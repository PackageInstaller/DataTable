return {
	Play319221001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319221001
		arg_1_1.duration_ = 8.1

		local var_1_0 = {
			zh = 8.099999999999,
			ja = 7.432999999999
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
				arg_1_0:Play319221002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I12g"

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
				local var_4_5 = arg_1_1.bgs_.I12g

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
					if iter_4_0 ~= "I12g" then
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

			local var_4_22 = "10079ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["10079ui_story"].transform
			local var_4_28 = 1.86666666666667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos10079ui_story = var_4_27.localPosition

				local var_4_29 = "10079ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_29 .. "Animator"].transform, false)
			end

			local var_4_30 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_28) / var_4_30
				local var_4_32 = Vector3.New(0, -0.95, -6.05)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10079ui_story, var_4_32, var_4_31)

				local var_4_33 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_33.x, var_4_33.y, var_4_33.z)

				local var_4_34 = var_4_27.localEulerAngles

				var_4_34.z = 0
				var_4_34.x = 0
				var_4_27.localEulerAngles = var_4_34
			end

			if arg_1_1.time_ >= var_4_28 + var_4_30 and arg_1_1.time_ < var_4_28 + var_4_30 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_27.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_27.localEulerAngles = var_4_36
			end

			local var_4_37 = arg_1_1.actors_["10079ui_story"]
			local var_4_38 = 1.86666666666667

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 and not isNil(var_4_37) and arg_1_1.var_.characterEffect10079ui_story == nil then
				arg_1_1.var_.characterEffect10079ui_story = var_4_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_39 = 0.200000002980232

			if var_4_38 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_39 and not isNil(var_4_37) then
				local var_4_40 = (arg_1_1.time_ - var_4_38) / var_4_39

				if arg_1_1.var_.characterEffect10079ui_story and not isNil(var_4_37) then
					arg_1_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 and not isNil(var_4_37) and arg_1_1.var_.characterEffect10079ui_story then
				arg_1_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_4_41 = 1.86666666666667

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_4_42 = 1.86666666666667

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_4_43 = 0
			local var_4_44 = 0.2

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

			local var_4_49 = 0.233333333333333
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

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

			local var_4_55 = 1.999999999999
			local var_4_56 = 0.8

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

				local var_4_58 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_59 = arg_1_1:GetWordFromCfg(319221001)
				local var_4_60 = arg_1_1:FormatText(var_4_59.content)

				arg_1_1.text_.text = var_4_60

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_61 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221001", "story_v_out_319221.awb") ~= 0 then
					local var_4_64 = manager.audio:GetVoiceLength("story_v_out_319221", "319221001", "story_v_out_319221.awb") / 1000

					if var_4_64 + var_4_55 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_55
					end

					if var_4_59.prefab_name ~= "" and arg_1_1.actors_[var_4_59.prefab_name] ~= nil then
						local var_4_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_59.prefab_name].transform, "story_v_out_319221", "319221001", "story_v_out_319221.awb")

						arg_1_1:RecordAudio("319221001", var_4_65)
						arg_1_1:RecordAudio("319221001", var_4_65)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319221", "319221001", "story_v_out_319221.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319221", "319221001", "story_v_out_319221.awb")
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
				actorName = "10079ui_story",
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
	Play319221002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319221002
		arg_9_1.duration_ = 4.9

		local var_9_0 = {
			zh = 2.7,
			ja = 4.9
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
				arg_9_0:Play319221003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.325

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[6].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(319221002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221002", "story_v_out_319221.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_319221", "319221002", "story_v_out_319221.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_319221", "319221002", "story_v_out_319221.awb")

						arg_9_1:RecordAudio("319221002", var_12_9)
						arg_9_1:RecordAudio("319221002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319221", "319221002", "story_v_out_319221.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319221", "319221002", "story_v_out_319221.awb")
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
	Play319221003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319221003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play319221004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10079ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10079ui_story = var_16_0.localPosition

				local var_16_2 = "10079ui_story"

				arg_13_1:ShowWeapon(arg_13_1.var_[var_16_2 .. "Animator"].transform, false)
			end

			local var_16_3 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_3 then
				local var_16_4 = (arg_13_1.time_ - var_16_1) / var_16_3
				local var_16_5 = Vector3.New(0, 100, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10079ui_story, var_16_5, var_16_4)

				local var_16_6 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_6.x, var_16_6.y, var_16_6.z)

				local var_16_7 = var_16_0.localEulerAngles

				var_16_7.z = 0
				var_16_7.x = 0
				var_16_0.localEulerAngles = var_16_7
			end

			if arg_13_1.time_ >= var_16_1 + var_16_3 and arg_13_1.time_ < var_16_1 + var_16_3 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, 100, 0)

				local var_16_8 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_8.x, var_16_8.y, var_16_8.z)

				local var_16_9 = var_16_0.localEulerAngles

				var_16_9.z = 0
				var_16_9.x = 0
				var_16_0.localEulerAngles = var_16_9
			end

			local var_16_10 = arg_13_1.actors_["10079ui_story"]
			local var_16_11 = 0

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect10079ui_story == nil then
				arg_13_1.var_.characterEffect10079ui_story = var_16_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_12 = 0.200000002980232

			if var_16_11 <= arg_13_1.time_ and arg_13_1.time_ < var_16_11 + var_16_12 and not isNil(var_16_10) then
				local var_16_13 = (arg_13_1.time_ - var_16_11) / var_16_12

				if arg_13_1.var_.characterEffect10079ui_story and not isNil(var_16_10) then
					arg_13_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_11 + var_16_12 and arg_13_1.time_ < var_16_11 + var_16_12 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect10079ui_story then
				arg_13_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_16_14 = 0
			local var_16_15 = 0.8

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_16 = arg_13_1:GetWordFromCfg(319221003)
				local var_16_17 = arg_13_1:FormatText(var_16_16.content)

				arg_13_1.text_.text = var_16_17

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_18 = 32
				local var_16_19 = utf8.len(var_16_17)
				local var_16_20 = var_16_18 <= 0 and var_16_15 or var_16_15 * (var_16_19 / var_16_18)

				if var_16_20 > 0 and var_16_15 < var_16_20 then
					arg_13_1.talkMaxDuration = var_16_20

					if var_16_20 + var_16_14 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_20 + var_16_14
					end
				end

				arg_13_1.text_.text = var_16_17
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_21 = math.max(var_16_15, arg_13_1.talkMaxDuration)

			if var_16_14 <= arg_13_1.time_ and arg_13_1.time_ < var_16_14 + var_16_21 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_14) / var_16_21

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_14 + var_16_21 and arg_13_1.time_ < var_16_14 + var_16_21 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play319221004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319221004
		arg_17_1.duration_ = 10.53

		local var_17_0 = {
			zh = 5.966,
			ja = 10.533
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
				arg_17_0:Play319221005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10079ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos10079ui_story = var_20_0.localPosition

				local var_20_2 = "10079ui_story"

				arg_17_1:ShowWeapon(arg_17_1.var_[var_20_2 .. "Animator"].transform, false)
			end

			local var_20_3 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_3 then
				local var_20_4 = (arg_17_1.time_ - var_20_1) / var_20_3
				local var_20_5 = Vector3.New(0, -0.95, -6.05)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10079ui_story, var_20_5, var_20_4)

				local var_20_6 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_6.x, var_20_6.y, var_20_6.z)

				local var_20_7 = var_20_0.localEulerAngles

				var_20_7.z = 0
				var_20_7.x = 0
				var_20_0.localEulerAngles = var_20_7
			end

			if arg_17_1.time_ >= var_20_1 + var_20_3 and arg_17_1.time_ < var_20_1 + var_20_3 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_20_8 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_8.x, var_20_8.y, var_20_8.z)

				local var_20_9 = var_20_0.localEulerAngles

				var_20_9.z = 0
				var_20_9.x = 0
				var_20_0.localEulerAngles = var_20_9
			end

			local var_20_10 = arg_17_1.actors_["10079ui_story"]
			local var_20_11 = 0

			if var_20_11 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect10079ui_story == nil then
				arg_17_1.var_.characterEffect10079ui_story = var_20_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_12 = 0.200000002980232

			if var_20_11 <= arg_17_1.time_ and arg_17_1.time_ < var_20_11 + var_20_12 and not isNil(var_20_10) then
				local var_20_13 = (arg_17_1.time_ - var_20_11) / var_20_12

				if arg_17_1.var_.characterEffect10079ui_story and not isNil(var_20_10) then
					arg_17_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_11 + var_20_12 and arg_17_1.time_ < var_20_11 + var_20_12 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect10079ui_story then
				arg_17_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_20_14 = 0
			local var_20_15 = 0.7

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_16 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_17 = arg_17_1:GetWordFromCfg(319221004)
				local var_20_18 = arg_17_1:FormatText(var_20_17.content)

				arg_17_1.text_.text = var_20_18

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_19 = 28
				local var_20_20 = utf8.len(var_20_18)
				local var_20_21 = var_20_19 <= 0 and var_20_15 or var_20_15 * (var_20_20 / var_20_19)

				if var_20_21 > 0 and var_20_15 < var_20_21 then
					arg_17_1.talkMaxDuration = var_20_21

					if var_20_21 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_21 + var_20_14
					end
				end

				arg_17_1.text_.text = var_20_18
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221004", "story_v_out_319221.awb") ~= 0 then
					local var_20_22 = manager.audio:GetVoiceLength("story_v_out_319221", "319221004", "story_v_out_319221.awb") / 1000

					if var_20_22 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_14
					end

					if var_20_17.prefab_name ~= "" and arg_17_1.actors_[var_20_17.prefab_name] ~= nil then
						local var_20_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_17.prefab_name].transform, "story_v_out_319221", "319221004", "story_v_out_319221.awb")

						arg_17_1:RecordAudio("319221004", var_20_23)
						arg_17_1:RecordAudio("319221004", var_20_23)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319221", "319221004", "story_v_out_319221.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319221", "319221004", "story_v_out_319221.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_24 = math.max(var_20_15, arg_17_1.talkMaxDuration)

			if var_20_14 <= arg_17_1.time_ and arg_17_1.time_ < var_20_14 + var_20_24 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_14) / var_20_24

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_14 + var_20_24 and arg_17_1.time_ < var_20_14 + var_20_24 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play319221005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319221005
		arg_21_1.duration_ = 2.87

		local var_21_0 = {
			zh = 1.999999999999,
			ja = 2.86633333333333
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
				arg_21_0:Play319221006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10079ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10079ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, -0.95, -6.05)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10079ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_10 = 0.333333333333333
			local var_24_11 = 0.125

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_12 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_12:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_13 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_14 = arg_21_1:GetWordFromCfg(319221005)
				local var_24_15 = arg_21_1:FormatText(var_24_14.content)

				arg_21_1.text_.text = var_24_15

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_16 = 5
				local var_24_17 = utf8.len(var_24_15)
				local var_24_18 = var_24_16 <= 0 and var_24_11 or var_24_11 * (var_24_17 / var_24_16)

				if var_24_18 > 0 and var_24_11 < var_24_18 then
					arg_21_1.talkMaxDuration = var_24_18
					var_24_10 = var_24_10 + 0.3

					if var_24_18 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_15
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221005", "story_v_out_319221.awb") ~= 0 then
					local var_24_19 = manager.audio:GetVoiceLength("story_v_out_319221", "319221005", "story_v_out_319221.awb") / 1000

					if var_24_19 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_10
					end

					if var_24_14.prefab_name ~= "" and arg_21_1.actors_[var_24_14.prefab_name] ~= nil then
						local var_24_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_14.prefab_name].transform, "story_v_out_319221", "319221005", "story_v_out_319221.awb")

						arg_21_1:RecordAudio("319221005", var_24_20)
						arg_21_1:RecordAudio("319221005", var_24_20)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319221", "319221005", "story_v_out_319221.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319221", "319221005", "story_v_out_319221.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_21 = var_24_10 + 0.3
			local var_24_22 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_21) / var_24_22

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play319221006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 319221006
		arg_27_1.duration_ = 1.07

		local var_27_0 = {
			zh = 0.999999999999,
			ja = 1.066
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play319221007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = "1095ui_story"

			if arg_27_1.actors_[var_30_0] == nil then
				local var_30_1 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_30_1) then
					local var_30_2 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_27_1.stage_.transform)

					var_30_2.name = var_30_0
					var_30_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_27_1.actors_[var_30_0] = var_30_2

					local var_30_3 = var_30_2:GetComponentInChildren(typeof(CharacterEffect))

					var_30_3.enabled = true

					local var_30_4 = GameObjectTools.GetOrAddComponent(var_30_2, typeof(DynamicBoneHelper))

					if var_30_4 then
						var_30_4:EnableDynamicBone(false)
					end

					arg_27_1:ShowWeapon(var_30_3.transform, false)

					arg_27_1.var_[var_30_0 .. "Animator"] = var_30_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_27_1.var_[var_30_0 .. "Animator"].applyRootMotion = true
					arg_27_1.var_[var_30_0 .. "LipSync"] = var_30_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_30_5 = arg_27_1.actors_["1095ui_story"].transform
			local var_30_6 = 0

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.var_.moveOldPos1095ui_story = var_30_5.localPosition
			end

			local var_30_7 = 0.001

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_7 then
				local var_30_8 = (arg_27_1.time_ - var_30_6) / var_30_7
				local var_30_9 = Vector3.New(0.7, -0.98, -6.1)

				var_30_5.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1095ui_story, var_30_9, var_30_8)

				local var_30_10 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_10.x, var_30_10.y, var_30_10.z)

				local var_30_11 = var_30_5.localEulerAngles

				var_30_11.z = 0
				var_30_11.x = 0
				var_30_5.localEulerAngles = var_30_11
			end

			if arg_27_1.time_ >= var_30_6 + var_30_7 and arg_27_1.time_ < var_30_6 + var_30_7 + arg_30_0 then
				var_30_5.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_30_12 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_12.x, var_30_12.y, var_30_12.z)

				local var_30_13 = var_30_5.localEulerAngles

				var_30_13.z = 0
				var_30_13.x = 0
				var_30_5.localEulerAngles = var_30_13
			end

			local var_30_14 = arg_27_1.actors_["1095ui_story"]
			local var_30_15 = 0

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect1095ui_story == nil then
				arg_27_1.var_.characterEffect1095ui_story = var_30_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_16 = 0.200000002980232

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_16 and not isNil(var_30_14) then
				local var_30_17 = (arg_27_1.time_ - var_30_15) / var_30_16

				if arg_27_1.var_.characterEffect1095ui_story and not isNil(var_30_14) then
					arg_27_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_15 + var_30_16 and arg_27_1.time_ < var_30_15 + var_30_16 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect1095ui_story then
				arg_27_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_30_18 = 0

			if var_30_18 < arg_27_1.time_ and arg_27_1.time_ <= var_30_18 + arg_30_0 then
				arg_27_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_30_19 = 0

			if var_30_19 < arg_27_1.time_ and arg_27_1.time_ <= var_30_19 + arg_30_0 then
				arg_27_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_20 = arg_27_1.actors_["10079ui_story"].transform
			local var_30_21 = 0

			if var_30_21 < arg_27_1.time_ and arg_27_1.time_ <= var_30_21 + arg_30_0 then
				arg_27_1.var_.moveOldPos10079ui_story = var_30_20.localPosition
			end

			local var_30_22 = 0.001

			if var_30_21 <= arg_27_1.time_ and arg_27_1.time_ < var_30_21 + var_30_22 then
				local var_30_23 = (arg_27_1.time_ - var_30_21) / var_30_22
				local var_30_24 = Vector3.New(-0.7, -0.95, -6.05)

				var_30_20.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10079ui_story, var_30_24, var_30_23)

				local var_30_25 = manager.ui.mainCamera.transform.position - var_30_20.position

				var_30_20.forward = Vector3.New(var_30_25.x, var_30_25.y, var_30_25.z)

				local var_30_26 = var_30_20.localEulerAngles

				var_30_26.z = 0
				var_30_26.x = 0
				var_30_20.localEulerAngles = var_30_26
			end

			if arg_27_1.time_ >= var_30_21 + var_30_22 and arg_27_1.time_ < var_30_21 + var_30_22 + arg_30_0 then
				var_30_20.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_30_27 = manager.ui.mainCamera.transform.position - var_30_20.position

				var_30_20.forward = Vector3.New(var_30_27.x, var_30_27.y, var_30_27.z)

				local var_30_28 = var_30_20.localEulerAngles

				var_30_28.z = 0
				var_30_28.x = 0
				var_30_20.localEulerAngles = var_30_28
			end

			local var_30_29 = arg_27_1.actors_["10079ui_story"]
			local var_30_30 = 0

			if var_30_30 < arg_27_1.time_ and arg_27_1.time_ <= var_30_30 + arg_30_0 and not isNil(var_30_29) and arg_27_1.var_.characterEffect10079ui_story == nil then
				arg_27_1.var_.characterEffect10079ui_story = var_30_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_31 = 0.200000002980232

			if var_30_30 <= arg_27_1.time_ and arg_27_1.time_ < var_30_30 + var_30_31 and not isNil(var_30_29) then
				local var_30_32 = (arg_27_1.time_ - var_30_30) / var_30_31

				if arg_27_1.var_.characterEffect10079ui_story and not isNil(var_30_29) then
					local var_30_33 = Mathf.Lerp(0, 0.5, var_30_32)

					arg_27_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_27_1.var_.characterEffect10079ui_story.fillRatio = var_30_33
				end
			end

			if arg_27_1.time_ >= var_30_30 + var_30_31 and arg_27_1.time_ < var_30_30 + var_30_31 + arg_30_0 and not isNil(var_30_29) and arg_27_1.var_.characterEffect10079ui_story then
				local var_30_34 = 0.5

				arg_27_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_27_1.var_.characterEffect10079ui_story.fillRatio = var_30_34
			end

			local var_30_35 = 0
			local var_30_36 = 0.05

			if var_30_35 < arg_27_1.time_ and arg_27_1.time_ <= var_30_35 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_37 = arg_27_1:FormatText(StoryNameCfg[471].name)

				arg_27_1.leftNameTxt_.text = var_30_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_38 = arg_27_1:GetWordFromCfg(319221006)
				local var_30_39 = arg_27_1:FormatText(var_30_38.content)

				arg_27_1.text_.text = var_30_39

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_40 = 2
				local var_30_41 = utf8.len(var_30_39)
				local var_30_42 = var_30_40 <= 0 and var_30_36 or var_30_36 * (var_30_41 / var_30_40)

				if var_30_42 > 0 and var_30_36 < var_30_42 then
					arg_27_1.talkMaxDuration = var_30_42

					if var_30_42 + var_30_35 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_42 + var_30_35
					end
				end

				arg_27_1.text_.text = var_30_39
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221006", "story_v_out_319221.awb") ~= 0 then
					local var_30_43 = manager.audio:GetVoiceLength("story_v_out_319221", "319221006", "story_v_out_319221.awb") / 1000

					if var_30_43 + var_30_35 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_43 + var_30_35
					end

					if var_30_38.prefab_name ~= "" and arg_27_1.actors_[var_30_38.prefab_name] ~= nil then
						local var_30_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_38.prefab_name].transform, "story_v_out_319221", "319221006", "story_v_out_319221.awb")

						arg_27_1:RecordAudio("319221006", var_30_44)
						arg_27_1:RecordAudio("319221006", var_30_44)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_319221", "319221006", "story_v_out_319221.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_319221", "319221006", "story_v_out_319221.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_45 = math.max(var_30_36, arg_27_1.talkMaxDuration)

			if var_30_35 <= arg_27_1.time_ and arg_27_1.time_ < var_30_35 + var_30_45 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_35) / var_30_45

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_35 + var_30_45 and arg_27_1.time_ < var_30_35 + var_30_45 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play319221007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 319221007
		arg_31_1.duration_ = 3.53

		local var_31_0 = {
			zh = 1.999999999999,
			ja = 3.533
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play319221008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1095ui_story"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1095ui_story == nil then
				arg_31_1.var_.characterEffect1095ui_story = var_34_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.characterEffect1095ui_story and not isNil(var_34_0) then
					local var_34_4 = Mathf.Lerp(0, 0.5, var_34_3)

					arg_31_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1095ui_story.fillRatio = var_34_4
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1095ui_story then
				local var_34_5 = 0.5

				arg_31_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1095ui_story.fillRatio = var_34_5
			end

			local var_34_6 = 0

			if var_34_6 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_34_7 = 0

			if var_34_7 < arg_31_1.time_ and arg_31_1.time_ <= var_34_7 + arg_34_0 then
				arg_31_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_34_8 = arg_31_1.actors_["10079ui_story"]
			local var_34_9 = 0

			if var_34_9 < arg_31_1.time_ and arg_31_1.time_ <= var_34_9 + arg_34_0 and not isNil(var_34_8) and arg_31_1.var_.characterEffect10079ui_story == nil then
				arg_31_1.var_.characterEffect10079ui_story = var_34_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_10 = 0.200000002980232

			if var_34_9 <= arg_31_1.time_ and arg_31_1.time_ < var_34_9 + var_34_10 and not isNil(var_34_8) then
				local var_34_11 = (arg_31_1.time_ - var_34_9) / var_34_10

				if arg_31_1.var_.characterEffect10079ui_story and not isNil(var_34_8) then
					arg_31_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_9 + var_34_10 and arg_31_1.time_ < var_34_9 + var_34_10 + arg_34_0 and not isNil(var_34_8) and arg_31_1.var_.characterEffect10079ui_story then
				arg_31_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_34_12 = 0
			local var_34_13 = 0.15

			if var_34_12 < arg_31_1.time_ and arg_31_1.time_ <= var_34_12 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_14 = arg_31_1:FormatText(StoryNameCfg[6].name)

				arg_31_1.leftNameTxt_.text = var_34_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_15 = arg_31_1:GetWordFromCfg(319221007)
				local var_34_16 = arg_31_1:FormatText(var_34_15.content)

				arg_31_1.text_.text = var_34_16

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_17 = 6
				local var_34_18 = utf8.len(var_34_16)
				local var_34_19 = var_34_17 <= 0 and var_34_13 or var_34_13 * (var_34_18 / var_34_17)

				if var_34_19 > 0 and var_34_13 < var_34_19 then
					arg_31_1.talkMaxDuration = var_34_19

					if var_34_19 + var_34_12 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_19 + var_34_12
					end
				end

				arg_31_1.text_.text = var_34_16
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221007", "story_v_out_319221.awb") ~= 0 then
					local var_34_20 = manager.audio:GetVoiceLength("story_v_out_319221", "319221007", "story_v_out_319221.awb") / 1000

					if var_34_20 + var_34_12 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_20 + var_34_12
					end

					if var_34_15.prefab_name ~= "" and arg_31_1.actors_[var_34_15.prefab_name] ~= nil then
						local var_34_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_15.prefab_name].transform, "story_v_out_319221", "319221007", "story_v_out_319221.awb")

						arg_31_1:RecordAudio("319221007", var_34_21)
						arg_31_1:RecordAudio("319221007", var_34_21)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_319221", "319221007", "story_v_out_319221.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_319221", "319221007", "story_v_out_319221.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_22 = math.max(var_34_13, arg_31_1.talkMaxDuration)

			if var_34_12 <= arg_31_1.time_ and arg_31_1.time_ < var_34_12 + var_34_22 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_12) / var_34_22

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_12 + var_34_22 and arg_31_1.time_ < var_34_12 + var_34_22 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play319221008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 319221008
		arg_35_1.duration_ = 6

		local var_35_0 = {
			zh = 2.2,
			ja = 6
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play319221009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1095ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1095ui_story == nil then
				arg_35_1.var_.characterEffect1095ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect1095ui_story and not isNil(var_38_0) then
					arg_35_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1095ui_story then
				arg_35_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_38_4 = arg_35_1.actors_["10079ui_story"]
			local var_38_5 = 0

			if var_38_5 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect10079ui_story == nil then
				arg_35_1.var_.characterEffect10079ui_story = var_38_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_6 = 0.200000002980232

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_6 and not isNil(var_38_4) then
				local var_38_7 = (arg_35_1.time_ - var_38_5) / var_38_6

				if arg_35_1.var_.characterEffect10079ui_story and not isNil(var_38_4) then
					local var_38_8 = Mathf.Lerp(0, 0.5, var_38_7)

					arg_35_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_35_1.var_.characterEffect10079ui_story.fillRatio = var_38_8
				end
			end

			if arg_35_1.time_ >= var_38_5 + var_38_6 and arg_35_1.time_ < var_38_5 + var_38_6 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect10079ui_story then
				local var_38_9 = 0.5

				arg_35_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_35_1.var_.characterEffect10079ui_story.fillRatio = var_38_9
			end

			local var_38_10 = 0
			local var_38_11 = 0.225

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_12 = arg_35_1:FormatText(StoryNameCfg[471].name)

				arg_35_1.leftNameTxt_.text = var_38_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_13 = arg_35_1:GetWordFromCfg(319221008)
				local var_38_14 = arg_35_1:FormatText(var_38_13.content)

				arg_35_1.text_.text = var_38_14

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_15 = 9
				local var_38_16 = utf8.len(var_38_14)
				local var_38_17 = var_38_15 <= 0 and var_38_11 or var_38_11 * (var_38_16 / var_38_15)

				if var_38_17 > 0 and var_38_11 < var_38_17 then
					arg_35_1.talkMaxDuration = var_38_17

					if var_38_17 + var_38_10 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_17 + var_38_10
					end
				end

				arg_35_1.text_.text = var_38_14
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221008", "story_v_out_319221.awb") ~= 0 then
					local var_38_18 = manager.audio:GetVoiceLength("story_v_out_319221", "319221008", "story_v_out_319221.awb") / 1000

					if var_38_18 + var_38_10 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_18 + var_38_10
					end

					if var_38_13.prefab_name ~= "" and arg_35_1.actors_[var_38_13.prefab_name] ~= nil then
						local var_38_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_13.prefab_name].transform, "story_v_out_319221", "319221008", "story_v_out_319221.awb")

						arg_35_1:RecordAudio("319221008", var_38_19)
						arg_35_1:RecordAudio("319221008", var_38_19)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_319221", "319221008", "story_v_out_319221.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_319221", "319221008", "story_v_out_319221.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_20 = math.max(var_38_11, arg_35_1.talkMaxDuration)

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_20 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_10) / var_38_20

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_10 + var_38_20 and arg_35_1.time_ < var_38_10 + var_38_20 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play319221009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319221009
		arg_39_1.duration_ = 10.73

		local var_39_0 = {
			zh = 8.4,
			ja = 10.733
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play319221010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_2 = 0
			local var_42_3 = 1.025

			if var_42_2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_4 = arg_39_1:FormatText(StoryNameCfg[471].name)

				arg_39_1.leftNameTxt_.text = var_42_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_5 = arg_39_1:GetWordFromCfg(319221009)
				local var_42_6 = arg_39_1:FormatText(var_42_5.content)

				arg_39_1.text_.text = var_42_6

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_7 = 41
				local var_42_8 = utf8.len(var_42_6)
				local var_42_9 = var_42_7 <= 0 and var_42_3 or var_42_3 * (var_42_8 / var_42_7)

				if var_42_9 > 0 and var_42_3 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_2 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_2
					end
				end

				arg_39_1.text_.text = var_42_6
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221009", "story_v_out_319221.awb") ~= 0 then
					local var_42_10 = manager.audio:GetVoiceLength("story_v_out_319221", "319221009", "story_v_out_319221.awb") / 1000

					if var_42_10 + var_42_2 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_2
					end

					if var_42_5.prefab_name ~= "" and arg_39_1.actors_[var_42_5.prefab_name] ~= nil then
						local var_42_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_5.prefab_name].transform, "story_v_out_319221", "319221009", "story_v_out_319221.awb")

						arg_39_1:RecordAudio("319221009", var_42_11)
						arg_39_1:RecordAudio("319221009", var_42_11)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_319221", "319221009", "story_v_out_319221.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_319221", "319221009", "story_v_out_319221.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_12 = math.max(var_42_3, arg_39_1.talkMaxDuration)

			if var_42_2 <= arg_39_1.time_ and arg_39_1.time_ < var_42_2 + var_42_12 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_2) / var_42_12

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_2 + var_42_12 and arg_39_1.time_ < var_42_2 + var_42_12 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play319221010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 319221010
		arg_43_1.duration_ = 2.9

		local var_43_0 = {
			zh = 2.766,
			ja = 2.9
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play319221011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["10079ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos10079ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10079ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = arg_43_1.actors_["10079ui_story"]
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect10079ui_story == nil then
				arg_43_1.var_.characterEffect10079ui_story = var_46_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.200000002980232

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 and not isNil(var_46_9) then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11

				if arg_43_1.var_.characterEffect10079ui_story and not isNil(var_46_9) then
					arg_43_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect10079ui_story then
				arg_43_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_46_13 = 0

			if var_46_13 < arg_43_1.time_ and arg_43_1.time_ <= var_46_13 + arg_46_0 then
				arg_43_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_46_14 = 0

			if var_46_14 < arg_43_1.time_ and arg_43_1.time_ <= var_46_14 + arg_46_0 then
				arg_43_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_46_15 = arg_43_1.actors_["1095ui_story"]
			local var_46_16 = 0

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 and not isNil(var_46_15) and arg_43_1.var_.characterEffect1095ui_story == nil then
				arg_43_1.var_.characterEffect1095ui_story = var_46_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_17 = 0.200000002980232

			if var_46_16 <= arg_43_1.time_ and arg_43_1.time_ < var_46_16 + var_46_17 and not isNil(var_46_15) then
				local var_46_18 = (arg_43_1.time_ - var_46_16) / var_46_17

				if arg_43_1.var_.characterEffect1095ui_story and not isNil(var_46_15) then
					local var_46_19 = Mathf.Lerp(0, 0.5, var_46_18)

					arg_43_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1095ui_story.fillRatio = var_46_19
				end
			end

			if arg_43_1.time_ >= var_46_16 + var_46_17 and arg_43_1.time_ < var_46_16 + var_46_17 + arg_46_0 and not isNil(var_46_15) and arg_43_1.var_.characterEffect1095ui_story then
				local var_46_20 = 0.5

				arg_43_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1095ui_story.fillRatio = var_46_20
			end

			local var_46_21 = 0
			local var_46_22 = 0.25

			if var_46_21 < arg_43_1.time_ and arg_43_1.time_ <= var_46_21 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_23 = arg_43_1:FormatText(StoryNameCfg[6].name)

				arg_43_1.leftNameTxt_.text = var_46_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_24 = arg_43_1:GetWordFromCfg(319221010)
				local var_46_25 = arg_43_1:FormatText(var_46_24.content)

				arg_43_1.text_.text = var_46_25

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_26 = 10
				local var_46_27 = utf8.len(var_46_25)
				local var_46_28 = var_46_26 <= 0 and var_46_22 or var_46_22 * (var_46_27 / var_46_26)

				if var_46_28 > 0 and var_46_22 < var_46_28 then
					arg_43_1.talkMaxDuration = var_46_28

					if var_46_28 + var_46_21 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_28 + var_46_21
					end
				end

				arg_43_1.text_.text = var_46_25
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221010", "story_v_out_319221.awb") ~= 0 then
					local var_46_29 = manager.audio:GetVoiceLength("story_v_out_319221", "319221010", "story_v_out_319221.awb") / 1000

					if var_46_29 + var_46_21 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_29 + var_46_21
					end

					if var_46_24.prefab_name ~= "" and arg_43_1.actors_[var_46_24.prefab_name] ~= nil then
						local var_46_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_24.prefab_name].transform, "story_v_out_319221", "319221010", "story_v_out_319221.awb")

						arg_43_1:RecordAudio("319221010", var_46_30)
						arg_43_1:RecordAudio("319221010", var_46_30)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_319221", "319221010", "story_v_out_319221.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_319221", "319221010", "story_v_out_319221.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_31 = math.max(var_46_22, arg_43_1.talkMaxDuration)

			if var_46_21 <= arg_43_1.time_ and arg_43_1.time_ < var_46_21 + var_46_31 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_21) / var_46_31

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_21 + var_46_31 and arg_43_1.time_ < var_46_21 + var_46_31 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play319221011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319221011
		arg_47_1.duration_ = 3.77

		local var_47_0 = {
			zh = 3.6,
			ja = 3.766
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play319221012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10079ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect10079ui_story == nil then
				arg_47_1.var_.characterEffect10079ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect10079ui_story and not isNil(var_50_0) then
					local var_50_4 = Mathf.Lerp(0, 0.5, var_50_3)

					arg_47_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10079ui_story.fillRatio = var_50_4
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect10079ui_story then
				local var_50_5 = 0.5

				arg_47_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10079ui_story.fillRatio = var_50_5
			end

			local var_50_6 = arg_47_1.actors_["1095ui_story"]
			local var_50_7 = 0

			if var_50_7 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect1095ui_story == nil then
				arg_47_1.var_.characterEffect1095ui_story = var_50_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_8 = 0.200000002980232

			if var_50_7 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_8 and not isNil(var_50_6) then
				local var_50_9 = (arg_47_1.time_ - var_50_7) / var_50_8

				if arg_47_1.var_.characterEffect1095ui_story and not isNil(var_50_6) then
					arg_47_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_7 + var_50_8 and arg_47_1.time_ < var_50_7 + var_50_8 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect1095ui_story then
				arg_47_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_50_10 = 0
			local var_50_11 = 0.25

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_12 = arg_47_1:FormatText(StoryNameCfg[471].name)

				arg_47_1.leftNameTxt_.text = var_50_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_13 = arg_47_1:GetWordFromCfg(319221011)
				local var_50_14 = arg_47_1:FormatText(var_50_13.content)

				arg_47_1.text_.text = var_50_14

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_15 = 10
				local var_50_16 = utf8.len(var_50_14)
				local var_50_17 = var_50_15 <= 0 and var_50_11 or var_50_11 * (var_50_16 / var_50_15)

				if var_50_17 > 0 and var_50_11 < var_50_17 then
					arg_47_1.talkMaxDuration = var_50_17

					if var_50_17 + var_50_10 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_17 + var_50_10
					end
				end

				arg_47_1.text_.text = var_50_14
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221011", "story_v_out_319221.awb") ~= 0 then
					local var_50_18 = manager.audio:GetVoiceLength("story_v_out_319221", "319221011", "story_v_out_319221.awb") / 1000

					if var_50_18 + var_50_10 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_18 + var_50_10
					end

					if var_50_13.prefab_name ~= "" and arg_47_1.actors_[var_50_13.prefab_name] ~= nil then
						local var_50_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_13.prefab_name].transform, "story_v_out_319221", "319221011", "story_v_out_319221.awb")

						arg_47_1:RecordAudio("319221011", var_50_19)
						arg_47_1:RecordAudio("319221011", var_50_19)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_319221", "319221011", "story_v_out_319221.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_319221", "319221011", "story_v_out_319221.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_20 = math.max(var_50_11, arg_47_1.talkMaxDuration)

			if var_50_10 <= arg_47_1.time_ and arg_47_1.time_ < var_50_10 + var_50_20 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_10) / var_50_20

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_10 + var_50_20 and arg_47_1.time_ < var_50_10 + var_50_20 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play319221012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319221012
		arg_51_1.duration_ = 2.53

		local var_51_0 = {
			zh = 1.633,
			ja = 2.533
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play319221013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1095ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1095ui_story == nil then
				arg_51_1.var_.characterEffect1095ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect1095ui_story and not isNil(var_54_0) then
					local var_54_4 = Mathf.Lerp(0, 0.5, var_54_3)

					arg_51_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1095ui_story.fillRatio = var_54_4
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1095ui_story then
				local var_54_5 = 0.5

				arg_51_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1095ui_story.fillRatio = var_54_5
			end

			local var_54_6 = arg_51_1.actors_["10079ui_story"]
			local var_54_7 = 0

			if var_54_7 < arg_51_1.time_ and arg_51_1.time_ <= var_54_7 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect10079ui_story == nil then
				arg_51_1.var_.characterEffect10079ui_story = var_54_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_8 = 0.200000002980232

			if var_54_7 <= arg_51_1.time_ and arg_51_1.time_ < var_54_7 + var_54_8 and not isNil(var_54_6) then
				local var_54_9 = (arg_51_1.time_ - var_54_7) / var_54_8

				if arg_51_1.var_.characterEffect10079ui_story and not isNil(var_54_6) then
					arg_51_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_7 + var_54_8 and arg_51_1.time_ < var_54_7 + var_54_8 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect10079ui_story then
				arg_51_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_54_10 = 0
			local var_54_11 = 0.075

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_12 = arg_51_1:FormatText(StoryNameCfg[6].name)

				arg_51_1.leftNameTxt_.text = var_54_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_13 = arg_51_1:GetWordFromCfg(319221012)
				local var_54_14 = arg_51_1:FormatText(var_54_13.content)

				arg_51_1.text_.text = var_54_14

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_15 = 3
				local var_54_16 = utf8.len(var_54_14)
				local var_54_17 = var_54_15 <= 0 and var_54_11 or var_54_11 * (var_54_16 / var_54_15)

				if var_54_17 > 0 and var_54_11 < var_54_17 then
					arg_51_1.talkMaxDuration = var_54_17

					if var_54_17 + var_54_10 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_17 + var_54_10
					end
				end

				arg_51_1.text_.text = var_54_14
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221012", "story_v_out_319221.awb") ~= 0 then
					local var_54_18 = manager.audio:GetVoiceLength("story_v_out_319221", "319221012", "story_v_out_319221.awb") / 1000

					if var_54_18 + var_54_10 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_18 + var_54_10
					end

					if var_54_13.prefab_name ~= "" and arg_51_1.actors_[var_54_13.prefab_name] ~= nil then
						local var_54_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_13.prefab_name].transform, "story_v_out_319221", "319221012", "story_v_out_319221.awb")

						arg_51_1:RecordAudio("319221012", var_54_19)
						arg_51_1:RecordAudio("319221012", var_54_19)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_319221", "319221012", "story_v_out_319221.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_319221", "319221012", "story_v_out_319221.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_20 = math.max(var_54_11, arg_51_1.talkMaxDuration)

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_20 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_10) / var_54_20

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_10 + var_54_20 and arg_51_1.time_ < var_54_10 + var_54_20 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play319221013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319221013
		arg_55_1.duration_ = 15.77

		local var_55_0 = {
			zh = 9.3,
			ja = 15.766
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play319221014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1095ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1095ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0.7, -0.98, -6.1)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1095ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = arg_55_1.actors_["1095ui_story"]
			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1095ui_story == nil then
				arg_55_1.var_.characterEffect1095ui_story = var_58_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_11 = 0.200000002980232

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_11 and not isNil(var_58_9) then
				local var_58_12 = (arg_55_1.time_ - var_58_10) / var_58_11

				if arg_55_1.var_.characterEffect1095ui_story and not isNil(var_58_9) then
					arg_55_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_10 + var_58_11 and arg_55_1.time_ < var_58_10 + var_58_11 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1095ui_story then
				arg_55_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_58_13 = 0

			if var_58_13 < arg_55_1.time_ and arg_55_1.time_ <= var_58_13 + arg_58_0 then
				arg_55_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_58_14 = 0

			if var_58_14 < arg_55_1.time_ and arg_55_1.time_ <= var_58_14 + arg_58_0 then
				arg_55_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_15 = arg_55_1.actors_["10079ui_story"]
			local var_58_16 = 0

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 and not isNil(var_58_15) and arg_55_1.var_.characterEffect10079ui_story == nil then
				arg_55_1.var_.characterEffect10079ui_story = var_58_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_17 = 0.200000002980232

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_17 and not isNil(var_58_15) then
				local var_58_18 = (arg_55_1.time_ - var_58_16) / var_58_17

				if arg_55_1.var_.characterEffect10079ui_story and not isNil(var_58_15) then
					local var_58_19 = Mathf.Lerp(0, 0.5, var_58_18)

					arg_55_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10079ui_story.fillRatio = var_58_19
				end
			end

			if arg_55_1.time_ >= var_58_16 + var_58_17 and arg_55_1.time_ < var_58_16 + var_58_17 + arg_58_0 and not isNil(var_58_15) and arg_55_1.var_.characterEffect10079ui_story then
				local var_58_20 = 0.5

				arg_55_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10079ui_story.fillRatio = var_58_20
			end

			local var_58_21 = 0
			local var_58_22 = 1.125

			if var_58_21 < arg_55_1.time_ and arg_55_1.time_ <= var_58_21 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_23 = arg_55_1:FormatText(StoryNameCfg[471].name)

				arg_55_1.leftNameTxt_.text = var_58_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_24 = arg_55_1:GetWordFromCfg(319221013)
				local var_58_25 = arg_55_1:FormatText(var_58_24.content)

				arg_55_1.text_.text = var_58_25

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_26 = 45
				local var_58_27 = utf8.len(var_58_25)
				local var_58_28 = var_58_26 <= 0 and var_58_22 or var_58_22 * (var_58_27 / var_58_26)

				if var_58_28 > 0 and var_58_22 < var_58_28 then
					arg_55_1.talkMaxDuration = var_58_28

					if var_58_28 + var_58_21 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_28 + var_58_21
					end
				end

				arg_55_1.text_.text = var_58_25
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221013", "story_v_out_319221.awb") ~= 0 then
					local var_58_29 = manager.audio:GetVoiceLength("story_v_out_319221", "319221013", "story_v_out_319221.awb") / 1000

					if var_58_29 + var_58_21 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_29 + var_58_21
					end

					if var_58_24.prefab_name ~= "" and arg_55_1.actors_[var_58_24.prefab_name] ~= nil then
						local var_58_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_24.prefab_name].transform, "story_v_out_319221", "319221013", "story_v_out_319221.awb")

						arg_55_1:RecordAudio("319221013", var_58_30)
						arg_55_1:RecordAudio("319221013", var_58_30)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319221", "319221013", "story_v_out_319221.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319221", "319221013", "story_v_out_319221.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_31 = math.max(var_58_22, arg_55_1.talkMaxDuration)

			if var_58_21 <= arg_55_1.time_ and arg_55_1.time_ < var_58_21 + var_58_31 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_21) / var_58_31

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_21 + var_58_31 and arg_55_1.time_ < var_58_21 + var_58_31 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play319221014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319221014
		arg_59_1.duration_ = 8.53

		local var_59_0 = {
			zh = 5.1,
			ja = 8.533
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play319221015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1095ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1095ui_story == nil then
				arg_59_1.var_.characterEffect1095ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1095ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1095ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1095ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1095ui_story.fillRatio = var_62_5
			end

			local var_62_6 = arg_59_1.actors_["10079ui_story"]
			local var_62_7 = 0

			if var_62_7 < arg_59_1.time_ and arg_59_1.time_ <= var_62_7 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect10079ui_story == nil then
				arg_59_1.var_.characterEffect10079ui_story = var_62_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_8 = 0.200000002980232

			if var_62_7 <= arg_59_1.time_ and arg_59_1.time_ < var_62_7 + var_62_8 and not isNil(var_62_6) then
				local var_62_9 = (arg_59_1.time_ - var_62_7) / var_62_8

				if arg_59_1.var_.characterEffect10079ui_story and not isNil(var_62_6) then
					arg_59_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_7 + var_62_8 and arg_59_1.time_ < var_62_7 + var_62_8 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect10079ui_story then
				arg_59_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 then
				arg_59_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_62_11 = 0

			if var_62_11 < arg_59_1.time_ and arg_59_1.time_ <= var_62_11 + arg_62_0 then
				arg_59_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_62_12 = 0
			local var_62_13 = 0.65

			if var_62_12 < arg_59_1.time_ and arg_59_1.time_ <= var_62_12 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_14 = arg_59_1:FormatText(StoryNameCfg[6].name)

				arg_59_1.leftNameTxt_.text = var_62_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_15 = arg_59_1:GetWordFromCfg(319221014)
				local var_62_16 = arg_59_1:FormatText(var_62_15.content)

				arg_59_1.text_.text = var_62_16

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_17 = 26
				local var_62_18 = utf8.len(var_62_16)
				local var_62_19 = var_62_17 <= 0 and var_62_13 or var_62_13 * (var_62_18 / var_62_17)

				if var_62_19 > 0 and var_62_13 < var_62_19 then
					arg_59_1.talkMaxDuration = var_62_19

					if var_62_19 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_19 + var_62_12
					end
				end

				arg_59_1.text_.text = var_62_16
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221014", "story_v_out_319221.awb") ~= 0 then
					local var_62_20 = manager.audio:GetVoiceLength("story_v_out_319221", "319221014", "story_v_out_319221.awb") / 1000

					if var_62_20 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_20 + var_62_12
					end

					if var_62_15.prefab_name ~= "" and arg_59_1.actors_[var_62_15.prefab_name] ~= nil then
						local var_62_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_15.prefab_name].transform, "story_v_out_319221", "319221014", "story_v_out_319221.awb")

						arg_59_1:RecordAudio("319221014", var_62_21)
						arg_59_1:RecordAudio("319221014", var_62_21)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_319221", "319221014", "story_v_out_319221.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_319221", "319221014", "story_v_out_319221.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_22 = math.max(var_62_13, arg_59_1.talkMaxDuration)

			if var_62_12 <= arg_59_1.time_ and arg_59_1.time_ < var_62_12 + var_62_22 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_12) / var_62_22

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_12 + var_62_22 and arg_59_1.time_ < var_62_12 + var_62_22 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play319221015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319221015
		arg_63_1.duration_ = 8.27

		local var_63_0 = {
			zh = 7.5,
			ja = 8.266
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play319221016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10079ui_story"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos10079ui_story = var_66_0.localPosition
			end

			local var_66_2 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2
				local var_66_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10079ui_story, var_66_4, var_66_3)

				local var_66_5 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_5.x, var_66_5.y, var_66_5.z)

				local var_66_6 = var_66_0.localEulerAngles

				var_66_6.z = 0
				var_66_6.x = 0
				var_66_0.localEulerAngles = var_66_6
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_66_7 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_7.x, var_66_7.y, var_66_7.z)

				local var_66_8 = var_66_0.localEulerAngles

				var_66_8.z = 0
				var_66_8.x = 0
				var_66_0.localEulerAngles = var_66_8
			end

			local var_66_9 = arg_63_1.actors_["10079ui_story"]
			local var_66_10 = 0

			if var_66_10 < arg_63_1.time_ and arg_63_1.time_ <= var_66_10 + arg_66_0 and not isNil(var_66_9) and arg_63_1.var_.characterEffect10079ui_story == nil then
				arg_63_1.var_.characterEffect10079ui_story = var_66_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_11 = 0.200000002980232

			if var_66_10 <= arg_63_1.time_ and arg_63_1.time_ < var_66_10 + var_66_11 and not isNil(var_66_9) then
				local var_66_12 = (arg_63_1.time_ - var_66_10) / var_66_11

				if arg_63_1.var_.characterEffect10079ui_story and not isNil(var_66_9) then
					arg_63_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_10 + var_66_11 and arg_63_1.time_ < var_66_10 + var_66_11 + arg_66_0 and not isNil(var_66_9) and arg_63_1.var_.characterEffect10079ui_story then
				arg_63_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_66_13 = 0

			if var_66_13 < arg_63_1.time_ and arg_63_1.time_ <= var_66_13 + arg_66_0 then
				arg_63_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_66_14 = 0

			if var_66_14 < arg_63_1.time_ and arg_63_1.time_ <= var_66_14 + arg_66_0 then
				arg_63_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_66_15 = arg_63_1.actors_["1095ui_story"]
			local var_66_16 = 0

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 and not isNil(var_66_15) and arg_63_1.var_.characterEffect1095ui_story == nil then
				arg_63_1.var_.characterEffect1095ui_story = var_66_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_17 = 0.200000002980232

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_17 and not isNil(var_66_15) then
				local var_66_18 = (arg_63_1.time_ - var_66_16) / var_66_17

				if arg_63_1.var_.characterEffect1095ui_story and not isNil(var_66_15) then
					local var_66_19 = Mathf.Lerp(0, 0.5, var_66_18)

					arg_63_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1095ui_story.fillRatio = var_66_19
				end
			end

			if arg_63_1.time_ >= var_66_16 + var_66_17 and arg_63_1.time_ < var_66_16 + var_66_17 + arg_66_0 and not isNil(var_66_15) and arg_63_1.var_.characterEffect1095ui_story then
				local var_66_20 = 0.5

				arg_63_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1095ui_story.fillRatio = var_66_20
			end

			local var_66_21 = 0
			local var_66_22 = 0.825

			if var_66_21 < arg_63_1.time_ and arg_63_1.time_ <= var_66_21 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_23 = arg_63_1:FormatText(StoryNameCfg[6].name)

				arg_63_1.leftNameTxt_.text = var_66_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_24 = arg_63_1:GetWordFromCfg(319221015)
				local var_66_25 = arg_63_1:FormatText(var_66_24.content)

				arg_63_1.text_.text = var_66_25

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_26 = 33
				local var_66_27 = utf8.len(var_66_25)
				local var_66_28 = var_66_26 <= 0 and var_66_22 or var_66_22 * (var_66_27 / var_66_26)

				if var_66_28 > 0 and var_66_22 < var_66_28 then
					arg_63_1.talkMaxDuration = var_66_28

					if var_66_28 + var_66_21 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_28 + var_66_21
					end
				end

				arg_63_1.text_.text = var_66_25
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221015", "story_v_out_319221.awb") ~= 0 then
					local var_66_29 = manager.audio:GetVoiceLength("story_v_out_319221", "319221015", "story_v_out_319221.awb") / 1000

					if var_66_29 + var_66_21 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_29 + var_66_21
					end

					if var_66_24.prefab_name ~= "" and arg_63_1.actors_[var_66_24.prefab_name] ~= nil then
						local var_66_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_24.prefab_name].transform, "story_v_out_319221", "319221015", "story_v_out_319221.awb")

						arg_63_1:RecordAudio("319221015", var_66_30)
						arg_63_1:RecordAudio("319221015", var_66_30)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_319221", "319221015", "story_v_out_319221.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_319221", "319221015", "story_v_out_319221.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_31 = math.max(var_66_22, arg_63_1.talkMaxDuration)

			if var_66_21 <= arg_63_1.time_ and arg_63_1.time_ < var_66_21 + var_66_31 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_21) / var_66_31

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_21 + var_66_31 and arg_63_1.time_ < var_66_21 + var_66_31 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play319221016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319221016
		arg_67_1.duration_ = 10.43

		local var_67_0 = {
			zh = 5.533,
			ja = 10.433
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play319221017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["10079ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect10079ui_story == nil then
				arg_67_1.var_.characterEffect10079ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect10079ui_story and not isNil(var_70_0) then
					local var_70_4 = Mathf.Lerp(0, 0.5, var_70_3)

					arg_67_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_67_1.var_.characterEffect10079ui_story.fillRatio = var_70_4
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect10079ui_story then
				local var_70_5 = 0.5

				arg_67_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_67_1.var_.characterEffect10079ui_story.fillRatio = var_70_5
			end

			local var_70_6 = arg_67_1.actors_["1095ui_story"]
			local var_70_7 = 0

			if var_70_7 < arg_67_1.time_ and arg_67_1.time_ <= var_70_7 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect1095ui_story == nil then
				arg_67_1.var_.characterEffect1095ui_story = var_70_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_8 = 0.200000002980232

			if var_70_7 <= arg_67_1.time_ and arg_67_1.time_ < var_70_7 + var_70_8 and not isNil(var_70_6) then
				local var_70_9 = (arg_67_1.time_ - var_70_7) / var_70_8

				if arg_67_1.var_.characterEffect1095ui_story and not isNil(var_70_6) then
					arg_67_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_7 + var_70_8 and arg_67_1.time_ < var_70_7 + var_70_8 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect1095ui_story then
				arg_67_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_70_11 = 0

			if var_70_11 < arg_67_1.time_ and arg_67_1.time_ <= var_70_11 + arg_70_0 then
				arg_67_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_70_12 = 0
			local var_70_13 = 0.75

			if var_70_12 < arg_67_1.time_ and arg_67_1.time_ <= var_70_12 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_14 = arg_67_1:FormatText(StoryNameCfg[471].name)

				arg_67_1.leftNameTxt_.text = var_70_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_15 = arg_67_1:GetWordFromCfg(319221016)
				local var_70_16 = arg_67_1:FormatText(var_70_15.content)

				arg_67_1.text_.text = var_70_16

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_17 = 30
				local var_70_18 = utf8.len(var_70_16)
				local var_70_19 = var_70_17 <= 0 and var_70_13 or var_70_13 * (var_70_18 / var_70_17)

				if var_70_19 > 0 and var_70_13 < var_70_19 then
					arg_67_1.talkMaxDuration = var_70_19

					if var_70_19 + var_70_12 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_19 + var_70_12
					end
				end

				arg_67_1.text_.text = var_70_16
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221016", "story_v_out_319221.awb") ~= 0 then
					local var_70_20 = manager.audio:GetVoiceLength("story_v_out_319221", "319221016", "story_v_out_319221.awb") / 1000

					if var_70_20 + var_70_12 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_20 + var_70_12
					end

					if var_70_15.prefab_name ~= "" and arg_67_1.actors_[var_70_15.prefab_name] ~= nil then
						local var_70_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_15.prefab_name].transform, "story_v_out_319221", "319221016", "story_v_out_319221.awb")

						arg_67_1:RecordAudio("319221016", var_70_21)
						arg_67_1:RecordAudio("319221016", var_70_21)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_319221", "319221016", "story_v_out_319221.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_319221", "319221016", "story_v_out_319221.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_22 = math.max(var_70_13, arg_67_1.talkMaxDuration)

			if var_70_12 <= arg_67_1.time_ and arg_67_1.time_ < var_70_12 + var_70_22 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_12) / var_70_22

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_12 + var_70_22 and arg_67_1.time_ < var_70_12 + var_70_22 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play319221017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319221017
		arg_71_1.duration_ = 6.6

		local var_71_0 = {
			zh = 2.1,
			ja = 6.6
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play319221018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1095ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1095ui_story == nil then
				arg_71_1.var_.characterEffect1095ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect1095ui_story and not isNil(var_74_0) then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1095ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1095ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1095ui_story.fillRatio = var_74_5
			end

			local var_74_6 = arg_71_1.actors_["10079ui_story"]
			local var_74_7 = 0

			if var_74_7 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect10079ui_story == nil then
				arg_71_1.var_.characterEffect10079ui_story = var_74_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_8 = 0.200000002980232

			if var_74_7 <= arg_71_1.time_ and arg_71_1.time_ < var_74_7 + var_74_8 and not isNil(var_74_6) then
				local var_74_9 = (arg_71_1.time_ - var_74_7) / var_74_8

				if arg_71_1.var_.characterEffect10079ui_story and not isNil(var_74_6) then
					arg_71_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_7 + var_74_8 and arg_71_1.time_ < var_74_7 + var_74_8 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect10079ui_story then
				arg_71_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_74_11 = 0
			local var_74_12 = 0.25

			if var_74_11 < arg_71_1.time_ and arg_71_1.time_ <= var_74_11 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_13 = arg_71_1:FormatText(StoryNameCfg[6].name)

				arg_71_1.leftNameTxt_.text = var_74_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_14 = arg_71_1:GetWordFromCfg(319221017)
				local var_74_15 = arg_71_1:FormatText(var_74_14.content)

				arg_71_1.text_.text = var_74_15

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_16 = 10
				local var_74_17 = utf8.len(var_74_15)
				local var_74_18 = var_74_16 <= 0 and var_74_12 or var_74_12 * (var_74_17 / var_74_16)

				if var_74_18 > 0 and var_74_12 < var_74_18 then
					arg_71_1.talkMaxDuration = var_74_18

					if var_74_18 + var_74_11 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_18 + var_74_11
					end
				end

				arg_71_1.text_.text = var_74_15
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221017", "story_v_out_319221.awb") ~= 0 then
					local var_74_19 = manager.audio:GetVoiceLength("story_v_out_319221", "319221017", "story_v_out_319221.awb") / 1000

					if var_74_19 + var_74_11 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_19 + var_74_11
					end

					if var_74_14.prefab_name ~= "" and arg_71_1.actors_[var_74_14.prefab_name] ~= nil then
						local var_74_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_14.prefab_name].transform, "story_v_out_319221", "319221017", "story_v_out_319221.awb")

						arg_71_1:RecordAudio("319221017", var_74_20)
						arg_71_1:RecordAudio("319221017", var_74_20)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_319221", "319221017", "story_v_out_319221.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_319221", "319221017", "story_v_out_319221.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_21 = math.max(var_74_12, arg_71_1.talkMaxDuration)

			if var_74_11 <= arg_71_1.time_ and arg_71_1.time_ < var_74_11 + var_74_21 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_11) / var_74_21

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_11 + var_74_21 and arg_71_1.time_ < var_74_11 + var_74_21 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play319221018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319221018
		arg_75_1.duration_ = 4.4

		local var_75_0 = {
			zh = 2.7,
			ja = 4.4
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play319221019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1095ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1095ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(0.7, -0.98, -6.1)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1095ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = arg_75_1.actors_["1095ui_story"]
			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect1095ui_story == nil then
				arg_75_1.var_.characterEffect1095ui_story = var_78_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_11 = 0.200000002980232

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_11 and not isNil(var_78_9) then
				local var_78_12 = (arg_75_1.time_ - var_78_10) / var_78_11

				if arg_75_1.var_.characterEffect1095ui_story and not isNil(var_78_9) then
					arg_75_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_10 + var_78_11 and arg_75_1.time_ < var_78_10 + var_78_11 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect1095ui_story then
				arg_75_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_78_13 = arg_75_1.actors_["10079ui_story"]
			local var_78_14 = 0

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 and not isNil(var_78_13) and arg_75_1.var_.characterEffect10079ui_story == nil then
				arg_75_1.var_.characterEffect10079ui_story = var_78_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_15 = 0.200000002980232

			if var_78_14 <= arg_75_1.time_ and arg_75_1.time_ < var_78_14 + var_78_15 and not isNil(var_78_13) then
				local var_78_16 = (arg_75_1.time_ - var_78_14) / var_78_15

				if arg_75_1.var_.characterEffect10079ui_story and not isNil(var_78_13) then
					local var_78_17 = Mathf.Lerp(0, 0.5, var_78_16)

					arg_75_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10079ui_story.fillRatio = var_78_17
				end
			end

			if arg_75_1.time_ >= var_78_14 + var_78_15 and arg_75_1.time_ < var_78_14 + var_78_15 + arg_78_0 and not isNil(var_78_13) and arg_75_1.var_.characterEffect10079ui_story then
				local var_78_18 = 0.5

				arg_75_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10079ui_story.fillRatio = var_78_18
			end

			local var_78_19 = 0
			local var_78_20 = 0.25

			if var_78_19 < arg_75_1.time_ and arg_75_1.time_ <= var_78_19 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_21 = arg_75_1:FormatText(StoryNameCfg[471].name)

				arg_75_1.leftNameTxt_.text = var_78_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_22 = arg_75_1:GetWordFromCfg(319221018)
				local var_78_23 = arg_75_1:FormatText(var_78_22.content)

				arg_75_1.text_.text = var_78_23

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_24 = 10
				local var_78_25 = utf8.len(var_78_23)
				local var_78_26 = var_78_24 <= 0 and var_78_20 or var_78_20 * (var_78_25 / var_78_24)

				if var_78_26 > 0 and var_78_20 < var_78_26 then
					arg_75_1.talkMaxDuration = var_78_26

					if var_78_26 + var_78_19 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_26 + var_78_19
					end
				end

				arg_75_1.text_.text = var_78_23
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221018", "story_v_out_319221.awb") ~= 0 then
					local var_78_27 = manager.audio:GetVoiceLength("story_v_out_319221", "319221018", "story_v_out_319221.awb") / 1000

					if var_78_27 + var_78_19 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_27 + var_78_19
					end

					if var_78_22.prefab_name ~= "" and arg_75_1.actors_[var_78_22.prefab_name] ~= nil then
						local var_78_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_22.prefab_name].transform, "story_v_out_319221", "319221018", "story_v_out_319221.awb")

						arg_75_1:RecordAudio("319221018", var_78_28)
						arg_75_1:RecordAudio("319221018", var_78_28)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_319221", "319221018", "story_v_out_319221.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_319221", "319221018", "story_v_out_319221.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_29 = math.max(var_78_20, arg_75_1.talkMaxDuration)

			if var_78_19 <= arg_75_1.time_ and arg_75_1.time_ < var_78_19 + var_78_29 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_19) / var_78_29

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_19 + var_78_29 and arg_75_1.time_ < var_78_19 + var_78_29 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play319221019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319221019
		arg_79_1.duration_ = 17.5

		local var_79_0 = {
			zh = 9.5,
			ja = 17.5
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
			arg_79_1.auto_ = false
		end

		function arg_79_1.playNext_(arg_81_0)
			arg_79_1.onStoryFinished_()
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 1.3

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[471].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:GetWordFromCfg(319221019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 52
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319221", "319221019", "story_v_out_319221.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_319221", "319221019", "story_v_out_319221.awb") / 1000

					if var_82_8 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_0
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_out_319221", "319221019", "story_v_out_319221.awb")

						arg_79_1:RecordAudio("319221019", var_82_9)
						arg_79_1:RecordAudio("319221019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_319221", "319221019", "story_v_out_319221.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_319221", "319221019", "story_v_out_319221.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_10 and arg_79_1.time_ < var_82_0 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I12g"
	},
	voices = {
		"story_v_out_319221.awb"
	}
}
