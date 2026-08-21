return {
	Play302062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 302062001
		arg_1_1.duration_ = 9.23

		local var_1_0 = {
			zh = 6.766,
			ja = 9.233
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
				arg_1_0:Play302062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I28f"

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
				local var_4_5 = arg_1_1.bgs_.I28f

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
					if iter_4_0 ~= "I28f" then
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

			local var_4_24 = "2079ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "2079ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["2079ui_story"].transform
			local var_4_30 = 1.83333333333333

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos2079ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -1.28, -5.6)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2079ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["2079ui_story"]
			local var_4_39 = 1.83333333333333

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect2079ui_story == nil then
				arg_1_1.var_.characterEffect2079ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect2079ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect2079ui_story then
				arg_1_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_4_42 = 1.83333333333333

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_4_43 = 1.83333333333333

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0.2
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "effect"

				arg_1_1:AudioAction(var_4_46, var_4_47, "se_story_side_1049", "se_story_side_1049_amb_room", "")
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
			local var_4_59 = 0.65

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

				local var_4_61 = arg_1_1:FormatText(StoryNameCfg[688].name)

				arg_1_1.leftNameTxt_.text = var_4_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_62 = arg_1_1:GetWordFromCfg(302062001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062001", "story_v_out_302062.awb") ~= 0 then
					local var_4_67 = manager.audio:GetVoiceLength("story_v_out_302062", "302062001", "story_v_out_302062.awb") / 1000

					if var_4_67 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_58
					end

					if var_4_62.prefab_name ~= "" and arg_1_1.actors_[var_4_62.prefab_name] ~= nil then
						local var_4_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_62.prefab_name].transform, "story_v_out_302062", "302062001", "story_v_out_302062.awb")

						arg_1_1:RecordAudio("302062001", var_4_68)
						arg_1_1:RecordAudio("302062001", var_4_68)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_302062", "302062001", "story_v_out_302062.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_302062", "302062001", "story_v_out_302062.awb")
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play302062002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 302062002
		arg_8_1.duration_ = 5.77

		local var_8_0 = {
			zh = 4.7,
			ja = 5.766
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
				arg_8_0:Play302062003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.675

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[688].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:GetWordFromCfg(302062002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 27
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062002", "story_v_out_302062.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_302062", "302062002", "story_v_out_302062.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_302062", "302062002", "story_v_out_302062.awb")

						arg_8_1:RecordAudio("302062002", var_11_9)
						arg_8_1:RecordAudio("302062002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_302062", "302062002", "story_v_out_302062.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_302062", "302062002", "story_v_out_302062.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_10 and arg_8_1.time_ < var_11_0 + var_11_10 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play302062003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 302062003
		arg_12_1.duration_ = 3.67

		local var_12_0 = {
			zh = 3.666,
			ja = 2.9
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
				arg_12_0:Play302062004(arg_12_1)
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

			local var_15_5 = arg_12_1.actors_["1084ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_5.localPosition
			end

			local var_15_7 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7
				local var_15_9 = Vector3.New(0.7, -0.97, -6)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, var_15_9, var_15_8)

				local var_15_10 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_10.x, var_15_10.y, var_15_10.z)

				local var_15_11 = var_15_5.localEulerAngles

				var_15_11.z = 0
				var_15_11.x = 0
				var_15_5.localEulerAngles = var_15_11
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_15_12 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_12.x, var_15_12.y, var_15_12.z)

				local var_15_13 = var_15_5.localEulerAngles

				var_15_13.z = 0
				var_15_13.x = 0
				var_15_5.localEulerAngles = var_15_13
			end

			local var_15_14 = arg_12_1.actors_["2079ui_story"].transform
			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 then
				arg_12_1.var_.moveOldPos2079ui_story = var_15_14.localPosition
			end

			local var_15_16 = 0.001

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_16 then
				local var_15_17 = (arg_12_1.time_ - var_15_15) / var_15_16
				local var_15_18 = Vector3.New(-0.7, -1.28, -5.6)

				var_15_14.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2079ui_story, var_15_18, var_15_17)

				local var_15_19 = manager.ui.mainCamera.transform.position - var_15_14.position

				var_15_14.forward = Vector3.New(var_15_19.x, var_15_19.y, var_15_19.z)

				local var_15_20 = var_15_14.localEulerAngles

				var_15_20.z = 0
				var_15_20.x = 0
				var_15_14.localEulerAngles = var_15_20
			end

			if arg_12_1.time_ >= var_15_15 + var_15_16 and arg_12_1.time_ < var_15_15 + var_15_16 + arg_15_0 then
				var_15_14.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_15_21 = manager.ui.mainCamera.transform.position - var_15_14.position

				var_15_14.forward = Vector3.New(var_15_21.x, var_15_21.y, var_15_21.z)

				local var_15_22 = var_15_14.localEulerAngles

				var_15_22.z = 0
				var_15_22.x = 0
				var_15_14.localEulerAngles = var_15_22
			end

			local var_15_23 = arg_12_1.actors_["1084ui_story"]
			local var_15_24 = 0

			if var_15_24 < arg_12_1.time_ and arg_12_1.time_ <= var_15_24 + arg_15_0 and not isNil(var_15_23) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_25 = 0.200000002980232

			if var_15_24 <= arg_12_1.time_ and arg_12_1.time_ < var_15_24 + var_15_25 and not isNil(var_15_23) then
				local var_15_26 = (arg_12_1.time_ - var_15_24) / var_15_25

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_23) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_24 + var_15_25 and arg_12_1.time_ < var_15_24 + var_15_25 + arg_15_0 and not isNil(var_15_23) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_15_27 = arg_12_1.actors_["2079ui_story"]
			local var_15_28 = 0

			if var_15_28 < arg_12_1.time_ and arg_12_1.time_ <= var_15_28 + arg_15_0 and not isNil(var_15_27) and arg_12_1.var_.characterEffect2079ui_story == nil then
				arg_12_1.var_.characterEffect2079ui_story = var_15_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_29 = 0.200000002980232

			if var_15_28 <= arg_12_1.time_ and arg_12_1.time_ < var_15_28 + var_15_29 and not isNil(var_15_27) then
				local var_15_30 = (arg_12_1.time_ - var_15_28) / var_15_29

				if arg_12_1.var_.characterEffect2079ui_story and not isNil(var_15_27) then
					local var_15_31 = Mathf.Lerp(0, 0.5, var_15_30)

					arg_12_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_12_1.var_.characterEffect2079ui_story.fillRatio = var_15_31
				end
			end

			if arg_12_1.time_ >= var_15_28 + var_15_29 and arg_12_1.time_ < var_15_28 + var_15_29 + arg_15_0 and not isNil(var_15_27) and arg_12_1.var_.characterEffect2079ui_story then
				local var_15_32 = 0.5

				arg_12_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_12_1.var_.characterEffect2079ui_story.fillRatio = var_15_32
			end

			local var_15_33 = 0

			if var_15_33 < arg_12_1.time_ and arg_12_1.time_ <= var_15_33 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_15_34 = 0

			if var_15_34 < arg_12_1.time_ and arg_12_1.time_ <= var_15_34 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_15_35 = 0
			local var_15_36 = 0.45

			if var_15_35 < arg_12_1.time_ and arg_12_1.time_ <= var_15_35 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_37 = arg_12_1:FormatText(StoryNameCfg[6].name)

				arg_12_1.leftNameTxt_.text = var_15_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_38 = arg_12_1:GetWordFromCfg(302062003)
				local var_15_39 = arg_12_1:FormatText(var_15_38.content)

				arg_12_1.text_.text = var_15_39

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_40 = 18
				local var_15_41 = utf8.len(var_15_39)
				local var_15_42 = var_15_40 <= 0 and var_15_36 or var_15_36 * (var_15_41 / var_15_40)

				if var_15_42 > 0 and var_15_36 < var_15_42 then
					arg_12_1.talkMaxDuration = var_15_42

					if var_15_42 + var_15_35 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_42 + var_15_35
					end
				end

				arg_12_1.text_.text = var_15_39
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062003", "story_v_out_302062.awb") ~= 0 then
					local var_15_43 = manager.audio:GetVoiceLength("story_v_out_302062", "302062003", "story_v_out_302062.awb") / 1000

					if var_15_43 + var_15_35 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_43 + var_15_35
					end

					if var_15_38.prefab_name ~= "" and arg_12_1.actors_[var_15_38.prefab_name] ~= nil then
						local var_15_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_38.prefab_name].transform, "story_v_out_302062", "302062003", "story_v_out_302062.awb")

						arg_12_1:RecordAudio("302062003", var_15_44)
						arg_12_1:RecordAudio("302062003", var_15_44)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_302062", "302062003", "story_v_out_302062.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_302062", "302062003", "story_v_out_302062.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_45 = math.max(var_15_36, arg_12_1.talkMaxDuration)

			if var_15_35 <= arg_12_1.time_ and arg_12_1.time_ < var_15_35 + var_15_45 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_35) / var_15_45

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_35 + var_15_45 and arg_12_1.time_ < var_15_35 + var_15_45 + arg_15_0 then
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
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play302062004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 302062004
		arg_16_1.duration_ = 3.9

		local var_16_0 = {
			zh = 3.1,
			ja = 3.9
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
				arg_16_0:Play302062005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["2079ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect2079ui_story == nil then
				arg_16_1.var_.characterEffect2079ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect2079ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect2079ui_story then
				arg_16_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_19_4 = arg_16_1.actors_["1084ui_story"]
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.200000002980232

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
				arg_16_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_19_11 = 0

			if var_19_11 < arg_16_1.time_ and arg_16_1.time_ <= var_19_11 + arg_19_0 then
				arg_16_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_12 = 0
			local var_19_13 = 0.375

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_14 = arg_16_1:FormatText(StoryNameCfg[688].name)

				arg_16_1.leftNameTxt_.text = var_19_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_15 = arg_16_1:GetWordFromCfg(302062004)
				local var_19_16 = arg_16_1:FormatText(var_19_15.content)

				arg_16_1.text_.text = var_19_16

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062004", "story_v_out_302062.awb") ~= 0 then
					local var_19_20 = manager.audio:GetVoiceLength("story_v_out_302062", "302062004", "story_v_out_302062.awb") / 1000

					if var_19_20 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_20 + var_19_12
					end

					if var_19_15.prefab_name ~= "" and arg_16_1.actors_[var_19_15.prefab_name] ~= nil then
						local var_19_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_15.prefab_name].transform, "story_v_out_302062", "302062004", "story_v_out_302062.awb")

						arg_16_1:RecordAudio("302062004", var_19_21)
						arg_16_1:RecordAudio("302062004", var_19_21)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_302062", "302062004", "story_v_out_302062.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_302062", "302062004", "story_v_out_302062.awb")
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
	Play302062005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 302062005
		arg_20_1.duration_ = 3.93

		local var_20_0 = {
			zh = 2.1,
			ja = 3.933
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
				arg_20_0:Play302062006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1084ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1084ui_story then
				arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["2079ui_story"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect2079ui_story == nil then
				arg_20_1.var_.characterEffect2079ui_story = var_23_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.200000002980232

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.characterEffect2079ui_story and not isNil(var_23_4) then
					local var_23_8 = Mathf.Lerp(0, 0.5, var_23_7)

					arg_20_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_20_1.var_.characterEffect2079ui_story.fillRatio = var_23_8
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect2079ui_story then
				local var_23_9 = 0.5

				arg_20_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_20_1.var_.characterEffect2079ui_story.fillRatio = var_23_9
			end

			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_23_11 = 0

			if var_23_11 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_23_12 = 0
			local var_23_13 = 0.25

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_14 = arg_20_1:FormatText(StoryNameCfg[6].name)

				arg_20_1.leftNameTxt_.text = var_23_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_15 = arg_20_1:GetWordFromCfg(302062005)
				local var_23_16 = arg_20_1:FormatText(var_23_15.content)

				arg_20_1.text_.text = var_23_16

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_17 = 10
				local var_23_18 = utf8.len(var_23_16)
				local var_23_19 = var_23_17 <= 0 and var_23_13 or var_23_13 * (var_23_18 / var_23_17)

				if var_23_19 > 0 and var_23_13 < var_23_19 then
					arg_20_1.talkMaxDuration = var_23_19

					if var_23_19 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_19 + var_23_12
					end
				end

				arg_20_1.text_.text = var_23_16
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062005", "story_v_out_302062.awb") ~= 0 then
					local var_23_20 = manager.audio:GetVoiceLength("story_v_out_302062", "302062005", "story_v_out_302062.awb") / 1000

					if var_23_20 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_20 + var_23_12
					end

					if var_23_15.prefab_name ~= "" and arg_20_1.actors_[var_23_15.prefab_name] ~= nil then
						local var_23_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_15.prefab_name].transform, "story_v_out_302062", "302062005", "story_v_out_302062.awb")

						arg_20_1:RecordAudio("302062005", var_23_21)
						arg_20_1:RecordAudio("302062005", var_23_21)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_302062", "302062005", "story_v_out_302062.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_302062", "302062005", "story_v_out_302062.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_22 = math.max(var_23_13, arg_20_1.talkMaxDuration)

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_22 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_12) / var_23_22

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_12 + var_23_22 and arg_20_1.time_ < var_23_12 + var_23_22 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play302062006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 302062006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play302062007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1084ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = arg_24_1.actors_["2079ui_story"].transform
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.var_.moveOldPos2079ui_story = var_27_9.localPosition
			end

			local var_27_11 = 0.001

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11
				local var_27_13 = Vector3.New(0, 100, 0)

				var_27_9.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos2079ui_story, var_27_13, var_27_12)

				local var_27_14 = manager.ui.mainCamera.transform.position - var_27_9.position

				var_27_9.forward = Vector3.New(var_27_14.x, var_27_14.y, var_27_14.z)

				local var_27_15 = var_27_9.localEulerAngles

				var_27_15.z = 0
				var_27_15.x = 0
				var_27_9.localEulerAngles = var_27_15
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 then
				var_27_9.localPosition = Vector3.New(0, 100, 0)

				local var_27_16 = manager.ui.mainCamera.transform.position - var_27_9.position

				var_27_9.forward = Vector3.New(var_27_16.x, var_27_16.y, var_27_16.z)

				local var_27_17 = var_27_9.localEulerAngles

				var_27_17.z = 0
				var_27_17.x = 0
				var_27_9.localEulerAngles = var_27_17
			end

			local var_27_18 = arg_24_1.actors_["1084ui_story"]
			local var_27_19 = 0

			if var_27_19 < arg_24_1.time_ and arg_24_1.time_ <= var_27_19 + arg_27_0 and not isNil(var_27_18) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_20 = 0.200000002980232

			if var_27_19 <= arg_24_1.time_ and arg_24_1.time_ < var_27_19 + var_27_20 and not isNil(var_27_18) then
				local var_27_21 = (arg_24_1.time_ - var_27_19) / var_27_20

				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_18) then
					local var_27_22 = Mathf.Lerp(0, 0.5, var_27_21)

					arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_22
				end
			end

			if arg_24_1.time_ >= var_27_19 + var_27_20 and arg_24_1.time_ < var_27_19 + var_27_20 + arg_27_0 and not isNil(var_27_18) and arg_24_1.var_.characterEffect1084ui_story then
				local var_27_23 = 0.5

				arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_23
			end

			local var_27_24 = 0
			local var_27_25 = 1.7

			if var_27_24 < arg_24_1.time_ and arg_24_1.time_ <= var_27_24 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_26 = arg_24_1:GetWordFromCfg(302062006)
				local var_27_27 = arg_24_1:FormatText(var_27_26.content)

				arg_24_1.text_.text = var_27_27

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_28 = 68
				local var_27_29 = utf8.len(var_27_27)
				local var_27_30 = var_27_28 <= 0 and var_27_25 or var_27_25 * (var_27_29 / var_27_28)

				if var_27_30 > 0 and var_27_25 < var_27_30 then
					arg_24_1.talkMaxDuration = var_27_30

					if var_27_30 + var_27_24 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_30 + var_27_24
					end
				end

				arg_24_1.text_.text = var_27_27
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_31 = math.max(var_27_25, arg_24_1.talkMaxDuration)

			if var_27_24 <= arg_24_1.time_ and arg_24_1.time_ < var_27_24 + var_27_31 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_24) / var_27_31

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_24 + var_27_31 and arg_24_1.time_ < var_27_24 + var_27_31 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play302062007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 302062007
		arg_28_1.duration_ = 2.87

		local var_28_0 = {
			zh = 2.866,
			ja = 1.999999999999
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
				arg_28_0:Play302062008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1166ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "1166ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "1166ui_story"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = arg_28_1.actors_["1166ui_story"].transform
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.var_.moveOldPos1166ui_story = var_31_5.localPosition

				local var_31_7 = GameObjectTools.GetOrAddComponent(var_31_5.gameObject, typeof(DynamicBoneHelper))

				if var_31_7 then
					var_31_7:EnableDynamicBone(false)
				end
			end

			local var_31_8 = 0.001

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_6) / var_31_8
				local var_31_10 = Vector3.New(0, -0.75, -6.25)

				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1166ui_story, var_31_10, var_31_9)

				local var_31_11 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_11.x, var_31_11.y, var_31_11.z)

				local var_31_12 = var_31_5.localEulerAngles

				var_31_12.z = 0
				var_31_12.x = 0
				var_31_5.localEulerAngles = var_31_12
			end

			if arg_28_1.time_ >= var_31_6 + var_31_8 and arg_28_1.time_ < var_31_6 + var_31_8 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(0, -0.75, -6.25)

				local var_31_13 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_13.x, var_31_13.y, var_31_13.z)

				local var_31_14 = var_31_5.localEulerAngles

				var_31_14.z = 0
				var_31_14.x = 0
				var_31_5.localEulerAngles = var_31_14

				local var_31_15 = GameObjectTools.GetOrAddComponent(var_31_5.gameObject, typeof(DynamicBoneHelper))

				if var_31_15 then
					var_31_15:EnableDynamicBone(true)
				end
			end

			local var_31_16 = arg_28_1.actors_["1166ui_story"]
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect1166ui_story == nil then
				arg_28_1.var_.characterEffect1166ui_story = var_31_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_18 = 0.200000002980232

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_18 and not isNil(var_31_16) then
				local var_31_19 = (arg_28_1.time_ - var_31_17) / var_31_18

				if arg_28_1.var_.characterEffect1166ui_story and not isNil(var_31_16) then
					arg_28_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_17 + var_31_18 and arg_28_1.time_ < var_31_17 + var_31_18 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect1166ui_story then
				arg_28_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_31_20 = 0

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action4_1")
			end

			local var_31_21 = 0

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 then
				arg_28_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_31_22 = 0
			local var_31_23 = 0.2

			if var_31_22 < arg_28_1.time_ and arg_28_1.time_ <= var_31_22 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_24 = arg_28_1:FormatText(StoryNameCfg[32].name)

				arg_28_1.leftNameTxt_.text = var_31_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_25 = arg_28_1:GetWordFromCfg(302062007)
				local var_31_26 = arg_28_1:FormatText(var_31_25.content)

				arg_28_1.text_.text = var_31_26

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_27 = 8
				local var_31_28 = utf8.len(var_31_26)
				local var_31_29 = var_31_27 <= 0 and var_31_23 or var_31_23 * (var_31_28 / var_31_27)

				if var_31_29 > 0 and var_31_23 < var_31_29 then
					arg_28_1.talkMaxDuration = var_31_29

					if var_31_29 + var_31_22 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_29 + var_31_22
					end
				end

				arg_28_1.text_.text = var_31_26
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062007", "story_v_out_302062.awb") ~= 0 then
					local var_31_30 = manager.audio:GetVoiceLength("story_v_out_302062", "302062007", "story_v_out_302062.awb") / 1000

					if var_31_30 + var_31_22 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_30 + var_31_22
					end

					if var_31_25.prefab_name ~= "" and arg_28_1.actors_[var_31_25.prefab_name] ~= nil then
						local var_31_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_25.prefab_name].transform, "story_v_out_302062", "302062007", "story_v_out_302062.awb")

						arg_28_1:RecordAudio("302062007", var_31_31)
						arg_28_1:RecordAudio("302062007", var_31_31)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_302062", "302062007", "story_v_out_302062.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_302062", "302062007", "story_v_out_302062.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_32 = math.max(var_31_23, arg_28_1.talkMaxDuration)

			if var_31_22 <= arg_28_1.time_ and arg_28_1.time_ < var_31_22 + var_31_32 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_22) / var_31_32

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_22 + var_31_32 and arg_28_1.time_ < var_31_22 + var_31_32 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
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
	Play302062008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 302062008
		arg_32_1.duration_ = 4.63

		local var_32_0 = {
			zh = 4.633,
			ja = 1.333
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
				arg_32_0:Play302062009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.55

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[32].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(302062008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 22
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062008", "story_v_out_302062.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_302062", "302062008", "story_v_out_302062.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_302062", "302062008", "story_v_out_302062.awb")

						arg_32_1:RecordAudio("302062008", var_35_9)
						arg_32_1:RecordAudio("302062008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_302062", "302062008", "story_v_out_302062.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_302062", "302062008", "story_v_out_302062.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play302062009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 302062009
		arg_36_1.duration_ = 7.13

		local var_36_0 = {
			zh = 5.966,
			ja = 7.133
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
				arg_36_0:Play302062010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1084ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1084ui_story = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(0.7, -0.97, -6)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1084ui_story, var_39_4, var_39_3)

				local var_39_5 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_5.x, var_39_5.y, var_39_5.z)

				local var_39_6 = var_39_0.localEulerAngles

				var_39_6.z = 0
				var_39_6.x = 0
				var_39_0.localEulerAngles = var_39_6
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_39_7 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_7.x, var_39_7.y, var_39_7.z)

				local var_39_8 = var_39_0.localEulerAngles

				var_39_8.z = 0
				var_39_8.x = 0
				var_39_0.localEulerAngles = var_39_8
			end

			local var_39_9 = arg_36_1.actors_["1166ui_story"].transform
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.var_.moveOldPos1166ui_story = var_39_9.localPosition

				local var_39_11 = GameObjectTools.GetOrAddComponent(var_39_9.gameObject, typeof(DynamicBoneHelper))

				if var_39_11 then
					var_39_11:EnableDynamicBone(false)
				end
			end

			local var_39_12 = 0.001

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_12 then
				local var_39_13 = (arg_36_1.time_ - var_39_10) / var_39_12
				local var_39_14 = Vector3.New(-0.7, -0.75, -6.25)

				var_39_9.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1166ui_story, var_39_14, var_39_13)

				local var_39_15 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_15.x, var_39_15.y, var_39_15.z)

				local var_39_16 = var_39_9.localEulerAngles

				var_39_16.z = 0
				var_39_16.x = 0
				var_39_9.localEulerAngles = var_39_16
			end

			if arg_36_1.time_ >= var_39_10 + var_39_12 and arg_36_1.time_ < var_39_10 + var_39_12 + arg_39_0 then
				var_39_9.localPosition = Vector3.New(-0.7, -0.75, -6.25)

				local var_39_17 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_17.x, var_39_17.y, var_39_17.z)

				local var_39_18 = var_39_9.localEulerAngles

				var_39_18.z = 0
				var_39_18.x = 0
				var_39_9.localEulerAngles = var_39_18

				local var_39_19 = GameObjectTools.GetOrAddComponent(var_39_9.gameObject, typeof(DynamicBoneHelper))

				if var_39_19 then
					var_39_19:EnableDynamicBone(true)
				end
			end

			local var_39_20 = arg_36_1.actors_["1084ui_story"]
			local var_39_21 = 0

			if var_39_21 < arg_36_1.time_ and arg_36_1.time_ <= var_39_21 + arg_39_0 and not isNil(var_39_20) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_22 = 0.200000002980232

			if var_39_21 <= arg_36_1.time_ and arg_36_1.time_ < var_39_21 + var_39_22 and not isNil(var_39_20) then
				local var_39_23 = (arg_36_1.time_ - var_39_21) / var_39_22

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_20) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_21 + var_39_22 and arg_36_1.time_ < var_39_21 + var_39_22 + arg_39_0 and not isNil(var_39_20) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_39_24 = arg_36_1.actors_["1166ui_story"]
			local var_39_25 = 0

			if var_39_25 < arg_36_1.time_ and arg_36_1.time_ <= var_39_25 + arg_39_0 and not isNil(var_39_24) and arg_36_1.var_.characterEffect1166ui_story == nil then
				arg_36_1.var_.characterEffect1166ui_story = var_39_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_26 = 0.200000002980232

			if var_39_25 <= arg_36_1.time_ and arg_36_1.time_ < var_39_25 + var_39_26 and not isNil(var_39_24) then
				local var_39_27 = (arg_36_1.time_ - var_39_25) / var_39_26

				if arg_36_1.var_.characterEffect1166ui_story and not isNil(var_39_24) then
					local var_39_28 = Mathf.Lerp(0, 0.5, var_39_27)

					arg_36_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1166ui_story.fillRatio = var_39_28
				end
			end

			if arg_36_1.time_ >= var_39_25 + var_39_26 and arg_36_1.time_ < var_39_25 + var_39_26 + arg_39_0 and not isNil(var_39_24) and arg_36_1.var_.characterEffect1166ui_story then
				local var_39_29 = 0.5

				arg_36_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1166ui_story.fillRatio = var_39_29
			end

			local var_39_30 = 0

			if var_39_30 < arg_36_1.time_ and arg_36_1.time_ <= var_39_30 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_39_31 = 0

			if var_39_31 < arg_36_1.time_ and arg_36_1.time_ <= var_39_31 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_32 = 0
			local var_39_33 = 0.725

			if var_39_32 < arg_36_1.time_ and arg_36_1.time_ <= var_39_32 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_34 = arg_36_1:FormatText(StoryNameCfg[6].name)

				arg_36_1.leftNameTxt_.text = var_39_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_35 = arg_36_1:GetWordFromCfg(302062009)
				local var_39_36 = arg_36_1:FormatText(var_39_35.content)

				arg_36_1.text_.text = var_39_36

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_37 = 29
				local var_39_38 = utf8.len(var_39_36)
				local var_39_39 = var_39_37 <= 0 and var_39_33 or var_39_33 * (var_39_38 / var_39_37)

				if var_39_39 > 0 and var_39_33 < var_39_39 then
					arg_36_1.talkMaxDuration = var_39_39

					if var_39_39 + var_39_32 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_39 + var_39_32
					end
				end

				arg_36_1.text_.text = var_39_36
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062009", "story_v_out_302062.awb") ~= 0 then
					local var_39_40 = manager.audio:GetVoiceLength("story_v_out_302062", "302062009", "story_v_out_302062.awb") / 1000

					if var_39_40 + var_39_32 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_40 + var_39_32
					end

					if var_39_35.prefab_name ~= "" and arg_36_1.actors_[var_39_35.prefab_name] ~= nil then
						local var_39_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_35.prefab_name].transform, "story_v_out_302062", "302062009", "story_v_out_302062.awb")

						arg_36_1:RecordAudio("302062009", var_39_41)
						arg_36_1:RecordAudio("302062009", var_39_41)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_302062", "302062009", "story_v_out_302062.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_302062", "302062009", "story_v_out_302062.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_42 = math.max(var_39_33, arg_36_1.talkMaxDuration)

			if var_39_32 <= arg_36_1.time_ and arg_36_1.time_ < var_39_32 + var_39_42 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_32) / var_39_42

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_32 + var_39_42 and arg_36_1.time_ < var_39_32 + var_39_42 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play302062010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 302062010
		arg_40_1.duration_ = 6.63

		local var_40_0 = {
			zh = 5.1,
			ja = 6.633
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
				arg_40_0:Play302062011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_2 = 0
			local var_43_3 = 0.7

			if var_43_2 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_4 = arg_40_1:FormatText(StoryNameCfg[6].name)

				arg_40_1.leftNameTxt_.text = var_43_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_5 = arg_40_1:GetWordFromCfg(302062010)
				local var_43_6 = arg_40_1:FormatText(var_43_5.content)

				arg_40_1.text_.text = var_43_6

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 28
				local var_43_8 = utf8.len(var_43_6)
				local var_43_9 = var_43_7 <= 0 and var_43_3 or var_43_3 * (var_43_8 / var_43_7)

				if var_43_9 > 0 and var_43_3 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_2
					end
				end

				arg_40_1.text_.text = var_43_6
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062010", "story_v_out_302062.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_302062", "302062010", "story_v_out_302062.awb") / 1000

					if var_43_10 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_2
					end

					if var_43_5.prefab_name ~= "" and arg_40_1.actors_[var_43_5.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_5.prefab_name].transform, "story_v_out_302062", "302062010", "story_v_out_302062.awb")

						arg_40_1:RecordAudio("302062010", var_43_11)
						arg_40_1:RecordAudio("302062010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_302062", "302062010", "story_v_out_302062.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_302062", "302062010", "story_v_out_302062.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_3, arg_40_1.talkMaxDuration)

			if var_43_2 <= arg_40_1.time_ and arg_40_1.time_ < var_43_2 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_2) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_2 + var_43_12 and arg_40_1.time_ < var_43_2 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play302062011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 302062011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play302062012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1084ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, 100, 0)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, 100, 0)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["1166ui_story"].transform
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1.var_.moveOldPos1166ui_story = var_47_9.localPosition

				local var_47_11 = GameObjectTools.GetOrAddComponent(var_47_9.gameObject, typeof(DynamicBoneHelper))

				if var_47_11 then
					var_47_11:EnableDynamicBone(false)
				end
			end

			local var_47_12 = 0.001

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_12 then
				local var_47_13 = (arg_44_1.time_ - var_47_10) / var_47_12
				local var_47_14 = Vector3.New(0, 100, 0)

				var_47_9.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1166ui_story, var_47_14, var_47_13)

				local var_47_15 = manager.ui.mainCamera.transform.position - var_47_9.position

				var_47_9.forward = Vector3.New(var_47_15.x, var_47_15.y, var_47_15.z)

				local var_47_16 = var_47_9.localEulerAngles

				var_47_16.z = 0
				var_47_16.x = 0
				var_47_9.localEulerAngles = var_47_16
			end

			if arg_44_1.time_ >= var_47_10 + var_47_12 and arg_44_1.time_ < var_47_10 + var_47_12 + arg_47_0 then
				var_47_9.localPosition = Vector3.New(0, 100, 0)

				local var_47_17 = manager.ui.mainCamera.transform.position - var_47_9.position

				var_47_9.forward = Vector3.New(var_47_17.x, var_47_17.y, var_47_17.z)

				local var_47_18 = var_47_9.localEulerAngles

				var_47_18.z = 0
				var_47_18.x = 0
				var_47_9.localEulerAngles = var_47_18

				local var_47_19 = GameObjectTools.GetOrAddComponent(var_47_9.gameObject, typeof(DynamicBoneHelper))

				if var_47_19 then
					var_47_19:EnableDynamicBone(true)
				end
			end

			local var_47_20 = arg_44_1.actors_["1084ui_story"]
			local var_47_21 = 0

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 and not isNil(var_47_20) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_22 = 0.200000002980232

			if var_47_21 <= arg_44_1.time_ and arg_44_1.time_ < var_47_21 + var_47_22 and not isNil(var_47_20) then
				local var_47_23 = (arg_44_1.time_ - var_47_21) / var_47_22

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_20) then
					local var_47_24 = Mathf.Lerp(0, 0.5, var_47_23)

					arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1084ui_story.fillRatio = var_47_24
				end
			end

			if arg_44_1.time_ >= var_47_21 + var_47_22 and arg_44_1.time_ < var_47_21 + var_47_22 + arg_47_0 and not isNil(var_47_20) and arg_44_1.var_.characterEffect1084ui_story then
				local var_47_25 = 0.5

				arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1084ui_story.fillRatio = var_47_25
			end

			local var_47_26 = 0
			local var_47_27 = 1

			if var_47_26 < arg_44_1.time_ and arg_44_1.time_ <= var_47_26 + arg_47_0 then
				local var_47_28 = "play"
				local var_47_29 = "effect"

				arg_44_1:AudioAction(var_47_28, var_47_29, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_47_30 = 0
			local var_47_31 = 1.35

			if var_47_30 < arg_44_1.time_ and arg_44_1.time_ <= var_47_30 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_32 = arg_44_1:GetWordFromCfg(302062011)
				local var_47_33 = arg_44_1:FormatText(var_47_32.content)

				arg_44_1.text_.text = var_47_33

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_34 = 54
				local var_47_35 = utf8.len(var_47_33)
				local var_47_36 = var_47_34 <= 0 and var_47_31 or var_47_31 * (var_47_35 / var_47_34)

				if var_47_36 > 0 and var_47_31 < var_47_36 then
					arg_44_1.talkMaxDuration = var_47_36

					if var_47_36 + var_47_30 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_36 + var_47_30
					end
				end

				arg_44_1.text_.text = var_47_33
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_37 = math.max(var_47_31, arg_44_1.talkMaxDuration)

			if var_47_30 <= arg_44_1.time_ and arg_44_1.time_ < var_47_30 + var_47_37 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_30) / var_47_37

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_30 + var_47_37 and arg_44_1.time_ < var_47_30 + var_47_37 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play302062012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 302062012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play302062013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1.675

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(302062012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 67
				local var_51_5 = utf8.len(var_51_3)
				local var_51_6 = var_51_4 <= 0 and var_51_1 or var_51_1 * (var_51_5 / var_51_4)

				if var_51_6 > 0 and var_51_1 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_7 and arg_48_1.time_ < var_51_0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play302062013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 302062013
		arg_52_1.duration_ = 2.03

		local var_52_0 = {
			zh = 1.999999999999,
			ja = 2.033
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
				arg_52_0:Play302062014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1084ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1084ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, -0.97, -6)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1084ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = arg_52_1.actors_["1084ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.200000002980232

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_9) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_55_13 = 0

			if var_55_13 < arg_52_1.time_ and arg_52_1.time_ <= var_55_13 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_55_14 = 0

			if var_55_14 < arg_52_1.time_ and arg_52_1.time_ <= var_55_14 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_55_15 = 0
			local var_55_16 = 0.05

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_17 = arg_52_1:FormatText(StoryNameCfg[6].name)

				arg_52_1.leftNameTxt_.text = var_55_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_18 = arg_52_1:GetWordFromCfg(302062013)
				local var_55_19 = arg_52_1:FormatText(var_55_18.content)

				arg_52_1.text_.text = var_55_19

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_20 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062013", "story_v_out_302062.awb") ~= 0 then
					local var_55_23 = manager.audio:GetVoiceLength("story_v_out_302062", "302062013", "story_v_out_302062.awb") / 1000

					if var_55_23 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_15
					end

					if var_55_18.prefab_name ~= "" and arg_52_1.actors_[var_55_18.prefab_name] ~= nil then
						local var_55_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_18.prefab_name].transform, "story_v_out_302062", "302062013", "story_v_out_302062.awb")

						arg_52_1:RecordAudio("302062013", var_55_24)
						arg_52_1:RecordAudio("302062013", var_55_24)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_302062", "302062013", "story_v_out_302062.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_302062", "302062013", "story_v_out_302062.awb")
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
	Play302062014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 302062014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play302062015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1084ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, 100, 0)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, var_59_4, var_59_3)

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

			local var_59_9 = arg_56_1.actors_["1084ui_story"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_9) then
					local var_59_13 = Mathf.Lerp(0, 0.5, var_59_12)

					arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1084ui_story.fillRatio = var_59_13
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1084ui_story then
				local var_59_14 = 0.5

				arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1084ui_story.fillRatio = var_59_14
			end

			local var_59_15 = 0
			local var_59_16 = 1.475

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_17 = arg_56_1:GetWordFromCfg(302062014)
				local var_59_18 = arg_56_1:FormatText(var_59_17.content)

				arg_56_1.text_.text = var_59_18

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_19 = 59
				local var_59_20 = utf8.len(var_59_18)
				local var_59_21 = var_59_19 <= 0 and var_59_16 or var_59_16 * (var_59_20 / var_59_19)

				if var_59_21 > 0 and var_59_16 < var_59_21 then
					arg_56_1.talkMaxDuration = var_59_21

					if var_59_21 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_21 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_18
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_22 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_22 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_22

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_22 and arg_56_1.time_ < var_59_15 + var_59_22 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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
	Play302062015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 302062015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play302062016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.325

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(302062015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 13
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_8 and arg_60_1.time_ < var_63_0 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play302062016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 302062016
		arg_64_1.duration_ = 10.8

		local var_64_0 = {
			zh = 10.8,
			ja = 9.166
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play302062017(arg_64_1)
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
				local var_67_4 = Vector3.New(0, -0.97, -6)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1084ui_story"]
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_11 = 0.200000002980232

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 and not isNil(var_67_9) then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11

				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_9) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_67_13 = 0

			if var_67_13 < arg_64_1.time_ and arg_64_1.time_ <= var_67_13 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_67_14 = 0

			if var_67_14 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_15 = 0
			local var_67_16 = 0.975

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_17 = arg_64_1:FormatText(StoryNameCfg[6].name)

				arg_64_1.leftNameTxt_.text = var_67_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_18 = arg_64_1:GetWordFromCfg(302062016)
				local var_67_19 = arg_64_1:FormatText(var_67_18.content)

				arg_64_1.text_.text = var_67_19

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_20 = 39
				local var_67_21 = utf8.len(var_67_19)
				local var_67_22 = var_67_20 <= 0 and var_67_16 or var_67_16 * (var_67_21 / var_67_20)

				if var_67_22 > 0 and var_67_16 < var_67_22 then
					arg_64_1.talkMaxDuration = var_67_22

					if var_67_22 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_22 + var_67_15
					end
				end

				arg_64_1.text_.text = var_67_19
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062016", "story_v_out_302062.awb") ~= 0 then
					local var_67_23 = manager.audio:GetVoiceLength("story_v_out_302062", "302062016", "story_v_out_302062.awb") / 1000

					if var_67_23 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_15
					end

					if var_67_18.prefab_name ~= "" and arg_64_1.actors_[var_67_18.prefab_name] ~= nil then
						local var_67_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_18.prefab_name].transform, "story_v_out_302062", "302062016", "story_v_out_302062.awb")

						arg_64_1:RecordAudio("302062016", var_67_24)
						arg_64_1:RecordAudio("302062016", var_67_24)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_302062", "302062016", "story_v_out_302062.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_302062", "302062016", "story_v_out_302062.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_25 = math.max(var_67_16, arg_64_1.talkMaxDuration)

			if var_67_15 <= arg_64_1.time_ and arg_64_1.time_ < var_67_15 + var_67_25 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_15) / var_67_25

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_15 + var_67_25 and arg_64_1.time_ < var_67_15 + var_67_25 + arg_67_0 then
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
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play302062017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 302062017
		arg_68_1.duration_ = 3.2

		local var_68_0 = {
			zh = 3.2,
			ja = 2.4
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
				arg_68_0:Play302062018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_71_1 = 0
			local var_71_2 = 0.175

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_3 = arg_68_1:FormatText(StoryNameCfg[6].name)

				arg_68_1.leftNameTxt_.text = var_71_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:GetWordFromCfg(302062017)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_6 = 7
				local var_71_7 = utf8.len(var_71_5)
				local var_71_8 = var_71_6 <= 0 and var_71_2 or var_71_2 * (var_71_7 / var_71_6)

				if var_71_8 > 0 and var_71_2 < var_71_8 then
					arg_68_1.talkMaxDuration = var_71_8

					if var_71_8 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062017", "story_v_out_302062.awb") ~= 0 then
					local var_71_9 = manager.audio:GetVoiceLength("story_v_out_302062", "302062017", "story_v_out_302062.awb") / 1000

					if var_71_9 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_1
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_out_302062", "302062017", "story_v_out_302062.awb")

						arg_68_1:RecordAudio("302062017", var_71_10)
						arg_68_1:RecordAudio("302062017", var_71_10)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_302062", "302062017", "story_v_out_302062.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_302062", "302062017", "story_v_out_302062.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_11 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_11 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_11

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_11 and arg_68_1.time_ < var_71_1 + var_71_11 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play302062018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 302062018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play302062019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1084ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_0.localPosition
			end

			local var_75_2 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2
				local var_75_4 = Vector3.New(0, 100, 0)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, var_75_4, var_75_3)

				local var_75_5 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_5.x, var_75_5.y, var_75_5.z)

				local var_75_6 = var_75_0.localEulerAngles

				var_75_6.z = 0
				var_75_6.x = 0
				var_75_0.localEulerAngles = var_75_6
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, 100, 0)

				local var_75_7 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_7.x, var_75_7.y, var_75_7.z)

				local var_75_8 = var_75_0.localEulerAngles

				var_75_8.z = 0
				var_75_8.x = 0
				var_75_0.localEulerAngles = var_75_8
			end

			local var_75_9 = arg_72_1.actors_["1084ui_story"]
			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_11 = 0.200000002980232

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_11 and not isNil(var_75_9) then
				local var_75_12 = (arg_72_1.time_ - var_75_10) / var_75_11

				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_9) then
					local var_75_13 = Mathf.Lerp(0, 0.5, var_75_12)

					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_13
				end
			end

			if arg_72_1.time_ >= var_75_10 + var_75_11 and arg_72_1.time_ < var_75_10 + var_75_11 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1084ui_story then
				local var_75_14 = 0.5

				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_14
			end

			local var_75_15 = 0
			local var_75_16 = 0.975

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_17 = arg_72_1:GetWordFromCfg(302062018)
				local var_75_18 = arg_72_1:FormatText(var_75_17.content)

				arg_72_1.text_.text = var_75_18

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_19 = 39
				local var_75_20 = utf8.len(var_75_18)
				local var_75_21 = var_75_19 <= 0 and var_75_16 or var_75_16 * (var_75_20 / var_75_19)

				if var_75_21 > 0 and var_75_16 < var_75_21 then
					arg_72_1.talkMaxDuration = var_75_21

					if var_75_21 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_21 + var_75_15
					end
				end

				arg_72_1.text_.text = var_75_18
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_22 = math.max(var_75_16, arg_72_1.talkMaxDuration)

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_22 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_15) / var_75_22

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_15 + var_75_22 and arg_72_1.time_ < var_75_15 + var_75_22 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play302062019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 302062019
		arg_76_1.duration_ = 4.13

		local var_76_0 = {
			zh = 2.366666666666,
			ja = 4.133
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
				arg_76_0:Play302062020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = manager.ui.mainCamera.transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				local var_79_2 = arg_76_1.var_.effectkepaniuqu1
				local var_79_3
				local var_79_4 = var_79_0

				if not var_79_2 then
					var_79_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_79_4)
					var_79_2.name = "kepaniuqu1"
					arg_76_1.var_.effectkepaniuqu1 = var_79_2
				else
					var_79_2.transform:SetParent(var_79_4)
				end

				var_79_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_79_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_79_5 = manager.ui.mainCamera.transform
			local var_79_6 = 2.26666666666667

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				local var_79_7 = arg_76_1.var_.effectkepaniuqu1

				if var_79_7 then
					Object.Destroy(var_79_7)

					arg_76_1.var_.effectkepaniuqu1 = nil
				end
			end

			local var_79_8 = 0

			if var_79_8 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.allBtn_.enabled = false
			end

			local var_79_9 = 0.8

			if arg_76_1.time_ >= var_79_8 + var_79_9 and arg_76_1.time_ < var_79_8 + var_79_9 + arg_79_0 then
				arg_76_1.allBtn_.enabled = true
			end

			local var_79_10 = 1
			local var_79_11 = 1

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				local var_79_12 = "play"
				local var_79_13 = "music"

				arg_76_1:AudioAction(var_79_12, var_79_13, "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous.awb")

				local var_79_14 = ""
				local var_79_15 = manager.audio:GetAudioName("bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous")

				if var_79_15 ~= "" then
					if arg_76_1.bgmTxt_.text ~= var_79_15 and arg_76_1.bgmTxt_.text ~= "" then
						if arg_76_1.bgmTxt2_.text ~= "" then
							arg_76_1.bgmTxt_.text = arg_76_1.bgmTxt2_.text
						end

						arg_76_1.bgmTxt2_.text = var_79_15

						arg_76_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_76_1.bgmTxt_.text = var_79_15
						arg_76_1.bgmTxt2_.text = var_79_15
					end

					if arg_76_1.bgmTimer then
						arg_76_1.bgmTimer:Stop()

						arg_76_1.bgmTimer = nil
					end

					if arg_76_1.settingData.show_music_name == 1 then
						arg_76_1.musicController:SetSelectedState("show")
						arg_76_1.musicAnimator_:Play("open", 0, 0)

						if arg_76_1.settingData.music_time ~= 0 then
							arg_76_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_76_1.settingData.music_time), function()
								if arg_76_1 == nil or isNil(arg_76_1.bgmTxt_) then
									return
								end

								arg_76_1.musicController:SetSelectedState("hide")
								arg_76_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_16 = 0.8
			local var_79_17 = 0.2

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_18 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_18:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_76_1.dialogCg_.alpha = arg_81_0
				end))
				var_79_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_19 = arg_76_1:FormatText(StoryNameCfg[36].name)

				arg_76_1.leftNameTxt_.text = var_79_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_20 = arg_76_1:GetWordFromCfg(302062019)
				local var_79_21 = arg_76_1:FormatText(var_79_20.content)

				arg_76_1.text_.text = var_79_21

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_22 = 8
				local var_79_23 = utf8.len(var_79_21)
				local var_79_24 = var_79_22 <= 0 and var_79_17 or var_79_17 * (var_79_23 / var_79_22)

				if var_79_24 > 0 and var_79_17 < var_79_24 then
					arg_76_1.talkMaxDuration = var_79_24
					var_79_16 = var_79_16 + 0.3

					if var_79_24 + var_79_16 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_24 + var_79_16
					end
				end

				arg_76_1.text_.text = var_79_21
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062019", "story_v_out_302062.awb") ~= 0 then
					local var_79_25 = manager.audio:GetVoiceLength("story_v_out_302062", "302062019", "story_v_out_302062.awb") / 1000

					if var_79_25 + var_79_16 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_25 + var_79_16
					end

					if var_79_20.prefab_name ~= "" and arg_76_1.actors_[var_79_20.prefab_name] ~= nil then
						local var_79_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_20.prefab_name].transform, "story_v_out_302062", "302062019", "story_v_out_302062.awb")

						arg_76_1:RecordAudio("302062019", var_79_26)
						arg_76_1:RecordAudio("302062019", var_79_26)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_302062", "302062019", "story_v_out_302062.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_302062", "302062019", "story_v_out_302062.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_27 = var_79_16 + 0.3
			local var_79_28 = math.max(var_79_17, arg_76_1.talkMaxDuration)

			if var_79_27 <= arg_76_1.time_ and arg_76_1.time_ < var_79_27 + var_79_28 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_27) / var_79_28

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_27 + var_79_28 and arg_76_1.time_ < var_79_27 + var_79_28 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play302062020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 302062020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play302062021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 1.075

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

				local var_86_2 = arg_83_1:GetWordFromCfg(302062020)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 43
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
	Play302062021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 302062021
		arg_87_1.duration_ = 2

		local var_87_0 = {
			zh = 2,
			ja = 1.999999999999
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
				arg_87_0:Play302062022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1166ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1166ui_story = var_90_0.localPosition

				local var_90_2 = GameObjectTools.GetOrAddComponent(var_90_0.gameObject, typeof(DynamicBoneHelper))

				if var_90_2 then
					var_90_2:EnableDynamicBone(false)
				end
			end

			local var_90_3 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_3 then
				local var_90_4 = (arg_87_1.time_ - var_90_1) / var_90_3
				local var_90_5 = Vector3.New(0, -0.75, -6.25)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1166ui_story, var_90_5, var_90_4)

				local var_90_6 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_6.x, var_90_6.y, var_90_6.z)

				local var_90_7 = var_90_0.localEulerAngles

				var_90_7.z = 0
				var_90_7.x = 0
				var_90_0.localEulerAngles = var_90_7
			end

			if arg_87_1.time_ >= var_90_1 + var_90_3 and arg_87_1.time_ < var_90_1 + var_90_3 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -0.75, -6.25)

				local var_90_8 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_8.x, var_90_8.y, var_90_8.z)

				local var_90_9 = var_90_0.localEulerAngles

				var_90_9.z = 0
				var_90_9.x = 0
				var_90_0.localEulerAngles = var_90_9

				local var_90_10 = GameObjectTools.GetOrAddComponent(var_90_0.gameObject, typeof(DynamicBoneHelper))

				if var_90_10 then
					var_90_10:EnableDynamicBone(true)
				end
			end

			local var_90_11 = arg_87_1.actors_["1166ui_story"]
			local var_90_12 = 0

			if var_90_12 < arg_87_1.time_ and arg_87_1.time_ <= var_90_12 + arg_90_0 and not isNil(var_90_11) and arg_87_1.var_.characterEffect1166ui_story == nil then
				arg_87_1.var_.characterEffect1166ui_story = var_90_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_13 = 0.200000002980232

			if var_90_12 <= arg_87_1.time_ and arg_87_1.time_ < var_90_12 + var_90_13 and not isNil(var_90_11) then
				local var_90_14 = (arg_87_1.time_ - var_90_12) / var_90_13

				if arg_87_1.var_.characterEffect1166ui_story and not isNil(var_90_11) then
					arg_87_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_12 + var_90_13 and arg_87_1.time_ < var_90_12 + var_90_13 + arg_90_0 and not isNil(var_90_11) and arg_87_1.var_.characterEffect1166ui_story then
				arg_87_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_90_15 = 0

			if var_90_15 < arg_87_1.time_ and arg_87_1.time_ <= var_90_15 + arg_90_0 then
				arg_87_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action4_1")
			end

			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_90_17 = 0
			local var_90_18 = 0.225

			if var_90_17 < arg_87_1.time_ and arg_87_1.time_ <= var_90_17 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_19 = arg_87_1:FormatText(StoryNameCfg[32].name)

				arg_87_1.leftNameTxt_.text = var_90_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_20 = arg_87_1:GetWordFromCfg(302062021)
				local var_90_21 = arg_87_1:FormatText(var_90_20.content)

				arg_87_1.text_.text = var_90_21

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_22 = 9
				local var_90_23 = utf8.len(var_90_21)
				local var_90_24 = var_90_22 <= 0 and var_90_18 or var_90_18 * (var_90_23 / var_90_22)

				if var_90_24 > 0 and var_90_18 < var_90_24 then
					arg_87_1.talkMaxDuration = var_90_24

					if var_90_24 + var_90_17 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_24 + var_90_17
					end
				end

				arg_87_1.text_.text = var_90_21
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062021", "story_v_out_302062.awb") ~= 0 then
					local var_90_25 = manager.audio:GetVoiceLength("story_v_out_302062", "302062021", "story_v_out_302062.awb") / 1000

					if var_90_25 + var_90_17 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_25 + var_90_17
					end

					if var_90_20.prefab_name ~= "" and arg_87_1.actors_[var_90_20.prefab_name] ~= nil then
						local var_90_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_20.prefab_name].transform, "story_v_out_302062", "302062021", "story_v_out_302062.awb")

						arg_87_1:RecordAudio("302062021", var_90_26)
						arg_87_1:RecordAudio("302062021", var_90_26)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_302062", "302062021", "story_v_out_302062.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_302062", "302062021", "story_v_out_302062.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_27 = math.max(var_90_18, arg_87_1.talkMaxDuration)

			if var_90_17 <= arg_87_1.time_ and arg_87_1.time_ < var_90_17 + var_90_27 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_17) / var_90_27

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_17 + var_90_27 and arg_87_1.time_ < var_90_17 + var_90_27 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
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
	Play302062022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 302062022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play302062023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1166ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1166ui_story = var_94_0.localPosition

				local var_94_2 = GameObjectTools.GetOrAddComponent(var_94_0.gameObject, typeof(DynamicBoneHelper))

				if var_94_2 then
					var_94_2:EnableDynamicBone(false)
				end
			end

			local var_94_3 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_3 then
				local var_94_4 = (arg_91_1.time_ - var_94_1) / var_94_3
				local var_94_5 = Vector3.New(0, 100, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1166ui_story, var_94_5, var_94_4)

				local var_94_6 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_6.x, var_94_6.y, var_94_6.z)

				local var_94_7 = var_94_0.localEulerAngles

				var_94_7.z = 0
				var_94_7.x = 0
				var_94_0.localEulerAngles = var_94_7
			end

			if arg_91_1.time_ >= var_94_1 + var_94_3 and arg_91_1.time_ < var_94_1 + var_94_3 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, 100, 0)

				local var_94_8 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_8.x, var_94_8.y, var_94_8.z)

				local var_94_9 = var_94_0.localEulerAngles

				var_94_9.z = 0
				var_94_9.x = 0
				var_94_0.localEulerAngles = var_94_9

				local var_94_10 = GameObjectTools.GetOrAddComponent(var_94_0.gameObject, typeof(DynamicBoneHelper))

				if var_94_10 then
					var_94_10:EnableDynamicBone(true)
				end
			end

			local var_94_11 = arg_91_1.actors_["1166ui_story"]
			local var_94_12 = 0

			if var_94_12 < arg_91_1.time_ and arg_91_1.time_ <= var_94_12 + arg_94_0 and not isNil(var_94_11) and arg_91_1.var_.characterEffect1166ui_story == nil then
				arg_91_1.var_.characterEffect1166ui_story = var_94_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_13 = 0.200000002980232

			if var_94_12 <= arg_91_1.time_ and arg_91_1.time_ < var_94_12 + var_94_13 and not isNil(var_94_11) then
				local var_94_14 = (arg_91_1.time_ - var_94_12) / var_94_13

				if arg_91_1.var_.characterEffect1166ui_story and not isNil(var_94_11) then
					local var_94_15 = Mathf.Lerp(0, 0.5, var_94_14)

					arg_91_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1166ui_story.fillRatio = var_94_15
				end
			end

			if arg_91_1.time_ >= var_94_12 + var_94_13 and arg_91_1.time_ < var_94_12 + var_94_13 + arg_94_0 and not isNil(var_94_11) and arg_91_1.var_.characterEffect1166ui_story then
				local var_94_16 = 0.5

				arg_91_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1166ui_story.fillRatio = var_94_16
			end

			local var_94_17 = 0
			local var_94_18 = 0.725

			if var_94_17 < arg_91_1.time_ and arg_91_1.time_ <= var_94_17 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_19 = arg_91_1:GetWordFromCfg(302062022)
				local var_94_20 = arg_91_1:FormatText(var_94_19.content)

				arg_91_1.text_.text = var_94_20

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_21 = 29
				local var_94_22 = utf8.len(var_94_20)
				local var_94_23 = var_94_21 <= 0 and var_94_18 or var_94_18 * (var_94_22 / var_94_21)

				if var_94_23 > 0 and var_94_18 < var_94_23 then
					arg_91_1.talkMaxDuration = var_94_23

					if var_94_23 + var_94_17 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_23 + var_94_17
					end
				end

				arg_91_1.text_.text = var_94_20
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_24 = math.max(var_94_18, arg_91_1.talkMaxDuration)

			if var_94_17 <= arg_91_1.time_ and arg_91_1.time_ < var_94_17 + var_94_24 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_17) / var_94_24

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_17 + var_94_24 and arg_91_1.time_ < var_94_17 + var_94_24 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
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
	Play302062023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 302062023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play302062024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.2
			local var_98_1 = 1

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				local var_98_2 = "play"
				local var_98_3 = "effect"

				arg_95_1:AudioAction(var_98_2, var_98_3, "se_story_138", "se_story_138_boomtimer_loop02", "")
			end

			local var_98_4 = 0
			local var_98_5 = 1.25

			if var_98_4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(302062023)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_8 = 50
				local var_98_9 = utf8.len(var_98_7)
				local var_98_10 = var_98_8 <= 0 and var_98_5 or var_98_5 * (var_98_9 / var_98_8)

				if var_98_10 > 0 and var_98_5 < var_98_10 then
					arg_95_1.talkMaxDuration = var_98_10

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_11 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_11 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_11

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_11 and arg_95_1.time_ < var_98_4 + var_98_11 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play302062024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 302062024
		arg_99_1.duration_ = 1.33

		local var_99_0 = {
			zh = 1.3,
			ja = 1.333
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
				arg_99_0:Play302062025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = manager.ui.mainCamera.transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.shakeOldPos = var_102_0.localPosition
			end

			local var_102_2 = 0.6

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / 0.066
				local var_102_4, var_102_5 = math.modf(var_102_3)

				var_102_0.localPosition = Vector3.New(var_102_5 * 0.13, var_102_5 * 0.13, var_102_5 * 0.13) + arg_99_1.var_.shakeOldPos
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = arg_99_1.var_.shakeOldPos
			end

			local var_102_6 = 0

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.allBtn_.enabled = false
			end

			local var_102_7 = 0.6

			if arg_99_1.time_ >= var_102_6 + var_102_7 and arg_99_1.time_ < var_102_6 + var_102_7 + arg_102_0 then
				arg_99_1.allBtn_.enabled = true
			end

			local var_102_8 = 0
			local var_102_9 = 0.075

			if var_102_8 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_10 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_10:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_11 = arg_99_1:FormatText(StoryNameCfg[32].name)

				arg_99_1.leftNameTxt_.text = var_102_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1166")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_12 = arg_99_1:GetWordFromCfg(302062024)
				local var_102_13 = arg_99_1:FormatText(var_102_12.content)

				arg_99_1.text_.text = var_102_13

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_14 = 3
				local var_102_15 = utf8.len(var_102_13)
				local var_102_16 = var_102_14 <= 0 and var_102_9 or var_102_9 * (var_102_15 / var_102_14)

				if var_102_16 > 0 and var_102_9 < var_102_16 then
					arg_99_1.talkMaxDuration = var_102_16
					var_102_8 = var_102_8 + 0.3

					if var_102_16 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_16 + var_102_8
					end
				end

				arg_99_1.text_.text = var_102_13
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302062", "302062024", "story_v_out_302062.awb") ~= 0 then
					local var_102_17 = manager.audio:GetVoiceLength("story_v_out_302062", "302062024", "story_v_out_302062.awb") / 1000

					if var_102_17 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_17 + var_102_8
					end

					if var_102_12.prefab_name ~= "" and arg_99_1.actors_[var_102_12.prefab_name] ~= nil then
						local var_102_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_12.prefab_name].transform, "story_v_out_302062", "302062024", "story_v_out_302062.awb")

						arg_99_1:RecordAudio("302062024", var_102_18)
						arg_99_1:RecordAudio("302062024", var_102_18)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_302062", "302062024", "story_v_out_302062.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_302062", "302062024", "story_v_out_302062.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_19 = var_102_8 + 0.3
			local var_102_20 = math.max(var_102_9, arg_99_1.talkMaxDuration)

			if var_102_19 <= arg_99_1.time_ and arg_99_1.time_ < var_102_19 + var_102_20 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_19) / var_102_20

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_19 + var_102_20 and arg_99_1.time_ < var_102_19 + var_102_20 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play302062025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 302062025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play302062026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1166ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1166ui_story = var_108_0.localPosition

				local var_108_2 = GameObjectTools.GetOrAddComponent(var_108_0.gameObject, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(false)
				end
			end

			local var_108_3 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_3 then
				local var_108_4 = (arg_105_1.time_ - var_108_1) / var_108_3
				local var_108_5 = Vector3.New(0, 100, 0)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1166ui_story, var_108_5, var_108_4)

				local var_108_6 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_6.x, var_108_6.y, var_108_6.z)

				local var_108_7 = var_108_0.localEulerAngles

				var_108_7.z = 0
				var_108_7.x = 0
				var_108_0.localEulerAngles = var_108_7
			end

			if arg_105_1.time_ >= var_108_1 + var_108_3 and arg_105_1.time_ < var_108_1 + var_108_3 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, 100, 0)

				local var_108_8 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_8.x, var_108_8.y, var_108_8.z)

				local var_108_9 = var_108_0.localEulerAngles

				var_108_9.z = 0
				var_108_9.x = 0
				var_108_0.localEulerAngles = var_108_9

				local var_108_10 = GameObjectTools.GetOrAddComponent(var_108_0.gameObject, typeof(DynamicBoneHelper))

				if var_108_10 then
					var_108_10:EnableDynamicBone(true)
				end
			end

			local var_108_11 = arg_105_1.actors_["1166ui_story"]
			local var_108_12 = 0

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 and not isNil(var_108_11) and arg_105_1.var_.characterEffect1166ui_story == nil then
				arg_105_1.var_.characterEffect1166ui_story = var_108_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_13 = 0.200000002980232

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_13 and not isNil(var_108_11) then
				local var_108_14 = (arg_105_1.time_ - var_108_12) / var_108_13

				if arg_105_1.var_.characterEffect1166ui_story and not isNil(var_108_11) then
					local var_108_15 = Mathf.Lerp(0, 0.5, var_108_14)

					arg_105_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1166ui_story.fillRatio = var_108_15
				end
			end

			if arg_105_1.time_ >= var_108_12 + var_108_13 and arg_105_1.time_ < var_108_12 + var_108_13 + arg_108_0 and not isNil(var_108_11) and arg_105_1.var_.characterEffect1166ui_story then
				local var_108_16 = 0.5

				arg_105_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1166ui_story.fillRatio = var_108_16
			end

			local var_108_17 = manager.ui.mainCamera.transform
			local var_108_18 = 0

			if var_108_18 < arg_105_1.time_ and arg_105_1.time_ <= var_108_18 + arg_108_0 then
				local var_108_19 = arg_105_1.var_.effectbaozhu1
				local var_108_20
				local var_108_21 = var_108_17

				if not var_108_19 then
					var_108_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heimu_keep"), var_108_21)
					var_108_19.name = "baozhu1"
					arg_105_1.var_.effectbaozhu1 = var_108_19
				else
					var_108_19.transform:SetParent(var_108_21)
				end

				var_108_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_108_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_108_22 = 0.2
			local var_108_23 = 1

			if var_108_22 < arg_105_1.time_ and arg_105_1.time_ <= var_108_22 + arg_108_0 then
				local var_108_24 = "play"
				local var_108_25 = "effect"

				arg_105_1:AudioAction(var_108_24, var_108_25, "se_story_1310", "se_story_1310_rush", "")
			end

			local var_108_26 = 0
			local var_108_27 = 1.375

			if var_108_26 < arg_105_1.time_ and arg_105_1.time_ <= var_108_26 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_28 = arg_105_1:GetWordFromCfg(302062025)
				local var_108_29 = arg_105_1:FormatText(var_108_28.content)

				arg_105_1.text_.text = var_108_29

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_30 = 55
				local var_108_31 = utf8.len(var_108_29)
				local var_108_32 = var_108_30 <= 0 and var_108_27 or var_108_27 * (var_108_31 / var_108_30)

				if var_108_32 > 0 and var_108_27 < var_108_32 then
					arg_105_1.talkMaxDuration = var_108_32

					if var_108_32 + var_108_26 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_32 + var_108_26
					end
				end

				arg_105_1.text_.text = var_108_29
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_33 = math.max(var_108_27, arg_105_1.talkMaxDuration)

			if var_108_26 <= arg_105_1.time_ and arg_105_1.time_ < var_108_26 + var_108_33 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_26) / var_108_33

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_26 + var_108_33 and arg_105_1.time_ < var_108_26 + var_108_33 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play302062026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 302062026
		arg_109_1.duration_ = 5.62

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
			arg_109_1.auto_ = false
		end

		function arg_109_1.playNext_(arg_111_0)
			arg_109_1.onStoryFinished_()
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = manager.ui.mainCamera.transform
			local var_112_1 = 0.375

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				local var_112_2 = arg_109_1.var_.effectbaozhu1

				if var_112_2 then
					Object.Destroy(var_112_2)

					arg_109_1.var_.effectbaozhu1 = nil
				end
			end

			local var_112_3 = manager.ui.mainCamera.transform
			local var_112_4 = 0

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				local var_112_5 = arg_109_1.var_.effectbaozhu2
				local var_112_6
				local var_112_7 = var_112_3

				if not var_112_5 then
					var_112_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_112_7)
					var_112_5.name = "baozhu2"
					arg_109_1.var_.effectbaozhu2 = var_112_5
				else
					var_112_5.transform:SetParent(var_112_7)
				end

				var_112_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_112_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_112_8 = "STblack"

			if arg_109_1.bgs_[var_112_8] == nil then
				local var_112_9 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_112_8)
				var_112_9.name = var_112_8
				var_112_9.transform.parent = arg_109_1.stage_.transform
				var_112_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_[var_112_8] = var_112_9
			end

			local var_112_10 = 0.375

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				local var_112_11 = manager.ui.mainCamera.transform.localPosition
				local var_112_12 = Vector3.New(0, 0, 10) + Vector3.New(var_112_11.x, var_112_11.y, 0)
				local var_112_13 = arg_109_1.bgs_.STblack

				var_112_13.transform.localPosition = var_112_12
				var_112_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_14 = var_112_13:GetComponent("SpriteRenderer")

				if var_112_14 and var_112_14.sprite then
					local var_112_15 = (var_112_13.transform.localPosition - var_112_11).z
					local var_112_16 = manager.ui.mainCameraCom_
					local var_112_17 = 2 * var_112_15 * Mathf.Tan(var_112_16.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_112_18 = var_112_17 * var_112_16.aspect
					local var_112_19 = var_112_14.sprite.bounds.size.x
					local var_112_20 = var_112_14.sprite.bounds.size.y
					local var_112_21 = var_112_18 / var_112_19
					local var_112_22 = var_112_17 / var_112_20
					local var_112_23 = var_112_22 < var_112_21 and var_112_21 or var_112_22

					var_112_13.transform.localScale = Vector3.New(var_112_23, var_112_23, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "STblack" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_24 = 0

			if var_112_24 < arg_109_1.time_ and arg_109_1.time_ <= var_112_24 + arg_112_0 then
				arg_109_1.allBtn_.enabled = false
			end

			local var_112_25 = 1

			if arg_109_1.time_ >= var_112_24 + var_112_25 and arg_109_1.time_ < var_112_24 + var_112_25 + arg_112_0 then
				arg_109_1.allBtn_.enabled = true
			end

			local var_112_26 = 0.1
			local var_112_27 = 1

			if var_112_26 < arg_109_1.time_ and arg_109_1.time_ <= var_112_26 + arg_112_0 then
				local var_112_28 = "stop"
				local var_112_29 = "effect"

				arg_109_1:AudioAction(var_112_28, var_112_29, "se_story_138", "se_story_138_boomtimer_loop02", "")
			end

			local var_112_30 = 0.1
			local var_112_31 = 1

			if var_112_30 < arg_109_1.time_ and arg_109_1.time_ <= var_112_30 + arg_112_0 then
				local var_112_32 = "play"
				local var_112_33 = "effect"

				arg_109_1:AudioAction(var_112_32, var_112_33, "se_story_145", "se_story_145_explosion03", "")
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_34 = 0.625
			local var_112_35 = 0.375

			if var_112_34 < arg_109_1.time_ and arg_109_1.time_ <= var_112_34 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_36 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_36:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_37 = arg_109_1:GetWordFromCfg(302062026)
				local var_112_38 = arg_109_1:FormatText(var_112_37.content)

				arg_109_1.text_.text = var_112_38

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_39 = 15
				local var_112_40 = utf8.len(var_112_38)
				local var_112_41 = var_112_39 <= 0 and var_112_35 or var_112_35 * (var_112_40 / var_112_39)

				if var_112_41 > 0 and var_112_35 < var_112_41 then
					arg_109_1.talkMaxDuration = var_112_41
					var_112_34 = var_112_34 + 0.3

					if var_112_41 + var_112_34 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_41 + var_112_34
					end
				end

				arg_109_1.text_.text = var_112_38
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_42 = var_112_34 + 0.3
			local var_112_43 = math.max(var_112_35, arg_109_1.talkMaxDuration)

			if var_112_42 <= arg_109_1.time_ and arg_109_1.time_ < var_112_42 + var_112_43 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_42) / var_112_43

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_42 + var_112_43 and arg_109_1.time_ < var_112_42 + var_112_43 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I28f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_302062.awb"
	}
}
