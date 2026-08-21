return {
	Play319181001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319181001
		arg_1_1.duration_ = 3.73

		local var_1_0 = {
			zh = 2.999999999999,
			ja = 3.73333333333333
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
				arg_1_0:Play319181002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

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
				local var_4_5 = arg_1_1.bgs_.STblack

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
					if iter_4_0 ~= "STblack" then
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

			local var_4_17 = 1.03400000184774

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

			local var_4_22 = "1084ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1084ui_story"].transform
			local var_4_28 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -0.97, -6)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -0.97, -6)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1084ui_story"]
			local var_4_37 = 1

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_40 = 1

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_4_41 = 1

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_4_42 = 0
			local var_4_43 = 1

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "effect"

				arg_1_1:AudioAction(var_4_44, var_4_45, "se_story_130", "se_story_130_hammer", "")
			end

			local var_4_46 = 0
			local var_4_47 = 0.2

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_52 = 1.43333333333333
			local var_4_53 = 0.0166666666666667

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_54 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_54:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_55 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_56 = arg_1_1:GetWordFromCfg(319181001)
				local var_4_57 = arg_1_1:FormatText(var_4_56.content)

				arg_1_1.text_.text = var_4_57

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_58 = 3
				local var_4_59 = utf8.len(var_4_57)
				local var_4_60 = var_4_58 <= 0 and var_4_53 or var_4_53 * (var_4_59 / var_4_58)

				if var_4_60 > 0 and var_4_53 < var_4_60 then
					arg_1_1.talkMaxDuration = var_4_60
					var_4_52 = var_4_52 + 0.3

					if var_4_60 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_60 + var_4_52
					end
				end

				arg_1_1.text_.text = var_4_57
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181001", "story_v_out_319181.awb") ~= 0 then
					local var_4_61 = manager.audio:GetVoiceLength("story_v_out_319181", "319181001", "story_v_out_319181.awb") / 1000

					if var_4_61 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_52
					end

					if var_4_56.prefab_name ~= "" and arg_1_1.actors_[var_4_56.prefab_name] ~= nil then
						local var_4_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_56.prefab_name].transform, "story_v_out_319181", "319181001", "story_v_out_319181.awb")

						arg_1_1:RecordAudio("319181001", var_4_62)
						arg_1_1:RecordAudio("319181001", var_4_62)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319181", "319181001", "story_v_out_319181.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319181", "319181001", "story_v_out_319181.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_63 = var_4_52 + 0.3
			local var_4_64 = math.max(var_4_53, arg_1_1.talkMaxDuration)

			if var_4_63 <= arg_1_1.time_ and arg_1_1.time_ < var_4_63 + var_4_64 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_63) / var_4_64

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_63 + var_4_64 and arg_1_1.time_ < var_4_63 + var_4_64 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319181002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319181002
		arg_8_1.duration_ = 3.1

		local var_8_0 = {
			zh = 1.999999999999,
			ja = 3.1
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
				arg_8_0:Play319181003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story_130", "se_story_130_hammer", "")
			end

			local var_11_4 = 0

			if var_11_4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_11_5 = 0
			local var_11_6 = 0.175

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_7 = arg_8_1:FormatText(StoryNameCfg[6].name)

				arg_8_1.leftNameTxt_.text = var_11_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_8 = arg_8_1:GetWordFromCfg(319181002)
				local var_11_9 = arg_8_1:FormatText(var_11_8.content)

				arg_8_1.text_.text = var_11_9

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_10 = 7
				local var_11_11 = utf8.len(var_11_9)
				local var_11_12 = var_11_10 <= 0 and var_11_6 or var_11_6 * (var_11_11 / var_11_10)

				if var_11_12 > 0 and var_11_6 < var_11_12 then
					arg_8_1.talkMaxDuration = var_11_12

					if var_11_12 + var_11_5 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_12 + var_11_5
					end
				end

				arg_8_1.text_.text = var_11_9
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181002", "story_v_out_319181.awb") ~= 0 then
					local var_11_13 = manager.audio:GetVoiceLength("story_v_out_319181", "319181002", "story_v_out_319181.awb") / 1000

					if var_11_13 + var_11_5 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_5
					end

					if var_11_8.prefab_name ~= "" and arg_8_1.actors_[var_11_8.prefab_name] ~= nil then
						local var_11_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_8.prefab_name].transform, "story_v_out_319181", "319181002", "story_v_out_319181.awb")

						arg_8_1:RecordAudio("319181002", var_11_14)
						arg_8_1:RecordAudio("319181002", var_11_14)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_319181", "319181002", "story_v_out_319181.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_319181", "319181002", "story_v_out_319181.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_15 = math.max(var_11_6, arg_8_1.talkMaxDuration)

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_15 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_5) / var_11_15

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_5 + var_11_15 and arg_8_1.time_ < var_11_5 + var_11_15 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play319181003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319181003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play319181004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1084ui_story"].transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_0.localPosition
			end

			local var_15_2 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2
				local var_15_4 = Vector3.New(0, 100, 0)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, var_15_4, var_15_3)

				local var_15_5 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_5.x, var_15_5.y, var_15_5.z)

				local var_15_6 = var_15_0.localEulerAngles

				var_15_6.z = 0
				var_15_6.x = 0
				var_15_0.localEulerAngles = var_15_6
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(0, 100, 0)

				local var_15_7 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_7.x, var_15_7.y, var_15_7.z)

				local var_15_8 = var_15_0.localEulerAngles

				var_15_8.z = 0
				var_15_8.x = 0
				var_15_0.localEulerAngles = var_15_8
			end

			local var_15_9 = 0
			local var_15_10 = 1.075

			if var_15_9 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_11 = arg_12_1:GetWordFromCfg(319181003)
				local var_15_12 = arg_12_1:FormatText(var_15_11.content)

				arg_12_1.text_.text = var_15_12

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 43
				local var_15_14 = utf8.len(var_15_12)
				local var_15_15 = var_15_13 <= 0 and var_15_10 or var_15_10 * (var_15_14 / var_15_13)

				if var_15_15 > 0 and var_15_10 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_9 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_9
					end
				end

				arg_12_1.text_.text = var_15_12
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_10, arg_12_1.talkMaxDuration)

			if var_15_9 <= arg_12_1.time_ and arg_12_1.time_ < var_15_9 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_9) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_9 + var_15_16 and arg_12_1.time_ < var_15_9 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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
	Play319181004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 319181004
		arg_16_1.duration_ = 9.07

		local var_16_0 = {
			zh = 6.8,
			ja = 9.066
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
				arg_16_0:Play319181005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "D02a"

			if arg_16_1.bgs_[var_19_0] == nil then
				local var_19_1 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_19_0)
				var_19_1.name = var_19_0
				var_19_1.transform.parent = arg_16_1.stage_.transform
				var_19_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_[var_19_0] = var_19_1
			end

			local var_19_2 = 1

			if var_19_2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				local var_19_3 = manager.ui.mainCamera.transform.localPosition
				local var_19_4 = Vector3.New(0, 0, 10) + Vector3.New(var_19_3.x, var_19_3.y, 0)
				local var_19_5 = arg_16_1.bgs_.D02a

				var_19_5.transform.localPosition = var_19_4
				var_19_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_6 = var_19_5:GetComponent("SpriteRenderer")

				if var_19_6 and var_19_6.sprite then
					local var_19_7 = (var_19_5.transform.localPosition - var_19_3).z
					local var_19_8 = manager.ui.mainCameraCom_
					local var_19_9 = 2 * var_19_7 * Mathf.Tan(var_19_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_19_10 = var_19_9 * var_19_8.aspect
					local var_19_11 = var_19_6.sprite.bounds.size.x
					local var_19_12 = var_19_6.sprite.bounds.size.y
					local var_19_13 = var_19_10 / var_19_11
					local var_19_14 = var_19_9 / var_19_12
					local var_19_15 = var_19_14 < var_19_13 and var_19_13 or var_19_14

					var_19_5.transform.localScale = Vector3.New(var_19_15, var_19_15, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "D02a" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_17 = 1

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_17 then
				local var_19_18 = (arg_16_1.time_ - var_19_16) / var_19_17
				local var_19_19 = Color.New(0, 0, 0)

				var_19_19.a = Mathf.Lerp(0, 1, var_19_18)
				arg_16_1.mask_.color = var_19_19
			end

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 then
				local var_19_20 = Color.New(0, 0, 0)

				var_19_20.a = 1
				arg_16_1.mask_.color = var_19_20
			end

			local var_19_21 = 1

			if var_19_21 < arg_16_1.time_ and arg_16_1.time_ <= var_19_21 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_22 = 2

			if var_19_21 <= arg_16_1.time_ and arg_16_1.time_ < var_19_21 + var_19_22 then
				local var_19_23 = (arg_16_1.time_ - var_19_21) / var_19_22
				local var_19_24 = Color.New(0, 0, 0)

				var_19_24.a = Mathf.Lerp(1, 0, var_19_23)
				arg_16_1.mask_.color = var_19_24
			end

			if arg_16_1.time_ >= var_19_21 + var_19_22 and arg_16_1.time_ < var_19_21 + var_19_22 + arg_19_0 then
				local var_19_25 = Color.New(0, 0, 0)
				local var_19_26 = 0

				arg_16_1.mask_.enabled = false
				var_19_25.a = var_19_26
				arg_16_1.mask_.color = var_19_25
			end

			local var_19_27 = 0
			local var_19_28 = 0.2

			if var_19_27 < arg_16_1.time_ and arg_16_1.time_ <= var_19_27 + arg_19_0 then
				local var_19_29 = "play"
				local var_19_30 = "music"

				arg_16_1:AudioAction(var_19_29, var_19_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_19_31 = ""
				local var_19_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_19_32 ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_32 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_32

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_32
						arg_16_1.bgmTxt2_.text = var_19_32
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_19_33 = 0.233333333333333
			local var_19_34 = 1

			if var_19_33 < arg_16_1.time_ and arg_16_1.time_ <= var_19_33 + arg_19_0 then
				local var_19_35 = "play"
				local var_19_36 = "music"

				arg_16_1:AudioAction(var_19_35, var_19_36, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_19_37 = ""
				local var_19_38 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_19_38 ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_38 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_38

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_38
						arg_16_1.bgmTxt2_.text = var_19_38
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_19_39 = arg_16_1.actors_["1084ui_story"]
			local var_19_40 = 2.86666666666667

			if var_19_40 < arg_16_1.time_ and arg_16_1.time_ <= var_19_40 + arg_19_0 and not isNil(var_19_39) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_41 = 0.200000002980232

			if var_19_40 <= arg_16_1.time_ and arg_16_1.time_ < var_19_40 + var_19_41 and not isNil(var_19_39) then
				local var_19_42 = (arg_16_1.time_ - var_19_40) / var_19_41

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_39) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_40 + var_19_41 and arg_16_1.time_ < var_19_40 + var_19_41 + arg_19_0 and not isNil(var_19_39) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_19_43 = arg_16_1.actors_["1084ui_story"].transform
			local var_19_44 = 2.86666666666667

			if var_19_44 < arg_16_1.time_ and arg_16_1.time_ <= var_19_44 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_43.localPosition
			end

			local var_19_45 = 0.001

			if var_19_44 <= arg_16_1.time_ and arg_16_1.time_ < var_19_44 + var_19_45 then
				local var_19_46 = (arg_16_1.time_ - var_19_44) / var_19_45
				local var_19_47 = Vector3.New(0, -0.97, -6)

				var_19_43.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, var_19_47, var_19_46)

				local var_19_48 = manager.ui.mainCamera.transform.position - var_19_43.position

				var_19_43.forward = Vector3.New(var_19_48.x, var_19_48.y, var_19_48.z)

				local var_19_49 = var_19_43.localEulerAngles

				var_19_49.z = 0
				var_19_49.x = 0
				var_19_43.localEulerAngles = var_19_49
			end

			if arg_16_1.time_ >= var_19_44 + var_19_45 and arg_16_1.time_ < var_19_44 + var_19_45 + arg_19_0 then
				var_19_43.localPosition = Vector3.New(0, -0.97, -6)

				local var_19_50 = manager.ui.mainCamera.transform.position - var_19_43.position

				var_19_43.forward = Vector3.New(var_19_50.x, var_19_50.y, var_19_50.z)

				local var_19_51 = var_19_43.localEulerAngles

				var_19_51.z = 0
				var_19_51.x = 0
				var_19_43.localEulerAngles = var_19_51
			end

			local var_19_52 = 2.86666666666667

			if var_19_52 < arg_16_1.time_ and arg_16_1.time_ <= var_19_52 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_19_53 = 2.86666666666667

			if var_19_53 < arg_16_1.time_ and arg_16_1.time_ <= var_19_53 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_54 = 3
			local var_19_55 = 0.45

			if var_19_54 < arg_16_1.time_ and arg_16_1.time_ <= var_19_54 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_56 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_56:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_16_1.dialogCg_.alpha = arg_22_0
				end))
				var_19_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_57 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_58 = arg_16_1:GetWordFromCfg(319181004)
				local var_19_59 = arg_16_1:FormatText(var_19_58.content)

				arg_16_1.text_.text = var_19_59

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_60 = 18
				local var_19_61 = utf8.len(var_19_59)
				local var_19_62 = var_19_60 <= 0 and var_19_55 or var_19_55 * (var_19_61 / var_19_60)

				if var_19_62 > 0 and var_19_55 < var_19_62 then
					arg_16_1.talkMaxDuration = var_19_62
					var_19_54 = var_19_54 + 0.3

					if var_19_62 + var_19_54 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_62 + var_19_54
					end
				end

				arg_16_1.text_.text = var_19_59
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181004", "story_v_out_319181.awb") ~= 0 then
					local var_19_63 = manager.audio:GetVoiceLength("story_v_out_319181", "319181004", "story_v_out_319181.awb") / 1000

					if var_19_63 + var_19_54 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_63 + var_19_54
					end

					if var_19_58.prefab_name ~= "" and arg_16_1.actors_[var_19_58.prefab_name] ~= nil then
						local var_19_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_58.prefab_name].transform, "story_v_out_319181", "319181004", "story_v_out_319181.awb")

						arg_16_1:RecordAudio("319181004", var_19_64)
						arg_16_1:RecordAudio("319181004", var_19_64)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_319181", "319181004", "story_v_out_319181.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_319181", "319181004", "story_v_out_319181.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_65 = var_19_54 + 0.3
			local var_19_66 = math.max(var_19_55, arg_16_1.talkMaxDuration)

			if var_19_65 <= arg_16_1.time_ and arg_16_1.time_ < var_19_65 + var_19_66 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_65) / var_19_66

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_65 + var_19_66 and arg_16_1.time_ < var_19_65 + var_19_66 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333337,
				className = "StoryMoveNode",
				startTime = 2.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play319181005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 319181005
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play319181006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1084ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1084ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 1.325

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_8 = arg_24_1:GetWordFromCfg(319181005)
				local var_27_9 = arg_24_1:FormatText(var_27_8.content)

				arg_24_1.text_.text = var_27_9

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_10 = 53
				local var_27_11 = utf8.len(var_27_9)
				local var_27_12 = var_27_10 <= 0 and var_27_7 or var_27_7 * (var_27_11 / var_27_10)

				if var_27_12 > 0 and var_27_7 < var_27_12 then
					arg_24_1.talkMaxDuration = var_27_12

					if var_27_12 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_9
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_13 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_13 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_13

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_13 and arg_24_1.time_ < var_27_6 + var_27_13 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play319181006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 319181006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play319181007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1.6

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:GetWordFromCfg(319181006)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 64
				local var_31_5 = utf8.len(var_31_3)
				local var_31_6 = var_31_4 <= 0 and var_31_1 or var_31_1 * (var_31_5 / var_31_4)

				if var_31_6 > 0 and var_31_1 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_7 and arg_28_1.time_ < var_31_0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play319181007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 319181007
		arg_32_1.duration_ = 8.87

		local var_32_0 = {
			zh = 5.333,
			ja = 8.866
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
				arg_32_0:Play319181008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "10066ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_32_1.stage_.transform)

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

			local var_35_5 = arg_32_1.actors_["10066ui_story"].transform
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.var_.moveOldPos10066ui_story = var_35_5.localPosition
			end

			local var_35_7 = 0.001

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7
				local var_35_9 = Vector3.New(0.7, -0.99, -5.83)

				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10066ui_story, var_35_9, var_35_8)

				local var_35_10 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_10.x, var_35_10.y, var_35_10.z)

				local var_35_11 = var_35_5.localEulerAngles

				var_35_11.z = 0
				var_35_11.x = 0
				var_35_5.localEulerAngles = var_35_11
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_35_12 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_12.x, var_35_12.y, var_35_12.z)

				local var_35_13 = var_35_5.localEulerAngles

				var_35_13.z = 0
				var_35_13.x = 0
				var_35_5.localEulerAngles = var_35_13
			end

			local var_35_14 = arg_32_1.actors_["10066ui_story"]
			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect10066ui_story == nil then
				arg_32_1.var_.characterEffect10066ui_story = var_35_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_16 = 0.200000002980232

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_16 and not isNil(var_35_14) then
				local var_35_17 = (arg_32_1.time_ - var_35_15) / var_35_16

				if arg_32_1.var_.characterEffect10066ui_story and not isNil(var_35_14) then
					arg_32_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_15 + var_35_16 and arg_32_1.time_ < var_35_15 + var_35_16 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect10066ui_story then
				arg_32_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_35_18 = 0

			if var_35_18 < arg_32_1.time_ and arg_32_1.time_ <= var_35_18 + arg_35_0 then
				arg_32_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			local var_35_19 = 0

			if var_35_19 < arg_32_1.time_ and arg_32_1.time_ <= var_35_19 + arg_35_0 then
				arg_32_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_35_20 = arg_32_1.actors_["1084ui_story"].transform
			local var_35_21 = 0

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_20.localPosition
			end

			local var_35_22 = 0.001

			if var_35_21 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_22 then
				local var_35_23 = (arg_32_1.time_ - var_35_21) / var_35_22
				local var_35_24 = Vector3.New(-0.7, -0.97, -6)

				var_35_20.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, var_35_24, var_35_23)

				local var_35_25 = manager.ui.mainCamera.transform.position - var_35_20.position

				var_35_20.forward = Vector3.New(var_35_25.x, var_35_25.y, var_35_25.z)

				local var_35_26 = var_35_20.localEulerAngles

				var_35_26.z = 0
				var_35_26.x = 0
				var_35_20.localEulerAngles = var_35_26
			end

			if arg_32_1.time_ >= var_35_21 + var_35_22 and arg_32_1.time_ < var_35_21 + var_35_22 + arg_35_0 then
				var_35_20.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_35_27 = manager.ui.mainCamera.transform.position - var_35_20.position

				var_35_20.forward = Vector3.New(var_35_27.x, var_35_27.y, var_35_27.z)

				local var_35_28 = var_35_20.localEulerAngles

				var_35_28.z = 0
				var_35_28.x = 0
				var_35_20.localEulerAngles = var_35_28
			end

			local var_35_29 = arg_32_1.actors_["1084ui_story"]
			local var_35_30 = 0

			if var_35_30 < arg_32_1.time_ and arg_32_1.time_ <= var_35_30 + arg_35_0 and not isNil(var_35_29) and arg_32_1.var_.characterEffect1084ui_story == nil then
				arg_32_1.var_.characterEffect1084ui_story = var_35_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_31 = 0.200000002980232

			if var_35_30 <= arg_32_1.time_ and arg_32_1.time_ < var_35_30 + var_35_31 and not isNil(var_35_29) then
				local var_35_32 = (arg_32_1.time_ - var_35_30) / var_35_31

				if arg_32_1.var_.characterEffect1084ui_story and not isNil(var_35_29) then
					local var_35_33 = Mathf.Lerp(0, 0.5, var_35_32)

					arg_32_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1084ui_story.fillRatio = var_35_33
				end
			end

			if arg_32_1.time_ >= var_35_30 + var_35_31 and arg_32_1.time_ < var_35_30 + var_35_31 + arg_35_0 and not isNil(var_35_29) and arg_32_1.var_.characterEffect1084ui_story then
				local var_35_34 = 0.5

				arg_32_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1084ui_story.fillRatio = var_35_34
			end

			local var_35_35 = 0

			if var_35_35 < arg_32_1.time_ and arg_32_1.time_ <= var_35_35 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_35_36 = 0
			local var_35_37 = 0.525

			if var_35_36 < arg_32_1.time_ and arg_32_1.time_ <= var_35_36 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_38 = arg_32_1:FormatText(StoryNameCfg[640].name)

				arg_32_1.leftNameTxt_.text = var_35_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_39 = arg_32_1:GetWordFromCfg(319181007)
				local var_35_40 = arg_32_1:FormatText(var_35_39.content)

				arg_32_1.text_.text = var_35_40

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_41 = 21
				local var_35_42 = utf8.len(var_35_40)
				local var_35_43 = var_35_41 <= 0 and var_35_37 or var_35_37 * (var_35_42 / var_35_41)

				if var_35_43 > 0 and var_35_37 < var_35_43 then
					arg_32_1.talkMaxDuration = var_35_43

					if var_35_43 + var_35_36 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_43 + var_35_36
					end
				end

				arg_32_1.text_.text = var_35_40
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181007", "story_v_out_319181.awb") ~= 0 then
					local var_35_44 = manager.audio:GetVoiceLength("story_v_out_319181", "319181007", "story_v_out_319181.awb") / 1000

					if var_35_44 + var_35_36 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_44 + var_35_36
					end

					if var_35_39.prefab_name ~= "" and arg_32_1.actors_[var_35_39.prefab_name] ~= nil then
						local var_35_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_39.prefab_name].transform, "story_v_out_319181", "319181007", "story_v_out_319181.awb")

						arg_32_1:RecordAudio("319181007", var_35_45)
						arg_32_1:RecordAudio("319181007", var_35_45)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_319181", "319181007", "story_v_out_319181.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_319181", "319181007", "story_v_out_319181.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_46 = math.max(var_35_37, arg_32_1.talkMaxDuration)

			if var_35_36 <= arg_32_1.time_ and arg_32_1.time_ < var_35_36 + var_35_46 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_36) / var_35_46

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_36 + var_35_46 and arg_32_1.time_ < var_35_36 + var_35_46 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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

		arg_32_1:InitPlayNodeList()
	end,
	Play319181008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 319181008
		arg_36_1.duration_ = 8.1

		local var_36_0 = {
			zh = 3.766,
			ja = 8.1
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
				arg_36_0:Play319181009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10066ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10066ui_story == nil then
				arg_36_1.var_.characterEffect10066ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect10066ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10066ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10066ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10066ui_story.fillRatio = var_39_5
			end

			local var_39_6 = arg_36_1.actors_["1084ui_story"]
			local var_39_7 = 0

			if var_39_7 < arg_36_1.time_ and arg_36_1.time_ <= var_39_7 + arg_39_0 and not isNil(var_39_6) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_8 = 0.200000002980232

			if var_39_7 <= arg_36_1.time_ and arg_36_1.time_ < var_39_7 + var_39_8 and not isNil(var_39_6) then
				local var_39_9 = (arg_36_1.time_ - var_39_7) / var_39_8

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_6) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_7 + var_39_8 and arg_36_1.time_ < var_39_7 + var_39_8 + arg_39_0 and not isNil(var_39_6) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_39_11 = 0
			local var_39_12 = 0.4

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_13 = arg_36_1:FormatText(StoryNameCfg[6].name)

				arg_36_1.leftNameTxt_.text = var_39_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_14 = arg_36_1:GetWordFromCfg(319181008)
				local var_39_15 = arg_36_1:FormatText(var_39_14.content)

				arg_36_1.text_.text = var_39_15

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_16 = 16
				local var_39_17 = utf8.len(var_39_15)
				local var_39_18 = var_39_16 <= 0 and var_39_12 or var_39_12 * (var_39_17 / var_39_16)

				if var_39_18 > 0 and var_39_12 < var_39_18 then
					arg_36_1.talkMaxDuration = var_39_18

					if var_39_18 + var_39_11 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_11
					end
				end

				arg_36_1.text_.text = var_39_15
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181008", "story_v_out_319181.awb") ~= 0 then
					local var_39_19 = manager.audio:GetVoiceLength("story_v_out_319181", "319181008", "story_v_out_319181.awb") / 1000

					if var_39_19 + var_39_11 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_19 + var_39_11
					end

					if var_39_14.prefab_name ~= "" and arg_36_1.actors_[var_39_14.prefab_name] ~= nil then
						local var_39_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_14.prefab_name].transform, "story_v_out_319181", "319181008", "story_v_out_319181.awb")

						arg_36_1:RecordAudio("319181008", var_39_20)
						arg_36_1:RecordAudio("319181008", var_39_20)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_319181", "319181008", "story_v_out_319181.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_319181", "319181008", "story_v_out_319181.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_21 = math.max(var_39_12, arg_36_1.talkMaxDuration)

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_21 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_11) / var_39_21

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_11 + var_39_21 and arg_36_1.time_ < var_39_11 + var_39_21 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play319181009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 319181009
		arg_40_1.duration_ = 6.8

		local var_40_0 = {
			zh = 6.8,
			ja = 4.4
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
				arg_40_0:Play319181010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10066ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10066ui_story == nil then
				arg_40_1.var_.characterEffect10066ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect10066ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10066ui_story then
				arg_40_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1084ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.200000002980232

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1084ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_43_11 = 0
			local var_43_12 = 0.7

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_13 = arg_40_1:FormatText(StoryNameCfg[640].name)

				arg_40_1.leftNameTxt_.text = var_43_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_14 = arg_40_1:GetWordFromCfg(319181009)
				local var_43_15 = arg_40_1:FormatText(var_43_14.content)

				arg_40_1.text_.text = var_43_15

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_16 = 28
				local var_43_17 = utf8.len(var_43_15)
				local var_43_18 = var_43_16 <= 0 and var_43_12 or var_43_12 * (var_43_17 / var_43_16)

				if var_43_18 > 0 and var_43_12 < var_43_18 then
					arg_40_1.talkMaxDuration = var_43_18

					if var_43_18 + var_43_11 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_18 + var_43_11
					end
				end

				arg_40_1.text_.text = var_43_15
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181009", "story_v_out_319181.awb") ~= 0 then
					local var_43_19 = manager.audio:GetVoiceLength("story_v_out_319181", "319181009", "story_v_out_319181.awb") / 1000

					if var_43_19 + var_43_11 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_11
					end

					if var_43_14.prefab_name ~= "" and arg_40_1.actors_[var_43_14.prefab_name] ~= nil then
						local var_43_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_14.prefab_name].transform, "story_v_out_319181", "319181009", "story_v_out_319181.awb")

						arg_40_1:RecordAudio("319181009", var_43_20)
						arg_40_1:RecordAudio("319181009", var_43_20)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_319181", "319181009", "story_v_out_319181.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_319181", "319181009", "story_v_out_319181.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_21 = math.max(var_43_12, arg_40_1.talkMaxDuration)

			if var_43_11 <= arg_40_1.time_ and arg_40_1.time_ < var_43_11 + var_43_21 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_11) / var_43_21

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_11 + var_43_21 and arg_40_1.time_ < var_43_11 + var_43_21 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play319181010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 319181010
		arg_44_1.duration_ = 3.07

		local var_44_0 = {
			zh = 3.066,
			ja = 2.833
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
				arg_44_0:Play319181011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.25

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[640].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:GetWordFromCfg(319181010)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 10
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181010", "story_v_out_319181.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_319181", "319181010", "story_v_out_319181.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_319181", "319181010", "story_v_out_319181.awb")

						arg_44_1:RecordAudio("319181010", var_47_9)
						arg_44_1:RecordAudio("319181010", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_319181", "319181010", "story_v_out_319181.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_319181", "319181010", "story_v_out_319181.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play319181011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319181011
		arg_48_1.duration_ = 8.23

		local var_48_0 = {
			zh = 6,
			ja = 8.233
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
				arg_48_0:Play319181012(arg_48_1)
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
				local var_51_4 = Vector3.New(-0.7, -0.97, -6)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = arg_48_1.actors_["1084ui_story"]
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.200000002980232

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 and not isNil(var_51_9) then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_9) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_51_13 = 0

			if var_51_13 < arg_48_1.time_ and arg_48_1.time_ <= var_51_13 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_51_14 = arg_48_1.actors_["10066ui_story"]
			local var_51_15 = 0

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 and not isNil(var_51_14) and arg_48_1.var_.characterEffect10066ui_story == nil then
				arg_48_1.var_.characterEffect10066ui_story = var_51_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_16 = 0.200000002980232

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_16 and not isNil(var_51_14) then
				local var_51_17 = (arg_48_1.time_ - var_51_15) / var_51_16

				if arg_48_1.var_.characterEffect10066ui_story and not isNil(var_51_14) then
					local var_51_18 = Mathf.Lerp(0, 0.5, var_51_17)

					arg_48_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10066ui_story.fillRatio = var_51_18
				end
			end

			if arg_48_1.time_ >= var_51_15 + var_51_16 and arg_48_1.time_ < var_51_15 + var_51_16 + arg_51_0 and not isNil(var_51_14) and arg_48_1.var_.characterEffect10066ui_story then
				local var_51_19 = 0.5

				arg_48_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10066ui_story.fillRatio = var_51_19
			end

			local var_51_20 = 0
			local var_51_21 = 0.65

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_22 = arg_48_1:FormatText(StoryNameCfg[6].name)

				arg_48_1.leftNameTxt_.text = var_51_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_23 = arg_48_1:GetWordFromCfg(319181011)
				local var_51_24 = arg_48_1:FormatText(var_51_23.content)

				arg_48_1.text_.text = var_51_24

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_25 = 26
				local var_51_26 = utf8.len(var_51_24)
				local var_51_27 = var_51_25 <= 0 and var_51_21 or var_51_21 * (var_51_26 / var_51_25)

				if var_51_27 > 0 and var_51_21 < var_51_27 then
					arg_48_1.talkMaxDuration = var_51_27

					if var_51_27 + var_51_20 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_27 + var_51_20
					end
				end

				arg_48_1.text_.text = var_51_24
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181011", "story_v_out_319181.awb") ~= 0 then
					local var_51_28 = manager.audio:GetVoiceLength("story_v_out_319181", "319181011", "story_v_out_319181.awb") / 1000

					if var_51_28 + var_51_20 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_28 + var_51_20
					end

					if var_51_23.prefab_name ~= "" and arg_48_1.actors_[var_51_23.prefab_name] ~= nil then
						local var_51_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_23.prefab_name].transform, "story_v_out_319181", "319181011", "story_v_out_319181.awb")

						arg_48_1:RecordAudio("319181011", var_51_29)
						arg_48_1:RecordAudio("319181011", var_51_29)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_319181", "319181011", "story_v_out_319181.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_319181", "319181011", "story_v_out_319181.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_30 = math.max(var_51_21, arg_48_1.talkMaxDuration)

			if var_51_20 <= arg_48_1.time_ and arg_48_1.time_ < var_51_20 + var_51_30 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_20) / var_51_30

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_20 + var_51_30 and arg_48_1.time_ < var_51_20 + var_51_30 + arg_51_0 then
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
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play319181012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319181012
		arg_52_1.duration_ = 3.5

		local var_52_0 = {
			zh = 3.266,
			ja = 3.5
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
				arg_52_0:Play319181013(arg_52_1)
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

			local var_55_6 = 0
			local var_55_7 = 0.325

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[36].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_9 = arg_52_1:GetWordFromCfg(319181012)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 13
				local var_55_12 = utf8.len(var_55_10)
				local var_55_13 = var_55_11 <= 0 and var_55_7 or var_55_7 * (var_55_12 / var_55_11)

				if var_55_13 > 0 and var_55_7 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181012", "story_v_out_319181.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_319181", "319181012", "story_v_out_319181.awb") / 1000

					if var_55_14 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_6
					end

					if var_55_9.prefab_name ~= "" and arg_52_1.actors_[var_55_9.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_9.prefab_name].transform, "story_v_out_319181", "319181012", "story_v_out_319181.awb")

						arg_52_1:RecordAudio("319181012", var_55_15)
						arg_52_1:RecordAudio("319181012", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_319181", "319181012", "story_v_out_319181.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_319181", "319181012", "story_v_out_319181.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_16 and arg_52_1.time_ < var_55_6 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play319181013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319181013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play319181014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10066ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos10066ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, 100, 0)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10066ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, 100, 0)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = arg_56_1.actors_["10066ui_story"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect10066ui_story == nil then
				arg_56_1.var_.characterEffect10066ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect10066ui_story and not isNil(var_59_9) then
					local var_59_13 = Mathf.Lerp(0, 0.5, var_59_12)

					arg_56_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10066ui_story.fillRatio = var_59_13
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect10066ui_story then
				local var_59_14 = 0.5

				arg_56_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10066ui_story.fillRatio = var_59_14
			end

			local var_59_15 = arg_56_1.actors_["1084ui_story"].transform
			local var_59_16 = 0

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_15.localPosition
			end

			local var_59_17 = 0.001

			if var_59_16 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_17 then
				local var_59_18 = (arg_56_1.time_ - var_59_16) / var_59_17
				local var_59_19 = Vector3.New(0, 100, 0)

				var_59_15.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, var_59_19, var_59_18)

				local var_59_20 = manager.ui.mainCamera.transform.position - var_59_15.position

				var_59_15.forward = Vector3.New(var_59_20.x, var_59_20.y, var_59_20.z)

				local var_59_21 = var_59_15.localEulerAngles

				var_59_21.z = 0
				var_59_21.x = 0
				var_59_15.localEulerAngles = var_59_21
			end

			if arg_56_1.time_ >= var_59_16 + var_59_17 and arg_56_1.time_ < var_59_16 + var_59_17 + arg_59_0 then
				var_59_15.localPosition = Vector3.New(0, 100, 0)

				local var_59_22 = manager.ui.mainCamera.transform.position - var_59_15.position

				var_59_15.forward = Vector3.New(var_59_22.x, var_59_22.y, var_59_22.z)

				local var_59_23 = var_59_15.localEulerAngles

				var_59_23.z = 0
				var_59_23.x = 0
				var_59_15.localEulerAngles = var_59_23
			end

			local var_59_24 = arg_56_1.actors_["1084ui_story"]
			local var_59_25 = 0

			if var_59_25 < arg_56_1.time_ and arg_56_1.time_ <= var_59_25 + arg_59_0 and not isNil(var_59_24) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_26 = 0.200000002980232

			if var_59_25 <= arg_56_1.time_ and arg_56_1.time_ < var_59_25 + var_59_26 and not isNil(var_59_24) then
				local var_59_27 = (arg_56_1.time_ - var_59_25) / var_59_26

				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_24) then
					local var_59_28 = Mathf.Lerp(0, 0.5, var_59_27)

					arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1084ui_story.fillRatio = var_59_28
				end
			end

			if arg_56_1.time_ >= var_59_25 + var_59_26 and arg_56_1.time_ < var_59_25 + var_59_26 + arg_59_0 and not isNil(var_59_24) and arg_56_1.var_.characterEffect1084ui_story then
				local var_59_29 = 0.5

				arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1084ui_story.fillRatio = var_59_29
			end

			local var_59_30 = 0
			local var_59_31 = 1

			if var_59_30 < arg_56_1.time_ and arg_56_1.time_ <= var_59_30 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_32 = arg_56_1:GetWordFromCfg(319181013)
				local var_59_33 = arg_56_1:FormatText(var_59_32.content)

				arg_56_1.text_.text = var_59_33

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_34 = 40
				local var_59_35 = utf8.len(var_59_33)
				local var_59_36 = var_59_34 <= 0 and var_59_31 or var_59_31 * (var_59_35 / var_59_34)

				if var_59_36 > 0 and var_59_31 < var_59_36 then
					arg_56_1.talkMaxDuration = var_59_36

					if var_59_36 + var_59_30 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_36 + var_59_30
					end
				end

				arg_56_1.text_.text = var_59_33
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_37 = math.max(var_59_31, arg_56_1.talkMaxDuration)

			if var_59_30 <= arg_56_1.time_ and arg_56_1.time_ < var_59_30 + var_59_37 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_30) / var_59_37

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_30 + var_59_37 and arg_56_1.time_ < var_59_30 + var_59_37 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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

		arg_56_1:InitPlayNodeList()
	end,
	Play319181014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319181014
		arg_60_1.duration_ = 4.63

		local var_60_0 = {
			zh = 2.8,
			ja = 4.633
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
				arg_60_0:Play319181015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "4040ui_story"

			if arg_60_1.actors_[var_63_0] == nil then
				local var_63_1 = Asset.Load("Char/" .. "4040ui_story")

				if not isNil(var_63_1) then
					local var_63_2 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_60_1.stage_.transform)

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

			local var_63_5 = arg_60_1.actors_["4040ui_story"].transform
			local var_63_6 = 0

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.var_.moveOldPos4040ui_story = var_63_5.localPosition
			end

			local var_63_7 = 0.001

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_7 then
				local var_63_8 = (arg_60_1.time_ - var_63_6) / var_63_7
				local var_63_9 = Vector3.New(0, -1.55, -5.5)

				var_63_5.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos4040ui_story, var_63_9, var_63_8)

				local var_63_10 = manager.ui.mainCamera.transform.position - var_63_5.position

				var_63_5.forward = Vector3.New(var_63_10.x, var_63_10.y, var_63_10.z)

				local var_63_11 = var_63_5.localEulerAngles

				var_63_11.z = 0
				var_63_11.x = 0
				var_63_5.localEulerAngles = var_63_11
			end

			if arg_60_1.time_ >= var_63_6 + var_63_7 and arg_60_1.time_ < var_63_6 + var_63_7 + arg_63_0 then
				var_63_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_63_12 = manager.ui.mainCamera.transform.position - var_63_5.position

				var_63_5.forward = Vector3.New(var_63_12.x, var_63_12.y, var_63_12.z)

				local var_63_13 = var_63_5.localEulerAngles

				var_63_13.z = 0
				var_63_13.x = 0
				var_63_5.localEulerAngles = var_63_13
			end

			local var_63_14 = arg_60_1.actors_["4040ui_story"]
			local var_63_15 = 0

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 and not isNil(var_63_14) and arg_60_1.var_.characterEffect4040ui_story == nil then
				arg_60_1.var_.characterEffect4040ui_story = var_63_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_16 = 0.200000002980232

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_16 and not isNil(var_63_14) then
				local var_63_17 = (arg_60_1.time_ - var_63_15) / var_63_16

				if arg_60_1.var_.characterEffect4040ui_story and not isNil(var_63_14) then
					arg_60_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_15 + var_63_16 and arg_60_1.time_ < var_63_15 + var_63_16 + arg_63_0 and not isNil(var_63_14) and arg_60_1.var_.characterEffect4040ui_story then
				arg_60_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_63_18 = 0

			if var_63_18 < arg_60_1.time_ and arg_60_1.time_ <= var_63_18 + arg_63_0 then
				arg_60_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_63_19 = 0

			if var_63_19 < arg_60_1.time_ and arg_60_1.time_ <= var_63_19 + arg_63_0 then
				arg_60_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_63_20 = 0
			local var_63_21 = 0.275

			if var_63_20 < arg_60_1.time_ and arg_60_1.time_ <= var_63_20 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_22 = arg_60_1:FormatText(StoryNameCfg[668].name)

				arg_60_1.leftNameTxt_.text = var_63_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_23 = arg_60_1:GetWordFromCfg(319181014)
				local var_63_24 = arg_60_1:FormatText(var_63_23.content)

				arg_60_1.text_.text = var_63_24

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_25 = 11
				local var_63_26 = utf8.len(var_63_24)
				local var_63_27 = var_63_25 <= 0 and var_63_21 or var_63_21 * (var_63_26 / var_63_25)

				if var_63_27 > 0 and var_63_21 < var_63_27 then
					arg_60_1.talkMaxDuration = var_63_27

					if var_63_27 + var_63_20 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_27 + var_63_20
					end
				end

				arg_60_1.text_.text = var_63_24
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181014", "story_v_out_319181.awb") ~= 0 then
					local var_63_28 = manager.audio:GetVoiceLength("story_v_out_319181", "319181014", "story_v_out_319181.awb") / 1000

					if var_63_28 + var_63_20 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_28 + var_63_20
					end

					if var_63_23.prefab_name ~= "" and arg_60_1.actors_[var_63_23.prefab_name] ~= nil then
						local var_63_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_23.prefab_name].transform, "story_v_out_319181", "319181014", "story_v_out_319181.awb")

						arg_60_1:RecordAudio("319181014", var_63_29)
						arg_60_1:RecordAudio("319181014", var_63_29)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_319181", "319181014", "story_v_out_319181.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_319181", "319181014", "story_v_out_319181.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_30 = math.max(var_63_21, arg_60_1.talkMaxDuration)

			if var_63_20 <= arg_60_1.time_ and arg_60_1.time_ < var_63_20 + var_63_30 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_20) / var_63_30

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_20 + var_63_30 and arg_60_1.time_ < var_63_20 + var_63_30 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319181015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319181015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play319181016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1084ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["4040ui_story"].transform
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.var_.moveOldPos4040ui_story = var_67_9.localPosition
			end

			local var_67_11 = 0.001

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11
				local var_67_13 = Vector3.New(0, 100, 0)

				var_67_9.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos4040ui_story, var_67_13, var_67_12)

				local var_67_14 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_14.x, var_67_14.y, var_67_14.z)

				local var_67_15 = var_67_9.localEulerAngles

				var_67_15.z = 0
				var_67_15.x = 0
				var_67_9.localEulerAngles = var_67_15
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 then
				var_67_9.localPosition = Vector3.New(0, 100, 0)

				local var_67_16 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_16.x, var_67_16.y, var_67_16.z)

				local var_67_17 = var_67_9.localEulerAngles

				var_67_17.z = 0
				var_67_17.x = 0
				var_67_9.localEulerAngles = var_67_17
			end

			local var_67_18 = arg_64_1.actors_["4040ui_story"]
			local var_67_19 = 0

			if var_67_19 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 and not isNil(var_67_18) and arg_64_1.var_.characterEffect4040ui_story == nil then
				arg_64_1.var_.characterEffect4040ui_story = var_67_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_20 = 0.200000002980232

			if var_67_19 <= arg_64_1.time_ and arg_64_1.time_ < var_67_19 + var_67_20 and not isNil(var_67_18) then
				local var_67_21 = (arg_64_1.time_ - var_67_19) / var_67_20

				if arg_64_1.var_.characterEffect4040ui_story and not isNil(var_67_18) then
					local var_67_22 = Mathf.Lerp(0, 0.5, var_67_21)

					arg_64_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_64_1.var_.characterEffect4040ui_story.fillRatio = var_67_22
				end
			end

			if arg_64_1.time_ >= var_67_19 + var_67_20 and arg_64_1.time_ < var_67_19 + var_67_20 + arg_67_0 and not isNil(var_67_18) and arg_64_1.var_.characterEffect4040ui_story then
				local var_67_23 = 0.5

				arg_64_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_64_1.var_.characterEffect4040ui_story.fillRatio = var_67_23
			end

			local var_67_24 = 0
			local var_67_25 = 0.9

			if var_67_24 < arg_64_1.time_ and arg_64_1.time_ <= var_67_24 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_26 = arg_64_1:GetWordFromCfg(319181015)
				local var_67_27 = arg_64_1:FormatText(var_67_26.content)

				arg_64_1.text_.text = var_67_27

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_28 = 36
				local var_67_29 = utf8.len(var_67_27)
				local var_67_30 = var_67_28 <= 0 and var_67_25 or var_67_25 * (var_67_29 / var_67_28)

				if var_67_30 > 0 and var_67_25 < var_67_30 then
					arg_64_1.talkMaxDuration = var_67_30

					if var_67_30 + var_67_24 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_30 + var_67_24
					end
				end

				arg_64_1.text_.text = var_67_27
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_31 = math.max(var_67_25, arg_64_1.talkMaxDuration)

			if var_67_24 <= arg_64_1.time_ and arg_64_1.time_ < var_67_24 + var_67_31 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_24) / var_67_31

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_24 + var_67_31 and arg_64_1.time_ < var_67_24 + var_67_31 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play319181016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 319181016
		arg_68_1.duration_ = 2.77

		local var_68_0 = {
			zh = 1.933,
			ja = 2.766
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
				arg_68_0:Play319181017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1084ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1084ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["1084ui_story"].transform
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_4.localPosition
			end

			local var_71_6 = 0.001

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6
				local var_71_8 = Vector3.New(0.7, -0.97, -6)

				var_71_4.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, var_71_8, var_71_7)

				local var_71_9 = manager.ui.mainCamera.transform.position - var_71_4.position

				var_71_4.forward = Vector3.New(var_71_9.x, var_71_9.y, var_71_9.z)

				local var_71_10 = var_71_4.localEulerAngles

				var_71_10.z = 0
				var_71_10.x = 0
				var_71_4.localEulerAngles = var_71_10
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 then
				var_71_4.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_71_11 = manager.ui.mainCamera.transform.position - var_71_4.position

				var_71_4.forward = Vector3.New(var_71_11.x, var_71_11.y, var_71_11.z)

				local var_71_12 = var_71_4.localEulerAngles

				var_71_12.z = 0
				var_71_12.x = 0
				var_71_4.localEulerAngles = var_71_12
			end

			local var_71_13 = 0
			local var_71_14 = 0.225

			if var_71_13 < arg_68_1.time_ and arg_68_1.time_ <= var_71_13 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_15 = arg_68_1:FormatText(StoryNameCfg[6].name)

				arg_68_1.leftNameTxt_.text = var_71_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_16 = arg_68_1:GetWordFromCfg(319181016)
				local var_71_17 = arg_68_1:FormatText(var_71_16.content)

				arg_68_1.text_.text = var_71_17

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_18 = 9
				local var_71_19 = utf8.len(var_71_17)
				local var_71_20 = var_71_18 <= 0 and var_71_14 or var_71_14 * (var_71_19 / var_71_18)

				if var_71_20 > 0 and var_71_14 < var_71_20 then
					arg_68_1.talkMaxDuration = var_71_20

					if var_71_20 + var_71_13 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_20 + var_71_13
					end
				end

				arg_68_1.text_.text = var_71_17
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181016", "story_v_out_319181.awb") ~= 0 then
					local var_71_21 = manager.audio:GetVoiceLength("story_v_out_319181", "319181016", "story_v_out_319181.awb") / 1000

					if var_71_21 + var_71_13 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_21 + var_71_13
					end

					if var_71_16.prefab_name ~= "" and arg_68_1.actors_[var_71_16.prefab_name] ~= nil then
						local var_71_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_16.prefab_name].transform, "story_v_out_319181", "319181016", "story_v_out_319181.awb")

						arg_68_1:RecordAudio("319181016", var_71_22)
						arg_68_1:RecordAudio("319181016", var_71_22)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_319181", "319181016", "story_v_out_319181.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_319181", "319181016", "story_v_out_319181.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_23 = math.max(var_71_14, arg_68_1.talkMaxDuration)

			if var_71_13 <= arg_68_1.time_ and arg_68_1.time_ < var_71_13 + var_71_23 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_13) / var_71_23

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_13 + var_71_23 and arg_68_1.time_ < var_71_13 + var_71_23 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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

		arg_68_1:InitPlayNodeList()
	end,
	Play319181017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 319181017
		arg_72_1.duration_ = 6.4

		local var_72_0 = {
			zh = 6.4,
			ja = 3.333
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play319181018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["4040ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect4040ui_story == nil then
				arg_72_1.var_.characterEffect4040ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect4040ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect4040ui_story then
				arg_72_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["1084ui_story"]
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.200000002980232

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 and not isNil(var_75_4) then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6

				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_4) then
					local var_75_8 = Mathf.Lerp(0, 0.5, var_75_7)

					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_8
				end
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1084ui_story then
				local var_75_9 = 0.5

				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_9
			end

			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_75_11 = arg_72_1.actors_["4040ui_story"].transform
			local var_75_12 = 0

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 then
				arg_72_1.var_.moveOldPos4040ui_story = var_75_11.localPosition
			end

			local var_75_13 = 0.001

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_13 then
				local var_75_14 = (arg_72_1.time_ - var_75_12) / var_75_13
				local var_75_15 = Vector3.New(-0.7, -1.55, -5.5)

				var_75_11.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos4040ui_story, var_75_15, var_75_14)

				local var_75_16 = manager.ui.mainCamera.transform.position - var_75_11.position

				var_75_11.forward = Vector3.New(var_75_16.x, var_75_16.y, var_75_16.z)

				local var_75_17 = var_75_11.localEulerAngles

				var_75_17.z = 0
				var_75_17.x = 0
				var_75_11.localEulerAngles = var_75_17
			end

			if arg_72_1.time_ >= var_75_12 + var_75_13 and arg_72_1.time_ < var_75_12 + var_75_13 + arg_75_0 then
				var_75_11.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_75_18 = manager.ui.mainCamera.transform.position - var_75_11.position

				var_75_11.forward = Vector3.New(var_75_18.x, var_75_18.y, var_75_18.z)

				local var_75_19 = var_75_11.localEulerAngles

				var_75_19.z = 0
				var_75_19.x = 0
				var_75_11.localEulerAngles = var_75_19
			end

			local var_75_20 = 0
			local var_75_21 = 0.75

			if var_75_20 < arg_72_1.time_ and arg_72_1.time_ <= var_75_20 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_22 = arg_72_1:FormatText(StoryNameCfg[668].name)

				arg_72_1.leftNameTxt_.text = var_75_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_23 = arg_72_1:GetWordFromCfg(319181017)
				local var_75_24 = arg_72_1:FormatText(var_75_23.content)

				arg_72_1.text_.text = var_75_24

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_25 = 30
				local var_75_26 = utf8.len(var_75_24)
				local var_75_27 = var_75_25 <= 0 and var_75_21 or var_75_21 * (var_75_26 / var_75_25)

				if var_75_27 > 0 and var_75_21 < var_75_27 then
					arg_72_1.talkMaxDuration = var_75_27

					if var_75_27 + var_75_20 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_27 + var_75_20
					end
				end

				arg_72_1.text_.text = var_75_24
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181017", "story_v_out_319181.awb") ~= 0 then
					local var_75_28 = manager.audio:GetVoiceLength("story_v_out_319181", "319181017", "story_v_out_319181.awb") / 1000

					if var_75_28 + var_75_20 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_28 + var_75_20
					end

					if var_75_23.prefab_name ~= "" and arg_72_1.actors_[var_75_23.prefab_name] ~= nil then
						local var_75_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_23.prefab_name].transform, "story_v_out_319181", "319181017", "story_v_out_319181.awb")

						arg_72_1:RecordAudio("319181017", var_75_29)
						arg_72_1:RecordAudio("319181017", var_75_29)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_319181", "319181017", "story_v_out_319181.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_319181", "319181017", "story_v_out_319181.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_30 = math.max(var_75_21, arg_72_1.talkMaxDuration)

			if var_75_20 <= arg_72_1.time_ and arg_72_1.time_ < var_75_20 + var_75_30 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_20) / var_75_30

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_20 + var_75_30 and arg_72_1.time_ < var_75_20 + var_75_30 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play319181018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319181018
		arg_76_1.duration_ = 10.07

		local var_76_0 = {
			zh = 4.433,
			ja = 10.066
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
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play319181019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1084ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos1084ui_story = var_79_0.localPosition
			end

			local var_79_2 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2
				local var_79_4 = Vector3.New(0.7, -0.97, -6)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1084ui_story, var_79_4, var_79_3)

				local var_79_5 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_5.x, var_79_5.y, var_79_5.z)

				local var_79_6 = var_79_0.localEulerAngles

				var_79_6.z = 0
				var_79_6.x = 0
				var_79_0.localEulerAngles = var_79_6
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_79_7 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_7.x, var_79_7.y, var_79_7.z)

				local var_79_8 = var_79_0.localEulerAngles

				var_79_8.z = 0
				var_79_8.x = 0
				var_79_0.localEulerAngles = var_79_8
			end

			local var_79_9 = arg_76_1.actors_["1084ui_story"]
			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect1084ui_story == nil then
				arg_76_1.var_.characterEffect1084ui_story = var_79_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_11 = 0.200000002980232

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_11 and not isNil(var_79_9) then
				local var_79_12 = (arg_76_1.time_ - var_79_10) / var_79_11

				if arg_76_1.var_.characterEffect1084ui_story and not isNil(var_79_9) then
					arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_10 + var_79_11 and arg_76_1.time_ < var_79_10 + var_79_11 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect1084ui_story then
				arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_79_13 = 0

			if var_79_13 < arg_76_1.time_ and arg_76_1.time_ <= var_79_13 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_79_14 = 0

			if var_79_14 < arg_76_1.time_ and arg_76_1.time_ <= var_79_14 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_79_15 = arg_76_1.actors_["4040ui_story"]
			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 and not isNil(var_79_15) and arg_76_1.var_.characterEffect4040ui_story == nil then
				arg_76_1.var_.characterEffect4040ui_story = var_79_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_17 = 0.200000002980232

			if var_79_16 <= arg_76_1.time_ and arg_76_1.time_ < var_79_16 + var_79_17 and not isNil(var_79_15) then
				local var_79_18 = (arg_76_1.time_ - var_79_16) / var_79_17

				if arg_76_1.var_.characterEffect4040ui_story and not isNil(var_79_15) then
					local var_79_19 = Mathf.Lerp(0, 0.5, var_79_18)

					arg_76_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_76_1.var_.characterEffect4040ui_story.fillRatio = var_79_19
				end
			end

			if arg_76_1.time_ >= var_79_16 + var_79_17 and arg_76_1.time_ < var_79_16 + var_79_17 + arg_79_0 and not isNil(var_79_15) and arg_76_1.var_.characterEffect4040ui_story then
				local var_79_20 = 0.5

				arg_76_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_76_1.var_.characterEffect4040ui_story.fillRatio = var_79_20
			end

			local var_79_21 = 0
			local var_79_22 = 0.525

			if var_79_21 < arg_76_1.time_ and arg_76_1.time_ <= var_79_21 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_23 = arg_76_1:FormatText(StoryNameCfg[6].name)

				arg_76_1.leftNameTxt_.text = var_79_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_24 = arg_76_1:GetWordFromCfg(319181018)
				local var_79_25 = arg_76_1:FormatText(var_79_24.content)

				arg_76_1.text_.text = var_79_25

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_26 = 21
				local var_79_27 = utf8.len(var_79_25)
				local var_79_28 = var_79_26 <= 0 and var_79_22 or var_79_22 * (var_79_27 / var_79_26)

				if var_79_28 > 0 and var_79_22 < var_79_28 then
					arg_76_1.talkMaxDuration = var_79_28

					if var_79_28 + var_79_21 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_28 + var_79_21
					end
				end

				arg_76_1.text_.text = var_79_25
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181018", "story_v_out_319181.awb") ~= 0 then
					local var_79_29 = manager.audio:GetVoiceLength("story_v_out_319181", "319181018", "story_v_out_319181.awb") / 1000

					if var_79_29 + var_79_21 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_29 + var_79_21
					end

					if var_79_24.prefab_name ~= "" and arg_76_1.actors_[var_79_24.prefab_name] ~= nil then
						local var_79_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_24.prefab_name].transform, "story_v_out_319181", "319181018", "story_v_out_319181.awb")

						arg_76_1:RecordAudio("319181018", var_79_30)
						arg_76_1:RecordAudio("319181018", var_79_30)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_319181", "319181018", "story_v_out_319181.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_319181", "319181018", "story_v_out_319181.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_31 = math.max(var_79_22, arg_76_1.talkMaxDuration)

			if var_79_21 <= arg_76_1.time_ and arg_76_1.time_ < var_79_21 + var_79_31 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_21) / var_79_31

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_21 + var_79_31 and arg_76_1.time_ < var_79_21 + var_79_31 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play319181019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319181019
		arg_80_1.duration_ = 6.77

		local var_80_0 = {
			zh = 5.633,
			ja = 6.766
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
				arg_80_0:Play319181020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1084ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1084ui_story and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1084ui_story.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1084ui_story then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1084ui_story.fillRatio = var_83_5
			end

			local var_83_6 = arg_80_1.actors_["4040ui_story"]
			local var_83_7 = 0

			if var_83_7 < arg_80_1.time_ and arg_80_1.time_ <= var_83_7 + arg_83_0 and not isNil(var_83_6) and arg_80_1.var_.characterEffect4040ui_story == nil then
				arg_80_1.var_.characterEffect4040ui_story = var_83_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_8 = 0.200000002980232

			if var_83_7 <= arg_80_1.time_ and arg_80_1.time_ < var_83_7 + var_83_8 and not isNil(var_83_6) then
				local var_83_9 = (arg_80_1.time_ - var_83_7) / var_83_8

				if arg_80_1.var_.characterEffect4040ui_story and not isNil(var_83_6) then
					arg_80_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_7 + var_83_8 and arg_80_1.time_ < var_83_7 + var_83_8 + arg_83_0 and not isNil(var_83_6) and arg_80_1.var_.characterEffect4040ui_story then
				arg_80_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_83_10 = 0
			local var_83_11 = 0.625

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_12 = arg_80_1:FormatText(StoryNameCfg[668].name)

				arg_80_1.leftNameTxt_.text = var_83_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_13 = arg_80_1:GetWordFromCfg(319181019)
				local var_83_14 = arg_80_1:FormatText(var_83_13.content)

				arg_80_1.text_.text = var_83_14

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_15 = 25
				local var_83_16 = utf8.len(var_83_14)
				local var_83_17 = var_83_15 <= 0 and var_83_11 or var_83_11 * (var_83_16 / var_83_15)

				if var_83_17 > 0 and var_83_11 < var_83_17 then
					arg_80_1.talkMaxDuration = var_83_17

					if var_83_17 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_17 + var_83_10
					end
				end

				arg_80_1.text_.text = var_83_14
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181019", "story_v_out_319181.awb") ~= 0 then
					local var_83_18 = manager.audio:GetVoiceLength("story_v_out_319181", "319181019", "story_v_out_319181.awb") / 1000

					if var_83_18 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_18 + var_83_10
					end

					if var_83_13.prefab_name ~= "" and arg_80_1.actors_[var_83_13.prefab_name] ~= nil then
						local var_83_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_13.prefab_name].transform, "story_v_out_319181", "319181019", "story_v_out_319181.awb")

						arg_80_1:RecordAudio("319181019", var_83_19)
						arg_80_1:RecordAudio("319181019", var_83_19)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_319181", "319181019", "story_v_out_319181.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_319181", "319181019", "story_v_out_319181.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_20 = math.max(var_83_11, arg_80_1.talkMaxDuration)

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_20 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_10) / var_83_20

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_10 + var_83_20 and arg_80_1.time_ < var_83_10 + var_83_20 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play319181020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 319181020
		arg_84_1.duration_ = 3.9

		local var_84_0 = {
			zh = 1.999999999999,
			ja = 3.9
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play319181021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["4040ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect4040ui_story == nil then
				arg_84_1.var_.characterEffect4040ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect4040ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_84_1.var_.characterEffect4040ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect4040ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_84_1.var_.characterEffect4040ui_story.fillRatio = var_87_5
			end

			local var_87_6 = arg_84_1.actors_["1084ui_story"]
			local var_87_7 = 0

			if var_87_7 < arg_84_1.time_ and arg_84_1.time_ <= var_87_7 + arg_87_0 and not isNil(var_87_6) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = var_87_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_8 = 0.200000002980232

			if var_87_7 <= arg_84_1.time_ and arg_84_1.time_ < var_87_7 + var_87_8 and not isNil(var_87_6) then
				local var_87_9 = (arg_84_1.time_ - var_87_7) / var_87_8

				if arg_84_1.var_.characterEffect1084ui_story and not isNil(var_87_6) then
					arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_7 + var_87_8 and arg_84_1.time_ < var_87_7 + var_87_8 + arg_87_0 and not isNil(var_87_6) and arg_84_1.var_.characterEffect1084ui_story then
				arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_87_11 = 0
			local var_87_12 = 0.175

			if var_87_11 < arg_84_1.time_ and arg_84_1.time_ <= var_87_11 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_13 = arg_84_1:FormatText(StoryNameCfg[6].name)

				arg_84_1.leftNameTxt_.text = var_87_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_14 = arg_84_1:GetWordFromCfg(319181020)
				local var_87_15 = arg_84_1:FormatText(var_87_14.content)

				arg_84_1.text_.text = var_87_15

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_16 = 7
				local var_87_17 = utf8.len(var_87_15)
				local var_87_18 = var_87_16 <= 0 and var_87_12 or var_87_12 * (var_87_17 / var_87_16)

				if var_87_18 > 0 and var_87_12 < var_87_18 then
					arg_84_1.talkMaxDuration = var_87_18

					if var_87_18 + var_87_11 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_18 + var_87_11
					end
				end

				arg_84_1.text_.text = var_87_15
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181020", "story_v_out_319181.awb") ~= 0 then
					local var_87_19 = manager.audio:GetVoiceLength("story_v_out_319181", "319181020", "story_v_out_319181.awb") / 1000

					if var_87_19 + var_87_11 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_19 + var_87_11
					end

					if var_87_14.prefab_name ~= "" and arg_84_1.actors_[var_87_14.prefab_name] ~= nil then
						local var_87_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_14.prefab_name].transform, "story_v_out_319181", "319181020", "story_v_out_319181.awb")

						arg_84_1:RecordAudio("319181020", var_87_20)
						arg_84_1:RecordAudio("319181020", var_87_20)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_319181", "319181020", "story_v_out_319181.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_319181", "319181020", "story_v_out_319181.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_21 = math.max(var_87_12, arg_84_1.talkMaxDuration)

			if var_87_11 <= arg_84_1.time_ and arg_84_1.time_ < var_87_11 + var_87_21 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_11) / var_87_21

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_11 + var_87_21 and arg_84_1.time_ < var_87_11 + var_87_21 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play319181021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 319181021
		arg_88_1.duration_ = 6.97

		local var_88_0 = {
			zh = 3.5,
			ja = 6.966
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play319181022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["4040ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect4040ui_story == nil then
				arg_88_1.var_.characterEffect4040ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect4040ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect4040ui_story then
				arg_88_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_91_4 = arg_88_1.actors_["1084ui_story"]
			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.200000002980232

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 and not isNil(var_91_4) then
				local var_91_7 = (arg_88_1.time_ - var_91_5) / var_91_6

				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_4) then
					local var_91_8 = Mathf.Lerp(0, 0.5, var_91_7)

					arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1084ui_story.fillRatio = var_91_8
				end
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1084ui_story then
				local var_91_9 = 0.5

				arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1084ui_story.fillRatio = var_91_9
			end

			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_91_11 = 0

			if var_91_11 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_91_12 = 0
			local var_91_13 = 0.4

			if var_91_12 < arg_88_1.time_ and arg_88_1.time_ <= var_91_12 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_14 = arg_88_1:FormatText(StoryNameCfg[668].name)

				arg_88_1.leftNameTxt_.text = var_91_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_15 = arg_88_1:GetWordFromCfg(319181021)
				local var_91_16 = arg_88_1:FormatText(var_91_15.content)

				arg_88_1.text_.text = var_91_16

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_17 = 16
				local var_91_18 = utf8.len(var_91_16)
				local var_91_19 = var_91_17 <= 0 and var_91_13 or var_91_13 * (var_91_18 / var_91_17)

				if var_91_19 > 0 and var_91_13 < var_91_19 then
					arg_88_1.talkMaxDuration = var_91_19

					if var_91_19 + var_91_12 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_19 + var_91_12
					end
				end

				arg_88_1.text_.text = var_91_16
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181021", "story_v_out_319181.awb") ~= 0 then
					local var_91_20 = manager.audio:GetVoiceLength("story_v_out_319181", "319181021", "story_v_out_319181.awb") / 1000

					if var_91_20 + var_91_12 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_20 + var_91_12
					end

					if var_91_15.prefab_name ~= "" and arg_88_1.actors_[var_91_15.prefab_name] ~= nil then
						local var_91_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_15.prefab_name].transform, "story_v_out_319181", "319181021", "story_v_out_319181.awb")

						arg_88_1:RecordAudio("319181021", var_91_21)
						arg_88_1:RecordAudio("319181021", var_91_21)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_319181", "319181021", "story_v_out_319181.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_319181", "319181021", "story_v_out_319181.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_22 = math.max(var_91_13, arg_88_1.talkMaxDuration)

			if var_91_12 <= arg_88_1.time_ and arg_88_1.time_ < var_91_12 + var_91_22 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_12) / var_91_22

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_12 + var_91_22 and arg_88_1.time_ < var_91_12 + var_91_22 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play319181022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 319181022
		arg_92_1.duration_ = 8.37

		local var_92_0 = {
			zh = 2.8,
			ja = 8.366
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play319181023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1084ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1084ui_story = var_95_0.localPosition
			end

			local var_95_2 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2
				local var_95_4 = Vector3.New(0.7, -0.97, -6)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1084ui_story, var_95_4, var_95_3)

				local var_95_5 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_5.x, var_95_5.y, var_95_5.z)

				local var_95_6 = var_95_0.localEulerAngles

				var_95_6.z = 0
				var_95_6.x = 0
				var_95_0.localEulerAngles = var_95_6
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_95_7 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_7.x, var_95_7.y, var_95_7.z)

				local var_95_8 = var_95_0.localEulerAngles

				var_95_8.z = 0
				var_95_8.x = 0
				var_95_0.localEulerAngles = var_95_8
			end

			local var_95_9 = arg_92_1.actors_["1084ui_story"]
			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = var_95_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_11 = 0.200000002980232

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_11 and not isNil(var_95_9) then
				local var_95_12 = (arg_92_1.time_ - var_95_10) / var_95_11

				if arg_92_1.var_.characterEffect1084ui_story and not isNil(var_95_9) then
					arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_10 + var_95_11 and arg_92_1.time_ < var_95_10 + var_95_11 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect1084ui_story then
				arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_95_13 = 0

			if var_95_13 < arg_92_1.time_ and arg_92_1.time_ <= var_95_13 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_95_14 = 0

			if var_95_14 < arg_92_1.time_ and arg_92_1.time_ <= var_95_14 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_95_15 = arg_92_1.actors_["4040ui_story"]
			local var_95_16 = 0

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 and not isNil(var_95_15) and arg_92_1.var_.characterEffect4040ui_story == nil then
				arg_92_1.var_.characterEffect4040ui_story = var_95_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_17 = 0.200000002980232

			if var_95_16 <= arg_92_1.time_ and arg_92_1.time_ < var_95_16 + var_95_17 and not isNil(var_95_15) then
				local var_95_18 = (arg_92_1.time_ - var_95_16) / var_95_17

				if arg_92_1.var_.characterEffect4040ui_story and not isNil(var_95_15) then
					local var_95_19 = Mathf.Lerp(0, 0.5, var_95_18)

					arg_92_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_92_1.var_.characterEffect4040ui_story.fillRatio = var_95_19
				end
			end

			if arg_92_1.time_ >= var_95_16 + var_95_17 and arg_92_1.time_ < var_95_16 + var_95_17 + arg_95_0 and not isNil(var_95_15) and arg_92_1.var_.characterEffect4040ui_story then
				local var_95_20 = 0.5

				arg_92_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_92_1.var_.characterEffect4040ui_story.fillRatio = var_95_20
			end

			local var_95_21 = 0
			local var_95_22 = 0.3

			if var_95_21 < arg_92_1.time_ and arg_92_1.time_ <= var_95_21 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_23 = arg_92_1:FormatText(StoryNameCfg[6].name)

				arg_92_1.leftNameTxt_.text = var_95_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_24 = arg_92_1:GetWordFromCfg(319181022)
				local var_95_25 = arg_92_1:FormatText(var_95_24.content)

				arg_92_1.text_.text = var_95_25

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_26 = 12
				local var_95_27 = utf8.len(var_95_25)
				local var_95_28 = var_95_26 <= 0 and var_95_22 or var_95_22 * (var_95_27 / var_95_26)

				if var_95_28 > 0 and var_95_22 < var_95_28 then
					arg_92_1.talkMaxDuration = var_95_28

					if var_95_28 + var_95_21 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_28 + var_95_21
					end
				end

				arg_92_1.text_.text = var_95_25
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181022", "story_v_out_319181.awb") ~= 0 then
					local var_95_29 = manager.audio:GetVoiceLength("story_v_out_319181", "319181022", "story_v_out_319181.awb") / 1000

					if var_95_29 + var_95_21 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_29 + var_95_21
					end

					if var_95_24.prefab_name ~= "" and arg_92_1.actors_[var_95_24.prefab_name] ~= nil then
						local var_95_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_24.prefab_name].transform, "story_v_out_319181", "319181022", "story_v_out_319181.awb")

						arg_92_1:RecordAudio("319181022", var_95_30)
						arg_92_1:RecordAudio("319181022", var_95_30)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_319181", "319181022", "story_v_out_319181.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_319181", "319181022", "story_v_out_319181.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_31 = math.max(var_95_22, arg_92_1.talkMaxDuration)

			if var_95_21 <= arg_92_1.time_ and arg_92_1.time_ < var_95_21 + var_95_31 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_21) / var_95_31

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_21 + var_95_31 and arg_92_1.time_ < var_95_21 + var_95_31 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play319181023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 319181023
		arg_96_1.duration_ = 4.8

		local var_96_0 = {
			zh = 2.6,
			ja = 4.8
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play319181024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["4040ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect4040ui_story == nil then
				arg_96_1.var_.characterEffect4040ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect4040ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect4040ui_story then
				arg_96_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_99_4 = 0

			if var_99_4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_99_6 = arg_96_1.actors_["1084ui_story"]
			local var_99_7 = 0

			if var_99_7 < arg_96_1.time_ and arg_96_1.time_ <= var_99_7 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = var_99_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_8 = 0.200000002980232

			if var_99_7 <= arg_96_1.time_ and arg_96_1.time_ < var_99_7 + var_99_8 and not isNil(var_99_6) then
				local var_99_9 = (arg_96_1.time_ - var_99_7) / var_99_8

				if arg_96_1.var_.characterEffect1084ui_story and not isNil(var_99_6) then
					local var_99_10 = Mathf.Lerp(0, 0.5, var_99_9)

					arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1084ui_story.fillRatio = var_99_10
				end
			end

			if arg_96_1.time_ >= var_99_7 + var_99_8 and arg_96_1.time_ < var_99_7 + var_99_8 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1084ui_story then
				local var_99_11 = 0.5

				arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1084ui_story.fillRatio = var_99_11
			end

			local var_99_12 = 0
			local var_99_13 = 0.3

			if var_99_12 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_14 = arg_96_1:FormatText(StoryNameCfg[668].name)

				arg_96_1.leftNameTxt_.text = var_99_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_15 = arg_96_1:GetWordFromCfg(319181023)
				local var_99_16 = arg_96_1:FormatText(var_99_15.content)

				arg_96_1.text_.text = var_99_16

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_17 = 12
				local var_99_18 = utf8.len(var_99_16)
				local var_99_19 = var_99_17 <= 0 and var_99_13 or var_99_13 * (var_99_18 / var_99_17)

				if var_99_19 > 0 and var_99_13 < var_99_19 then
					arg_96_1.talkMaxDuration = var_99_19

					if var_99_19 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_19 + var_99_12
					end
				end

				arg_96_1.text_.text = var_99_16
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181023", "story_v_out_319181.awb") ~= 0 then
					local var_99_20 = manager.audio:GetVoiceLength("story_v_out_319181", "319181023", "story_v_out_319181.awb") / 1000

					if var_99_20 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_20 + var_99_12
					end

					if var_99_15.prefab_name ~= "" and arg_96_1.actors_[var_99_15.prefab_name] ~= nil then
						local var_99_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_15.prefab_name].transform, "story_v_out_319181", "319181023", "story_v_out_319181.awb")

						arg_96_1:RecordAudio("319181023", var_99_21)
						arg_96_1:RecordAudio("319181023", var_99_21)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_319181", "319181023", "story_v_out_319181.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_319181", "319181023", "story_v_out_319181.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_22 = math.max(var_99_13, arg_96_1.talkMaxDuration)

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_22 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_12) / var_99_22

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_12 + var_99_22 and arg_96_1.time_ < var_99_12 + var_99_22 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play319181024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 319181024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play319181025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["4040ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect4040ui_story == nil then
				arg_100_1.var_.characterEffect4040ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect4040ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_100_1.var_.characterEffect4040ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect4040ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_100_1.var_.characterEffect4040ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 1

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_8 = arg_100_1:GetWordFromCfg(319181024)
				local var_103_9 = arg_100_1:FormatText(var_103_8.content)

				arg_100_1.text_.text = var_103_9

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_10 = 40
				local var_103_11 = utf8.len(var_103_9)
				local var_103_12 = var_103_10 <= 0 and var_103_7 or var_103_7 * (var_103_11 / var_103_10)

				if var_103_12 > 0 and var_103_7 < var_103_12 then
					arg_100_1.talkMaxDuration = var_103_12

					if var_103_12 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_12 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_9
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_13 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_13 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_13

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_13 and arg_100_1.time_ < var_103_6 + var_103_13 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play319181025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 319181025
		arg_104_1.duration_ = 3.57

		local var_104_0 = {
			zh = 2.8,
			ja = 3.566
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play319181026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["4040ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect4040ui_story == nil then
				arg_104_1.var_.characterEffect4040ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect4040ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect4040ui_story then
				arg_104_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_107_4 = 0
			local var_107_5 = 0.25

			if var_107_4 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_6 = arg_104_1:FormatText(StoryNameCfg[668].name)

				arg_104_1.leftNameTxt_.text = var_107_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_7 = arg_104_1:GetWordFromCfg(319181025)
				local var_107_8 = arg_104_1:FormatText(var_107_7.content)

				arg_104_1.text_.text = var_107_8

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 10
				local var_107_10 = utf8.len(var_107_8)
				local var_107_11 = var_107_9 <= 0 and var_107_5 or var_107_5 * (var_107_10 / var_107_9)

				if var_107_11 > 0 and var_107_5 < var_107_11 then
					arg_104_1.talkMaxDuration = var_107_11

					if var_107_11 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_11 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_8
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181025", "story_v_out_319181.awb") ~= 0 then
					local var_107_12 = manager.audio:GetVoiceLength("story_v_out_319181", "319181025", "story_v_out_319181.awb") / 1000

					if var_107_12 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_4
					end

					if var_107_7.prefab_name ~= "" and arg_104_1.actors_[var_107_7.prefab_name] ~= nil then
						local var_107_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_7.prefab_name].transform, "story_v_out_319181", "319181025", "story_v_out_319181.awb")

						arg_104_1:RecordAudio("319181025", var_107_13)
						arg_104_1:RecordAudio("319181025", var_107_13)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_319181", "319181025", "story_v_out_319181.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_319181", "319181025", "story_v_out_319181.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_5, arg_104_1.talkMaxDuration)

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_4) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_4 + var_107_14 and arg_104_1.time_ < var_107_4 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play319181026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 319181026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play319181027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1084ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1084ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(0, 100, 0)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1084ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0, 100, 0)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = arg_108_1.actors_["1084ui_story"]
			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1084ui_story == nil then
				arg_108_1.var_.characterEffect1084ui_story = var_111_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_11 = 0.200000002980232

			if var_111_10 <= arg_108_1.time_ and arg_108_1.time_ < var_111_10 + var_111_11 and not isNil(var_111_9) then
				local var_111_12 = (arg_108_1.time_ - var_111_10) / var_111_11

				if arg_108_1.var_.characterEffect1084ui_story and not isNil(var_111_9) then
					local var_111_13 = Mathf.Lerp(0, 0.5, var_111_12)

					arg_108_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1084ui_story.fillRatio = var_111_13
				end
			end

			if arg_108_1.time_ >= var_111_10 + var_111_11 and arg_108_1.time_ < var_111_10 + var_111_11 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1084ui_story then
				local var_111_14 = 0.5

				arg_108_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1084ui_story.fillRatio = var_111_14
			end

			local var_111_15 = arg_108_1.actors_["4040ui_story"].transform
			local var_111_16 = 0

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.var_.moveOldPos4040ui_story = var_111_15.localPosition
			end

			local var_111_17 = 0.001

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_17 then
				local var_111_18 = (arg_108_1.time_ - var_111_16) / var_111_17
				local var_111_19 = Vector3.New(0, 100, 0)

				var_111_15.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos4040ui_story, var_111_19, var_111_18)

				local var_111_20 = manager.ui.mainCamera.transform.position - var_111_15.position

				var_111_15.forward = Vector3.New(var_111_20.x, var_111_20.y, var_111_20.z)

				local var_111_21 = var_111_15.localEulerAngles

				var_111_21.z = 0
				var_111_21.x = 0
				var_111_15.localEulerAngles = var_111_21
			end

			if arg_108_1.time_ >= var_111_16 + var_111_17 and arg_108_1.time_ < var_111_16 + var_111_17 + arg_111_0 then
				var_111_15.localPosition = Vector3.New(0, 100, 0)

				local var_111_22 = manager.ui.mainCamera.transform.position - var_111_15.position

				var_111_15.forward = Vector3.New(var_111_22.x, var_111_22.y, var_111_22.z)

				local var_111_23 = var_111_15.localEulerAngles

				var_111_23.z = 0
				var_111_23.x = 0
				var_111_15.localEulerAngles = var_111_23
			end

			local var_111_24 = arg_108_1.actors_["4040ui_story"]
			local var_111_25 = 0

			if var_111_25 < arg_108_1.time_ and arg_108_1.time_ <= var_111_25 + arg_111_0 and not isNil(var_111_24) and arg_108_1.var_.characterEffect4040ui_story == nil then
				arg_108_1.var_.characterEffect4040ui_story = var_111_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_26 = 0.200000002980232

			if var_111_25 <= arg_108_1.time_ and arg_108_1.time_ < var_111_25 + var_111_26 and not isNil(var_111_24) then
				local var_111_27 = (arg_108_1.time_ - var_111_25) / var_111_26

				if arg_108_1.var_.characterEffect4040ui_story and not isNil(var_111_24) then
					local var_111_28 = Mathf.Lerp(0, 0.5, var_111_27)

					arg_108_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_108_1.var_.characterEffect4040ui_story.fillRatio = var_111_28
				end
			end

			if arg_108_1.time_ >= var_111_25 + var_111_26 and arg_108_1.time_ < var_111_25 + var_111_26 + arg_111_0 and not isNil(var_111_24) and arg_108_1.var_.characterEffect4040ui_story then
				local var_111_29 = 0.5

				arg_108_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_108_1.var_.characterEffect4040ui_story.fillRatio = var_111_29
			end

			local var_111_30 = 0
			local var_111_31 = 0.95

			if var_111_30 < arg_108_1.time_ and arg_108_1.time_ <= var_111_30 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_32 = arg_108_1:GetWordFromCfg(319181026)
				local var_111_33 = arg_108_1:FormatText(var_111_32.content)

				arg_108_1.text_.text = var_111_33

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_34 = 38
				local var_111_35 = utf8.len(var_111_33)
				local var_111_36 = var_111_34 <= 0 and var_111_31 or var_111_31 * (var_111_35 / var_111_34)

				if var_111_36 > 0 and var_111_31 < var_111_36 then
					arg_108_1.talkMaxDuration = var_111_36

					if var_111_36 + var_111_30 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_36 + var_111_30
					end
				end

				arg_108_1.text_.text = var_111_33
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_37 = math.max(var_111_31, arg_108_1.talkMaxDuration)

			if var_111_30 <= arg_108_1.time_ and arg_108_1.time_ < var_111_30 + var_111_37 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_30) / var_111_37

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_30 + var_111_37 and arg_108_1.time_ < var_111_30 + var_111_37 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play319181027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319181027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play319181028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 1.55

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_2 = arg_112_1:GetWordFromCfg(319181027)
				local var_115_3 = arg_112_1:FormatText(var_115_2.content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 62
				local var_115_5 = utf8.len(var_115_3)
				local var_115_6 = var_115_4 <= 0 and var_115_1 or var_115_1 * (var_115_5 / var_115_4)

				if var_115_6 > 0 and var_115_1 < var_115_6 then
					arg_112_1.talkMaxDuration = var_115_6

					if var_115_6 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_7 and arg_112_1.time_ < var_115_0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play319181028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 319181028
		arg_116_1.duration_ = 2.93

		local var_116_0 = {
			zh = 2.933,
			ja = 1.999999999999
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play319181029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["4040ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos4040ui_story = var_119_0.localPosition
			end

			local var_119_2 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2
				local var_119_4 = Vector3.New(0, -1.55, -5.5)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos4040ui_story, var_119_4, var_119_3)

				local var_119_5 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_5.x, var_119_5.y, var_119_5.z)

				local var_119_6 = var_119_0.localEulerAngles

				var_119_6.z = 0
				var_119_6.x = 0
				var_119_0.localEulerAngles = var_119_6
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_119_7 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_7.x, var_119_7.y, var_119_7.z)

				local var_119_8 = var_119_0.localEulerAngles

				var_119_8.z = 0
				var_119_8.x = 0
				var_119_0.localEulerAngles = var_119_8
			end

			local var_119_9 = arg_116_1.actors_["4040ui_story"]
			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect4040ui_story == nil then
				arg_116_1.var_.characterEffect4040ui_story = var_119_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_11 = 0.200000002980232

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_11 and not isNil(var_119_9) then
				local var_119_12 = (arg_116_1.time_ - var_119_10) / var_119_11

				if arg_116_1.var_.characterEffect4040ui_story and not isNil(var_119_9) then
					arg_116_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_10 + var_119_11 and arg_116_1.time_ < var_119_10 + var_119_11 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect4040ui_story then
				arg_116_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_119_13 = 0

			if var_119_13 < arg_116_1.time_ and arg_116_1.time_ <= var_119_13 + arg_119_0 then
				arg_116_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_119_14 = 0

			if var_119_14 < arg_116_1.time_ and arg_116_1.time_ <= var_119_14 + arg_119_0 then
				arg_116_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_119_15 = 0
			local var_119_16 = 0.225

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_17 = arg_116_1:FormatText(StoryNameCfg[668].name)

				arg_116_1.leftNameTxt_.text = var_119_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_18 = arg_116_1:GetWordFromCfg(319181028)
				local var_119_19 = arg_116_1:FormatText(var_119_18.content)

				arg_116_1.text_.text = var_119_19

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_20 = 9
				local var_119_21 = utf8.len(var_119_19)
				local var_119_22 = var_119_20 <= 0 and var_119_16 or var_119_16 * (var_119_21 / var_119_20)

				if var_119_22 > 0 and var_119_16 < var_119_22 then
					arg_116_1.talkMaxDuration = var_119_22

					if var_119_22 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_22 + var_119_15
					end
				end

				arg_116_1.text_.text = var_119_19
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181028", "story_v_out_319181.awb") ~= 0 then
					local var_119_23 = manager.audio:GetVoiceLength("story_v_out_319181", "319181028", "story_v_out_319181.awb") / 1000

					if var_119_23 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_23 + var_119_15
					end

					if var_119_18.prefab_name ~= "" and arg_116_1.actors_[var_119_18.prefab_name] ~= nil then
						local var_119_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_18.prefab_name].transform, "story_v_out_319181", "319181028", "story_v_out_319181.awb")

						arg_116_1:RecordAudio("319181028", var_119_24)
						arg_116_1:RecordAudio("319181028", var_119_24)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_319181", "319181028", "story_v_out_319181.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_319181", "319181028", "story_v_out_319181.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_25 = math.max(var_119_16, arg_116_1.talkMaxDuration)

			if var_119_15 <= arg_116_1.time_ and arg_116_1.time_ < var_119_15 + var_119_25 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_15) / var_119_25

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_15 + var_119_25 and arg_116_1.time_ < var_119_15 + var_119_25 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play319181029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319181029
		arg_120_1.duration_ = 4.8

		local var_120_0 = {
			zh = 3.1,
			ja = 4.8
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
				arg_120_0:Play319181030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["10066ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos10066ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(0.7, -0.99, -5.83)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos10066ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = arg_120_1.actors_["10066ui_story"]
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect10066ui_story == nil then
				arg_120_1.var_.characterEffect10066ui_story = var_123_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_11 = 0.200000002980232

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 and not isNil(var_123_9) then
				local var_123_12 = (arg_120_1.time_ - var_123_10) / var_123_11

				if arg_120_1.var_.characterEffect10066ui_story and not isNil(var_123_9) then
					arg_120_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect10066ui_story then
				arg_120_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_123_13 = 0

			if var_123_13 < arg_120_1.time_ and arg_120_1.time_ <= var_123_13 + arg_123_0 then
				arg_120_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			local var_123_14 = 0

			if var_123_14 < arg_120_1.time_ and arg_120_1.time_ <= var_123_14 + arg_123_0 then
				arg_120_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_123_15 = arg_120_1.actors_["4040ui_story"].transform
			local var_123_16 = 0

			if var_123_16 < arg_120_1.time_ and arg_120_1.time_ <= var_123_16 + arg_123_0 then
				arg_120_1.var_.moveOldPos4040ui_story = var_123_15.localPosition
			end

			local var_123_17 = 0.001

			if var_123_16 <= arg_120_1.time_ and arg_120_1.time_ < var_123_16 + var_123_17 then
				local var_123_18 = (arg_120_1.time_ - var_123_16) / var_123_17
				local var_123_19 = Vector3.New(-0.7, -1.55, -5.5)

				var_123_15.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos4040ui_story, var_123_19, var_123_18)

				local var_123_20 = manager.ui.mainCamera.transform.position - var_123_15.position

				var_123_15.forward = Vector3.New(var_123_20.x, var_123_20.y, var_123_20.z)

				local var_123_21 = var_123_15.localEulerAngles

				var_123_21.z = 0
				var_123_21.x = 0
				var_123_15.localEulerAngles = var_123_21
			end

			if arg_120_1.time_ >= var_123_16 + var_123_17 and arg_120_1.time_ < var_123_16 + var_123_17 + arg_123_0 then
				var_123_15.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_123_22 = manager.ui.mainCamera.transform.position - var_123_15.position

				var_123_15.forward = Vector3.New(var_123_22.x, var_123_22.y, var_123_22.z)

				local var_123_23 = var_123_15.localEulerAngles

				var_123_23.z = 0
				var_123_23.x = 0
				var_123_15.localEulerAngles = var_123_23
			end

			local var_123_24 = arg_120_1.actors_["4040ui_story"]
			local var_123_25 = 0

			if var_123_25 < arg_120_1.time_ and arg_120_1.time_ <= var_123_25 + arg_123_0 and not isNil(var_123_24) and arg_120_1.var_.characterEffect4040ui_story == nil then
				arg_120_1.var_.characterEffect4040ui_story = var_123_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_26 = 0.200000002980232

			if var_123_25 <= arg_120_1.time_ and arg_120_1.time_ < var_123_25 + var_123_26 and not isNil(var_123_24) then
				local var_123_27 = (arg_120_1.time_ - var_123_25) / var_123_26

				if arg_120_1.var_.characterEffect4040ui_story and not isNil(var_123_24) then
					local var_123_28 = Mathf.Lerp(0, 0.5, var_123_27)

					arg_120_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_120_1.var_.characterEffect4040ui_story.fillRatio = var_123_28
				end
			end

			if arg_120_1.time_ >= var_123_25 + var_123_26 and arg_120_1.time_ < var_123_25 + var_123_26 + arg_123_0 and not isNil(var_123_24) and arg_120_1.var_.characterEffect4040ui_story then
				local var_123_29 = 0.5

				arg_120_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_120_1.var_.characterEffect4040ui_story.fillRatio = var_123_29
			end

			local var_123_30 = 0
			local var_123_31 = 0.2

			if var_123_30 < arg_120_1.time_ and arg_120_1.time_ <= var_123_30 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_32 = arg_120_1:FormatText(StoryNameCfg[640].name)

				arg_120_1.leftNameTxt_.text = var_123_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_33 = arg_120_1:GetWordFromCfg(319181029)
				local var_123_34 = arg_120_1:FormatText(var_123_33.content)

				arg_120_1.text_.text = var_123_34

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_35 = 8
				local var_123_36 = utf8.len(var_123_34)
				local var_123_37 = var_123_35 <= 0 and var_123_31 or var_123_31 * (var_123_36 / var_123_35)

				if var_123_37 > 0 and var_123_31 < var_123_37 then
					arg_120_1.talkMaxDuration = var_123_37

					if var_123_37 + var_123_30 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_37 + var_123_30
					end
				end

				arg_120_1.text_.text = var_123_34
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181029", "story_v_out_319181.awb") ~= 0 then
					local var_123_38 = manager.audio:GetVoiceLength("story_v_out_319181", "319181029", "story_v_out_319181.awb") / 1000

					if var_123_38 + var_123_30 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_38 + var_123_30
					end

					if var_123_33.prefab_name ~= "" and arg_120_1.actors_[var_123_33.prefab_name] ~= nil then
						local var_123_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_33.prefab_name].transform, "story_v_out_319181", "319181029", "story_v_out_319181.awb")

						arg_120_1:RecordAudio("319181029", var_123_39)
						arg_120_1:RecordAudio("319181029", var_123_39)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_319181", "319181029", "story_v_out_319181.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_319181", "319181029", "story_v_out_319181.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_40 = math.max(var_123_31, arg_120_1.talkMaxDuration)

			if var_123_30 <= arg_120_1.time_ and arg_120_1.time_ < var_123_30 + var_123_40 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_30) / var_123_40

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_30 + var_123_40 and arg_120_1.time_ < var_123_30 + var_123_40 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319181030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 319181030
		arg_124_1.duration_ = 7.37

		local var_124_0 = {
			zh = 4.6,
			ja = 7.366
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
				arg_124_0:Play319181031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10066ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10066ui_story == nil then
				arg_124_1.var_.characterEffect10066ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect10066ui_story and not isNil(var_127_0) then
					local var_127_4 = Mathf.Lerp(0, 0.5, var_127_3)

					arg_124_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10066ui_story.fillRatio = var_127_4
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10066ui_story then
				local var_127_5 = 0.5

				arg_124_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10066ui_story.fillRatio = var_127_5
			end

			local var_127_6 = arg_124_1.actors_["4040ui_story"]
			local var_127_7 = 0

			if var_127_7 < arg_124_1.time_ and arg_124_1.time_ <= var_127_7 + arg_127_0 and not isNil(var_127_6) and arg_124_1.var_.characterEffect4040ui_story == nil then
				arg_124_1.var_.characterEffect4040ui_story = var_127_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_8 = 0.200000002980232

			if var_127_7 <= arg_124_1.time_ and arg_124_1.time_ < var_127_7 + var_127_8 and not isNil(var_127_6) then
				local var_127_9 = (arg_124_1.time_ - var_127_7) / var_127_8

				if arg_124_1.var_.characterEffect4040ui_story and not isNil(var_127_6) then
					arg_124_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_7 + var_127_8 and arg_124_1.time_ < var_127_7 + var_127_8 + arg_127_0 and not isNil(var_127_6) and arg_124_1.var_.characterEffect4040ui_story then
				arg_124_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_127_10 = 0
			local var_127_11 = 0.275

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_12 = arg_124_1:FormatText(StoryNameCfg[668].name)

				arg_124_1.leftNameTxt_.text = var_127_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_13 = arg_124_1:GetWordFromCfg(319181030)
				local var_127_14 = arg_124_1:FormatText(var_127_13.content)

				arg_124_1.text_.text = var_127_14

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_15 = 11
				local var_127_16 = utf8.len(var_127_14)
				local var_127_17 = var_127_15 <= 0 and var_127_11 or var_127_11 * (var_127_16 / var_127_15)

				if var_127_17 > 0 and var_127_11 < var_127_17 then
					arg_124_1.talkMaxDuration = var_127_17

					if var_127_17 + var_127_10 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_17 + var_127_10
					end
				end

				arg_124_1.text_.text = var_127_14
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181030", "story_v_out_319181.awb") ~= 0 then
					local var_127_18 = manager.audio:GetVoiceLength("story_v_out_319181", "319181030", "story_v_out_319181.awb") / 1000

					if var_127_18 + var_127_10 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_18 + var_127_10
					end

					if var_127_13.prefab_name ~= "" and arg_124_1.actors_[var_127_13.prefab_name] ~= nil then
						local var_127_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_13.prefab_name].transform, "story_v_out_319181", "319181030", "story_v_out_319181.awb")

						arg_124_1:RecordAudio("319181030", var_127_19)
						arg_124_1:RecordAudio("319181030", var_127_19)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_319181", "319181030", "story_v_out_319181.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_319181", "319181030", "story_v_out_319181.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_20 = math.max(var_127_11, arg_124_1.talkMaxDuration)

			if var_127_10 <= arg_124_1.time_ and arg_124_1.time_ < var_127_10 + var_127_20 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_10) / var_127_20

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_10 + var_127_20 and arg_124_1.time_ < var_127_10 + var_127_20 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play319181031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 319181031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play319181032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["4040ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect4040ui_story == nil then
				arg_128_1.var_.characterEffect4040ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect4040ui_story and not isNil(var_131_0) then
					local var_131_4 = Mathf.Lerp(0, 0.5, var_131_3)

					arg_128_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_128_1.var_.characterEffect4040ui_story.fillRatio = var_131_4
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect4040ui_story then
				local var_131_5 = 0.5

				arg_128_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_128_1.var_.characterEffect4040ui_story.fillRatio = var_131_5
			end

			local var_131_6 = 0

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action443")
			end

			local var_131_7 = 0

			if var_131_7 < arg_128_1.time_ and arg_128_1.time_ <= var_131_7 + arg_131_0 then
				arg_128_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_131_8 = 0
			local var_131_9 = 1.175

			if var_131_8 < arg_128_1.time_ and arg_128_1.time_ <= var_131_8 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_10 = arg_128_1:GetWordFromCfg(319181031)
				local var_131_11 = arg_128_1:FormatText(var_131_10.content)

				arg_128_1.text_.text = var_131_11

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_12 = 47
				local var_131_13 = utf8.len(var_131_11)
				local var_131_14 = var_131_12 <= 0 and var_131_9 or var_131_9 * (var_131_13 / var_131_12)

				if var_131_14 > 0 and var_131_9 < var_131_14 then
					arg_128_1.talkMaxDuration = var_131_14

					if var_131_14 + var_131_8 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_14 + var_131_8
					end
				end

				arg_128_1.text_.text = var_131_11
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_15 = math.max(var_131_9, arg_128_1.talkMaxDuration)

			if var_131_8 <= arg_128_1.time_ and arg_128_1.time_ < var_131_8 + var_131_15 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_8) / var_131_15

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_8 + var_131_15 and arg_128_1.time_ < var_131_8 + var_131_15 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play319181032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 319181032
		arg_132_1.duration_ = 5.5

		local var_132_0 = {
			zh = 4.2,
			ja = 5.5
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
				arg_132_0:Play319181033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["4040ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos4040ui_story = var_135_0.localPosition
			end

			local var_135_2 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos4040ui_story, var_135_4, var_135_3)

				local var_135_5 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_5.x, var_135_5.y, var_135_5.z)

				local var_135_6 = var_135_0.localEulerAngles

				var_135_6.z = 0
				var_135_6.x = 0
				var_135_0.localEulerAngles = var_135_6
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_135_7 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_7.x, var_135_7.y, var_135_7.z)

				local var_135_8 = var_135_0.localEulerAngles

				var_135_8.z = 0
				var_135_8.x = 0
				var_135_0.localEulerAngles = var_135_8
			end

			local var_135_9 = arg_132_1.actors_["4040ui_story"]
			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect4040ui_story == nil then
				arg_132_1.var_.characterEffect4040ui_story = var_135_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_11 = 0.200000002980232

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_11 and not isNil(var_135_9) then
				local var_135_12 = (arg_132_1.time_ - var_135_10) / var_135_11

				if arg_132_1.var_.characterEffect4040ui_story and not isNil(var_135_9) then
					arg_132_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_10 + var_135_11 and arg_132_1.time_ < var_135_10 + var_135_11 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect4040ui_story then
				arg_132_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_135_13 = 0

			if var_135_13 < arg_132_1.time_ and arg_132_1.time_ <= var_135_13 + arg_135_0 then
				arg_132_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_135_14 = 0

			if var_135_14 < arg_132_1.time_ and arg_132_1.time_ <= var_135_14 + arg_135_0 then
				arg_132_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_135_15 = 0
			local var_135_16 = 0.225

			if var_135_15 < arg_132_1.time_ and arg_132_1.time_ <= var_135_15 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_17 = arg_132_1:FormatText(StoryNameCfg[668].name)

				arg_132_1.leftNameTxt_.text = var_135_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_18 = arg_132_1:GetWordFromCfg(319181032)
				local var_135_19 = arg_132_1:FormatText(var_135_18.content)

				arg_132_1.text_.text = var_135_19

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_20 = 9
				local var_135_21 = utf8.len(var_135_19)
				local var_135_22 = var_135_20 <= 0 and var_135_16 or var_135_16 * (var_135_21 / var_135_20)

				if var_135_22 > 0 and var_135_16 < var_135_22 then
					arg_132_1.talkMaxDuration = var_135_22

					if var_135_22 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_22 + var_135_15
					end
				end

				arg_132_1.text_.text = var_135_19
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181032", "story_v_out_319181.awb") ~= 0 then
					local var_135_23 = manager.audio:GetVoiceLength("story_v_out_319181", "319181032", "story_v_out_319181.awb") / 1000

					if var_135_23 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_23 + var_135_15
					end

					if var_135_18.prefab_name ~= "" and arg_132_1.actors_[var_135_18.prefab_name] ~= nil then
						local var_135_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_18.prefab_name].transform, "story_v_out_319181", "319181032", "story_v_out_319181.awb")

						arg_132_1:RecordAudio("319181032", var_135_24)
						arg_132_1:RecordAudio("319181032", var_135_24)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_319181", "319181032", "story_v_out_319181.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_319181", "319181032", "story_v_out_319181.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_25 = math.max(var_135_16, arg_132_1.talkMaxDuration)

			if var_135_15 <= arg_132_1.time_ and arg_132_1.time_ < var_135_15 + var_135_25 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_15) / var_135_25

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_15 + var_135_25 and arg_132_1.time_ < var_135_15 + var_135_25 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319181033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 319181033
		arg_136_1.duration_ = 4.53

		local var_136_0 = {
			zh = 2.5,
			ja = 4.533
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
				arg_136_0:Play319181034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10066ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos10066ui_story = var_139_0.localPosition
			end

			local var_139_2 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2
				local var_139_4 = Vector3.New(0.7, -0.99, -5.83)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10066ui_story, var_139_4, var_139_3)

				local var_139_5 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_5.x, var_139_5.y, var_139_5.z)

				local var_139_6 = var_139_0.localEulerAngles

				var_139_6.z = 0
				var_139_6.x = 0
				var_139_0.localEulerAngles = var_139_6
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_139_7 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_7.x, var_139_7.y, var_139_7.z)

				local var_139_8 = var_139_0.localEulerAngles

				var_139_8.z = 0
				var_139_8.x = 0
				var_139_0.localEulerAngles = var_139_8
			end

			local var_139_9 = arg_136_1.actors_["10066ui_story"]
			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect10066ui_story == nil then
				arg_136_1.var_.characterEffect10066ui_story = var_139_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_11 = 0.200000002980232

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_11 and not isNil(var_139_9) then
				local var_139_12 = (arg_136_1.time_ - var_139_10) / var_139_11

				if arg_136_1.var_.characterEffect10066ui_story and not isNil(var_139_9) then
					arg_136_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_10 + var_139_11 and arg_136_1.time_ < var_139_10 + var_139_11 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect10066ui_story then
				arg_136_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_139_13 = 0

			if var_139_13 < arg_136_1.time_ and arg_136_1.time_ <= var_139_13 + arg_139_0 then
				arg_136_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			local var_139_14 = 0

			if var_139_14 < arg_136_1.time_ and arg_136_1.time_ <= var_139_14 + arg_139_0 then
				arg_136_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_139_15 = arg_136_1.actors_["4040ui_story"]
			local var_139_16 = 0

			if var_139_16 < arg_136_1.time_ and arg_136_1.time_ <= var_139_16 + arg_139_0 and not isNil(var_139_15) and arg_136_1.var_.characterEffect4040ui_story == nil then
				arg_136_1.var_.characterEffect4040ui_story = var_139_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_17 = 0.200000002980232

			if var_139_16 <= arg_136_1.time_ and arg_136_1.time_ < var_139_16 + var_139_17 and not isNil(var_139_15) then
				local var_139_18 = (arg_136_1.time_ - var_139_16) / var_139_17

				if arg_136_1.var_.characterEffect4040ui_story and not isNil(var_139_15) then
					local var_139_19 = Mathf.Lerp(0, 0.5, var_139_18)

					arg_136_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_136_1.var_.characterEffect4040ui_story.fillRatio = var_139_19
				end
			end

			if arg_136_1.time_ >= var_139_16 + var_139_17 and arg_136_1.time_ < var_139_16 + var_139_17 + arg_139_0 and not isNil(var_139_15) and arg_136_1.var_.characterEffect4040ui_story then
				local var_139_20 = 0.5

				arg_136_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_136_1.var_.characterEffect4040ui_story.fillRatio = var_139_20
			end

			local var_139_21 = 0
			local var_139_22 = 0.25

			if var_139_21 < arg_136_1.time_ and arg_136_1.time_ <= var_139_21 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_23 = arg_136_1:FormatText(StoryNameCfg[640].name)

				arg_136_1.leftNameTxt_.text = var_139_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_24 = arg_136_1:GetWordFromCfg(319181033)
				local var_139_25 = arg_136_1:FormatText(var_139_24.content)

				arg_136_1.text_.text = var_139_25

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_26 = 10
				local var_139_27 = utf8.len(var_139_25)
				local var_139_28 = var_139_26 <= 0 and var_139_22 or var_139_22 * (var_139_27 / var_139_26)

				if var_139_28 > 0 and var_139_22 < var_139_28 then
					arg_136_1.talkMaxDuration = var_139_28

					if var_139_28 + var_139_21 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_28 + var_139_21
					end
				end

				arg_136_1.text_.text = var_139_25
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181033", "story_v_out_319181.awb") ~= 0 then
					local var_139_29 = manager.audio:GetVoiceLength("story_v_out_319181", "319181033", "story_v_out_319181.awb") / 1000

					if var_139_29 + var_139_21 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_29 + var_139_21
					end

					if var_139_24.prefab_name ~= "" and arg_136_1.actors_[var_139_24.prefab_name] ~= nil then
						local var_139_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_24.prefab_name].transform, "story_v_out_319181", "319181033", "story_v_out_319181.awb")

						arg_136_1:RecordAudio("319181033", var_139_30)
						arg_136_1:RecordAudio("319181033", var_139_30)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_319181", "319181033", "story_v_out_319181.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_319181", "319181033", "story_v_out_319181.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_31 = math.max(var_139_22, arg_136_1.talkMaxDuration)

			if var_139_21 <= arg_136_1.time_ and arg_136_1.time_ < var_139_21 + var_139_31 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_21) / var_139_31

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_21 + var_139_31 and arg_136_1.time_ < var_139_21 + var_139_31 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319181034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 319181034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play319181035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["10066ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect10066ui_story == nil then
				arg_140_1.var_.characterEffect10066ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect10066ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_140_1.var_.characterEffect10066ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect10066ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_140_1.var_.characterEffect10066ui_story.fillRatio = var_143_5
			end

			local var_143_6 = arg_140_1.actors_["4040ui_story"].transform
			local var_143_7 = 0

			if var_143_7 < arg_140_1.time_ and arg_140_1.time_ <= var_143_7 + arg_143_0 then
				arg_140_1.var_.moveOldPos4040ui_story = var_143_6.localPosition
			end

			local var_143_8 = 0.001

			if var_143_7 <= arg_140_1.time_ and arg_140_1.time_ < var_143_7 + var_143_8 then
				local var_143_9 = (arg_140_1.time_ - var_143_7) / var_143_8
				local var_143_10 = Vector3.New(0, 100, 0)

				var_143_6.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos4040ui_story, var_143_10, var_143_9)

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

			local var_143_15 = arg_140_1.actors_["10066ui_story"].transform
			local var_143_16 = 0

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 then
				arg_140_1.var_.moveOldPos10066ui_story = var_143_15.localPosition
			end

			local var_143_17 = 0.001

			if var_143_16 <= arg_140_1.time_ and arg_140_1.time_ < var_143_16 + var_143_17 then
				local var_143_18 = (arg_140_1.time_ - var_143_16) / var_143_17
				local var_143_19 = Vector3.New(0, 100, 0)

				var_143_15.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10066ui_story, var_143_19, var_143_18)

				local var_143_20 = manager.ui.mainCamera.transform.position - var_143_15.position

				var_143_15.forward = Vector3.New(var_143_20.x, var_143_20.y, var_143_20.z)

				local var_143_21 = var_143_15.localEulerAngles

				var_143_21.z = 0
				var_143_21.x = 0
				var_143_15.localEulerAngles = var_143_21
			end

			if arg_140_1.time_ >= var_143_16 + var_143_17 and arg_140_1.time_ < var_143_16 + var_143_17 + arg_143_0 then
				var_143_15.localPosition = Vector3.New(0, 100, 0)

				local var_143_22 = manager.ui.mainCamera.transform.position - var_143_15.position

				var_143_15.forward = Vector3.New(var_143_22.x, var_143_22.y, var_143_22.z)

				local var_143_23 = var_143_15.localEulerAngles

				var_143_23.z = 0
				var_143_23.x = 0
				var_143_15.localEulerAngles = var_143_23
			end

			local var_143_24 = 0
			local var_143_25 = 0.875

			if var_143_24 < arg_140_1.time_ and arg_140_1.time_ <= var_143_24 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_26 = arg_140_1:GetWordFromCfg(319181034)
				local var_143_27 = arg_140_1:FormatText(var_143_26.content)

				arg_140_1.text_.text = var_143_27

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_28 = 35
				local var_143_29 = utf8.len(var_143_27)
				local var_143_30 = var_143_28 <= 0 and var_143_25 or var_143_25 * (var_143_29 / var_143_28)

				if var_143_30 > 0 and var_143_25 < var_143_30 then
					arg_140_1.talkMaxDuration = var_143_30

					if var_143_30 + var_143_24 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_30 + var_143_24
					end
				end

				arg_140_1.text_.text = var_143_27
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_31 = math.max(var_143_25, arg_140_1.talkMaxDuration)

			if var_143_24 <= arg_140_1.time_ and arg_140_1.time_ < var_143_24 + var_143_31 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_24) / var_143_31

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_24 + var_143_31 and arg_140_1.time_ < var_143_24 + var_143_31 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319181035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 319181035
		arg_144_1.duration_ = 3.03

		local var_144_0 = {
			zh = 2.6,
			ja = 3.033
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
				arg_144_0:Play319181036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = "10079ui_story"

			if arg_144_1.actors_[var_147_0] == nil then
				local var_147_1 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_147_1) then
					local var_147_2 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_144_1.stage_.transform)

					var_147_2.name = var_147_0
					var_147_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_144_1.actors_[var_147_0] = var_147_2

					local var_147_3 = var_147_2:GetComponentInChildren(typeof(CharacterEffect))

					var_147_3.enabled = true

					local var_147_4 = GameObjectTools.GetOrAddComponent(var_147_2, typeof(DynamicBoneHelper))

					if var_147_4 then
						var_147_4:EnableDynamicBone(false)
					end

					arg_144_1:ShowWeapon(var_147_3.transform, false)

					arg_144_1.var_[var_147_0 .. "Animator"] = var_147_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_144_1.var_[var_147_0 .. "Animator"].applyRootMotion = true
					arg_144_1.var_[var_147_0 .. "LipSync"] = var_147_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_147_5 = arg_144_1.actors_["10079ui_story"].transform
			local var_147_6 = 0

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.var_.moveOldPos10079ui_story = var_147_5.localPosition
			end

			local var_147_7 = 0.001

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_7 then
				local var_147_8 = (arg_144_1.time_ - var_147_6) / var_147_7
				local var_147_9 = Vector3.New(0, -0.95, -6.05)

				var_147_5.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10079ui_story, var_147_9, var_147_8)

				local var_147_10 = manager.ui.mainCamera.transform.position - var_147_5.position

				var_147_5.forward = Vector3.New(var_147_10.x, var_147_10.y, var_147_10.z)

				local var_147_11 = var_147_5.localEulerAngles

				var_147_11.z = 0
				var_147_11.x = 0
				var_147_5.localEulerAngles = var_147_11
			end

			if arg_144_1.time_ >= var_147_6 + var_147_7 and arg_144_1.time_ < var_147_6 + var_147_7 + arg_147_0 then
				var_147_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_147_12 = manager.ui.mainCamera.transform.position - var_147_5.position

				var_147_5.forward = Vector3.New(var_147_12.x, var_147_12.y, var_147_12.z)

				local var_147_13 = var_147_5.localEulerAngles

				var_147_13.z = 0
				var_147_13.x = 0
				var_147_5.localEulerAngles = var_147_13
			end

			local var_147_14 = arg_144_1.actors_["10079ui_story"]
			local var_147_15 = 0

			if var_147_15 < arg_144_1.time_ and arg_144_1.time_ <= var_147_15 + arg_147_0 and not isNil(var_147_14) and arg_144_1.var_.characterEffect10079ui_story == nil then
				arg_144_1.var_.characterEffect10079ui_story = var_147_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_16 = 0.200000002980232

			if var_147_15 <= arg_144_1.time_ and arg_144_1.time_ < var_147_15 + var_147_16 and not isNil(var_147_14) then
				local var_147_17 = (arg_144_1.time_ - var_147_15) / var_147_16

				if arg_144_1.var_.characterEffect10079ui_story and not isNil(var_147_14) then
					arg_144_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_15 + var_147_16 and arg_144_1.time_ < var_147_15 + var_147_16 + arg_147_0 and not isNil(var_147_14) and arg_144_1.var_.characterEffect10079ui_story then
				arg_144_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_147_18 = 0

			if var_147_18 < arg_144_1.time_ and arg_144_1.time_ <= var_147_18 + arg_147_0 then
				arg_144_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_147_19 = 0

			if var_147_19 < arg_144_1.time_ and arg_144_1.time_ <= var_147_19 + arg_147_0 then
				arg_144_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_147_20 = 0
			local var_147_21 = 0.25

			if var_147_20 < arg_144_1.time_ and arg_144_1.time_ <= var_147_20 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_22 = arg_144_1:FormatText(StoryNameCfg[6].name)

				arg_144_1.leftNameTxt_.text = var_147_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_23 = arg_144_1:GetWordFromCfg(319181035)
				local var_147_24 = arg_144_1:FormatText(var_147_23.content)

				arg_144_1.text_.text = var_147_24

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_25 = 10
				local var_147_26 = utf8.len(var_147_24)
				local var_147_27 = var_147_25 <= 0 and var_147_21 or var_147_21 * (var_147_26 / var_147_25)

				if var_147_27 > 0 and var_147_21 < var_147_27 then
					arg_144_1.talkMaxDuration = var_147_27

					if var_147_27 + var_147_20 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_27 + var_147_20
					end
				end

				arg_144_1.text_.text = var_147_24
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181035", "story_v_out_319181.awb") ~= 0 then
					local var_147_28 = manager.audio:GetVoiceLength("story_v_out_319181", "319181035", "story_v_out_319181.awb") / 1000

					if var_147_28 + var_147_20 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_28 + var_147_20
					end

					if var_147_23.prefab_name ~= "" and arg_144_1.actors_[var_147_23.prefab_name] ~= nil then
						local var_147_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_23.prefab_name].transform, "story_v_out_319181", "319181035", "story_v_out_319181.awb")

						arg_144_1:RecordAudio("319181035", var_147_29)
						arg_144_1:RecordAudio("319181035", var_147_29)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_319181", "319181035", "story_v_out_319181.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_319181", "319181035", "story_v_out_319181.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_30 = math.max(var_147_21, arg_144_1.talkMaxDuration)

			if var_147_20 <= arg_144_1.time_ and arg_144_1.time_ < var_147_20 + var_147_30 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_20) / var_147_30

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_20 + var_147_30 and arg_144_1.time_ < var_147_20 + var_147_30 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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

		arg_144_1:InitPlayNodeList()
	end,
	Play319181036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 319181036
		arg_148_1.duration_ = 5.1

		local var_148_0 = {
			zh = 5.066,
			ja = 5.1
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
				arg_148_0:Play319181037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["4040ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos4040ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0.7, -1.55, -5.5)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos4040ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = arg_148_1.actors_["4040ui_story"]
			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect4040ui_story == nil then
				arg_148_1.var_.characterEffect4040ui_story = var_151_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_11 = 0.200000002980232

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_11 and not isNil(var_151_9) then
				local var_151_12 = (arg_148_1.time_ - var_151_10) / var_151_11

				if arg_148_1.var_.characterEffect4040ui_story and not isNil(var_151_9) then
					arg_148_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_10 + var_151_11 and arg_148_1.time_ < var_151_10 + var_151_11 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect4040ui_story then
				arg_148_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_151_13 = 0

			if var_151_13 < arg_148_1.time_ and arg_148_1.time_ <= var_151_13 + arg_151_0 then
				arg_148_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			local var_151_14 = 0

			if var_151_14 < arg_148_1.time_ and arg_148_1.time_ <= var_151_14 + arg_151_0 then
				arg_148_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_151_15 = arg_148_1.actors_["10079ui_story"].transform
			local var_151_16 = 0

			if var_151_16 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 then
				arg_148_1.var_.moveOldPos10079ui_story = var_151_15.localPosition
			end

			local var_151_17 = 0.001

			if var_151_16 <= arg_148_1.time_ and arg_148_1.time_ < var_151_16 + var_151_17 then
				local var_151_18 = (arg_148_1.time_ - var_151_16) / var_151_17
				local var_151_19 = Vector3.New(-0.7, -0.95, -6.05)

				var_151_15.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10079ui_story, var_151_19, var_151_18)

				local var_151_20 = manager.ui.mainCamera.transform.position - var_151_15.position

				var_151_15.forward = Vector3.New(var_151_20.x, var_151_20.y, var_151_20.z)

				local var_151_21 = var_151_15.localEulerAngles

				var_151_21.z = 0
				var_151_21.x = 0
				var_151_15.localEulerAngles = var_151_21
			end

			if arg_148_1.time_ >= var_151_16 + var_151_17 and arg_148_1.time_ < var_151_16 + var_151_17 + arg_151_0 then
				var_151_15.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_151_22 = manager.ui.mainCamera.transform.position - var_151_15.position

				var_151_15.forward = Vector3.New(var_151_22.x, var_151_22.y, var_151_22.z)

				local var_151_23 = var_151_15.localEulerAngles

				var_151_23.z = 0
				var_151_23.x = 0
				var_151_15.localEulerAngles = var_151_23
			end

			local var_151_24 = arg_148_1.actors_["10079ui_story"]
			local var_151_25 = 0

			if var_151_25 < arg_148_1.time_ and arg_148_1.time_ <= var_151_25 + arg_151_0 and not isNil(var_151_24) and arg_148_1.var_.characterEffect10079ui_story == nil then
				arg_148_1.var_.characterEffect10079ui_story = var_151_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_26 = 0.200000002980232

			if var_151_25 <= arg_148_1.time_ and arg_148_1.time_ < var_151_25 + var_151_26 and not isNil(var_151_24) then
				local var_151_27 = (arg_148_1.time_ - var_151_25) / var_151_26

				if arg_148_1.var_.characterEffect10079ui_story and not isNil(var_151_24) then
					local var_151_28 = Mathf.Lerp(0, 0.5, var_151_27)

					arg_148_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10079ui_story.fillRatio = var_151_28
				end
			end

			if arg_148_1.time_ >= var_151_25 + var_151_26 and arg_148_1.time_ < var_151_25 + var_151_26 + arg_151_0 and not isNil(var_151_24) and arg_148_1.var_.characterEffect10079ui_story then
				local var_151_29 = 0.5

				arg_148_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10079ui_story.fillRatio = var_151_29
			end

			local var_151_30 = 0
			local var_151_31 = 0.6

			if var_151_30 < arg_148_1.time_ and arg_148_1.time_ <= var_151_30 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_32 = arg_148_1:FormatText(StoryNameCfg[668].name)

				arg_148_1.leftNameTxt_.text = var_151_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_33 = arg_148_1:GetWordFromCfg(319181036)
				local var_151_34 = arg_148_1:FormatText(var_151_33.content)

				arg_148_1.text_.text = var_151_34

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_35 = 24
				local var_151_36 = utf8.len(var_151_34)
				local var_151_37 = var_151_35 <= 0 and var_151_31 or var_151_31 * (var_151_36 / var_151_35)

				if var_151_37 > 0 and var_151_31 < var_151_37 then
					arg_148_1.talkMaxDuration = var_151_37

					if var_151_37 + var_151_30 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_37 + var_151_30
					end
				end

				arg_148_1.text_.text = var_151_34
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181036", "story_v_out_319181.awb") ~= 0 then
					local var_151_38 = manager.audio:GetVoiceLength("story_v_out_319181", "319181036", "story_v_out_319181.awb") / 1000

					if var_151_38 + var_151_30 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_38 + var_151_30
					end

					if var_151_33.prefab_name ~= "" and arg_148_1.actors_[var_151_33.prefab_name] ~= nil then
						local var_151_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_33.prefab_name].transform, "story_v_out_319181", "319181036", "story_v_out_319181.awb")

						arg_148_1:RecordAudio("319181036", var_151_39)
						arg_148_1:RecordAudio("319181036", var_151_39)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_319181", "319181036", "story_v_out_319181.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_319181", "319181036", "story_v_out_319181.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_40 = math.max(var_151_31, arg_148_1.talkMaxDuration)

			if var_151_30 <= arg_148_1.time_ and arg_148_1.time_ < var_151_30 + var_151_40 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_30) / var_151_40

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_30 + var_151_40 and arg_148_1.time_ < var_151_30 + var_151_40 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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

		arg_148_1:InitPlayNodeList()
	end,
	Play319181037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 319181037
		arg_152_1.duration_ = 6.1

		local var_152_0 = {
			zh = 6.1,
			ja = 5.633
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play319181038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.675

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[668].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_3 = arg_152_1:GetWordFromCfg(319181037)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 27
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181037", "story_v_out_319181.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_319181", "319181037", "story_v_out_319181.awb") / 1000

					if var_155_8 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_0
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_319181", "319181037", "story_v_out_319181.awb")

						arg_152_1:RecordAudio("319181037", var_155_9)
						arg_152_1:RecordAudio("319181037", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_319181", "319181037", "story_v_out_319181.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_319181", "319181037", "story_v_out_319181.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_10 and arg_152_1.time_ < var_155_0 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play319181038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 319181038
		arg_156_1.duration_ = 2.2

		local var_156_0 = {
			zh = 2.2,
			ja = 1.999999999999
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
				arg_156_0:Play319181039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["10079ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos10079ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10079ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = arg_156_1.actors_["10079ui_story"]
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect10079ui_story == nil then
				arg_156_1.var_.characterEffect10079ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_11 = 0.200000002980232

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 and not isNil(var_159_9) then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11

				if arg_156_1.var_.characterEffect10079ui_story and not isNil(var_159_9) then
					arg_156_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect10079ui_story then
				arg_156_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_159_13 = 0

			if var_159_13 < arg_156_1.time_ and arg_156_1.time_ <= var_159_13 + arg_159_0 then
				arg_156_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4127")
			end

			local var_159_14 = 0

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_159_15 = arg_156_1.actors_["4040ui_story"]
			local var_159_16 = 0

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 and not isNil(var_159_15) and arg_156_1.var_.characterEffect4040ui_story == nil then
				arg_156_1.var_.characterEffect4040ui_story = var_159_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_17 = 0.200000002980232

			if var_159_16 <= arg_156_1.time_ and arg_156_1.time_ < var_159_16 + var_159_17 and not isNil(var_159_15) then
				local var_159_18 = (arg_156_1.time_ - var_159_16) / var_159_17

				if arg_156_1.var_.characterEffect4040ui_story and not isNil(var_159_15) then
					local var_159_19 = Mathf.Lerp(0, 0.5, var_159_18)

					arg_156_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_156_1.var_.characterEffect4040ui_story.fillRatio = var_159_19
				end
			end

			if arg_156_1.time_ >= var_159_16 + var_159_17 and arg_156_1.time_ < var_159_16 + var_159_17 + arg_159_0 and not isNil(var_159_15) and arg_156_1.var_.characterEffect4040ui_story then
				local var_159_20 = 0.5

				arg_156_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_156_1.var_.characterEffect4040ui_story.fillRatio = var_159_20
			end

			local var_159_21 = 0
			local var_159_22 = 0.2

			if var_159_21 < arg_156_1.time_ and arg_156_1.time_ <= var_159_21 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_23 = arg_156_1:FormatText(StoryNameCfg[6].name)

				arg_156_1.leftNameTxt_.text = var_159_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_24 = arg_156_1:GetWordFromCfg(319181038)
				local var_159_25 = arg_156_1:FormatText(var_159_24.content)

				arg_156_1.text_.text = var_159_25

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_26 = 8
				local var_159_27 = utf8.len(var_159_25)
				local var_159_28 = var_159_26 <= 0 and var_159_22 or var_159_22 * (var_159_27 / var_159_26)

				if var_159_28 > 0 and var_159_22 < var_159_28 then
					arg_156_1.talkMaxDuration = var_159_28

					if var_159_28 + var_159_21 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_28 + var_159_21
					end
				end

				arg_156_1.text_.text = var_159_25
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181038", "story_v_out_319181.awb") ~= 0 then
					local var_159_29 = manager.audio:GetVoiceLength("story_v_out_319181", "319181038", "story_v_out_319181.awb") / 1000

					if var_159_29 + var_159_21 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_29 + var_159_21
					end

					if var_159_24.prefab_name ~= "" and arg_156_1.actors_[var_159_24.prefab_name] ~= nil then
						local var_159_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_24.prefab_name].transform, "story_v_out_319181", "319181038", "story_v_out_319181.awb")

						arg_156_1:RecordAudio("319181038", var_159_30)
						arg_156_1:RecordAudio("319181038", var_159_30)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319181", "319181038", "story_v_out_319181.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319181", "319181038", "story_v_out_319181.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_31 = math.max(var_159_22, arg_156_1.talkMaxDuration)

			if var_159_21 <= arg_156_1.time_ and arg_156_1.time_ < var_159_21 + var_159_31 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_21) / var_159_31

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_21 + var_159_31 and arg_156_1.time_ < var_159_21 + var_159_31 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
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

		arg_156_1:InitPlayNodeList()
	end,
	Play319181039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 319181039
		arg_160_1.duration_ = 7.43

		local var_160_0 = {
			zh = 7.433,
			ja = 6.033
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
				arg_160_0:Play319181040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10079ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10079ui_story == nil then
				arg_160_1.var_.characterEffect10079ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect10079ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_160_1.var_.characterEffect10079ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10079ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_160_1.var_.characterEffect10079ui_story.fillRatio = var_163_5
			end

			local var_163_6 = arg_160_1.actors_["4040ui_story"]
			local var_163_7 = 0

			if var_163_7 < arg_160_1.time_ and arg_160_1.time_ <= var_163_7 + arg_163_0 and not isNil(var_163_6) and arg_160_1.var_.characterEffect4040ui_story == nil then
				arg_160_1.var_.characterEffect4040ui_story = var_163_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_8 = 0.200000002980232

			if var_163_7 <= arg_160_1.time_ and arg_160_1.time_ < var_163_7 + var_163_8 and not isNil(var_163_6) then
				local var_163_9 = (arg_160_1.time_ - var_163_7) / var_163_8

				if arg_160_1.var_.characterEffect4040ui_story and not isNil(var_163_6) then
					arg_160_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_7 + var_163_8 and arg_160_1.time_ < var_163_7 + var_163_8 + arg_163_0 and not isNil(var_163_6) and arg_160_1.var_.characterEffect4040ui_story then
				arg_160_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_163_10 = 0
			local var_163_11 = 0.825

			if var_163_10 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_12 = arg_160_1:FormatText(StoryNameCfg[668].name)

				arg_160_1.leftNameTxt_.text = var_163_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_13 = arg_160_1:GetWordFromCfg(319181039)
				local var_163_14 = arg_160_1:FormatText(var_163_13.content)

				arg_160_1.text_.text = var_163_14

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_15 = 33
				local var_163_16 = utf8.len(var_163_14)
				local var_163_17 = var_163_15 <= 0 and var_163_11 or var_163_11 * (var_163_16 / var_163_15)

				if var_163_17 > 0 and var_163_11 < var_163_17 then
					arg_160_1.talkMaxDuration = var_163_17

					if var_163_17 + var_163_10 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_17 + var_163_10
					end
				end

				arg_160_1.text_.text = var_163_14
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181039", "story_v_out_319181.awb") ~= 0 then
					local var_163_18 = manager.audio:GetVoiceLength("story_v_out_319181", "319181039", "story_v_out_319181.awb") / 1000

					if var_163_18 + var_163_10 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_18 + var_163_10
					end

					if var_163_13.prefab_name ~= "" and arg_160_1.actors_[var_163_13.prefab_name] ~= nil then
						local var_163_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_13.prefab_name].transform, "story_v_out_319181", "319181039", "story_v_out_319181.awb")

						arg_160_1:RecordAudio("319181039", var_163_19)
						arg_160_1:RecordAudio("319181039", var_163_19)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_319181", "319181039", "story_v_out_319181.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_319181", "319181039", "story_v_out_319181.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_20 = math.max(var_163_11, arg_160_1.talkMaxDuration)

			if var_163_10 <= arg_160_1.time_ and arg_160_1.time_ < var_163_10 + var_163_20 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_10) / var_163_20

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_10 + var_163_20 and arg_160_1.time_ < var_163_10 + var_163_20 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play319181040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 319181040
		arg_164_1.duration_ = 4.07

		local var_164_0 = {
			zh = 4.066,
			ja = 2.6
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
			arg_164_1.auto_ = false
		end

		function arg_164_1.playNext_(arg_166_0)
			arg_164_1.onStoryFinished_()
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["4040ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos4040ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(0.7, -1.55, -5.5)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos4040ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = arg_164_1.actors_["4040ui_story"]
			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect4040ui_story == nil then
				arg_164_1.var_.characterEffect4040ui_story = var_167_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_11 = 0.200000002980232

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_11 and not isNil(var_167_9) then
				local var_167_12 = (arg_164_1.time_ - var_167_10) / var_167_11

				if arg_164_1.var_.characterEffect4040ui_story and not isNil(var_167_9) then
					arg_164_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_10 + var_167_11 and arg_164_1.time_ < var_167_10 + var_167_11 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect4040ui_story then
				arg_164_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_167_13 = 0

			if var_167_13 < arg_164_1.time_ and arg_164_1.time_ <= var_167_13 + arg_167_0 then
				arg_164_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_167_14 = 0

			if var_167_14 < arg_164_1.time_ and arg_164_1.time_ <= var_167_14 + arg_167_0 then
				arg_164_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_167_15 = 0
			local var_167_16 = 0.4

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_17 = arg_164_1:FormatText(StoryNameCfg[668].name)

				arg_164_1.leftNameTxt_.text = var_167_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_18 = arg_164_1:GetWordFromCfg(319181040)
				local var_167_19 = arg_164_1:FormatText(var_167_18.content)

				arg_164_1.text_.text = var_167_19

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_20 = 16
				local var_167_21 = utf8.len(var_167_19)
				local var_167_22 = var_167_20 <= 0 and var_167_16 or var_167_16 * (var_167_21 / var_167_20)

				if var_167_22 > 0 and var_167_16 < var_167_22 then
					arg_164_1.talkMaxDuration = var_167_22

					if var_167_22 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_22 + var_167_15
					end
				end

				arg_164_1.text_.text = var_167_19
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181040", "story_v_out_319181.awb") ~= 0 then
					local var_167_23 = manager.audio:GetVoiceLength("story_v_out_319181", "319181040", "story_v_out_319181.awb") / 1000

					if var_167_23 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_23 + var_167_15
					end

					if var_167_18.prefab_name ~= "" and arg_164_1.actors_[var_167_18.prefab_name] ~= nil then
						local var_167_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_18.prefab_name].transform, "story_v_out_319181", "319181040", "story_v_out_319181.awb")

						arg_164_1:RecordAudio("319181040", var_167_24)
						arg_164_1:RecordAudio("319181040", var_167_24)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_319181", "319181040", "story_v_out_319181.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_319181", "319181040", "story_v_out_319181.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_25 = math.max(var_167_16, arg_164_1.talkMaxDuration)

			if var_167_15 <= arg_164_1.time_ and arg_164_1.time_ < var_167_15 + var_167_25 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_15) / var_167_25

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_15 + var_167_25 and arg_164_1.time_ < var_167_15 + var_167_25 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/D02a"
	},
	voices = {
		"story_v_out_319181.awb"
	}
}
