return {
	Play301041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 301041001
		arg_1_1.duration_ = 4.87

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play301041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0118"

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
				local var_4_5 = arg_1_1.bgs_.ST0118

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
					if iter_4_0 ~= "ST0118" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

			local var_4_24 = "1084ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1084ui_story"].transform
			local var_4_30 = 1.86666666666667

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -0.97, -6)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.97, -6)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1084ui_story"]
			local var_4_39 = 1.86666666666667

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_42 = 1.86666666666667

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_4_43 = 1.86666666666667

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0.2
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "effect"

				arg_1_1:AudioAction(var_4_46, var_4_47, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_4_48 = 1
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_activity_5_2_story_remake_daily", "bgm_activity_5_2_story_remake_daily", "bgm_activity_5_2_story_remake_daily.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_activity_5_2_story_remake_daily", "bgm_activity_5_2_story_remake_daily")

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
			local var_4_59 = 0.225

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

				local var_4_61 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_62 = arg_1_1:GetWordFromCfg(301041001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041001", "story_v_out_301041.awb") ~= 0 then
					local var_4_67 = manager.audio:GetVoiceLength("story_v_out_301041", "301041001", "story_v_out_301041.awb") / 1000

					if var_4_67 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_58
					end

					if var_4_62.prefab_name ~= "" and arg_1_1.actors_[var_4_62.prefab_name] ~= nil then
						local var_4_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_62.prefab_name].transform, "story_v_out_301041", "301041001", "story_v_out_301041.awb")

						arg_1_1:RecordAudio("301041001", var_4_68)
						arg_1_1:RecordAudio("301041001", var_4_68)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_301041", "301041001", "story_v_out_301041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_301041", "301041001", "story_v_out_301041.awb")
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
				actorName = "1084ui_story",
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
	Play301041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 301041002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play301041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1084ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.200000002980232

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1084ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_5
			end

			local var_11_6 = 0
			local var_11_7 = 0.35

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_8 = arg_8_1:FormatText(StoryNameCfg[7].name)

				arg_8_1.leftNameTxt_.text = var_11_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_9 = arg_8_1:GetWordFromCfg(301041002)
				local var_11_10 = arg_8_1:FormatText(var_11_9.content)

				arg_8_1.text_.text = var_11_10

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_11 = 14
				local var_11_12 = utf8.len(var_11_10)
				local var_11_13 = var_11_11 <= 0 and var_11_7 or var_11_7 * (var_11_12 / var_11_11)

				if var_11_13 > 0 and var_11_7 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_6
					end
				end

				arg_8_1.text_.text = var_11_10
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_14 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_14 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_14

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_14 and arg_8_1.time_ < var_11_6 + var_11_14 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play301041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 301041003
		arg_12_1.duration_ = 9.5

		local var_12_0 = {
			zh = 6.1,
			ja = 9.5
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
				arg_12_0:Play301041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1084ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_15_4 = 0

			if var_15_4 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_15_6 = 0
			local var_15_7 = 0.7

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[6].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_9 = arg_12_1:GetWordFromCfg(301041003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 28
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041003", "story_v_out_301041.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_301041", "301041003", "story_v_out_301041.awb") / 1000

					if var_15_14 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_6
					end

					if var_15_9.prefab_name ~= "" and arg_12_1.actors_[var_15_9.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_9.prefab_name].transform, "story_v_out_301041", "301041003", "story_v_out_301041.awb")

						arg_12_1:RecordAudio("301041003", var_15_15)
						arg_12_1:RecordAudio("301041003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_301041", "301041003", "story_v_out_301041.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_301041", "301041003", "story_v_out_301041.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_16 and arg_12_1.time_ < var_15_6 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play301041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 301041004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play301041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1084ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_0.localPosition
			end

			local var_19_2 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2
				local var_19_4 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, var_19_4, var_19_3)

				local var_19_5 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_5.x, var_19_5.y, var_19_5.z)

				local var_19_6 = var_19_0.localEulerAngles

				var_19_6.z = 0
				var_19_6.x = 0
				var_19_0.localEulerAngles = var_19_6
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, 100, 0)

				local var_19_7 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_7.x, var_19_7.y, var_19_7.z)

				local var_19_8 = var_19_0.localEulerAngles

				var_19_8.z = 0
				var_19_8.x = 0
				var_19_0.localEulerAngles = var_19_8
			end

			local var_19_9 = arg_16_1.actors_["1084ui_story"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.200000002980232

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_9) then
					local var_19_13 = Mathf.Lerp(0, 0.5, var_19_12)

					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_13
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1084ui_story then
				local var_19_14 = 0.5

				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_14
			end

			local var_19_15 = 0
			local var_19_16 = 1.45

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_17 = arg_16_1:GetWordFromCfg(301041004)
				local var_19_18 = arg_16_1:FormatText(var_19_17.content)

				arg_16_1.text_.text = var_19_18

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_19 = 58
				local var_19_20 = utf8.len(var_19_18)
				local var_19_21 = var_19_19 <= 0 and var_19_16 or var_19_16 * (var_19_20 / var_19_19)

				if var_19_21 > 0 and var_19_16 < var_19_21 then
					arg_16_1.talkMaxDuration = var_19_21

					if var_19_21 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_21 + var_19_15
					end
				end

				arg_16_1.text_.text = var_19_18
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_16, arg_16_1.talkMaxDuration)

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_15) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_15 + var_19_22 and arg_16_1.time_ < var_19_15 + var_19_22 + arg_19_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play301041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 301041005
		arg_20_1.duration_ = 7.27

		local var_20_0 = {
			zh = 7.133,
			ja = 7.266
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play301041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.7

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[1548].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(301041005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 28
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041005", "story_v_out_301041.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_301041", "301041005", "story_v_out_301041.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_301041", "301041005", "story_v_out_301041.awb")

						arg_20_1:RecordAudio("301041005", var_23_9)
						arg_20_1:RecordAudio("301041005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_301041", "301041005", "story_v_out_301041.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_301041", "301041005", "story_v_out_301041.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play301041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 301041006
		arg_24_1.duration_ = 8.27

		local var_24_0 = {
			zh = 8.1,
			ja = 8.266
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
				arg_24_0:Play301041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 1.025

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[1548].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(301041006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041006", "story_v_out_301041.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_301041", "301041006", "story_v_out_301041.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_301041", "301041006", "story_v_out_301041.awb")

						arg_24_1:RecordAudio("301041006", var_27_9)
						arg_24_1:RecordAudio("301041006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_301041", "301041006", "story_v_out_301041.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_301041", "301041006", "story_v_out_301041.awb")
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
	Play301041007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 301041007
		arg_28_1.duration_ = 9.97

		local var_28_0 = {
			zh = 5.5,
			ja = 9.966
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
				arg_28_0:Play301041008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1084ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = var_31_0.localPosition
			end

			local var_31_2 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2
				local var_31_4 = Vector3.New(0, -0.97, -6)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, var_31_4, var_31_3)

				local var_31_5 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_5.x, var_31_5.y, var_31_5.z)

				local var_31_6 = var_31_0.localEulerAngles

				var_31_6.z = 0
				var_31_6.x = 0
				var_31_0.localEulerAngles = var_31_6
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_31_7 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_7.x, var_31_7.y, var_31_7.z)

				local var_31_8 = var_31_0.localEulerAngles

				var_31_8.z = 0
				var_31_8.x = 0
				var_31_0.localEulerAngles = var_31_8
			end

			local var_31_9 = arg_28_1.actors_["1084ui_story"]
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = var_31_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.200000002980232

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 and not isNil(var_31_9) then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11

				if arg_28_1.var_.characterEffect1084ui_story and not isNil(var_31_9) then
					arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1084ui_story then
				arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_31_13 = 0

			if var_31_13 < arg_28_1.time_ and arg_28_1.time_ <= var_31_13 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_31_14 = 0

			if var_31_14 < arg_28_1.time_ and arg_28_1.time_ <= var_31_14 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_31_15 = 0
			local var_31_16 = 0.65

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_17 = arg_28_1:FormatText(StoryNameCfg[6].name)

				arg_28_1.leftNameTxt_.text = var_31_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_18 = arg_28_1:GetWordFromCfg(301041007)
				local var_31_19 = arg_28_1:FormatText(var_31_18.content)

				arg_28_1.text_.text = var_31_19

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_20 = 26
				local var_31_21 = utf8.len(var_31_19)
				local var_31_22 = var_31_20 <= 0 and var_31_16 or var_31_16 * (var_31_21 / var_31_20)

				if var_31_22 > 0 and var_31_16 < var_31_22 then
					arg_28_1.talkMaxDuration = var_31_22

					if var_31_22 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_22 + var_31_15
					end
				end

				arg_28_1.text_.text = var_31_19
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041007", "story_v_out_301041.awb") ~= 0 then
					local var_31_23 = manager.audio:GetVoiceLength("story_v_out_301041", "301041007", "story_v_out_301041.awb") / 1000

					if var_31_23 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_23 + var_31_15
					end

					if var_31_18.prefab_name ~= "" and arg_28_1.actors_[var_31_18.prefab_name] ~= nil then
						local var_31_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_18.prefab_name].transform, "story_v_out_301041", "301041007", "story_v_out_301041.awb")

						arg_28_1:RecordAudio("301041007", var_31_24)
						arg_28_1:RecordAudio("301041007", var_31_24)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_301041", "301041007", "story_v_out_301041.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_301041", "301041007", "story_v_out_301041.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_25 = math.max(var_31_16, arg_28_1.talkMaxDuration)

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_25 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_15) / var_31_25

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_15 + var_31_25 and arg_28_1.time_ < var_31_15 + var_31_25 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play301041008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 301041008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play301041009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1084ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0, 100, 0)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, var_35_4, var_35_3)

				local var_35_5 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_5.x, var_35_5.y, var_35_5.z)

				local var_35_6 = var_35_0.localEulerAngles

				var_35_6.z = 0
				var_35_6.x = 0
				var_35_0.localEulerAngles = var_35_6
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, 100, 0)

				local var_35_7 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_7.x, var_35_7.y, var_35_7.z)

				local var_35_8 = var_35_0.localEulerAngles

				var_35_8.z = 0
				var_35_8.x = 0
				var_35_0.localEulerAngles = var_35_8
			end

			local var_35_9 = 0
			local var_35_10 = 0.625

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_11 = arg_32_1:GetWordFromCfg(301041008)
				local var_35_12 = arg_32_1:FormatText(var_35_11.content)

				arg_32_1.text_.text = var_35_12

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 25
				local var_35_14 = utf8.len(var_35_12)
				local var_35_15 = var_35_13 <= 0 and var_35_10 or var_35_10 * (var_35_14 / var_35_13)

				if var_35_15 > 0 and var_35_10 < var_35_15 then
					arg_32_1.talkMaxDuration = var_35_15

					if var_35_15 + var_35_9 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_15 + var_35_9
					end
				end

				arg_32_1.text_.text = var_35_12
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_10, arg_32_1.talkMaxDuration)

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_9) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_9 + var_35_16 and arg_32_1.time_ < var_35_9 + var_35_16 + arg_35_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play301041009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 301041009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play301041010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.15

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[7].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(301041009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 6
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_8 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_8 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_8

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_8 and arg_36_1.time_ < var_39_0 + var_39_8 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play301041010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 301041010
		arg_40_1.duration_ = 4.57

		local var_40_0 = {
			zh = 3.8,
			ja = 4.566
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
				arg_40_0:Play301041011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1084ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos1084ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(0, -0.97, -6)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1084ui_story, var_43_4, var_43_3)

				local var_43_5 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_5.x, var_43_5.y, var_43_5.z)

				local var_43_6 = var_43_0.localEulerAngles

				var_43_6.z = 0
				var_43_6.x = 0
				var_43_0.localEulerAngles = var_43_6
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_43_7 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_7.x, var_43_7.y, var_43_7.z)

				local var_43_8 = var_43_0.localEulerAngles

				var_43_8.z = 0
				var_43_8.x = 0
				var_43_0.localEulerAngles = var_43_8
			end

			local var_43_9 = arg_40_1.actors_["1084ui_story"]
			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_11 = 0.200000002980232

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_11 and not isNil(var_43_9) then
				local var_43_12 = (arg_40_1.time_ - var_43_10) / var_43_11

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_9) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_10 + var_43_11 and arg_40_1.time_ < var_43_10 + var_43_11 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_43_13 = 0

			if var_43_13 < arg_40_1.time_ and arg_40_1.time_ <= var_43_13 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_43_14 = 0

			if var_43_14 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_15 = 0
			local var_43_16 = 0.3

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

				local var_43_18 = arg_40_1:GetWordFromCfg(301041010)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041010", "story_v_out_301041.awb") ~= 0 then
					local var_43_23 = manager.audio:GetVoiceLength("story_v_out_301041", "301041010", "story_v_out_301041.awb") / 1000

					if var_43_23 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_23 + var_43_15
					end

					if var_43_18.prefab_name ~= "" and arg_40_1.actors_[var_43_18.prefab_name] ~= nil then
						local var_43_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_18.prefab_name].transform, "story_v_out_301041", "301041010", "story_v_out_301041.awb")

						arg_40_1:RecordAudio("301041010", var_43_24)
						arg_40_1:RecordAudio("301041010", var_43_24)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_301041", "301041010", "story_v_out_301041.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_301041", "301041010", "story_v_out_301041.awb")
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play301041011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 301041011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play301041012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1084ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

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
			local var_47_7 = 0.375

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

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_9 = arg_44_1:GetWordFromCfg(301041011)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 15
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
	Play301041012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 301041012
		arg_48_1.duration_ = 5.93

		local var_48_0 = {
			zh = 5.766,
			ja = 5.933
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
				arg_48_0:Play301041013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1084ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_51_4 = 0

			if var_51_4 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_51_6 = 0
			local var_51_7 = 0.525

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_8 = arg_48_1:FormatText(StoryNameCfg[6].name)

				arg_48_1.leftNameTxt_.text = var_51_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_9 = arg_48_1:GetWordFromCfg(301041012)
				local var_51_10 = arg_48_1:FormatText(var_51_9.content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 21
				local var_51_12 = utf8.len(var_51_10)
				local var_51_13 = var_51_11 <= 0 and var_51_7 or var_51_7 * (var_51_12 / var_51_11)

				if var_51_13 > 0 and var_51_7 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_10
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041012", "story_v_out_301041.awb") ~= 0 then
					local var_51_14 = manager.audio:GetVoiceLength("story_v_out_301041", "301041012", "story_v_out_301041.awb") / 1000

					if var_51_14 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_14 + var_51_6
					end

					if var_51_9.prefab_name ~= "" and arg_48_1.actors_[var_51_9.prefab_name] ~= nil then
						local var_51_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_9.prefab_name].transform, "story_v_out_301041", "301041012", "story_v_out_301041.awb")

						arg_48_1:RecordAudio("301041012", var_51_15)
						arg_48_1:RecordAudio("301041012", var_51_15)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_301041", "301041012", "story_v_out_301041.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_301041", "301041012", "story_v_out_301041.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_16 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_16 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_16

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_16 and arg_48_1.time_ < var_51_6 + var_51_16 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play301041013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 301041013
		arg_52_1.duration_ = 9

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play301041014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "I05"

			if arg_52_1.bgs_[var_55_0] == nil then
				local var_55_1 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_0)
				var_55_1.name = var_55_0
				var_55_1.transform.parent = arg_52_1.stage_.transform
				var_55_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_0] = var_55_1
			end

			local var_55_2 = 1.98333333333333

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				local var_55_3 = manager.ui.mainCamera.transform.localPosition
				local var_55_4 = Vector3.New(0, 0, 10) + Vector3.New(var_55_3.x, var_55_3.y, 0)
				local var_55_5 = arg_52_1.bgs_.I05

				var_55_5.transform.localPosition = var_55_4
				var_55_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_6 = var_55_5:GetComponent("SpriteRenderer")

				if var_55_6 and var_55_6.sprite then
					local var_55_7 = (var_55_5.transform.localPosition - var_55_3).z
					local var_55_8 = manager.ui.mainCameraCom_
					local var_55_9 = 2 * var_55_7 * Mathf.Tan(var_55_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_55_10 = var_55_9 * var_55_8.aspect
					local var_55_11 = var_55_6.sprite.bounds.size.x
					local var_55_12 = var_55_6.sprite.bounds.size.y
					local var_55_13 = var_55_10 / var_55_11
					local var_55_14 = var_55_9 / var_55_12
					local var_55_15 = var_55_14 < var_55_13 and var_55_13 or var_55_14

					var_55_5.transform.localScale = Vector3.New(var_55_15, var_55_15, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "I05" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_16 = 3.999999999999

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			local var_55_17 = 0.3

			if arg_52_1.time_ >= var_55_16 + var_55_17 and arg_52_1.time_ < var_55_16 + var_55_17 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			local var_55_18 = 0

			if var_55_18 < arg_52_1.time_ and arg_52_1.time_ <= var_55_18 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_19 = 2

			if var_55_18 <= arg_52_1.time_ and arg_52_1.time_ < var_55_18 + var_55_19 then
				local var_55_20 = (arg_52_1.time_ - var_55_18) / var_55_19
				local var_55_21 = Color.New(0, 0, 0)

				var_55_21.a = Mathf.Lerp(0, 1, var_55_20)
				arg_52_1.mask_.color = var_55_21
			end

			if arg_52_1.time_ >= var_55_18 + var_55_19 and arg_52_1.time_ < var_55_18 + var_55_19 + arg_55_0 then
				local var_55_22 = Color.New(0, 0, 0)

				var_55_22.a = 1
				arg_52_1.mask_.color = var_55_22
			end

			local var_55_23 = 2

			if var_55_23 < arg_52_1.time_ and arg_52_1.time_ <= var_55_23 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_24 = 2

			if var_55_23 <= arg_52_1.time_ and arg_52_1.time_ < var_55_23 + var_55_24 then
				local var_55_25 = (arg_52_1.time_ - var_55_23) / var_55_24
				local var_55_26 = Color.New(0, 0, 0)

				var_55_26.a = Mathf.Lerp(1, 0, var_55_25)
				arg_52_1.mask_.color = var_55_26
			end

			if arg_52_1.time_ >= var_55_23 + var_55_24 and arg_52_1.time_ < var_55_23 + var_55_24 + arg_55_0 then
				local var_55_27 = Color.New(0, 0, 0)
				local var_55_28 = 0

				arg_52_1.mask_.enabled = false
				var_55_27.a = var_55_28
				arg_52_1.mask_.color = var_55_27
			end

			local var_55_29 = arg_52_1.actors_["1084ui_story"]
			local var_55_30 = 1.98333333333333

			if var_55_30 < arg_52_1.time_ and arg_52_1.time_ <= var_55_30 + arg_55_0 and not isNil(var_55_29) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_31 = 0.0166666666666666

			if var_55_30 <= arg_52_1.time_ and arg_52_1.time_ < var_55_30 + var_55_31 and not isNil(var_55_29) then
				local var_55_32 = (arg_52_1.time_ - var_55_30) / var_55_31

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_29) then
					local var_55_33 = Mathf.Lerp(0, 0.5, var_55_32)

					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_33
				end
			end

			if arg_52_1.time_ >= var_55_30 + var_55_31 and arg_52_1.time_ < var_55_30 + var_55_31 + arg_55_0 and not isNil(var_55_29) and arg_52_1.var_.characterEffect1084ui_story then
				local var_55_34 = 0.5

				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_34
			end

			local var_55_35 = arg_52_1.actors_["1084ui_story"].transform
			local var_55_36 = 1.96599999815226

			if var_55_36 < arg_52_1.time_ and arg_52_1.time_ <= var_55_36 + arg_55_0 then
				arg_52_1.var_.moveOldPos1084ui_story = var_55_35.localPosition
			end

			local var_55_37 = 0.001

			if var_55_36 <= arg_52_1.time_ and arg_52_1.time_ < var_55_36 + var_55_37 then
				local var_55_38 = (arg_52_1.time_ - var_55_36) / var_55_37
				local var_55_39 = Vector3.New(0, 100, 0)

				var_55_35.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1084ui_story, var_55_39, var_55_38)

				local var_55_40 = manager.ui.mainCamera.transform.position - var_55_35.position

				var_55_35.forward = Vector3.New(var_55_40.x, var_55_40.y, var_55_40.z)

				local var_55_41 = var_55_35.localEulerAngles

				var_55_41.z = 0
				var_55_41.x = 0
				var_55_35.localEulerAngles = var_55_41
			end

			if arg_52_1.time_ >= var_55_36 + var_55_37 and arg_52_1.time_ < var_55_36 + var_55_37 + arg_55_0 then
				var_55_35.localPosition = Vector3.New(0, 100, 0)

				local var_55_42 = manager.ui.mainCamera.transform.position - var_55_35.position

				var_55_35.forward = Vector3.New(var_55_42.x, var_55_42.y, var_55_42.z)

				local var_55_43 = var_55_35.localEulerAngles

				var_55_43.z = 0
				var_55_43.x = 0
				var_55_35.localEulerAngles = var_55_43
			end

			local var_55_44 = 1.2
			local var_55_45 = 1

			if var_55_44 < arg_52_1.time_ and arg_52_1.time_ <= var_55_44 + arg_55_0 then
				local var_55_46 = "play"
				local var_55_47 = "effect"

				arg_52_1:AudioAction(var_55_46, var_55_47, "se_story_16", "se_story_16_street_loop", "")
			end

			local var_55_48 = 0.2
			local var_55_49 = 1

			if var_55_48 < arg_52_1.time_ and arg_52_1.time_ <= var_55_48 + arg_55_0 then
				local var_55_50 = "stop"
				local var_55_51 = "effect"

				arg_52_1:AudioAction(var_55_50, var_55_51, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_52 = 4
			local var_55_53 = 0.925

			if var_55_52 < arg_52_1.time_ and arg_52_1.time_ <= var_55_52 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_54 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_54:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_55 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_56 = arg_52_1:GetWordFromCfg(301041013)
				local var_55_57 = arg_52_1:FormatText(var_55_56.content)

				arg_52_1.text_.text = var_55_57

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_58 = 37
				local var_55_59 = utf8.len(var_55_57)
				local var_55_60 = var_55_58 <= 0 and var_55_53 or var_55_53 * (var_55_59 / var_55_58)

				if var_55_60 > 0 and var_55_53 < var_55_60 then
					arg_52_1.talkMaxDuration = var_55_60
					var_55_52 = var_55_52 + 0.3

					if var_55_60 + var_55_52 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_60 + var_55_52
					end
				end

				arg_52_1.text_.text = var_55_57
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_61 = var_55_52 + 0.3
			local var_55_62 = math.max(var_55_53, arg_52_1.talkMaxDuration)

			if var_55_61 <= arg_52_1.time_ and arg_52_1.time_ < var_55_61 + var_55_62 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_61) / var_55_62

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_61 + var_55_62 and arg_52_1.time_ < var_55_61 + var_55_62 + arg_55_0 then
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
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play301041014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 301041014
		arg_58_1.duration_ = 9.67

		local var_58_0 = {
			zh = 9.3,
			ja = 9.666
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play301041015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1084ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1084ui_story == nil then
				arg_58_1.var_.characterEffect1084ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1084ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1084ui_story then
				arg_58_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_61_4 = 0

			if var_61_4 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_61_6 = arg_58_1.actors_["1084ui_story"].transform
			local var_61_7 = 0

			if var_61_7 < arg_58_1.time_ and arg_58_1.time_ <= var_61_7 + arg_61_0 then
				arg_58_1.var_.moveOldPos1084ui_story = var_61_6.localPosition
			end

			local var_61_8 = 0.001

			if var_61_7 <= arg_58_1.time_ and arg_58_1.time_ < var_61_7 + var_61_8 then
				local var_61_9 = (arg_58_1.time_ - var_61_7) / var_61_8
				local var_61_10 = Vector3.New(0, -0.97, -6)

				var_61_6.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1084ui_story, var_61_10, var_61_9)

				local var_61_11 = manager.ui.mainCamera.transform.position - var_61_6.position

				var_61_6.forward = Vector3.New(var_61_11.x, var_61_11.y, var_61_11.z)

				local var_61_12 = var_61_6.localEulerAngles

				var_61_12.z = 0
				var_61_12.x = 0
				var_61_6.localEulerAngles = var_61_12
			end

			if arg_58_1.time_ >= var_61_7 + var_61_8 and arg_58_1.time_ < var_61_7 + var_61_8 + arg_61_0 then
				var_61_6.localPosition = Vector3.New(0, -0.97, -6)

				local var_61_13 = manager.ui.mainCamera.transform.position - var_61_6.position

				var_61_6.forward = Vector3.New(var_61_13.x, var_61_13.y, var_61_13.z)

				local var_61_14 = var_61_6.localEulerAngles

				var_61_14.z = 0
				var_61_14.x = 0
				var_61_6.localEulerAngles = var_61_14
			end

			local var_61_15 = 0
			local var_61_16 = 0.9

			if var_61_15 < arg_58_1.time_ and arg_58_1.time_ <= var_61_15 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_17 = arg_58_1:FormatText(StoryNameCfg[6].name)

				arg_58_1.leftNameTxt_.text = var_61_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_18 = arg_58_1:GetWordFromCfg(301041014)
				local var_61_19 = arg_58_1:FormatText(var_61_18.content)

				arg_58_1.text_.text = var_61_19

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_20 = 37
				local var_61_21 = utf8.len(var_61_19)
				local var_61_22 = var_61_20 <= 0 and var_61_16 or var_61_16 * (var_61_21 / var_61_20)

				if var_61_22 > 0 and var_61_16 < var_61_22 then
					arg_58_1.talkMaxDuration = var_61_22

					if var_61_22 + var_61_15 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_22 + var_61_15
					end
				end

				arg_58_1.text_.text = var_61_19
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041014", "story_v_out_301041.awb") ~= 0 then
					local var_61_23 = manager.audio:GetVoiceLength("story_v_out_301041", "301041014", "story_v_out_301041.awb") / 1000

					if var_61_23 + var_61_15 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_23 + var_61_15
					end

					if var_61_18.prefab_name ~= "" and arg_58_1.actors_[var_61_18.prefab_name] ~= nil then
						local var_61_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_18.prefab_name].transform, "story_v_out_301041", "301041014", "story_v_out_301041.awb")

						arg_58_1:RecordAudio("301041014", var_61_24)
						arg_58_1:RecordAudio("301041014", var_61_24)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_301041", "301041014", "story_v_out_301041.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_301041", "301041014", "story_v_out_301041.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_25 = math.max(var_61_16, arg_58_1.talkMaxDuration)

			if var_61_15 <= arg_58_1.time_ and arg_58_1.time_ < var_61_15 + var_61_25 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_15) / var_61_25

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_15 + var_61_25 and arg_58_1.time_ < var_61_15 + var_61_25 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play301041015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 301041015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play301041016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1084ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1084ui_story == nil then
				arg_62_1.var_.characterEffect1084ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1084ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1084ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1084ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1084ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 0.3

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[7].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_9 = arg_62_1:GetWordFromCfg(301041015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 12
				local var_65_12 = utf8.len(var_65_10)
				local var_65_13 = var_65_11 <= 0 and var_65_7 or var_65_7 * (var_65_12 / var_65_11)

				if var_65_13 > 0 and var_65_7 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_14 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_14 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_14

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_14 and arg_62_1.time_ < var_65_6 + var_65_14 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play301041016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 301041016
		arg_66_1.duration_ = 5.43

		local var_66_0 = {
			zh = 4.766,
			ja = 5.433
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play301041017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1084ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1084ui_story == nil then
				arg_66_1.var_.characterEffect1084ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1084ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1084ui_story then
				arg_66_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_69_4 = 0

			if var_69_4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_69_6 = 0
			local var_69_7 = 0.6

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_8 = arg_66_1:FormatText(StoryNameCfg[6].name)

				arg_66_1.leftNameTxt_.text = var_69_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_9 = arg_66_1:GetWordFromCfg(301041016)
				local var_69_10 = arg_66_1:FormatText(var_69_9.content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 24
				local var_69_12 = utf8.len(var_69_10)
				local var_69_13 = var_69_11 <= 0 and var_69_7 or var_69_7 * (var_69_12 / var_69_11)

				if var_69_13 > 0 and var_69_7 < var_69_13 then
					arg_66_1.talkMaxDuration = var_69_13

					if var_69_13 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_10
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041016", "story_v_out_301041.awb") ~= 0 then
					local var_69_14 = manager.audio:GetVoiceLength("story_v_out_301041", "301041016", "story_v_out_301041.awb") / 1000

					if var_69_14 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_14 + var_69_6
					end

					if var_69_9.prefab_name ~= "" and arg_66_1.actors_[var_69_9.prefab_name] ~= nil then
						local var_69_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_9.prefab_name].transform, "story_v_out_301041", "301041016", "story_v_out_301041.awb")

						arg_66_1:RecordAudio("301041016", var_69_15)
						arg_66_1:RecordAudio("301041016", var_69_15)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_301041", "301041016", "story_v_out_301041.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_301041", "301041016", "story_v_out_301041.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_16 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_16 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_16

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_16 and arg_66_1.time_ < var_69_6 + var_69_16 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play301041017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 301041017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play301041018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1084ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1084ui_story == nil then
				arg_70_1.var_.characterEffect1084ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1084ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1084ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1084ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1084ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 0.1

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_8 = arg_70_1:FormatText(StoryNameCfg[7].name)

				arg_70_1.leftNameTxt_.text = var_73_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_9 = arg_70_1:GetWordFromCfg(301041017)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 4
				local var_73_12 = utf8.len(var_73_10)
				local var_73_13 = var_73_11 <= 0 and var_73_7 or var_73_7 * (var_73_12 / var_73_11)

				if var_73_13 > 0 and var_73_7 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_10
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play301041018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 301041018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play301041019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.9

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(301041018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 36
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
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_8 and arg_74_1.time_ < var_77_0 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play301041019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 301041019
		arg_78_1.duration_ = 9.3

		local var_78_0 = {
			zh = 6.5,
			ja = 9.3
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
				arg_78_0:Play301041020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1084ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1084ui_story == nil then
				arg_78_1.var_.characterEffect1084ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1084ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1084ui_story then
				arg_78_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_81_4 = 0

			if var_81_4 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_81_6 = 0
			local var_81_7 = 0.725

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_8 = arg_78_1:FormatText(StoryNameCfg[6].name)

				arg_78_1.leftNameTxt_.text = var_81_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_9 = arg_78_1:GetWordFromCfg(301041019)
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

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041019", "story_v_out_301041.awb") ~= 0 then
					local var_81_14 = manager.audio:GetVoiceLength("story_v_out_301041", "301041019", "story_v_out_301041.awb") / 1000

					if var_81_14 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_14 + var_81_6
					end

					if var_81_9.prefab_name ~= "" and arg_78_1.actors_[var_81_9.prefab_name] ~= nil then
						local var_81_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_9.prefab_name].transform, "story_v_out_301041", "301041019", "story_v_out_301041.awb")

						arg_78_1:RecordAudio("301041019", var_81_15)
						arg_78_1:RecordAudio("301041019", var_81_15)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_301041", "301041019", "story_v_out_301041.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_301041", "301041019", "story_v_out_301041.awb")
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
	Play301041020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 301041020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play301041021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1084ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1084ui_story == nil then
				arg_82_1.var_.characterEffect1084ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect1084ui_story and not isNil(var_85_0) then
					local var_85_4 = Mathf.Lerp(0, 0.5, var_85_3)

					arg_82_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1084ui_story.fillRatio = var_85_4
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1084ui_story then
				local var_85_5 = 0.5

				arg_82_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1084ui_story.fillRatio = var_85_5
			end

			local var_85_6 = 0
			local var_85_7 = 0.2

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_8 = arg_82_1:FormatText(StoryNameCfg[7].name)

				arg_82_1.leftNameTxt_.text = var_85_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_9 = arg_82_1:GetWordFromCfg(301041020)
				local var_85_10 = arg_82_1:FormatText(var_85_9.content)

				arg_82_1.text_.text = var_85_10

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 8
				local var_85_12 = utf8.len(var_85_10)
				local var_85_13 = var_85_11 <= 0 and var_85_7 or var_85_7 * (var_85_12 / var_85_11)

				if var_85_13 > 0 and var_85_7 < var_85_13 then
					arg_82_1.talkMaxDuration = var_85_13

					if var_85_13 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_10
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_14 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_14 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_14

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_14 and arg_82_1.time_ < var_85_6 + var_85_14 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play301041021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 301041021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play301041022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1084ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1084ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(0, 100, 0)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1084ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, 100, 0)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = 0
			local var_89_10 = 1.05

			if var_89_9 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_11 = arg_86_1:GetWordFromCfg(301041021)
				local var_89_12 = arg_86_1:FormatText(var_89_11.content)

				arg_86_1.text_.text = var_89_12

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_13 = 42
				local var_89_14 = utf8.len(var_89_12)
				local var_89_15 = var_89_13 <= 0 and var_89_10 or var_89_10 * (var_89_14 / var_89_13)

				if var_89_15 > 0 and var_89_10 < var_89_15 then
					arg_86_1.talkMaxDuration = var_89_15

					if var_89_15 + var_89_9 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_15 + var_89_9
					end
				end

				arg_86_1.text_.text = var_89_12
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_16 = math.max(var_89_10, arg_86_1.talkMaxDuration)

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_16 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_9) / var_89_16

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_9 + var_89_16 and arg_86_1.time_ < var_89_9 + var_89_16 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play301041022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 301041022
		arg_90_1.duration_ = 6.07

		local var_90_0 = {
			zh = 4.3,
			ja = 6.066
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play301041023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1084ui_story"].transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.moveOldPos1084ui_story = var_93_0.localPosition
			end

			local var_93_2 = 0.001

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2
				local var_93_4 = Vector3.New(0, -0.97, -6)

				var_93_0.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1084ui_story, var_93_4, var_93_3)

				local var_93_5 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_5.x, var_93_5.y, var_93_5.z)

				local var_93_6 = var_93_0.localEulerAngles

				var_93_6.z = 0
				var_93_6.x = 0
				var_93_0.localEulerAngles = var_93_6
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 then
				var_93_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_93_7 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_7.x, var_93_7.y, var_93_7.z)

				local var_93_8 = var_93_0.localEulerAngles

				var_93_8.z = 0
				var_93_8.x = 0
				var_93_0.localEulerAngles = var_93_8
			end

			local var_93_9 = arg_90_1.actors_["1084ui_story"]
			local var_93_10 = 0

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 and not isNil(var_93_9) and arg_90_1.var_.characterEffect1084ui_story == nil then
				arg_90_1.var_.characterEffect1084ui_story = var_93_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_11 = 0.200000002980232

			if var_93_10 <= arg_90_1.time_ and arg_90_1.time_ < var_93_10 + var_93_11 and not isNil(var_93_9) then
				local var_93_12 = (arg_90_1.time_ - var_93_10) / var_93_11

				if arg_90_1.var_.characterEffect1084ui_story and not isNil(var_93_9) then
					arg_90_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_10 + var_93_11 and arg_90_1.time_ < var_93_10 + var_93_11 + arg_93_0 and not isNil(var_93_9) and arg_90_1.var_.characterEffect1084ui_story then
				arg_90_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_93_13 = 0

			if var_93_13 < arg_90_1.time_ and arg_90_1.time_ <= var_93_13 + arg_93_0 then
				arg_90_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_93_14 = 0

			if var_93_14 < arg_90_1.time_ and arg_90_1.time_ <= var_93_14 + arg_93_0 then
				arg_90_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_93_15 = 0
			local var_93_16 = 0.55

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_17 = arg_90_1:FormatText(StoryNameCfg[6].name)

				arg_90_1.leftNameTxt_.text = var_93_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_18 = arg_90_1:GetWordFromCfg(301041022)
				local var_93_19 = arg_90_1:FormatText(var_93_18.content)

				arg_90_1.text_.text = var_93_19

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_20 = 22
				local var_93_21 = utf8.len(var_93_19)
				local var_93_22 = var_93_20 <= 0 and var_93_16 or var_93_16 * (var_93_21 / var_93_20)

				if var_93_22 > 0 and var_93_16 < var_93_22 then
					arg_90_1.talkMaxDuration = var_93_22

					if var_93_22 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_22 + var_93_15
					end
				end

				arg_90_1.text_.text = var_93_19
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041022", "story_v_out_301041.awb") ~= 0 then
					local var_93_23 = manager.audio:GetVoiceLength("story_v_out_301041", "301041022", "story_v_out_301041.awb") / 1000

					if var_93_23 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_23 + var_93_15
					end

					if var_93_18.prefab_name ~= "" and arg_90_1.actors_[var_93_18.prefab_name] ~= nil then
						local var_93_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_18.prefab_name].transform, "story_v_out_301041", "301041022", "story_v_out_301041.awb")

						arg_90_1:RecordAudio("301041022", var_93_24)
						arg_90_1:RecordAudio("301041022", var_93_24)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_301041", "301041022", "story_v_out_301041.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_301041", "301041022", "story_v_out_301041.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_25 = math.max(var_93_16, arg_90_1.talkMaxDuration)

			if var_93_15 <= arg_90_1.time_ and arg_90_1.time_ < var_93_15 + var_93_25 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_15) / var_93_25

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_15 + var_93_25 and arg_90_1.time_ < var_93_15 + var_93_25 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play301041023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 301041023
		arg_94_1.duration_ = 3.67

		local var_94_0 = {
			zh = 3.333,
			ja = 3.666
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
				arg_94_0:Play301041024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_97_2 = 0
			local var_97_3 = 0.375

			if var_97_2 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_4 = arg_94_1:FormatText(StoryNameCfg[6].name)

				arg_94_1.leftNameTxt_.text = var_97_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_5 = arg_94_1:GetWordFromCfg(301041023)
				local var_97_6 = arg_94_1:FormatText(var_97_5.content)

				arg_94_1.text_.text = var_97_6

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_7 = 15
				local var_97_8 = utf8.len(var_97_6)
				local var_97_9 = var_97_7 <= 0 and var_97_3 or var_97_3 * (var_97_8 / var_97_7)

				if var_97_9 > 0 and var_97_3 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_2
					end
				end

				arg_94_1.text_.text = var_97_6
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041023", "story_v_out_301041.awb") ~= 0 then
					local var_97_10 = manager.audio:GetVoiceLength("story_v_out_301041", "301041023", "story_v_out_301041.awb") / 1000

					if var_97_10 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_2
					end

					if var_97_5.prefab_name ~= "" and arg_94_1.actors_[var_97_5.prefab_name] ~= nil then
						local var_97_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_5.prefab_name].transform, "story_v_out_301041", "301041023", "story_v_out_301041.awb")

						arg_94_1:RecordAudio("301041023", var_97_11)
						arg_94_1:RecordAudio("301041023", var_97_11)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_301041", "301041023", "story_v_out_301041.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_301041", "301041023", "story_v_out_301041.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_12 = math.max(var_97_3, arg_94_1.talkMaxDuration)

			if var_97_2 <= arg_94_1.time_ and arg_94_1.time_ < var_97_2 + var_97_12 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_2) / var_97_12

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_2 + var_97_12 and arg_94_1.time_ < var_97_2 + var_97_12 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play301041024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 301041024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play301041025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1084ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1084ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1084ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1084ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1084ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.35

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_8 = arg_98_1:FormatText(StoryNameCfg[7].name)

				arg_98_1.leftNameTxt_.text = var_101_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_9 = arg_98_1:GetWordFromCfg(301041024)
				local var_101_10 = arg_98_1:FormatText(var_101_9.content)

				arg_98_1.text_.text = var_101_10

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_11 = 14
				local var_101_12 = utf8.len(var_101_10)
				local var_101_13 = var_101_11 <= 0 and var_101_7 or var_101_7 * (var_101_12 / var_101_11)

				if var_101_13 > 0 and var_101_7 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_10
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_14 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_14 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_14

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_14 and arg_98_1.time_ < var_101_6 + var_101_14 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play301041025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 301041025
		arg_102_1.duration_ = 3.3

		local var_102_0 = {
			zh = 1.999999999999,
			ja = 3.3
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
				arg_102_0:Play301041026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1084ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1084ui_story == nil then
				arg_102_1.var_.characterEffect1084ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1084ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1084ui_story then
				arg_102_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_105_4 = 0

			if var_105_4 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_105_6 = 0
			local var_105_7 = 0.125

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_8 = arg_102_1:FormatText(StoryNameCfg[6].name)

				arg_102_1.leftNameTxt_.text = var_105_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_9 = arg_102_1:GetWordFromCfg(301041025)
				local var_105_10 = arg_102_1:FormatText(var_105_9.content)

				arg_102_1.text_.text = var_105_10

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 5
				local var_105_12 = utf8.len(var_105_10)
				local var_105_13 = var_105_11 <= 0 and var_105_7 or var_105_7 * (var_105_12 / var_105_11)

				if var_105_13 > 0 and var_105_7 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_10
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041025", "story_v_out_301041.awb") ~= 0 then
					local var_105_14 = manager.audio:GetVoiceLength("story_v_out_301041", "301041025", "story_v_out_301041.awb") / 1000

					if var_105_14 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_14 + var_105_6
					end

					if var_105_9.prefab_name ~= "" and arg_102_1.actors_[var_105_9.prefab_name] ~= nil then
						local var_105_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_9.prefab_name].transform, "story_v_out_301041", "301041025", "story_v_out_301041.awb")

						arg_102_1:RecordAudio("301041025", var_105_15)
						arg_102_1:RecordAudio("301041025", var_105_15)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_301041", "301041025", "story_v_out_301041.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_301041", "301041025", "story_v_out_301041.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_16 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_16 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_16

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_16 and arg_102_1.time_ < var_105_6 + var_105_16 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play301041026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 301041026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play301041027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1084ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos1084ui_story = var_109_0.localPosition
			end

			local var_109_2 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2
				local var_109_4 = Vector3.New(0, 100, 0)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1084ui_story, var_109_4, var_109_3)

				local var_109_5 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_5.x, var_109_5.y, var_109_5.z)

				local var_109_6 = var_109_0.localEulerAngles

				var_109_6.z = 0
				var_109_6.x = 0
				var_109_0.localEulerAngles = var_109_6
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(0, 100, 0)

				local var_109_7 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_7.x, var_109_7.y, var_109_7.z)

				local var_109_8 = var_109_0.localEulerAngles

				var_109_8.z = 0
				var_109_8.x = 0
				var_109_0.localEulerAngles = var_109_8
			end

			local var_109_9 = arg_106_1.actors_["1084ui_story"]
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1084ui_story == nil then
				arg_106_1.var_.characterEffect1084ui_story = var_109_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_11 = 0.200000002980232

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_11 and not isNil(var_109_9) then
				local var_109_12 = (arg_106_1.time_ - var_109_10) / var_109_11

				if arg_106_1.var_.characterEffect1084ui_story and not isNil(var_109_9) then
					local var_109_13 = Mathf.Lerp(0, 0.5, var_109_12)

					arg_106_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1084ui_story.fillRatio = var_109_13
				end
			end

			if arg_106_1.time_ >= var_109_10 + var_109_11 and arg_106_1.time_ < var_109_10 + var_109_11 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1084ui_story then
				local var_109_14 = 0.5

				arg_106_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1084ui_story.fillRatio = var_109_14
			end

			local var_109_15 = 0
			local var_109_16 = 1.05

			if var_109_15 < arg_106_1.time_ and arg_106_1.time_ <= var_109_15 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_17 = arg_106_1:GetWordFromCfg(301041026)
				local var_109_18 = arg_106_1:FormatText(var_109_17.content)

				arg_106_1.text_.text = var_109_18

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_19 = 42
				local var_109_20 = utf8.len(var_109_18)
				local var_109_21 = var_109_19 <= 0 and var_109_16 or var_109_16 * (var_109_20 / var_109_19)

				if var_109_21 > 0 and var_109_16 < var_109_21 then
					arg_106_1.talkMaxDuration = var_109_21

					if var_109_21 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_21 + var_109_15
					end
				end

				arg_106_1.text_.text = var_109_18
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_22 = math.max(var_109_16, arg_106_1.talkMaxDuration)

			if var_109_15 <= arg_106_1.time_ and arg_106_1.time_ < var_109_15 + var_109_22 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_15) / var_109_22

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_15 + var_109_22 and arg_106_1.time_ < var_109_15 + var_109_22 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play301041027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 301041027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play301041028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.875

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(301041027)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 35
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
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_8 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_8 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_8

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_8 and arg_110_1.time_ < var_113_0 + var_113_8 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play301041028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 301041028
		arg_114_1.duration_ = 3.73

		local var_114_0 = {
			zh = 2.8,
			ja = 3.733
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play301041029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1084ui_story"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos1084ui_story = var_117_0.localPosition
			end

			local var_117_2 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2
				local var_117_4 = Vector3.New(0, -0.97, -6)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1084ui_story, var_117_4, var_117_3)

				local var_117_5 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_5.x, var_117_5.y, var_117_5.z)

				local var_117_6 = var_117_0.localEulerAngles

				var_117_6.z = 0
				var_117_6.x = 0
				var_117_0.localEulerAngles = var_117_6
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_117_7 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_7.x, var_117_7.y, var_117_7.z)

				local var_117_8 = var_117_0.localEulerAngles

				var_117_8.z = 0
				var_117_8.x = 0
				var_117_0.localEulerAngles = var_117_8
			end

			local var_117_9 = arg_114_1.actors_["1084ui_story"]
			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 and not isNil(var_117_9) and arg_114_1.var_.characterEffect1084ui_story == nil then
				arg_114_1.var_.characterEffect1084ui_story = var_117_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_11 = 0.200000002980232

			if var_117_10 <= arg_114_1.time_ and arg_114_1.time_ < var_117_10 + var_117_11 and not isNil(var_117_9) then
				local var_117_12 = (arg_114_1.time_ - var_117_10) / var_117_11

				if arg_114_1.var_.characterEffect1084ui_story and not isNil(var_117_9) then
					arg_114_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_10 + var_117_11 and arg_114_1.time_ < var_117_10 + var_117_11 + arg_117_0 and not isNil(var_117_9) and arg_114_1.var_.characterEffect1084ui_story then
				arg_114_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_117_13 = 0

			if var_117_13 < arg_114_1.time_ and arg_114_1.time_ <= var_117_13 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_117_14 = 0

			if var_117_14 < arg_114_1.time_ and arg_114_1.time_ <= var_117_14 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_117_15 = 0
			local var_117_16 = 0.3

			if var_117_15 < arg_114_1.time_ and arg_114_1.time_ <= var_117_15 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_17 = arg_114_1:FormatText(StoryNameCfg[6].name)

				arg_114_1.leftNameTxt_.text = var_117_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_18 = arg_114_1:GetWordFromCfg(301041028)
				local var_117_19 = arg_114_1:FormatText(var_117_18.content)

				arg_114_1.text_.text = var_117_19

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_20 = 12
				local var_117_21 = utf8.len(var_117_19)
				local var_117_22 = var_117_20 <= 0 and var_117_16 or var_117_16 * (var_117_21 / var_117_20)

				if var_117_22 > 0 and var_117_16 < var_117_22 then
					arg_114_1.talkMaxDuration = var_117_22

					if var_117_22 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_22 + var_117_15
					end
				end

				arg_114_1.text_.text = var_117_19
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041028", "story_v_out_301041.awb") ~= 0 then
					local var_117_23 = manager.audio:GetVoiceLength("story_v_out_301041", "301041028", "story_v_out_301041.awb") / 1000

					if var_117_23 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_23 + var_117_15
					end

					if var_117_18.prefab_name ~= "" and arg_114_1.actors_[var_117_18.prefab_name] ~= nil then
						local var_117_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_18.prefab_name].transform, "story_v_out_301041", "301041028", "story_v_out_301041.awb")

						arg_114_1:RecordAudio("301041028", var_117_24)
						arg_114_1:RecordAudio("301041028", var_117_24)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_301041", "301041028", "story_v_out_301041.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_301041", "301041028", "story_v_out_301041.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_25 = math.max(var_117_16, arg_114_1.talkMaxDuration)

			if var_117_15 <= arg_114_1.time_ and arg_114_1.time_ < var_117_15 + var_117_25 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_15) / var_117_25

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_15 + var_117_25 and arg_114_1.time_ < var_117_15 + var_117_25 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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

		arg_114_1:InitPlayNodeList()
	end,
	Play301041029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 301041029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play301041030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1084ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_0) then
					local var_121_4 = Mathf.Lerp(0, 0.5, var_121_3)

					arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1084ui_story.fillRatio = var_121_4
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1084ui_story then
				local var_121_5 = 0.5

				arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1084ui_story.fillRatio = var_121_5
			end

			local var_121_6 = 0
			local var_121_7 = 0.575

			if var_121_6 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_8 = arg_118_1:FormatText(StoryNameCfg[7].name)

				arg_118_1.leftNameTxt_.text = var_121_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_9 = arg_118_1:GetWordFromCfg(301041029)
				local var_121_10 = arg_118_1:FormatText(var_121_9.content)

				arg_118_1.text_.text = var_121_10

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 23
				local var_121_12 = utf8.len(var_121_10)
				local var_121_13 = var_121_11 <= 0 and var_121_7 or var_121_7 * (var_121_12 / var_121_11)

				if var_121_13 > 0 and var_121_7 < var_121_13 then
					arg_118_1.talkMaxDuration = var_121_13

					if var_121_13 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_13 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_10
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_14 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_14 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_14

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_14 and arg_118_1.time_ < var_121_6 + var_121_14 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play301041030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 301041030
		arg_122_1.duration_ = 5.77

		local var_122_0 = {
			zh = 4.633,
			ja = 5.766
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play301041031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1084ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1084ui_story then
				arg_122_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_125_4 = 0

			if var_125_4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 then
				arg_122_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_125_6 = 0
			local var_125_7 = 0.575

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_8 = arg_122_1:FormatText(StoryNameCfg[6].name)

				arg_122_1.leftNameTxt_.text = var_125_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_9 = arg_122_1:GetWordFromCfg(301041030)
				local var_125_10 = arg_122_1:FormatText(var_125_9.content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 23
				local var_125_12 = utf8.len(var_125_10)
				local var_125_13 = var_125_11 <= 0 and var_125_7 or var_125_7 * (var_125_12 / var_125_11)

				if var_125_13 > 0 and var_125_7 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041030", "story_v_out_301041.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_301041", "301041030", "story_v_out_301041.awb") / 1000

					if var_125_14 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_6
					end

					if var_125_9.prefab_name ~= "" and arg_122_1.actors_[var_125_9.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_9.prefab_name].transform, "story_v_out_301041", "301041030", "story_v_out_301041.awb")

						arg_122_1:RecordAudio("301041030", var_125_15)
						arg_122_1:RecordAudio("301041030", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_301041", "301041030", "story_v_out_301041.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_301041", "301041030", "story_v_out_301041.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_16 and arg_122_1.time_ < var_125_6 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play301041031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 301041031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play301041032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1084ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1084ui_story == nil then
				arg_126_1.var_.characterEffect1084ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1084ui_story and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1084ui_story.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1084ui_story then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1084ui_story.fillRatio = var_129_5
			end

			local var_129_6 = 0
			local var_129_7 = 0.35

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[7].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_9 = arg_126_1:GetWordFromCfg(301041031)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 14
				local var_129_12 = utf8.len(var_129_10)
				local var_129_13 = var_129_11 <= 0 and var_129_7 or var_129_7 * (var_129_12 / var_129_11)

				if var_129_13 > 0 and var_129_7 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_10
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_14 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_14 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_14

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_14 and arg_126_1.time_ < var_129_6 + var_129_14 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play301041032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 301041032
		arg_130_1.duration_ = 4.5

		local var_130_0 = {
			zh = 3.366,
			ja = 4.5
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play301041033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1084ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1084ui_story == nil then
				arg_130_1.var_.characterEffect1084ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect1084ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1084ui_story then
				arg_130_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_133_4 = 0

			if var_133_4 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_133_5 = 0

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_133_6 = 0
			local var_133_7 = 0.5

			if var_133_6 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_8 = arg_130_1:FormatText(StoryNameCfg[6].name)

				arg_130_1.leftNameTxt_.text = var_133_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_9 = arg_130_1:GetWordFromCfg(301041032)
				local var_133_10 = arg_130_1:FormatText(var_133_9.content)

				arg_130_1.text_.text = var_133_10

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_11 = 20
				local var_133_12 = utf8.len(var_133_10)
				local var_133_13 = var_133_11 <= 0 and var_133_7 or var_133_7 * (var_133_12 / var_133_11)

				if var_133_13 > 0 and var_133_7 < var_133_13 then
					arg_130_1.talkMaxDuration = var_133_13

					if var_133_13 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_13 + var_133_6
					end
				end

				arg_130_1.text_.text = var_133_10
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041032", "story_v_out_301041.awb") ~= 0 then
					local var_133_14 = manager.audio:GetVoiceLength("story_v_out_301041", "301041032", "story_v_out_301041.awb") / 1000

					if var_133_14 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_14 + var_133_6
					end

					if var_133_9.prefab_name ~= "" and arg_130_1.actors_[var_133_9.prefab_name] ~= nil then
						local var_133_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_9.prefab_name].transform, "story_v_out_301041", "301041032", "story_v_out_301041.awb")

						arg_130_1:RecordAudio("301041032", var_133_15)
						arg_130_1:RecordAudio("301041032", var_133_15)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_301041", "301041032", "story_v_out_301041.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_301041", "301041032", "story_v_out_301041.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_16 = math.max(var_133_7, arg_130_1.talkMaxDuration)

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_16 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_6) / var_133_16

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_6 + var_133_16 and arg_130_1.time_ < var_133_6 + var_133_16 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play301041033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 301041033
		arg_134_1.duration_ = 5.43

		local var_134_0 = {
			zh = 3.866,
			ja = 5.433
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play301041034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_137_2 = 0
			local var_137_3 = 0.575

			if var_137_2 < arg_134_1.time_ and arg_134_1.time_ <= var_137_2 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_4 = arg_134_1:FormatText(StoryNameCfg[6].name)

				arg_134_1.leftNameTxt_.text = var_137_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_5 = arg_134_1:GetWordFromCfg(301041033)
				local var_137_6 = arg_134_1:FormatText(var_137_5.content)

				arg_134_1.text_.text = var_137_6

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_7 = 23
				local var_137_8 = utf8.len(var_137_6)
				local var_137_9 = var_137_7 <= 0 and var_137_3 or var_137_3 * (var_137_8 / var_137_7)

				if var_137_9 > 0 and var_137_3 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_2
					end
				end

				arg_134_1.text_.text = var_137_6
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041033", "story_v_out_301041.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_out_301041", "301041033", "story_v_out_301041.awb") / 1000

					if var_137_10 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_2
					end

					if var_137_5.prefab_name ~= "" and arg_134_1.actors_[var_137_5.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_5.prefab_name].transform, "story_v_out_301041", "301041033", "story_v_out_301041.awb")

						arg_134_1:RecordAudio("301041033", var_137_11)
						arg_134_1:RecordAudio("301041033", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_301041", "301041033", "story_v_out_301041.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_301041", "301041033", "story_v_out_301041.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_3, arg_134_1.talkMaxDuration)

			if var_137_2 <= arg_134_1.time_ and arg_134_1.time_ < var_137_2 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_2) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_2 + var_137_12 and arg_134_1.time_ < var_137_2 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play301041034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 301041034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play301041035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1084ui_story"].transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.var_.moveOldPos1084ui_story = var_141_0.localPosition
			end

			local var_141_2 = 0.001

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2
				local var_141_4 = Vector3.New(0, 100, 0)

				var_141_0.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1084ui_story, var_141_4, var_141_3)

				local var_141_5 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_5.x, var_141_5.y, var_141_5.z)

				local var_141_6 = var_141_0.localEulerAngles

				var_141_6.z = 0
				var_141_6.x = 0
				var_141_0.localEulerAngles = var_141_6
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 then
				var_141_0.localPosition = Vector3.New(0, 100, 0)

				local var_141_7 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_7.x, var_141_7.y, var_141_7.z)

				local var_141_8 = var_141_0.localEulerAngles

				var_141_8.z = 0
				var_141_8.x = 0
				var_141_0.localEulerAngles = var_141_8
			end

			local var_141_9 = arg_138_1.actors_["1084ui_story"]
			local var_141_10 = 0

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 and not isNil(var_141_9) and arg_138_1.var_.characterEffect1084ui_story == nil then
				arg_138_1.var_.characterEffect1084ui_story = var_141_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_11 = 0.200000002980232

			if var_141_10 <= arg_138_1.time_ and arg_138_1.time_ < var_141_10 + var_141_11 and not isNil(var_141_9) then
				local var_141_12 = (arg_138_1.time_ - var_141_10) / var_141_11

				if arg_138_1.var_.characterEffect1084ui_story and not isNil(var_141_9) then
					local var_141_13 = Mathf.Lerp(0, 0.5, var_141_12)

					arg_138_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1084ui_story.fillRatio = var_141_13
				end
			end

			if arg_138_1.time_ >= var_141_10 + var_141_11 and arg_138_1.time_ < var_141_10 + var_141_11 + arg_141_0 and not isNil(var_141_9) and arg_138_1.var_.characterEffect1084ui_story then
				local var_141_14 = 0.5

				arg_138_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1084ui_story.fillRatio = var_141_14
			end

			local var_141_15 = 0
			local var_141_16 = 1.05

			if var_141_15 < arg_138_1.time_ and arg_138_1.time_ <= var_141_15 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_17 = arg_138_1:GetWordFromCfg(301041034)
				local var_141_18 = arg_138_1:FormatText(var_141_17.content)

				arg_138_1.text_.text = var_141_18

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_19 = 42
				local var_141_20 = utf8.len(var_141_18)
				local var_141_21 = var_141_19 <= 0 and var_141_16 or var_141_16 * (var_141_20 / var_141_19)

				if var_141_21 > 0 and var_141_16 < var_141_21 then
					arg_138_1.talkMaxDuration = var_141_21

					if var_141_21 + var_141_15 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_21 + var_141_15
					end
				end

				arg_138_1.text_.text = var_141_18
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_22 = math.max(var_141_16, arg_138_1.talkMaxDuration)

			if var_141_15 <= arg_138_1.time_ and arg_138_1.time_ < var_141_15 + var_141_22 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_15) / var_141_22

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_15 + var_141_22 and arg_138_1.time_ < var_141_15 + var_141_22 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
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

		arg_138_1:InitPlayNodeList()
	end,
	Play301041035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 301041035
		arg_142_1.duration_ = 4.73

		local var_142_0 = {
			zh = 4.366,
			ja = 4.733
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play301041036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1084ui_story"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos1084ui_story = var_145_0.localPosition
			end

			local var_145_2 = 0.001

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2
				local var_145_4 = Vector3.New(0, -0.97, -6)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1084ui_story, var_145_4, var_145_3)

				local var_145_5 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_5.x, var_145_5.y, var_145_5.z)

				local var_145_6 = var_145_0.localEulerAngles

				var_145_6.z = 0
				var_145_6.x = 0
				var_145_0.localEulerAngles = var_145_6
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_145_7 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_7.x, var_145_7.y, var_145_7.z)

				local var_145_8 = var_145_0.localEulerAngles

				var_145_8.z = 0
				var_145_8.x = 0
				var_145_0.localEulerAngles = var_145_8
			end

			local var_145_9 = arg_142_1.actors_["1084ui_story"]
			local var_145_10 = 0

			if var_145_10 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 and not isNil(var_145_9) and arg_142_1.var_.characterEffect1084ui_story == nil then
				arg_142_1.var_.characterEffect1084ui_story = var_145_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_11 = 0.200000002980232

			if var_145_10 <= arg_142_1.time_ and arg_142_1.time_ < var_145_10 + var_145_11 and not isNil(var_145_9) then
				local var_145_12 = (arg_142_1.time_ - var_145_10) / var_145_11

				if arg_142_1.var_.characterEffect1084ui_story and not isNil(var_145_9) then
					arg_142_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_10 + var_145_11 and arg_142_1.time_ < var_145_10 + var_145_11 + arg_145_0 and not isNil(var_145_9) and arg_142_1.var_.characterEffect1084ui_story then
				arg_142_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_145_13 = 0

			if var_145_13 < arg_142_1.time_ and arg_142_1.time_ <= var_145_13 + arg_145_0 then
				arg_142_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_145_14 = 0

			if var_145_14 < arg_142_1.time_ and arg_142_1.time_ <= var_145_14 + arg_145_0 then
				arg_142_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_145_15 = 0
			local var_145_16 = 0.625

			if var_145_15 < arg_142_1.time_ and arg_142_1.time_ <= var_145_15 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_17 = arg_142_1:FormatText(StoryNameCfg[6].name)

				arg_142_1.leftNameTxt_.text = var_145_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_18 = arg_142_1:GetWordFromCfg(301041035)
				local var_145_19 = arg_142_1:FormatText(var_145_18.content)

				arg_142_1.text_.text = var_145_19

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_20 = 25
				local var_145_21 = utf8.len(var_145_19)
				local var_145_22 = var_145_20 <= 0 and var_145_16 or var_145_16 * (var_145_21 / var_145_20)

				if var_145_22 > 0 and var_145_16 < var_145_22 then
					arg_142_1.talkMaxDuration = var_145_22

					if var_145_22 + var_145_15 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_22 + var_145_15
					end
				end

				arg_142_1.text_.text = var_145_19
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041035", "story_v_out_301041.awb") ~= 0 then
					local var_145_23 = manager.audio:GetVoiceLength("story_v_out_301041", "301041035", "story_v_out_301041.awb") / 1000

					if var_145_23 + var_145_15 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_23 + var_145_15
					end

					if var_145_18.prefab_name ~= "" and arg_142_1.actors_[var_145_18.prefab_name] ~= nil then
						local var_145_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_18.prefab_name].transform, "story_v_out_301041", "301041035", "story_v_out_301041.awb")

						arg_142_1:RecordAudio("301041035", var_145_24)
						arg_142_1:RecordAudio("301041035", var_145_24)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_301041", "301041035", "story_v_out_301041.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_301041", "301041035", "story_v_out_301041.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_25 = math.max(var_145_16, arg_142_1.talkMaxDuration)

			if var_145_15 <= arg_142_1.time_ and arg_142_1.time_ < var_145_15 + var_145_25 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_15) / var_145_25

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_15 + var_145_25 and arg_142_1.time_ < var_145_15 + var_145_25 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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

		arg_142_1:InitPlayNodeList()
	end,
	Play301041036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 301041036
		arg_146_1.duration_ = 6.8

		local var_146_0 = {
			zh = 6.133,
			ja = 6.8
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play301041037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			local var_149_1 = 0
			local var_149_2 = 0.825

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_3 = arg_146_1:FormatText(StoryNameCfg[6].name)

				arg_146_1.leftNameTxt_.text = var_149_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_4 = arg_146_1:GetWordFromCfg(301041036)
				local var_149_5 = arg_146_1:FormatText(var_149_4.content)

				arg_146_1.text_.text = var_149_5

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_6 = 33
				local var_149_7 = utf8.len(var_149_5)
				local var_149_8 = var_149_6 <= 0 and var_149_2 or var_149_2 * (var_149_7 / var_149_6)

				if var_149_8 > 0 and var_149_2 < var_149_8 then
					arg_146_1.talkMaxDuration = var_149_8

					if var_149_8 + var_149_1 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_1
					end
				end

				arg_146_1.text_.text = var_149_5
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041036", "story_v_out_301041.awb") ~= 0 then
					local var_149_9 = manager.audio:GetVoiceLength("story_v_out_301041", "301041036", "story_v_out_301041.awb") / 1000

					if var_149_9 + var_149_1 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_1
					end

					if var_149_4.prefab_name ~= "" and arg_146_1.actors_[var_149_4.prefab_name] ~= nil then
						local var_149_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_4.prefab_name].transform, "story_v_out_301041", "301041036", "story_v_out_301041.awb")

						arg_146_1:RecordAudio("301041036", var_149_10)
						arg_146_1:RecordAudio("301041036", var_149_10)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_301041", "301041036", "story_v_out_301041.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_301041", "301041036", "story_v_out_301041.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_11 = math.max(var_149_2, arg_146_1.talkMaxDuration)

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_11 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_1) / var_149_11

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_1 + var_149_11 and arg_146_1.time_ < var_149_1 + var_149_11 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play301041037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 301041037
		arg_150_1.duration_ = 13.03

		local var_150_0 = {
			zh = 11,
			ja = 13.033
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play301041038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 1.45

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_2 = arg_150_1:FormatText(StoryNameCfg[6].name)

				arg_150_1.leftNameTxt_.text = var_153_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_3 = arg_150_1:GetWordFromCfg(301041037)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 58
				local var_153_6 = utf8.len(var_153_4)
				local var_153_7 = var_153_5 <= 0 and var_153_1 or var_153_1 * (var_153_6 / var_153_5)

				if var_153_7 > 0 and var_153_1 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301041", "301041037", "story_v_out_301041.awb") ~= 0 then
					local var_153_8 = manager.audio:GetVoiceLength("story_v_out_301041", "301041037", "story_v_out_301041.awb") / 1000

					if var_153_8 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_0
					end

					if var_153_3.prefab_name ~= "" and arg_150_1.actors_[var_153_3.prefab_name] ~= nil then
						local var_153_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_3.prefab_name].transform, "story_v_out_301041", "301041037", "story_v_out_301041.awb")

						arg_150_1:RecordAudio("301041037", var_153_9)
						arg_150_1:RecordAudio("301041037", var_153_9)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_301041", "301041037", "story_v_out_301041.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_301041", "301041037", "story_v_out_301041.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_10 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_10 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_10

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_10 and arg_150_1.time_ < var_153_0 + var_153_10 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play301041038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 301041038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play301041039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1084ui_story"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos1084ui_story = var_157_0.localPosition
			end

			local var_157_2 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2
				local var_157_4 = Vector3.New(0, 100, 0)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1084ui_story, var_157_4, var_157_3)

				local var_157_5 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_5.x, var_157_5.y, var_157_5.z)

				local var_157_6 = var_157_0.localEulerAngles

				var_157_6.z = 0
				var_157_6.x = 0
				var_157_0.localEulerAngles = var_157_6
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(0, 100, 0)

				local var_157_7 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_7.x, var_157_7.y, var_157_7.z)

				local var_157_8 = var_157_0.localEulerAngles

				var_157_8.z = 0
				var_157_8.x = 0
				var_157_0.localEulerAngles = var_157_8
			end

			local var_157_9 = arg_154_1.actors_["1084ui_story"]
			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect1084ui_story == nil then
				arg_154_1.var_.characterEffect1084ui_story = var_157_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_11 = 0.200000002980232

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_11 and not isNil(var_157_9) then
				local var_157_12 = (arg_154_1.time_ - var_157_10) / var_157_11

				if arg_154_1.var_.characterEffect1084ui_story and not isNil(var_157_9) then
					local var_157_13 = Mathf.Lerp(0, 0.5, var_157_12)

					arg_154_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1084ui_story.fillRatio = var_157_13
				end
			end

			if arg_154_1.time_ >= var_157_10 + var_157_11 and arg_154_1.time_ < var_157_10 + var_157_11 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect1084ui_story then
				local var_157_14 = 0.5

				arg_154_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1084ui_story.fillRatio = var_157_14
			end

			local var_157_15 = 0
			local var_157_16 = 1.025

			if var_157_15 < arg_154_1.time_ and arg_154_1.time_ <= var_157_15 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_17 = arg_154_1:GetWordFromCfg(301041038)
				local var_157_18 = arg_154_1:FormatText(var_157_17.content)

				arg_154_1.text_.text = var_157_18

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_19 = 41
				local var_157_20 = utf8.len(var_157_18)
				local var_157_21 = var_157_19 <= 0 and var_157_16 or var_157_16 * (var_157_20 / var_157_19)

				if var_157_21 > 0 and var_157_16 < var_157_21 then
					arg_154_1.talkMaxDuration = var_157_21

					if var_157_21 + var_157_15 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_21 + var_157_15
					end
				end

				arg_154_1.text_.text = var_157_18
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_22 = math.max(var_157_16, arg_154_1.talkMaxDuration)

			if var_157_15 <= arg_154_1.time_ and arg_154_1.time_ < var_157_15 + var_157_22 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_15) / var_157_22

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_15 + var_157_22 and arg_154_1.time_ < var_157_15 + var_157_22 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
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

		arg_154_1:InitPlayNodeList()
	end,
	Play301041039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 301041039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
			arg_158_1.auto_ = false
		end

		function arg_158_1.playNext_(arg_160_0)
			arg_158_1.onStoryFinished_()
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.25

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_2 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:GetWordFromCfg(301041039)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 10
				local var_161_6 = utf8.len(var_161_4)
				local var_161_7 = var_161_5 <= 0 and var_161_1 or var_161_1 * (var_161_6 / var_161_5)

				if var_161_7 > 0 and var_161_1 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_8 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_8 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_8

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_8 and arg_158_1.time_ < var_161_0 + var_161_8 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0118",
		"TextureConfig/Background/I05"
	},
	voices = {
		"story_v_out_301041.awb"
	}
}
