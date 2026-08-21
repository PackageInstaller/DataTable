return {
	Play301031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 301031001
		arg_1_1.duration_ = 5.7

		local var_1_0 = {
			zh = 5.1,
			ja = 5.7
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
				arg_1_0:Play301031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST07b"

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
				local var_4_5 = arg_1_1.bgs_.ST07b

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
					if iter_4_0 ~= "ST07b" then
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

			local var_4_24 = "10066ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["10066ui_story"].transform
			local var_4_30 = 1.9

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos10066ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -0.99, -5.83)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10066ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["10066ui_story"]
			local var_4_39 = 1.9

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10066ui_story == nil then
				arg_1_1.var_.characterEffect10066ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect10066ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10066ui_story then
				arg_1_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_4_42 = 1.9

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_1")
			end

			local var_4_43 = 1.9

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0.2
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "effect"

				arg_1_1:AudioAction(var_4_46, var_4_47, "se_story_140", "se_story_140_amb_dream01", "")
			end

			local var_4_48 = 1
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

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
			local var_4_59 = 0.2

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

				local var_4_61 = arg_1_1:FormatText(StoryNameCfg[640].name)

				arg_1_1.leftNameTxt_.text = var_4_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_62 = arg_1_1:GetWordFromCfg(301031001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031001", "story_v_out_301031.awb") ~= 0 then
					local var_4_67 = manager.audio:GetVoiceLength("story_v_out_301031", "301031001", "story_v_out_301031.awb") / 1000

					if var_4_67 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_58
					end

					if var_4_62.prefab_name ~= "" and arg_1_1.actors_[var_4_62.prefab_name] ~= nil then
						local var_4_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_62.prefab_name].transform, "story_v_out_301031", "301031001", "story_v_out_301031.awb")

						arg_1_1:RecordAudio("301031001", var_4_68)
						arg_1_1:RecordAudio("301031001", var_4_68)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_301031", "301031001", "story_v_out_301031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_301031", "301031001", "story_v_out_301031.awb")
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
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play301031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 301031002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play301031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["10066ui_story"].transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.moveOldPos10066ui_story = var_11_0.localPosition
			end

			local var_11_2 = 0.001

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2
				local var_11_4 = Vector3.New(0, 100, 0)

				var_11_0.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10066ui_story, var_11_4, var_11_3)

				local var_11_5 = manager.ui.mainCamera.transform.position - var_11_0.position

				var_11_0.forward = Vector3.New(var_11_5.x, var_11_5.y, var_11_5.z)

				local var_11_6 = var_11_0.localEulerAngles

				var_11_6.z = 0
				var_11_6.x = 0
				var_11_0.localEulerAngles = var_11_6
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 then
				var_11_0.localPosition = Vector3.New(0, 100, 0)

				local var_11_7 = manager.ui.mainCamera.transform.position - var_11_0.position

				var_11_0.forward = Vector3.New(var_11_7.x, var_11_7.y, var_11_7.z)

				local var_11_8 = var_11_0.localEulerAngles

				var_11_8.z = 0
				var_11_8.x = 0
				var_11_0.localEulerAngles = var_11_8
			end

			local var_11_9 = arg_8_1.actors_["10066ui_story"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect10066ui_story == nil then
				arg_8_1.var_.characterEffect10066ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.200000002980232

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect10066ui_story and not isNil(var_11_9) then
					local var_11_13 = Mathf.Lerp(0, 0.5, var_11_12)

					arg_8_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10066ui_story.fillRatio = var_11_13
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect10066ui_story then
				local var_11_14 = 0.5

				arg_8_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10066ui_story.fillRatio = var_11_14
			end

			local var_11_15 = 0
			local var_11_16 = 1.175

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_17 = arg_8_1:GetWordFromCfg(301031002)
				local var_11_18 = arg_8_1:FormatText(var_11_17.content)

				arg_8_1.text_.text = var_11_18

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_19 = 47
				local var_11_20 = utf8.len(var_11_18)
				local var_11_21 = var_11_19 <= 0 and var_11_16 or var_11_16 * (var_11_20 / var_11_19)

				if var_11_21 > 0 and var_11_16 < var_11_21 then
					arg_8_1.talkMaxDuration = var_11_21

					if var_11_21 + var_11_15 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_21 + var_11_15
					end
				end

				arg_8_1.text_.text = var_11_18
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_22 = math.max(var_11_16, arg_8_1.talkMaxDuration)

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_22 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_15) / var_11_22

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_15 + var_11_22 and arg_8_1.time_ < var_11_15 + var_11_22 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play301031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 301031003
		arg_12_1.duration_ = 9.37

		local var_12_0 = {
			zh = 8.4,
			ja = 9.366
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
				arg_12_0:Play301031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["10066ui_story"].transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos10066ui_story = var_15_0.localPosition
			end

			local var_15_2 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2
				local var_15_4 = Vector3.New(0, -0.99, -5.83)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10066ui_story, var_15_4, var_15_3)

				local var_15_5 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_5.x, var_15_5.y, var_15_5.z)

				local var_15_6 = var_15_0.localEulerAngles

				var_15_6.z = 0
				var_15_6.x = 0
				var_15_0.localEulerAngles = var_15_6
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_15_7 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_7.x, var_15_7.y, var_15_7.z)

				local var_15_8 = var_15_0.localEulerAngles

				var_15_8.z = 0
				var_15_8.x = 0
				var_15_0.localEulerAngles = var_15_8
			end

			local var_15_9 = arg_12_1.actors_["10066ui_story"]
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect10066ui_story == nil then
				arg_12_1.var_.characterEffect10066ui_story = var_15_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_11 = 0.200000002980232

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 and not isNil(var_15_9) then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11

				if arg_12_1.var_.characterEffect10066ui_story and not isNil(var_15_9) then
					arg_12_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect10066ui_story then
				arg_12_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_15_13 = 0

			if var_15_13 < arg_12_1.time_ and arg_12_1.time_ <= var_15_13 + arg_15_0 then
				arg_12_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_2")
			end

			local var_15_14 = 0

			if var_15_14 < arg_12_1.time_ and arg_12_1.time_ <= var_15_14 + arg_15_0 then
				arg_12_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_15_15 = 0
			local var_15_16 = 0.95

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_17 = arg_12_1:FormatText(StoryNameCfg[640].name)

				arg_12_1.leftNameTxt_.text = var_15_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_18 = arg_12_1:GetWordFromCfg(301031003)
				local var_15_19 = arg_12_1:FormatText(var_15_18.content)

				arg_12_1.text_.text = var_15_19

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_20 = 38
				local var_15_21 = utf8.len(var_15_19)
				local var_15_22 = var_15_20 <= 0 and var_15_16 or var_15_16 * (var_15_21 / var_15_20)

				if var_15_22 > 0 and var_15_16 < var_15_22 then
					arg_12_1.talkMaxDuration = var_15_22

					if var_15_22 + var_15_15 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_22 + var_15_15
					end
				end

				arg_12_1.text_.text = var_15_19
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031003", "story_v_out_301031.awb") ~= 0 then
					local var_15_23 = manager.audio:GetVoiceLength("story_v_out_301031", "301031003", "story_v_out_301031.awb") / 1000

					if var_15_23 + var_15_15 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_23 + var_15_15
					end

					if var_15_18.prefab_name ~= "" and arg_12_1.actors_[var_15_18.prefab_name] ~= nil then
						local var_15_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_18.prefab_name].transform, "story_v_out_301031", "301031003", "story_v_out_301031.awb")

						arg_12_1:RecordAudio("301031003", var_15_24)
						arg_12_1:RecordAudio("301031003", var_15_24)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_301031", "301031003", "story_v_out_301031.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_301031", "301031003", "story_v_out_301031.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_25 = math.max(var_15_16, arg_12_1.talkMaxDuration)

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_25 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_15) / var_15_25

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_15 + var_15_25 and arg_12_1.time_ < var_15_15 + var_15_25 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play301031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 301031004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play301031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10066ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect10066ui_story == nil then
				arg_16_1.var_.characterEffect10066ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect10066ui_story and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_16_1.var_.characterEffect10066ui_story.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect10066ui_story then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_16_1.var_.characterEffect10066ui_story.fillRatio = var_19_5
			end

			local var_19_6 = 0
			local var_19_7 = 0.4

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[7].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_9 = arg_16_1:GetWordFromCfg(301031004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 16
				local var_19_12 = utf8.len(var_19_10)
				local var_19_13 = var_19_11 <= 0 and var_19_7 or var_19_7 * (var_19_12 / var_19_11)

				if var_19_13 > 0 and var_19_7 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_10
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_14 and arg_16_1.time_ < var_19_6 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play301031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 301031005
		arg_20_1.duration_ = 3.43

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play301031006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10066ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10066ui_story == nil then
				arg_20_1.var_.characterEffect10066ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect10066ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10066ui_story then
				arg_20_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_23_4 = 0

			if var_23_4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_23_6 = 0
			local var_23_7 = 0.375

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[640].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_9 = arg_20_1:GetWordFromCfg(301031005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031005", "story_v_out_301031.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_301031", "301031005", "story_v_out_301031.awb") / 1000

					if var_23_14 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_6
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_301031", "301031005", "story_v_out_301031.awb")

						arg_20_1:RecordAudio("301031005", var_23_15)
						arg_20_1:RecordAudio("301031005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_301031", "301031005", "story_v_out_301031.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_301031", "301031005", "story_v_out_301031.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_16 and arg_20_1.time_ < var_23_6 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play301031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 301031006
		arg_24_1.duration_ = 8.17

		local var_24_0 = {
			zh = 7.866,
			ja = 8.166
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
				arg_24_0:Play301031007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_27_2 = 0
			local var_27_3 = 0.925

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_4 = arg_24_1:FormatText(StoryNameCfg[640].name)

				arg_24_1.leftNameTxt_.text = var_27_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_5 = arg_24_1:GetWordFromCfg(301031006)
				local var_27_6 = arg_24_1:FormatText(var_27_5.content)

				arg_24_1.text_.text = var_27_6

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 37
				local var_27_8 = utf8.len(var_27_6)
				local var_27_9 = var_27_7 <= 0 and var_27_3 or var_27_3 * (var_27_8 / var_27_7)

				if var_27_9 > 0 and var_27_3 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_6
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031006", "story_v_out_301031.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_out_301031", "301031006", "story_v_out_301031.awb") / 1000

					if var_27_10 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_2
					end

					if var_27_5.prefab_name ~= "" and arg_24_1.actors_[var_27_5.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_5.prefab_name].transform, "story_v_out_301031", "301031006", "story_v_out_301031.awb")

						arg_24_1:RecordAudio("301031006", var_27_11)
						arg_24_1:RecordAudio("301031006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_301031", "301031006", "story_v_out_301031.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_301031", "301031006", "story_v_out_301031.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_12 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_12 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_12

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_12 and arg_24_1.time_ < var_27_2 + var_27_12 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play301031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 301031007
		arg_28_1.duration_ = 3.13

		local var_28_0 = {
			zh = 2.466,
			ja = 3.133
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
				arg_28_0:Play301031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1084ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_28_1.stage_.transform)

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

			local var_31_5 = arg_28_1.actors_["1084ui_story"].transform
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = var_31_5.localPosition
			end

			local var_31_7 = 0.001

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7
				local var_31_9 = Vector3.New(0.7, -0.97, -6)

				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, var_31_9, var_31_8)

				local var_31_10 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_10.x, var_31_10.y, var_31_10.z)

				local var_31_11 = var_31_5.localEulerAngles

				var_31_11.z = 0
				var_31_11.x = 0
				var_31_5.localEulerAngles = var_31_11
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_31_12 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_12.x, var_31_12.y, var_31_12.z)

				local var_31_13 = var_31_5.localEulerAngles

				var_31_13.z = 0
				var_31_13.x = 0
				var_31_5.localEulerAngles = var_31_13
			end

			local var_31_14 = arg_28_1.actors_["10066ui_story"].transform
			local var_31_15 = 0

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.var_.moveOldPos10066ui_story = var_31_14.localPosition
			end

			local var_31_16 = 0.001

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_16 then
				local var_31_17 = (arg_28_1.time_ - var_31_15) / var_31_16
				local var_31_18 = Vector3.New(-0.7, -0.99, -5.83)

				var_31_14.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10066ui_story, var_31_18, var_31_17)

				local var_31_19 = manager.ui.mainCamera.transform.position - var_31_14.position

				var_31_14.forward = Vector3.New(var_31_19.x, var_31_19.y, var_31_19.z)

				local var_31_20 = var_31_14.localEulerAngles

				var_31_20.z = 0
				var_31_20.x = 0
				var_31_14.localEulerAngles = var_31_20
			end

			if arg_28_1.time_ >= var_31_15 + var_31_16 and arg_28_1.time_ < var_31_15 + var_31_16 + arg_31_0 then
				var_31_14.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_31_21 = manager.ui.mainCamera.transform.position - var_31_14.position

				var_31_14.forward = Vector3.New(var_31_21.x, var_31_21.y, var_31_21.z)

				local var_31_22 = var_31_14.localEulerAngles

				var_31_22.z = 0
				var_31_22.x = 0
				var_31_14.localEulerAngles = var_31_22
			end

			local var_31_23 = arg_28_1.actors_["1084ui_story"]
			local var_31_24 = 0

			if var_31_24 < arg_28_1.time_ and arg_28_1.time_ <= var_31_24 + arg_31_0 and not isNil(var_31_23) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = var_31_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_25 = 0.200000002980232

			if var_31_24 <= arg_28_1.time_ and arg_28_1.time_ < var_31_24 + var_31_25 and not isNil(var_31_23) then
				local var_31_26 = (arg_28_1.time_ - var_31_24) / var_31_25

				if arg_28_1.var_.characterEffect1084ui_story and not isNil(var_31_23) then
					arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_24 + var_31_25 and arg_28_1.time_ < var_31_24 + var_31_25 + arg_31_0 and not isNil(var_31_23) and arg_28_1.var_.characterEffect1084ui_story then
				arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_31_27 = arg_28_1.actors_["10066ui_story"]
			local var_31_28 = 0

			if var_31_28 < arg_28_1.time_ and arg_28_1.time_ <= var_31_28 + arg_31_0 and not isNil(var_31_27) and arg_28_1.var_.characterEffect10066ui_story == nil then
				arg_28_1.var_.characterEffect10066ui_story = var_31_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_29 = 0.200000002980232

			if var_31_28 <= arg_28_1.time_ and arg_28_1.time_ < var_31_28 + var_31_29 and not isNil(var_31_27) then
				local var_31_30 = (arg_28_1.time_ - var_31_28) / var_31_29

				if arg_28_1.var_.characterEffect10066ui_story and not isNil(var_31_27) then
					local var_31_31 = Mathf.Lerp(0, 0.5, var_31_30)

					arg_28_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10066ui_story.fillRatio = var_31_31
				end
			end

			if arg_28_1.time_ >= var_31_28 + var_31_29 and arg_28_1.time_ < var_31_28 + var_31_29 + arg_31_0 and not isNil(var_31_27) and arg_28_1.var_.characterEffect10066ui_story then
				local var_31_32 = 0.5

				arg_28_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10066ui_story.fillRatio = var_31_32
			end

			local var_31_33 = 0

			if var_31_33 < arg_28_1.time_ and arg_28_1.time_ <= var_31_33 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_31_34 = 0

			if var_31_34 < arg_28_1.time_ and arg_28_1.time_ <= var_31_34 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_31_35 = 0
			local var_31_36 = 0.275

			if var_31_35 < arg_28_1.time_ and arg_28_1.time_ <= var_31_35 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_37 = arg_28_1:FormatText(StoryNameCfg[6].name)

				arg_28_1.leftNameTxt_.text = var_31_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_38 = arg_28_1:GetWordFromCfg(301031007)
				local var_31_39 = arg_28_1:FormatText(var_31_38.content)

				arg_28_1.text_.text = var_31_39

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_40 = 11
				local var_31_41 = utf8.len(var_31_39)
				local var_31_42 = var_31_40 <= 0 and var_31_36 or var_31_36 * (var_31_41 / var_31_40)

				if var_31_42 > 0 and var_31_36 < var_31_42 then
					arg_28_1.talkMaxDuration = var_31_42

					if var_31_42 + var_31_35 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_42 + var_31_35
					end
				end

				arg_28_1.text_.text = var_31_39
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031007", "story_v_out_301031.awb") ~= 0 then
					local var_31_43 = manager.audio:GetVoiceLength("story_v_out_301031", "301031007", "story_v_out_301031.awb") / 1000

					if var_31_43 + var_31_35 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_43 + var_31_35
					end

					if var_31_38.prefab_name ~= "" and arg_28_1.actors_[var_31_38.prefab_name] ~= nil then
						local var_31_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_38.prefab_name].transform, "story_v_out_301031", "301031007", "story_v_out_301031.awb")

						arg_28_1:RecordAudio("301031007", var_31_44)
						arg_28_1:RecordAudio("301031007", var_31_44)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_301031", "301031007", "story_v_out_301031.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_301031", "301031007", "story_v_out_301031.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_45 = math.max(var_31_36, arg_28_1.talkMaxDuration)

			if var_31_35 <= arg_28_1.time_ and arg_28_1.time_ < var_31_35 + var_31_45 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_35) / var_31_45

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_35 + var_31_45 and arg_28_1.time_ < var_31_35 + var_31_45 + arg_31_0 then
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

		arg_28_1:InitPlayNodeList()
	end,
	Play301031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 301031008
		arg_32_1.duration_ = 4.47

		local var_32_0 = {
			zh = 3.033,
			ja = 4.466
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
				arg_32_0:Play301031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10066ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10066ui_story == nil then
				arg_32_1.var_.characterEffect10066ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect10066ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10066ui_story then
				arg_32_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1084ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1084ui_story == nil then
				arg_32_1.var_.characterEffect1084ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect1084ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1084ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1084ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1084ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_35_12 = 0
			local var_35_13 = 0.325

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_14 = arg_32_1:FormatText(StoryNameCfg[640].name)

				arg_32_1.leftNameTxt_.text = var_35_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_15 = arg_32_1:GetWordFromCfg(301031008)
				local var_35_16 = arg_32_1:FormatText(var_35_15.content)

				arg_32_1.text_.text = var_35_16

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 13
				local var_35_18 = utf8.len(var_35_16)
				local var_35_19 = var_35_17 <= 0 and var_35_13 or var_35_13 * (var_35_18 / var_35_17)

				if var_35_19 > 0 and var_35_13 < var_35_19 then
					arg_32_1.talkMaxDuration = var_35_19

					if var_35_19 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_16
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031008", "story_v_out_301031.awb") ~= 0 then
					local var_35_20 = manager.audio:GetVoiceLength("story_v_out_301031", "301031008", "story_v_out_301031.awb") / 1000

					if var_35_20 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_20 + var_35_12
					end

					if var_35_15.prefab_name ~= "" and arg_32_1.actors_[var_35_15.prefab_name] ~= nil then
						local var_35_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_15.prefab_name].transform, "story_v_out_301031", "301031008", "story_v_out_301031.awb")

						arg_32_1:RecordAudio("301031008", var_35_21)
						arg_32_1:RecordAudio("301031008", var_35_21)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_301031", "301031008", "story_v_out_301031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_301031", "301031008", "story_v_out_301031.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_22 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_22 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_22

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_22 and arg_32_1.time_ < var_35_12 + var_35_22 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play301031009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 301031009
		arg_36_1.duration_ = 10.2

		local var_36_0 = {
			zh = 6.533,
			ja = 10.2
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
				arg_36_0:Play301031010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_39_2 = 0
			local var_39_3 = 0.775

			if var_39_2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_4 = arg_36_1:FormatText(StoryNameCfg[640].name)

				arg_36_1.leftNameTxt_.text = var_39_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_5 = arg_36_1:GetWordFromCfg(301031009)
				local var_39_6 = arg_36_1:FormatText(var_39_5.content)

				arg_36_1.text_.text = var_39_6

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 31
				local var_39_8 = utf8.len(var_39_6)
				local var_39_9 = var_39_7 <= 0 and var_39_3 or var_39_3 * (var_39_8 / var_39_7)

				if var_39_9 > 0 and var_39_3 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_6
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031009", "story_v_out_301031.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_301031", "301031009", "story_v_out_301031.awb") / 1000

					if var_39_10 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_2
					end

					if var_39_5.prefab_name ~= "" and arg_36_1.actors_[var_39_5.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_5.prefab_name].transform, "story_v_out_301031", "301031009", "story_v_out_301031.awb")

						arg_36_1:RecordAudio("301031009", var_39_11)
						arg_36_1:RecordAudio("301031009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_301031", "301031009", "story_v_out_301031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_301031", "301031009", "story_v_out_301031.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_12 and arg_36_1.time_ < var_39_2 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play301031010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 301031010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play301031011(arg_40_1)
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
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10066ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10066ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10066ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0
			local var_43_7 = 0.45

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_9 = arg_40_1:GetWordFromCfg(301031010)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 18
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_14 and arg_40_1.time_ < var_43_6 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play301031011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 301031011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play301031012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.875

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[7].name)

				arg_44_1.leftNameTxt_.text = var_47_2

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

				local var_47_3 = arg_44_1:GetWordFromCfg(301031011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 35
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
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_8 and arg_44_1.time_ < var_47_0 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play301031012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 301031012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play301031013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.175

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[7].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(301031012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 7
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
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play301031013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 301031013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play301031014(arg_52_1)
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
				local var_55_4 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1084ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, 100, 0)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = arg_52_1.actors_["10066ui_story"].transform
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1.var_.moveOldPos10066ui_story = var_55_9.localPosition
			end

			local var_55_11 = 0.001

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11
				local var_55_13 = Vector3.New(0, 100, 0)

				var_55_9.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10066ui_story, var_55_13, var_55_12)

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
			local var_55_19 = 1.5

			if var_55_18 < arg_52_1.time_ and arg_52_1.time_ <= var_55_18 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_20 = arg_52_1:GetWordFromCfg(301031013)
				local var_55_21 = arg_52_1:FormatText(var_55_20.content)

				arg_52_1.text_.text = var_55_21

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_22 = 60
				local var_55_23 = utf8.len(var_55_21)
				local var_55_24 = var_55_22 <= 0 and var_55_19 or var_55_19 * (var_55_23 / var_55_22)

				if var_55_24 > 0 and var_55_19 < var_55_24 then
					arg_52_1.talkMaxDuration = var_55_24

					if var_55_24 + var_55_18 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_24 + var_55_18
					end
				end

				arg_52_1.text_.text = var_55_21
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_25 = math.max(var_55_19, arg_52_1.talkMaxDuration)

			if var_55_18 <= arg_52_1.time_ and arg_52_1.time_ < var_55_18 + var_55_25 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_18) / var_55_25

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_18 + var_55_25 and arg_52_1.time_ < var_55_18 + var_55_25 + arg_55_0 then
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

		arg_52_1:InitPlayNodeList()
	end,
	Play301031014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 301031014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play301031015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.55

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(301031014)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 22
				local var_59_5 = utf8.len(var_59_3)
				local var_59_6 = var_59_4 <= 0 and var_59_1 or var_59_1 * (var_59_5 / var_59_4)

				if var_59_6 > 0 and var_59_1 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_7 and arg_56_1.time_ < var_59_0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play301031015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 301031015
		arg_60_1.duration_ = 4.07

		local var_60_0 = {
			zh = 4.066,
			ja = 3.866
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
				arg_60_0:Play301031016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "1019ui_story"

			if arg_60_1.actors_[var_63_0] == nil then
				local var_63_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_63_1) then
					local var_63_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_60_1.stage_.transform)

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

			local var_63_5 = arg_60_1.actors_["1019ui_story"].transform
			local var_63_6 = 0

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.var_.moveOldPos1019ui_story = var_63_5.localPosition
			end

			local var_63_7 = 0.001

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_7 then
				local var_63_8 = (arg_60_1.time_ - var_63_6) / var_63_7
				local var_63_9 = Vector3.New(-0.7, -1.08, -5.9)

				var_63_5.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1019ui_story, var_63_9, var_63_8)

				local var_63_10 = manager.ui.mainCamera.transform.position - var_63_5.position

				var_63_5.forward = Vector3.New(var_63_10.x, var_63_10.y, var_63_10.z)

				local var_63_11 = var_63_5.localEulerAngles

				var_63_11.z = 0
				var_63_11.x = 0
				var_63_5.localEulerAngles = var_63_11
			end

			if arg_60_1.time_ >= var_63_6 + var_63_7 and arg_60_1.time_ < var_63_6 + var_63_7 + arg_63_0 then
				var_63_5.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_63_12 = manager.ui.mainCamera.transform.position - var_63_5.position

				var_63_5.forward = Vector3.New(var_63_12.x, var_63_12.y, var_63_12.z)

				local var_63_13 = var_63_5.localEulerAngles

				var_63_13.z = 0
				var_63_13.x = 0
				var_63_5.localEulerAngles = var_63_13
			end

			local var_63_14 = arg_60_1.actors_["1019ui_story"]
			local var_63_15 = 0

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 and not isNil(var_63_14) and arg_60_1.var_.characterEffect1019ui_story == nil then
				arg_60_1.var_.characterEffect1019ui_story = var_63_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_16 = 0.200000002980232

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_16 and not isNil(var_63_14) then
				local var_63_17 = (arg_60_1.time_ - var_63_15) / var_63_16

				if arg_60_1.var_.characterEffect1019ui_story and not isNil(var_63_14) then
					arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_15 + var_63_16 and arg_60_1.time_ < var_63_15 + var_63_16 + arg_63_0 and not isNil(var_63_14) and arg_60_1.var_.characterEffect1019ui_story then
				arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_63_18 = 0

			if var_63_18 < arg_60_1.time_ and arg_60_1.time_ <= var_63_18 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_63_19 = 0

			if var_63_19 < arg_60_1.time_ and arg_60_1.time_ <= var_63_19 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_63_20 = 0
			local var_63_21 = 0.4

			if var_63_20 < arg_60_1.time_ and arg_60_1.time_ <= var_63_20 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_22 = arg_60_1:FormatText(StoryNameCfg[13].name)

				arg_60_1.leftNameTxt_.text = var_63_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_23 = arg_60_1:GetWordFromCfg(301031015)
				local var_63_24 = arg_60_1:FormatText(var_63_23.content)

				arg_60_1.text_.text = var_63_24

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_25 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031015", "story_v_out_301031.awb") ~= 0 then
					local var_63_28 = manager.audio:GetVoiceLength("story_v_out_301031", "301031015", "story_v_out_301031.awb") / 1000

					if var_63_28 + var_63_20 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_28 + var_63_20
					end

					if var_63_23.prefab_name ~= "" and arg_60_1.actors_[var_63_23.prefab_name] ~= nil then
						local var_63_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_23.prefab_name].transform, "story_v_out_301031", "301031015", "story_v_out_301031.awb")

						arg_60_1:RecordAudio("301031015", var_63_29)
						arg_60_1:RecordAudio("301031015", var_63_29)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_301031", "301031015", "story_v_out_301031.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_301031", "301031015", "story_v_out_301031.awb")
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
	Play301031016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 301031016
		arg_64_1.duration_ = 11.9

		local var_64_0 = {
			zh = 8.5,
			ja = 11.9
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
				arg_64_0:Play301031017(arg_64_1)
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
				local var_67_4 = Vector3.New(0.7, -0.97, -6)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0.7, -0.97, -6)

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

			local var_67_13 = arg_64_1.actors_["1019ui_story"]
			local var_67_14 = 0

			if var_67_14 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 and not isNil(var_67_13) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = var_67_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_15 = 0.200000002980232

			if var_67_14 <= arg_64_1.time_ and arg_64_1.time_ < var_67_14 + var_67_15 and not isNil(var_67_13) then
				local var_67_16 = (arg_64_1.time_ - var_67_14) / var_67_15

				if arg_64_1.var_.characterEffect1019ui_story and not isNil(var_67_13) then
					local var_67_17 = Mathf.Lerp(0, 0.5, var_67_16)

					arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1019ui_story.fillRatio = var_67_17
				end
			end

			if arg_64_1.time_ >= var_67_14 + var_67_15 and arg_64_1.time_ < var_67_14 + var_67_15 + arg_67_0 and not isNil(var_67_13) and arg_64_1.var_.characterEffect1019ui_story then
				local var_67_18 = 0.5

				arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1019ui_story.fillRatio = var_67_18
			end

			local var_67_19 = 0

			if var_67_19 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_67_20 = 0

			if var_67_20 < arg_64_1.time_ and arg_64_1.time_ <= var_67_20 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_21 = 0
			local var_67_22 = 1.25

			if var_67_21 < arg_64_1.time_ and arg_64_1.time_ <= var_67_21 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_23 = arg_64_1:FormatText(StoryNameCfg[6].name)

				arg_64_1.leftNameTxt_.text = var_67_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_24 = arg_64_1:GetWordFromCfg(301031016)
				local var_67_25 = arg_64_1:FormatText(var_67_24.content)

				arg_64_1.text_.text = var_67_25

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_26 = 50
				local var_67_27 = utf8.len(var_67_25)
				local var_67_28 = var_67_26 <= 0 and var_67_22 or var_67_22 * (var_67_27 / var_67_26)

				if var_67_28 > 0 and var_67_22 < var_67_28 then
					arg_64_1.talkMaxDuration = var_67_28

					if var_67_28 + var_67_21 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_28 + var_67_21
					end
				end

				arg_64_1.text_.text = var_67_25
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031016", "story_v_out_301031.awb") ~= 0 then
					local var_67_29 = manager.audio:GetVoiceLength("story_v_out_301031", "301031016", "story_v_out_301031.awb") / 1000

					if var_67_29 + var_67_21 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_29 + var_67_21
					end

					if var_67_24.prefab_name ~= "" and arg_64_1.actors_[var_67_24.prefab_name] ~= nil then
						local var_67_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_24.prefab_name].transform, "story_v_out_301031", "301031016", "story_v_out_301031.awb")

						arg_64_1:RecordAudio("301031016", var_67_30)
						arg_64_1:RecordAudio("301031016", var_67_30)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_301031", "301031016", "story_v_out_301031.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_301031", "301031016", "story_v_out_301031.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_31 = math.max(var_67_22, arg_64_1.talkMaxDuration)

			if var_67_21 <= arg_64_1.time_ and arg_64_1.time_ < var_67_21 + var_67_31 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_21) / var_67_31

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_21 + var_67_31 and arg_64_1.time_ < var_67_21 + var_67_31 + arg_67_0 then
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
	Play301031017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 301031017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play301031018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1084ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, 100, 0)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, 100, 0)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = arg_68_1.actors_["1019ui_story"].transform
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1.var_.moveOldPos1019ui_story = var_71_9.localPosition
			end

			local var_71_11 = 0.001

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11
				local var_71_13 = Vector3.New(0, 100, 0)

				var_71_9.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1019ui_story, var_71_13, var_71_12)

				local var_71_14 = manager.ui.mainCamera.transform.position - var_71_9.position

				var_71_9.forward = Vector3.New(var_71_14.x, var_71_14.y, var_71_14.z)

				local var_71_15 = var_71_9.localEulerAngles

				var_71_15.z = 0
				var_71_15.x = 0
				var_71_9.localEulerAngles = var_71_15
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 then
				var_71_9.localPosition = Vector3.New(0, 100, 0)

				local var_71_16 = manager.ui.mainCamera.transform.position - var_71_9.position

				var_71_9.forward = Vector3.New(var_71_16.x, var_71_16.y, var_71_16.z)

				local var_71_17 = var_71_9.localEulerAngles

				var_71_17.z = 0
				var_71_17.x = 0
				var_71_9.localEulerAngles = var_71_17
			end

			local var_71_18 = arg_68_1.actors_["1084ui_story"]
			local var_71_19 = 0

			if var_71_19 < arg_68_1.time_ and arg_68_1.time_ <= var_71_19 + arg_71_0 and not isNil(var_71_18) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = var_71_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_20 = 0.200000002980232

			if var_71_19 <= arg_68_1.time_ and arg_68_1.time_ < var_71_19 + var_71_20 and not isNil(var_71_18) then
				local var_71_21 = (arg_68_1.time_ - var_71_19) / var_71_20

				if arg_68_1.var_.characterEffect1084ui_story and not isNil(var_71_18) then
					local var_71_22 = Mathf.Lerp(0, 0.5, var_71_21)

					arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1084ui_story.fillRatio = var_71_22
				end
			end

			if arg_68_1.time_ >= var_71_19 + var_71_20 and arg_68_1.time_ < var_71_19 + var_71_20 + arg_71_0 and not isNil(var_71_18) and arg_68_1.var_.characterEffect1084ui_story then
				local var_71_23 = 0.5

				arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1084ui_story.fillRatio = var_71_23
			end

			local var_71_24 = 0
			local var_71_25 = 0.625

			if var_71_24 < arg_68_1.time_ and arg_68_1.time_ <= var_71_24 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_26 = arg_68_1:GetWordFromCfg(301031017)
				local var_71_27 = arg_68_1:FormatText(var_71_26.content)

				arg_68_1.text_.text = var_71_27

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_28 = 25
				local var_71_29 = utf8.len(var_71_27)
				local var_71_30 = var_71_28 <= 0 and var_71_25 or var_71_25 * (var_71_29 / var_71_28)

				if var_71_30 > 0 and var_71_25 < var_71_30 then
					arg_68_1.talkMaxDuration = var_71_30

					if var_71_30 + var_71_24 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_30 + var_71_24
					end
				end

				arg_68_1.text_.text = var_71_27
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_31 = math.max(var_71_25, arg_68_1.talkMaxDuration)

			if var_71_24 <= arg_68_1.time_ and arg_68_1.time_ < var_71_24 + var_71_31 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_24) / var_71_31

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_24 + var_71_31 and arg_68_1.time_ < var_71_24 + var_71_31 + arg_71_0 then
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

		arg_68_1:InitPlayNodeList()
	end,
	Play301031018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 301031018
		arg_72_1.duration_ = 14.17

		local var_72_0 = {
			zh = 7.7,
			ja = 14.166
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
				arg_72_0:Play301031019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1019ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1019ui_story = var_75_0.localPosition
			end

			local var_75_2 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2
				local var_75_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1019ui_story, var_75_4, var_75_3)

				local var_75_5 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_5.x, var_75_5.y, var_75_5.z)

				local var_75_6 = var_75_0.localEulerAngles

				var_75_6.z = 0
				var_75_6.x = 0
				var_75_0.localEulerAngles = var_75_6
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_75_7 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_7.x, var_75_7.y, var_75_7.z)

				local var_75_8 = var_75_0.localEulerAngles

				var_75_8.z = 0
				var_75_8.x = 0
				var_75_0.localEulerAngles = var_75_8
			end

			local var_75_9 = arg_72_1.actors_["1019ui_story"]
			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1019ui_story == nil then
				arg_72_1.var_.characterEffect1019ui_story = var_75_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_11 = 0.200000002980232

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_11 and not isNil(var_75_9) then
				local var_75_12 = (arg_72_1.time_ - var_75_10) / var_75_11

				if arg_72_1.var_.characterEffect1019ui_story and not isNil(var_75_9) then
					arg_72_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_10 + var_75_11 and arg_72_1.time_ < var_75_10 + var_75_11 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1019ui_story then
				arg_72_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_75_13 = 0

			if var_75_13 < arg_72_1.time_ and arg_72_1.time_ <= var_75_13 + arg_75_0 then
				arg_72_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_75_14 = 0

			if var_75_14 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_75_15 = 0
			local var_75_16 = 0.95

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_17 = arg_72_1:FormatText(StoryNameCfg[13].name)

				arg_72_1.leftNameTxt_.text = var_75_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_18 = arg_72_1:GetWordFromCfg(301031018)
				local var_75_19 = arg_72_1:FormatText(var_75_18.content)

				arg_72_1.text_.text = var_75_19

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_20 = 38
				local var_75_21 = utf8.len(var_75_19)
				local var_75_22 = var_75_20 <= 0 and var_75_16 or var_75_16 * (var_75_21 / var_75_20)

				if var_75_22 > 0 and var_75_16 < var_75_22 then
					arg_72_1.talkMaxDuration = var_75_22

					if var_75_22 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_22 + var_75_15
					end
				end

				arg_72_1.text_.text = var_75_19
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031018", "story_v_out_301031.awb") ~= 0 then
					local var_75_23 = manager.audio:GetVoiceLength("story_v_out_301031", "301031018", "story_v_out_301031.awb") / 1000

					if var_75_23 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_23 + var_75_15
					end

					if var_75_18.prefab_name ~= "" and arg_72_1.actors_[var_75_18.prefab_name] ~= nil then
						local var_75_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_18.prefab_name].transform, "story_v_out_301031", "301031018", "story_v_out_301031.awb")

						arg_72_1:RecordAudio("301031018", var_75_24)
						arg_72_1:RecordAudio("301031018", var_75_24)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_301031", "301031018", "story_v_out_301031.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_301031", "301031018", "story_v_out_301031.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_25 = math.max(var_75_16, arg_72_1.talkMaxDuration)

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_25 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_15) / var_75_25

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_15 + var_75_25 and arg_72_1.time_ < var_75_15 + var_75_25 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play301031019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 301031019
		arg_76_1.duration_ = 8.2

		local var_76_0 = {
			zh = 4.966,
			ja = 8.2
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
				arg_76_0:Play301031020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_2 = 0
			local var_79_3 = 0.625

			if var_79_2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_4 = arg_76_1:FormatText(StoryNameCfg[13].name)

				arg_76_1.leftNameTxt_.text = var_79_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_5 = arg_76_1:GetWordFromCfg(301031019)
				local var_79_6 = arg_76_1:FormatText(var_79_5.content)

				arg_76_1.text_.text = var_79_6

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 25
				local var_79_8 = utf8.len(var_79_6)
				local var_79_9 = var_79_7 <= 0 and var_79_3 or var_79_3 * (var_79_8 / var_79_7)

				if var_79_9 > 0 and var_79_3 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_6
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031019", "story_v_out_301031.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_301031", "301031019", "story_v_out_301031.awb") / 1000

					if var_79_10 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_2
					end

					if var_79_5.prefab_name ~= "" and arg_76_1.actors_[var_79_5.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_5.prefab_name].transform, "story_v_out_301031", "301031019", "story_v_out_301031.awb")

						arg_76_1:RecordAudio("301031019", var_79_11)
						arg_76_1:RecordAudio("301031019", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_301031", "301031019", "story_v_out_301031.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_301031", "301031019", "story_v_out_301031.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_3, arg_76_1.talkMaxDuration)

			if var_79_2 <= arg_76_1.time_ and arg_76_1.time_ < var_79_2 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_2) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_2 + var_79_12 and arg_76_1.time_ < var_79_2 + var_79_12 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play301031020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 301031020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play301031021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1019ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1019ui_story == nil then
				arg_80_1.var_.characterEffect1019ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1019ui_story and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1019ui_story.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1019ui_story then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1019ui_story.fillRatio = var_83_5
			end

			local var_83_6 = 0
			local var_83_7 = 0.75

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_8 = arg_80_1:FormatText(StoryNameCfg[7].name)

				arg_80_1.leftNameTxt_.text = var_83_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_9 = arg_80_1:GetWordFromCfg(301031020)
				local var_83_10 = arg_80_1:FormatText(var_83_9.content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 30
				local var_83_12 = utf8.len(var_83_10)
				local var_83_13 = var_83_11 <= 0 and var_83_7 or var_83_7 * (var_83_12 / var_83_11)

				if var_83_13 > 0 and var_83_7 < var_83_13 then
					arg_80_1.talkMaxDuration = var_83_13

					if var_83_13 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_10
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_14 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_14 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_14

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_14 and arg_80_1.time_ < var_83_6 + var_83_14 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play301031021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 301031021
		arg_84_1.duration_ = 7.8

		local var_84_0 = {
			zh = 5.033,
			ja = 7.8
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
				arg_84_0:Play301031022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1019ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1019ui_story == nil then
				arg_84_1.var_.characterEffect1019ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1019ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1019ui_story then
				arg_84_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_87_4 = 0

			if var_87_4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_87_6 = 0
			local var_87_7 = 0.625

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[13].name)

				arg_84_1.leftNameTxt_.text = var_87_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_9 = arg_84_1:GetWordFromCfg(301031021)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 25
				local var_87_12 = utf8.len(var_87_10)
				local var_87_13 = var_87_11 <= 0 and var_87_7 or var_87_7 * (var_87_12 / var_87_11)

				if var_87_13 > 0 and var_87_7 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_10
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031021", "story_v_out_301031.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_301031", "301031021", "story_v_out_301031.awb") / 1000

					if var_87_14 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_6
					end

					if var_87_9.prefab_name ~= "" and arg_84_1.actors_[var_87_9.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_9.prefab_name].transform, "story_v_out_301031", "301031021", "story_v_out_301031.awb")

						arg_84_1:RecordAudio("301031021", var_87_15)
						arg_84_1:RecordAudio("301031021", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_301031", "301031021", "story_v_out_301031.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_301031", "301031021", "story_v_out_301031.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_16 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_16

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_16 and arg_84_1.time_ < var_87_6 + var_87_16 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play301031022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 301031022
		arg_88_1.duration_ = 12.03

		local var_88_0 = {
			zh = 8.933,
			ja = 12.033
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
				arg_88_0:Play301031023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_91_2 = 0
			local var_91_3 = 1.15

			if var_91_2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_4 = arg_88_1:FormatText(StoryNameCfg[13].name)

				arg_88_1.leftNameTxt_.text = var_91_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_5 = arg_88_1:GetWordFromCfg(301031022)
				local var_91_6 = arg_88_1:FormatText(var_91_5.content)

				arg_88_1.text_.text = var_91_6

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 46
				local var_91_8 = utf8.len(var_91_6)
				local var_91_9 = var_91_7 <= 0 and var_91_3 or var_91_3 * (var_91_8 / var_91_7)

				if var_91_9 > 0 and var_91_3 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_6
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031022", "story_v_out_301031.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_301031", "301031022", "story_v_out_301031.awb") / 1000

					if var_91_10 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_2
					end

					if var_91_5.prefab_name ~= "" and arg_88_1.actors_[var_91_5.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_5.prefab_name].transform, "story_v_out_301031", "301031022", "story_v_out_301031.awb")

						arg_88_1:RecordAudio("301031022", var_91_11)
						arg_88_1:RecordAudio("301031022", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_301031", "301031022", "story_v_out_301031.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_301031", "301031022", "story_v_out_301031.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_12 and arg_88_1.time_ < var_91_2 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play301031023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 301031023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play301031024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1019ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1019ui_story == nil then
				arg_92_1.var_.characterEffect1019ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1019ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1019ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1019ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1019ui_story.fillRatio = var_95_5
			end

			local var_95_6 = 0
			local var_95_7 = 0.575

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_8 = arg_92_1:FormatText(StoryNameCfg[7].name)

				arg_92_1.leftNameTxt_.text = var_95_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_9 = arg_92_1:GetWordFromCfg(301031023)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 23
				local var_95_12 = utf8.len(var_95_10)
				local var_95_13 = var_95_11 <= 0 and var_95_7 or var_95_7 * (var_95_12 / var_95_11)

				if var_95_13 > 0 and var_95_7 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_14 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_14 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_14

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_14 and arg_92_1.time_ < var_95_6 + var_95_14 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play301031024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 301031024
		arg_96_1.duration_ = 7.5

		local var_96_0 = {
			zh = 4.733,
			ja = 7.5
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
				arg_96_0:Play301031025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1019ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1019ui_story == nil then
				arg_96_1.var_.characterEffect1019ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1019ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1019ui_story then
				arg_96_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_99_4 = 0

			if var_99_4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_2")
			end

			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_99_6 = 0
			local var_99_7 = 0.65

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[13].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_9 = arg_96_1:GetWordFromCfg(301031024)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 26
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_7 or var_99_7 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_7 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031024", "story_v_out_301031.awb") ~= 0 then
					local var_99_14 = manager.audio:GetVoiceLength("story_v_out_301031", "301031024", "story_v_out_301031.awb") / 1000

					if var_99_14 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_6
					end

					if var_99_9.prefab_name ~= "" and arg_96_1.actors_[var_99_9.prefab_name] ~= nil then
						local var_99_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_9.prefab_name].transform, "story_v_out_301031", "301031024", "story_v_out_301031.awb")

						arg_96_1:RecordAudio("301031024", var_99_15)
						arg_96_1:RecordAudio("301031024", var_99_15)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_301031", "301031024", "story_v_out_301031.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_301031", "301031024", "story_v_out_301031.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_16 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_16 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_16

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_16 and arg_96_1.time_ < var_99_6 + var_99_16 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play301031025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 301031025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play301031026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1019ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1019ui_story == nil then
				arg_100_1.var_.characterEffect1019ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1019ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1019ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1019ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1019ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 0.475

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_9 = arg_100_1:GetWordFromCfg(301031025)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 19
				local var_103_12 = utf8.len(var_103_10)
				local var_103_13 = var_103_11 <= 0 and var_103_7 or var_103_7 * (var_103_12 / var_103_11)

				if var_103_13 > 0 and var_103_7 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_14 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_14 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_14

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_14 and arg_100_1.time_ < var_103_6 + var_103_14 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play301031026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 301031026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play301031027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1019ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1019ui_story = var_107_0.localPosition
			end

			local var_107_2 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2
				local var_107_4 = Vector3.New(0, 100, 0)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1019ui_story, var_107_4, var_107_3)

				local var_107_5 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_5.x, var_107_5.y, var_107_5.z)

				local var_107_6 = var_107_0.localEulerAngles

				var_107_6.z = 0
				var_107_6.x = 0
				var_107_0.localEulerAngles = var_107_6
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, 100, 0)

				local var_107_7 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_7.x, var_107_7.y, var_107_7.z)

				local var_107_8 = var_107_0.localEulerAngles

				var_107_8.z = 0
				var_107_8.x = 0
				var_107_0.localEulerAngles = var_107_8
			end

			local var_107_9 = 0
			local var_107_10 = 0.775

			if var_107_9 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_11 = arg_104_1:GetWordFromCfg(301031026)
				local var_107_12 = arg_104_1:FormatText(var_107_11.content)

				arg_104_1.text_.text = var_107_12

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_13 = 31
				local var_107_14 = utf8.len(var_107_12)
				local var_107_15 = var_107_13 <= 0 and var_107_10 or var_107_10 * (var_107_14 / var_107_13)

				if var_107_15 > 0 and var_107_10 < var_107_15 then
					arg_104_1.talkMaxDuration = var_107_15

					if var_107_15 + var_107_9 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_15 + var_107_9
					end
				end

				arg_104_1.text_.text = var_107_12
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_10, arg_104_1.talkMaxDuration)

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_9) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_9 + var_107_16 and arg_104_1.time_ < var_107_9 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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

		arg_104_1:InitPlayNodeList()
	end,
	Play301031027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 301031027
		arg_108_1.duration_ = 8.37

		local var_108_0 = {
			zh = 5.666,
			ja = 8.366
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play301031028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1019ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1019ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1019ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = arg_108_1.actors_["1019ui_story"]
			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1019ui_story == nil then
				arg_108_1.var_.characterEffect1019ui_story = var_111_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_11 = 0.200000002980232

			if var_111_10 <= arg_108_1.time_ and arg_108_1.time_ < var_111_10 + var_111_11 and not isNil(var_111_9) then
				local var_111_12 = (arg_108_1.time_ - var_111_10) / var_111_11

				if arg_108_1.var_.characterEffect1019ui_story and not isNil(var_111_9) then
					arg_108_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_10 + var_111_11 and arg_108_1.time_ < var_111_10 + var_111_11 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1019ui_story then
				arg_108_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_111_13 = 0

			if var_111_13 < arg_108_1.time_ and arg_108_1.time_ <= var_111_13 + arg_111_0 then
				arg_108_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_111_14 = 0

			if var_111_14 < arg_108_1.time_ and arg_108_1.time_ <= var_111_14 + arg_111_0 then
				arg_108_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_111_15 = 0
			local var_111_16 = 0.925

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_17 = arg_108_1:FormatText(StoryNameCfg[13].name)

				arg_108_1.leftNameTxt_.text = var_111_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_18 = arg_108_1:GetWordFromCfg(301031027)
				local var_111_19 = arg_108_1:FormatText(var_111_18.content)

				arg_108_1.text_.text = var_111_19

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_20 = 37
				local var_111_21 = utf8.len(var_111_19)
				local var_111_22 = var_111_20 <= 0 and var_111_16 or var_111_16 * (var_111_21 / var_111_20)

				if var_111_22 > 0 and var_111_16 < var_111_22 then
					arg_108_1.talkMaxDuration = var_111_22

					if var_111_22 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_22 + var_111_15
					end
				end

				arg_108_1.text_.text = var_111_19
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031027", "story_v_out_301031.awb") ~= 0 then
					local var_111_23 = manager.audio:GetVoiceLength("story_v_out_301031", "301031027", "story_v_out_301031.awb") / 1000

					if var_111_23 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_15
					end

					if var_111_18.prefab_name ~= "" and arg_108_1.actors_[var_111_18.prefab_name] ~= nil then
						local var_111_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_18.prefab_name].transform, "story_v_out_301031", "301031027", "story_v_out_301031.awb")

						arg_108_1:RecordAudio("301031027", var_111_24)
						arg_108_1:RecordAudio("301031027", var_111_24)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_301031", "301031027", "story_v_out_301031.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_301031", "301031027", "story_v_out_301031.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_25 = math.max(var_111_16, arg_108_1.talkMaxDuration)

			if var_111_15 <= arg_108_1.time_ and arg_108_1.time_ < var_111_15 + var_111_25 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_15) / var_111_25

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_15 + var_111_25 and arg_108_1.time_ < var_111_15 + var_111_25 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play301031028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 301031028
		arg_112_1.duration_ = 3.03

		local var_112_0 = {
			zh = 3.033,
			ja = 1.999999999999
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play301031029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1084ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos1084ui_story = var_115_0.localPosition
			end

			local var_115_2 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2
				local var_115_4 = Vector3.New(0.7, -0.97, -6)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1084ui_story, var_115_4, var_115_3)

				local var_115_5 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_5.x, var_115_5.y, var_115_5.z)

				local var_115_6 = var_115_0.localEulerAngles

				var_115_6.z = 0
				var_115_6.x = 0
				var_115_0.localEulerAngles = var_115_6
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_115_7 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_7.x, var_115_7.y, var_115_7.z)

				local var_115_8 = var_115_0.localEulerAngles

				var_115_8.z = 0
				var_115_8.x = 0
				var_115_0.localEulerAngles = var_115_8
			end

			local var_115_9 = arg_112_1.actors_["1084ui_story"]
			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1084ui_story == nil then
				arg_112_1.var_.characterEffect1084ui_story = var_115_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_11 = 0.200000002980232

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_11 and not isNil(var_115_9) then
				local var_115_12 = (arg_112_1.time_ - var_115_10) / var_115_11

				if arg_112_1.var_.characterEffect1084ui_story and not isNil(var_115_9) then
					arg_112_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_10 + var_115_11 and arg_112_1.time_ < var_115_10 + var_115_11 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1084ui_story then
				arg_112_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_115_13 = arg_112_1.actors_["1019ui_story"]
			local var_115_14 = 0

			if var_115_14 < arg_112_1.time_ and arg_112_1.time_ <= var_115_14 + arg_115_0 and not isNil(var_115_13) and arg_112_1.var_.characterEffect1019ui_story == nil then
				arg_112_1.var_.characterEffect1019ui_story = var_115_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_15 = 0.200000002980232

			if var_115_14 <= arg_112_1.time_ and arg_112_1.time_ < var_115_14 + var_115_15 and not isNil(var_115_13) then
				local var_115_16 = (arg_112_1.time_ - var_115_14) / var_115_15

				if arg_112_1.var_.characterEffect1019ui_story and not isNil(var_115_13) then
					local var_115_17 = Mathf.Lerp(0, 0.5, var_115_16)

					arg_112_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1019ui_story.fillRatio = var_115_17
				end
			end

			if arg_112_1.time_ >= var_115_14 + var_115_15 and arg_112_1.time_ < var_115_14 + var_115_15 + arg_115_0 and not isNil(var_115_13) and arg_112_1.var_.characterEffect1019ui_story then
				local var_115_18 = 0.5

				arg_112_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1019ui_story.fillRatio = var_115_18
			end

			local var_115_19 = 0

			if var_115_19 < arg_112_1.time_ and arg_112_1.time_ <= var_115_19 + arg_115_0 then
				arg_112_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_115_20 = 0

			if var_115_20 < arg_112_1.time_ and arg_112_1.time_ <= var_115_20 + arg_115_0 then
				arg_112_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_115_21 = 0
			local var_115_22 = 0.3

			if var_115_21 < arg_112_1.time_ and arg_112_1.time_ <= var_115_21 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_23 = arg_112_1:FormatText(StoryNameCfg[6].name)

				arg_112_1.leftNameTxt_.text = var_115_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_24 = arg_112_1:GetWordFromCfg(301031028)
				local var_115_25 = arg_112_1:FormatText(var_115_24.content)

				arg_112_1.text_.text = var_115_25

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_26 = 12
				local var_115_27 = utf8.len(var_115_25)
				local var_115_28 = var_115_26 <= 0 and var_115_22 or var_115_22 * (var_115_27 / var_115_26)

				if var_115_28 > 0 and var_115_22 < var_115_28 then
					arg_112_1.talkMaxDuration = var_115_28

					if var_115_28 + var_115_21 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_28 + var_115_21
					end
				end

				arg_112_1.text_.text = var_115_25
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031028", "story_v_out_301031.awb") ~= 0 then
					local var_115_29 = manager.audio:GetVoiceLength("story_v_out_301031", "301031028", "story_v_out_301031.awb") / 1000

					if var_115_29 + var_115_21 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_29 + var_115_21
					end

					if var_115_24.prefab_name ~= "" and arg_112_1.actors_[var_115_24.prefab_name] ~= nil then
						local var_115_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_24.prefab_name].transform, "story_v_out_301031", "301031028", "story_v_out_301031.awb")

						arg_112_1:RecordAudio("301031028", var_115_30)
						arg_112_1:RecordAudio("301031028", var_115_30)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_301031", "301031028", "story_v_out_301031.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_301031", "301031028", "story_v_out_301031.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_31 = math.max(var_115_22, arg_112_1.talkMaxDuration)

			if var_115_21 <= arg_112_1.time_ and arg_112_1.time_ < var_115_21 + var_115_31 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_21) / var_115_31

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_21 + var_115_31 and arg_112_1.time_ < var_115_21 + var_115_31 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play301031029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 301031029
		arg_116_1.duration_ = 8.6

		local var_116_0 = {
			zh = 7.266,
			ja = 8.6
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
				arg_116_0:Play301031030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1019ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1019ui_story == nil then
				arg_116_1.var_.characterEffect1019ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1019ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1019ui_story then
				arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_119_4 = arg_116_1.actors_["1084ui_story"]
			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect1084ui_story == nil then
				arg_116_1.var_.characterEffect1084ui_story = var_119_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_6 = 0.200000002980232

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 and not isNil(var_119_4) then
				local var_119_7 = (arg_116_1.time_ - var_119_5) / var_119_6

				if arg_116_1.var_.characterEffect1084ui_story and not isNil(var_119_4) then
					local var_119_8 = Mathf.Lerp(0, 0.5, var_119_7)

					arg_116_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1084ui_story.fillRatio = var_119_8
				end
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect1084ui_story then
				local var_119_9 = 0.5

				arg_116_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1084ui_story.fillRatio = var_119_9
			end

			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_119_11 = 0

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_119_12 = 0
			local var_119_13 = 0.825

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_14 = arg_116_1:FormatText(StoryNameCfg[13].name)

				arg_116_1.leftNameTxt_.text = var_119_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_15 = arg_116_1:GetWordFromCfg(301031029)
				local var_119_16 = arg_116_1:FormatText(var_119_15.content)

				arg_116_1.text_.text = var_119_16

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_17 = 34
				local var_119_18 = utf8.len(var_119_16)
				local var_119_19 = var_119_17 <= 0 and var_119_13 or var_119_13 * (var_119_18 / var_119_17)

				if var_119_19 > 0 and var_119_13 < var_119_19 then
					arg_116_1.talkMaxDuration = var_119_19

					if var_119_19 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_19 + var_119_12
					end
				end

				arg_116_1.text_.text = var_119_16
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031029", "story_v_out_301031.awb") ~= 0 then
					local var_119_20 = manager.audio:GetVoiceLength("story_v_out_301031", "301031029", "story_v_out_301031.awb") / 1000

					if var_119_20 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_20 + var_119_12
					end

					if var_119_15.prefab_name ~= "" and arg_116_1.actors_[var_119_15.prefab_name] ~= nil then
						local var_119_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_15.prefab_name].transform, "story_v_out_301031", "301031029", "story_v_out_301031.awb")

						arg_116_1:RecordAudio("301031029", var_119_21)
						arg_116_1:RecordAudio("301031029", var_119_21)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_301031", "301031029", "story_v_out_301031.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_301031", "301031029", "story_v_out_301031.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_22 = math.max(var_119_13, arg_116_1.talkMaxDuration)

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_22 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_12) / var_119_22

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_12 + var_119_22 and arg_116_1.time_ < var_119_12 + var_119_22 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play301031030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 301031030
		arg_120_1.duration_ = 3.83

		local var_120_0 = {
			zh = 3.066,
			ja = 3.833
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
			arg_120_1.auto_ = false
		end

		function arg_120_1.playNext_(arg_122_0)
			arg_120_1.onStoryFinished_()
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_2 = 0
			local var_123_3 = 0.4

			if var_123_2 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_4 = arg_120_1:FormatText(StoryNameCfg[13].name)

				arg_120_1.leftNameTxt_.text = var_123_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_5 = arg_120_1:GetWordFromCfg(301031030)
				local var_123_6 = arg_120_1:FormatText(var_123_5.content)

				arg_120_1.text_.text = var_123_6

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_7 = 16
				local var_123_8 = utf8.len(var_123_6)
				local var_123_9 = var_123_7 <= 0 and var_123_3 or var_123_3 * (var_123_8 / var_123_7)

				if var_123_9 > 0 and var_123_3 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_6
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301031", "301031030", "story_v_out_301031.awb") ~= 0 then
					local var_123_10 = manager.audio:GetVoiceLength("story_v_out_301031", "301031030", "story_v_out_301031.awb") / 1000

					if var_123_10 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_2
					end

					if var_123_5.prefab_name ~= "" and arg_120_1.actors_[var_123_5.prefab_name] ~= nil then
						local var_123_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_5.prefab_name].transform, "story_v_out_301031", "301031030", "story_v_out_301031.awb")

						arg_120_1:RecordAudio("301031030", var_123_11)
						arg_120_1:RecordAudio("301031030", var_123_11)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_301031", "301031030", "story_v_out_301031.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_301031", "301031030", "story_v_out_301031.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_12 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_12 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_12

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_12 and arg_120_1.time_ < var_123_2 + var_123_12 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST07b"
	},
	voices = {
		"story_v_out_301031.awb"
	}
}
