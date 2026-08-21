return {
	Play121511001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121511001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play121511002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J12f"

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
				local var_4_5 = arg_1_1.bgs_.J12f

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
					if iter_4_0 ~= "J12f" then
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

			local var_4_22 = "1075ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1075ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1075ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -1.055, -6.16)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1075ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1075ui_story"]
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1075ui_story == nil then
				arg_1_1.var_.characterEffect1075ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1075ui_story and not isNil(var_4_36) then
					local var_4_40 = Mathf.Lerp(0, 0.5, var_4_39)

					arg_1_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1075ui_story.fillRatio = var_4_40
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1075ui_story then
				local var_4_41 = 0.5

				arg_1_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1075ui_story.fillRatio = var_4_41
			end

			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_4_44 = 0
			local var_4_45 = 0.0666666666666667

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

			local var_4_50 = 0.1
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "effect"

				arg_1_1:AudioAction(var_4_52, var_4_53, "se_story_121_04", "se_story_121_04_harbor_loop", "")
			end

			local var_4_54 = 2
			local var_4_55 = 0.15

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_57 = arg_1_1:GetWordFromCfg(121511001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 6
				local var_4_60 = utf8.len(var_4_58)
				local var_4_61 = var_4_59 <= 0 and var_4_55 or var_4_55 * (var_4_60 / var_4_59)

				if var_4_61 > 0 and var_4_55 < var_4_61 then
					arg_1_1.talkMaxDuration = var_4_61

					if var_4_61 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_58
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_62 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_62 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_54) / var_4_62

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_54 + var_4_62 and arg_1_1.time_ < var_4_54 + var_4_62 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play121511002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 121511002
		arg_6_1.duration_ = 6.87

		local var_6_0 = {
			ja = 6.866,
			ko = 5.7,
			zh = 5.7
		}
		local var_6_1 = manager.audio:GetLocalizationFlag()

		if var_6_0[var_6_1] ~= nil then
			arg_6_1.duration_ = var_6_0[var_6_1]
		end

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play121511003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = arg_6_1.actors_["1075ui_story"]
			local var_9_1 = 0

			if var_9_1 < arg_6_1.time_ and arg_6_1.time_ <= var_9_1 + arg_9_0 and not isNil(var_9_0) and arg_6_1.var_.characterEffect1075ui_story == nil then
				arg_6_1.var_.characterEffect1075ui_story = var_9_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_9_2 = 0.200000002980232

			if var_9_1 <= arg_6_1.time_ and arg_6_1.time_ < var_9_1 + var_9_2 and not isNil(var_9_0) then
				local var_9_3 = (arg_6_1.time_ - var_9_1) / var_9_2

				if arg_6_1.var_.characterEffect1075ui_story and not isNil(var_9_0) then
					arg_6_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_6_1.time_ >= var_9_1 + var_9_2 and arg_6_1.time_ < var_9_1 + var_9_2 + arg_9_0 and not isNil(var_9_0) and arg_6_1.var_.characterEffect1075ui_story then
				arg_6_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_9_4 = 0

			if var_9_4 < arg_6_1.time_ and arg_6_1.time_ <= var_9_4 + arg_9_0 then
				arg_6_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_9_5 = 0

			if var_9_5 < arg_6_1.time_ and arg_6_1.time_ <= var_9_5 + arg_9_0 then
				arg_6_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_9_6 = 0
			local var_9_7 = 0.55

			if var_9_6 < arg_6_1.time_ and arg_6_1.time_ <= var_9_6 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0
				arg_6_1.dialogCg_.alpha = 1

				arg_6_1.dialog_:SetActive(true)
				SetActive(arg_6_1.leftNameGo_, true)

				local var_9_8 = arg_6_1:FormatText(StoryNameCfg[381].name)

				arg_6_1.leftNameTxt_.text = var_9_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_1.leftNameTxt_.transform)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1.leftNameTxt_.text)
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_9 = arg_6_1:GetWordFromCfg(121511002)
				local var_9_10 = arg_6_1:FormatText(var_9_9.content)

				arg_6_1.text_.text = var_9_10

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_11 = 22
				local var_9_12 = utf8.len(var_9_10)
				local var_9_13 = var_9_11 <= 0 and var_9_7 or var_9_7 * (var_9_12 / var_9_11)

				if var_9_13 > 0 and var_9_7 < var_9_13 then
					arg_6_1.talkMaxDuration = var_9_13

					if var_9_13 + var_9_6 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_13 + var_9_6
					end
				end

				arg_6_1.text_.text = var_9_10
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511002", "story_v_out_121511.awb") ~= 0 then
					local var_9_14 = manager.audio:GetVoiceLength("story_v_out_121511", "121511002", "story_v_out_121511.awb") / 1000

					if var_9_14 + var_9_6 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_14 + var_9_6
					end

					if var_9_9.prefab_name ~= "" and arg_6_1.actors_[var_9_9.prefab_name] ~= nil then
						local var_9_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_6_1.actors_[var_9_9.prefab_name].transform, "story_v_out_121511", "121511002", "story_v_out_121511.awb")

						arg_6_1:RecordAudio("121511002", var_9_15)
						arg_6_1:RecordAudio("121511002", var_9_15)
					else
						arg_6_1:AudioAction("play", "voice", "story_v_out_121511", "121511002", "story_v_out_121511.awb")
					end

					arg_6_1:RecordHistoryTalkVoice("story_v_out_121511", "121511002", "story_v_out_121511.awb")
				end

				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_16 = math.max(var_9_7, arg_6_1.talkMaxDuration)

			if var_9_6 <= arg_6_1.time_ and arg_6_1.time_ < var_9_6 + var_9_16 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_6) / var_9_16

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_6 + var_9_16 and arg_6_1.time_ < var_9_6 + var_9_16 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play121511003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 121511003
		arg_10_1.duration_ = 14.17

		local var_10_0 = {
			ja = 10.2,
			ko = 14.166,
			zh = 14.166
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play121511004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_13_1 = 0

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_13_2 = 0
			local var_13_3 = 1.45

			if var_13_2 < arg_10_1.time_ and arg_10_1.time_ <= var_13_2 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_4 = arg_10_1:FormatText(StoryNameCfg[381].name)

				arg_10_1.leftNameTxt_.text = var_13_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_5 = arg_10_1:GetWordFromCfg(121511003)
				local var_13_6 = arg_10_1:FormatText(var_13_5.content)

				arg_10_1.text_.text = var_13_6

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_7 = 59
				local var_13_8 = utf8.len(var_13_6)
				local var_13_9 = var_13_7 <= 0 and var_13_3 or var_13_3 * (var_13_8 / var_13_7)

				if var_13_9 > 0 and var_13_3 < var_13_9 then
					arg_10_1.talkMaxDuration = var_13_9

					if var_13_9 + var_13_2 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_9 + var_13_2
					end
				end

				arg_10_1.text_.text = var_13_6
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511003", "story_v_out_121511.awb") ~= 0 then
					local var_13_10 = manager.audio:GetVoiceLength("story_v_out_121511", "121511003", "story_v_out_121511.awb") / 1000

					if var_13_10 + var_13_2 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_10 + var_13_2
					end

					if var_13_5.prefab_name ~= "" and arg_10_1.actors_[var_13_5.prefab_name] ~= nil then
						local var_13_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_5.prefab_name].transform, "story_v_out_121511", "121511003", "story_v_out_121511.awb")

						arg_10_1:RecordAudio("121511003", var_13_11)
						arg_10_1:RecordAudio("121511003", var_13_11)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_121511", "121511003", "story_v_out_121511.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_121511", "121511003", "story_v_out_121511.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_12 = math.max(var_13_3, arg_10_1.talkMaxDuration)

			if var_13_2 <= arg_10_1.time_ and arg_10_1.time_ < var_13_2 + var_13_12 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_2) / var_13_12

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_2 + var_13_12 and arg_10_1.time_ < var_13_2 + var_13_12 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play121511004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 121511004
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play121511005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["1075ui_story"].transform
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.var_.moveOldPos1075ui_story = var_17_0.localPosition
			end

			local var_17_2 = 0.001

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2
				local var_17_4 = Vector3.New(0, 100, 0)

				var_17_0.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1075ui_story, var_17_4, var_17_3)

				local var_17_5 = manager.ui.mainCamera.transform.position - var_17_0.position

				var_17_0.forward = Vector3.New(var_17_5.x, var_17_5.y, var_17_5.z)

				local var_17_6 = var_17_0.localEulerAngles

				var_17_6.z = 0
				var_17_6.x = 0
				var_17_0.localEulerAngles = var_17_6
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 then
				var_17_0.localPosition = Vector3.New(0, 100, 0)

				local var_17_7 = manager.ui.mainCamera.transform.position - var_17_0.position

				var_17_0.forward = Vector3.New(var_17_7.x, var_17_7.y, var_17_7.z)

				local var_17_8 = var_17_0.localEulerAngles

				var_17_8.z = 0
				var_17_8.x = 0
				var_17_0.localEulerAngles = var_17_8
			end

			local var_17_9 = arg_14_1.actors_["1075ui_story"]
			local var_17_10 = 0

			if var_17_10 < arg_14_1.time_ and arg_14_1.time_ <= var_17_10 + arg_17_0 and not isNil(var_17_9) and arg_14_1.var_.characterEffect1075ui_story == nil then
				arg_14_1.var_.characterEffect1075ui_story = var_17_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_11 = 0.200000002980232

			if var_17_10 <= arg_14_1.time_ and arg_14_1.time_ < var_17_10 + var_17_11 and not isNil(var_17_9) then
				local var_17_12 = (arg_14_1.time_ - var_17_10) / var_17_11

				if arg_14_1.var_.characterEffect1075ui_story and not isNil(var_17_9) then
					local var_17_13 = Mathf.Lerp(0, 0.5, var_17_12)

					arg_14_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_14_1.var_.characterEffect1075ui_story.fillRatio = var_17_13
				end
			end

			if arg_14_1.time_ >= var_17_10 + var_17_11 and arg_14_1.time_ < var_17_10 + var_17_11 + arg_17_0 and not isNil(var_17_9) and arg_14_1.var_.characterEffect1075ui_story then
				local var_17_14 = 0.5

				arg_14_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_14_1.var_.characterEffect1075ui_story.fillRatio = var_17_14
			end

			local var_17_15 = 0
			local var_17_16 = 0.75

			if var_17_15 < arg_14_1.time_ and arg_14_1.time_ <= var_17_15 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_17 = arg_14_1:GetWordFromCfg(121511004)
				local var_17_18 = arg_14_1:FormatText(var_17_17.content)

				arg_14_1.text_.text = var_17_18

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_19 = 30
				local var_17_20 = utf8.len(var_17_18)
				local var_17_21 = var_17_19 <= 0 and var_17_16 or var_17_16 * (var_17_20 / var_17_19)

				if var_17_21 > 0 and var_17_16 < var_17_21 then
					arg_14_1.talkMaxDuration = var_17_21

					if var_17_21 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_21 + var_17_15
					end
				end

				arg_14_1.text_.text = var_17_18
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_22 = math.max(var_17_16, arg_14_1.talkMaxDuration)

			if var_17_15 <= arg_14_1.time_ and arg_14_1.time_ < var_17_15 + var_17_22 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_15) / var_17_22

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_15 + var_17_22 and arg_14_1.time_ < var_17_15 + var_17_22 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play121511005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 121511005
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play121511006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 1.225

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_2 = arg_18_1:GetWordFromCfg(121511005)
				local var_21_3 = arg_18_1:FormatText(var_21_2.content)

				arg_18_1.text_.text = var_21_3

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 49
				local var_21_5 = utf8.len(var_21_3)
				local var_21_6 = var_21_4 <= 0 and var_21_1 or var_21_1 * (var_21_5 / var_21_4)

				if var_21_6 > 0 and var_21_1 < var_21_6 then
					arg_18_1.talkMaxDuration = var_21_6

					if var_21_6 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_6 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_3
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_7 and arg_18_1.time_ < var_21_0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play121511006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 121511006
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play121511007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 0.6

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_2 = arg_22_1:FormatText(StoryNameCfg[7].name)

				arg_22_1.leftNameTxt_.text = var_25_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_3 = arg_22_1:GetWordFromCfg(121511006)
				local var_25_4 = arg_22_1:FormatText(var_25_3.content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_5 = 24
				local var_25_6 = utf8.len(var_25_4)
				local var_25_7 = var_25_5 <= 0 and var_25_1 or var_25_1 * (var_25_6 / var_25_5)

				if var_25_7 > 0 and var_25_1 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_0
					end
				end

				arg_22_1.text_.text = var_25_4
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_8 = math.max(var_25_1, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_8 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_0) / var_25_8

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_8 and arg_22_1.time_ < var_25_0 + var_25_8 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play121511007 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 121511007
		arg_26_1.duration_ = 4.87

		local var_26_0 = {
			ja = 4.866,
			ko = 4.666,
			zh = 4.666
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play121511008(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1075ui_story"].transform
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.var_.moveOldPos1075ui_story = var_29_0.localPosition
			end

			local var_29_2 = 0.001

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2
				local var_29_4 = Vector3.New(0, -1.055, -6.16)

				var_29_0.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1075ui_story, var_29_4, var_29_3)

				local var_29_5 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_5.x, var_29_5.y, var_29_5.z)

				local var_29_6 = var_29_0.localEulerAngles

				var_29_6.z = 0
				var_29_6.x = 0
				var_29_0.localEulerAngles = var_29_6
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 then
				var_29_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_29_7 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_7.x, var_29_7.y, var_29_7.z)

				local var_29_8 = var_29_0.localEulerAngles

				var_29_8.z = 0
				var_29_8.x = 0
				var_29_0.localEulerAngles = var_29_8
			end

			local var_29_9 = arg_26_1.actors_["1075ui_story"]
			local var_29_10 = 0

			if var_29_10 < arg_26_1.time_ and arg_26_1.time_ <= var_29_10 + arg_29_0 and not isNil(var_29_9) and arg_26_1.var_.characterEffect1075ui_story == nil then
				arg_26_1.var_.characterEffect1075ui_story = var_29_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_11 = 0.200000002980232

			if var_29_10 <= arg_26_1.time_ and arg_26_1.time_ < var_29_10 + var_29_11 and not isNil(var_29_9) then
				local var_29_12 = (arg_26_1.time_ - var_29_10) / var_29_11

				if arg_26_1.var_.characterEffect1075ui_story and not isNil(var_29_9) then
					arg_26_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_10 + var_29_11 and arg_26_1.time_ < var_29_10 + var_29_11 + arg_29_0 and not isNil(var_29_9) and arg_26_1.var_.characterEffect1075ui_story then
				arg_26_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_29_13 = 0

			if var_29_13 < arg_26_1.time_ and arg_26_1.time_ <= var_29_13 + arg_29_0 then
				arg_26_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_29_14 = 0

			if var_29_14 < arg_26_1.time_ and arg_26_1.time_ <= var_29_14 + arg_29_0 then
				arg_26_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_29_15 = 0
			local var_29_16 = 0.45

			if var_29_15 < arg_26_1.time_ and arg_26_1.time_ <= var_29_15 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_17 = arg_26_1:FormatText(StoryNameCfg[381].name)

				arg_26_1.leftNameTxt_.text = var_29_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_18 = arg_26_1:GetWordFromCfg(121511007)
				local var_29_19 = arg_26_1:FormatText(var_29_18.content)

				arg_26_1.text_.text = var_29_19

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_20 = 18
				local var_29_21 = utf8.len(var_29_19)
				local var_29_22 = var_29_20 <= 0 and var_29_16 or var_29_16 * (var_29_21 / var_29_20)

				if var_29_22 > 0 and var_29_16 < var_29_22 then
					arg_26_1.talkMaxDuration = var_29_22

					if var_29_22 + var_29_15 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_22 + var_29_15
					end
				end

				arg_26_1.text_.text = var_29_19
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511007", "story_v_out_121511.awb") ~= 0 then
					local var_29_23 = manager.audio:GetVoiceLength("story_v_out_121511", "121511007", "story_v_out_121511.awb") / 1000

					if var_29_23 + var_29_15 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_23 + var_29_15
					end

					if var_29_18.prefab_name ~= "" and arg_26_1.actors_[var_29_18.prefab_name] ~= nil then
						local var_29_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_18.prefab_name].transform, "story_v_out_121511", "121511007", "story_v_out_121511.awb")

						arg_26_1:RecordAudio("121511007", var_29_24)
						arg_26_1:RecordAudio("121511007", var_29_24)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_121511", "121511007", "story_v_out_121511.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_121511", "121511007", "story_v_out_121511.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_25 = math.max(var_29_16, arg_26_1.talkMaxDuration)

			if var_29_15 <= arg_26_1.time_ and arg_26_1.time_ < var_29_15 + var_29_25 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_15) / var_29_25

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_15 + var_29_25 and arg_26_1.time_ < var_29_15 + var_29_25 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play121511008 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 121511008
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play121511009(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1075ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect1075ui_story == nil then
				arg_30_1.var_.characterEffect1075ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.200000002980232

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect1075ui_story and not isNil(var_33_0) then
					local var_33_4 = Mathf.Lerp(0, 0.5, var_33_3)

					arg_30_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1075ui_story.fillRatio = var_33_4
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect1075ui_story then
				local var_33_5 = 0.5

				arg_30_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1075ui_story.fillRatio = var_33_5
			end

			local var_33_6 = 0
			local var_33_7 = 0.35

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_8 = arg_30_1:GetWordFromCfg(121511008)
				local var_33_9 = arg_30_1:FormatText(var_33_8.content)

				arg_30_1.text_.text = var_33_9

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_10 = 14
				local var_33_11 = utf8.len(var_33_9)
				local var_33_12 = var_33_10 <= 0 and var_33_7 or var_33_7 * (var_33_11 / var_33_10)

				if var_33_12 > 0 and var_33_7 < var_33_12 then
					arg_30_1.talkMaxDuration = var_33_12

					if var_33_12 + var_33_6 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_12 + var_33_6
					end
				end

				arg_30_1.text_.text = var_33_9
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_13 = math.max(var_33_7, arg_30_1.talkMaxDuration)

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_13 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_6) / var_33_13

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_6 + var_33_13 and arg_30_1.time_ < var_33_6 + var_33_13 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play121511009 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 121511009
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play121511010(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1075ui_story"].transform
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.var_.moveOldPos1075ui_story = var_37_0.localPosition
			end

			local var_37_2 = 0.001

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2
				local var_37_4 = Vector3.New(0, 100, 0)

				var_37_0.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1075ui_story, var_37_4, var_37_3)

				local var_37_5 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_5.x, var_37_5.y, var_37_5.z)

				local var_37_6 = var_37_0.localEulerAngles

				var_37_6.z = 0
				var_37_6.x = 0
				var_37_0.localEulerAngles = var_37_6
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 then
				var_37_0.localPosition = Vector3.New(0, 100, 0)

				local var_37_7 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_7.x, var_37_7.y, var_37_7.z)

				local var_37_8 = var_37_0.localEulerAngles

				var_37_8.z = 0
				var_37_8.x = 0
				var_37_0.localEulerAngles = var_37_8
			end

			local var_37_9 = arg_34_1.actors_["1075ui_story"]
			local var_37_10 = 0

			if var_37_10 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect1075ui_story == nil then
				arg_34_1.var_.characterEffect1075ui_story = var_37_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_11 = 0.200000002980232

			if var_37_10 <= arg_34_1.time_ and arg_34_1.time_ < var_37_10 + var_37_11 and not isNil(var_37_9) then
				local var_37_12 = (arg_34_1.time_ - var_37_10) / var_37_11

				if arg_34_1.var_.characterEffect1075ui_story and not isNil(var_37_9) then
					local var_37_13 = Mathf.Lerp(0, 0.5, var_37_12)

					arg_34_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1075ui_story.fillRatio = var_37_13
				end
			end

			if arg_34_1.time_ >= var_37_10 + var_37_11 and arg_34_1.time_ < var_37_10 + var_37_11 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect1075ui_story then
				local var_37_14 = 0.5

				arg_34_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1075ui_story.fillRatio = var_37_14
			end

			local var_37_15 = 0
			local var_37_16 = 1.05

			if var_37_15 < arg_34_1.time_ and arg_34_1.time_ <= var_37_15 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_17 = arg_34_1:GetWordFromCfg(121511009)
				local var_37_18 = arg_34_1:FormatText(var_37_17.content)

				arg_34_1.text_.text = var_37_18

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_19 = 42
				local var_37_20 = utf8.len(var_37_18)
				local var_37_21 = var_37_19 <= 0 and var_37_16 or var_37_16 * (var_37_20 / var_37_19)

				if var_37_21 > 0 and var_37_16 < var_37_21 then
					arg_34_1.talkMaxDuration = var_37_21

					if var_37_21 + var_37_15 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_21 + var_37_15
					end
				end

				arg_34_1.text_.text = var_37_18
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_22 = math.max(var_37_16, arg_34_1.talkMaxDuration)

			if var_37_15 <= arg_34_1.time_ and arg_34_1.time_ < var_37_15 + var_37_22 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_15) / var_37_22

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_15 + var_37_22 and arg_34_1.time_ < var_37_15 + var_37_22 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play121511010 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 121511010
		arg_38_1.duration_ = 5.4

		local var_38_0 = {
			ja = 5.033,
			ko = 5.4,
			zh = 5.4
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play121511011(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = "1184ui_story"

			if arg_38_1.actors_[var_41_0] == nil then
				local var_41_1 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_41_1) then
					local var_41_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_38_1.stage_.transform)

					var_41_2.name = var_41_0
					var_41_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_38_1.actors_[var_41_0] = var_41_2

					local var_41_3 = var_41_2:GetComponentInChildren(typeof(CharacterEffect))

					var_41_3.enabled = true

					local var_41_4 = GameObjectTools.GetOrAddComponent(var_41_2, typeof(DynamicBoneHelper))

					if var_41_4 then
						var_41_4:EnableDynamicBone(false)
					end

					arg_38_1:ShowWeapon(var_41_3.transform, false)

					arg_38_1.var_[var_41_0 .. "Animator"] = var_41_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_38_1.var_[var_41_0 .. "Animator"].applyRootMotion = true
					arg_38_1.var_[var_41_0 .. "LipSync"] = var_41_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_41_5 = arg_38_1.actors_["1184ui_story"].transform
			local var_41_6 = 0

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.var_.moveOldPos1184ui_story = var_41_5.localPosition
			end

			local var_41_7 = 0.001

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_7 then
				local var_41_8 = (arg_38_1.time_ - var_41_6) / var_41_7
				local var_41_9 = Vector3.New(0, -0.97, -6)

				var_41_5.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1184ui_story, var_41_9, var_41_8)

				local var_41_10 = manager.ui.mainCamera.transform.position - var_41_5.position

				var_41_5.forward = Vector3.New(var_41_10.x, var_41_10.y, var_41_10.z)

				local var_41_11 = var_41_5.localEulerAngles

				var_41_11.z = 0
				var_41_11.x = 0
				var_41_5.localEulerAngles = var_41_11
			end

			if arg_38_1.time_ >= var_41_6 + var_41_7 and arg_38_1.time_ < var_41_6 + var_41_7 + arg_41_0 then
				var_41_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_41_12 = manager.ui.mainCamera.transform.position - var_41_5.position

				var_41_5.forward = Vector3.New(var_41_12.x, var_41_12.y, var_41_12.z)

				local var_41_13 = var_41_5.localEulerAngles

				var_41_13.z = 0
				var_41_13.x = 0
				var_41_5.localEulerAngles = var_41_13
			end

			local var_41_14 = arg_38_1.actors_["1184ui_story"]
			local var_41_15 = 0

			if var_41_15 < arg_38_1.time_ and arg_38_1.time_ <= var_41_15 + arg_41_0 and not isNil(var_41_14) and arg_38_1.var_.characterEffect1184ui_story == nil then
				arg_38_1.var_.characterEffect1184ui_story = var_41_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_16 = 0.200000002980232

			if var_41_15 <= arg_38_1.time_ and arg_38_1.time_ < var_41_15 + var_41_16 and not isNil(var_41_14) then
				local var_41_17 = (arg_38_1.time_ - var_41_15) / var_41_16

				if arg_38_1.var_.characterEffect1184ui_story and not isNil(var_41_14) then
					arg_38_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_15 + var_41_16 and arg_38_1.time_ < var_41_15 + var_41_16 + arg_41_0 and not isNil(var_41_14) and arg_38_1.var_.characterEffect1184ui_story then
				arg_38_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_41_18 = 0

			if var_41_18 < arg_38_1.time_ and arg_38_1.time_ <= var_41_18 + arg_41_0 then
				arg_38_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_41_19 = 0

			if var_41_19 < arg_38_1.time_ and arg_38_1.time_ <= var_41_19 + arg_41_0 then
				arg_38_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_41_20 = 0
			local var_41_21 = 0.7

			if var_41_20 < arg_38_1.time_ and arg_38_1.time_ <= var_41_20 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_22 = arg_38_1:FormatText(StoryNameCfg[6].name)

				arg_38_1.leftNameTxt_.text = var_41_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_23 = arg_38_1:GetWordFromCfg(121511010)
				local var_41_24 = arg_38_1:FormatText(var_41_23.content)

				arg_38_1.text_.text = var_41_24

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_25 = 28
				local var_41_26 = utf8.len(var_41_24)
				local var_41_27 = var_41_25 <= 0 and var_41_21 or var_41_21 * (var_41_26 / var_41_25)

				if var_41_27 > 0 and var_41_21 < var_41_27 then
					arg_38_1.talkMaxDuration = var_41_27

					if var_41_27 + var_41_20 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_27 + var_41_20
					end
				end

				arg_38_1.text_.text = var_41_24
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511010", "story_v_out_121511.awb") ~= 0 then
					local var_41_28 = manager.audio:GetVoiceLength("story_v_out_121511", "121511010", "story_v_out_121511.awb") / 1000

					if var_41_28 + var_41_20 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_28 + var_41_20
					end

					if var_41_23.prefab_name ~= "" and arg_38_1.actors_[var_41_23.prefab_name] ~= nil then
						local var_41_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_23.prefab_name].transform, "story_v_out_121511", "121511010", "story_v_out_121511.awb")

						arg_38_1:RecordAudio("121511010", var_41_29)
						arg_38_1:RecordAudio("121511010", var_41_29)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_121511", "121511010", "story_v_out_121511.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_121511", "121511010", "story_v_out_121511.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_30 = math.max(var_41_21, arg_38_1.talkMaxDuration)

			if var_41_20 <= arg_38_1.time_ and arg_38_1.time_ < var_41_20 + var_41_30 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_20) / var_41_30

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_20 + var_41_30 and arg_38_1.time_ < var_41_20 + var_41_30 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play121511011 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 121511011
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play121511012(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1184ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1184ui_story == nil then
				arg_42_1.var_.characterEffect1184ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect1184ui_story and not isNil(var_45_0) then
					local var_45_4 = Mathf.Lerp(0, 0.5, var_45_3)

					arg_42_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1184ui_story.fillRatio = var_45_4
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1184ui_story then
				local var_45_5 = 0.5

				arg_42_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1184ui_story.fillRatio = var_45_5
			end

			local var_45_6 = 0
			local var_45_7 = 0.525

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_8 = arg_42_1:FormatText(StoryNameCfg[7].name)

				arg_42_1.leftNameTxt_.text = var_45_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_9 = arg_42_1:GetWordFromCfg(121511011)
				local var_45_10 = arg_42_1:FormatText(var_45_9.content)

				arg_42_1.text_.text = var_45_10

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 21
				local var_45_12 = utf8.len(var_45_10)
				local var_45_13 = var_45_11 <= 0 and var_45_7 or var_45_7 * (var_45_12 / var_45_11)

				if var_45_13 > 0 and var_45_7 < var_45_13 then
					arg_42_1.talkMaxDuration = var_45_13

					if var_45_13 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_13 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_10
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_14 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_14 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_14

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_14 and arg_42_1.time_ < var_45_6 + var_45_14 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play121511012 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 121511012
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play121511013(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 0.925

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_2 = arg_46_1:FormatText(StoryNameCfg[7].name)

				arg_46_1.leftNameTxt_.text = var_49_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_3 = arg_46_1:GetWordFromCfg(121511012)
				local var_49_4 = arg_46_1:FormatText(var_49_3.content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 37
				local var_49_6 = utf8.len(var_49_4)
				local var_49_7 = var_49_5 <= 0 and var_49_1 or var_49_1 * (var_49_6 / var_49_5)

				if var_49_7 > 0 and var_49_1 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_4
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_8 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_8 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_8

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_8 and arg_46_1.time_ < var_49_0 + var_49_8 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play121511013 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 121511013
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play121511014(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1184ui_story"].transform
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.var_.moveOldPos1184ui_story = var_53_0.localPosition
			end

			local var_53_2 = 0.001

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2
				local var_53_4 = Vector3.New(0, 100, 0)

				var_53_0.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1184ui_story, var_53_4, var_53_3)

				local var_53_5 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_5.x, var_53_5.y, var_53_5.z)

				local var_53_6 = var_53_0.localEulerAngles

				var_53_6.z = 0
				var_53_6.x = 0
				var_53_0.localEulerAngles = var_53_6
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 then
				var_53_0.localPosition = Vector3.New(0, 100, 0)

				local var_53_7 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_7.x, var_53_7.y, var_53_7.z)

				local var_53_8 = var_53_0.localEulerAngles

				var_53_8.z = 0
				var_53_8.x = 0
				var_53_0.localEulerAngles = var_53_8
			end

			local var_53_9 = arg_50_1.actors_["1184ui_story"]
			local var_53_10 = 0

			if var_53_10 < arg_50_1.time_ and arg_50_1.time_ <= var_53_10 + arg_53_0 and not isNil(var_53_9) and arg_50_1.var_.characterEffect1184ui_story == nil then
				arg_50_1.var_.characterEffect1184ui_story = var_53_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_11 = 0.200000002980232

			if var_53_10 <= arg_50_1.time_ and arg_50_1.time_ < var_53_10 + var_53_11 and not isNil(var_53_9) then
				local var_53_12 = (arg_50_1.time_ - var_53_10) / var_53_11

				if arg_50_1.var_.characterEffect1184ui_story and not isNil(var_53_9) then
					local var_53_13 = Mathf.Lerp(0, 0.5, var_53_12)

					arg_50_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1184ui_story.fillRatio = var_53_13
				end
			end

			if arg_50_1.time_ >= var_53_10 + var_53_11 and arg_50_1.time_ < var_53_10 + var_53_11 + arg_53_0 and not isNil(var_53_9) and arg_50_1.var_.characterEffect1184ui_story then
				local var_53_14 = 0.5

				arg_50_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1184ui_story.fillRatio = var_53_14
			end

			local var_53_15 = 0
			local var_53_16 = 0.8

			if var_53_15 < arg_50_1.time_ and arg_50_1.time_ <= var_53_15 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_17 = arg_50_1:GetWordFromCfg(121511013)
				local var_53_18 = arg_50_1:FormatText(var_53_17.content)

				arg_50_1.text_.text = var_53_18

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_19 = 32
				local var_53_20 = utf8.len(var_53_18)
				local var_53_21 = var_53_19 <= 0 and var_53_16 or var_53_16 * (var_53_20 / var_53_19)

				if var_53_21 > 0 and var_53_16 < var_53_21 then
					arg_50_1.talkMaxDuration = var_53_21

					if var_53_21 + var_53_15 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_21 + var_53_15
					end
				end

				arg_50_1.text_.text = var_53_18
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_22 = math.max(var_53_16, arg_50_1.talkMaxDuration)

			if var_53_15 <= arg_50_1.time_ and arg_50_1.time_ < var_53_15 + var_53_22 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_15) / var_53_22

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_15 + var_53_22 and arg_50_1.time_ < var_53_15 + var_53_22 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play121511014 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 121511014
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play121511015(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.0666666666666667

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				local var_57_2 = "play"
				local var_57_3 = "music"

				arg_54_1:AudioAction(var_57_2, var_57_3, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_57_4 = ""
				local var_57_5 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if var_57_5 ~= "" then
					if arg_54_1.bgmTxt_.text ~= var_57_5 and arg_54_1.bgmTxt_.text ~= "" then
						if arg_54_1.bgmTxt2_.text ~= "" then
							arg_54_1.bgmTxt_.text = arg_54_1.bgmTxt2_.text
						end

						arg_54_1.bgmTxt2_.text = var_57_5

						arg_54_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_54_1.bgmTxt_.text = var_57_5
						arg_54_1.bgmTxt2_.text = var_57_5
					end

					if arg_54_1.bgmTimer then
						arg_54_1.bgmTimer:Stop()

						arg_54_1.bgmTimer = nil
					end

					if arg_54_1.settingData.show_music_name == 1 then
						arg_54_1.musicController:SetSelectedState("show")
						arg_54_1.musicAnimator_:Play("open", 0, 0)

						if arg_54_1.settingData.music_time ~= 0 then
							arg_54_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_54_1.settingData.music_time), function()
								if arg_54_1 == nil or isNil(arg_54_1.bgmTxt_) then
									return
								end

								arg_54_1.musicController:SetSelectedState("hide")
								arg_54_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_57_6 = 0.0666666666666667
			local var_57_7 = 0.333333333333333

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				local var_57_8 = "play"
				local var_57_9 = "effect"

				arg_54_1:AudioAction(var_57_8, var_57_9, "se_story_121_04", "se_story_121_04_message1", "")
			end

			local var_57_10 = 0
			local var_57_11 = 1.225

			if var_57_10 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_12 = arg_54_1:GetWordFromCfg(121511014)
				local var_57_13 = arg_54_1:FormatText(var_57_12.content)

				arg_54_1.text_.text = var_57_13

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_14 = 49
				local var_57_15 = utf8.len(var_57_13)
				local var_57_16 = var_57_14 <= 0 and var_57_11 or var_57_11 * (var_57_15 / var_57_14)

				if var_57_16 > 0 and var_57_11 < var_57_16 then
					arg_54_1.talkMaxDuration = var_57_16

					if var_57_16 + var_57_10 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_16 + var_57_10
					end
				end

				arg_54_1.text_.text = var_57_13
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_17 = math.max(var_57_11, arg_54_1.talkMaxDuration)

			if var_57_10 <= arg_54_1.time_ and arg_54_1.time_ < var_57_10 + var_57_17 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_10) / var_57_17

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_10 + var_57_17 and arg_54_1.time_ < var_57_10 + var_57_17 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play121511015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 121511015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play121511016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.55

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[7].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(121511015)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 22
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_8 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_8 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_8

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_8 and arg_59_1.time_ < var_62_0 + var_62_8 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play121511016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 121511016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play121511017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.925

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_2 = arg_63_1:GetWordFromCfg(121511016)
				local var_66_3 = arg_63_1:FormatText(var_66_2.content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 37
				local var_66_5 = utf8.len(var_66_3)
				local var_66_6 = var_66_4 <= 0 and var_66_1 or var_66_1 * (var_66_5 / var_66_4)

				if var_66_6 > 0 and var_66_1 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_7 and arg_63_1.time_ < var_66_0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play121511017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 121511017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play121511018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.633333333333333

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				local var_70_2 = "play"
				local var_70_3 = "effect"

				arg_67_1:AudioAction(var_70_2, var_70_3, "se_story_121_04", "se_story_121_04_message2", "")
			end

			local var_70_4 = 0
			local var_70_5 = 1.15

			if var_70_4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:GetWordFromCfg(121511017)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_8 = 46
				local var_70_9 = utf8.len(var_70_7)
				local var_70_10 = var_70_8 <= 0 and var_70_5 or var_70_5 * (var_70_9 / var_70_8)

				if var_70_10 > 0 and var_70_5 < var_70_10 then
					arg_67_1.talkMaxDuration = var_70_10

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_11 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_11 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_11

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_11 and arg_67_1.time_ < var_70_4 + var_70_11 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play121511018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 121511018
		arg_71_1.duration_ = 13.7

		local var_71_0 = {
			ja = 13.7,
			ko = 13.1,
			zh = 13.1
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
				arg_71_0:Play121511019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1184ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1184ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, -0.97, -6)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1184ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["1184ui_story"]
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1184ui_story == nil then
				arg_71_1.var_.characterEffect1184ui_story = var_74_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_11 = 0.200000002980232

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 and not isNil(var_74_9) then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11

				if arg_71_1.var_.characterEffect1184ui_story and not isNil(var_74_9) then
					arg_71_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1184ui_story then
				arg_71_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_74_13 = 0

			if var_74_13 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				arg_71_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_74_14 = 0

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_15 = 0
			local var_74_16 = 1.275

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_17 = arg_71_1:FormatText(StoryNameCfg[6].name)

				arg_71_1.leftNameTxt_.text = var_74_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_18 = arg_71_1:GetWordFromCfg(121511018)
				local var_74_19 = arg_71_1:FormatText(var_74_18.content)

				arg_71_1.text_.text = var_74_19

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_20 = 51
				local var_74_21 = utf8.len(var_74_19)
				local var_74_22 = var_74_20 <= 0 and var_74_16 or var_74_16 * (var_74_21 / var_74_20)

				if var_74_22 > 0 and var_74_16 < var_74_22 then
					arg_71_1.talkMaxDuration = var_74_22

					if var_74_22 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_22 + var_74_15
					end
				end

				arg_71_1.text_.text = var_74_19
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511018", "story_v_out_121511.awb") ~= 0 then
					local var_74_23 = manager.audio:GetVoiceLength("story_v_out_121511", "121511018", "story_v_out_121511.awb") / 1000

					if var_74_23 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_23 + var_74_15
					end

					if var_74_18.prefab_name ~= "" and arg_71_1.actors_[var_74_18.prefab_name] ~= nil then
						local var_74_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_18.prefab_name].transform, "story_v_out_121511", "121511018", "story_v_out_121511.awb")

						arg_71_1:RecordAudio("121511018", var_74_24)
						arg_71_1:RecordAudio("121511018", var_74_24)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_121511", "121511018", "story_v_out_121511.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_121511", "121511018", "story_v_out_121511.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_25 = math.max(var_74_16, arg_71_1.talkMaxDuration)

			if var_74_15 <= arg_71_1.time_ and arg_71_1.time_ < var_74_15 + var_74_25 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_15) / var_74_25

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_15 + var_74_25 and arg_71_1.time_ < var_74_15 + var_74_25 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play121511019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 121511019
		arg_75_1.duration_ = 7.57

		local var_75_0 = {
			ja = 7.566,
			ko = 6.6,
			zh = 6.6
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
				arg_75_0:Play121511020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4136")
			end

			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_78_2 = 0
			local var_78_3 = 0.725

			if var_78_2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_4 = arg_75_1:FormatText(StoryNameCfg[6].name)

				arg_75_1.leftNameTxt_.text = var_78_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_5 = arg_75_1:GetWordFromCfg(121511019)
				local var_78_6 = arg_75_1:FormatText(var_78_5.content)

				arg_75_1.text_.text = var_78_6

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 29
				local var_78_8 = utf8.len(var_78_6)
				local var_78_9 = var_78_7 <= 0 and var_78_3 or var_78_3 * (var_78_8 / var_78_7)

				if var_78_9 > 0 and var_78_3 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_2
					end
				end

				arg_75_1.text_.text = var_78_6
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511019", "story_v_out_121511.awb") ~= 0 then
					local var_78_10 = manager.audio:GetVoiceLength("story_v_out_121511", "121511019", "story_v_out_121511.awb") / 1000

					if var_78_10 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_2
					end

					if var_78_5.prefab_name ~= "" and arg_75_1.actors_[var_78_5.prefab_name] ~= nil then
						local var_78_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_5.prefab_name].transform, "story_v_out_121511", "121511019", "story_v_out_121511.awb")

						arg_75_1:RecordAudio("121511019", var_78_11)
						arg_75_1:RecordAudio("121511019", var_78_11)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_121511", "121511019", "story_v_out_121511.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_121511", "121511019", "story_v_out_121511.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_12 = math.max(var_78_3, arg_75_1.talkMaxDuration)

			if var_78_2 <= arg_75_1.time_ and arg_75_1.time_ < var_78_2 + var_78_12 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_2) / var_78_12

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_2 + var_78_12 and arg_75_1.time_ < var_78_2 + var_78_12 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play121511020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 121511020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play121511021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1184ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1184ui_story = var_82_0.localPosition
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(0, 100, 0)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1184ui_story, var_82_4, var_82_3)

				local var_82_5 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_5.x, var_82_5.y, var_82_5.z)

				local var_82_6 = var_82_0.localEulerAngles

				var_82_6.z = 0
				var_82_6.x = 0
				var_82_0.localEulerAngles = var_82_6
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, 100, 0)

				local var_82_7 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_7.x, var_82_7.y, var_82_7.z)

				local var_82_8 = var_82_0.localEulerAngles

				var_82_8.z = 0
				var_82_8.x = 0
				var_82_0.localEulerAngles = var_82_8
			end

			local var_82_9 = arg_79_1.actors_["1184ui_story"]
			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1184ui_story == nil then
				arg_79_1.var_.characterEffect1184ui_story = var_82_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_11 = 0.200000002980232

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_11 and not isNil(var_82_9) then
				local var_82_12 = (arg_79_1.time_ - var_82_10) / var_82_11

				if arg_79_1.var_.characterEffect1184ui_story and not isNil(var_82_9) then
					local var_82_13 = Mathf.Lerp(0, 0.5, var_82_12)

					arg_79_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1184ui_story.fillRatio = var_82_13
				end
			end

			if arg_79_1.time_ >= var_82_10 + var_82_11 and arg_79_1.time_ < var_82_10 + var_82_11 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1184ui_story then
				local var_82_14 = 0.5

				arg_79_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1184ui_story.fillRatio = var_82_14
			end

			local var_82_15 = 0
			local var_82_16 = 0.7

			if var_82_15 < arg_79_1.time_ and arg_79_1.time_ <= var_82_15 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_17 = arg_79_1:GetWordFromCfg(121511020)
				local var_82_18 = arg_79_1:FormatText(var_82_17.content)

				arg_79_1.text_.text = var_82_18

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_19 = 28
				local var_82_20 = utf8.len(var_82_18)
				local var_82_21 = var_82_19 <= 0 and var_82_16 or var_82_16 * (var_82_20 / var_82_19)

				if var_82_21 > 0 and var_82_16 < var_82_21 then
					arg_79_1.talkMaxDuration = var_82_21

					if var_82_21 + var_82_15 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_21 + var_82_15
					end
				end

				arg_79_1.text_.text = var_82_18
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_22 = math.max(var_82_16, arg_79_1.talkMaxDuration)

			if var_82_15 <= arg_79_1.time_ and arg_79_1.time_ < var_82_15 + var_82_22 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_15) / var_82_22

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_15 + var_82_22 and arg_79_1.time_ < var_82_15 + var_82_22 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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
	Play121511021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 121511021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play121511022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 1.05

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:GetWordFromCfg(121511021)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 42
				local var_86_5 = utf8.len(var_86_3)
				local var_86_6 = var_86_4 <= 0 and var_86_1 or var_86_1 * (var_86_5 / var_86_4)

				if var_86_6 > 0 and var_86_1 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_7 and arg_83_1.time_ < var_86_0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play121511022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 121511022
		arg_87_1.duration_ = 8.87

		local var_87_0 = {
			ja = 8.866,
			ko = 4.4,
			zh = 4.4
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
				arg_87_0:Play121511023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1184ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1184ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(-0.7, -0.97, -6)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1184ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = arg_87_1.actors_["1184ui_story"]
			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect1184ui_story == nil then
				arg_87_1.var_.characterEffect1184ui_story = var_90_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_11 = 0.200000002980232

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_11 and not isNil(var_90_9) then
				local var_90_12 = (arg_87_1.time_ - var_90_10) / var_90_11

				if arg_87_1.var_.characterEffect1184ui_story and not isNil(var_90_9) then
					local var_90_13 = Mathf.Lerp(0, 0.5, var_90_12)

					arg_87_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1184ui_story.fillRatio = var_90_13
				end
			end

			if arg_87_1.time_ >= var_90_10 + var_90_11 and arg_87_1.time_ < var_90_10 + var_90_11 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect1184ui_story then
				local var_90_14 = 0.5

				arg_87_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1184ui_story.fillRatio = var_90_14
			end

			local var_90_15 = arg_87_1.actors_["1075ui_story"].transform
			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1.var_.moveOldPos1075ui_story = var_90_15.localPosition
			end

			local var_90_17 = 0.001

			if var_90_16 <= arg_87_1.time_ and arg_87_1.time_ < var_90_16 + var_90_17 then
				local var_90_18 = (arg_87_1.time_ - var_90_16) / var_90_17
				local var_90_19 = Vector3.New(0.7, -1.055, -6.16)

				var_90_15.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1075ui_story, var_90_19, var_90_18)

				local var_90_20 = manager.ui.mainCamera.transform.position - var_90_15.position

				var_90_15.forward = Vector3.New(var_90_20.x, var_90_20.y, var_90_20.z)

				local var_90_21 = var_90_15.localEulerAngles

				var_90_21.z = 0
				var_90_21.x = 0
				var_90_15.localEulerAngles = var_90_21
			end

			if arg_87_1.time_ >= var_90_16 + var_90_17 and arg_87_1.time_ < var_90_16 + var_90_17 + arg_90_0 then
				var_90_15.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_90_22 = manager.ui.mainCamera.transform.position - var_90_15.position

				var_90_15.forward = Vector3.New(var_90_22.x, var_90_22.y, var_90_22.z)

				local var_90_23 = var_90_15.localEulerAngles

				var_90_23.z = 0
				var_90_23.x = 0
				var_90_15.localEulerAngles = var_90_23
			end

			local var_90_24 = arg_87_1.actors_["1075ui_story"]
			local var_90_25 = 0

			if var_90_25 < arg_87_1.time_ and arg_87_1.time_ <= var_90_25 + arg_90_0 and not isNil(var_90_24) and arg_87_1.var_.characterEffect1075ui_story == nil then
				arg_87_1.var_.characterEffect1075ui_story = var_90_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_26 = 0.200000002980232

			if var_90_25 <= arg_87_1.time_ and arg_87_1.time_ < var_90_25 + var_90_26 and not isNil(var_90_24) then
				local var_90_27 = (arg_87_1.time_ - var_90_25) / var_90_26

				if arg_87_1.var_.characterEffect1075ui_story and not isNil(var_90_24) then
					arg_87_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_25 + var_90_26 and arg_87_1.time_ < var_90_25 + var_90_26 + arg_90_0 and not isNil(var_90_24) and arg_87_1.var_.characterEffect1075ui_story then
				arg_87_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_90_28 = 0

			if var_90_28 < arg_87_1.time_ and arg_87_1.time_ <= var_90_28 + arg_90_0 then
				arg_87_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_90_29 = 0

			if var_90_29 < arg_87_1.time_ and arg_87_1.time_ <= var_90_29 + arg_90_0 then
				arg_87_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_90_30 = 0

			if var_90_30 < arg_87_1.time_ and arg_87_1.time_ <= var_90_30 + arg_90_0 then
				arg_87_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_90_31 = 0
			local var_90_32 = 0.55

			if var_90_31 < arg_87_1.time_ and arg_87_1.time_ <= var_90_31 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_33 = arg_87_1:FormatText(StoryNameCfg[381].name)

				arg_87_1.leftNameTxt_.text = var_90_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_34 = arg_87_1:GetWordFromCfg(121511022)
				local var_90_35 = arg_87_1:FormatText(var_90_34.content)

				arg_87_1.text_.text = var_90_35

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_36 = 22
				local var_90_37 = utf8.len(var_90_35)
				local var_90_38 = var_90_36 <= 0 and var_90_32 or var_90_32 * (var_90_37 / var_90_36)

				if var_90_38 > 0 and var_90_32 < var_90_38 then
					arg_87_1.talkMaxDuration = var_90_38

					if var_90_38 + var_90_31 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_38 + var_90_31
					end
				end

				arg_87_1.text_.text = var_90_35
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511022", "story_v_out_121511.awb") ~= 0 then
					local var_90_39 = manager.audio:GetVoiceLength("story_v_out_121511", "121511022", "story_v_out_121511.awb") / 1000

					if var_90_39 + var_90_31 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_39 + var_90_31
					end

					if var_90_34.prefab_name ~= "" and arg_87_1.actors_[var_90_34.prefab_name] ~= nil then
						local var_90_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_34.prefab_name].transform, "story_v_out_121511", "121511022", "story_v_out_121511.awb")

						arg_87_1:RecordAudio("121511022", var_90_40)
						arg_87_1:RecordAudio("121511022", var_90_40)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_121511", "121511022", "story_v_out_121511.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_121511", "121511022", "story_v_out_121511.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_41 = math.max(var_90_32, arg_87_1.talkMaxDuration)

			if var_90_31 <= arg_87_1.time_ and arg_87_1.time_ < var_90_31 + var_90_41 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_31) / var_90_41

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_31 + var_90_41 and arg_87_1.time_ < var_90_31 + var_90_41 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play121511023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 121511023
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play121511024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1075ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1075ui_story == nil then
				arg_91_1.var_.characterEffect1075ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1075ui_story and not isNil(var_94_0) then
					local var_94_4 = Mathf.Lerp(0, 0.5, var_94_3)

					arg_91_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1075ui_story.fillRatio = var_94_4
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1075ui_story then
				local var_94_5 = 0.5

				arg_91_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1075ui_story.fillRatio = var_94_5
			end

			local var_94_6 = 0
			local var_94_7 = 0.725

			if var_94_6 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_8 = arg_91_1:FormatText(StoryNameCfg[7].name)

				arg_91_1.leftNameTxt_.text = var_94_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_9 = arg_91_1:GetWordFromCfg(121511023)
				local var_94_10 = arg_91_1:FormatText(var_94_9.content)

				arg_91_1.text_.text = var_94_10

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 29
				local var_94_12 = utf8.len(var_94_10)
				local var_94_13 = var_94_11 <= 0 and var_94_7 or var_94_7 * (var_94_12 / var_94_11)

				if var_94_13 > 0 and var_94_7 < var_94_13 then
					arg_91_1.talkMaxDuration = var_94_13

					if var_94_13 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_10
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_14 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_14 and arg_91_1.time_ < var_94_6 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play121511024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 121511024
		arg_95_1.duration_ = 9.3

		local var_95_0 = {
			ja = 9.3,
			ko = 8.4,
			zh = 8.4
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play121511025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1184ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1184ui_story == nil then
				arg_95_1.var_.characterEffect1184ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1184ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1184ui_story then
				arg_95_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_98_4 = 0

			if var_98_4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_98_6 = 0
			local var_98_7 = 1.15

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[6].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_9 = arg_95_1:GetWordFromCfg(121511024)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 46
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511024", "story_v_out_121511.awb") ~= 0 then
					local var_98_14 = manager.audio:GetVoiceLength("story_v_out_121511", "121511024", "story_v_out_121511.awb") / 1000

					if var_98_14 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_6
					end

					if var_98_9.prefab_name ~= "" and arg_95_1.actors_[var_98_9.prefab_name] ~= nil then
						local var_98_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_9.prefab_name].transform, "story_v_out_121511", "121511024", "story_v_out_121511.awb")

						arg_95_1:RecordAudio("121511024", var_98_15)
						arg_95_1:RecordAudio("121511024", var_98_15)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_121511", "121511024", "story_v_out_121511.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_121511", "121511024", "story_v_out_121511.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_16 and arg_95_1.time_ < var_98_6 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play121511025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 121511025
		arg_99_1.duration_ = 7.3

		local var_99_0 = {
			ja = 7.3,
			ko = 6.2,
			zh = 6.2
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play121511026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1075ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1075ui_story == nil then
				arg_99_1.var_.characterEffect1075ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect1075ui_story and not isNil(var_102_0) then
					arg_99_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1075ui_story then
				arg_99_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_102_4 = 0

			if var_102_4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_102_5 = 0

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_6 = arg_99_1.actors_["1184ui_story"]
			local var_102_7 = 0

			if var_102_7 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 and not isNil(var_102_6) and arg_99_1.var_.characterEffect1184ui_story == nil then
				arg_99_1.var_.characterEffect1184ui_story = var_102_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_8 = 0.200000002980232

			if var_102_7 <= arg_99_1.time_ and arg_99_1.time_ < var_102_7 + var_102_8 and not isNil(var_102_6) then
				local var_102_9 = (arg_99_1.time_ - var_102_7) / var_102_8

				if arg_99_1.var_.characterEffect1184ui_story and not isNil(var_102_6) then
					local var_102_10 = Mathf.Lerp(0, 0.5, var_102_9)

					arg_99_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1184ui_story.fillRatio = var_102_10
				end
			end

			if arg_99_1.time_ >= var_102_7 + var_102_8 and arg_99_1.time_ < var_102_7 + var_102_8 + arg_102_0 and not isNil(var_102_6) and arg_99_1.var_.characterEffect1184ui_story then
				local var_102_11 = 0.5

				arg_99_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1184ui_story.fillRatio = var_102_11
			end

			local var_102_12 = 0
			local var_102_13 = 0.675

			if var_102_12 < arg_99_1.time_ and arg_99_1.time_ <= var_102_12 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_14 = arg_99_1:FormatText(StoryNameCfg[381].name)

				arg_99_1.leftNameTxt_.text = var_102_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_15 = arg_99_1:GetWordFromCfg(121511025)
				local var_102_16 = arg_99_1:FormatText(var_102_15.content)

				arg_99_1.text_.text = var_102_16

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_17 = 27
				local var_102_18 = utf8.len(var_102_16)
				local var_102_19 = var_102_17 <= 0 and var_102_13 or var_102_13 * (var_102_18 / var_102_17)

				if var_102_19 > 0 and var_102_13 < var_102_19 then
					arg_99_1.talkMaxDuration = var_102_19

					if var_102_19 + var_102_12 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_19 + var_102_12
					end
				end

				arg_99_1.text_.text = var_102_16
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511025", "story_v_out_121511.awb") ~= 0 then
					local var_102_20 = manager.audio:GetVoiceLength("story_v_out_121511", "121511025", "story_v_out_121511.awb") / 1000

					if var_102_20 + var_102_12 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_20 + var_102_12
					end

					if var_102_15.prefab_name ~= "" and arg_99_1.actors_[var_102_15.prefab_name] ~= nil then
						local var_102_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_15.prefab_name].transform, "story_v_out_121511", "121511025", "story_v_out_121511.awb")

						arg_99_1:RecordAudio("121511025", var_102_21)
						arg_99_1:RecordAudio("121511025", var_102_21)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_121511", "121511025", "story_v_out_121511.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_121511", "121511025", "story_v_out_121511.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_22 = math.max(var_102_13, arg_99_1.talkMaxDuration)

			if var_102_12 <= arg_99_1.time_ and arg_99_1.time_ < var_102_12 + var_102_22 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_12) / var_102_22

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_12 + var_102_22 and arg_99_1.time_ < var_102_12 + var_102_22 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play121511026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 121511026
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play121511027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1075ui_story"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos1075ui_story = var_106_0.localPosition
			end

			local var_106_2 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2
				local var_106_4 = Vector3.New(0, 100, 0)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1075ui_story, var_106_4, var_106_3)

				local var_106_5 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_5.x, var_106_5.y, var_106_5.z)

				local var_106_6 = var_106_0.localEulerAngles

				var_106_6.z = 0
				var_106_6.x = 0
				var_106_0.localEulerAngles = var_106_6
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, 100, 0)

				local var_106_7 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_7.x, var_106_7.y, var_106_7.z)

				local var_106_8 = var_106_0.localEulerAngles

				var_106_8.z = 0
				var_106_8.x = 0
				var_106_0.localEulerAngles = var_106_8
			end

			local var_106_9 = arg_103_1.actors_["1075ui_story"]
			local var_106_10 = 0

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1075ui_story == nil then
				arg_103_1.var_.characterEffect1075ui_story = var_106_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_11 = 0.200000002980232

			if var_106_10 <= arg_103_1.time_ and arg_103_1.time_ < var_106_10 + var_106_11 and not isNil(var_106_9) then
				local var_106_12 = (arg_103_1.time_ - var_106_10) / var_106_11

				if arg_103_1.var_.characterEffect1075ui_story and not isNil(var_106_9) then
					local var_106_13 = Mathf.Lerp(0, 0.5, var_106_12)

					arg_103_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1075ui_story.fillRatio = var_106_13
				end
			end

			if arg_103_1.time_ >= var_106_10 + var_106_11 and arg_103_1.time_ < var_106_10 + var_106_11 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1075ui_story then
				local var_106_14 = 0.5

				arg_103_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1075ui_story.fillRatio = var_106_14
			end

			local var_106_15 = arg_103_1.actors_["1184ui_story"].transform
			local var_106_16 = 0

			if var_106_16 < arg_103_1.time_ and arg_103_1.time_ <= var_106_16 + arg_106_0 then
				arg_103_1.var_.moveOldPos1184ui_story = var_106_15.localPosition
			end

			local var_106_17 = 0.001

			if var_106_16 <= arg_103_1.time_ and arg_103_1.time_ < var_106_16 + var_106_17 then
				local var_106_18 = (arg_103_1.time_ - var_106_16) / var_106_17
				local var_106_19 = Vector3.New(0, 100, 0)

				var_106_15.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1184ui_story, var_106_19, var_106_18)

				local var_106_20 = manager.ui.mainCamera.transform.position - var_106_15.position

				var_106_15.forward = Vector3.New(var_106_20.x, var_106_20.y, var_106_20.z)

				local var_106_21 = var_106_15.localEulerAngles

				var_106_21.z = 0
				var_106_21.x = 0
				var_106_15.localEulerAngles = var_106_21
			end

			if arg_103_1.time_ >= var_106_16 + var_106_17 and arg_103_1.time_ < var_106_16 + var_106_17 + arg_106_0 then
				var_106_15.localPosition = Vector3.New(0, 100, 0)

				local var_106_22 = manager.ui.mainCamera.transform.position - var_106_15.position

				var_106_15.forward = Vector3.New(var_106_22.x, var_106_22.y, var_106_22.z)

				local var_106_23 = var_106_15.localEulerAngles

				var_106_23.z = 0
				var_106_23.x = 0
				var_106_15.localEulerAngles = var_106_23
			end

			local var_106_24 = arg_103_1.actors_["1184ui_story"]
			local var_106_25 = 0

			if var_106_25 < arg_103_1.time_ and arg_103_1.time_ <= var_106_25 + arg_106_0 and not isNil(var_106_24) and arg_103_1.var_.characterEffect1184ui_story == nil then
				arg_103_1.var_.characterEffect1184ui_story = var_106_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_26 = 0.200000002980232

			if var_106_25 <= arg_103_1.time_ and arg_103_1.time_ < var_106_25 + var_106_26 and not isNil(var_106_24) then
				local var_106_27 = (arg_103_1.time_ - var_106_25) / var_106_26

				if arg_103_1.var_.characterEffect1184ui_story and not isNil(var_106_24) then
					local var_106_28 = Mathf.Lerp(0, 0.5, var_106_27)

					arg_103_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1184ui_story.fillRatio = var_106_28
				end
			end

			if arg_103_1.time_ >= var_106_25 + var_106_26 and arg_103_1.time_ < var_106_25 + var_106_26 + arg_106_0 and not isNil(var_106_24) and arg_103_1.var_.characterEffect1184ui_story then
				local var_106_29 = 0.5

				arg_103_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1184ui_story.fillRatio = var_106_29
			end

			local var_106_30 = 0
			local var_106_31 = 1

			if var_106_30 < arg_103_1.time_ and arg_103_1.time_ <= var_106_30 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_32 = arg_103_1:GetWordFromCfg(121511026)
				local var_106_33 = arg_103_1:FormatText(var_106_32.content)

				arg_103_1.text_.text = var_106_33

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_34 = 40
				local var_106_35 = utf8.len(var_106_33)
				local var_106_36 = var_106_34 <= 0 and var_106_31 or var_106_31 * (var_106_35 / var_106_34)

				if var_106_36 > 0 and var_106_31 < var_106_36 then
					arg_103_1.talkMaxDuration = var_106_36

					if var_106_36 + var_106_30 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_36 + var_106_30
					end
				end

				arg_103_1.text_.text = var_106_33
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_37 = math.max(var_106_31, arg_103_1.talkMaxDuration)

			if var_106_30 <= arg_103_1.time_ and arg_103_1.time_ < var_106_30 + var_106_37 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_30) / var_106_37

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_30 + var_106_37 and arg_103_1.time_ < var_106_30 + var_106_37 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play121511027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 121511027
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play121511028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.625

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

				local var_110_2 = arg_107_1:GetWordFromCfg(121511027)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 25
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
	Play121511028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 121511028
		arg_111_1.duration_ = 6.13

		local var_111_0 = {
			ja = 6.133,
			ko = 5.433,
			zh = 5.433
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play121511029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = "10042ui_story"

			if arg_111_1.actors_[var_114_0] == nil then
				local var_114_1 = Asset.Load("Char/" .. "10042ui_story")

				if not isNil(var_114_1) then
					local var_114_2 = Object.Instantiate(Asset.Load("Char/" .. "10042ui_story"), arg_111_1.stage_.transform)

					var_114_2.name = var_114_0
					var_114_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_111_1.actors_[var_114_0] = var_114_2

					local var_114_3 = var_114_2:GetComponentInChildren(typeof(CharacterEffect))

					var_114_3.enabled = true

					local var_114_4 = GameObjectTools.GetOrAddComponent(var_114_2, typeof(DynamicBoneHelper))

					if var_114_4 then
						var_114_4:EnableDynamicBone(false)
					end

					arg_111_1:ShowWeapon(var_114_3.transform, false)

					arg_111_1.var_[var_114_0 .. "Animator"] = var_114_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_111_1.var_[var_114_0 .. "Animator"].applyRootMotion = true
					arg_111_1.var_[var_114_0 .. "LipSync"] = var_114_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_114_5 = arg_111_1.actors_["10042ui_story"].transform
			local var_114_6 = 0

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.var_.moveOldPos10042ui_story = var_114_5.localPosition
			end

			local var_114_7 = 0.001

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_7 then
				local var_114_8 = (arg_111_1.time_ - var_114_6) / var_114_7
				local var_114_9 = Vector3.New(-0.7, -1.12, -6.2)

				var_114_5.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10042ui_story, var_114_9, var_114_8)

				local var_114_10 = manager.ui.mainCamera.transform.position - var_114_5.position

				var_114_5.forward = Vector3.New(var_114_10.x, var_114_10.y, var_114_10.z)

				local var_114_11 = var_114_5.localEulerAngles

				var_114_11.z = 0
				var_114_11.x = 0
				var_114_5.localEulerAngles = var_114_11
			end

			if arg_111_1.time_ >= var_114_6 + var_114_7 and arg_111_1.time_ < var_114_6 + var_114_7 + arg_114_0 then
				var_114_5.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_114_12 = manager.ui.mainCamera.transform.position - var_114_5.position

				var_114_5.forward = Vector3.New(var_114_12.x, var_114_12.y, var_114_12.z)

				local var_114_13 = var_114_5.localEulerAngles

				var_114_13.z = 0
				var_114_13.x = 0
				var_114_5.localEulerAngles = var_114_13
			end

			local var_114_14 = arg_111_1.actors_["10042ui_story"]
			local var_114_15 = 0

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 and not isNil(var_114_14) and arg_111_1.var_.characterEffect10042ui_story == nil then
				arg_111_1.var_.characterEffect10042ui_story = var_114_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_16 = 0.200000002980232

			if var_114_15 <= arg_111_1.time_ and arg_111_1.time_ < var_114_15 + var_114_16 and not isNil(var_114_14) then
				local var_114_17 = (arg_111_1.time_ - var_114_15) / var_114_16

				if arg_111_1.var_.characterEffect10042ui_story and not isNil(var_114_14) then
					arg_111_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_15 + var_114_16 and arg_111_1.time_ < var_114_15 + var_114_16 + arg_114_0 and not isNil(var_114_14) and arg_111_1.var_.characterEffect10042ui_story then
				arg_111_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_114_18 = 0

			if var_114_18 < arg_111_1.time_ and arg_111_1.time_ <= var_114_18 + arg_114_0 then
				arg_111_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action1_1")
			end

			local var_114_19 = 0

			if var_114_19 < arg_111_1.time_ and arg_111_1.time_ <= var_114_19 + arg_114_0 then
				arg_111_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_114_20 = arg_111_1.actors_["1184ui_story"].transform
			local var_114_21 = 0

			if var_114_21 < arg_111_1.time_ and arg_111_1.time_ <= var_114_21 + arg_114_0 then
				arg_111_1.var_.moveOldPos1184ui_story = var_114_20.localPosition
			end

			local var_114_22 = 0.001

			if var_114_21 <= arg_111_1.time_ and arg_111_1.time_ < var_114_21 + var_114_22 then
				local var_114_23 = (arg_111_1.time_ - var_114_21) / var_114_22
				local var_114_24 = Vector3.New(0.7, -0.97, -6)

				var_114_20.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1184ui_story, var_114_24, var_114_23)

				local var_114_25 = manager.ui.mainCamera.transform.position - var_114_20.position

				var_114_20.forward = Vector3.New(var_114_25.x, var_114_25.y, var_114_25.z)

				local var_114_26 = var_114_20.localEulerAngles

				var_114_26.z = 0
				var_114_26.x = 0
				var_114_20.localEulerAngles = var_114_26
			end

			if arg_111_1.time_ >= var_114_21 + var_114_22 and arg_111_1.time_ < var_114_21 + var_114_22 + arg_114_0 then
				var_114_20.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_114_27 = manager.ui.mainCamera.transform.position - var_114_20.position

				var_114_20.forward = Vector3.New(var_114_27.x, var_114_27.y, var_114_27.z)

				local var_114_28 = var_114_20.localEulerAngles

				var_114_28.z = 0
				var_114_28.x = 0
				var_114_20.localEulerAngles = var_114_28
			end

			local var_114_29 = arg_111_1.actors_["1184ui_story"]
			local var_114_30 = 0

			if var_114_30 < arg_111_1.time_ and arg_111_1.time_ <= var_114_30 + arg_114_0 and not isNil(var_114_29) and arg_111_1.var_.characterEffect1184ui_story == nil then
				arg_111_1.var_.characterEffect1184ui_story = var_114_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_31 = 0.200000002980232

			if var_114_30 <= arg_111_1.time_ and arg_111_1.time_ < var_114_30 + var_114_31 and not isNil(var_114_29) then
				local var_114_32 = (arg_111_1.time_ - var_114_30) / var_114_31

				if arg_111_1.var_.characterEffect1184ui_story and not isNil(var_114_29) then
					local var_114_33 = Mathf.Lerp(0, 0.5, var_114_32)

					arg_111_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1184ui_story.fillRatio = var_114_33
				end
			end

			if arg_111_1.time_ >= var_114_30 + var_114_31 and arg_111_1.time_ < var_114_30 + var_114_31 + arg_114_0 and not isNil(var_114_29) and arg_111_1.var_.characterEffect1184ui_story then
				local var_114_34 = 0.5

				arg_111_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1184ui_story.fillRatio = var_114_34
			end

			local var_114_35 = 0

			if var_114_35 < arg_111_1.time_ and arg_111_1.time_ <= var_114_35 + arg_114_0 then
				arg_111_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_114_36 = 0
			local var_114_37 = 0.65

			if var_114_36 < arg_111_1.time_ and arg_111_1.time_ <= var_114_36 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_38 = arg_111_1:FormatText(StoryNameCfg[388].name)

				arg_111_1.leftNameTxt_.text = var_114_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_39 = arg_111_1:GetWordFromCfg(121511028)
				local var_114_40 = arg_111_1:FormatText(var_114_39.content)

				arg_111_1.text_.text = var_114_40

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_41 = 26
				local var_114_42 = utf8.len(var_114_40)
				local var_114_43 = var_114_41 <= 0 and var_114_37 or var_114_37 * (var_114_42 / var_114_41)

				if var_114_43 > 0 and var_114_37 < var_114_43 then
					arg_111_1.talkMaxDuration = var_114_43

					if var_114_43 + var_114_36 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_43 + var_114_36
					end
				end

				arg_111_1.text_.text = var_114_40
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511028", "story_v_out_121511.awb") ~= 0 then
					local var_114_44 = manager.audio:GetVoiceLength("story_v_out_121511", "121511028", "story_v_out_121511.awb") / 1000

					if var_114_44 + var_114_36 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_44 + var_114_36
					end

					if var_114_39.prefab_name ~= "" and arg_111_1.actors_[var_114_39.prefab_name] ~= nil then
						local var_114_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_39.prefab_name].transform, "story_v_out_121511", "121511028", "story_v_out_121511.awb")

						arg_111_1:RecordAudio("121511028", var_114_45)
						arg_111_1:RecordAudio("121511028", var_114_45)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_121511", "121511028", "story_v_out_121511.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_121511", "121511028", "story_v_out_121511.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_46 = math.max(var_114_37, arg_111_1.talkMaxDuration)

			if var_114_36 <= arg_111_1.time_ and arg_111_1.time_ < var_114_36 + var_114_46 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_36) / var_114_46

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_36 + var_114_46 and arg_111_1.time_ < var_114_36 + var_114_46 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play121511029 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 121511029
		arg_115_1.duration_ = 8.67

		local var_115_0 = {
			ja = 8.666,
			ko = 2.9,
			zh = 2.9
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
				arg_115_0:Play121511030(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1184ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1184ui_story == nil then
				arg_115_1.var_.characterEffect1184ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1184ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1184ui_story then
				arg_115_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_118_4 = 0

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_118_5 = arg_115_1.actors_["10042ui_story"]
			local var_118_6 = 0

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.characterEffect10042ui_story == nil then
				arg_115_1.var_.characterEffect10042ui_story = var_118_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_7 = 0.200000002980232

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_7 and not isNil(var_118_5) then
				local var_118_8 = (arg_115_1.time_ - var_118_6) / var_118_7

				if arg_115_1.var_.characterEffect10042ui_story and not isNil(var_118_5) then
					local var_118_9 = Mathf.Lerp(0, 0.5, var_118_8)

					arg_115_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10042ui_story.fillRatio = var_118_9
				end
			end

			if arg_115_1.time_ >= var_118_6 + var_118_7 and arg_115_1.time_ < var_118_6 + var_118_7 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.characterEffect10042ui_story then
				local var_118_10 = 0.5

				arg_115_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10042ui_story.fillRatio = var_118_10
			end

			local var_118_11 = 0
			local var_118_12 = 0.275

			if var_118_11 < arg_115_1.time_ and arg_115_1.time_ <= var_118_11 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_13 = arg_115_1:FormatText(StoryNameCfg[6].name)

				arg_115_1.leftNameTxt_.text = var_118_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_14 = arg_115_1:GetWordFromCfg(121511029)
				local var_118_15 = arg_115_1:FormatText(var_118_14.content)

				arg_115_1.text_.text = var_118_15

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_16 = 11
				local var_118_17 = utf8.len(var_118_15)
				local var_118_18 = var_118_16 <= 0 and var_118_12 or var_118_12 * (var_118_17 / var_118_16)

				if var_118_18 > 0 and var_118_12 < var_118_18 then
					arg_115_1.talkMaxDuration = var_118_18

					if var_118_18 + var_118_11 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_18 + var_118_11
					end
				end

				arg_115_1.text_.text = var_118_15
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511029", "story_v_out_121511.awb") ~= 0 then
					local var_118_19 = manager.audio:GetVoiceLength("story_v_out_121511", "121511029", "story_v_out_121511.awb") / 1000

					if var_118_19 + var_118_11 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_19 + var_118_11
					end

					if var_118_14.prefab_name ~= "" and arg_115_1.actors_[var_118_14.prefab_name] ~= nil then
						local var_118_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_14.prefab_name].transform, "story_v_out_121511", "121511029", "story_v_out_121511.awb")

						arg_115_1:RecordAudio("121511029", var_118_20)
						arg_115_1:RecordAudio("121511029", var_118_20)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_121511", "121511029", "story_v_out_121511.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_121511", "121511029", "story_v_out_121511.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_21 = math.max(var_118_12, arg_115_1.talkMaxDuration)

			if var_118_11 <= arg_115_1.time_ and arg_115_1.time_ < var_118_11 + var_118_21 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_11) / var_118_21

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_11 + var_118_21 and arg_115_1.time_ < var_118_11 + var_118_21 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play121511030 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 121511030
		arg_119_1.duration_ = 6.07

		local var_119_0 = {
			ja = 3.733,
			ko = 6.066,
			zh = 6.066
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
				arg_119_0:Play121511031(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10042ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10042ui_story == nil then
				arg_119_1.var_.characterEffect10042ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect10042ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10042ui_story then
				arg_119_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_122_4 = arg_119_1.actors_["1184ui_story"]
			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect1184ui_story == nil then
				arg_119_1.var_.characterEffect1184ui_story = var_122_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.200000002980232

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_6 and not isNil(var_122_4) then
				local var_122_7 = (arg_119_1.time_ - var_122_5) / var_122_6

				if arg_119_1.var_.characterEffect1184ui_story and not isNil(var_122_4) then
					local var_122_8 = Mathf.Lerp(0, 0.5, var_122_7)

					arg_119_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1184ui_story.fillRatio = var_122_8
				end
			end

			if arg_119_1.time_ >= var_122_5 + var_122_6 and arg_119_1.time_ < var_122_5 + var_122_6 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect1184ui_story then
				local var_122_9 = 0.5

				arg_119_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1184ui_story.fillRatio = var_122_9
			end

			local var_122_10 = 0
			local var_122_11 = 0.675

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_12 = arg_119_1:FormatText(StoryNameCfg[388].name)

				arg_119_1.leftNameTxt_.text = var_122_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_13 = arg_119_1:GetWordFromCfg(121511030)
				local var_122_14 = arg_119_1:FormatText(var_122_13.content)

				arg_119_1.text_.text = var_122_14

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_15 = 27
				local var_122_16 = utf8.len(var_122_14)
				local var_122_17 = var_122_15 <= 0 and var_122_11 or var_122_11 * (var_122_16 / var_122_15)

				if var_122_17 > 0 and var_122_11 < var_122_17 then
					arg_119_1.talkMaxDuration = var_122_17

					if var_122_17 + var_122_10 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_17 + var_122_10
					end
				end

				arg_119_1.text_.text = var_122_14
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511030", "story_v_out_121511.awb") ~= 0 then
					local var_122_18 = manager.audio:GetVoiceLength("story_v_out_121511", "121511030", "story_v_out_121511.awb") / 1000

					if var_122_18 + var_122_10 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_18 + var_122_10
					end

					if var_122_13.prefab_name ~= "" and arg_119_1.actors_[var_122_13.prefab_name] ~= nil then
						local var_122_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_13.prefab_name].transform, "story_v_out_121511", "121511030", "story_v_out_121511.awb")

						arg_119_1:RecordAudio("121511030", var_122_19)
						arg_119_1:RecordAudio("121511030", var_122_19)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_121511", "121511030", "story_v_out_121511.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_121511", "121511030", "story_v_out_121511.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_20 = math.max(var_122_11, arg_119_1.talkMaxDuration)

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_20 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_10) / var_122_20

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_10 + var_122_20 and arg_119_1.time_ < var_122_10 + var_122_20 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play121511031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 121511031
		arg_123_1.duration_ = 2.03

		local var_123_0 = {
			ja = 1.999999999999,
			ko = 2.033,
			zh = 2.033
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
				arg_123_0:Play121511032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1184ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1184ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0, 100, 0)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1184ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, 100, 0)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["1184ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1184ui_story == nil then
				arg_123_1.var_.characterEffect1184ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect1184ui_story and not isNil(var_126_9) then
					local var_126_13 = Mathf.Lerp(0, 0.5, var_126_12)

					arg_123_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1184ui_story.fillRatio = var_126_13
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1184ui_story then
				local var_126_14 = 0.5

				arg_123_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1184ui_story.fillRatio = var_126_14
			end

			local var_126_15 = arg_123_1.actors_["1075ui_story"].transform
			local var_126_16 = 0

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.var_.moveOldPos1075ui_story = var_126_15.localPosition
			end

			local var_126_17 = 0.001

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 then
				local var_126_18 = (arg_123_1.time_ - var_126_16) / var_126_17
				local var_126_19 = Vector3.New(0.7, -1.055, -6.16)

				var_126_15.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1075ui_story, var_126_19, var_126_18)

				local var_126_20 = manager.ui.mainCamera.transform.position - var_126_15.position

				var_126_15.forward = Vector3.New(var_126_20.x, var_126_20.y, var_126_20.z)

				local var_126_21 = var_126_15.localEulerAngles

				var_126_21.z = 0
				var_126_21.x = 0
				var_126_15.localEulerAngles = var_126_21
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 then
				var_126_15.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_126_22 = manager.ui.mainCamera.transform.position - var_126_15.position

				var_126_15.forward = Vector3.New(var_126_22.x, var_126_22.y, var_126_22.z)

				local var_126_23 = var_126_15.localEulerAngles

				var_126_23.z = 0
				var_126_23.x = 0
				var_126_15.localEulerAngles = var_126_23
			end

			local var_126_24 = arg_123_1.actors_["1075ui_story"]
			local var_126_25 = 0

			if var_126_25 < arg_123_1.time_ and arg_123_1.time_ <= var_126_25 + arg_126_0 and not isNil(var_126_24) and arg_123_1.var_.characterEffect1075ui_story == nil then
				arg_123_1.var_.characterEffect1075ui_story = var_126_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_26 = 0.200000002980232

			if var_126_25 <= arg_123_1.time_ and arg_123_1.time_ < var_126_25 + var_126_26 and not isNil(var_126_24) then
				local var_126_27 = (arg_123_1.time_ - var_126_25) / var_126_26

				if arg_123_1.var_.characterEffect1075ui_story and not isNil(var_126_24) then
					arg_123_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_25 + var_126_26 and arg_123_1.time_ < var_126_25 + var_126_26 + arg_126_0 and not isNil(var_126_24) and arg_123_1.var_.characterEffect1075ui_story then
				arg_123_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_126_28 = 0

			if var_126_28 < arg_123_1.time_ and arg_123_1.time_ <= var_126_28 + arg_126_0 then
				arg_123_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_126_29 = 0

			if var_126_29 < arg_123_1.time_ and arg_123_1.time_ <= var_126_29 + arg_126_0 then
				arg_123_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_126_30 = arg_123_1.actors_["10042ui_story"]
			local var_126_31 = 0

			if var_126_31 < arg_123_1.time_ and arg_123_1.time_ <= var_126_31 + arg_126_0 and not isNil(var_126_30) and arg_123_1.var_.characterEffect10042ui_story == nil then
				arg_123_1.var_.characterEffect10042ui_story = var_126_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_32 = 0.200000002980232

			if var_126_31 <= arg_123_1.time_ and arg_123_1.time_ < var_126_31 + var_126_32 and not isNil(var_126_30) then
				local var_126_33 = (arg_123_1.time_ - var_126_31) / var_126_32

				if arg_123_1.var_.characterEffect10042ui_story and not isNil(var_126_30) then
					local var_126_34 = Mathf.Lerp(0, 0.5, var_126_33)

					arg_123_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10042ui_story.fillRatio = var_126_34
				end
			end

			if arg_123_1.time_ >= var_126_31 + var_126_32 and arg_123_1.time_ < var_126_31 + var_126_32 + arg_126_0 and not isNil(var_126_30) and arg_123_1.var_.characterEffect10042ui_story then
				local var_126_35 = 0.5

				arg_123_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10042ui_story.fillRatio = var_126_35
			end

			local var_126_36 = 0
			local var_126_37 = 0.25

			if var_126_36 < arg_123_1.time_ and arg_123_1.time_ <= var_126_36 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_38 = arg_123_1:FormatText(StoryNameCfg[381].name)

				arg_123_1.leftNameTxt_.text = var_126_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_39 = arg_123_1:GetWordFromCfg(121511031)
				local var_126_40 = arg_123_1:FormatText(var_126_39.content)

				arg_123_1.text_.text = var_126_40

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_41 = 10
				local var_126_42 = utf8.len(var_126_40)
				local var_126_43 = var_126_41 <= 0 and var_126_37 or var_126_37 * (var_126_42 / var_126_41)

				if var_126_43 > 0 and var_126_37 < var_126_43 then
					arg_123_1.talkMaxDuration = var_126_43

					if var_126_43 + var_126_36 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_43 + var_126_36
					end
				end

				arg_123_1.text_.text = var_126_40
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511031", "story_v_out_121511.awb") ~= 0 then
					local var_126_44 = manager.audio:GetVoiceLength("story_v_out_121511", "121511031", "story_v_out_121511.awb") / 1000

					if var_126_44 + var_126_36 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_44 + var_126_36
					end

					if var_126_39.prefab_name ~= "" and arg_123_1.actors_[var_126_39.prefab_name] ~= nil then
						local var_126_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_39.prefab_name].transform, "story_v_out_121511", "121511031", "story_v_out_121511.awb")

						arg_123_1:RecordAudio("121511031", var_126_45)
						arg_123_1:RecordAudio("121511031", var_126_45)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_121511", "121511031", "story_v_out_121511.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_121511", "121511031", "story_v_out_121511.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_46 = math.max(var_126_37, arg_123_1.talkMaxDuration)

			if var_126_36 <= arg_123_1.time_ and arg_123_1.time_ < var_126_36 + var_126_46 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_36) / var_126_46

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_36 + var_126_46 and arg_123_1.time_ < var_126_36 + var_126_46 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play121511032 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 121511032
		arg_127_1.duration_ = 7.47

		local var_127_0 = {
			ja = 6.166,
			ko = 7.466,
			zh = 7.466
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
				arg_127_0:Play121511033(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10042ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10042ui_story == nil then
				arg_127_1.var_.characterEffect10042ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect10042ui_story and not isNil(var_130_0) then
					arg_127_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10042ui_story then
				arg_127_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_130_4 = 0

			if var_130_4 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action3_1")
			end

			local var_130_5 = 0

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_6 = arg_127_1.actors_["1075ui_story"]
			local var_130_7 = 0

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1075ui_story == nil then
				arg_127_1.var_.characterEffect1075ui_story = var_130_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_8 = 0.200000002980232

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_8 and not isNil(var_130_6) then
				local var_130_9 = (arg_127_1.time_ - var_130_7) / var_130_8

				if arg_127_1.var_.characterEffect1075ui_story and not isNil(var_130_6) then
					local var_130_10 = Mathf.Lerp(0, 0.5, var_130_9)

					arg_127_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1075ui_story.fillRatio = var_130_10
				end
			end

			if arg_127_1.time_ >= var_130_7 + var_130_8 and arg_127_1.time_ < var_130_7 + var_130_8 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1075ui_story then
				local var_130_11 = 0.5

				arg_127_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1075ui_story.fillRatio = var_130_11
			end

			local var_130_12 = 0
			local var_130_13 = 0.65

			if var_130_12 < arg_127_1.time_ and arg_127_1.time_ <= var_130_12 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_14 = arg_127_1:FormatText(StoryNameCfg[388].name)

				arg_127_1.leftNameTxt_.text = var_130_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_15 = arg_127_1:GetWordFromCfg(121511032)
				local var_130_16 = arg_127_1:FormatText(var_130_15.content)

				arg_127_1.text_.text = var_130_16

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_17 = 26
				local var_130_18 = utf8.len(var_130_16)
				local var_130_19 = var_130_17 <= 0 and var_130_13 or var_130_13 * (var_130_18 / var_130_17)

				if var_130_19 > 0 and var_130_13 < var_130_19 then
					arg_127_1.talkMaxDuration = var_130_19

					if var_130_19 + var_130_12 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_19 + var_130_12
					end
				end

				arg_127_1.text_.text = var_130_16
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511032", "story_v_out_121511.awb") ~= 0 then
					local var_130_20 = manager.audio:GetVoiceLength("story_v_out_121511", "121511032", "story_v_out_121511.awb") / 1000

					if var_130_20 + var_130_12 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_20 + var_130_12
					end

					if var_130_15.prefab_name ~= "" and arg_127_1.actors_[var_130_15.prefab_name] ~= nil then
						local var_130_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_15.prefab_name].transform, "story_v_out_121511", "121511032", "story_v_out_121511.awb")

						arg_127_1:RecordAudio("121511032", var_130_21)
						arg_127_1:RecordAudio("121511032", var_130_21)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_121511", "121511032", "story_v_out_121511.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_121511", "121511032", "story_v_out_121511.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_22 = math.max(var_130_13, arg_127_1.talkMaxDuration)

			if var_130_12 <= arg_127_1.time_ and arg_127_1.time_ < var_130_12 + var_130_22 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_12) / var_130_22

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_12 + var_130_22 and arg_127_1.time_ < var_130_12 + var_130_22 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play121511033 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 121511033
		arg_131_1.duration_ = 5.8

		local var_131_0 = {
			ja = 5.8,
			ko = 3.733,
			zh = 3.733
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play121511034(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1075ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1075ui_story == nil then
				arg_131_1.var_.characterEffect1075ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1075ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1075ui_story then
				arg_131_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_134_4 = 0

			if var_134_4 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_134_5 = 0

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_6 = arg_131_1.actors_["10042ui_story"]
			local var_134_7 = 0

			if var_134_7 < arg_131_1.time_ and arg_131_1.time_ <= var_134_7 + arg_134_0 and not isNil(var_134_6) and arg_131_1.var_.characterEffect10042ui_story == nil then
				arg_131_1.var_.characterEffect10042ui_story = var_134_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_8 = 0.200000002980232

			if var_134_7 <= arg_131_1.time_ and arg_131_1.time_ < var_134_7 + var_134_8 and not isNil(var_134_6) then
				local var_134_9 = (arg_131_1.time_ - var_134_7) / var_134_8

				if arg_131_1.var_.characterEffect10042ui_story and not isNil(var_134_6) then
					local var_134_10 = Mathf.Lerp(0, 0.5, var_134_9)

					arg_131_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10042ui_story.fillRatio = var_134_10
				end
			end

			if arg_131_1.time_ >= var_134_7 + var_134_8 and arg_131_1.time_ < var_134_7 + var_134_8 + arg_134_0 and not isNil(var_134_6) and arg_131_1.var_.characterEffect10042ui_story then
				local var_134_11 = 0.5

				arg_131_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10042ui_story.fillRatio = var_134_11
			end

			local var_134_12 = 0
			local var_134_13 = 0.45

			if var_134_12 < arg_131_1.time_ and arg_131_1.time_ <= var_134_12 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_14 = arg_131_1:FormatText(StoryNameCfg[381].name)

				arg_131_1.leftNameTxt_.text = var_134_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_15 = arg_131_1:GetWordFromCfg(121511033)
				local var_134_16 = arg_131_1:FormatText(var_134_15.content)

				arg_131_1.text_.text = var_134_16

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_17 = 18
				local var_134_18 = utf8.len(var_134_16)
				local var_134_19 = var_134_17 <= 0 and var_134_13 or var_134_13 * (var_134_18 / var_134_17)

				if var_134_19 > 0 and var_134_13 < var_134_19 then
					arg_131_1.talkMaxDuration = var_134_19

					if var_134_19 + var_134_12 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_19 + var_134_12
					end
				end

				arg_131_1.text_.text = var_134_16
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511033", "story_v_out_121511.awb") ~= 0 then
					local var_134_20 = manager.audio:GetVoiceLength("story_v_out_121511", "121511033", "story_v_out_121511.awb") / 1000

					if var_134_20 + var_134_12 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_20 + var_134_12
					end

					if var_134_15.prefab_name ~= "" and arg_131_1.actors_[var_134_15.prefab_name] ~= nil then
						local var_134_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_15.prefab_name].transform, "story_v_out_121511", "121511033", "story_v_out_121511.awb")

						arg_131_1:RecordAudio("121511033", var_134_21)
						arg_131_1:RecordAudio("121511033", var_134_21)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_121511", "121511033", "story_v_out_121511.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_121511", "121511033", "story_v_out_121511.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_22 = math.max(var_134_13, arg_131_1.talkMaxDuration)

			if var_134_12 <= arg_131_1.time_ and arg_131_1.time_ < var_134_12 + var_134_22 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_12) / var_134_22

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_12 + var_134_22 and arg_131_1.time_ < var_134_12 + var_134_22 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play121511034 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 121511034
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play121511035(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1075ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1075ui_story == nil then
				arg_135_1.var_.characterEffect1075ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1075ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1075ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1075ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1075ui_story.fillRatio = var_138_5
			end

			local var_138_6 = 0
			local var_138_7 = 0.633333333333333

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				local var_138_8 = "play"
				local var_138_9 = "effect"

				arg_135_1:AudioAction(var_138_8, var_138_9, "se_story_121_04", "se_story_121_04_scan", "")
			end

			local var_138_10 = 0
			local var_138_11 = 1.4

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_12 = arg_135_1:GetWordFromCfg(121511034)
				local var_138_13 = arg_135_1:FormatText(var_138_12.content)

				arg_135_1.text_.text = var_138_13

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_14 = 56
				local var_138_15 = utf8.len(var_138_13)
				local var_138_16 = var_138_14 <= 0 and var_138_11 or var_138_11 * (var_138_15 / var_138_14)

				if var_138_16 > 0 and var_138_11 < var_138_16 then
					arg_135_1.talkMaxDuration = var_138_16

					if var_138_16 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_10
					end
				end

				arg_135_1.text_.text = var_138_13
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_17 = math.max(var_138_11, arg_135_1.talkMaxDuration)

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_17 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_10) / var_138_17

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_10 + var_138_17 and arg_135_1.time_ < var_138_10 + var_138_17 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play121511035 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 121511035
		arg_139_1.duration_ = 10.73

		local var_139_0 = {
			ja = 10.733,
			ko = 8.233,
			zh = 8.233
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
				arg_139_0:Play121511036(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10042ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10042ui_story == nil then
				arg_139_1.var_.characterEffect10042ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect10042ui_story and not isNil(var_142_0) then
					arg_139_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10042ui_story then
				arg_139_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_142_4 = 0

			if var_142_4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action3_2")
			end

			local var_142_5 = 0

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_6 = 0

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_142_7 = 0
			local var_142_8 = 1.125

			if var_142_7 < arg_139_1.time_ and arg_139_1.time_ <= var_142_7 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_9 = arg_139_1:FormatText(StoryNameCfg[388].name)

				arg_139_1.leftNameTxt_.text = var_142_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(121511035)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_12 = 45
				local var_142_13 = utf8.len(var_142_11)
				local var_142_14 = var_142_12 <= 0 and var_142_8 or var_142_8 * (var_142_13 / var_142_12)

				if var_142_14 > 0 and var_142_8 < var_142_14 then
					arg_139_1.talkMaxDuration = var_142_14

					if var_142_14 + var_142_7 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_7
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511035", "story_v_out_121511.awb") ~= 0 then
					local var_142_15 = manager.audio:GetVoiceLength("story_v_out_121511", "121511035", "story_v_out_121511.awb") / 1000

					if var_142_15 + var_142_7 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_15 + var_142_7
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_121511", "121511035", "story_v_out_121511.awb")

						arg_139_1:RecordAudio("121511035", var_142_16)
						arg_139_1:RecordAudio("121511035", var_142_16)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_121511", "121511035", "story_v_out_121511.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_121511", "121511035", "story_v_out_121511.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_17 = math.max(var_142_8, arg_139_1.talkMaxDuration)

			if var_142_7 <= arg_139_1.time_ and arg_139_1.time_ < var_142_7 + var_142_17 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_7) / var_142_17

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_7 + var_142_17 and arg_139_1.time_ < var_142_7 + var_142_17 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play121511036 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 121511036
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play121511037(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10042ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10042ui_story == nil then
				arg_143_1.var_.characterEffect10042ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect10042ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10042ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10042ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10042ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0
			local var_146_7 = 0.325

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_8 = arg_143_1:FormatText(StoryNameCfg[7].name)

				arg_143_1.leftNameTxt_.text = var_146_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_9 = arg_143_1:GetWordFromCfg(121511036)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 13
				local var_146_12 = utf8.len(var_146_10)
				local var_146_13 = var_146_11 <= 0 and var_146_7 or var_146_7 * (var_146_12 / var_146_11)

				if var_146_13 > 0 and var_146_7 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_10
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_14 and arg_143_1.time_ < var_146_6 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play121511037 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 121511037
		arg_147_1.duration_ = 6.63

		local var_147_0 = {
			ja = 6.633,
			ko = 3.2,
			zh = 3.2
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
				arg_147_0:Play121511038(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10042ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10042ui_story == nil then
				arg_147_1.var_.characterEffect10042ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect10042ui_story and not isNil(var_150_0) then
					arg_147_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10042ui_story then
				arg_147_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_150_4 = 0
			local var_150_5 = 0.4

			if var_150_4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_6 = arg_147_1:FormatText(StoryNameCfg[388].name)

				arg_147_1.leftNameTxt_.text = var_150_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_7 = arg_147_1:GetWordFromCfg(121511037)
				local var_150_8 = arg_147_1:FormatText(var_150_7.content)

				arg_147_1.text_.text = var_150_8

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 16
				local var_150_10 = utf8.len(var_150_8)
				local var_150_11 = var_150_9 <= 0 and var_150_5 or var_150_5 * (var_150_10 / var_150_9)

				if var_150_11 > 0 and var_150_5 < var_150_11 then
					arg_147_1.talkMaxDuration = var_150_11

					if var_150_11 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_8
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511037", "story_v_out_121511.awb") ~= 0 then
					local var_150_12 = manager.audio:GetVoiceLength("story_v_out_121511", "121511037", "story_v_out_121511.awb") / 1000

					if var_150_12 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_4
					end

					if var_150_7.prefab_name ~= "" and arg_147_1.actors_[var_150_7.prefab_name] ~= nil then
						local var_150_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_7.prefab_name].transform, "story_v_out_121511", "121511037", "story_v_out_121511.awb")

						arg_147_1:RecordAudio("121511037", var_150_13)
						arg_147_1:RecordAudio("121511037", var_150_13)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_121511", "121511037", "story_v_out_121511.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_121511", "121511037", "story_v_out_121511.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_14 and arg_147_1.time_ < var_150_4 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play121511038 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 121511038
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play121511039(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10042ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10042ui_story == nil then
				arg_151_1.var_.characterEffect10042ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect10042ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10042ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10042ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10042ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.725

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[7].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(121511038)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 29
				local var_154_12 = utf8.len(var_154_10)
				local var_154_13 = var_154_11 <= 0 and var_154_7 or var_154_7 * (var_154_12 / var_154_11)

				if var_154_13 > 0 and var_154_7 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_10
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_14 and arg_151_1.time_ < var_154_6 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play121511039 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 121511039
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play121511040(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1.325

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[7].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(121511039)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 53
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
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_8 and arg_155_1.time_ < var_158_0 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play121511040 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 121511040
		arg_159_1.duration_ = 6.33

		local var_159_0 = {
			ja = 6.333,
			ko = 4.033,
			zh = 4.033
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
				arg_159_0:Play121511041(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10042ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10042ui_story == nil then
				arg_159_1.var_.characterEffect10042ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect10042ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10042ui_story then
				arg_159_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_162_4 = 0
			local var_162_5 = 0.5

			if var_162_4 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_6 = arg_159_1:FormatText(StoryNameCfg[388].name)

				arg_159_1.leftNameTxt_.text = var_162_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_7 = arg_159_1:GetWordFromCfg(121511040)
				local var_162_8 = arg_159_1:FormatText(var_162_7.content)

				arg_159_1.text_.text = var_162_8

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 20
				local var_162_10 = utf8.len(var_162_8)
				local var_162_11 = var_162_9 <= 0 and var_162_5 or var_162_5 * (var_162_10 / var_162_9)

				if var_162_11 > 0 and var_162_5 < var_162_11 then
					arg_159_1.talkMaxDuration = var_162_11

					if var_162_11 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_8
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511040", "story_v_out_121511.awb") ~= 0 then
					local var_162_12 = manager.audio:GetVoiceLength("story_v_out_121511", "121511040", "story_v_out_121511.awb") / 1000

					if var_162_12 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_4
					end

					if var_162_7.prefab_name ~= "" and arg_159_1.actors_[var_162_7.prefab_name] ~= nil then
						local var_162_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_7.prefab_name].transform, "story_v_out_121511", "121511040", "story_v_out_121511.awb")

						arg_159_1:RecordAudio("121511040", var_162_13)
						arg_159_1:RecordAudio("121511040", var_162_13)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_121511", "121511040", "story_v_out_121511.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_121511", "121511040", "story_v_out_121511.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_14 and arg_159_1.time_ < var_162_4 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play121511041 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 121511041
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play121511042(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10042ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10042ui_story == nil then
				arg_163_1.var_.characterEffect10042ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect10042ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_163_1.var_.characterEffect10042ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10042ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_163_1.var_.characterEffect10042ui_story.fillRatio = var_166_5
			end

			local var_166_6 = 0
			local var_166_7 = 0.9

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_8 = arg_163_1:FormatText(StoryNameCfg[7].name)

				arg_163_1.leftNameTxt_.text = var_166_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_9 = arg_163_1:GetWordFromCfg(121511041)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 36
				local var_166_12 = utf8.len(var_166_10)
				local var_166_13 = var_166_11 <= 0 and var_166_7 or var_166_7 * (var_166_12 / var_166_11)

				if var_166_13 > 0 and var_166_7 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_10
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play121511042 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 121511042
		arg_167_1.duration_ = 4.33

		local var_167_0 = {
			ja = 3.633,
			ko = 4.333,
			zh = 4.333
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play121511043(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10042ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10042ui_story == nil then
				arg_167_1.var_.characterEffect10042ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect10042ui_story and not isNil(var_170_0) then
					arg_167_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10042ui_story then
				arg_167_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_170_4 = 0
			local var_170_5 = 0.375

			if var_170_4 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_6 = arg_167_1:FormatText(StoryNameCfg[388].name)

				arg_167_1.leftNameTxt_.text = var_170_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:GetWordFromCfg(121511042)
				local var_170_8 = arg_167_1:FormatText(var_170_7.content)

				arg_167_1.text_.text = var_170_8

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 15
				local var_170_10 = utf8.len(var_170_8)
				local var_170_11 = var_170_9 <= 0 and var_170_5 or var_170_5 * (var_170_10 / var_170_9)

				if var_170_11 > 0 and var_170_5 < var_170_11 then
					arg_167_1.talkMaxDuration = var_170_11

					if var_170_11 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_8
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511042", "story_v_out_121511.awb") ~= 0 then
					local var_170_12 = manager.audio:GetVoiceLength("story_v_out_121511", "121511042", "story_v_out_121511.awb") / 1000

					if var_170_12 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_12 + var_170_4
					end

					if var_170_7.prefab_name ~= "" and arg_167_1.actors_[var_170_7.prefab_name] ~= nil then
						local var_170_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_7.prefab_name].transform, "story_v_out_121511", "121511042", "story_v_out_121511.awb")

						arg_167_1:RecordAudio("121511042", var_170_13)
						arg_167_1:RecordAudio("121511042", var_170_13)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_121511", "121511042", "story_v_out_121511.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_121511", "121511042", "story_v_out_121511.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_14 and arg_167_1.time_ < var_170_4 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play121511043 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 121511043
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play121511044(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10042ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10042ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0, 100, 0)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10042ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, 100, 0)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["10042ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10042ui_story == nil then
				arg_171_1.var_.characterEffect10042ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect10042ui_story and not isNil(var_174_9) then
					local var_174_13 = Mathf.Lerp(0, 0.5, var_174_12)

					arg_171_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10042ui_story.fillRatio = var_174_13
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10042ui_story then
				local var_174_14 = 0.5

				arg_171_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10042ui_story.fillRatio = var_174_14
			end

			local var_174_15 = arg_171_1.actors_["1075ui_story"].transform
			local var_174_16 = 0

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.var_.moveOldPos1075ui_story = var_174_15.localPosition
			end

			local var_174_17 = 0.001

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_17 then
				local var_174_18 = (arg_171_1.time_ - var_174_16) / var_174_17
				local var_174_19 = Vector3.New(0, 100, 0)

				var_174_15.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1075ui_story, var_174_19, var_174_18)

				local var_174_20 = manager.ui.mainCamera.transform.position - var_174_15.position

				var_174_15.forward = Vector3.New(var_174_20.x, var_174_20.y, var_174_20.z)

				local var_174_21 = var_174_15.localEulerAngles

				var_174_21.z = 0
				var_174_21.x = 0
				var_174_15.localEulerAngles = var_174_21
			end

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 then
				var_174_15.localPosition = Vector3.New(0, 100, 0)

				local var_174_22 = manager.ui.mainCamera.transform.position - var_174_15.position

				var_174_15.forward = Vector3.New(var_174_22.x, var_174_22.y, var_174_22.z)

				local var_174_23 = var_174_15.localEulerAngles

				var_174_23.z = 0
				var_174_23.x = 0
				var_174_15.localEulerAngles = var_174_23
			end

			local var_174_24 = 0
			local var_174_25 = 0.45

			if var_174_24 < arg_171_1.time_ and arg_171_1.time_ <= var_174_24 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_26 = arg_171_1:FormatText(StoryNameCfg[7].name)

				arg_171_1.leftNameTxt_.text = var_174_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_27 = arg_171_1:GetWordFromCfg(121511043)
				local var_174_28 = arg_171_1:FormatText(var_174_27.content)

				arg_171_1.text_.text = var_174_28

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_29 = 18
				local var_174_30 = utf8.len(var_174_28)
				local var_174_31 = var_174_29 <= 0 and var_174_25 or var_174_25 * (var_174_30 / var_174_29)

				if var_174_31 > 0 and var_174_25 < var_174_31 then
					arg_171_1.talkMaxDuration = var_174_31

					if var_174_31 + var_174_24 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_31 + var_174_24
					end
				end

				arg_171_1.text_.text = var_174_28
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_32 = math.max(var_174_25, arg_171_1.talkMaxDuration)

			if var_174_24 <= arg_171_1.time_ and arg_171_1.time_ < var_174_24 + var_174_32 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_24) / var_174_32

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_24 + var_174_32 and arg_171_1.time_ < var_174_24 + var_174_32 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play121511044 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 121511044
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play121511045(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 1.225

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_2 = arg_175_1:GetWordFromCfg(121511044)
				local var_178_3 = arg_175_1:FormatText(var_178_2.content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 49
				local var_178_5 = utf8.len(var_178_3)
				local var_178_6 = var_178_4 <= 0 and var_178_1 or var_178_1 * (var_178_5 / var_178_4)

				if var_178_6 > 0 and var_178_1 < var_178_6 then
					arg_175_1.talkMaxDuration = var_178_6

					if var_178_6 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_7 and arg_175_1.time_ < var_178_0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play121511045 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 121511045
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play121511046(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.775

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(121511045)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 31
				local var_182_5 = utf8.len(var_182_3)
				local var_182_6 = var_182_4 <= 0 and var_182_1 or var_182_1 * (var_182_5 / var_182_4)

				if var_182_6 > 0 and var_182_1 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_7 and arg_179_1.time_ < var_182_0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play121511046 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 121511046
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play121511047(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.125

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[7].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(121511046)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 5
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_8 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_8 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_8

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_8 and arg_183_1.time_ < var_186_0 + var_186_8 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play121511047 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 121511047
		arg_187_1.duration_ = 8.8

		local var_187_0 = {
			ja = 8.8,
			ko = 8.633,
			zh = 8.633
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play121511048(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1184ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos1184ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(0, -0.97, -6)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1184ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = arg_187_1.actors_["1184ui_story"]
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect1184ui_story == nil then
				arg_187_1.var_.characterEffect1184ui_story = var_190_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_11 = 0.200000002980232

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 and not isNil(var_190_9) then
				local var_190_12 = (arg_187_1.time_ - var_190_10) / var_190_11

				if arg_187_1.var_.characterEffect1184ui_story and not isNil(var_190_9) then
					arg_187_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect1184ui_story then
				arg_187_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_190_13 = 0

			if var_190_13 < arg_187_1.time_ and arg_187_1.time_ <= var_190_13 + arg_190_0 then
				arg_187_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_190_14 = 0

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				arg_187_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_190_15 = 0
			local var_190_16 = 0.9

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_17 = arg_187_1:FormatText(StoryNameCfg[6].name)

				arg_187_1.leftNameTxt_.text = var_190_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_18 = arg_187_1:GetWordFromCfg(121511047)
				local var_190_19 = arg_187_1:FormatText(var_190_18.content)

				arg_187_1.text_.text = var_190_19

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_20 = 36
				local var_190_21 = utf8.len(var_190_19)
				local var_190_22 = var_190_20 <= 0 and var_190_16 or var_190_16 * (var_190_21 / var_190_20)

				if var_190_22 > 0 and var_190_16 < var_190_22 then
					arg_187_1.talkMaxDuration = var_190_22

					if var_190_22 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_22 + var_190_15
					end
				end

				arg_187_1.text_.text = var_190_19
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511047", "story_v_out_121511.awb") ~= 0 then
					local var_190_23 = manager.audio:GetVoiceLength("story_v_out_121511", "121511047", "story_v_out_121511.awb") / 1000

					if var_190_23 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_23 + var_190_15
					end

					if var_190_18.prefab_name ~= "" and arg_187_1.actors_[var_190_18.prefab_name] ~= nil then
						local var_190_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_18.prefab_name].transform, "story_v_out_121511", "121511047", "story_v_out_121511.awb")

						arg_187_1:RecordAudio("121511047", var_190_24)
						arg_187_1:RecordAudio("121511047", var_190_24)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_121511", "121511047", "story_v_out_121511.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_121511", "121511047", "story_v_out_121511.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_25 = math.max(var_190_16, arg_187_1.talkMaxDuration)

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_25 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_15) / var_190_25

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_15 + var_190_25 and arg_187_1.time_ < var_190_15 + var_190_25 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play121511048 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 121511048
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play121511049(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1184ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos1184ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0, 100, 0)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1184ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, 100, 0)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["1184ui_story"]
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1184ui_story == nil then
				arg_191_1.var_.characterEffect1184ui_story = var_194_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_11 = 0.200000002980232

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 and not isNil(var_194_9) then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / var_194_11

				if arg_191_1.var_.characterEffect1184ui_story and not isNil(var_194_9) then
					local var_194_13 = Mathf.Lerp(0, 0.5, var_194_12)

					arg_191_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1184ui_story.fillRatio = var_194_13
				end
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1184ui_story then
				local var_194_14 = 0.5

				arg_191_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1184ui_story.fillRatio = var_194_14
			end

			local var_194_15 = 0
			local var_194_16 = 1.25

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_17 = arg_191_1:GetWordFromCfg(121511048)
				local var_194_18 = arg_191_1:FormatText(var_194_17.content)

				arg_191_1.text_.text = var_194_18

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_19 = 50
				local var_194_20 = utf8.len(var_194_18)
				local var_194_21 = var_194_19 <= 0 and var_194_16 or var_194_16 * (var_194_20 / var_194_19)

				if var_194_21 > 0 and var_194_16 < var_194_21 then
					arg_191_1.talkMaxDuration = var_194_21

					if var_194_21 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_21 + var_194_15
					end
				end

				arg_191_1.text_.text = var_194_18
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_22 = math.max(var_194_16, arg_191_1.talkMaxDuration)

			if var_194_15 <= arg_191_1.time_ and arg_191_1.time_ < var_194_15 + var_194_22 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_15) / var_194_22

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_15 + var_194_22 and arg_191_1.time_ < var_194_15 + var_194_22 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play121511049 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 121511049
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play121511050(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.8

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_2 = arg_195_1:GetWordFromCfg(121511049)
				local var_198_3 = arg_195_1:FormatText(var_198_2.content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 32
				local var_198_5 = utf8.len(var_198_3)
				local var_198_6 = var_198_4 <= 0 and var_198_1 or var_198_1 * (var_198_5 / var_198_4)

				if var_198_6 > 0 and var_198_1 < var_198_6 then
					arg_195_1.talkMaxDuration = var_198_6

					if var_198_6 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_7 and arg_195_1.time_ < var_198_0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play121511050 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 121511050
		arg_199_1.duration_ = 7

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play121511051(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 2

			arg_199_1.isInRecall_ = false

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.screenFilterGo_:SetActive(true)

				arg_199_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_202_0, iter_202_1 in pairs(arg_199_1.actors_) do
					local var_202_1 = iter_202_1:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_202_2, iter_202_3 in ipairs(var_202_1) do
						if iter_202_3.color.r > 0.51 then
							iter_202_3.color = Color.New(1, 1, 1)
						else
							iter_202_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_202_2 = 0.1

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_0) / var_202_2

				arg_199_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_202_3)
			end

			if arg_199_1.time_ >= var_202_0 + var_202_2 and arg_199_1.time_ < var_202_0 + var_202_2 + arg_202_0 then
				arg_199_1.screenFilterEffect_.weight = 1
			end

			local var_202_4 = 0

			if var_202_4 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_5 = 2

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_5 then
				local var_202_6 = (arg_199_1.time_ - var_202_4) / var_202_5
				local var_202_7 = Color.New(0, 0, 0)

				var_202_7.a = Mathf.Lerp(0, 1, var_202_6)
				arg_199_1.mask_.color = var_202_7
			end

			if arg_199_1.time_ >= var_202_4 + var_202_5 and arg_199_1.time_ < var_202_4 + var_202_5 + arg_202_0 then
				local var_202_8 = Color.New(0, 0, 0)

				var_202_8.a = 1
				arg_199_1.mask_.color = var_202_8
			end

			local var_202_9 = 2

			if var_202_9 < arg_199_1.time_ and arg_199_1.time_ <= var_202_9 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_10 = 2

			if var_202_9 <= arg_199_1.time_ and arg_199_1.time_ < var_202_9 + var_202_10 then
				local var_202_11 = (arg_199_1.time_ - var_202_9) / var_202_10
				local var_202_12 = Color.New(0, 0, 0)

				var_202_12.a = Mathf.Lerp(1, 0, var_202_11)
				arg_199_1.mask_.color = var_202_12
			end

			if arg_199_1.time_ >= var_202_9 + var_202_10 and arg_199_1.time_ < var_202_9 + var_202_10 + arg_202_0 then
				local var_202_13 = Color.New(0, 0, 0)
				local var_202_14 = 0

				arg_199_1.mask_.enabled = false
				var_202_13.a = var_202_14
				arg_199_1.mask_.color = var_202_13
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_15 = 2
			local var_202_16 = 0.975

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_17 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_17:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(121511050)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 39
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22
					var_202_15 = var_202_15 + 0.3

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_23 = var_202_15 + 0.3
			local var_202_24 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_23 <= arg_199_1.time_ and arg_199_1.time_ < var_202_23 + var_202_24 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_23) / var_202_24

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_23 + var_202_24 and arg_199_1.time_ < var_202_23 + var_202_24 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play121511051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 121511051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play121511052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.05

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[7].name)

				arg_205_1.leftNameTxt_.text = var_208_2

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

				local var_208_3 = arg_205_1:GetWordFromCfg(121511051)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 2
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
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_8 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_8 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_8

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_8 and arg_205_1.time_ < var_208_0 + var_208_8 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play121511052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 121511052
		arg_209_1.duration_ = 5.27

		local var_209_0 = {
			ja = 5.266,
			ko = 1.4,
			zh = 1.4
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
				arg_209_0:Play121511053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.15

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[319].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(121511052)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511052", "story_v_out_121511.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511052", "story_v_out_121511.awb") / 1000

					if var_212_8 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_0
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_121511", "121511052", "story_v_out_121511.awb")

						arg_209_1:RecordAudio("121511052", var_212_9)
						arg_209_1:RecordAudio("121511052", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_121511", "121511052", "story_v_out_121511.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_121511", "121511052", "story_v_out_121511.awb")
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
	Play121511053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 121511053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play121511054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 1.25

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

				local var_216_2 = arg_213_1:GetWordFromCfg(121511053)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 50
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
	Play121511054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 121511054
		arg_217_1.duration_ = 10.8

		local var_217_0 = {
			ja = 10.8,
			ko = 8.6,
			zh = 8.6
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
				arg_217_0:Play121511055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.95

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[319].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(121511054)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511054", "story_v_out_121511.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511054", "story_v_out_121511.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_121511", "121511054", "story_v_out_121511.awb")

						arg_217_1:RecordAudio("121511054", var_220_9)
						arg_217_1:RecordAudio("121511054", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_121511", "121511054", "story_v_out_121511.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_121511", "121511054", "story_v_out_121511.awb")
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
	Play121511055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 121511055
		arg_221_1.duration_ = 13.53

		local var_221_0 = {
			ja = 13.533,
			ko = 8,
			zh = 8
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
				arg_221_0:Play121511056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 1.025

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[319].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(121511055)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511055", "story_v_out_121511.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511055", "story_v_out_121511.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_121511", "121511055", "story_v_out_121511.awb")

						arg_221_1:RecordAudio("121511055", var_224_9)
						arg_221_1:RecordAudio("121511055", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_121511", "121511055", "story_v_out_121511.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_121511", "121511055", "story_v_out_121511.awb")
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
	Play121511056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 121511056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play121511057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 1.45

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

				local var_228_2 = arg_225_1:GetWordFromCfg(121511056)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 58
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
	Play121511057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 121511057
		arg_229_1.duration_ = 2.7

		local var_229_0 = {
			ja = 2.7,
			ko = 2.1,
			zh = 2.1
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
				arg_229_0:Play121511058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.3

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[319].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(121511057)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511057", "story_v_out_121511.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511057", "story_v_out_121511.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_121511", "121511057", "story_v_out_121511.awb")

						arg_229_1:RecordAudio("121511057", var_232_9)
						arg_229_1:RecordAudio("121511057", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_121511", "121511057", "story_v_out_121511.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_121511", "121511057", "story_v_out_121511.awb")
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
	Play121511058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 121511058
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play121511059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 1.3

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_2 = arg_233_1:GetWordFromCfg(121511058)
				local var_236_3 = arg_233_1:FormatText(var_236_2.content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 52
				local var_236_5 = utf8.len(var_236_3)
				local var_236_6 = var_236_4 <= 0 and var_236_1 or var_236_1 * (var_236_5 / var_236_4)

				if var_236_6 > 0 and var_236_1 < var_236_6 then
					arg_233_1.talkMaxDuration = var_236_6

					if var_236_6 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_6 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_7 and arg_233_1.time_ < var_236_0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play121511059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 121511059
		arg_237_1.duration_ = 9.1

		local var_237_0 = {
			ja = 9.1,
			ko = 8.566,
			zh = 8.566
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
				arg_237_0:Play121511060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.9

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[319].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:GetWordFromCfg(121511059)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511059", "story_v_out_121511.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511059", "story_v_out_121511.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_121511", "121511059", "story_v_out_121511.awb")

						arg_237_1:RecordAudio("121511059", var_240_9)
						arg_237_1:RecordAudio("121511059", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_121511", "121511059", "story_v_out_121511.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_121511", "121511059", "story_v_out_121511.awb")
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
	Play121511060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 121511060
		arg_241_1.duration_ = 7

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play121511061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_1 = 2

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_1 then
				local var_244_2 = (arg_241_1.time_ - var_244_0) / var_244_1
				local var_244_3 = Color.New(1, 1, 1)

				var_244_3.a = Mathf.Lerp(1, 0, var_244_2)
				arg_241_1.mask_.color = var_244_3
			end

			if arg_241_1.time_ >= var_244_0 + var_244_1 and arg_241_1.time_ < var_244_0 + var_244_1 + arg_244_0 then
				local var_244_4 = Color.New(1, 1, 1)
				local var_244_5 = 0

				arg_241_1.mask_.enabled = false
				var_244_4.a = var_244_5
				arg_241_1.mask_.color = var_244_4
			end

			local var_244_6 = 0

			arg_241_1.isInRecall_ = false

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.screenFilterGo_:SetActive(false)

				for iter_244_0, iter_244_1 in pairs(arg_241_1.actors_) do
					local var_244_7 = iter_244_1:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_244_2, iter_244_3 in ipairs(var_244_7) do
						if iter_244_3.color.r > 0.51 then
							iter_244_3.color = Color.New(1, 1, 1)
						else
							iter_244_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_244_8 = 0.1

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_8 then
				local var_244_9 = (arg_241_1.time_ - var_244_6) / var_244_8

				arg_241_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_244_9)
			end

			if arg_241_1.time_ >= var_244_6 + var_244_8 and arg_241_1.time_ < var_244_6 + var_244_8 + arg_244_0 then
				arg_241_1.screenFilterEffect_.weight = 0
			end

			local var_244_10 = 0.0333333333333333
			local var_244_11 = 1

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				local var_244_12 = "play"
				local var_244_13 = "music"

				arg_241_1:AudioAction(var_244_12, var_244_13, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_244_14 = ""
				local var_244_15 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_244_15 ~= "" then
					if arg_241_1.bgmTxt_.text ~= var_244_15 and arg_241_1.bgmTxt_.text ~= "" then
						if arg_241_1.bgmTxt2_.text ~= "" then
							arg_241_1.bgmTxt_.text = arg_241_1.bgmTxt2_.text
						end

						arg_241_1.bgmTxt2_.text = var_244_15

						arg_241_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_241_1.bgmTxt_.text = var_244_15
						arg_241_1.bgmTxt2_.text = var_244_15
					end

					if arg_241_1.bgmTimer then
						arg_241_1.bgmTimer:Stop()

						arg_241_1.bgmTimer = nil
					end

					if arg_241_1.settingData.show_music_name == 1 then
						arg_241_1.musicController:SetSelectedState("show")
						arg_241_1.musicAnimator_:Play("open", 0, 0)

						if arg_241_1.settingData.music_time ~= 0 then
							arg_241_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_241_1.settingData.music_time), function()
								if arg_241_1 == nil or isNil(arg_241_1.bgmTxt_) then
									return
								end

								arg_241_1.musicController:SetSelectedState("hide")
								arg_241_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_241_1.frameCnt_ <= 1 then
				arg_241_1.dialog_:SetActive(false)
			end

			local var_244_16 = 2
			local var_244_17 = 0.175

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_18 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_18:setOnUpdate(LuaHelper.FloatAction(function(arg_246_0)
					arg_241_1.dialogCg_.alpha = arg_246_0
				end))
				var_244_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_19 = arg_241_1:FormatText(StoryNameCfg[7].name)

				arg_241_1.leftNameTxt_.text = var_244_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_20 = arg_241_1:GetWordFromCfg(121511060)
				local var_244_21 = arg_241_1:FormatText(var_244_20.content)

				arg_241_1.text_.text = var_244_21

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_22 = 7
				local var_244_23 = utf8.len(var_244_21)
				local var_244_24 = var_244_22 <= 0 and var_244_17 or var_244_17 * (var_244_23 / var_244_22)

				if var_244_24 > 0 and var_244_17 < var_244_24 then
					arg_241_1.talkMaxDuration = var_244_24
					var_244_16 = var_244_16 + 0.3

					if var_244_24 + var_244_16 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_24 + var_244_16
					end
				end

				arg_241_1.text_.text = var_244_21
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_25 = var_244_16 + 0.3
			local var_244_26 = math.max(var_244_17, arg_241_1.talkMaxDuration)

			if var_244_25 <= arg_241_1.time_ and arg_241_1.time_ < var_244_25 + var_244_26 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_25) / var_244_26

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_25 + var_244_26 and arg_241_1.time_ < var_244_25 + var_244_26 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play121511061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 121511061
		arg_248_1.duration_ = 1.67

		local var_248_0 = {
			ja = 1.666,
			ko = 1.2,
			zh = 1.2
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
				arg_248_0:Play121511062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.125

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[319].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_3 = arg_248_1:GetWordFromCfg(121511061)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511061", "story_v_out_121511.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511061", "story_v_out_121511.awb") / 1000

					if var_251_8 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_0
					end

					if var_251_3.prefab_name ~= "" and arg_248_1.actors_[var_251_3.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_3.prefab_name].transform, "story_v_out_121511", "121511061", "story_v_out_121511.awb")

						arg_248_1:RecordAudio("121511061", var_251_9)
						arg_248_1:RecordAudio("121511061", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_121511", "121511061", "story_v_out_121511.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_121511", "121511061", "story_v_out_121511.awb")
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
	Play121511062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 121511062
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play121511063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = manager.ui.mainCamera.transform
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.var_.shakeOldPos = var_255_0.localPosition
			end

			local var_255_2 = 0.6

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / 0.066
				local var_255_4, var_255_5 = math.modf(var_255_3)

				var_255_0.localPosition = Vector3.New(var_255_5 * 0.13, var_255_5 * 0.13, var_255_5 * 0.13) + arg_252_1.var_.shakeOldPos
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 then
				var_255_0.localPosition = arg_252_1.var_.shakeOldPos
			end

			local var_255_6 = 0

			if var_255_6 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.allBtn_.enabled = false
			end

			local var_255_7 = 0.6

			if arg_252_1.time_ >= var_255_6 + var_255_7 and arg_252_1.time_ < var_255_6 + var_255_7 + arg_255_0 then
				arg_252_1.allBtn_.enabled = true
			end

			local var_255_8 = 0
			local var_255_9 = 0.05

			if var_255_8 < arg_252_1.time_ and arg_252_1.time_ <= var_255_8 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_10 = arg_252_1:FormatText(StoryNameCfg[7].name)

				arg_252_1.leftNameTxt_.text = var_255_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_11 = arg_252_1:GetWordFromCfg(121511062)
				local var_255_12 = arg_252_1:FormatText(var_255_11.content)

				arg_252_1.text_.text = var_255_12

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_13 = 2
				local var_255_14 = utf8.len(var_255_12)
				local var_255_15 = var_255_13 <= 0 and var_255_9 or var_255_9 * (var_255_14 / var_255_13)

				if var_255_15 > 0 and var_255_9 < var_255_15 then
					arg_252_1.talkMaxDuration = var_255_15

					if var_255_15 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_15 + var_255_8
					end
				end

				arg_252_1.text_.text = var_255_12
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_16 = math.max(var_255_9, arg_252_1.talkMaxDuration)

			if var_255_8 <= arg_252_1.time_ and arg_252_1.time_ < var_255_8 + var_255_16 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_8) / var_255_16

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_8 + var_255_16 and arg_252_1.time_ < var_255_8 + var_255_16 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play121511063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 121511063
		arg_256_1.duration_ = 10.1

		local var_256_0 = {
			ja = 10.1,
			ko = 5.533,
			zh = 5.533
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play121511064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 0.65

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_2 = arg_256_1:FormatText(StoryNameCfg[319].name)

				arg_256_1.leftNameTxt_.text = var_259_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_3 = arg_256_1:GetWordFromCfg(121511063)
				local var_259_4 = arg_256_1:FormatText(var_259_3.content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 26
				local var_259_6 = utf8.len(var_259_4)
				local var_259_7 = var_259_5 <= 0 and var_259_1 or var_259_1 * (var_259_6 / var_259_5)

				if var_259_7 > 0 and var_259_1 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511063", "story_v_out_121511.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511063", "story_v_out_121511.awb") / 1000

					if var_259_8 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_0
					end

					if var_259_3.prefab_name ~= "" and arg_256_1.actors_[var_259_3.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_3.prefab_name].transform, "story_v_out_121511", "121511063", "story_v_out_121511.awb")

						arg_256_1:RecordAudio("121511063", var_259_9)
						arg_256_1:RecordAudio("121511063", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_121511", "121511063", "story_v_out_121511.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_121511", "121511063", "story_v_out_121511.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_10 and arg_256_1.time_ < var_259_0 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play121511064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 121511064
		arg_260_1.duration_ = 0.2

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"

			SetActive(arg_260_1.choicesGo_, true)

			for iter_261_0, iter_261_1 in ipairs(arg_260_1.choices_) do
				local var_261_0 = iter_261_0 <= 2

				SetActive(iter_261_1.go, var_261_0)
			end

			arg_260_1.choices_[1].txt.text = arg_260_1:FormatText(StoryChoiceCfg[402].name)
			arg_260_1.choices_[2].txt.text = arg_260_1:FormatText(StoryChoiceCfg[403].name)
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play121511065(arg_260_1)
			end

			if arg_262_0 == 2 then
				arg_260_0:Play121511070(arg_260_1)
			end

			arg_260_1:RecordChoiceLog(121511064, 402, 403)
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.allBtn_.enabled = false
			end

			local var_263_1 = 0.2

			if arg_260_1.time_ >= var_263_0 + var_263_1 and arg_260_1.time_ < var_263_0 + var_263_1 + arg_263_0 then
				arg_260_1.allBtn_.enabled = true
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play121511065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 121511065
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play121511066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0
			local var_267_1 = 0.633333333333333

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				local var_267_2 = "play"
				local var_267_3 = "effect"

				arg_264_1:AudioAction(var_267_2, var_267_3, "se_story_121_04", "se_story_121_04_gunready", "")
			end

			local var_267_4 = 0
			local var_267_5 = 0.85

			if var_267_4 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_6 = arg_264_1:GetWordFromCfg(121511065)
				local var_267_7 = arg_264_1:FormatText(var_267_6.content)

				arg_264_1.text_.text = var_267_7

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_8 = 34
				local var_267_9 = utf8.len(var_267_7)
				local var_267_10 = var_267_8 <= 0 and var_267_5 or var_267_5 * (var_267_9 / var_267_8)

				if var_267_10 > 0 and var_267_5 < var_267_10 then
					arg_264_1.talkMaxDuration = var_267_10

					if var_267_10 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_10 + var_267_4
					end
				end

				arg_264_1.text_.text = var_267_7
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_11 = math.max(var_267_5, arg_264_1.talkMaxDuration)

			if var_267_4 <= arg_264_1.time_ and arg_264_1.time_ < var_267_4 + var_267_11 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_4) / var_267_11

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_4 + var_267_11 and arg_264_1.time_ < var_267_4 + var_267_11 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play121511066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 121511066
		arg_268_1.duration_ = 2.77

		local var_268_0 = {
			ja = 2.766,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play121511067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["1075ui_story"].transform
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.var_.moveOldPos1075ui_story = var_271_0.localPosition
			end

			local var_271_2 = 0.001

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2
				local var_271_4 = Vector3.New(-0.7, -1.055, -6.16)

				var_271_0.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1075ui_story, var_271_4, var_271_3)

				local var_271_5 = manager.ui.mainCamera.transform.position - var_271_0.position

				var_271_0.forward = Vector3.New(var_271_5.x, var_271_5.y, var_271_5.z)

				local var_271_6 = var_271_0.localEulerAngles

				var_271_6.z = 0
				var_271_6.x = 0
				var_271_0.localEulerAngles = var_271_6
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 then
				var_271_0.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_271_7 = manager.ui.mainCamera.transform.position - var_271_0.position

				var_271_0.forward = Vector3.New(var_271_7.x, var_271_7.y, var_271_7.z)

				local var_271_8 = var_271_0.localEulerAngles

				var_271_8.z = 0
				var_271_8.x = 0
				var_271_0.localEulerAngles = var_271_8
			end

			local var_271_9 = arg_268_1.actors_["1075ui_story"]
			local var_271_10 = 0

			if var_271_10 < arg_268_1.time_ and arg_268_1.time_ <= var_271_10 + arg_271_0 and not isNil(var_271_9) and arg_268_1.var_.characterEffect1075ui_story == nil then
				arg_268_1.var_.characterEffect1075ui_story = var_271_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_11 = 0.200000002980232

			if var_271_10 <= arg_268_1.time_ and arg_268_1.time_ < var_271_10 + var_271_11 and not isNil(var_271_9) then
				local var_271_12 = (arg_268_1.time_ - var_271_10) / var_271_11

				if arg_268_1.var_.characterEffect1075ui_story and not isNil(var_271_9) then
					arg_268_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= var_271_10 + var_271_11 and arg_268_1.time_ < var_271_10 + var_271_11 + arg_271_0 and not isNil(var_271_9) and arg_268_1.var_.characterEffect1075ui_story then
				arg_268_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_271_13 = 0

			if var_271_13 < arg_268_1.time_ and arg_268_1.time_ <= var_271_13 + arg_271_0 then
				arg_268_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_271_14 = 0

			if var_271_14 < arg_268_1.time_ and arg_268_1.time_ <= var_271_14 + arg_271_0 then
				arg_268_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_271_15 = arg_268_1.actors_["1184ui_story"].transform
			local var_271_16 = 0

			if var_271_16 < arg_268_1.time_ and arg_268_1.time_ <= var_271_16 + arg_271_0 then
				arg_268_1.var_.moveOldPos1184ui_story = var_271_15.localPosition
			end

			local var_271_17 = 0.001

			if var_271_16 <= arg_268_1.time_ and arg_268_1.time_ < var_271_16 + var_271_17 then
				local var_271_18 = (arg_268_1.time_ - var_271_16) / var_271_17
				local var_271_19 = Vector3.New(0.7, -0.97, -6)

				var_271_15.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1184ui_story, var_271_19, var_271_18)

				local var_271_20 = manager.ui.mainCamera.transform.position - var_271_15.position

				var_271_15.forward = Vector3.New(var_271_20.x, var_271_20.y, var_271_20.z)

				local var_271_21 = var_271_15.localEulerAngles

				var_271_21.z = 0
				var_271_21.x = 0
				var_271_15.localEulerAngles = var_271_21
			end

			if arg_268_1.time_ >= var_271_16 + var_271_17 and arg_268_1.time_ < var_271_16 + var_271_17 + arg_271_0 then
				var_271_15.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_271_22 = manager.ui.mainCamera.transform.position - var_271_15.position

				var_271_15.forward = Vector3.New(var_271_22.x, var_271_22.y, var_271_22.z)

				local var_271_23 = var_271_15.localEulerAngles

				var_271_23.z = 0
				var_271_23.x = 0
				var_271_15.localEulerAngles = var_271_23
			end

			local var_271_24 = arg_268_1.actors_["1184ui_story"]
			local var_271_25 = 0

			if var_271_25 < arg_268_1.time_ and arg_268_1.time_ <= var_271_25 + arg_271_0 and not isNil(var_271_24) and arg_268_1.var_.characterEffect1184ui_story == nil then
				arg_268_1.var_.characterEffect1184ui_story = var_271_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_26 = 0.200000002980232

			if var_271_25 <= arg_268_1.time_ and arg_268_1.time_ < var_271_25 + var_271_26 and not isNil(var_271_24) then
				local var_271_27 = (arg_268_1.time_ - var_271_25) / var_271_26

				if arg_268_1.var_.characterEffect1184ui_story and not isNil(var_271_24) then
					arg_268_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= var_271_25 + var_271_26 and arg_268_1.time_ < var_271_25 + var_271_26 + arg_271_0 and not isNil(var_271_24) and arg_268_1.var_.characterEffect1184ui_story then
				arg_268_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_271_28 = 0

			if var_271_28 < arg_268_1.time_ and arg_268_1.time_ <= var_271_28 + arg_271_0 then
				arg_268_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_271_29 = 0
			local var_271_30 = 0.475

			if var_271_29 < arg_268_1.time_ and arg_268_1.time_ <= var_271_29 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_31 = arg_268_1:FormatText(StoryNameCfg[381].name)

				arg_268_1.leftNameTxt_.text = var_271_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_32 = arg_268_1:GetWordFromCfg(121511066)
				local var_271_33 = arg_268_1:FormatText(var_271_32.content)

				arg_268_1.text_.text = var_271_33

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_34 = 19
				local var_271_35 = utf8.len(var_271_33)
				local var_271_36 = var_271_34 <= 0 and var_271_30 or var_271_30 * (var_271_35 / var_271_34)

				if var_271_36 > 0 and var_271_30 < var_271_36 then
					arg_268_1.talkMaxDuration = var_271_36

					if var_271_36 + var_271_29 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_36 + var_271_29
					end
				end

				arg_268_1.text_.text = var_271_33
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511066", "story_v_out_121511.awb") ~= 0 then
					local var_271_37 = manager.audio:GetVoiceLength("story_v_out_121511", "121511066", "story_v_out_121511.awb") / 1000

					if var_271_37 + var_271_29 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_37 + var_271_29
					end

					if var_271_32.prefab_name ~= "" and arg_268_1.actors_[var_271_32.prefab_name] ~= nil then
						local var_271_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_32.prefab_name].transform, "story_v_out_121511", "121511066", "story_v_out_121511.awb")

						arg_268_1:RecordAudio("121511066", var_271_38)
						arg_268_1:RecordAudio("121511066", var_271_38)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_121511", "121511066", "story_v_out_121511.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_121511", "121511066", "story_v_out_121511.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_39 = math.max(var_271_30, arg_268_1.talkMaxDuration)

			if var_271_29 <= arg_268_1.time_ and arg_268_1.time_ < var_271_29 + var_271_39 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_29) / var_271_39

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_29 + var_271_39 and arg_268_1.time_ < var_271_29 + var_271_39 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play121511067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 121511067
		arg_272_1.duration_ = 2.3

		local var_272_0 = {
			ja = 2.3,
			ko = 1.233,
			zh = 1.233
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
				arg_272_0:Play121511068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 0.125

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[6].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_3 = arg_272_1:GetWordFromCfg(121511067)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511067", "story_v_out_121511.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511067", "story_v_out_121511.awb") / 1000

					if var_275_8 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_0
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_121511", "121511067", "story_v_out_121511.awb")

						arg_272_1:RecordAudio("121511067", var_275_9)
						arg_272_1:RecordAudio("121511067", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_121511", "121511067", "story_v_out_121511.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_121511", "121511067", "story_v_out_121511.awb")
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
	Play121511068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 121511068
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play121511069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1075ui_story"].transform
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.var_.moveOldPos1075ui_story = var_279_0.localPosition
			end

			local var_279_2 = 0.001

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2
				local var_279_4 = Vector3.New(0, 100, 0)

				var_279_0.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1075ui_story, var_279_4, var_279_3)

				local var_279_5 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_5.x, var_279_5.y, var_279_5.z)

				local var_279_6 = var_279_0.localEulerAngles

				var_279_6.z = 0
				var_279_6.x = 0
				var_279_0.localEulerAngles = var_279_6
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 then
				var_279_0.localPosition = Vector3.New(0, 100, 0)

				local var_279_7 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_7.x, var_279_7.y, var_279_7.z)

				local var_279_8 = var_279_0.localEulerAngles

				var_279_8.z = 0
				var_279_8.x = 0
				var_279_0.localEulerAngles = var_279_8
			end

			local var_279_9 = arg_276_1.actors_["1075ui_story"]
			local var_279_10 = 0

			if var_279_10 < arg_276_1.time_ and arg_276_1.time_ <= var_279_10 + arg_279_0 and not isNil(var_279_9) and arg_276_1.var_.characterEffect1075ui_story == nil then
				arg_276_1.var_.characterEffect1075ui_story = var_279_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_11 = 0.200000002980232

			if var_279_10 <= arg_276_1.time_ and arg_276_1.time_ < var_279_10 + var_279_11 and not isNil(var_279_9) then
				local var_279_12 = (arg_276_1.time_ - var_279_10) / var_279_11

				if arg_276_1.var_.characterEffect1075ui_story and not isNil(var_279_9) then
					local var_279_13 = Mathf.Lerp(0, 0.5, var_279_12)

					arg_276_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1075ui_story.fillRatio = var_279_13
				end
			end

			if arg_276_1.time_ >= var_279_10 + var_279_11 and arg_276_1.time_ < var_279_10 + var_279_11 + arg_279_0 and not isNil(var_279_9) and arg_276_1.var_.characterEffect1075ui_story then
				local var_279_14 = 0.5

				arg_276_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1075ui_story.fillRatio = var_279_14
			end

			local var_279_15 = arg_276_1.actors_["1184ui_story"].transform
			local var_279_16 = 0

			if var_279_16 < arg_276_1.time_ and arg_276_1.time_ <= var_279_16 + arg_279_0 then
				arg_276_1.var_.moveOldPos1184ui_story = var_279_15.localPosition
			end

			local var_279_17 = 0.001

			if var_279_16 <= arg_276_1.time_ and arg_276_1.time_ < var_279_16 + var_279_17 then
				local var_279_18 = (arg_276_1.time_ - var_279_16) / var_279_17
				local var_279_19 = Vector3.New(0, 100, 0)

				var_279_15.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1184ui_story, var_279_19, var_279_18)

				local var_279_20 = manager.ui.mainCamera.transform.position - var_279_15.position

				var_279_15.forward = Vector3.New(var_279_20.x, var_279_20.y, var_279_20.z)

				local var_279_21 = var_279_15.localEulerAngles

				var_279_21.z = 0
				var_279_21.x = 0
				var_279_15.localEulerAngles = var_279_21
			end

			if arg_276_1.time_ >= var_279_16 + var_279_17 and arg_276_1.time_ < var_279_16 + var_279_17 + arg_279_0 then
				var_279_15.localPosition = Vector3.New(0, 100, 0)

				local var_279_22 = manager.ui.mainCamera.transform.position - var_279_15.position

				var_279_15.forward = Vector3.New(var_279_22.x, var_279_22.y, var_279_22.z)

				local var_279_23 = var_279_15.localEulerAngles

				var_279_23.z = 0
				var_279_23.x = 0
				var_279_15.localEulerAngles = var_279_23
			end

			local var_279_24 = arg_276_1.actors_["1184ui_story"]
			local var_279_25 = 0

			if var_279_25 < arg_276_1.time_ and arg_276_1.time_ <= var_279_25 + arg_279_0 and not isNil(var_279_24) and arg_276_1.var_.characterEffect1184ui_story == nil then
				arg_276_1.var_.characterEffect1184ui_story = var_279_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_26 = 0.200000002980232

			if var_279_25 <= arg_276_1.time_ and arg_276_1.time_ < var_279_25 + var_279_26 and not isNil(var_279_24) then
				local var_279_27 = (arg_276_1.time_ - var_279_25) / var_279_26

				if arg_276_1.var_.characterEffect1184ui_story and not isNil(var_279_24) then
					local var_279_28 = Mathf.Lerp(0, 0.5, var_279_27)

					arg_276_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1184ui_story.fillRatio = var_279_28
				end
			end

			if arg_276_1.time_ >= var_279_25 + var_279_26 and arg_276_1.time_ < var_279_25 + var_279_26 + arg_279_0 and not isNil(var_279_24) and arg_276_1.var_.characterEffect1184ui_story then
				local var_279_29 = 0.5

				arg_276_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1184ui_story.fillRatio = var_279_29
			end

			local var_279_30 = 0
			local var_279_31 = 0.633333333333333

			if var_279_30 < arg_276_1.time_ and arg_276_1.time_ <= var_279_30 + arg_279_0 then
				local var_279_32 = "play"
				local var_279_33 = "effect"

				arg_276_1:AudioAction(var_279_32, var_279_33, "se_story_121_04", "se_story_121_04_gunreadygroup", "")
			end

			local var_279_34 = 0
			local var_279_35 = 1.2

			if var_279_34 < arg_276_1.time_ and arg_276_1.time_ <= var_279_34 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_36 = arg_276_1:GetWordFromCfg(121511068)
				local var_279_37 = arg_276_1:FormatText(var_279_36.content)

				arg_276_1.text_.text = var_279_37

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_38 = 48
				local var_279_39 = utf8.len(var_279_37)
				local var_279_40 = var_279_38 <= 0 and var_279_35 or var_279_35 * (var_279_39 / var_279_38)

				if var_279_40 > 0 and var_279_35 < var_279_40 then
					arg_276_1.talkMaxDuration = var_279_40

					if var_279_40 + var_279_34 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_40 + var_279_34
					end
				end

				arg_276_1.text_.text = var_279_37
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_41 = math.max(var_279_35, arg_276_1.talkMaxDuration)

			if var_279_34 <= arg_276_1.time_ and arg_276_1.time_ < var_279_34 + var_279_41 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_34) / var_279_41

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_34 + var_279_41 and arg_276_1.time_ < var_279_34 + var_279_41 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play121511069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 121511069
		arg_280_1.duration_ = 3.93

		local var_280_0 = {
			ja = 3.933,
			ko = 2.5,
			zh = 2.5
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play121511076(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["10042ui_story"].transform
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.var_.moveOldPos10042ui_story = var_283_0.localPosition
			end

			local var_283_2 = 0.001

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2
				local var_283_4 = Vector3.New(0, -1.12, -6.2)

				var_283_0.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10042ui_story, var_283_4, var_283_3)

				local var_283_5 = manager.ui.mainCamera.transform.position - var_283_0.position

				var_283_0.forward = Vector3.New(var_283_5.x, var_283_5.y, var_283_5.z)

				local var_283_6 = var_283_0.localEulerAngles

				var_283_6.z = 0
				var_283_6.x = 0
				var_283_0.localEulerAngles = var_283_6
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 then
				var_283_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_283_7 = manager.ui.mainCamera.transform.position - var_283_0.position

				var_283_0.forward = Vector3.New(var_283_7.x, var_283_7.y, var_283_7.z)

				local var_283_8 = var_283_0.localEulerAngles

				var_283_8.z = 0
				var_283_8.x = 0
				var_283_0.localEulerAngles = var_283_8
			end

			local var_283_9 = arg_280_1.actors_["10042ui_story"]
			local var_283_10 = 0

			if var_283_10 < arg_280_1.time_ and arg_280_1.time_ <= var_283_10 + arg_283_0 and not isNil(var_283_9) and arg_280_1.var_.characterEffect10042ui_story == nil then
				arg_280_1.var_.characterEffect10042ui_story = var_283_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_11 = 0.200000002980232

			if var_283_10 <= arg_280_1.time_ and arg_280_1.time_ < var_283_10 + var_283_11 and not isNil(var_283_9) then
				local var_283_12 = (arg_280_1.time_ - var_283_10) / var_283_11

				if arg_280_1.var_.characterEffect10042ui_story and not isNil(var_283_9) then
					arg_280_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= var_283_10 + var_283_11 and arg_280_1.time_ < var_283_10 + var_283_11 + arg_283_0 and not isNil(var_283_9) and arg_280_1.var_.characterEffect10042ui_story then
				arg_280_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_283_13 = 0

			if var_283_13 < arg_280_1.time_ and arg_280_1.time_ <= var_283_13 + arg_283_0 then
				arg_280_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action2_1")
			end

			local var_283_14 = 0

			if var_283_14 < arg_280_1.time_ and arg_280_1.time_ <= var_283_14 + arg_283_0 then
				arg_280_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_283_15 = 0
			local var_283_16 = 0.275

			if var_283_15 < arg_280_1.time_ and arg_280_1.time_ <= var_283_15 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_17 = arg_280_1:FormatText(StoryNameCfg[388].name)

				arg_280_1.leftNameTxt_.text = var_283_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_18 = arg_280_1:GetWordFromCfg(121511069)
				local var_283_19 = arg_280_1:FormatText(var_283_18.content)

				arg_280_1.text_.text = var_283_19

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_20 = 11
				local var_283_21 = utf8.len(var_283_19)
				local var_283_22 = var_283_20 <= 0 and var_283_16 or var_283_16 * (var_283_21 / var_283_20)

				if var_283_22 > 0 and var_283_16 < var_283_22 then
					arg_280_1.talkMaxDuration = var_283_22

					if var_283_22 + var_283_15 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_22 + var_283_15
					end
				end

				arg_280_1.text_.text = var_283_19
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511069", "story_v_out_121511.awb") ~= 0 then
					local var_283_23 = manager.audio:GetVoiceLength("story_v_out_121511", "121511069", "story_v_out_121511.awb") / 1000

					if var_283_23 + var_283_15 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_23 + var_283_15
					end

					if var_283_18.prefab_name ~= "" and arg_280_1.actors_[var_283_18.prefab_name] ~= nil then
						local var_283_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_18.prefab_name].transform, "story_v_out_121511", "121511069", "story_v_out_121511.awb")

						arg_280_1:RecordAudio("121511069", var_283_24)
						arg_280_1:RecordAudio("121511069", var_283_24)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_121511", "121511069", "story_v_out_121511.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_121511", "121511069", "story_v_out_121511.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_25 = math.max(var_283_16, arg_280_1.talkMaxDuration)

			if var_283_15 <= arg_280_1.time_ and arg_280_1.time_ < var_283_15 + var_283_25 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_15) / var_283_25

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_15 + var_283_25 and arg_280_1.time_ < var_283_15 + var_283_25 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play121511076 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 121511076
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play121511077(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["10042ui_story"].transform
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.var_.moveOldPos10042ui_story = var_287_0.localPosition
			end

			local var_287_2 = 0.001

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2
				local var_287_4 = Vector3.New(0, 100, 0)

				var_287_0.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10042ui_story, var_287_4, var_287_3)

				local var_287_5 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_5.x, var_287_5.y, var_287_5.z)

				local var_287_6 = var_287_0.localEulerAngles

				var_287_6.z = 0
				var_287_6.x = 0
				var_287_0.localEulerAngles = var_287_6
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 then
				var_287_0.localPosition = Vector3.New(0, 100, 0)

				local var_287_7 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_7.x, var_287_7.y, var_287_7.z)

				local var_287_8 = var_287_0.localEulerAngles

				var_287_8.z = 0
				var_287_8.x = 0
				var_287_0.localEulerAngles = var_287_8
			end

			local var_287_9 = arg_284_1.actors_["10042ui_story"]
			local var_287_10 = 0

			if var_287_10 < arg_284_1.time_ and arg_284_1.time_ <= var_287_10 + arg_287_0 and not isNil(var_287_9) and arg_284_1.var_.characterEffect10042ui_story == nil then
				arg_284_1.var_.characterEffect10042ui_story = var_287_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_11 = 0.200000002980232

			if var_287_10 <= arg_284_1.time_ and arg_284_1.time_ < var_287_10 + var_287_11 and not isNil(var_287_9) then
				local var_287_12 = (arg_284_1.time_ - var_287_10) / var_287_11

				if arg_284_1.var_.characterEffect10042ui_story and not isNil(var_287_9) then
					local var_287_13 = Mathf.Lerp(0, 0.5, var_287_12)

					arg_284_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_284_1.var_.characterEffect10042ui_story.fillRatio = var_287_13
				end
			end

			if arg_284_1.time_ >= var_287_10 + var_287_11 and arg_284_1.time_ < var_287_10 + var_287_11 + arg_287_0 and not isNil(var_287_9) and arg_284_1.var_.characterEffect10042ui_story then
				local var_287_14 = 0.5

				arg_284_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_284_1.var_.characterEffect10042ui_story.fillRatio = var_287_14
			end

			local var_287_15 = 0
			local var_287_16 = 0.925

			if var_287_15 < arg_284_1.time_ and arg_284_1.time_ <= var_287_15 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_17 = arg_284_1:GetWordFromCfg(121511076)
				local var_287_18 = arg_284_1:FormatText(var_287_17.content)

				arg_284_1.text_.text = var_287_18

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_19 = 37
				local var_287_20 = utf8.len(var_287_18)
				local var_287_21 = var_287_19 <= 0 and var_287_16 or var_287_16 * (var_287_20 / var_287_19)

				if var_287_21 > 0 and var_287_16 < var_287_21 then
					arg_284_1.talkMaxDuration = var_287_21

					if var_287_21 + var_287_15 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_21 + var_287_15
					end
				end

				arg_284_1.text_.text = var_287_18
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_22 = math.max(var_287_16, arg_284_1.talkMaxDuration)

			if var_287_15 <= arg_284_1.time_ and arg_284_1.time_ < var_287_15 + var_287_22 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_15) / var_287_22

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_15 + var_287_22 and arg_284_1.time_ < var_287_15 + var_287_22 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play121511077 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 121511077
		arg_288_1.duration_ = 9.3

		local var_288_0 = {
			ja = 9.3,
			ko = 3.7,
			zh = 3.7
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play121511078(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0
			local var_291_1 = 0.525

			if var_291_0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_2 = arg_288_1:FormatText(StoryNameCfg[319].name)

				arg_288_1.leftNameTxt_.text = var_291_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_3 = arg_288_1:GetWordFromCfg(121511077)
				local var_291_4 = arg_288_1:FormatText(var_291_3.content)

				arg_288_1.text_.text = var_291_4

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 21
				local var_291_6 = utf8.len(var_291_4)
				local var_291_7 = var_291_5 <= 0 and var_291_1 or var_291_1 * (var_291_6 / var_291_5)

				if var_291_7 > 0 and var_291_1 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_0
					end
				end

				arg_288_1.text_.text = var_291_4
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511077", "story_v_out_121511.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511077", "story_v_out_121511.awb") / 1000

					if var_291_8 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_0
					end

					if var_291_3.prefab_name ~= "" and arg_288_1.actors_[var_291_3.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_3.prefab_name].transform, "story_v_out_121511", "121511077", "story_v_out_121511.awb")

						arg_288_1:RecordAudio("121511077", var_291_9)
						arg_288_1:RecordAudio("121511077", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_121511", "121511077", "story_v_out_121511.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_121511", "121511077", "story_v_out_121511.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_1, arg_288_1.talkMaxDuration)

			if var_291_0 <= arg_288_1.time_ and arg_288_1.time_ < var_291_0 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_0) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_0 + var_291_10 and arg_288_1.time_ < var_291_0 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play121511078 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 121511078
		arg_292_1.duration_ = 9

		local var_292_0 = {
			ja = 9,
			ko = 5.933,
			zh = 5.933
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play121511079(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0
			local var_295_1 = 0.775

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_2 = arg_292_1:FormatText(StoryNameCfg[319].name)

				arg_292_1.leftNameTxt_.text = var_295_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_3 = arg_292_1:GetWordFromCfg(121511078)
				local var_295_4 = arg_292_1:FormatText(var_295_3.content)

				arg_292_1.text_.text = var_295_4

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 31
				local var_295_6 = utf8.len(var_295_4)
				local var_295_7 = var_295_5 <= 0 and var_295_1 or var_295_1 * (var_295_6 / var_295_5)

				if var_295_7 > 0 and var_295_1 < var_295_7 then
					arg_292_1.talkMaxDuration = var_295_7

					if var_295_7 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_7 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_4
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511078", "story_v_out_121511.awb") ~= 0 then
					local var_295_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511078", "story_v_out_121511.awb") / 1000

					if var_295_8 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_8 + var_295_0
					end

					if var_295_3.prefab_name ~= "" and arg_292_1.actors_[var_295_3.prefab_name] ~= nil then
						local var_295_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_3.prefab_name].transform, "story_v_out_121511", "121511078", "story_v_out_121511.awb")

						arg_292_1:RecordAudio("121511078", var_295_9)
						arg_292_1:RecordAudio("121511078", var_295_9)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_121511", "121511078", "story_v_out_121511.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_121511", "121511078", "story_v_out_121511.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_10 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_10 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_10

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_10 and arg_292_1.time_ < var_295_0 + var_295_10 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play121511079 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 121511079
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play121511080(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0
			local var_299_1 = 1

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_2 = arg_296_1:GetWordFromCfg(121511079)
				local var_299_3 = arg_296_1:FormatText(var_299_2.content)

				arg_296_1.text_.text = var_299_3

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_4 = 40
				local var_299_5 = utf8.len(var_299_3)
				local var_299_6 = var_299_4 <= 0 and var_299_1 or var_299_1 * (var_299_5 / var_299_4)

				if var_299_6 > 0 and var_299_1 < var_299_6 then
					arg_296_1.talkMaxDuration = var_299_6

					if var_299_6 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_6 + var_299_0
					end
				end

				arg_296_1.text_.text = var_299_3
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_7 = math.max(var_299_1, arg_296_1.talkMaxDuration)

			if var_299_0 <= arg_296_1.time_ and arg_296_1.time_ < var_299_0 + var_299_7 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_0) / var_299_7

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_0 + var_299_7 and arg_296_1.time_ < var_299_0 + var_299_7 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play121511080 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 121511080
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play121511081(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 1.3

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_2 = arg_300_1:GetWordFromCfg(121511080)
				local var_303_3 = arg_300_1:FormatText(var_303_2.content)

				arg_300_1.text_.text = var_303_3

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 52
				local var_303_5 = utf8.len(var_303_3)
				local var_303_6 = var_303_4 <= 0 and var_303_1 or var_303_1 * (var_303_5 / var_303_4)

				if var_303_6 > 0 and var_303_1 < var_303_6 then
					arg_300_1.talkMaxDuration = var_303_6

					if var_303_6 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_3
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_7 and arg_300_1.time_ < var_303_0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play121511081 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 121511081
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play121511082(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 0.525

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_2 = arg_304_1:FormatText(StoryNameCfg[7].name)

				arg_304_1.leftNameTxt_.text = var_307_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_3 = arg_304_1:GetWordFromCfg(121511081)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 21
				local var_307_6 = utf8.len(var_307_4)
				local var_307_7 = var_307_5 <= 0 and var_307_1 or var_307_1 * (var_307_6 / var_307_5)

				if var_307_7 > 0 and var_307_1 < var_307_7 then
					arg_304_1.talkMaxDuration = var_307_7

					if var_307_7 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_8 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_8 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_8

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_8 and arg_304_1.time_ < var_307_0 + var_307_8 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play121511082 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 121511082
		arg_308_1.duration_ = 2

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play121511083(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1075ui_story"].transform
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.var_.moveOldPos1075ui_story = var_311_0.localPosition
			end

			local var_311_2 = 0.001

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2
				local var_311_4 = Vector3.New(0, -1.055, -6.16)

				var_311_0.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1075ui_story, var_311_4, var_311_3)

				local var_311_5 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_5.x, var_311_5.y, var_311_5.z)

				local var_311_6 = var_311_0.localEulerAngles

				var_311_6.z = 0
				var_311_6.x = 0
				var_311_0.localEulerAngles = var_311_6
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 then
				var_311_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_311_7 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_7.x, var_311_7.y, var_311_7.z)

				local var_311_8 = var_311_0.localEulerAngles

				var_311_8.z = 0
				var_311_8.x = 0
				var_311_0.localEulerAngles = var_311_8
			end

			local var_311_9 = arg_308_1.actors_["1075ui_story"]
			local var_311_10 = 0

			if var_311_10 < arg_308_1.time_ and arg_308_1.time_ <= var_311_10 + arg_311_0 and not isNil(var_311_9) and arg_308_1.var_.characterEffect1075ui_story == nil then
				arg_308_1.var_.characterEffect1075ui_story = var_311_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_11 = 0.200000002980232

			if var_311_10 <= arg_308_1.time_ and arg_308_1.time_ < var_311_10 + var_311_11 and not isNil(var_311_9) then
				local var_311_12 = (arg_308_1.time_ - var_311_10) / var_311_11

				if arg_308_1.var_.characterEffect1075ui_story and not isNil(var_311_9) then
					arg_308_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= var_311_10 + var_311_11 and arg_308_1.time_ < var_311_10 + var_311_11 + arg_311_0 and not isNil(var_311_9) and arg_308_1.var_.characterEffect1075ui_story then
				arg_308_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_311_13 = 0

			if var_311_13 < arg_308_1.time_ and arg_308_1.time_ <= var_311_13 + arg_311_0 then
				arg_308_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_311_14 = 0

			if var_311_14 < arg_308_1.time_ and arg_308_1.time_ <= var_311_14 + arg_311_0 then
				arg_308_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_311_15 = 0
			local var_311_16 = 0.1

			if var_311_15 < arg_308_1.time_ and arg_308_1.time_ <= var_311_15 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_17 = arg_308_1:FormatText(StoryNameCfg[381].name)

				arg_308_1.leftNameTxt_.text = var_311_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_18 = arg_308_1:GetWordFromCfg(121511082)
				local var_311_19 = arg_308_1:FormatText(var_311_18.content)

				arg_308_1.text_.text = var_311_19

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_20 = 4
				local var_311_21 = utf8.len(var_311_19)
				local var_311_22 = var_311_20 <= 0 and var_311_16 or var_311_16 * (var_311_21 / var_311_20)

				if var_311_22 > 0 and var_311_16 < var_311_22 then
					arg_308_1.talkMaxDuration = var_311_22

					if var_311_22 + var_311_15 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_22 + var_311_15
					end
				end

				arg_308_1.text_.text = var_311_19
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511082", "story_v_out_121511.awb") ~= 0 then
					local var_311_23 = manager.audio:GetVoiceLength("story_v_out_121511", "121511082", "story_v_out_121511.awb") / 1000

					if var_311_23 + var_311_15 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_23 + var_311_15
					end

					if var_311_18.prefab_name ~= "" and arg_308_1.actors_[var_311_18.prefab_name] ~= nil then
						local var_311_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_18.prefab_name].transform, "story_v_out_121511", "121511082", "story_v_out_121511.awb")

						arg_308_1:RecordAudio("121511082", var_311_24)
						arg_308_1:RecordAudio("121511082", var_311_24)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_121511", "121511082", "story_v_out_121511.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_121511", "121511082", "story_v_out_121511.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_25 = math.max(var_311_16, arg_308_1.talkMaxDuration)

			if var_311_15 <= arg_308_1.time_ and arg_308_1.time_ < var_311_15 + var_311_25 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_15) / var_311_25

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_15 + var_311_25 and arg_308_1.time_ < var_311_15 + var_311_25 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play121511083 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 121511083
		arg_312_1.duration_ = 2

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play121511084(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1075ui_story"].transform
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.var_.moveOldPos1075ui_story = var_315_0.localPosition
			end

			local var_315_2 = 0.001

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2
				local var_315_4 = Vector3.New(0, 100, 0)

				var_315_0.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1075ui_story, var_315_4, var_315_3)

				local var_315_5 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_5.x, var_315_5.y, var_315_5.z)

				local var_315_6 = var_315_0.localEulerAngles

				var_315_6.z = 0
				var_315_6.x = 0
				var_315_0.localEulerAngles = var_315_6
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 then
				var_315_0.localPosition = Vector3.New(0, 100, 0)

				local var_315_7 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_7.x, var_315_7.y, var_315_7.z)

				local var_315_8 = var_315_0.localEulerAngles

				var_315_8.z = 0
				var_315_8.x = 0
				var_315_0.localEulerAngles = var_315_8
			end

			local var_315_9 = arg_312_1.actors_["1075ui_story"]
			local var_315_10 = 0

			if var_315_10 < arg_312_1.time_ and arg_312_1.time_ <= var_315_10 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect1075ui_story == nil then
				arg_312_1.var_.characterEffect1075ui_story = var_315_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_11 = 0.200000002980232

			if var_315_10 <= arg_312_1.time_ and arg_312_1.time_ < var_315_10 + var_315_11 and not isNil(var_315_9) then
				local var_315_12 = (arg_312_1.time_ - var_315_10) / var_315_11

				if arg_312_1.var_.characterEffect1075ui_story and not isNil(var_315_9) then
					local var_315_13 = Mathf.Lerp(0, 0.5, var_315_12)

					arg_312_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1075ui_story.fillRatio = var_315_13
				end
			end

			if arg_312_1.time_ >= var_315_10 + var_315_11 and arg_312_1.time_ < var_315_10 + var_315_11 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect1075ui_story then
				local var_315_14 = 0.5

				arg_312_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1075ui_story.fillRatio = var_315_14
			end

			local var_315_15 = arg_312_1.actors_["10042ui_story"].transform
			local var_315_16 = 0

			if var_315_16 < arg_312_1.time_ and arg_312_1.time_ <= var_315_16 + arg_315_0 then
				arg_312_1.var_.moveOldPos10042ui_story = var_315_15.localPosition
			end

			local var_315_17 = 0.001

			if var_315_16 <= arg_312_1.time_ and arg_312_1.time_ < var_315_16 + var_315_17 then
				local var_315_18 = (arg_312_1.time_ - var_315_16) / var_315_17
				local var_315_19 = Vector3.New(0, -1.12, -6.2)

				var_315_15.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10042ui_story, var_315_19, var_315_18)

				local var_315_20 = manager.ui.mainCamera.transform.position - var_315_15.position

				var_315_15.forward = Vector3.New(var_315_20.x, var_315_20.y, var_315_20.z)

				local var_315_21 = var_315_15.localEulerAngles

				var_315_21.z = 0
				var_315_21.x = 0
				var_315_15.localEulerAngles = var_315_21
			end

			if arg_312_1.time_ >= var_315_16 + var_315_17 and arg_312_1.time_ < var_315_16 + var_315_17 + arg_315_0 then
				var_315_15.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_315_22 = manager.ui.mainCamera.transform.position - var_315_15.position

				var_315_15.forward = Vector3.New(var_315_22.x, var_315_22.y, var_315_22.z)

				local var_315_23 = var_315_15.localEulerAngles

				var_315_23.z = 0
				var_315_23.x = 0
				var_315_15.localEulerAngles = var_315_23
			end

			local var_315_24 = arg_312_1.actors_["10042ui_story"]
			local var_315_25 = 0

			if var_315_25 < arg_312_1.time_ and arg_312_1.time_ <= var_315_25 + arg_315_0 and not isNil(var_315_24) and arg_312_1.var_.characterEffect10042ui_story == nil then
				arg_312_1.var_.characterEffect10042ui_story = var_315_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_26 = 0.200000002980232

			if var_315_25 <= arg_312_1.time_ and arg_312_1.time_ < var_315_25 + var_315_26 and not isNil(var_315_24) then
				local var_315_27 = (arg_312_1.time_ - var_315_25) / var_315_26

				if arg_312_1.var_.characterEffect10042ui_story and not isNil(var_315_24) then
					arg_312_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= var_315_25 + var_315_26 and arg_312_1.time_ < var_315_25 + var_315_26 + arg_315_0 and not isNil(var_315_24) and arg_312_1.var_.characterEffect10042ui_story then
				arg_312_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_315_28 = 0

			if var_315_28 < arg_312_1.time_ and arg_312_1.time_ <= var_315_28 + arg_315_0 then
				arg_312_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_315_29 = 0
			local var_315_30 = 0.05

			if var_315_29 < arg_312_1.time_ and arg_312_1.time_ <= var_315_29 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_31 = arg_312_1:FormatText(StoryNameCfg[388].name)

				arg_312_1.leftNameTxt_.text = var_315_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_32 = arg_312_1:GetWordFromCfg(121511083)
				local var_315_33 = arg_312_1:FormatText(var_315_32.content)

				arg_312_1.text_.text = var_315_33

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_34 = 2
				local var_315_35 = utf8.len(var_315_33)
				local var_315_36 = var_315_34 <= 0 and var_315_30 or var_315_30 * (var_315_35 / var_315_34)

				if var_315_36 > 0 and var_315_30 < var_315_36 then
					arg_312_1.talkMaxDuration = var_315_36

					if var_315_36 + var_315_29 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_36 + var_315_29
					end
				end

				arg_312_1.text_.text = var_315_33
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511083", "story_v_out_121511.awb") ~= 0 then
					local var_315_37 = manager.audio:GetVoiceLength("story_v_out_121511", "121511083", "story_v_out_121511.awb") / 1000

					if var_315_37 + var_315_29 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_37 + var_315_29
					end

					if var_315_32.prefab_name ~= "" and arg_312_1.actors_[var_315_32.prefab_name] ~= nil then
						local var_315_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_32.prefab_name].transform, "story_v_out_121511", "121511083", "story_v_out_121511.awb")

						arg_312_1:RecordAudio("121511083", var_315_38)
						arg_312_1:RecordAudio("121511083", var_315_38)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_121511", "121511083", "story_v_out_121511.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_121511", "121511083", "story_v_out_121511.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_39 = math.max(var_315_30, arg_312_1.talkMaxDuration)

			if var_315_29 <= arg_312_1.time_ and arg_312_1.time_ < var_315_29 + var_315_39 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_29) / var_315_39

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_29 + var_315_39 and arg_312_1.time_ < var_315_29 + var_315_39 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play121511084 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 121511084
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play121511085(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["10042ui_story"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect10042ui_story == nil then
				arg_316_1.var_.characterEffect10042ui_story = var_319_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.characterEffect10042ui_story and not isNil(var_319_0) then
					local var_319_4 = Mathf.Lerp(0, 0.5, var_319_3)

					arg_316_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_316_1.var_.characterEffect10042ui_story.fillRatio = var_319_4
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect10042ui_story then
				local var_319_5 = 0.5

				arg_316_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_316_1.var_.characterEffect10042ui_story.fillRatio = var_319_5
			end

			local var_319_6 = 0
			local var_319_7 = 1.45

			if var_319_6 < arg_316_1.time_ and arg_316_1.time_ <= var_319_6 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_8 = arg_316_1:GetWordFromCfg(121511084)
				local var_319_9 = arg_316_1:FormatText(var_319_8.content)

				arg_316_1.text_.text = var_319_9

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_10 = 58
				local var_319_11 = utf8.len(var_319_9)
				local var_319_12 = var_319_10 <= 0 and var_319_7 or var_319_7 * (var_319_11 / var_319_10)

				if var_319_12 > 0 and var_319_7 < var_319_12 then
					arg_316_1.talkMaxDuration = var_319_12

					if var_319_12 + var_319_6 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_12 + var_319_6
					end
				end

				arg_316_1.text_.text = var_319_9
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_13 = math.max(var_319_7, arg_316_1.talkMaxDuration)

			if var_319_6 <= arg_316_1.time_ and arg_316_1.time_ < var_319_6 + var_319_13 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_6) / var_319_13

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_6 + var_319_13 and arg_316_1.time_ < var_319_6 + var_319_13 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play121511085 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 121511085
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play121511086(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 1

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_2 = arg_320_1:GetWordFromCfg(121511085)
				local var_323_3 = arg_320_1:FormatText(var_323_2.content)

				arg_320_1.text_.text = var_323_3

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 38
				local var_323_5 = utf8.len(var_323_3)
				local var_323_6 = var_323_4 <= 0 and var_323_1 or var_323_1 * (var_323_5 / var_323_4)

				if var_323_6 > 0 and var_323_1 < var_323_6 then
					arg_320_1.talkMaxDuration = var_323_6

					if var_323_6 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_6 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_3
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_7 and arg_320_1.time_ < var_323_0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play121511086 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 121511086
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play121511087(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 0.6

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_2 = arg_324_1:FormatText(StoryNameCfg[7].name)

				arg_324_1.leftNameTxt_.text = var_327_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_3 = arg_324_1:GetWordFromCfg(121511086)
				local var_327_4 = arg_324_1:FormatText(var_327_3.content)

				arg_324_1.text_.text = var_327_4

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 24
				local var_327_6 = utf8.len(var_327_4)
				local var_327_7 = var_327_5 <= 0 and var_327_1 or var_327_1 * (var_327_6 / var_327_5)

				if var_327_7 > 0 and var_327_1 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_4
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_8 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_8 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_8

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_8 and arg_324_1.time_ < var_327_0 + var_327_8 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play121511087 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 121511087
		arg_328_1.duration_ = 8.07

		local var_328_0 = {
			ja = 7.7,
			ko = 8.066,
			zh = 8.066
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play121511088(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["10042ui_story"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect10042ui_story == nil then
				arg_328_1.var_.characterEffect10042ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.characterEffect10042ui_story and not isNil(var_331_0) then
					arg_328_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect10042ui_story then
				arg_328_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_331_4 = 0
			local var_331_5 = 0.5

			if var_331_4 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_6 = arg_328_1:FormatText(StoryNameCfg[388].name)

				arg_328_1.leftNameTxt_.text = var_331_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_7 = arg_328_1:GetWordFromCfg(121511087)
				local var_331_8 = arg_328_1:FormatText(var_331_7.content)

				arg_328_1.text_.text = var_331_8

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_9 = 20
				local var_331_10 = utf8.len(var_331_8)
				local var_331_11 = var_331_9 <= 0 and var_331_5 or var_331_5 * (var_331_10 / var_331_9)

				if var_331_11 > 0 and var_331_5 < var_331_11 then
					arg_328_1.talkMaxDuration = var_331_11

					if var_331_11 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_11 + var_331_4
					end
				end

				arg_328_1.text_.text = var_331_8
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511087", "story_v_out_121511.awb") ~= 0 then
					local var_331_12 = manager.audio:GetVoiceLength("story_v_out_121511", "121511087", "story_v_out_121511.awb") / 1000

					if var_331_12 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_12 + var_331_4
					end

					if var_331_7.prefab_name ~= "" and arg_328_1.actors_[var_331_7.prefab_name] ~= nil then
						local var_331_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_7.prefab_name].transform, "story_v_out_121511", "121511087", "story_v_out_121511.awb")

						arg_328_1:RecordAudio("121511087", var_331_13)
						arg_328_1:RecordAudio("121511087", var_331_13)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_121511", "121511087", "story_v_out_121511.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_121511", "121511087", "story_v_out_121511.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_14 = math.max(var_331_5, arg_328_1.talkMaxDuration)

			if var_331_4 <= arg_328_1.time_ and arg_328_1.time_ < var_331_4 + var_331_14 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_4) / var_331_14

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_4 + var_331_14 and arg_328_1.time_ < var_331_4 + var_331_14 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play121511088 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 121511088
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play121511089(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["10042ui_story"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect10042ui_story == nil then
				arg_332_1.var_.characterEffect10042ui_story = var_335_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.200000002980232

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.characterEffect10042ui_story and not isNil(var_335_0) then
					local var_335_4 = Mathf.Lerp(0, 0.5, var_335_3)

					arg_332_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_332_1.var_.characterEffect10042ui_story.fillRatio = var_335_4
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect10042ui_story then
				local var_335_5 = 0.5

				arg_332_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_332_1.var_.characterEffect10042ui_story.fillRatio = var_335_5
			end

			local var_335_6 = 0
			local var_335_7 = 0.8

			if var_335_6 < arg_332_1.time_ and arg_332_1.time_ <= var_335_6 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_8 = arg_332_1:FormatText(StoryNameCfg[7].name)

				arg_332_1.leftNameTxt_.text = var_335_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_9 = arg_332_1:GetWordFromCfg(121511088)
				local var_335_10 = arg_332_1:FormatText(var_335_9.content)

				arg_332_1.text_.text = var_335_10

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_11 = 32
				local var_335_12 = utf8.len(var_335_10)
				local var_335_13 = var_335_11 <= 0 and var_335_7 or var_335_7 * (var_335_12 / var_335_11)

				if var_335_13 > 0 and var_335_7 < var_335_13 then
					arg_332_1.talkMaxDuration = var_335_13

					if var_335_13 + var_335_6 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_13 + var_335_6
					end
				end

				arg_332_1.text_.text = var_335_10
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_14 = math.max(var_335_7, arg_332_1.talkMaxDuration)

			if var_335_6 <= arg_332_1.time_ and arg_332_1.time_ < var_335_6 + var_335_14 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_6) / var_335_14

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_6 + var_335_14 and arg_332_1.time_ < var_335_6 + var_335_14 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play121511089 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 121511089
		arg_336_1.duration_ = 15.2

		local var_336_0 = {
			ja = 13.133,
			ko = 15.2,
			zh = 15.2
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
				arg_336_0:Play121511090(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["10042ui_story"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect10042ui_story == nil then
				arg_336_1.var_.characterEffect10042ui_story = var_339_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.characterEffect10042ui_story and not isNil(var_339_0) then
					arg_336_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect10042ui_story then
				arg_336_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_339_4 = 0

			if var_339_4 < arg_336_1.time_ and arg_336_1.time_ <= var_339_4 + arg_339_0 then
				arg_336_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042actionlink/10042action423")
			end

			local var_339_5 = 0

			if var_339_5 < arg_336_1.time_ and arg_336_1.time_ <= var_339_5 + arg_339_0 then
				arg_336_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_339_6 = 0
			local var_339_7 = 1.325

			if var_339_6 < arg_336_1.time_ and arg_336_1.time_ <= var_339_6 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_8 = arg_336_1:FormatText(StoryNameCfg[388].name)

				arg_336_1.leftNameTxt_.text = var_339_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_9 = arg_336_1:GetWordFromCfg(121511089)
				local var_339_10 = arg_336_1:FormatText(var_339_9.content)

				arg_336_1.text_.text = var_339_10

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_11 = 53
				local var_339_12 = utf8.len(var_339_10)
				local var_339_13 = var_339_11 <= 0 and var_339_7 or var_339_7 * (var_339_12 / var_339_11)

				if var_339_13 > 0 and var_339_7 < var_339_13 then
					arg_336_1.talkMaxDuration = var_339_13

					if var_339_13 + var_339_6 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_13 + var_339_6
					end
				end

				arg_336_1.text_.text = var_339_10
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511089", "story_v_out_121511.awb") ~= 0 then
					local var_339_14 = manager.audio:GetVoiceLength("story_v_out_121511", "121511089", "story_v_out_121511.awb") / 1000

					if var_339_14 + var_339_6 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_14 + var_339_6
					end

					if var_339_9.prefab_name ~= "" and arg_336_1.actors_[var_339_9.prefab_name] ~= nil then
						local var_339_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_9.prefab_name].transform, "story_v_out_121511", "121511089", "story_v_out_121511.awb")

						arg_336_1:RecordAudio("121511089", var_339_15)
						arg_336_1:RecordAudio("121511089", var_339_15)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_121511", "121511089", "story_v_out_121511.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_121511", "121511089", "story_v_out_121511.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_16 = math.max(var_339_7, arg_336_1.talkMaxDuration)

			if var_339_6 <= arg_336_1.time_ and arg_336_1.time_ < var_339_6 + var_339_16 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_6) / var_339_16

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_6 + var_339_16 and arg_336_1.time_ < var_339_6 + var_339_16 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play121511090 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 121511090
		arg_340_1.duration_ = 13.77

		local var_340_0 = {
			ja = 13,
			ko = 13.766,
			zh = 13.766
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play121511091(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 1.125

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_2 = arg_340_1:FormatText(StoryNameCfg[388].name)

				arg_340_1.leftNameTxt_.text = var_343_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_3 = arg_340_1:GetWordFromCfg(121511090)
				local var_343_4 = arg_340_1:FormatText(var_343_3.content)

				arg_340_1.text_.text = var_343_4

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_5 = 45
				local var_343_6 = utf8.len(var_343_4)
				local var_343_7 = var_343_5 <= 0 and var_343_1 or var_343_1 * (var_343_6 / var_343_5)

				if var_343_7 > 0 and var_343_1 < var_343_7 then
					arg_340_1.talkMaxDuration = var_343_7

					if var_343_7 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_4
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511090", "story_v_out_121511.awb") ~= 0 then
					local var_343_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511090", "story_v_out_121511.awb") / 1000

					if var_343_8 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_8 + var_343_0
					end

					if var_343_3.prefab_name ~= "" and arg_340_1.actors_[var_343_3.prefab_name] ~= nil then
						local var_343_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_3.prefab_name].transform, "story_v_out_121511", "121511090", "story_v_out_121511.awb")

						arg_340_1:RecordAudio("121511090", var_343_9)
						arg_340_1:RecordAudio("121511090", var_343_9)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_121511", "121511090", "story_v_out_121511.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_121511", "121511090", "story_v_out_121511.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_10 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_10 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_10

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_10 and arg_340_1.time_ < var_343_0 + var_343_10 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play121511091 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 121511091
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play121511092(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["10042ui_story"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect10042ui_story == nil then
				arg_344_1.var_.characterEffect10042ui_story = var_347_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.characterEffect10042ui_story and not isNil(var_347_0) then
					local var_347_4 = Mathf.Lerp(0, 0.5, var_347_3)

					arg_344_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_344_1.var_.characterEffect10042ui_story.fillRatio = var_347_4
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect10042ui_story then
				local var_347_5 = 0.5

				arg_344_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_344_1.var_.characterEffect10042ui_story.fillRatio = var_347_5
			end

			local var_347_6 = 0
			local var_347_7 = 0.8

			if var_347_6 < arg_344_1.time_ and arg_344_1.time_ <= var_347_6 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_8 = arg_344_1:FormatText(StoryNameCfg[7].name)

				arg_344_1.leftNameTxt_.text = var_347_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_9 = arg_344_1:GetWordFromCfg(121511091)
				local var_347_10 = arg_344_1:FormatText(var_347_9.content)

				arg_344_1.text_.text = var_347_10

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_11 = 32
				local var_347_12 = utf8.len(var_347_10)
				local var_347_13 = var_347_11 <= 0 and var_347_7 or var_347_7 * (var_347_12 / var_347_11)

				if var_347_13 > 0 and var_347_7 < var_347_13 then
					arg_344_1.talkMaxDuration = var_347_13

					if var_347_13 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_13 + var_347_6
					end
				end

				arg_344_1.text_.text = var_347_10
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_14 = math.max(var_347_7, arg_344_1.talkMaxDuration)

			if var_347_6 <= arg_344_1.time_ and arg_344_1.time_ < var_347_6 + var_347_14 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_6) / var_347_14

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_6 + var_347_14 and arg_344_1.time_ < var_347_6 + var_347_14 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play121511092 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 121511092
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play121511093(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 1.25

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[7].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_3 = arg_348_1:GetWordFromCfg(121511092)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 50
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_8 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_8 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_8

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_8 and arg_348_1.time_ < var_351_0 + var_351_8 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play121511093 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 121511093
		arg_352_1.duration_ = 7.33

		local var_352_0 = {
			ja = 7.333,
			ko = 3,
			zh = 3
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play121511094(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["10042ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect10042ui_story == nil then
				arg_352_1.var_.characterEffect10042ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect10042ui_story and not isNil(var_355_0) then
					arg_352_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect10042ui_story then
				arg_352_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_355_4 = 0

			if var_355_4 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042actionlink/10042action432")
			end

			local var_355_5 = 0

			if var_355_5 < arg_352_1.time_ and arg_352_1.time_ <= var_355_5 + arg_355_0 then
				arg_352_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_355_6 = 0
			local var_355_7 = 0.375

			if var_355_6 < arg_352_1.time_ and arg_352_1.time_ <= var_355_6 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_8 = arg_352_1:FormatText(StoryNameCfg[388].name)

				arg_352_1.leftNameTxt_.text = var_355_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_9 = arg_352_1:GetWordFromCfg(121511093)
				local var_355_10 = arg_352_1:FormatText(var_355_9.content)

				arg_352_1.text_.text = var_355_10

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_11 = 15
				local var_355_12 = utf8.len(var_355_10)
				local var_355_13 = var_355_11 <= 0 and var_355_7 or var_355_7 * (var_355_12 / var_355_11)

				if var_355_13 > 0 and var_355_7 < var_355_13 then
					arg_352_1.talkMaxDuration = var_355_13

					if var_355_13 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_13 + var_355_6
					end
				end

				arg_352_1.text_.text = var_355_10
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511093", "story_v_out_121511.awb") ~= 0 then
					local var_355_14 = manager.audio:GetVoiceLength("story_v_out_121511", "121511093", "story_v_out_121511.awb") / 1000

					if var_355_14 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_14 + var_355_6
					end

					if var_355_9.prefab_name ~= "" and arg_352_1.actors_[var_355_9.prefab_name] ~= nil then
						local var_355_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_9.prefab_name].transform, "story_v_out_121511", "121511093", "story_v_out_121511.awb")

						arg_352_1:RecordAudio("121511093", var_355_15)
						arg_352_1:RecordAudio("121511093", var_355_15)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_121511", "121511093", "story_v_out_121511.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_121511", "121511093", "story_v_out_121511.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_16 = math.max(var_355_7, arg_352_1.talkMaxDuration)

			if var_355_6 <= arg_352_1.time_ and arg_352_1.time_ < var_355_6 + var_355_16 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_6) / var_355_16

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_6 + var_355_16 and arg_352_1.time_ < var_355_6 + var_355_16 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play121511094 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 121511094
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play121511095(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["10042ui_story"]
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect10042ui_story == nil then
				arg_356_1.var_.characterEffect10042ui_story = var_359_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.200000002980232

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.characterEffect10042ui_story and not isNil(var_359_0) then
					local var_359_4 = Mathf.Lerp(0, 0.5, var_359_3)

					arg_356_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_356_1.var_.characterEffect10042ui_story.fillRatio = var_359_4
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect10042ui_story then
				local var_359_5 = 0.5

				arg_356_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_356_1.var_.characterEffect10042ui_story.fillRatio = var_359_5
			end

			local var_359_6 = 0
			local var_359_7 = 1.05

			if var_359_6 < arg_356_1.time_ and arg_356_1.time_ <= var_359_6 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_8 = arg_356_1:FormatText(StoryNameCfg[7].name)

				arg_356_1.leftNameTxt_.text = var_359_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_9 = arg_356_1:GetWordFromCfg(121511094)
				local var_359_10 = arg_356_1:FormatText(var_359_9.content)

				arg_356_1.text_.text = var_359_10

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_11 = 42
				local var_359_12 = utf8.len(var_359_10)
				local var_359_13 = var_359_11 <= 0 and var_359_7 or var_359_7 * (var_359_12 / var_359_11)

				if var_359_13 > 0 and var_359_7 < var_359_13 then
					arg_356_1.talkMaxDuration = var_359_13

					if var_359_13 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_13 + var_359_6
					end
				end

				arg_356_1.text_.text = var_359_10
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_14 = math.max(var_359_7, arg_356_1.talkMaxDuration)

			if var_359_6 <= arg_356_1.time_ and arg_356_1.time_ < var_359_6 + var_359_14 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_6) / var_359_14

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_6 + var_359_14 and arg_356_1.time_ < var_359_6 + var_359_14 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play121511095 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 121511095
		arg_360_1.duration_ = 4.2

		local var_360_0 = {
			ja = 4.2,
			ko = 2.066,
			zh = 2.066
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play121511096(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["10042ui_story"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect10042ui_story == nil then
				arg_360_1.var_.characterEffect10042ui_story = var_363_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.characterEffect10042ui_story and not isNil(var_363_0) then
					arg_360_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect10042ui_story then
				arg_360_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_363_4 = 0
			local var_363_5 = 0.1

			if var_363_4 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_6 = arg_360_1:FormatText(StoryNameCfg[388].name)

				arg_360_1.leftNameTxt_.text = var_363_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_7 = arg_360_1:GetWordFromCfg(121511095)
				local var_363_8 = arg_360_1:FormatText(var_363_7.content)

				arg_360_1.text_.text = var_363_8

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_9 = 4
				local var_363_10 = utf8.len(var_363_8)
				local var_363_11 = var_363_9 <= 0 and var_363_5 or var_363_5 * (var_363_10 / var_363_9)

				if var_363_11 > 0 and var_363_5 < var_363_11 then
					arg_360_1.talkMaxDuration = var_363_11

					if var_363_11 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_11 + var_363_4
					end
				end

				arg_360_1.text_.text = var_363_8
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511095", "story_v_out_121511.awb") ~= 0 then
					local var_363_12 = manager.audio:GetVoiceLength("story_v_out_121511", "121511095", "story_v_out_121511.awb") / 1000

					if var_363_12 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_12 + var_363_4
					end

					if var_363_7.prefab_name ~= "" and arg_360_1.actors_[var_363_7.prefab_name] ~= nil then
						local var_363_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_7.prefab_name].transform, "story_v_out_121511", "121511095", "story_v_out_121511.awb")

						arg_360_1:RecordAudio("121511095", var_363_13)
						arg_360_1:RecordAudio("121511095", var_363_13)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_121511", "121511095", "story_v_out_121511.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_121511", "121511095", "story_v_out_121511.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_14 = math.max(var_363_5, arg_360_1.talkMaxDuration)

			if var_363_4 <= arg_360_1.time_ and arg_360_1.time_ < var_363_4 + var_363_14 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_4) / var_363_14

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_4 + var_363_14 and arg_360_1.time_ < var_363_4 + var_363_14 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play121511096 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 121511096
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play121511097(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["10042ui_story"]
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect10042ui_story == nil then
				arg_364_1.var_.characterEffect10042ui_story = var_367_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_2 = 0.200000002980232

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 and not isNil(var_367_0) then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2

				if arg_364_1.var_.characterEffect10042ui_story and not isNil(var_367_0) then
					local var_367_4 = Mathf.Lerp(0, 0.5, var_367_3)

					arg_364_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_364_1.var_.characterEffect10042ui_story.fillRatio = var_367_4
				end
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect10042ui_story then
				local var_367_5 = 0.5

				arg_364_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_364_1.var_.characterEffect10042ui_story.fillRatio = var_367_5
			end

			local var_367_6 = 0
			local var_367_7 = 0.8

			if var_367_6 < arg_364_1.time_ and arg_364_1.time_ <= var_367_6 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_8 = arg_364_1:GetWordFromCfg(121511096)
				local var_367_9 = arg_364_1:FormatText(var_367_8.content)

				arg_364_1.text_.text = var_367_9

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_10 = 32
				local var_367_11 = utf8.len(var_367_9)
				local var_367_12 = var_367_10 <= 0 and var_367_7 or var_367_7 * (var_367_11 / var_367_10)

				if var_367_12 > 0 and var_367_7 < var_367_12 then
					arg_364_1.talkMaxDuration = var_367_12

					if var_367_12 + var_367_6 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_12 + var_367_6
					end
				end

				arg_364_1.text_.text = var_367_9
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_13 = math.max(var_367_7, arg_364_1.talkMaxDuration)

			if var_367_6 <= arg_364_1.time_ and arg_364_1.time_ < var_367_6 + var_367_13 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_6) / var_367_13

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_6 + var_367_13 and arg_364_1.time_ < var_367_6 + var_367_13 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play121511097 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 121511097
		arg_368_1.duration_ = 9.03

		local var_368_0 = {
			ja = 6.8,
			ko = 9.033,
			zh = 9.033
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
				arg_368_0:Play121511098(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["10042ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10042ui_story == nil then
				arg_368_1.var_.characterEffect10042ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect10042ui_story and not isNil(var_371_0) then
					arg_368_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10042ui_story then
				arg_368_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_371_4 = 0
			local var_371_5 = 0.925

			if var_371_4 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_6 = arg_368_1:FormatText(StoryNameCfg[388].name)

				arg_368_1.leftNameTxt_.text = var_371_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_7 = arg_368_1:GetWordFromCfg(121511097)
				local var_371_8 = arg_368_1:FormatText(var_371_7.content)

				arg_368_1.text_.text = var_371_8

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_9 = 37
				local var_371_10 = utf8.len(var_371_8)
				local var_371_11 = var_371_9 <= 0 and var_371_5 or var_371_5 * (var_371_10 / var_371_9)

				if var_371_11 > 0 and var_371_5 < var_371_11 then
					arg_368_1.talkMaxDuration = var_371_11

					if var_371_11 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_11 + var_371_4
					end
				end

				arg_368_1.text_.text = var_371_8
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511097", "story_v_out_121511.awb") ~= 0 then
					local var_371_12 = manager.audio:GetVoiceLength("story_v_out_121511", "121511097", "story_v_out_121511.awb") / 1000

					if var_371_12 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_12 + var_371_4
					end

					if var_371_7.prefab_name ~= "" and arg_368_1.actors_[var_371_7.prefab_name] ~= nil then
						local var_371_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_7.prefab_name].transform, "story_v_out_121511", "121511097", "story_v_out_121511.awb")

						arg_368_1:RecordAudio("121511097", var_371_13)
						arg_368_1:RecordAudio("121511097", var_371_13)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_121511", "121511097", "story_v_out_121511.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_121511", "121511097", "story_v_out_121511.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_14 = math.max(var_371_5, arg_368_1.talkMaxDuration)

			if var_371_4 <= arg_368_1.time_ and arg_368_1.time_ < var_371_4 + var_371_14 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_4) / var_371_14

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_4 + var_371_14 and arg_368_1.time_ < var_371_4 + var_371_14 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play121511098 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 121511098
		arg_372_1.duration_ = 13.3

		local var_372_0 = {
			ja = 13.3,
			ko = 11.4,
			zh = 11.4
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
				arg_372_0:Play121511099(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042actionlink/10042action423")
			end

			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_375_2 = 0
			local var_375_3 = 1.2

			if var_375_2 < arg_372_1.time_ and arg_372_1.time_ <= var_375_2 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_4 = arg_372_1:FormatText(StoryNameCfg[388].name)

				arg_372_1.leftNameTxt_.text = var_375_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_5 = arg_372_1:GetWordFromCfg(121511098)
				local var_375_6 = arg_372_1:FormatText(var_375_5.content)

				arg_372_1.text_.text = var_375_6

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_7 = 48
				local var_375_8 = utf8.len(var_375_6)
				local var_375_9 = var_375_7 <= 0 and var_375_3 or var_375_3 * (var_375_8 / var_375_7)

				if var_375_9 > 0 and var_375_3 < var_375_9 then
					arg_372_1.talkMaxDuration = var_375_9

					if var_375_9 + var_375_2 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_9 + var_375_2
					end
				end

				arg_372_1.text_.text = var_375_6
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511098", "story_v_out_121511.awb") ~= 0 then
					local var_375_10 = manager.audio:GetVoiceLength("story_v_out_121511", "121511098", "story_v_out_121511.awb") / 1000

					if var_375_10 + var_375_2 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_10 + var_375_2
					end

					if var_375_5.prefab_name ~= "" and arg_372_1.actors_[var_375_5.prefab_name] ~= nil then
						local var_375_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_5.prefab_name].transform, "story_v_out_121511", "121511098", "story_v_out_121511.awb")

						arg_372_1:RecordAudio("121511098", var_375_11)
						arg_372_1:RecordAudio("121511098", var_375_11)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_121511", "121511098", "story_v_out_121511.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_121511", "121511098", "story_v_out_121511.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_12 = math.max(var_375_3, arg_372_1.talkMaxDuration)

			if var_375_2 <= arg_372_1.time_ and arg_372_1.time_ < var_375_2 + var_375_12 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_2) / var_375_12

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_2 + var_375_12 and arg_372_1.time_ < var_375_2 + var_375_12 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play121511099 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 121511099
		arg_376_1.duration_ = 6.2

		local var_376_0 = {
			ja = 6.2,
			ko = 4.9,
			zh = 4.9
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
				arg_376_0:Play121511100(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 0.45

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_2 = arg_376_1:FormatText(StoryNameCfg[388].name)

				arg_376_1.leftNameTxt_.text = var_379_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_3 = arg_376_1:GetWordFromCfg(121511099)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511099", "story_v_out_121511.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511099", "story_v_out_121511.awb") / 1000

					if var_379_8 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_0
					end

					if var_379_3.prefab_name ~= "" and arg_376_1.actors_[var_379_3.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_3.prefab_name].transform, "story_v_out_121511", "121511099", "story_v_out_121511.awb")

						arg_376_1:RecordAudio("121511099", var_379_9)
						arg_376_1:RecordAudio("121511099", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_121511", "121511099", "story_v_out_121511.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_121511", "121511099", "story_v_out_121511.awb")
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
	Play121511100 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 121511100
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play121511101(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["10042ui_story"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect10042ui_story == nil then
				arg_380_1.var_.characterEffect10042ui_story = var_383_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.2

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.characterEffect10042ui_story and not isNil(var_383_0) then
					local var_383_4 = Mathf.Lerp(0, 0.5, var_383_3)

					arg_380_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_380_1.var_.characterEffect10042ui_story.fillRatio = var_383_4
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect10042ui_story then
				local var_383_5 = 0.5

				arg_380_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_380_1.var_.characterEffect10042ui_story.fillRatio = var_383_5
			end

			local var_383_6 = 0
			local var_383_7 = 0.6

			if var_383_6 < arg_380_1.time_ and arg_380_1.time_ <= var_383_6 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_8 = arg_380_1:FormatText(StoryNameCfg[7].name)

				arg_380_1.leftNameTxt_.text = var_383_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_9 = arg_380_1:GetWordFromCfg(121511100)
				local var_383_10 = arg_380_1:FormatText(var_383_9.content)

				arg_380_1.text_.text = var_383_10

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_11 = 24
				local var_383_12 = utf8.len(var_383_10)
				local var_383_13 = var_383_11 <= 0 and var_383_7 or var_383_7 * (var_383_12 / var_383_11)

				if var_383_13 > 0 and var_383_7 < var_383_13 then
					arg_380_1.talkMaxDuration = var_383_13

					if var_383_13 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_13 + var_383_6
					end
				end

				arg_380_1.text_.text = var_383_10
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_14 = math.max(var_383_7, arg_380_1.talkMaxDuration)

			if var_383_6 <= arg_380_1.time_ and arg_380_1.time_ < var_383_6 + var_383_14 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_6) / var_383_14

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_6 + var_383_14 and arg_380_1.time_ < var_383_6 + var_383_14 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play121511101 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 121511101
		arg_384_1.duration_ = 13.63

		local var_384_0 = {
			ja = 13.633,
			ko = 12.233,
			zh = 12.233
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
				arg_384_0:Play121511102(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["10042ui_story"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect10042ui_story == nil then
				arg_384_1.var_.characterEffect10042ui_story = var_387_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.characterEffect10042ui_story and not isNil(var_387_0) then
					arg_384_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect10042ui_story then
				arg_384_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_387_4 = 0

			if var_387_4 < arg_384_1.time_ and arg_384_1.time_ <= var_387_4 + arg_387_0 then
				arg_384_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042actionlink/10042action432")
			end

			local var_387_5 = 0

			if var_387_5 < arg_384_1.time_ and arg_384_1.time_ <= var_387_5 + arg_387_0 then
				arg_384_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_387_6 = 0
			local var_387_7 = 0.85

			if var_387_6 < arg_384_1.time_ and arg_384_1.time_ <= var_387_6 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_8 = arg_384_1:FormatText(StoryNameCfg[388].name)

				arg_384_1.leftNameTxt_.text = var_387_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_9 = arg_384_1:GetWordFromCfg(121511101)
				local var_387_10 = arg_384_1:FormatText(var_387_9.content)

				arg_384_1.text_.text = var_387_10

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_11 = 34
				local var_387_12 = utf8.len(var_387_10)
				local var_387_13 = var_387_11 <= 0 and var_387_7 or var_387_7 * (var_387_12 / var_387_11)

				if var_387_13 > 0 and var_387_7 < var_387_13 then
					arg_384_1.talkMaxDuration = var_387_13

					if var_387_13 + var_387_6 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_13 + var_387_6
					end
				end

				arg_384_1.text_.text = var_387_10
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511101", "story_v_out_121511.awb") ~= 0 then
					local var_387_14 = manager.audio:GetVoiceLength("story_v_out_121511", "121511101", "story_v_out_121511.awb") / 1000

					if var_387_14 + var_387_6 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_14 + var_387_6
					end

					if var_387_9.prefab_name ~= "" and arg_384_1.actors_[var_387_9.prefab_name] ~= nil then
						local var_387_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_9.prefab_name].transform, "story_v_out_121511", "121511101", "story_v_out_121511.awb")

						arg_384_1:RecordAudio("121511101", var_387_15)
						arg_384_1:RecordAudio("121511101", var_387_15)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_121511", "121511101", "story_v_out_121511.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_121511", "121511101", "story_v_out_121511.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_16 = math.max(var_387_7, arg_384_1.talkMaxDuration)

			if var_387_6 <= arg_384_1.time_ and arg_384_1.time_ < var_387_6 + var_387_16 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_6) / var_387_16

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_6 + var_387_16 and arg_384_1.time_ < var_387_6 + var_387_16 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play121511102 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 121511102
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play121511103(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["10042ui_story"].transform
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.var_.moveOldPos10042ui_story = var_391_0.localPosition
			end

			local var_391_2 = 0.001

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2
				local var_391_4 = Vector3.New(0, 100, 0)

				var_391_0.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10042ui_story, var_391_4, var_391_3)

				local var_391_5 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_5.x, var_391_5.y, var_391_5.z)

				local var_391_6 = var_391_0.localEulerAngles

				var_391_6.z = 0
				var_391_6.x = 0
				var_391_0.localEulerAngles = var_391_6
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 then
				var_391_0.localPosition = Vector3.New(0, 100, 0)

				local var_391_7 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_7.x, var_391_7.y, var_391_7.z)

				local var_391_8 = var_391_0.localEulerAngles

				var_391_8.z = 0
				var_391_8.x = 0
				var_391_0.localEulerAngles = var_391_8
			end

			local var_391_9 = arg_388_1.actors_["10042ui_story"]
			local var_391_10 = 0

			if var_391_10 < arg_388_1.time_ and arg_388_1.time_ <= var_391_10 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect10042ui_story == nil then
				arg_388_1.var_.characterEffect10042ui_story = var_391_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_11 = 0.200000002980232

			if var_391_10 <= arg_388_1.time_ and arg_388_1.time_ < var_391_10 + var_391_11 and not isNil(var_391_9) then
				local var_391_12 = (arg_388_1.time_ - var_391_10) / var_391_11

				if arg_388_1.var_.characterEffect10042ui_story and not isNil(var_391_9) then
					local var_391_13 = Mathf.Lerp(0, 0.5, var_391_12)

					arg_388_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_388_1.var_.characterEffect10042ui_story.fillRatio = var_391_13
				end
			end

			if arg_388_1.time_ >= var_391_10 + var_391_11 and arg_388_1.time_ < var_391_10 + var_391_11 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect10042ui_story then
				local var_391_14 = 0.5

				arg_388_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_388_1.var_.characterEffect10042ui_story.fillRatio = var_391_14
			end

			local var_391_15 = 0
			local var_391_16 = 1.7

			if var_391_15 < arg_388_1.time_ and arg_388_1.time_ <= var_391_15 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_17 = arg_388_1:GetWordFromCfg(121511102)
				local var_391_18 = arg_388_1:FormatText(var_391_17.content)

				arg_388_1.text_.text = var_391_18

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_19 = 68
				local var_391_20 = utf8.len(var_391_18)
				local var_391_21 = var_391_19 <= 0 and var_391_16 or var_391_16 * (var_391_20 / var_391_19)

				if var_391_21 > 0 and var_391_16 < var_391_21 then
					arg_388_1.talkMaxDuration = var_391_21

					if var_391_21 + var_391_15 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_21 + var_391_15
					end
				end

				arg_388_1.text_.text = var_391_18
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_22 = math.max(var_391_16, arg_388_1.talkMaxDuration)

			if var_391_15 <= arg_388_1.time_ and arg_388_1.time_ < var_391_15 + var_391_22 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_15) / var_391_22

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_15 + var_391_22 and arg_388_1.time_ < var_391_15 + var_391_22 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play121511103 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 121511103
		arg_392_1.duration_ = 4.93

		local var_392_0 = {
			ja = 4.933,
			ko = 4.466,
			zh = 4.466
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
				arg_392_0:Play121511104(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1075ui_story"].transform
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.var_.moveOldPos1075ui_story = var_395_0.localPosition
			end

			local var_395_2 = 0.001

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2
				local var_395_4 = Vector3.New(-0.7, -1.055, -6.16)

				var_395_0.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1075ui_story, var_395_4, var_395_3)

				local var_395_5 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_5.x, var_395_5.y, var_395_5.z)

				local var_395_6 = var_395_0.localEulerAngles

				var_395_6.z = 0
				var_395_6.x = 0
				var_395_0.localEulerAngles = var_395_6
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 then
				var_395_0.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_395_7 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_7.x, var_395_7.y, var_395_7.z)

				local var_395_8 = var_395_0.localEulerAngles

				var_395_8.z = 0
				var_395_8.x = 0
				var_395_0.localEulerAngles = var_395_8
			end

			local var_395_9 = arg_392_1.actors_["1075ui_story"]
			local var_395_10 = 0

			if var_395_10 < arg_392_1.time_ and arg_392_1.time_ <= var_395_10 + arg_395_0 and not isNil(var_395_9) and arg_392_1.var_.characterEffect1075ui_story == nil then
				arg_392_1.var_.characterEffect1075ui_story = var_395_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_11 = 0.200000002980232

			if var_395_10 <= arg_392_1.time_ and arg_392_1.time_ < var_395_10 + var_395_11 and not isNil(var_395_9) then
				local var_395_12 = (arg_392_1.time_ - var_395_10) / var_395_11

				if arg_392_1.var_.characterEffect1075ui_story and not isNil(var_395_9) then
					arg_392_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_10 + var_395_11 and arg_392_1.time_ < var_395_10 + var_395_11 + arg_395_0 and not isNil(var_395_9) and arg_392_1.var_.characterEffect1075ui_story then
				arg_392_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_395_13 = 0

			if var_395_13 < arg_392_1.time_ and arg_392_1.time_ <= var_395_13 + arg_395_0 then
				arg_392_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_395_14 = 0

			if var_395_14 < arg_392_1.time_ and arg_392_1.time_ <= var_395_14 + arg_395_0 then
				arg_392_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_395_15 = arg_392_1.actors_["1184ui_story"].transform
			local var_395_16 = 0

			if var_395_16 < arg_392_1.time_ and arg_392_1.time_ <= var_395_16 + arg_395_0 then
				arg_392_1.var_.moveOldPos1184ui_story = var_395_15.localPosition
			end

			local var_395_17 = 0.001

			if var_395_16 <= arg_392_1.time_ and arg_392_1.time_ < var_395_16 + var_395_17 then
				local var_395_18 = (arg_392_1.time_ - var_395_16) / var_395_17
				local var_395_19 = Vector3.New(0.7, -0.97, -6)

				var_395_15.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1184ui_story, var_395_19, var_395_18)

				local var_395_20 = manager.ui.mainCamera.transform.position - var_395_15.position

				var_395_15.forward = Vector3.New(var_395_20.x, var_395_20.y, var_395_20.z)

				local var_395_21 = var_395_15.localEulerAngles

				var_395_21.z = 0
				var_395_21.x = 0
				var_395_15.localEulerAngles = var_395_21
			end

			if arg_392_1.time_ >= var_395_16 + var_395_17 and arg_392_1.time_ < var_395_16 + var_395_17 + arg_395_0 then
				var_395_15.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_395_22 = manager.ui.mainCamera.transform.position - var_395_15.position

				var_395_15.forward = Vector3.New(var_395_22.x, var_395_22.y, var_395_22.z)

				local var_395_23 = var_395_15.localEulerAngles

				var_395_23.z = 0
				var_395_23.x = 0
				var_395_15.localEulerAngles = var_395_23
			end

			local var_395_24 = arg_392_1.actors_["1184ui_story"]
			local var_395_25 = 0

			if var_395_25 < arg_392_1.time_ and arg_392_1.time_ <= var_395_25 + arg_395_0 and not isNil(var_395_24) and arg_392_1.var_.characterEffect1184ui_story == nil then
				arg_392_1.var_.characterEffect1184ui_story = var_395_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_26 = 0.200000002980232

			if var_395_25 <= arg_392_1.time_ and arg_392_1.time_ < var_395_25 + var_395_26 and not isNil(var_395_24) then
				local var_395_27 = (arg_392_1.time_ - var_395_25) / var_395_26

				if arg_392_1.var_.characterEffect1184ui_story and not isNil(var_395_24) then
					local var_395_28 = Mathf.Lerp(0, 0.5, var_395_27)

					arg_392_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_392_1.var_.characterEffect1184ui_story.fillRatio = var_395_28
				end
			end

			if arg_392_1.time_ >= var_395_25 + var_395_26 and arg_392_1.time_ < var_395_25 + var_395_26 + arg_395_0 and not isNil(var_395_24) and arg_392_1.var_.characterEffect1184ui_story then
				local var_395_29 = 0.5

				arg_392_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_392_1.var_.characterEffect1184ui_story.fillRatio = var_395_29
			end

			local var_395_30 = 0

			if var_395_30 < arg_392_1.time_ and arg_392_1.time_ <= var_395_30 + arg_395_0 then
				arg_392_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_395_31 = 0

			if var_395_31 < arg_392_1.time_ and arg_392_1.time_ <= var_395_31 + arg_395_0 then
				arg_392_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_395_32 = 0
			local var_395_33 = 0.575

			if var_395_32 < arg_392_1.time_ and arg_392_1.time_ <= var_395_32 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_34 = arg_392_1:FormatText(StoryNameCfg[381].name)

				arg_392_1.leftNameTxt_.text = var_395_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_35 = arg_392_1:GetWordFromCfg(121511103)
				local var_395_36 = arg_392_1:FormatText(var_395_35.content)

				arg_392_1.text_.text = var_395_36

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_37 = 23
				local var_395_38 = utf8.len(var_395_36)
				local var_395_39 = var_395_37 <= 0 and var_395_33 or var_395_33 * (var_395_38 / var_395_37)

				if var_395_39 > 0 and var_395_33 < var_395_39 then
					arg_392_1.talkMaxDuration = var_395_39

					if var_395_39 + var_395_32 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_39 + var_395_32
					end
				end

				arg_392_1.text_.text = var_395_36
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511103", "story_v_out_121511.awb") ~= 0 then
					local var_395_40 = manager.audio:GetVoiceLength("story_v_out_121511", "121511103", "story_v_out_121511.awb") / 1000

					if var_395_40 + var_395_32 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_40 + var_395_32
					end

					if var_395_35.prefab_name ~= "" and arg_392_1.actors_[var_395_35.prefab_name] ~= nil then
						local var_395_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_35.prefab_name].transform, "story_v_out_121511", "121511103", "story_v_out_121511.awb")

						arg_392_1:RecordAudio("121511103", var_395_41)
						arg_392_1:RecordAudio("121511103", var_395_41)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_121511", "121511103", "story_v_out_121511.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_121511", "121511103", "story_v_out_121511.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_42 = math.max(var_395_33, arg_392_1.talkMaxDuration)

			if var_395_32 <= arg_392_1.time_ and arg_392_1.time_ < var_395_32 + var_395_42 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_32) / var_395_42

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_32 + var_395_42 and arg_392_1.time_ < var_395_32 + var_395_42 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play121511104 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 121511104
		arg_396_1.duration_ = 8.17

		local var_396_0 = {
			ja = 8.166,
			ko = 4.266,
			zh = 4.266
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
				arg_396_0:Play121511105(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1184ui_story"].transform
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.var_.moveOldPos1184ui_story = var_399_0.localPosition
			end

			local var_399_2 = 0.001

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2
				local var_399_4 = Vector3.New(0.7, -0.97, -6)

				var_399_0.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1184ui_story, var_399_4, var_399_3)

				local var_399_5 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_5.x, var_399_5.y, var_399_5.z)

				local var_399_6 = var_399_0.localEulerAngles

				var_399_6.z = 0
				var_399_6.x = 0
				var_399_0.localEulerAngles = var_399_6
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 then
				var_399_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_399_7 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_7.x, var_399_7.y, var_399_7.z)

				local var_399_8 = var_399_0.localEulerAngles

				var_399_8.z = 0
				var_399_8.x = 0
				var_399_0.localEulerAngles = var_399_8
			end

			local var_399_9 = arg_396_1.actors_["1184ui_story"]
			local var_399_10 = 0

			if var_399_10 < arg_396_1.time_ and arg_396_1.time_ <= var_399_10 + arg_399_0 and not isNil(var_399_9) and arg_396_1.var_.characterEffect1184ui_story == nil then
				arg_396_1.var_.characterEffect1184ui_story = var_399_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_11 = 0.200000002980232

			if var_399_10 <= arg_396_1.time_ and arg_396_1.time_ < var_399_10 + var_399_11 and not isNil(var_399_9) then
				local var_399_12 = (arg_396_1.time_ - var_399_10) / var_399_11

				if arg_396_1.var_.characterEffect1184ui_story and not isNil(var_399_9) then
					arg_396_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= var_399_10 + var_399_11 and arg_396_1.time_ < var_399_10 + var_399_11 + arg_399_0 and not isNil(var_399_9) and arg_396_1.var_.characterEffect1184ui_story then
				arg_396_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_399_13 = 0

			if var_399_13 < arg_396_1.time_ and arg_396_1.time_ <= var_399_13 + arg_399_0 then
				arg_396_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_399_14 = arg_396_1.actors_["1075ui_story"]
			local var_399_15 = 0

			if var_399_15 < arg_396_1.time_ and arg_396_1.time_ <= var_399_15 + arg_399_0 and not isNil(var_399_14) and arg_396_1.var_.characterEffect1075ui_story == nil then
				arg_396_1.var_.characterEffect1075ui_story = var_399_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_16 = 0.200000002980232

			if var_399_15 <= arg_396_1.time_ and arg_396_1.time_ < var_399_15 + var_399_16 and not isNil(var_399_14) then
				local var_399_17 = (arg_396_1.time_ - var_399_15) / var_399_16

				if arg_396_1.var_.characterEffect1075ui_story and not isNil(var_399_14) then
					local var_399_18 = Mathf.Lerp(0, 0.5, var_399_17)

					arg_396_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1075ui_story.fillRatio = var_399_18
				end
			end

			if arg_396_1.time_ >= var_399_15 + var_399_16 and arg_396_1.time_ < var_399_15 + var_399_16 + arg_399_0 and not isNil(var_399_14) and arg_396_1.var_.characterEffect1075ui_story then
				local var_399_19 = 0.5

				arg_396_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1075ui_story.fillRatio = var_399_19
			end

			local var_399_20 = 0

			if var_399_20 < arg_396_1.time_ and arg_396_1.time_ <= var_399_20 + arg_399_0 then
				arg_396_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_399_21 = 0
			local var_399_22 = 0.55

			if var_399_21 < arg_396_1.time_ and arg_396_1.time_ <= var_399_21 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_23 = arg_396_1:FormatText(StoryNameCfg[6].name)

				arg_396_1.leftNameTxt_.text = var_399_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_24 = arg_396_1:GetWordFromCfg(121511104)
				local var_399_25 = arg_396_1:FormatText(var_399_24.content)

				arg_396_1.text_.text = var_399_25

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_26 = 22
				local var_399_27 = utf8.len(var_399_25)
				local var_399_28 = var_399_26 <= 0 and var_399_22 or var_399_22 * (var_399_27 / var_399_26)

				if var_399_28 > 0 and var_399_22 < var_399_28 then
					arg_396_1.talkMaxDuration = var_399_28

					if var_399_28 + var_399_21 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_28 + var_399_21
					end
				end

				arg_396_1.text_.text = var_399_25
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511104", "story_v_out_121511.awb") ~= 0 then
					local var_399_29 = manager.audio:GetVoiceLength("story_v_out_121511", "121511104", "story_v_out_121511.awb") / 1000

					if var_399_29 + var_399_21 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_29 + var_399_21
					end

					if var_399_24.prefab_name ~= "" and arg_396_1.actors_[var_399_24.prefab_name] ~= nil then
						local var_399_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_24.prefab_name].transform, "story_v_out_121511", "121511104", "story_v_out_121511.awb")

						arg_396_1:RecordAudio("121511104", var_399_30)
						arg_396_1:RecordAudio("121511104", var_399_30)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_121511", "121511104", "story_v_out_121511.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_121511", "121511104", "story_v_out_121511.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_31 = math.max(var_399_22, arg_396_1.talkMaxDuration)

			if var_399_21 <= arg_396_1.time_ and arg_396_1.time_ < var_399_21 + var_399_31 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_21) / var_399_31

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_21 + var_399_31 and arg_396_1.time_ < var_399_21 + var_399_31 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play121511105 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 121511105
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play121511106(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["1184ui_story"].transform
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.var_.moveOldPos1184ui_story = var_403_0.localPosition

				local var_403_2 = "1184ui_story"

				arg_400_1:ShowWeapon(arg_400_1.var_[var_403_2 .. "Animator"].transform, false)
			end

			local var_403_3 = 0.001

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_3 then
				local var_403_4 = (arg_400_1.time_ - var_403_1) / var_403_3
				local var_403_5 = Vector3.New(0, 100, 0)

				var_403_0.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1184ui_story, var_403_5, var_403_4)

				local var_403_6 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_6.x, var_403_6.y, var_403_6.z)

				local var_403_7 = var_403_0.localEulerAngles

				var_403_7.z = 0
				var_403_7.x = 0
				var_403_0.localEulerAngles = var_403_7
			end

			if arg_400_1.time_ >= var_403_1 + var_403_3 and arg_400_1.time_ < var_403_1 + var_403_3 + arg_403_0 then
				var_403_0.localPosition = Vector3.New(0, 100, 0)

				local var_403_8 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_8.x, var_403_8.y, var_403_8.z)

				local var_403_9 = var_403_0.localEulerAngles

				var_403_9.z = 0
				var_403_9.x = 0
				var_403_0.localEulerAngles = var_403_9
			end

			local var_403_10 = arg_400_1.actors_["1184ui_story"]
			local var_403_11 = 0

			if var_403_11 < arg_400_1.time_ and arg_400_1.time_ <= var_403_11 + arg_403_0 and not isNil(var_403_10) and arg_400_1.var_.characterEffect1184ui_story == nil then
				arg_400_1.var_.characterEffect1184ui_story = var_403_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_12 = 0.200000002980232

			if var_403_11 <= arg_400_1.time_ and arg_400_1.time_ < var_403_11 + var_403_12 and not isNil(var_403_10) then
				local var_403_13 = (arg_400_1.time_ - var_403_11) / var_403_12

				if arg_400_1.var_.characterEffect1184ui_story and not isNil(var_403_10) then
					local var_403_14 = Mathf.Lerp(0, 0.5, var_403_13)

					arg_400_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_400_1.var_.characterEffect1184ui_story.fillRatio = var_403_14
				end
			end

			if arg_400_1.time_ >= var_403_11 + var_403_12 and arg_400_1.time_ < var_403_11 + var_403_12 + arg_403_0 and not isNil(var_403_10) and arg_400_1.var_.characterEffect1184ui_story then
				local var_403_15 = 0.5

				arg_400_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_400_1.var_.characterEffect1184ui_story.fillRatio = var_403_15
			end

			local var_403_16 = arg_400_1.actors_["1075ui_story"].transform
			local var_403_17 = 0

			if var_403_17 < arg_400_1.time_ and arg_400_1.time_ <= var_403_17 + arg_403_0 then
				arg_400_1.var_.moveOldPos1075ui_story = var_403_16.localPosition
			end

			local var_403_18 = 0.001

			if var_403_17 <= arg_400_1.time_ and arg_400_1.time_ < var_403_17 + var_403_18 then
				local var_403_19 = (arg_400_1.time_ - var_403_17) / var_403_18
				local var_403_20 = Vector3.New(0, 100, 0)

				var_403_16.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1075ui_story, var_403_20, var_403_19)

				local var_403_21 = manager.ui.mainCamera.transform.position - var_403_16.position

				var_403_16.forward = Vector3.New(var_403_21.x, var_403_21.y, var_403_21.z)

				local var_403_22 = var_403_16.localEulerAngles

				var_403_22.z = 0
				var_403_22.x = 0
				var_403_16.localEulerAngles = var_403_22
			end

			if arg_400_1.time_ >= var_403_17 + var_403_18 and arg_400_1.time_ < var_403_17 + var_403_18 + arg_403_0 then
				var_403_16.localPosition = Vector3.New(0, 100, 0)

				local var_403_23 = manager.ui.mainCamera.transform.position - var_403_16.position

				var_403_16.forward = Vector3.New(var_403_23.x, var_403_23.y, var_403_23.z)

				local var_403_24 = var_403_16.localEulerAngles

				var_403_24.z = 0
				var_403_24.x = 0
				var_403_16.localEulerAngles = var_403_24
			end

			local var_403_25 = arg_400_1.actors_["1075ui_story"]
			local var_403_26 = 0

			if var_403_26 < arg_400_1.time_ and arg_400_1.time_ <= var_403_26 + arg_403_0 and not isNil(var_403_25) and arg_400_1.var_.characterEffect1075ui_story == nil then
				arg_400_1.var_.characterEffect1075ui_story = var_403_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_27 = 0.200000002980232

			if var_403_26 <= arg_400_1.time_ and arg_400_1.time_ < var_403_26 + var_403_27 and not isNil(var_403_25) then
				local var_403_28 = (arg_400_1.time_ - var_403_26) / var_403_27

				if arg_400_1.var_.characterEffect1075ui_story and not isNil(var_403_25) then
					local var_403_29 = Mathf.Lerp(0, 0.5, var_403_28)

					arg_400_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_400_1.var_.characterEffect1075ui_story.fillRatio = var_403_29
				end
			end

			if arg_400_1.time_ >= var_403_26 + var_403_27 and arg_400_1.time_ < var_403_26 + var_403_27 + arg_403_0 and not isNil(var_403_25) and arg_400_1.var_.characterEffect1075ui_story then
				local var_403_30 = 0.5

				arg_400_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_400_1.var_.characterEffect1075ui_story.fillRatio = var_403_30
			end

			local var_403_31 = 0
			local var_403_32 = 0.633333333333333

			if var_403_31 < arg_400_1.time_ and arg_400_1.time_ <= var_403_31 + arg_403_0 then
				local var_403_33 = "play"
				local var_403_34 = "effect"

				arg_400_1:AudioAction(var_403_33, var_403_34, "se_story_16", "se_story_16_gun02", "")
			end

			local var_403_35 = manager.ui.mainCamera.transform
			local var_403_36 = 0

			if var_403_36 < arg_400_1.time_ and arg_400_1.time_ <= var_403_36 + arg_403_0 then
				arg_400_1.var_.shakeOldPos = var_403_35.localPosition
			end

			local var_403_37 = 0.6

			if var_403_36 <= arg_400_1.time_ and arg_400_1.time_ < var_403_36 + var_403_37 then
				local var_403_38 = (arg_400_1.time_ - var_403_36) / 0.066
				local var_403_39, var_403_40 = math.modf(var_403_38)

				var_403_35.localPosition = Vector3.New(var_403_40 * 0.13, var_403_40 * 0.13, var_403_40 * 0.13) + arg_400_1.var_.shakeOldPos
			end

			if arg_400_1.time_ >= var_403_36 + var_403_37 and arg_400_1.time_ < var_403_36 + var_403_37 + arg_403_0 then
				var_403_35.localPosition = arg_400_1.var_.shakeOldPos
			end

			local var_403_41 = 0

			if var_403_41 < arg_400_1.time_ and arg_400_1.time_ <= var_403_41 + arg_403_0 then
				arg_400_1.allBtn_.enabled = false
			end

			local var_403_42 = 0.6

			if arg_400_1.time_ >= var_403_41 + var_403_42 and arg_400_1.time_ < var_403_41 + var_403_42 + arg_403_0 then
				arg_400_1.allBtn_.enabled = true
			end

			local var_403_43 = 0
			local var_403_44 = 1

			if var_403_43 < arg_400_1.time_ and arg_400_1.time_ <= var_403_43 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_45 = arg_400_1:GetWordFromCfg(121511105)
				local var_403_46 = arg_400_1:FormatText(var_403_45.content)

				arg_400_1.text_.text = var_403_46

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_47 = 40
				local var_403_48 = utf8.len(var_403_46)
				local var_403_49 = var_403_47 <= 0 and var_403_44 or var_403_44 * (var_403_48 / var_403_47)

				if var_403_49 > 0 and var_403_44 < var_403_49 then
					arg_400_1.talkMaxDuration = var_403_49

					if var_403_49 + var_403_43 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_49 + var_403_43
					end
				end

				arg_400_1.text_.text = var_403_46
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_50 = math.max(var_403_44, arg_400_1.talkMaxDuration)

			if var_403_43 <= arg_400_1.time_ and arg_400_1.time_ < var_403_43 + var_403_50 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_43) / var_403_50

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_43 + var_403_50 and arg_400_1.time_ < var_403_43 + var_403_50 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play121511106 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 121511106
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play121511107(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 1.675

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_2 = arg_404_1:GetWordFromCfg(121511106)
				local var_407_3 = arg_404_1:FormatText(var_407_2.content)

				arg_404_1.text_.text = var_407_3

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 67
				local var_407_5 = utf8.len(var_407_3)
				local var_407_6 = var_407_4 <= 0 and var_407_1 or var_407_1 * (var_407_5 / var_407_4)

				if var_407_6 > 0 and var_407_1 < var_407_6 then
					arg_404_1.talkMaxDuration = var_407_6

					if var_407_6 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_6 + var_407_0
					end
				end

				arg_404_1.text_.text = var_407_3
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_7 and arg_404_1.time_ < var_407_0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play121511107 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 121511107
		arg_408_1.duration_ = 5.67

		local var_408_0 = {
			ja = 5.666,
			ko = 3.066,
			zh = 3.066
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
				arg_408_0:Play121511108(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["1184ui_story"].transform
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.var_.moveOldPos1184ui_story = var_411_0.localPosition
			end

			local var_411_2 = 0.001

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2
				local var_411_4 = Vector3.New(-0.7, -0.97, -6)

				var_411_0.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos1184ui_story, var_411_4, var_411_3)

				local var_411_5 = manager.ui.mainCamera.transform.position - var_411_0.position

				var_411_0.forward = Vector3.New(var_411_5.x, var_411_5.y, var_411_5.z)

				local var_411_6 = var_411_0.localEulerAngles

				var_411_6.z = 0
				var_411_6.x = 0
				var_411_0.localEulerAngles = var_411_6
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 then
				var_411_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_411_7 = manager.ui.mainCamera.transform.position - var_411_0.position

				var_411_0.forward = Vector3.New(var_411_7.x, var_411_7.y, var_411_7.z)

				local var_411_8 = var_411_0.localEulerAngles

				var_411_8.z = 0
				var_411_8.x = 0
				var_411_0.localEulerAngles = var_411_8
			end

			local var_411_9 = arg_408_1.actors_["1184ui_story"]
			local var_411_10 = 0

			if var_411_10 < arg_408_1.time_ and arg_408_1.time_ <= var_411_10 + arg_411_0 and not isNil(var_411_9) and arg_408_1.var_.characterEffect1184ui_story == nil then
				arg_408_1.var_.characterEffect1184ui_story = var_411_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_11 = 0.200000002980232

			if var_411_10 <= arg_408_1.time_ and arg_408_1.time_ < var_411_10 + var_411_11 and not isNil(var_411_9) then
				local var_411_12 = (arg_408_1.time_ - var_411_10) / var_411_11

				if arg_408_1.var_.characterEffect1184ui_story and not isNil(var_411_9) then
					arg_408_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= var_411_10 + var_411_11 and arg_408_1.time_ < var_411_10 + var_411_11 + arg_411_0 and not isNil(var_411_9) and arg_408_1.var_.characterEffect1184ui_story then
				arg_408_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_411_13 = 0

			if var_411_13 < arg_408_1.time_ and arg_408_1.time_ <= var_411_13 + arg_411_0 then
				arg_408_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_411_14 = arg_408_1.actors_["10042ui_story"].transform
			local var_411_15 = 0

			if var_411_15 < arg_408_1.time_ and arg_408_1.time_ <= var_411_15 + arg_411_0 then
				arg_408_1.var_.moveOldPos10042ui_story = var_411_14.localPosition
			end

			local var_411_16 = 0.001

			if var_411_15 <= arg_408_1.time_ and arg_408_1.time_ < var_411_15 + var_411_16 then
				local var_411_17 = (arg_408_1.time_ - var_411_15) / var_411_16
				local var_411_18 = Vector3.New(0.7, -1.12, -6.2)

				var_411_14.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos10042ui_story, var_411_18, var_411_17)

				local var_411_19 = manager.ui.mainCamera.transform.position - var_411_14.position

				var_411_14.forward = Vector3.New(var_411_19.x, var_411_19.y, var_411_19.z)

				local var_411_20 = var_411_14.localEulerAngles

				var_411_20.z = 0
				var_411_20.x = 0
				var_411_14.localEulerAngles = var_411_20
			end

			if arg_408_1.time_ >= var_411_15 + var_411_16 and arg_408_1.time_ < var_411_15 + var_411_16 + arg_411_0 then
				var_411_14.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_411_21 = manager.ui.mainCamera.transform.position - var_411_14.position

				var_411_14.forward = Vector3.New(var_411_21.x, var_411_21.y, var_411_21.z)

				local var_411_22 = var_411_14.localEulerAngles

				var_411_22.z = 0
				var_411_22.x = 0
				var_411_14.localEulerAngles = var_411_22
			end

			local var_411_23 = arg_408_1.actors_["10042ui_story"]
			local var_411_24 = 0

			if var_411_24 < arg_408_1.time_ and arg_408_1.time_ <= var_411_24 + arg_411_0 and not isNil(var_411_23) and arg_408_1.var_.characterEffect10042ui_story == nil then
				arg_408_1.var_.characterEffect10042ui_story = var_411_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_25 = 0.200000002980232

			if var_411_24 <= arg_408_1.time_ and arg_408_1.time_ < var_411_24 + var_411_25 and not isNil(var_411_23) then
				local var_411_26 = (arg_408_1.time_ - var_411_24) / var_411_25

				if arg_408_1.var_.characterEffect10042ui_story and not isNil(var_411_23) then
					local var_411_27 = Mathf.Lerp(0, 0.5, var_411_26)

					arg_408_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_408_1.var_.characterEffect10042ui_story.fillRatio = var_411_27
				end
			end

			if arg_408_1.time_ >= var_411_24 + var_411_25 and arg_408_1.time_ < var_411_24 + var_411_25 + arg_411_0 and not isNil(var_411_23) and arg_408_1.var_.characterEffect10042ui_story then
				local var_411_28 = 0.5

				arg_408_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_408_1.var_.characterEffect10042ui_story.fillRatio = var_411_28
			end

			local var_411_29 = 0

			if var_411_29 < arg_408_1.time_ and arg_408_1.time_ <= var_411_29 + arg_411_0 then
				arg_408_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_411_30 = 0
			local var_411_31 = 0.275

			if var_411_30 < arg_408_1.time_ and arg_408_1.time_ <= var_411_30 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_32 = arg_408_1:FormatText(StoryNameCfg[6].name)

				arg_408_1.leftNameTxt_.text = var_411_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_33 = arg_408_1:GetWordFromCfg(121511107)
				local var_411_34 = arg_408_1:FormatText(var_411_33.content)

				arg_408_1.text_.text = var_411_34

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_35 = 11
				local var_411_36 = utf8.len(var_411_34)
				local var_411_37 = var_411_35 <= 0 and var_411_31 or var_411_31 * (var_411_36 / var_411_35)

				if var_411_37 > 0 and var_411_31 < var_411_37 then
					arg_408_1.talkMaxDuration = var_411_37

					if var_411_37 + var_411_30 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_37 + var_411_30
					end
				end

				arg_408_1.text_.text = var_411_34
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511107", "story_v_out_121511.awb") ~= 0 then
					local var_411_38 = manager.audio:GetVoiceLength("story_v_out_121511", "121511107", "story_v_out_121511.awb") / 1000

					if var_411_38 + var_411_30 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_38 + var_411_30
					end

					if var_411_33.prefab_name ~= "" and arg_408_1.actors_[var_411_33.prefab_name] ~= nil then
						local var_411_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_33.prefab_name].transform, "story_v_out_121511", "121511107", "story_v_out_121511.awb")

						arg_408_1:RecordAudio("121511107", var_411_39)
						arg_408_1:RecordAudio("121511107", var_411_39)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_121511", "121511107", "story_v_out_121511.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_121511", "121511107", "story_v_out_121511.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_40 = math.max(var_411_31, arg_408_1.talkMaxDuration)

			if var_411_30 <= arg_408_1.time_ and arg_408_1.time_ < var_411_30 + var_411_40 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_30) / var_411_40

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_30 + var_411_40 and arg_408_1.time_ < var_411_30 + var_411_40 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play121511108 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 121511108
		arg_412_1.duration_ = 9.33

		local var_412_0 = {
			ja = 9.333,
			ko = 9.1,
			zh = 9.1
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
				arg_412_0:Play121511109(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["10042ui_story"]
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.characterEffect10042ui_story == nil then
				arg_412_1.var_.characterEffect10042ui_story = var_415_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_2 = 0.200000002980232

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 and not isNil(var_415_0) then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2

				if arg_412_1.var_.characterEffect10042ui_story and not isNil(var_415_0) then
					arg_412_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.characterEffect10042ui_story then
				arg_412_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_415_4 = arg_412_1.actors_["1184ui_story"]
			local var_415_5 = 0

			if var_415_5 < arg_412_1.time_ and arg_412_1.time_ <= var_415_5 + arg_415_0 and not isNil(var_415_4) and arg_412_1.var_.characterEffect1184ui_story == nil then
				arg_412_1.var_.characterEffect1184ui_story = var_415_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_6 = 0.200000002980232

			if var_415_5 <= arg_412_1.time_ and arg_412_1.time_ < var_415_5 + var_415_6 and not isNil(var_415_4) then
				local var_415_7 = (arg_412_1.time_ - var_415_5) / var_415_6

				if arg_412_1.var_.characterEffect1184ui_story and not isNil(var_415_4) then
					local var_415_8 = Mathf.Lerp(0, 0.5, var_415_7)

					arg_412_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_412_1.var_.characterEffect1184ui_story.fillRatio = var_415_8
				end
			end

			if arg_412_1.time_ >= var_415_5 + var_415_6 and arg_412_1.time_ < var_415_5 + var_415_6 + arg_415_0 and not isNil(var_415_4) and arg_412_1.var_.characterEffect1184ui_story then
				local var_415_9 = 0.5

				arg_412_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_412_1.var_.characterEffect1184ui_story.fillRatio = var_415_9
			end

			local var_415_10 = 0
			local var_415_11 = 0.625

			if var_415_10 < arg_412_1.time_ and arg_412_1.time_ <= var_415_10 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_12 = arg_412_1:FormatText(StoryNameCfg[388].name)

				arg_412_1.leftNameTxt_.text = var_415_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_13 = arg_412_1:GetWordFromCfg(121511108)
				local var_415_14 = arg_412_1:FormatText(var_415_13.content)

				arg_412_1.text_.text = var_415_14

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_15 = 25
				local var_415_16 = utf8.len(var_415_14)
				local var_415_17 = var_415_15 <= 0 and var_415_11 or var_415_11 * (var_415_16 / var_415_15)

				if var_415_17 > 0 and var_415_11 < var_415_17 then
					arg_412_1.talkMaxDuration = var_415_17

					if var_415_17 + var_415_10 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_17 + var_415_10
					end
				end

				arg_412_1.text_.text = var_415_14
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511108", "story_v_out_121511.awb") ~= 0 then
					local var_415_18 = manager.audio:GetVoiceLength("story_v_out_121511", "121511108", "story_v_out_121511.awb") / 1000

					if var_415_18 + var_415_10 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_18 + var_415_10
					end

					if var_415_13.prefab_name ~= "" and arg_412_1.actors_[var_415_13.prefab_name] ~= nil then
						local var_415_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_13.prefab_name].transform, "story_v_out_121511", "121511108", "story_v_out_121511.awb")

						arg_412_1:RecordAudio("121511108", var_415_19)
						arg_412_1:RecordAudio("121511108", var_415_19)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_121511", "121511108", "story_v_out_121511.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_121511", "121511108", "story_v_out_121511.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_20 = math.max(var_415_11, arg_412_1.talkMaxDuration)

			if var_415_10 <= arg_412_1.time_ and arg_412_1.time_ < var_415_10 + var_415_20 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_10) / var_415_20

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_10 + var_415_20 and arg_412_1.time_ < var_415_10 + var_415_20 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play121511109 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 121511109
		arg_416_1.duration_ = 10.37

		local var_416_0 = {
			ja = 10.366,
			ko = 10.133,
			zh = 10.133
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
				arg_416_0:Play121511110(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.825

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[388].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_3 = arg_416_1:GetWordFromCfg(121511109)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511109", "story_v_out_121511.awb") ~= 0 then
					local var_419_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511109", "story_v_out_121511.awb") / 1000

					if var_419_8 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_8 + var_419_0
					end

					if var_419_3.prefab_name ~= "" and arg_416_1.actors_[var_419_3.prefab_name] ~= nil then
						local var_419_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_3.prefab_name].transform, "story_v_out_121511", "121511109", "story_v_out_121511.awb")

						arg_416_1:RecordAudio("121511109", var_419_9)
						arg_416_1:RecordAudio("121511109", var_419_9)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_121511", "121511109", "story_v_out_121511.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_121511", "121511109", "story_v_out_121511.awb")
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
	Play121511110 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 121511110
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play121511111(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["1184ui_story"].transform
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 then
				arg_420_1.var_.moveOldPos1184ui_story = var_423_0.localPosition
			end

			local var_423_2 = 0.001

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2
				local var_423_4 = Vector3.New(0, 100, 0)

				var_423_0.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1184ui_story, var_423_4, var_423_3)

				local var_423_5 = manager.ui.mainCamera.transform.position - var_423_0.position

				var_423_0.forward = Vector3.New(var_423_5.x, var_423_5.y, var_423_5.z)

				local var_423_6 = var_423_0.localEulerAngles

				var_423_6.z = 0
				var_423_6.x = 0
				var_423_0.localEulerAngles = var_423_6
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 then
				var_423_0.localPosition = Vector3.New(0, 100, 0)

				local var_423_7 = manager.ui.mainCamera.transform.position - var_423_0.position

				var_423_0.forward = Vector3.New(var_423_7.x, var_423_7.y, var_423_7.z)

				local var_423_8 = var_423_0.localEulerAngles

				var_423_8.z = 0
				var_423_8.x = 0
				var_423_0.localEulerAngles = var_423_8
			end

			local var_423_9 = arg_420_1.actors_["1184ui_story"]
			local var_423_10 = 0

			if var_423_10 < arg_420_1.time_ and arg_420_1.time_ <= var_423_10 + arg_423_0 and not isNil(var_423_9) and arg_420_1.var_.characterEffect1184ui_story == nil then
				arg_420_1.var_.characterEffect1184ui_story = var_423_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_11 = 0.200000002980232

			if var_423_10 <= arg_420_1.time_ and arg_420_1.time_ < var_423_10 + var_423_11 and not isNil(var_423_9) then
				local var_423_12 = (arg_420_1.time_ - var_423_10) / var_423_11

				if arg_420_1.var_.characterEffect1184ui_story and not isNil(var_423_9) then
					local var_423_13 = Mathf.Lerp(0, 0.5, var_423_12)

					arg_420_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_420_1.var_.characterEffect1184ui_story.fillRatio = var_423_13
				end
			end

			if arg_420_1.time_ >= var_423_10 + var_423_11 and arg_420_1.time_ < var_423_10 + var_423_11 + arg_423_0 and not isNil(var_423_9) and arg_420_1.var_.characterEffect1184ui_story then
				local var_423_14 = 0.5

				arg_420_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_420_1.var_.characterEffect1184ui_story.fillRatio = var_423_14
			end

			local var_423_15 = arg_420_1.actors_["10042ui_story"].transform
			local var_423_16 = 0

			if var_423_16 < arg_420_1.time_ and arg_420_1.time_ <= var_423_16 + arg_423_0 then
				arg_420_1.var_.moveOldPos10042ui_story = var_423_15.localPosition
			end

			local var_423_17 = 0.001

			if var_423_16 <= arg_420_1.time_ and arg_420_1.time_ < var_423_16 + var_423_17 then
				local var_423_18 = (arg_420_1.time_ - var_423_16) / var_423_17
				local var_423_19 = Vector3.New(0, 100, 0)

				var_423_15.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos10042ui_story, var_423_19, var_423_18)

				local var_423_20 = manager.ui.mainCamera.transform.position - var_423_15.position

				var_423_15.forward = Vector3.New(var_423_20.x, var_423_20.y, var_423_20.z)

				local var_423_21 = var_423_15.localEulerAngles

				var_423_21.z = 0
				var_423_21.x = 0
				var_423_15.localEulerAngles = var_423_21
			end

			if arg_420_1.time_ >= var_423_16 + var_423_17 and arg_420_1.time_ < var_423_16 + var_423_17 + arg_423_0 then
				var_423_15.localPosition = Vector3.New(0, 100, 0)

				local var_423_22 = manager.ui.mainCamera.transform.position - var_423_15.position

				var_423_15.forward = Vector3.New(var_423_22.x, var_423_22.y, var_423_22.z)

				local var_423_23 = var_423_15.localEulerAngles

				var_423_23.z = 0
				var_423_23.x = 0
				var_423_15.localEulerAngles = var_423_23
			end

			local var_423_24 = arg_420_1.actors_["10042ui_story"]
			local var_423_25 = 0

			if var_423_25 < arg_420_1.time_ and arg_420_1.time_ <= var_423_25 + arg_423_0 and not isNil(var_423_24) and arg_420_1.var_.characterEffect10042ui_story == nil then
				arg_420_1.var_.characterEffect10042ui_story = var_423_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_26 = 0.200000002980232

			if var_423_25 <= arg_420_1.time_ and arg_420_1.time_ < var_423_25 + var_423_26 and not isNil(var_423_24) then
				local var_423_27 = (arg_420_1.time_ - var_423_25) / var_423_26

				if arg_420_1.var_.characterEffect10042ui_story and not isNil(var_423_24) then
					local var_423_28 = Mathf.Lerp(0, 0.5, var_423_27)

					arg_420_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_420_1.var_.characterEffect10042ui_story.fillRatio = var_423_28
				end
			end

			if arg_420_1.time_ >= var_423_25 + var_423_26 and arg_420_1.time_ < var_423_25 + var_423_26 + arg_423_0 and not isNil(var_423_24) and arg_420_1.var_.characterEffect10042ui_story then
				local var_423_29 = 0.5

				arg_420_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_420_1.var_.characterEffect10042ui_story.fillRatio = var_423_29
			end

			local var_423_30 = manager.ui.mainCamera.transform
			local var_423_31 = 0.5

			if var_423_31 < arg_420_1.time_ and arg_420_1.time_ <= var_423_31 + arg_423_0 then
				arg_420_1.var_.shakeOldPos = var_423_30.localPosition
			end

			local var_423_32 = 1

			if var_423_31 <= arg_420_1.time_ and arg_420_1.time_ < var_423_31 + var_423_32 then
				local var_423_33 = (arg_420_1.time_ - var_423_31) / 0.066
				local var_423_34, var_423_35 = math.modf(var_423_33)

				var_423_30.localPosition = Vector3.New(var_423_35 * 0.13, var_423_35 * 0.13, var_423_35 * 0.13) + arg_420_1.var_.shakeOldPos
			end

			if arg_420_1.time_ >= var_423_31 + var_423_32 and arg_420_1.time_ < var_423_31 + var_423_32 + arg_423_0 then
				var_423_30.localPosition = arg_420_1.var_.shakeOldPos
			end

			local var_423_36 = 0

			if var_423_36 < arg_420_1.time_ and arg_420_1.time_ <= var_423_36 + arg_423_0 then
				arg_420_1.allBtn_.enabled = false
			end

			local var_423_37 = 1.5

			if arg_420_1.time_ >= var_423_36 + var_423_37 and arg_420_1.time_ < var_423_36 + var_423_37 + arg_423_0 then
				arg_420_1.allBtn_.enabled = true
			end

			local var_423_38 = 0
			local var_423_39 = 0.633333333333333

			if var_423_38 < arg_420_1.time_ and arg_420_1.time_ <= var_423_38 + arg_423_0 then
				local var_423_40 = "play"
				local var_423_41 = "effect"

				arg_420_1:AudioAction(var_423_40, var_423_41, "se_story_121_04", "se_story_121_04_bulletdefence", "")
			end

			local var_423_42 = 0
			local var_423_43 = 1.4

			if var_423_42 < arg_420_1.time_ and arg_420_1.time_ <= var_423_42 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_44 = arg_420_1:GetWordFromCfg(121511110)
				local var_423_45 = arg_420_1:FormatText(var_423_44.content)

				arg_420_1.text_.text = var_423_45

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_46 = 56
				local var_423_47 = utf8.len(var_423_45)
				local var_423_48 = var_423_46 <= 0 and var_423_43 or var_423_43 * (var_423_47 / var_423_46)

				if var_423_48 > 0 and var_423_43 < var_423_48 then
					arg_420_1.talkMaxDuration = var_423_48

					if var_423_48 + var_423_42 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_48 + var_423_42
					end
				end

				arg_420_1.text_.text = var_423_45
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_49 = math.max(var_423_43, arg_420_1.talkMaxDuration)

			if var_423_42 <= arg_420_1.time_ and arg_420_1.time_ < var_423_42 + var_423_49 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_42) / var_423_49

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_42 + var_423_49 and arg_420_1.time_ < var_423_42 + var_423_49 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play121511111 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 121511111
		arg_424_1.duration_ = 7

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play121511112(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0

			if var_427_0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1.mask_.enabled = true
				arg_424_1.mask_.raycastTarget = false

				arg_424_1:SetGaussion(false)
			end

			local var_427_1 = 2

			if var_427_0 <= arg_424_1.time_ and arg_424_1.time_ < var_427_0 + var_427_1 then
				local var_427_2 = (arg_424_1.time_ - var_427_0) / var_427_1
				local var_427_3 = Color.New(0.3207547, 0, 0)

				var_427_3.a = Mathf.Lerp(1, 0, var_427_2)
				arg_424_1.mask_.color = var_427_3
			end

			if arg_424_1.time_ >= var_427_0 + var_427_1 and arg_424_1.time_ < var_427_0 + var_427_1 + arg_427_0 then
				local var_427_4 = Color.New(0.3207547, 0, 0)
				local var_427_5 = 0

				arg_424_1.mask_.enabled = false
				var_427_4.a = var_427_5
				arg_424_1.mask_.color = var_427_4
			end

			local var_427_6 = manager.ui.mainCamera.transform
			local var_427_7 = 0

			if var_427_7 < arg_424_1.time_ and arg_424_1.time_ <= var_427_7 + arg_427_0 then
				arg_424_1.var_.shakeOldPos = var_427_6.localPosition
			end

			local var_427_8 = 2

			if var_427_7 <= arg_424_1.time_ and arg_424_1.time_ < var_427_7 + var_427_8 then
				local var_427_9 = (arg_424_1.time_ - var_427_7) / 0.066
				local var_427_10, var_427_11 = math.modf(var_427_9)

				var_427_6.localPosition = Vector3.New(var_427_11 * 0.13, var_427_11 * 0.13, var_427_11 * 0.13) + arg_424_1.var_.shakeOldPos
			end

			if arg_424_1.time_ >= var_427_7 + var_427_8 and arg_424_1.time_ < var_427_7 + var_427_8 + arg_427_0 then
				var_427_6.localPosition = arg_424_1.var_.shakeOldPos
			end

			if arg_424_1.frameCnt_ <= 1 then
				arg_424_1.dialog_:SetActive(false)
			end

			local var_427_12 = 2
			local var_427_13 = 1.275

			if var_427_12 < arg_424_1.time_ and arg_424_1.time_ <= var_427_12 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0

				arg_424_1.dialog_:SetActive(true)

				arg_424_1.dialogCg_.alpha = 0

				local var_427_14 = LeanTween.value(arg_424_1.dialog_, 0, 1, 0.3)

				var_427_14:setOnUpdate(LuaHelper.FloatAction(function(arg_428_0)
					arg_424_1.dialogCg_.alpha = arg_428_0
				end))
				var_427_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_424_1.dialog_)
					var_427_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_424_1.duration_ = arg_424_1.duration_ + 0.3

				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_15 = arg_424_1:GetWordFromCfg(121511111)
				local var_427_16 = arg_424_1:FormatText(var_427_15.content)

				arg_424_1.text_.text = var_427_16

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_17 = 51
				local var_427_18 = utf8.len(var_427_16)
				local var_427_19 = var_427_17 <= 0 and var_427_13 or var_427_13 * (var_427_18 / var_427_17)

				if var_427_19 > 0 and var_427_13 < var_427_19 then
					arg_424_1.talkMaxDuration = var_427_19
					var_427_12 = var_427_12 + 0.3

					if var_427_19 + var_427_12 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_19 + var_427_12
					end
				end

				arg_424_1.text_.text = var_427_16
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_20 = var_427_12 + 0.3
			local var_427_21 = math.max(var_427_13, arg_424_1.talkMaxDuration)

			if var_427_20 <= arg_424_1.time_ and arg_424_1.time_ < var_427_20 + var_427_21 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_20) / var_427_21

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_20 + var_427_21 and arg_424_1.time_ < var_427_20 + var_427_21 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play121511112 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 121511112
		arg_430_1.duration_ = 1.67

		local var_430_0 = {
			ja = 1.533,
			ko = 1.666,
			zh = 1.666
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
				arg_430_0:Play121511113(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0
			local var_433_1 = 0.125

			if var_433_0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_2 = arg_430_1:FormatText(StoryNameCfg[6].name)

				arg_430_1.leftNameTxt_.text = var_433_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_3 = arg_430_1:GetWordFromCfg(121511112)
				local var_433_4 = arg_430_1:FormatText(var_433_3.content)

				arg_430_1.text_.text = var_433_4

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511112", "story_v_out_121511.awb") ~= 0 then
					local var_433_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511112", "story_v_out_121511.awb") / 1000

					if var_433_8 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_8 + var_433_0
					end

					if var_433_3.prefab_name ~= "" and arg_430_1.actors_[var_433_3.prefab_name] ~= nil then
						local var_433_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_3.prefab_name].transform, "story_v_out_121511", "121511112", "story_v_out_121511.awb")

						arg_430_1:RecordAudio("121511112", var_433_9)
						arg_430_1:RecordAudio("121511112", var_433_9)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_121511", "121511112", "story_v_out_121511.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_121511", "121511112", "story_v_out_121511.awb")
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
	Play121511113 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 121511113
		arg_434_1.duration_ = 6.8

		local var_434_0 = {
			ja = 6.8,
			ko = 5.933,
			zh = 5.933
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
				arg_434_0:Play121511114(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["10042ui_story"].transform
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.var_.moveOldPos10042ui_story = var_437_0.localPosition
			end

			local var_437_2 = 0.001

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2
				local var_437_4 = Vector3.New(0, -1.12, -6.2)

				var_437_0.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos10042ui_story, var_437_4, var_437_3)

				local var_437_5 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_5.x, var_437_5.y, var_437_5.z)

				local var_437_6 = var_437_0.localEulerAngles

				var_437_6.z = 0
				var_437_6.x = 0
				var_437_0.localEulerAngles = var_437_6
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 then
				var_437_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_437_7 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_7.x, var_437_7.y, var_437_7.z)

				local var_437_8 = var_437_0.localEulerAngles

				var_437_8.z = 0
				var_437_8.x = 0
				var_437_0.localEulerAngles = var_437_8
			end

			local var_437_9 = arg_434_1.actors_["10042ui_story"]
			local var_437_10 = 0

			if var_437_10 < arg_434_1.time_ and arg_434_1.time_ <= var_437_10 + arg_437_0 and not isNil(var_437_9) and arg_434_1.var_.characterEffect10042ui_story == nil then
				arg_434_1.var_.characterEffect10042ui_story = var_437_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_11 = 0.200000002980232

			if var_437_10 <= arg_434_1.time_ and arg_434_1.time_ < var_437_10 + var_437_11 and not isNil(var_437_9) then
				local var_437_12 = (arg_434_1.time_ - var_437_10) / var_437_11

				if arg_434_1.var_.characterEffect10042ui_story and not isNil(var_437_9) then
					arg_434_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= var_437_10 + var_437_11 and arg_434_1.time_ < var_437_10 + var_437_11 + arg_437_0 and not isNil(var_437_9) and arg_434_1.var_.characterEffect10042ui_story then
				arg_434_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_437_13 = 0

			if var_437_13 < arg_434_1.time_ and arg_434_1.time_ <= var_437_13 + arg_437_0 then
				arg_434_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action1_1")
			end

			local var_437_14 = 0

			if var_437_14 < arg_434_1.time_ and arg_434_1.time_ <= var_437_14 + arg_437_0 then
				arg_434_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_437_15 = 0
			local var_437_16 = 0.325

			if var_437_15 < arg_434_1.time_ and arg_434_1.time_ <= var_437_15 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_17 = arg_434_1:FormatText(StoryNameCfg[388].name)

				arg_434_1.leftNameTxt_.text = var_437_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_18 = arg_434_1:GetWordFromCfg(121511113)
				local var_437_19 = arg_434_1:FormatText(var_437_18.content)

				arg_434_1.text_.text = var_437_19

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_20 = 13
				local var_437_21 = utf8.len(var_437_19)
				local var_437_22 = var_437_20 <= 0 and var_437_16 or var_437_16 * (var_437_21 / var_437_20)

				if var_437_22 > 0 and var_437_16 < var_437_22 then
					arg_434_1.talkMaxDuration = var_437_22

					if var_437_22 + var_437_15 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_22 + var_437_15
					end
				end

				arg_434_1.text_.text = var_437_19
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511113", "story_v_out_121511.awb") ~= 0 then
					local var_437_23 = manager.audio:GetVoiceLength("story_v_out_121511", "121511113", "story_v_out_121511.awb") / 1000

					if var_437_23 + var_437_15 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_23 + var_437_15
					end

					if var_437_18.prefab_name ~= "" and arg_434_1.actors_[var_437_18.prefab_name] ~= nil then
						local var_437_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_18.prefab_name].transform, "story_v_out_121511", "121511113", "story_v_out_121511.awb")

						arg_434_1:RecordAudio("121511113", var_437_24)
						arg_434_1:RecordAudio("121511113", var_437_24)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_121511", "121511113", "story_v_out_121511.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_121511", "121511113", "story_v_out_121511.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_25 = math.max(var_437_16, arg_434_1.talkMaxDuration)

			if var_437_15 <= arg_434_1.time_ and arg_434_1.time_ < var_437_15 + var_437_25 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_15) / var_437_25

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_15 + var_437_25 and arg_434_1.time_ < var_437_15 + var_437_25 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play121511114 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 121511114
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play121511115(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["10042ui_story"].transform
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 then
				arg_438_1.var_.moveOldPos10042ui_story = var_441_0.localPosition
			end

			local var_441_2 = 0.001

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2
				local var_441_4 = Vector3.New(0, 100, 0)

				var_441_0.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos10042ui_story, var_441_4, var_441_3)

				local var_441_5 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_5.x, var_441_5.y, var_441_5.z)

				local var_441_6 = var_441_0.localEulerAngles

				var_441_6.z = 0
				var_441_6.x = 0
				var_441_0.localEulerAngles = var_441_6
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 then
				var_441_0.localPosition = Vector3.New(0, 100, 0)

				local var_441_7 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_7.x, var_441_7.y, var_441_7.z)

				local var_441_8 = var_441_0.localEulerAngles

				var_441_8.z = 0
				var_441_8.x = 0
				var_441_0.localEulerAngles = var_441_8
			end

			local var_441_9 = arg_438_1.actors_["10042ui_story"]
			local var_441_10 = 0

			if var_441_10 < arg_438_1.time_ and arg_438_1.time_ <= var_441_10 + arg_441_0 and not isNil(var_441_9) and arg_438_1.var_.characterEffect10042ui_story == nil then
				arg_438_1.var_.characterEffect10042ui_story = var_441_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_11 = 0.200000002980232

			if var_441_10 <= arg_438_1.time_ and arg_438_1.time_ < var_441_10 + var_441_11 and not isNil(var_441_9) then
				local var_441_12 = (arg_438_1.time_ - var_441_10) / var_441_11

				if arg_438_1.var_.characterEffect10042ui_story and not isNil(var_441_9) then
					local var_441_13 = Mathf.Lerp(0, 0.5, var_441_12)

					arg_438_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_438_1.var_.characterEffect10042ui_story.fillRatio = var_441_13
				end
			end

			if arg_438_1.time_ >= var_441_10 + var_441_11 and arg_438_1.time_ < var_441_10 + var_441_11 + arg_441_0 and not isNil(var_441_9) and arg_438_1.var_.characterEffect10042ui_story then
				local var_441_14 = 0.5

				arg_438_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_438_1.var_.characterEffect10042ui_story.fillRatio = var_441_14
			end

			local var_441_15 = 0
			local var_441_16 = 0.925

			if var_441_15 < arg_438_1.time_ and arg_438_1.time_ <= var_441_15 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_17 = arg_438_1:GetWordFromCfg(121511114)
				local var_441_18 = arg_438_1:FormatText(var_441_17.content)

				arg_438_1.text_.text = var_441_18

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_19 = 37
				local var_441_20 = utf8.len(var_441_18)
				local var_441_21 = var_441_19 <= 0 and var_441_16 or var_441_16 * (var_441_20 / var_441_19)

				if var_441_21 > 0 and var_441_16 < var_441_21 then
					arg_438_1.talkMaxDuration = var_441_21

					if var_441_21 + var_441_15 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_21 + var_441_15
					end
				end

				arg_438_1.text_.text = var_441_18
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_22 = math.max(var_441_16, arg_438_1.talkMaxDuration)

			if var_441_15 <= arg_438_1.time_ and arg_438_1.time_ < var_441_15 + var_441_22 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_15) / var_441_22

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_15 + var_441_22 and arg_438_1.time_ < var_441_15 + var_441_22 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play121511115 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 121511115
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play121511116(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0
			local var_445_1 = 0.275

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_2 = arg_442_1:FormatText(StoryNameCfg[7].name)

				arg_442_1.leftNameTxt_.text = var_445_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_3 = arg_442_1:GetWordFromCfg(121511115)
				local var_445_4 = arg_442_1:FormatText(var_445_3.content)

				arg_442_1.text_.text = var_445_4

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_5 = 11
				local var_445_6 = utf8.len(var_445_4)
				local var_445_7 = var_445_5 <= 0 and var_445_1 or var_445_1 * (var_445_6 / var_445_5)

				if var_445_7 > 0 and var_445_1 < var_445_7 then
					arg_442_1.talkMaxDuration = var_445_7

					if var_445_7 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_7 + var_445_0
					end
				end

				arg_442_1.text_.text = var_445_4
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_8 = math.max(var_445_1, arg_442_1.talkMaxDuration)

			if var_445_0 <= arg_442_1.time_ and arg_442_1.time_ < var_445_0 + var_445_8 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_0) / var_445_8

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_0 + var_445_8 and arg_442_1.time_ < var_445_0 + var_445_8 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play121511116 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 121511116
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play121511117(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0
			local var_449_1 = 0.633333333333333

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				local var_449_2 = "play"
				local var_449_3 = "effect"

				arg_446_1:AudioAction(var_449_2, var_449_3, "se_story_121_04", "se_story_121_04_fireanergy1", "")
			end

			local var_449_4 = 0
			local var_449_5 = 1.025

			if var_449_4 < arg_446_1.time_ and arg_446_1.time_ <= var_449_4 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_6 = arg_446_1:GetWordFromCfg(121511116)
				local var_449_7 = arg_446_1:FormatText(var_449_6.content)

				arg_446_1.text_.text = var_449_7

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_8 = 41
				local var_449_9 = utf8.len(var_449_7)
				local var_449_10 = var_449_8 <= 0 and var_449_5 or var_449_5 * (var_449_9 / var_449_8)

				if var_449_10 > 0 and var_449_5 < var_449_10 then
					arg_446_1.talkMaxDuration = var_449_10

					if var_449_10 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_10 + var_449_4
					end
				end

				arg_446_1.text_.text = var_449_7
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_11 = math.max(var_449_5, arg_446_1.talkMaxDuration)

			if var_449_4 <= arg_446_1.time_ and arg_446_1.time_ < var_449_4 + var_449_11 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_4) / var_449_11

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_4 + var_449_11 and arg_446_1.time_ < var_449_4 + var_449_11 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play121511117 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 121511117
		arg_450_1.duration_ = 11.8

		local var_450_0 = {
			ja = 11.8,
			ko = 9.6,
			zh = 9.6
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play121511118(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0
			local var_453_1 = 1.025

			if var_453_0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_2 = arg_450_1:FormatText(StoryNameCfg[388].name)

				arg_450_1.leftNameTxt_.text = var_453_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10042")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_3 = arg_450_1:GetWordFromCfg(121511117)
				local var_453_4 = arg_450_1:FormatText(var_453_3.content)

				arg_450_1.text_.text = var_453_4

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 41
				local var_453_6 = utf8.len(var_453_4)
				local var_453_7 = var_453_5 <= 0 and var_453_1 or var_453_1 * (var_453_6 / var_453_5)

				if var_453_7 > 0 and var_453_1 < var_453_7 then
					arg_450_1.talkMaxDuration = var_453_7

					if var_453_7 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_7 + var_453_0
					end
				end

				arg_450_1.text_.text = var_453_4
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511117", "story_v_out_121511.awb") ~= 0 then
					local var_453_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511117", "story_v_out_121511.awb") / 1000

					if var_453_8 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_8 + var_453_0
					end

					if var_453_3.prefab_name ~= "" and arg_450_1.actors_[var_453_3.prefab_name] ~= nil then
						local var_453_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_3.prefab_name].transform, "story_v_out_121511", "121511117", "story_v_out_121511.awb")

						arg_450_1:RecordAudio("121511117", var_453_9)
						arg_450_1:RecordAudio("121511117", var_453_9)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_121511", "121511117", "story_v_out_121511.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_121511", "121511117", "story_v_out_121511.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_10 = math.max(var_453_1, arg_450_1.talkMaxDuration)

			if var_453_0 <= arg_450_1.time_ and arg_450_1.time_ < var_453_0 + var_453_10 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_0) / var_453_10

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_0 + var_453_10 and arg_450_1.time_ < var_453_0 + var_453_10 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play121511118 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 121511118
		arg_454_1.duration_ = 12.6

		local var_454_0 = {
			ja = 12.6,
			ko = 9.433,
			zh = 9.433
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play121511119(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0
			local var_457_1 = 0.675

			if var_457_0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_2 = arg_454_1:FormatText(StoryNameCfg[388].name)

				arg_454_1.leftNameTxt_.text = var_457_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10042")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_3 = arg_454_1:GetWordFromCfg(121511118)
				local var_457_4 = arg_454_1:FormatText(var_457_3.content)

				arg_454_1.text_.text = var_457_4

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_5 = 27
				local var_457_6 = utf8.len(var_457_4)
				local var_457_7 = var_457_5 <= 0 and var_457_1 or var_457_1 * (var_457_6 / var_457_5)

				if var_457_7 > 0 and var_457_1 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_0
					end
				end

				arg_454_1.text_.text = var_457_4
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511118", "story_v_out_121511.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511118", "story_v_out_121511.awb") / 1000

					if var_457_8 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_0
					end

					if var_457_3.prefab_name ~= "" and arg_454_1.actors_[var_457_3.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_3.prefab_name].transform, "story_v_out_121511", "121511118", "story_v_out_121511.awb")

						arg_454_1:RecordAudio("121511118", var_457_9)
						arg_454_1:RecordAudio("121511118", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_121511", "121511118", "story_v_out_121511.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_121511", "121511118", "story_v_out_121511.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_10 = math.max(var_457_1, arg_454_1.talkMaxDuration)

			if var_457_0 <= arg_454_1.time_ and arg_454_1.time_ < var_457_0 + var_457_10 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_0) / var_457_10

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_0 + var_457_10 and arg_454_1.time_ < var_457_0 + var_457_10 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play121511119 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 121511119
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play121511120(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 0
			local var_461_1 = 0.633333333333333

			if var_461_0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_0 + arg_461_0 then
				local var_461_2 = "play"
				local var_461_3 = "effect"

				arg_458_1:AudioAction(var_461_2, var_461_3, "se_story_121_04", "se_story_121_04_fireanergy2", "")
			end

			local var_461_4 = 0
			local var_461_5 = 1.7

			if var_461_4 < arg_458_1.time_ and arg_458_1.time_ <= var_461_4 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_6 = arg_458_1:GetWordFromCfg(121511119)
				local var_461_7 = arg_458_1:FormatText(var_461_6.content)

				arg_458_1.text_.text = var_461_7

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_8 = 69
				local var_461_9 = utf8.len(var_461_7)
				local var_461_10 = var_461_8 <= 0 and var_461_5 or var_461_5 * (var_461_9 / var_461_8)

				if var_461_10 > 0 and var_461_5 < var_461_10 then
					arg_458_1.talkMaxDuration = var_461_10

					if var_461_10 + var_461_4 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_10 + var_461_4
					end
				end

				arg_458_1.text_.text = var_461_7
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_11 = math.max(var_461_5, arg_458_1.talkMaxDuration)

			if var_461_4 <= arg_458_1.time_ and arg_458_1.time_ < var_461_4 + var_461_11 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_4) / var_461_11

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_4 + var_461_11 and arg_458_1.time_ < var_461_4 + var_461_11 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play121511120 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 121511120
		arg_462_1.duration_ = 7

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play121511121(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = "XH0305"

			if arg_462_1.bgs_[var_465_0] == nil then
				local var_465_1 = Object.Instantiate(arg_462_1.paintGo_)

				var_465_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_465_0)
				var_465_1.name = var_465_0
				var_465_1.transform.parent = arg_462_1.stage_.transform
				var_465_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_462_1.bgs_[var_465_0] = var_465_1
			end

			local var_465_2 = 0

			if var_465_2 < arg_462_1.time_ and arg_462_1.time_ <= var_465_2 + arg_465_0 then
				local var_465_3 = manager.ui.mainCamera.transform.localPosition
				local var_465_4 = Vector3.New(0, 0, 10) + Vector3.New(var_465_3.x, var_465_3.y, 0)
				local var_465_5 = arg_462_1.bgs_.XH0305

				var_465_5.transform.localPosition = var_465_4
				var_465_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_465_6 = var_465_5:GetComponent("SpriteRenderer")

				if var_465_6 and var_465_6.sprite then
					local var_465_7 = (var_465_5.transform.localPosition - var_465_3).z
					local var_465_8 = manager.ui.mainCameraCom_
					local var_465_9 = 2 * var_465_7 * Mathf.Tan(var_465_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_465_10 = var_465_9 * var_465_8.aspect
					local var_465_11 = var_465_6.sprite.bounds.size.x
					local var_465_12 = var_465_6.sprite.bounds.size.y
					local var_465_13 = var_465_10 / var_465_11
					local var_465_14 = var_465_9 / var_465_12
					local var_465_15 = var_465_14 < var_465_13 and var_465_13 or var_465_14

					var_465_5.transform.localScale = Vector3.New(var_465_15, var_465_15, 0)
				end

				for iter_465_0, iter_465_1 in pairs(arg_462_1.bgs_) do
					if iter_465_0 ~= "XH0305" then
						iter_465_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_465_16 = 0

			if var_465_16 < arg_462_1.time_ and arg_462_1.time_ <= var_465_16 + arg_465_0 then
				arg_462_1.mask_.enabled = true
				arg_462_1.mask_.raycastTarget = true

				arg_462_1:SetGaussion(false)
			end

			local var_465_17 = 2

			if var_465_16 <= arg_462_1.time_ and arg_462_1.time_ < var_465_16 + var_465_17 then
				local var_465_18 = (arg_462_1.time_ - var_465_16) / var_465_17
				local var_465_19 = Color.New(1, 1, 1)

				var_465_19.a = Mathf.Lerp(1, 0, var_465_18)
				arg_462_1.mask_.color = var_465_19
			end

			if arg_462_1.time_ >= var_465_16 + var_465_17 and arg_462_1.time_ < var_465_16 + var_465_17 + arg_465_0 then
				local var_465_20 = Color.New(1, 1, 1)
				local var_465_21 = 0

				arg_462_1.mask_.enabled = false
				var_465_20.a = var_465_21
				arg_462_1.mask_.color = var_465_20
			end

			local var_465_22 = arg_462_1.bgs_.XH0305.transform
			local var_465_23 = 0

			if var_465_23 < arg_462_1.time_ and arg_462_1.time_ <= var_465_23 + arg_465_0 then
				arg_462_1.var_.moveOldPosXH0305 = var_465_22.localPosition
			end

			local var_465_24 = 0.001

			if var_465_23 <= arg_462_1.time_ and arg_462_1.time_ < var_465_23 + var_465_24 then
				local var_465_25 = (arg_462_1.time_ - var_465_23) / var_465_24
				local var_465_26 = Vector3.New(0, 1, 9)

				var_465_22.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPosXH0305, var_465_26, var_465_25)
			end

			if arg_462_1.time_ >= var_465_23 + var_465_24 and arg_462_1.time_ < var_465_23 + var_465_24 + arg_465_0 then
				var_465_22.localPosition = Vector3.New(0, 1, 9)
			end

			local var_465_27 = arg_462_1.bgs_.XH0305.transform
			local var_465_28 = 0.0333333333333333

			if var_465_28 < arg_462_1.time_ and arg_462_1.time_ <= var_465_28 + arg_465_0 then
				arg_462_1.var_.moveOldPosXH0305 = var_465_27.localPosition
			end

			local var_465_29 = 4.5

			if var_465_28 <= arg_462_1.time_ and arg_462_1.time_ < var_465_28 + var_465_29 then
				local var_465_30 = (arg_462_1.time_ - var_465_28) / var_465_29
				local var_465_31 = Vector3.New(0, 1, 10)

				var_465_27.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPosXH0305, var_465_31, var_465_30)
			end

			if arg_462_1.time_ >= var_465_28 + var_465_29 and arg_462_1.time_ < var_465_28 + var_465_29 + arg_465_0 then
				var_465_27.localPosition = Vector3.New(0, 1, 10)
			end

			local var_465_32 = 2

			if var_465_32 < arg_462_1.time_ and arg_462_1.time_ <= var_465_32 + arg_465_0 then
				arg_462_1.allBtn_.enabled = false
			end

			local var_465_33 = 2.53333333333333

			if arg_462_1.time_ >= var_465_32 + var_465_33 and arg_462_1.time_ < var_465_32 + var_465_33 + arg_465_0 then
				arg_462_1.allBtn_.enabled = true
			end

			if arg_462_1.frameCnt_ <= 1 then
				arg_462_1.dialog_:SetActive(false)
			end

			local var_465_34 = 2
			local var_465_35 = 1.325

			if var_465_34 < arg_462_1.time_ and arg_462_1.time_ <= var_465_34 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0

				arg_462_1.dialog_:SetActive(true)

				arg_462_1.dialogCg_.alpha = 0

				local var_465_36 = LeanTween.value(arg_462_1.dialog_, 0, 1, 0.3)

				var_465_36:setOnUpdate(LuaHelper.FloatAction(function(arg_466_0)
					arg_462_1.dialogCg_.alpha = arg_466_0
				end))
				var_465_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_462_1.dialog_)
					var_465_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_462_1.duration_ = arg_462_1.duration_ + 0.3

				SetActive(arg_462_1.leftNameGo_, false)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_37 = arg_462_1:GetWordFromCfg(121511120)
				local var_465_38 = arg_462_1:FormatText(var_465_37.content)

				arg_462_1.text_.text = var_465_38

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_39 = 53
				local var_465_40 = utf8.len(var_465_38)
				local var_465_41 = var_465_39 <= 0 and var_465_35 or var_465_35 * (var_465_40 / var_465_39)

				if var_465_41 > 0 and var_465_35 < var_465_41 then
					arg_462_1.talkMaxDuration = var_465_41
					var_465_34 = var_465_34 + 0.3

					if var_465_41 + var_465_34 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_41 + var_465_34
					end
				end

				arg_462_1.text_.text = var_465_38
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_42 = var_465_34 + 0.3
			local var_465_43 = math.max(var_465_35, arg_462_1.talkMaxDuration)

			if var_465_42 <= arg_462_1.time_ and arg_462_1.time_ < var_465_42 + var_465_43 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_42) / var_465_43

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_42 + var_465_43 and arg_462_1.time_ < var_465_42 + var_465_43 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0305",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0305",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play121511121 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 121511121
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play121511122(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 1.4

			if var_471_0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_2 = arg_468_1:GetWordFromCfg(121511121)
				local var_471_3 = arg_468_1:FormatText(var_471_2.content)

				arg_468_1.text_.text = var_471_3

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_4 = 56
				local var_471_5 = utf8.len(var_471_3)
				local var_471_6 = var_471_4 <= 0 and var_471_1 or var_471_1 * (var_471_5 / var_471_4)

				if var_471_6 > 0 and var_471_1 < var_471_6 then
					arg_468_1.talkMaxDuration = var_471_6

					if var_471_6 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_6 + var_471_0
					end
				end

				arg_468_1.text_.text = var_471_3
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_7 = math.max(var_471_1, arg_468_1.talkMaxDuration)

			if var_471_0 <= arg_468_1.time_ and arg_468_1.time_ < var_471_0 + var_471_7 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_0) / var_471_7

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_0 + var_471_7 and arg_468_1.time_ < var_471_0 + var_471_7 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play121511122 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 121511122
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play121511123(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0
			local var_475_1 = 1.1

			if var_475_0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, false)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_2 = arg_472_1:GetWordFromCfg(121511122)
				local var_475_3 = arg_472_1:FormatText(var_475_2.content)

				arg_472_1.text_.text = var_475_3

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_4 = 44
				local var_475_5 = utf8.len(var_475_3)
				local var_475_6 = var_475_4 <= 0 and var_475_1 or var_475_1 * (var_475_5 / var_475_4)

				if var_475_6 > 0 and var_475_1 < var_475_6 then
					arg_472_1.talkMaxDuration = var_475_6

					if var_475_6 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_6 + var_475_0
					end
				end

				arg_472_1.text_.text = var_475_3
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_7 = math.max(var_475_1, arg_472_1.talkMaxDuration)

			if var_475_0 <= arg_472_1.time_ and arg_472_1.time_ < var_475_0 + var_475_7 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_0) / var_475_7

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_0 + var_475_7 and arg_472_1.time_ < var_475_0 + var_475_7 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play121511123 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 121511123
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play121511124(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0
			local var_479_1 = 1.025

			if var_479_0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_2 = arg_476_1:GetWordFromCfg(121511123)
				local var_479_3 = arg_476_1:FormatText(var_479_2.content)

				arg_476_1.text_.text = var_479_3

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_4 = 41
				local var_479_5 = utf8.len(var_479_3)
				local var_479_6 = var_479_4 <= 0 and var_479_1 or var_479_1 * (var_479_5 / var_479_4)

				if var_479_6 > 0 and var_479_1 < var_479_6 then
					arg_476_1.talkMaxDuration = var_479_6

					if var_479_6 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_6 + var_479_0
					end
				end

				arg_476_1.text_.text = var_479_3
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_7 = math.max(var_479_1, arg_476_1.talkMaxDuration)

			if var_479_0 <= arg_476_1.time_ and arg_476_1.time_ < var_479_0 + var_479_7 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_0) / var_479_7

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_0 + var_479_7 and arg_476_1.time_ < var_479_0 + var_479_7 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play121511124 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 121511124
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play121511125(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0
			local var_483_1 = 1.275

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_2 = arg_480_1:GetWordFromCfg(121511124)
				local var_483_3 = arg_480_1:FormatText(var_483_2.content)

				arg_480_1.text_.text = var_483_3

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_4 = 51
				local var_483_5 = utf8.len(var_483_3)
				local var_483_6 = var_483_4 <= 0 and var_483_1 or var_483_1 * (var_483_5 / var_483_4)

				if var_483_6 > 0 and var_483_1 < var_483_6 then
					arg_480_1.talkMaxDuration = var_483_6

					if var_483_6 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_6 + var_483_0
					end
				end

				arg_480_1.text_.text = var_483_3
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_7 = math.max(var_483_1, arg_480_1.talkMaxDuration)

			if var_483_0 <= arg_480_1.time_ and arg_480_1.time_ < var_483_0 + var_483_7 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_0) / var_483_7

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_0 + var_483_7 and arg_480_1.time_ < var_483_0 + var_483_7 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play121511125 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 121511125
		arg_484_1.duration_ = 12.87

		local var_484_0 = {
			ja = 12.866,
			ko = 8.166,
			zh = 8.166
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play121511126(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0
			local var_487_1 = 0.85

			if var_487_0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_2 = arg_484_1:FormatText(StoryNameCfg[388].name)

				arg_484_1.leftNameTxt_.text = var_487_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_3 = arg_484_1:GetWordFromCfg(121511125)
				local var_487_4 = arg_484_1:FormatText(var_487_3.content)

				arg_484_1.text_.text = var_487_4

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 34
				local var_487_6 = utf8.len(var_487_4)
				local var_487_7 = var_487_5 <= 0 and var_487_1 or var_487_1 * (var_487_6 / var_487_5)

				if var_487_7 > 0 and var_487_1 < var_487_7 then
					arg_484_1.talkMaxDuration = var_487_7

					if var_487_7 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_7 + var_487_0
					end
				end

				arg_484_1.text_.text = var_487_4
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511125", "story_v_out_121511.awb") ~= 0 then
					local var_487_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511125", "story_v_out_121511.awb") / 1000

					if var_487_8 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_8 + var_487_0
					end

					if var_487_3.prefab_name ~= "" and arg_484_1.actors_[var_487_3.prefab_name] ~= nil then
						local var_487_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_3.prefab_name].transform, "story_v_out_121511", "121511125", "story_v_out_121511.awb")

						arg_484_1:RecordAudio("121511125", var_487_9)
						arg_484_1:RecordAudio("121511125", var_487_9)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_121511", "121511125", "story_v_out_121511.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_121511", "121511125", "story_v_out_121511.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_10 = math.max(var_487_1, arg_484_1.talkMaxDuration)

			if var_487_0 <= arg_484_1.time_ and arg_484_1.time_ < var_487_0 + var_487_10 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_0) / var_487_10

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_0 + var_487_10 and arg_484_1.time_ < var_487_0 + var_487_10 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play121511126 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 121511126
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play121511127(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 0
			local var_491_1 = 0.425

			if var_491_0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_2 = arg_488_1:FormatText(StoryNameCfg[7].name)

				arg_488_1.leftNameTxt_.text = var_491_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, true)
				arg_488_1.iconController_:SetSelectedState("hero")

				arg_488_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_488_1.callingController_:SetSelectedState("normal")

				arg_488_1.keyicon_.color = Color.New(1, 1, 1)
				arg_488_1.icon_.color = Color.New(1, 1, 1)

				local var_491_3 = arg_488_1:GetWordFromCfg(121511126)
				local var_491_4 = arg_488_1:FormatText(var_491_3.content)

				arg_488_1.text_.text = var_491_4

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_5 = 17
				local var_491_6 = utf8.len(var_491_4)
				local var_491_7 = var_491_5 <= 0 and var_491_1 or var_491_1 * (var_491_6 / var_491_5)

				if var_491_7 > 0 and var_491_1 < var_491_7 then
					arg_488_1.talkMaxDuration = var_491_7

					if var_491_7 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_7 + var_491_0
					end
				end

				arg_488_1.text_.text = var_491_4
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_8 = math.max(var_491_1, arg_488_1.talkMaxDuration)

			if var_491_0 <= arg_488_1.time_ and arg_488_1.time_ < var_491_0 + var_491_8 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_0) / var_491_8

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_0 + var_491_8 and arg_488_1.time_ < var_491_0 + var_491_8 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play121511127 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 121511127
		arg_492_1.duration_ = 5.23

		local var_492_0 = {
			ja = 1.8,
			ko = 5.233,
			zh = 5.233
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play121511128(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = 0
			local var_495_1 = 0.375

			if var_495_0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_2 = arg_492_1:FormatText(StoryNameCfg[388].name)

				arg_492_1.leftNameTxt_.text = var_495_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_3 = arg_492_1:GetWordFromCfg(121511127)
				local var_495_4 = arg_492_1:FormatText(var_495_3.content)

				arg_492_1.text_.text = var_495_4

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_5 = 15
				local var_495_6 = utf8.len(var_495_4)
				local var_495_7 = var_495_5 <= 0 and var_495_1 or var_495_1 * (var_495_6 / var_495_5)

				if var_495_7 > 0 and var_495_1 < var_495_7 then
					arg_492_1.talkMaxDuration = var_495_7

					if var_495_7 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_7 + var_495_0
					end
				end

				arg_492_1.text_.text = var_495_4
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511127", "story_v_out_121511.awb") ~= 0 then
					local var_495_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511127", "story_v_out_121511.awb") / 1000

					if var_495_8 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_8 + var_495_0
					end

					if var_495_3.prefab_name ~= "" and arg_492_1.actors_[var_495_3.prefab_name] ~= nil then
						local var_495_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_3.prefab_name].transform, "story_v_out_121511", "121511127", "story_v_out_121511.awb")

						arg_492_1:RecordAudio("121511127", var_495_9)
						arg_492_1:RecordAudio("121511127", var_495_9)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_121511", "121511127", "story_v_out_121511.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_121511", "121511127", "story_v_out_121511.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_10 = math.max(var_495_1, arg_492_1.talkMaxDuration)

			if var_495_0 <= arg_492_1.time_ and arg_492_1.time_ < var_495_0 + var_495_10 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_0) / var_495_10

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_0 + var_495_10 and arg_492_1.time_ < var_495_0 + var_495_10 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play121511128 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 121511128
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play121511129(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0
			local var_499_1 = 1.625

			if var_499_0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_2 = arg_496_1:FormatText(StoryNameCfg[7].name)

				arg_496_1.leftNameTxt_.text = var_499_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_3 = arg_496_1:GetWordFromCfg(121511128)
				local var_499_4 = arg_496_1:FormatText(var_499_3.content)

				arg_496_1.text_.text = var_499_4

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_5 = 65
				local var_499_6 = utf8.len(var_499_4)
				local var_499_7 = var_499_5 <= 0 and var_499_1 or var_499_1 * (var_499_6 / var_499_5)

				if var_499_7 > 0 and var_499_1 < var_499_7 then
					arg_496_1.talkMaxDuration = var_499_7

					if var_499_7 + var_499_0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_7 + var_499_0
					end
				end

				arg_496_1.text_.text = var_499_4
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_8 = math.max(var_499_1, arg_496_1.talkMaxDuration)

			if var_499_0 <= arg_496_1.time_ and arg_496_1.time_ < var_499_0 + var_499_8 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_0) / var_499_8

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_0 + var_499_8 and arg_496_1.time_ < var_499_0 + var_499_8 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play121511129 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 121511129
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play121511130(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 0.675

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

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_3 = arg_500_1:GetWordFromCfg(121511129)
				local var_503_4 = arg_500_1:FormatText(var_503_3.content)

				arg_500_1.text_.text = var_503_4

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_5 = 27
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
	Play121511130 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 121511130
		arg_504_1.duration_ = 6.17

		local var_504_0 = {
			ja = 6.133,
			ko = 6.166,
			zh = 6.166
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
				arg_504_0:Play121511131(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 0.475

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_2 = arg_504_1:FormatText(StoryNameCfg[388].name)

				arg_504_1.leftNameTxt_.text = var_507_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_3 = arg_504_1:GetWordFromCfg(121511130)
				local var_507_4 = arg_504_1:FormatText(var_507_3.content)

				arg_504_1.text_.text = var_507_4

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 19
				local var_507_6 = utf8.len(var_507_4)
				local var_507_7 = var_507_5 <= 0 and var_507_1 or var_507_1 * (var_507_6 / var_507_5)

				if var_507_7 > 0 and var_507_1 < var_507_7 then
					arg_504_1.talkMaxDuration = var_507_7

					if var_507_7 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_7 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_4
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511130", "story_v_out_121511.awb") ~= 0 then
					local var_507_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511130", "story_v_out_121511.awb") / 1000

					if var_507_8 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_8 + var_507_0
					end

					if var_507_3.prefab_name ~= "" and arg_504_1.actors_[var_507_3.prefab_name] ~= nil then
						local var_507_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_3.prefab_name].transform, "story_v_out_121511", "121511130", "story_v_out_121511.awb")

						arg_504_1:RecordAudio("121511130", var_507_9)
						arg_504_1:RecordAudio("121511130", var_507_9)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_121511", "121511130", "story_v_out_121511.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_121511", "121511130", "story_v_out_121511.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_10 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_10 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_10

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_10 and arg_504_1.time_ < var_507_0 + var_507_10 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play121511131 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 121511131
		arg_508_1.duration_ = 11.2

		local var_508_0 = {
			ja = 11.2,
			ko = 9.233,
			zh = 9.233
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play121511132(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0
			local var_511_1 = 0.9

			if var_511_0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_2 = arg_508_1:FormatText(StoryNameCfg[388].name)

				arg_508_1.leftNameTxt_.text = var_511_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_3 = arg_508_1:GetWordFromCfg(121511131)
				local var_511_4 = arg_508_1:FormatText(var_511_3.content)

				arg_508_1.text_.text = var_511_4

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_5 = 36
				local var_511_6 = utf8.len(var_511_4)
				local var_511_7 = var_511_5 <= 0 and var_511_1 or var_511_1 * (var_511_6 / var_511_5)

				if var_511_7 > 0 and var_511_1 < var_511_7 then
					arg_508_1.talkMaxDuration = var_511_7

					if var_511_7 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_7 + var_511_0
					end
				end

				arg_508_1.text_.text = var_511_4
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511131", "story_v_out_121511.awb") ~= 0 then
					local var_511_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511131", "story_v_out_121511.awb") / 1000

					if var_511_8 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_8 + var_511_0
					end

					if var_511_3.prefab_name ~= "" and arg_508_1.actors_[var_511_3.prefab_name] ~= nil then
						local var_511_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_3.prefab_name].transform, "story_v_out_121511", "121511131", "story_v_out_121511.awb")

						arg_508_1:RecordAudio("121511131", var_511_9)
						arg_508_1:RecordAudio("121511131", var_511_9)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_121511", "121511131", "story_v_out_121511.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_121511", "121511131", "story_v_out_121511.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_10 = math.max(var_511_1, arg_508_1.talkMaxDuration)

			if var_511_0 <= arg_508_1.time_ and arg_508_1.time_ < var_511_0 + var_511_10 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_0) / var_511_10

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_0 + var_511_10 and arg_508_1.time_ < var_511_0 + var_511_10 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play121511132 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 121511132
		arg_512_1.duration_ = 2.27

		local var_512_0 = {
			ja = 1.7,
			ko = 2.266,
			zh = 2.266
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play121511133(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = 0
			local var_515_1 = 0.35

			if var_515_0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_0 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_2 = arg_512_1:FormatText(StoryNameCfg[6].name)

				arg_512_1.leftNameTxt_.text = var_515_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, true)
				arg_512_1.iconController_:SetSelectedState("hero")

				arg_512_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_512_1.callingController_:SetSelectedState("normal")

				arg_512_1.keyicon_.color = Color.New(1, 1, 1)
				arg_512_1.icon_.color = Color.New(1, 1, 1)

				local var_515_3 = arg_512_1:GetWordFromCfg(121511132)
				local var_515_4 = arg_512_1:FormatText(var_515_3.content)

				arg_512_1.text_.text = var_515_4

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_5 = 14
				local var_515_6 = utf8.len(var_515_4)
				local var_515_7 = var_515_5 <= 0 and var_515_1 or var_515_1 * (var_515_6 / var_515_5)

				if var_515_7 > 0 and var_515_1 < var_515_7 then
					arg_512_1.talkMaxDuration = var_515_7

					if var_515_7 + var_515_0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_7 + var_515_0
					end
				end

				arg_512_1.text_.text = var_515_4
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511132", "story_v_out_121511.awb") ~= 0 then
					local var_515_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511132", "story_v_out_121511.awb") / 1000

					if var_515_8 + var_515_0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_8 + var_515_0
					end

					if var_515_3.prefab_name ~= "" and arg_512_1.actors_[var_515_3.prefab_name] ~= nil then
						local var_515_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_3.prefab_name].transform, "story_v_out_121511", "121511132", "story_v_out_121511.awb")

						arg_512_1:RecordAudio("121511132", var_515_9)
						arg_512_1:RecordAudio("121511132", var_515_9)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_121511", "121511132", "story_v_out_121511.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_121511", "121511132", "story_v_out_121511.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_10 = math.max(var_515_1, arg_512_1.talkMaxDuration)

			if var_515_0 <= arg_512_1.time_ and arg_512_1.time_ < var_515_0 + var_515_10 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_0) / var_515_10

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_0 + var_515_10 and arg_512_1.time_ < var_515_0 + var_515_10 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play121511133 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 121511133
		arg_516_1.duration_ = 7.27

		local var_516_0 = {
			ja = 5.233,
			ko = 7.266,
			zh = 7.266
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
				arg_516_0:Play121511134(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 0
			local var_519_1 = 0.55

			if var_519_0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_0 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_2 = arg_516_1:FormatText(StoryNameCfg[388].name)

				arg_516_1.leftNameTxt_.text = var_519_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_3 = arg_516_1:GetWordFromCfg(121511133)
				local var_519_4 = arg_516_1:FormatText(var_519_3.content)

				arg_516_1.text_.text = var_519_4

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_5 = 22
				local var_519_6 = utf8.len(var_519_4)
				local var_519_7 = var_519_5 <= 0 and var_519_1 or var_519_1 * (var_519_6 / var_519_5)

				if var_519_7 > 0 and var_519_1 < var_519_7 then
					arg_516_1.talkMaxDuration = var_519_7

					if var_519_7 + var_519_0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_7 + var_519_0
					end
				end

				arg_516_1.text_.text = var_519_4
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511133", "story_v_out_121511.awb") ~= 0 then
					local var_519_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511133", "story_v_out_121511.awb") / 1000

					if var_519_8 + var_519_0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_8 + var_519_0
					end

					if var_519_3.prefab_name ~= "" and arg_516_1.actors_[var_519_3.prefab_name] ~= nil then
						local var_519_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_3.prefab_name].transform, "story_v_out_121511", "121511133", "story_v_out_121511.awb")

						arg_516_1:RecordAudio("121511133", var_519_9)
						arg_516_1:RecordAudio("121511133", var_519_9)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_121511", "121511133", "story_v_out_121511.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_121511", "121511133", "story_v_out_121511.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_10 = math.max(var_519_1, arg_516_1.talkMaxDuration)

			if var_519_0 <= arg_516_1.time_ and arg_516_1.time_ < var_519_0 + var_519_10 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_0) / var_519_10

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_0 + var_519_10 and arg_516_1.time_ < var_519_0 + var_519_10 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play121511134 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 121511134
		arg_520_1.duration_ = 11.07

		local var_520_0 = {
			ja = 11.066,
			ko = 8.633,
			zh = 8.633
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play121511135(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0
			local var_523_1 = 0.925

			if var_523_0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_2 = arg_520_1:FormatText(StoryNameCfg[381].name)

				arg_520_1.leftNameTxt_.text = var_523_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, true)
				arg_520_1.iconController_:SetSelectedState("hero")

				arg_520_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_520_1.callingController_:SetSelectedState("normal")

				arg_520_1.keyicon_.color = Color.New(1, 1, 1)
				arg_520_1.icon_.color = Color.New(1, 1, 1)

				local var_523_3 = arg_520_1:GetWordFromCfg(121511134)
				local var_523_4 = arg_520_1:FormatText(var_523_3.content)

				arg_520_1.text_.text = var_523_4

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_5 = 37
				local var_523_6 = utf8.len(var_523_4)
				local var_523_7 = var_523_5 <= 0 and var_523_1 or var_523_1 * (var_523_6 / var_523_5)

				if var_523_7 > 0 and var_523_1 < var_523_7 then
					arg_520_1.talkMaxDuration = var_523_7

					if var_523_7 + var_523_0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_7 + var_523_0
					end
				end

				arg_520_1.text_.text = var_523_4
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511134", "story_v_out_121511.awb") ~= 0 then
					local var_523_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511134", "story_v_out_121511.awb") / 1000

					if var_523_8 + var_523_0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_8 + var_523_0
					end

					if var_523_3.prefab_name ~= "" and arg_520_1.actors_[var_523_3.prefab_name] ~= nil then
						local var_523_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_3.prefab_name].transform, "story_v_out_121511", "121511134", "story_v_out_121511.awb")

						arg_520_1:RecordAudio("121511134", var_523_9)
						arg_520_1:RecordAudio("121511134", var_523_9)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_out_121511", "121511134", "story_v_out_121511.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_out_121511", "121511134", "story_v_out_121511.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_10 = math.max(var_523_1, arg_520_1.talkMaxDuration)

			if var_523_0 <= arg_520_1.time_ and arg_520_1.time_ < var_523_0 + var_523_10 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_0) / var_523_10

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_0 + var_523_10 and arg_520_1.time_ < var_523_0 + var_523_10 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play121511135 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 121511135
		arg_524_1.duration_ = 11.93

		local var_524_0 = {
			ja = 11.933,
			ko = 8.666,
			zh = 8.666
		}
		local var_524_1 = manager.audio:GetLocalizationFlag()

		if var_524_0[var_524_1] ~= nil then
			arg_524_1.duration_ = var_524_0[var_524_1]
		end

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play121511136(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0
			local var_527_1 = 0.625

			if var_527_0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_2 = arg_524_1:FormatText(StoryNameCfg[388].name)

				arg_524_1.leftNameTxt_.text = var_527_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_3 = arg_524_1:GetWordFromCfg(121511135)
				local var_527_4 = arg_524_1:FormatText(var_527_3.content)

				arg_524_1.text_.text = var_527_4

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_5 = 25
				local var_527_6 = utf8.len(var_527_4)
				local var_527_7 = var_527_5 <= 0 and var_527_1 or var_527_1 * (var_527_6 / var_527_5)

				if var_527_7 > 0 and var_527_1 < var_527_7 then
					arg_524_1.talkMaxDuration = var_527_7

					if var_527_7 + var_527_0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_7 + var_527_0
					end
				end

				arg_524_1.text_.text = var_527_4
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511135", "story_v_out_121511.awb") ~= 0 then
					local var_527_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511135", "story_v_out_121511.awb") / 1000

					if var_527_8 + var_527_0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_8 + var_527_0
					end

					if var_527_3.prefab_name ~= "" and arg_524_1.actors_[var_527_3.prefab_name] ~= nil then
						local var_527_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_3.prefab_name].transform, "story_v_out_121511", "121511135", "story_v_out_121511.awb")

						arg_524_1:RecordAudio("121511135", var_527_9)
						arg_524_1:RecordAudio("121511135", var_527_9)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_out_121511", "121511135", "story_v_out_121511.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_out_121511", "121511135", "story_v_out_121511.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_10 = math.max(var_527_1, arg_524_1.talkMaxDuration)

			if var_527_0 <= arg_524_1.time_ and arg_524_1.time_ < var_527_0 + var_527_10 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_0) / var_527_10

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_0 + var_527_10 and arg_524_1.time_ < var_527_0 + var_527_10 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play121511136 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 121511136
		arg_528_1.duration_ = 10.9

		local var_528_0 = {
			ja = 10.9,
			ko = 10.033,
			zh = 10.033
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
				arg_528_0:Play121511137(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0
			local var_531_1 = 1.075

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_2 = arg_528_1:FormatText(StoryNameCfg[388].name)

				arg_528_1.leftNameTxt_.text = var_531_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_3 = arg_528_1:GetWordFromCfg(121511136)
				local var_531_4 = arg_528_1:FormatText(var_531_3.content)

				arg_528_1.text_.text = var_531_4

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_5 = 43
				local var_531_6 = utf8.len(var_531_4)
				local var_531_7 = var_531_5 <= 0 and var_531_1 or var_531_1 * (var_531_6 / var_531_5)

				if var_531_7 > 0 and var_531_1 < var_531_7 then
					arg_528_1.talkMaxDuration = var_531_7

					if var_531_7 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_7 + var_531_0
					end
				end

				arg_528_1.text_.text = var_531_4
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511136", "story_v_out_121511.awb") ~= 0 then
					local var_531_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511136", "story_v_out_121511.awb") / 1000

					if var_531_8 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_8 + var_531_0
					end

					if var_531_3.prefab_name ~= "" and arg_528_1.actors_[var_531_3.prefab_name] ~= nil then
						local var_531_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_3.prefab_name].transform, "story_v_out_121511", "121511136", "story_v_out_121511.awb")

						arg_528_1:RecordAudio("121511136", var_531_9)
						arg_528_1:RecordAudio("121511136", var_531_9)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_out_121511", "121511136", "story_v_out_121511.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_out_121511", "121511136", "story_v_out_121511.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_10 = math.max(var_531_1, arg_528_1.talkMaxDuration)

			if var_531_0 <= arg_528_1.time_ and arg_528_1.time_ < var_531_0 + var_531_10 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_0) / var_531_10

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_0 + var_531_10 and arg_528_1.time_ < var_531_0 + var_531_10 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play121511137 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 121511137
		arg_532_1.duration_ = 12.4

		local var_532_0 = {
			ja = 12.4,
			ko = 8.966,
			zh = 8.966
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
				arg_532_0:Play121511138(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 0.9

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_2 = arg_532_1:FormatText(StoryNameCfg[388].name)

				arg_532_1.leftNameTxt_.text = var_535_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_3 = arg_532_1:GetWordFromCfg(121511137)
				local var_535_4 = arg_532_1:FormatText(var_535_3.content)

				arg_532_1.text_.text = var_535_4

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 36
				local var_535_6 = utf8.len(var_535_4)
				local var_535_7 = var_535_5 <= 0 and var_535_1 or var_535_1 * (var_535_6 / var_535_5)

				if var_535_7 > 0 and var_535_1 < var_535_7 then
					arg_532_1.talkMaxDuration = var_535_7

					if var_535_7 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_7 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_4
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511137", "story_v_out_121511.awb") ~= 0 then
					local var_535_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511137", "story_v_out_121511.awb") / 1000

					if var_535_8 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_8 + var_535_0
					end

					if var_535_3.prefab_name ~= "" and arg_532_1.actors_[var_535_3.prefab_name] ~= nil then
						local var_535_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_3.prefab_name].transform, "story_v_out_121511", "121511137", "story_v_out_121511.awb")

						arg_532_1:RecordAudio("121511137", var_535_9)
						arg_532_1:RecordAudio("121511137", var_535_9)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_out_121511", "121511137", "story_v_out_121511.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_out_121511", "121511137", "story_v_out_121511.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_10 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_10 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_10

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_10 and arg_532_1.time_ < var_535_0 + var_535_10 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play121511138 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 121511138
		arg_536_1.duration_ = 17.63

		local var_536_0 = {
			ja = 17.633,
			ko = 7.8,
			zh = 7.8
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
				arg_536_0:Play121511139(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0
			local var_539_1 = 0.8

			if var_539_0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_0 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_2 = arg_536_1:FormatText(StoryNameCfg[388].name)

				arg_536_1.leftNameTxt_.text = var_539_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_3 = arg_536_1:GetWordFromCfg(121511138)
				local var_539_4 = arg_536_1:FormatText(var_539_3.content)

				arg_536_1.text_.text = var_539_4

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511138", "story_v_out_121511.awb") ~= 0 then
					local var_539_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511138", "story_v_out_121511.awb") / 1000

					if var_539_8 + var_539_0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_8 + var_539_0
					end

					if var_539_3.prefab_name ~= "" and arg_536_1.actors_[var_539_3.prefab_name] ~= nil then
						local var_539_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_3.prefab_name].transform, "story_v_out_121511", "121511138", "story_v_out_121511.awb")

						arg_536_1:RecordAudio("121511138", var_539_9)
						arg_536_1:RecordAudio("121511138", var_539_9)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_out_121511", "121511138", "story_v_out_121511.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_out_121511", "121511138", "story_v_out_121511.awb")
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
	Play121511139 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 121511139
		arg_540_1.duration_ = 13.87

		local var_540_0 = {
			ja = 13.866,
			ko = 8.6,
			zh = 8.6
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
				arg_540_0:Play121511140(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0
			local var_543_1 = 0.875

			if var_543_0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_2 = arg_540_1:FormatText(StoryNameCfg[388].name)

				arg_540_1.leftNameTxt_.text = var_543_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_3 = arg_540_1:GetWordFromCfg(121511139)
				local var_543_4 = arg_540_1:FormatText(var_543_3.content)

				arg_540_1.text_.text = var_543_4

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511139", "story_v_out_121511.awb") ~= 0 then
					local var_543_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511139", "story_v_out_121511.awb") / 1000

					if var_543_8 + var_543_0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_8 + var_543_0
					end

					if var_543_3.prefab_name ~= "" and arg_540_1.actors_[var_543_3.prefab_name] ~= nil then
						local var_543_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_3.prefab_name].transform, "story_v_out_121511", "121511139", "story_v_out_121511.awb")

						arg_540_1:RecordAudio("121511139", var_543_9)
						arg_540_1:RecordAudio("121511139", var_543_9)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_121511", "121511139", "story_v_out_121511.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_121511", "121511139", "story_v_out_121511.awb")
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
	Play121511140 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 121511140
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play121511141(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0
			local var_547_1 = 0.675

			if var_547_0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_2 = arg_544_1:FormatText(StoryNameCfg[7].name)

				arg_544_1.leftNameTxt_.text = var_547_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, true)
				arg_544_1.iconController_:SetSelectedState("hero")

				arg_544_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_544_1.callingController_:SetSelectedState("normal")

				arg_544_1.keyicon_.color = Color.New(1, 1, 1)
				arg_544_1.icon_.color = Color.New(1, 1, 1)

				local var_547_3 = arg_544_1:GetWordFromCfg(121511140)
				local var_547_4 = arg_544_1:FormatText(var_547_3.content)

				arg_544_1.text_.text = var_547_4

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_5 = 27
				local var_547_6 = utf8.len(var_547_4)
				local var_547_7 = var_547_5 <= 0 and var_547_1 or var_547_1 * (var_547_6 / var_547_5)

				if var_547_7 > 0 and var_547_1 < var_547_7 then
					arg_544_1.talkMaxDuration = var_547_7

					if var_547_7 + var_547_0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_7 + var_547_0
					end
				end

				arg_544_1.text_.text = var_547_4
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_8 = math.max(var_547_1, arg_544_1.talkMaxDuration)

			if var_547_0 <= arg_544_1.time_ and arg_544_1.time_ < var_547_0 + var_547_8 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_0) / var_547_8

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_0 + var_547_8 and arg_544_1.time_ < var_547_0 + var_547_8 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play121511141 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 121511141
		arg_548_1.duration_ = 18.33

		local var_548_0 = {
			ja = 18.333,
			ko = 11.733,
			zh = 11.733
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play121511142(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0
			local var_551_1 = 0.975

			if var_551_0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				local var_551_2 = arg_548_1:FormatText(StoryNameCfg[441].name)

				arg_548_1.leftNameTxt_.text = var_551_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_3 = arg_548_1:GetWordFromCfg(121511141)
				local var_551_4 = arg_548_1:FormatText(var_551_3.content)

				arg_548_1.text_.text = var_551_4

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_5 = 39
				local var_551_6 = utf8.len(var_551_4)
				local var_551_7 = var_551_5 <= 0 and var_551_1 or var_551_1 * (var_551_6 / var_551_5)

				if var_551_7 > 0 and var_551_1 < var_551_7 then
					arg_548_1.talkMaxDuration = var_551_7

					if var_551_7 + var_551_0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_7 + var_551_0
					end
				end

				arg_548_1.text_.text = var_551_4
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511141", "story_v_out_121511.awb") ~= 0 then
					local var_551_8 = manager.audio:GetVoiceLength("story_v_out_121511", "121511141", "story_v_out_121511.awb") / 1000

					if var_551_8 + var_551_0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_8 + var_551_0
					end

					if var_551_3.prefab_name ~= "" and arg_548_1.actors_[var_551_3.prefab_name] ~= nil then
						local var_551_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_3.prefab_name].transform, "story_v_out_121511", "121511141", "story_v_out_121511.awb")

						arg_548_1:RecordAudio("121511141", var_551_9)
						arg_548_1:RecordAudio("121511141", var_551_9)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_out_121511", "121511141", "story_v_out_121511.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_out_121511", "121511141", "story_v_out_121511.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_10 = math.max(var_551_1, arg_548_1.talkMaxDuration)

			if var_551_0 <= arg_548_1.time_ and arg_548_1.time_ < var_551_0 + var_551_10 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_0) / var_551_10

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_0 + var_551_10 and arg_548_1.time_ < var_551_0 + var_551_10 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play121511142 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 121511142
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play121511143(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = manager.ui.mainCamera.transform
			local var_555_1 = 0

			if var_555_1 < arg_552_1.time_ and arg_552_1.time_ <= var_555_1 + arg_555_0 then
				local var_555_2 = arg_552_1.var_.effectxuehua2

				if var_555_2 then
					Object.Destroy(var_555_2)

					arg_552_1.var_.effectxuehua2 = nil
				end
			end

			local var_555_3 = 0
			local var_555_4 = 0.633333333333333

			if var_555_3 < arg_552_1.time_ and arg_552_1.time_ <= var_555_3 + arg_555_0 then
				local var_555_5 = "play"
				local var_555_6 = "effect"

				arg_552_1:AudioAction(var_555_5, var_555_6, "se_story_121_04", "se_story_121_04_spacegap", "")
			end

			local var_555_7 = 0
			local var_555_8 = 0.85

			if var_555_7 < arg_552_1.time_ and arg_552_1.time_ <= var_555_7 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0

				arg_552_1.dialog_:SetActive(true)

				arg_552_1.dialogCg_.alpha = 0

				local var_555_9 = LeanTween.value(arg_552_1.dialog_, 0, 1, 0.3)

				var_555_9:setOnUpdate(LuaHelper.FloatAction(function(arg_556_0)
					arg_552_1.dialogCg_.alpha = arg_556_0
				end))
				var_555_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_552_1.dialog_)
					var_555_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_552_1.duration_ = arg_552_1.duration_ + 0.3

				SetActive(arg_552_1.leftNameGo_, false)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_10 = arg_552_1:GetWordFromCfg(121511142)
				local var_555_11 = arg_552_1:FormatText(var_555_10.content)

				arg_552_1.text_.text = var_555_11

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_12 = 34
				local var_555_13 = utf8.len(var_555_11)
				local var_555_14 = var_555_12 <= 0 and var_555_8 or var_555_8 * (var_555_13 / var_555_12)

				if var_555_14 > 0 and var_555_8 < var_555_14 then
					arg_552_1.talkMaxDuration = var_555_14
					var_555_7 = var_555_7 + 0.3

					if var_555_14 + var_555_7 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_14 + var_555_7
					end
				end

				arg_552_1.text_.text = var_555_11
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_15 = var_555_7 + 0.3
			local var_555_16 = math.max(var_555_8, arg_552_1.talkMaxDuration)

			if var_555_15 <= arg_552_1.time_ and arg_552_1.time_ < var_555_15 + var_555_16 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_15) / var_555_16

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_15 + var_555_16 and arg_552_1.time_ < var_555_15 + var_555_16 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play121511143 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 121511143
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play121511144(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0.166666666666667
			local var_561_1 = 0.633333333333333

			if var_561_0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_0 + arg_561_0 then
				local var_561_2 = "play"
				local var_561_3 = "effect"

				arg_558_1:AudioAction(var_561_2, var_561_3, "se_story_121_04", "se_story_121_04_monsterchange", "")
			end

			local var_561_4 = 0
			local var_561_5 = 1.55

			if var_561_4 < arg_558_1.time_ and arg_558_1.time_ <= var_561_4 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, false)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_6 = arg_558_1:GetWordFromCfg(121511143)
				local var_561_7 = arg_558_1:FormatText(var_561_6.content)

				arg_558_1.text_.text = var_561_7

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_8 = 62
				local var_561_9 = utf8.len(var_561_7)
				local var_561_10 = var_561_8 <= 0 and var_561_5 or var_561_5 * (var_561_9 / var_561_8)

				if var_561_10 > 0 and var_561_5 < var_561_10 then
					arg_558_1.talkMaxDuration = var_561_10

					if var_561_10 + var_561_4 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_10 + var_561_4
					end
				end

				arg_558_1.text_.text = var_561_7
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_11 = math.max(var_561_5, arg_558_1.talkMaxDuration)

			if var_561_4 <= arg_558_1.time_ and arg_558_1.time_ < var_561_4 + var_561_11 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_4) / var_561_11

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_4 + var_561_11 and arg_558_1.time_ < var_561_4 + var_561_11 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play121511144 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 121511144
		arg_562_1.duration_ = 9.32

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play121511145(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = "STblack"

			if arg_562_1.bgs_[var_565_0] == nil then
				local var_565_1 = Object.Instantiate(arg_562_1.paintGo_)

				var_565_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_565_0)
				var_565_1.name = var_565_0
				var_565_1.transform.parent = arg_562_1.stage_.transform
				var_565_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_562_1.bgs_[var_565_0] = var_565_1
			end

			local var_565_2 = 2

			if var_565_2 < arg_562_1.time_ and arg_562_1.time_ <= var_565_2 + arg_565_0 then
				local var_565_3 = manager.ui.mainCamera.transform.localPosition
				local var_565_4 = Vector3.New(0, 0, 10) + Vector3.New(var_565_3.x, var_565_3.y, 0)
				local var_565_5 = arg_562_1.bgs_.STblack

				var_565_5.transform.localPosition = var_565_4
				var_565_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_565_6 = var_565_5:GetComponent("SpriteRenderer")

				if var_565_6 and var_565_6.sprite then
					local var_565_7 = (var_565_5.transform.localPosition - var_565_3).z
					local var_565_8 = manager.ui.mainCameraCom_
					local var_565_9 = 2 * var_565_7 * Mathf.Tan(var_565_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_565_10 = var_565_9 * var_565_8.aspect
					local var_565_11 = var_565_6.sprite.bounds.size.x
					local var_565_12 = var_565_6.sprite.bounds.size.y
					local var_565_13 = var_565_10 / var_565_11
					local var_565_14 = var_565_9 / var_565_12
					local var_565_15 = var_565_14 < var_565_13 and var_565_13 or var_565_14

					var_565_5.transform.localScale = Vector3.New(var_565_15, var_565_15, 0)
				end

				for iter_565_0, iter_565_1 in pairs(arg_562_1.bgs_) do
					if iter_565_0 ~= "STblack" then
						iter_565_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_565_16 = 0

			if var_565_16 < arg_562_1.time_ and arg_562_1.time_ <= var_565_16 + arg_565_0 then
				arg_562_1.mask_.enabled = true
				arg_562_1.mask_.raycastTarget = true

				arg_562_1:SetGaussion(false)
			end

			local var_565_17 = 2

			if var_565_16 <= arg_562_1.time_ and arg_562_1.time_ < var_565_16 + var_565_17 then
				local var_565_18 = (arg_562_1.time_ - var_565_16) / var_565_17
				local var_565_19 = Color.New(0, 0, 0)

				var_565_19.a = Mathf.Lerp(0, 1, var_565_18)
				arg_562_1.mask_.color = var_565_19
			end

			if arg_562_1.time_ >= var_565_16 + var_565_17 and arg_562_1.time_ < var_565_16 + var_565_17 + arg_565_0 then
				local var_565_20 = Color.New(0, 0, 0)

				var_565_20.a = 1
				arg_562_1.mask_.color = var_565_20
			end

			local var_565_21 = 2

			if var_565_21 < arg_562_1.time_ and arg_562_1.time_ <= var_565_21 + arg_565_0 then
				arg_562_1.mask_.enabled = true
				arg_562_1.mask_.raycastTarget = true

				arg_562_1:SetGaussion(false)
			end

			local var_565_22 = 2

			if var_565_21 <= arg_562_1.time_ and arg_562_1.time_ < var_565_21 + var_565_22 then
				local var_565_23 = (arg_562_1.time_ - var_565_21) / var_565_22
				local var_565_24 = Color.New(0, 0, 0)

				var_565_24.a = Mathf.Lerp(1, 0, var_565_23)
				arg_562_1.mask_.color = var_565_24
			end

			if arg_562_1.time_ >= var_565_21 + var_565_22 and arg_562_1.time_ < var_565_21 + var_565_22 + arg_565_0 then
				local var_565_25 = Color.New(0, 0, 0)
				local var_565_26 = 0

				arg_562_1.mask_.enabled = false
				var_565_25.a = var_565_26
				arg_562_1.mask_.color = var_565_25
			end

			local var_565_27 = 2

			if var_565_27 < arg_562_1.time_ and arg_562_1.time_ <= var_565_27 + arg_565_0 then
				arg_562_1.fswbg_:SetActive(true)
				arg_562_1.dialog_:SetActive(false)

				arg_562_1.fswtw_.percent = 0

				local var_565_28 = arg_562_1:GetWordFromCfg(121511144)
				local var_565_29 = arg_562_1:FormatText(var_565_28.content)

				arg_562_1.fswt_.text = var_565_29

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.fswt_)

				arg_562_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_562_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_562_1.fswtw_:SetDirty()

				arg_562_1.typewritterCharCountI18N = 0

				SetActive(arg_562_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_562_1:ShowNextGo(false)
			end

			local var_565_30 = 4

			if var_565_30 < arg_562_1.time_ and arg_562_1.time_ <= var_565_30 + arg_565_0 then
				arg_562_1.var_.oldValueTypewriter = arg_562_1.fswtw_.percent

				SetActive(arg_562_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_562_1:ShowNextGo(false)
			end

			local var_565_31 = 25
			local var_565_32 = 1.66666666666667
			local var_565_33 = arg_562_1:GetWordFromCfg(121511144)
			local var_565_34 = arg_562_1:FormatText(var_565_33.content)
			local var_565_35, var_565_36 = arg_562_1:GetPercentByPara(var_565_34, 1)

			if var_565_30 < arg_562_1.time_ and arg_562_1.time_ <= var_565_30 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0

				local var_565_37 = var_565_31 <= 0 and var_565_32 or var_565_32 * ((var_565_36 - arg_562_1.typewritterCharCountI18N) / var_565_31)

				if var_565_37 > 0 and var_565_32 < var_565_37 then
					arg_562_1.talkMaxDuration = var_565_37

					if var_565_37 + var_565_30 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_37 + var_565_30
					end
				end
			end

			local var_565_38 = 1.66666666666667
			local var_565_39 = math.max(var_565_38, arg_562_1.talkMaxDuration)

			if var_565_30 <= arg_562_1.time_ and arg_562_1.time_ < var_565_30 + var_565_39 then
				local var_565_40 = (arg_562_1.time_ - var_565_30) / var_565_39

				arg_562_1.fswtw_.percent = Mathf.Lerp(arg_562_1.var_.oldValueTypewriter, var_565_35, var_565_40)
				arg_562_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_562_1.fswtw_:SetDirty()
			end

			if arg_562_1.time_ >= var_565_30 + var_565_39 and arg_562_1.time_ < var_565_30 + var_565_39 + arg_565_0 then
				arg_562_1.fswtw_.percent = var_565_35

				arg_562_1.fswtw_:SetDirty()
				arg_562_1:ShowNextGo(true)

				arg_562_1.typewritterCharCountI18N = var_565_36
			end

			local var_565_41 = 4

			if var_565_41 < arg_562_1.time_ and arg_562_1.time_ <= var_565_41 + arg_565_0 then
				local var_565_42 = arg_562_1.fswbg_.transform:Find("textbox/adapt/content") or arg_562_1.fswbg_.transform:Find("textbox/content")
				local var_565_43 = arg_562_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_565_44 = var_565_42:GetComponent("Text")
				local var_565_45 = var_565_42:GetComponent("RectTransform")

				var_565_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_565_45.offsetMin = Vector2.New(0, 0)
				var_565_45.offsetMax = Vector2.New(0, 0)
			end

			local var_565_46 = 4.01666666666667
			local var_565_47 = 5.3
			local var_565_48 = manager.audio:GetVoiceLength("story_v_out_121511", "121511144", "story_v_out_121511.awb") / 1000

			if var_565_48 > 0 and var_565_47 < var_565_48 and var_565_48 + var_565_46 > arg_562_1.duration_ then
				local var_565_49 = var_565_48

				arg_562_1.duration_ = var_565_48 + var_565_46
			end

			if var_565_46 < arg_562_1.time_ and arg_562_1.time_ <= var_565_46 + arg_565_0 then
				local var_565_50 = "play"
				local var_565_51 = "voice"

				arg_562_1:AudioAction(var_565_50, var_565_51, "story_v_out_121511", "121511144", "story_v_out_121511.awb")
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play121511145 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 121511145
		arg_566_1.duration_ = 5.07

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play121511146(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 0

			if var_569_0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_0 + arg_569_0 then
				arg_566_1.fswbg_:SetActive(true)
				arg_566_1.dialog_:SetActive(false)

				arg_566_1.fswtw_.percent = 0

				local var_569_1 = arg_566_1:GetWordFromCfg(121511145)
				local var_569_2 = arg_566_1:FormatText(var_569_1.content)

				arg_566_1.fswt_.text = var_569_2

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.fswt_)

				arg_566_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_566_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_566_1.fswtw_:SetDirty()

				arg_566_1.typewritterCharCountI18N = 0

				SetActive(arg_566_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_566_1:ShowNextGo(false)
			end

			local var_569_3 = 0.0166666666666666

			if var_569_3 < arg_566_1.time_ and arg_566_1.time_ <= var_569_3 + arg_569_0 then
				arg_566_1.var_.oldValueTypewriter = arg_566_1.fswtw_.percent

				SetActive(arg_566_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_566_1:ShowNextGo(false)
			end

			local var_569_4 = 27
			local var_569_5 = 1.8
			local var_569_6 = arg_566_1:GetWordFromCfg(121511145)
			local var_569_7 = arg_566_1:FormatText(var_569_6.content)
			local var_569_8, var_569_9 = arg_566_1:GetPercentByPara(var_569_7, 1)

			if var_569_3 < arg_566_1.time_ and arg_566_1.time_ <= var_569_3 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0

				local var_569_10 = var_569_4 <= 0 and var_569_5 or var_569_5 * ((var_569_9 - arg_566_1.typewritterCharCountI18N) / var_569_4)

				if var_569_10 > 0 and var_569_5 < var_569_10 then
					arg_566_1.talkMaxDuration = var_569_10

					if var_569_10 + var_569_3 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_10 + var_569_3
					end
				end
			end

			local var_569_11 = 1.8
			local var_569_12 = math.max(var_569_11, arg_566_1.talkMaxDuration)

			if var_569_3 <= arg_566_1.time_ and arg_566_1.time_ < var_569_3 + var_569_12 then
				local var_569_13 = (arg_566_1.time_ - var_569_3) / var_569_12

				arg_566_1.fswtw_.percent = Mathf.Lerp(arg_566_1.var_.oldValueTypewriter, var_569_8, var_569_13)
				arg_566_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_566_1.fswtw_:SetDirty()
			end

			if arg_566_1.time_ >= var_569_3 + var_569_12 and arg_566_1.time_ < var_569_3 + var_569_12 + arg_569_0 then
				arg_566_1.fswtw_.percent = var_569_8

				arg_566_1.fswtw_:SetDirty()
				arg_566_1:ShowNextGo(true)

				arg_566_1.typewritterCharCountI18N = var_569_9
			end

			local var_569_14 = 0
			local var_569_15 = 5.066
			local var_569_16 = manager.audio:GetVoiceLength("story_v_out_121511", "121511145", "story_v_out_121511.awb") / 1000

			if var_569_16 > 0 and var_569_15 < var_569_16 and var_569_16 + var_569_14 > arg_566_1.duration_ then
				local var_569_17 = var_569_16

				arg_566_1.duration_ = var_569_16 + var_569_14
			end

			if var_569_14 < arg_566_1.time_ and arg_566_1.time_ <= var_569_14 + arg_569_0 then
				local var_569_18 = "play"
				local var_569_19 = "voice"

				arg_566_1:AudioAction(var_569_18, var_569_19, "story_v_out_121511", "121511145", "story_v_out_121511.awb")
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play121511146 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 121511146
		arg_570_1.duration_ = 1.53

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
			arg_570_1.auto_ = false
		end

		function arg_570_1.playNext_(arg_572_0)
			arg_570_1.onStoryFinished_()
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = 0

			if var_573_0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_0 + arg_573_0 then
				arg_570_1.fswbg_:SetActive(true)
				arg_570_1.dialog_:SetActive(false)

				arg_570_1.fswtw_.percent = 0

				local var_573_1 = arg_570_1:GetWordFromCfg(121511146)
				local var_573_2 = arg_570_1:FormatText(var_573_1.content)

				arg_570_1.fswt_.text = var_573_2

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.fswt_)

				arg_570_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_570_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_570_1.fswtw_:SetDirty()

				arg_570_1.typewritterCharCountI18N = 0

				SetActive(arg_570_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_570_1:ShowNextGo(false)
			end

			local var_573_3 = 0.0166666666666665

			if var_573_3 < arg_570_1.time_ and arg_570_1.time_ <= var_573_3 + arg_573_0 then
				arg_570_1.var_.oldValueTypewriter = arg_570_1.fswtw_.percent

				SetActive(arg_570_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_570_1:ShowNextGo(false)
			end

			local var_573_4 = 5
			local var_573_5 = 0.333333333333333
			local var_573_6 = arg_570_1:GetWordFromCfg(121511146)
			local var_573_7 = arg_570_1:FormatText(var_573_6.content)
			local var_573_8, var_573_9 = arg_570_1:GetPercentByPara(var_573_7, 1)

			if var_573_3 < arg_570_1.time_ and arg_570_1.time_ <= var_573_3 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0

				local var_573_10 = var_573_4 <= 0 and var_573_5 or var_573_5 * ((var_573_9 - arg_570_1.typewritterCharCountI18N) / var_573_4)

				if var_573_10 > 0 and var_573_5 < var_573_10 then
					arg_570_1.talkMaxDuration = var_573_10

					if var_573_10 + var_573_3 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_10 + var_573_3
					end
				end
			end

			local var_573_11 = 0.333333333333333
			local var_573_12 = math.max(var_573_11, arg_570_1.talkMaxDuration)

			if var_573_3 <= arg_570_1.time_ and arg_570_1.time_ < var_573_3 + var_573_12 then
				local var_573_13 = (arg_570_1.time_ - var_573_3) / var_573_12

				arg_570_1.fswtw_.percent = Mathf.Lerp(arg_570_1.var_.oldValueTypewriter, var_573_8, var_573_13)
				arg_570_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_570_1.fswtw_:SetDirty()
			end

			if arg_570_1.time_ >= var_573_3 + var_573_12 and arg_570_1.time_ < var_573_3 + var_573_12 + arg_573_0 then
				arg_570_1.fswtw_.percent = var_573_8

				arg_570_1.fswtw_:SetDirty()
				arg_570_1:ShowNextGo(true)

				arg_570_1.typewritterCharCountI18N = var_573_9
			end

			local var_573_14 = 0
			local var_573_15 = 1.533
			local var_573_16 = manager.audio:GetVoiceLength("story_v_out_121511", "121511146", "story_v_out_121511.awb") / 1000

			if var_573_16 > 0 and var_573_15 < var_573_16 and var_573_16 + var_573_14 > arg_570_1.duration_ then
				local var_573_17 = var_573_16

				arg_570_1.duration_ = var_573_16 + var_573_14
			end

			if var_573_14 < arg_570_1.time_ and arg_570_1.time_ <= var_573_14 + arg_573_0 then
				local var_573_18 = "play"
				local var_573_19 = "voice"

				arg_570_1:AudioAction(var_573_18, var_573_19, "story_v_out_121511", "121511146", "story_v_out_121511.awb")
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play121511070 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 121511070
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play121511071(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = arg_574_1.actors_["10042ui_story"]
			local var_577_1 = 0

			if var_577_1 < arg_574_1.time_ and arg_574_1.time_ <= var_577_1 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.characterEffect10042ui_story == nil then
				arg_574_1.var_.characterEffect10042ui_story = var_577_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_2 = 0.200000002980232

			if var_577_1 <= arg_574_1.time_ and arg_574_1.time_ < var_577_1 + var_577_2 and not isNil(var_577_0) then
				local var_577_3 = (arg_574_1.time_ - var_577_1) / var_577_2

				if arg_574_1.var_.characterEffect10042ui_story and not isNil(var_577_0) then
					local var_577_4 = Mathf.Lerp(0, 0.5, var_577_3)

					arg_574_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_574_1.var_.characterEffect10042ui_story.fillRatio = var_577_4
				end
			end

			if arg_574_1.time_ >= var_577_1 + var_577_2 and arg_574_1.time_ < var_577_1 + var_577_2 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.characterEffect10042ui_story then
				local var_577_5 = 0.5

				arg_574_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_574_1.var_.characterEffect10042ui_story.fillRatio = var_577_5
			end

			local var_577_6 = 0
			local var_577_7 = 0.25

			if var_577_6 < arg_574_1.time_ and arg_574_1.time_ <= var_577_6 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				local var_577_8 = arg_574_1:FormatText(StoryNameCfg[7].name)

				arg_574_1.leftNameTxt_.text = var_577_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, true)
				arg_574_1.iconController_:SetSelectedState("hero")

				arg_574_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_574_1.callingController_:SetSelectedState("normal")

				arg_574_1.keyicon_.color = Color.New(1, 1, 1)
				arg_574_1.icon_.color = Color.New(1, 1, 1)

				local var_577_9 = arg_574_1:GetWordFromCfg(121511070)
				local var_577_10 = arg_574_1:FormatText(var_577_9.content)

				arg_574_1.text_.text = var_577_10

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_11 = 10
				local var_577_12 = utf8.len(var_577_10)
				local var_577_13 = var_577_11 <= 0 and var_577_7 or var_577_7 * (var_577_12 / var_577_11)

				if var_577_13 > 0 and var_577_7 < var_577_13 then
					arg_574_1.talkMaxDuration = var_577_13

					if var_577_13 + var_577_6 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_13 + var_577_6
					end
				end

				arg_574_1.text_.text = var_577_10
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_14 = math.max(var_577_7, arg_574_1.talkMaxDuration)

			if var_577_6 <= arg_574_1.time_ and arg_574_1.time_ < var_577_6 + var_577_14 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_6) / var_577_14

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_6 + var_577_14 and arg_574_1.time_ < var_577_6 + var_577_14 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play121511071 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 121511071
		arg_578_1.duration_ = 3.57

		local var_578_0 = {
			ja = 3.566,
			ko = 2.366,
			zh = 2.366
		}
		local var_578_1 = manager.audio:GetLocalizationFlag()

		if var_578_0[var_578_1] ~= nil then
			arg_578_1.duration_ = var_578_0[var_578_1]
		end

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play121511072(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = arg_578_1.actors_["1184ui_story"].transform
			local var_581_1 = 0

			if var_581_1 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 then
				arg_578_1.var_.moveOldPos1184ui_story = var_581_0.localPosition
			end

			local var_581_2 = 0.001

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_2 then
				local var_581_3 = (arg_578_1.time_ - var_581_1) / var_581_2
				local var_581_4 = Vector3.New(0, -0.97, -6)

				var_581_0.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos1184ui_story, var_581_4, var_581_3)

				local var_581_5 = manager.ui.mainCamera.transform.position - var_581_0.position

				var_581_0.forward = Vector3.New(var_581_5.x, var_581_5.y, var_581_5.z)

				local var_581_6 = var_581_0.localEulerAngles

				var_581_6.z = 0
				var_581_6.x = 0
				var_581_0.localEulerAngles = var_581_6
			end

			if arg_578_1.time_ >= var_581_1 + var_581_2 and arg_578_1.time_ < var_581_1 + var_581_2 + arg_581_0 then
				var_581_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_581_7 = manager.ui.mainCamera.transform.position - var_581_0.position

				var_581_0.forward = Vector3.New(var_581_7.x, var_581_7.y, var_581_7.z)

				local var_581_8 = var_581_0.localEulerAngles

				var_581_8.z = 0
				var_581_8.x = 0
				var_581_0.localEulerAngles = var_581_8
			end

			local var_581_9 = arg_578_1.actors_["1184ui_story"]
			local var_581_10 = 0

			if var_581_10 < arg_578_1.time_ and arg_578_1.time_ <= var_581_10 + arg_581_0 and not isNil(var_581_9) and arg_578_1.var_.characterEffect1184ui_story == nil then
				arg_578_1.var_.characterEffect1184ui_story = var_581_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_11 = 0.200000002980232

			if var_581_10 <= arg_578_1.time_ and arg_578_1.time_ < var_581_10 + var_581_11 and not isNil(var_581_9) then
				local var_581_12 = (arg_578_1.time_ - var_581_10) / var_581_11

				if arg_578_1.var_.characterEffect1184ui_story and not isNil(var_581_9) then
					arg_578_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_578_1.time_ >= var_581_10 + var_581_11 and arg_578_1.time_ < var_581_10 + var_581_11 + arg_581_0 and not isNil(var_581_9) and arg_578_1.var_.characterEffect1184ui_story then
				arg_578_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_581_13 = 0

			if var_581_13 < arg_578_1.time_ and arg_578_1.time_ <= var_581_13 + arg_581_0 then
				arg_578_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_581_14 = 0

			if var_581_14 < arg_578_1.time_ and arg_578_1.time_ <= var_581_14 + arg_581_0 then
				arg_578_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_581_15 = 0
			local var_581_16 = 0.2

			if var_581_15 < arg_578_1.time_ and arg_578_1.time_ <= var_581_15 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				local var_581_17 = arg_578_1:FormatText(StoryNameCfg[6].name)

				arg_578_1.leftNameTxt_.text = var_581_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_18 = arg_578_1:GetWordFromCfg(121511071)
				local var_581_19 = arg_578_1:FormatText(var_581_18.content)

				arg_578_1.text_.text = var_581_19

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_20 = 8
				local var_581_21 = utf8.len(var_581_19)
				local var_581_22 = var_581_20 <= 0 and var_581_16 or var_581_16 * (var_581_21 / var_581_20)

				if var_581_22 > 0 and var_581_16 < var_581_22 then
					arg_578_1.talkMaxDuration = var_581_22

					if var_581_22 + var_581_15 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_22 + var_581_15
					end
				end

				arg_578_1.text_.text = var_581_19
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511071", "story_v_out_121511.awb") ~= 0 then
					local var_581_23 = manager.audio:GetVoiceLength("story_v_out_121511", "121511071", "story_v_out_121511.awb") / 1000

					if var_581_23 + var_581_15 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_23 + var_581_15
					end

					if var_581_18.prefab_name ~= "" and arg_578_1.actors_[var_581_18.prefab_name] ~= nil then
						local var_581_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_18.prefab_name].transform, "story_v_out_121511", "121511071", "story_v_out_121511.awb")

						arg_578_1:RecordAudio("121511071", var_581_24)
						arg_578_1:RecordAudio("121511071", var_581_24)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_out_121511", "121511071", "story_v_out_121511.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_out_121511", "121511071", "story_v_out_121511.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_25 = math.max(var_581_16, arg_578_1.talkMaxDuration)

			if var_581_15 <= arg_578_1.time_ and arg_578_1.time_ < var_581_15 + var_581_25 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_15) / var_581_25

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_15 + var_581_25 and arg_578_1.time_ < var_581_15 + var_581_25 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_578_1:InitPlayNodeList()
	end,
	Play121511072 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 121511072
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play121511073(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = arg_582_1.actors_["1184ui_story"]
			local var_585_1 = 0

			if var_585_1 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 and not isNil(var_585_0) and arg_582_1.var_.characterEffect1184ui_story == nil then
				arg_582_1.var_.characterEffect1184ui_story = var_585_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_2 = 0.200000002980232

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_2 and not isNil(var_585_0) then
				local var_585_3 = (arg_582_1.time_ - var_585_1) / var_585_2

				if arg_582_1.var_.characterEffect1184ui_story and not isNil(var_585_0) then
					local var_585_4 = Mathf.Lerp(0, 0.5, var_585_3)

					arg_582_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_582_1.var_.characterEffect1184ui_story.fillRatio = var_585_4
				end
			end

			if arg_582_1.time_ >= var_585_1 + var_585_2 and arg_582_1.time_ < var_585_1 + var_585_2 + arg_585_0 and not isNil(var_585_0) and arg_582_1.var_.characterEffect1184ui_story then
				local var_585_5 = 0.5

				arg_582_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_582_1.var_.characterEffect1184ui_story.fillRatio = var_585_5
			end

			local var_585_6 = 0
			local var_585_7 = 0.5

			if var_585_6 < arg_582_1.time_ and arg_582_1.time_ <= var_585_6 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				local var_585_8 = arg_582_1:FormatText(StoryNameCfg[7].name)

				arg_582_1.leftNameTxt_.text = var_585_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, true)
				arg_582_1.iconController_:SetSelectedState("hero")

				arg_582_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_582_1.callingController_:SetSelectedState("normal")

				arg_582_1.keyicon_.color = Color.New(1, 1, 1)
				arg_582_1.icon_.color = Color.New(1, 1, 1)

				local var_585_9 = arg_582_1:GetWordFromCfg(121511072)
				local var_585_10 = arg_582_1:FormatText(var_585_9.content)

				arg_582_1.text_.text = var_585_10

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_11 = 20
				local var_585_12 = utf8.len(var_585_10)
				local var_585_13 = var_585_11 <= 0 and var_585_7 or var_585_7 * (var_585_12 / var_585_11)

				if var_585_13 > 0 and var_585_7 < var_585_13 then
					arg_582_1.talkMaxDuration = var_585_13

					if var_585_13 + var_585_6 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_13 + var_585_6
					end
				end

				arg_582_1.text_.text = var_585_10
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_14 = math.max(var_585_7, arg_582_1.talkMaxDuration)

			if var_585_6 <= arg_582_1.time_ and arg_582_1.time_ < var_585_6 + var_585_14 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_6) / var_585_14

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_6 + var_585_14 and arg_582_1.time_ < var_585_6 + var_585_14 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play121511073 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 121511073
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play121511074(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = arg_586_1.actors_["1184ui_story"].transform
			local var_589_1 = 0

			if var_589_1 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 then
				arg_586_1.var_.moveOldPos1184ui_story = var_589_0.localPosition
			end

			local var_589_2 = 0.001

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_2 then
				local var_589_3 = (arg_586_1.time_ - var_589_1) / var_589_2
				local var_589_4 = Vector3.New(0, 100, 0)

				var_589_0.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos1184ui_story, var_589_4, var_589_3)

				local var_589_5 = manager.ui.mainCamera.transform.position - var_589_0.position

				var_589_0.forward = Vector3.New(var_589_5.x, var_589_5.y, var_589_5.z)

				local var_589_6 = var_589_0.localEulerAngles

				var_589_6.z = 0
				var_589_6.x = 0
				var_589_0.localEulerAngles = var_589_6
			end

			if arg_586_1.time_ >= var_589_1 + var_589_2 and arg_586_1.time_ < var_589_1 + var_589_2 + arg_589_0 then
				var_589_0.localPosition = Vector3.New(0, 100, 0)

				local var_589_7 = manager.ui.mainCamera.transform.position - var_589_0.position

				var_589_0.forward = Vector3.New(var_589_7.x, var_589_7.y, var_589_7.z)

				local var_589_8 = var_589_0.localEulerAngles

				var_589_8.z = 0
				var_589_8.x = 0
				var_589_0.localEulerAngles = var_589_8
			end

			local var_589_9 = arg_586_1.actors_["1184ui_story"]
			local var_589_10 = 0

			if var_589_10 < arg_586_1.time_ and arg_586_1.time_ <= var_589_10 + arg_589_0 and not isNil(var_589_9) and arg_586_1.var_.characterEffect1184ui_story == nil then
				arg_586_1.var_.characterEffect1184ui_story = var_589_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_11 = 0.200000002980232

			if var_589_10 <= arg_586_1.time_ and arg_586_1.time_ < var_589_10 + var_589_11 and not isNil(var_589_9) then
				local var_589_12 = (arg_586_1.time_ - var_589_10) / var_589_11

				if arg_586_1.var_.characterEffect1184ui_story and not isNil(var_589_9) then
					local var_589_13 = Mathf.Lerp(0, 0.5, var_589_12)

					arg_586_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_586_1.var_.characterEffect1184ui_story.fillRatio = var_589_13
				end
			end

			if arg_586_1.time_ >= var_589_10 + var_589_11 and arg_586_1.time_ < var_589_10 + var_589_11 + arg_589_0 and not isNil(var_589_9) and arg_586_1.var_.characterEffect1184ui_story then
				local var_589_14 = 0.5

				arg_586_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_586_1.var_.characterEffect1184ui_story.fillRatio = var_589_14
			end

			local var_589_15 = 0
			local var_589_16 = 1.225

			if var_589_15 < arg_586_1.time_ and arg_586_1.time_ <= var_589_15 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, false)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_17 = arg_586_1:GetWordFromCfg(121511073)
				local var_589_18 = arg_586_1:FormatText(var_589_17.content)

				arg_586_1.text_.text = var_589_18

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_19 = 49
				local var_589_20 = utf8.len(var_589_18)
				local var_589_21 = var_589_19 <= 0 and var_589_16 or var_589_16 * (var_589_20 / var_589_19)

				if var_589_21 > 0 and var_589_16 < var_589_21 then
					arg_586_1.talkMaxDuration = var_589_21

					if var_589_21 + var_589_15 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_21 + var_589_15
					end
				end

				arg_586_1.text_.text = var_589_18
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_22 = math.max(var_589_16, arg_586_1.talkMaxDuration)

			if var_589_15 <= arg_586_1.time_ and arg_586_1.time_ < var_589_15 + var_589_22 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_15) / var_589_22

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_15 + var_589_22 and arg_586_1.time_ < var_589_15 + var_589_22 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_586_1:InitPlayNodeList()
	end,
	Play121511074 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 121511074
		arg_590_1.duration_ = 4.7

		local var_590_0 = {
			ja = 4.433,
			ko = 4.7,
			zh = 4.7
		}
		local var_590_1 = manager.audio:GetLocalizationFlag()

		if var_590_0[var_590_1] ~= nil then
			arg_590_1.duration_ = var_590_0[var_590_1]
		end

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play121511075(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = arg_590_1.actors_["10042ui_story"].transform
			local var_593_1 = 0

			if var_593_1 < arg_590_1.time_ and arg_590_1.time_ <= var_593_1 + arg_593_0 then
				arg_590_1.var_.moveOldPos10042ui_story = var_593_0.localPosition
			end

			local var_593_2 = 0.001

			if var_593_1 <= arg_590_1.time_ and arg_590_1.time_ < var_593_1 + var_593_2 then
				local var_593_3 = (arg_590_1.time_ - var_593_1) / var_593_2
				local var_593_4 = Vector3.New(0, -1.12, -6.2)

				var_593_0.localPosition = Vector3.Lerp(arg_590_1.var_.moveOldPos10042ui_story, var_593_4, var_593_3)

				local var_593_5 = manager.ui.mainCamera.transform.position - var_593_0.position

				var_593_0.forward = Vector3.New(var_593_5.x, var_593_5.y, var_593_5.z)

				local var_593_6 = var_593_0.localEulerAngles

				var_593_6.z = 0
				var_593_6.x = 0
				var_593_0.localEulerAngles = var_593_6
			end

			if arg_590_1.time_ >= var_593_1 + var_593_2 and arg_590_1.time_ < var_593_1 + var_593_2 + arg_593_0 then
				var_593_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_593_7 = manager.ui.mainCamera.transform.position - var_593_0.position

				var_593_0.forward = Vector3.New(var_593_7.x, var_593_7.y, var_593_7.z)

				local var_593_8 = var_593_0.localEulerAngles

				var_593_8.z = 0
				var_593_8.x = 0
				var_593_0.localEulerAngles = var_593_8
			end

			local var_593_9 = arg_590_1.actors_["10042ui_story"]
			local var_593_10 = 0

			if var_593_10 < arg_590_1.time_ and arg_590_1.time_ <= var_593_10 + arg_593_0 and not isNil(var_593_9) and arg_590_1.var_.characterEffect10042ui_story == nil then
				arg_590_1.var_.characterEffect10042ui_story = var_593_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_11 = 0.200000002980232

			if var_593_10 <= arg_590_1.time_ and arg_590_1.time_ < var_593_10 + var_593_11 and not isNil(var_593_9) then
				local var_593_12 = (arg_590_1.time_ - var_593_10) / var_593_11

				if arg_590_1.var_.characterEffect10042ui_story and not isNil(var_593_9) then
					arg_590_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_590_1.time_ >= var_593_10 + var_593_11 and arg_590_1.time_ < var_593_10 + var_593_11 + arg_593_0 and not isNil(var_593_9) and arg_590_1.var_.characterEffect10042ui_story then
				arg_590_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_593_13 = 0

			if var_593_13 < arg_590_1.time_ and arg_590_1.time_ <= var_593_13 + arg_593_0 then
				arg_590_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action1_1")
			end

			local var_593_14 = 0

			if var_593_14 < arg_590_1.time_ and arg_590_1.time_ <= var_593_14 + arg_593_0 then
				arg_590_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_593_15 = 0
			local var_593_16 = 0.4

			if var_593_15 < arg_590_1.time_ and arg_590_1.time_ <= var_593_15 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				local var_593_17 = arg_590_1:FormatText(StoryNameCfg[388].name)

				arg_590_1.leftNameTxt_.text = var_593_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_18 = arg_590_1:GetWordFromCfg(121511074)
				local var_593_19 = arg_590_1:FormatText(var_593_18.content)

				arg_590_1.text_.text = var_593_19

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_20 = 16
				local var_593_21 = utf8.len(var_593_19)
				local var_593_22 = var_593_20 <= 0 and var_593_16 or var_593_16 * (var_593_21 / var_593_20)

				if var_593_22 > 0 and var_593_16 < var_593_22 then
					arg_590_1.talkMaxDuration = var_593_22

					if var_593_22 + var_593_15 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_22 + var_593_15
					end
				end

				arg_590_1.text_.text = var_593_19
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511074", "story_v_out_121511.awb") ~= 0 then
					local var_593_23 = manager.audio:GetVoiceLength("story_v_out_121511", "121511074", "story_v_out_121511.awb") / 1000

					if var_593_23 + var_593_15 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_23 + var_593_15
					end

					if var_593_18.prefab_name ~= "" and arg_590_1.actors_[var_593_18.prefab_name] ~= nil then
						local var_593_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_590_1.actors_[var_593_18.prefab_name].transform, "story_v_out_121511", "121511074", "story_v_out_121511.awb")

						arg_590_1:RecordAudio("121511074", var_593_24)
						arg_590_1:RecordAudio("121511074", var_593_24)
					else
						arg_590_1:AudioAction("play", "voice", "story_v_out_121511", "121511074", "story_v_out_121511.awb")
					end

					arg_590_1:RecordHistoryTalkVoice("story_v_out_121511", "121511074", "story_v_out_121511.awb")
				end

				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_25 = math.max(var_593_16, arg_590_1.talkMaxDuration)

			if var_593_15 <= arg_590_1.time_ and arg_590_1.time_ < var_593_15 + var_593_25 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_15) / var_593_25

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_15 + var_593_25 and arg_590_1.time_ < var_593_15 + var_593_25 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_590_1:InitPlayNodeList()
	end,
	Play121511075 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 121511075
		arg_594_1.duration_ = 6.07

		local var_594_0 = {
			ja = 6.066,
			ko = 3.866,
			zh = 3.866
		}
		local var_594_1 = manager.audio:GetLocalizationFlag()

		if var_594_0[var_594_1] ~= nil then
			arg_594_1.duration_ = var_594_0[var_594_1]
		end

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play121511076(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = arg_594_1.actors_["10042ui_story"].transform
			local var_597_1 = 0

			if var_597_1 < arg_594_1.time_ and arg_594_1.time_ <= var_597_1 + arg_597_0 then
				arg_594_1.var_.moveOldPos10042ui_story = var_597_0.localPosition
			end

			local var_597_2 = 0.001

			if var_597_1 <= arg_594_1.time_ and arg_594_1.time_ < var_597_1 + var_597_2 then
				local var_597_3 = (arg_594_1.time_ - var_597_1) / var_597_2
				local var_597_4 = Vector3.New(0, -1.12, -6.2)

				var_597_0.localPosition = Vector3.Lerp(arg_594_1.var_.moveOldPos10042ui_story, var_597_4, var_597_3)

				local var_597_5 = manager.ui.mainCamera.transform.position - var_597_0.position

				var_597_0.forward = Vector3.New(var_597_5.x, var_597_5.y, var_597_5.z)

				local var_597_6 = var_597_0.localEulerAngles

				var_597_6.z = 0
				var_597_6.x = 0
				var_597_0.localEulerAngles = var_597_6
			end

			if arg_594_1.time_ >= var_597_1 + var_597_2 and arg_594_1.time_ < var_597_1 + var_597_2 + arg_597_0 then
				var_597_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_597_7 = manager.ui.mainCamera.transform.position - var_597_0.position

				var_597_0.forward = Vector3.New(var_597_7.x, var_597_7.y, var_597_7.z)

				local var_597_8 = var_597_0.localEulerAngles

				var_597_8.z = 0
				var_597_8.x = 0
				var_597_0.localEulerAngles = var_597_8
			end

			local var_597_9 = arg_594_1.actors_["10042ui_story"]
			local var_597_10 = 0

			if var_597_10 < arg_594_1.time_ and arg_594_1.time_ <= var_597_10 + arg_597_0 and not isNil(var_597_9) and arg_594_1.var_.characterEffect10042ui_story == nil then
				arg_594_1.var_.characterEffect10042ui_story = var_597_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_597_11 = 0.200000002980232

			if var_597_10 <= arg_594_1.time_ and arg_594_1.time_ < var_597_10 + var_597_11 and not isNil(var_597_9) then
				local var_597_12 = (arg_594_1.time_ - var_597_10) / var_597_11

				if arg_594_1.var_.characterEffect10042ui_story and not isNil(var_597_9) then
					arg_594_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_594_1.time_ >= var_597_10 + var_597_11 and arg_594_1.time_ < var_597_10 + var_597_11 + arg_597_0 and not isNil(var_597_9) and arg_594_1.var_.characterEffect10042ui_story then
				arg_594_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_597_13 = 0

			if var_597_13 < arg_594_1.time_ and arg_594_1.time_ <= var_597_13 + arg_597_0 then
				arg_594_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action2_1")
			end

			local var_597_14 = 0

			if var_597_14 < arg_594_1.time_ and arg_594_1.time_ <= var_597_14 + arg_597_0 then
				arg_594_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_597_15 = 0
			local var_597_16 = 0.3

			if var_597_15 < arg_594_1.time_ and arg_594_1.time_ <= var_597_15 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				local var_597_17 = arg_594_1:FormatText(StoryNameCfg[388].name)

				arg_594_1.leftNameTxt_.text = var_597_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_18 = arg_594_1:GetWordFromCfg(121511075)
				local var_597_19 = arg_594_1:FormatText(var_597_18.content)

				arg_594_1.text_.text = var_597_19

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_20 = 12
				local var_597_21 = utf8.len(var_597_19)
				local var_597_22 = var_597_20 <= 0 and var_597_16 or var_597_16 * (var_597_21 / var_597_20)

				if var_597_22 > 0 and var_597_16 < var_597_22 then
					arg_594_1.talkMaxDuration = var_597_22

					if var_597_22 + var_597_15 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_22 + var_597_15
					end
				end

				arg_594_1.text_.text = var_597_19
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121511", "121511075", "story_v_out_121511.awb") ~= 0 then
					local var_597_23 = manager.audio:GetVoiceLength("story_v_out_121511", "121511075", "story_v_out_121511.awb") / 1000

					if var_597_23 + var_597_15 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_23 + var_597_15
					end

					if var_597_18.prefab_name ~= "" and arg_594_1.actors_[var_597_18.prefab_name] ~= nil then
						local var_597_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_18.prefab_name].transform, "story_v_out_121511", "121511075", "story_v_out_121511.awb")

						arg_594_1:RecordAudio("121511075", var_597_24)
						arg_594_1:RecordAudio("121511075", var_597_24)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_out_121511", "121511075", "story_v_out_121511.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_out_121511", "121511075", "story_v_out_121511.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_25 = math.max(var_597_16, arg_594_1.talkMaxDuration)

			if var_597_15 <= arg_594_1.time_ and arg_594_1.time_ < var_597_15 + var_597_25 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_15) / var_597_25

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_15 + var_597_25 and arg_594_1.time_ < var_597_15 + var_597_25 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_594_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J12f",
		"TextureConfig/Background/XH0305",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_121511.awb"
	}
}
