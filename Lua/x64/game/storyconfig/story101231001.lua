return {
	Play123101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 123101001
		arg_1_1.duration_ = 9.5

		local var_1_0 = {
			zh = 6.165999999999,
			ja = 9.499999999999
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
				arg_1_0:Play123101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K05f"

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
				local var_4_5 = arg_1_1.bgs_.K05f

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
					if iter_4_0 ~= "K05f" then
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

			local var_4_22 = "1093ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1093ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1093ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -1.11, -5.88)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1093ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1093ui_story"]
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1093ui_story == nil then
				arg_1_1.var_.characterEffect1093ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1093ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1093ui_story then
				arg_1_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_4_42 = 0
			local var_4_43 = 0.866666666666667

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "music"

				arg_1_1:AudioAction(var_4_44, var_4_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_46 = ""
				local var_4_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_47 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_47 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_47

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_47
						arg_1_1.bgmTxt2_.text = var_4_47
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

			local var_4_48 = 1.8
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_54 = 1.999999999999
			local var_4_55 = 0.575

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_56 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_56:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[73].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(123101001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 23
				local var_4_61 = utf8.len(var_4_59)
				local var_4_62 = var_4_60 <= 0 and var_4_55 or var_4_55 * (var_4_61 / var_4_60)

				if var_4_62 > 0 and var_4_55 < var_4_62 then
					arg_1_1.talkMaxDuration = var_4_62
					var_4_54 = var_4_54 + 0.3

					if var_4_62 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_59
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101001", "story_v_out_123101.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_123101", "123101001", "story_v_out_123101.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_123101", "123101001", "story_v_out_123101.awb")

						arg_1_1:RecordAudio("123101001", var_4_64)
						arg_1_1:RecordAudio("123101001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_123101", "123101001", "story_v_out_123101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_123101", "123101001", "story_v_out_123101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_65 = var_4_54 + 0.3
			local var_4_66 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_65 <= arg_1_1.time_ and arg_1_1.time_ < var_4_65 + var_4_66 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_65) / var_4_66

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_65 + var_4_66 and arg_1_1.time_ < var_4_65 + var_4_66 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play123101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 123101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play123101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1093ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1093ui_story == nil then
				arg_9_1.var_.characterEffect1093ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect1093ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1093ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1093ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1093ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 0.225

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

				local var_12_9 = arg_9_1:GetWordFromCfg(123101002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 9
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
	Play123101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 123101003
		arg_13_1.duration_ = 10.4

		local var_13_0 = {
			zh = 8.233,
			ja = 10.4
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
				arg_13_0:Play123101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1093ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1093ui_story == nil then
				arg_13_1.var_.characterEffect1093ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1093ui_story and not isNil(var_16_0) then
					arg_13_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1093ui_story then
				arg_13_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_16_4 = 0

			if var_16_4 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action426")
			end

			local var_16_6 = 0
			local var_16_7 = 0.825

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_8 = arg_13_1:FormatText(StoryNameCfg[73].name)

				arg_13_1.leftNameTxt_.text = var_16_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_9 = arg_13_1:GetWordFromCfg(123101003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 33
				local var_16_12 = utf8.len(var_16_10)
				local var_16_13 = var_16_11 <= 0 and var_16_7 or var_16_7 * (var_16_12 / var_16_11)

				if var_16_13 > 0 and var_16_7 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101003", "story_v_out_123101.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101003", "story_v_out_123101.awb") / 1000

					if var_16_14 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_6
					end

					if var_16_9.prefab_name ~= "" and arg_13_1.actors_[var_16_9.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_9.prefab_name].transform, "story_v_out_123101", "123101003", "story_v_out_123101.awb")

						arg_13_1:RecordAudio("123101003", var_16_15)
						arg_13_1:RecordAudio("123101003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_123101", "123101003", "story_v_out_123101.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_123101", "123101003", "story_v_out_123101.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_16 and arg_13_1.time_ < var_16_6 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play123101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 123101004
		arg_17_1.duration_ = 3.6

		local var_17_0 = {
			zh = 3.066,
			ja = 3.6
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
				arg_17_0:Play123101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1093ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1093ui_story == nil then
				arg_17_1.var_.characterEffect1093ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1093ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1093ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1093ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1093ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.3

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[495].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(123101004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 12
				local var_20_12 = utf8.len(var_20_10)
				local var_20_13 = var_20_11 <= 0 and var_20_7 or var_20_7 * (var_20_12 / var_20_11)

				if var_20_13 > 0 and var_20_7 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101004", "story_v_out_123101.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101004", "story_v_out_123101.awb") / 1000

					if var_20_14 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_6
					end

					if var_20_9.prefab_name ~= "" and arg_17_1.actors_[var_20_9.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_9.prefab_name].transform, "story_v_out_123101", "123101004", "story_v_out_123101.awb")

						arg_17_1:RecordAudio("123101004", var_20_15)
						arg_17_1:RecordAudio("123101004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_123101", "123101004", "story_v_out_123101.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_123101", "123101004", "story_v_out_123101.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_16 and arg_17_1.time_ < var_20_6 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play123101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 123101005
		arg_21_1.duration_ = 2

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play123101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1093ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1093ui_story == nil then
				arg_21_1.var_.characterEffect1093ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1093ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1093ui_story then
				arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_24_4 = 0

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_24_5 = 0
			local var_24_6 = 0.05

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_7 = arg_21_1:FormatText(StoryNameCfg[73].name)

				arg_21_1.leftNameTxt_.text = var_24_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(123101005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 2
				local var_24_11 = utf8.len(var_24_9)
				local var_24_12 = var_24_10 <= 0 and var_24_6 or var_24_6 * (var_24_11 / var_24_10)

				if var_24_12 > 0 and var_24_6 < var_24_12 then
					arg_21_1.talkMaxDuration = var_24_12

					if var_24_12 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101005", "story_v_out_123101.awb") ~= 0 then
					local var_24_13 = manager.audio:GetVoiceLength("story_v_out_123101", "123101005", "story_v_out_123101.awb") / 1000

					if var_24_13 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_5
					end

					if var_24_8.prefab_name ~= "" and arg_21_1.actors_[var_24_8.prefab_name] ~= nil then
						local var_24_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_8.prefab_name].transform, "story_v_out_123101", "123101005", "story_v_out_123101.awb")

						arg_21_1:RecordAudio("123101005", var_24_14)
						arg_21_1:RecordAudio("123101005", var_24_14)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_123101", "123101005", "story_v_out_123101.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_123101", "123101005", "story_v_out_123101.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_15 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_15 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_15

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_15 and arg_21_1.time_ < var_24_5 + var_24_15 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play123101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 123101006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play123101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1093ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1093ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1093ui_story, var_28_4, var_28_3)

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

			local var_28_9 = arg_25_1.actors_["1093ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1093ui_story == nil then
				arg_25_1.var_.characterEffect1093ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1093ui_story and not isNil(var_28_9) then
					local var_28_13 = Mathf.Lerp(0, 0.5, var_28_12)

					arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1093ui_story.fillRatio = var_28_13
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1093ui_story then
				local var_28_14 = 0.5

				arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1093ui_story.fillRatio = var_28_14
			end

			local var_28_15 = 0
			local var_28_16 = 2

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

				local var_28_17 = arg_25_1:GetWordFromCfg(123101006)
				local var_28_18 = arg_25_1:FormatText(var_28_17.content)

				arg_25_1.text_.text = var_28_18

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_19 = 80
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
				actorName = "1093ui_story",
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
	Play123101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 123101007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play123101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.175

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(123101007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 47
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play123101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 123101008
		arg_33_1.duration_ = 2.17

		local var_33_0 = {
			zh = 2.133,
			ja = 2.166
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
				arg_33_0:Play123101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.2

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[357].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(123101008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 8
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101008", "story_v_out_123101.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101008", "story_v_out_123101.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_123101", "123101008", "story_v_out_123101.awb")

						arg_33_1:RecordAudio("123101008", var_36_9)
						arg_33_1:RecordAudio("123101008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_123101", "123101008", "story_v_out_123101.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_123101", "123101008", "story_v_out_123101.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play123101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 123101009
		arg_37_1.duration_ = 3.93

		local var_37_0 = {
			zh = 3.933,
			ja = 3.766
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
				arg_37_0:Play123101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.525

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[357].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(123101009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101009", "story_v_out_123101.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101009", "story_v_out_123101.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_123101", "123101009", "story_v_out_123101.awb")

						arg_37_1:RecordAudio("123101009", var_40_9)
						arg_37_1:RecordAudio("123101009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_123101", "123101009", "story_v_out_123101.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_123101", "123101009", "story_v_out_123101.awb")
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
	Play123101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 123101010
		arg_41_1.duration_ = 4.23

		local var_41_0 = {
			zh = 4.233,
			ja = 4.166
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
				arg_41_0:Play123101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.5

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[495].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(123101010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101010", "story_v_out_123101.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101010", "story_v_out_123101.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_123101", "123101010", "story_v_out_123101.awb")

						arg_41_1:RecordAudio("123101010", var_44_9)
						arg_41_1:RecordAudio("123101010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_123101", "123101010", "story_v_out_123101.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_123101", "123101010", "story_v_out_123101.awb")
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
	Play123101011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 123101011
		arg_45_1.duration_ = 4.6

		local var_45_0 = {
			zh = 3.5,
			ja = 4.6
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
				arg_45_0:Play123101012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.3

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[495].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(123101011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101011", "story_v_out_123101.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101011", "story_v_out_123101.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_123101", "123101011", "story_v_out_123101.awb")

						arg_45_1:RecordAudio("123101011", var_48_9)
						arg_45_1:RecordAudio("123101011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_123101", "123101011", "story_v_out_123101.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_123101", "123101011", "story_v_out_123101.awb")
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
	Play123101012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 123101012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play123101013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1.125

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(123101012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 45
				local var_52_5 = utf8.len(var_52_3)
				local var_52_6 = var_52_4 <= 0 and var_52_1 or var_52_1 * (var_52_5 / var_52_4)

				if var_52_6 > 0 and var_52_1 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_7 and arg_49_1.time_ < var_52_0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play123101013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 123101013
		arg_53_1.duration_ = 3.43

		local var_53_0 = {
			zh = 1.7,
			ja = 3.433
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
				arg_53_0:Play123101014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.225

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[495].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(123101013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 9
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101013", "story_v_out_123101.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101013", "story_v_out_123101.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_123101", "123101013", "story_v_out_123101.awb")

						arg_53_1:RecordAudio("123101013", var_56_9)
						arg_53_1:RecordAudio("123101013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_123101", "123101013", "story_v_out_123101.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_123101", "123101013", "story_v_out_123101.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play123101014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 123101014
		arg_57_1.duration_ = 10.03

		local var_57_0 = {
			zh = 10.033,
			ja = 6.2
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
				arg_57_0:Play123101015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.775

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[36].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(123101014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101014", "story_v_out_123101.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101014", "story_v_out_123101.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_123101", "123101014", "story_v_out_123101.awb")

						arg_57_1:RecordAudio("123101014", var_60_9)
						arg_57_1:RecordAudio("123101014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_123101", "123101014", "story_v_out_123101.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_123101", "123101014", "story_v_out_123101.awb")
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
	Play123101015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 123101015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play123101016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.95

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(123101015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 38
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play123101016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 123101016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play123101017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.075

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(123101016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 3
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play123101017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 123101017
		arg_69_1.duration_ = 6.97

		local var_69_0 = {
			zh = 6.966,
			ja = 2.5
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
				arg_69_0:Play123101018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "1055ui_story"

			if arg_69_1.actors_[var_72_0] == nil then
				local var_72_1 = Asset.Load("Char/" .. "1055ui_story")

				if not isNil(var_72_1) then
					local var_72_2 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_69_1.stage_.transform)

					var_72_2.name = var_72_0
					var_72_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_69_1.actors_[var_72_0] = var_72_2

					local var_72_3 = var_72_2:GetComponentInChildren(typeof(CharacterEffect))

					var_72_3.enabled = true

					local var_72_4 = GameObjectTools.GetOrAddComponent(var_72_2, typeof(DynamicBoneHelper))

					if var_72_4 then
						var_72_4:EnableDynamicBone(false)
					end

					arg_69_1:ShowWeapon(var_72_3.transform, false)

					arg_69_1.var_[var_72_0 .. "Animator"] = var_72_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_69_1.var_[var_72_0 .. "Animator"].applyRootMotion = true
					arg_69_1.var_[var_72_0 .. "LipSync"] = var_72_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_72_5 = arg_69_1.actors_["1055ui_story"].transform
			local var_72_6 = 0

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.var_.moveOldPos1055ui_story = var_72_5.localPosition
			end

			local var_72_7 = 0.001

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_7 then
				local var_72_8 = (arg_69_1.time_ - var_72_6) / var_72_7
				local var_72_9 = Vector3.New(0, -0.965, -6.2)

				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1055ui_story, var_72_9, var_72_8)

				local var_72_10 = manager.ui.mainCamera.transform.position - var_72_5.position

				var_72_5.forward = Vector3.New(var_72_10.x, var_72_10.y, var_72_10.z)

				local var_72_11 = var_72_5.localEulerAngles

				var_72_11.z = 0
				var_72_11.x = 0
				var_72_5.localEulerAngles = var_72_11
			end

			if arg_69_1.time_ >= var_72_6 + var_72_7 and arg_69_1.time_ < var_72_6 + var_72_7 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_72_12 = manager.ui.mainCamera.transform.position - var_72_5.position

				var_72_5.forward = Vector3.New(var_72_12.x, var_72_12.y, var_72_12.z)

				local var_72_13 = var_72_5.localEulerAngles

				var_72_13.z = 0
				var_72_13.x = 0
				var_72_5.localEulerAngles = var_72_13
			end

			local var_72_14 = arg_69_1.actors_["1055ui_story"]
			local var_72_15 = 0

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.characterEffect1055ui_story == nil then
				arg_69_1.var_.characterEffect1055ui_story = var_72_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_16 = 0.200000002980232

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_16 and not isNil(var_72_14) then
				local var_72_17 = (arg_69_1.time_ - var_72_15) / var_72_16

				if arg_69_1.var_.characterEffect1055ui_story and not isNil(var_72_14) then
					arg_69_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_15 + var_72_16 and arg_69_1.time_ < var_72_15 + var_72_16 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.characterEffect1055ui_story then
				arg_69_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_72_18 = 0

			if var_72_18 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			local var_72_19 = 0

			if var_72_19 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				arg_69_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_72_20 = 0
			local var_72_21 = 0.825

			if var_72_20 < arg_69_1.time_ and arg_69_1.time_ <= var_72_20 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_22 = arg_69_1:FormatText(StoryNameCfg[481].name)

				arg_69_1.leftNameTxt_.text = var_72_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_23 = arg_69_1:GetWordFromCfg(123101017)
				local var_72_24 = arg_69_1:FormatText(var_72_23.content)

				arg_69_1.text_.text = var_72_24

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_25 = 33
				local var_72_26 = utf8.len(var_72_24)
				local var_72_27 = var_72_25 <= 0 and var_72_21 or var_72_21 * (var_72_26 / var_72_25)

				if var_72_27 > 0 and var_72_21 < var_72_27 then
					arg_69_1.talkMaxDuration = var_72_27

					if var_72_27 + var_72_20 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_27 + var_72_20
					end
				end

				arg_69_1.text_.text = var_72_24
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101017", "story_v_out_123101.awb") ~= 0 then
					local var_72_28 = manager.audio:GetVoiceLength("story_v_out_123101", "123101017", "story_v_out_123101.awb") / 1000

					if var_72_28 + var_72_20 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_28 + var_72_20
					end

					if var_72_23.prefab_name ~= "" and arg_69_1.actors_[var_72_23.prefab_name] ~= nil then
						local var_72_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_23.prefab_name].transform, "story_v_out_123101", "123101017", "story_v_out_123101.awb")

						arg_69_1:RecordAudio("123101017", var_72_29)
						arg_69_1:RecordAudio("123101017", var_72_29)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_123101", "123101017", "story_v_out_123101.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_123101", "123101017", "story_v_out_123101.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_30 = math.max(var_72_21, arg_69_1.talkMaxDuration)

			if var_72_20 <= arg_69_1.time_ and arg_69_1.time_ < var_72_20 + var_72_30 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_20) / var_72_30

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_20 + var_72_30 and arg_69_1.time_ < var_72_20 + var_72_30 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play123101018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 123101018
		arg_73_1.duration_ = 3.73

		local var_73_0 = {
			zh = 2,
			ja = 3.733
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
				arg_73_0:Play123101019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1055ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1055ui_story == nil then
				arg_73_1.var_.characterEffect1055ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1055ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1055ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1055ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1055ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.15

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[495].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(123101018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 6
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_7 or var_76_7 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_7 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101018", "story_v_out_123101.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101018", "story_v_out_123101.awb") / 1000

					if var_76_14 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_6
					end

					if var_76_9.prefab_name ~= "" and arg_73_1.actors_[var_76_9.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_9.prefab_name].transform, "story_v_out_123101", "123101018", "story_v_out_123101.awb")

						arg_73_1:RecordAudio("123101018", var_76_15)
						arg_73_1:RecordAudio("123101018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_123101", "123101018", "story_v_out_123101.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_123101", "123101018", "story_v_out_123101.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_16 and arg_73_1.time_ < var_76_6 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play123101019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 123101019
		arg_77_1.duration_ = 7.73

		local var_77_0 = {
			zh = 4.833,
			ja = 7.733
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
				arg_77_0:Play123101020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1055ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1055ui_story == nil then
				arg_77_1.var_.characterEffect1055ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1055ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1055ui_story then
				arg_77_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_80_4 = 0

			if var_80_4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_80_5 = 0
			local var_80_6 = 0.525

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_7 = arg_77_1:FormatText(StoryNameCfg[481].name)

				arg_77_1.leftNameTxt_.text = var_80_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(123101019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 21
				local var_80_11 = utf8.len(var_80_9)
				local var_80_12 = var_80_10 <= 0 and var_80_6 or var_80_6 * (var_80_11 / var_80_10)

				if var_80_12 > 0 and var_80_6 < var_80_12 then
					arg_77_1.talkMaxDuration = var_80_12

					if var_80_12 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101019", "story_v_out_123101.awb") ~= 0 then
					local var_80_13 = manager.audio:GetVoiceLength("story_v_out_123101", "123101019", "story_v_out_123101.awb") / 1000

					if var_80_13 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_5
					end

					if var_80_8.prefab_name ~= "" and arg_77_1.actors_[var_80_8.prefab_name] ~= nil then
						local var_80_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_8.prefab_name].transform, "story_v_out_123101", "123101019", "story_v_out_123101.awb")

						arg_77_1:RecordAudio("123101019", var_80_14)
						arg_77_1:RecordAudio("123101019", var_80_14)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_123101", "123101019", "story_v_out_123101.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_123101", "123101019", "story_v_out_123101.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_15 = math.max(var_80_6, arg_77_1.talkMaxDuration)

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_15 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_5) / var_80_15

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_5 + var_80_15 and arg_77_1.time_ < var_80_5 + var_80_15 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play123101020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 123101020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play123101021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1055ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1055ui_story == nil then
				arg_81_1.var_.characterEffect1055ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1055ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1055ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1055ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1055ui_story.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 0.2

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(123101020)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 8
				local var_84_11 = utf8.len(var_84_9)
				local var_84_12 = var_84_10 <= 0 and var_84_7 or var_84_7 * (var_84_11 / var_84_10)

				if var_84_12 > 0 and var_84_7 < var_84_12 then
					arg_81_1.talkMaxDuration = var_84_12

					if var_84_12 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_13 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_13 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_13

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_13 and arg_81_1.time_ < var_84_6 + var_84_13 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play123101021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 123101021
		arg_85_1.duration_ = 3.6

		local var_85_0 = {
			zh = 2.1,
			ja = 3.6
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
				arg_85_0:Play123101022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.225

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[495].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(123101021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101021", "story_v_out_123101.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101021", "story_v_out_123101.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_123101", "123101021", "story_v_out_123101.awb")

						arg_85_1:RecordAudio("123101021", var_88_9)
						arg_85_1:RecordAudio("123101021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_123101", "123101021", "story_v_out_123101.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_123101", "123101021", "story_v_out_123101.awb")
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
	Play123101022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 123101022
		arg_89_1.duration_ = 5.97

		local var_89_0 = {
			zh = 3.933,
			ja = 5.966
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
				arg_89_0:Play123101023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1055ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1055ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, -0.965, -6.2)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1055ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["1055ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1055ui_story == nil then
				arg_89_1.var_.characterEffect1055ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect1055ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1055ui_story then
				arg_89_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_2")
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_92_15 = 0
			local var_92_16 = 0.45

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[481].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(123101022)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 18
				local var_92_21 = utf8.len(var_92_19)
				local var_92_22 = var_92_20 <= 0 and var_92_16 or var_92_16 * (var_92_21 / var_92_20)

				if var_92_22 > 0 and var_92_16 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22

					if var_92_22 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101022", "story_v_out_123101.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_out_123101", "123101022", "story_v_out_123101.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_out_123101", "123101022", "story_v_out_123101.awb")

						arg_89_1:RecordAudio("123101022", var_92_24)
						arg_89_1:RecordAudio("123101022", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_123101", "123101022", "story_v_out_123101.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_123101", "123101022", "story_v_out_123101.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_25 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_25 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_25

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_25 and arg_89_1.time_ < var_92_15 + var_92_25 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123101023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 123101023
		arg_93_1.duration_ = 10.43

		local var_93_0 = {
			zh = 7.9,
			ja = 10.433
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
				arg_93_0:Play123101024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_96_2 = 0
			local var_96_3 = 0.925

			if var_96_2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_4 = arg_93_1:FormatText(StoryNameCfg[481].name)

				arg_93_1.leftNameTxt_.text = var_96_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_5 = arg_93_1:GetWordFromCfg(123101023)
				local var_96_6 = arg_93_1:FormatText(var_96_5.content)

				arg_93_1.text_.text = var_96_6

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 37
				local var_96_8 = utf8.len(var_96_6)
				local var_96_9 = var_96_7 <= 0 and var_96_3 or var_96_3 * (var_96_8 / var_96_7)

				if var_96_9 > 0 and var_96_3 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_6
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101023", "story_v_out_123101.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101023", "story_v_out_123101.awb") / 1000

					if var_96_10 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_2
					end

					if var_96_5.prefab_name ~= "" and arg_93_1.actors_[var_96_5.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_5.prefab_name].transform, "story_v_out_123101", "123101023", "story_v_out_123101.awb")

						arg_93_1:RecordAudio("123101023", var_96_11)
						arg_93_1:RecordAudio("123101023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_123101", "123101023", "story_v_out_123101.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_123101", "123101023", "story_v_out_123101.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_12 and arg_93_1.time_ < var_96_2 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play123101024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 123101024
		arg_97_1.duration_ = 5.93

		local var_97_0 = {
			zh = 4.833,
			ja = 5.933
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
				arg_97_0:Play123101025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1055ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1055ui_story == nil then
				arg_97_1.var_.characterEffect1055ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1055ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1055ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1055ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1055ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.625

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[495].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_9 = arg_97_1:GetWordFromCfg(123101024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101024", "story_v_out_123101.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101024", "story_v_out_123101.awb") / 1000

					if var_100_14 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_6
					end

					if var_100_9.prefab_name ~= "" and arg_97_1.actors_[var_100_9.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_9.prefab_name].transform, "story_v_out_123101", "123101024", "story_v_out_123101.awb")

						arg_97_1:RecordAudio("123101024", var_100_15)
						arg_97_1:RecordAudio("123101024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_123101", "123101024", "story_v_out_123101.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_123101", "123101024", "story_v_out_123101.awb")
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
	Play123101025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 123101025
		arg_101_1.duration_ = 7.23

		local var_101_0 = {
			zh = 4.4,
			ja = 7.233
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
				arg_101_0:Play123101026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1055ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1055ui_story == nil then
				arg_101_1.var_.characterEffect1055ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1055ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1055ui_story then
				arg_101_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_104_4 = 0

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_104_6 = 0
			local var_104_7 = 0.25

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_8 = arg_101_1:FormatText(StoryNameCfg[481].name)

				arg_101_1.leftNameTxt_.text = var_104_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_9 = arg_101_1:GetWordFromCfg(123101025)
				local var_104_10 = arg_101_1:FormatText(var_104_9.content)

				arg_101_1.text_.text = var_104_10

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101025", "story_v_out_123101.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101025", "story_v_out_123101.awb") / 1000

					if var_104_14 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_6
					end

					if var_104_9.prefab_name ~= "" and arg_101_1.actors_[var_104_9.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_9.prefab_name].transform, "story_v_out_123101", "123101025", "story_v_out_123101.awb")

						arg_101_1:RecordAudio("123101025", var_104_15)
						arg_101_1:RecordAudio("123101025", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_123101", "123101025", "story_v_out_123101.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_123101", "123101025", "story_v_out_123101.awb")
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
	Play123101026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 123101026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play123101027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1055ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1055ui_story == nil then
				arg_105_1.var_.characterEffect1055ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1055ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1055ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1055ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1055ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 1.25

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:GetWordFromCfg(123101026)
				local var_108_9 = arg_105_1:FormatText(var_108_8.content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 50
				local var_108_11 = utf8.len(var_108_9)
				local var_108_12 = var_108_10 <= 0 and var_108_7 or var_108_7 * (var_108_11 / var_108_10)

				if var_108_12 > 0 and var_108_7 < var_108_12 then
					arg_105_1.talkMaxDuration = var_108_12

					if var_108_12 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_13 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_13

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_13 and arg_105_1.time_ < var_108_6 + var_108_13 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play123101027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 123101027
		arg_109_1.duration_ = 5.13

		local var_109_0 = {
			zh = 5.133,
			ja = 3.1
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
				arg_109_0:Play123101028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1055ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1055ui_story == nil then
				arg_109_1.var_.characterEffect1055ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1055ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1055ui_story then
				arg_109_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_112_4 = 0

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_112_5 = 0

			if var_112_5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_112_6 = 0
			local var_112_7 = 0.625

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[481].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_9 = arg_109_1:GetWordFromCfg(123101027)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101027", "story_v_out_123101.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101027", "story_v_out_123101.awb") / 1000

					if var_112_14 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_6
					end

					if var_112_9.prefab_name ~= "" and arg_109_1.actors_[var_112_9.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_9.prefab_name].transform, "story_v_out_123101", "123101027", "story_v_out_123101.awb")

						arg_109_1:RecordAudio("123101027", var_112_15)
						arg_109_1:RecordAudio("123101027", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_123101", "123101027", "story_v_out_123101.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_123101", "123101027", "story_v_out_123101.awb")
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
	Play123101028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 123101028
		arg_113_1.duration_ = 5.93

		local var_113_0 = {
			zh = 4.533,
			ja = 5.933
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
				arg_113_0:Play123101029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1055ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1055ui_story == nil then
				arg_113_1.var_.characterEffect1055ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1055ui_story and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1055ui_story.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1055ui_story then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1055ui_story.fillRatio = var_116_5
			end

			local var_116_6 = 0
			local var_116_7 = 0.4

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_8 = arg_113_1:FormatText(StoryNameCfg[495].name)

				arg_113_1.leftNameTxt_.text = var_116_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_9 = arg_113_1:GetWordFromCfg(123101028)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 16
				local var_116_12 = utf8.len(var_116_10)
				local var_116_13 = var_116_11 <= 0 and var_116_7 or var_116_7 * (var_116_12 / var_116_11)

				if var_116_13 > 0 and var_116_7 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101028", "story_v_out_123101.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101028", "story_v_out_123101.awb") / 1000

					if var_116_14 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_6
					end

					if var_116_9.prefab_name ~= "" and arg_113_1.actors_[var_116_9.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_9.prefab_name].transform, "story_v_out_123101", "123101028", "story_v_out_123101.awb")

						arg_113_1:RecordAudio("123101028", var_116_15)
						arg_113_1:RecordAudio("123101028", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_123101", "123101028", "story_v_out_123101.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_123101", "123101028", "story_v_out_123101.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_16 and arg_113_1.time_ < var_116_6 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play123101029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 123101029
		arg_117_1.duration_ = 9.4

		local var_117_0 = {
			zh = 7.066,
			ja = 9.4
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
				arg_117_0:Play123101030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.775

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[498].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:GetWordFromCfg(123101029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101029", "story_v_out_123101.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101029", "story_v_out_123101.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_123101", "123101029", "story_v_out_123101.awb")

						arg_117_1:RecordAudio("123101029", var_120_9)
						arg_117_1:RecordAudio("123101029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_123101", "123101029", "story_v_out_123101.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_123101", "123101029", "story_v_out_123101.awb")
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
	Play123101030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 123101030
		arg_121_1.duration_ = 8.37

		local var_121_0 = {
			zh = 8.366,
			ja = 6.333
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
				arg_121_0:Play123101031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.9

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[495].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(123101030)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 36
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101030", "story_v_out_123101.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101030", "story_v_out_123101.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_123101", "123101030", "story_v_out_123101.awb")

						arg_121_1:RecordAudio("123101030", var_124_9)
						arg_121_1:RecordAudio("123101030", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_123101", "123101030", "story_v_out_123101.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_123101", "123101030", "story_v_out_123101.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_10 and arg_121_1.time_ < var_124_0 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play123101031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 123101031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play123101032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.475

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(123101031)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 19
				local var_128_5 = utf8.len(var_128_3)
				local var_128_6 = var_128_4 <= 0 and var_128_1 or var_128_1 * (var_128_5 / var_128_4)

				if var_128_6 > 0 and var_128_1 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_7 and arg_125_1.time_ < var_128_0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play123101032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 123101032
		arg_129_1.duration_ = 2.03

		local var_129_0 = {
			zh = 1.166,
			ja = 2.033
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
				arg_129_0:Play123101033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.125

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[495].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(123101032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101032", "story_v_out_123101.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101032", "story_v_out_123101.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_123101", "123101032", "story_v_out_123101.awb")

						arg_129_1:RecordAudio("123101032", var_132_9)
						arg_129_1:RecordAudio("123101032", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_123101", "123101032", "story_v_out_123101.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_123101", "123101032", "story_v_out_123101.awb")
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
	Play123101033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 123101033
		arg_133_1.duration_ = 2.53

		local var_133_0 = {
			zh = 1.999999999999,
			ja = 2.533
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
				arg_133_0:Play123101034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1055ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1055ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(0, -0.965, -6.2)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1055ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = arg_133_1.actors_["1055ui_story"]
			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1055ui_story == nil then
				arg_133_1.var_.characterEffect1055ui_story = var_136_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_11 = 0.200000002980232

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_11 and not isNil(var_136_9) then
				local var_136_12 = (arg_133_1.time_ - var_136_10) / var_136_11

				if arg_133_1.var_.characterEffect1055ui_story and not isNil(var_136_9) then
					arg_133_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_10 + var_136_11 and arg_133_1.time_ < var_136_10 + var_136_11 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1055ui_story then
				arg_133_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_136_13 = 0

			if var_136_13 < arg_133_1.time_ and arg_133_1.time_ <= var_136_13 + arg_136_0 then
				arg_133_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_136_14 = 0

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 then
				arg_133_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_136_15 = 0
			local var_136_16 = 0.075

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_17 = arg_133_1:FormatText(StoryNameCfg[481].name)

				arg_133_1.leftNameTxt_.text = var_136_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_18 = arg_133_1:GetWordFromCfg(123101033)
				local var_136_19 = arg_133_1:FormatText(var_136_18.content)

				arg_133_1.text_.text = var_136_19

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_20 = 3
				local var_136_21 = utf8.len(var_136_19)
				local var_136_22 = var_136_20 <= 0 and var_136_16 or var_136_16 * (var_136_21 / var_136_20)

				if var_136_22 > 0 and var_136_16 < var_136_22 then
					arg_133_1.talkMaxDuration = var_136_22

					if var_136_22 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_22 + var_136_15
					end
				end

				arg_133_1.text_.text = var_136_19
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101033", "story_v_out_123101.awb") ~= 0 then
					local var_136_23 = manager.audio:GetVoiceLength("story_v_out_123101", "123101033", "story_v_out_123101.awb") / 1000

					if var_136_23 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_15
					end

					if var_136_18.prefab_name ~= "" and arg_133_1.actors_[var_136_18.prefab_name] ~= nil then
						local var_136_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_18.prefab_name].transform, "story_v_out_123101", "123101033", "story_v_out_123101.awb")

						arg_133_1:RecordAudio("123101033", var_136_24)
						arg_133_1:RecordAudio("123101033", var_136_24)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_123101", "123101033", "story_v_out_123101.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_123101", "123101033", "story_v_out_123101.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_25 = math.max(var_136_16, arg_133_1.talkMaxDuration)

			if var_136_15 <= arg_133_1.time_ and arg_133_1.time_ < var_136_15 + var_136_25 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_15) / var_136_25

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_15 + var_136_25 and arg_133_1.time_ < var_136_15 + var_136_25 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123101034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 123101034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play123101035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1055ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1055ui_story == nil then
				arg_137_1.var_.characterEffect1055ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1055ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1055ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1055ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1055ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 0.75

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(123101034)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 30
				local var_140_11 = utf8.len(var_140_9)
				local var_140_12 = var_140_10 <= 0 and var_140_7 or var_140_7 * (var_140_11 / var_140_10)

				if var_140_12 > 0 and var_140_7 < var_140_12 then
					arg_137_1.talkMaxDuration = var_140_12

					if var_140_12 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_13 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_13 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_13

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_13 and arg_137_1.time_ < var_140_6 + var_140_13 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play123101035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 123101035
		arg_141_1.duration_ = 8.7

		local var_141_0 = {
			zh = 8.7,
			ja = 4.733
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
				arg_141_0:Play123101036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1093ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1093ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(-0.7, -1.11, -5.88)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1093ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["1093ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1093ui_story == nil then
				arg_141_1.var_.characterEffect1093ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect1093ui_story and not isNil(var_144_9) then
					arg_141_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1093ui_story then
				arg_141_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_144_13 = 0

			if var_144_13 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				arg_141_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			local var_144_14 = 0

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				arg_141_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_144_15 = arg_141_1.actors_["1055ui_story"].transform
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.var_.moveOldPos1055ui_story = var_144_15.localPosition
			end

			local var_144_17 = 0.001

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_17 then
				local var_144_18 = (arg_141_1.time_ - var_144_16) / var_144_17
				local var_144_19 = Vector3.New(0.7, -0.965, -6.2)

				var_144_15.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1055ui_story, var_144_19, var_144_18)

				local var_144_20 = manager.ui.mainCamera.transform.position - var_144_15.position

				var_144_15.forward = Vector3.New(var_144_20.x, var_144_20.y, var_144_20.z)

				local var_144_21 = var_144_15.localEulerAngles

				var_144_21.z = 0
				var_144_21.x = 0
				var_144_15.localEulerAngles = var_144_21
			end

			if arg_141_1.time_ >= var_144_16 + var_144_17 and arg_141_1.time_ < var_144_16 + var_144_17 + arg_144_0 then
				var_144_15.localPosition = Vector3.New(0.7, -0.965, -6.2)

				local var_144_22 = manager.ui.mainCamera.transform.position - var_144_15.position

				var_144_15.forward = Vector3.New(var_144_22.x, var_144_22.y, var_144_22.z)

				local var_144_23 = var_144_15.localEulerAngles

				var_144_23.z = 0
				var_144_23.x = 0
				var_144_15.localEulerAngles = var_144_23
			end

			local var_144_24 = arg_141_1.actors_["1055ui_story"]
			local var_144_25 = 0

			if var_144_25 < arg_141_1.time_ and arg_141_1.time_ <= var_144_25 + arg_144_0 and not isNil(var_144_24) and arg_141_1.var_.characterEffect1055ui_story == nil then
				arg_141_1.var_.characterEffect1055ui_story = var_144_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_26 = 0.200000002980232

			if var_144_25 <= arg_141_1.time_ and arg_141_1.time_ < var_144_25 + var_144_26 and not isNil(var_144_24) then
				local var_144_27 = (arg_141_1.time_ - var_144_25) / var_144_26

				if arg_141_1.var_.characterEffect1055ui_story and not isNil(var_144_24) then
					local var_144_28 = Mathf.Lerp(0, 0.5, var_144_27)

					arg_141_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1055ui_story.fillRatio = var_144_28
				end
			end

			if arg_141_1.time_ >= var_144_25 + var_144_26 and arg_141_1.time_ < var_144_25 + var_144_26 + arg_144_0 and not isNil(var_144_24) and arg_141_1.var_.characterEffect1055ui_story then
				local var_144_29 = 0.5

				arg_141_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1055ui_story.fillRatio = var_144_29
			end

			local var_144_30 = 0

			if var_144_30 < arg_141_1.time_ and arg_141_1.time_ <= var_144_30 + arg_144_0 then
				arg_141_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_144_31 = 0
			local var_144_32 = 1

			if var_144_31 < arg_141_1.time_ and arg_141_1.time_ <= var_144_31 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_33 = arg_141_1:FormatText(StoryNameCfg[73].name)

				arg_141_1.leftNameTxt_.text = var_144_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_34 = arg_141_1:GetWordFromCfg(123101035)
				local var_144_35 = arg_141_1:FormatText(var_144_34.content)

				arg_141_1.text_.text = var_144_35

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_36 = 40
				local var_144_37 = utf8.len(var_144_35)
				local var_144_38 = var_144_36 <= 0 and var_144_32 or var_144_32 * (var_144_37 / var_144_36)

				if var_144_38 > 0 and var_144_32 < var_144_38 then
					arg_141_1.talkMaxDuration = var_144_38

					if var_144_38 + var_144_31 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_38 + var_144_31
					end
				end

				arg_141_1.text_.text = var_144_35
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101035", "story_v_out_123101.awb") ~= 0 then
					local var_144_39 = manager.audio:GetVoiceLength("story_v_out_123101", "123101035", "story_v_out_123101.awb") / 1000

					if var_144_39 + var_144_31 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_39 + var_144_31
					end

					if var_144_34.prefab_name ~= "" and arg_141_1.actors_[var_144_34.prefab_name] ~= nil then
						local var_144_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_34.prefab_name].transform, "story_v_out_123101", "123101035", "story_v_out_123101.awb")

						arg_141_1:RecordAudio("123101035", var_144_40)
						arg_141_1:RecordAudio("123101035", var_144_40)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_123101", "123101035", "story_v_out_123101.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_123101", "123101035", "story_v_out_123101.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_41 = math.max(var_144_32, arg_141_1.talkMaxDuration)

			if var_144_31 <= arg_141_1.time_ and arg_141_1.time_ < var_144_31 + var_144_41 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_31) / var_144_41

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_31 + var_144_41 and arg_141_1.time_ < var_144_31 + var_144_41 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play123101036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 123101036
		arg_145_1.duration_ = 4.9

		local var_145_0 = {
			zh = 3.5,
			ja = 4.9
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
				arg_145_0:Play123101037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_148_1 = 0
			local var_148_2 = 0.35

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_3 = arg_145_1:FormatText(StoryNameCfg[73].name)

				arg_145_1.leftNameTxt_.text = var_148_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_4 = arg_145_1:GetWordFromCfg(123101036)
				local var_148_5 = arg_145_1:FormatText(var_148_4.content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_6 = 14
				local var_148_7 = utf8.len(var_148_5)
				local var_148_8 = var_148_6 <= 0 and var_148_2 or var_148_2 * (var_148_7 / var_148_6)

				if var_148_8 > 0 and var_148_2 < var_148_8 then
					arg_145_1.talkMaxDuration = var_148_8

					if var_148_8 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101036", "story_v_out_123101.awb") ~= 0 then
					local var_148_9 = manager.audio:GetVoiceLength("story_v_out_123101", "123101036", "story_v_out_123101.awb") / 1000

					if var_148_9 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_1
					end

					if var_148_4.prefab_name ~= "" and arg_145_1.actors_[var_148_4.prefab_name] ~= nil then
						local var_148_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_4.prefab_name].transform, "story_v_out_123101", "123101036", "story_v_out_123101.awb")

						arg_145_1:RecordAudio("123101036", var_148_10)
						arg_145_1:RecordAudio("123101036", var_148_10)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_123101", "123101036", "story_v_out_123101.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_123101", "123101036", "story_v_out_123101.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_11 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_11 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_11

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_11 and arg_145_1.time_ < var_148_1 + var_148_11 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play123101037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 123101037
		arg_149_1.duration_ = 6.6

		local var_149_0 = {
			zh = 2.3,
			ja = 6.6
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
				arg_149_0:Play123101038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1055ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1055ui_story == nil then
				arg_149_1.var_.characterEffect1055ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect1055ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1055ui_story then
				arg_149_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_152_4 = 0

			if var_152_4 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_1")
			end

			local var_152_5 = 0

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_152_6 = arg_149_1.actors_["1093ui_story"]
			local var_152_7 = 0

			if var_152_7 < arg_149_1.time_ and arg_149_1.time_ <= var_152_7 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect1093ui_story == nil then
				arg_149_1.var_.characterEffect1093ui_story = var_152_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_8 = 0.200000002980232

			if var_152_7 <= arg_149_1.time_ and arg_149_1.time_ < var_152_7 + var_152_8 and not isNil(var_152_6) then
				local var_152_9 = (arg_149_1.time_ - var_152_7) / var_152_8

				if arg_149_1.var_.characterEffect1093ui_story and not isNil(var_152_6) then
					local var_152_10 = Mathf.Lerp(0, 0.5, var_152_9)

					arg_149_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1093ui_story.fillRatio = var_152_10
				end
			end

			if arg_149_1.time_ >= var_152_7 + var_152_8 and arg_149_1.time_ < var_152_7 + var_152_8 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect1093ui_story then
				local var_152_11 = 0.5

				arg_149_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1093ui_story.fillRatio = var_152_11
			end

			local var_152_12 = 0
			local var_152_13 = 0.275

			if var_152_12 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_14 = arg_149_1:FormatText(StoryNameCfg[481].name)

				arg_149_1.leftNameTxt_.text = var_152_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_15 = arg_149_1:GetWordFromCfg(123101037)
				local var_152_16 = arg_149_1:FormatText(var_152_15.content)

				arg_149_1.text_.text = var_152_16

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_17 = 11
				local var_152_18 = utf8.len(var_152_16)
				local var_152_19 = var_152_17 <= 0 and var_152_13 or var_152_13 * (var_152_18 / var_152_17)

				if var_152_19 > 0 and var_152_13 < var_152_19 then
					arg_149_1.talkMaxDuration = var_152_19

					if var_152_19 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_19 + var_152_12
					end
				end

				arg_149_1.text_.text = var_152_16
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101037", "story_v_out_123101.awb") ~= 0 then
					local var_152_20 = manager.audio:GetVoiceLength("story_v_out_123101", "123101037", "story_v_out_123101.awb") / 1000

					if var_152_20 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_20 + var_152_12
					end

					if var_152_15.prefab_name ~= "" and arg_149_1.actors_[var_152_15.prefab_name] ~= nil then
						local var_152_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_15.prefab_name].transform, "story_v_out_123101", "123101037", "story_v_out_123101.awb")

						arg_149_1:RecordAudio("123101037", var_152_21)
						arg_149_1:RecordAudio("123101037", var_152_21)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_123101", "123101037", "story_v_out_123101.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_123101", "123101037", "story_v_out_123101.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_22 = math.max(var_152_13, arg_149_1.talkMaxDuration)

			if var_152_12 <= arg_149_1.time_ and arg_149_1.time_ < var_152_12 + var_152_22 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_12) / var_152_22

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_12 + var_152_22 and arg_149_1.time_ < var_152_12 + var_152_22 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play123101038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 123101038
		arg_153_1.duration_ = 2

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play123101039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1093ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1093ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(-0.7, -1.11, -5.88)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1093ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = arg_153_1.actors_["1093ui_story"]
			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1093ui_story == nil then
				arg_153_1.var_.characterEffect1093ui_story = var_156_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_11 = 0.200000002980232

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 and not isNil(var_156_9) then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11

				if arg_153_1.var_.characterEffect1093ui_story and not isNil(var_156_9) then
					arg_153_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1093ui_story then
				arg_153_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_156_13 = 0

			if var_156_13 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 then
				arg_153_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_2")
			end

			local var_156_14 = 0

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_156_15 = arg_153_1.actors_["1055ui_story"]
			local var_156_16 = 0

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.characterEffect1055ui_story == nil then
				arg_153_1.var_.characterEffect1055ui_story = var_156_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_17 = 0.200000002980232

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_17 and not isNil(var_156_15) then
				local var_156_18 = (arg_153_1.time_ - var_156_16) / var_156_17

				if arg_153_1.var_.characterEffect1055ui_story and not isNil(var_156_15) then
					local var_156_19 = Mathf.Lerp(0, 0.5, var_156_18)

					arg_153_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1055ui_story.fillRatio = var_156_19
				end
			end

			if arg_153_1.time_ >= var_156_16 + var_156_17 and arg_153_1.time_ < var_156_16 + var_156_17 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.characterEffect1055ui_story then
				local var_156_20 = 0.5

				arg_153_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1055ui_story.fillRatio = var_156_20
			end

			local var_156_21 = 0
			local var_156_22 = 0.05

			if var_156_21 < arg_153_1.time_ and arg_153_1.time_ <= var_156_21 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_23 = arg_153_1:FormatText(StoryNameCfg[73].name)

				arg_153_1.leftNameTxt_.text = var_156_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_24 = arg_153_1:GetWordFromCfg(123101038)
				local var_156_25 = arg_153_1:FormatText(var_156_24.content)

				arg_153_1.text_.text = var_156_25

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_26 = 2
				local var_156_27 = utf8.len(var_156_25)
				local var_156_28 = var_156_26 <= 0 and var_156_22 or var_156_22 * (var_156_27 / var_156_26)

				if var_156_28 > 0 and var_156_22 < var_156_28 then
					arg_153_1.talkMaxDuration = var_156_28

					if var_156_28 + var_156_21 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_28 + var_156_21
					end
				end

				arg_153_1.text_.text = var_156_25
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101038", "story_v_out_123101.awb") ~= 0 then
					local var_156_29 = manager.audio:GetVoiceLength("story_v_out_123101", "123101038", "story_v_out_123101.awb") / 1000

					if var_156_29 + var_156_21 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_29 + var_156_21
					end

					if var_156_24.prefab_name ~= "" and arg_153_1.actors_[var_156_24.prefab_name] ~= nil then
						local var_156_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_24.prefab_name].transform, "story_v_out_123101", "123101038", "story_v_out_123101.awb")

						arg_153_1:RecordAudio("123101038", var_156_30)
						arg_153_1:RecordAudio("123101038", var_156_30)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_123101", "123101038", "story_v_out_123101.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_123101", "123101038", "story_v_out_123101.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_31 = math.max(var_156_22, arg_153_1.talkMaxDuration)

			if var_156_21 <= arg_153_1.time_ and arg_153_1.time_ < var_156_21 + var_156_31 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_21) / var_156_31

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_21 + var_156_31 and arg_153_1.time_ < var_156_21 + var_156_31 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play123101039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 123101039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play123101040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1093ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1093ui_story == nil then
				arg_157_1.var_.characterEffect1093ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1093ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1093ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1093ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1093ui_story.fillRatio = var_160_5
			end

			local var_160_6 = 0
			local var_160_7 = 1.5

			if var_160_6 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_8 = arg_157_1:GetWordFromCfg(123101039)
				local var_160_9 = arg_157_1:FormatText(var_160_8.content)

				arg_157_1.text_.text = var_160_9

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_10 = 60
				local var_160_11 = utf8.len(var_160_9)
				local var_160_12 = var_160_10 <= 0 and var_160_7 or var_160_7 * (var_160_11 / var_160_10)

				if var_160_12 > 0 and var_160_7 < var_160_12 then
					arg_157_1.talkMaxDuration = var_160_12

					if var_160_12 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_12 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_9
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_13 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_13 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_13

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_13 and arg_157_1.time_ < var_160_6 + var_160_13 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play123101040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 123101040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play123101041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.3

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(123101040)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 12
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
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_8 and arg_161_1.time_ < var_164_0 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play123101041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 123101041
		arg_165_1.duration_ = 12.63

		local var_165_0 = {
			zh = 8.366,
			ja = 12.633
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
				arg_165_0:Play123101042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1055ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1055ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0.7, -0.965, -6.2)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1055ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0.7, -0.965, -6.2)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["1055ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1055ui_story == nil then
				arg_165_1.var_.characterEffect1055ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect1055ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1055ui_story then
				arg_165_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_168_13 = 0

			if var_168_13 < arg_165_1.time_ and arg_165_1.time_ <= var_168_13 + arg_168_0 then
				arg_165_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_2")
			end

			local var_168_14 = 0

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 then
				arg_165_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_15 = 0
			local var_168_16 = 1.125

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_17 = arg_165_1:FormatText(StoryNameCfg[481].name)

				arg_165_1.leftNameTxt_.text = var_168_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(123101041)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 45
				local var_168_21 = utf8.len(var_168_19)
				local var_168_22 = var_168_20 <= 0 and var_168_16 or var_168_16 * (var_168_21 / var_168_20)

				if var_168_22 > 0 and var_168_16 < var_168_22 then
					arg_165_1.talkMaxDuration = var_168_22

					if var_168_22 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_15
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101041", "story_v_out_123101.awb") ~= 0 then
					local var_168_23 = manager.audio:GetVoiceLength("story_v_out_123101", "123101041", "story_v_out_123101.awb") / 1000

					if var_168_23 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_23 + var_168_15
					end

					if var_168_18.prefab_name ~= "" and arg_165_1.actors_[var_168_18.prefab_name] ~= nil then
						local var_168_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_18.prefab_name].transform, "story_v_out_123101", "123101041", "story_v_out_123101.awb")

						arg_165_1:RecordAudio("123101041", var_168_24)
						arg_165_1:RecordAudio("123101041", var_168_24)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_123101", "123101041", "story_v_out_123101.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_123101", "123101041", "story_v_out_123101.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_25 = math.max(var_168_16, arg_165_1.talkMaxDuration)

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_25 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_15) / var_168_25

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_15 + var_168_25 and arg_165_1.time_ < var_168_15 + var_168_25 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123101042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 123101042
		arg_169_1.duration_ = 13.73

		local var_169_0 = {
			zh = 8.566,
			ja = 13.733
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
				arg_169_0:Play123101043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_1 = 0
			local var_172_2 = 1.075

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_3 = arg_169_1:FormatText(StoryNameCfg[481].name)

				arg_169_1.leftNameTxt_.text = var_172_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_4 = arg_169_1:GetWordFromCfg(123101042)
				local var_172_5 = arg_169_1:FormatText(var_172_4.content)

				arg_169_1.text_.text = var_172_5

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_6 = 43
				local var_172_7 = utf8.len(var_172_5)
				local var_172_8 = var_172_6 <= 0 and var_172_2 or var_172_2 * (var_172_7 / var_172_6)

				if var_172_8 > 0 and var_172_2 < var_172_8 then
					arg_169_1.talkMaxDuration = var_172_8

					if var_172_8 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_5
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101042", "story_v_out_123101.awb") ~= 0 then
					local var_172_9 = manager.audio:GetVoiceLength("story_v_out_123101", "123101042", "story_v_out_123101.awb") / 1000

					if var_172_9 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_1
					end

					if var_172_4.prefab_name ~= "" and arg_169_1.actors_[var_172_4.prefab_name] ~= nil then
						local var_172_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_4.prefab_name].transform, "story_v_out_123101", "123101042", "story_v_out_123101.awb")

						arg_169_1:RecordAudio("123101042", var_172_10)
						arg_169_1:RecordAudio("123101042", var_172_10)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_123101", "123101042", "story_v_out_123101.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_123101", "123101042", "story_v_out_123101.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_11 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_11 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_11

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_11 and arg_169_1.time_ < var_172_1 + var_172_11 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play123101043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 123101043
		arg_173_1.duration_ = 7.2

		local var_173_0 = {
			zh = 6.266,
			ja = 7.2
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
				arg_173_0:Play123101044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_2 = 0
			local var_176_3 = 0.725

			if var_176_2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_4 = arg_173_1:FormatText(StoryNameCfg[481].name)

				arg_173_1.leftNameTxt_.text = var_176_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_5 = arg_173_1:GetWordFromCfg(123101043)
				local var_176_6 = arg_173_1:FormatText(var_176_5.content)

				arg_173_1.text_.text = var_176_6

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 29
				local var_176_8 = utf8.len(var_176_6)
				local var_176_9 = var_176_7 <= 0 and var_176_3 or var_176_3 * (var_176_8 / var_176_7)

				if var_176_9 > 0 and var_176_3 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_6
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101043", "story_v_out_123101.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101043", "story_v_out_123101.awb") / 1000

					if var_176_10 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_2
					end

					if var_176_5.prefab_name ~= "" and arg_173_1.actors_[var_176_5.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_5.prefab_name].transform, "story_v_out_123101", "123101043", "story_v_out_123101.awb")

						arg_173_1:RecordAudio("123101043", var_176_11)
						arg_173_1:RecordAudio("123101043", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_123101", "123101043", "story_v_out_123101.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_123101", "123101043", "story_v_out_123101.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_12 and arg_173_1.time_ < var_176_2 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play123101044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 123101044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play123101045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1055ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1055ui_story == nil then
				arg_177_1.var_.characterEffect1055ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1055ui_story and not isNil(var_180_0) then
					local var_180_4 = Mathf.Lerp(0, 0.5, var_180_3)

					arg_177_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1055ui_story.fillRatio = var_180_4
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1055ui_story then
				local var_180_5 = 0.5

				arg_177_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1055ui_story.fillRatio = var_180_5
			end

			local var_180_6 = 0
			local var_180_7 = 0.675

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(123101044)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 27
				local var_180_11 = utf8.len(var_180_9)
				local var_180_12 = var_180_10 <= 0 and var_180_7 or var_180_7 * (var_180_11 / var_180_10)

				if var_180_12 > 0 and var_180_7 < var_180_12 then
					arg_177_1.talkMaxDuration = var_180_12

					if var_180_12 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_13 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_13 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_13

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_13 and arg_177_1.time_ < var_180_6 + var_180_13 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play123101045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 123101045
		arg_181_1.duration_ = 6.77

		local var_181_0 = {
			zh = 5.066,
			ja = 6.766
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
				arg_181_0:Play123101046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1093ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1093ui_story == nil then
				arg_181_1.var_.characterEffect1093ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1093ui_story and not isNil(var_184_0) then
					arg_181_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1093ui_story then
				arg_181_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_184_4 = 0

			if var_184_4 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			local var_184_5 = 0

			if var_184_5 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_184_6 = 0
			local var_184_7 = 0.375

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_8 = arg_181_1:FormatText(StoryNameCfg[73].name)

				arg_181_1.leftNameTxt_.text = var_184_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_9 = arg_181_1:GetWordFromCfg(123101045)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 15
				local var_184_12 = utf8.len(var_184_10)
				local var_184_13 = var_184_11 <= 0 and var_184_7 or var_184_7 * (var_184_12 / var_184_11)

				if var_184_13 > 0 and var_184_7 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101045", "story_v_out_123101.awb") ~= 0 then
					local var_184_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101045", "story_v_out_123101.awb") / 1000

					if var_184_14 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_14 + var_184_6
					end

					if var_184_9.prefab_name ~= "" and arg_181_1.actors_[var_184_9.prefab_name] ~= nil then
						local var_184_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_9.prefab_name].transform, "story_v_out_123101", "123101045", "story_v_out_123101.awb")

						arg_181_1:RecordAudio("123101045", var_184_15)
						arg_181_1:RecordAudio("123101045", var_184_15)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_123101", "123101045", "story_v_out_123101.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_123101", "123101045", "story_v_out_123101.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_16 and arg_181_1.time_ < var_184_6 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play123101046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 123101046
		arg_185_1.duration_ = 12.4

		local var_185_0 = {
			zh = 6.2,
			ja = 12.4
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
				arg_185_0:Play123101047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1055ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1055ui_story == nil then
				arg_185_1.var_.characterEffect1055ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1055ui_story and not isNil(var_188_0) then
					arg_185_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1055ui_story then
				arg_185_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_188_4 = 0

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_188_5 = 0

			if var_188_5 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_188_6 = arg_185_1.actors_["1093ui_story"]
			local var_188_7 = 0

			if var_188_7 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect1093ui_story == nil then
				arg_185_1.var_.characterEffect1093ui_story = var_188_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_8 = 0.200000002980232

			if var_188_7 <= arg_185_1.time_ and arg_185_1.time_ < var_188_7 + var_188_8 and not isNil(var_188_6) then
				local var_188_9 = (arg_185_1.time_ - var_188_7) / var_188_8

				if arg_185_1.var_.characterEffect1093ui_story and not isNil(var_188_6) then
					local var_188_10 = Mathf.Lerp(0, 0.5, var_188_9)

					arg_185_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1093ui_story.fillRatio = var_188_10
				end
			end

			if arg_185_1.time_ >= var_188_7 + var_188_8 and arg_185_1.time_ < var_188_7 + var_188_8 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect1093ui_story then
				local var_188_11 = 0.5

				arg_185_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1093ui_story.fillRatio = var_188_11
			end

			local var_188_12 = 0
			local var_188_13 = 0.875

			if var_188_12 < arg_185_1.time_ and arg_185_1.time_ <= var_188_12 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_14 = arg_185_1:FormatText(StoryNameCfg[481].name)

				arg_185_1.leftNameTxt_.text = var_188_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_15 = arg_185_1:GetWordFromCfg(123101046)
				local var_188_16 = arg_185_1:FormatText(var_188_15.content)

				arg_185_1.text_.text = var_188_16

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_17 = 34
				local var_188_18 = utf8.len(var_188_16)
				local var_188_19 = var_188_17 <= 0 and var_188_13 or var_188_13 * (var_188_18 / var_188_17)

				if var_188_19 > 0 and var_188_13 < var_188_19 then
					arg_185_1.talkMaxDuration = var_188_19

					if var_188_19 + var_188_12 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_19 + var_188_12
					end
				end

				arg_185_1.text_.text = var_188_16
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101046", "story_v_out_123101.awb") ~= 0 then
					local var_188_20 = manager.audio:GetVoiceLength("story_v_out_123101", "123101046", "story_v_out_123101.awb") / 1000

					if var_188_20 + var_188_12 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_20 + var_188_12
					end

					if var_188_15.prefab_name ~= "" and arg_185_1.actors_[var_188_15.prefab_name] ~= nil then
						local var_188_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_15.prefab_name].transform, "story_v_out_123101", "123101046", "story_v_out_123101.awb")

						arg_185_1:RecordAudio("123101046", var_188_21)
						arg_185_1:RecordAudio("123101046", var_188_21)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_123101", "123101046", "story_v_out_123101.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_123101", "123101046", "story_v_out_123101.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_22 = math.max(var_188_13, arg_185_1.talkMaxDuration)

			if var_188_12 <= arg_185_1.time_ and arg_185_1.time_ < var_188_12 + var_188_22 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_12) / var_188_22

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_12 + var_188_22 and arg_185_1.time_ < var_188_12 + var_188_22 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play123101047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 123101047
		arg_189_1.duration_ = 3.1

		local var_189_0 = {
			zh = 1.999999999999,
			ja = 3.1
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
				arg_189_0:Play123101048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1093ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1093ui_story == nil then
				arg_189_1.var_.characterEffect1093ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1093ui_story and not isNil(var_192_0) then
					arg_189_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1093ui_story then
				arg_189_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_192_4 = 0

			if var_192_4 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action446")
			end

			local var_192_5 = 0

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_192_6 = arg_189_1.actors_["1055ui_story"]
			local var_192_7 = 0

			if var_192_7 < arg_189_1.time_ and arg_189_1.time_ <= var_192_7 + arg_192_0 and not isNil(var_192_6) and arg_189_1.var_.characterEffect1055ui_story == nil then
				arg_189_1.var_.characterEffect1055ui_story = var_192_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_8 = 0.200000002980232

			if var_192_7 <= arg_189_1.time_ and arg_189_1.time_ < var_192_7 + var_192_8 and not isNil(var_192_6) then
				local var_192_9 = (arg_189_1.time_ - var_192_7) / var_192_8

				if arg_189_1.var_.characterEffect1055ui_story and not isNil(var_192_6) then
					local var_192_10 = Mathf.Lerp(0, 0.5, var_192_9)

					arg_189_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1055ui_story.fillRatio = var_192_10
				end
			end

			if arg_189_1.time_ >= var_192_7 + var_192_8 and arg_189_1.time_ < var_192_7 + var_192_8 + arg_192_0 and not isNil(var_192_6) and arg_189_1.var_.characterEffect1055ui_story then
				local var_192_11 = 0.5

				arg_189_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1055ui_story.fillRatio = var_192_11
			end

			local var_192_12 = 0
			local var_192_13 = 0.15

			if var_192_12 < arg_189_1.time_ and arg_189_1.time_ <= var_192_12 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_14 = arg_189_1:FormatText(StoryNameCfg[73].name)

				arg_189_1.leftNameTxt_.text = var_192_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_15 = arg_189_1:GetWordFromCfg(123101047)
				local var_192_16 = arg_189_1:FormatText(var_192_15.content)

				arg_189_1.text_.text = var_192_16

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_17 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101047", "story_v_out_123101.awb") ~= 0 then
					local var_192_20 = manager.audio:GetVoiceLength("story_v_out_123101", "123101047", "story_v_out_123101.awb") / 1000

					if var_192_20 + var_192_12 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_20 + var_192_12
					end

					if var_192_15.prefab_name ~= "" and arg_189_1.actors_[var_192_15.prefab_name] ~= nil then
						local var_192_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_15.prefab_name].transform, "story_v_out_123101", "123101047", "story_v_out_123101.awb")

						arg_189_1:RecordAudio("123101047", var_192_21)
						arg_189_1:RecordAudio("123101047", var_192_21)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_123101", "123101047", "story_v_out_123101.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_123101", "123101047", "story_v_out_123101.awb")
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
	Play123101048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 123101048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play123101049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1093ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1093ui_story == nil then
				arg_193_1.var_.characterEffect1093ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1093ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1093ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1093ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1093ui_story.fillRatio = var_196_5
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

				local var_196_9 = arg_193_1:GetWordFromCfg(123101048)
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
	Play123101049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 123101049
		arg_197_1.duration_ = 16.03

		local var_197_0 = {
			zh = 11.266,
			ja = 16.033
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
				arg_197_0:Play123101050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1055ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1055ui_story == nil then
				arg_197_1.var_.characterEffect1055ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1055ui_story and not isNil(var_200_0) then
					arg_197_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1055ui_story then
				arg_197_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_200_4 = 0

			if var_200_4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_200_5 = 0

			if var_200_5 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_200_6 = 0
			local var_200_7 = 1.325

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_8 = arg_197_1:FormatText(StoryNameCfg[481].name)

				arg_197_1.leftNameTxt_.text = var_200_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_9 = arg_197_1:GetWordFromCfg(123101049)
				local var_200_10 = arg_197_1:FormatText(var_200_9.content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 53
				local var_200_12 = utf8.len(var_200_10)
				local var_200_13 = var_200_11 <= 0 and var_200_7 or var_200_7 * (var_200_12 / var_200_11)

				if var_200_13 > 0 and var_200_7 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_10
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101049", "story_v_out_123101.awb") ~= 0 then
					local var_200_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101049", "story_v_out_123101.awb") / 1000

					if var_200_14 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_14 + var_200_6
					end

					if var_200_9.prefab_name ~= "" and arg_197_1.actors_[var_200_9.prefab_name] ~= nil then
						local var_200_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_9.prefab_name].transform, "story_v_out_123101", "123101049", "story_v_out_123101.awb")

						arg_197_1:RecordAudio("123101049", var_200_15)
						arg_197_1:RecordAudio("123101049", var_200_15)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_123101", "123101049", "story_v_out_123101.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_123101", "123101049", "story_v_out_123101.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_16 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_16 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_16

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_16 and arg_197_1.time_ < var_200_6 + var_200_16 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play123101050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 123101050
		arg_201_1.duration_ = 4.47

		local var_201_0 = {
			zh = 3.833,
			ja = 4.466
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
				arg_201_0:Play123101051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1055ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1055ui_story == nil then
				arg_201_1.var_.characterEffect1055ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1055ui_story and not isNil(var_204_0) then
					arg_201_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1055ui_story then
				arg_201_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_204_4 = 0

			if var_204_4 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_204_5 = 0

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_204_6 = 0
			local var_204_7 = 0.525

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_8 = arg_201_1:FormatText(StoryNameCfg[481].name)

				arg_201_1.leftNameTxt_.text = var_204_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_9 = arg_201_1:GetWordFromCfg(123101050)
				local var_204_10 = arg_201_1:FormatText(var_204_9.content)

				arg_201_1.text_.text = var_204_10

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101050", "story_v_out_123101.awb") ~= 0 then
					local var_204_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101050", "story_v_out_123101.awb") / 1000

					if var_204_14 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_6
					end

					if var_204_9.prefab_name ~= "" and arg_201_1.actors_[var_204_9.prefab_name] ~= nil then
						local var_204_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_9.prefab_name].transform, "story_v_out_123101", "123101050", "story_v_out_123101.awb")

						arg_201_1:RecordAudio("123101050", var_204_15)
						arg_201_1:RecordAudio("123101050", var_204_15)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_123101", "123101050", "story_v_out_123101.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_123101", "123101050", "story_v_out_123101.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_16 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_16 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_16

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_16 and arg_201_1.time_ < var_204_6 + var_204_16 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play123101051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 123101051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play123101052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1055ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1055ui_story == nil then
				arg_205_1.var_.characterEffect1055ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect1055ui_story and not isNil(var_208_0) then
					local var_208_4 = Mathf.Lerp(0, 0.5, var_208_3)

					arg_205_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1055ui_story.fillRatio = var_208_4
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1055ui_story then
				local var_208_5 = 0.5

				arg_205_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1055ui_story.fillRatio = var_208_5
			end

			local var_208_6 = 0
			local var_208_7 = 0.375

			if var_208_6 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_8 = arg_205_1:FormatText(StoryNameCfg[7].name)

				arg_205_1.leftNameTxt_.text = var_208_8

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

				local var_208_9 = arg_205_1:GetWordFromCfg(123101051)
				local var_208_10 = arg_205_1:FormatText(var_208_9.content)

				arg_205_1.text_.text = var_208_10

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_11 = 15
				local var_208_12 = utf8.len(var_208_10)
				local var_208_13 = var_208_11 <= 0 and var_208_7 or var_208_7 * (var_208_12 / var_208_11)

				if var_208_13 > 0 and var_208_7 < var_208_13 then
					arg_205_1.talkMaxDuration = var_208_13

					if var_208_13 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_6
					end
				end

				arg_205_1.text_.text = var_208_10
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_14 = math.max(var_208_7, arg_205_1.talkMaxDuration)

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_14 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_6) / var_208_14

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_6 + var_208_14 and arg_205_1.time_ < var_208_6 + var_208_14 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play123101052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 123101052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play123101053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1093ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1093ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0, 100, 0)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1093ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, 100, 0)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["1093ui_story"]
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1093ui_story == nil then
				arg_209_1.var_.characterEffect1093ui_story = var_212_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_11 = 0.200000002980232

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_11 and not isNil(var_212_9) then
				local var_212_12 = (arg_209_1.time_ - var_212_10) / var_212_11

				if arg_209_1.var_.characterEffect1093ui_story and not isNil(var_212_9) then
					local var_212_13 = Mathf.Lerp(0, 0.5, var_212_12)

					arg_209_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1093ui_story.fillRatio = var_212_13
				end
			end

			if arg_209_1.time_ >= var_212_10 + var_212_11 and arg_209_1.time_ < var_212_10 + var_212_11 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1093ui_story then
				local var_212_14 = 0.5

				arg_209_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1093ui_story.fillRatio = var_212_14
			end

			local var_212_15 = arg_209_1.actors_["1055ui_story"].transform
			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.var_.moveOldPos1055ui_story = var_212_15.localPosition
			end

			local var_212_17 = 0.001

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 then
				local var_212_18 = (arg_209_1.time_ - var_212_16) / var_212_17
				local var_212_19 = Vector3.New(0, 100, 0)

				var_212_15.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1055ui_story, var_212_19, var_212_18)

				local var_212_20 = manager.ui.mainCamera.transform.position - var_212_15.position

				var_212_15.forward = Vector3.New(var_212_20.x, var_212_20.y, var_212_20.z)

				local var_212_21 = var_212_15.localEulerAngles

				var_212_21.z = 0
				var_212_21.x = 0
				var_212_15.localEulerAngles = var_212_21
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 then
				var_212_15.localPosition = Vector3.New(0, 100, 0)

				local var_212_22 = manager.ui.mainCamera.transform.position - var_212_15.position

				var_212_15.forward = Vector3.New(var_212_22.x, var_212_22.y, var_212_22.z)

				local var_212_23 = var_212_15.localEulerAngles

				var_212_23.z = 0
				var_212_23.x = 0
				var_212_15.localEulerAngles = var_212_23
			end

			local var_212_24 = arg_209_1.actors_["1055ui_story"]
			local var_212_25 = 0

			if var_212_25 < arg_209_1.time_ and arg_209_1.time_ <= var_212_25 + arg_212_0 and not isNil(var_212_24) and arg_209_1.var_.characterEffect1055ui_story == nil then
				arg_209_1.var_.characterEffect1055ui_story = var_212_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_26 = 0.200000002980232

			if var_212_25 <= arg_209_1.time_ and arg_209_1.time_ < var_212_25 + var_212_26 and not isNil(var_212_24) then
				local var_212_27 = (arg_209_1.time_ - var_212_25) / var_212_26

				if arg_209_1.var_.characterEffect1055ui_story and not isNil(var_212_24) then
					local var_212_28 = Mathf.Lerp(0, 0.5, var_212_27)

					arg_209_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1055ui_story.fillRatio = var_212_28
				end
			end

			if arg_209_1.time_ >= var_212_25 + var_212_26 and arg_209_1.time_ < var_212_25 + var_212_26 + arg_212_0 and not isNil(var_212_24) and arg_209_1.var_.characterEffect1055ui_story then
				local var_212_29 = 0.5

				arg_209_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1055ui_story.fillRatio = var_212_29
			end

			local var_212_30 = 0
			local var_212_31 = 1.5

			if var_212_30 < arg_209_1.time_ and arg_209_1.time_ <= var_212_30 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_32 = arg_209_1:GetWordFromCfg(123101052)
				local var_212_33 = arg_209_1:FormatText(var_212_32.content)

				arg_209_1.text_.text = var_212_33

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_34 = 60
				local var_212_35 = utf8.len(var_212_33)
				local var_212_36 = var_212_34 <= 0 and var_212_31 or var_212_31 * (var_212_35 / var_212_34)

				if var_212_36 > 0 and var_212_31 < var_212_36 then
					arg_209_1.talkMaxDuration = var_212_36

					if var_212_36 + var_212_30 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_36 + var_212_30
					end
				end

				arg_209_1.text_.text = var_212_33
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_37 = math.max(var_212_31, arg_209_1.talkMaxDuration)

			if var_212_30 <= arg_209_1.time_ and arg_209_1.time_ < var_212_30 + var_212_37 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_30) / var_212_37

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_30 + var_212_37 and arg_209_1.time_ < var_212_30 + var_212_37 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123101053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 123101053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play123101054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.9

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_2 = arg_213_1:GetWordFromCfg(123101053)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 36
				local var_216_5 = utf8.len(var_216_3)
				local var_216_6 = var_216_4 <= 0 and var_216_1 or var_216_1 * (var_216_5 / var_216_4)

				if var_216_6 > 0 and var_216_1 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_7 and arg_213_1.time_ < var_216_0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play123101054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 123101054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play123101055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.15

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

				local var_220_3 = arg_217_1:GetWordFromCfg(123101054)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 6
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
	Play123101055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 123101055
		arg_221_1.duration_ = 2

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play123101056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1055ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1055ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, -0.965, -6.2)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1055ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = arg_221_1.actors_["1055ui_story"]
			local var_224_10 = 0

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1055ui_story == nil then
				arg_221_1.var_.characterEffect1055ui_story = var_224_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.200000002980232

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_11 and not isNil(var_224_9) then
				local var_224_12 = (arg_221_1.time_ - var_224_10) / var_224_11

				if arg_221_1.var_.characterEffect1055ui_story and not isNil(var_224_9) then
					arg_221_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_10 + var_224_11 and arg_221_1.time_ < var_224_10 + var_224_11 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1055ui_story then
				arg_221_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_224_13 = 0

			if var_224_13 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_224_14 = 0

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_224_15 = 0
			local var_224_16 = 0.05

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_17 = arg_221_1:FormatText(StoryNameCfg[481].name)

				arg_221_1.leftNameTxt_.text = var_224_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_18 = arg_221_1:GetWordFromCfg(123101055)
				local var_224_19 = arg_221_1:FormatText(var_224_18.content)

				arg_221_1.text_.text = var_224_19

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_20 = 2
				local var_224_21 = utf8.len(var_224_19)
				local var_224_22 = var_224_20 <= 0 and var_224_16 or var_224_16 * (var_224_21 / var_224_20)

				if var_224_22 > 0 and var_224_16 < var_224_22 then
					arg_221_1.talkMaxDuration = var_224_22

					if var_224_22 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_22 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_19
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101055", "story_v_out_123101.awb") ~= 0 then
					local var_224_23 = manager.audio:GetVoiceLength("story_v_out_123101", "123101055", "story_v_out_123101.awb") / 1000

					if var_224_23 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_23 + var_224_15
					end

					if var_224_18.prefab_name ~= "" and arg_221_1.actors_[var_224_18.prefab_name] ~= nil then
						local var_224_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_18.prefab_name].transform, "story_v_out_123101", "123101055", "story_v_out_123101.awb")

						arg_221_1:RecordAudio("123101055", var_224_24)
						arg_221_1:RecordAudio("123101055", var_224_24)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_123101", "123101055", "story_v_out_123101.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_123101", "123101055", "story_v_out_123101.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_25 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_25 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_15) / var_224_25

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_15 + var_224_25 and arg_221_1.time_ < var_224_15 + var_224_25 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123101056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 123101056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play123101057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1055ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1055ui_story == nil then
				arg_225_1.var_.characterEffect1055ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1055ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1055ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1055ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1055ui_story.fillRatio = var_228_5
			end

			local var_228_6 = 0
			local var_228_7 = 0.925

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_8 = arg_225_1:GetWordFromCfg(123101056)
				local var_228_9 = arg_225_1:FormatText(var_228_8.content)

				arg_225_1.text_.text = var_228_9

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_10 = 37
				local var_228_11 = utf8.len(var_228_9)
				local var_228_12 = var_228_10 <= 0 and var_228_7 or var_228_7 * (var_228_11 / var_228_10)

				if var_228_12 > 0 and var_228_7 < var_228_12 then
					arg_225_1.talkMaxDuration = var_228_12

					if var_228_12 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_9
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_13 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_13 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_13

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_13 and arg_225_1.time_ < var_228_6 + var_228_13 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play123101057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 123101057
		arg_229_1.duration_ = 4.17

		local var_229_0 = {
			zh = 3.266,
			ja = 4.166
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
				arg_229_0:Play123101058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_1")
			end

			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_232_2 = arg_229_1.actors_["1055ui_story"]
			local var_232_3 = 0

			if var_232_3 < arg_229_1.time_ and arg_229_1.time_ <= var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect1055ui_story == nil then
				arg_229_1.var_.characterEffect1055ui_story = var_232_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_4 = 0.200000002980232

			if var_232_3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_3 + var_232_4 and not isNil(var_232_2) then
				local var_232_5 = (arg_229_1.time_ - var_232_3) / var_232_4

				if arg_229_1.var_.characterEffect1055ui_story and not isNil(var_232_2) then
					arg_229_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_3 + var_232_4 and arg_229_1.time_ < var_232_3 + var_232_4 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect1055ui_story then
				arg_229_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_232_6 = 0
			local var_232_7 = 0.3

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_8 = arg_229_1:FormatText(StoryNameCfg[481].name)

				arg_229_1.leftNameTxt_.text = var_232_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_9 = arg_229_1:GetWordFromCfg(123101057)
				local var_232_10 = arg_229_1:FormatText(var_232_9.content)

				arg_229_1.text_.text = var_232_10

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101057", "story_v_out_123101.awb") ~= 0 then
					local var_232_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101057", "story_v_out_123101.awb") / 1000

					if var_232_14 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_14 + var_232_6
					end

					if var_232_9.prefab_name ~= "" and arg_229_1.actors_[var_232_9.prefab_name] ~= nil then
						local var_232_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_9.prefab_name].transform, "story_v_out_123101", "123101057", "story_v_out_123101.awb")

						arg_229_1:RecordAudio("123101057", var_232_15)
						arg_229_1:RecordAudio("123101057", var_232_15)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_123101", "123101057", "story_v_out_123101.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_123101", "123101057", "story_v_out_123101.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_16 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_16 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_6) / var_232_16

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_6 + var_232_16 and arg_229_1.time_ < var_232_6 + var_232_16 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play123101058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 123101058
		arg_233_1.duration_ = 8.73

		local var_233_0 = {
			zh = 8.733,
			ja = 4.8
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
				arg_233_0:Play123101059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1055ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1055ui_story = var_236_0.localPosition
			end

			local var_236_2 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2
				local var_236_4 = Vector3.New(0, 100, 0)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1055ui_story, var_236_4, var_236_3)

				local var_236_5 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_5.x, var_236_5.y, var_236_5.z)

				local var_236_6 = var_236_0.localEulerAngles

				var_236_6.z = 0
				var_236_6.x = 0
				var_236_0.localEulerAngles = var_236_6
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, 100, 0)

				local var_236_7 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_7.x, var_236_7.y, var_236_7.z)

				local var_236_8 = var_236_0.localEulerAngles

				var_236_8.z = 0
				var_236_8.x = 0
				var_236_0.localEulerAngles = var_236_8
			end

			local var_236_9 = arg_233_1.actors_["1055ui_story"]
			local var_236_10 = 0

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1055ui_story == nil then
				arg_233_1.var_.characterEffect1055ui_story = var_236_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_11 = 0.200000002980232

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_11 and not isNil(var_236_9) then
				local var_236_12 = (arg_233_1.time_ - var_236_10) / var_236_11

				if arg_233_1.var_.characterEffect1055ui_story and not isNil(var_236_9) then
					local var_236_13 = Mathf.Lerp(0, 0.5, var_236_12)

					arg_233_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1055ui_story.fillRatio = var_236_13
				end
			end

			if arg_233_1.time_ >= var_236_10 + var_236_11 and arg_233_1.time_ < var_236_10 + var_236_11 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1055ui_story then
				local var_236_14 = 0.5

				arg_233_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1055ui_story.fillRatio = var_236_14
			end

			local var_236_15 = arg_233_1.actors_["1093ui_story"].transform
			local var_236_16 = 0

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.var_.moveOldPos1093ui_story = var_236_15.localPosition
			end

			local var_236_17 = 0.001

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_17 then
				local var_236_18 = (arg_233_1.time_ - var_236_16) / var_236_17
				local var_236_19 = Vector3.New(0, -1.11, -5.88)

				var_236_15.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1093ui_story, var_236_19, var_236_18)

				local var_236_20 = manager.ui.mainCamera.transform.position - var_236_15.position

				var_236_15.forward = Vector3.New(var_236_20.x, var_236_20.y, var_236_20.z)

				local var_236_21 = var_236_15.localEulerAngles

				var_236_21.z = 0
				var_236_21.x = 0
				var_236_15.localEulerAngles = var_236_21
			end

			if arg_233_1.time_ >= var_236_16 + var_236_17 and arg_233_1.time_ < var_236_16 + var_236_17 + arg_236_0 then
				var_236_15.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_236_22 = manager.ui.mainCamera.transform.position - var_236_15.position

				var_236_15.forward = Vector3.New(var_236_22.x, var_236_22.y, var_236_22.z)

				local var_236_23 = var_236_15.localEulerAngles

				var_236_23.z = 0
				var_236_23.x = 0
				var_236_15.localEulerAngles = var_236_23
			end

			local var_236_24 = arg_233_1.actors_["1093ui_story"]
			local var_236_25 = 0

			if var_236_25 < arg_233_1.time_ and arg_233_1.time_ <= var_236_25 + arg_236_0 and not isNil(var_236_24) and arg_233_1.var_.characterEffect1093ui_story == nil then
				arg_233_1.var_.characterEffect1093ui_story = var_236_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_26 = 0.200000002980232

			if var_236_25 <= arg_233_1.time_ and arg_233_1.time_ < var_236_25 + var_236_26 and not isNil(var_236_24) then
				local var_236_27 = (arg_233_1.time_ - var_236_25) / var_236_26

				if arg_233_1.var_.characterEffect1093ui_story and not isNil(var_236_24) then
					arg_233_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_25 + var_236_26 and arg_233_1.time_ < var_236_25 + var_236_26 + arg_236_0 and not isNil(var_236_24) and arg_233_1.var_.characterEffect1093ui_story then
				arg_233_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_236_28 = 0

			if var_236_28 < arg_233_1.time_ and arg_233_1.time_ <= var_236_28 + arg_236_0 then
				arg_233_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			local var_236_29 = 0

			if var_236_29 < arg_233_1.time_ and arg_233_1.time_ <= var_236_29 + arg_236_0 then
				arg_233_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_236_30 = 0
			local var_236_31 = 0.7

			if var_236_30 < arg_233_1.time_ and arg_233_1.time_ <= var_236_30 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_32 = arg_233_1:FormatText(StoryNameCfg[73].name)

				arg_233_1.leftNameTxt_.text = var_236_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_33 = arg_233_1:GetWordFromCfg(123101058)
				local var_236_34 = arg_233_1:FormatText(var_236_33.content)

				arg_233_1.text_.text = var_236_34

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_35 = 28
				local var_236_36 = utf8.len(var_236_34)
				local var_236_37 = var_236_35 <= 0 and var_236_31 or var_236_31 * (var_236_36 / var_236_35)

				if var_236_37 > 0 and var_236_31 < var_236_37 then
					arg_233_1.talkMaxDuration = var_236_37

					if var_236_37 + var_236_30 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_37 + var_236_30
					end
				end

				arg_233_1.text_.text = var_236_34
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101058", "story_v_out_123101.awb") ~= 0 then
					local var_236_38 = manager.audio:GetVoiceLength("story_v_out_123101", "123101058", "story_v_out_123101.awb") / 1000

					if var_236_38 + var_236_30 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_38 + var_236_30
					end

					if var_236_33.prefab_name ~= "" and arg_233_1.actors_[var_236_33.prefab_name] ~= nil then
						local var_236_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_33.prefab_name].transform, "story_v_out_123101", "123101058", "story_v_out_123101.awb")

						arg_233_1:RecordAudio("123101058", var_236_39)
						arg_233_1:RecordAudio("123101058", var_236_39)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_123101", "123101058", "story_v_out_123101.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_123101", "123101058", "story_v_out_123101.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_40 = math.max(var_236_31, arg_233_1.talkMaxDuration)

			if var_236_30 <= arg_233_1.time_ and arg_233_1.time_ < var_236_30 + var_236_40 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_30) / var_236_40

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_30 + var_236_40 and arg_233_1.time_ < var_236_30 + var_236_40 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play123101059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 123101059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play123101060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1093ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1093ui_story == nil then
				arg_237_1.var_.characterEffect1093ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect1093ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1093ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1093ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1093ui_story.fillRatio = var_240_5
			end

			local var_240_6 = 0

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			local var_240_7 = 0

			if var_240_7 < arg_237_1.time_ and arg_237_1.time_ <= var_240_7 + arg_240_0 then
				arg_237_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_240_8 = 0
			local var_240_9 = 0.375

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_10 = arg_237_1:GetWordFromCfg(123101059)
				local var_240_11 = arg_237_1:FormatText(var_240_10.content)

				arg_237_1.text_.text = var_240_11

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_12 = 15
				local var_240_13 = utf8.len(var_240_11)
				local var_240_14 = var_240_12 <= 0 and var_240_9 or var_240_9 * (var_240_13 / var_240_12)

				if var_240_14 > 0 and var_240_9 < var_240_14 then
					arg_237_1.talkMaxDuration = var_240_14

					if var_240_14 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_11
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_15 = math.max(var_240_9, arg_237_1.talkMaxDuration)

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_15 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_8) / var_240_15

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_8 + var_240_15 and arg_237_1.time_ < var_240_8 + var_240_15 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play123101060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 123101060
		arg_241_1.duration_ = 8.73

		local var_241_0 = {
			zh = 6.733,
			ja = 8.733
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
				arg_241_0:Play123101061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1055ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1055ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0.7, -0.965, -6.2)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1055ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0.7, -0.965, -6.2)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = arg_241_1.actors_["1055ui_story"]
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1055ui_story == nil then
				arg_241_1.var_.characterEffect1055ui_story = var_244_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_11 = 0.200000002980232

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 and not isNil(var_244_9) then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11

				if arg_241_1.var_.characterEffect1055ui_story and not isNil(var_244_9) then
					arg_241_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1055ui_story then
				arg_241_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_244_13 = 0

			if var_244_13 < arg_241_1.time_ and arg_241_1.time_ <= var_244_13 + arg_244_0 then
				arg_241_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_244_14 = 0

			if var_244_14 < arg_241_1.time_ and arg_241_1.time_ <= var_244_14 + arg_244_0 then
				arg_241_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_15 = arg_241_1.actors_["1093ui_story"].transform
			local var_244_16 = 0

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 then
				arg_241_1.var_.moveOldPos1093ui_story = var_244_15.localPosition
			end

			local var_244_17 = 0.001

			if var_244_16 <= arg_241_1.time_ and arg_241_1.time_ < var_244_16 + var_244_17 then
				local var_244_18 = (arg_241_1.time_ - var_244_16) / var_244_17
				local var_244_19 = Vector3.New(-0.7, -1.11, -5.88)

				var_244_15.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1093ui_story, var_244_19, var_244_18)

				local var_244_20 = manager.ui.mainCamera.transform.position - var_244_15.position

				var_244_15.forward = Vector3.New(var_244_20.x, var_244_20.y, var_244_20.z)

				local var_244_21 = var_244_15.localEulerAngles

				var_244_21.z = 0
				var_244_21.x = 0
				var_244_15.localEulerAngles = var_244_21
			end

			if arg_241_1.time_ >= var_244_16 + var_244_17 and arg_241_1.time_ < var_244_16 + var_244_17 + arg_244_0 then
				var_244_15.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_244_22 = manager.ui.mainCamera.transform.position - var_244_15.position

				var_244_15.forward = Vector3.New(var_244_22.x, var_244_22.y, var_244_22.z)

				local var_244_23 = var_244_15.localEulerAngles

				var_244_23.z = 0
				var_244_23.x = 0
				var_244_15.localEulerAngles = var_244_23
			end

			local var_244_24 = 0
			local var_244_25 = 0.775

			if var_244_24 < arg_241_1.time_ and arg_241_1.time_ <= var_244_24 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_26 = arg_241_1:FormatText(StoryNameCfg[481].name)

				arg_241_1.leftNameTxt_.text = var_244_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_27 = arg_241_1:GetWordFromCfg(123101060)
				local var_244_28 = arg_241_1:FormatText(var_244_27.content)

				arg_241_1.text_.text = var_244_28

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_29 = 31
				local var_244_30 = utf8.len(var_244_28)
				local var_244_31 = var_244_29 <= 0 and var_244_25 or var_244_25 * (var_244_30 / var_244_29)

				if var_244_31 > 0 and var_244_25 < var_244_31 then
					arg_241_1.talkMaxDuration = var_244_31

					if var_244_31 + var_244_24 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_31 + var_244_24
					end
				end

				arg_241_1.text_.text = var_244_28
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101060", "story_v_out_123101.awb") ~= 0 then
					local var_244_32 = manager.audio:GetVoiceLength("story_v_out_123101", "123101060", "story_v_out_123101.awb") / 1000

					if var_244_32 + var_244_24 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_32 + var_244_24
					end

					if var_244_27.prefab_name ~= "" and arg_241_1.actors_[var_244_27.prefab_name] ~= nil then
						local var_244_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_27.prefab_name].transform, "story_v_out_123101", "123101060", "story_v_out_123101.awb")

						arg_241_1:RecordAudio("123101060", var_244_33)
						arg_241_1:RecordAudio("123101060", var_244_33)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_123101", "123101060", "story_v_out_123101.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_123101", "123101060", "story_v_out_123101.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_34 = math.max(var_244_25, arg_241_1.talkMaxDuration)

			if var_244_24 <= arg_241_1.time_ and arg_241_1.time_ < var_244_24 + var_244_34 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_24) / var_244_34

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_24 + var_244_34 and arg_241_1.time_ < var_244_24 + var_244_34 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play123101061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 123101061
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play123101062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1055ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1055ui_story == nil then
				arg_245_1.var_.characterEffect1055ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1055ui_story and not isNil(var_248_0) then
					local var_248_4 = Mathf.Lerp(0, 0.5, var_248_3)

					arg_245_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1055ui_story.fillRatio = var_248_4
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1055ui_story then
				local var_248_5 = 0.5

				arg_245_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1055ui_story.fillRatio = var_248_5
			end

			local var_248_6 = 0
			local var_248_7 = 0.925

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_8 = arg_245_1:GetWordFromCfg(123101061)
				local var_248_9 = arg_245_1:FormatText(var_248_8.content)

				arg_245_1.text_.text = var_248_9

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_10 = 37
				local var_248_11 = utf8.len(var_248_9)
				local var_248_12 = var_248_10 <= 0 and var_248_7 or var_248_7 * (var_248_11 / var_248_10)

				if var_248_12 > 0 and var_248_7 < var_248_12 then
					arg_245_1.talkMaxDuration = var_248_12

					if var_248_12 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_12 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_9
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_13 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_13 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_13

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_13 and arg_245_1.time_ < var_248_6 + var_248_13 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play123101062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 123101062
		arg_249_1.duration_ = 10.97

		local var_249_0 = {
			zh = 9,
			ja = 10.966
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
				arg_249_0:Play123101063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1055ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1055ui_story == nil then
				arg_249_1.var_.characterEffect1055ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1055ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1055ui_story then
				arg_249_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_252_4 = 0

			if var_252_4 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_252_5 = 0

			if var_252_5 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_6 = 0
			local var_252_7 = 0.925

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_8 = arg_249_1:FormatText(StoryNameCfg[481].name)

				arg_249_1.leftNameTxt_.text = var_252_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_9 = arg_249_1:GetWordFromCfg(123101062)
				local var_252_10 = arg_249_1:FormatText(var_252_9.content)

				arg_249_1.text_.text = var_252_10

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 37
				local var_252_12 = utf8.len(var_252_10)
				local var_252_13 = var_252_11 <= 0 and var_252_7 or var_252_7 * (var_252_12 / var_252_11)

				if var_252_13 > 0 and var_252_7 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_10
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101062", "story_v_out_123101.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101062", "story_v_out_123101.awb") / 1000

					if var_252_14 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_6
					end

					if var_252_9.prefab_name ~= "" and arg_249_1.actors_[var_252_9.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_9.prefab_name].transform, "story_v_out_123101", "123101062", "story_v_out_123101.awb")

						arg_249_1:RecordAudio("123101062", var_252_15)
						arg_249_1:RecordAudio("123101062", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_123101", "123101062", "story_v_out_123101.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_123101", "123101062", "story_v_out_123101.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_16 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_16 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_16

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_16 and arg_249_1.time_ < var_252_6 + var_252_16 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play123101063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 123101063
		arg_253_1.duration_ = 3.73

		local var_253_0 = {
			zh = 2.633,
			ja = 3.733
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
				arg_253_0:Play123101064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1093ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1093ui_story == nil then
				arg_253_1.var_.characterEffect1093ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1093ui_story and not isNil(var_256_0) then
					arg_253_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1093ui_story then
				arg_253_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_256_4 = 0

			if var_256_4 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_256_5 = 0

			if var_256_5 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 then
				arg_253_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_6 = arg_253_1.actors_["1055ui_story"]
			local var_256_7 = 0

			if var_256_7 < arg_253_1.time_ and arg_253_1.time_ <= var_256_7 + arg_256_0 and not isNil(var_256_6) and arg_253_1.var_.characterEffect1055ui_story == nil then
				arg_253_1.var_.characterEffect1055ui_story = var_256_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_8 = 0.200000002980232

			if var_256_7 <= arg_253_1.time_ and arg_253_1.time_ < var_256_7 + var_256_8 and not isNil(var_256_6) then
				local var_256_9 = (arg_253_1.time_ - var_256_7) / var_256_8

				if arg_253_1.var_.characterEffect1055ui_story and not isNil(var_256_6) then
					local var_256_10 = Mathf.Lerp(0, 0.5, var_256_9)

					arg_253_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1055ui_story.fillRatio = var_256_10
				end
			end

			if arg_253_1.time_ >= var_256_7 + var_256_8 and arg_253_1.time_ < var_256_7 + var_256_8 + arg_256_0 and not isNil(var_256_6) and arg_253_1.var_.characterEffect1055ui_story then
				local var_256_11 = 0.5

				arg_253_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1055ui_story.fillRatio = var_256_11
			end

			local var_256_12 = 0
			local var_256_13 = 0.35

			if var_256_12 < arg_253_1.time_ and arg_253_1.time_ <= var_256_12 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_14 = arg_253_1:FormatText(StoryNameCfg[73].name)

				arg_253_1.leftNameTxt_.text = var_256_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_15 = arg_253_1:GetWordFromCfg(123101063)
				local var_256_16 = arg_253_1:FormatText(var_256_15.content)

				arg_253_1.text_.text = var_256_16

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_17 = 14
				local var_256_18 = utf8.len(var_256_16)
				local var_256_19 = var_256_17 <= 0 and var_256_13 or var_256_13 * (var_256_18 / var_256_17)

				if var_256_19 > 0 and var_256_13 < var_256_19 then
					arg_253_1.talkMaxDuration = var_256_19

					if var_256_19 + var_256_12 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_19 + var_256_12
					end
				end

				arg_253_1.text_.text = var_256_16
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101063", "story_v_out_123101.awb") ~= 0 then
					local var_256_20 = manager.audio:GetVoiceLength("story_v_out_123101", "123101063", "story_v_out_123101.awb") / 1000

					if var_256_20 + var_256_12 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_20 + var_256_12
					end

					if var_256_15.prefab_name ~= "" and arg_253_1.actors_[var_256_15.prefab_name] ~= nil then
						local var_256_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_15.prefab_name].transform, "story_v_out_123101", "123101063", "story_v_out_123101.awb")

						arg_253_1:RecordAudio("123101063", var_256_21)
						arg_253_1:RecordAudio("123101063", var_256_21)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_123101", "123101063", "story_v_out_123101.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_123101", "123101063", "story_v_out_123101.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_22 = math.max(var_256_13, arg_253_1.talkMaxDuration)

			if var_256_12 <= arg_253_1.time_ and arg_253_1.time_ < var_256_12 + var_256_22 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_12) / var_256_22

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_12 + var_256_22 and arg_253_1.time_ < var_256_12 + var_256_22 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play123101064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 123101064
		arg_257_1.duration_ = 5.87

		local var_257_0 = {
			zh = 3.933,
			ja = 5.866
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
				arg_257_0:Play123101065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1055ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1055ui_story == nil then
				arg_257_1.var_.characterEffect1055ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1055ui_story and not isNil(var_260_0) then
					arg_257_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1055ui_story then
				arg_257_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_260_4 = 0

			if var_260_4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_260_5 = 0

			if var_260_5 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 then
				arg_257_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_260_6 = arg_257_1.actors_["1093ui_story"]
			local var_260_7 = 0

			if var_260_7 < arg_257_1.time_ and arg_257_1.time_ <= var_260_7 + arg_260_0 and not isNil(var_260_6) and arg_257_1.var_.characterEffect1093ui_story == nil then
				arg_257_1.var_.characterEffect1093ui_story = var_260_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_8 = 0.200000002980232

			if var_260_7 <= arg_257_1.time_ and arg_257_1.time_ < var_260_7 + var_260_8 and not isNil(var_260_6) then
				local var_260_9 = (arg_257_1.time_ - var_260_7) / var_260_8

				if arg_257_1.var_.characterEffect1093ui_story and not isNil(var_260_6) then
					local var_260_10 = Mathf.Lerp(0, 0.5, var_260_9)

					arg_257_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1093ui_story.fillRatio = var_260_10
				end
			end

			if arg_257_1.time_ >= var_260_7 + var_260_8 and arg_257_1.time_ < var_260_7 + var_260_8 + arg_260_0 and not isNil(var_260_6) and arg_257_1.var_.characterEffect1093ui_story then
				local var_260_11 = 0.5

				arg_257_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1093ui_story.fillRatio = var_260_11
			end

			local var_260_12 = 0
			local var_260_13 = 0.425

			if var_260_12 < arg_257_1.time_ and arg_257_1.time_ <= var_260_12 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_14 = arg_257_1:FormatText(StoryNameCfg[481].name)

				arg_257_1.leftNameTxt_.text = var_260_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_15 = arg_257_1:GetWordFromCfg(123101064)
				local var_260_16 = arg_257_1:FormatText(var_260_15.content)

				arg_257_1.text_.text = var_260_16

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_17 = 17
				local var_260_18 = utf8.len(var_260_16)
				local var_260_19 = var_260_17 <= 0 and var_260_13 or var_260_13 * (var_260_18 / var_260_17)

				if var_260_19 > 0 and var_260_13 < var_260_19 then
					arg_257_1.talkMaxDuration = var_260_19

					if var_260_19 + var_260_12 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_19 + var_260_12
					end
				end

				arg_257_1.text_.text = var_260_16
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101064", "story_v_out_123101.awb") ~= 0 then
					local var_260_20 = manager.audio:GetVoiceLength("story_v_out_123101", "123101064", "story_v_out_123101.awb") / 1000

					if var_260_20 + var_260_12 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_20 + var_260_12
					end

					if var_260_15.prefab_name ~= "" and arg_257_1.actors_[var_260_15.prefab_name] ~= nil then
						local var_260_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_15.prefab_name].transform, "story_v_out_123101", "123101064", "story_v_out_123101.awb")

						arg_257_1:RecordAudio("123101064", var_260_21)
						arg_257_1:RecordAudio("123101064", var_260_21)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_123101", "123101064", "story_v_out_123101.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_123101", "123101064", "story_v_out_123101.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_22 = math.max(var_260_13, arg_257_1.talkMaxDuration)

			if var_260_12 <= arg_257_1.time_ and arg_257_1.time_ < var_260_12 + var_260_22 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_12) / var_260_22

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_12 + var_260_22 and arg_257_1.time_ < var_260_12 + var_260_22 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play123101065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 123101065
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play123101066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1055ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1055ui_story == nil then
				arg_261_1.var_.characterEffect1055ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1055ui_story and not isNil(var_264_0) then
					local var_264_4 = Mathf.Lerp(0, 0.5, var_264_3)

					arg_261_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1055ui_story.fillRatio = var_264_4
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1055ui_story then
				local var_264_5 = 0.5

				arg_261_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1055ui_story.fillRatio = var_264_5
			end

			local var_264_6 = 0
			local var_264_7 = 0.5

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_8 = arg_261_1:FormatText(StoryNameCfg[7].name)

				arg_261_1.leftNameTxt_.text = var_264_8

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

				local var_264_9 = arg_261_1:GetWordFromCfg(123101065)
				local var_264_10 = arg_261_1:FormatText(var_264_9.content)

				arg_261_1.text_.text = var_264_10

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_11 = 20
				local var_264_12 = utf8.len(var_264_10)
				local var_264_13 = var_264_11 <= 0 and var_264_7 or var_264_7 * (var_264_12 / var_264_11)

				if var_264_13 > 0 and var_264_7 < var_264_13 then
					arg_261_1.talkMaxDuration = var_264_13

					if var_264_13 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_13 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_10
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_14 = math.max(var_264_7, arg_261_1.talkMaxDuration)

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_14 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_14

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_14 and arg_261_1.time_ < var_264_6 + var_264_14 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play123101066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 123101066
		arg_265_1.duration_ = 6.4

		local var_265_0 = {
			zh = 5.133,
			ja = 6.4
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
				arg_265_0:Play123101067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1055ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1055ui_story == nil then
				arg_265_1.var_.characterEffect1055ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1055ui_story and not isNil(var_268_0) then
					arg_265_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1055ui_story then
				arg_265_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_268_4 = 0

			if var_268_4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_268_5 = 0

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_268_6 = 0
			local var_268_7 = 0.6

			if var_268_6 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_8 = arg_265_1:FormatText(StoryNameCfg[481].name)

				arg_265_1.leftNameTxt_.text = var_268_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_9 = arg_265_1:GetWordFromCfg(123101066)
				local var_268_10 = arg_265_1:FormatText(var_268_9.content)

				arg_265_1.text_.text = var_268_10

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_11 = 24
				local var_268_12 = utf8.len(var_268_10)
				local var_268_13 = var_268_11 <= 0 and var_268_7 or var_268_7 * (var_268_12 / var_268_11)

				if var_268_13 > 0 and var_268_7 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_6
					end
				end

				arg_265_1.text_.text = var_268_10
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101066", "story_v_out_123101.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101066", "story_v_out_123101.awb") / 1000

					if var_268_14 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_6
					end

					if var_268_9.prefab_name ~= "" and arg_265_1.actors_[var_268_9.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_9.prefab_name].transform, "story_v_out_123101", "123101066", "story_v_out_123101.awb")

						arg_265_1:RecordAudio("123101066", var_268_15)
						arg_265_1:RecordAudio("123101066", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_123101", "123101066", "story_v_out_123101.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_123101", "123101066", "story_v_out_123101.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_16 = math.max(var_268_7, arg_265_1.talkMaxDuration)

			if var_268_6 <= arg_265_1.time_ and arg_265_1.time_ < var_268_6 + var_268_16 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_6) / var_268_16

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_6 + var_268_16 and arg_265_1.time_ < var_268_6 + var_268_16 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play123101067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 123101067
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play123101068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1055ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1055ui_story == nil then
				arg_269_1.var_.characterEffect1055ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1055ui_story and not isNil(var_272_0) then
					local var_272_4 = Mathf.Lerp(0, 0.5, var_272_3)

					arg_269_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1055ui_story.fillRatio = var_272_4
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1055ui_story then
				local var_272_5 = 0.5

				arg_269_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1055ui_story.fillRatio = var_272_5
			end

			local var_272_6 = 0
			local var_272_7 = 0.675

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_8 = arg_269_1:GetWordFromCfg(123101067)
				local var_272_9 = arg_269_1:FormatText(var_272_8.content)

				arg_269_1.text_.text = var_272_9

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_10 = 27
				local var_272_11 = utf8.len(var_272_9)
				local var_272_12 = var_272_10 <= 0 and var_272_7 or var_272_7 * (var_272_11 / var_272_10)

				if var_272_12 > 0 and var_272_7 < var_272_12 then
					arg_269_1.talkMaxDuration = var_272_12

					if var_272_12 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_12 + var_272_6
					end
				end

				arg_269_1.text_.text = var_272_9
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_13 = math.max(var_272_7, arg_269_1.talkMaxDuration)

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_13 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_6) / var_272_13

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_6 + var_272_13 and arg_269_1.time_ < var_272_6 + var_272_13 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play123101068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 123101068
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play123101069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1055ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1055ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0, 100, 0)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1055ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, 100, 0)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = arg_273_1.actors_["1055ui_story"]
			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect1055ui_story == nil then
				arg_273_1.var_.characterEffect1055ui_story = var_276_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_11 = 0.200000002980232

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_11 and not isNil(var_276_9) then
				local var_276_12 = (arg_273_1.time_ - var_276_10) / var_276_11

				if arg_273_1.var_.characterEffect1055ui_story and not isNil(var_276_9) then
					local var_276_13 = Mathf.Lerp(0, 0.5, var_276_12)

					arg_273_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1055ui_story.fillRatio = var_276_13
				end
			end

			if arg_273_1.time_ >= var_276_10 + var_276_11 and arg_273_1.time_ < var_276_10 + var_276_11 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect1055ui_story then
				local var_276_14 = 0.5

				arg_273_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1055ui_story.fillRatio = var_276_14
			end

			local var_276_15 = arg_273_1.actors_["1093ui_story"].transform
			local var_276_16 = 0

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 then
				arg_273_1.var_.moveOldPos1093ui_story = var_276_15.localPosition
			end

			local var_276_17 = 0.001

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_17 then
				local var_276_18 = (arg_273_1.time_ - var_276_16) / var_276_17
				local var_276_19 = Vector3.New(0, 100, 0)

				var_276_15.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1093ui_story, var_276_19, var_276_18)

				local var_276_20 = manager.ui.mainCamera.transform.position - var_276_15.position

				var_276_15.forward = Vector3.New(var_276_20.x, var_276_20.y, var_276_20.z)

				local var_276_21 = var_276_15.localEulerAngles

				var_276_21.z = 0
				var_276_21.x = 0
				var_276_15.localEulerAngles = var_276_21
			end

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 then
				var_276_15.localPosition = Vector3.New(0, 100, 0)

				local var_276_22 = manager.ui.mainCamera.transform.position - var_276_15.position

				var_276_15.forward = Vector3.New(var_276_22.x, var_276_22.y, var_276_22.z)

				local var_276_23 = var_276_15.localEulerAngles

				var_276_23.z = 0
				var_276_23.x = 0
				var_276_15.localEulerAngles = var_276_23
			end

			local var_276_24 = 0
			local var_276_25 = 1.35

			if var_276_24 < arg_273_1.time_ and arg_273_1.time_ <= var_276_24 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_26 = arg_273_1:GetWordFromCfg(123101068)
				local var_276_27 = arg_273_1:FormatText(var_276_26.content)

				arg_273_1.text_.text = var_276_27

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_28 = 54
				local var_276_29 = utf8.len(var_276_27)
				local var_276_30 = var_276_28 <= 0 and var_276_25 or var_276_25 * (var_276_29 / var_276_28)

				if var_276_30 > 0 and var_276_25 < var_276_30 then
					arg_273_1.talkMaxDuration = var_276_30

					if var_276_30 + var_276_24 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_30 + var_276_24
					end
				end

				arg_273_1.text_.text = var_276_27
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_31 = math.max(var_276_25, arg_273_1.talkMaxDuration)

			if var_276_24 <= arg_273_1.time_ and arg_273_1.time_ < var_276_24 + var_276_31 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_24) / var_276_31

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_24 + var_276_31 and arg_273_1.time_ < var_276_24 + var_276_31 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play123101069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 123101069
		arg_277_1.duration_ = 0.6

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"

			SetActive(arg_277_1.choicesGo_, true)

			for iter_278_0, iter_278_1 in ipairs(arg_277_1.choices_) do
				local var_278_0 = iter_278_0 <= 1

				SetActive(iter_278_1.go, var_278_0)
			end

			arg_277_1.choices_[1].txt.text = arg_277_1:FormatText(StoryChoiceCfg[504].name)
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play123101070(arg_277_1)
			end

			arg_277_1:RecordChoiceLog(123101069, 504)
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			local var_280_1 = 0.6

			if arg_277_1.time_ >= var_280_0 + var_280_1 and arg_277_1.time_ < var_280_0 + var_280_1 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play123101070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 123101070
		arg_281_1.duration_ = 2

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play123101071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1055ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1055ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0.7, -0.965, -6.2)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1055ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0.7, -0.965, -6.2)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = arg_281_1.actors_["1055ui_story"]
			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect1055ui_story == nil then
				arg_281_1.var_.characterEffect1055ui_story = var_284_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_11 = 0.200000002980232

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_11 and not isNil(var_284_9) then
				local var_284_12 = (arg_281_1.time_ - var_284_10) / var_284_11

				if arg_281_1.var_.characterEffect1055ui_story and not isNil(var_284_9) then
					arg_281_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_10 + var_284_11 and arg_281_1.time_ < var_284_10 + var_284_11 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect1055ui_story then
				arg_281_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_284_13 = 0

			if var_284_13 < arg_281_1.time_ and arg_281_1.time_ <= var_284_13 + arg_284_0 then
				arg_281_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_284_14 = 0

			if var_284_14 < arg_281_1.time_ and arg_281_1.time_ <= var_284_14 + arg_284_0 then
				arg_281_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_284_15 = 0
			local var_284_16 = 0.05

			if var_284_15 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_17 = arg_281_1:FormatText(StoryNameCfg[481].name)

				arg_281_1.leftNameTxt_.text = var_284_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_18 = arg_281_1:GetWordFromCfg(123101070)
				local var_284_19 = arg_281_1:FormatText(var_284_18.content)

				arg_281_1.text_.text = var_284_19

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_20 = 2
				local var_284_21 = utf8.len(var_284_19)
				local var_284_22 = var_284_20 <= 0 and var_284_16 or var_284_16 * (var_284_21 / var_284_20)

				if var_284_22 > 0 and var_284_16 < var_284_22 then
					arg_281_1.talkMaxDuration = var_284_22

					if var_284_22 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_22 + var_284_15
					end
				end

				arg_281_1.text_.text = var_284_19
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101070", "story_v_out_123101.awb") ~= 0 then
					local var_284_23 = manager.audio:GetVoiceLength("story_v_out_123101", "123101070", "story_v_out_123101.awb") / 1000

					if var_284_23 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_23 + var_284_15
					end

					if var_284_18.prefab_name ~= "" and arg_281_1.actors_[var_284_18.prefab_name] ~= nil then
						local var_284_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_18.prefab_name].transform, "story_v_out_123101", "123101070", "story_v_out_123101.awb")

						arg_281_1:RecordAudio("123101070", var_284_24)
						arg_281_1:RecordAudio("123101070", var_284_24)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_123101", "123101070", "story_v_out_123101.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_123101", "123101070", "story_v_out_123101.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_25 = math.max(var_284_16, arg_281_1.talkMaxDuration)

			if var_284_15 <= arg_281_1.time_ and arg_281_1.time_ < var_284_15 + var_284_25 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_15) / var_284_25

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_15 + var_284_25 and arg_281_1.time_ < var_284_15 + var_284_25 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play123101071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 123101071
		arg_285_1.duration_ = 2.57

		local var_285_0 = {
			zh = 2.566,
			ja = 2.533
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
				arg_285_0:Play123101072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1093ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1093ui_story = var_288_0.localPosition
			end

			local var_288_2 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2
				local var_288_4 = Vector3.New(-0.7, -1.11, -5.88)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1093ui_story, var_288_4, var_288_3)

				local var_288_5 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_5.x, var_288_5.y, var_288_5.z)

				local var_288_6 = var_288_0.localEulerAngles

				var_288_6.z = 0
				var_288_6.x = 0
				var_288_0.localEulerAngles = var_288_6
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_288_7 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_7.x, var_288_7.y, var_288_7.z)

				local var_288_8 = var_288_0.localEulerAngles

				var_288_8.z = 0
				var_288_8.x = 0
				var_288_0.localEulerAngles = var_288_8
			end

			local var_288_9 = arg_285_1.actors_["1093ui_story"]
			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect1093ui_story == nil then
				arg_285_1.var_.characterEffect1093ui_story = var_288_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_11 = 0.200000002980232

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_11 and not isNil(var_288_9) then
				local var_288_12 = (arg_285_1.time_ - var_288_10) / var_288_11

				if arg_285_1.var_.characterEffect1093ui_story and not isNil(var_288_9) then
					arg_285_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_10 + var_288_11 and arg_285_1.time_ < var_288_10 + var_288_11 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect1093ui_story then
				arg_285_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_288_13 = 0

			if var_288_13 < arg_285_1.time_ and arg_285_1.time_ <= var_288_13 + arg_288_0 then
				arg_285_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			local var_288_14 = 0

			if var_288_14 < arg_285_1.time_ and arg_285_1.time_ <= var_288_14 + arg_288_0 then
				arg_285_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_288_15 = arg_285_1.actors_["1055ui_story"]
			local var_288_16 = 0

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 and not isNil(var_288_15) and arg_285_1.var_.characterEffect1055ui_story == nil then
				arg_285_1.var_.characterEffect1055ui_story = var_288_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_17 = 0.200000002980232

			if var_288_16 <= arg_285_1.time_ and arg_285_1.time_ < var_288_16 + var_288_17 and not isNil(var_288_15) then
				local var_288_18 = (arg_285_1.time_ - var_288_16) / var_288_17

				if arg_285_1.var_.characterEffect1055ui_story and not isNil(var_288_15) then
					local var_288_19 = Mathf.Lerp(0, 0.5, var_288_18)

					arg_285_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1055ui_story.fillRatio = var_288_19
				end
			end

			if arg_285_1.time_ >= var_288_16 + var_288_17 and arg_285_1.time_ < var_288_16 + var_288_17 + arg_288_0 and not isNil(var_288_15) and arg_285_1.var_.characterEffect1055ui_story then
				local var_288_20 = 0.5

				arg_285_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1055ui_story.fillRatio = var_288_20
			end

			local var_288_21 = 0
			local var_288_22 = 0.3

			if var_288_21 < arg_285_1.time_ and arg_285_1.time_ <= var_288_21 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_23 = arg_285_1:FormatText(StoryNameCfg[73].name)

				arg_285_1.leftNameTxt_.text = var_288_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_24 = arg_285_1:GetWordFromCfg(123101071)
				local var_288_25 = arg_285_1:FormatText(var_288_24.content)

				arg_285_1.text_.text = var_288_25

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_26 = 12
				local var_288_27 = utf8.len(var_288_25)
				local var_288_28 = var_288_26 <= 0 and var_288_22 or var_288_22 * (var_288_27 / var_288_26)

				if var_288_28 > 0 and var_288_22 < var_288_28 then
					arg_285_1.talkMaxDuration = var_288_28

					if var_288_28 + var_288_21 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_28 + var_288_21
					end
				end

				arg_285_1.text_.text = var_288_25
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101071", "story_v_out_123101.awb") ~= 0 then
					local var_288_29 = manager.audio:GetVoiceLength("story_v_out_123101", "123101071", "story_v_out_123101.awb") / 1000

					if var_288_29 + var_288_21 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_29 + var_288_21
					end

					if var_288_24.prefab_name ~= "" and arg_285_1.actors_[var_288_24.prefab_name] ~= nil then
						local var_288_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_24.prefab_name].transform, "story_v_out_123101", "123101071", "story_v_out_123101.awb")

						arg_285_1:RecordAudio("123101071", var_288_30)
						arg_285_1:RecordAudio("123101071", var_288_30)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_123101", "123101071", "story_v_out_123101.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_123101", "123101071", "story_v_out_123101.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_31 = math.max(var_288_22, arg_285_1.talkMaxDuration)

			if var_288_21 <= arg_285_1.time_ and arg_285_1.time_ < var_288_21 + var_288_31 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_21) / var_288_31

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_21 + var_288_31 and arg_285_1.time_ < var_288_21 + var_288_31 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play123101072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 123101072
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play123101073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1093ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1093ui_story == nil then
				arg_289_1.var_.characterEffect1093ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1093ui_story and not isNil(var_292_0) then
					local var_292_4 = Mathf.Lerp(0, 0.5, var_292_3)

					arg_289_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1093ui_story.fillRatio = var_292_4
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1093ui_story then
				local var_292_5 = 0.5

				arg_289_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1093ui_story.fillRatio = var_292_5
			end

			local var_292_6 = 0
			local var_292_7 = 0.45

			if var_292_6 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_8 = arg_289_1:FormatText(StoryNameCfg[7].name)

				arg_289_1.leftNameTxt_.text = var_292_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_9 = arg_289_1:GetWordFromCfg(123101072)
				local var_292_10 = arg_289_1:FormatText(var_292_9.content)

				arg_289_1.text_.text = var_292_10

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_11 = 18
				local var_292_12 = utf8.len(var_292_10)
				local var_292_13 = var_292_11 <= 0 and var_292_7 or var_292_7 * (var_292_12 / var_292_11)

				if var_292_13 > 0 and var_292_7 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_6
					end
				end

				arg_289_1.text_.text = var_292_10
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_14 = math.max(var_292_7, arg_289_1.talkMaxDuration)

			if var_292_6 <= arg_289_1.time_ and arg_289_1.time_ < var_292_6 + var_292_14 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_6) / var_292_14

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_6 + var_292_14 and arg_289_1.time_ < var_292_6 + var_292_14 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play123101073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 123101073
		arg_293_1.duration_ = 4.3

		local var_293_0 = {
			zh = 4.3,
			ja = 2.566
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
				arg_293_0:Play123101074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1093ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1093ui_story == nil then
				arg_293_1.var_.characterEffect1093ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1093ui_story and not isNil(var_296_0) then
					arg_293_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1093ui_story then
				arg_293_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_296_4 = 0
			local var_296_5 = 0.425

			if var_296_4 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_6 = arg_293_1:FormatText(StoryNameCfg[73].name)

				arg_293_1.leftNameTxt_.text = var_296_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_7 = arg_293_1:GetWordFromCfg(123101073)
				local var_296_8 = arg_293_1:FormatText(var_296_7.content)

				arg_293_1.text_.text = var_296_8

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_9 = 17
				local var_296_10 = utf8.len(var_296_8)
				local var_296_11 = var_296_9 <= 0 and var_296_5 or var_296_5 * (var_296_10 / var_296_9)

				if var_296_11 > 0 and var_296_5 < var_296_11 then
					arg_293_1.talkMaxDuration = var_296_11

					if var_296_11 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_8
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101073", "story_v_out_123101.awb") ~= 0 then
					local var_296_12 = manager.audio:GetVoiceLength("story_v_out_123101", "123101073", "story_v_out_123101.awb") / 1000

					if var_296_12 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_12 + var_296_4
					end

					if var_296_7.prefab_name ~= "" and arg_293_1.actors_[var_296_7.prefab_name] ~= nil then
						local var_296_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_7.prefab_name].transform, "story_v_out_123101", "123101073", "story_v_out_123101.awb")

						arg_293_1:RecordAudio("123101073", var_296_13)
						arg_293_1:RecordAudio("123101073", var_296_13)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_123101", "123101073", "story_v_out_123101.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_123101", "123101073", "story_v_out_123101.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_14 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_14 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_14

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_14 and arg_293_1.time_ < var_296_4 + var_296_14 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play123101074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 123101074
		arg_297_1.duration_ = 7.23

		local var_297_0 = {
			zh = 4.966,
			ja = 7.233
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play123101075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1055ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1055ui_story = var_300_0.localPosition
			end

			local var_300_2 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2
				local var_300_4 = Vector3.New(0.7, -0.965, -6.2)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1055ui_story, var_300_4, var_300_3)

				local var_300_5 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_5.x, var_300_5.y, var_300_5.z)

				local var_300_6 = var_300_0.localEulerAngles

				var_300_6.z = 0
				var_300_6.x = 0
				var_300_0.localEulerAngles = var_300_6
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0.7, -0.965, -6.2)

				local var_300_7 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_7.x, var_300_7.y, var_300_7.z)

				local var_300_8 = var_300_0.localEulerAngles

				var_300_8.z = 0
				var_300_8.x = 0
				var_300_0.localEulerAngles = var_300_8
			end

			local var_300_9 = arg_297_1.actors_["1055ui_story"]
			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 and not isNil(var_300_9) and arg_297_1.var_.characterEffect1055ui_story == nil then
				arg_297_1.var_.characterEffect1055ui_story = var_300_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_11 = 0.200000002980232

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_11 and not isNil(var_300_9) then
				local var_300_12 = (arg_297_1.time_ - var_300_10) / var_300_11

				if arg_297_1.var_.characterEffect1055ui_story and not isNil(var_300_9) then
					arg_297_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_10 + var_300_11 and arg_297_1.time_ < var_300_10 + var_300_11 + arg_300_0 and not isNil(var_300_9) and arg_297_1.var_.characterEffect1055ui_story then
				arg_297_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_300_13 = 0

			if var_300_13 < arg_297_1.time_ and arg_297_1.time_ <= var_300_13 + arg_300_0 then
				arg_297_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			local var_300_14 = 0

			if var_300_14 < arg_297_1.time_ and arg_297_1.time_ <= var_300_14 + arg_300_0 then
				arg_297_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_300_15 = arg_297_1.actors_["1093ui_story"]
			local var_300_16 = 0

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.characterEffect1093ui_story == nil then
				arg_297_1.var_.characterEffect1093ui_story = var_300_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_17 = 0.200000002980232

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_17 and not isNil(var_300_15) then
				local var_300_18 = (arg_297_1.time_ - var_300_16) / var_300_17

				if arg_297_1.var_.characterEffect1093ui_story and not isNil(var_300_15) then
					local var_300_19 = Mathf.Lerp(0, 0.5, var_300_18)

					arg_297_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1093ui_story.fillRatio = var_300_19
				end
			end

			if arg_297_1.time_ >= var_300_16 + var_300_17 and arg_297_1.time_ < var_300_16 + var_300_17 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.characterEffect1093ui_story then
				local var_300_20 = 0.5

				arg_297_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1093ui_story.fillRatio = var_300_20
			end

			local var_300_21 = 0
			local var_300_22 = 0.525

			if var_300_21 < arg_297_1.time_ and arg_297_1.time_ <= var_300_21 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_23 = arg_297_1:FormatText(StoryNameCfg[481].name)

				arg_297_1.leftNameTxt_.text = var_300_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_24 = arg_297_1:GetWordFromCfg(123101074)
				local var_300_25 = arg_297_1:FormatText(var_300_24.content)

				arg_297_1.text_.text = var_300_25

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_26 = 21
				local var_300_27 = utf8.len(var_300_25)
				local var_300_28 = var_300_26 <= 0 and var_300_22 or var_300_22 * (var_300_27 / var_300_26)

				if var_300_28 > 0 and var_300_22 < var_300_28 then
					arg_297_1.talkMaxDuration = var_300_28

					if var_300_28 + var_300_21 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_28 + var_300_21
					end
				end

				arg_297_1.text_.text = var_300_25
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101074", "story_v_out_123101.awb") ~= 0 then
					local var_300_29 = manager.audio:GetVoiceLength("story_v_out_123101", "123101074", "story_v_out_123101.awb") / 1000

					if var_300_29 + var_300_21 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_29 + var_300_21
					end

					if var_300_24.prefab_name ~= "" and arg_297_1.actors_[var_300_24.prefab_name] ~= nil then
						local var_300_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_24.prefab_name].transform, "story_v_out_123101", "123101074", "story_v_out_123101.awb")

						arg_297_1:RecordAudio("123101074", var_300_30)
						arg_297_1:RecordAudio("123101074", var_300_30)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_123101", "123101074", "story_v_out_123101.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_123101", "123101074", "story_v_out_123101.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_31 = math.max(var_300_22, arg_297_1.talkMaxDuration)

			if var_300_21 <= arg_297_1.time_ and arg_297_1.time_ < var_300_21 + var_300_31 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_21) / var_300_31

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_21 + var_300_31 and arg_297_1.time_ < var_300_21 + var_300_31 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123101075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 123101075
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play123101076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1055ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1055ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0, 100, 0)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1055ui_story, var_304_4, var_304_3)

				local var_304_5 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_5.x, var_304_5.y, var_304_5.z)

				local var_304_6 = var_304_0.localEulerAngles

				var_304_6.z = 0
				var_304_6.x = 0
				var_304_0.localEulerAngles = var_304_6
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0, 100, 0)

				local var_304_7 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_7.x, var_304_7.y, var_304_7.z)

				local var_304_8 = var_304_0.localEulerAngles

				var_304_8.z = 0
				var_304_8.x = 0
				var_304_0.localEulerAngles = var_304_8
			end

			local var_304_9 = arg_301_1.actors_["1055ui_story"]
			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1055ui_story == nil then
				arg_301_1.var_.characterEffect1055ui_story = var_304_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_11 = 0.200000002980232

			if var_304_10 <= arg_301_1.time_ and arg_301_1.time_ < var_304_10 + var_304_11 and not isNil(var_304_9) then
				local var_304_12 = (arg_301_1.time_ - var_304_10) / var_304_11

				if arg_301_1.var_.characterEffect1055ui_story and not isNil(var_304_9) then
					local var_304_13 = Mathf.Lerp(0, 0.5, var_304_12)

					arg_301_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1055ui_story.fillRatio = var_304_13
				end
			end

			if arg_301_1.time_ >= var_304_10 + var_304_11 and arg_301_1.time_ < var_304_10 + var_304_11 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1055ui_story then
				local var_304_14 = 0.5

				arg_301_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1055ui_story.fillRatio = var_304_14
			end

			local var_304_15 = arg_301_1.actors_["1093ui_story"].transform
			local var_304_16 = 0

			if var_304_16 < arg_301_1.time_ and arg_301_1.time_ <= var_304_16 + arg_304_0 then
				arg_301_1.var_.moveOldPos1093ui_story = var_304_15.localPosition
			end

			local var_304_17 = 0.001

			if var_304_16 <= arg_301_1.time_ and arg_301_1.time_ < var_304_16 + var_304_17 then
				local var_304_18 = (arg_301_1.time_ - var_304_16) / var_304_17
				local var_304_19 = Vector3.New(0, 100, 0)

				var_304_15.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1093ui_story, var_304_19, var_304_18)

				local var_304_20 = manager.ui.mainCamera.transform.position - var_304_15.position

				var_304_15.forward = Vector3.New(var_304_20.x, var_304_20.y, var_304_20.z)

				local var_304_21 = var_304_15.localEulerAngles

				var_304_21.z = 0
				var_304_21.x = 0
				var_304_15.localEulerAngles = var_304_21
			end

			if arg_301_1.time_ >= var_304_16 + var_304_17 and arg_301_1.time_ < var_304_16 + var_304_17 + arg_304_0 then
				var_304_15.localPosition = Vector3.New(0, 100, 0)

				local var_304_22 = manager.ui.mainCamera.transform.position - var_304_15.position

				var_304_15.forward = Vector3.New(var_304_22.x, var_304_22.y, var_304_22.z)

				local var_304_23 = var_304_15.localEulerAngles

				var_304_23.z = 0
				var_304_23.x = 0
				var_304_15.localEulerAngles = var_304_23
			end

			local var_304_24 = arg_301_1.actors_["1093ui_story"]
			local var_304_25 = 0

			if var_304_25 < arg_301_1.time_ and arg_301_1.time_ <= var_304_25 + arg_304_0 and not isNil(var_304_24) and arg_301_1.var_.characterEffect1093ui_story == nil then
				arg_301_1.var_.characterEffect1093ui_story = var_304_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_26 = 0.200000002980232

			if var_304_25 <= arg_301_1.time_ and arg_301_1.time_ < var_304_25 + var_304_26 and not isNil(var_304_24) then
				local var_304_27 = (arg_301_1.time_ - var_304_25) / var_304_26

				if arg_301_1.var_.characterEffect1093ui_story and not isNil(var_304_24) then
					local var_304_28 = Mathf.Lerp(0, 0.5, var_304_27)

					arg_301_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1093ui_story.fillRatio = var_304_28
				end
			end

			if arg_301_1.time_ >= var_304_25 + var_304_26 and arg_301_1.time_ < var_304_25 + var_304_26 + arg_304_0 and not isNil(var_304_24) and arg_301_1.var_.characterEffect1093ui_story then
				local var_304_29 = 0.5

				arg_301_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1093ui_story.fillRatio = var_304_29
			end

			local var_304_30 = 0
			local var_304_31 = 0.7

			if var_304_30 < arg_301_1.time_ and arg_301_1.time_ <= var_304_30 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_32 = arg_301_1:FormatText(StoryNameCfg[7].name)

				arg_301_1.leftNameTxt_.text = var_304_32

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

				local var_304_33 = arg_301_1:GetWordFromCfg(123101075)
				local var_304_34 = arg_301_1:FormatText(var_304_33.content)

				arg_301_1.text_.text = var_304_34

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_35 = 28
				local var_304_36 = utf8.len(var_304_34)
				local var_304_37 = var_304_35 <= 0 and var_304_31 or var_304_31 * (var_304_36 / var_304_35)

				if var_304_37 > 0 and var_304_31 < var_304_37 then
					arg_301_1.talkMaxDuration = var_304_37

					if var_304_37 + var_304_30 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_37 + var_304_30
					end
				end

				arg_301_1.text_.text = var_304_34
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_38 = math.max(var_304_31, arg_301_1.talkMaxDuration)

			if var_304_30 <= arg_301_1.time_ and arg_301_1.time_ < var_304_30 + var_304_38 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_30) / var_304_38

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_30 + var_304_38 and arg_301_1.time_ < var_304_30 + var_304_38 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play123101076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 123101076
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play123101077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.525

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_2 = arg_305_1:GetWordFromCfg(123101076)
				local var_308_3 = arg_305_1:FormatText(var_308_2.content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 21
				local var_308_5 = utf8.len(var_308_3)
				local var_308_6 = var_308_4 <= 0 and var_308_1 or var_308_1 * (var_308_5 / var_308_4)

				if var_308_6 > 0 and var_308_1 < var_308_6 then
					arg_305_1.talkMaxDuration = var_308_6

					if var_308_6 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_6 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_7 and arg_305_1.time_ < var_308_0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play123101077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 123101077
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play123101078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.925

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[7].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(123101077)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 37
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_8 and arg_309_1.time_ < var_312_0 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play123101078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 123101078
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play123101079(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.975

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[7].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:GetWordFromCfg(123101078)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 39
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_8 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_8 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_8

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_8 and arg_313_1.time_ < var_316_0 + var_316_8 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play123101079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 123101079
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play123101080(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.5

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(123101079)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 20
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play123101080 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 123101080
		arg_321_1.duration_ = 7.13

		local var_321_0 = {
			zh = 7.133,
			ja = 6
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play123101081(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1055ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1055ui_story = var_324_0.localPosition
			end

			local var_324_2 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2
				local var_324_4 = Vector3.New(0, -0.965, -6.2)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1055ui_story, var_324_4, var_324_3)

				local var_324_5 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_5.x, var_324_5.y, var_324_5.z)

				local var_324_6 = var_324_0.localEulerAngles

				var_324_6.z = 0
				var_324_6.x = 0
				var_324_0.localEulerAngles = var_324_6
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_324_7 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_7.x, var_324_7.y, var_324_7.z)

				local var_324_8 = var_324_0.localEulerAngles

				var_324_8.z = 0
				var_324_8.x = 0
				var_324_0.localEulerAngles = var_324_8
			end

			local var_324_9 = arg_321_1.actors_["1055ui_story"]
			local var_324_10 = 0

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1055ui_story == nil then
				arg_321_1.var_.characterEffect1055ui_story = var_324_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_11 = 0.200000002980232

			if var_324_10 <= arg_321_1.time_ and arg_321_1.time_ < var_324_10 + var_324_11 and not isNil(var_324_9) then
				local var_324_12 = (arg_321_1.time_ - var_324_10) / var_324_11

				if arg_321_1.var_.characterEffect1055ui_story and not isNil(var_324_9) then
					arg_321_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_10 + var_324_11 and arg_321_1.time_ < var_324_10 + var_324_11 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1055ui_story then
				arg_321_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_324_13 = 0

			if var_324_13 < arg_321_1.time_ and arg_321_1.time_ <= var_324_13 + arg_324_0 then
				arg_321_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_324_14 = 0

			if var_324_14 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 then
				arg_321_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_324_15 = 0
			local var_324_16 = 0.475

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_17 = arg_321_1:FormatText(StoryNameCfg[481].name)

				arg_321_1.leftNameTxt_.text = var_324_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_18 = arg_321_1:GetWordFromCfg(123101080)
				local var_324_19 = arg_321_1:FormatText(var_324_18.content)

				arg_321_1.text_.text = var_324_19

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_20 = 20
				local var_324_21 = utf8.len(var_324_19)
				local var_324_22 = var_324_20 <= 0 and var_324_16 or var_324_16 * (var_324_21 / var_324_20)

				if var_324_22 > 0 and var_324_16 < var_324_22 then
					arg_321_1.talkMaxDuration = var_324_22

					if var_324_22 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_22 + var_324_15
					end
				end

				arg_321_1.text_.text = var_324_19
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101080", "story_v_out_123101.awb") ~= 0 then
					local var_324_23 = manager.audio:GetVoiceLength("story_v_out_123101", "123101080", "story_v_out_123101.awb") / 1000

					if var_324_23 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_23 + var_324_15
					end

					if var_324_18.prefab_name ~= "" and arg_321_1.actors_[var_324_18.prefab_name] ~= nil then
						local var_324_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_18.prefab_name].transform, "story_v_out_123101", "123101080", "story_v_out_123101.awb")

						arg_321_1:RecordAudio("123101080", var_324_24)
						arg_321_1:RecordAudio("123101080", var_324_24)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_123101", "123101080", "story_v_out_123101.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_123101", "123101080", "story_v_out_123101.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_25 = math.max(var_324_16, arg_321_1.talkMaxDuration)

			if var_324_15 <= arg_321_1.time_ and arg_321_1.time_ < var_324_15 + var_324_25 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_15) / var_324_25

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_15 + var_324_25 and arg_321_1.time_ < var_324_15 + var_324_25 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play123101081 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 123101081
		arg_325_1.duration_ = 6.63

		local var_325_0 = {
			zh = 3.366,
			ja = 6.633
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
				arg_325_0:Play123101082(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1055ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1055ui_story == nil then
				arg_325_1.var_.characterEffect1055ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect1055ui_story and not isNil(var_328_0) then
					arg_325_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1055ui_story then
				arg_325_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_328_4 = 0

			if var_328_4 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_328_5 = 0

			if var_328_5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_328_6 = 0
			local var_328_7 = 0.375

			if var_328_6 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_8 = arg_325_1:FormatText(StoryNameCfg[481].name)

				arg_325_1.leftNameTxt_.text = var_328_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_9 = arg_325_1:GetWordFromCfg(123101081)
				local var_328_10 = arg_325_1:FormatText(var_328_9.content)

				arg_325_1.text_.text = var_328_10

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_11 = 15
				local var_328_12 = utf8.len(var_328_10)
				local var_328_13 = var_328_11 <= 0 and var_328_7 or var_328_7 * (var_328_12 / var_328_11)

				if var_328_13 > 0 and var_328_7 < var_328_13 then
					arg_325_1.talkMaxDuration = var_328_13

					if var_328_13 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_13 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_10
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101081", "story_v_out_123101.awb") ~= 0 then
					local var_328_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101081", "story_v_out_123101.awb") / 1000

					if var_328_14 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_14 + var_328_6
					end

					if var_328_9.prefab_name ~= "" and arg_325_1.actors_[var_328_9.prefab_name] ~= nil then
						local var_328_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_9.prefab_name].transform, "story_v_out_123101", "123101081", "story_v_out_123101.awb")

						arg_325_1:RecordAudio("123101081", var_328_15)
						arg_325_1:RecordAudio("123101081", var_328_15)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_123101", "123101081", "story_v_out_123101.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_123101", "123101081", "story_v_out_123101.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_16 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_16 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_16

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_16 and arg_325_1.time_ < var_328_6 + var_328_16 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play123101082 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 123101082
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play123101083(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1055ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1055ui_story == nil then
				arg_329_1.var_.characterEffect1055ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect1055ui_story and not isNil(var_332_0) then
					local var_332_4 = Mathf.Lerp(0, 0.5, var_332_3)

					arg_329_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1055ui_story.fillRatio = var_332_4
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1055ui_story then
				local var_332_5 = 0.5

				arg_329_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1055ui_story.fillRatio = var_332_5
			end

			local var_332_6 = 0
			local var_332_7 = 0.825

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_8 = arg_329_1:FormatText(StoryNameCfg[7].name)

				arg_329_1.leftNameTxt_.text = var_332_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_9 = arg_329_1:GetWordFromCfg(123101082)
				local var_332_10 = arg_329_1:FormatText(var_332_9.content)

				arg_329_1.text_.text = var_332_10

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_11 = 33
				local var_332_12 = utf8.len(var_332_10)
				local var_332_13 = var_332_11 <= 0 and var_332_7 or var_332_7 * (var_332_12 / var_332_11)

				if var_332_13 > 0 and var_332_7 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_6 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_6
					end
				end

				arg_329_1.text_.text = var_332_10
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_14 = math.max(var_332_7, arg_329_1.talkMaxDuration)

			if var_332_6 <= arg_329_1.time_ and arg_329_1.time_ < var_332_6 + var_332_14 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_6) / var_332_14

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_6 + var_332_14 and arg_329_1.time_ < var_332_6 + var_332_14 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play123101083 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 123101083
		arg_333_1.duration_ = 2.6

		local var_333_0 = {
			zh = 2.6,
			ja = 2.033
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
				arg_333_0:Play123101084(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1055ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1055ui_story == nil then
				arg_333_1.var_.characterEffect1055ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect1055ui_story and not isNil(var_336_0) then
					arg_333_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1055ui_story then
				arg_333_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_336_4 = 0

			if var_336_4 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action2_1")
			end

			local var_336_5 = 0

			if var_336_5 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_336_6 = 0
			local var_336_7 = 0.125

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_8 = arg_333_1:FormatText(StoryNameCfg[481].name)

				arg_333_1.leftNameTxt_.text = var_336_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_9 = arg_333_1:GetWordFromCfg(123101083)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 5
				local var_336_12 = utf8.len(var_336_10)
				local var_336_13 = var_336_11 <= 0 and var_336_7 or var_336_7 * (var_336_12 / var_336_11)

				if var_336_13 > 0 and var_336_7 < var_336_13 then
					arg_333_1.talkMaxDuration = var_336_13

					if var_336_13 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_10
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101083", "story_v_out_123101.awb") ~= 0 then
					local var_336_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101083", "story_v_out_123101.awb") / 1000

					if var_336_14 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_14 + var_336_6
					end

					if var_336_9.prefab_name ~= "" and arg_333_1.actors_[var_336_9.prefab_name] ~= nil then
						local var_336_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_9.prefab_name].transform, "story_v_out_123101", "123101083", "story_v_out_123101.awb")

						arg_333_1:RecordAudio("123101083", var_336_15)
						arg_333_1:RecordAudio("123101083", var_336_15)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_123101", "123101083", "story_v_out_123101.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_123101", "123101083", "story_v_out_123101.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_16 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_16 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_16

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_16 and arg_333_1.time_ < var_336_6 + var_336_16 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play123101084 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 123101084
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play123101085(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1055ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1055ui_story == nil then
				arg_337_1.var_.characterEffect1055ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1055ui_story and not isNil(var_340_0) then
					local var_340_4 = Mathf.Lerp(0, 0.5, var_340_3)

					arg_337_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1055ui_story.fillRatio = var_340_4
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1055ui_story then
				local var_340_5 = 0.5

				arg_337_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1055ui_story.fillRatio = var_340_5
			end

			local var_340_6 = 0
			local var_340_7 = 0.6

			if var_340_6 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_8 = arg_337_1:GetWordFromCfg(123101084)
				local var_340_9 = arg_337_1:FormatText(var_340_8.content)

				arg_337_1.text_.text = var_340_9

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_10 = 24
				local var_340_11 = utf8.len(var_340_9)
				local var_340_12 = var_340_10 <= 0 and var_340_7 or var_340_7 * (var_340_11 / var_340_10)

				if var_340_12 > 0 and var_340_7 < var_340_12 then
					arg_337_1.talkMaxDuration = var_340_12

					if var_340_12 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_12 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_9
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_13 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_13 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_13

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_13 and arg_337_1.time_ < var_340_6 + var_340_13 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play123101085 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 123101085
		arg_341_1.duration_ = 5.53

		local var_341_0 = {
			zh = 5.533,
			ja = 5.4
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play123101086(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1055ui_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1055ui_story == nil then
				arg_341_1.var_.characterEffect1055ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect1055ui_story and not isNil(var_344_0) then
					arg_341_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1055ui_story then
				arg_341_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_344_4 = 0

			if var_344_4 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action2_2")
			end

			local var_344_5 = 0

			if var_344_5 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 then
				arg_341_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_344_6 = 0
			local var_344_7 = 0.75

			if var_344_6 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_8 = arg_341_1:FormatText(StoryNameCfg[481].name)

				arg_341_1.leftNameTxt_.text = var_344_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_9 = arg_341_1:GetWordFromCfg(123101085)
				local var_344_10 = arg_341_1:FormatText(var_344_9.content)

				arg_341_1.text_.text = var_344_10

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_11 = 30
				local var_344_12 = utf8.len(var_344_10)
				local var_344_13 = var_344_11 <= 0 and var_344_7 or var_344_7 * (var_344_12 / var_344_11)

				if var_344_13 > 0 and var_344_7 < var_344_13 then
					arg_341_1.talkMaxDuration = var_344_13

					if var_344_13 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_6
					end
				end

				arg_341_1.text_.text = var_344_10
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101085", "story_v_out_123101.awb") ~= 0 then
					local var_344_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101085", "story_v_out_123101.awb") / 1000

					if var_344_14 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_14 + var_344_6
					end

					if var_344_9.prefab_name ~= "" and arg_341_1.actors_[var_344_9.prefab_name] ~= nil then
						local var_344_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_9.prefab_name].transform, "story_v_out_123101", "123101085", "story_v_out_123101.awb")

						arg_341_1:RecordAudio("123101085", var_344_15)
						arg_341_1:RecordAudio("123101085", var_344_15)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_123101", "123101085", "story_v_out_123101.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_123101", "123101085", "story_v_out_123101.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_16 = math.max(var_344_7, arg_341_1.talkMaxDuration)

			if var_344_6 <= arg_341_1.time_ and arg_341_1.time_ < var_344_6 + var_344_16 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_6) / var_344_16

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_6 + var_344_16 and arg_341_1.time_ < var_344_6 + var_344_16 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play123101086 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 123101086
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play123101087(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1055ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1055ui_story == nil then
				arg_345_1.var_.characterEffect1055ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect1055ui_story and not isNil(var_348_0) then
					local var_348_4 = Mathf.Lerp(0, 0.5, var_348_3)

					arg_345_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1055ui_story.fillRatio = var_348_4
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1055ui_story then
				local var_348_5 = 0.5

				arg_345_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1055ui_story.fillRatio = var_348_5
			end

			local var_348_6 = 0
			local var_348_7 = 0.7

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_8 = arg_345_1:FormatText(StoryNameCfg[7].name)

				arg_345_1.leftNameTxt_.text = var_348_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_9 = arg_345_1:GetWordFromCfg(123101086)
				local var_348_10 = arg_345_1:FormatText(var_348_9.content)

				arg_345_1.text_.text = var_348_10

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 28
				local var_348_12 = utf8.len(var_348_10)
				local var_348_13 = var_348_11 <= 0 and var_348_7 or var_348_7 * (var_348_12 / var_348_11)

				if var_348_13 > 0 and var_348_7 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_10
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_14 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_14 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_14

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_14 and arg_345_1.time_ < var_348_6 + var_348_14 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play123101087 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 123101087
		arg_349_1.duration_ = 7

		local var_349_0 = {
			zh = 6.033,
			ja = 7
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play123101088(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1055ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1055ui_story == nil then
				arg_349_1.var_.characterEffect1055ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect1055ui_story and not isNil(var_352_0) then
					arg_349_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1055ui_story then
				arg_349_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_352_4 = 0

			if var_352_4 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_352_5 = 0

			if var_352_5 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 then
				arg_349_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_352_6 = 0
			local var_352_7 = 0.625

			if var_352_6 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_8 = arg_349_1:FormatText(StoryNameCfg[481].name)

				arg_349_1.leftNameTxt_.text = var_352_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_9 = arg_349_1:GetWordFromCfg(123101087)
				local var_352_10 = arg_349_1:FormatText(var_352_9.content)

				arg_349_1.text_.text = var_352_10

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 25
				local var_352_12 = utf8.len(var_352_10)
				local var_352_13 = var_352_11 <= 0 and var_352_7 or var_352_7 * (var_352_12 / var_352_11)

				if var_352_13 > 0 and var_352_7 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_10
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101087", "story_v_out_123101.awb") ~= 0 then
					local var_352_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101087", "story_v_out_123101.awb") / 1000

					if var_352_14 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_14 + var_352_6
					end

					if var_352_9.prefab_name ~= "" and arg_349_1.actors_[var_352_9.prefab_name] ~= nil then
						local var_352_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_9.prefab_name].transform, "story_v_out_123101", "123101087", "story_v_out_123101.awb")

						arg_349_1:RecordAudio("123101087", var_352_15)
						arg_349_1:RecordAudio("123101087", var_352_15)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_123101", "123101087", "story_v_out_123101.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_123101", "123101087", "story_v_out_123101.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_16 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_16 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_16

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_16 and arg_349_1.time_ < var_352_6 + var_352_16 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play123101088 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 123101088
		arg_353_1.duration_ = 3.7

		local var_353_0 = {
			zh = 3.166,
			ja = 3.7
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play123101089(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1093ui_story"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos1093ui_story = var_356_0.localPosition
			end

			local var_356_2 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2
				local var_356_4 = Vector3.New(-0.7, -1.11, -5.88)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1093ui_story, var_356_4, var_356_3)

				local var_356_5 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_5.x, var_356_5.y, var_356_5.z)

				local var_356_6 = var_356_0.localEulerAngles

				var_356_6.z = 0
				var_356_6.x = 0
				var_356_0.localEulerAngles = var_356_6
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_356_7 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_7.x, var_356_7.y, var_356_7.z)

				local var_356_8 = var_356_0.localEulerAngles

				var_356_8.z = 0
				var_356_8.x = 0
				var_356_0.localEulerAngles = var_356_8
			end

			local var_356_9 = arg_353_1.actors_["1093ui_story"]
			local var_356_10 = 0

			if var_356_10 < arg_353_1.time_ and arg_353_1.time_ <= var_356_10 + arg_356_0 and not isNil(var_356_9) and arg_353_1.var_.characterEffect1093ui_story == nil then
				arg_353_1.var_.characterEffect1093ui_story = var_356_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_11 = 0.200000002980232

			if var_356_10 <= arg_353_1.time_ and arg_353_1.time_ < var_356_10 + var_356_11 and not isNil(var_356_9) then
				local var_356_12 = (arg_353_1.time_ - var_356_10) / var_356_11

				if arg_353_1.var_.characterEffect1093ui_story and not isNil(var_356_9) then
					arg_353_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= var_356_10 + var_356_11 and arg_353_1.time_ < var_356_10 + var_356_11 + arg_356_0 and not isNil(var_356_9) and arg_353_1.var_.characterEffect1093ui_story then
				arg_353_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_356_13 = 0

			if var_356_13 < arg_353_1.time_ and arg_353_1.time_ <= var_356_13 + arg_356_0 then
				arg_353_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			local var_356_14 = 0

			if var_356_14 < arg_353_1.time_ and arg_353_1.time_ <= var_356_14 + arg_356_0 then
				arg_353_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_356_15 = arg_353_1.actors_["1055ui_story"].transform
			local var_356_16 = 0

			if var_356_16 < arg_353_1.time_ and arg_353_1.time_ <= var_356_16 + arg_356_0 then
				arg_353_1.var_.moveOldPos1055ui_story = var_356_15.localPosition
			end

			local var_356_17 = 0.001

			if var_356_16 <= arg_353_1.time_ and arg_353_1.time_ < var_356_16 + var_356_17 then
				local var_356_18 = (arg_353_1.time_ - var_356_16) / var_356_17
				local var_356_19 = Vector3.New(0.7, -0.965, -6.2)

				var_356_15.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1055ui_story, var_356_19, var_356_18)

				local var_356_20 = manager.ui.mainCamera.transform.position - var_356_15.position

				var_356_15.forward = Vector3.New(var_356_20.x, var_356_20.y, var_356_20.z)

				local var_356_21 = var_356_15.localEulerAngles

				var_356_21.z = 0
				var_356_21.x = 0
				var_356_15.localEulerAngles = var_356_21
			end

			if arg_353_1.time_ >= var_356_16 + var_356_17 and arg_353_1.time_ < var_356_16 + var_356_17 + arg_356_0 then
				var_356_15.localPosition = Vector3.New(0.7, -0.965, -6.2)

				local var_356_22 = manager.ui.mainCamera.transform.position - var_356_15.position

				var_356_15.forward = Vector3.New(var_356_22.x, var_356_22.y, var_356_22.z)

				local var_356_23 = var_356_15.localEulerAngles

				var_356_23.z = 0
				var_356_23.x = 0
				var_356_15.localEulerAngles = var_356_23
			end

			local var_356_24 = arg_353_1.actors_["1055ui_story"]
			local var_356_25 = 0

			if var_356_25 < arg_353_1.time_ and arg_353_1.time_ <= var_356_25 + arg_356_0 and not isNil(var_356_24) and arg_353_1.var_.characterEffect1055ui_story == nil then
				arg_353_1.var_.characterEffect1055ui_story = var_356_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_26 = 0.200000002980232

			if var_356_25 <= arg_353_1.time_ and arg_353_1.time_ < var_356_25 + var_356_26 and not isNil(var_356_24) then
				local var_356_27 = (arg_353_1.time_ - var_356_25) / var_356_26

				if arg_353_1.var_.characterEffect1055ui_story and not isNil(var_356_24) then
					local var_356_28 = Mathf.Lerp(0, 0.5, var_356_27)

					arg_353_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1055ui_story.fillRatio = var_356_28
				end
			end

			if arg_353_1.time_ >= var_356_25 + var_356_26 and arg_353_1.time_ < var_356_25 + var_356_26 + arg_356_0 and not isNil(var_356_24) and arg_353_1.var_.characterEffect1055ui_story then
				local var_356_29 = 0.5

				arg_353_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1055ui_story.fillRatio = var_356_29
			end

			local var_356_30 = 0
			local var_356_31 = 0.225

			if var_356_30 < arg_353_1.time_ and arg_353_1.time_ <= var_356_30 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_32 = arg_353_1:FormatText(StoryNameCfg[73].name)

				arg_353_1.leftNameTxt_.text = var_356_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_33 = arg_353_1:GetWordFromCfg(123101088)
				local var_356_34 = arg_353_1:FormatText(var_356_33.content)

				arg_353_1.text_.text = var_356_34

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_35 = 9
				local var_356_36 = utf8.len(var_356_34)
				local var_356_37 = var_356_35 <= 0 and var_356_31 or var_356_31 * (var_356_36 / var_356_35)

				if var_356_37 > 0 and var_356_31 < var_356_37 then
					arg_353_1.talkMaxDuration = var_356_37

					if var_356_37 + var_356_30 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_37 + var_356_30
					end
				end

				arg_353_1.text_.text = var_356_34
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101088", "story_v_out_123101.awb") ~= 0 then
					local var_356_38 = manager.audio:GetVoiceLength("story_v_out_123101", "123101088", "story_v_out_123101.awb") / 1000

					if var_356_38 + var_356_30 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_38 + var_356_30
					end

					if var_356_33.prefab_name ~= "" and arg_353_1.actors_[var_356_33.prefab_name] ~= nil then
						local var_356_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_33.prefab_name].transform, "story_v_out_123101", "123101088", "story_v_out_123101.awb")

						arg_353_1:RecordAudio("123101088", var_356_39)
						arg_353_1:RecordAudio("123101088", var_356_39)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_123101", "123101088", "story_v_out_123101.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_123101", "123101088", "story_v_out_123101.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_40 = math.max(var_356_31, arg_353_1.talkMaxDuration)

			if var_356_30 <= arg_353_1.time_ and arg_353_1.time_ < var_356_30 + var_356_40 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_30) / var_356_40

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_30 + var_356_40 and arg_353_1.time_ < var_356_30 + var_356_40 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play123101089 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 123101089
		arg_357_1.duration_ = 6.17

		local var_357_0 = {
			zh = 3.9,
			ja = 6.166
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play123101090(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1055ui_story"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1055ui_story == nil then
				arg_357_1.var_.characterEffect1055ui_story = var_360_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.characterEffect1055ui_story and not isNil(var_360_0) then
					arg_357_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1055ui_story then
				arg_357_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_360_4 = 0

			if var_360_4 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_360_5 = 0

			if var_360_5 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 then
				arg_357_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_360_6 = arg_357_1.actors_["1093ui_story"]
			local var_360_7 = 0

			if var_360_7 < arg_357_1.time_ and arg_357_1.time_ <= var_360_7 + arg_360_0 and not isNil(var_360_6) and arg_357_1.var_.characterEffect1093ui_story == nil then
				arg_357_1.var_.characterEffect1093ui_story = var_360_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_8 = 0.200000002980232

			if var_360_7 <= arg_357_1.time_ and arg_357_1.time_ < var_360_7 + var_360_8 and not isNil(var_360_6) then
				local var_360_9 = (arg_357_1.time_ - var_360_7) / var_360_8

				if arg_357_1.var_.characterEffect1093ui_story and not isNil(var_360_6) then
					local var_360_10 = Mathf.Lerp(0, 0.5, var_360_9)

					arg_357_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1093ui_story.fillRatio = var_360_10
				end
			end

			if arg_357_1.time_ >= var_360_7 + var_360_8 and arg_357_1.time_ < var_360_7 + var_360_8 + arg_360_0 and not isNil(var_360_6) and arg_357_1.var_.characterEffect1093ui_story then
				local var_360_11 = 0.5

				arg_357_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1093ui_story.fillRatio = var_360_11
			end

			local var_360_12 = 0
			local var_360_13 = 0.425

			if var_360_12 < arg_357_1.time_ and arg_357_1.time_ <= var_360_12 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_14 = arg_357_1:FormatText(StoryNameCfg[481].name)

				arg_357_1.leftNameTxt_.text = var_360_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_15 = arg_357_1:GetWordFromCfg(123101089)
				local var_360_16 = arg_357_1:FormatText(var_360_15.content)

				arg_357_1.text_.text = var_360_16

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_17 = 17
				local var_360_18 = utf8.len(var_360_16)
				local var_360_19 = var_360_17 <= 0 and var_360_13 or var_360_13 * (var_360_18 / var_360_17)

				if var_360_19 > 0 and var_360_13 < var_360_19 then
					arg_357_1.talkMaxDuration = var_360_19

					if var_360_19 + var_360_12 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_19 + var_360_12
					end
				end

				arg_357_1.text_.text = var_360_16
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101089", "story_v_out_123101.awb") ~= 0 then
					local var_360_20 = manager.audio:GetVoiceLength("story_v_out_123101", "123101089", "story_v_out_123101.awb") / 1000

					if var_360_20 + var_360_12 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_20 + var_360_12
					end

					if var_360_15.prefab_name ~= "" and arg_357_1.actors_[var_360_15.prefab_name] ~= nil then
						local var_360_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_15.prefab_name].transform, "story_v_out_123101", "123101089", "story_v_out_123101.awb")

						arg_357_1:RecordAudio("123101089", var_360_21)
						arg_357_1:RecordAudio("123101089", var_360_21)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_123101", "123101089", "story_v_out_123101.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_123101", "123101089", "story_v_out_123101.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_22 = math.max(var_360_13, arg_357_1.talkMaxDuration)

			if var_360_12 <= arg_357_1.time_ and arg_357_1.time_ < var_360_12 + var_360_22 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_12) / var_360_22

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_12 + var_360_22 and arg_357_1.time_ < var_360_12 + var_360_22 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play123101090 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 123101090
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play123101091(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1055ui_story"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1055ui_story == nil then
				arg_361_1.var_.characterEffect1055ui_story = var_364_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.characterEffect1055ui_story and not isNil(var_364_0) then
					local var_364_4 = Mathf.Lerp(0, 0.5, var_364_3)

					arg_361_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1055ui_story.fillRatio = var_364_4
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1055ui_story then
				local var_364_5 = 0.5

				arg_361_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1055ui_story.fillRatio = var_364_5
			end

			local var_364_6 = arg_361_1.actors_["1055ui_story"].transform
			local var_364_7 = 0

			if var_364_7 < arg_361_1.time_ and arg_361_1.time_ <= var_364_7 + arg_364_0 then
				arg_361_1.var_.moveOldPos1055ui_story = var_364_6.localPosition
			end

			local var_364_8 = 0.001

			if var_364_7 <= arg_361_1.time_ and arg_361_1.time_ < var_364_7 + var_364_8 then
				local var_364_9 = (arg_361_1.time_ - var_364_7) / var_364_8
				local var_364_10 = Vector3.New(0, 100, 0)

				var_364_6.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1055ui_story, var_364_10, var_364_9)

				local var_364_11 = manager.ui.mainCamera.transform.position - var_364_6.position

				var_364_6.forward = Vector3.New(var_364_11.x, var_364_11.y, var_364_11.z)

				local var_364_12 = var_364_6.localEulerAngles

				var_364_12.z = 0
				var_364_12.x = 0
				var_364_6.localEulerAngles = var_364_12
			end

			if arg_361_1.time_ >= var_364_7 + var_364_8 and arg_361_1.time_ < var_364_7 + var_364_8 + arg_364_0 then
				var_364_6.localPosition = Vector3.New(0, 100, 0)

				local var_364_13 = manager.ui.mainCamera.transform.position - var_364_6.position

				var_364_6.forward = Vector3.New(var_364_13.x, var_364_13.y, var_364_13.z)

				local var_364_14 = var_364_6.localEulerAngles

				var_364_14.z = 0
				var_364_14.x = 0
				var_364_6.localEulerAngles = var_364_14
			end

			local var_364_15 = arg_361_1.actors_["1093ui_story"].transform
			local var_364_16 = 0

			if var_364_16 < arg_361_1.time_ and arg_361_1.time_ <= var_364_16 + arg_364_0 then
				arg_361_1.var_.moveOldPos1093ui_story = var_364_15.localPosition
			end

			local var_364_17 = 0.001

			if var_364_16 <= arg_361_1.time_ and arg_361_1.time_ < var_364_16 + var_364_17 then
				local var_364_18 = (arg_361_1.time_ - var_364_16) / var_364_17
				local var_364_19 = Vector3.New(0, 100, 0)

				var_364_15.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1093ui_story, var_364_19, var_364_18)

				local var_364_20 = manager.ui.mainCamera.transform.position - var_364_15.position

				var_364_15.forward = Vector3.New(var_364_20.x, var_364_20.y, var_364_20.z)

				local var_364_21 = var_364_15.localEulerAngles

				var_364_21.z = 0
				var_364_21.x = 0
				var_364_15.localEulerAngles = var_364_21
			end

			if arg_361_1.time_ >= var_364_16 + var_364_17 and arg_361_1.time_ < var_364_16 + var_364_17 + arg_364_0 then
				var_364_15.localPosition = Vector3.New(0, 100, 0)

				local var_364_22 = manager.ui.mainCamera.transform.position - var_364_15.position

				var_364_15.forward = Vector3.New(var_364_22.x, var_364_22.y, var_364_22.z)

				local var_364_23 = var_364_15.localEulerAngles

				var_364_23.z = 0
				var_364_23.x = 0
				var_364_15.localEulerAngles = var_364_23
			end

			local var_364_24 = 0
			local var_364_25 = 0.7

			if var_364_24 < arg_361_1.time_ and arg_361_1.time_ <= var_364_24 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_26 = arg_361_1:GetWordFromCfg(123101090)
				local var_364_27 = arg_361_1:FormatText(var_364_26.content)

				arg_361_1.text_.text = var_364_27

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_28 = 28
				local var_364_29 = utf8.len(var_364_27)
				local var_364_30 = var_364_28 <= 0 and var_364_25 or var_364_25 * (var_364_29 / var_364_28)

				if var_364_30 > 0 and var_364_25 < var_364_30 then
					arg_361_1.talkMaxDuration = var_364_30

					if var_364_30 + var_364_24 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_30 + var_364_24
					end
				end

				arg_361_1.text_.text = var_364_27
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_31 = math.max(var_364_25, arg_361_1.talkMaxDuration)

			if var_364_24 <= arg_361_1.time_ and arg_361_1.time_ < var_364_24 + var_364_31 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_24) / var_364_31

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_24 + var_364_31 and arg_361_1.time_ < var_364_24 + var_364_31 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play123101091 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 123101091
		arg_365_1.duration_ = 3.9

		local var_365_0 = {
			zh = 3.3,
			ja = 3.9
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play123101092(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1093ui_story"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1093ui_story == nil then
				arg_365_1.var_.characterEffect1093ui_story = var_368_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.characterEffect1093ui_story and not isNil(var_368_0) then
					arg_365_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1093ui_story then
				arg_365_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_368_4 = 0

			if var_368_4 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action3_1")
			end

			local var_368_5 = 0

			if var_368_5 < arg_365_1.time_ and arg_365_1.time_ <= var_368_5 + arg_368_0 then
				arg_365_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_368_6 = arg_365_1.actors_["1093ui_story"].transform
			local var_368_7 = 0

			if var_368_7 < arg_365_1.time_ and arg_365_1.time_ <= var_368_7 + arg_368_0 then
				arg_365_1.var_.moveOldPos1093ui_story = var_368_6.localPosition
			end

			local var_368_8 = 0.001

			if var_368_7 <= arg_365_1.time_ and arg_365_1.time_ < var_368_7 + var_368_8 then
				local var_368_9 = (arg_365_1.time_ - var_368_7) / var_368_8
				local var_368_10 = Vector3.New(0, -1.11, -5.88)

				var_368_6.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1093ui_story, var_368_10, var_368_9)

				local var_368_11 = manager.ui.mainCamera.transform.position - var_368_6.position

				var_368_6.forward = Vector3.New(var_368_11.x, var_368_11.y, var_368_11.z)

				local var_368_12 = var_368_6.localEulerAngles

				var_368_12.z = 0
				var_368_12.x = 0
				var_368_6.localEulerAngles = var_368_12
			end

			if arg_365_1.time_ >= var_368_7 + var_368_8 and arg_365_1.time_ < var_368_7 + var_368_8 + arg_368_0 then
				var_368_6.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_368_13 = manager.ui.mainCamera.transform.position - var_368_6.position

				var_368_6.forward = Vector3.New(var_368_13.x, var_368_13.y, var_368_13.z)

				local var_368_14 = var_368_6.localEulerAngles

				var_368_14.z = 0
				var_368_14.x = 0
				var_368_6.localEulerAngles = var_368_14
			end

			local var_368_15 = arg_365_1.actors_["1055ui_story"].transform
			local var_368_16 = 0

			if var_368_16 < arg_365_1.time_ and arg_365_1.time_ <= var_368_16 + arg_368_0 then
				arg_365_1.var_.moveOldPos1055ui_story = var_368_15.localPosition
			end

			local var_368_17 = 0.001

			if var_368_16 <= arg_365_1.time_ and arg_365_1.time_ < var_368_16 + var_368_17 then
				local var_368_18 = (arg_365_1.time_ - var_368_16) / var_368_17
				local var_368_19 = Vector3.New(0, 100, 0)

				var_368_15.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1055ui_story, var_368_19, var_368_18)

				local var_368_20 = manager.ui.mainCamera.transform.position - var_368_15.position

				var_368_15.forward = Vector3.New(var_368_20.x, var_368_20.y, var_368_20.z)

				local var_368_21 = var_368_15.localEulerAngles

				var_368_21.z = 0
				var_368_21.x = 0
				var_368_15.localEulerAngles = var_368_21
			end

			if arg_365_1.time_ >= var_368_16 + var_368_17 and arg_365_1.time_ < var_368_16 + var_368_17 + arg_368_0 then
				var_368_15.localPosition = Vector3.New(0, 100, 0)

				local var_368_22 = manager.ui.mainCamera.transform.position - var_368_15.position

				var_368_15.forward = Vector3.New(var_368_22.x, var_368_22.y, var_368_22.z)

				local var_368_23 = var_368_15.localEulerAngles

				var_368_23.z = 0
				var_368_23.x = 0
				var_368_15.localEulerAngles = var_368_23
			end

			local var_368_24 = 0
			local var_368_25 = 0.35

			if var_368_24 < arg_365_1.time_ and arg_365_1.time_ <= var_368_24 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_26 = arg_365_1:FormatText(StoryNameCfg[73].name)

				arg_365_1.leftNameTxt_.text = var_368_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_27 = arg_365_1:GetWordFromCfg(123101091)
				local var_368_28 = arg_365_1:FormatText(var_368_27.content)

				arg_365_1.text_.text = var_368_28

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_29 = 14
				local var_368_30 = utf8.len(var_368_28)
				local var_368_31 = var_368_29 <= 0 and var_368_25 or var_368_25 * (var_368_30 / var_368_29)

				if var_368_31 > 0 and var_368_25 < var_368_31 then
					arg_365_1.talkMaxDuration = var_368_31

					if var_368_31 + var_368_24 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_31 + var_368_24
					end
				end

				arg_365_1.text_.text = var_368_28
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101091", "story_v_out_123101.awb") ~= 0 then
					local var_368_32 = manager.audio:GetVoiceLength("story_v_out_123101", "123101091", "story_v_out_123101.awb") / 1000

					if var_368_32 + var_368_24 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_32 + var_368_24
					end

					if var_368_27.prefab_name ~= "" and arg_365_1.actors_[var_368_27.prefab_name] ~= nil then
						local var_368_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_27.prefab_name].transform, "story_v_out_123101", "123101091", "story_v_out_123101.awb")

						arg_365_1:RecordAudio("123101091", var_368_33)
						arg_365_1:RecordAudio("123101091", var_368_33)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_123101", "123101091", "story_v_out_123101.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_123101", "123101091", "story_v_out_123101.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_34 = math.max(var_368_25, arg_365_1.talkMaxDuration)

			if var_368_24 <= arg_365_1.time_ and arg_365_1.time_ < var_368_24 + var_368_34 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_24) / var_368_34

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_24 + var_368_34 and arg_365_1.time_ < var_368_24 + var_368_34 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play123101092 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 123101092
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play123101093(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1093ui_story"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1093ui_story == nil then
				arg_369_1.var_.characterEffect1093ui_story = var_372_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.characterEffect1093ui_story and not isNil(var_372_0) then
					local var_372_4 = Mathf.Lerp(0, 0.5, var_372_3)

					arg_369_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1093ui_story.fillRatio = var_372_4
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1093ui_story then
				local var_372_5 = 0.5

				arg_369_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1093ui_story.fillRatio = var_372_5
			end

			local var_372_6 = 0
			local var_372_7 = 1.15

			if var_372_6 < arg_369_1.time_ and arg_369_1.time_ <= var_372_6 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_8 = arg_369_1:FormatText(StoryNameCfg[7].name)

				arg_369_1.leftNameTxt_.text = var_372_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_9 = arg_369_1:GetWordFromCfg(123101092)
				local var_372_10 = arg_369_1:FormatText(var_372_9.content)

				arg_369_1.text_.text = var_372_10

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_11 = 46
				local var_372_12 = utf8.len(var_372_10)
				local var_372_13 = var_372_11 <= 0 and var_372_7 or var_372_7 * (var_372_12 / var_372_11)

				if var_372_13 > 0 and var_372_7 < var_372_13 then
					arg_369_1.talkMaxDuration = var_372_13

					if var_372_13 + var_372_6 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_13 + var_372_6
					end
				end

				arg_369_1.text_.text = var_372_10
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_14 = math.max(var_372_7, arg_369_1.talkMaxDuration)

			if var_372_6 <= arg_369_1.time_ and arg_369_1.time_ < var_372_6 + var_372_14 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_6) / var_372_14

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_6 + var_372_14 and arg_369_1.time_ < var_372_6 + var_372_14 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play123101093 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 123101093
		arg_373_1.duration_ = 9.53

		local var_373_0 = {
			zh = 9.533,
			ja = 8.966
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play123101094(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1093ui_story"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1093ui_story == nil then
				arg_373_1.var_.characterEffect1093ui_story = var_376_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.characterEffect1093ui_story and not isNil(var_376_0) then
					arg_373_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1093ui_story then
				arg_373_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_376_4 = 0

			if var_376_4 < arg_373_1.time_ and arg_373_1.time_ <= var_376_4 + arg_376_0 then
				arg_373_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_376_5 = 0
			local var_376_6 = 1.05

			if var_376_5 < arg_373_1.time_ and arg_373_1.time_ <= var_376_5 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_7 = arg_373_1:FormatText(StoryNameCfg[73].name)

				arg_373_1.leftNameTxt_.text = var_376_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_8 = arg_373_1:GetWordFromCfg(123101093)
				local var_376_9 = arg_373_1:FormatText(var_376_8.content)

				arg_373_1.text_.text = var_376_9

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_10 = 42
				local var_376_11 = utf8.len(var_376_9)
				local var_376_12 = var_376_10 <= 0 and var_376_6 or var_376_6 * (var_376_11 / var_376_10)

				if var_376_12 > 0 and var_376_6 < var_376_12 then
					arg_373_1.talkMaxDuration = var_376_12

					if var_376_12 + var_376_5 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_12 + var_376_5
					end
				end

				arg_373_1.text_.text = var_376_9
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101093", "story_v_out_123101.awb") ~= 0 then
					local var_376_13 = manager.audio:GetVoiceLength("story_v_out_123101", "123101093", "story_v_out_123101.awb") / 1000

					if var_376_13 + var_376_5 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_13 + var_376_5
					end

					if var_376_8.prefab_name ~= "" and arg_373_1.actors_[var_376_8.prefab_name] ~= nil then
						local var_376_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_8.prefab_name].transform, "story_v_out_123101", "123101093", "story_v_out_123101.awb")

						arg_373_1:RecordAudio("123101093", var_376_14)
						arg_373_1:RecordAudio("123101093", var_376_14)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_123101", "123101093", "story_v_out_123101.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_123101", "123101093", "story_v_out_123101.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_15 = math.max(var_376_6, arg_373_1.talkMaxDuration)

			if var_376_5 <= arg_373_1.time_ and arg_373_1.time_ < var_376_5 + var_376_15 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_5) / var_376_15

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_5 + var_376_15 and arg_373_1.time_ < var_376_5 + var_376_15 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play123101094 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 123101094
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play123101095(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1093ui_story"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1093ui_story == nil then
				arg_377_1.var_.characterEffect1093ui_story = var_380_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.characterEffect1093ui_story and not isNil(var_380_0) then
					local var_380_4 = Mathf.Lerp(0, 0.5, var_380_3)

					arg_377_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1093ui_story.fillRatio = var_380_4
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1093ui_story then
				local var_380_5 = 0.5

				arg_377_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1093ui_story.fillRatio = var_380_5
			end

			local var_380_6 = 0
			local var_380_7 = 1.15

			if var_380_6 < arg_377_1.time_ and arg_377_1.time_ <= var_380_6 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_8 = arg_377_1:FormatText(StoryNameCfg[7].name)

				arg_377_1.leftNameTxt_.text = var_380_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_9 = arg_377_1:GetWordFromCfg(123101094)
				local var_380_10 = arg_377_1:FormatText(var_380_9.content)

				arg_377_1.text_.text = var_380_10

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_11 = 46
				local var_380_12 = utf8.len(var_380_10)
				local var_380_13 = var_380_11 <= 0 and var_380_7 or var_380_7 * (var_380_12 / var_380_11)

				if var_380_13 > 0 and var_380_7 < var_380_13 then
					arg_377_1.talkMaxDuration = var_380_13

					if var_380_13 + var_380_6 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_13 + var_380_6
					end
				end

				arg_377_1.text_.text = var_380_10
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_14 = math.max(var_380_7, arg_377_1.talkMaxDuration)

			if var_380_6 <= arg_377_1.time_ and arg_377_1.time_ < var_380_6 + var_380_14 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_6) / var_380_14

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_6 + var_380_14 and arg_377_1.time_ < var_380_6 + var_380_14 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play123101095 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 123101095
		arg_381_1.duration_ = 2.3

		local var_381_0 = {
			zh = 1.999999999999,
			ja = 2.3
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play123101096(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1093ui_story"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1093ui_story == nil then
				arg_381_1.var_.characterEffect1093ui_story = var_384_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 and not isNil(var_384_0) then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2

				if arg_381_1.var_.characterEffect1093ui_story and not isNil(var_384_0) then
					arg_381_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1093ui_story then
				arg_381_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_384_4 = 0

			if var_384_4 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action3_2")
			end

			local var_384_5 = 0

			if var_384_5 < arg_381_1.time_ and arg_381_1.time_ <= var_384_5 + arg_384_0 then
				arg_381_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_384_6 = 0
			local var_384_7 = 0.125

			if var_384_6 < arg_381_1.time_ and arg_381_1.time_ <= var_384_6 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_8 = arg_381_1:FormatText(StoryNameCfg[73].name)

				arg_381_1.leftNameTxt_.text = var_384_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_9 = arg_381_1:GetWordFromCfg(123101095)
				local var_384_10 = arg_381_1:FormatText(var_384_9.content)

				arg_381_1.text_.text = var_384_10

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_11 = 5
				local var_384_12 = utf8.len(var_384_10)
				local var_384_13 = var_384_11 <= 0 and var_384_7 or var_384_7 * (var_384_12 / var_384_11)

				if var_384_13 > 0 and var_384_7 < var_384_13 then
					arg_381_1.talkMaxDuration = var_384_13

					if var_384_13 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_13 + var_384_6
					end
				end

				arg_381_1.text_.text = var_384_10
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101095", "story_v_out_123101.awb") ~= 0 then
					local var_384_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101095", "story_v_out_123101.awb") / 1000

					if var_384_14 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_14 + var_384_6
					end

					if var_384_9.prefab_name ~= "" and arg_381_1.actors_[var_384_9.prefab_name] ~= nil then
						local var_384_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_9.prefab_name].transform, "story_v_out_123101", "123101095", "story_v_out_123101.awb")

						arg_381_1:RecordAudio("123101095", var_384_15)
						arg_381_1:RecordAudio("123101095", var_384_15)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_123101", "123101095", "story_v_out_123101.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_123101", "123101095", "story_v_out_123101.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_16 = math.max(var_384_7, arg_381_1.talkMaxDuration)

			if var_384_6 <= arg_381_1.time_ and arg_381_1.time_ < var_384_6 + var_384_16 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_6) / var_384_16

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_6 + var_384_16 and arg_381_1.time_ < var_384_6 + var_384_16 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play123101096 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 123101096
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play123101097(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1093ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1093ui_story == nil then
				arg_385_1.var_.characterEffect1093ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect1093ui_story and not isNil(var_388_0) then
					local var_388_4 = Mathf.Lerp(0, 0.5, var_388_3)

					arg_385_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1093ui_story.fillRatio = var_388_4
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1093ui_story then
				local var_388_5 = 0.5

				arg_385_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1093ui_story.fillRatio = var_388_5
			end

			local var_388_6 = 0
			local var_388_7 = 1.075

			if var_388_6 < arg_385_1.time_ and arg_385_1.time_ <= var_388_6 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_8 = arg_385_1:FormatText(StoryNameCfg[7].name)

				arg_385_1.leftNameTxt_.text = var_388_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_9 = arg_385_1:GetWordFromCfg(123101096)
				local var_388_10 = arg_385_1:FormatText(var_388_9.content)

				arg_385_1.text_.text = var_388_10

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_11 = 43
				local var_388_12 = utf8.len(var_388_10)
				local var_388_13 = var_388_11 <= 0 and var_388_7 or var_388_7 * (var_388_12 / var_388_11)

				if var_388_13 > 0 and var_388_7 < var_388_13 then
					arg_385_1.talkMaxDuration = var_388_13

					if var_388_13 + var_388_6 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_13 + var_388_6
					end
				end

				arg_385_1.text_.text = var_388_10
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_14 = math.max(var_388_7, arg_385_1.talkMaxDuration)

			if var_388_6 <= arg_385_1.time_ and arg_385_1.time_ < var_388_6 + var_388_14 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_6) / var_388_14

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_6 + var_388_14 and arg_385_1.time_ < var_388_6 + var_388_14 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play123101097 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 123101097
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play123101098(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 0.625

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_2 = arg_389_1:GetWordFromCfg(123101097)
				local var_392_3 = arg_389_1:FormatText(var_392_2.content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 25
				local var_392_5 = utf8.len(var_392_3)
				local var_392_6 = var_392_4 <= 0 and var_392_1 or var_392_1 * (var_392_5 / var_392_4)

				if var_392_6 > 0 and var_392_1 < var_392_6 then
					arg_389_1.talkMaxDuration = var_392_6

					if var_392_6 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_6 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_3
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_7 and arg_389_1.time_ < var_392_0 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play123101098 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 123101098
		arg_393_1.duration_ = 5.83

		local var_393_0 = {
			zh = 5.2,
			ja = 5.833
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play123101099(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1093ui_story"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1093ui_story == nil then
				arg_393_1.var_.characterEffect1093ui_story = var_396_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.characterEffect1093ui_story and not isNil(var_396_0) then
					arg_393_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1093ui_story then
				arg_393_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_396_4 = 0

			if var_396_4 < arg_393_1.time_ and arg_393_1.time_ <= var_396_4 + arg_396_0 then
				arg_393_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_396_5 = 0

			if var_396_5 < arg_393_1.time_ and arg_393_1.time_ <= var_396_5 + arg_396_0 then
				arg_393_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_396_6 = 0
			local var_396_7 = 0.65

			if var_396_6 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_8 = arg_393_1:FormatText(StoryNameCfg[73].name)

				arg_393_1.leftNameTxt_.text = var_396_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_9 = arg_393_1:GetWordFromCfg(123101098)
				local var_396_10 = arg_393_1:FormatText(var_396_9.content)

				arg_393_1.text_.text = var_396_10

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_11 = 26
				local var_396_12 = utf8.len(var_396_10)
				local var_396_13 = var_396_11 <= 0 and var_396_7 or var_396_7 * (var_396_12 / var_396_11)

				if var_396_13 > 0 and var_396_7 < var_396_13 then
					arg_393_1.talkMaxDuration = var_396_13

					if var_396_13 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_13 + var_396_6
					end
				end

				arg_393_1.text_.text = var_396_10
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101098", "story_v_out_123101.awb") ~= 0 then
					local var_396_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101098", "story_v_out_123101.awb") / 1000

					if var_396_14 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_14 + var_396_6
					end

					if var_396_9.prefab_name ~= "" and arg_393_1.actors_[var_396_9.prefab_name] ~= nil then
						local var_396_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_9.prefab_name].transform, "story_v_out_123101", "123101098", "story_v_out_123101.awb")

						arg_393_1:RecordAudio("123101098", var_396_15)
						arg_393_1:RecordAudio("123101098", var_396_15)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_123101", "123101098", "story_v_out_123101.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_123101", "123101098", "story_v_out_123101.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_16 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_16 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_16

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_16 and arg_393_1.time_ < var_396_6 + var_396_16 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play123101099 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 123101099
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play123101100(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1093ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1093ui_story == nil then
				arg_397_1.var_.characterEffect1093ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1093ui_story and not isNil(var_400_0) then
					local var_400_4 = Mathf.Lerp(0, 0.5, var_400_3)

					arg_397_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1093ui_story.fillRatio = var_400_4
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1093ui_story then
				local var_400_5 = 0.5

				arg_397_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1093ui_story.fillRatio = var_400_5
			end

			local var_400_6 = 0
			local var_400_7 = 1

			if var_400_6 < arg_397_1.time_ and arg_397_1.time_ <= var_400_6 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_8 = arg_397_1:GetWordFromCfg(123101099)
				local var_400_9 = arg_397_1:FormatText(var_400_8.content)

				arg_397_1.text_.text = var_400_9

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_10 = 40
				local var_400_11 = utf8.len(var_400_9)
				local var_400_12 = var_400_10 <= 0 and var_400_7 or var_400_7 * (var_400_11 / var_400_10)

				if var_400_12 > 0 and var_400_7 < var_400_12 then
					arg_397_1.talkMaxDuration = var_400_12

					if var_400_12 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_12 + var_400_6
					end
				end

				arg_397_1.text_.text = var_400_9
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_13 = math.max(var_400_7, arg_397_1.talkMaxDuration)

			if var_400_6 <= arg_397_1.time_ and arg_397_1.time_ < var_400_6 + var_400_13 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_6) / var_400_13

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_6 + var_400_13 and arg_397_1.time_ < var_400_6 + var_400_13 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play123101100 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 123101100
		arg_401_1.duration_ = 8

		local var_401_0 = {
			zh = 5.2,
			ja = 8
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play123101101(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1055ui_story"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos1055ui_story = var_404_0.localPosition
			end

			local var_404_2 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2
				local var_404_4 = Vector3.New(0, -0.965, -6.2)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1055ui_story, var_404_4, var_404_3)

				local var_404_5 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_5.x, var_404_5.y, var_404_5.z)

				local var_404_6 = var_404_0.localEulerAngles

				var_404_6.z = 0
				var_404_6.x = 0
				var_404_0.localEulerAngles = var_404_6
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_404_7 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_7.x, var_404_7.y, var_404_7.z)

				local var_404_8 = var_404_0.localEulerAngles

				var_404_8.z = 0
				var_404_8.x = 0
				var_404_0.localEulerAngles = var_404_8
			end

			local var_404_9 = arg_401_1.actors_["1055ui_story"]
			local var_404_10 = 0

			if var_404_10 < arg_401_1.time_ and arg_401_1.time_ <= var_404_10 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect1055ui_story == nil then
				arg_401_1.var_.characterEffect1055ui_story = var_404_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_11 = 0.200000002980232

			if var_404_10 <= arg_401_1.time_ and arg_401_1.time_ < var_404_10 + var_404_11 and not isNil(var_404_9) then
				local var_404_12 = (arg_401_1.time_ - var_404_10) / var_404_11

				if arg_401_1.var_.characterEffect1055ui_story and not isNil(var_404_9) then
					arg_401_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= var_404_10 + var_404_11 and arg_401_1.time_ < var_404_10 + var_404_11 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect1055ui_story then
				arg_401_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_404_13 = 0

			if var_404_13 < arg_401_1.time_ and arg_401_1.time_ <= var_404_13 + arg_404_0 then
				arg_401_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_404_14 = 0

			if var_404_14 < arg_401_1.time_ and arg_401_1.time_ <= var_404_14 + arg_404_0 then
				arg_401_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_404_15 = arg_401_1.actors_["1093ui_story"].transform
			local var_404_16 = 0

			if var_404_16 < arg_401_1.time_ and arg_401_1.time_ <= var_404_16 + arg_404_0 then
				arg_401_1.var_.moveOldPos1093ui_story = var_404_15.localPosition
			end

			local var_404_17 = 0.001

			if var_404_16 <= arg_401_1.time_ and arg_401_1.time_ < var_404_16 + var_404_17 then
				local var_404_18 = (arg_401_1.time_ - var_404_16) / var_404_17
				local var_404_19 = Vector3.New(0, 100, 0)

				var_404_15.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1093ui_story, var_404_19, var_404_18)

				local var_404_20 = manager.ui.mainCamera.transform.position - var_404_15.position

				var_404_15.forward = Vector3.New(var_404_20.x, var_404_20.y, var_404_20.z)

				local var_404_21 = var_404_15.localEulerAngles

				var_404_21.z = 0
				var_404_21.x = 0
				var_404_15.localEulerAngles = var_404_21
			end

			if arg_401_1.time_ >= var_404_16 + var_404_17 and arg_401_1.time_ < var_404_16 + var_404_17 + arg_404_0 then
				var_404_15.localPosition = Vector3.New(0, 100, 0)

				local var_404_22 = manager.ui.mainCamera.transform.position - var_404_15.position

				var_404_15.forward = Vector3.New(var_404_22.x, var_404_22.y, var_404_22.z)

				local var_404_23 = var_404_15.localEulerAngles

				var_404_23.z = 0
				var_404_23.x = 0
				var_404_15.localEulerAngles = var_404_23
			end

			local var_404_24 = 0
			local var_404_25 = 0.6

			if var_404_24 < arg_401_1.time_ and arg_401_1.time_ <= var_404_24 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_26 = arg_401_1:FormatText(StoryNameCfg[481].name)

				arg_401_1.leftNameTxt_.text = var_404_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_27 = arg_401_1:GetWordFromCfg(123101100)
				local var_404_28 = arg_401_1:FormatText(var_404_27.content)

				arg_401_1.text_.text = var_404_28

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_29 = 24
				local var_404_30 = utf8.len(var_404_28)
				local var_404_31 = var_404_29 <= 0 and var_404_25 or var_404_25 * (var_404_30 / var_404_29)

				if var_404_31 > 0 and var_404_25 < var_404_31 then
					arg_401_1.talkMaxDuration = var_404_31

					if var_404_31 + var_404_24 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_31 + var_404_24
					end
				end

				arg_401_1.text_.text = var_404_28
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101100", "story_v_out_123101.awb") ~= 0 then
					local var_404_32 = manager.audio:GetVoiceLength("story_v_out_123101", "123101100", "story_v_out_123101.awb") / 1000

					if var_404_32 + var_404_24 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_32 + var_404_24
					end

					if var_404_27.prefab_name ~= "" and arg_401_1.actors_[var_404_27.prefab_name] ~= nil then
						local var_404_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_27.prefab_name].transform, "story_v_out_123101", "123101100", "story_v_out_123101.awb")

						arg_401_1:RecordAudio("123101100", var_404_33)
						arg_401_1:RecordAudio("123101100", var_404_33)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_123101", "123101100", "story_v_out_123101.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_123101", "123101100", "story_v_out_123101.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_34 = math.max(var_404_25, arg_401_1.talkMaxDuration)

			if var_404_24 <= arg_401_1.time_ and arg_401_1.time_ < var_404_24 + var_404_34 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_24) / var_404_34

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_24 + var_404_34 and arg_401_1.time_ < var_404_24 + var_404_34 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play123101101 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 123101101
		arg_405_1.duration_ = 3.7

		local var_405_0 = {
			zh = 3.366,
			ja = 3.7
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play123101102(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1093ui_story"].transform
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.var_.moveOldPos1093ui_story = var_408_0.localPosition
			end

			local var_408_2 = 0.001

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2
				local var_408_4 = Vector3.New(0, -1.11, -5.88)

				var_408_0.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1093ui_story, var_408_4, var_408_3)

				local var_408_5 = manager.ui.mainCamera.transform.position - var_408_0.position

				var_408_0.forward = Vector3.New(var_408_5.x, var_408_5.y, var_408_5.z)

				local var_408_6 = var_408_0.localEulerAngles

				var_408_6.z = 0
				var_408_6.x = 0
				var_408_0.localEulerAngles = var_408_6
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 then
				var_408_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_408_7 = manager.ui.mainCamera.transform.position - var_408_0.position

				var_408_0.forward = Vector3.New(var_408_7.x, var_408_7.y, var_408_7.z)

				local var_408_8 = var_408_0.localEulerAngles

				var_408_8.z = 0
				var_408_8.x = 0
				var_408_0.localEulerAngles = var_408_8
			end

			local var_408_9 = arg_405_1.actors_["1093ui_story"]
			local var_408_10 = 0

			if var_408_10 < arg_405_1.time_ and arg_405_1.time_ <= var_408_10 + arg_408_0 and not isNil(var_408_9) and arg_405_1.var_.characterEffect1093ui_story == nil then
				arg_405_1.var_.characterEffect1093ui_story = var_408_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_11 = 0.200000002980232

			if var_408_10 <= arg_405_1.time_ and arg_405_1.time_ < var_408_10 + var_408_11 and not isNil(var_408_9) then
				local var_408_12 = (arg_405_1.time_ - var_408_10) / var_408_11

				if arg_405_1.var_.characterEffect1093ui_story and not isNil(var_408_9) then
					arg_405_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= var_408_10 + var_408_11 and arg_405_1.time_ < var_408_10 + var_408_11 + arg_408_0 and not isNil(var_408_9) and arg_405_1.var_.characterEffect1093ui_story then
				arg_405_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_408_13 = 0

			if var_408_13 < arg_405_1.time_ and arg_405_1.time_ <= var_408_13 + arg_408_0 then
				arg_405_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			local var_408_14 = 0

			if var_408_14 < arg_405_1.time_ and arg_405_1.time_ <= var_408_14 + arg_408_0 then
				arg_405_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_408_15 = arg_405_1.actors_["1055ui_story"]
			local var_408_16 = 0

			if var_408_16 < arg_405_1.time_ and arg_405_1.time_ <= var_408_16 + arg_408_0 and not isNil(var_408_15) and arg_405_1.var_.characterEffect1055ui_story == nil then
				arg_405_1.var_.characterEffect1055ui_story = var_408_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_17 = 0.200000002980232

			if var_408_16 <= arg_405_1.time_ and arg_405_1.time_ < var_408_16 + var_408_17 and not isNil(var_408_15) then
				local var_408_18 = (arg_405_1.time_ - var_408_16) / var_408_17

				if arg_405_1.var_.characterEffect1055ui_story and not isNil(var_408_15) then
					local var_408_19 = Mathf.Lerp(0, 0.5, var_408_18)

					arg_405_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1055ui_story.fillRatio = var_408_19
				end
			end

			if arg_405_1.time_ >= var_408_16 + var_408_17 and arg_405_1.time_ < var_408_16 + var_408_17 + arg_408_0 and not isNil(var_408_15) and arg_405_1.var_.characterEffect1055ui_story then
				local var_408_20 = 0.5

				arg_405_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1055ui_story.fillRatio = var_408_20
			end

			local var_408_21 = arg_405_1.actors_["1055ui_story"].transform
			local var_408_22 = 0

			if var_408_22 < arg_405_1.time_ and arg_405_1.time_ <= var_408_22 + arg_408_0 then
				arg_405_1.var_.moveOldPos1055ui_story = var_408_21.localPosition
			end

			local var_408_23 = 0.001

			if var_408_22 <= arg_405_1.time_ and arg_405_1.time_ < var_408_22 + var_408_23 then
				local var_408_24 = (arg_405_1.time_ - var_408_22) / var_408_23
				local var_408_25 = Vector3.New(0, 100, 0)

				var_408_21.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1055ui_story, var_408_25, var_408_24)

				local var_408_26 = manager.ui.mainCamera.transform.position - var_408_21.position

				var_408_21.forward = Vector3.New(var_408_26.x, var_408_26.y, var_408_26.z)

				local var_408_27 = var_408_21.localEulerAngles

				var_408_27.z = 0
				var_408_27.x = 0
				var_408_21.localEulerAngles = var_408_27
			end

			if arg_405_1.time_ >= var_408_22 + var_408_23 and arg_405_1.time_ < var_408_22 + var_408_23 + arg_408_0 then
				var_408_21.localPosition = Vector3.New(0, 100, 0)

				local var_408_28 = manager.ui.mainCamera.transform.position - var_408_21.position

				var_408_21.forward = Vector3.New(var_408_28.x, var_408_28.y, var_408_28.z)

				local var_408_29 = var_408_21.localEulerAngles

				var_408_29.z = 0
				var_408_29.x = 0
				var_408_21.localEulerAngles = var_408_29
			end

			local var_408_30 = 0
			local var_408_31 = 0.4

			if var_408_30 < arg_405_1.time_ and arg_405_1.time_ <= var_408_30 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_32 = arg_405_1:FormatText(StoryNameCfg[73].name)

				arg_405_1.leftNameTxt_.text = var_408_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_33 = arg_405_1:GetWordFromCfg(123101101)
				local var_408_34 = arg_405_1:FormatText(var_408_33.content)

				arg_405_1.text_.text = var_408_34

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_35 = 16
				local var_408_36 = utf8.len(var_408_34)
				local var_408_37 = var_408_35 <= 0 and var_408_31 or var_408_31 * (var_408_36 / var_408_35)

				if var_408_37 > 0 and var_408_31 < var_408_37 then
					arg_405_1.talkMaxDuration = var_408_37

					if var_408_37 + var_408_30 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_37 + var_408_30
					end
				end

				arg_405_1.text_.text = var_408_34
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101101", "story_v_out_123101.awb") ~= 0 then
					local var_408_38 = manager.audio:GetVoiceLength("story_v_out_123101", "123101101", "story_v_out_123101.awb") / 1000

					if var_408_38 + var_408_30 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_38 + var_408_30
					end

					if var_408_33.prefab_name ~= "" and arg_405_1.actors_[var_408_33.prefab_name] ~= nil then
						local var_408_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_33.prefab_name].transform, "story_v_out_123101", "123101101", "story_v_out_123101.awb")

						arg_405_1:RecordAudio("123101101", var_408_39)
						arg_405_1:RecordAudio("123101101", var_408_39)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_123101", "123101101", "story_v_out_123101.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_123101", "123101101", "story_v_out_123101.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_40 = math.max(var_408_31, arg_405_1.talkMaxDuration)

			if var_408_30 <= arg_405_1.time_ and arg_405_1.time_ < var_408_30 + var_408_40 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_30) / var_408_40

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_30 + var_408_40 and arg_405_1.time_ < var_408_30 + var_408_40 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play123101102 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 123101102
		arg_409_1.duration_ = 10.1

		local var_409_0 = {
			zh = 6.766,
			ja = 10.1
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play123101103(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1093ui_story"]
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect1093ui_story == nil then
				arg_409_1.var_.characterEffect1093ui_story = var_412_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.200000002980232

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 and not isNil(var_412_0) then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2

				if arg_409_1.var_.characterEffect1093ui_story and not isNil(var_412_0) then
					local var_412_4 = Mathf.Lerp(0, 0.5, var_412_3)

					arg_409_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1093ui_story.fillRatio = var_412_4
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect1093ui_story then
				local var_412_5 = 0.5

				arg_409_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1093ui_story.fillRatio = var_412_5
			end

			local var_412_6 = arg_409_1.actors_["1093ui_story"].transform
			local var_412_7 = 0

			if var_412_7 < arg_409_1.time_ and arg_409_1.time_ <= var_412_7 + arg_412_0 then
				arg_409_1.var_.moveOldPos1093ui_story = var_412_6.localPosition
			end

			local var_412_8 = 0.001

			if var_412_7 <= arg_409_1.time_ and arg_409_1.time_ < var_412_7 + var_412_8 then
				local var_412_9 = (arg_409_1.time_ - var_412_7) / var_412_8
				local var_412_10 = Vector3.New(0, 100, 0)

				var_412_6.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1093ui_story, var_412_10, var_412_9)

				local var_412_11 = manager.ui.mainCamera.transform.position - var_412_6.position

				var_412_6.forward = Vector3.New(var_412_11.x, var_412_11.y, var_412_11.z)

				local var_412_12 = var_412_6.localEulerAngles

				var_412_12.z = 0
				var_412_12.x = 0
				var_412_6.localEulerAngles = var_412_12
			end

			if arg_409_1.time_ >= var_412_7 + var_412_8 and arg_409_1.time_ < var_412_7 + var_412_8 + arg_412_0 then
				var_412_6.localPosition = Vector3.New(0, 100, 0)

				local var_412_13 = manager.ui.mainCamera.transform.position - var_412_6.position

				var_412_6.forward = Vector3.New(var_412_13.x, var_412_13.y, var_412_13.z)

				local var_412_14 = var_412_6.localEulerAngles

				var_412_14.z = 0
				var_412_14.x = 0
				var_412_6.localEulerAngles = var_412_14
			end

			local var_412_15 = 0
			local var_412_16 = 0.525

			if var_412_15 < arg_409_1.time_ and arg_409_1.time_ <= var_412_15 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_17 = arg_409_1:FormatText(StoryNameCfg[485].name)

				arg_409_1.leftNameTxt_.text = var_412_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_18 = arg_409_1:GetWordFromCfg(123101102)
				local var_412_19 = arg_409_1:FormatText(var_412_18.content)

				arg_409_1.text_.text = var_412_19

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_20 = 21
				local var_412_21 = utf8.len(var_412_19)
				local var_412_22 = var_412_20 <= 0 and var_412_16 or var_412_16 * (var_412_21 / var_412_20)

				if var_412_22 > 0 and var_412_16 < var_412_22 then
					arg_409_1.talkMaxDuration = var_412_22

					if var_412_22 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_22 + var_412_15
					end
				end

				arg_409_1.text_.text = var_412_19
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101102", "story_v_out_123101.awb") ~= 0 then
					local var_412_23 = manager.audio:GetVoiceLength("story_v_out_123101", "123101102", "story_v_out_123101.awb") / 1000

					if var_412_23 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_23 + var_412_15
					end

					if var_412_18.prefab_name ~= "" and arg_409_1.actors_[var_412_18.prefab_name] ~= nil then
						local var_412_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_18.prefab_name].transform, "story_v_out_123101", "123101102", "story_v_out_123101.awb")

						arg_409_1:RecordAudio("123101102", var_412_24)
						arg_409_1:RecordAudio("123101102", var_412_24)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_123101", "123101102", "story_v_out_123101.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_123101", "123101102", "story_v_out_123101.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_25 = math.max(var_412_16, arg_409_1.talkMaxDuration)

			if var_412_15 <= arg_409_1.time_ and arg_409_1.time_ < var_412_15 + var_412_25 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_15) / var_412_25

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_15 + var_412_25 and arg_409_1.time_ < var_412_15 + var_412_25 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play123101103 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 123101103
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play123101104(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0
			local var_416_1 = 0.8

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_2 = arg_413_1:GetWordFromCfg(123101103)
				local var_416_3 = arg_413_1:FormatText(var_416_2.content)

				arg_413_1.text_.text = var_416_3

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_4 = 32
				local var_416_5 = utf8.len(var_416_3)
				local var_416_6 = var_416_4 <= 0 and var_416_1 or var_416_1 * (var_416_5 / var_416_4)

				if var_416_6 > 0 and var_416_1 < var_416_6 then
					arg_413_1.talkMaxDuration = var_416_6

					if var_416_6 + var_416_0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_6 + var_416_0
					end
				end

				arg_413_1.text_.text = var_416_3
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_7 = math.max(var_416_1, arg_413_1.talkMaxDuration)

			if var_416_0 <= arg_413_1.time_ and arg_413_1.time_ < var_416_0 + var_416_7 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_0) / var_416_7

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_0 + var_416_7 and arg_413_1.time_ < var_416_0 + var_416_7 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play123101104 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 123101104
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play123101105(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0
			local var_420_1 = 0.525

			if var_420_0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_2 = arg_417_1:FormatText(StoryNameCfg[7].name)

				arg_417_1.leftNameTxt_.text = var_420_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:GetWordFromCfg(123101104)
				local var_420_4 = arg_417_1:FormatText(var_420_3.content)

				arg_417_1.text_.text = var_420_4

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 21
				local var_420_6 = utf8.len(var_420_4)
				local var_420_7 = var_420_5 <= 0 and var_420_1 or var_420_1 * (var_420_6 / var_420_5)

				if var_420_7 > 0 and var_420_1 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_0
					end
				end

				arg_417_1.text_.text = var_420_4
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_8 = math.max(var_420_1, arg_417_1.talkMaxDuration)

			if var_420_0 <= arg_417_1.time_ and arg_417_1.time_ < var_420_0 + var_420_8 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_0) / var_420_8

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_0 + var_420_8 and arg_417_1.time_ < var_420_0 + var_420_8 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play123101105 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 123101105
		arg_421_1.duration_ = 10.07

		local var_421_0 = {
			zh = 5.533,
			ja = 10.066
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
				arg_421_0:Play123101106(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1055ui_story"].transform
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.var_.moveOldPos1055ui_story = var_424_0.localPosition
			end

			local var_424_2 = 0.001

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2
				local var_424_4 = Vector3.New(0, -0.965, -6.2)

				var_424_0.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1055ui_story, var_424_4, var_424_3)

				local var_424_5 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_5.x, var_424_5.y, var_424_5.z)

				local var_424_6 = var_424_0.localEulerAngles

				var_424_6.z = 0
				var_424_6.x = 0
				var_424_0.localEulerAngles = var_424_6
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 then
				var_424_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_424_7 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_7.x, var_424_7.y, var_424_7.z)

				local var_424_8 = var_424_0.localEulerAngles

				var_424_8.z = 0
				var_424_8.x = 0
				var_424_0.localEulerAngles = var_424_8
			end

			local var_424_9 = arg_421_1.actors_["1055ui_story"]
			local var_424_10 = 0

			if var_424_10 < arg_421_1.time_ and arg_421_1.time_ <= var_424_10 + arg_424_0 and not isNil(var_424_9) and arg_421_1.var_.characterEffect1055ui_story == nil then
				arg_421_1.var_.characterEffect1055ui_story = var_424_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_11 = 0.200000002980232

			if var_424_10 <= arg_421_1.time_ and arg_421_1.time_ < var_424_10 + var_424_11 and not isNil(var_424_9) then
				local var_424_12 = (arg_421_1.time_ - var_424_10) / var_424_11

				if arg_421_1.var_.characterEffect1055ui_story and not isNil(var_424_9) then
					arg_421_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= var_424_10 + var_424_11 and arg_421_1.time_ < var_424_10 + var_424_11 + arg_424_0 and not isNil(var_424_9) and arg_421_1.var_.characterEffect1055ui_story then
				arg_421_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_424_13 = 0

			if var_424_13 < arg_421_1.time_ and arg_421_1.time_ <= var_424_13 + arg_424_0 then
				arg_421_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			local var_424_14 = 0

			if var_424_14 < arg_421_1.time_ and arg_421_1.time_ <= var_424_14 + arg_424_0 then
				arg_421_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_424_15 = 0
			local var_424_16 = 0.575

			if var_424_15 < arg_421_1.time_ and arg_421_1.time_ <= var_424_15 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_17 = arg_421_1:FormatText(StoryNameCfg[481].name)

				arg_421_1.leftNameTxt_.text = var_424_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_18 = arg_421_1:GetWordFromCfg(123101105)
				local var_424_19 = arg_421_1:FormatText(var_424_18.content)

				arg_421_1.text_.text = var_424_19

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_20 = 23
				local var_424_21 = utf8.len(var_424_19)
				local var_424_22 = var_424_20 <= 0 and var_424_16 or var_424_16 * (var_424_21 / var_424_20)

				if var_424_22 > 0 and var_424_16 < var_424_22 then
					arg_421_1.talkMaxDuration = var_424_22

					if var_424_22 + var_424_15 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_22 + var_424_15
					end
				end

				arg_421_1.text_.text = var_424_19
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101105", "story_v_out_123101.awb") ~= 0 then
					local var_424_23 = manager.audio:GetVoiceLength("story_v_out_123101", "123101105", "story_v_out_123101.awb") / 1000

					if var_424_23 + var_424_15 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_23 + var_424_15
					end

					if var_424_18.prefab_name ~= "" and arg_421_1.actors_[var_424_18.prefab_name] ~= nil then
						local var_424_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_18.prefab_name].transform, "story_v_out_123101", "123101105", "story_v_out_123101.awb")

						arg_421_1:RecordAudio("123101105", var_424_24)
						arg_421_1:RecordAudio("123101105", var_424_24)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_123101", "123101105", "story_v_out_123101.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_123101", "123101105", "story_v_out_123101.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_25 = math.max(var_424_16, arg_421_1.talkMaxDuration)

			if var_424_15 <= arg_421_1.time_ and arg_421_1.time_ < var_424_15 + var_424_25 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_15) / var_424_25

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_15 + var_424_25 and arg_421_1.time_ < var_424_15 + var_424_25 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123101106 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 123101106
		arg_425_1.duration_ = 1.2

		local var_425_0 = {
			zh = 0.999999999999,
			ja = 1.2
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play123101107(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1055ui_story"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1055ui_story == nil then
				arg_425_1.var_.characterEffect1055ui_story = var_428_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.characterEffect1055ui_story and not isNil(var_428_0) then
					local var_428_4 = Mathf.Lerp(0, 0.5, var_428_3)

					arg_425_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1055ui_story.fillRatio = var_428_4
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1055ui_story then
				local var_428_5 = 0.5

				arg_425_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1055ui_story.fillRatio = var_428_5
			end

			local var_428_6 = 0
			local var_428_7 = 0.075

			if var_428_6 < arg_425_1.time_ and arg_425_1.time_ <= var_428_6 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_8 = arg_425_1:FormatText(StoryNameCfg[485].name)

				arg_425_1.leftNameTxt_.text = var_428_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_9 = arg_425_1:GetWordFromCfg(123101106)
				local var_428_10 = arg_425_1:FormatText(var_428_9.content)

				arg_425_1.text_.text = var_428_10

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_11 = 3
				local var_428_12 = utf8.len(var_428_10)
				local var_428_13 = var_428_11 <= 0 and var_428_7 or var_428_7 * (var_428_12 / var_428_11)

				if var_428_13 > 0 and var_428_7 < var_428_13 then
					arg_425_1.talkMaxDuration = var_428_13

					if var_428_13 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_13 + var_428_6
					end
				end

				arg_425_1.text_.text = var_428_10
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101106", "story_v_out_123101.awb") ~= 0 then
					local var_428_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101106", "story_v_out_123101.awb") / 1000

					if var_428_14 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_14 + var_428_6
					end

					if var_428_9.prefab_name ~= "" and arg_425_1.actors_[var_428_9.prefab_name] ~= nil then
						local var_428_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_9.prefab_name].transform, "story_v_out_123101", "123101106", "story_v_out_123101.awb")

						arg_425_1:RecordAudio("123101106", var_428_15)
						arg_425_1:RecordAudio("123101106", var_428_15)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_123101", "123101106", "story_v_out_123101.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_123101", "123101106", "story_v_out_123101.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_16 = math.max(var_428_7, arg_425_1.talkMaxDuration)

			if var_428_6 <= arg_425_1.time_ and arg_425_1.time_ < var_428_6 + var_428_16 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_6) / var_428_16

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_6 + var_428_16 and arg_425_1.time_ < var_428_6 + var_428_16 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play123101107 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 123101107
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play123101108(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0
			local var_432_1 = 0.725

			if var_432_0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_2 = arg_429_1:GetWordFromCfg(123101107)
				local var_432_3 = arg_429_1:FormatText(var_432_2.content)

				arg_429_1.text_.text = var_432_3

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_4 = 29
				local var_432_5 = utf8.len(var_432_3)
				local var_432_6 = var_432_4 <= 0 and var_432_1 or var_432_1 * (var_432_5 / var_432_4)

				if var_432_6 > 0 and var_432_1 < var_432_6 then
					arg_429_1.talkMaxDuration = var_432_6

					if var_432_6 + var_432_0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_6 + var_432_0
					end
				end

				arg_429_1.text_.text = var_432_3
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_7 = math.max(var_432_1, arg_429_1.talkMaxDuration)

			if var_432_0 <= arg_429_1.time_ and arg_429_1.time_ < var_432_0 + var_432_7 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_0) / var_432_7

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_0 + var_432_7 and arg_429_1.time_ < var_432_0 + var_432_7 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play123101108 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 123101108
		arg_433_1.duration_ = 6.67

		local var_433_0 = {
			zh = 4,
			ja = 6.666
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
				arg_433_0:Play123101109(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1055ui_story"]
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1055ui_story == nil then
				arg_433_1.var_.characterEffect1055ui_story = var_436_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 and not isNil(var_436_0) then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2

				if arg_433_1.var_.characterEffect1055ui_story and not isNil(var_436_0) then
					arg_433_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1055ui_story then
				arg_433_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_436_4 = 0

			if var_436_4 < arg_433_1.time_ and arg_433_1.time_ <= var_436_4 + arg_436_0 then
				arg_433_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_2")
			end

			local var_436_5 = 0

			if var_436_5 < arg_433_1.time_ and arg_433_1.time_ <= var_436_5 + arg_436_0 then
				arg_433_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_436_6 = 0
			local var_436_7 = 0.4

			if var_436_6 < arg_433_1.time_ and arg_433_1.time_ <= var_436_6 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_8 = arg_433_1:FormatText(StoryNameCfg[481].name)

				arg_433_1.leftNameTxt_.text = var_436_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_9 = arg_433_1:GetWordFromCfg(123101108)
				local var_436_10 = arg_433_1:FormatText(var_436_9.content)

				arg_433_1.text_.text = var_436_10

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_11 = 16
				local var_436_12 = utf8.len(var_436_10)
				local var_436_13 = var_436_11 <= 0 and var_436_7 or var_436_7 * (var_436_12 / var_436_11)

				if var_436_13 > 0 and var_436_7 < var_436_13 then
					arg_433_1.talkMaxDuration = var_436_13

					if var_436_13 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_13 + var_436_6
					end
				end

				arg_433_1.text_.text = var_436_10
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101108", "story_v_out_123101.awb") ~= 0 then
					local var_436_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101108", "story_v_out_123101.awb") / 1000

					if var_436_14 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_14 + var_436_6
					end

					if var_436_9.prefab_name ~= "" and arg_433_1.actors_[var_436_9.prefab_name] ~= nil then
						local var_436_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_9.prefab_name].transform, "story_v_out_123101", "123101108", "story_v_out_123101.awb")

						arg_433_1:RecordAudio("123101108", var_436_15)
						arg_433_1:RecordAudio("123101108", var_436_15)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_123101", "123101108", "story_v_out_123101.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_123101", "123101108", "story_v_out_123101.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_16 = math.max(var_436_7, arg_433_1.talkMaxDuration)

			if var_436_6 <= arg_433_1.time_ and arg_433_1.time_ < var_436_6 + var_436_16 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_6) / var_436_16

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_6 + var_436_16 and arg_433_1.time_ < var_436_6 + var_436_16 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play123101109 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 123101109
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play123101110(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["1055ui_story"]
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1055ui_story == nil then
				arg_437_1.var_.characterEffect1055ui_story = var_440_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 and not isNil(var_440_0) then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2

				if arg_437_1.var_.characterEffect1055ui_story and not isNil(var_440_0) then
					local var_440_4 = Mathf.Lerp(0, 0.5, var_440_3)

					arg_437_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1055ui_story.fillRatio = var_440_4
				end
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1055ui_story then
				local var_440_5 = 0.5

				arg_437_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1055ui_story.fillRatio = var_440_5
			end

			local var_440_6 = arg_437_1.actors_["1055ui_story"].transform
			local var_440_7 = 0

			if var_440_7 < arg_437_1.time_ and arg_437_1.time_ <= var_440_7 + arg_440_0 then
				arg_437_1.var_.moveOldPos1055ui_story = var_440_6.localPosition
			end

			local var_440_8 = 0.001

			if var_440_7 <= arg_437_1.time_ and arg_437_1.time_ < var_440_7 + var_440_8 then
				local var_440_9 = (arg_437_1.time_ - var_440_7) / var_440_8
				local var_440_10 = Vector3.New(0, 100, 0)

				var_440_6.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1055ui_story, var_440_10, var_440_9)

				local var_440_11 = manager.ui.mainCamera.transform.position - var_440_6.position

				var_440_6.forward = Vector3.New(var_440_11.x, var_440_11.y, var_440_11.z)

				local var_440_12 = var_440_6.localEulerAngles

				var_440_12.z = 0
				var_440_12.x = 0
				var_440_6.localEulerAngles = var_440_12
			end

			if arg_437_1.time_ >= var_440_7 + var_440_8 and arg_437_1.time_ < var_440_7 + var_440_8 + arg_440_0 then
				var_440_6.localPosition = Vector3.New(0, 100, 0)

				local var_440_13 = manager.ui.mainCamera.transform.position - var_440_6.position

				var_440_6.forward = Vector3.New(var_440_13.x, var_440_13.y, var_440_13.z)

				local var_440_14 = var_440_6.localEulerAngles

				var_440_14.z = 0
				var_440_14.x = 0
				var_440_6.localEulerAngles = var_440_14
			end

			local var_440_15 = 0
			local var_440_16 = 0.7

			if var_440_15 < arg_437_1.time_ and arg_437_1.time_ <= var_440_15 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_17 = arg_437_1:GetWordFromCfg(123101109)
				local var_440_18 = arg_437_1:FormatText(var_440_17.content)

				arg_437_1.text_.text = var_440_18

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_19 = 28
				local var_440_20 = utf8.len(var_440_18)
				local var_440_21 = var_440_19 <= 0 and var_440_16 or var_440_16 * (var_440_20 / var_440_19)

				if var_440_21 > 0 and var_440_16 < var_440_21 then
					arg_437_1.talkMaxDuration = var_440_21

					if var_440_21 + var_440_15 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_21 + var_440_15
					end
				end

				arg_437_1.text_.text = var_440_18
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_22 = math.max(var_440_16, arg_437_1.talkMaxDuration)

			if var_440_15 <= arg_437_1.time_ and arg_437_1.time_ < var_440_15 + var_440_22 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_15) / var_440_22

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_15 + var_440_22 and arg_437_1.time_ < var_440_15 + var_440_22 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play123101110 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 123101110
		arg_441_1.duration_ = 4.1

		local var_441_0 = {
			zh = 4.1,
			ja = 2.5
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
				arg_441_0:Play123101111(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["1055ui_story"]
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1055ui_story == nil then
				arg_441_1.var_.characterEffect1055ui_story = var_444_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 and not isNil(var_444_0) then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2

				if arg_441_1.var_.characterEffect1055ui_story and not isNil(var_444_0) then
					local var_444_4 = Mathf.Lerp(0, 0.5, var_444_3)

					arg_441_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_441_1.var_.characterEffect1055ui_story.fillRatio = var_444_4
				end
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1055ui_story then
				local var_444_5 = 0.5

				arg_441_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_441_1.var_.characterEffect1055ui_story.fillRatio = var_444_5
			end

			local var_444_6 = 0
			local var_444_7 = 0.15

			if var_444_6 < arg_441_1.time_ and arg_441_1.time_ <= var_444_6 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_8 = arg_441_1:FormatText(StoryNameCfg[485].name)

				arg_441_1.leftNameTxt_.text = var_444_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_9 = arg_441_1:GetWordFromCfg(123101110)
				local var_444_10 = arg_441_1:FormatText(var_444_9.content)

				arg_441_1.text_.text = var_444_10

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_11 = 6
				local var_444_12 = utf8.len(var_444_10)
				local var_444_13 = var_444_11 <= 0 and var_444_7 or var_444_7 * (var_444_12 / var_444_11)

				if var_444_13 > 0 and var_444_7 < var_444_13 then
					arg_441_1.talkMaxDuration = var_444_13

					if var_444_13 + var_444_6 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_13 + var_444_6
					end
				end

				arg_441_1.text_.text = var_444_10
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101110", "story_v_out_123101.awb") ~= 0 then
					local var_444_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101110", "story_v_out_123101.awb") / 1000

					if var_444_14 + var_444_6 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_14 + var_444_6
					end

					if var_444_9.prefab_name ~= "" and arg_441_1.actors_[var_444_9.prefab_name] ~= nil then
						local var_444_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_9.prefab_name].transform, "story_v_out_123101", "123101110", "story_v_out_123101.awb")

						arg_441_1:RecordAudio("123101110", var_444_15)
						arg_441_1:RecordAudio("123101110", var_444_15)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_123101", "123101110", "story_v_out_123101.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_123101", "123101110", "story_v_out_123101.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_16 = math.max(var_444_7, arg_441_1.talkMaxDuration)

			if var_444_6 <= arg_441_1.time_ and arg_441_1.time_ < var_444_6 + var_444_16 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_6) / var_444_16

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_6 + var_444_16 and arg_441_1.time_ < var_444_6 + var_444_16 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play123101111 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 123101111
		arg_445_1.duration_ = 9

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play123101112(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = "K05g"

			if arg_445_1.bgs_[var_448_0] == nil then
				local var_448_1 = Object.Instantiate(arg_445_1.paintGo_)

				var_448_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_448_0)
				var_448_1.name = var_448_0
				var_448_1.transform.parent = arg_445_1.stage_.transform
				var_448_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_445_1.bgs_[var_448_0] = var_448_1
			end

			local var_448_2 = 1.999999999999

			if var_448_2 < arg_445_1.time_ and arg_445_1.time_ <= var_448_2 + arg_448_0 then
				local var_448_3 = manager.ui.mainCamera.transform.localPosition
				local var_448_4 = Vector3.New(0, 0, 10) + Vector3.New(var_448_3.x, var_448_3.y, 0)
				local var_448_5 = arg_445_1.bgs_.K05g

				var_448_5.transform.localPosition = var_448_4
				var_448_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_448_6 = var_448_5:GetComponent("SpriteRenderer")

				if var_448_6 and var_448_6.sprite then
					local var_448_7 = (var_448_5.transform.localPosition - var_448_3).z
					local var_448_8 = manager.ui.mainCameraCom_
					local var_448_9 = 2 * var_448_7 * Mathf.Tan(var_448_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_448_10 = var_448_9 * var_448_8.aspect
					local var_448_11 = var_448_6.sprite.bounds.size.x
					local var_448_12 = var_448_6.sprite.bounds.size.y
					local var_448_13 = var_448_10 / var_448_11
					local var_448_14 = var_448_9 / var_448_12
					local var_448_15 = var_448_14 < var_448_13 and var_448_13 or var_448_14

					var_448_5.transform.localScale = Vector3.New(var_448_15, var_448_15, 0)
				end

				for iter_448_0, iter_448_1 in pairs(arg_445_1.bgs_) do
					if iter_448_0 ~= "K05g" then
						iter_448_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_448_16 = 0

			if var_448_16 < arg_445_1.time_ and arg_445_1.time_ <= var_448_16 + arg_448_0 then
				arg_445_1.mask_.enabled = true
				arg_445_1.mask_.raycastTarget = true

				arg_445_1:SetGaussion(false)
			end

			local var_448_17 = 2

			if var_448_16 <= arg_445_1.time_ and arg_445_1.time_ < var_448_16 + var_448_17 then
				local var_448_18 = (arg_445_1.time_ - var_448_16) / var_448_17
				local var_448_19 = Color.New(0, 0, 0)

				var_448_19.a = Mathf.Lerp(0, 1, var_448_18)
				arg_445_1.mask_.color = var_448_19
			end

			if arg_445_1.time_ >= var_448_16 + var_448_17 and arg_445_1.time_ < var_448_16 + var_448_17 + arg_448_0 then
				local var_448_20 = Color.New(0, 0, 0)

				var_448_20.a = 1
				arg_445_1.mask_.color = var_448_20
			end

			local var_448_21 = 2

			if var_448_21 < arg_445_1.time_ and arg_445_1.time_ <= var_448_21 + arg_448_0 then
				arg_445_1.mask_.enabled = true
				arg_445_1.mask_.raycastTarget = true

				arg_445_1:SetGaussion(false)
			end

			local var_448_22 = 2

			if var_448_21 <= arg_445_1.time_ and arg_445_1.time_ < var_448_21 + var_448_22 then
				local var_448_23 = (arg_445_1.time_ - var_448_21) / var_448_22
				local var_448_24 = Color.New(0, 0, 0)

				var_448_24.a = Mathf.Lerp(1, 0, var_448_23)
				arg_445_1.mask_.color = var_448_24
			end

			if arg_445_1.time_ >= var_448_21 + var_448_22 and arg_445_1.time_ < var_448_21 + var_448_22 + arg_448_0 then
				local var_448_25 = Color.New(0, 0, 0)
				local var_448_26 = 0

				arg_445_1.mask_.enabled = false
				var_448_25.a = var_448_26
				arg_445_1.mask_.color = var_448_25
			end

			if arg_445_1.frameCnt_ <= 1 then
				arg_445_1.dialog_:SetActive(false)
			end

			local var_448_27 = 4
			local var_448_28 = 0.85

			if var_448_27 < arg_445_1.time_ and arg_445_1.time_ <= var_448_27 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0

				arg_445_1.dialog_:SetActive(true)

				arg_445_1.dialogCg_.alpha = 0

				local var_448_29 = LeanTween.value(arg_445_1.dialog_, 0, 1, 0.3)

				var_448_29:setOnUpdate(LuaHelper.FloatAction(function(arg_449_0)
					arg_445_1.dialogCg_.alpha = arg_449_0
				end))
				var_448_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_445_1.dialog_)
					var_448_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_445_1.duration_ = arg_445_1.duration_ + 0.3

				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_30 = arg_445_1:GetWordFromCfg(123101111)
				local var_448_31 = arg_445_1:FormatText(var_448_30.content)

				arg_445_1.text_.text = var_448_31

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_32 = 34
				local var_448_33 = utf8.len(var_448_31)
				local var_448_34 = var_448_32 <= 0 and var_448_28 or var_448_28 * (var_448_33 / var_448_32)

				if var_448_34 > 0 and var_448_28 < var_448_34 then
					arg_445_1.talkMaxDuration = var_448_34
					var_448_27 = var_448_27 + 0.3

					if var_448_34 + var_448_27 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_34 + var_448_27
					end
				end

				arg_445_1.text_.text = var_448_31
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_35 = var_448_27 + 0.3
			local var_448_36 = math.max(var_448_28, arg_445_1.talkMaxDuration)

			if var_448_35 <= arg_445_1.time_ and arg_445_1.time_ < var_448_35 + var_448_36 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_35) / var_448_36

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_35 + var_448_36 and arg_445_1.time_ < var_448_35 + var_448_36 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play123101112 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 123101112
		arg_451_1.duration_ = 4.8

		local var_451_0 = {
			zh = 4.8,
			ja = 4
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play123101113(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1055ui_story"].transform
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				arg_451_1.var_.moveOldPos1055ui_story = var_454_0.localPosition
			end

			local var_454_2 = 0.001

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2
				local var_454_4 = Vector3.New(0, -0.965, -6.2)

				var_454_0.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1055ui_story, var_454_4, var_454_3)

				local var_454_5 = manager.ui.mainCamera.transform.position - var_454_0.position

				var_454_0.forward = Vector3.New(var_454_5.x, var_454_5.y, var_454_5.z)

				local var_454_6 = var_454_0.localEulerAngles

				var_454_6.z = 0
				var_454_6.x = 0
				var_454_0.localEulerAngles = var_454_6
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 then
				var_454_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_454_7 = manager.ui.mainCamera.transform.position - var_454_0.position

				var_454_0.forward = Vector3.New(var_454_7.x, var_454_7.y, var_454_7.z)

				local var_454_8 = var_454_0.localEulerAngles

				var_454_8.z = 0
				var_454_8.x = 0
				var_454_0.localEulerAngles = var_454_8
			end

			local var_454_9 = arg_451_1.actors_["1055ui_story"]
			local var_454_10 = 0

			if var_454_10 < arg_451_1.time_ and arg_451_1.time_ <= var_454_10 + arg_454_0 and not isNil(var_454_9) and arg_451_1.var_.characterEffect1055ui_story == nil then
				arg_451_1.var_.characterEffect1055ui_story = var_454_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_11 = 0.200000002980232

			if var_454_10 <= arg_451_1.time_ and arg_451_1.time_ < var_454_10 + var_454_11 and not isNil(var_454_9) then
				local var_454_12 = (arg_451_1.time_ - var_454_10) / var_454_11

				if arg_451_1.var_.characterEffect1055ui_story and not isNil(var_454_9) then
					arg_451_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= var_454_10 + var_454_11 and arg_451_1.time_ < var_454_10 + var_454_11 + arg_454_0 and not isNil(var_454_9) and arg_451_1.var_.characterEffect1055ui_story then
				arg_451_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_454_13 = 0

			if var_454_13 < arg_451_1.time_ and arg_451_1.time_ <= var_454_13 + arg_454_0 then
				arg_451_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_454_14 = 0

			if var_454_14 < arg_451_1.time_ and arg_451_1.time_ <= var_454_14 + arg_454_0 then
				arg_451_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_454_15 = 0
			local var_454_16 = 0.45

			if var_454_15 < arg_451_1.time_ and arg_451_1.time_ <= var_454_15 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_17 = arg_451_1:FormatText(StoryNameCfg[481].name)

				arg_451_1.leftNameTxt_.text = var_454_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_18 = arg_451_1:GetWordFromCfg(123101112)
				local var_454_19 = arg_451_1:FormatText(var_454_18.content)

				arg_451_1.text_.text = var_454_19

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_20 = 18
				local var_454_21 = utf8.len(var_454_19)
				local var_454_22 = var_454_20 <= 0 and var_454_16 or var_454_16 * (var_454_21 / var_454_20)

				if var_454_22 > 0 and var_454_16 < var_454_22 then
					arg_451_1.talkMaxDuration = var_454_22

					if var_454_22 + var_454_15 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_22 + var_454_15
					end
				end

				arg_451_1.text_.text = var_454_19
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101112", "story_v_out_123101.awb") ~= 0 then
					local var_454_23 = manager.audio:GetVoiceLength("story_v_out_123101", "123101112", "story_v_out_123101.awb") / 1000

					if var_454_23 + var_454_15 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_23 + var_454_15
					end

					if var_454_18.prefab_name ~= "" and arg_451_1.actors_[var_454_18.prefab_name] ~= nil then
						local var_454_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_18.prefab_name].transform, "story_v_out_123101", "123101112", "story_v_out_123101.awb")

						arg_451_1:RecordAudio("123101112", var_454_24)
						arg_451_1:RecordAudio("123101112", var_454_24)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_123101", "123101112", "story_v_out_123101.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_123101", "123101112", "story_v_out_123101.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_25 = math.max(var_454_16, arg_451_1.talkMaxDuration)

			if var_454_15 <= arg_451_1.time_ and arg_451_1.time_ < var_454_15 + var_454_25 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_15) / var_454_25

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_15 + var_454_25 and arg_451_1.time_ < var_454_15 + var_454_25 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play123101113 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 123101113
		arg_455_1.duration_ = 3.5

		local var_455_0 = {
			zh = 2.2,
			ja = 3.5
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play123101114(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["1055ui_story"]
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1055ui_story == nil then
				arg_455_1.var_.characterEffect1055ui_story = var_458_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_2 = 0.200000002980232

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 and not isNil(var_458_0) then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2

				if arg_455_1.var_.characterEffect1055ui_story and not isNil(var_458_0) then
					local var_458_4 = Mathf.Lerp(0, 0.5, var_458_3)

					arg_455_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1055ui_story.fillRatio = var_458_4
				end
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1055ui_story then
				local var_458_5 = 0.5

				arg_455_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1055ui_story.fillRatio = var_458_5
			end

			local var_458_6 = 0
			local var_458_7 = 0.275

			if var_458_6 < arg_455_1.time_ and arg_455_1.time_ <= var_458_6 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_8 = arg_455_1:FormatText(StoryNameCfg[496].name)

				arg_455_1.leftNameTxt_.text = var_458_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_9 = arg_455_1:GetWordFromCfg(123101113)
				local var_458_10 = arg_455_1:FormatText(var_458_9.content)

				arg_455_1.text_.text = var_458_10

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_11 = 11
				local var_458_12 = utf8.len(var_458_10)
				local var_458_13 = var_458_11 <= 0 and var_458_7 or var_458_7 * (var_458_12 / var_458_11)

				if var_458_13 > 0 and var_458_7 < var_458_13 then
					arg_455_1.talkMaxDuration = var_458_13

					if var_458_13 + var_458_6 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_13 + var_458_6
					end
				end

				arg_455_1.text_.text = var_458_10
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101113", "story_v_out_123101.awb") ~= 0 then
					local var_458_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101113", "story_v_out_123101.awb") / 1000

					if var_458_14 + var_458_6 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_14 + var_458_6
					end

					if var_458_9.prefab_name ~= "" and arg_455_1.actors_[var_458_9.prefab_name] ~= nil then
						local var_458_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_9.prefab_name].transform, "story_v_out_123101", "123101113", "story_v_out_123101.awb")

						arg_455_1:RecordAudio("123101113", var_458_15)
						arg_455_1:RecordAudio("123101113", var_458_15)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_123101", "123101113", "story_v_out_123101.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_123101", "123101113", "story_v_out_123101.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_16 = math.max(var_458_7, arg_455_1.talkMaxDuration)

			if var_458_6 <= arg_455_1.time_ and arg_455_1.time_ < var_458_6 + var_458_16 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_6) / var_458_16

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_6 + var_458_16 and arg_455_1.time_ < var_458_6 + var_458_16 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play123101114 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 123101114
		arg_459_1.duration_ = 3.5

		local var_459_0 = {
			zh = 3.5,
			ja = 2.733
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play123101115(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["1055ui_story"]
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect1055ui_story == nil then
				arg_459_1.var_.characterEffect1055ui_story = var_462_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_2 = 0.200000002980232

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_2 and not isNil(var_462_0) then
				local var_462_3 = (arg_459_1.time_ - var_462_1) / var_462_2

				if arg_459_1.var_.characterEffect1055ui_story and not isNil(var_462_0) then
					arg_459_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= var_462_1 + var_462_2 and arg_459_1.time_ < var_462_1 + var_462_2 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect1055ui_story then
				arg_459_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_462_4 = 0

			if var_462_4 < arg_459_1.time_ and arg_459_1.time_ <= var_462_4 + arg_462_0 then
				arg_459_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_462_5 = 0

			if var_462_5 < arg_459_1.time_ and arg_459_1.time_ <= var_462_5 + arg_462_0 then
				arg_459_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_462_6 = 0
			local var_462_7 = 0.4

			if var_462_6 < arg_459_1.time_ and arg_459_1.time_ <= var_462_6 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_8 = arg_459_1:FormatText(StoryNameCfg[481].name)

				arg_459_1.leftNameTxt_.text = var_462_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_9 = arg_459_1:GetWordFromCfg(123101114)
				local var_462_10 = arg_459_1:FormatText(var_462_9.content)

				arg_459_1.text_.text = var_462_10

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_11 = 16
				local var_462_12 = utf8.len(var_462_10)
				local var_462_13 = var_462_11 <= 0 and var_462_7 or var_462_7 * (var_462_12 / var_462_11)

				if var_462_13 > 0 and var_462_7 < var_462_13 then
					arg_459_1.talkMaxDuration = var_462_13

					if var_462_13 + var_462_6 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_13 + var_462_6
					end
				end

				arg_459_1.text_.text = var_462_10
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101114", "story_v_out_123101.awb") ~= 0 then
					local var_462_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101114", "story_v_out_123101.awb") / 1000

					if var_462_14 + var_462_6 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_14 + var_462_6
					end

					if var_462_9.prefab_name ~= "" and arg_459_1.actors_[var_462_9.prefab_name] ~= nil then
						local var_462_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_9.prefab_name].transform, "story_v_out_123101", "123101114", "story_v_out_123101.awb")

						arg_459_1:RecordAudio("123101114", var_462_15)
						arg_459_1:RecordAudio("123101114", var_462_15)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_123101", "123101114", "story_v_out_123101.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_123101", "123101114", "story_v_out_123101.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_16 = math.max(var_462_7, arg_459_1.talkMaxDuration)

			if var_462_6 <= arg_459_1.time_ and arg_459_1.time_ < var_462_6 + var_462_16 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_6) / var_462_16

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_6 + var_462_16 and arg_459_1.time_ < var_462_6 + var_462_16 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play123101115 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 123101115
		arg_463_1.duration_ = 13.4

		local var_463_0 = {
			zh = 5.1,
			ja = 13.4
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play123101116(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["1055ui_story"]
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect1055ui_story == nil then
				arg_463_1.var_.characterEffect1055ui_story = var_466_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_2 = 0.200000002980232

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_2 and not isNil(var_466_0) then
				local var_466_3 = (arg_463_1.time_ - var_466_1) / var_466_2

				if arg_463_1.var_.characterEffect1055ui_story and not isNil(var_466_0) then
					local var_466_4 = Mathf.Lerp(0, 0.5, var_466_3)

					arg_463_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_463_1.var_.characterEffect1055ui_story.fillRatio = var_466_4
				end
			end

			if arg_463_1.time_ >= var_466_1 + var_466_2 and arg_463_1.time_ < var_466_1 + var_466_2 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect1055ui_story then
				local var_466_5 = 0.5

				arg_463_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_463_1.var_.characterEffect1055ui_story.fillRatio = var_466_5
			end

			local var_466_6 = 0
			local var_466_7 = 0.575

			if var_466_6 < arg_463_1.time_ and arg_463_1.time_ <= var_466_6 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_8 = arg_463_1:FormatText(StoryNameCfg[496].name)

				arg_463_1.leftNameTxt_.text = var_466_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_9 = arg_463_1:GetWordFromCfg(123101115)
				local var_466_10 = arg_463_1:FormatText(var_466_9.content)

				arg_463_1.text_.text = var_466_10

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_11 = 23
				local var_466_12 = utf8.len(var_466_10)
				local var_466_13 = var_466_11 <= 0 and var_466_7 or var_466_7 * (var_466_12 / var_466_11)

				if var_466_13 > 0 and var_466_7 < var_466_13 then
					arg_463_1.talkMaxDuration = var_466_13

					if var_466_13 + var_466_6 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_13 + var_466_6
					end
				end

				arg_463_1.text_.text = var_466_10
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101115", "story_v_out_123101.awb") ~= 0 then
					local var_466_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101115", "story_v_out_123101.awb") / 1000

					if var_466_14 + var_466_6 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_14 + var_466_6
					end

					if var_466_9.prefab_name ~= "" and arg_463_1.actors_[var_466_9.prefab_name] ~= nil then
						local var_466_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_9.prefab_name].transform, "story_v_out_123101", "123101115", "story_v_out_123101.awb")

						arg_463_1:RecordAudio("123101115", var_466_15)
						arg_463_1:RecordAudio("123101115", var_466_15)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_123101", "123101115", "story_v_out_123101.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_123101", "123101115", "story_v_out_123101.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_16 = math.max(var_466_7, arg_463_1.talkMaxDuration)

			if var_466_6 <= arg_463_1.time_ and arg_463_1.time_ < var_466_6 + var_466_16 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_6) / var_466_16

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_6 + var_466_16 and arg_463_1.time_ < var_466_6 + var_466_16 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play123101116 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 123101116
		arg_467_1.duration_ = 5.2

		local var_467_0 = {
			zh = 3.666,
			ja = 5.2
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play123101117(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = arg_467_1.actors_["1055ui_story"]
			local var_470_1 = 0

			if var_470_1 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 and not isNil(var_470_0) and arg_467_1.var_.characterEffect1055ui_story == nil then
				arg_467_1.var_.characterEffect1055ui_story = var_470_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_2 = 0.200000002980232

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_2 and not isNil(var_470_0) then
				local var_470_3 = (arg_467_1.time_ - var_470_1) / var_470_2

				if arg_467_1.var_.characterEffect1055ui_story and not isNil(var_470_0) then
					arg_467_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= var_470_1 + var_470_2 and arg_467_1.time_ < var_470_1 + var_470_2 + arg_470_0 and not isNil(var_470_0) and arg_467_1.var_.characterEffect1055ui_story then
				arg_467_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_470_4 = 0

			if var_470_4 < arg_467_1.time_ and arg_467_1.time_ <= var_470_4 + arg_470_0 then
				arg_467_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_470_5 = 0

			if var_470_5 < arg_467_1.time_ and arg_467_1.time_ <= var_470_5 + arg_470_0 then
				arg_467_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_470_6 = 0
			local var_470_7 = 0.325

			if var_470_6 < arg_467_1.time_ and arg_467_1.time_ <= var_470_6 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_8 = arg_467_1:FormatText(StoryNameCfg[481].name)

				arg_467_1.leftNameTxt_.text = var_470_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_9 = arg_467_1:GetWordFromCfg(123101116)
				local var_470_10 = arg_467_1:FormatText(var_470_9.content)

				arg_467_1.text_.text = var_470_10

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_11 = 13
				local var_470_12 = utf8.len(var_470_10)
				local var_470_13 = var_470_11 <= 0 and var_470_7 or var_470_7 * (var_470_12 / var_470_11)

				if var_470_13 > 0 and var_470_7 < var_470_13 then
					arg_467_1.talkMaxDuration = var_470_13

					if var_470_13 + var_470_6 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_13 + var_470_6
					end
				end

				arg_467_1.text_.text = var_470_10
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101116", "story_v_out_123101.awb") ~= 0 then
					local var_470_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101116", "story_v_out_123101.awb") / 1000

					if var_470_14 + var_470_6 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_14 + var_470_6
					end

					if var_470_9.prefab_name ~= "" and arg_467_1.actors_[var_470_9.prefab_name] ~= nil then
						local var_470_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_9.prefab_name].transform, "story_v_out_123101", "123101116", "story_v_out_123101.awb")

						arg_467_1:RecordAudio("123101116", var_470_15)
						arg_467_1:RecordAudio("123101116", var_470_15)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_123101", "123101116", "story_v_out_123101.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_123101", "123101116", "story_v_out_123101.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_16 = math.max(var_470_7, arg_467_1.talkMaxDuration)

			if var_470_6 <= arg_467_1.time_ and arg_467_1.time_ < var_470_6 + var_470_16 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_6) / var_470_16

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_6 + var_470_16 and arg_467_1.time_ < var_470_6 + var_470_16 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play123101117 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 123101117
		arg_471_1.duration_ = 7.7

		local var_471_0 = {
			zh = 4.8,
			ja = 7.7
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play123101118(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = arg_471_1.actors_["1055ui_story"]
			local var_474_1 = 0

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 and not isNil(var_474_0) and arg_471_1.var_.characterEffect1055ui_story == nil then
				arg_471_1.var_.characterEffect1055ui_story = var_474_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_2 = 0.200000002980232

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_2 and not isNil(var_474_0) then
				local var_474_3 = (arg_471_1.time_ - var_474_1) / var_474_2

				if arg_471_1.var_.characterEffect1055ui_story and not isNil(var_474_0) then
					local var_474_4 = Mathf.Lerp(0, 0.5, var_474_3)

					arg_471_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_471_1.var_.characterEffect1055ui_story.fillRatio = var_474_4
				end
			end

			if arg_471_1.time_ >= var_474_1 + var_474_2 and arg_471_1.time_ < var_474_1 + var_474_2 + arg_474_0 and not isNil(var_474_0) and arg_471_1.var_.characterEffect1055ui_story then
				local var_474_5 = 0.5

				arg_471_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_471_1.var_.characterEffect1055ui_story.fillRatio = var_474_5
			end

			local var_474_6 = 0
			local var_474_7 = 0.65

			if var_474_6 < arg_471_1.time_ and arg_471_1.time_ <= var_474_6 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_8 = arg_471_1:FormatText(StoryNameCfg[496].name)

				arg_471_1.leftNameTxt_.text = var_474_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_9 = arg_471_1:GetWordFromCfg(123101117)
				local var_474_10 = arg_471_1:FormatText(var_474_9.content)

				arg_471_1.text_.text = var_474_10

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_11 = 26
				local var_474_12 = utf8.len(var_474_10)
				local var_474_13 = var_474_11 <= 0 and var_474_7 or var_474_7 * (var_474_12 / var_474_11)

				if var_474_13 > 0 and var_474_7 < var_474_13 then
					arg_471_1.talkMaxDuration = var_474_13

					if var_474_13 + var_474_6 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_13 + var_474_6
					end
				end

				arg_471_1.text_.text = var_474_10
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101117", "story_v_out_123101.awb") ~= 0 then
					local var_474_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101117", "story_v_out_123101.awb") / 1000

					if var_474_14 + var_474_6 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_14 + var_474_6
					end

					if var_474_9.prefab_name ~= "" and arg_471_1.actors_[var_474_9.prefab_name] ~= nil then
						local var_474_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_9.prefab_name].transform, "story_v_out_123101", "123101117", "story_v_out_123101.awb")

						arg_471_1:RecordAudio("123101117", var_474_15)
						arg_471_1:RecordAudio("123101117", var_474_15)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_123101", "123101117", "story_v_out_123101.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_123101", "123101117", "story_v_out_123101.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_16 = math.max(var_474_7, arg_471_1.talkMaxDuration)

			if var_474_6 <= arg_471_1.time_ and arg_471_1.time_ < var_474_6 + var_474_16 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_6) / var_474_16

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_6 + var_474_16 and arg_471_1.time_ < var_474_6 + var_474_16 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play123101118 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 123101118
		arg_475_1.duration_ = 8.27

		local var_475_0 = {
			zh = 6.566,
			ja = 8.266
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
				arg_475_0:Play123101119(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["1055ui_story"]
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.characterEffect1055ui_story == nil then
				arg_475_1.var_.characterEffect1055ui_story = var_478_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_2 = 0.200000002980232

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_2 and not isNil(var_478_0) then
				local var_478_3 = (arg_475_1.time_ - var_478_1) / var_478_2

				if arg_475_1.var_.characterEffect1055ui_story and not isNil(var_478_0) then
					arg_475_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= var_478_1 + var_478_2 and arg_475_1.time_ < var_478_1 + var_478_2 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.characterEffect1055ui_story then
				arg_475_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_478_4 = 0

			if var_478_4 < arg_475_1.time_ and arg_475_1.time_ <= var_478_4 + arg_478_0 then
				arg_475_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_478_5 = 0

			if var_478_5 < arg_475_1.time_ and arg_475_1.time_ <= var_478_5 + arg_478_0 then
				arg_475_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_478_6 = 0
			local var_478_7 = 0.85

			if var_478_6 < arg_475_1.time_ and arg_475_1.time_ <= var_478_6 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_8 = arg_475_1:FormatText(StoryNameCfg[481].name)

				arg_475_1.leftNameTxt_.text = var_478_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_9 = arg_475_1:GetWordFromCfg(123101118)
				local var_478_10 = arg_475_1:FormatText(var_478_9.content)

				arg_475_1.text_.text = var_478_10

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_11 = 34
				local var_478_12 = utf8.len(var_478_10)
				local var_478_13 = var_478_11 <= 0 and var_478_7 or var_478_7 * (var_478_12 / var_478_11)

				if var_478_13 > 0 and var_478_7 < var_478_13 then
					arg_475_1.talkMaxDuration = var_478_13

					if var_478_13 + var_478_6 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_13 + var_478_6
					end
				end

				arg_475_1.text_.text = var_478_10
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101118", "story_v_out_123101.awb") ~= 0 then
					local var_478_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101118", "story_v_out_123101.awb") / 1000

					if var_478_14 + var_478_6 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_14 + var_478_6
					end

					if var_478_9.prefab_name ~= "" and arg_475_1.actors_[var_478_9.prefab_name] ~= nil then
						local var_478_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_9.prefab_name].transform, "story_v_out_123101", "123101118", "story_v_out_123101.awb")

						arg_475_1:RecordAudio("123101118", var_478_15)
						arg_475_1:RecordAudio("123101118", var_478_15)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_123101", "123101118", "story_v_out_123101.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_123101", "123101118", "story_v_out_123101.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_16 = math.max(var_478_7, arg_475_1.talkMaxDuration)

			if var_478_6 <= arg_475_1.time_ and arg_475_1.time_ < var_478_6 + var_478_16 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_6) / var_478_16

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_6 + var_478_16 and arg_475_1.time_ < var_478_6 + var_478_16 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play123101119 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 123101119
		arg_479_1.duration_ = 4.47

		local var_479_0 = {
			zh = 3.633,
			ja = 4.466
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
				arg_479_0:Play123101120(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0

			if var_482_0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_0 + arg_482_0 then
				arg_479_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 then
				arg_479_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_482_2 = 0
			local var_482_3 = 0.375

			if var_482_2 < arg_479_1.time_ and arg_479_1.time_ <= var_482_2 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_4 = arg_479_1:FormatText(StoryNameCfg[481].name)

				arg_479_1.leftNameTxt_.text = var_482_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_5 = arg_479_1:GetWordFromCfg(123101119)
				local var_482_6 = arg_479_1:FormatText(var_482_5.content)

				arg_479_1.text_.text = var_482_6

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_7 = 15
				local var_482_8 = utf8.len(var_482_6)
				local var_482_9 = var_482_7 <= 0 and var_482_3 or var_482_3 * (var_482_8 / var_482_7)

				if var_482_9 > 0 and var_482_3 < var_482_9 then
					arg_479_1.talkMaxDuration = var_482_9

					if var_482_9 + var_482_2 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_9 + var_482_2
					end
				end

				arg_479_1.text_.text = var_482_6
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101119", "story_v_out_123101.awb") ~= 0 then
					local var_482_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101119", "story_v_out_123101.awb") / 1000

					if var_482_10 + var_482_2 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_10 + var_482_2
					end

					if var_482_5.prefab_name ~= "" and arg_479_1.actors_[var_482_5.prefab_name] ~= nil then
						local var_482_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_5.prefab_name].transform, "story_v_out_123101", "123101119", "story_v_out_123101.awb")

						arg_479_1:RecordAudio("123101119", var_482_11)
						arg_479_1:RecordAudio("123101119", var_482_11)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_123101", "123101119", "story_v_out_123101.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_123101", "123101119", "story_v_out_123101.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_12 = math.max(var_482_3, arg_479_1.talkMaxDuration)

			if var_482_2 <= arg_479_1.time_ and arg_479_1.time_ < var_482_2 + var_482_12 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_2) / var_482_12

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_2 + var_482_12 and arg_479_1.time_ < var_482_2 + var_482_12 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play123101120 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 123101120
		arg_483_1.duration_ = 8.7

		local var_483_0 = {
			zh = 6.9,
			ja = 8.7
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
				arg_483_0:Play123101121(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = arg_483_1.actors_["1055ui_story"]
			local var_486_1 = 0

			if var_486_1 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.characterEffect1055ui_story == nil then
				arg_483_1.var_.characterEffect1055ui_story = var_486_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.200000002980232

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_2 and not isNil(var_486_0) then
				local var_486_3 = (arg_483_1.time_ - var_486_1) / var_486_2

				if arg_483_1.var_.characterEffect1055ui_story and not isNil(var_486_0) then
					local var_486_4 = Mathf.Lerp(0, 0.5, var_486_3)

					arg_483_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_483_1.var_.characterEffect1055ui_story.fillRatio = var_486_4
				end
			end

			if arg_483_1.time_ >= var_486_1 + var_486_2 and arg_483_1.time_ < var_486_1 + var_486_2 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.characterEffect1055ui_story then
				local var_486_5 = 0.5

				arg_483_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_483_1.var_.characterEffect1055ui_story.fillRatio = var_486_5
			end

			local var_486_6 = 0
			local var_486_7 = 0.675

			if var_486_6 < arg_483_1.time_ and arg_483_1.time_ <= var_486_6 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_8 = arg_483_1:FormatText(StoryNameCfg[496].name)

				arg_483_1.leftNameTxt_.text = var_486_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_9 = arg_483_1:GetWordFromCfg(123101120)
				local var_486_10 = arg_483_1:FormatText(var_486_9.content)

				arg_483_1.text_.text = var_486_10

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_11 = 27
				local var_486_12 = utf8.len(var_486_10)
				local var_486_13 = var_486_11 <= 0 and var_486_7 or var_486_7 * (var_486_12 / var_486_11)

				if var_486_13 > 0 and var_486_7 < var_486_13 then
					arg_483_1.talkMaxDuration = var_486_13

					if var_486_13 + var_486_6 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_13 + var_486_6
					end
				end

				arg_483_1.text_.text = var_486_10
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101120", "story_v_out_123101.awb") ~= 0 then
					local var_486_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101120", "story_v_out_123101.awb") / 1000

					if var_486_14 + var_486_6 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_14 + var_486_6
					end

					if var_486_9.prefab_name ~= "" and arg_483_1.actors_[var_486_9.prefab_name] ~= nil then
						local var_486_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_9.prefab_name].transform, "story_v_out_123101", "123101120", "story_v_out_123101.awb")

						arg_483_1:RecordAudio("123101120", var_486_15)
						arg_483_1:RecordAudio("123101120", var_486_15)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_123101", "123101120", "story_v_out_123101.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_123101", "123101120", "story_v_out_123101.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_16 = math.max(var_486_7, arg_483_1.talkMaxDuration)

			if var_486_6 <= arg_483_1.time_ and arg_483_1.time_ < var_486_6 + var_486_16 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_6) / var_486_16

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_6 + var_486_16 and arg_483_1.time_ < var_486_6 + var_486_16 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play123101121 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 123101121
		arg_487_1.duration_ = 8.73

		local var_487_0 = {
			zh = 6.533,
			ja = 8.733
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
				arg_487_0:Play123101122(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = arg_487_1.actors_["1055ui_story"]
			local var_490_1 = 0

			if var_490_1 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 and not isNil(var_490_0) and arg_487_1.var_.characterEffect1055ui_story == nil then
				arg_487_1.var_.characterEffect1055ui_story = var_490_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_2 = 0.200000002980232

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_2 and not isNil(var_490_0) then
				local var_490_3 = (arg_487_1.time_ - var_490_1) / var_490_2

				if arg_487_1.var_.characterEffect1055ui_story and not isNil(var_490_0) then
					arg_487_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= var_490_1 + var_490_2 and arg_487_1.time_ < var_490_1 + var_490_2 + arg_490_0 and not isNil(var_490_0) and arg_487_1.var_.characterEffect1055ui_story then
				arg_487_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_490_4 = 0

			if var_490_4 < arg_487_1.time_ and arg_487_1.time_ <= var_490_4 + arg_490_0 then
				arg_487_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_490_5 = 0

			if var_490_5 < arg_487_1.time_ and arg_487_1.time_ <= var_490_5 + arg_490_0 then
				arg_487_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_490_6 = 0
			local var_490_7 = 0.675

			if var_490_6 < arg_487_1.time_ and arg_487_1.time_ <= var_490_6 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_8 = arg_487_1:FormatText(StoryNameCfg[481].name)

				arg_487_1.leftNameTxt_.text = var_490_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_9 = arg_487_1:GetWordFromCfg(123101121)
				local var_490_10 = arg_487_1:FormatText(var_490_9.content)

				arg_487_1.text_.text = var_490_10

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_11 = 27
				local var_490_12 = utf8.len(var_490_10)
				local var_490_13 = var_490_11 <= 0 and var_490_7 or var_490_7 * (var_490_12 / var_490_11)

				if var_490_13 > 0 and var_490_7 < var_490_13 then
					arg_487_1.talkMaxDuration = var_490_13

					if var_490_13 + var_490_6 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_13 + var_490_6
					end
				end

				arg_487_1.text_.text = var_490_10
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101121", "story_v_out_123101.awb") ~= 0 then
					local var_490_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101121", "story_v_out_123101.awb") / 1000

					if var_490_14 + var_490_6 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_14 + var_490_6
					end

					if var_490_9.prefab_name ~= "" and arg_487_1.actors_[var_490_9.prefab_name] ~= nil then
						local var_490_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_9.prefab_name].transform, "story_v_out_123101", "123101121", "story_v_out_123101.awb")

						arg_487_1:RecordAudio("123101121", var_490_15)
						arg_487_1:RecordAudio("123101121", var_490_15)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_123101", "123101121", "story_v_out_123101.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_123101", "123101121", "story_v_out_123101.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_16 = math.max(var_490_7, arg_487_1.talkMaxDuration)

			if var_490_6 <= arg_487_1.time_ and arg_487_1.time_ < var_490_6 + var_490_16 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_6) / var_490_16

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_6 + var_490_16 and arg_487_1.time_ < var_490_6 + var_490_16 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play123101122 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 123101122
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play123101123(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["1055ui_story"]
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.characterEffect1055ui_story == nil then
				arg_491_1.var_.characterEffect1055ui_story = var_494_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.200000002980232

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_2 and not isNil(var_494_0) then
				local var_494_3 = (arg_491_1.time_ - var_494_1) / var_494_2

				if arg_491_1.var_.characterEffect1055ui_story and not isNil(var_494_0) then
					local var_494_4 = Mathf.Lerp(0, 0.5, var_494_3)

					arg_491_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_491_1.var_.characterEffect1055ui_story.fillRatio = var_494_4
				end
			end

			if arg_491_1.time_ >= var_494_1 + var_494_2 and arg_491_1.time_ < var_494_1 + var_494_2 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.characterEffect1055ui_story then
				local var_494_5 = 0.5

				arg_491_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_491_1.var_.characterEffect1055ui_story.fillRatio = var_494_5
			end

			local var_494_6 = 0
			local var_494_7 = 0.275

			if var_494_6 < arg_491_1.time_ and arg_491_1.time_ <= var_494_6 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, false)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_8 = arg_491_1:GetWordFromCfg(123101122)
				local var_494_9 = arg_491_1:FormatText(var_494_8.content)

				arg_491_1.text_.text = var_494_9

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_10 = 11
				local var_494_11 = utf8.len(var_494_9)
				local var_494_12 = var_494_10 <= 0 and var_494_7 or var_494_7 * (var_494_11 / var_494_10)

				if var_494_12 > 0 and var_494_7 < var_494_12 then
					arg_491_1.talkMaxDuration = var_494_12

					if var_494_12 + var_494_6 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_12 + var_494_6
					end
				end

				arg_491_1.text_.text = var_494_9
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_13 = math.max(var_494_7, arg_491_1.talkMaxDuration)

			if var_494_6 <= arg_491_1.time_ and arg_491_1.time_ < var_494_6 + var_494_13 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_6) / var_494_13

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_6 + var_494_13 and arg_491_1.time_ < var_494_6 + var_494_13 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play123101123 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 123101123
		arg_495_1.duration_ = 3.53

		local var_495_0 = {
			zh = 2.233,
			ja = 3.533
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
				arg_495_0:Play123101124(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0
			local var_498_1 = 0.25

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_2 = arg_495_1:FormatText(StoryNameCfg[496].name)

				arg_495_1.leftNameTxt_.text = var_498_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_3 = arg_495_1:GetWordFromCfg(123101123)
				local var_498_4 = arg_495_1:FormatText(var_498_3.content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101123", "story_v_out_123101.awb") ~= 0 then
					local var_498_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101123", "story_v_out_123101.awb") / 1000

					if var_498_8 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_8 + var_498_0
					end

					if var_498_3.prefab_name ~= "" and arg_495_1.actors_[var_498_3.prefab_name] ~= nil then
						local var_498_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_3.prefab_name].transform, "story_v_out_123101", "123101123", "story_v_out_123101.awb")

						arg_495_1:RecordAudio("123101123", var_498_9)
						arg_495_1:RecordAudio("123101123", var_498_9)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_123101", "123101123", "story_v_out_123101.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_123101", "123101123", "story_v_out_123101.awb")
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
	Play123101124 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 123101124
		arg_499_1.duration_ = 2

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play123101125(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["1055ui_story"]
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.characterEffect1055ui_story == nil then
				arg_499_1.var_.characterEffect1055ui_story = var_502_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.200000002980232

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 and not isNil(var_502_0) then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2

				if arg_499_1.var_.characterEffect1055ui_story and not isNil(var_502_0) then
					arg_499_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.characterEffect1055ui_story then
				arg_499_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_502_4 = 0

			if var_502_4 < arg_499_1.time_ and arg_499_1.time_ <= var_502_4 + arg_502_0 then
				arg_499_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_502_5 = 0

			if var_502_5 < arg_499_1.time_ and arg_499_1.time_ <= var_502_5 + arg_502_0 then
				arg_499_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_502_6 = 0
			local var_502_7 = 0.05

			if var_502_6 < arg_499_1.time_ and arg_499_1.time_ <= var_502_6 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_8 = arg_499_1:FormatText(StoryNameCfg[481].name)

				arg_499_1.leftNameTxt_.text = var_502_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_9 = arg_499_1:GetWordFromCfg(123101124)
				local var_502_10 = arg_499_1:FormatText(var_502_9.content)

				arg_499_1.text_.text = var_502_10

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_11 = 2
				local var_502_12 = utf8.len(var_502_10)
				local var_502_13 = var_502_11 <= 0 and var_502_7 or var_502_7 * (var_502_12 / var_502_11)

				if var_502_13 > 0 and var_502_7 < var_502_13 then
					arg_499_1.talkMaxDuration = var_502_13

					if var_502_13 + var_502_6 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_13 + var_502_6
					end
				end

				arg_499_1.text_.text = var_502_10
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101124", "story_v_out_123101.awb") ~= 0 then
					local var_502_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101124", "story_v_out_123101.awb") / 1000

					if var_502_14 + var_502_6 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_14 + var_502_6
					end

					if var_502_9.prefab_name ~= "" and arg_499_1.actors_[var_502_9.prefab_name] ~= nil then
						local var_502_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_9.prefab_name].transform, "story_v_out_123101", "123101124", "story_v_out_123101.awb")

						arg_499_1:RecordAudio("123101124", var_502_15)
						arg_499_1:RecordAudio("123101124", var_502_15)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_123101", "123101124", "story_v_out_123101.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_123101", "123101124", "story_v_out_123101.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_16 = math.max(var_502_7, arg_499_1.talkMaxDuration)

			if var_502_6 <= arg_499_1.time_ and arg_499_1.time_ < var_502_6 + var_502_16 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_6) / var_502_16

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_6 + var_502_16 and arg_499_1.time_ < var_502_6 + var_502_16 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play123101125 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 123101125
		arg_503_1.duration_ = 6.93

		local var_503_0 = {
			zh = 6.333,
			ja = 6.933
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
				arg_503_0:Play123101126(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["1055ui_story"]
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.characterEffect1055ui_story == nil then
				arg_503_1.var_.characterEffect1055ui_story = var_506_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_2 = 0.200000002980232

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 and not isNil(var_506_0) then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2

				if arg_503_1.var_.characterEffect1055ui_story and not isNil(var_506_0) then
					local var_506_4 = Mathf.Lerp(0, 0.5, var_506_3)

					arg_503_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_503_1.var_.characterEffect1055ui_story.fillRatio = var_506_4
				end
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.characterEffect1055ui_story then
				local var_506_5 = 0.5

				arg_503_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_503_1.var_.characterEffect1055ui_story.fillRatio = var_506_5
			end

			local var_506_6 = 0
			local var_506_7 = 0.675

			if var_506_6 < arg_503_1.time_ and arg_503_1.time_ <= var_506_6 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_8 = arg_503_1:FormatText(StoryNameCfg[496].name)

				arg_503_1.leftNameTxt_.text = var_506_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_9 = arg_503_1:GetWordFromCfg(123101125)
				local var_506_10 = arg_503_1:FormatText(var_506_9.content)

				arg_503_1.text_.text = var_506_10

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_11 = 27
				local var_506_12 = utf8.len(var_506_10)
				local var_506_13 = var_506_11 <= 0 and var_506_7 or var_506_7 * (var_506_12 / var_506_11)

				if var_506_13 > 0 and var_506_7 < var_506_13 then
					arg_503_1.talkMaxDuration = var_506_13

					if var_506_13 + var_506_6 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_13 + var_506_6
					end
				end

				arg_503_1.text_.text = var_506_10
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101125", "story_v_out_123101.awb") ~= 0 then
					local var_506_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101125", "story_v_out_123101.awb") / 1000

					if var_506_14 + var_506_6 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_14 + var_506_6
					end

					if var_506_9.prefab_name ~= "" and arg_503_1.actors_[var_506_9.prefab_name] ~= nil then
						local var_506_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_9.prefab_name].transform, "story_v_out_123101", "123101125", "story_v_out_123101.awb")

						arg_503_1:RecordAudio("123101125", var_506_15)
						arg_503_1:RecordAudio("123101125", var_506_15)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_123101", "123101125", "story_v_out_123101.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_123101", "123101125", "story_v_out_123101.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_16 = math.max(var_506_7, arg_503_1.talkMaxDuration)

			if var_506_6 <= arg_503_1.time_ and arg_503_1.time_ < var_506_6 + var_506_16 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_6) / var_506_16

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_6 + var_506_16 and arg_503_1.time_ < var_506_6 + var_506_16 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play123101126 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 123101126
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play123101127(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0
			local var_510_1 = 0.75

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_2 = arg_507_1:GetWordFromCfg(123101126)
				local var_510_3 = arg_507_1:FormatText(var_510_2.content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_4 = 30
				local var_510_5 = utf8.len(var_510_3)
				local var_510_6 = var_510_4 <= 0 and var_510_1 or var_510_1 * (var_510_5 / var_510_4)

				if var_510_6 > 0 and var_510_1 < var_510_6 then
					arg_507_1.talkMaxDuration = var_510_6

					if var_510_6 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_6 + var_510_0
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_7 = math.max(var_510_1, arg_507_1.talkMaxDuration)

			if var_510_0 <= arg_507_1.time_ and arg_507_1.time_ < var_510_0 + var_510_7 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_0) / var_510_7

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_0 + var_510_7 and arg_507_1.time_ < var_510_0 + var_510_7 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play123101127 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 123101127
		arg_511_1.duration_ = 4.93

		local var_511_0 = {
			zh = 2.766,
			ja = 4.933
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
				arg_511_0:Play123101128(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["1055ui_story"]
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.characterEffect1055ui_story == nil then
				arg_511_1.var_.characterEffect1055ui_story = var_514_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_2 = 0.200000002980232

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 and not isNil(var_514_0) then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2

				if arg_511_1.var_.characterEffect1055ui_story and not isNil(var_514_0) then
					arg_511_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.characterEffect1055ui_story then
				arg_511_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_514_4 = 0

			if var_514_4 < arg_511_1.time_ and arg_511_1.time_ <= var_514_4 + arg_514_0 then
				arg_511_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_1")
			end

			local var_514_5 = 0

			if var_514_5 < arg_511_1.time_ and arg_511_1.time_ <= var_514_5 + arg_514_0 then
				arg_511_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_514_6 = 0
			local var_514_7 = 0.375

			if var_514_6 < arg_511_1.time_ and arg_511_1.time_ <= var_514_6 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_8 = arg_511_1:FormatText(StoryNameCfg[481].name)

				arg_511_1.leftNameTxt_.text = var_514_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_9 = arg_511_1:GetWordFromCfg(123101127)
				local var_514_10 = arg_511_1:FormatText(var_514_9.content)

				arg_511_1.text_.text = var_514_10

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_11 = 15
				local var_514_12 = utf8.len(var_514_10)
				local var_514_13 = var_514_11 <= 0 and var_514_7 or var_514_7 * (var_514_12 / var_514_11)

				if var_514_13 > 0 and var_514_7 < var_514_13 then
					arg_511_1.talkMaxDuration = var_514_13

					if var_514_13 + var_514_6 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_13 + var_514_6
					end
				end

				arg_511_1.text_.text = var_514_10
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101127", "story_v_out_123101.awb") ~= 0 then
					local var_514_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101127", "story_v_out_123101.awb") / 1000

					if var_514_14 + var_514_6 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_14 + var_514_6
					end

					if var_514_9.prefab_name ~= "" and arg_511_1.actors_[var_514_9.prefab_name] ~= nil then
						local var_514_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_9.prefab_name].transform, "story_v_out_123101", "123101127", "story_v_out_123101.awb")

						arg_511_1:RecordAudio("123101127", var_514_15)
						arg_511_1:RecordAudio("123101127", var_514_15)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_123101", "123101127", "story_v_out_123101.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_123101", "123101127", "story_v_out_123101.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_16 = math.max(var_514_7, arg_511_1.talkMaxDuration)

			if var_514_6 <= arg_511_1.time_ and arg_511_1.time_ < var_514_6 + var_514_16 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_6) / var_514_16

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_6 + var_514_16 and arg_511_1.time_ < var_514_6 + var_514_16 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play123101128 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 123101128
		arg_515_1.duration_ = 8.83

		local var_515_0 = {
			zh = 4.533,
			ja = 8.833
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
				arg_515_0:Play123101129(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["1055ui_story"]
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.characterEffect1055ui_story == nil then
				arg_515_1.var_.characterEffect1055ui_story = var_518_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_2 = 0.200000002980232

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 and not isNil(var_518_0) then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2

				if arg_515_1.var_.characterEffect1055ui_story and not isNil(var_518_0) then
					local var_518_4 = Mathf.Lerp(0, 0.5, var_518_3)

					arg_515_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1055ui_story.fillRatio = var_518_4
				end
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.characterEffect1055ui_story then
				local var_518_5 = 0.5

				arg_515_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1055ui_story.fillRatio = var_518_5
			end

			local var_518_6 = 0
			local var_518_7 = 0.5

			if var_518_6 < arg_515_1.time_ and arg_515_1.time_ <= var_518_6 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_8 = arg_515_1:FormatText(StoryNameCfg[497].name)

				arg_515_1.leftNameTxt_.text = var_518_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_9 = arg_515_1:GetWordFromCfg(123101128)
				local var_518_10 = arg_515_1:FormatText(var_518_9.content)

				arg_515_1.text_.text = var_518_10

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_11 = 20
				local var_518_12 = utf8.len(var_518_10)
				local var_518_13 = var_518_11 <= 0 and var_518_7 or var_518_7 * (var_518_12 / var_518_11)

				if var_518_13 > 0 and var_518_7 < var_518_13 then
					arg_515_1.talkMaxDuration = var_518_13

					if var_518_13 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_13 + var_518_6
					end
				end

				arg_515_1.text_.text = var_518_10
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101128", "story_v_out_123101.awb") ~= 0 then
					local var_518_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101128", "story_v_out_123101.awb") / 1000

					if var_518_14 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_14 + var_518_6
					end

					if var_518_9.prefab_name ~= "" and arg_515_1.actors_[var_518_9.prefab_name] ~= nil then
						local var_518_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_9.prefab_name].transform, "story_v_out_123101", "123101128", "story_v_out_123101.awb")

						arg_515_1:RecordAudio("123101128", var_518_15)
						arg_515_1:RecordAudio("123101128", var_518_15)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_123101", "123101128", "story_v_out_123101.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_123101", "123101128", "story_v_out_123101.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_16 = math.max(var_518_7, arg_515_1.talkMaxDuration)

			if var_518_6 <= arg_515_1.time_ and arg_515_1.time_ < var_518_6 + var_518_16 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_6) / var_518_16

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_6 + var_518_16 and arg_515_1.time_ < var_518_6 + var_518_16 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play123101129 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 123101129
		arg_519_1.duration_ = 3.43

		local var_519_0 = {
			zh = 3.433,
			ja = 3.1
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
				arg_519_0:Play123101130(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["1055ui_story"]
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.characterEffect1055ui_story == nil then
				arg_519_1.var_.characterEffect1055ui_story = var_522_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 and not isNil(var_522_0) then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2

				if arg_519_1.var_.characterEffect1055ui_story and not isNil(var_522_0) then
					arg_519_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.characterEffect1055ui_story then
				arg_519_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_522_4 = 0

			if var_522_4 < arg_519_1.time_ and arg_519_1.time_ <= var_522_4 + arg_522_0 then
				arg_519_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_2")
			end

			local var_522_5 = 0

			if var_522_5 < arg_519_1.time_ and arg_519_1.time_ <= var_522_5 + arg_522_0 then
				arg_519_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_522_6 = 0
			local var_522_7 = 0.425

			if var_522_6 < arg_519_1.time_ and arg_519_1.time_ <= var_522_6 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_8 = arg_519_1:FormatText(StoryNameCfg[481].name)

				arg_519_1.leftNameTxt_.text = var_522_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_9 = arg_519_1:GetWordFromCfg(123101129)
				local var_522_10 = arg_519_1:FormatText(var_522_9.content)

				arg_519_1.text_.text = var_522_10

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_11 = 17
				local var_522_12 = utf8.len(var_522_10)
				local var_522_13 = var_522_11 <= 0 and var_522_7 or var_522_7 * (var_522_12 / var_522_11)

				if var_522_13 > 0 and var_522_7 < var_522_13 then
					arg_519_1.talkMaxDuration = var_522_13

					if var_522_13 + var_522_6 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_13 + var_522_6
					end
				end

				arg_519_1.text_.text = var_522_10
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101129", "story_v_out_123101.awb") ~= 0 then
					local var_522_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101129", "story_v_out_123101.awb") / 1000

					if var_522_14 + var_522_6 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_14 + var_522_6
					end

					if var_522_9.prefab_name ~= "" and arg_519_1.actors_[var_522_9.prefab_name] ~= nil then
						local var_522_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_9.prefab_name].transform, "story_v_out_123101", "123101129", "story_v_out_123101.awb")

						arg_519_1:RecordAudio("123101129", var_522_15)
						arg_519_1:RecordAudio("123101129", var_522_15)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_123101", "123101129", "story_v_out_123101.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_123101", "123101129", "story_v_out_123101.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_16 = math.max(var_522_7, arg_519_1.talkMaxDuration)

			if var_522_6 <= arg_519_1.time_ and arg_519_1.time_ < var_522_6 + var_522_16 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_6) / var_522_16

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_6 + var_522_16 and arg_519_1.time_ < var_522_6 + var_522_16 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play123101130 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 123101130
		arg_523_1.duration_ = 4.2

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play123101131(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["1055ui_story"]
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.characterEffect1055ui_story == nil then
				arg_523_1.var_.characterEffect1055ui_story = var_526_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_2 = 0.200000002980232

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_2 and not isNil(var_526_0) then
				local var_526_3 = (arg_523_1.time_ - var_526_1) / var_526_2

				if arg_523_1.var_.characterEffect1055ui_story and not isNil(var_526_0) then
					local var_526_4 = Mathf.Lerp(0, 0.5, var_526_3)

					arg_523_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1055ui_story.fillRatio = var_526_4
				end
			end

			if arg_523_1.time_ >= var_526_1 + var_526_2 and arg_523_1.time_ < var_526_1 + var_526_2 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.characterEffect1055ui_story then
				local var_526_5 = 0.5

				arg_523_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1055ui_story.fillRatio = var_526_5
			end

			local var_526_6 = 0
			local var_526_7 = 0.375

			if var_526_6 < arg_523_1.time_ and arg_523_1.time_ <= var_526_6 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_8 = arg_523_1:FormatText(StoryNameCfg[497].name)

				arg_523_1.leftNameTxt_.text = var_526_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_9 = arg_523_1:GetWordFromCfg(123101130)
				local var_526_10 = arg_523_1:FormatText(var_526_9.content)

				arg_523_1.text_.text = var_526_10

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_11 = 15
				local var_526_12 = utf8.len(var_526_10)
				local var_526_13 = var_526_11 <= 0 and var_526_7 or var_526_7 * (var_526_12 / var_526_11)

				if var_526_13 > 0 and var_526_7 < var_526_13 then
					arg_523_1.talkMaxDuration = var_526_13

					if var_526_13 + var_526_6 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_13 + var_526_6
					end
				end

				arg_523_1.text_.text = var_526_10
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101130", "story_v_out_123101.awb") ~= 0 then
					local var_526_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101130", "story_v_out_123101.awb") / 1000

					if var_526_14 + var_526_6 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_14 + var_526_6
					end

					if var_526_9.prefab_name ~= "" and arg_523_1.actors_[var_526_9.prefab_name] ~= nil then
						local var_526_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_9.prefab_name].transform, "story_v_out_123101", "123101130", "story_v_out_123101.awb")

						arg_523_1:RecordAudio("123101130", var_526_15)
						arg_523_1:RecordAudio("123101130", var_526_15)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_123101", "123101130", "story_v_out_123101.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_123101", "123101130", "story_v_out_123101.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_16 = math.max(var_526_7, arg_523_1.talkMaxDuration)

			if var_526_6 <= arg_523_1.time_ and arg_523_1.time_ < var_526_6 + var_526_16 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_6) / var_526_16

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_6 + var_526_16 and arg_523_1.time_ < var_526_6 + var_526_16 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play123101131 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 123101131
		arg_527_1.duration_ = 8.9

		local var_527_0 = {
			zh = 8.466,
			ja = 8.9
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
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play123101132(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0
			local var_530_1 = 0.8

			if var_530_0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_2 = arg_527_1:FormatText(StoryNameCfg[497].name)

				arg_527_1.leftNameTxt_.text = var_530_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_3 = arg_527_1:GetWordFromCfg(123101131)
				local var_530_4 = arg_527_1:FormatText(var_530_3.content)

				arg_527_1.text_.text = var_530_4

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_5 = 32
				local var_530_6 = utf8.len(var_530_4)
				local var_530_7 = var_530_5 <= 0 and var_530_1 or var_530_1 * (var_530_6 / var_530_5)

				if var_530_7 > 0 and var_530_1 < var_530_7 then
					arg_527_1.talkMaxDuration = var_530_7

					if var_530_7 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_7 + var_530_0
					end
				end

				arg_527_1.text_.text = var_530_4
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101131", "story_v_out_123101.awb") ~= 0 then
					local var_530_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101131", "story_v_out_123101.awb") / 1000

					if var_530_8 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_8 + var_530_0
					end

					if var_530_3.prefab_name ~= "" and arg_527_1.actors_[var_530_3.prefab_name] ~= nil then
						local var_530_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_3.prefab_name].transform, "story_v_out_123101", "123101131", "story_v_out_123101.awb")

						arg_527_1:RecordAudio("123101131", var_530_9)
						arg_527_1:RecordAudio("123101131", var_530_9)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_123101", "123101131", "story_v_out_123101.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_123101", "123101131", "story_v_out_123101.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_10 = math.max(var_530_1, arg_527_1.talkMaxDuration)

			if var_530_0 <= arg_527_1.time_ and arg_527_1.time_ < var_530_0 + var_530_10 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_0) / var_530_10

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_0 + var_530_10 and arg_527_1.time_ < var_530_0 + var_530_10 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play123101132 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 123101132
		arg_531_1.duration_ = 4.6

		local var_531_0 = {
			zh = 4.6,
			ja = 2.033
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play123101133(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = arg_531_1.actors_["1055ui_story"].transform
			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.var_.moveOldPos1055ui_story = var_534_0.localPosition
			end

			local var_534_2 = 0.001

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_2 then
				local var_534_3 = (arg_531_1.time_ - var_534_1) / var_534_2
				local var_534_4 = Vector3.New(0, 100, 0)

				var_534_0.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1055ui_story, var_534_4, var_534_3)

				local var_534_5 = manager.ui.mainCamera.transform.position - var_534_0.position

				var_534_0.forward = Vector3.New(var_534_5.x, var_534_5.y, var_534_5.z)

				local var_534_6 = var_534_0.localEulerAngles

				var_534_6.z = 0
				var_534_6.x = 0
				var_534_0.localEulerAngles = var_534_6
			end

			if arg_531_1.time_ >= var_534_1 + var_534_2 and arg_531_1.time_ < var_534_1 + var_534_2 + arg_534_0 then
				var_534_0.localPosition = Vector3.New(0, 100, 0)

				local var_534_7 = manager.ui.mainCamera.transform.position - var_534_0.position

				var_534_0.forward = Vector3.New(var_534_7.x, var_534_7.y, var_534_7.z)

				local var_534_8 = var_534_0.localEulerAngles

				var_534_8.z = 0
				var_534_8.x = 0
				var_534_0.localEulerAngles = var_534_8
			end

			local var_534_9 = arg_531_1.actors_["1055ui_story"]
			local var_534_10 = 0

			if var_534_10 < arg_531_1.time_ and arg_531_1.time_ <= var_534_10 + arg_534_0 and not isNil(var_534_9) and arg_531_1.var_.characterEffect1055ui_story == nil then
				arg_531_1.var_.characterEffect1055ui_story = var_534_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_11 = 0.200000002980232

			if var_534_10 <= arg_531_1.time_ and arg_531_1.time_ < var_534_10 + var_534_11 and not isNil(var_534_9) then
				local var_534_12 = (arg_531_1.time_ - var_534_10) / var_534_11

				if arg_531_1.var_.characterEffect1055ui_story and not isNil(var_534_9) then
					local var_534_13 = Mathf.Lerp(0, 0.5, var_534_12)

					arg_531_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1055ui_story.fillRatio = var_534_13
				end
			end

			if arg_531_1.time_ >= var_534_10 + var_534_11 and arg_531_1.time_ < var_534_10 + var_534_11 + arg_534_0 and not isNil(var_534_9) and arg_531_1.var_.characterEffect1055ui_story then
				local var_534_14 = 0.5

				arg_531_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1055ui_story.fillRatio = var_534_14
			end

			local var_534_15 = arg_531_1.actors_["1093ui_story"].transform
			local var_534_16 = 0

			if var_534_16 < arg_531_1.time_ and arg_531_1.time_ <= var_534_16 + arg_534_0 then
				arg_531_1.var_.moveOldPos1093ui_story = var_534_15.localPosition
			end

			local var_534_17 = 0.001

			if var_534_16 <= arg_531_1.time_ and arg_531_1.time_ < var_534_16 + var_534_17 then
				local var_534_18 = (arg_531_1.time_ - var_534_16) / var_534_17
				local var_534_19 = Vector3.New(0, -1.11, -5.88)

				var_534_15.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1093ui_story, var_534_19, var_534_18)

				local var_534_20 = manager.ui.mainCamera.transform.position - var_534_15.position

				var_534_15.forward = Vector3.New(var_534_20.x, var_534_20.y, var_534_20.z)

				local var_534_21 = var_534_15.localEulerAngles

				var_534_21.z = 0
				var_534_21.x = 0
				var_534_15.localEulerAngles = var_534_21
			end

			if arg_531_1.time_ >= var_534_16 + var_534_17 and arg_531_1.time_ < var_534_16 + var_534_17 + arg_534_0 then
				var_534_15.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_534_22 = manager.ui.mainCamera.transform.position - var_534_15.position

				var_534_15.forward = Vector3.New(var_534_22.x, var_534_22.y, var_534_22.z)

				local var_534_23 = var_534_15.localEulerAngles

				var_534_23.z = 0
				var_534_23.x = 0
				var_534_15.localEulerAngles = var_534_23
			end

			local var_534_24 = arg_531_1.actors_["1093ui_story"]
			local var_534_25 = 0

			if var_534_25 < arg_531_1.time_ and arg_531_1.time_ <= var_534_25 + arg_534_0 and not isNil(var_534_24) and arg_531_1.var_.characterEffect1093ui_story == nil then
				arg_531_1.var_.characterEffect1093ui_story = var_534_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_26 = 0.200000002980232

			if var_534_25 <= arg_531_1.time_ and arg_531_1.time_ < var_534_25 + var_534_26 and not isNil(var_534_24) then
				local var_534_27 = (arg_531_1.time_ - var_534_25) / var_534_26

				if arg_531_1.var_.characterEffect1093ui_story and not isNil(var_534_24) then
					arg_531_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= var_534_25 + var_534_26 and arg_531_1.time_ < var_534_25 + var_534_26 + arg_534_0 and not isNil(var_534_24) and arg_531_1.var_.characterEffect1093ui_story then
				arg_531_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_534_28 = 0

			if var_534_28 < arg_531_1.time_ and arg_531_1.time_ <= var_534_28 + arg_534_0 then
				arg_531_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_534_29 = 0

			if var_534_29 < arg_531_1.time_ and arg_531_1.time_ <= var_534_29 + arg_534_0 then
				arg_531_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_534_30 = 0
			local var_534_31 = 0.225

			if var_534_30 < arg_531_1.time_ and arg_531_1.time_ <= var_534_30 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_32 = arg_531_1:FormatText(StoryNameCfg[73].name)

				arg_531_1.leftNameTxt_.text = var_534_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_33 = arg_531_1:GetWordFromCfg(123101132)
				local var_534_34 = arg_531_1:FormatText(var_534_33.content)

				arg_531_1.text_.text = var_534_34

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_35 = 9
				local var_534_36 = utf8.len(var_534_34)
				local var_534_37 = var_534_35 <= 0 and var_534_31 or var_534_31 * (var_534_36 / var_534_35)

				if var_534_37 > 0 and var_534_31 < var_534_37 then
					arg_531_1.talkMaxDuration = var_534_37

					if var_534_37 + var_534_30 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_37 + var_534_30
					end
				end

				arg_531_1.text_.text = var_534_34
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101132", "story_v_out_123101.awb") ~= 0 then
					local var_534_38 = manager.audio:GetVoiceLength("story_v_out_123101", "123101132", "story_v_out_123101.awb") / 1000

					if var_534_38 + var_534_30 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_38 + var_534_30
					end

					if var_534_33.prefab_name ~= "" and arg_531_1.actors_[var_534_33.prefab_name] ~= nil then
						local var_534_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_33.prefab_name].transform, "story_v_out_123101", "123101132", "story_v_out_123101.awb")

						arg_531_1:RecordAudio("123101132", var_534_39)
						arg_531_1:RecordAudio("123101132", var_534_39)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_123101", "123101132", "story_v_out_123101.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_123101", "123101132", "story_v_out_123101.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_40 = math.max(var_534_31, arg_531_1.talkMaxDuration)

			if var_534_30 <= arg_531_1.time_ and arg_531_1.time_ < var_534_30 + var_534_40 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_30) / var_534_40

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_30 + var_534_40 and arg_531_1.time_ < var_534_30 + var_534_40 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play123101133 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 123101133
		arg_535_1.duration_ = 2.37

		local var_535_0 = {
			zh = 2.366,
			ja = 1.999999999999
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play123101134(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.actors_["1093ui_story"]
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 and not isNil(var_538_0) and arg_535_1.var_.characterEffect1093ui_story == nil then
				arg_535_1.var_.characterEffect1093ui_story = var_538_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_2 = 0.200000002980232

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_2 and not isNil(var_538_0) then
				local var_538_3 = (arg_535_1.time_ - var_538_1) / var_538_2

				if arg_535_1.var_.characterEffect1093ui_story and not isNil(var_538_0) then
					local var_538_4 = Mathf.Lerp(0, 0.5, var_538_3)

					arg_535_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1093ui_story.fillRatio = var_538_4
				end
			end

			if arg_535_1.time_ >= var_538_1 + var_538_2 and arg_535_1.time_ < var_538_1 + var_538_2 + arg_538_0 and not isNil(var_538_0) and arg_535_1.var_.characterEffect1093ui_story then
				local var_538_5 = 0.5

				arg_535_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1093ui_story.fillRatio = var_538_5
			end

			local var_538_6 = 0

			if var_538_6 < arg_535_1.time_ and arg_535_1.time_ <= var_538_6 + arg_538_0 then
				arg_535_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_538_7 = 0
			local var_538_8 = 0.15

			if var_538_7 < arg_535_1.time_ and arg_535_1.time_ <= var_538_7 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_9 = arg_535_1:FormatText(StoryNameCfg[497].name)

				arg_535_1.leftNameTxt_.text = var_538_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_10 = arg_535_1:GetWordFromCfg(123101133)
				local var_538_11 = arg_535_1:FormatText(var_538_10.content)

				arg_535_1.text_.text = var_538_11

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_12 = 6
				local var_538_13 = utf8.len(var_538_11)
				local var_538_14 = var_538_12 <= 0 and var_538_8 or var_538_8 * (var_538_13 / var_538_12)

				if var_538_14 > 0 and var_538_8 < var_538_14 then
					arg_535_1.talkMaxDuration = var_538_14

					if var_538_14 + var_538_7 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_14 + var_538_7
					end
				end

				arg_535_1.text_.text = var_538_11
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101133", "story_v_out_123101.awb") ~= 0 then
					local var_538_15 = manager.audio:GetVoiceLength("story_v_out_123101", "123101133", "story_v_out_123101.awb") / 1000

					if var_538_15 + var_538_7 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_15 + var_538_7
					end

					if var_538_10.prefab_name ~= "" and arg_535_1.actors_[var_538_10.prefab_name] ~= nil then
						local var_538_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_10.prefab_name].transform, "story_v_out_123101", "123101133", "story_v_out_123101.awb")

						arg_535_1:RecordAudio("123101133", var_538_16)
						arg_535_1:RecordAudio("123101133", var_538_16)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_123101", "123101133", "story_v_out_123101.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_123101", "123101133", "story_v_out_123101.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_17 = math.max(var_538_8, arg_535_1.talkMaxDuration)

			if var_538_7 <= arg_535_1.time_ and arg_535_1.time_ < var_538_7 + var_538_17 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_7) / var_538_17

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_7 + var_538_17 and arg_535_1.time_ < var_538_7 + var_538_17 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play123101134 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 123101134
		arg_539_1.duration_ = 6.07

		local var_539_0 = {
			zh = 3.666,
			ja = 6.066
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play123101135(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = arg_539_1.actors_["1055ui_story"].transform
			local var_542_1 = 0

			if var_542_1 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 then
				arg_539_1.var_.moveOldPos1055ui_story = var_542_0.localPosition
			end

			local var_542_2 = 0.001

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_2 then
				local var_542_3 = (arg_539_1.time_ - var_542_1) / var_542_2
				local var_542_4 = Vector3.New(0, -0.965, -6.2)

				var_542_0.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos1055ui_story, var_542_4, var_542_3)

				local var_542_5 = manager.ui.mainCamera.transform.position - var_542_0.position

				var_542_0.forward = Vector3.New(var_542_5.x, var_542_5.y, var_542_5.z)

				local var_542_6 = var_542_0.localEulerAngles

				var_542_6.z = 0
				var_542_6.x = 0
				var_542_0.localEulerAngles = var_542_6
			end

			if arg_539_1.time_ >= var_542_1 + var_542_2 and arg_539_1.time_ < var_542_1 + var_542_2 + arg_542_0 then
				var_542_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_542_7 = manager.ui.mainCamera.transform.position - var_542_0.position

				var_542_0.forward = Vector3.New(var_542_7.x, var_542_7.y, var_542_7.z)

				local var_542_8 = var_542_0.localEulerAngles

				var_542_8.z = 0
				var_542_8.x = 0
				var_542_0.localEulerAngles = var_542_8
			end

			local var_542_9 = arg_539_1.actors_["1055ui_story"]
			local var_542_10 = 0

			if var_542_10 < arg_539_1.time_ and arg_539_1.time_ <= var_542_10 + arg_542_0 and not isNil(var_542_9) and arg_539_1.var_.characterEffect1055ui_story == nil then
				arg_539_1.var_.characterEffect1055ui_story = var_542_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_11 = 0.200000002980232

			if var_542_10 <= arg_539_1.time_ and arg_539_1.time_ < var_542_10 + var_542_11 and not isNil(var_542_9) then
				local var_542_12 = (arg_539_1.time_ - var_542_10) / var_542_11

				if arg_539_1.var_.characterEffect1055ui_story and not isNil(var_542_9) then
					arg_539_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_539_1.time_ >= var_542_10 + var_542_11 and arg_539_1.time_ < var_542_10 + var_542_11 + arg_542_0 and not isNil(var_542_9) and arg_539_1.var_.characterEffect1055ui_story then
				arg_539_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_542_13 = 0

			if var_542_13 < arg_539_1.time_ and arg_539_1.time_ <= var_542_13 + arg_542_0 then
				arg_539_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_542_14 = 0

			if var_542_14 < arg_539_1.time_ and arg_539_1.time_ <= var_542_14 + arg_542_0 then
				arg_539_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_542_15 = arg_539_1.actors_["1093ui_story"].transform
			local var_542_16 = 0

			if var_542_16 < arg_539_1.time_ and arg_539_1.time_ <= var_542_16 + arg_542_0 then
				arg_539_1.var_.moveOldPos1093ui_story = var_542_15.localPosition
			end

			local var_542_17 = 0.001

			if var_542_16 <= arg_539_1.time_ and arg_539_1.time_ < var_542_16 + var_542_17 then
				local var_542_18 = (arg_539_1.time_ - var_542_16) / var_542_17
				local var_542_19 = Vector3.New(0, 100, 0)

				var_542_15.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos1093ui_story, var_542_19, var_542_18)

				local var_542_20 = manager.ui.mainCamera.transform.position - var_542_15.position

				var_542_15.forward = Vector3.New(var_542_20.x, var_542_20.y, var_542_20.z)

				local var_542_21 = var_542_15.localEulerAngles

				var_542_21.z = 0
				var_542_21.x = 0
				var_542_15.localEulerAngles = var_542_21
			end

			if arg_539_1.time_ >= var_542_16 + var_542_17 and arg_539_1.time_ < var_542_16 + var_542_17 + arg_542_0 then
				var_542_15.localPosition = Vector3.New(0, 100, 0)

				local var_542_22 = manager.ui.mainCamera.transform.position - var_542_15.position

				var_542_15.forward = Vector3.New(var_542_22.x, var_542_22.y, var_542_22.z)

				local var_542_23 = var_542_15.localEulerAngles

				var_542_23.z = 0
				var_542_23.x = 0
				var_542_15.localEulerAngles = var_542_23
			end

			local var_542_24 = 0
			local var_542_25 = 0.425

			if var_542_24 < arg_539_1.time_ and arg_539_1.time_ <= var_542_24 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_26 = arg_539_1:FormatText(StoryNameCfg[481].name)

				arg_539_1.leftNameTxt_.text = var_542_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_27 = arg_539_1:GetWordFromCfg(123101134)
				local var_542_28 = arg_539_1:FormatText(var_542_27.content)

				arg_539_1.text_.text = var_542_28

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_29 = 17
				local var_542_30 = utf8.len(var_542_28)
				local var_542_31 = var_542_29 <= 0 and var_542_25 or var_542_25 * (var_542_30 / var_542_29)

				if var_542_31 > 0 and var_542_25 < var_542_31 then
					arg_539_1.talkMaxDuration = var_542_31

					if var_542_31 + var_542_24 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_31 + var_542_24
					end
				end

				arg_539_1.text_.text = var_542_28
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101134", "story_v_out_123101.awb") ~= 0 then
					local var_542_32 = manager.audio:GetVoiceLength("story_v_out_123101", "123101134", "story_v_out_123101.awb") / 1000

					if var_542_32 + var_542_24 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_32 + var_542_24
					end

					if var_542_27.prefab_name ~= "" and arg_539_1.actors_[var_542_27.prefab_name] ~= nil then
						local var_542_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_27.prefab_name].transform, "story_v_out_123101", "123101134", "story_v_out_123101.awb")

						arg_539_1:RecordAudio("123101134", var_542_33)
						arg_539_1:RecordAudio("123101134", var_542_33)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_123101", "123101134", "story_v_out_123101.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_123101", "123101134", "story_v_out_123101.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_34 = math.max(var_542_25, arg_539_1.talkMaxDuration)

			if var_542_24 <= arg_539_1.time_ and arg_539_1.time_ < var_542_24 + var_542_34 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_24) / var_542_34

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_24 + var_542_34 and arg_539_1.time_ < var_542_24 + var_542_34 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_539_1:InitPlayNodeList()
	end,
	Play123101135 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 123101135
		arg_543_1.duration_ = 3.9

		local var_543_0 = {
			zh = 3.9,
			ja = 3.566
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play123101136(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = arg_543_1.actors_["1055ui_story"]
			local var_546_1 = 0

			if var_546_1 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 and not isNil(var_546_0) and arg_543_1.var_.characterEffect1055ui_story == nil then
				arg_543_1.var_.characterEffect1055ui_story = var_546_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_2 = 0.200000002980232

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_2 and not isNil(var_546_0) then
				local var_546_3 = (arg_543_1.time_ - var_546_1) / var_546_2

				if arg_543_1.var_.characterEffect1055ui_story and not isNil(var_546_0) then
					local var_546_4 = Mathf.Lerp(0, 0.5, var_546_3)

					arg_543_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_543_1.var_.characterEffect1055ui_story.fillRatio = var_546_4
				end
			end

			if arg_543_1.time_ >= var_546_1 + var_546_2 and arg_543_1.time_ < var_546_1 + var_546_2 + arg_546_0 and not isNil(var_546_0) and arg_543_1.var_.characterEffect1055ui_story then
				local var_546_5 = 0.5

				arg_543_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_543_1.var_.characterEffect1055ui_story.fillRatio = var_546_5
			end

			local var_546_6 = 0
			local var_546_7 = 0.425

			if var_546_6 < arg_543_1.time_ and arg_543_1.time_ <= var_546_6 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_8 = arg_543_1:FormatText(StoryNameCfg[497].name)

				arg_543_1.leftNameTxt_.text = var_546_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, true)
				arg_543_1.iconController_:SetSelectedState("hero")

				arg_543_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_543_1.callingController_:SetSelectedState("normal")

				arg_543_1.keyicon_.color = Color.New(1, 1, 1)
				arg_543_1.icon_.color = Color.New(1, 1, 1)

				local var_546_9 = arg_543_1:GetWordFromCfg(123101135)
				local var_546_10 = arg_543_1:FormatText(var_546_9.content)

				arg_543_1.text_.text = var_546_10

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_11 = 17
				local var_546_12 = utf8.len(var_546_10)
				local var_546_13 = var_546_11 <= 0 and var_546_7 or var_546_7 * (var_546_12 / var_546_11)

				if var_546_13 > 0 and var_546_7 < var_546_13 then
					arg_543_1.talkMaxDuration = var_546_13

					if var_546_13 + var_546_6 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_13 + var_546_6
					end
				end

				arg_543_1.text_.text = var_546_10
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101135", "story_v_out_123101.awb") ~= 0 then
					local var_546_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101135", "story_v_out_123101.awb") / 1000

					if var_546_14 + var_546_6 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_14 + var_546_6
					end

					if var_546_9.prefab_name ~= "" and arg_543_1.actors_[var_546_9.prefab_name] ~= nil then
						local var_546_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_9.prefab_name].transform, "story_v_out_123101", "123101135", "story_v_out_123101.awb")

						arg_543_1:RecordAudio("123101135", var_546_15)
						arg_543_1:RecordAudio("123101135", var_546_15)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_123101", "123101135", "story_v_out_123101.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_123101", "123101135", "story_v_out_123101.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_16 = math.max(var_546_7, arg_543_1.talkMaxDuration)

			if var_546_6 <= arg_543_1.time_ and arg_543_1.time_ < var_546_6 + var_546_16 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_6) / var_546_16

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_6 + var_546_16 and arg_543_1.time_ < var_546_6 + var_546_16 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play123101136 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 123101136
		arg_547_1.duration_ = 4.73

		local var_547_0 = {
			zh = 4.266,
			ja = 4.733
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play123101137(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["1055ui_story"]
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.characterEffect1055ui_story == nil then
				arg_547_1.var_.characterEffect1055ui_story = var_550_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_2 = 0.200000002980232

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 and not isNil(var_550_0) then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2

				if arg_547_1.var_.characterEffect1055ui_story and not isNil(var_550_0) then
					arg_547_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.characterEffect1055ui_story then
				arg_547_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_550_4 = 0

			if var_550_4 < arg_547_1.time_ and arg_547_1.time_ <= var_550_4 + arg_550_0 then
				arg_547_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_550_5 = 0

			if var_550_5 < arg_547_1.time_ and arg_547_1.time_ <= var_550_5 + arg_550_0 then
				arg_547_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_550_6 = 0
			local var_550_7 = 0.4

			if var_550_6 < arg_547_1.time_ and arg_547_1.time_ <= var_550_6 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				local var_550_8 = arg_547_1:FormatText(StoryNameCfg[481].name)

				arg_547_1.leftNameTxt_.text = var_550_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_9 = arg_547_1:GetWordFromCfg(123101136)
				local var_550_10 = arg_547_1:FormatText(var_550_9.content)

				arg_547_1.text_.text = var_550_10

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_11 = 16
				local var_550_12 = utf8.len(var_550_10)
				local var_550_13 = var_550_11 <= 0 and var_550_7 or var_550_7 * (var_550_12 / var_550_11)

				if var_550_13 > 0 and var_550_7 < var_550_13 then
					arg_547_1.talkMaxDuration = var_550_13

					if var_550_13 + var_550_6 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_13 + var_550_6
					end
				end

				arg_547_1.text_.text = var_550_10
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101136", "story_v_out_123101.awb") ~= 0 then
					local var_550_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101136", "story_v_out_123101.awb") / 1000

					if var_550_14 + var_550_6 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_14 + var_550_6
					end

					if var_550_9.prefab_name ~= "" and arg_547_1.actors_[var_550_9.prefab_name] ~= nil then
						local var_550_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_9.prefab_name].transform, "story_v_out_123101", "123101136", "story_v_out_123101.awb")

						arg_547_1:RecordAudio("123101136", var_550_15)
						arg_547_1:RecordAudio("123101136", var_550_15)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_123101", "123101136", "story_v_out_123101.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_123101", "123101136", "story_v_out_123101.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_16 = math.max(var_550_7, arg_547_1.talkMaxDuration)

			if var_550_6 <= arg_547_1.time_ and arg_547_1.time_ < var_550_6 + var_550_16 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_6) / var_550_16

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_6 + var_550_16 and arg_547_1.time_ < var_550_6 + var_550_16 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play123101137 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 123101137
		arg_551_1.duration_ = 7.53

		local var_551_0 = {
			zh = 4.6,
			ja = 7.533
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play123101138(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = arg_551_1.actors_["1055ui_story"]
			local var_554_1 = 0

			if var_554_1 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.characterEffect1055ui_story == nil then
				arg_551_1.var_.characterEffect1055ui_story = var_554_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_2 = 0.200000002980232

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_2 and not isNil(var_554_0) then
				local var_554_3 = (arg_551_1.time_ - var_554_1) / var_554_2

				if arg_551_1.var_.characterEffect1055ui_story and not isNil(var_554_0) then
					local var_554_4 = Mathf.Lerp(0, 0.5, var_554_3)

					arg_551_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_551_1.var_.characterEffect1055ui_story.fillRatio = var_554_4
				end
			end

			if arg_551_1.time_ >= var_554_1 + var_554_2 and arg_551_1.time_ < var_554_1 + var_554_2 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.characterEffect1055ui_story then
				local var_554_5 = 0.5

				arg_551_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_551_1.var_.characterEffect1055ui_story.fillRatio = var_554_5
			end

			local var_554_6 = 0
			local var_554_7 = 0.5

			if var_554_6 < arg_551_1.time_ and arg_551_1.time_ <= var_554_6 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_8 = arg_551_1:FormatText(StoryNameCfg[497].name)

				arg_551_1.leftNameTxt_.text = var_554_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_9 = arg_551_1:GetWordFromCfg(123101137)
				local var_554_10 = arg_551_1:FormatText(var_554_9.content)

				arg_551_1.text_.text = var_554_10

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_11 = 20
				local var_554_12 = utf8.len(var_554_10)
				local var_554_13 = var_554_11 <= 0 and var_554_7 or var_554_7 * (var_554_12 / var_554_11)

				if var_554_13 > 0 and var_554_7 < var_554_13 then
					arg_551_1.talkMaxDuration = var_554_13

					if var_554_13 + var_554_6 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_13 + var_554_6
					end
				end

				arg_551_1.text_.text = var_554_10
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101137", "story_v_out_123101.awb") ~= 0 then
					local var_554_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101137", "story_v_out_123101.awb") / 1000

					if var_554_14 + var_554_6 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_14 + var_554_6
					end

					if var_554_9.prefab_name ~= "" and arg_551_1.actors_[var_554_9.prefab_name] ~= nil then
						local var_554_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_9.prefab_name].transform, "story_v_out_123101", "123101137", "story_v_out_123101.awb")

						arg_551_1:RecordAudio("123101137", var_554_15)
						arg_551_1:RecordAudio("123101137", var_554_15)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_123101", "123101137", "story_v_out_123101.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_123101", "123101137", "story_v_out_123101.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_16 = math.max(var_554_7, arg_551_1.talkMaxDuration)

			if var_554_6 <= arg_551_1.time_ and arg_551_1.time_ < var_554_6 + var_554_16 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_6) / var_554_16

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_6 + var_554_16 and arg_551_1.time_ < var_554_6 + var_554_16 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play123101138 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 123101138
		arg_555_1.duration_ = 9.07

		local var_555_0 = {
			zh = 6.8,
			ja = 9.066
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play123101139(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = arg_555_1.actors_["1055ui_story"]
			local var_558_1 = 0

			if var_558_1 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 and not isNil(var_558_0) and arg_555_1.var_.characterEffect1055ui_story == nil then
				arg_555_1.var_.characterEffect1055ui_story = var_558_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_2 = 0.200000002980232

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_2 and not isNil(var_558_0) then
				local var_558_3 = (arg_555_1.time_ - var_558_1) / var_558_2

				if arg_555_1.var_.characterEffect1055ui_story and not isNil(var_558_0) then
					arg_555_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_555_1.time_ >= var_558_1 + var_558_2 and arg_555_1.time_ < var_558_1 + var_558_2 + arg_558_0 and not isNil(var_558_0) and arg_555_1.var_.characterEffect1055ui_story then
				arg_555_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_558_4 = 0

			if var_558_4 < arg_555_1.time_ and arg_555_1.time_ <= var_558_4 + arg_558_0 then
				arg_555_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_558_5 = 0

			if var_558_5 < arg_555_1.time_ and arg_555_1.time_ <= var_558_5 + arg_558_0 then
				arg_555_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_558_6 = 0
			local var_558_7 = 0.675

			if var_558_6 < arg_555_1.time_ and arg_555_1.time_ <= var_558_6 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				local var_558_8 = arg_555_1:FormatText(StoryNameCfg[481].name)

				arg_555_1.leftNameTxt_.text = var_558_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_9 = arg_555_1:GetWordFromCfg(123101138)
				local var_558_10 = arg_555_1:FormatText(var_558_9.content)

				arg_555_1.text_.text = var_558_10

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_11 = 27
				local var_558_12 = utf8.len(var_558_10)
				local var_558_13 = var_558_11 <= 0 and var_558_7 or var_558_7 * (var_558_12 / var_558_11)

				if var_558_13 > 0 and var_558_7 < var_558_13 then
					arg_555_1.talkMaxDuration = var_558_13

					if var_558_13 + var_558_6 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_13 + var_558_6
					end
				end

				arg_555_1.text_.text = var_558_10
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101138", "story_v_out_123101.awb") ~= 0 then
					local var_558_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101138", "story_v_out_123101.awb") / 1000

					if var_558_14 + var_558_6 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_14 + var_558_6
					end

					if var_558_9.prefab_name ~= "" and arg_555_1.actors_[var_558_9.prefab_name] ~= nil then
						local var_558_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_9.prefab_name].transform, "story_v_out_123101", "123101138", "story_v_out_123101.awb")

						arg_555_1:RecordAudio("123101138", var_558_15)
						arg_555_1:RecordAudio("123101138", var_558_15)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_out_123101", "123101138", "story_v_out_123101.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_out_123101", "123101138", "story_v_out_123101.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_16 = math.max(var_558_7, arg_555_1.talkMaxDuration)

			if var_558_6 <= arg_555_1.time_ and arg_555_1.time_ < var_558_6 + var_558_16 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_6) / var_558_16

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_6 + var_558_16 and arg_555_1.time_ < var_558_6 + var_558_16 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play123101139 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 123101139
		arg_559_1.duration_ = 11.2

		local var_559_0 = {
			zh = 11.2,
			ja = 8.7
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play123101140(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0
			local var_562_1 = 1.15

			if var_562_0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				local var_562_2 = arg_559_1:FormatText(StoryNameCfg[481].name)

				arg_559_1.leftNameTxt_.text = var_562_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_3 = arg_559_1:GetWordFromCfg(123101139)
				local var_562_4 = arg_559_1:FormatText(var_562_3.content)

				arg_559_1.text_.text = var_562_4

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_5 = 46
				local var_562_6 = utf8.len(var_562_4)
				local var_562_7 = var_562_5 <= 0 and var_562_1 or var_562_1 * (var_562_6 / var_562_5)

				if var_562_7 > 0 and var_562_1 < var_562_7 then
					arg_559_1.talkMaxDuration = var_562_7

					if var_562_7 + var_562_0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_7 + var_562_0
					end
				end

				arg_559_1.text_.text = var_562_4
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101139", "story_v_out_123101.awb") ~= 0 then
					local var_562_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101139", "story_v_out_123101.awb") / 1000

					if var_562_8 + var_562_0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_8 + var_562_0
					end

					if var_562_3.prefab_name ~= "" and arg_559_1.actors_[var_562_3.prefab_name] ~= nil then
						local var_562_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_3.prefab_name].transform, "story_v_out_123101", "123101139", "story_v_out_123101.awb")

						arg_559_1:RecordAudio("123101139", var_562_9)
						arg_559_1:RecordAudio("123101139", var_562_9)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_out_123101", "123101139", "story_v_out_123101.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_out_123101", "123101139", "story_v_out_123101.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_10 = math.max(var_562_1, arg_559_1.talkMaxDuration)

			if var_562_0 <= arg_559_1.time_ and arg_559_1.time_ < var_562_0 + var_562_10 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_0) / var_562_10

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_0 + var_562_10 and arg_559_1.time_ < var_562_0 + var_562_10 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play123101140 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 123101140
		arg_563_1.duration_ = 4.2

		local var_563_0 = {
			zh = 2.066,
			ja = 4.2
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play123101141(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = arg_563_1.actors_["1055ui_story"]
			local var_566_1 = 0

			if var_566_1 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect1055ui_story == nil then
				arg_563_1.var_.characterEffect1055ui_story = var_566_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_2 = 0.200000002980232

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_2 and not isNil(var_566_0) then
				local var_566_3 = (arg_563_1.time_ - var_566_1) / var_566_2

				if arg_563_1.var_.characterEffect1055ui_story and not isNil(var_566_0) then
					local var_566_4 = Mathf.Lerp(0, 0.5, var_566_3)

					arg_563_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_563_1.var_.characterEffect1055ui_story.fillRatio = var_566_4
				end
			end

			if arg_563_1.time_ >= var_566_1 + var_566_2 and arg_563_1.time_ < var_566_1 + var_566_2 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect1055ui_story then
				local var_566_5 = 0.5

				arg_563_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_563_1.var_.characterEffect1055ui_story.fillRatio = var_566_5
			end

			local var_566_6 = 0
			local var_566_7 = 0.2

			if var_566_6 < arg_563_1.time_ and arg_563_1.time_ <= var_566_6 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_8 = arg_563_1:FormatText(StoryNameCfg[497].name)

				arg_563_1.leftNameTxt_.text = var_566_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_9 = arg_563_1:GetWordFromCfg(123101140)
				local var_566_10 = arg_563_1:FormatText(var_566_9.content)

				arg_563_1.text_.text = var_566_10

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_11 = 8
				local var_566_12 = utf8.len(var_566_10)
				local var_566_13 = var_566_11 <= 0 and var_566_7 or var_566_7 * (var_566_12 / var_566_11)

				if var_566_13 > 0 and var_566_7 < var_566_13 then
					arg_563_1.talkMaxDuration = var_566_13

					if var_566_13 + var_566_6 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_13 + var_566_6
					end
				end

				arg_563_1.text_.text = var_566_10
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101140", "story_v_out_123101.awb") ~= 0 then
					local var_566_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101140", "story_v_out_123101.awb") / 1000

					if var_566_14 + var_566_6 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_14 + var_566_6
					end

					if var_566_9.prefab_name ~= "" and arg_563_1.actors_[var_566_9.prefab_name] ~= nil then
						local var_566_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_9.prefab_name].transform, "story_v_out_123101", "123101140", "story_v_out_123101.awb")

						arg_563_1:RecordAudio("123101140", var_566_15)
						arg_563_1:RecordAudio("123101140", var_566_15)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_123101", "123101140", "story_v_out_123101.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_123101", "123101140", "story_v_out_123101.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_16 = math.max(var_566_7, arg_563_1.talkMaxDuration)

			if var_566_6 <= arg_563_1.time_ and arg_563_1.time_ < var_566_6 + var_566_16 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_6) / var_566_16

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_6 + var_566_16 and arg_563_1.time_ < var_566_6 + var_566_16 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play123101141 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 123101141
		arg_567_1.duration_ = 2

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play123101142(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = arg_567_1.actors_["1055ui_story"]
			local var_570_1 = 0

			if var_570_1 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 and not isNil(var_570_0) and arg_567_1.var_.characterEffect1055ui_story == nil then
				arg_567_1.var_.characterEffect1055ui_story = var_570_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_2 = 0.200000002980232

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_2 and not isNil(var_570_0) then
				local var_570_3 = (arg_567_1.time_ - var_570_1) / var_570_2

				if arg_567_1.var_.characterEffect1055ui_story and not isNil(var_570_0) then
					arg_567_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_567_1.time_ >= var_570_1 + var_570_2 and arg_567_1.time_ < var_570_1 + var_570_2 + arg_570_0 and not isNil(var_570_0) and arg_567_1.var_.characterEffect1055ui_story then
				arg_567_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_570_4 = 0

			if var_570_4 < arg_567_1.time_ and arg_567_1.time_ <= var_570_4 + arg_570_0 then
				arg_567_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_570_5 = 0

			if var_570_5 < arg_567_1.time_ and arg_567_1.time_ <= var_570_5 + arg_570_0 then
				arg_567_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_570_6 = 0
			local var_570_7 = 0.1

			if var_570_6 < arg_567_1.time_ and arg_567_1.time_ <= var_570_6 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_8 = arg_567_1:FormatText(StoryNameCfg[481].name)

				arg_567_1.leftNameTxt_.text = var_570_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_9 = arg_567_1:GetWordFromCfg(123101141)
				local var_570_10 = arg_567_1:FormatText(var_570_9.content)

				arg_567_1.text_.text = var_570_10

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_11 = 4
				local var_570_12 = utf8.len(var_570_10)
				local var_570_13 = var_570_11 <= 0 and var_570_7 or var_570_7 * (var_570_12 / var_570_11)

				if var_570_13 > 0 and var_570_7 < var_570_13 then
					arg_567_1.talkMaxDuration = var_570_13

					if var_570_13 + var_570_6 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_13 + var_570_6
					end
				end

				arg_567_1.text_.text = var_570_10
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101141", "story_v_out_123101.awb") ~= 0 then
					local var_570_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101141", "story_v_out_123101.awb") / 1000

					if var_570_14 + var_570_6 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_14 + var_570_6
					end

					if var_570_9.prefab_name ~= "" and arg_567_1.actors_[var_570_9.prefab_name] ~= nil then
						local var_570_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_9.prefab_name].transform, "story_v_out_123101", "123101141", "story_v_out_123101.awb")

						arg_567_1:RecordAudio("123101141", var_570_15)
						arg_567_1:RecordAudio("123101141", var_570_15)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_out_123101", "123101141", "story_v_out_123101.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_out_123101", "123101141", "story_v_out_123101.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_16 = math.max(var_570_7, arg_567_1.talkMaxDuration)

			if var_570_6 <= arg_567_1.time_ and arg_567_1.time_ < var_570_6 + var_570_16 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_6) / var_570_16

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_6 + var_570_16 and arg_567_1.time_ < var_570_6 + var_570_16 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play123101142 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 123101142
		arg_571_1.duration_ = 4.67

		local var_571_0 = {
			zh = 4.566,
			ja = 4.666
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play123101143(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = arg_571_1.actors_["1055ui_story"]
			local var_574_1 = 0

			if var_574_1 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 and not isNil(var_574_0) and arg_571_1.var_.characterEffect1055ui_story == nil then
				arg_571_1.var_.characterEffect1055ui_story = var_574_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_2 = 0.200000002980232

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_2 and not isNil(var_574_0) then
				local var_574_3 = (arg_571_1.time_ - var_574_1) / var_574_2

				if arg_571_1.var_.characterEffect1055ui_story and not isNil(var_574_0) then
					local var_574_4 = Mathf.Lerp(0, 0.5, var_574_3)

					arg_571_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_571_1.var_.characterEffect1055ui_story.fillRatio = var_574_4
				end
			end

			if arg_571_1.time_ >= var_574_1 + var_574_2 and arg_571_1.time_ < var_574_1 + var_574_2 + arg_574_0 and not isNil(var_574_0) and arg_571_1.var_.characterEffect1055ui_story then
				local var_574_5 = 0.5

				arg_571_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_571_1.var_.characterEffect1055ui_story.fillRatio = var_574_5
			end

			local var_574_6 = 0
			local var_574_7 = 0.325

			if var_574_6 < arg_571_1.time_ and arg_571_1.time_ <= var_574_6 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_8 = arg_571_1:FormatText(StoryNameCfg[497].name)

				arg_571_1.leftNameTxt_.text = var_574_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_9 = arg_571_1:GetWordFromCfg(123101142)
				local var_574_10 = arg_571_1:FormatText(var_574_9.content)

				arg_571_1.text_.text = var_574_10

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_11 = 13
				local var_574_12 = utf8.len(var_574_10)
				local var_574_13 = var_574_11 <= 0 and var_574_7 or var_574_7 * (var_574_12 / var_574_11)

				if var_574_13 > 0 and var_574_7 < var_574_13 then
					arg_571_1.talkMaxDuration = var_574_13

					if var_574_13 + var_574_6 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_13 + var_574_6
					end
				end

				arg_571_1.text_.text = var_574_10
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101142", "story_v_out_123101.awb") ~= 0 then
					local var_574_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101142", "story_v_out_123101.awb") / 1000

					if var_574_14 + var_574_6 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_14 + var_574_6
					end

					if var_574_9.prefab_name ~= "" and arg_571_1.actors_[var_574_9.prefab_name] ~= nil then
						local var_574_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_9.prefab_name].transform, "story_v_out_123101", "123101142", "story_v_out_123101.awb")

						arg_571_1:RecordAudio("123101142", var_574_15)
						arg_571_1:RecordAudio("123101142", var_574_15)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_123101", "123101142", "story_v_out_123101.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_123101", "123101142", "story_v_out_123101.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_16 = math.max(var_574_7, arg_571_1.talkMaxDuration)

			if var_574_6 <= arg_571_1.time_ and arg_571_1.time_ < var_574_6 + var_574_16 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_6) / var_574_16

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_6 + var_574_16 and arg_571_1.time_ < var_574_6 + var_574_16 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play123101143 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 123101143
		arg_575_1.duration_ = 9

		local var_575_0 = {
			zh = 5.433,
			ja = 9
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play123101144(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = arg_575_1.actors_["1055ui_story"]
			local var_578_1 = 0

			if var_578_1 < arg_575_1.time_ and arg_575_1.time_ <= var_578_1 + arg_578_0 and not isNil(var_578_0) and arg_575_1.var_.characterEffect1055ui_story == nil then
				arg_575_1.var_.characterEffect1055ui_story = var_578_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_2 = 0.200000002980232

			if var_578_1 <= arg_575_1.time_ and arg_575_1.time_ < var_578_1 + var_578_2 and not isNil(var_578_0) then
				local var_578_3 = (arg_575_1.time_ - var_578_1) / var_578_2

				if arg_575_1.var_.characterEffect1055ui_story and not isNil(var_578_0) then
					arg_575_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_575_1.time_ >= var_578_1 + var_578_2 and arg_575_1.time_ < var_578_1 + var_578_2 + arg_578_0 and not isNil(var_578_0) and arg_575_1.var_.characterEffect1055ui_story then
				arg_575_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_578_4 = 0

			if var_578_4 < arg_575_1.time_ and arg_575_1.time_ <= var_578_4 + arg_578_0 then
				arg_575_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_578_5 = 0

			if var_578_5 < arg_575_1.time_ and arg_575_1.time_ <= var_578_5 + arg_578_0 then
				arg_575_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_578_6 = 0
			local var_578_7 = 0.575

			if var_578_6 < arg_575_1.time_ and arg_575_1.time_ <= var_578_6 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_8 = arg_575_1:FormatText(StoryNameCfg[481].name)

				arg_575_1.leftNameTxt_.text = var_578_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_9 = arg_575_1:GetWordFromCfg(123101143)
				local var_578_10 = arg_575_1:FormatText(var_578_9.content)

				arg_575_1.text_.text = var_578_10

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_11 = 23
				local var_578_12 = utf8.len(var_578_10)
				local var_578_13 = var_578_11 <= 0 and var_578_7 or var_578_7 * (var_578_12 / var_578_11)

				if var_578_13 > 0 and var_578_7 < var_578_13 then
					arg_575_1.talkMaxDuration = var_578_13

					if var_578_13 + var_578_6 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_13 + var_578_6
					end
				end

				arg_575_1.text_.text = var_578_10
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101143", "story_v_out_123101.awb") ~= 0 then
					local var_578_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101143", "story_v_out_123101.awb") / 1000

					if var_578_14 + var_578_6 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_14 + var_578_6
					end

					if var_578_9.prefab_name ~= "" and arg_575_1.actors_[var_578_9.prefab_name] ~= nil then
						local var_578_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_9.prefab_name].transform, "story_v_out_123101", "123101143", "story_v_out_123101.awb")

						arg_575_1:RecordAudio("123101143", var_578_15)
						arg_575_1:RecordAudio("123101143", var_578_15)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_123101", "123101143", "story_v_out_123101.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_123101", "123101143", "story_v_out_123101.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_16 = math.max(var_578_7, arg_575_1.talkMaxDuration)

			if var_578_6 <= arg_575_1.time_ and arg_575_1.time_ < var_578_6 + var_578_16 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_6) / var_578_16

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_6 + var_578_16 and arg_575_1.time_ < var_578_6 + var_578_16 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play123101144 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 123101144
		arg_579_1.duration_ = 3.1

		local var_579_0 = {
			zh = 3.1,
			ja = 1.8
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play123101145(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = arg_579_1.actors_["1055ui_story"]
			local var_582_1 = 0

			if var_582_1 < arg_579_1.time_ and arg_579_1.time_ <= var_582_1 + arg_582_0 and not isNil(var_582_0) and arg_579_1.var_.characterEffect1055ui_story == nil then
				arg_579_1.var_.characterEffect1055ui_story = var_582_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_2 = 0.200000002980232

			if var_582_1 <= arg_579_1.time_ and arg_579_1.time_ < var_582_1 + var_582_2 and not isNil(var_582_0) then
				local var_582_3 = (arg_579_1.time_ - var_582_1) / var_582_2

				if arg_579_1.var_.characterEffect1055ui_story and not isNil(var_582_0) then
					local var_582_4 = Mathf.Lerp(0, 0.5, var_582_3)

					arg_579_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_579_1.var_.characterEffect1055ui_story.fillRatio = var_582_4
				end
			end

			if arg_579_1.time_ >= var_582_1 + var_582_2 and arg_579_1.time_ < var_582_1 + var_582_2 + arg_582_0 and not isNil(var_582_0) and arg_579_1.var_.characterEffect1055ui_story then
				local var_582_5 = 0.5

				arg_579_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_579_1.var_.characterEffect1055ui_story.fillRatio = var_582_5
			end

			local var_582_6 = 0
			local var_582_7 = 0.225

			if var_582_6 < arg_579_1.time_ and arg_579_1.time_ <= var_582_6 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				local var_582_8 = arg_579_1:FormatText(StoryNameCfg[497].name)

				arg_579_1.leftNameTxt_.text = var_582_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_9 = arg_579_1:GetWordFromCfg(123101144)
				local var_582_10 = arg_579_1:FormatText(var_582_9.content)

				arg_579_1.text_.text = var_582_10

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_11 = 9
				local var_582_12 = utf8.len(var_582_10)
				local var_582_13 = var_582_11 <= 0 and var_582_7 or var_582_7 * (var_582_12 / var_582_11)

				if var_582_13 > 0 and var_582_7 < var_582_13 then
					arg_579_1.talkMaxDuration = var_582_13

					if var_582_13 + var_582_6 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_13 + var_582_6
					end
				end

				arg_579_1.text_.text = var_582_10
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101144", "story_v_out_123101.awb") ~= 0 then
					local var_582_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101144", "story_v_out_123101.awb") / 1000

					if var_582_14 + var_582_6 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_14 + var_582_6
					end

					if var_582_9.prefab_name ~= "" and arg_579_1.actors_[var_582_9.prefab_name] ~= nil then
						local var_582_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_9.prefab_name].transform, "story_v_out_123101", "123101144", "story_v_out_123101.awb")

						arg_579_1:RecordAudio("123101144", var_582_15)
						arg_579_1:RecordAudio("123101144", var_582_15)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_out_123101", "123101144", "story_v_out_123101.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_out_123101", "123101144", "story_v_out_123101.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_16 = math.max(var_582_7, arg_579_1.talkMaxDuration)

			if var_582_6 <= arg_579_1.time_ and arg_579_1.time_ < var_582_6 + var_582_16 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_6) / var_582_16

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_6 + var_582_16 and arg_579_1.time_ < var_582_6 + var_582_16 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play123101145 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 123101145
		arg_583_1.duration_ = 12.5

		local var_583_0 = {
			zh = 9.233,
			ja = 12.5
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play123101146(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = arg_583_1.actors_["1055ui_story"]
			local var_586_1 = 0

			if var_586_1 < arg_583_1.time_ and arg_583_1.time_ <= var_586_1 + arg_586_0 and not isNil(var_586_0) and arg_583_1.var_.characterEffect1055ui_story == nil then
				arg_583_1.var_.characterEffect1055ui_story = var_586_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_2 = 0.200000002980232

			if var_586_1 <= arg_583_1.time_ and arg_583_1.time_ < var_586_1 + var_586_2 and not isNil(var_586_0) then
				local var_586_3 = (arg_583_1.time_ - var_586_1) / var_586_2

				if arg_583_1.var_.characterEffect1055ui_story and not isNil(var_586_0) then
					arg_583_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_583_1.time_ >= var_586_1 + var_586_2 and arg_583_1.time_ < var_586_1 + var_586_2 + arg_586_0 and not isNil(var_586_0) and arg_583_1.var_.characterEffect1055ui_story then
				arg_583_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_586_4 = 0

			if var_586_4 < arg_583_1.time_ and arg_583_1.time_ <= var_586_4 + arg_586_0 then
				arg_583_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			local var_586_5 = 0

			if var_586_5 < arg_583_1.time_ and arg_583_1.time_ <= var_586_5 + arg_586_0 then
				arg_583_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_586_6 = 0
			local var_586_7 = 0.9

			if var_586_6 < arg_583_1.time_ and arg_583_1.time_ <= var_586_6 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_8 = arg_583_1:FormatText(StoryNameCfg[481].name)

				arg_583_1.leftNameTxt_.text = var_586_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_9 = arg_583_1:GetWordFromCfg(123101145)
				local var_586_10 = arg_583_1:FormatText(var_586_9.content)

				arg_583_1.text_.text = var_586_10

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_11 = 36
				local var_586_12 = utf8.len(var_586_10)
				local var_586_13 = var_586_11 <= 0 and var_586_7 or var_586_7 * (var_586_12 / var_586_11)

				if var_586_13 > 0 and var_586_7 < var_586_13 then
					arg_583_1.talkMaxDuration = var_586_13

					if var_586_13 + var_586_6 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_13 + var_586_6
					end
				end

				arg_583_1.text_.text = var_586_10
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101145", "story_v_out_123101.awb") ~= 0 then
					local var_586_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101145", "story_v_out_123101.awb") / 1000

					if var_586_14 + var_586_6 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_14 + var_586_6
					end

					if var_586_9.prefab_name ~= "" and arg_583_1.actors_[var_586_9.prefab_name] ~= nil then
						local var_586_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_9.prefab_name].transform, "story_v_out_123101", "123101145", "story_v_out_123101.awb")

						arg_583_1:RecordAudio("123101145", var_586_15)
						arg_583_1:RecordAudio("123101145", var_586_15)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_123101", "123101145", "story_v_out_123101.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_123101", "123101145", "story_v_out_123101.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_16 = math.max(var_586_7, arg_583_1.talkMaxDuration)

			if var_586_6 <= arg_583_1.time_ and arg_583_1.time_ < var_586_6 + var_586_16 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_6) / var_586_16

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_6 + var_586_16 and arg_583_1.time_ < var_586_6 + var_586_16 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play123101146 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 123101146
		arg_587_1.duration_ = 7.63

		local var_587_0 = {
			zh = 4.6,
			ja = 7.633
		}
		local var_587_1 = manager.audio:GetLocalizationFlag()

		if var_587_0[var_587_1] ~= nil then
			arg_587_1.duration_ = var_587_0[var_587_1]
		end

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play123101147(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0

			if var_590_0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_0 + arg_590_0 then
				arg_587_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_590_1 = 0
			local var_590_2 = 0.425

			if var_590_1 < arg_587_1.time_ and arg_587_1.time_ <= var_590_1 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				local var_590_3 = arg_587_1:FormatText(StoryNameCfg[481].name)

				arg_587_1.leftNameTxt_.text = var_590_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_4 = arg_587_1:GetWordFromCfg(123101146)
				local var_590_5 = arg_587_1:FormatText(var_590_4.content)

				arg_587_1.text_.text = var_590_5

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_6 = 17
				local var_590_7 = utf8.len(var_590_5)
				local var_590_8 = var_590_6 <= 0 and var_590_2 or var_590_2 * (var_590_7 / var_590_6)

				if var_590_8 > 0 and var_590_2 < var_590_8 then
					arg_587_1.talkMaxDuration = var_590_8

					if var_590_8 + var_590_1 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_8 + var_590_1
					end
				end

				arg_587_1.text_.text = var_590_5
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101146", "story_v_out_123101.awb") ~= 0 then
					local var_590_9 = manager.audio:GetVoiceLength("story_v_out_123101", "123101146", "story_v_out_123101.awb") / 1000

					if var_590_9 + var_590_1 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_9 + var_590_1
					end

					if var_590_4.prefab_name ~= "" and arg_587_1.actors_[var_590_4.prefab_name] ~= nil then
						local var_590_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_4.prefab_name].transform, "story_v_out_123101", "123101146", "story_v_out_123101.awb")

						arg_587_1:RecordAudio("123101146", var_590_10)
						arg_587_1:RecordAudio("123101146", var_590_10)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_out_123101", "123101146", "story_v_out_123101.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_out_123101", "123101146", "story_v_out_123101.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_11 = math.max(var_590_2, arg_587_1.talkMaxDuration)

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_11 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_1) / var_590_11

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_1 + var_590_11 and arg_587_1.time_ < var_590_1 + var_590_11 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play123101147 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 123101147
		arg_591_1.duration_ = 6.47

		local var_591_0 = {
			zh = 5.166,
			ja = 6.466
		}
		local var_591_1 = manager.audio:GetLocalizationFlag()

		if var_591_0[var_591_1] ~= nil then
			arg_591_1.duration_ = var_591_0[var_591_1]
		end

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play123101148(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = arg_591_1.actors_["1055ui_story"]
			local var_594_1 = 0

			if var_594_1 < arg_591_1.time_ and arg_591_1.time_ <= var_594_1 + arg_594_0 and not isNil(var_594_0) and arg_591_1.var_.characterEffect1055ui_story == nil then
				arg_591_1.var_.characterEffect1055ui_story = var_594_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_594_2 = 0.200000002980232

			if var_594_1 <= arg_591_1.time_ and arg_591_1.time_ < var_594_1 + var_594_2 and not isNil(var_594_0) then
				local var_594_3 = (arg_591_1.time_ - var_594_1) / var_594_2

				if arg_591_1.var_.characterEffect1055ui_story and not isNil(var_594_0) then
					local var_594_4 = Mathf.Lerp(0, 0.5, var_594_3)

					arg_591_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_591_1.var_.characterEffect1055ui_story.fillRatio = var_594_4
				end
			end

			if arg_591_1.time_ >= var_594_1 + var_594_2 and arg_591_1.time_ < var_594_1 + var_594_2 + arg_594_0 and not isNil(var_594_0) and arg_591_1.var_.characterEffect1055ui_story then
				local var_594_5 = 0.5

				arg_591_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_591_1.var_.characterEffect1055ui_story.fillRatio = var_594_5
			end

			local var_594_6 = 0
			local var_594_7 = 0.525

			if var_594_6 < arg_591_1.time_ and arg_591_1.time_ <= var_594_6 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				local var_594_8 = arg_591_1:FormatText(StoryNameCfg[497].name)

				arg_591_1.leftNameTxt_.text = var_594_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_9 = arg_591_1:GetWordFromCfg(123101147)
				local var_594_10 = arg_591_1:FormatText(var_594_9.content)

				arg_591_1.text_.text = var_594_10

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_11 = 21
				local var_594_12 = utf8.len(var_594_10)
				local var_594_13 = var_594_11 <= 0 and var_594_7 or var_594_7 * (var_594_12 / var_594_11)

				if var_594_13 > 0 and var_594_7 < var_594_13 then
					arg_591_1.talkMaxDuration = var_594_13

					if var_594_13 + var_594_6 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_13 + var_594_6
					end
				end

				arg_591_1.text_.text = var_594_10
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101147", "story_v_out_123101.awb") ~= 0 then
					local var_594_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101147", "story_v_out_123101.awb") / 1000

					if var_594_14 + var_594_6 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_14 + var_594_6
					end

					if var_594_9.prefab_name ~= "" and arg_591_1.actors_[var_594_9.prefab_name] ~= nil then
						local var_594_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_9.prefab_name].transform, "story_v_out_123101", "123101147", "story_v_out_123101.awb")

						arg_591_1:RecordAudio("123101147", var_594_15)
						arg_591_1:RecordAudio("123101147", var_594_15)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_out_123101", "123101147", "story_v_out_123101.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_out_123101", "123101147", "story_v_out_123101.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_16 = math.max(var_594_7, arg_591_1.talkMaxDuration)

			if var_594_6 <= arg_591_1.time_ and arg_591_1.time_ < var_594_6 + var_594_16 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_6) / var_594_16

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_6 + var_594_16 and arg_591_1.time_ < var_594_6 + var_594_16 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play123101148 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 123101148
		arg_595_1.duration_ = 11.8

		local var_595_0 = {
			zh = 11.8,
			ja = 8.3
		}
		local var_595_1 = manager.audio:GetLocalizationFlag()

		if var_595_0[var_595_1] ~= nil then
			arg_595_1.duration_ = var_595_0[var_595_1]
		end

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play123101149(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0
			local var_598_1 = 1.025

			if var_598_0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				local var_598_2 = arg_595_1:FormatText(StoryNameCfg[497].name)

				arg_595_1.leftNameTxt_.text = var_598_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_3 = arg_595_1:GetWordFromCfg(123101148)
				local var_598_4 = arg_595_1:FormatText(var_598_3.content)

				arg_595_1.text_.text = var_598_4

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_5 = 41
				local var_598_6 = utf8.len(var_598_4)
				local var_598_7 = var_598_5 <= 0 and var_598_1 or var_598_1 * (var_598_6 / var_598_5)

				if var_598_7 > 0 and var_598_1 < var_598_7 then
					arg_595_1.talkMaxDuration = var_598_7

					if var_598_7 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_7 + var_598_0
					end
				end

				arg_595_1.text_.text = var_598_4
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101148", "story_v_out_123101.awb") ~= 0 then
					local var_598_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101148", "story_v_out_123101.awb") / 1000

					if var_598_8 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_8 + var_598_0
					end

					if var_598_3.prefab_name ~= "" and arg_595_1.actors_[var_598_3.prefab_name] ~= nil then
						local var_598_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_3.prefab_name].transform, "story_v_out_123101", "123101148", "story_v_out_123101.awb")

						arg_595_1:RecordAudio("123101148", var_598_9)
						arg_595_1:RecordAudio("123101148", var_598_9)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_out_123101", "123101148", "story_v_out_123101.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_out_123101", "123101148", "story_v_out_123101.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_10 = math.max(var_598_1, arg_595_1.talkMaxDuration)

			if var_598_0 <= arg_595_1.time_ and arg_595_1.time_ < var_598_0 + var_598_10 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_0) / var_598_10

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_0 + var_598_10 and arg_595_1.time_ < var_598_0 + var_598_10 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play123101149 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 123101149
		arg_599_1.duration_ = 11.17

		local var_599_0 = {
			zh = 10.166,
			ja = 11.166
		}
		local var_599_1 = manager.audio:GetLocalizationFlag()

		if var_599_0[var_599_1] ~= nil then
			arg_599_1.duration_ = var_599_0[var_599_1]
		end

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play123101150(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0
			local var_602_1 = 1.225

			if var_602_0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_2 = arg_599_1:FormatText(StoryNameCfg[497].name)

				arg_599_1.leftNameTxt_.text = var_602_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_3 = arg_599_1:GetWordFromCfg(123101149)
				local var_602_4 = arg_599_1:FormatText(var_602_3.content)

				arg_599_1.text_.text = var_602_4

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_5 = 49
				local var_602_6 = utf8.len(var_602_4)
				local var_602_7 = var_602_5 <= 0 and var_602_1 or var_602_1 * (var_602_6 / var_602_5)

				if var_602_7 > 0 and var_602_1 < var_602_7 then
					arg_599_1.talkMaxDuration = var_602_7

					if var_602_7 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_7 + var_602_0
					end
				end

				arg_599_1.text_.text = var_602_4
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101149", "story_v_out_123101.awb") ~= 0 then
					local var_602_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101149", "story_v_out_123101.awb") / 1000

					if var_602_8 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_8 + var_602_0
					end

					if var_602_3.prefab_name ~= "" and arg_599_1.actors_[var_602_3.prefab_name] ~= nil then
						local var_602_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_3.prefab_name].transform, "story_v_out_123101", "123101149", "story_v_out_123101.awb")

						arg_599_1:RecordAudio("123101149", var_602_9)
						arg_599_1:RecordAudio("123101149", var_602_9)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_out_123101", "123101149", "story_v_out_123101.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_out_123101", "123101149", "story_v_out_123101.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_10 = math.max(var_602_1, arg_599_1.talkMaxDuration)

			if var_602_0 <= arg_599_1.time_ and arg_599_1.time_ < var_602_0 + var_602_10 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_0) / var_602_10

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_0 + var_602_10 and arg_599_1.time_ < var_602_0 + var_602_10 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play123101150 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 123101150
		arg_603_1.duration_ = 2

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play123101151(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = arg_603_1.actors_["1055ui_story"]
			local var_606_1 = 0

			if var_606_1 < arg_603_1.time_ and arg_603_1.time_ <= var_606_1 + arg_606_0 and not isNil(var_606_0) and arg_603_1.var_.characterEffect1055ui_story == nil then
				arg_603_1.var_.characterEffect1055ui_story = var_606_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_2 = 0.200000002980232

			if var_606_1 <= arg_603_1.time_ and arg_603_1.time_ < var_606_1 + var_606_2 and not isNil(var_606_0) then
				local var_606_3 = (arg_603_1.time_ - var_606_1) / var_606_2

				if arg_603_1.var_.characterEffect1055ui_story and not isNil(var_606_0) then
					arg_603_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_603_1.time_ >= var_606_1 + var_606_2 and arg_603_1.time_ < var_606_1 + var_606_2 + arg_606_0 and not isNil(var_606_0) and arg_603_1.var_.characterEffect1055ui_story then
				arg_603_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_606_4 = 0

			if var_606_4 < arg_603_1.time_ and arg_603_1.time_ <= var_606_4 + arg_606_0 then
				arg_603_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_606_5 = 0
			local var_606_6 = 0.125

			if var_606_5 < arg_603_1.time_ and arg_603_1.time_ <= var_606_5 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				local var_606_7 = arg_603_1:FormatText(StoryNameCfg[481].name)

				arg_603_1.leftNameTxt_.text = var_606_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_8 = arg_603_1:GetWordFromCfg(123101150)
				local var_606_9 = arg_603_1:FormatText(var_606_8.content)

				arg_603_1.text_.text = var_606_9

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_10 = 5
				local var_606_11 = utf8.len(var_606_9)
				local var_606_12 = var_606_10 <= 0 and var_606_6 or var_606_6 * (var_606_11 / var_606_10)

				if var_606_12 > 0 and var_606_6 < var_606_12 then
					arg_603_1.talkMaxDuration = var_606_12

					if var_606_12 + var_606_5 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_12 + var_606_5
					end
				end

				arg_603_1.text_.text = var_606_9
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101150", "story_v_out_123101.awb") ~= 0 then
					local var_606_13 = manager.audio:GetVoiceLength("story_v_out_123101", "123101150", "story_v_out_123101.awb") / 1000

					if var_606_13 + var_606_5 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_13 + var_606_5
					end

					if var_606_8.prefab_name ~= "" and arg_603_1.actors_[var_606_8.prefab_name] ~= nil then
						local var_606_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_8.prefab_name].transform, "story_v_out_123101", "123101150", "story_v_out_123101.awb")

						arg_603_1:RecordAudio("123101150", var_606_14)
						arg_603_1:RecordAudio("123101150", var_606_14)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_out_123101", "123101150", "story_v_out_123101.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_out_123101", "123101150", "story_v_out_123101.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_15 = math.max(var_606_6, arg_603_1.talkMaxDuration)

			if var_606_5 <= arg_603_1.time_ and arg_603_1.time_ < var_606_5 + var_606_15 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_5) / var_606_15

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_5 + var_606_15 and arg_603_1.time_ < var_606_5 + var_606_15 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play123101151 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 123101151
		arg_607_1.duration_ = 1.47

		local var_607_0 = {
			zh = 1.233,
			ja = 1.466
		}
		local var_607_1 = manager.audio:GetLocalizationFlag()

		if var_607_0[var_607_1] ~= nil then
			arg_607_1.duration_ = var_607_0[var_607_1]
		end

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play123101152(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = arg_607_1.actors_["1055ui_story"]
			local var_610_1 = 0

			if var_610_1 < arg_607_1.time_ and arg_607_1.time_ <= var_610_1 + arg_610_0 and not isNil(var_610_0) and arg_607_1.var_.characterEffect1055ui_story == nil then
				arg_607_1.var_.characterEffect1055ui_story = var_610_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_2 = 0.200000002980232

			if var_610_1 <= arg_607_1.time_ and arg_607_1.time_ < var_610_1 + var_610_2 and not isNil(var_610_0) then
				local var_610_3 = (arg_607_1.time_ - var_610_1) / var_610_2

				if arg_607_1.var_.characterEffect1055ui_story and not isNil(var_610_0) then
					local var_610_4 = Mathf.Lerp(0, 0.5, var_610_3)

					arg_607_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_607_1.var_.characterEffect1055ui_story.fillRatio = var_610_4
				end
			end

			if arg_607_1.time_ >= var_610_1 + var_610_2 and arg_607_1.time_ < var_610_1 + var_610_2 + arg_610_0 and not isNil(var_610_0) and arg_607_1.var_.characterEffect1055ui_story then
				local var_610_5 = 0.5

				arg_607_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_607_1.var_.characterEffect1055ui_story.fillRatio = var_610_5
			end

			local var_610_6 = 0
			local var_610_7 = 0.1

			if var_610_6 < arg_607_1.time_ and arg_607_1.time_ <= var_610_6 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				local var_610_8 = arg_607_1:FormatText(StoryNameCfg[497].name)

				arg_607_1.leftNameTxt_.text = var_610_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_607_1.callingController_:SetSelectedState("normal")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_9 = arg_607_1:GetWordFromCfg(123101151)
				local var_610_10 = arg_607_1:FormatText(var_610_9.content)

				arg_607_1.text_.text = var_610_10

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_11 = 4
				local var_610_12 = utf8.len(var_610_10)
				local var_610_13 = var_610_11 <= 0 and var_610_7 or var_610_7 * (var_610_12 / var_610_11)

				if var_610_13 > 0 and var_610_7 < var_610_13 then
					arg_607_1.talkMaxDuration = var_610_13

					if var_610_13 + var_610_6 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_13 + var_610_6
					end
				end

				arg_607_1.text_.text = var_610_10
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101151", "story_v_out_123101.awb") ~= 0 then
					local var_610_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101151", "story_v_out_123101.awb") / 1000

					if var_610_14 + var_610_6 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_14 + var_610_6
					end

					if var_610_9.prefab_name ~= "" and arg_607_1.actors_[var_610_9.prefab_name] ~= nil then
						local var_610_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_9.prefab_name].transform, "story_v_out_123101", "123101151", "story_v_out_123101.awb")

						arg_607_1:RecordAudio("123101151", var_610_15)
						arg_607_1:RecordAudio("123101151", var_610_15)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_out_123101", "123101151", "story_v_out_123101.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_out_123101", "123101151", "story_v_out_123101.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_16 = math.max(var_610_7, arg_607_1.talkMaxDuration)

			if var_610_6 <= arg_607_1.time_ and arg_607_1.time_ < var_610_6 + var_610_16 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_6) / var_610_16

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_6 + var_610_16 and arg_607_1.time_ < var_610_6 + var_610_16 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play123101152 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 123101152
		arg_611_1.duration_ = 5.87

		local var_611_0 = {
			zh = 3.466,
			ja = 5.866
		}
		local var_611_1 = manager.audio:GetLocalizationFlag()

		if var_611_0[var_611_1] ~= nil then
			arg_611_1.duration_ = var_611_0[var_611_1]
		end

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play123101153(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = arg_611_1.actors_["1055ui_story"]
			local var_614_1 = 0

			if var_614_1 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1055ui_story == nil then
				arg_611_1.var_.characterEffect1055ui_story = var_614_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_2 = 0.200000002980232

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_2 and not isNil(var_614_0) then
				local var_614_3 = (arg_611_1.time_ - var_614_1) / var_614_2

				if arg_611_1.var_.characterEffect1055ui_story and not isNil(var_614_0) then
					arg_611_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_611_1.time_ >= var_614_1 + var_614_2 and arg_611_1.time_ < var_614_1 + var_614_2 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1055ui_story then
				arg_611_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_614_4 = 0

			if var_614_4 < arg_611_1.time_ and arg_611_1.time_ <= var_614_4 + arg_614_0 then
				arg_611_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055actionlink/1055action472")
			end

			local var_614_5 = 0

			if var_614_5 < arg_611_1.time_ and arg_611_1.time_ <= var_614_5 + arg_614_0 then
				arg_611_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_614_6 = 0
			local var_614_7 = 0.175

			if var_614_6 < arg_611_1.time_ and arg_611_1.time_ <= var_614_6 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_8 = arg_611_1:FormatText(StoryNameCfg[481].name)

				arg_611_1.leftNameTxt_.text = var_614_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_9 = arg_611_1:GetWordFromCfg(123101152)
				local var_614_10 = arg_611_1:FormatText(var_614_9.content)

				arg_611_1.text_.text = var_614_10

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_11 = 7
				local var_614_12 = utf8.len(var_614_10)
				local var_614_13 = var_614_11 <= 0 and var_614_7 or var_614_7 * (var_614_12 / var_614_11)

				if var_614_13 > 0 and var_614_7 < var_614_13 then
					arg_611_1.talkMaxDuration = var_614_13

					if var_614_13 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_13 + var_614_6
					end
				end

				arg_611_1.text_.text = var_614_10
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101152", "story_v_out_123101.awb") ~= 0 then
					local var_614_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101152", "story_v_out_123101.awb") / 1000

					if var_614_14 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_14 + var_614_6
					end

					if var_614_9.prefab_name ~= "" and arg_611_1.actors_[var_614_9.prefab_name] ~= nil then
						local var_614_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_9.prefab_name].transform, "story_v_out_123101", "123101152", "story_v_out_123101.awb")

						arg_611_1:RecordAudio("123101152", var_614_15)
						arg_611_1:RecordAudio("123101152", var_614_15)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_out_123101", "123101152", "story_v_out_123101.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_out_123101", "123101152", "story_v_out_123101.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_16 = math.max(var_614_7, arg_611_1.talkMaxDuration)

			if var_614_6 <= arg_611_1.time_ and arg_611_1.time_ < var_614_6 + var_614_16 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_6) / var_614_16

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_6 + var_614_16 and arg_611_1.time_ < var_614_6 + var_614_16 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play123101153 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 123101153
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play123101154(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = arg_615_1.actors_["1055ui_story"].transform
			local var_618_1 = 0

			if var_618_1 < arg_615_1.time_ and arg_615_1.time_ <= var_618_1 + arg_618_0 then
				arg_615_1.var_.moveOldPos1055ui_story = var_618_0.localPosition
			end

			local var_618_2 = 0.001

			if var_618_1 <= arg_615_1.time_ and arg_615_1.time_ < var_618_1 + var_618_2 then
				local var_618_3 = (arg_615_1.time_ - var_618_1) / var_618_2
				local var_618_4 = Vector3.New(0, 100, 0)

				var_618_0.localPosition = Vector3.Lerp(arg_615_1.var_.moveOldPos1055ui_story, var_618_4, var_618_3)

				local var_618_5 = manager.ui.mainCamera.transform.position - var_618_0.position

				var_618_0.forward = Vector3.New(var_618_5.x, var_618_5.y, var_618_5.z)

				local var_618_6 = var_618_0.localEulerAngles

				var_618_6.z = 0
				var_618_6.x = 0
				var_618_0.localEulerAngles = var_618_6
			end

			if arg_615_1.time_ >= var_618_1 + var_618_2 and arg_615_1.time_ < var_618_1 + var_618_2 + arg_618_0 then
				var_618_0.localPosition = Vector3.New(0, 100, 0)

				local var_618_7 = manager.ui.mainCamera.transform.position - var_618_0.position

				var_618_0.forward = Vector3.New(var_618_7.x, var_618_7.y, var_618_7.z)

				local var_618_8 = var_618_0.localEulerAngles

				var_618_8.z = 0
				var_618_8.x = 0
				var_618_0.localEulerAngles = var_618_8
			end

			local var_618_9 = arg_615_1.actors_["1055ui_story"]
			local var_618_10 = 0

			if var_618_10 < arg_615_1.time_ and arg_615_1.time_ <= var_618_10 + arg_618_0 and not isNil(var_618_9) and arg_615_1.var_.characterEffect1055ui_story == nil then
				arg_615_1.var_.characterEffect1055ui_story = var_618_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_11 = 0.200000002980232

			if var_618_10 <= arg_615_1.time_ and arg_615_1.time_ < var_618_10 + var_618_11 and not isNil(var_618_9) then
				local var_618_12 = (arg_615_1.time_ - var_618_10) / var_618_11

				if arg_615_1.var_.characterEffect1055ui_story and not isNil(var_618_9) then
					local var_618_13 = Mathf.Lerp(0, 0.5, var_618_12)

					arg_615_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_615_1.var_.characterEffect1055ui_story.fillRatio = var_618_13
				end
			end

			if arg_615_1.time_ >= var_618_10 + var_618_11 and arg_615_1.time_ < var_618_10 + var_618_11 + arg_618_0 and not isNil(var_618_9) and arg_615_1.var_.characterEffect1055ui_story then
				local var_618_14 = 0.5

				arg_615_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_615_1.var_.characterEffect1055ui_story.fillRatio = var_618_14
			end

			local var_618_15 = 0
			local var_618_16 = 0.475

			if var_618_15 < arg_615_1.time_ and arg_615_1.time_ <= var_618_15 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, false)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_17 = arg_615_1:GetWordFromCfg(123101153)
				local var_618_18 = arg_615_1:FormatText(var_618_17.content)

				arg_615_1.text_.text = var_618_18

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_19 = 19
				local var_618_20 = utf8.len(var_618_18)
				local var_618_21 = var_618_19 <= 0 and var_618_16 or var_618_16 * (var_618_20 / var_618_19)

				if var_618_21 > 0 and var_618_16 < var_618_21 then
					arg_615_1.talkMaxDuration = var_618_21

					if var_618_21 + var_618_15 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_21 + var_618_15
					end
				end

				arg_615_1.text_.text = var_618_18
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_22 = math.max(var_618_16, arg_615_1.talkMaxDuration)

			if var_618_15 <= arg_615_1.time_ and arg_615_1.time_ < var_618_15 + var_618_22 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_15) / var_618_22

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_15 + var_618_22 and arg_615_1.time_ < var_618_15 + var_618_22 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_615_1:InitPlayNodeList()
	end,
	Play123101154 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 123101154
		arg_619_1.duration_ = 4.4

		local var_619_0 = {
			zh = 4.4,
			ja = 2.1
		}
		local var_619_1 = manager.audio:GetLocalizationFlag()

		if var_619_0[var_619_1] ~= nil then
			arg_619_1.duration_ = var_619_0[var_619_1]
		end

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play123101155(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = arg_619_1.actors_["1093ui_story"].transform
			local var_622_1 = 0

			if var_622_1 < arg_619_1.time_ and arg_619_1.time_ <= var_622_1 + arg_622_0 then
				arg_619_1.var_.moveOldPos1093ui_story = var_622_0.localPosition
			end

			local var_622_2 = 0.001

			if var_622_1 <= arg_619_1.time_ and arg_619_1.time_ < var_622_1 + var_622_2 then
				local var_622_3 = (arg_619_1.time_ - var_622_1) / var_622_2
				local var_622_4 = Vector3.New(-0.7, -1.11, -5.88)

				var_622_0.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos1093ui_story, var_622_4, var_622_3)

				local var_622_5 = manager.ui.mainCamera.transform.position - var_622_0.position

				var_622_0.forward = Vector3.New(var_622_5.x, var_622_5.y, var_622_5.z)

				local var_622_6 = var_622_0.localEulerAngles

				var_622_6.z = 0
				var_622_6.x = 0
				var_622_0.localEulerAngles = var_622_6
			end

			if arg_619_1.time_ >= var_622_1 + var_622_2 and arg_619_1.time_ < var_622_1 + var_622_2 + arg_622_0 then
				var_622_0.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_622_7 = manager.ui.mainCamera.transform.position - var_622_0.position

				var_622_0.forward = Vector3.New(var_622_7.x, var_622_7.y, var_622_7.z)

				local var_622_8 = var_622_0.localEulerAngles

				var_622_8.z = 0
				var_622_8.x = 0
				var_622_0.localEulerAngles = var_622_8
			end

			local var_622_9 = arg_619_1.actors_["1093ui_story"]
			local var_622_10 = 0

			if var_622_10 < arg_619_1.time_ and arg_619_1.time_ <= var_622_10 + arg_622_0 and not isNil(var_622_9) and arg_619_1.var_.characterEffect1093ui_story == nil then
				arg_619_1.var_.characterEffect1093ui_story = var_622_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_11 = 0.200000002980232

			if var_622_10 <= arg_619_1.time_ and arg_619_1.time_ < var_622_10 + var_622_11 and not isNil(var_622_9) then
				local var_622_12 = (arg_619_1.time_ - var_622_10) / var_622_11

				if arg_619_1.var_.characterEffect1093ui_story and not isNil(var_622_9) then
					arg_619_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_619_1.time_ >= var_622_10 + var_622_11 and arg_619_1.time_ < var_622_10 + var_622_11 + arg_622_0 and not isNil(var_622_9) and arg_619_1.var_.characterEffect1093ui_story then
				arg_619_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_622_13 = 0

			if var_622_13 < arg_619_1.time_ and arg_619_1.time_ <= var_622_13 + arg_622_0 then
				arg_619_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			local var_622_14 = 0

			if var_622_14 < arg_619_1.time_ and arg_619_1.time_ <= var_622_14 + arg_622_0 then
				arg_619_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_622_15 = 0
			local var_622_16 = 0.275

			if var_622_15 < arg_619_1.time_ and arg_619_1.time_ <= var_622_15 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				local var_622_17 = arg_619_1:FormatText(StoryNameCfg[73].name)

				arg_619_1.leftNameTxt_.text = var_622_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_18 = arg_619_1:GetWordFromCfg(123101154)
				local var_622_19 = arg_619_1:FormatText(var_622_18.content)

				arg_619_1.text_.text = var_622_19

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_20 = 11
				local var_622_21 = utf8.len(var_622_19)
				local var_622_22 = var_622_20 <= 0 and var_622_16 or var_622_16 * (var_622_21 / var_622_20)

				if var_622_22 > 0 and var_622_16 < var_622_22 then
					arg_619_1.talkMaxDuration = var_622_22

					if var_622_22 + var_622_15 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_22 + var_622_15
					end
				end

				arg_619_1.text_.text = var_622_19
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101154", "story_v_out_123101.awb") ~= 0 then
					local var_622_23 = manager.audio:GetVoiceLength("story_v_out_123101", "123101154", "story_v_out_123101.awb") / 1000

					if var_622_23 + var_622_15 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_23 + var_622_15
					end

					if var_622_18.prefab_name ~= "" and arg_619_1.actors_[var_622_18.prefab_name] ~= nil then
						local var_622_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_619_1.actors_[var_622_18.prefab_name].transform, "story_v_out_123101", "123101154", "story_v_out_123101.awb")

						arg_619_1:RecordAudio("123101154", var_622_24)
						arg_619_1:RecordAudio("123101154", var_622_24)
					else
						arg_619_1:AudioAction("play", "voice", "story_v_out_123101", "123101154", "story_v_out_123101.awb")
					end

					arg_619_1:RecordHistoryTalkVoice("story_v_out_123101", "123101154", "story_v_out_123101.awb")
				end

				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_25 = math.max(var_622_16, arg_619_1.talkMaxDuration)

			if var_622_15 <= arg_619_1.time_ and arg_619_1.time_ < var_622_15 + var_622_25 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_15) / var_622_25

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_15 + var_622_25 and arg_619_1.time_ < var_622_15 + var_622_25 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_619_1:InitPlayNodeList()
	end,
	Play123101155 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 123101155
		arg_623_1.duration_ = 12.53

		local var_623_0 = {
			zh = 9.133,
			ja = 12.533
		}
		local var_623_1 = manager.audio:GetLocalizationFlag()

		if var_623_0[var_623_1] ~= nil then
			arg_623_1.duration_ = var_623_0[var_623_1]
		end

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
			arg_623_1.auto_ = false
		end

		function arg_623_1.playNext_(arg_625_0)
			arg_623_1.onStoryFinished_()
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = arg_623_1.actors_["1055ui_story"].transform
			local var_626_1 = 0

			if var_626_1 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 then
				arg_623_1.var_.moveOldPos1055ui_story = var_626_0.localPosition
			end

			local var_626_2 = 0.001

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_2 then
				local var_626_3 = (arg_623_1.time_ - var_626_1) / var_626_2
				local var_626_4 = Vector3.New(0.7, -0.965, -6.2)

				var_626_0.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos1055ui_story, var_626_4, var_626_3)

				local var_626_5 = manager.ui.mainCamera.transform.position - var_626_0.position

				var_626_0.forward = Vector3.New(var_626_5.x, var_626_5.y, var_626_5.z)

				local var_626_6 = var_626_0.localEulerAngles

				var_626_6.z = 0
				var_626_6.x = 0
				var_626_0.localEulerAngles = var_626_6
			end

			if arg_623_1.time_ >= var_626_1 + var_626_2 and arg_623_1.time_ < var_626_1 + var_626_2 + arg_626_0 then
				var_626_0.localPosition = Vector3.New(0.7, -0.965, -6.2)

				local var_626_7 = manager.ui.mainCamera.transform.position - var_626_0.position

				var_626_0.forward = Vector3.New(var_626_7.x, var_626_7.y, var_626_7.z)

				local var_626_8 = var_626_0.localEulerAngles

				var_626_8.z = 0
				var_626_8.x = 0
				var_626_0.localEulerAngles = var_626_8
			end

			local var_626_9 = arg_623_1.actors_["1055ui_story"]
			local var_626_10 = 0

			if var_626_10 < arg_623_1.time_ and arg_623_1.time_ <= var_626_10 + arg_626_0 and not isNil(var_626_9) and arg_623_1.var_.characterEffect1055ui_story == nil then
				arg_623_1.var_.characterEffect1055ui_story = var_626_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_11 = 0.200000002980232

			if var_626_10 <= arg_623_1.time_ and arg_623_1.time_ < var_626_10 + var_626_11 and not isNil(var_626_9) then
				local var_626_12 = (arg_623_1.time_ - var_626_10) / var_626_11

				if arg_623_1.var_.characterEffect1055ui_story and not isNil(var_626_9) then
					arg_623_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_623_1.time_ >= var_626_10 + var_626_11 and arg_623_1.time_ < var_626_10 + var_626_11 + arg_626_0 and not isNil(var_626_9) and arg_623_1.var_.characterEffect1055ui_story then
				arg_623_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_626_13 = 0

			if var_626_13 < arg_623_1.time_ and arg_623_1.time_ <= var_626_13 + arg_626_0 then
				arg_623_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_626_14 = 0

			if var_626_14 < arg_623_1.time_ and arg_623_1.time_ <= var_626_14 + arg_626_0 then
				arg_623_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_626_15 = arg_623_1.actors_["1093ui_story"]
			local var_626_16 = 0

			if var_626_16 < arg_623_1.time_ and arg_623_1.time_ <= var_626_16 + arg_626_0 and not isNil(var_626_15) and arg_623_1.var_.characterEffect1093ui_story == nil then
				arg_623_1.var_.characterEffect1093ui_story = var_626_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_17 = 0.200000002980232

			if var_626_16 <= arg_623_1.time_ and arg_623_1.time_ < var_626_16 + var_626_17 and not isNil(var_626_15) then
				local var_626_18 = (arg_623_1.time_ - var_626_16) / var_626_17

				if arg_623_1.var_.characterEffect1093ui_story and not isNil(var_626_15) then
					local var_626_19 = Mathf.Lerp(0, 0.5, var_626_18)

					arg_623_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_623_1.var_.characterEffect1093ui_story.fillRatio = var_626_19
				end
			end

			if arg_623_1.time_ >= var_626_16 + var_626_17 and arg_623_1.time_ < var_626_16 + var_626_17 + arg_626_0 and not isNil(var_626_15) and arg_623_1.var_.characterEffect1093ui_story then
				local var_626_20 = 0.5

				arg_623_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_623_1.var_.characterEffect1093ui_story.fillRatio = var_626_20
			end

			local var_626_21 = 0
			local var_626_22 = 0.975

			if var_626_21 < arg_623_1.time_ and arg_623_1.time_ <= var_626_21 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				local var_626_23 = arg_623_1:FormatText(StoryNameCfg[481].name)

				arg_623_1.leftNameTxt_.text = var_626_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_24 = arg_623_1:GetWordFromCfg(123101155)
				local var_626_25 = arg_623_1:FormatText(var_626_24.content)

				arg_623_1.text_.text = var_626_25

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_26 = 39
				local var_626_27 = utf8.len(var_626_25)
				local var_626_28 = var_626_26 <= 0 and var_626_22 or var_626_22 * (var_626_27 / var_626_26)

				if var_626_28 > 0 and var_626_22 < var_626_28 then
					arg_623_1.talkMaxDuration = var_626_28

					if var_626_28 + var_626_21 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_28 + var_626_21
					end
				end

				arg_623_1.text_.text = var_626_25
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101155", "story_v_out_123101.awb") ~= 0 then
					local var_626_29 = manager.audio:GetVoiceLength("story_v_out_123101", "123101155", "story_v_out_123101.awb") / 1000

					if var_626_29 + var_626_21 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_29 + var_626_21
					end

					if var_626_24.prefab_name ~= "" and arg_623_1.actors_[var_626_24.prefab_name] ~= nil then
						local var_626_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_24.prefab_name].transform, "story_v_out_123101", "123101155", "story_v_out_123101.awb")

						arg_623_1:RecordAudio("123101155", var_626_30)
						arg_623_1:RecordAudio("123101155", var_626_30)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_out_123101", "123101155", "story_v_out_123101.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_out_123101", "123101155", "story_v_out_123101.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_31 = math.max(var_626_22, arg_623_1.talkMaxDuration)

			if var_626_21 <= arg_623_1.time_ and arg_623_1.time_ < var_626_21 + var_626_31 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_21) / var_626_31

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_21 + var_626_31 and arg_623_1.time_ < var_626_21 + var_626_31 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_623_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K05f",
		"TextureConfig/Background/K05g"
	},
	voices = {
		"story_v_out_123101.awb"
	}
}
