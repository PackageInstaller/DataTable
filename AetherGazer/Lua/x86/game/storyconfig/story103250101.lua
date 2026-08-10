return {
	Play325011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325011001
		arg_1_1.duration_ = 3.73

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2015"

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
				local var_4_5 = arg_1_1.bgs_.ST2015

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
					if iter_4_0 ~= "ST2015" then
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

			local var_4_24 = "1077ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1077ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1077ui_story"].transform
			local var_4_30 = 1.73333333333333

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1077ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, 100, 0)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1077ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, 100, 0)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_29.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_29.localEulerAngles = var_4_38

				local var_4_39 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_39 then
					var_4_39:EnableDynamicBone(true)
				end
			end

			local var_4_40 = arg_1_1.actors_["1077ui_story"]
			local var_4_41 = 1.73333333333333

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect1077ui_story == nil then
				arg_1_1.var_.characterEffect1077ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect1077ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect1077ui_story then
				arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_4_44 = 1.73333333333333

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_4_45 = 1.73333333333333

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_4_46 = 0.1
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "effect"

				arg_1_1:AudioAction(var_4_48, var_4_49, "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			local var_4_50 = 0.1
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "effect"

				arg_1_1:AudioAction(var_4_52, var_4_53, "se_story_143", "se_story_143_amb_town", "")
			end

			local var_4_54 = 1
			local var_4_55 = 1

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_56 = "play"
				local var_4_57 = "music"

				arg_1_1:AudioAction(var_4_56, var_4_57, "bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily.awb")

				local var_4_58 = ""
				local var_4_59 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily")

				if var_4_59 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_59 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_59

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_59
						arg_1_1.bgmTxt2_.text = var_4_59
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

			local var_4_60 = 1.93333333631357
			local var_4_61 = 0.175

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_62 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_62:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[1467].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_64 = arg_1_1:GetWordFromCfg(325011001)
				local var_4_65 = arg_1_1:FormatText(var_4_64.content)

				arg_1_1.text_.text = var_4_65

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_66 = 7
				local var_4_67 = utf8.len(var_4_65)
				local var_4_68 = var_4_66 <= 0 and var_4_61 or var_4_61 * (var_4_67 / var_4_66)

				if var_4_68 > 0 and var_4_61 < var_4_68 then
					arg_1_1.talkMaxDuration = var_4_68
					var_4_60 = var_4_60 + 0.3

					if var_4_68 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_60
					end
				end

				arg_1_1.text_.text = var_4_65
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011001", "story_v_out_325011.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_out_325011", "325011001", "story_v_out_325011.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_out_325011", "325011001", "story_v_out_325011.awb")

						arg_1_1:RecordAudio("325011001", var_4_70)
						arg_1_1:RecordAudio("325011001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325011", "325011001", "story_v_out_325011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325011", "325011001", "story_v_out_325011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_71 = var_4_60 + 0.3
			local var_4_72 = math.max(var_4_61, arg_1_1.talkMaxDuration)

			if var_4_71 <= arg_1_1.time_ and arg_1_1.time_ < var_4_71 + var_4_72 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_71) / var_4_72

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_71 + var_4_72 and arg_1_1.time_ < var_4_71 + var_4_72 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325011002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1077ui_story"].transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.moveOldPos1077ui_story = var_11_0.localPosition

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end
			end

			local var_11_3 = 0.001

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_3 then
				local var_11_4 = (arg_8_1.time_ - var_11_1) / var_11_3
				local var_11_5 = Vector3.New(0, 100, 0)

				var_11_0.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1077ui_story, var_11_5, var_11_4)

				local var_11_6 = manager.ui.mainCamera.transform.position - var_11_0.position

				var_11_0.forward = Vector3.New(var_11_6.x, var_11_6.y, var_11_6.z)

				local var_11_7 = var_11_0.localEulerAngles

				var_11_7.z = 0
				var_11_7.x = 0
				var_11_0.localEulerAngles = var_11_7
			end

			if arg_8_1.time_ >= var_11_1 + var_11_3 and arg_8_1.time_ < var_11_1 + var_11_3 + arg_11_0 then
				var_11_0.localPosition = Vector3.New(0, 100, 0)

				local var_11_8 = manager.ui.mainCamera.transform.position - var_11_0.position

				var_11_0.forward = Vector3.New(var_11_8.x, var_11_8.y, var_11_8.z)

				local var_11_9 = var_11_0.localEulerAngles

				var_11_9.z = 0
				var_11_9.x = 0
				var_11_0.localEulerAngles = var_11_9

				local var_11_10 = GameObjectTools.GetOrAddComponent(var_11_0.gameObject, typeof(DynamicBoneHelper))

				if var_11_10 then
					var_11_10:EnableDynamicBone(true)
				end
			end

			local var_11_11 = arg_8_1.actors_["1077ui_story"]
			local var_11_12 = 0

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect1077ui_story == nil then
				arg_8_1.var_.characterEffect1077ui_story = var_11_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_13 = 0.200000002980232

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_13 and not isNil(var_11_11) then
				local var_11_14 = (arg_8_1.time_ - var_11_12) / var_11_13

				if arg_8_1.var_.characterEffect1077ui_story and not isNil(var_11_11) then
					local var_11_15 = Mathf.Lerp(0, 0.5, var_11_14)

					arg_8_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1077ui_story.fillRatio = var_11_15
				end
			end

			if arg_8_1.time_ >= var_11_12 + var_11_13 and arg_8_1.time_ < var_11_12 + var_11_13 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect1077ui_story then
				local var_11_16 = 0.5

				arg_8_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1077ui_story.fillRatio = var_11_16
			end

			local var_11_17 = 0
			local var_11_18 = 1.35

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_19 = arg_8_1:GetWordFromCfg(325011002)
				local var_11_20 = arg_8_1:FormatText(var_11_19.content)

				arg_8_1.text_.text = var_11_20

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_21 = 54
				local var_11_22 = utf8.len(var_11_20)
				local var_11_23 = var_11_21 <= 0 and var_11_18 or var_11_18 * (var_11_22 / var_11_21)

				if var_11_23 > 0 and var_11_18 < var_11_23 then
					arg_8_1.talkMaxDuration = var_11_23

					if var_11_23 + var_11_17 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_23 + var_11_17
					end
				end

				arg_8_1.text_.text = var_11_20
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_24 = math.max(var_11_18, arg_8_1.talkMaxDuration)

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_24 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_17) / var_11_24

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_17 + var_11_24 and arg_8_1.time_ < var_11_17 + var_11_24 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325011003
		arg_12_1.duration_ = 2.8

		local var_12_0 = {
			zh = 2.7,
			ja = 2.8
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
				arg_12_0:Play325011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1077ui_story"].transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos1077ui_story = var_15_0.localPosition

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end
			end

			local var_15_3 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_3 then
				local var_15_4 = (arg_12_1.time_ - var_15_1) / var_15_3
				local var_15_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1077ui_story, var_15_5, var_15_4)

				local var_15_6 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_6.x, var_15_6.y, var_15_6.z)

				local var_15_7 = var_15_0.localEulerAngles

				var_15_7.z = 0
				var_15_7.x = 0
				var_15_0.localEulerAngles = var_15_7
			end

			if arg_12_1.time_ >= var_15_1 + var_15_3 and arg_12_1.time_ < var_15_1 + var_15_3 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_15_8 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_8.x, var_15_8.y, var_15_8.z)

				local var_15_9 = var_15_0.localEulerAngles

				var_15_9.z = 0
				var_15_9.x = 0
				var_15_0.localEulerAngles = var_15_9

				local var_15_10 = GameObjectTools.GetOrAddComponent(var_15_0.gameObject, typeof(DynamicBoneHelper))

				if var_15_10 then
					var_15_10:EnableDynamicBone(true)
				end
			end

			local var_15_11 = arg_12_1.actors_["1077ui_story"]
			local var_15_12 = 0

			if var_15_12 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 and not isNil(var_15_11) and arg_12_1.var_.characterEffect1077ui_story == nil then
				arg_12_1.var_.characterEffect1077ui_story = var_15_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_13 = 0.200000002980232

			if var_15_12 <= arg_12_1.time_ and arg_12_1.time_ < var_15_12 + var_15_13 and not isNil(var_15_11) then
				local var_15_14 = (arg_12_1.time_ - var_15_12) / var_15_13

				if arg_12_1.var_.characterEffect1077ui_story and not isNil(var_15_11) then
					arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_12 + var_15_13 and arg_12_1.time_ < var_15_12 + var_15_13 + arg_15_0 and not isNil(var_15_11) and arg_12_1.var_.characterEffect1077ui_story then
				arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 then
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_15_17 = 0
			local var_15_18 = 0.25

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_19 = arg_12_1:FormatText(StoryNameCfg[1467].name)

				arg_12_1.leftNameTxt_.text = var_15_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_20 = arg_12_1:GetWordFromCfg(325011003)
				local var_15_21 = arg_12_1:FormatText(var_15_20.content)

				arg_12_1.text_.text = var_15_21

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_22 = 10
				local var_15_23 = utf8.len(var_15_21)
				local var_15_24 = var_15_22 <= 0 and var_15_18 or var_15_18 * (var_15_23 / var_15_22)

				if var_15_24 > 0 and var_15_18 < var_15_24 then
					arg_12_1.talkMaxDuration = var_15_24

					if var_15_24 + var_15_17 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_24 + var_15_17
					end
				end

				arg_12_1.text_.text = var_15_21
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011003", "story_v_out_325011.awb") ~= 0 then
					local var_15_25 = manager.audio:GetVoiceLength("story_v_out_325011", "325011003", "story_v_out_325011.awb") / 1000

					if var_15_25 + var_15_17 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_25 + var_15_17
					end

					if var_15_20.prefab_name ~= "" and arg_12_1.actors_[var_15_20.prefab_name] ~= nil then
						local var_15_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_20.prefab_name].transform, "story_v_out_325011", "325011003", "story_v_out_325011.awb")

						arg_12_1:RecordAudio("325011003", var_15_26)
						arg_12_1:RecordAudio("325011003", var_15_26)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325011", "325011003", "story_v_out_325011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325011", "325011003", "story_v_out_325011.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_27 = math.max(var_15_18, arg_12_1.talkMaxDuration)

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_27 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_17) / var_15_27

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_17 + var_15_27 and arg_12_1.time_ < var_15_17 + var_15_27 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325011004
		arg_16_1.duration_ = 6.07

		local var_16_0 = {
			zh = 4.9,
			ja = 6.066
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
				arg_16_0:Play325011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1077ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1077ui_story == nil then
				arg_16_1.var_.characterEffect1077ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1077ui_story and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1077ui_story.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1077ui_story then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1077ui_story.fillRatio = var_19_5
			end

			local var_19_6 = 0
			local var_19_7 = 0.6

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[1465].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_9 = arg_16_1:GetWordFromCfg(325011004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011004", "story_v_out_325011.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011004", "story_v_out_325011.awb") / 1000

					if var_19_14 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_6
					end

					if var_19_9.prefab_name ~= "" and arg_16_1.actors_[var_19_9.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_9.prefab_name].transform, "story_v_out_325011", "325011004", "story_v_out_325011.awb")

						arg_16_1:RecordAudio("325011004", var_19_15)
						arg_16_1:RecordAudio("325011004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325011", "325011004", "story_v_out_325011.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325011", "325011004", "story_v_out_325011.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_16 and arg_16_1.time_ < var_19_6 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play325011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325011005
		arg_20_1.duration_ = 6.7

		local var_20_0 = {
			zh = 4.566,
			ja = 6.7
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
				arg_20_0:Play325011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1077ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1077ui_story == nil then
				arg_20_1.var_.characterEffect1077ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1077ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1077ui_story then
				arg_20_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_23_4 = 0

			if var_23_4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_23_6 = 0
			local var_23_7 = 0.475

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[1467].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_9 = arg_20_1:GetWordFromCfg(325011005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011005", "story_v_out_325011.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011005", "story_v_out_325011.awb") / 1000

					if var_23_14 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_6
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_325011", "325011005", "story_v_out_325011.awb")

						arg_20_1:RecordAudio("325011005", var_23_15)
						arg_20_1:RecordAudio("325011005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325011", "325011005", "story_v_out_325011.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325011", "325011005", "story_v_out_325011.awb")
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
	Play325011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325011006
		arg_24_1.duration_ = 12.5

		local var_24_0 = {
			zh = 7.133,
			ja = 12.5
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
				arg_24_0:Play325011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1077ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1077ui_story == nil then
				arg_24_1.var_.characterEffect1077ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1077ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1077ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1077ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1077ui_story.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 0.875

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[1465].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_9 = arg_24_1:GetWordFromCfg(325011006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 35
				local var_27_12 = utf8.len(var_27_10)
				local var_27_13 = var_27_11 <= 0 and var_27_7 or var_27_7 * (var_27_12 / var_27_11)

				if var_27_13 > 0 and var_27_7 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011006", "story_v_out_325011.awb") ~= 0 then
					local var_27_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011006", "story_v_out_325011.awb") / 1000

					if var_27_14 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_6
					end

					if var_27_9.prefab_name ~= "" and arg_24_1.actors_[var_27_9.prefab_name] ~= nil then
						local var_27_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_9.prefab_name].transform, "story_v_out_325011", "325011006", "story_v_out_325011.awb")

						arg_24_1:RecordAudio("325011006", var_27_15)
						arg_24_1:RecordAudio("325011006", var_27_15)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325011", "325011006", "story_v_out_325011.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325011", "325011006", "story_v_out_325011.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_16 and arg_24_1.time_ < var_27_6 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325011007
		arg_28_1.duration_ = 8.6

		local var_28_0 = {
			zh = 7.5,
			ja = 8.6
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
				arg_28_0:Play325011008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.95

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[1465].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(325011007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011007", "story_v_out_325011.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011007", "story_v_out_325011.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_325011", "325011007", "story_v_out_325011.awb")

						arg_28_1:RecordAudio("325011007", var_31_9)
						arg_28_1:RecordAudio("325011007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325011", "325011007", "story_v_out_325011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325011", "325011007", "story_v_out_325011.awb")
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
	Play325011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325011008
		arg_32_1.duration_ = 8

		local var_32_0 = {
			zh = 8,
			ja = 5.433
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
				arg_32_0:Play325011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1077ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1077ui_story == nil then
				arg_32_1.var_.characterEffect1077ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1077ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1077ui_story then
				arg_32_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_35_4 = 0

			if var_35_4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_35_5 = 0
			local var_35_6 = 0.8

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_7 = arg_32_1:FormatText(StoryNameCfg[1467].name)

				arg_32_1.leftNameTxt_.text = var_35_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_8 = arg_32_1:GetWordFromCfg(325011008)
				local var_35_9 = arg_32_1:FormatText(var_35_8.content)

				arg_32_1.text_.text = var_35_9

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_10 = 32
				local var_35_11 = utf8.len(var_35_9)
				local var_35_12 = var_35_10 <= 0 and var_35_6 or var_35_6 * (var_35_11 / var_35_10)

				if var_35_12 > 0 and var_35_6 < var_35_12 then
					arg_32_1.talkMaxDuration = var_35_12

					if var_35_12 + var_35_5 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_5
					end
				end

				arg_32_1.text_.text = var_35_9
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011008", "story_v_out_325011.awb") ~= 0 then
					local var_35_13 = manager.audio:GetVoiceLength("story_v_out_325011", "325011008", "story_v_out_325011.awb") / 1000

					if var_35_13 + var_35_5 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_5
					end

					if var_35_8.prefab_name ~= "" and arg_32_1.actors_[var_35_8.prefab_name] ~= nil then
						local var_35_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_8.prefab_name].transform, "story_v_out_325011", "325011008", "story_v_out_325011.awb")

						arg_32_1:RecordAudio("325011008", var_35_14)
						arg_32_1:RecordAudio("325011008", var_35_14)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325011", "325011008", "story_v_out_325011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325011", "325011008", "story_v_out_325011.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_15 = math.max(var_35_6, arg_32_1.talkMaxDuration)

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_15 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_5) / var_35_15

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_5 + var_35_15 and arg_32_1.time_ < var_35_5 + var_35_15 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325011009
		arg_36_1.duration_ = 10.1

		local var_36_0 = {
			zh = 8.866,
			ja = 10.1
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
				arg_36_0:Play325011010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1077ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1077ui_story == nil then
				arg_36_1.var_.characterEffect1077ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1077ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1077ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1077ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1077ui_story.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 1.05

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[1465].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_9 = arg_36_1:GetWordFromCfg(325011009)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 42
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_7 or var_39_7 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_7 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011009", "story_v_out_325011.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011009", "story_v_out_325011.awb") / 1000

					if var_39_14 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_6
					end

					if var_39_9.prefab_name ~= "" and arg_36_1.actors_[var_39_9.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_9.prefab_name].transform, "story_v_out_325011", "325011009", "story_v_out_325011.awb")

						arg_36_1:RecordAudio("325011009", var_39_15)
						arg_36_1:RecordAudio("325011009", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325011", "325011009", "story_v_out_325011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325011", "325011009", "story_v_out_325011.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_16 and arg_36_1.time_ < var_39_6 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play325011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325011010
		arg_40_1.duration_ = 10.33

		local var_40_0 = {
			zh = 8.133,
			ja = 10.333
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
				arg_40_0:Play325011011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.875

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[1465].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(325011010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 35
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011010", "story_v_out_325011.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011010", "story_v_out_325011.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_325011", "325011010", "story_v_out_325011.awb")

						arg_40_1:RecordAudio("325011010", var_43_9)
						arg_40_1:RecordAudio("325011010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325011", "325011010", "story_v_out_325011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325011", "325011010", "story_v_out_325011.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325011011
		arg_44_1.duration_ = 2.73

		local var_44_0 = {
			zh = 1.999999999999,
			ja = 2.733
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
				arg_44_0:Play325011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1077ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1077ui_story == nil then
				arg_44_1.var_.characterEffect1077ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1077ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1077ui_story then
				arg_44_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_47_4 = 0

			if var_47_4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_47_5 = 0
			local var_47_6 = 0.15

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_7 = arg_44_1:FormatText(StoryNameCfg[1467].name)

				arg_44_1.leftNameTxt_.text = var_47_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_8 = arg_44_1:GetWordFromCfg(325011011)
				local var_47_9 = arg_44_1:FormatText(var_47_8.content)

				arg_44_1.text_.text = var_47_9

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_10 = 6
				local var_47_11 = utf8.len(var_47_9)
				local var_47_12 = var_47_10 <= 0 and var_47_6 or var_47_6 * (var_47_11 / var_47_10)

				if var_47_12 > 0 and var_47_6 < var_47_12 then
					arg_44_1.talkMaxDuration = var_47_12

					if var_47_12 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_5
					end
				end

				arg_44_1.text_.text = var_47_9
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011011", "story_v_out_325011.awb") ~= 0 then
					local var_47_13 = manager.audio:GetVoiceLength("story_v_out_325011", "325011011", "story_v_out_325011.awb") / 1000

					if var_47_13 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_5
					end

					if var_47_8.prefab_name ~= "" and arg_44_1.actors_[var_47_8.prefab_name] ~= nil then
						local var_47_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_8.prefab_name].transform, "story_v_out_325011", "325011011", "story_v_out_325011.awb")

						arg_44_1:RecordAudio("325011011", var_47_14)
						arg_44_1:RecordAudio("325011011", var_47_14)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325011", "325011011", "story_v_out_325011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325011", "325011011", "story_v_out_325011.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_15 = math.max(var_47_6, arg_44_1.talkMaxDuration)

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_15 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_5) / var_47_15

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_5 + var_47_15 and arg_44_1.time_ < var_47_5 + var_47_15 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play325011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325011012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325011013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1077ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos1077ui_story = var_51_0.localPosition

				local var_51_2 = GameObjectTools.GetOrAddComponent(var_51_0.gameObject, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(false)
				end
			end

			local var_51_3 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_3 then
				local var_51_4 = (arg_48_1.time_ - var_51_1) / var_51_3
				local var_51_5 = Vector3.New(0, 100, 0)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1077ui_story, var_51_5, var_51_4)

				local var_51_6 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_6.x, var_51_6.y, var_51_6.z)

				local var_51_7 = var_51_0.localEulerAngles

				var_51_7.z = 0
				var_51_7.x = 0
				var_51_0.localEulerAngles = var_51_7
			end

			if arg_48_1.time_ >= var_51_1 + var_51_3 and arg_48_1.time_ < var_51_1 + var_51_3 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0, 100, 0)

				local var_51_8 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_8.x, var_51_8.y, var_51_8.z)

				local var_51_9 = var_51_0.localEulerAngles

				var_51_9.z = 0
				var_51_9.x = 0
				var_51_0.localEulerAngles = var_51_9

				local var_51_10 = GameObjectTools.GetOrAddComponent(var_51_0.gameObject, typeof(DynamicBoneHelper))

				if var_51_10 then
					var_51_10:EnableDynamicBone(true)
				end
			end

			local var_51_11 = arg_48_1.actors_["1077ui_story"]
			local var_51_12 = 0

			if var_51_12 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 and not isNil(var_51_11) and arg_48_1.var_.characterEffect1077ui_story == nil then
				arg_48_1.var_.characterEffect1077ui_story = var_51_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_13 = 0.200000002980232

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_13 and not isNil(var_51_11) then
				local var_51_14 = (arg_48_1.time_ - var_51_12) / var_51_13

				if arg_48_1.var_.characterEffect1077ui_story and not isNil(var_51_11) then
					local var_51_15 = Mathf.Lerp(0, 0.5, var_51_14)

					arg_48_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1077ui_story.fillRatio = var_51_15
				end
			end

			if arg_48_1.time_ >= var_51_12 + var_51_13 and arg_48_1.time_ < var_51_12 + var_51_13 + arg_51_0 and not isNil(var_51_11) and arg_48_1.var_.characterEffect1077ui_story then
				local var_51_16 = 0.5

				arg_48_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1077ui_story.fillRatio = var_51_16
			end

			local var_51_17 = 0
			local var_51_18 = 1.35

			if var_51_17 < arg_48_1.time_ and arg_48_1.time_ <= var_51_17 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_19 = arg_48_1:GetWordFromCfg(325011012)
				local var_51_20 = arg_48_1:FormatText(var_51_19.content)

				arg_48_1.text_.text = var_51_20

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_21 = 54
				local var_51_22 = utf8.len(var_51_20)
				local var_51_23 = var_51_21 <= 0 and var_51_18 or var_51_18 * (var_51_22 / var_51_21)

				if var_51_23 > 0 and var_51_18 < var_51_23 then
					arg_48_1.talkMaxDuration = var_51_23

					if var_51_23 + var_51_17 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_17
					end
				end

				arg_48_1.text_.text = var_51_20
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_24 = math.max(var_51_18, arg_48_1.talkMaxDuration)

			if var_51_17 <= arg_48_1.time_ and arg_48_1.time_ < var_51_17 + var_51_24 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_17) / var_51_24

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_17 + var_51_24 and arg_48_1.time_ < var_51_17 + var_51_24 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325011013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325011013
		arg_52_1.duration_ = 2.83

		local var_52_0 = {
			zh = 2.833,
			ja = 2.633
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
				arg_52_0:Play325011014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1077ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1077ui_story = var_55_0.localPosition

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end
			end

			local var_55_3 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_3 then
				local var_55_4 = (arg_52_1.time_ - var_55_1) / var_55_3
				local var_55_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1077ui_story, var_55_5, var_55_4)

				local var_55_6 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_6.x, var_55_6.y, var_55_6.z)

				local var_55_7 = var_55_0.localEulerAngles

				var_55_7.z = 0
				var_55_7.x = 0
				var_55_0.localEulerAngles = var_55_7
			end

			if arg_52_1.time_ >= var_55_1 + var_55_3 and arg_52_1.time_ < var_55_1 + var_55_3 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_55_8 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_8.x, var_55_8.y, var_55_8.z)

				local var_55_9 = var_55_0.localEulerAngles

				var_55_9.z = 0
				var_55_9.x = 0
				var_55_0.localEulerAngles = var_55_9

				local var_55_10 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_10 then
					var_55_10:EnableDynamicBone(true)
				end
			end

			local var_55_11 = arg_52_1.actors_["1077ui_story"]
			local var_55_12 = 0

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 and not isNil(var_55_11) and arg_52_1.var_.characterEffect1077ui_story == nil then
				arg_52_1.var_.characterEffect1077ui_story = var_55_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_13 = 0.200000002980232

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_13 and not isNil(var_55_11) then
				local var_55_14 = (arg_52_1.time_ - var_55_12) / var_55_13

				if arg_52_1.var_.characterEffect1077ui_story and not isNil(var_55_11) then
					arg_52_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_12 + var_55_13 and arg_52_1.time_ < var_55_12 + var_55_13 + arg_55_0 and not isNil(var_55_11) and arg_52_1.var_.characterEffect1077ui_story then
				arg_52_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_55_15 = 0
			local var_55_16 = 0.225

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_17 = arg_52_1:FormatText(StoryNameCfg[1467].name)

				arg_52_1.leftNameTxt_.text = var_55_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_18 = arg_52_1:GetWordFromCfg(325011013)
				local var_55_19 = arg_52_1:FormatText(var_55_18.content)

				arg_52_1.text_.text = var_55_19

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_20 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011013", "story_v_out_325011.awb") ~= 0 then
					local var_55_23 = manager.audio:GetVoiceLength("story_v_out_325011", "325011013", "story_v_out_325011.awb") / 1000

					if var_55_23 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_15
					end

					if var_55_18.prefab_name ~= "" and arg_52_1.actors_[var_55_18.prefab_name] ~= nil then
						local var_55_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_18.prefab_name].transform, "story_v_out_325011", "325011013", "story_v_out_325011.awb")

						arg_52_1:RecordAudio("325011013", var_55_24)
						arg_52_1:RecordAudio("325011013", var_55_24)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325011", "325011013", "story_v_out_325011.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325011", "325011013", "story_v_out_325011.awb")
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
				actorName = "1077ui_story",
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
	Play325011014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325011014
		arg_56_1.duration_ = 5.8

		local var_56_0 = {
			zh = 4.1,
			ja = 5.8
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
				arg_56_0:Play325011015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1077ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1077ui_story == nil then
				arg_56_1.var_.characterEffect1077ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1077ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1077ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1077ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1077ui_story.fillRatio = var_59_5
			end

			local var_59_6 = 0
			local var_59_7 = 0.45

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[688].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_9 = arg_56_1:GetWordFromCfg(325011014)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 18
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011014", "story_v_out_325011.awb") ~= 0 then
					local var_59_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011014", "story_v_out_325011.awb") / 1000

					if var_59_14 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_6
					end

					if var_59_9.prefab_name ~= "" and arg_56_1.actors_[var_59_9.prefab_name] ~= nil then
						local var_59_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_9.prefab_name].transform, "story_v_out_325011", "325011014", "story_v_out_325011.awb")

						arg_56_1:RecordAudio("325011014", var_59_15)
						arg_56_1:RecordAudio("325011014", var_59_15)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325011", "325011014", "story_v_out_325011.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325011", "325011014", "story_v_out_325011.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_16 and arg_56_1.time_ < var_59_6 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play325011015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325011015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play325011016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1077ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos1077ui_story = var_63_0.localPosition

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end
			end

			local var_63_3 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_3 then
				local var_63_4 = (arg_60_1.time_ - var_63_1) / var_63_3
				local var_63_5 = Vector3.New(0, 100, 0)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1077ui_story, var_63_5, var_63_4)

				local var_63_6 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_6.x, var_63_6.y, var_63_6.z)

				local var_63_7 = var_63_0.localEulerAngles

				var_63_7.z = 0
				var_63_7.x = 0
				var_63_0.localEulerAngles = var_63_7
			end

			if arg_60_1.time_ >= var_63_1 + var_63_3 and arg_60_1.time_ < var_63_1 + var_63_3 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, 100, 0)

				local var_63_8 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_8.x, var_63_8.y, var_63_8.z)

				local var_63_9 = var_63_0.localEulerAngles

				var_63_9.z = 0
				var_63_9.x = 0
				var_63_0.localEulerAngles = var_63_9

				local var_63_10 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_10 then
					var_63_10:EnableDynamicBone(true)
				end
			end

			local var_63_11 = 0
			local var_63_12 = 1.05

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_13 = arg_60_1:GetWordFromCfg(325011015)
				local var_63_14 = arg_60_1:FormatText(var_63_13.content)

				arg_60_1.text_.text = var_63_14

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_15 = 42
				local var_63_16 = utf8.len(var_63_14)
				local var_63_17 = var_63_15 <= 0 and var_63_12 or var_63_12 * (var_63_16 / var_63_15)

				if var_63_17 > 0 and var_63_12 < var_63_17 then
					arg_60_1.talkMaxDuration = var_63_17

					if var_63_17 + var_63_11 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_17 + var_63_11
					end
				end

				arg_60_1.text_.text = var_63_14
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_18 = math.max(var_63_12, arg_60_1.talkMaxDuration)

			if var_63_11 <= arg_60_1.time_ and arg_60_1.time_ < var_63_11 + var_63_18 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_11) / var_63_18

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_11 + var_63_18 and arg_60_1.time_ < var_63_11 + var_63_18 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325011016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325011016
		arg_64_1.duration_ = 5.57

		local var_64_0 = {
			zh = 2.733,
			ja = 5.566
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
				arg_64_0:Play325011017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.3

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[688].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(325011016)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 12
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011016", "story_v_out_325011.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011016", "story_v_out_325011.awb") / 1000

					if var_67_8 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_0
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_325011", "325011016", "story_v_out_325011.awb")

						arg_64_1:RecordAudio("325011016", var_67_9)
						arg_64_1:RecordAudio("325011016", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325011", "325011016", "story_v_out_325011.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325011", "325011016", "story_v_out_325011.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_10 and arg_64_1.time_ < var_67_0 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play325011017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325011017
		arg_68_1.duration_ = 10.27

		local var_68_0 = {
			zh = 10.266,
			ja = 9.866
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
				arg_68_0:Play325011018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1077ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1077ui_story == nil then
				arg_68_1.var_.characterEffect1077ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1077ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1077ui_story then
				arg_68_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_71_4 = 0

			if var_71_4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_71_6 = arg_68_1.actors_["1077ui_story"].transform
			local var_71_7 = 0

			if var_71_7 < arg_68_1.time_ and arg_68_1.time_ <= var_71_7 + arg_71_0 then
				arg_68_1.var_.moveOldPos1077ui_story = var_71_6.localPosition

				local var_71_8 = GameObjectTools.GetOrAddComponent(var_71_6.gameObject, typeof(DynamicBoneHelper))

				if var_71_8 then
					var_71_8:EnableDynamicBone(false)
				end
			end

			local var_71_9 = 0.001

			if var_71_7 <= arg_68_1.time_ and arg_68_1.time_ < var_71_7 + var_71_9 then
				local var_71_10 = (arg_68_1.time_ - var_71_7) / var_71_9
				local var_71_11 = Vector3.New(-0.03, -1.02, -5.92)

				var_71_6.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1077ui_story, var_71_11, var_71_10)

				local var_71_12 = manager.ui.mainCamera.transform.position - var_71_6.position

				var_71_6.forward = Vector3.New(var_71_12.x, var_71_12.y, var_71_12.z)

				local var_71_13 = var_71_6.localEulerAngles

				var_71_13.z = 0
				var_71_13.x = 0
				var_71_6.localEulerAngles = var_71_13
			end

			if arg_68_1.time_ >= var_71_7 + var_71_9 and arg_68_1.time_ < var_71_7 + var_71_9 + arg_71_0 then
				var_71_6.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_71_14 = manager.ui.mainCamera.transform.position - var_71_6.position

				var_71_6.forward = Vector3.New(var_71_14.x, var_71_14.y, var_71_14.z)

				local var_71_15 = var_71_6.localEulerAngles

				var_71_15.z = 0
				var_71_15.x = 0
				var_71_6.localEulerAngles = var_71_15

				local var_71_16 = GameObjectTools.GetOrAddComponent(var_71_6.gameObject, typeof(DynamicBoneHelper))

				if var_71_16 then
					var_71_16:EnableDynamicBone(true)
				end
			end

			local var_71_17 = 0
			local var_71_18 = 1.1

			if var_71_17 < arg_68_1.time_ and arg_68_1.time_ <= var_71_17 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_19 = arg_68_1:FormatText(StoryNameCfg[1467].name)

				arg_68_1.leftNameTxt_.text = var_71_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_20 = arg_68_1:GetWordFromCfg(325011017)
				local var_71_21 = arg_68_1:FormatText(var_71_20.content)

				arg_68_1.text_.text = var_71_21

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_22 = 44
				local var_71_23 = utf8.len(var_71_21)
				local var_71_24 = var_71_22 <= 0 and var_71_18 or var_71_18 * (var_71_23 / var_71_22)

				if var_71_24 > 0 and var_71_18 < var_71_24 then
					arg_68_1.talkMaxDuration = var_71_24

					if var_71_24 + var_71_17 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_24 + var_71_17
					end
				end

				arg_68_1.text_.text = var_71_21
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011017", "story_v_out_325011.awb") ~= 0 then
					local var_71_25 = manager.audio:GetVoiceLength("story_v_out_325011", "325011017", "story_v_out_325011.awb") / 1000

					if var_71_25 + var_71_17 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_25 + var_71_17
					end

					if var_71_20.prefab_name ~= "" and arg_68_1.actors_[var_71_20.prefab_name] ~= nil then
						local var_71_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_20.prefab_name].transform, "story_v_out_325011", "325011017", "story_v_out_325011.awb")

						arg_68_1:RecordAudio("325011017", var_71_26)
						arg_68_1:RecordAudio("325011017", var_71_26)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325011", "325011017", "story_v_out_325011.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325011", "325011017", "story_v_out_325011.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_27 = math.max(var_71_18, arg_68_1.talkMaxDuration)

			if var_71_17 <= arg_68_1.time_ and arg_68_1.time_ < var_71_17 + var_71_27 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_17) / var_71_27

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_17 + var_71_27 and arg_68_1.time_ < var_71_17 + var_71_27 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325011018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325011018
		arg_72_1.duration_ = 9

		local var_72_0 = {
			zh = 5.333,
			ja = 9
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
				arg_72_0:Play325011019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1077ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1077ui_story == nil then
				arg_72_1.var_.characterEffect1077ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1077ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1077ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1077ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1077ui_story.fillRatio = var_75_5
			end

			local var_75_6 = 0
			local var_75_7 = 0.725

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_8 = arg_72_1:FormatText(StoryNameCfg[688].name)

				arg_72_1.leftNameTxt_.text = var_75_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_9 = arg_72_1:GetWordFromCfg(325011018)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 29
				local var_75_12 = utf8.len(var_75_10)
				local var_75_13 = var_75_11 <= 0 and var_75_7 or var_75_7 * (var_75_12 / var_75_11)

				if var_75_13 > 0 and var_75_7 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_10
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011018", "story_v_out_325011.awb") ~= 0 then
					local var_75_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011018", "story_v_out_325011.awb") / 1000

					if var_75_14 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_6
					end

					if var_75_9.prefab_name ~= "" and arg_72_1.actors_[var_75_9.prefab_name] ~= nil then
						local var_75_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_9.prefab_name].transform, "story_v_out_325011", "325011018", "story_v_out_325011.awb")

						arg_72_1:RecordAudio("325011018", var_75_15)
						arg_72_1:RecordAudio("325011018", var_75_15)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325011", "325011018", "story_v_out_325011.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325011", "325011018", "story_v_out_325011.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_16 and arg_72_1.time_ < var_75_6 + var_75_16 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play325011019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325011019
		arg_76_1.duration_ = 3.33

		local var_76_0 = {
			zh = 2.1,
			ja = 3.333
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
				arg_76_0:Play325011020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1077ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1077ui_story == nil then
				arg_76_1.var_.characterEffect1077ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1077ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1077ui_story then
				arg_76_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_79_4 = 0
			local var_79_5 = 0.225

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_6 = arg_76_1:FormatText(StoryNameCfg[1467].name)

				arg_76_1.leftNameTxt_.text = var_79_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_7 = arg_76_1:GetWordFromCfg(325011019)
				local var_79_8 = arg_76_1:FormatText(var_79_7.content)

				arg_76_1.text_.text = var_79_8

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 9
				local var_79_10 = utf8.len(var_79_8)
				local var_79_11 = var_79_9 <= 0 and var_79_5 or var_79_5 * (var_79_10 / var_79_9)

				if var_79_11 > 0 and var_79_5 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_8
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011019", "story_v_out_325011.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011019", "story_v_out_325011.awb") / 1000

					if var_79_12 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_4
					end

					if var_79_7.prefab_name ~= "" and arg_76_1.actors_[var_79_7.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_7.prefab_name].transform, "story_v_out_325011", "325011019", "story_v_out_325011.awb")

						arg_76_1:RecordAudio("325011019", var_79_13)
						arg_76_1:RecordAudio("325011019", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325011", "325011019", "story_v_out_325011.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325011", "325011019", "story_v_out_325011.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_14 and arg_76_1.time_ < var_79_4 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play325011020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325011020
		arg_80_1.duration_ = 10.63

		local var_80_0 = {
			zh = 5.9,
			ja = 10.633
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
				arg_80_0:Play325011021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1077ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1077ui_story == nil then
				arg_80_1.var_.characterEffect1077ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1077ui_story and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1077ui_story.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1077ui_story then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1077ui_story.fillRatio = var_83_5
			end

			local var_83_6 = 0
			local var_83_7 = 0.75

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_8 = arg_80_1:FormatText(StoryNameCfg[688].name)

				arg_80_1.leftNameTxt_.text = var_83_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_9 = arg_80_1:GetWordFromCfg(325011020)
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011020", "story_v_out_325011.awb") ~= 0 then
					local var_83_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011020", "story_v_out_325011.awb") / 1000

					if var_83_14 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_6
					end

					if var_83_9.prefab_name ~= "" and arg_80_1.actors_[var_83_9.prefab_name] ~= nil then
						local var_83_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_9.prefab_name].transform, "story_v_out_325011", "325011020", "story_v_out_325011.awb")

						arg_80_1:RecordAudio("325011020", var_83_15)
						arg_80_1:RecordAudio("325011020", var_83_15)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_325011", "325011020", "story_v_out_325011.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_325011", "325011020", "story_v_out_325011.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_16 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_16 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_16

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_16 and arg_80_1.time_ < var_83_6 + var_83_16 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play325011021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325011021
		arg_84_1.duration_ = 2.3

		local var_84_0 = {
			zh = 2.233,
			ja = 2.3
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
				arg_84_0:Play325011022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1077ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1077ui_story == nil then
				arg_84_1.var_.characterEffect1077ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1077ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1077ui_story then
				arg_84_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_87_4 = 0

			if var_87_4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077actionlink/1077action453")
			end

			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_87_6 = 0
			local var_87_7 = 0.275

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[1467].name)

				arg_84_1.leftNameTxt_.text = var_87_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_9 = arg_84_1:GetWordFromCfg(325011021)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011021", "story_v_out_325011.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011021", "story_v_out_325011.awb") / 1000

					if var_87_14 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_6
					end

					if var_87_9.prefab_name ~= "" and arg_84_1.actors_[var_87_9.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_9.prefab_name].transform, "story_v_out_325011", "325011021", "story_v_out_325011.awb")

						arg_84_1:RecordAudio("325011021", var_87_15)
						arg_84_1:RecordAudio("325011021", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_325011", "325011021", "story_v_out_325011.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_325011", "325011021", "story_v_out_325011.awb")
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
	Play325011022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325011022
		arg_88_1.duration_ = 9.2

		local var_88_0 = {
			zh = 5.4,
			ja = 9.2
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
				arg_88_0:Play325011023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1077ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1077ui_story == nil then
				arg_88_1.var_.characterEffect1077ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1077ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1077ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1077ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1077ui_story.fillRatio = var_91_5
			end

			local var_91_6 = 0
			local var_91_7 = 0.65

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[688].name)

				arg_88_1.leftNameTxt_.text = var_91_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_9 = arg_88_1:GetWordFromCfg(325011022)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 26
				local var_91_12 = utf8.len(var_91_10)
				local var_91_13 = var_91_11 <= 0 and var_91_7 or var_91_7 * (var_91_12 / var_91_11)

				if var_91_13 > 0 and var_91_7 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011022", "story_v_out_325011.awb") ~= 0 then
					local var_91_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011022", "story_v_out_325011.awb") / 1000

					if var_91_14 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_6
					end

					if var_91_9.prefab_name ~= "" and arg_88_1.actors_[var_91_9.prefab_name] ~= nil then
						local var_91_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_9.prefab_name].transform, "story_v_out_325011", "325011022", "story_v_out_325011.awb")

						arg_88_1:RecordAudio("325011022", var_91_15)
						arg_88_1:RecordAudio("325011022", var_91_15)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_325011", "325011022", "story_v_out_325011.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_325011", "325011022", "story_v_out_325011.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_16 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_16 and arg_88_1.time_ < var_91_6 + var_91_16 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play325011023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325011023
		arg_92_1.duration_ = 9.27

		local var_92_0 = {
			zh = 7.2,
			ja = 9.266
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
				arg_92_0:Play325011024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 1

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[688].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(325011023)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 40
				local var_95_6 = utf8.len(var_95_4)
				local var_95_7 = var_95_5 <= 0 and var_95_1 or var_95_1 * (var_95_6 / var_95_5)

				if var_95_7 > 0 and var_95_1 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011023", "story_v_out_325011.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011023", "story_v_out_325011.awb") / 1000

					if var_95_8 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_0
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_325011", "325011023", "story_v_out_325011.awb")

						arg_92_1:RecordAudio("325011023", var_95_9)
						arg_92_1:RecordAudio("325011023", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325011", "325011023", "story_v_out_325011.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325011", "325011023", "story_v_out_325011.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_10 and arg_92_1.time_ < var_95_0 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play325011024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325011024
		arg_96_1.duration_ = 1.5

		local var_96_0 = {
			zh = 1.1,
			ja = 1.5
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
				arg_96_0:Play325011025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1077ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1077ui_story == nil then
				arg_96_1.var_.characterEffect1077ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1077ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1077ui_story then
				arg_96_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_99_4 = 0
			local var_99_5 = 0.075

			if var_99_4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_6 = arg_96_1:FormatText(StoryNameCfg[1467].name)

				arg_96_1.leftNameTxt_.text = var_99_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_7 = arg_96_1:GetWordFromCfg(325011024)
				local var_99_8 = arg_96_1:FormatText(var_99_7.content)

				arg_96_1.text_.text = var_99_8

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 3
				local var_99_10 = utf8.len(var_99_8)
				local var_99_11 = var_99_9 <= 0 and var_99_5 or var_99_5 * (var_99_10 / var_99_9)

				if var_99_11 > 0 and var_99_5 < var_99_11 then
					arg_96_1.talkMaxDuration = var_99_11

					if var_99_11 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_11 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_8
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011024", "story_v_out_325011.awb") ~= 0 then
					local var_99_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011024", "story_v_out_325011.awb") / 1000

					if var_99_12 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_12 + var_99_4
					end

					if var_99_7.prefab_name ~= "" and arg_96_1.actors_[var_99_7.prefab_name] ~= nil then
						local var_99_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_7.prefab_name].transform, "story_v_out_325011", "325011024", "story_v_out_325011.awb")

						arg_96_1:RecordAudio("325011024", var_99_13)
						arg_96_1:RecordAudio("325011024", var_99_13)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325011", "325011024", "story_v_out_325011.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325011", "325011024", "story_v_out_325011.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_14 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_14 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_14

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_14 and arg_96_1.time_ < var_99_4 + var_99_14 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play325011025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325011025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play325011026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1077ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1077ui_story == nil then
				arg_100_1.var_.characterEffect1077ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1077ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1077ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1077ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1077ui_story.fillRatio = var_103_5
			end

			local var_103_6 = arg_100_1.actors_["1077ui_story"].transform
			local var_103_7 = 0

			if var_103_7 < arg_100_1.time_ and arg_100_1.time_ <= var_103_7 + arg_103_0 then
				arg_100_1.var_.moveOldPos1077ui_story = var_103_6.localPosition

				local var_103_8 = GameObjectTools.GetOrAddComponent(var_103_6.gameObject, typeof(DynamicBoneHelper))

				if var_103_8 then
					var_103_8:EnableDynamicBone(false)
				end
			end

			local var_103_9 = 0.001

			if var_103_7 <= arg_100_1.time_ and arg_100_1.time_ < var_103_7 + var_103_9 then
				local var_103_10 = (arg_100_1.time_ - var_103_7) / var_103_9
				local var_103_11 = Vector3.New(0, 100, 0)

				var_103_6.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1077ui_story, var_103_11, var_103_10)

				local var_103_12 = manager.ui.mainCamera.transform.position - var_103_6.position

				var_103_6.forward = Vector3.New(var_103_12.x, var_103_12.y, var_103_12.z)

				local var_103_13 = var_103_6.localEulerAngles

				var_103_13.z = 0
				var_103_13.x = 0
				var_103_6.localEulerAngles = var_103_13
			end

			if arg_100_1.time_ >= var_103_7 + var_103_9 and arg_100_1.time_ < var_103_7 + var_103_9 + arg_103_0 then
				var_103_6.localPosition = Vector3.New(0, 100, 0)

				local var_103_14 = manager.ui.mainCamera.transform.position - var_103_6.position

				var_103_6.forward = Vector3.New(var_103_14.x, var_103_14.y, var_103_14.z)

				local var_103_15 = var_103_6.localEulerAngles

				var_103_15.z = 0
				var_103_15.x = 0
				var_103_6.localEulerAngles = var_103_15

				local var_103_16 = GameObjectTools.GetOrAddComponent(var_103_6.gameObject, typeof(DynamicBoneHelper))

				if var_103_16 then
					var_103_16:EnableDynamicBone(true)
				end
			end

			local var_103_17 = 0
			local var_103_18 = 0.7

			if var_103_17 < arg_100_1.time_ and arg_100_1.time_ <= var_103_17 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_19 = arg_100_1:GetWordFromCfg(325011025)
				local var_103_20 = arg_100_1:FormatText(var_103_19.content)

				arg_100_1.text_.text = var_103_20

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_21 = 28
				local var_103_22 = utf8.len(var_103_20)
				local var_103_23 = var_103_21 <= 0 and var_103_18 or var_103_18 * (var_103_22 / var_103_21)

				if var_103_23 > 0 and var_103_18 < var_103_23 then
					arg_100_1.talkMaxDuration = var_103_23

					if var_103_23 + var_103_17 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_23 + var_103_17
					end
				end

				arg_100_1.text_.text = var_103_20
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_24 = math.max(var_103_18, arg_100_1.talkMaxDuration)

			if var_103_17 <= arg_100_1.time_ and arg_100_1.time_ < var_103_17 + var_103_24 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_17) / var_103_24

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_17 + var_103_24 and arg_100_1.time_ < var_103_17 + var_103_24 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play325011026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 325011026
		arg_104_1.duration_ = 4.23

		local var_104_0 = {
			zh = 1.033,
			ja = 4.233
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
				arg_104_0:Play325011027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.125

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[688].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(325011026)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 5
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011026", "story_v_out_325011.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011026", "story_v_out_325011.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_325011", "325011026", "story_v_out_325011.awb")

						arg_104_1:RecordAudio("325011026", var_107_9)
						arg_104_1:RecordAudio("325011026", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_325011", "325011026", "story_v_out_325011.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_325011", "325011026", "story_v_out_325011.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_10 and arg_104_1.time_ < var_107_0 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play325011027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325011027
		arg_108_1.duration_ = 7.8

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play325011028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 1.3

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				local var_111_1 = manager.ui.mainCamera.transform.localPosition
				local var_111_2 = Vector3.New(0, 0, 10) + Vector3.New(var_111_1.x, var_111_1.y, 0)
				local var_111_3 = arg_108_1.bgs_.ST2015

				var_111_3.transform.localPosition = var_111_2
				var_111_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_111_4 = var_111_3:GetComponent("SpriteRenderer")

				if var_111_4 and var_111_4.sprite then
					local var_111_5 = (var_111_3.transform.localPosition - var_111_1).z
					local var_111_6 = manager.ui.mainCameraCom_
					local var_111_7 = 2 * var_111_5 * Mathf.Tan(var_111_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_111_8 = var_111_7 * var_111_6.aspect
					local var_111_9 = var_111_4.sprite.bounds.size.x
					local var_111_10 = var_111_4.sprite.bounds.size.y
					local var_111_11 = var_111_8 / var_111_9
					local var_111_12 = var_111_7 / var_111_10
					local var_111_13 = var_111_12 < var_111_11 and var_111_11 or var_111_12

					var_111_3.transform.localScale = Vector3.New(var_111_13, var_111_13, 0)
				end

				for iter_111_0, iter_111_1 in pairs(arg_108_1.bgs_) do
					if iter_111_0 ~= "ST2015" then
						iter_111_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_111_14 = 1.3

			if var_111_14 < arg_108_1.time_ and arg_108_1.time_ <= var_111_14 + arg_111_0 then
				arg_108_1.allBtn_.enabled = false
			end

			local var_111_15 = 0.3

			if arg_108_1.time_ >= var_111_14 + var_111_15 and arg_108_1.time_ < var_111_14 + var_111_15 + arg_111_0 then
				arg_108_1.allBtn_.enabled = true
			end

			local var_111_16 = 0

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.mask_.enabled = true
				arg_108_1.mask_.raycastTarget = true

				arg_108_1:SetGaussion(false)
			end

			local var_111_17 = 1.3

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_17 then
				local var_111_18 = (arg_108_1.time_ - var_111_16) / var_111_17
				local var_111_19 = Color.New(0, 0, 0)

				var_111_19.a = Mathf.Lerp(0, 1, var_111_18)
				arg_108_1.mask_.color = var_111_19
			end

			if arg_108_1.time_ >= var_111_16 + var_111_17 and arg_108_1.time_ < var_111_16 + var_111_17 + arg_111_0 then
				local var_111_20 = Color.New(0, 0, 0)

				var_111_20.a = 1
				arg_108_1.mask_.color = var_111_20
			end

			local var_111_21 = 1.3

			if var_111_21 < arg_108_1.time_ and arg_108_1.time_ <= var_111_21 + arg_111_0 then
				arg_108_1.mask_.enabled = true
				arg_108_1.mask_.raycastTarget = true

				arg_108_1:SetGaussion(false)
			end

			local var_111_22 = 2

			if var_111_21 <= arg_108_1.time_ and arg_108_1.time_ < var_111_21 + var_111_22 then
				local var_111_23 = (arg_108_1.time_ - var_111_21) / var_111_22
				local var_111_24 = Color.New(0, 0, 0)

				var_111_24.a = Mathf.Lerp(1, 0, var_111_23)
				arg_108_1.mask_.color = var_111_24
			end

			if arg_108_1.time_ >= var_111_21 + var_111_22 and arg_108_1.time_ < var_111_21 + var_111_22 + arg_111_0 then
				local var_111_25 = Color.New(0, 0, 0)
				local var_111_26 = 0

				arg_108_1.mask_.enabled = false
				var_111_25.a = var_111_26
				arg_108_1.mask_.color = var_111_25
			end

			local var_111_27 = arg_108_1.actors_["1077ui_story"].transform
			local var_111_28 = 0

			if var_111_28 < arg_108_1.time_ and arg_108_1.time_ <= var_111_28 + arg_111_0 then
				arg_108_1.var_.moveOldPos1077ui_story = var_111_27.localPosition

				local var_111_29 = GameObjectTools.GetOrAddComponent(var_111_27.gameObject, typeof(DynamicBoneHelper))

				if var_111_29 then
					var_111_29:EnableDynamicBone(false)
				end
			end

			local var_111_30 = 0.001

			if var_111_28 <= arg_108_1.time_ and arg_108_1.time_ < var_111_28 + var_111_30 then
				local var_111_31 = (arg_108_1.time_ - var_111_28) / var_111_30
				local var_111_32 = Vector3.New(0, 100, 0)

				var_111_27.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1077ui_story, var_111_32, var_111_31)

				local var_111_33 = manager.ui.mainCamera.transform.position - var_111_27.position

				var_111_27.forward = Vector3.New(var_111_33.x, var_111_33.y, var_111_33.z)

				local var_111_34 = var_111_27.localEulerAngles

				var_111_34.z = 0
				var_111_34.x = 0
				var_111_27.localEulerAngles = var_111_34
			end

			if arg_108_1.time_ >= var_111_28 + var_111_30 and arg_108_1.time_ < var_111_28 + var_111_30 + arg_111_0 then
				var_111_27.localPosition = Vector3.New(0, 100, 0)

				local var_111_35 = manager.ui.mainCamera.transform.position - var_111_27.position

				var_111_27.forward = Vector3.New(var_111_35.x, var_111_35.y, var_111_35.z)

				local var_111_36 = var_111_27.localEulerAngles

				var_111_36.z = 0
				var_111_36.x = 0
				var_111_27.localEulerAngles = var_111_36

				local var_111_37 = GameObjectTools.GetOrAddComponent(var_111_27.gameObject, typeof(DynamicBoneHelper))

				if var_111_37 then
					var_111_37:EnableDynamicBone(true)
				end
			end

			if arg_108_1.frameCnt_ <= 1 then
				arg_108_1.dialog_:SetActive(false)
			end

			local var_111_38 = 2.8
			local var_111_39 = 1.375

			if var_111_38 < arg_108_1.time_ and arg_108_1.time_ <= var_111_38 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0

				arg_108_1.dialog_:SetActive(true)

				arg_108_1.dialogCg_.alpha = 0

				local var_111_40 = LeanTween.value(arg_108_1.dialog_, 0, 1, 0.3)

				var_111_40:setOnUpdate(LuaHelper.FloatAction(function(arg_112_0)
					arg_108_1.dialogCg_.alpha = arg_112_0
				end))
				var_111_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_108_1.dialog_)
					var_111_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_108_1.duration_ = arg_108_1.duration_ + 0.3

				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_41 = arg_108_1:GetWordFromCfg(325011027)
				local var_111_42 = arg_108_1:FormatText(var_111_41.content)

				arg_108_1.text_.text = var_111_42

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_43 = 55
				local var_111_44 = utf8.len(var_111_42)
				local var_111_45 = var_111_43 <= 0 and var_111_39 or var_111_39 * (var_111_44 / var_111_43)

				if var_111_45 > 0 and var_111_39 < var_111_45 then
					arg_108_1.talkMaxDuration = var_111_45
					var_111_38 = var_111_38 + 0.3

					if var_111_45 + var_111_38 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_45 + var_111_38
					end
				end

				arg_108_1.text_.text = var_111_42
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_46 = var_111_38 + 0.3
			local var_111_47 = math.max(var_111_39, arg_108_1.talkMaxDuration)

			if var_111_46 <= arg_108_1.time_ and arg_108_1.time_ < var_111_46 + var_111_47 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_46) / var_111_47

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_46 + var_111_47 and arg_108_1.time_ < var_111_46 + var_111_47 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325011028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325011028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play325011029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 1.3

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_2 = arg_114_1:GetWordFromCfg(325011028)
				local var_117_3 = arg_114_1:FormatText(var_117_2.content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 52
				local var_117_5 = utf8.len(var_117_3)
				local var_117_6 = var_117_4 <= 0 and var_117_1 or var_117_1 * (var_117_5 / var_117_4)

				if var_117_6 > 0 and var_117_1 < var_117_6 then
					arg_114_1.talkMaxDuration = var_117_6

					if var_117_6 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_6 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_7 and arg_114_1.time_ < var_117_0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play325011029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325011029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play325011030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 1.375

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_2 = arg_118_1:GetWordFromCfg(325011029)
				local var_121_3 = arg_118_1:FormatText(var_121_2.content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 55
				local var_121_5 = utf8.len(var_121_3)
				local var_121_6 = var_121_4 <= 0 and var_121_1 or var_121_1 * (var_121_5 / var_121_4)

				if var_121_6 > 0 and var_121_1 < var_121_6 then
					arg_118_1.talkMaxDuration = var_121_6

					if var_121_6 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_6 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_7 and arg_118_1.time_ < var_121_0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play325011030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325011030
		arg_122_1.duration_ = 1.5

		local var_122_0 = {
			zh = 1,
			ja = 1.5
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
				arg_122_0:Play325011031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1077ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos1077ui_story = var_125_0.localPosition

				local var_125_2 = GameObjectTools.GetOrAddComponent(var_125_0.gameObject, typeof(DynamicBoneHelper))

				if var_125_2 then
					var_125_2:EnableDynamicBone(false)
				end
			end

			local var_125_3 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_3 then
				local var_125_4 = (arg_122_1.time_ - var_125_1) / var_125_3
				local var_125_5 = Vector3.New(0, 100, 0)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1077ui_story, var_125_5, var_125_4)

				local var_125_6 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_6.x, var_125_6.y, var_125_6.z)

				local var_125_7 = var_125_0.localEulerAngles

				var_125_7.z = 0
				var_125_7.x = 0
				var_125_0.localEulerAngles = var_125_7
			end

			if arg_122_1.time_ >= var_125_1 + var_125_3 and arg_122_1.time_ < var_125_1 + var_125_3 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(0, 100, 0)

				local var_125_8 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_8.x, var_125_8.y, var_125_8.z)

				local var_125_9 = var_125_0.localEulerAngles

				var_125_9.z = 0
				var_125_9.x = 0
				var_125_0.localEulerAngles = var_125_9

				local var_125_10 = GameObjectTools.GetOrAddComponent(var_125_0.gameObject, typeof(DynamicBoneHelper))

				if var_125_10 then
					var_125_10:EnableDynamicBone(true)
				end
			end

			local var_125_11 = arg_122_1.actors_["1077ui_story"]
			local var_125_12 = 0

			if var_125_12 < arg_122_1.time_ and arg_122_1.time_ <= var_125_12 + arg_125_0 and not isNil(var_125_11) and arg_122_1.var_.characterEffect1077ui_story == nil then
				arg_122_1.var_.characterEffect1077ui_story = var_125_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_13 = 0.200000002980232

			if var_125_12 <= arg_122_1.time_ and arg_122_1.time_ < var_125_12 + var_125_13 and not isNil(var_125_11) then
				local var_125_14 = (arg_122_1.time_ - var_125_12) / var_125_13

				if arg_122_1.var_.characterEffect1077ui_story and not isNil(var_125_11) then
					arg_122_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_12 + var_125_13 and arg_122_1.time_ < var_125_12 + var_125_13 + arg_125_0 and not isNil(var_125_11) and arg_122_1.var_.characterEffect1077ui_story then
				arg_122_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_125_15 = 0
			local var_125_16 = 0.05

			if var_125_15 < arg_122_1.time_ and arg_122_1.time_ <= var_125_15 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_17 = arg_122_1:FormatText(StoryNameCfg[1467].name)

				arg_122_1.leftNameTxt_.text = var_125_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_18 = arg_122_1:GetWordFromCfg(325011030)
				local var_125_19 = arg_122_1:FormatText(var_125_18.content)

				arg_122_1.text_.text = var_125_19

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_20 = 2
				local var_125_21 = utf8.len(var_125_19)
				local var_125_22 = var_125_20 <= 0 and var_125_16 or var_125_16 * (var_125_21 / var_125_20)

				if var_125_22 > 0 and var_125_16 < var_125_22 then
					arg_122_1.talkMaxDuration = var_125_22

					if var_125_22 + var_125_15 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_22 + var_125_15
					end
				end

				arg_122_1.text_.text = var_125_19
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011030", "story_v_out_325011.awb") ~= 0 then
					local var_125_23 = manager.audio:GetVoiceLength("story_v_out_325011", "325011030", "story_v_out_325011.awb") / 1000

					if var_125_23 + var_125_15 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_23 + var_125_15
					end

					if var_125_18.prefab_name ~= "" and arg_122_1.actors_[var_125_18.prefab_name] ~= nil then
						local var_125_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_18.prefab_name].transform, "story_v_out_325011", "325011030", "story_v_out_325011.awb")

						arg_122_1:RecordAudio("325011030", var_125_24)
						arg_122_1:RecordAudio("325011030", var_125_24)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_325011", "325011030", "story_v_out_325011.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_325011", "325011030", "story_v_out_325011.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_25 = math.max(var_125_16, arg_122_1.talkMaxDuration)

			if var_125_15 <= arg_122_1.time_ and arg_122_1.time_ < var_125_15 + var_125_25 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_15) / var_125_25

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_15 + var_125_25 and arg_122_1.time_ < var_125_15 + var_125_25 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play325011031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325011031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play325011032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1077ui_story"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos1077ui_story = var_129_0.localPosition

				local var_129_2 = GameObjectTools.GetOrAddComponent(var_129_0.gameObject, typeof(DynamicBoneHelper))

				if var_129_2 then
					var_129_2:EnableDynamicBone(false)
				end
			end

			local var_129_3 = 0.001

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_3 then
				local var_129_4 = (arg_126_1.time_ - var_129_1) / var_129_3
				local var_129_5 = Vector3.New(0, 100, 0)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1077ui_story, var_129_5, var_129_4)

				local var_129_6 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_6.x, var_129_6.y, var_129_6.z)

				local var_129_7 = var_129_0.localEulerAngles

				var_129_7.z = 0
				var_129_7.x = 0
				var_129_0.localEulerAngles = var_129_7
			end

			if arg_126_1.time_ >= var_129_1 + var_129_3 and arg_126_1.time_ < var_129_1 + var_129_3 + arg_129_0 then
				var_129_0.localPosition = Vector3.New(0, 100, 0)

				local var_129_8 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_8.x, var_129_8.y, var_129_8.z)

				local var_129_9 = var_129_0.localEulerAngles

				var_129_9.z = 0
				var_129_9.x = 0
				var_129_0.localEulerAngles = var_129_9

				local var_129_10 = GameObjectTools.GetOrAddComponent(var_129_0.gameObject, typeof(DynamicBoneHelper))

				if var_129_10 then
					var_129_10:EnableDynamicBone(true)
				end
			end

			local var_129_11 = arg_126_1.actors_["1077ui_story"]
			local var_129_12 = 0

			if var_129_12 < arg_126_1.time_ and arg_126_1.time_ <= var_129_12 + arg_129_0 and not isNil(var_129_11) and arg_126_1.var_.characterEffect1077ui_story == nil then
				arg_126_1.var_.characterEffect1077ui_story = var_129_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_13 = 0.200000002980232

			if var_129_12 <= arg_126_1.time_ and arg_126_1.time_ < var_129_12 + var_129_13 and not isNil(var_129_11) then
				local var_129_14 = (arg_126_1.time_ - var_129_12) / var_129_13

				if arg_126_1.var_.characterEffect1077ui_story and not isNil(var_129_11) then
					local var_129_15 = Mathf.Lerp(0, 0.5, var_129_14)

					arg_126_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1077ui_story.fillRatio = var_129_15
				end
			end

			if arg_126_1.time_ >= var_129_12 + var_129_13 and arg_126_1.time_ < var_129_12 + var_129_13 + arg_129_0 and not isNil(var_129_11) and arg_126_1.var_.characterEffect1077ui_story then
				local var_129_16 = 0.5

				arg_126_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1077ui_story.fillRatio = var_129_16
			end

			local var_129_17 = 0
			local var_129_18 = 1.45

			if var_129_17 < arg_126_1.time_ and arg_126_1.time_ <= var_129_17 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_19 = arg_126_1:GetWordFromCfg(325011031)
				local var_129_20 = arg_126_1:FormatText(var_129_19.content)

				arg_126_1.text_.text = var_129_20

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_21 = 58
				local var_129_22 = utf8.len(var_129_20)
				local var_129_23 = var_129_21 <= 0 and var_129_18 or var_129_18 * (var_129_22 / var_129_21)

				if var_129_23 > 0 and var_129_18 < var_129_23 then
					arg_126_1.talkMaxDuration = var_129_23

					if var_129_23 + var_129_17 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_23 + var_129_17
					end
				end

				arg_126_1.text_.text = var_129_20
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_24 = math.max(var_129_18, arg_126_1.talkMaxDuration)

			if var_129_17 <= arg_126_1.time_ and arg_126_1.time_ < var_129_17 + var_129_24 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_17) / var_129_24

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_17 + var_129_24 and arg_126_1.time_ < var_129_17 + var_129_24 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play325011032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325011032
		arg_130_1.duration_ = 7.9

		local var_130_0 = {
			zh = 5.533,
			ja = 7.9
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
				arg_130_0:Play325011033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.6

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_2 = arg_130_1:FormatText(StoryNameCfg[1521].name)

				arg_130_1.leftNameTxt_.text = var_133_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_3 = arg_130_1:GetWordFromCfg(325011032)
				local var_133_4 = arg_130_1:FormatText(var_133_3.content)

				arg_130_1.text_.text = var_133_4

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 24
				local var_133_6 = utf8.len(var_133_4)
				local var_133_7 = var_133_5 <= 0 and var_133_1 or var_133_1 * (var_133_6 / var_133_5)

				if var_133_7 > 0 and var_133_1 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_4
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011032", "story_v_out_325011.awb") ~= 0 then
					local var_133_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011032", "story_v_out_325011.awb") / 1000

					if var_133_8 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_8 + var_133_0
					end

					if var_133_3.prefab_name ~= "" and arg_130_1.actors_[var_133_3.prefab_name] ~= nil then
						local var_133_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_3.prefab_name].transform, "story_v_out_325011", "325011032", "story_v_out_325011.awb")

						arg_130_1:RecordAudio("325011032", var_133_9)
						arg_130_1:RecordAudio("325011032", var_133_9)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_325011", "325011032", "story_v_out_325011.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_325011", "325011032", "story_v_out_325011.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_10 and arg_130_1.time_ < var_133_0 + var_133_10 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play325011033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325011033
		arg_134_1.duration_ = 6.57

		local var_134_0 = {
			zh = 4.3,
			ja = 6.566
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
				arg_134_0:Play325011034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1077ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1077ui_story == nil then
				arg_134_1.var_.characterEffect1077ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1077ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1077ui_story then
				arg_134_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_137_4 = arg_134_1.actors_["1077ui_story"].transform
			local var_137_5 = 0

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 then
				arg_134_1.var_.moveOldPos1077ui_story = var_137_4.localPosition

				local var_137_6 = GameObjectTools.GetOrAddComponent(var_137_4.gameObject, typeof(DynamicBoneHelper))

				if var_137_6 then
					var_137_6:EnableDynamicBone(false)
				end
			end

			local var_137_7 = 0.001

			if var_137_5 <= arg_134_1.time_ and arg_134_1.time_ < var_137_5 + var_137_7 then
				local var_137_8 = (arg_134_1.time_ - var_137_5) / var_137_7
				local var_137_9 = Vector3.New(-0.03, -1.02, -5.92)

				var_137_4.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1077ui_story, var_137_9, var_137_8)

				local var_137_10 = manager.ui.mainCamera.transform.position - var_137_4.position

				var_137_4.forward = Vector3.New(var_137_10.x, var_137_10.y, var_137_10.z)

				local var_137_11 = var_137_4.localEulerAngles

				var_137_11.z = 0
				var_137_11.x = 0
				var_137_4.localEulerAngles = var_137_11
			end

			if arg_134_1.time_ >= var_137_5 + var_137_7 and arg_134_1.time_ < var_137_5 + var_137_7 + arg_137_0 then
				var_137_4.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_137_12 = manager.ui.mainCamera.transform.position - var_137_4.position

				var_137_4.forward = Vector3.New(var_137_12.x, var_137_12.y, var_137_12.z)

				local var_137_13 = var_137_4.localEulerAngles

				var_137_13.z = 0
				var_137_13.x = 0
				var_137_4.localEulerAngles = var_137_13

				local var_137_14 = GameObjectTools.GetOrAddComponent(var_137_4.gameObject, typeof(DynamicBoneHelper))

				if var_137_14 then
					var_137_14:EnableDynamicBone(true)
				end
			end

			local var_137_15 = 0

			if var_137_15 < arg_134_1.time_ and arg_134_1.time_ <= var_137_15 + arg_137_0 then
				arg_134_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			local var_137_16 = 0

			if var_137_16 < arg_134_1.time_ and arg_134_1.time_ <= var_137_16 + arg_137_0 then
				arg_134_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_137_17 = 0
			local var_137_18 = 0.475

			if var_137_17 < arg_134_1.time_ and arg_134_1.time_ <= var_137_17 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_19 = arg_134_1:FormatText(StoryNameCfg[1467].name)

				arg_134_1.leftNameTxt_.text = var_137_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_20 = arg_134_1:GetWordFromCfg(325011033)
				local var_137_21 = arg_134_1:FormatText(var_137_20.content)

				arg_134_1.text_.text = var_137_21

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_22 = 19
				local var_137_23 = utf8.len(var_137_21)
				local var_137_24 = var_137_22 <= 0 and var_137_18 or var_137_18 * (var_137_23 / var_137_22)

				if var_137_24 > 0 and var_137_18 < var_137_24 then
					arg_134_1.talkMaxDuration = var_137_24

					if var_137_24 + var_137_17 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_24 + var_137_17
					end
				end

				arg_134_1.text_.text = var_137_21
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011033", "story_v_out_325011.awb") ~= 0 then
					local var_137_25 = manager.audio:GetVoiceLength("story_v_out_325011", "325011033", "story_v_out_325011.awb") / 1000

					if var_137_25 + var_137_17 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_25 + var_137_17
					end

					if var_137_20.prefab_name ~= "" and arg_134_1.actors_[var_137_20.prefab_name] ~= nil then
						local var_137_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_20.prefab_name].transform, "story_v_out_325011", "325011033", "story_v_out_325011.awb")

						arg_134_1:RecordAudio("325011033", var_137_26)
						arg_134_1:RecordAudio("325011033", var_137_26)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_325011", "325011033", "story_v_out_325011.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_325011", "325011033", "story_v_out_325011.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_27 = math.max(var_137_18, arg_134_1.talkMaxDuration)

			if var_137_17 <= arg_134_1.time_ and arg_134_1.time_ < var_137_17 + var_137_27 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_17) / var_137_27

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_17 + var_137_27 and arg_134_1.time_ < var_137_17 + var_137_27 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play325011034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325011034
		arg_138_1.duration_ = 5.9

		local var_138_0 = {
			zh = 5.5,
			ja = 5.9
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play325011035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1077ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1077ui_story == nil then
				arg_138_1.var_.characterEffect1077ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1077ui_story and not isNil(var_141_0) then
					local var_141_4 = Mathf.Lerp(0, 0.5, var_141_3)

					arg_138_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1077ui_story.fillRatio = var_141_4
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1077ui_story then
				local var_141_5 = 0.5

				arg_138_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1077ui_story.fillRatio = var_141_5
			end

			local var_141_6 = 0
			local var_141_7 = 0.475

			if var_141_6 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_8 = arg_138_1:FormatText(StoryNameCfg[1521].name)

				arg_138_1.leftNameTxt_.text = var_141_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_9 = arg_138_1:GetWordFromCfg(325011034)
				local var_141_10 = arg_138_1:FormatText(var_141_9.content)

				arg_138_1.text_.text = var_141_10

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 19
				local var_141_12 = utf8.len(var_141_10)
				local var_141_13 = var_141_11 <= 0 and var_141_7 or var_141_7 * (var_141_12 / var_141_11)

				if var_141_13 > 0 and var_141_7 < var_141_13 then
					arg_138_1.talkMaxDuration = var_141_13

					if var_141_13 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_13 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_10
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011034", "story_v_out_325011.awb") ~= 0 then
					local var_141_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011034", "story_v_out_325011.awb") / 1000

					if var_141_14 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_14 + var_141_6
					end

					if var_141_9.prefab_name ~= "" and arg_138_1.actors_[var_141_9.prefab_name] ~= nil then
						local var_141_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_9.prefab_name].transform, "story_v_out_325011", "325011034", "story_v_out_325011.awb")

						arg_138_1:RecordAudio("325011034", var_141_15)
						arg_138_1:RecordAudio("325011034", var_141_15)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_325011", "325011034", "story_v_out_325011.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_325011", "325011034", "story_v_out_325011.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_16 = math.max(var_141_7, arg_138_1.talkMaxDuration)

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_16 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_6) / var_141_16

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_6 + var_141_16 and arg_138_1.time_ < var_141_6 + var_141_16 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play325011035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 325011035
		arg_142_1.duration_ = 3.87

		local var_142_0 = {
			zh = 2.333,
			ja = 3.866
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
				arg_142_0:Play325011036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1077ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1077ui_story == nil then
				arg_142_1.var_.characterEffect1077ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.200000002980232

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1077ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1077ui_story then
				arg_142_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_145_4 = 0

			if var_145_4 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_145_5 = 0

			if var_145_5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1.allBtn_.enabled = false
			end

			local var_145_6 = 1.13333333333333

			if arg_142_1.time_ >= var_145_5 + var_145_6 and arg_142_1.time_ < var_145_5 + var_145_6 + arg_145_0 then
				arg_142_1.allBtn_.enabled = true
			end

			if arg_142_1.frameCnt_ <= 1 then
				arg_142_1.dialog_:SetActive(false)
			end

			local var_145_7 = 0.6
			local var_145_8 = 0.175

			if var_145_7 < arg_142_1.time_ and arg_142_1.time_ <= var_145_7 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0

				arg_142_1.dialog_:SetActive(true)

				arg_142_1.dialogCg_.alpha = 0

				local var_145_9 = LeanTween.value(arg_142_1.dialog_, 0, 1, 0.3)

				var_145_9:setOnUpdate(LuaHelper.FloatAction(function(arg_146_0)
					arg_142_1.dialogCg_.alpha = arg_146_0
				end))
				var_145_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_142_1.dialog_)
					var_145_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_142_1.duration_ = arg_142_1.duration_ + 0.3

				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_10 = arg_142_1:FormatText(StoryNameCfg[1467].name)

				arg_142_1.leftNameTxt_.text = var_145_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_11 = arg_142_1:GetWordFromCfg(325011035)
				local var_145_12 = arg_142_1:FormatText(var_145_11.content)

				arg_142_1.text_.text = var_145_12

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_13 = 7
				local var_145_14 = utf8.len(var_145_12)
				local var_145_15 = var_145_13 <= 0 and var_145_8 or var_145_8 * (var_145_14 / var_145_13)

				if var_145_15 > 0 and var_145_8 < var_145_15 then
					arg_142_1.talkMaxDuration = var_145_15
					var_145_7 = var_145_7 + 0.3

					if var_145_15 + var_145_7 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_15 + var_145_7
					end
				end

				arg_142_1.text_.text = var_145_12
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011035", "story_v_out_325011.awb") ~= 0 then
					local var_145_16 = manager.audio:GetVoiceLength("story_v_out_325011", "325011035", "story_v_out_325011.awb") / 1000

					if var_145_16 + var_145_7 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_16 + var_145_7
					end

					if var_145_11.prefab_name ~= "" and arg_142_1.actors_[var_145_11.prefab_name] ~= nil then
						local var_145_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_11.prefab_name].transform, "story_v_out_325011", "325011035", "story_v_out_325011.awb")

						arg_142_1:RecordAudio("325011035", var_145_17)
						arg_142_1:RecordAudio("325011035", var_145_17)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_325011", "325011035", "story_v_out_325011.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_325011", "325011035", "story_v_out_325011.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_18 = var_145_7 + 0.3
			local var_145_19 = math.max(var_145_8, arg_142_1.talkMaxDuration)

			if var_145_18 <= arg_142_1.time_ and arg_142_1.time_ < var_145_18 + var_145_19 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_18) / var_145_19

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_18 + var_145_19 and arg_142_1.time_ < var_145_18 + var_145_19 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play325011036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325011036
		arg_148_1.duration_ = 6.1

		local var_148_0 = {
			zh = 4.033,
			ja = 6.1
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
				arg_148_0:Play325011037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1077ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1077ui_story == nil then
				arg_148_1.var_.characterEffect1077ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect1077ui_story and not isNil(var_151_0) then
					local var_151_4 = Mathf.Lerp(0, 0.5, var_151_3)

					arg_148_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1077ui_story.fillRatio = var_151_4
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1077ui_story then
				local var_151_5 = 0.5

				arg_148_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1077ui_story.fillRatio = var_151_5
			end

			local var_151_6 = 0
			local var_151_7 = 0.375

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_8 = arg_148_1:FormatText(StoryNameCfg[1521].name)

				arg_148_1.leftNameTxt_.text = var_151_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_9 = arg_148_1:GetWordFromCfg(325011036)
				local var_151_10 = arg_148_1:FormatText(var_151_9.content)

				arg_148_1.text_.text = var_151_10

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 15
				local var_151_12 = utf8.len(var_151_10)
				local var_151_13 = var_151_11 <= 0 and var_151_7 or var_151_7 * (var_151_12 / var_151_11)

				if var_151_13 > 0 and var_151_7 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_6
					end
				end

				arg_148_1.text_.text = var_151_10
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011036", "story_v_out_325011.awb") ~= 0 then
					local var_151_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011036", "story_v_out_325011.awb") / 1000

					if var_151_14 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_6
					end

					if var_151_9.prefab_name ~= "" and arg_148_1.actors_[var_151_9.prefab_name] ~= nil then
						local var_151_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_9.prefab_name].transform, "story_v_out_325011", "325011036", "story_v_out_325011.awb")

						arg_148_1:RecordAudio("325011036", var_151_15)
						arg_148_1:RecordAudio("325011036", var_151_15)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_325011", "325011036", "story_v_out_325011.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_325011", "325011036", "story_v_out_325011.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_16 and arg_148_1.time_ < var_151_6 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play325011037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 325011037
		arg_152_1.duration_ = 7.13

		local var_152_0 = {
			zh = 4.866,
			ja = 7.133
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
				arg_152_0:Play325011038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1077ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1077ui_story == nil then
				arg_152_1.var_.characterEffect1077ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1077ui_story and not isNil(var_155_0) then
					arg_152_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1077ui_story then
				arg_152_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_155_4 = 0

			if var_155_4 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_155_5 = 0
			local var_155_6 = 0.575

			if var_155_5 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_7 = arg_152_1:FormatText(StoryNameCfg[1467].name)

				arg_152_1.leftNameTxt_.text = var_155_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_8 = arg_152_1:GetWordFromCfg(325011037)
				local var_155_9 = arg_152_1:FormatText(var_155_8.content)

				arg_152_1.text_.text = var_155_9

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_10 = 23
				local var_155_11 = utf8.len(var_155_9)
				local var_155_12 = var_155_10 <= 0 and var_155_6 or var_155_6 * (var_155_11 / var_155_10)

				if var_155_12 > 0 and var_155_6 < var_155_12 then
					arg_152_1.talkMaxDuration = var_155_12

					if var_155_12 + var_155_5 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_12 + var_155_5
					end
				end

				arg_152_1.text_.text = var_155_9
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011037", "story_v_out_325011.awb") ~= 0 then
					local var_155_13 = manager.audio:GetVoiceLength("story_v_out_325011", "325011037", "story_v_out_325011.awb") / 1000

					if var_155_13 + var_155_5 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_5
					end

					if var_155_8.prefab_name ~= "" and arg_152_1.actors_[var_155_8.prefab_name] ~= nil then
						local var_155_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_8.prefab_name].transform, "story_v_out_325011", "325011037", "story_v_out_325011.awb")

						arg_152_1:RecordAudio("325011037", var_155_14)
						arg_152_1:RecordAudio("325011037", var_155_14)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_325011", "325011037", "story_v_out_325011.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_325011", "325011037", "story_v_out_325011.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_15 = math.max(var_155_6, arg_152_1.talkMaxDuration)

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_15 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_5) / var_155_15

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_5 + var_155_15 and arg_152_1.time_ < var_155_5 + var_155_15 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play325011038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325011038
		arg_156_1.duration_ = 7.3

		local var_156_0 = {
			zh = 6.566,
			ja = 7.3
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
				arg_156_0:Play325011039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1077ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1077ui_story == nil then
				arg_156_1.var_.characterEffect1077ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1077ui_story and not isNil(var_159_0) then
					local var_159_4 = Mathf.Lerp(0, 0.5, var_159_3)

					arg_156_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1077ui_story.fillRatio = var_159_4
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1077ui_story then
				local var_159_5 = 0.5

				arg_156_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1077ui_story.fillRatio = var_159_5
			end

			local var_159_6 = 0
			local var_159_7 = 0.7

			if var_159_6 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_8 = arg_156_1:FormatText(StoryNameCfg[1521].name)

				arg_156_1.leftNameTxt_.text = var_159_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_9 = arg_156_1:GetWordFromCfg(325011038)
				local var_159_10 = arg_156_1:FormatText(var_159_9.content)

				arg_156_1.text_.text = var_159_10

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 28
				local var_159_12 = utf8.len(var_159_10)
				local var_159_13 = var_159_11 <= 0 and var_159_7 or var_159_7 * (var_159_12 / var_159_11)

				if var_159_13 > 0 and var_159_7 < var_159_13 then
					arg_156_1.talkMaxDuration = var_159_13

					if var_159_13 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_10
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011038", "story_v_out_325011.awb") ~= 0 then
					local var_159_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011038", "story_v_out_325011.awb") / 1000

					if var_159_14 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_14 + var_159_6
					end

					if var_159_9.prefab_name ~= "" and arg_156_1.actors_[var_159_9.prefab_name] ~= nil then
						local var_159_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_9.prefab_name].transform, "story_v_out_325011", "325011038", "story_v_out_325011.awb")

						arg_156_1:RecordAudio("325011038", var_159_15)
						arg_156_1:RecordAudio("325011038", var_159_15)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_325011", "325011038", "story_v_out_325011.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_325011", "325011038", "story_v_out_325011.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_16 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_16 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_16

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_16 and arg_156_1.time_ < var_159_6 + var_159_16 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play325011039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 325011039
		arg_160_1.duration_ = 2

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play325011040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1077ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1077ui_story == nil then
				arg_160_1.var_.characterEffect1077ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1077ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1077ui_story then
				arg_160_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_163_4 = 0

			if var_163_4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_163_5 = 0
			local var_163_6 = 0.125

			if var_163_5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_7 = arg_160_1:FormatText(StoryNameCfg[1467].name)

				arg_160_1.leftNameTxt_.text = var_163_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_8 = arg_160_1:GetWordFromCfg(325011039)
				local var_163_9 = arg_160_1:FormatText(var_163_8.content)

				arg_160_1.text_.text = var_163_9

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_10 = 5
				local var_163_11 = utf8.len(var_163_9)
				local var_163_12 = var_163_10 <= 0 and var_163_6 or var_163_6 * (var_163_11 / var_163_10)

				if var_163_12 > 0 and var_163_6 < var_163_12 then
					arg_160_1.talkMaxDuration = var_163_12

					if var_163_12 + var_163_5 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_12 + var_163_5
					end
				end

				arg_160_1.text_.text = var_163_9
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011039", "story_v_out_325011.awb") ~= 0 then
					local var_163_13 = manager.audio:GetVoiceLength("story_v_out_325011", "325011039", "story_v_out_325011.awb") / 1000

					if var_163_13 + var_163_5 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_5
					end

					if var_163_8.prefab_name ~= "" and arg_160_1.actors_[var_163_8.prefab_name] ~= nil then
						local var_163_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_8.prefab_name].transform, "story_v_out_325011", "325011039", "story_v_out_325011.awb")

						arg_160_1:RecordAudio("325011039", var_163_14)
						arg_160_1:RecordAudio("325011039", var_163_14)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_325011", "325011039", "story_v_out_325011.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_325011", "325011039", "story_v_out_325011.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_15 = math.max(var_163_6, arg_160_1.talkMaxDuration)

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_15 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_5) / var_163_15

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_5 + var_163_15 and arg_160_1.time_ < var_163_5 + var_163_15 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play325011040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 325011040
		arg_164_1.duration_ = 3.4

		local var_164_0 = {
			zh = 1.2,
			ja = 3.4
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
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play325011041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1077ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1077ui_story == nil then
				arg_164_1.var_.characterEffect1077ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1077ui_story and not isNil(var_167_0) then
					local var_167_4 = Mathf.Lerp(0, 0.5, var_167_3)

					arg_164_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1077ui_story.fillRatio = var_167_4
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1077ui_story then
				local var_167_5 = 0.5

				arg_164_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1077ui_story.fillRatio = var_167_5
			end

			local var_167_6 = 0
			local var_167_7 = 0.175

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_8 = arg_164_1:FormatText(StoryNameCfg[1521].name)

				arg_164_1.leftNameTxt_.text = var_167_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_9 = arg_164_1:GetWordFromCfg(325011040)
				local var_167_10 = arg_164_1:FormatText(var_167_9.content)

				arg_164_1.text_.text = var_167_10

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011040", "story_v_out_325011.awb") ~= 0 then
					local var_167_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011040", "story_v_out_325011.awb") / 1000

					if var_167_14 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_14 + var_167_6
					end

					if var_167_9.prefab_name ~= "" and arg_164_1.actors_[var_167_9.prefab_name] ~= nil then
						local var_167_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_9.prefab_name].transform, "story_v_out_325011", "325011040", "story_v_out_325011.awb")

						arg_164_1:RecordAudio("325011040", var_167_15)
						arg_164_1:RecordAudio("325011040", var_167_15)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_325011", "325011040", "story_v_out_325011.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_325011", "325011040", "story_v_out_325011.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_16 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_16 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_16

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_16 and arg_164_1.time_ < var_167_6 + var_167_16 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play325011041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 325011041
		arg_168_1.duration_ = 4.43

		local var_168_0 = {
			zh = 2.733,
			ja = 4.433
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
				arg_168_0:Play325011042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1077ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1077ui_story == nil then
				arg_168_1.var_.characterEffect1077ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1077ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1077ui_story then
				arg_168_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_171_4 = 0

			if var_171_4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_171_5 = 0
			local var_171_6 = 0.3

			if var_171_5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_7 = arg_168_1:FormatText(StoryNameCfg[1467].name)

				arg_168_1.leftNameTxt_.text = var_171_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_8 = arg_168_1:GetWordFromCfg(325011041)
				local var_171_9 = arg_168_1:FormatText(var_171_8.content)

				arg_168_1.text_.text = var_171_9

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_10 = 12
				local var_171_11 = utf8.len(var_171_9)
				local var_171_12 = var_171_10 <= 0 and var_171_6 or var_171_6 * (var_171_11 / var_171_10)

				if var_171_12 > 0 and var_171_6 < var_171_12 then
					arg_168_1.talkMaxDuration = var_171_12

					if var_171_12 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_12 + var_171_5
					end
				end

				arg_168_1.text_.text = var_171_9
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011041", "story_v_out_325011.awb") ~= 0 then
					local var_171_13 = manager.audio:GetVoiceLength("story_v_out_325011", "325011041", "story_v_out_325011.awb") / 1000

					if var_171_13 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_5
					end

					if var_171_8.prefab_name ~= "" and arg_168_1.actors_[var_171_8.prefab_name] ~= nil then
						local var_171_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_8.prefab_name].transform, "story_v_out_325011", "325011041", "story_v_out_325011.awb")

						arg_168_1:RecordAudio("325011041", var_171_14)
						arg_168_1:RecordAudio("325011041", var_171_14)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_325011", "325011041", "story_v_out_325011.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_325011", "325011041", "story_v_out_325011.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_15 = math.max(var_171_6, arg_168_1.talkMaxDuration)

			if var_171_5 <= arg_168_1.time_ and arg_168_1.time_ < var_171_5 + var_171_15 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_5) / var_171_15

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_5 + var_171_15 and arg_168_1.time_ < var_171_5 + var_171_15 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play325011042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 325011042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play325011043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1077ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1077ui_story == nil then
				arg_172_1.var_.characterEffect1077ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1077ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1077ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1077ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1077ui_story.fillRatio = var_175_5
			end

			local var_175_6 = arg_172_1.actors_["1077ui_story"].transform
			local var_175_7 = 0

			if var_175_7 < arg_172_1.time_ and arg_172_1.time_ <= var_175_7 + arg_175_0 then
				arg_172_1.var_.moveOldPos1077ui_story = var_175_6.localPosition

				local var_175_8 = GameObjectTools.GetOrAddComponent(var_175_6.gameObject, typeof(DynamicBoneHelper))

				if var_175_8 then
					var_175_8:EnableDynamicBone(false)
				end
			end

			local var_175_9 = 0.001

			if var_175_7 <= arg_172_1.time_ and arg_172_1.time_ < var_175_7 + var_175_9 then
				local var_175_10 = (arg_172_1.time_ - var_175_7) / var_175_9
				local var_175_11 = Vector3.New(0, 100, 0)

				var_175_6.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1077ui_story, var_175_11, var_175_10)

				local var_175_12 = manager.ui.mainCamera.transform.position - var_175_6.position

				var_175_6.forward = Vector3.New(var_175_12.x, var_175_12.y, var_175_12.z)

				local var_175_13 = var_175_6.localEulerAngles

				var_175_13.z = 0
				var_175_13.x = 0
				var_175_6.localEulerAngles = var_175_13
			end

			if arg_172_1.time_ >= var_175_7 + var_175_9 and arg_172_1.time_ < var_175_7 + var_175_9 + arg_175_0 then
				var_175_6.localPosition = Vector3.New(0, 100, 0)

				local var_175_14 = manager.ui.mainCamera.transform.position - var_175_6.position

				var_175_6.forward = Vector3.New(var_175_14.x, var_175_14.y, var_175_14.z)

				local var_175_15 = var_175_6.localEulerAngles

				var_175_15.z = 0
				var_175_15.x = 0
				var_175_6.localEulerAngles = var_175_15

				local var_175_16 = GameObjectTools.GetOrAddComponent(var_175_6.gameObject, typeof(DynamicBoneHelper))

				if var_175_16 then
					var_175_16:EnableDynamicBone(true)
				end
			end

			local var_175_17 = 0
			local var_175_18 = 1.45

			if var_175_17 < arg_172_1.time_ and arg_172_1.time_ <= var_175_17 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_19 = arg_172_1:GetWordFromCfg(325011042)
				local var_175_20 = arg_172_1:FormatText(var_175_19.content)

				arg_172_1.text_.text = var_175_20

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_21 = 58
				local var_175_22 = utf8.len(var_175_20)
				local var_175_23 = var_175_21 <= 0 and var_175_18 or var_175_18 * (var_175_22 / var_175_21)

				if var_175_23 > 0 and var_175_18 < var_175_23 then
					arg_172_1.talkMaxDuration = var_175_23

					if var_175_23 + var_175_17 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_23 + var_175_17
					end
				end

				arg_172_1.text_.text = var_175_20
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_24 = math.max(var_175_18, arg_172_1.talkMaxDuration)

			if var_175_17 <= arg_172_1.time_ and arg_172_1.time_ < var_175_17 + var_175_24 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_17) / var_175_24

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_17 + var_175_24 and arg_172_1.time_ < var_175_17 + var_175_24 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325011043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 325011043
		arg_176_1.duration_ = 8.1

		local var_176_0 = {
			zh = 7.6,
			ja = 8.1
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
				arg_176_0:Play325011044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1077ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1077ui_story == nil then
				arg_176_1.var_.characterEffect1077ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1077ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1077ui_story then
				arg_176_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_179_4 = 0

			if var_179_4 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_179_5 = 0

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_179_6 = arg_176_1.actors_["1077ui_story"].transform
			local var_179_7 = 0

			if var_179_7 < arg_176_1.time_ and arg_176_1.time_ <= var_179_7 + arg_179_0 then
				arg_176_1.var_.moveOldPos1077ui_story = var_179_6.localPosition

				local var_179_8 = GameObjectTools.GetOrAddComponent(var_179_6.gameObject, typeof(DynamicBoneHelper))

				if var_179_8 then
					var_179_8:EnableDynamicBone(false)
				end
			end

			local var_179_9 = 0.001

			if var_179_7 <= arg_176_1.time_ and arg_176_1.time_ < var_179_7 + var_179_9 then
				local var_179_10 = (arg_176_1.time_ - var_179_7) / var_179_9
				local var_179_11 = Vector3.New(-0.03, -1.02, -5.92)

				var_179_6.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1077ui_story, var_179_11, var_179_10)

				local var_179_12 = manager.ui.mainCamera.transform.position - var_179_6.position

				var_179_6.forward = Vector3.New(var_179_12.x, var_179_12.y, var_179_12.z)

				local var_179_13 = var_179_6.localEulerAngles

				var_179_13.z = 0
				var_179_13.x = 0
				var_179_6.localEulerAngles = var_179_13
			end

			if arg_176_1.time_ >= var_179_7 + var_179_9 and arg_176_1.time_ < var_179_7 + var_179_9 + arg_179_0 then
				var_179_6.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_179_14 = manager.ui.mainCamera.transform.position - var_179_6.position

				var_179_6.forward = Vector3.New(var_179_14.x, var_179_14.y, var_179_14.z)

				local var_179_15 = var_179_6.localEulerAngles

				var_179_15.z = 0
				var_179_15.x = 0
				var_179_6.localEulerAngles = var_179_15

				local var_179_16 = GameObjectTools.GetOrAddComponent(var_179_6.gameObject, typeof(DynamicBoneHelper))

				if var_179_16 then
					var_179_16:EnableDynamicBone(true)
				end
			end

			local var_179_17 = 0
			local var_179_18 = 0.85

			if var_179_17 < arg_176_1.time_ and arg_176_1.time_ <= var_179_17 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_19 = arg_176_1:FormatText(StoryNameCfg[1467].name)

				arg_176_1.leftNameTxt_.text = var_179_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_20 = arg_176_1:GetWordFromCfg(325011043)
				local var_179_21 = arg_176_1:FormatText(var_179_20.content)

				arg_176_1.text_.text = var_179_21

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_22 = 34
				local var_179_23 = utf8.len(var_179_21)
				local var_179_24 = var_179_22 <= 0 and var_179_18 or var_179_18 * (var_179_23 / var_179_22)

				if var_179_24 > 0 and var_179_18 < var_179_24 then
					arg_176_1.talkMaxDuration = var_179_24

					if var_179_24 + var_179_17 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_24 + var_179_17
					end
				end

				arg_176_1.text_.text = var_179_21
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011043", "story_v_out_325011.awb") ~= 0 then
					local var_179_25 = manager.audio:GetVoiceLength("story_v_out_325011", "325011043", "story_v_out_325011.awb") / 1000

					if var_179_25 + var_179_17 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_25 + var_179_17
					end

					if var_179_20.prefab_name ~= "" and arg_176_1.actors_[var_179_20.prefab_name] ~= nil then
						local var_179_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_20.prefab_name].transform, "story_v_out_325011", "325011043", "story_v_out_325011.awb")

						arg_176_1:RecordAudio("325011043", var_179_26)
						arg_176_1:RecordAudio("325011043", var_179_26)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_325011", "325011043", "story_v_out_325011.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_325011", "325011043", "story_v_out_325011.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_27 = math.max(var_179_18, arg_176_1.talkMaxDuration)

			if var_179_17 <= arg_176_1.time_ and arg_176_1.time_ < var_179_17 + var_179_27 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_17) / var_179_27

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_17 + var_179_27 and arg_176_1.time_ < var_179_17 + var_179_27 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325011044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 325011044
		arg_180_1.duration_ = 7.23

		local var_180_0 = {
			zh = 3.166,
			ja = 7.233
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
				arg_180_0:Play325011045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1077ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1077ui_story == nil then
				arg_180_1.var_.characterEffect1077ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1077ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1077ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1077ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1077ui_story.fillRatio = var_183_5
			end

			local var_183_6 = 0
			local var_183_7 = 0.3

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_8 = arg_180_1:FormatText(StoryNameCfg[1521].name)

				arg_180_1.leftNameTxt_.text = var_183_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_9 = arg_180_1:GetWordFromCfg(325011044)
				local var_183_10 = arg_180_1:FormatText(var_183_9.content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 12
				local var_183_12 = utf8.len(var_183_10)
				local var_183_13 = var_183_11 <= 0 and var_183_7 or var_183_7 * (var_183_12 / var_183_11)

				if var_183_13 > 0 and var_183_7 < var_183_13 then
					arg_180_1.talkMaxDuration = var_183_13

					if var_183_13 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_10
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011044", "story_v_out_325011.awb") ~= 0 then
					local var_183_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011044", "story_v_out_325011.awb") / 1000

					if var_183_14 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_14 + var_183_6
					end

					if var_183_9.prefab_name ~= "" and arg_180_1.actors_[var_183_9.prefab_name] ~= nil then
						local var_183_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_9.prefab_name].transform, "story_v_out_325011", "325011044", "story_v_out_325011.awb")

						arg_180_1:RecordAudio("325011044", var_183_15)
						arg_180_1:RecordAudio("325011044", var_183_15)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_325011", "325011044", "story_v_out_325011.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_325011", "325011044", "story_v_out_325011.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_16 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_16 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_16

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_16 and arg_180_1.time_ < var_183_6 + var_183_16 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play325011045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 325011045
		arg_184_1.duration_ = 2.23

		local var_184_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_184_0:Play325011046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1077ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1077ui_story == nil then
				arg_184_1.var_.characterEffect1077ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1077ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1077ui_story then
				arg_184_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_187_4 = 0

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_1")
			end

			local var_187_5 = 0
			local var_187_6 = 0.1

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_7 = arg_184_1:FormatText(StoryNameCfg[1467].name)

				arg_184_1.leftNameTxt_.text = var_187_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_8 = arg_184_1:GetWordFromCfg(325011045)
				local var_187_9 = arg_184_1:FormatText(var_187_8.content)

				arg_184_1.text_.text = var_187_9

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_10 = 4
				local var_187_11 = utf8.len(var_187_9)
				local var_187_12 = var_187_10 <= 0 and var_187_6 or var_187_6 * (var_187_11 / var_187_10)

				if var_187_12 > 0 and var_187_6 < var_187_12 then
					arg_184_1.talkMaxDuration = var_187_12

					if var_187_12 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_12 + var_187_5
					end
				end

				arg_184_1.text_.text = var_187_9
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011045", "story_v_out_325011.awb") ~= 0 then
					local var_187_13 = manager.audio:GetVoiceLength("story_v_out_325011", "325011045", "story_v_out_325011.awb") / 1000

					if var_187_13 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_5
					end

					if var_187_8.prefab_name ~= "" and arg_184_1.actors_[var_187_8.prefab_name] ~= nil then
						local var_187_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_8.prefab_name].transform, "story_v_out_325011", "325011045", "story_v_out_325011.awb")

						arg_184_1:RecordAudio("325011045", var_187_14)
						arg_184_1:RecordAudio("325011045", var_187_14)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_325011", "325011045", "story_v_out_325011.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_325011", "325011045", "story_v_out_325011.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_15 = math.max(var_187_6, arg_184_1.talkMaxDuration)

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_15 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_5) / var_187_15

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_5 + var_187_15 and arg_184_1.time_ < var_187_5 + var_187_15 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play325011046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 325011046
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play325011047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1077ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1077ui_story == nil then
				arg_188_1.var_.characterEffect1077ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect1077ui_story and not isNil(var_191_0) then
					local var_191_4 = Mathf.Lerp(0, 0.5, var_191_3)

					arg_188_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1077ui_story.fillRatio = var_191_4
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1077ui_story then
				local var_191_5 = 0.5

				arg_188_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1077ui_story.fillRatio = var_191_5
			end

			local var_191_6 = 0
			local var_191_7 = 0.95

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_8 = arg_188_1:GetWordFromCfg(325011046)
				local var_191_9 = arg_188_1:FormatText(var_191_8.content)

				arg_188_1.text_.text = var_191_9

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_10 = 38
				local var_191_11 = utf8.len(var_191_9)
				local var_191_12 = var_191_10 <= 0 and var_191_7 or var_191_7 * (var_191_11 / var_191_10)

				if var_191_12 > 0 and var_191_7 < var_191_12 then
					arg_188_1.talkMaxDuration = var_191_12

					if var_191_12 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_12 + var_191_6
					end
				end

				arg_188_1.text_.text = var_191_9
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_13 = math.max(var_191_7, arg_188_1.talkMaxDuration)

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_13 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_6) / var_191_13

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_6 + var_191_13 and arg_188_1.time_ < var_191_6 + var_191_13 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play325011047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 325011047
		arg_192_1.duration_ = 10.77

		local var_192_0 = {
			zh = 3.5,
			ja = 10.766
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
				arg_192_0:Play325011048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 0.425

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[1521].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_3 = arg_192_1:GetWordFromCfg(325011047)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 17
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011047", "story_v_out_325011.awb") ~= 0 then
					local var_195_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011047", "story_v_out_325011.awb") / 1000

					if var_195_8 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_0
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_325011", "325011047", "story_v_out_325011.awb")

						arg_192_1:RecordAudio("325011047", var_195_9)
						arg_192_1:RecordAudio("325011047", var_195_9)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_325011", "325011047", "story_v_out_325011.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_325011", "325011047", "story_v_out_325011.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_10 and arg_192_1.time_ < var_195_0 + var_195_10 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play325011048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 325011048
		arg_196_1.duration_ = 8.4

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play325011049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = "ST13"

			if arg_196_1.bgs_[var_199_0] == nil then
				local var_199_1 = Object.Instantiate(arg_196_1.paintGo_)

				var_199_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_199_0)
				var_199_1.name = var_199_0
				var_199_1.transform.parent = arg_196_1.stage_.transform
				var_199_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_196_1.bgs_[var_199_0] = var_199_1
			end

			local var_199_2 = 1.8

			if var_199_2 < arg_196_1.time_ and arg_196_1.time_ <= var_199_2 + arg_199_0 then
				local var_199_3 = manager.ui.mainCamera.transform.localPosition
				local var_199_4 = Vector3.New(0, 0, 10) + Vector3.New(var_199_3.x, var_199_3.y, 0)
				local var_199_5 = arg_196_1.bgs_.ST13

				var_199_5.transform.localPosition = var_199_4
				var_199_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_199_6 = var_199_5:GetComponent("SpriteRenderer")

				if var_199_6 and var_199_6.sprite then
					local var_199_7 = (var_199_5.transform.localPosition - var_199_3).z
					local var_199_8 = manager.ui.mainCameraCom_
					local var_199_9 = 2 * var_199_7 * Mathf.Tan(var_199_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_199_10 = var_199_9 * var_199_8.aspect
					local var_199_11 = var_199_6.sprite.bounds.size.x
					local var_199_12 = var_199_6.sprite.bounds.size.y
					local var_199_13 = var_199_10 / var_199_11
					local var_199_14 = var_199_9 / var_199_12
					local var_199_15 = var_199_14 < var_199_13 and var_199_13 or var_199_14

					var_199_5.transform.localScale = Vector3.New(var_199_15, var_199_15, 0)
				end

				for iter_199_0, iter_199_1 in pairs(arg_196_1.bgs_) do
					if iter_199_0 ~= "ST13" then
						iter_199_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_199_16 = 1.8

			if var_199_16 < arg_196_1.time_ and arg_196_1.time_ <= var_199_16 + arg_199_0 then
				arg_196_1.allBtn_.enabled = false
			end

			local var_199_17 = 0.3

			if arg_196_1.time_ >= var_199_16 + var_199_17 and arg_196_1.time_ < var_199_16 + var_199_17 + arg_199_0 then
				arg_196_1.allBtn_.enabled = true
			end

			local var_199_18 = 0

			if var_199_18 < arg_196_1.time_ and arg_196_1.time_ <= var_199_18 + arg_199_0 then
				arg_196_1.mask_.enabled = true
				arg_196_1.mask_.raycastTarget = true

				arg_196_1:SetGaussion(false)
			end

			local var_199_19 = 1.8

			if var_199_18 <= arg_196_1.time_ and arg_196_1.time_ < var_199_18 + var_199_19 then
				local var_199_20 = (arg_196_1.time_ - var_199_18) / var_199_19
				local var_199_21 = Color.New(0, 0, 0)

				var_199_21.a = Mathf.Lerp(0, 1, var_199_20)
				arg_196_1.mask_.color = var_199_21
			end

			if arg_196_1.time_ >= var_199_18 + var_199_19 and arg_196_1.time_ < var_199_18 + var_199_19 + arg_199_0 then
				local var_199_22 = Color.New(0, 0, 0)

				var_199_22.a = 1
				arg_196_1.mask_.color = var_199_22
			end

			local var_199_23 = 1.8

			if var_199_23 < arg_196_1.time_ and arg_196_1.time_ <= var_199_23 + arg_199_0 then
				arg_196_1.mask_.enabled = true
				arg_196_1.mask_.raycastTarget = true

				arg_196_1:SetGaussion(false)
			end

			local var_199_24 = 2

			if var_199_23 <= arg_196_1.time_ and arg_196_1.time_ < var_199_23 + var_199_24 then
				local var_199_25 = (arg_196_1.time_ - var_199_23) / var_199_24
				local var_199_26 = Color.New(0, 0, 0)

				var_199_26.a = Mathf.Lerp(1, 0, var_199_25)
				arg_196_1.mask_.color = var_199_26
			end

			if arg_196_1.time_ >= var_199_23 + var_199_24 and arg_196_1.time_ < var_199_23 + var_199_24 + arg_199_0 then
				local var_199_27 = Color.New(0, 0, 0)
				local var_199_28 = 0

				arg_196_1.mask_.enabled = false
				var_199_27.a = var_199_28
				arg_196_1.mask_.color = var_199_27
			end

			local var_199_29 = arg_196_1.actors_["1077ui_story"].transform
			local var_199_30 = 1.8

			if var_199_30 < arg_196_1.time_ and arg_196_1.time_ <= var_199_30 + arg_199_0 then
				arg_196_1.var_.moveOldPos1077ui_story = var_199_29.localPosition

				local var_199_31 = GameObjectTools.GetOrAddComponent(var_199_29.gameObject, typeof(DynamicBoneHelper))

				if var_199_31 then
					var_199_31:EnableDynamicBone(false)
				end
			end

			local var_199_32 = 0.001

			if var_199_30 <= arg_196_1.time_ and arg_196_1.time_ < var_199_30 + var_199_32 then
				local var_199_33 = (arg_196_1.time_ - var_199_30) / var_199_32
				local var_199_34 = Vector3.New(0, 100, 0)

				var_199_29.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1077ui_story, var_199_34, var_199_33)

				local var_199_35 = manager.ui.mainCamera.transform.position - var_199_29.position

				var_199_29.forward = Vector3.New(var_199_35.x, var_199_35.y, var_199_35.z)

				local var_199_36 = var_199_29.localEulerAngles

				var_199_36.z = 0
				var_199_36.x = 0
				var_199_29.localEulerAngles = var_199_36
			end

			if arg_196_1.time_ >= var_199_30 + var_199_32 and arg_196_1.time_ < var_199_30 + var_199_32 + arg_199_0 then
				var_199_29.localPosition = Vector3.New(0, 100, 0)

				local var_199_37 = manager.ui.mainCamera.transform.position - var_199_29.position

				var_199_29.forward = Vector3.New(var_199_37.x, var_199_37.y, var_199_37.z)

				local var_199_38 = var_199_29.localEulerAngles

				var_199_38.z = 0
				var_199_38.x = 0
				var_199_29.localEulerAngles = var_199_38

				local var_199_39 = GameObjectTools.GetOrAddComponent(var_199_29.gameObject, typeof(DynamicBoneHelper))

				if var_199_39 then
					var_199_39:EnableDynamicBone(true)
				end
			end

			local var_199_40 = 1.2
			local var_199_41 = 1

			if var_199_40 < arg_196_1.time_ and arg_196_1.time_ <= var_199_40 + arg_199_0 then
				local var_199_42 = "play"
				local var_199_43 = "effect"

				arg_196_1:AudioAction(var_199_42, var_199_43, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_199_44 = 1.5
			local var_199_45 = 1

			if var_199_44 < arg_196_1.time_ and arg_196_1.time_ <= var_199_44 + arg_199_0 then
				local var_199_46 = "play"
				local var_199_47 = "effect"

				arg_196_1:AudioAction(var_199_46, var_199_47, "se_story_16", "se_story_16_door03", "")
			end

			local var_199_48 = 0.1
			local var_199_49 = 1

			if var_199_48 < arg_196_1.time_ and arg_196_1.time_ <= var_199_48 + arg_199_0 then
				local var_199_50 = "stop"
				local var_199_51 = "effect"

				arg_196_1:AudioAction(var_199_50, var_199_51, "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			local var_199_52 = 0.1
			local var_199_53 = 1

			if var_199_52 < arg_196_1.time_ and arg_196_1.time_ <= var_199_52 + arg_199_0 then
				local var_199_54 = "stop"
				local var_199_55 = "effect"

				arg_196_1:AudioAction(var_199_54, var_199_55, "se_story_143", "se_story_143_amb_town", "")
			end

			if arg_196_1.frameCnt_ <= 1 then
				arg_196_1.dialog_:SetActive(false)
			end

			local var_199_56 = 3.4
			local var_199_57 = 1.55

			if var_199_56 < arg_196_1.time_ and arg_196_1.time_ <= var_199_56 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0

				arg_196_1.dialog_:SetActive(true)

				arg_196_1.dialogCg_.alpha = 0

				local var_199_58 = LeanTween.value(arg_196_1.dialog_, 0, 1, 0.3)

				var_199_58:setOnUpdate(LuaHelper.FloatAction(function(arg_200_0)
					arg_196_1.dialogCg_.alpha = arg_200_0
				end))
				var_199_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_196_1.dialog_)
					var_199_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_196_1.duration_ = arg_196_1.duration_ + 0.3

				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_59 = arg_196_1:GetWordFromCfg(325011048)
				local var_199_60 = arg_196_1:FormatText(var_199_59.content)

				arg_196_1.text_.text = var_199_60

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_61 = 62
				local var_199_62 = utf8.len(var_199_60)
				local var_199_63 = var_199_61 <= 0 and var_199_57 or var_199_57 * (var_199_62 / var_199_61)

				if var_199_63 > 0 and var_199_57 < var_199_63 then
					arg_196_1.talkMaxDuration = var_199_63
					var_199_56 = var_199_56 + 0.3

					if var_199_63 + var_199_56 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_63 + var_199_56
					end
				end

				arg_196_1.text_.text = var_199_60
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_64 = var_199_56 + 0.3
			local var_199_65 = math.max(var_199_57, arg_196_1.talkMaxDuration)

			if var_199_64 <= arg_196_1.time_ and arg_196_1.time_ < var_199_64 + var_199_65 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_64) / var_199_65

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_64 + var_199_65 and arg_196_1.time_ < var_199_64 + var_199_65 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play325011049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 325011049
		arg_202_1.duration_ = 4.83

		local var_202_0 = {
			zh = 4.7,
			ja = 4.833
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play325011050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0
			local var_205_1 = 0.4

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_2 = arg_202_1:FormatText(StoryNameCfg[1467].name)

				arg_202_1.leftNameTxt_.text = var_205_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_3 = arg_202_1:GetWordFromCfg(325011049)
				local var_205_4 = arg_202_1:FormatText(var_205_3.content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 16
				local var_205_6 = utf8.len(var_205_4)
				local var_205_7 = var_205_5 <= 0 and var_205_1 or var_205_1 * (var_205_6 / var_205_5)

				if var_205_7 > 0 and var_205_1 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011049", "story_v_out_325011.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011049", "story_v_out_325011.awb") / 1000

					if var_205_8 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_0
					end

					if var_205_3.prefab_name ~= "" and arg_202_1.actors_[var_205_3.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_3.prefab_name].transform, "story_v_out_325011", "325011049", "story_v_out_325011.awb")

						arg_202_1:RecordAudio("325011049", var_205_9)
						arg_202_1:RecordAudio("325011049", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_325011", "325011049", "story_v_out_325011.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_325011", "325011049", "story_v_out_325011.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_10 and arg_202_1.time_ < var_205_0 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play325011050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 325011050
		arg_206_1.duration_ = 6.2

		local var_206_0 = {
			zh = 5.066,
			ja = 6.2
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play325011051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0
			local var_209_1 = 0.4

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_2 = arg_206_1:FormatText(StoryNameCfg[1467].name)

				arg_206_1.leftNameTxt_.text = var_209_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_3 = arg_206_1:GetWordFromCfg(325011050)
				local var_209_4 = arg_206_1:FormatText(var_209_3.content)

				arg_206_1.text_.text = var_209_4

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 16
				local var_209_6 = utf8.len(var_209_4)
				local var_209_7 = var_209_5 <= 0 and var_209_1 or var_209_1 * (var_209_6 / var_209_5)

				if var_209_7 > 0 and var_209_1 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_0
					end
				end

				arg_206_1.text_.text = var_209_4
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011050", "story_v_out_325011.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011050", "story_v_out_325011.awb") / 1000

					if var_209_8 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_0
					end

					if var_209_3.prefab_name ~= "" and arg_206_1.actors_[var_209_3.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_3.prefab_name].transform, "story_v_out_325011", "325011050", "story_v_out_325011.awb")

						arg_206_1:RecordAudio("325011050", var_209_9)
						arg_206_1:RecordAudio("325011050", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_325011", "325011050", "story_v_out_325011.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_325011", "325011050", "story_v_out_325011.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_10 = math.max(var_209_1, arg_206_1.talkMaxDuration)

			if var_209_0 <= arg_206_1.time_ and arg_206_1.time_ < var_209_0 + var_209_10 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_0) / var_209_10

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_0 + var_209_10 and arg_206_1.time_ < var_209_0 + var_209_10 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play325011051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 325011051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play325011052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0
			local var_213_1 = 1.125

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_2 = arg_210_1:GetWordFromCfg(325011051)
				local var_213_3 = arg_210_1:FormatText(var_213_2.content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 45
				local var_213_5 = utf8.len(var_213_3)
				local var_213_6 = var_213_4 <= 0 and var_213_1 or var_213_1 * (var_213_5 / var_213_4)

				if var_213_6 > 0 and var_213_1 < var_213_6 then
					arg_210_1.talkMaxDuration = var_213_6

					if var_213_6 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_6 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_3
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_7 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_7 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_7

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_7 and arg_210_1.time_ < var_213_0 + var_213_7 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play325011052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 325011052
		arg_214_1.duration_ = 4.43

		local var_214_0 = {
			zh = 3.7,
			ja = 4.433
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play325011053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1077ui_story"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos1077ui_story = var_217_0.localPosition

				local var_217_2 = GameObjectTools.GetOrAddComponent(var_217_0.gameObject, typeof(DynamicBoneHelper))

				if var_217_2 then
					var_217_2:EnableDynamicBone(false)
				end
			end

			local var_217_3 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_3 then
				local var_217_4 = (arg_214_1.time_ - var_217_1) / var_217_3
				local var_217_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1077ui_story, var_217_5, var_217_4)

				local var_217_6 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_6.x, var_217_6.y, var_217_6.z)

				local var_217_7 = var_217_0.localEulerAngles

				var_217_7.z = 0
				var_217_7.x = 0
				var_217_0.localEulerAngles = var_217_7
			end

			if arg_214_1.time_ >= var_217_1 + var_217_3 and arg_214_1.time_ < var_217_1 + var_217_3 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_217_8 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_8.x, var_217_8.y, var_217_8.z)

				local var_217_9 = var_217_0.localEulerAngles

				var_217_9.z = 0
				var_217_9.x = 0
				var_217_0.localEulerAngles = var_217_9

				local var_217_10 = GameObjectTools.GetOrAddComponent(var_217_0.gameObject, typeof(DynamicBoneHelper))

				if var_217_10 then
					var_217_10:EnableDynamicBone(true)
				end
			end

			local var_217_11 = arg_214_1.actors_["1077ui_story"]
			local var_217_12 = 0

			if var_217_12 < arg_214_1.time_ and arg_214_1.time_ <= var_217_12 + arg_217_0 and not isNil(var_217_11) and arg_214_1.var_.characterEffect1077ui_story == nil then
				arg_214_1.var_.characterEffect1077ui_story = var_217_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_13 = 0.200000002980232

			if var_217_12 <= arg_214_1.time_ and arg_214_1.time_ < var_217_12 + var_217_13 and not isNil(var_217_11) then
				local var_217_14 = (arg_214_1.time_ - var_217_12) / var_217_13

				if arg_214_1.var_.characterEffect1077ui_story and not isNil(var_217_11) then
					arg_214_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_12 + var_217_13 and arg_214_1.time_ < var_217_12 + var_217_13 + arg_217_0 and not isNil(var_217_11) and arg_214_1.var_.characterEffect1077ui_story then
				arg_214_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_217_15 = 0

			if var_217_15 < arg_214_1.time_ and arg_214_1.time_ <= var_217_15 + arg_217_0 then
				arg_214_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_217_16 = 0

			if var_217_16 < arg_214_1.time_ and arg_214_1.time_ <= var_217_16 + arg_217_0 then
				arg_214_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_217_17 = 0
			local var_217_18 = 0.55

			if var_217_17 < arg_214_1.time_ and arg_214_1.time_ <= var_217_17 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_19 = arg_214_1:FormatText(StoryNameCfg[1467].name)

				arg_214_1.leftNameTxt_.text = var_217_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_20 = arg_214_1:GetWordFromCfg(325011052)
				local var_217_21 = arg_214_1:FormatText(var_217_20.content)

				arg_214_1.text_.text = var_217_21

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_22 = 22
				local var_217_23 = utf8.len(var_217_21)
				local var_217_24 = var_217_22 <= 0 and var_217_18 or var_217_18 * (var_217_23 / var_217_22)

				if var_217_24 > 0 and var_217_18 < var_217_24 then
					arg_214_1.talkMaxDuration = var_217_24

					if var_217_24 + var_217_17 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_24 + var_217_17
					end
				end

				arg_214_1.text_.text = var_217_21
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011052", "story_v_out_325011.awb") ~= 0 then
					local var_217_25 = manager.audio:GetVoiceLength("story_v_out_325011", "325011052", "story_v_out_325011.awb") / 1000

					if var_217_25 + var_217_17 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_25 + var_217_17
					end

					if var_217_20.prefab_name ~= "" and arg_214_1.actors_[var_217_20.prefab_name] ~= nil then
						local var_217_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_20.prefab_name].transform, "story_v_out_325011", "325011052", "story_v_out_325011.awb")

						arg_214_1:RecordAudio("325011052", var_217_26)
						arg_214_1:RecordAudio("325011052", var_217_26)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_325011", "325011052", "story_v_out_325011.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_325011", "325011052", "story_v_out_325011.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_27 = math.max(var_217_18, arg_214_1.talkMaxDuration)

			if var_217_17 <= arg_214_1.time_ and arg_214_1.time_ < var_217_17 + var_217_27 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_17) / var_217_27

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_17 + var_217_27 and arg_214_1.time_ < var_217_17 + var_217_27 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play325011053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 325011053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play325011054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1077ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos1077ui_story = var_221_0.localPosition

				local var_221_2 = GameObjectTools.GetOrAddComponent(var_221_0.gameObject, typeof(DynamicBoneHelper))

				if var_221_2 then
					var_221_2:EnableDynamicBone(false)
				end
			end

			local var_221_3 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_3 then
				local var_221_4 = (arg_218_1.time_ - var_221_1) / var_221_3
				local var_221_5 = Vector3.New(0, 100, 0)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1077ui_story, var_221_5, var_221_4)

				local var_221_6 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_6.x, var_221_6.y, var_221_6.z)

				local var_221_7 = var_221_0.localEulerAngles

				var_221_7.z = 0
				var_221_7.x = 0
				var_221_0.localEulerAngles = var_221_7
			end

			if arg_218_1.time_ >= var_221_1 + var_221_3 and arg_218_1.time_ < var_221_1 + var_221_3 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0, 100, 0)

				local var_221_8 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_8.x, var_221_8.y, var_221_8.z)

				local var_221_9 = var_221_0.localEulerAngles

				var_221_9.z = 0
				var_221_9.x = 0
				var_221_0.localEulerAngles = var_221_9

				local var_221_10 = GameObjectTools.GetOrAddComponent(var_221_0.gameObject, typeof(DynamicBoneHelper))

				if var_221_10 then
					var_221_10:EnableDynamicBone(true)
				end
			end

			local var_221_11 = arg_218_1.actors_["1077ui_story"]
			local var_221_12 = 0

			if var_221_12 < arg_218_1.time_ and arg_218_1.time_ <= var_221_12 + arg_221_0 and not isNil(var_221_11) and arg_218_1.var_.characterEffect1077ui_story == nil then
				arg_218_1.var_.characterEffect1077ui_story = var_221_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_13 = 0.200000002980232

			if var_221_12 <= arg_218_1.time_ and arg_218_1.time_ < var_221_12 + var_221_13 and not isNil(var_221_11) then
				local var_221_14 = (arg_218_1.time_ - var_221_12) / var_221_13

				if arg_218_1.var_.characterEffect1077ui_story and not isNil(var_221_11) then
					local var_221_15 = Mathf.Lerp(0, 0.5, var_221_14)

					arg_218_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1077ui_story.fillRatio = var_221_15
				end
			end

			if arg_218_1.time_ >= var_221_12 + var_221_13 and arg_218_1.time_ < var_221_12 + var_221_13 + arg_221_0 and not isNil(var_221_11) and arg_218_1.var_.characterEffect1077ui_story then
				local var_221_16 = 0.5

				arg_218_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1077ui_story.fillRatio = var_221_16
			end

			local var_221_17 = 0.1
			local var_221_18 = 1

			if var_221_17 < arg_218_1.time_ and arg_218_1.time_ <= var_221_17 + arg_221_0 then
				local var_221_19 = "play"
				local var_221_20 = "effect"

				arg_218_1:AudioAction(var_221_19, var_221_20, "se_story_side_1085", "se_story_side_1085_sit", "")
			end

			local var_221_21 = 0.5
			local var_221_22 = 1

			if var_221_21 < arg_218_1.time_ and arg_218_1.time_ <= var_221_21 + arg_221_0 then
				local var_221_23 = "play"
				local var_221_24 = "effect"

				arg_218_1:AudioAction(var_221_23, var_221_24, "se_story_15", "se_story_15_ui", "")
			end

			local var_221_25 = 0
			local var_221_26 = 0.95

			if var_221_25 < arg_218_1.time_ and arg_218_1.time_ <= var_221_25 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_27 = arg_218_1:GetWordFromCfg(325011053)
				local var_221_28 = arg_218_1:FormatText(var_221_27.content)

				arg_218_1.text_.text = var_221_28

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_29 = 38
				local var_221_30 = utf8.len(var_221_28)
				local var_221_31 = var_221_29 <= 0 and var_221_26 or var_221_26 * (var_221_30 / var_221_29)

				if var_221_31 > 0 and var_221_26 < var_221_31 then
					arg_218_1.talkMaxDuration = var_221_31

					if var_221_31 + var_221_25 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_31 + var_221_25
					end
				end

				arg_218_1.text_.text = var_221_28
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_32 = math.max(var_221_26, arg_218_1.talkMaxDuration)

			if var_221_25 <= arg_218_1.time_ and arg_218_1.time_ < var_221_25 + var_221_32 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_25) / var_221_32

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_25 + var_221_32 and arg_218_1.time_ < var_221_25 + var_221_32 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play325011054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 325011054
		arg_222_1.duration_ = 6.9

		local var_222_0 = {
			zh = 6.9,
			ja = 6.133
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play325011055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1077ui_story"].transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.var_.moveOldPos1077ui_story = var_225_0.localPosition

				local var_225_2 = GameObjectTools.GetOrAddComponent(var_225_0.gameObject, typeof(DynamicBoneHelper))

				if var_225_2 then
					var_225_2:EnableDynamicBone(false)
				end
			end

			local var_225_3 = 0.001

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_3 then
				local var_225_4 = (arg_222_1.time_ - var_225_1) / var_225_3
				local var_225_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_225_0.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1077ui_story, var_225_5, var_225_4)

				local var_225_6 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_6.x, var_225_6.y, var_225_6.z)

				local var_225_7 = var_225_0.localEulerAngles

				var_225_7.z = 0
				var_225_7.x = 0
				var_225_0.localEulerAngles = var_225_7
			end

			if arg_222_1.time_ >= var_225_1 + var_225_3 and arg_222_1.time_ < var_225_1 + var_225_3 + arg_225_0 then
				var_225_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_225_8 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_8.x, var_225_8.y, var_225_8.z)

				local var_225_9 = var_225_0.localEulerAngles

				var_225_9.z = 0
				var_225_9.x = 0
				var_225_0.localEulerAngles = var_225_9

				local var_225_10 = GameObjectTools.GetOrAddComponent(var_225_0.gameObject, typeof(DynamicBoneHelper))

				if var_225_10 then
					var_225_10:EnableDynamicBone(true)
				end
			end

			local var_225_11 = arg_222_1.actors_["1077ui_story"]
			local var_225_12 = 0

			if var_225_12 < arg_222_1.time_ and arg_222_1.time_ <= var_225_12 + arg_225_0 and not isNil(var_225_11) and arg_222_1.var_.characterEffect1077ui_story == nil then
				arg_222_1.var_.characterEffect1077ui_story = var_225_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_13 = 0.200000002980232

			if var_225_12 <= arg_222_1.time_ and arg_222_1.time_ < var_225_12 + var_225_13 and not isNil(var_225_11) then
				local var_225_14 = (arg_222_1.time_ - var_225_12) / var_225_13

				if arg_222_1.var_.characterEffect1077ui_story and not isNil(var_225_11) then
					arg_222_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_12 + var_225_13 and arg_222_1.time_ < var_225_12 + var_225_13 + arg_225_0 and not isNil(var_225_11) and arg_222_1.var_.characterEffect1077ui_story then
				arg_222_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_225_15 = 0

			if var_225_15 < arg_222_1.time_ and arg_222_1.time_ <= var_225_15 + arg_225_0 then
				arg_222_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_225_16 = 0
			local var_225_17 = 0.8

			if var_225_16 < arg_222_1.time_ and arg_222_1.time_ <= var_225_16 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_18 = arg_222_1:FormatText(StoryNameCfg[1467].name)

				arg_222_1.leftNameTxt_.text = var_225_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_19 = arg_222_1:GetWordFromCfg(325011054)
				local var_225_20 = arg_222_1:FormatText(var_225_19.content)

				arg_222_1.text_.text = var_225_20

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_21 = 32
				local var_225_22 = utf8.len(var_225_20)
				local var_225_23 = var_225_21 <= 0 and var_225_17 or var_225_17 * (var_225_22 / var_225_21)

				if var_225_23 > 0 and var_225_17 < var_225_23 then
					arg_222_1.talkMaxDuration = var_225_23

					if var_225_23 + var_225_16 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_23 + var_225_16
					end
				end

				arg_222_1.text_.text = var_225_20
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011054", "story_v_out_325011.awb") ~= 0 then
					local var_225_24 = manager.audio:GetVoiceLength("story_v_out_325011", "325011054", "story_v_out_325011.awb") / 1000

					if var_225_24 + var_225_16 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_24 + var_225_16
					end

					if var_225_19.prefab_name ~= "" and arg_222_1.actors_[var_225_19.prefab_name] ~= nil then
						local var_225_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_19.prefab_name].transform, "story_v_out_325011", "325011054", "story_v_out_325011.awb")

						arg_222_1:RecordAudio("325011054", var_225_25)
						arg_222_1:RecordAudio("325011054", var_225_25)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_325011", "325011054", "story_v_out_325011.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_325011", "325011054", "story_v_out_325011.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_26 = math.max(var_225_17, arg_222_1.talkMaxDuration)

			if var_225_16 <= arg_222_1.time_ and arg_222_1.time_ < var_225_16 + var_225_26 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_16) / var_225_26

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_16 + var_225_26 and arg_222_1.time_ < var_225_16 + var_225_26 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play325011055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 325011055
		arg_226_1.duration_ = 10.33

		local var_226_0 = {
			zh = 10.333,
			ja = 8.633
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play325011056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 1.175

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_2 = arg_226_1:FormatText(StoryNameCfg[1467].name)

				arg_226_1.leftNameTxt_.text = var_229_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_3 = arg_226_1:GetWordFromCfg(325011055)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 46
				local var_229_6 = utf8.len(var_229_4)
				local var_229_7 = var_229_5 <= 0 and var_229_1 or var_229_1 * (var_229_6 / var_229_5)

				if var_229_7 > 0 and var_229_1 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_4
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011055", "story_v_out_325011.awb") ~= 0 then
					local var_229_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011055", "story_v_out_325011.awb") / 1000

					if var_229_8 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_0
					end

					if var_229_3.prefab_name ~= "" and arg_226_1.actors_[var_229_3.prefab_name] ~= nil then
						local var_229_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_3.prefab_name].transform, "story_v_out_325011", "325011055", "story_v_out_325011.awb")

						arg_226_1:RecordAudio("325011055", var_229_9)
						arg_226_1:RecordAudio("325011055", var_229_9)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_325011", "325011055", "story_v_out_325011.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_325011", "325011055", "story_v_out_325011.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_10 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_10 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_10

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_10 and arg_226_1.time_ < var_229_0 + var_229_10 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play325011056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 325011056
		arg_230_1.duration_ = 6.23

		local var_230_0 = {
			zh = 3.933,
			ja = 6.233
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
				arg_230_0:Play325011057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0
			local var_233_1 = 0.375

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_2 = arg_230_1:FormatText(StoryNameCfg[1467].name)

				arg_230_1.leftNameTxt_.text = var_233_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_3 = arg_230_1:GetWordFromCfg(325011056)
				local var_233_4 = arg_230_1:FormatText(var_233_3.content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 15
				local var_233_6 = utf8.len(var_233_4)
				local var_233_7 = var_233_5 <= 0 and var_233_1 or var_233_1 * (var_233_6 / var_233_5)

				if var_233_7 > 0 and var_233_1 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_0
					end
				end

				arg_230_1.text_.text = var_233_4
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011056", "story_v_out_325011.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011056", "story_v_out_325011.awb") / 1000

					if var_233_8 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_0
					end

					if var_233_3.prefab_name ~= "" and arg_230_1.actors_[var_233_3.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_3.prefab_name].transform, "story_v_out_325011", "325011056", "story_v_out_325011.awb")

						arg_230_1:RecordAudio("325011056", var_233_9)
						arg_230_1:RecordAudio("325011056", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_325011", "325011056", "story_v_out_325011.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_325011", "325011056", "story_v_out_325011.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_1, arg_230_1.talkMaxDuration)

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_0) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_0 + var_233_10 and arg_230_1.time_ < var_233_0 + var_233_10 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play325011057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 325011057
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play325011058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1077ui_story"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos1077ui_story = var_237_0.localPosition

				local var_237_2 = GameObjectTools.GetOrAddComponent(var_237_0.gameObject, typeof(DynamicBoneHelper))

				if var_237_2 then
					var_237_2:EnableDynamicBone(false)
				end
			end

			local var_237_3 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_3 then
				local var_237_4 = (arg_234_1.time_ - var_237_1) / var_237_3
				local var_237_5 = Vector3.New(0, 100, 0)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1077ui_story, var_237_5, var_237_4)

				local var_237_6 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_6.x, var_237_6.y, var_237_6.z)

				local var_237_7 = var_237_0.localEulerAngles

				var_237_7.z = 0
				var_237_7.x = 0
				var_237_0.localEulerAngles = var_237_7
			end

			if arg_234_1.time_ >= var_237_1 + var_237_3 and arg_234_1.time_ < var_237_1 + var_237_3 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(0, 100, 0)

				local var_237_8 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_8.x, var_237_8.y, var_237_8.z)

				local var_237_9 = var_237_0.localEulerAngles

				var_237_9.z = 0
				var_237_9.x = 0
				var_237_0.localEulerAngles = var_237_9

				local var_237_10 = GameObjectTools.GetOrAddComponent(var_237_0.gameObject, typeof(DynamicBoneHelper))

				if var_237_10 then
					var_237_10:EnableDynamicBone(true)
				end
			end

			local var_237_11 = arg_234_1.actors_["1077ui_story"]
			local var_237_12 = 0

			if var_237_12 < arg_234_1.time_ and arg_234_1.time_ <= var_237_12 + arg_237_0 and not isNil(var_237_11) and arg_234_1.var_.characterEffect1077ui_story == nil then
				arg_234_1.var_.characterEffect1077ui_story = var_237_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_13 = 0.200000002980232

			if var_237_12 <= arg_234_1.time_ and arg_234_1.time_ < var_237_12 + var_237_13 and not isNil(var_237_11) then
				local var_237_14 = (arg_234_1.time_ - var_237_12) / var_237_13

				if arg_234_1.var_.characterEffect1077ui_story and not isNil(var_237_11) then
					local var_237_15 = Mathf.Lerp(0, 0.5, var_237_14)

					arg_234_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1077ui_story.fillRatio = var_237_15
				end
			end

			if arg_234_1.time_ >= var_237_12 + var_237_13 and arg_234_1.time_ < var_237_12 + var_237_13 + arg_237_0 and not isNil(var_237_11) and arg_234_1.var_.characterEffect1077ui_story then
				local var_237_16 = 0.5

				arg_234_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1077ui_story.fillRatio = var_237_16
			end

			local var_237_17 = 0
			local var_237_18 = 1.6

			if var_237_17 < arg_234_1.time_ and arg_234_1.time_ <= var_237_17 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_19 = arg_234_1:GetWordFromCfg(325011057)
				local var_237_20 = arg_234_1:FormatText(var_237_19.content)

				arg_234_1.text_.text = var_237_20

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_21 = 64
				local var_237_22 = utf8.len(var_237_20)
				local var_237_23 = var_237_21 <= 0 and var_237_18 or var_237_18 * (var_237_22 / var_237_21)

				if var_237_23 > 0 and var_237_18 < var_237_23 then
					arg_234_1.talkMaxDuration = var_237_23

					if var_237_23 + var_237_17 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_23 + var_237_17
					end
				end

				arg_234_1.text_.text = var_237_20
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_24 = math.max(var_237_18, arg_234_1.talkMaxDuration)

			if var_237_17 <= arg_234_1.time_ and arg_234_1.time_ < var_237_17 + var_237_24 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_17) / var_237_24

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_17 + var_237_24 and arg_234_1.time_ < var_237_17 + var_237_24 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play325011058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 325011058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play325011059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 1.5

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_2 = arg_238_1:GetWordFromCfg(325011058)
				local var_241_3 = arg_238_1:FormatText(var_241_2.content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_4 = 60
				local var_241_5 = utf8.len(var_241_3)
				local var_241_6 = var_241_4 <= 0 and var_241_1 or var_241_1 * (var_241_5 / var_241_4)

				if var_241_6 > 0 and var_241_1 < var_241_6 then
					arg_238_1.talkMaxDuration = var_241_6

					if var_241_6 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_6 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_7 and arg_238_1.time_ < var_241_0 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play325011059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 325011059
		arg_242_1.duration_ = 4.07

		local var_242_0 = {
			zh = 4.066,
			ja = 2.4
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
				arg_242_0:Play325011060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1077ui_story"].transform
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.var_.moveOldPos1077ui_story = var_245_0.localPosition

				local var_245_2 = GameObjectTools.GetOrAddComponent(var_245_0.gameObject, typeof(DynamicBoneHelper))

				if var_245_2 then
					var_245_2:EnableDynamicBone(false)
				end
			end

			local var_245_3 = 0.001

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_3 then
				local var_245_4 = (arg_242_1.time_ - var_245_1) / var_245_3
				local var_245_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_245_0.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1077ui_story, var_245_5, var_245_4)

				local var_245_6 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_6.x, var_245_6.y, var_245_6.z)

				local var_245_7 = var_245_0.localEulerAngles

				var_245_7.z = 0
				var_245_7.x = 0
				var_245_0.localEulerAngles = var_245_7
			end

			if arg_242_1.time_ >= var_245_1 + var_245_3 and arg_242_1.time_ < var_245_1 + var_245_3 + arg_245_0 then
				var_245_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_245_8 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_8.x, var_245_8.y, var_245_8.z)

				local var_245_9 = var_245_0.localEulerAngles

				var_245_9.z = 0
				var_245_9.x = 0
				var_245_0.localEulerAngles = var_245_9

				local var_245_10 = GameObjectTools.GetOrAddComponent(var_245_0.gameObject, typeof(DynamicBoneHelper))

				if var_245_10 then
					var_245_10:EnableDynamicBone(true)
				end
			end

			local var_245_11 = arg_242_1.actors_["1077ui_story"]
			local var_245_12 = 0

			if var_245_12 < arg_242_1.time_ and arg_242_1.time_ <= var_245_12 + arg_245_0 and not isNil(var_245_11) and arg_242_1.var_.characterEffect1077ui_story == nil then
				arg_242_1.var_.characterEffect1077ui_story = var_245_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_13 = 0.200000002980232

			if var_245_12 <= arg_242_1.time_ and arg_242_1.time_ < var_245_12 + var_245_13 and not isNil(var_245_11) then
				local var_245_14 = (arg_242_1.time_ - var_245_12) / var_245_13

				if arg_242_1.var_.characterEffect1077ui_story and not isNil(var_245_11) then
					arg_242_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_12 + var_245_13 and arg_242_1.time_ < var_245_12 + var_245_13 + arg_245_0 and not isNil(var_245_11) and arg_242_1.var_.characterEffect1077ui_story then
				arg_242_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_245_15 = 0

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_245_16 = 0

			if var_245_16 < arg_242_1.time_ and arg_242_1.time_ <= var_245_16 + arg_245_0 then
				arg_242_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_245_17 = 0
			local var_245_18 = 0.275

			if var_245_17 < arg_242_1.time_ and arg_242_1.time_ <= var_245_17 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_19 = arg_242_1:FormatText(StoryNameCfg[1467].name)

				arg_242_1.leftNameTxt_.text = var_245_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_20 = arg_242_1:GetWordFromCfg(325011059)
				local var_245_21 = arg_242_1:FormatText(var_245_20.content)

				arg_242_1.text_.text = var_245_21

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_22 = 11
				local var_245_23 = utf8.len(var_245_21)
				local var_245_24 = var_245_22 <= 0 and var_245_18 or var_245_18 * (var_245_23 / var_245_22)

				if var_245_24 > 0 and var_245_18 < var_245_24 then
					arg_242_1.talkMaxDuration = var_245_24

					if var_245_24 + var_245_17 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_24 + var_245_17
					end
				end

				arg_242_1.text_.text = var_245_21
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011059", "story_v_out_325011.awb") ~= 0 then
					local var_245_25 = manager.audio:GetVoiceLength("story_v_out_325011", "325011059", "story_v_out_325011.awb") / 1000

					if var_245_25 + var_245_17 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_25 + var_245_17
					end

					if var_245_20.prefab_name ~= "" and arg_242_1.actors_[var_245_20.prefab_name] ~= nil then
						local var_245_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_20.prefab_name].transform, "story_v_out_325011", "325011059", "story_v_out_325011.awb")

						arg_242_1:RecordAudio("325011059", var_245_26)
						arg_242_1:RecordAudio("325011059", var_245_26)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_325011", "325011059", "story_v_out_325011.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_325011", "325011059", "story_v_out_325011.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_27 = math.max(var_245_18, arg_242_1.talkMaxDuration)

			if var_245_17 <= arg_242_1.time_ and arg_242_1.time_ < var_245_17 + var_245_27 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_17) / var_245_27

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_17 + var_245_27 and arg_242_1.time_ < var_245_17 + var_245_27 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play325011060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 325011060
		arg_246_1.duration_ = 6.33

		local var_246_0 = {
			zh = 5.633,
			ja = 6.333
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
				arg_246_0:Play325011061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.625

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_2 = arg_246_1:FormatText(StoryNameCfg[1467].name)

				arg_246_1.leftNameTxt_.text = var_249_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_3 = arg_246_1:GetWordFromCfg(325011060)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 25
				local var_249_6 = utf8.len(var_249_4)
				local var_249_7 = var_249_5 <= 0 and var_249_1 or var_249_1 * (var_249_6 / var_249_5)

				if var_249_7 > 0 and var_249_1 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011060", "story_v_out_325011.awb") ~= 0 then
					local var_249_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011060", "story_v_out_325011.awb") / 1000

					if var_249_8 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_8 + var_249_0
					end

					if var_249_3.prefab_name ~= "" and arg_246_1.actors_[var_249_3.prefab_name] ~= nil then
						local var_249_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_3.prefab_name].transform, "story_v_out_325011", "325011060", "story_v_out_325011.awb")

						arg_246_1:RecordAudio("325011060", var_249_9)
						arg_246_1:RecordAudio("325011060", var_249_9)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_325011", "325011060", "story_v_out_325011.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_325011", "325011060", "story_v_out_325011.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_10 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_10 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_10

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_10 and arg_246_1.time_ < var_249_0 + var_249_10 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play325011061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 325011061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play325011062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1077ui_story"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1077ui_story == nil then
				arg_250_1.var_.characterEffect1077ui_story = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect1077ui_story and not isNil(var_253_0) then
					local var_253_4 = Mathf.Lerp(0, 0.5, var_253_3)

					arg_250_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1077ui_story.fillRatio = var_253_4
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1077ui_story then
				local var_253_5 = 0.5

				arg_250_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1077ui_story.fillRatio = var_253_5
			end

			local var_253_6 = arg_250_1.actors_["1077ui_story"].transform
			local var_253_7 = 0

			if var_253_7 < arg_250_1.time_ and arg_250_1.time_ <= var_253_7 + arg_253_0 then
				arg_250_1.var_.moveOldPos1077ui_story = var_253_6.localPosition

				local var_253_8 = GameObjectTools.GetOrAddComponent(var_253_6.gameObject, typeof(DynamicBoneHelper))

				if var_253_8 then
					var_253_8:EnableDynamicBone(false)
				end
			end

			local var_253_9 = 0.001

			if var_253_7 <= arg_250_1.time_ and arg_250_1.time_ < var_253_7 + var_253_9 then
				local var_253_10 = (arg_250_1.time_ - var_253_7) / var_253_9
				local var_253_11 = Vector3.New(0, 100, 0)

				var_253_6.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1077ui_story, var_253_11, var_253_10)

				local var_253_12 = manager.ui.mainCamera.transform.position - var_253_6.position

				var_253_6.forward = Vector3.New(var_253_12.x, var_253_12.y, var_253_12.z)

				local var_253_13 = var_253_6.localEulerAngles

				var_253_13.z = 0
				var_253_13.x = 0
				var_253_6.localEulerAngles = var_253_13
			end

			if arg_250_1.time_ >= var_253_7 + var_253_9 and arg_250_1.time_ < var_253_7 + var_253_9 + arg_253_0 then
				var_253_6.localPosition = Vector3.New(0, 100, 0)

				local var_253_14 = manager.ui.mainCamera.transform.position - var_253_6.position

				var_253_6.forward = Vector3.New(var_253_14.x, var_253_14.y, var_253_14.z)

				local var_253_15 = var_253_6.localEulerAngles

				var_253_15.z = 0
				var_253_15.x = 0
				var_253_6.localEulerAngles = var_253_15

				local var_253_16 = GameObjectTools.GetOrAddComponent(var_253_6.gameObject, typeof(DynamicBoneHelper))

				if var_253_16 then
					var_253_16:EnableDynamicBone(true)
				end
			end

			local var_253_17 = 0
			local var_253_18 = 1.1

			if var_253_17 < arg_250_1.time_ and arg_250_1.time_ <= var_253_17 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_19 = arg_250_1:GetWordFromCfg(325011061)
				local var_253_20 = arg_250_1:FormatText(var_253_19.content)

				arg_250_1.text_.text = var_253_20

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_21 = 44
				local var_253_22 = utf8.len(var_253_20)
				local var_253_23 = var_253_21 <= 0 and var_253_18 or var_253_18 * (var_253_22 / var_253_21)

				if var_253_23 > 0 and var_253_18 < var_253_23 then
					arg_250_1.talkMaxDuration = var_253_23

					if var_253_23 + var_253_17 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_23 + var_253_17
					end
				end

				arg_250_1.text_.text = var_253_20
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_24 = math.max(var_253_18, arg_250_1.talkMaxDuration)

			if var_253_17 <= arg_250_1.time_ and arg_250_1.time_ < var_253_17 + var_253_24 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_17) / var_253_24

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_17 + var_253_24 and arg_250_1.time_ < var_253_17 + var_253_24 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play325011062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 325011062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play325011063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.3
			local var_257_1 = 1

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				local var_257_2 = "play"
				local var_257_3 = "effect"

				arg_254_1:AudioAction(var_257_2, var_257_3, "se_story_side_1095", "se_story_side_1095_foley_cloth", "")
			end

			local var_257_4 = 0
			local var_257_5 = 0.95

			if var_257_4 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_6 = arg_254_1:GetWordFromCfg(325011062)
				local var_257_7 = arg_254_1:FormatText(var_257_6.content)

				arg_254_1.text_.text = var_257_7

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_8 = 38
				local var_257_9 = utf8.len(var_257_7)
				local var_257_10 = var_257_8 <= 0 and var_257_5 or var_257_5 * (var_257_9 / var_257_8)

				if var_257_10 > 0 and var_257_5 < var_257_10 then
					arg_254_1.talkMaxDuration = var_257_10

					if var_257_10 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_10 + var_257_4
					end
				end

				arg_254_1.text_.text = var_257_7
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_11 = math.max(var_257_5, arg_254_1.talkMaxDuration)

			if var_257_4 <= arg_254_1.time_ and arg_254_1.time_ < var_257_4 + var_257_11 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_4) / var_257_11

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_4 + var_257_11 and arg_254_1.time_ < var_257_4 + var_257_11 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play325011063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 325011063
		arg_258_1.duration_ = 9.73

		local var_258_0 = {
			zh = 6.266,
			ja = 9.733
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
				arg_258_0:Play325011064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1077ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos1077ui_story = var_261_0.localPosition

				local var_261_2 = GameObjectTools.GetOrAddComponent(var_261_0.gameObject, typeof(DynamicBoneHelper))

				if var_261_2 then
					var_261_2:EnableDynamicBone(false)
				end
			end

			local var_261_3 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_3 then
				local var_261_4 = (arg_258_1.time_ - var_261_1) / var_261_3
				local var_261_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1077ui_story, var_261_5, var_261_4)

				local var_261_6 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_6.x, var_261_6.y, var_261_6.z)

				local var_261_7 = var_261_0.localEulerAngles

				var_261_7.z = 0
				var_261_7.x = 0
				var_261_0.localEulerAngles = var_261_7
			end

			if arg_258_1.time_ >= var_261_1 + var_261_3 and arg_258_1.time_ < var_261_1 + var_261_3 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_261_8 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_8.x, var_261_8.y, var_261_8.z)

				local var_261_9 = var_261_0.localEulerAngles

				var_261_9.z = 0
				var_261_9.x = 0
				var_261_0.localEulerAngles = var_261_9

				local var_261_10 = GameObjectTools.GetOrAddComponent(var_261_0.gameObject, typeof(DynamicBoneHelper))

				if var_261_10 then
					var_261_10:EnableDynamicBone(true)
				end
			end

			local var_261_11 = arg_258_1.actors_["1077ui_story"]
			local var_261_12 = 0

			if var_261_12 < arg_258_1.time_ and arg_258_1.time_ <= var_261_12 + arg_261_0 and not isNil(var_261_11) and arg_258_1.var_.characterEffect1077ui_story == nil then
				arg_258_1.var_.characterEffect1077ui_story = var_261_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_13 = 0.200000002980232

			if var_261_12 <= arg_258_1.time_ and arg_258_1.time_ < var_261_12 + var_261_13 and not isNil(var_261_11) then
				local var_261_14 = (arg_258_1.time_ - var_261_12) / var_261_13

				if arg_258_1.var_.characterEffect1077ui_story and not isNil(var_261_11) then
					arg_258_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_12 + var_261_13 and arg_258_1.time_ < var_261_12 + var_261_13 + arg_261_0 and not isNil(var_261_11) and arg_258_1.var_.characterEffect1077ui_story then
				arg_258_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_261_15 = 0
			local var_261_16 = 0.6

			if var_261_15 < arg_258_1.time_ and arg_258_1.time_ <= var_261_15 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_17 = arg_258_1:FormatText(StoryNameCfg[1467].name)

				arg_258_1.leftNameTxt_.text = var_261_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_18 = arg_258_1:GetWordFromCfg(325011063)
				local var_261_19 = arg_258_1:FormatText(var_261_18.content)

				arg_258_1.text_.text = var_261_19

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_20 = 24
				local var_261_21 = utf8.len(var_261_19)
				local var_261_22 = var_261_20 <= 0 and var_261_16 or var_261_16 * (var_261_21 / var_261_20)

				if var_261_22 > 0 and var_261_16 < var_261_22 then
					arg_258_1.talkMaxDuration = var_261_22

					if var_261_22 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_22 + var_261_15
					end
				end

				arg_258_1.text_.text = var_261_19
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011063", "story_v_out_325011.awb") ~= 0 then
					local var_261_23 = manager.audio:GetVoiceLength("story_v_out_325011", "325011063", "story_v_out_325011.awb") / 1000

					if var_261_23 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_23 + var_261_15
					end

					if var_261_18.prefab_name ~= "" and arg_258_1.actors_[var_261_18.prefab_name] ~= nil then
						local var_261_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_18.prefab_name].transform, "story_v_out_325011", "325011063", "story_v_out_325011.awb")

						arg_258_1:RecordAudio("325011063", var_261_24)
						arg_258_1:RecordAudio("325011063", var_261_24)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_325011", "325011063", "story_v_out_325011.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_325011", "325011063", "story_v_out_325011.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_25 = math.max(var_261_16, arg_258_1.talkMaxDuration)

			if var_261_15 <= arg_258_1.time_ and arg_258_1.time_ < var_261_15 + var_261_25 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_15) / var_261_25

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_15 + var_261_25 and arg_258_1.time_ < var_261_15 + var_261_25 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play325011064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 325011064
		arg_262_1.duration_ = 6.27

		local var_262_0 = {
			zh = 4.566,
			ja = 6.266
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play325011065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			local var_265_1 = 0
			local var_265_2 = 0.625

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_3 = arg_262_1:FormatText(StoryNameCfg[1467].name)

				arg_262_1.leftNameTxt_.text = var_265_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_4 = arg_262_1:GetWordFromCfg(325011064)
				local var_265_5 = arg_262_1:FormatText(var_265_4.content)

				arg_262_1.text_.text = var_265_5

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_6 = 25
				local var_265_7 = utf8.len(var_265_5)
				local var_265_8 = var_265_6 <= 0 and var_265_2 or var_265_2 * (var_265_7 / var_265_6)

				if var_265_8 > 0 and var_265_2 < var_265_8 then
					arg_262_1.talkMaxDuration = var_265_8

					if var_265_8 + var_265_1 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_1
					end
				end

				arg_262_1.text_.text = var_265_5
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011064", "story_v_out_325011.awb") ~= 0 then
					local var_265_9 = manager.audio:GetVoiceLength("story_v_out_325011", "325011064", "story_v_out_325011.awb") / 1000

					if var_265_9 + var_265_1 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_9 + var_265_1
					end

					if var_265_4.prefab_name ~= "" and arg_262_1.actors_[var_265_4.prefab_name] ~= nil then
						local var_265_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_4.prefab_name].transform, "story_v_out_325011", "325011064", "story_v_out_325011.awb")

						arg_262_1:RecordAudio("325011064", var_265_10)
						arg_262_1:RecordAudio("325011064", var_265_10)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_325011", "325011064", "story_v_out_325011.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_325011", "325011064", "story_v_out_325011.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_11 = math.max(var_265_2, arg_262_1.talkMaxDuration)

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_11 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_1) / var_265_11

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_1 + var_265_11 and arg_262_1.time_ < var_265_1 + var_265_11 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play325011065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 325011065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play325011066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1077ui_story"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect1077ui_story == nil then
				arg_266_1.var_.characterEffect1077ui_story = var_269_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.characterEffect1077ui_story and not isNil(var_269_0) then
					local var_269_4 = Mathf.Lerp(0, 0.5, var_269_3)

					arg_266_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1077ui_story.fillRatio = var_269_4
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect1077ui_story then
				local var_269_5 = 0.5

				arg_266_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1077ui_story.fillRatio = var_269_5
			end

			local var_269_6 = 0
			local var_269_7 = 0.15

			if var_269_6 < arg_266_1.time_ and arg_266_1.time_ <= var_269_6 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_8 = arg_266_1:GetWordFromCfg(325011065)
				local var_269_9 = arg_266_1:FormatText(var_269_8.content)

				arg_266_1.text_.text = var_269_9

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_10 = 6
				local var_269_11 = utf8.len(var_269_9)
				local var_269_12 = var_269_10 <= 0 and var_269_7 or var_269_7 * (var_269_11 / var_269_10)

				if var_269_12 > 0 and var_269_7 < var_269_12 then
					arg_266_1.talkMaxDuration = var_269_12

					if var_269_12 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_12 + var_269_6
					end
				end

				arg_266_1.text_.text = var_269_9
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_13 = math.max(var_269_7, arg_266_1.talkMaxDuration)

			if var_269_6 <= arg_266_1.time_ and arg_266_1.time_ < var_269_6 + var_269_13 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_6) / var_269_13

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_6 + var_269_13 and arg_266_1.time_ < var_269_6 + var_269_13 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play325011066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 325011066
		arg_270_1.duration_ = 5.6

		local var_270_0 = {
			zh = 3.7,
			ja = 5.6
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play325011067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1077ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1077ui_story == nil then
				arg_270_1.var_.characterEffect1077ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect1077ui_story and not isNil(var_273_0) then
					arg_270_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1077ui_story then
				arg_270_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_273_4 = 0

			if var_273_4 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			local var_273_5 = 0

			if var_273_5 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_273_6 = 0
			local var_273_7 = 0.475

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_8 = arg_270_1:FormatText(StoryNameCfg[1467].name)

				arg_270_1.leftNameTxt_.text = var_273_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_9 = arg_270_1:GetWordFromCfg(325011066)
				local var_273_10 = arg_270_1:FormatText(var_273_9.content)

				arg_270_1.text_.text = var_273_10

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_11 = 19
				local var_273_12 = utf8.len(var_273_10)
				local var_273_13 = var_273_11 <= 0 and var_273_7 or var_273_7 * (var_273_12 / var_273_11)

				if var_273_13 > 0 and var_273_7 < var_273_13 then
					arg_270_1.talkMaxDuration = var_273_13

					if var_273_13 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_6
					end
				end

				arg_270_1.text_.text = var_273_10
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011066", "story_v_out_325011.awb") ~= 0 then
					local var_273_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011066", "story_v_out_325011.awb") / 1000

					if var_273_14 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_14 + var_273_6
					end

					if var_273_9.prefab_name ~= "" and arg_270_1.actors_[var_273_9.prefab_name] ~= nil then
						local var_273_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_9.prefab_name].transform, "story_v_out_325011", "325011066", "story_v_out_325011.awb")

						arg_270_1:RecordAudio("325011066", var_273_15)
						arg_270_1:RecordAudio("325011066", var_273_15)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_325011", "325011066", "story_v_out_325011.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_325011", "325011066", "story_v_out_325011.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_16 = math.max(var_273_7, arg_270_1.talkMaxDuration)

			if var_273_6 <= arg_270_1.time_ and arg_270_1.time_ < var_273_6 + var_273_16 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_6) / var_273_16

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_6 + var_273_16 and arg_270_1.time_ < var_273_6 + var_273_16 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play325011067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 325011067
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play325011068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1077ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos1077ui_story = var_277_0.localPosition

				local var_277_2 = GameObjectTools.GetOrAddComponent(var_277_0.gameObject, typeof(DynamicBoneHelper))

				if var_277_2 then
					var_277_2:EnableDynamicBone(false)
				end
			end

			local var_277_3 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_3 then
				local var_277_4 = (arg_274_1.time_ - var_277_1) / var_277_3
				local var_277_5 = Vector3.New(0, 100, 0)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1077ui_story, var_277_5, var_277_4)

				local var_277_6 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_6.x, var_277_6.y, var_277_6.z)

				local var_277_7 = var_277_0.localEulerAngles

				var_277_7.z = 0
				var_277_7.x = 0
				var_277_0.localEulerAngles = var_277_7
			end

			if arg_274_1.time_ >= var_277_1 + var_277_3 and arg_274_1.time_ < var_277_1 + var_277_3 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, 100, 0)

				local var_277_8 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_8.x, var_277_8.y, var_277_8.z)

				local var_277_9 = var_277_0.localEulerAngles

				var_277_9.z = 0
				var_277_9.x = 0
				var_277_0.localEulerAngles = var_277_9

				local var_277_10 = GameObjectTools.GetOrAddComponent(var_277_0.gameObject, typeof(DynamicBoneHelper))

				if var_277_10 then
					var_277_10:EnableDynamicBone(true)
				end
			end

			local var_277_11 = arg_274_1.actors_["1077ui_story"]
			local var_277_12 = 0

			if var_277_12 < arg_274_1.time_ and arg_274_1.time_ <= var_277_12 + arg_277_0 and not isNil(var_277_11) and arg_274_1.var_.characterEffect1077ui_story == nil then
				arg_274_1.var_.characterEffect1077ui_story = var_277_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_13 = 0.200000002980232

			if var_277_12 <= arg_274_1.time_ and arg_274_1.time_ < var_277_12 + var_277_13 and not isNil(var_277_11) then
				local var_277_14 = (arg_274_1.time_ - var_277_12) / var_277_13

				if arg_274_1.var_.characterEffect1077ui_story and not isNil(var_277_11) then
					local var_277_15 = Mathf.Lerp(0, 0.5, var_277_14)

					arg_274_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1077ui_story.fillRatio = var_277_15
				end
			end

			if arg_274_1.time_ >= var_277_12 + var_277_13 and arg_274_1.time_ < var_277_12 + var_277_13 + arg_277_0 and not isNil(var_277_11) and arg_274_1.var_.characterEffect1077ui_story then
				local var_277_16 = 0.5

				arg_274_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1077ui_story.fillRatio = var_277_16
			end

			local var_277_17 = 0
			local var_277_18 = 0.2

			if var_277_17 < arg_274_1.time_ and arg_274_1.time_ <= var_277_17 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_19 = arg_274_1:GetWordFromCfg(325011067)
				local var_277_20 = arg_274_1:FormatText(var_277_19.content)

				arg_274_1.text_.text = var_277_20

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_21 = 8
				local var_277_22 = utf8.len(var_277_20)
				local var_277_23 = var_277_21 <= 0 and var_277_18 or var_277_18 * (var_277_22 / var_277_21)

				if var_277_23 > 0 and var_277_18 < var_277_23 then
					arg_274_1.talkMaxDuration = var_277_23

					if var_277_23 + var_277_17 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_23 + var_277_17
					end
				end

				arg_274_1.text_.text = var_277_20
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_24 = math.max(var_277_18, arg_274_1.talkMaxDuration)

			if var_277_17 <= arg_274_1.time_ and arg_274_1.time_ < var_277_17 + var_277_24 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_17) / var_277_24

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_17 + var_277_24 and arg_274_1.time_ < var_277_17 + var_277_24 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325011068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 325011068
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play325011069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1077ui_story"].transform
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.var_.moveOldPos1077ui_story = var_281_0.localPosition

				local var_281_2 = GameObjectTools.GetOrAddComponent(var_281_0.gameObject, typeof(DynamicBoneHelper))

				if var_281_2 then
					var_281_2:EnableDynamicBone(false)
				end
			end

			local var_281_3 = 0.001

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_3 then
				local var_281_4 = (arg_278_1.time_ - var_281_1) / var_281_3
				local var_281_5 = Vector3.New(0, 100, 0)

				var_281_0.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1077ui_story, var_281_5, var_281_4)

				local var_281_6 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_6.x, var_281_6.y, var_281_6.z)

				local var_281_7 = var_281_0.localEulerAngles

				var_281_7.z = 0
				var_281_7.x = 0
				var_281_0.localEulerAngles = var_281_7
			end

			if arg_278_1.time_ >= var_281_1 + var_281_3 and arg_278_1.time_ < var_281_1 + var_281_3 + arg_281_0 then
				var_281_0.localPosition = Vector3.New(0, 100, 0)

				local var_281_8 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_8.x, var_281_8.y, var_281_8.z)

				local var_281_9 = var_281_0.localEulerAngles

				var_281_9.z = 0
				var_281_9.x = 0
				var_281_0.localEulerAngles = var_281_9

				local var_281_10 = GameObjectTools.GetOrAddComponent(var_281_0.gameObject, typeof(DynamicBoneHelper))

				if var_281_10 then
					var_281_10:EnableDynamicBone(true)
				end
			end

			local var_281_11 = 0
			local var_281_12 = 0.9

			if var_281_11 < arg_278_1.time_ and arg_278_1.time_ <= var_281_11 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_13 = arg_278_1:GetWordFromCfg(325011068)
				local var_281_14 = arg_278_1:FormatText(var_281_13.content)

				arg_278_1.text_.text = var_281_14

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_15 = 36
				local var_281_16 = utf8.len(var_281_14)
				local var_281_17 = var_281_15 <= 0 and var_281_12 or var_281_12 * (var_281_16 / var_281_15)

				if var_281_17 > 0 and var_281_12 < var_281_17 then
					arg_278_1.talkMaxDuration = var_281_17

					if var_281_17 + var_281_11 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_17 + var_281_11
					end
				end

				arg_278_1.text_.text = var_281_14
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_18 = math.max(var_281_12, arg_278_1.talkMaxDuration)

			if var_281_11 <= arg_278_1.time_ and arg_278_1.time_ < var_281_11 + var_281_18 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_11) / var_281_18

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_11 + var_281_18 and arg_278_1.time_ < var_281_11 + var_281_18 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play325011069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 325011069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play325011070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 0.95

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_2 = arg_282_1:GetWordFromCfg(325011069)
				local var_285_3 = arg_282_1:FormatText(var_285_2.content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_4 = 38
				local var_285_5 = utf8.len(var_285_3)
				local var_285_6 = var_285_4 <= 0 and var_285_1 or var_285_1 * (var_285_5 / var_285_4)

				if var_285_6 > 0 and var_285_1 < var_285_6 then
					arg_282_1.talkMaxDuration = var_285_6

					if var_285_6 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_6 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_7 and arg_282_1.time_ < var_285_0 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play325011070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 325011070
		arg_286_1.duration_ = 3.37

		local var_286_0 = {
			zh = 3.166,
			ja = 3.366
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play325011071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["1077ui_story"].transform
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.var_.moveOldPos1077ui_story = var_289_0.localPosition

				local var_289_2 = GameObjectTools.GetOrAddComponent(var_289_0.gameObject, typeof(DynamicBoneHelper))

				if var_289_2 then
					var_289_2:EnableDynamicBone(false)
				end
			end

			local var_289_3 = 0.001

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_3 then
				local var_289_4 = (arg_286_1.time_ - var_289_1) / var_289_3
				local var_289_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_289_0.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1077ui_story, var_289_5, var_289_4)

				local var_289_6 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_6.x, var_289_6.y, var_289_6.z)

				local var_289_7 = var_289_0.localEulerAngles

				var_289_7.z = 0
				var_289_7.x = 0
				var_289_0.localEulerAngles = var_289_7
			end

			if arg_286_1.time_ >= var_289_1 + var_289_3 and arg_286_1.time_ < var_289_1 + var_289_3 + arg_289_0 then
				var_289_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_289_8 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_8.x, var_289_8.y, var_289_8.z)

				local var_289_9 = var_289_0.localEulerAngles

				var_289_9.z = 0
				var_289_9.x = 0
				var_289_0.localEulerAngles = var_289_9

				local var_289_10 = GameObjectTools.GetOrAddComponent(var_289_0.gameObject, typeof(DynamicBoneHelper))

				if var_289_10 then
					var_289_10:EnableDynamicBone(true)
				end
			end

			local var_289_11 = arg_286_1.actors_["1077ui_story"]
			local var_289_12 = 0

			if var_289_12 < arg_286_1.time_ and arg_286_1.time_ <= var_289_12 + arg_289_0 and not isNil(var_289_11) and arg_286_1.var_.characterEffect1077ui_story == nil then
				arg_286_1.var_.characterEffect1077ui_story = var_289_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_13 = 0.200000002980232

			if var_289_12 <= arg_286_1.time_ and arg_286_1.time_ < var_289_12 + var_289_13 and not isNil(var_289_11) then
				local var_289_14 = (arg_286_1.time_ - var_289_12) / var_289_13

				if arg_286_1.var_.characterEffect1077ui_story and not isNil(var_289_11) then
					arg_286_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= var_289_12 + var_289_13 and arg_286_1.time_ < var_289_12 + var_289_13 + arg_289_0 and not isNil(var_289_11) and arg_286_1.var_.characterEffect1077ui_story then
				arg_286_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_289_15 = 0
			local var_289_16 = 0.175

			if var_289_15 < arg_286_1.time_ and arg_286_1.time_ <= var_289_15 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_17 = arg_286_1:FormatText(StoryNameCfg[1467].name)

				arg_286_1.leftNameTxt_.text = var_289_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_18 = arg_286_1:GetWordFromCfg(325011070)
				local var_289_19 = arg_286_1:FormatText(var_289_18.content)

				arg_286_1.text_.text = var_289_19

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_20 = 7
				local var_289_21 = utf8.len(var_289_19)
				local var_289_22 = var_289_20 <= 0 and var_289_16 or var_289_16 * (var_289_21 / var_289_20)

				if var_289_22 > 0 and var_289_16 < var_289_22 then
					arg_286_1.talkMaxDuration = var_289_22

					if var_289_22 + var_289_15 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_22 + var_289_15
					end
				end

				arg_286_1.text_.text = var_289_19
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011070", "story_v_out_325011.awb") ~= 0 then
					local var_289_23 = manager.audio:GetVoiceLength("story_v_out_325011", "325011070", "story_v_out_325011.awb") / 1000

					if var_289_23 + var_289_15 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_23 + var_289_15
					end

					if var_289_18.prefab_name ~= "" and arg_286_1.actors_[var_289_18.prefab_name] ~= nil then
						local var_289_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_18.prefab_name].transform, "story_v_out_325011", "325011070", "story_v_out_325011.awb")

						arg_286_1:RecordAudio("325011070", var_289_24)
						arg_286_1:RecordAudio("325011070", var_289_24)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_325011", "325011070", "story_v_out_325011.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_325011", "325011070", "story_v_out_325011.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_25 = math.max(var_289_16, arg_286_1.talkMaxDuration)

			if var_289_15 <= arg_286_1.time_ and arg_286_1.time_ < var_289_15 + var_289_25 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_15) / var_289_25

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_15 + var_289_25 and arg_286_1.time_ < var_289_15 + var_289_25 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play325011071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 325011071
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play325011072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1077ui_story"].transform
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.var_.moveOldPos1077ui_story = var_293_0.localPosition

				local var_293_2 = GameObjectTools.GetOrAddComponent(var_293_0.gameObject, typeof(DynamicBoneHelper))

				if var_293_2 then
					var_293_2:EnableDynamicBone(false)
				end
			end

			local var_293_3 = 0.001

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_3 then
				local var_293_4 = (arg_290_1.time_ - var_293_1) / var_293_3
				local var_293_5 = Vector3.New(0, 100, 0)

				var_293_0.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1077ui_story, var_293_5, var_293_4)

				local var_293_6 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_6.x, var_293_6.y, var_293_6.z)

				local var_293_7 = var_293_0.localEulerAngles

				var_293_7.z = 0
				var_293_7.x = 0
				var_293_0.localEulerAngles = var_293_7
			end

			if arg_290_1.time_ >= var_293_1 + var_293_3 and arg_290_1.time_ < var_293_1 + var_293_3 + arg_293_0 then
				var_293_0.localPosition = Vector3.New(0, 100, 0)

				local var_293_8 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_8.x, var_293_8.y, var_293_8.z)

				local var_293_9 = var_293_0.localEulerAngles

				var_293_9.z = 0
				var_293_9.x = 0
				var_293_0.localEulerAngles = var_293_9

				local var_293_10 = GameObjectTools.GetOrAddComponent(var_293_0.gameObject, typeof(DynamicBoneHelper))

				if var_293_10 then
					var_293_10:EnableDynamicBone(true)
				end
			end

			local var_293_11 = arg_290_1.actors_["1077ui_story"]
			local var_293_12 = 0

			if var_293_12 < arg_290_1.time_ and arg_290_1.time_ <= var_293_12 + arg_293_0 and not isNil(var_293_11) and arg_290_1.var_.characterEffect1077ui_story == nil then
				arg_290_1.var_.characterEffect1077ui_story = var_293_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_13 = 0.200000002980232

			if var_293_12 <= arg_290_1.time_ and arg_290_1.time_ < var_293_12 + var_293_13 and not isNil(var_293_11) then
				local var_293_14 = (arg_290_1.time_ - var_293_12) / var_293_13

				if arg_290_1.var_.characterEffect1077ui_story and not isNil(var_293_11) then
					local var_293_15 = Mathf.Lerp(0, 0.5, var_293_14)

					arg_290_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1077ui_story.fillRatio = var_293_15
				end
			end

			if arg_290_1.time_ >= var_293_12 + var_293_13 and arg_290_1.time_ < var_293_12 + var_293_13 + arg_293_0 and not isNil(var_293_11) and arg_290_1.var_.characterEffect1077ui_story then
				local var_293_16 = 0.5

				arg_290_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1077ui_story.fillRatio = var_293_16
			end

			local var_293_17 = 0.3
			local var_293_18 = 1

			if var_293_17 < arg_290_1.time_ and arg_290_1.time_ <= var_293_17 + arg_293_0 then
				local var_293_19 = "play"
				local var_293_20 = "effect"

				arg_290_1:AudioAction(var_293_19, var_293_20, "se_story_148", "se_story_148_sword11", "")
			end

			local var_293_21 = 0
			local var_293_22 = 1.075

			if var_293_21 < arg_290_1.time_ and arg_290_1.time_ <= var_293_21 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_23 = arg_290_1:GetWordFromCfg(325011071)
				local var_293_24 = arg_290_1:FormatText(var_293_23.content)

				arg_290_1.text_.text = var_293_24

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_25 = 43
				local var_293_26 = utf8.len(var_293_24)
				local var_293_27 = var_293_25 <= 0 and var_293_22 or var_293_22 * (var_293_26 / var_293_25)

				if var_293_27 > 0 and var_293_22 < var_293_27 then
					arg_290_1.talkMaxDuration = var_293_27

					if var_293_27 + var_293_21 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_27 + var_293_21
					end
				end

				arg_290_1.text_.text = var_293_24
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_28 = math.max(var_293_22, arg_290_1.talkMaxDuration)

			if var_293_21 <= arg_290_1.time_ and arg_290_1.time_ < var_293_21 + var_293_28 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_21) / var_293_28

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_21 + var_293_28 and arg_290_1.time_ < var_293_21 + var_293_28 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play325011072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 325011072
		arg_294_1.duration_ = 3.63

		local var_294_0 = {
			zh = 2,
			ja = 3.633
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play325011073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1077ui_story"].transform
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.var_.moveOldPos1077ui_story = var_297_0.localPosition

				local var_297_2 = GameObjectTools.GetOrAddComponent(var_297_0.gameObject, typeof(DynamicBoneHelper))

				if var_297_2 then
					var_297_2:EnableDynamicBone(false)
				end
			end

			local var_297_3 = 0.001

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_3 then
				local var_297_4 = (arg_294_1.time_ - var_297_1) / var_297_3
				local var_297_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_297_0.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1077ui_story, var_297_5, var_297_4)

				local var_297_6 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_6.x, var_297_6.y, var_297_6.z)

				local var_297_7 = var_297_0.localEulerAngles

				var_297_7.z = 0
				var_297_7.x = 0
				var_297_0.localEulerAngles = var_297_7
			end

			if arg_294_1.time_ >= var_297_1 + var_297_3 and arg_294_1.time_ < var_297_1 + var_297_3 + arg_297_0 then
				var_297_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_297_8 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_8.x, var_297_8.y, var_297_8.z)

				local var_297_9 = var_297_0.localEulerAngles

				var_297_9.z = 0
				var_297_9.x = 0
				var_297_0.localEulerAngles = var_297_9

				local var_297_10 = GameObjectTools.GetOrAddComponent(var_297_0.gameObject, typeof(DynamicBoneHelper))

				if var_297_10 then
					var_297_10:EnableDynamicBone(true)
				end
			end

			local var_297_11 = arg_294_1.actors_["1077ui_story"]
			local var_297_12 = 0

			if var_297_12 < arg_294_1.time_ and arg_294_1.time_ <= var_297_12 + arg_297_0 and not isNil(var_297_11) and arg_294_1.var_.characterEffect1077ui_story == nil then
				arg_294_1.var_.characterEffect1077ui_story = var_297_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_13 = 0.200000002980232

			if var_297_12 <= arg_294_1.time_ and arg_294_1.time_ < var_297_12 + var_297_13 and not isNil(var_297_11) then
				local var_297_14 = (arg_294_1.time_ - var_297_12) / var_297_13

				if arg_294_1.var_.characterEffect1077ui_story and not isNil(var_297_11) then
					arg_294_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= var_297_12 + var_297_13 and arg_294_1.time_ < var_297_12 + var_297_13 + arg_297_0 and not isNil(var_297_11) and arg_294_1.var_.characterEffect1077ui_story then
				arg_294_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_297_15 = 0

			if var_297_15 < arg_294_1.time_ and arg_294_1.time_ <= var_297_15 + arg_297_0 then
				arg_294_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_297_16 = 0

			if var_297_16 < arg_294_1.time_ and arg_294_1.time_ <= var_297_16 + arg_297_0 then
				arg_294_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_297_17 = 0
			local var_297_18 = 0.2

			if var_297_17 < arg_294_1.time_ and arg_294_1.time_ <= var_297_17 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_19 = arg_294_1:FormatText(StoryNameCfg[1467].name)

				arg_294_1.leftNameTxt_.text = var_297_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_20 = arg_294_1:GetWordFromCfg(325011072)
				local var_297_21 = arg_294_1:FormatText(var_297_20.content)

				arg_294_1.text_.text = var_297_21

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_22 = 8
				local var_297_23 = utf8.len(var_297_21)
				local var_297_24 = var_297_22 <= 0 and var_297_18 or var_297_18 * (var_297_23 / var_297_22)

				if var_297_24 > 0 and var_297_18 < var_297_24 then
					arg_294_1.talkMaxDuration = var_297_24

					if var_297_24 + var_297_17 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_24 + var_297_17
					end
				end

				arg_294_1.text_.text = var_297_21
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011072", "story_v_out_325011.awb") ~= 0 then
					local var_297_25 = manager.audio:GetVoiceLength("story_v_out_325011", "325011072", "story_v_out_325011.awb") / 1000

					if var_297_25 + var_297_17 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_25 + var_297_17
					end

					if var_297_20.prefab_name ~= "" and arg_294_1.actors_[var_297_20.prefab_name] ~= nil then
						local var_297_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_20.prefab_name].transform, "story_v_out_325011", "325011072", "story_v_out_325011.awb")

						arg_294_1:RecordAudio("325011072", var_297_26)
						arg_294_1:RecordAudio("325011072", var_297_26)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_325011", "325011072", "story_v_out_325011.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_325011", "325011072", "story_v_out_325011.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_27 = math.max(var_297_18, arg_294_1.talkMaxDuration)

			if var_297_17 <= arg_294_1.time_ and arg_294_1.time_ < var_297_17 + var_297_27 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_17) / var_297_27

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_17 + var_297_27 and arg_294_1.time_ < var_297_17 + var_297_27 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play325011073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 325011073
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play325011074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1077ui_story"].transform
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.var_.moveOldPos1077ui_story = var_301_0.localPosition

				local var_301_2 = GameObjectTools.GetOrAddComponent(var_301_0.gameObject, typeof(DynamicBoneHelper))

				if var_301_2 then
					var_301_2:EnableDynamicBone(false)
				end
			end

			local var_301_3 = 0.001

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_3 then
				local var_301_4 = (arg_298_1.time_ - var_301_1) / var_301_3
				local var_301_5 = Vector3.New(0, 100, 0)

				var_301_0.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1077ui_story, var_301_5, var_301_4)

				local var_301_6 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_6.x, var_301_6.y, var_301_6.z)

				local var_301_7 = var_301_0.localEulerAngles

				var_301_7.z = 0
				var_301_7.x = 0
				var_301_0.localEulerAngles = var_301_7
			end

			if arg_298_1.time_ >= var_301_1 + var_301_3 and arg_298_1.time_ < var_301_1 + var_301_3 + arg_301_0 then
				var_301_0.localPosition = Vector3.New(0, 100, 0)

				local var_301_8 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_8.x, var_301_8.y, var_301_8.z)

				local var_301_9 = var_301_0.localEulerAngles

				var_301_9.z = 0
				var_301_9.x = 0
				var_301_0.localEulerAngles = var_301_9

				local var_301_10 = GameObjectTools.GetOrAddComponent(var_301_0.gameObject, typeof(DynamicBoneHelper))

				if var_301_10 then
					var_301_10:EnableDynamicBone(true)
				end
			end

			local var_301_11 = arg_298_1.actors_["1077ui_story"]
			local var_301_12 = 0

			if var_301_12 < arg_298_1.time_ and arg_298_1.time_ <= var_301_12 + arg_301_0 and not isNil(var_301_11) and arg_298_1.var_.characterEffect1077ui_story == nil then
				arg_298_1.var_.characterEffect1077ui_story = var_301_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_13 = 0.200000002980232

			if var_301_12 <= arg_298_1.time_ and arg_298_1.time_ < var_301_12 + var_301_13 and not isNil(var_301_11) then
				local var_301_14 = (arg_298_1.time_ - var_301_12) / var_301_13

				if arg_298_1.var_.characterEffect1077ui_story and not isNil(var_301_11) then
					local var_301_15 = Mathf.Lerp(0, 0.5, var_301_14)

					arg_298_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_298_1.var_.characterEffect1077ui_story.fillRatio = var_301_15
				end
			end

			if arg_298_1.time_ >= var_301_12 + var_301_13 and arg_298_1.time_ < var_301_12 + var_301_13 + arg_301_0 and not isNil(var_301_11) and arg_298_1.var_.characterEffect1077ui_story then
				local var_301_16 = 0.5

				arg_298_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_298_1.var_.characterEffect1077ui_story.fillRatio = var_301_16
			end

			local var_301_17 = 0
			local var_301_18 = 0.775

			if var_301_17 < arg_298_1.time_ and arg_298_1.time_ <= var_301_17 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_19 = arg_298_1:GetWordFromCfg(325011073)
				local var_301_20 = arg_298_1:FormatText(var_301_19.content)

				arg_298_1.text_.text = var_301_20

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_21 = 31
				local var_301_22 = utf8.len(var_301_20)
				local var_301_23 = var_301_21 <= 0 and var_301_18 or var_301_18 * (var_301_22 / var_301_21)

				if var_301_23 > 0 and var_301_18 < var_301_23 then
					arg_298_1.talkMaxDuration = var_301_23

					if var_301_23 + var_301_17 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_23 + var_301_17
					end
				end

				arg_298_1.text_.text = var_301_20
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_24 = math.max(var_301_18, arg_298_1.talkMaxDuration)

			if var_301_17 <= arg_298_1.time_ and arg_298_1.time_ < var_301_17 + var_301_24 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_17) / var_301_24

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_17 + var_301_24 and arg_298_1.time_ < var_301_17 + var_301_24 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play325011074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 325011074
		arg_302_1.duration_ = 6

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play325011075(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.bgs_.ST13.transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPosST13 = var_305_0.localPosition
			end

			local var_305_2 = 1.53333333333333

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2
				local var_305_4 = Vector3.New(0, 1, 8)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPosST13, var_305_4, var_305_3)
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0, 1, 8)
			end

			local var_305_5 = 0

			if var_305_5 < arg_302_1.time_ and arg_302_1.time_ <= var_305_5 + arg_305_0 then
				arg_302_1.allBtn_.enabled = false
			end

			local var_305_6 = 1.93333333333333

			if arg_302_1.time_ >= var_305_5 + var_305_6 and arg_302_1.time_ < var_305_5 + var_305_6 + arg_305_0 then
				arg_302_1.allBtn_.enabled = true
			end

			local var_305_7 = 0.3
			local var_305_8 = 1

			if var_305_7 < arg_302_1.time_ and arg_302_1.time_ <= var_305_7 + arg_305_0 then
				local var_305_9 = "play"
				local var_305_10 = "effect"

				arg_302_1:AudioAction(var_305_9, var_305_10, "se_story_16", "se_story_16_door03", "")
			end

			if arg_302_1.frameCnt_ <= 1 then
				arg_302_1.dialog_:SetActive(false)
			end

			local var_305_11 = 1
			local var_305_12 = 1.225

			if var_305_11 < arg_302_1.time_ and arg_302_1.time_ <= var_305_11 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0

				arg_302_1.dialog_:SetActive(true)

				arg_302_1.dialogCg_.alpha = 0

				local var_305_13 = LeanTween.value(arg_302_1.dialog_, 0, 1, 0.3)

				var_305_13:setOnUpdate(LuaHelper.FloatAction(function(arg_306_0)
					arg_302_1.dialogCg_.alpha = arg_306_0
				end))
				var_305_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_302_1.dialog_)
					var_305_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_302_1.duration_ = arg_302_1.duration_ + 0.3

				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_14 = arg_302_1:GetWordFromCfg(325011074)
				local var_305_15 = arg_302_1:FormatText(var_305_14.content)

				arg_302_1.text_.text = var_305_15

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_16 = 49
				local var_305_17 = utf8.len(var_305_15)
				local var_305_18 = var_305_16 <= 0 and var_305_12 or var_305_12 * (var_305_17 / var_305_16)

				if var_305_18 > 0 and var_305_12 < var_305_18 then
					arg_302_1.talkMaxDuration = var_305_18
					var_305_11 = var_305_11 + 0.3

					if var_305_18 + var_305_11 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_18 + var_305_11
					end
				end

				arg_302_1.text_.text = var_305_15
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_19 = var_305_11 + 0.3
			local var_305_20 = math.max(var_305_12, arg_302_1.talkMaxDuration)

			if var_305_19 <= arg_302_1.time_ and arg_302_1.time_ < var_305_19 + var_305_20 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_19) / var_305_20

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_19 + var_305_20 and arg_302_1.time_ < var_305_19 + var_305_20 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST13",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.53333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 8),
					easeType = LeanTweenType.easeInOutSine
				}
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play325011075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 325011075
		arg_308_1.duration_ = 3.1

		local var_308_0 = {
			zh = 2.1,
			ja = 3.1
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play325011076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1077ui_story"].transform
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.var_.moveOldPos1077ui_story = var_311_0.localPosition

				local var_311_2 = GameObjectTools.GetOrAddComponent(var_311_0.gameObject, typeof(DynamicBoneHelper))

				if var_311_2 then
					var_311_2:EnableDynamicBone(false)
				end
			end

			local var_311_3 = 0.001

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_3 then
				local var_311_4 = (arg_308_1.time_ - var_311_1) / var_311_3
				local var_311_5 = Vector3.New(0, 100, 0)

				var_311_0.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1077ui_story, var_311_5, var_311_4)

				local var_311_6 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_6.x, var_311_6.y, var_311_6.z)

				local var_311_7 = var_311_0.localEulerAngles

				var_311_7.z = 0
				var_311_7.x = 0
				var_311_0.localEulerAngles = var_311_7
			end

			if arg_308_1.time_ >= var_311_1 + var_311_3 and arg_308_1.time_ < var_311_1 + var_311_3 + arg_311_0 then
				var_311_0.localPosition = Vector3.New(0, 100, 0)

				local var_311_8 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_8.x, var_311_8.y, var_311_8.z)

				local var_311_9 = var_311_0.localEulerAngles

				var_311_9.z = 0
				var_311_9.x = 0
				var_311_0.localEulerAngles = var_311_9

				local var_311_10 = GameObjectTools.GetOrAddComponent(var_311_0.gameObject, typeof(DynamicBoneHelper))

				if var_311_10 then
					var_311_10:EnableDynamicBone(true)
				end
			end

			local var_311_11 = arg_308_1.actors_["1077ui_story"]
			local var_311_12 = 0

			if var_311_12 < arg_308_1.time_ and arg_308_1.time_ <= var_311_12 + arg_311_0 and not isNil(var_311_11) and arg_308_1.var_.characterEffect1077ui_story == nil then
				arg_308_1.var_.characterEffect1077ui_story = var_311_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_13 = 0.200000002980232

			if var_311_12 <= arg_308_1.time_ and arg_308_1.time_ < var_311_12 + var_311_13 and not isNil(var_311_11) then
				local var_311_14 = (arg_308_1.time_ - var_311_12) / var_311_13

				if arg_308_1.var_.characterEffect1077ui_story and not isNil(var_311_11) then
					arg_308_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= var_311_12 + var_311_13 and arg_308_1.time_ < var_311_12 + var_311_13 + arg_311_0 and not isNil(var_311_11) and arg_308_1.var_.characterEffect1077ui_story then
				arg_308_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_311_15 = 0
			local var_311_16 = 0.125

			if var_311_15 < arg_308_1.time_ and arg_308_1.time_ <= var_311_15 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_17 = arg_308_1:FormatText(StoryNameCfg[1467].name)

				arg_308_1.leftNameTxt_.text = var_311_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_18 = arg_308_1:GetWordFromCfg(325011075)
				local var_311_19 = arg_308_1:FormatText(var_311_18.content)

				arg_308_1.text_.text = var_311_19

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_20 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011075", "story_v_out_325011.awb") ~= 0 then
					local var_311_23 = manager.audio:GetVoiceLength("story_v_out_325011", "325011075", "story_v_out_325011.awb") / 1000

					if var_311_23 + var_311_15 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_23 + var_311_15
					end

					if var_311_18.prefab_name ~= "" and arg_308_1.actors_[var_311_18.prefab_name] ~= nil then
						local var_311_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_18.prefab_name].transform, "story_v_out_325011", "325011075", "story_v_out_325011.awb")

						arg_308_1:RecordAudio("325011075", var_311_24)
						arg_308_1:RecordAudio("325011075", var_311_24)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_325011", "325011075", "story_v_out_325011.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_325011", "325011075", "story_v_out_325011.awb")
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
				actorName = "1077ui_story",
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
	Play325011076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 325011076
		arg_312_1.duration_ = 8.03

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play325011077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 1.66666666666667

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				local var_315_1 = manager.ui.mainCamera.transform.localPosition
				local var_315_2 = Vector3.New(0, 0, 10) + Vector3.New(var_315_1.x, var_315_1.y, 0)
				local var_315_3 = arg_312_1.bgs_.ST2015

				var_315_3.transform.localPosition = var_315_2
				var_315_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_315_4 = var_315_3:GetComponent("SpriteRenderer")

				if var_315_4 and var_315_4.sprite then
					local var_315_5 = (var_315_3.transform.localPosition - var_315_1).z
					local var_315_6 = manager.ui.mainCameraCom_
					local var_315_7 = 2 * var_315_5 * Mathf.Tan(var_315_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_315_8 = var_315_7 * var_315_6.aspect
					local var_315_9 = var_315_4.sprite.bounds.size.x
					local var_315_10 = var_315_4.sprite.bounds.size.y
					local var_315_11 = var_315_8 / var_315_9
					local var_315_12 = var_315_7 / var_315_10
					local var_315_13 = var_315_12 < var_315_11 and var_315_11 or var_315_12

					var_315_3.transform.localScale = Vector3.New(var_315_13, var_315_13, 0)
				end

				for iter_315_0, iter_315_1 in pairs(arg_312_1.bgs_) do
					if iter_315_0 ~= "ST2015" then
						iter_315_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_315_14 = 1.66666666666667

			if var_315_14 < arg_312_1.time_ and arg_312_1.time_ <= var_315_14 + arg_315_0 then
				arg_312_1.allBtn_.enabled = false
			end

			local var_315_15 = 0.3

			if arg_312_1.time_ >= var_315_14 + var_315_15 and arg_312_1.time_ < var_315_14 + var_315_15 + arg_315_0 then
				arg_312_1.allBtn_.enabled = true
			end

			local var_315_16 = 0

			if var_315_16 < arg_312_1.time_ and arg_312_1.time_ <= var_315_16 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_17 = 1.66666666666667

			if var_315_16 <= arg_312_1.time_ and arg_312_1.time_ < var_315_16 + var_315_17 then
				local var_315_18 = (arg_312_1.time_ - var_315_16) / var_315_17
				local var_315_19 = Color.New(0, 0, 0)

				var_315_19.a = Mathf.Lerp(0, 1, var_315_18)
				arg_312_1.mask_.color = var_315_19
			end

			if arg_312_1.time_ >= var_315_16 + var_315_17 and arg_312_1.time_ < var_315_16 + var_315_17 + arg_315_0 then
				local var_315_20 = Color.New(0, 0, 0)

				var_315_20.a = 1
				arg_312_1.mask_.color = var_315_20
			end

			local var_315_21 = 1.66666666666667

			if var_315_21 < arg_312_1.time_ and arg_312_1.time_ <= var_315_21 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_22 = 2

			if var_315_21 <= arg_312_1.time_ and arg_312_1.time_ < var_315_21 + var_315_22 then
				local var_315_23 = (arg_312_1.time_ - var_315_21) / var_315_22
				local var_315_24 = Color.New(0, 0, 0)

				var_315_24.a = Mathf.Lerp(1, 0, var_315_23)
				arg_312_1.mask_.color = var_315_24
			end

			if arg_312_1.time_ >= var_315_21 + var_315_22 and arg_312_1.time_ < var_315_21 + var_315_22 + arg_315_0 then
				local var_315_25 = Color.New(0, 0, 0)
				local var_315_26 = 0

				arg_312_1.mask_.enabled = false
				var_315_25.a = var_315_26
				arg_312_1.mask_.color = var_315_25
			end

			local var_315_27 = arg_312_1.actors_["1077ui_story"].transform
			local var_315_28 = 1.66666666666667

			if var_315_28 < arg_312_1.time_ and arg_312_1.time_ <= var_315_28 + arg_315_0 then
				arg_312_1.var_.moveOldPos1077ui_story = var_315_27.localPosition

				local var_315_29 = GameObjectTools.GetOrAddComponent(var_315_27.gameObject, typeof(DynamicBoneHelper))

				if var_315_29 then
					var_315_29:EnableDynamicBone(false)
				end
			end

			local var_315_30 = 0.001

			if var_315_28 <= arg_312_1.time_ and arg_312_1.time_ < var_315_28 + var_315_30 then
				local var_315_31 = (arg_312_1.time_ - var_315_28) / var_315_30
				local var_315_32 = Vector3.New(0, 100, 0)

				var_315_27.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1077ui_story, var_315_32, var_315_31)

				local var_315_33 = manager.ui.mainCamera.transform.position - var_315_27.position

				var_315_27.forward = Vector3.New(var_315_33.x, var_315_33.y, var_315_33.z)

				local var_315_34 = var_315_27.localEulerAngles

				var_315_34.z = 0
				var_315_34.x = 0
				var_315_27.localEulerAngles = var_315_34
			end

			if arg_312_1.time_ >= var_315_28 + var_315_30 and arg_312_1.time_ < var_315_28 + var_315_30 + arg_315_0 then
				var_315_27.localPosition = Vector3.New(0, 100, 0)

				local var_315_35 = manager.ui.mainCamera.transform.position - var_315_27.position

				var_315_27.forward = Vector3.New(var_315_35.x, var_315_35.y, var_315_35.z)

				local var_315_36 = var_315_27.localEulerAngles

				var_315_36.z = 0
				var_315_36.x = 0
				var_315_27.localEulerAngles = var_315_36

				local var_315_37 = GameObjectTools.GetOrAddComponent(var_315_27.gameObject, typeof(DynamicBoneHelper))

				if var_315_37 then
					var_315_37:EnableDynamicBone(true)
				end
			end

			local var_315_38 = arg_312_1.actors_["1077ui_story"]
			local var_315_39 = 1.66666666666667

			if var_315_39 < arg_312_1.time_ and arg_312_1.time_ <= var_315_39 + arg_315_0 and not isNil(var_315_38) and arg_312_1.var_.characterEffect1077ui_story == nil then
				arg_312_1.var_.characterEffect1077ui_story = var_315_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_40 = 0.200000002980232

			if var_315_39 <= arg_312_1.time_ and arg_312_1.time_ < var_315_39 + var_315_40 and not isNil(var_315_38) then
				local var_315_41 = (arg_312_1.time_ - var_315_39) / var_315_40

				if arg_312_1.var_.characterEffect1077ui_story and not isNil(var_315_38) then
					local var_315_42 = Mathf.Lerp(0, 0.5, var_315_41)

					arg_312_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1077ui_story.fillRatio = var_315_42
				end
			end

			if arg_312_1.time_ >= var_315_39 + var_315_40 and arg_312_1.time_ < var_315_39 + var_315_40 + arg_315_0 and not isNil(var_315_38) and arg_312_1.var_.characterEffect1077ui_story then
				local var_315_43 = 0.5

				arg_312_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1077ui_story.fillRatio = var_315_43
			end

			local var_315_44 = 1.2
			local var_315_45 = 1

			if var_315_44 < arg_312_1.time_ and arg_312_1.time_ <= var_315_44 + arg_315_0 then
				local var_315_46 = "play"
				local var_315_47 = "effect"

				arg_312_1:AudioAction(var_315_46, var_315_47, "se_story_143", "se_story_143_amb_town", "")
			end

			if arg_312_1.frameCnt_ <= 1 then
				arg_312_1.dialog_:SetActive(false)
			end

			local var_315_48 = 3.03333333333333
			local var_315_49 = 1.275

			if var_315_48 < arg_312_1.time_ and arg_312_1.time_ <= var_315_48 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				arg_312_1.dialog_:SetActive(true)

				arg_312_1.dialogCg_.alpha = 0

				local var_315_50 = LeanTween.value(arg_312_1.dialog_, 0, 1, 0.3)

				var_315_50:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_312_1.dialogCg_.alpha = arg_316_0
				end))
				var_315_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_312_1.dialog_)
					var_315_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_312_1.duration_ = arg_312_1.duration_ + 0.3

				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_51 = arg_312_1:GetWordFromCfg(325011076)
				local var_315_52 = arg_312_1:FormatText(var_315_51.content)

				arg_312_1.text_.text = var_315_52

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_53 = 51
				local var_315_54 = utf8.len(var_315_52)
				local var_315_55 = var_315_53 <= 0 and var_315_49 or var_315_49 * (var_315_54 / var_315_53)

				if var_315_55 > 0 and var_315_49 < var_315_55 then
					arg_312_1.talkMaxDuration = var_315_55
					var_315_48 = var_315_48 + 0.3

					if var_315_55 + var_315_48 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_55 + var_315_48
					end
				end

				arg_312_1.text_.text = var_315_52
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_56 = var_315_48 + 0.3
			local var_315_57 = math.max(var_315_49, arg_312_1.talkMaxDuration)

			if var_315_56 <= arg_312_1.time_ and arg_312_1.time_ < var_315_56 + var_315_57 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_56) / var_315_57

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_56 + var_315_57 and arg_312_1.time_ < var_315_56 + var_315_57 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play325011077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 325011077
		arg_318_1.duration_ = 3.47

		local var_318_0 = {
			zh = 2.8,
			ja = 3.466
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
				arg_318_0:Play325011078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1077ui_story"].transform
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.var_.moveOldPos1077ui_story = var_321_0.localPosition

				local var_321_2 = GameObjectTools.GetOrAddComponent(var_321_0.gameObject, typeof(DynamicBoneHelper))

				if var_321_2 then
					var_321_2:EnableDynamicBone(false)
				end
			end

			local var_321_3 = 0.001

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_3 then
				local var_321_4 = (arg_318_1.time_ - var_321_1) / var_321_3
				local var_321_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_321_0.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1077ui_story, var_321_5, var_321_4)

				local var_321_6 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_6.x, var_321_6.y, var_321_6.z)

				local var_321_7 = var_321_0.localEulerAngles

				var_321_7.z = 0
				var_321_7.x = 0
				var_321_0.localEulerAngles = var_321_7
			end

			if arg_318_1.time_ >= var_321_1 + var_321_3 and arg_318_1.time_ < var_321_1 + var_321_3 + arg_321_0 then
				var_321_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_321_8 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_8.x, var_321_8.y, var_321_8.z)

				local var_321_9 = var_321_0.localEulerAngles

				var_321_9.z = 0
				var_321_9.x = 0
				var_321_0.localEulerAngles = var_321_9

				local var_321_10 = GameObjectTools.GetOrAddComponent(var_321_0.gameObject, typeof(DynamicBoneHelper))

				if var_321_10 then
					var_321_10:EnableDynamicBone(true)
				end
			end

			local var_321_11 = arg_318_1.actors_["1077ui_story"]
			local var_321_12 = 0

			if var_321_12 < arg_318_1.time_ and arg_318_1.time_ <= var_321_12 + arg_321_0 and not isNil(var_321_11) and arg_318_1.var_.characterEffect1077ui_story == nil then
				arg_318_1.var_.characterEffect1077ui_story = var_321_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_13 = 0.200000002980232

			if var_321_12 <= arg_318_1.time_ and arg_318_1.time_ < var_321_12 + var_321_13 and not isNil(var_321_11) then
				local var_321_14 = (arg_318_1.time_ - var_321_12) / var_321_13

				if arg_318_1.var_.characterEffect1077ui_story and not isNil(var_321_11) then
					arg_318_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_12 + var_321_13 and arg_318_1.time_ < var_321_12 + var_321_13 + arg_321_0 and not isNil(var_321_11) and arg_318_1.var_.characterEffect1077ui_story then
				arg_318_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_321_15 = 0

			if var_321_15 < arg_318_1.time_ and arg_318_1.time_ <= var_321_15 + arg_321_0 then
				arg_318_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_1")
			end

			local var_321_16 = 0

			if var_321_16 < arg_318_1.time_ and arg_318_1.time_ <= var_321_16 + arg_321_0 then
				arg_318_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_321_17 = 0
			local var_321_18 = 0.25

			if var_321_17 < arg_318_1.time_ and arg_318_1.time_ <= var_321_17 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_19 = arg_318_1:FormatText(StoryNameCfg[1467].name)

				arg_318_1.leftNameTxt_.text = var_321_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_20 = arg_318_1:GetWordFromCfg(325011077)
				local var_321_21 = arg_318_1:FormatText(var_321_20.content)

				arg_318_1.text_.text = var_321_21

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_22 = 10
				local var_321_23 = utf8.len(var_321_21)
				local var_321_24 = var_321_22 <= 0 and var_321_18 or var_321_18 * (var_321_23 / var_321_22)

				if var_321_24 > 0 and var_321_18 < var_321_24 then
					arg_318_1.talkMaxDuration = var_321_24

					if var_321_24 + var_321_17 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_24 + var_321_17
					end
				end

				arg_318_1.text_.text = var_321_21
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011077", "story_v_out_325011.awb") ~= 0 then
					local var_321_25 = manager.audio:GetVoiceLength("story_v_out_325011", "325011077", "story_v_out_325011.awb") / 1000

					if var_321_25 + var_321_17 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_25 + var_321_17
					end

					if var_321_20.prefab_name ~= "" and arg_318_1.actors_[var_321_20.prefab_name] ~= nil then
						local var_321_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_20.prefab_name].transform, "story_v_out_325011", "325011077", "story_v_out_325011.awb")

						arg_318_1:RecordAudio("325011077", var_321_26)
						arg_318_1:RecordAudio("325011077", var_321_26)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_325011", "325011077", "story_v_out_325011.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_325011", "325011077", "story_v_out_325011.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_27 = math.max(var_321_18, arg_318_1.talkMaxDuration)

			if var_321_17 <= arg_318_1.time_ and arg_318_1.time_ < var_321_17 + var_321_27 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_17) / var_321_27

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_17 + var_321_27 and arg_318_1.time_ < var_321_17 + var_321_27 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play325011078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 325011078
		arg_322_1.duration_ = 13.33

		local var_322_0 = {
			zh = 9.033,
			ja = 13.333
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
				arg_322_0:Play325011079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["1077ui_story"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1077ui_story == nil then
				arg_322_1.var_.characterEffect1077ui_story = var_325_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.200000002980232

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.characterEffect1077ui_story and not isNil(var_325_0) then
					local var_325_4 = Mathf.Lerp(0, 0.5, var_325_3)

					arg_322_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1077ui_story.fillRatio = var_325_4
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1077ui_story then
				local var_325_5 = 0.5

				arg_322_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1077ui_story.fillRatio = var_325_5
			end

			local var_325_6 = 0
			local var_325_7 = 0.775

			if var_325_6 < arg_322_1.time_ and arg_322_1.time_ <= var_325_6 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_8 = arg_322_1:FormatText(StoryNameCfg[1522].name)

				arg_322_1.leftNameTxt_.text = var_325_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_9 = arg_322_1:GetWordFromCfg(325011078)
				local var_325_10 = arg_322_1:FormatText(var_325_9.content)

				arg_322_1.text_.text = var_325_10

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_11 = 31
				local var_325_12 = utf8.len(var_325_10)
				local var_325_13 = var_325_11 <= 0 and var_325_7 or var_325_7 * (var_325_12 / var_325_11)

				if var_325_13 > 0 and var_325_7 < var_325_13 then
					arg_322_1.talkMaxDuration = var_325_13

					if var_325_13 + var_325_6 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_13 + var_325_6
					end
				end

				arg_322_1.text_.text = var_325_10
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011078", "story_v_out_325011.awb") ~= 0 then
					local var_325_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011078", "story_v_out_325011.awb") / 1000

					if var_325_14 + var_325_6 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_14 + var_325_6
					end

					if var_325_9.prefab_name ~= "" and arg_322_1.actors_[var_325_9.prefab_name] ~= nil then
						local var_325_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_9.prefab_name].transform, "story_v_out_325011", "325011078", "story_v_out_325011.awb")

						arg_322_1:RecordAudio("325011078", var_325_15)
						arg_322_1:RecordAudio("325011078", var_325_15)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_325011", "325011078", "story_v_out_325011.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_325011", "325011078", "story_v_out_325011.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_16 = math.max(var_325_7, arg_322_1.talkMaxDuration)

			if var_325_6 <= arg_322_1.time_ and arg_322_1.time_ < var_325_6 + var_325_16 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_6) / var_325_16

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_6 + var_325_16 and arg_322_1.time_ < var_325_6 + var_325_16 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play325011079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 325011079
		arg_326_1.duration_ = 16.07

		local var_326_0 = {
			zh = 13.6,
			ja = 16.066
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play325011080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 1.175

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[1522].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:GetWordFromCfg(325011079)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 47
				local var_329_6 = utf8.len(var_329_4)
				local var_329_7 = var_329_5 <= 0 and var_329_1 or var_329_1 * (var_329_6 / var_329_5)

				if var_329_7 > 0 and var_329_1 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011079", "story_v_out_325011.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011079", "story_v_out_325011.awb") / 1000

					if var_329_8 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_0
					end

					if var_329_3.prefab_name ~= "" and arg_326_1.actors_[var_329_3.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_3.prefab_name].transform, "story_v_out_325011", "325011079", "story_v_out_325011.awb")

						arg_326_1:RecordAudio("325011079", var_329_9)
						arg_326_1:RecordAudio("325011079", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_325011", "325011079", "story_v_out_325011.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_325011", "325011079", "story_v_out_325011.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_10 and arg_326_1.time_ < var_329_0 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play325011080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 325011080
		arg_330_1.duration_ = 7.6

		local var_330_0 = {
			zh = 6.8,
			ja = 7.6
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
				arg_330_0:Play325011081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["1077ui_story"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1077ui_story == nil then
				arg_330_1.var_.characterEffect1077ui_story = var_333_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.characterEffect1077ui_story and not isNil(var_333_0) then
					arg_330_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1077ui_story then
				arg_330_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_333_4 = 0

			if var_333_4 < arg_330_1.time_ and arg_330_1.time_ <= var_333_4 + arg_333_0 then
				arg_330_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_333_5 = 0
			local var_333_6 = 0.575

			if var_333_5 < arg_330_1.time_ and arg_330_1.time_ <= var_333_5 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_7 = arg_330_1:FormatText(StoryNameCfg[1467].name)

				arg_330_1.leftNameTxt_.text = var_333_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_8 = arg_330_1:GetWordFromCfg(325011080)
				local var_333_9 = arg_330_1:FormatText(var_333_8.content)

				arg_330_1.text_.text = var_333_9

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_10 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011080", "story_v_out_325011.awb") ~= 0 then
					local var_333_13 = manager.audio:GetVoiceLength("story_v_out_325011", "325011080", "story_v_out_325011.awb") / 1000

					if var_333_13 + var_333_5 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_13 + var_333_5
					end

					if var_333_8.prefab_name ~= "" and arg_330_1.actors_[var_333_8.prefab_name] ~= nil then
						local var_333_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_8.prefab_name].transform, "story_v_out_325011", "325011080", "story_v_out_325011.awb")

						arg_330_1:RecordAudio("325011080", var_333_14)
						arg_330_1:RecordAudio("325011080", var_333_14)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_325011", "325011080", "story_v_out_325011.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_325011", "325011080", "story_v_out_325011.awb")
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
	Play325011081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 325011081
		arg_334_1.duration_ = 13.2

		local var_334_0 = {
			zh = 11.466,
			ja = 13.2
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
				arg_334_0:Play325011082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1077ui_story"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1077ui_story == nil then
				arg_334_1.var_.characterEffect1077ui_story = var_337_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.characterEffect1077ui_story and not isNil(var_337_0) then
					local var_337_4 = Mathf.Lerp(0, 0.5, var_337_3)

					arg_334_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_334_1.var_.characterEffect1077ui_story.fillRatio = var_337_4
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1077ui_story then
				local var_337_5 = 0.5

				arg_334_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_334_1.var_.characterEffect1077ui_story.fillRatio = var_337_5
			end

			local var_337_6 = 0
			local var_337_7 = 1.075

			if var_337_6 < arg_334_1.time_ and arg_334_1.time_ <= var_337_6 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_8 = arg_334_1:FormatText(StoryNameCfg[1522].name)

				arg_334_1.leftNameTxt_.text = var_337_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_9 = arg_334_1:GetWordFromCfg(325011081)
				local var_337_10 = arg_334_1:FormatText(var_337_9.content)

				arg_334_1.text_.text = var_337_10

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_11 = 43
				local var_337_12 = utf8.len(var_337_10)
				local var_337_13 = var_337_11 <= 0 and var_337_7 or var_337_7 * (var_337_12 / var_337_11)

				if var_337_13 > 0 and var_337_7 < var_337_13 then
					arg_334_1.talkMaxDuration = var_337_13

					if var_337_13 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_13 + var_337_6
					end
				end

				arg_334_1.text_.text = var_337_10
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011081", "story_v_out_325011.awb") ~= 0 then
					local var_337_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011081", "story_v_out_325011.awb") / 1000

					if var_337_14 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_14 + var_337_6
					end

					if var_337_9.prefab_name ~= "" and arg_334_1.actors_[var_337_9.prefab_name] ~= nil then
						local var_337_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_9.prefab_name].transform, "story_v_out_325011", "325011081", "story_v_out_325011.awb")

						arg_334_1:RecordAudio("325011081", var_337_15)
						arg_334_1:RecordAudio("325011081", var_337_15)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_325011", "325011081", "story_v_out_325011.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_325011", "325011081", "story_v_out_325011.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_16 = math.max(var_337_7, arg_334_1.talkMaxDuration)

			if var_337_6 <= arg_334_1.time_ and arg_334_1.time_ < var_337_6 + var_337_16 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_6) / var_337_16

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_6 + var_337_16 and arg_334_1.time_ < var_337_6 + var_337_16 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play325011082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 325011082
		arg_338_1.duration_ = 5.73

		local var_338_0 = {
			zh = 5.733,
			ja = 4.266
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play325011083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1077ui_story"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1077ui_story == nil then
				arg_338_1.var_.characterEffect1077ui_story = var_341_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.characterEffect1077ui_story and not isNil(var_341_0) then
					arg_338_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1077ui_story then
				arg_338_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_341_4 = 0

			if var_341_4 < arg_338_1.time_ and arg_338_1.time_ <= var_341_4 + arg_341_0 then
				arg_338_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			local var_341_5 = 0

			if var_341_5 < arg_338_1.time_ and arg_338_1.time_ <= var_341_5 + arg_341_0 then
				arg_338_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_341_6 = 0
			local var_341_7 = 0.6

			if var_341_6 < arg_338_1.time_ and arg_338_1.time_ <= var_341_6 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_8 = arg_338_1:FormatText(StoryNameCfg[1467].name)

				arg_338_1.leftNameTxt_.text = var_341_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_9 = arg_338_1:GetWordFromCfg(325011082)
				local var_341_10 = arg_338_1:FormatText(var_341_9.content)

				arg_338_1.text_.text = var_341_10

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_11 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011082", "story_v_out_325011.awb") ~= 0 then
					local var_341_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011082", "story_v_out_325011.awb") / 1000

					if var_341_14 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_14 + var_341_6
					end

					if var_341_9.prefab_name ~= "" and arg_338_1.actors_[var_341_9.prefab_name] ~= nil then
						local var_341_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_9.prefab_name].transform, "story_v_out_325011", "325011082", "story_v_out_325011.awb")

						arg_338_1:RecordAudio("325011082", var_341_15)
						arg_338_1:RecordAudio("325011082", var_341_15)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_325011", "325011082", "story_v_out_325011.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_325011", "325011082", "story_v_out_325011.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_16 = math.max(var_341_7, arg_338_1.talkMaxDuration)

			if var_341_6 <= arg_338_1.time_ and arg_338_1.time_ < var_341_6 + var_341_16 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_6) / var_341_16

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_6 + var_341_16 and arg_338_1.time_ < var_341_6 + var_341_16 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play325011083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 325011083
		arg_342_1.duration_ = 8.33

		local var_342_0 = {
			zh = 6.366,
			ja = 8.333
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play325011084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 0.6

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_2 = arg_342_1:FormatText(StoryNameCfg[1467].name)

				arg_342_1.leftNameTxt_.text = var_345_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_3 = arg_342_1:GetWordFromCfg(325011083)
				local var_345_4 = arg_342_1:FormatText(var_345_3.content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 24
				local var_345_6 = utf8.len(var_345_4)
				local var_345_7 = var_345_5 <= 0 and var_345_1 or var_345_1 * (var_345_6 / var_345_5)

				if var_345_7 > 0 and var_345_1 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_4
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011083", "story_v_out_325011.awb") ~= 0 then
					local var_345_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011083", "story_v_out_325011.awb") / 1000

					if var_345_8 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_8 + var_345_0
					end

					if var_345_3.prefab_name ~= "" and arg_342_1.actors_[var_345_3.prefab_name] ~= nil then
						local var_345_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_3.prefab_name].transform, "story_v_out_325011", "325011083", "story_v_out_325011.awb")

						arg_342_1:RecordAudio("325011083", var_345_9)
						arg_342_1:RecordAudio("325011083", var_345_9)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_325011", "325011083", "story_v_out_325011.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_325011", "325011083", "story_v_out_325011.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_10 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_10 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_10

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_10 and arg_342_1.time_ < var_345_0 + var_345_10 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play325011084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 325011084
		arg_346_1.duration_ = 14.8

		local var_346_0 = {
			zh = 13.3,
			ja = 14.8
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play325011085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1077ui_story"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1077ui_story == nil then
				arg_346_1.var_.characterEffect1077ui_story = var_349_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.characterEffect1077ui_story and not isNil(var_349_0) then
					local var_349_4 = Mathf.Lerp(0, 0.5, var_349_3)

					arg_346_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1077ui_story.fillRatio = var_349_4
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1077ui_story then
				local var_349_5 = 0.5

				arg_346_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1077ui_story.fillRatio = var_349_5
			end

			local var_349_6 = 0
			local var_349_7 = 1.275

			if var_349_6 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_8 = arg_346_1:FormatText(StoryNameCfg[1522].name)

				arg_346_1.leftNameTxt_.text = var_349_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_9 = arg_346_1:GetWordFromCfg(325011084)
				local var_349_10 = arg_346_1:FormatText(var_349_9.content)

				arg_346_1.text_.text = var_349_10

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_11 = 51
				local var_349_12 = utf8.len(var_349_10)
				local var_349_13 = var_349_11 <= 0 and var_349_7 or var_349_7 * (var_349_12 / var_349_11)

				if var_349_13 > 0 and var_349_7 < var_349_13 then
					arg_346_1.talkMaxDuration = var_349_13

					if var_349_13 + var_349_6 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_13 + var_349_6
					end
				end

				arg_346_1.text_.text = var_349_10
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011084", "story_v_out_325011.awb") ~= 0 then
					local var_349_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011084", "story_v_out_325011.awb") / 1000

					if var_349_14 + var_349_6 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_14 + var_349_6
					end

					if var_349_9.prefab_name ~= "" and arg_346_1.actors_[var_349_9.prefab_name] ~= nil then
						local var_349_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_9.prefab_name].transform, "story_v_out_325011", "325011084", "story_v_out_325011.awb")

						arg_346_1:RecordAudio("325011084", var_349_15)
						arg_346_1:RecordAudio("325011084", var_349_15)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_325011", "325011084", "story_v_out_325011.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_325011", "325011084", "story_v_out_325011.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_16 = math.max(var_349_7, arg_346_1.talkMaxDuration)

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_16 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_6) / var_349_16

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_6 + var_349_16 and arg_346_1.time_ < var_349_6 + var_349_16 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play325011085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 325011085
		arg_350_1.duration_ = 2.17

		local var_350_0 = {
			zh = 2.166,
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
				arg_350_0:Play325011086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1077ui_story"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1077ui_story == nil then
				arg_350_1.var_.characterEffect1077ui_story = var_353_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.characterEffect1077ui_story and not isNil(var_353_0) then
					arg_350_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1077ui_story then
				arg_350_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_353_4 = 0

			if var_353_4 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			local var_353_5 = 0

			if var_353_5 < arg_350_1.time_ and arg_350_1.time_ <= var_353_5 + arg_353_0 then
				arg_350_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_353_6 = 0
			local var_353_7 = 0.175

			if var_353_6 < arg_350_1.time_ and arg_350_1.time_ <= var_353_6 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_8 = arg_350_1:FormatText(StoryNameCfg[1467].name)

				arg_350_1.leftNameTxt_.text = var_353_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_9 = arg_350_1:GetWordFromCfg(325011085)
				local var_353_10 = arg_350_1:FormatText(var_353_9.content)

				arg_350_1.text_.text = var_353_10

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_11 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011085", "story_v_out_325011.awb") ~= 0 then
					local var_353_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011085", "story_v_out_325011.awb") / 1000

					if var_353_14 + var_353_6 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_14 + var_353_6
					end

					if var_353_9.prefab_name ~= "" and arg_350_1.actors_[var_353_9.prefab_name] ~= nil then
						local var_353_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_9.prefab_name].transform, "story_v_out_325011", "325011085", "story_v_out_325011.awb")

						arg_350_1:RecordAudio("325011085", var_353_15)
						arg_350_1:RecordAudio("325011085", var_353_15)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_325011", "325011085", "story_v_out_325011.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_325011", "325011085", "story_v_out_325011.awb")
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
	Play325011086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 325011086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play325011087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1077ui_story"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1077ui_story == nil then
				arg_354_1.var_.characterEffect1077ui_story = var_357_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.characterEffect1077ui_story and not isNil(var_357_0) then
					local var_357_4 = Mathf.Lerp(0, 0.5, var_357_3)

					arg_354_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_354_1.var_.characterEffect1077ui_story.fillRatio = var_357_4
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1077ui_story then
				local var_357_5 = 0.5

				arg_354_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_354_1.var_.characterEffect1077ui_story.fillRatio = var_357_5
			end

			local var_357_6 = 0
			local var_357_7 = 0.95

			if var_357_6 < arg_354_1.time_ and arg_354_1.time_ <= var_357_6 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_8 = arg_354_1:GetWordFromCfg(325011086)
				local var_357_9 = arg_354_1:FormatText(var_357_8.content)

				arg_354_1.text_.text = var_357_9

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_10 = 38
				local var_357_11 = utf8.len(var_357_9)
				local var_357_12 = var_357_10 <= 0 and var_357_7 or var_357_7 * (var_357_11 / var_357_10)

				if var_357_12 > 0 and var_357_7 < var_357_12 then
					arg_354_1.talkMaxDuration = var_357_12

					if var_357_12 + var_357_6 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_12 + var_357_6
					end
				end

				arg_354_1.text_.text = var_357_9
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_13 = math.max(var_357_7, arg_354_1.talkMaxDuration)

			if var_357_6 <= arg_354_1.time_ and arg_354_1.time_ < var_357_6 + var_357_13 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_6) / var_357_13

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_6 + var_357_13 and arg_354_1.time_ < var_357_6 + var_357_13 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play325011087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 325011087
		arg_358_1.duration_ = 7.97

		local var_358_0 = {
			zh = 5.633,
			ja = 7.966
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play325011088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1077ui_story"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1077ui_story == nil then
				arg_358_1.var_.characterEffect1077ui_story = var_361_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.characterEffect1077ui_story and not isNil(var_361_0) then
					arg_358_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1077ui_story then
				arg_358_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_361_4 = 0
			local var_361_5 = 0.6

			if var_361_4 < arg_358_1.time_ and arg_358_1.time_ <= var_361_4 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_6 = arg_358_1:FormatText(StoryNameCfg[1467].name)

				arg_358_1.leftNameTxt_.text = var_361_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_7 = arg_358_1:GetWordFromCfg(325011087)
				local var_361_8 = arg_358_1:FormatText(var_361_7.content)

				arg_358_1.text_.text = var_361_8

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_9 = 24
				local var_361_10 = utf8.len(var_361_8)
				local var_361_11 = var_361_9 <= 0 and var_361_5 or var_361_5 * (var_361_10 / var_361_9)

				if var_361_11 > 0 and var_361_5 < var_361_11 then
					arg_358_1.talkMaxDuration = var_361_11

					if var_361_11 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_11 + var_361_4
					end
				end

				arg_358_1.text_.text = var_361_8
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011087", "story_v_out_325011.awb") ~= 0 then
					local var_361_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011087", "story_v_out_325011.awb") / 1000

					if var_361_12 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_12 + var_361_4
					end

					if var_361_7.prefab_name ~= "" and arg_358_1.actors_[var_361_7.prefab_name] ~= nil then
						local var_361_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_7.prefab_name].transform, "story_v_out_325011", "325011087", "story_v_out_325011.awb")

						arg_358_1:RecordAudio("325011087", var_361_13)
						arg_358_1:RecordAudio("325011087", var_361_13)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_325011", "325011087", "story_v_out_325011.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_325011", "325011087", "story_v_out_325011.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_14 = math.max(var_361_5, arg_358_1.talkMaxDuration)

			if var_361_4 <= arg_358_1.time_ and arg_358_1.time_ < var_361_4 + var_361_14 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_4) / var_361_14

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_4 + var_361_14 and arg_358_1.time_ < var_361_4 + var_361_14 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play325011088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 325011088
		arg_362_1.duration_ = 9.03

		local var_362_0 = {
			zh = 6.233,
			ja = 9.033
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play325011089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["1077ui_story"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect1077ui_story == nil then
				arg_362_1.var_.characterEffect1077ui_story = var_365_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.200000002980232

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.characterEffect1077ui_story and not isNil(var_365_0) then
					local var_365_4 = Mathf.Lerp(0, 0.5, var_365_3)

					arg_362_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_362_1.var_.characterEffect1077ui_story.fillRatio = var_365_4
				end
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect1077ui_story then
				local var_365_5 = 0.5

				arg_362_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_362_1.var_.characterEffect1077ui_story.fillRatio = var_365_5
			end

			local var_365_6 = 0
			local var_365_7 = 0.525

			if var_365_6 < arg_362_1.time_ and arg_362_1.time_ <= var_365_6 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_8 = arg_362_1:FormatText(StoryNameCfg[1522].name)

				arg_362_1.leftNameTxt_.text = var_365_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_9 = arg_362_1:GetWordFromCfg(325011088)
				local var_365_10 = arg_362_1:FormatText(var_365_9.content)

				arg_362_1.text_.text = var_365_10

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_11 = 21
				local var_365_12 = utf8.len(var_365_10)
				local var_365_13 = var_365_11 <= 0 and var_365_7 or var_365_7 * (var_365_12 / var_365_11)

				if var_365_13 > 0 and var_365_7 < var_365_13 then
					arg_362_1.talkMaxDuration = var_365_13

					if var_365_13 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_13 + var_365_6
					end
				end

				arg_362_1.text_.text = var_365_10
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011088", "story_v_out_325011.awb") ~= 0 then
					local var_365_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011088", "story_v_out_325011.awb") / 1000

					if var_365_14 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_14 + var_365_6
					end

					if var_365_9.prefab_name ~= "" and arg_362_1.actors_[var_365_9.prefab_name] ~= nil then
						local var_365_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_9.prefab_name].transform, "story_v_out_325011", "325011088", "story_v_out_325011.awb")

						arg_362_1:RecordAudio("325011088", var_365_15)
						arg_362_1:RecordAudio("325011088", var_365_15)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_325011", "325011088", "story_v_out_325011.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_325011", "325011088", "story_v_out_325011.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_16 = math.max(var_365_7, arg_362_1.talkMaxDuration)

			if var_365_6 <= arg_362_1.time_ and arg_362_1.time_ < var_365_6 + var_365_16 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_6) / var_365_16

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_6 + var_365_16 and arg_362_1.time_ < var_365_6 + var_365_16 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play325011089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 325011089
		arg_366_1.duration_ = 2.73

		local var_366_0 = {
			zh = 2.733,
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
				arg_366_0:Play325011090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1077ui_story"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect1077ui_story == nil then
				arg_366_1.var_.characterEffect1077ui_story = var_369_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.characterEffect1077ui_story and not isNil(var_369_0) then
					arg_366_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect1077ui_story then
				arg_366_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_369_4 = 0

			if var_369_4 < arg_366_1.time_ and arg_366_1.time_ <= var_369_4 + arg_369_0 then
				arg_366_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			local var_369_5 = 0

			if var_369_5 < arg_366_1.time_ and arg_366_1.time_ <= var_369_5 + arg_369_0 then
				arg_366_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_369_6 = 0
			local var_369_7 = 0.175

			if var_369_6 < arg_366_1.time_ and arg_366_1.time_ <= var_369_6 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_8 = arg_366_1:FormatText(StoryNameCfg[1467].name)

				arg_366_1.leftNameTxt_.text = var_369_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_9 = arg_366_1:GetWordFromCfg(325011089)
				local var_369_10 = arg_366_1:FormatText(var_369_9.content)

				arg_366_1.text_.text = var_369_10

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_11 = 7
				local var_369_12 = utf8.len(var_369_10)
				local var_369_13 = var_369_11 <= 0 and var_369_7 or var_369_7 * (var_369_12 / var_369_11)

				if var_369_13 > 0 and var_369_7 < var_369_13 then
					arg_366_1.talkMaxDuration = var_369_13

					if var_369_13 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_13 + var_369_6
					end
				end

				arg_366_1.text_.text = var_369_10
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011089", "story_v_out_325011.awb") ~= 0 then
					local var_369_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011089", "story_v_out_325011.awb") / 1000

					if var_369_14 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_14 + var_369_6
					end

					if var_369_9.prefab_name ~= "" and arg_366_1.actors_[var_369_9.prefab_name] ~= nil then
						local var_369_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_9.prefab_name].transform, "story_v_out_325011", "325011089", "story_v_out_325011.awb")

						arg_366_1:RecordAudio("325011089", var_369_15)
						arg_366_1:RecordAudio("325011089", var_369_15)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_325011", "325011089", "story_v_out_325011.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_325011", "325011089", "story_v_out_325011.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_16 = math.max(var_369_7, arg_366_1.talkMaxDuration)

			if var_369_6 <= arg_366_1.time_ and arg_366_1.time_ < var_369_6 + var_369_16 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_6) / var_369_16

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_6 + var_369_16 and arg_366_1.time_ < var_369_6 + var_369_16 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play325011090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 325011090
		arg_370_1.duration_ = 11.43

		local var_370_0 = {
			zh = 8.1,
			ja = 11.433
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play325011091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["1077ui_story"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect1077ui_story == nil then
				arg_370_1.var_.characterEffect1077ui_story = var_373_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.200000002980232

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.characterEffect1077ui_story and not isNil(var_373_0) then
					local var_373_4 = Mathf.Lerp(0, 0.5, var_373_3)

					arg_370_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1077ui_story.fillRatio = var_373_4
				end
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect1077ui_story then
				local var_373_5 = 0.5

				arg_370_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1077ui_story.fillRatio = var_373_5
			end

			local var_373_6 = 0
			local var_373_7 = 0.725

			if var_373_6 < arg_370_1.time_ and arg_370_1.time_ <= var_373_6 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_8 = arg_370_1:FormatText(StoryNameCfg[1522].name)

				arg_370_1.leftNameTxt_.text = var_373_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_9 = arg_370_1:GetWordFromCfg(325011090)
				local var_373_10 = arg_370_1:FormatText(var_373_9.content)

				arg_370_1.text_.text = var_373_10

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_11 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011090", "story_v_out_325011.awb") ~= 0 then
					local var_373_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011090", "story_v_out_325011.awb") / 1000

					if var_373_14 + var_373_6 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_14 + var_373_6
					end

					if var_373_9.prefab_name ~= "" and arg_370_1.actors_[var_373_9.prefab_name] ~= nil then
						local var_373_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_9.prefab_name].transform, "story_v_out_325011", "325011090", "story_v_out_325011.awb")

						arg_370_1:RecordAudio("325011090", var_373_15)
						arg_370_1:RecordAudio("325011090", var_373_15)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_325011", "325011090", "story_v_out_325011.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_325011", "325011090", "story_v_out_325011.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_16 = math.max(var_373_7, arg_370_1.talkMaxDuration)

			if var_373_6 <= arg_370_1.time_ and arg_370_1.time_ < var_373_6 + var_373_16 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_6) / var_373_16

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_6 + var_373_16 and arg_370_1.time_ < var_373_6 + var_373_16 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play325011091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 325011091
		arg_374_1.duration_ = 12

		local var_374_0 = {
			zh = 9.033,
			ja = 12
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play325011092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0
			local var_377_1 = 0.725

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_2 = arg_374_1:FormatText(StoryNameCfg[1522].name)

				arg_374_1.leftNameTxt_.text = var_377_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_3 = arg_374_1:GetWordFromCfg(325011091)
				local var_377_4 = arg_374_1:FormatText(var_377_3.content)

				arg_374_1.text_.text = var_377_4

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011091", "story_v_out_325011.awb") ~= 0 then
					local var_377_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011091", "story_v_out_325011.awb") / 1000

					if var_377_8 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_8 + var_377_0
					end

					if var_377_3.prefab_name ~= "" and arg_374_1.actors_[var_377_3.prefab_name] ~= nil then
						local var_377_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_3.prefab_name].transform, "story_v_out_325011", "325011091", "story_v_out_325011.awb")

						arg_374_1:RecordAudio("325011091", var_377_9)
						arg_374_1:RecordAudio("325011091", var_377_9)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_325011", "325011091", "story_v_out_325011.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_325011", "325011091", "story_v_out_325011.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_10 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_10 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_10

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_10 and arg_374_1.time_ < var_377_0 + var_377_10 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play325011092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 325011092
		arg_378_1.duration_ = 7.63

		local var_378_0 = {
			zh = 5.533,
			ja = 7.633
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
				arg_378_0:Play325011093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1077ui_story"]
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1077ui_story == nil then
				arg_378_1.var_.characterEffect1077ui_story = var_381_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 and not isNil(var_381_0) then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2

				if arg_378_1.var_.characterEffect1077ui_story and not isNil(var_381_0) then
					arg_378_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1077ui_story then
				arg_378_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_381_4 = 0
			local var_381_5 = 0.675

			if var_381_4 < arg_378_1.time_ and arg_378_1.time_ <= var_381_4 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_6 = arg_378_1:FormatText(StoryNameCfg[1467].name)

				arg_378_1.leftNameTxt_.text = var_381_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_7 = arg_378_1:GetWordFromCfg(325011092)
				local var_381_8 = arg_378_1:FormatText(var_381_7.content)

				arg_378_1.text_.text = var_381_8

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_9 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011092", "story_v_out_325011.awb") ~= 0 then
					local var_381_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011092", "story_v_out_325011.awb") / 1000

					if var_381_12 + var_381_4 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_12 + var_381_4
					end

					if var_381_7.prefab_name ~= "" and arg_378_1.actors_[var_381_7.prefab_name] ~= nil then
						local var_381_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_7.prefab_name].transform, "story_v_out_325011", "325011092", "story_v_out_325011.awb")

						arg_378_1:RecordAudio("325011092", var_381_13)
						arg_378_1:RecordAudio("325011092", var_381_13)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_325011", "325011092", "story_v_out_325011.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_325011", "325011092", "story_v_out_325011.awb")
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
	Play325011093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 325011093
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play325011094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["1077ui_story"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1077ui_story == nil then
				arg_382_1.var_.characterEffect1077ui_story = var_385_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.characterEffect1077ui_story and not isNil(var_385_0) then
					local var_385_4 = Mathf.Lerp(0, 0.5, var_385_3)

					arg_382_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1077ui_story.fillRatio = var_385_4
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1077ui_story then
				local var_385_5 = 0.5

				arg_382_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1077ui_story.fillRatio = var_385_5
			end

			local var_385_6 = 0
			local var_385_7 = 1.025

			if var_385_6 < arg_382_1.time_ and arg_382_1.time_ <= var_385_6 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_8 = arg_382_1:GetWordFromCfg(325011093)
				local var_385_9 = arg_382_1:FormatText(var_385_8.content)

				arg_382_1.text_.text = var_385_9

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_10 = 41
				local var_385_11 = utf8.len(var_385_9)
				local var_385_12 = var_385_10 <= 0 and var_385_7 or var_385_7 * (var_385_11 / var_385_10)

				if var_385_12 > 0 and var_385_7 < var_385_12 then
					arg_382_1.talkMaxDuration = var_385_12

					if var_385_12 + var_385_6 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_12 + var_385_6
					end
				end

				arg_382_1.text_.text = var_385_9
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_13 = math.max(var_385_7, arg_382_1.talkMaxDuration)

			if var_385_6 <= arg_382_1.time_ and arg_382_1.time_ < var_385_6 + var_385_13 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_6) / var_385_13

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_6 + var_385_13 and arg_382_1.time_ < var_385_6 + var_385_13 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play325011094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 325011094
		arg_386_1.duration_ = 17.23

		local var_386_0 = {
			zh = 17.233,
			ja = 16.933
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play325011095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 1.35

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_2 = arg_386_1:FormatText(StoryNameCfg[1522].name)

				arg_386_1.leftNameTxt_.text = var_389_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_3 = arg_386_1:GetWordFromCfg(325011094)
				local var_389_4 = arg_386_1:FormatText(var_389_3.content)

				arg_386_1.text_.text = var_389_4

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 54
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011094", "story_v_out_325011.awb") ~= 0 then
					local var_389_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011094", "story_v_out_325011.awb") / 1000

					if var_389_8 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_8 + var_389_0
					end

					if var_389_3.prefab_name ~= "" and arg_386_1.actors_[var_389_3.prefab_name] ~= nil then
						local var_389_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_3.prefab_name].transform, "story_v_out_325011", "325011094", "story_v_out_325011.awb")

						arg_386_1:RecordAudio("325011094", var_389_9)
						arg_386_1:RecordAudio("325011094", var_389_9)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_325011", "325011094", "story_v_out_325011.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_325011", "325011094", "story_v_out_325011.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_10 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_10 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_10

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_10 and arg_386_1.time_ < var_389_0 + var_389_10 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play325011095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 325011095
		arg_390_1.duration_ = 7.43

		local var_390_0 = {
			zh = 6.9,
			ja = 7.433
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
				arg_390_0:Play325011096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 0.55

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_2 = arg_390_1:FormatText(StoryNameCfg[1522].name)

				arg_390_1.leftNameTxt_.text = var_393_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_3 = arg_390_1:GetWordFromCfg(325011095)
				local var_393_4 = arg_390_1:FormatText(var_393_3.content)

				arg_390_1.text_.text = var_393_4

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 22
				local var_393_6 = utf8.len(var_393_4)
				local var_393_7 = var_393_5 <= 0 and var_393_1 or var_393_1 * (var_393_6 / var_393_5)

				if var_393_7 > 0 and var_393_1 < var_393_7 then
					arg_390_1.talkMaxDuration = var_393_7

					if var_393_7 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_4
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011095", "story_v_out_325011.awb") ~= 0 then
					local var_393_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011095", "story_v_out_325011.awb") / 1000

					if var_393_8 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_0
					end

					if var_393_3.prefab_name ~= "" and arg_390_1.actors_[var_393_3.prefab_name] ~= nil then
						local var_393_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_3.prefab_name].transform, "story_v_out_325011", "325011095", "story_v_out_325011.awb")

						arg_390_1:RecordAudio("325011095", var_393_9)
						arg_390_1:RecordAudio("325011095", var_393_9)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_325011", "325011095", "story_v_out_325011.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_325011", "325011095", "story_v_out_325011.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_10 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_10 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_10

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_10 and arg_390_1.time_ < var_393_0 + var_393_10 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play325011096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 325011096
		arg_394_1.duration_ = 2.97

		local var_394_0 = {
			zh = 2.533,
			ja = 2.966
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play325011097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1077ui_story"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1077ui_story == nil then
				arg_394_1.var_.characterEffect1077ui_story = var_397_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.characterEffect1077ui_story and not isNil(var_397_0) then
					arg_394_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1077ui_story then
				arg_394_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_397_4 = 0

			if var_397_4 < arg_394_1.time_ and arg_394_1.time_ <= var_397_4 + arg_397_0 then
				arg_394_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			local var_397_5 = 0

			if var_397_5 < arg_394_1.time_ and arg_394_1.time_ <= var_397_5 + arg_397_0 then
				arg_394_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_397_6 = 0
			local var_397_7 = 0.2

			if var_397_6 < arg_394_1.time_ and arg_394_1.time_ <= var_397_6 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_8 = arg_394_1:FormatText(StoryNameCfg[1467].name)

				arg_394_1.leftNameTxt_.text = var_397_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_9 = arg_394_1:GetWordFromCfg(325011096)
				local var_397_10 = arg_394_1:FormatText(var_397_9.content)

				arg_394_1.text_.text = var_397_10

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_11 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011096", "story_v_out_325011.awb") ~= 0 then
					local var_397_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011096", "story_v_out_325011.awb") / 1000

					if var_397_14 + var_397_6 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_14 + var_397_6
					end

					if var_397_9.prefab_name ~= "" and arg_394_1.actors_[var_397_9.prefab_name] ~= nil then
						local var_397_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_9.prefab_name].transform, "story_v_out_325011", "325011096", "story_v_out_325011.awb")

						arg_394_1:RecordAudio("325011096", var_397_15)
						arg_394_1:RecordAudio("325011096", var_397_15)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_325011", "325011096", "story_v_out_325011.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_325011", "325011096", "story_v_out_325011.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_16 = math.max(var_397_7, arg_394_1.talkMaxDuration)

			if var_397_6 <= arg_394_1.time_ and arg_394_1.time_ < var_397_6 + var_397_16 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_6) / var_397_16

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_6 + var_397_16 and arg_394_1.time_ < var_397_6 + var_397_16 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play325011097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 325011097
		arg_398_1.duration_ = 20.2

		local var_398_0 = {
			zh = 13.266,
			ja = 20.2
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play325011098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1077ui_story"]
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.characterEffect1077ui_story == nil then
				arg_398_1.var_.characterEffect1077ui_story = var_401_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_2 = 0.200000002980232

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 and not isNil(var_401_0) then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2

				if arg_398_1.var_.characterEffect1077ui_story and not isNil(var_401_0) then
					local var_401_4 = Mathf.Lerp(0, 0.5, var_401_3)

					arg_398_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_398_1.var_.characterEffect1077ui_story.fillRatio = var_401_4
				end
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.characterEffect1077ui_story then
				local var_401_5 = 0.5

				arg_398_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_398_1.var_.characterEffect1077ui_story.fillRatio = var_401_5
			end

			local var_401_6 = 0
			local var_401_7 = 1.175

			if var_401_6 < arg_398_1.time_ and arg_398_1.time_ <= var_401_6 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_8 = arg_398_1:FormatText(StoryNameCfg[1522].name)

				arg_398_1.leftNameTxt_.text = var_401_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_9 = arg_398_1:GetWordFromCfg(325011097)
				local var_401_10 = arg_398_1:FormatText(var_401_9.content)

				arg_398_1.text_.text = var_401_10

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_11 = 47
				local var_401_12 = utf8.len(var_401_10)
				local var_401_13 = var_401_11 <= 0 and var_401_7 or var_401_7 * (var_401_12 / var_401_11)

				if var_401_13 > 0 and var_401_7 < var_401_13 then
					arg_398_1.talkMaxDuration = var_401_13

					if var_401_13 + var_401_6 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_13 + var_401_6
					end
				end

				arg_398_1.text_.text = var_401_10
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011097", "story_v_out_325011.awb") ~= 0 then
					local var_401_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011097", "story_v_out_325011.awb") / 1000

					if var_401_14 + var_401_6 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_14 + var_401_6
					end

					if var_401_9.prefab_name ~= "" and arg_398_1.actors_[var_401_9.prefab_name] ~= nil then
						local var_401_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_9.prefab_name].transform, "story_v_out_325011", "325011097", "story_v_out_325011.awb")

						arg_398_1:RecordAudio("325011097", var_401_15)
						arg_398_1:RecordAudio("325011097", var_401_15)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_325011", "325011097", "story_v_out_325011.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_325011", "325011097", "story_v_out_325011.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_16 = math.max(var_401_7, arg_398_1.talkMaxDuration)

			if var_401_6 <= arg_398_1.time_ and arg_398_1.time_ < var_401_6 + var_401_16 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_6) / var_401_16

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_6 + var_401_16 and arg_398_1.time_ < var_401_6 + var_401_16 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play325011098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 325011098
		arg_402_1.duration_ = 10.47

		local var_402_0 = {
			zh = 10.466,
			ja = 9.933
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play325011099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0
			local var_405_1 = 0.95

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_2 = arg_402_1:FormatText(StoryNameCfg[1522].name)

				arg_402_1.leftNameTxt_.text = var_405_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_3 = arg_402_1:GetWordFromCfg(325011098)
				local var_405_4 = arg_402_1:FormatText(var_405_3.content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011098", "story_v_out_325011.awb") ~= 0 then
					local var_405_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011098", "story_v_out_325011.awb") / 1000

					if var_405_8 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_0
					end

					if var_405_3.prefab_name ~= "" and arg_402_1.actors_[var_405_3.prefab_name] ~= nil then
						local var_405_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_3.prefab_name].transform, "story_v_out_325011", "325011098", "story_v_out_325011.awb")

						arg_402_1:RecordAudio("325011098", var_405_9)
						arg_402_1:RecordAudio("325011098", var_405_9)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_325011", "325011098", "story_v_out_325011.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_325011", "325011098", "story_v_out_325011.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_10 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_10 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_10

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_10 and arg_402_1.time_ < var_405_0 + var_405_10 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play325011099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 325011099
		arg_406_1.duration_ = 7.67

		local var_406_0 = {
			zh = 7.666,
			ja = 6.933
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
				arg_406_0:Play325011100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0
			local var_409_1 = 0.625

			if var_409_0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_2 = arg_406_1:FormatText(StoryNameCfg[1522].name)

				arg_406_1.leftNameTxt_.text = var_409_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_3 = arg_406_1:GetWordFromCfg(325011099)
				local var_409_4 = arg_406_1:FormatText(var_409_3.content)

				arg_406_1.text_.text = var_409_4

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011099", "story_v_out_325011.awb") ~= 0 then
					local var_409_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011099", "story_v_out_325011.awb") / 1000

					if var_409_8 + var_409_0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_8 + var_409_0
					end

					if var_409_3.prefab_name ~= "" and arg_406_1.actors_[var_409_3.prefab_name] ~= nil then
						local var_409_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_3.prefab_name].transform, "story_v_out_325011", "325011099", "story_v_out_325011.awb")

						arg_406_1:RecordAudio("325011099", var_409_9)
						arg_406_1:RecordAudio("325011099", var_409_9)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_325011", "325011099", "story_v_out_325011.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_325011", "325011099", "story_v_out_325011.awb")
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
	Play325011100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 325011100
		arg_410_1.duration_ = 2.9

		local var_410_0 = {
			zh = 1.999999999999,
			ja = 2.9
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
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play325011101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1077ui_story"]
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect1077ui_story == nil then
				arg_410_1.var_.characterEffect1077ui_story = var_413_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_2 = 0.200000002980232

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 and not isNil(var_413_0) then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / var_413_2

				if arg_410_1.var_.characterEffect1077ui_story and not isNil(var_413_0) then
					arg_410_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect1077ui_story then
				arg_410_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_413_4 = 0

			if var_413_4 < arg_410_1.time_ and arg_410_1.time_ <= var_413_4 + arg_413_0 then
				arg_410_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			local var_413_5 = 0
			local var_413_6 = 0.225

			if var_413_5 < arg_410_1.time_ and arg_410_1.time_ <= var_413_5 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_7 = arg_410_1:FormatText(StoryNameCfg[1467].name)

				arg_410_1.leftNameTxt_.text = var_413_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_8 = arg_410_1:GetWordFromCfg(325011100)
				local var_413_9 = arg_410_1:FormatText(var_413_8.content)

				arg_410_1.text_.text = var_413_9

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_10 = 9
				local var_413_11 = utf8.len(var_413_9)
				local var_413_12 = var_413_10 <= 0 and var_413_6 or var_413_6 * (var_413_11 / var_413_10)

				if var_413_12 > 0 and var_413_6 < var_413_12 then
					arg_410_1.talkMaxDuration = var_413_12

					if var_413_12 + var_413_5 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_12 + var_413_5
					end
				end

				arg_410_1.text_.text = var_413_9
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011100", "story_v_out_325011.awb") ~= 0 then
					local var_413_13 = manager.audio:GetVoiceLength("story_v_out_325011", "325011100", "story_v_out_325011.awb") / 1000

					if var_413_13 + var_413_5 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_13 + var_413_5
					end

					if var_413_8.prefab_name ~= "" and arg_410_1.actors_[var_413_8.prefab_name] ~= nil then
						local var_413_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_8.prefab_name].transform, "story_v_out_325011", "325011100", "story_v_out_325011.awb")

						arg_410_1:RecordAudio("325011100", var_413_14)
						arg_410_1:RecordAudio("325011100", var_413_14)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_325011", "325011100", "story_v_out_325011.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_325011", "325011100", "story_v_out_325011.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_15 = math.max(var_413_6, arg_410_1.talkMaxDuration)

			if var_413_5 <= arg_410_1.time_ and arg_410_1.time_ < var_413_5 + var_413_15 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_5) / var_413_15

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_5 + var_413_15 and arg_410_1.time_ < var_413_5 + var_413_15 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play325011101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 325011101
		arg_414_1.duration_ = 8.67

		local var_414_0 = {
			zh = 6.566,
			ja = 8.666
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play325011102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["1077ui_story"]
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect1077ui_story == nil then
				arg_414_1.var_.characterEffect1077ui_story = var_417_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_2 = 0.200000002980232

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 and not isNil(var_417_0) then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2

				if arg_414_1.var_.characterEffect1077ui_story and not isNil(var_417_0) then
					local var_417_4 = Mathf.Lerp(0, 0.5, var_417_3)

					arg_414_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_414_1.var_.characterEffect1077ui_story.fillRatio = var_417_4
				end
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect1077ui_story then
				local var_417_5 = 0.5

				arg_414_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_414_1.var_.characterEffect1077ui_story.fillRatio = var_417_5
			end

			local var_417_6 = 0
			local var_417_7 = 0.525

			if var_417_6 < arg_414_1.time_ and arg_414_1.time_ <= var_417_6 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_8 = arg_414_1:FormatText(StoryNameCfg[1522].name)

				arg_414_1.leftNameTxt_.text = var_417_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_9 = arg_414_1:GetWordFromCfg(325011101)
				local var_417_10 = arg_414_1:FormatText(var_417_9.content)

				arg_414_1.text_.text = var_417_10

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_11 = 21
				local var_417_12 = utf8.len(var_417_10)
				local var_417_13 = var_417_11 <= 0 and var_417_7 or var_417_7 * (var_417_12 / var_417_11)

				if var_417_13 > 0 and var_417_7 < var_417_13 then
					arg_414_1.talkMaxDuration = var_417_13

					if var_417_13 + var_417_6 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_13 + var_417_6
					end
				end

				arg_414_1.text_.text = var_417_10
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011101", "story_v_out_325011.awb") ~= 0 then
					local var_417_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011101", "story_v_out_325011.awb") / 1000

					if var_417_14 + var_417_6 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_14 + var_417_6
					end

					if var_417_9.prefab_name ~= "" and arg_414_1.actors_[var_417_9.prefab_name] ~= nil then
						local var_417_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_9.prefab_name].transform, "story_v_out_325011", "325011101", "story_v_out_325011.awb")

						arg_414_1:RecordAudio("325011101", var_417_15)
						arg_414_1:RecordAudio("325011101", var_417_15)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_325011", "325011101", "story_v_out_325011.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_325011", "325011101", "story_v_out_325011.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_16 = math.max(var_417_7, arg_414_1.talkMaxDuration)

			if var_417_6 <= arg_414_1.time_ and arg_414_1.time_ < var_417_6 + var_417_16 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_6) / var_417_16

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_6 + var_417_16 and arg_414_1.time_ < var_417_6 + var_417_16 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play325011102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 325011102
		arg_418_1.duration_ = 9.3

		local var_418_0 = {
			zh = 8.233,
			ja = 9.3
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play325011103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["1077ui_story"]
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect1077ui_story == nil then
				arg_418_1.var_.characterEffect1077ui_story = var_421_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_2 = 0.200000002980232

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 and not isNil(var_421_0) then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2

				if arg_418_1.var_.characterEffect1077ui_story and not isNil(var_421_0) then
					arg_418_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect1077ui_story then
				arg_418_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_421_4 = 0

			if var_421_4 < arg_418_1.time_ and arg_418_1.time_ <= var_421_4 + arg_421_0 then
				arg_418_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action4_1")
			end

			local var_421_5 = 0

			if var_421_5 < arg_418_1.time_ and arg_418_1.time_ <= var_421_5 + arg_421_0 then
				arg_418_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_421_6 = 0
			local var_421_7 = 0.7

			if var_421_6 < arg_418_1.time_ and arg_418_1.time_ <= var_421_6 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_8 = arg_418_1:FormatText(StoryNameCfg[1467].name)

				arg_418_1.leftNameTxt_.text = var_421_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_9 = arg_418_1:GetWordFromCfg(325011102)
				local var_421_10 = arg_418_1:FormatText(var_421_9.content)

				arg_418_1.text_.text = var_421_10

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_11 = 28
				local var_421_12 = utf8.len(var_421_10)
				local var_421_13 = var_421_11 <= 0 and var_421_7 or var_421_7 * (var_421_12 / var_421_11)

				if var_421_13 > 0 and var_421_7 < var_421_13 then
					arg_418_1.talkMaxDuration = var_421_13

					if var_421_13 + var_421_6 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_13 + var_421_6
					end
				end

				arg_418_1.text_.text = var_421_10
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011102", "story_v_out_325011.awb") ~= 0 then
					local var_421_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011102", "story_v_out_325011.awb") / 1000

					if var_421_14 + var_421_6 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_14 + var_421_6
					end

					if var_421_9.prefab_name ~= "" and arg_418_1.actors_[var_421_9.prefab_name] ~= nil then
						local var_421_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_9.prefab_name].transform, "story_v_out_325011", "325011102", "story_v_out_325011.awb")

						arg_418_1:RecordAudio("325011102", var_421_15)
						arg_418_1:RecordAudio("325011102", var_421_15)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_325011", "325011102", "story_v_out_325011.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_325011", "325011102", "story_v_out_325011.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_16 = math.max(var_421_7, arg_418_1.talkMaxDuration)

			if var_421_6 <= arg_418_1.time_ and arg_418_1.time_ < var_421_6 + var_421_16 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_6) / var_421_16

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_6 + var_421_16 and arg_418_1.time_ < var_421_6 + var_421_16 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play325011103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 325011103
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play325011104(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["1077ui_story"].transform
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				arg_422_1.var_.moveOldPos1077ui_story = var_425_0.localPosition

				local var_425_2 = GameObjectTools.GetOrAddComponent(var_425_0.gameObject, typeof(DynamicBoneHelper))

				if var_425_2 then
					var_425_2:EnableDynamicBone(false)
				end
			end

			local var_425_3 = 0.001

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_3 then
				local var_425_4 = (arg_422_1.time_ - var_425_1) / var_425_3
				local var_425_5 = Vector3.New(0, 100, 0)

				var_425_0.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1077ui_story, var_425_5, var_425_4)

				local var_425_6 = manager.ui.mainCamera.transform.position - var_425_0.position

				var_425_0.forward = Vector3.New(var_425_6.x, var_425_6.y, var_425_6.z)

				local var_425_7 = var_425_0.localEulerAngles

				var_425_7.z = 0
				var_425_7.x = 0
				var_425_0.localEulerAngles = var_425_7
			end

			if arg_422_1.time_ >= var_425_1 + var_425_3 and arg_422_1.time_ < var_425_1 + var_425_3 + arg_425_0 then
				var_425_0.localPosition = Vector3.New(0, 100, 0)

				local var_425_8 = manager.ui.mainCamera.transform.position - var_425_0.position

				var_425_0.forward = Vector3.New(var_425_8.x, var_425_8.y, var_425_8.z)

				local var_425_9 = var_425_0.localEulerAngles

				var_425_9.z = 0
				var_425_9.x = 0
				var_425_0.localEulerAngles = var_425_9

				local var_425_10 = GameObjectTools.GetOrAddComponent(var_425_0.gameObject, typeof(DynamicBoneHelper))

				if var_425_10 then
					var_425_10:EnableDynamicBone(true)
				end
			end

			local var_425_11 = arg_422_1.actors_["1077ui_story"]
			local var_425_12 = 0

			if var_425_12 < arg_422_1.time_ and arg_422_1.time_ <= var_425_12 + arg_425_0 and not isNil(var_425_11) and arg_422_1.var_.characterEffect1077ui_story == nil then
				arg_422_1.var_.characterEffect1077ui_story = var_425_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_13 = 0.200000002980232

			if var_425_12 <= arg_422_1.time_ and arg_422_1.time_ < var_425_12 + var_425_13 and not isNil(var_425_11) then
				local var_425_14 = (arg_422_1.time_ - var_425_12) / var_425_13

				if arg_422_1.var_.characterEffect1077ui_story and not isNil(var_425_11) then
					local var_425_15 = Mathf.Lerp(0, 0.5, var_425_14)

					arg_422_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_422_1.var_.characterEffect1077ui_story.fillRatio = var_425_15
				end
			end

			if arg_422_1.time_ >= var_425_12 + var_425_13 and arg_422_1.time_ < var_425_12 + var_425_13 + arg_425_0 and not isNil(var_425_11) and arg_422_1.var_.characterEffect1077ui_story then
				local var_425_16 = 0.5

				arg_422_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_422_1.var_.characterEffect1077ui_story.fillRatio = var_425_16
			end

			local var_425_17 = 0
			local var_425_18 = 0.975

			if var_425_17 < arg_422_1.time_ and arg_422_1.time_ <= var_425_17 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_19 = arg_422_1:GetWordFromCfg(325011103)
				local var_425_20 = arg_422_1:FormatText(var_425_19.content)

				arg_422_1.text_.text = var_425_20

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_21 = 39
				local var_425_22 = utf8.len(var_425_20)
				local var_425_23 = var_425_21 <= 0 and var_425_18 or var_425_18 * (var_425_22 / var_425_21)

				if var_425_23 > 0 and var_425_18 < var_425_23 then
					arg_422_1.talkMaxDuration = var_425_23

					if var_425_23 + var_425_17 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_23 + var_425_17
					end
				end

				arg_422_1.text_.text = var_425_20
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_24 = math.max(var_425_18, arg_422_1.talkMaxDuration)

			if var_425_17 <= arg_422_1.time_ and arg_422_1.time_ < var_425_17 + var_425_24 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_17) / var_425_24

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_17 + var_425_24 and arg_422_1.time_ < var_425_17 + var_425_24 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play325011104 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 325011104
		arg_426_1.duration_ = 2.5

		local var_426_0 = {
			zh = 2.5,
			ja = 2.266
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
				arg_426_0:Play325011105(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0
			local var_429_1 = 0.175

			if var_429_0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_2 = arg_426_1:FormatText(StoryNameCfg[1522].name)

				arg_426_1.leftNameTxt_.text = var_429_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_3 = arg_426_1:GetWordFromCfg(325011104)
				local var_429_4 = arg_426_1:FormatText(var_429_3.content)

				arg_426_1.text_.text = var_429_4

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011104", "story_v_out_325011.awb") ~= 0 then
					local var_429_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011104", "story_v_out_325011.awb") / 1000

					if var_429_8 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_8 + var_429_0
					end

					if var_429_3.prefab_name ~= "" and arg_426_1.actors_[var_429_3.prefab_name] ~= nil then
						local var_429_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_3.prefab_name].transform, "story_v_out_325011", "325011104", "story_v_out_325011.awb")

						arg_426_1:RecordAudio("325011104", var_429_9)
						arg_426_1:RecordAudio("325011104", var_429_9)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_325011", "325011104", "story_v_out_325011.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_325011", "325011104", "story_v_out_325011.awb")
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
	Play325011105 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 325011105
		arg_430_1.duration_ = 2.13

		local var_430_0 = {
			zh = 1.999999999999,
			ja = 2.133
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
				arg_430_0:Play325011106(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["1077ui_story"]
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1077ui_story == nil then
				arg_430_1.var_.characterEffect1077ui_story = var_433_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.200000002980232

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 and not isNil(var_433_0) then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2

				if arg_430_1.var_.characterEffect1077ui_story and not isNil(var_433_0) then
					arg_430_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1077ui_story then
				arg_430_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_433_4 = arg_430_1.actors_["1077ui_story"].transform
			local var_433_5 = 0

			if var_433_5 < arg_430_1.time_ and arg_430_1.time_ <= var_433_5 + arg_433_0 then
				arg_430_1.var_.moveOldPos1077ui_story = var_433_4.localPosition

				local var_433_6 = GameObjectTools.GetOrAddComponent(var_433_4.gameObject, typeof(DynamicBoneHelper))

				if var_433_6 then
					var_433_6:EnableDynamicBone(false)
				end
			end

			local var_433_7 = 0.001

			if var_433_5 <= arg_430_1.time_ and arg_430_1.time_ < var_433_5 + var_433_7 then
				local var_433_8 = (arg_430_1.time_ - var_433_5) / var_433_7
				local var_433_9 = Vector3.New(-0.03, -1.02, -5.92)

				var_433_4.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1077ui_story, var_433_9, var_433_8)

				local var_433_10 = manager.ui.mainCamera.transform.position - var_433_4.position

				var_433_4.forward = Vector3.New(var_433_10.x, var_433_10.y, var_433_10.z)

				local var_433_11 = var_433_4.localEulerAngles

				var_433_11.z = 0
				var_433_11.x = 0
				var_433_4.localEulerAngles = var_433_11
			end

			if arg_430_1.time_ >= var_433_5 + var_433_7 and arg_430_1.time_ < var_433_5 + var_433_7 + arg_433_0 then
				var_433_4.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_433_12 = manager.ui.mainCamera.transform.position - var_433_4.position

				var_433_4.forward = Vector3.New(var_433_12.x, var_433_12.y, var_433_12.z)

				local var_433_13 = var_433_4.localEulerAngles

				var_433_13.z = 0
				var_433_13.x = 0
				var_433_4.localEulerAngles = var_433_13

				local var_433_14 = GameObjectTools.GetOrAddComponent(var_433_4.gameObject, typeof(DynamicBoneHelper))

				if var_433_14 then
					var_433_14:EnableDynamicBone(true)
				end
			end

			local var_433_15 = 0

			if var_433_15 < arg_430_1.time_ and arg_430_1.time_ <= var_433_15 + arg_433_0 then
				arg_430_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action4_2")
			end

			local var_433_16 = 0
			local var_433_17 = 0.15

			if var_433_16 < arg_430_1.time_ and arg_430_1.time_ <= var_433_16 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_18 = arg_430_1:FormatText(StoryNameCfg[1467].name)

				arg_430_1.leftNameTxt_.text = var_433_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_19 = arg_430_1:GetWordFromCfg(325011105)
				local var_433_20 = arg_430_1:FormatText(var_433_19.content)

				arg_430_1.text_.text = var_433_20

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_21 = 6
				local var_433_22 = utf8.len(var_433_20)
				local var_433_23 = var_433_21 <= 0 and var_433_17 or var_433_17 * (var_433_22 / var_433_21)

				if var_433_23 > 0 and var_433_17 < var_433_23 then
					arg_430_1.talkMaxDuration = var_433_23

					if var_433_23 + var_433_16 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_23 + var_433_16
					end
				end

				arg_430_1.text_.text = var_433_20
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011105", "story_v_out_325011.awb") ~= 0 then
					local var_433_24 = manager.audio:GetVoiceLength("story_v_out_325011", "325011105", "story_v_out_325011.awb") / 1000

					if var_433_24 + var_433_16 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_24 + var_433_16
					end

					if var_433_19.prefab_name ~= "" and arg_430_1.actors_[var_433_19.prefab_name] ~= nil then
						local var_433_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_19.prefab_name].transform, "story_v_out_325011", "325011105", "story_v_out_325011.awb")

						arg_430_1:RecordAudio("325011105", var_433_25)
						arg_430_1:RecordAudio("325011105", var_433_25)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_325011", "325011105", "story_v_out_325011.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_325011", "325011105", "story_v_out_325011.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_26 = math.max(var_433_17, arg_430_1.talkMaxDuration)

			if var_433_16 <= arg_430_1.time_ and arg_430_1.time_ < var_433_16 + var_433_26 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_16) / var_433_26

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_16 + var_433_26 and arg_430_1.time_ < var_433_16 + var_433_26 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play325011106 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 325011106
		arg_434_1.duration_ = 15.1

		local var_434_0 = {
			zh = 10.8,
			ja = 15.1
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
				arg_434_0:Play325011107(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["1077ui_story"]
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect1077ui_story == nil then
				arg_434_1.var_.characterEffect1077ui_story = var_437_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 and not isNil(var_437_0) then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2

				if arg_434_1.var_.characterEffect1077ui_story and not isNil(var_437_0) then
					local var_437_4 = Mathf.Lerp(0, 0.5, var_437_3)

					arg_434_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1077ui_story.fillRatio = var_437_4
				end
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect1077ui_story then
				local var_437_5 = 0.5

				arg_434_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1077ui_story.fillRatio = var_437_5
			end

			local var_437_6 = 0
			local var_437_7 = 1

			if var_437_6 < arg_434_1.time_ and arg_434_1.time_ <= var_437_6 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_8 = arg_434_1:FormatText(StoryNameCfg[1522].name)

				arg_434_1.leftNameTxt_.text = var_437_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_9 = arg_434_1:GetWordFromCfg(325011106)
				local var_437_10 = arg_434_1:FormatText(var_437_9.content)

				arg_434_1.text_.text = var_437_10

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_11 = 40
				local var_437_12 = utf8.len(var_437_10)
				local var_437_13 = var_437_11 <= 0 and var_437_7 or var_437_7 * (var_437_12 / var_437_11)

				if var_437_13 > 0 and var_437_7 < var_437_13 then
					arg_434_1.talkMaxDuration = var_437_13

					if var_437_13 + var_437_6 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_13 + var_437_6
					end
				end

				arg_434_1.text_.text = var_437_10
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011106", "story_v_out_325011.awb") ~= 0 then
					local var_437_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011106", "story_v_out_325011.awb") / 1000

					if var_437_14 + var_437_6 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_14 + var_437_6
					end

					if var_437_9.prefab_name ~= "" and arg_434_1.actors_[var_437_9.prefab_name] ~= nil then
						local var_437_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_9.prefab_name].transform, "story_v_out_325011", "325011106", "story_v_out_325011.awb")

						arg_434_1:RecordAudio("325011106", var_437_15)
						arg_434_1:RecordAudio("325011106", var_437_15)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_325011", "325011106", "story_v_out_325011.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_325011", "325011106", "story_v_out_325011.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_16 = math.max(var_437_7, arg_434_1.talkMaxDuration)

			if var_437_6 <= arg_434_1.time_ and arg_434_1.time_ < var_437_6 + var_437_16 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_6) / var_437_16

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_6 + var_437_16 and arg_434_1.time_ < var_437_6 + var_437_16 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play325011107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 325011107
		arg_438_1.duration_ = 9.3

		local var_438_0 = {
			zh = 7.9,
			ja = 9.3
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play325011108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0
			local var_441_1 = 0.775

			if var_441_0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_2 = arg_438_1:FormatText(StoryNameCfg[1522].name)

				arg_438_1.leftNameTxt_.text = var_441_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_3 = arg_438_1:GetWordFromCfg(325011107)
				local var_441_4 = arg_438_1:FormatText(var_441_3.content)

				arg_438_1.text_.text = var_441_4

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_5 = 31
				local var_441_6 = utf8.len(var_441_4)
				local var_441_7 = var_441_5 <= 0 and var_441_1 or var_441_1 * (var_441_6 / var_441_5)

				if var_441_7 > 0 and var_441_1 < var_441_7 then
					arg_438_1.talkMaxDuration = var_441_7

					if var_441_7 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_7 + var_441_0
					end
				end

				arg_438_1.text_.text = var_441_4
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011107", "story_v_out_325011.awb") ~= 0 then
					local var_441_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011107", "story_v_out_325011.awb") / 1000

					if var_441_8 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_8 + var_441_0
					end

					if var_441_3.prefab_name ~= "" and arg_438_1.actors_[var_441_3.prefab_name] ~= nil then
						local var_441_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_3.prefab_name].transform, "story_v_out_325011", "325011107", "story_v_out_325011.awb")

						arg_438_1:RecordAudio("325011107", var_441_9)
						arg_438_1:RecordAudio("325011107", var_441_9)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_325011", "325011107", "story_v_out_325011.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_325011", "325011107", "story_v_out_325011.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_10 = math.max(var_441_1, arg_438_1.talkMaxDuration)

			if var_441_0 <= arg_438_1.time_ and arg_438_1.time_ < var_441_0 + var_441_10 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_0) / var_441_10

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_0 + var_441_10 and arg_438_1.time_ < var_441_0 + var_441_10 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play325011108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 325011108
		arg_442_1.duration_ = 5.93

		local var_442_0 = {
			zh = 5.833,
			ja = 5.933
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play325011109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["1077ui_story"]
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.characterEffect1077ui_story == nil then
				arg_442_1.var_.characterEffect1077ui_story = var_445_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_2 = 0.200000002980232

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 and not isNil(var_445_0) then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2

				if arg_442_1.var_.characterEffect1077ui_story and not isNil(var_445_0) then
					arg_442_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.characterEffect1077ui_story then
				arg_442_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_445_4 = 0

			if var_445_4 < arg_442_1.time_ and arg_442_1.time_ <= var_445_4 + arg_445_0 then
				arg_442_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_445_5 = 0
			local var_445_6 = 0.65

			if var_445_5 < arg_442_1.time_ and arg_442_1.time_ <= var_445_5 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_7 = arg_442_1:FormatText(StoryNameCfg[1467].name)

				arg_442_1.leftNameTxt_.text = var_445_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_8 = arg_442_1:GetWordFromCfg(325011108)
				local var_445_9 = arg_442_1:FormatText(var_445_8.content)

				arg_442_1.text_.text = var_445_9

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_10 = 26
				local var_445_11 = utf8.len(var_445_9)
				local var_445_12 = var_445_10 <= 0 and var_445_6 or var_445_6 * (var_445_11 / var_445_10)

				if var_445_12 > 0 and var_445_6 < var_445_12 then
					arg_442_1.talkMaxDuration = var_445_12

					if var_445_12 + var_445_5 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_12 + var_445_5
					end
				end

				arg_442_1.text_.text = var_445_9
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011108", "story_v_out_325011.awb") ~= 0 then
					local var_445_13 = manager.audio:GetVoiceLength("story_v_out_325011", "325011108", "story_v_out_325011.awb") / 1000

					if var_445_13 + var_445_5 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_13 + var_445_5
					end

					if var_445_8.prefab_name ~= "" and arg_442_1.actors_[var_445_8.prefab_name] ~= nil then
						local var_445_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_8.prefab_name].transform, "story_v_out_325011", "325011108", "story_v_out_325011.awb")

						arg_442_1:RecordAudio("325011108", var_445_14)
						arg_442_1:RecordAudio("325011108", var_445_14)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_325011", "325011108", "story_v_out_325011.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_325011", "325011108", "story_v_out_325011.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_15 = math.max(var_445_6, arg_442_1.talkMaxDuration)

			if var_445_5 <= arg_442_1.time_ and arg_442_1.time_ < var_445_5 + var_445_15 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_5) / var_445_15

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_5 + var_445_15 and arg_442_1.time_ < var_445_5 + var_445_15 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play325011109 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 325011109
		arg_446_1.duration_ = 7.43

		local var_446_0 = {
			zh = 7,
			ja = 7.433
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play325011110(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["1077ui_story"]
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect1077ui_story == nil then
				arg_446_1.var_.characterEffect1077ui_story = var_449_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_2 = 0.200000002980232

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 and not isNil(var_449_0) then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2

				if arg_446_1.var_.characterEffect1077ui_story and not isNil(var_449_0) then
					local var_449_4 = Mathf.Lerp(0, 0.5, var_449_3)

					arg_446_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1077ui_story.fillRatio = var_449_4
				end
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect1077ui_story then
				local var_449_5 = 0.5

				arg_446_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1077ui_story.fillRatio = var_449_5
			end

			local var_449_6 = 0
			local var_449_7 = 0.55

			if var_449_6 < arg_446_1.time_ and arg_446_1.time_ <= var_449_6 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_8 = arg_446_1:FormatText(StoryNameCfg[1522].name)

				arg_446_1.leftNameTxt_.text = var_449_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_9 = arg_446_1:GetWordFromCfg(325011109)
				local var_449_10 = arg_446_1:FormatText(var_449_9.content)

				arg_446_1.text_.text = var_449_10

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_11 = 22
				local var_449_12 = utf8.len(var_449_10)
				local var_449_13 = var_449_11 <= 0 and var_449_7 or var_449_7 * (var_449_12 / var_449_11)

				if var_449_13 > 0 and var_449_7 < var_449_13 then
					arg_446_1.talkMaxDuration = var_449_13

					if var_449_13 + var_449_6 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_13 + var_449_6
					end
				end

				arg_446_1.text_.text = var_449_10
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011109", "story_v_out_325011.awb") ~= 0 then
					local var_449_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011109", "story_v_out_325011.awb") / 1000

					if var_449_14 + var_449_6 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_14 + var_449_6
					end

					if var_449_9.prefab_name ~= "" and arg_446_1.actors_[var_449_9.prefab_name] ~= nil then
						local var_449_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_9.prefab_name].transform, "story_v_out_325011", "325011109", "story_v_out_325011.awb")

						arg_446_1:RecordAudio("325011109", var_449_15)
						arg_446_1:RecordAudio("325011109", var_449_15)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_325011", "325011109", "story_v_out_325011.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_325011", "325011109", "story_v_out_325011.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_16 = math.max(var_449_7, arg_446_1.talkMaxDuration)

			if var_449_6 <= arg_446_1.time_ and arg_446_1.time_ < var_449_6 + var_449_16 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_6) / var_449_16

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_6 + var_449_16 and arg_446_1.time_ < var_449_6 + var_449_16 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play325011110 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 325011110
		arg_450_1.duration_ = 9

		local var_450_0 = {
			zh = 9,
			ja = 5.3
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
				arg_450_0:Play325011111(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0
			local var_453_1 = 0.6

			if var_453_0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_2 = arg_450_1:FormatText(StoryNameCfg[1522].name)

				arg_450_1.leftNameTxt_.text = var_453_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_3 = arg_450_1:GetWordFromCfg(325011110)
				local var_453_4 = arg_450_1:FormatText(var_453_3.content)

				arg_450_1.text_.text = var_453_4

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011110", "story_v_out_325011.awb") ~= 0 then
					local var_453_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011110", "story_v_out_325011.awb") / 1000

					if var_453_8 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_8 + var_453_0
					end

					if var_453_3.prefab_name ~= "" and arg_450_1.actors_[var_453_3.prefab_name] ~= nil then
						local var_453_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_3.prefab_name].transform, "story_v_out_325011", "325011110", "story_v_out_325011.awb")

						arg_450_1:RecordAudio("325011110", var_453_9)
						arg_450_1:RecordAudio("325011110", var_453_9)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_325011", "325011110", "story_v_out_325011.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_325011", "325011110", "story_v_out_325011.awb")
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
	Play325011111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 325011111
		arg_454_1.duration_ = 3.43

		local var_454_0 = {
			zh = 3.433,
			ja = 2.033
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
				arg_454_0:Play325011112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["1077ui_story"]
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1077ui_story == nil then
				arg_454_1.var_.characterEffect1077ui_story = var_457_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_2 = 0.200000002980232

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_2 and not isNil(var_457_0) then
				local var_457_3 = (arg_454_1.time_ - var_457_1) / var_457_2

				if arg_454_1.var_.characterEffect1077ui_story and not isNil(var_457_0) then
					arg_454_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= var_457_1 + var_457_2 and arg_454_1.time_ < var_457_1 + var_457_2 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1077ui_story then
				arg_454_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_457_4 = 0

			if var_457_4 < arg_454_1.time_ and arg_454_1.time_ <= var_457_4 + arg_457_0 then
				arg_454_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_1")
			end

			local var_457_5 = 0
			local var_457_6 = 0.375

			if var_457_5 < arg_454_1.time_ and arg_454_1.time_ <= var_457_5 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_7 = arg_454_1:FormatText(StoryNameCfg[1467].name)

				arg_454_1.leftNameTxt_.text = var_457_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_8 = arg_454_1:GetWordFromCfg(325011111)
				local var_457_9 = arg_454_1:FormatText(var_457_8.content)

				arg_454_1.text_.text = var_457_9

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_10 = 15
				local var_457_11 = utf8.len(var_457_9)
				local var_457_12 = var_457_10 <= 0 and var_457_6 or var_457_6 * (var_457_11 / var_457_10)

				if var_457_12 > 0 and var_457_6 < var_457_12 then
					arg_454_1.talkMaxDuration = var_457_12

					if var_457_12 + var_457_5 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_12 + var_457_5
					end
				end

				arg_454_1.text_.text = var_457_9
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011111", "story_v_out_325011.awb") ~= 0 then
					local var_457_13 = manager.audio:GetVoiceLength("story_v_out_325011", "325011111", "story_v_out_325011.awb") / 1000

					if var_457_13 + var_457_5 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_13 + var_457_5
					end

					if var_457_8.prefab_name ~= "" and arg_454_1.actors_[var_457_8.prefab_name] ~= nil then
						local var_457_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_8.prefab_name].transform, "story_v_out_325011", "325011111", "story_v_out_325011.awb")

						arg_454_1:RecordAudio("325011111", var_457_14)
						arg_454_1:RecordAudio("325011111", var_457_14)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_325011", "325011111", "story_v_out_325011.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_325011", "325011111", "story_v_out_325011.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_15 = math.max(var_457_6, arg_454_1.talkMaxDuration)

			if var_457_5 <= arg_454_1.time_ and arg_454_1.time_ < var_457_5 + var_457_15 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_5) / var_457_15

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_5 + var_457_15 and arg_454_1.time_ < var_457_5 + var_457_15 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play325011112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 325011112
		arg_458_1.duration_ = 7.7

		local var_458_0 = {
			zh = 6.733,
			ja = 7.7
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play325011113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["1077ui_story"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1077ui_story == nil then
				arg_458_1.var_.characterEffect1077ui_story = var_461_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.characterEffect1077ui_story and not isNil(var_461_0) then
					local var_461_4 = Mathf.Lerp(0, 0.5, var_461_3)

					arg_458_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1077ui_story.fillRatio = var_461_4
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1077ui_story then
				local var_461_5 = 0.5

				arg_458_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1077ui_story.fillRatio = var_461_5
			end

			local var_461_6 = 0
			local var_461_7 = 0.6

			if var_461_6 < arg_458_1.time_ and arg_458_1.time_ <= var_461_6 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_8 = arg_458_1:FormatText(StoryNameCfg[1522].name)

				arg_458_1.leftNameTxt_.text = var_461_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_9 = arg_458_1:GetWordFromCfg(325011112)
				local var_461_10 = arg_458_1:FormatText(var_461_9.content)

				arg_458_1.text_.text = var_461_10

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_11 = 24
				local var_461_12 = utf8.len(var_461_10)
				local var_461_13 = var_461_11 <= 0 and var_461_7 or var_461_7 * (var_461_12 / var_461_11)

				if var_461_13 > 0 and var_461_7 < var_461_13 then
					arg_458_1.talkMaxDuration = var_461_13

					if var_461_13 + var_461_6 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_13 + var_461_6
					end
				end

				arg_458_1.text_.text = var_461_10
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011112", "story_v_out_325011.awb") ~= 0 then
					local var_461_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011112", "story_v_out_325011.awb") / 1000

					if var_461_14 + var_461_6 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_14 + var_461_6
					end

					if var_461_9.prefab_name ~= "" and arg_458_1.actors_[var_461_9.prefab_name] ~= nil then
						local var_461_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_9.prefab_name].transform, "story_v_out_325011", "325011112", "story_v_out_325011.awb")

						arg_458_1:RecordAudio("325011112", var_461_15)
						arg_458_1:RecordAudio("325011112", var_461_15)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_325011", "325011112", "story_v_out_325011.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_325011", "325011112", "story_v_out_325011.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_16 = math.max(var_461_7, arg_458_1.talkMaxDuration)

			if var_461_6 <= arg_458_1.time_ and arg_458_1.time_ < var_461_6 + var_461_16 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_6) / var_461_16

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_6 + var_461_16 and arg_458_1.time_ < var_461_6 + var_461_16 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play325011113 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 325011113
		arg_462_1.duration_ = 12.33

		local var_462_0 = {
			zh = 8.1,
			ja = 12.333
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play325011114(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["1077ui_story"]
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect1077ui_story == nil then
				arg_462_1.var_.characterEffect1077ui_story = var_465_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_2 = 0.200000002980232

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 and not isNil(var_465_0) then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2

				if arg_462_1.var_.characterEffect1077ui_story and not isNil(var_465_0) then
					arg_462_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect1077ui_story then
				arg_462_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_465_4 = 0

			if var_465_4 < arg_462_1.time_ and arg_462_1.time_ <= var_465_4 + arg_465_0 then
				arg_462_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_2")
			end

			local var_465_5 = 0
			local var_465_6 = 1.025

			if var_465_5 < arg_462_1.time_ and arg_462_1.time_ <= var_465_5 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_7 = arg_462_1:FormatText(StoryNameCfg[1467].name)

				arg_462_1.leftNameTxt_.text = var_465_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_8 = arg_462_1:GetWordFromCfg(325011113)
				local var_465_9 = arg_462_1:FormatText(var_465_8.content)

				arg_462_1.text_.text = var_465_9

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_10 = 41
				local var_465_11 = utf8.len(var_465_9)
				local var_465_12 = var_465_10 <= 0 and var_465_6 or var_465_6 * (var_465_11 / var_465_10)

				if var_465_12 > 0 and var_465_6 < var_465_12 then
					arg_462_1.talkMaxDuration = var_465_12

					if var_465_12 + var_465_5 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_12 + var_465_5
					end
				end

				arg_462_1.text_.text = var_465_9
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011113", "story_v_out_325011.awb") ~= 0 then
					local var_465_13 = manager.audio:GetVoiceLength("story_v_out_325011", "325011113", "story_v_out_325011.awb") / 1000

					if var_465_13 + var_465_5 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_13 + var_465_5
					end

					if var_465_8.prefab_name ~= "" and arg_462_1.actors_[var_465_8.prefab_name] ~= nil then
						local var_465_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_8.prefab_name].transform, "story_v_out_325011", "325011113", "story_v_out_325011.awb")

						arg_462_1:RecordAudio("325011113", var_465_14)
						arg_462_1:RecordAudio("325011113", var_465_14)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_325011", "325011113", "story_v_out_325011.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_325011", "325011113", "story_v_out_325011.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_15 = math.max(var_465_6, arg_462_1.talkMaxDuration)

			if var_465_5 <= arg_462_1.time_ and arg_462_1.time_ < var_465_5 + var_465_15 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_5) / var_465_15

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_5 + var_465_15 and arg_462_1.time_ < var_465_5 + var_465_15 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play325011114 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 325011114
		arg_466_1.duration_ = 9.83

		local var_466_0 = {
			zh = 9.633,
			ja = 9.833
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play325011115(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1077ui_story"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1077ui_story == nil then
				arg_466_1.var_.characterEffect1077ui_story = var_469_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.200000002980232

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.characterEffect1077ui_story and not isNil(var_469_0) then
					local var_469_4 = Mathf.Lerp(0, 0.5, var_469_3)

					arg_466_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1077ui_story.fillRatio = var_469_4
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1077ui_story then
				local var_469_5 = 0.5

				arg_466_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1077ui_story.fillRatio = var_469_5
			end

			local var_469_6 = 0
			local var_469_7 = 0.875

			if var_469_6 < arg_466_1.time_ and arg_466_1.time_ <= var_469_6 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_8 = arg_466_1:FormatText(StoryNameCfg[1522].name)

				arg_466_1.leftNameTxt_.text = var_469_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_9 = arg_466_1:GetWordFromCfg(325011114)
				local var_469_10 = arg_466_1:FormatText(var_469_9.content)

				arg_466_1.text_.text = var_469_10

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_11 = 35
				local var_469_12 = utf8.len(var_469_10)
				local var_469_13 = var_469_11 <= 0 and var_469_7 or var_469_7 * (var_469_12 / var_469_11)

				if var_469_13 > 0 and var_469_7 < var_469_13 then
					arg_466_1.talkMaxDuration = var_469_13

					if var_469_13 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_13 + var_469_6
					end
				end

				arg_466_1.text_.text = var_469_10
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011114", "story_v_out_325011.awb") ~= 0 then
					local var_469_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011114", "story_v_out_325011.awb") / 1000

					if var_469_14 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_14 + var_469_6
					end

					if var_469_9.prefab_name ~= "" and arg_466_1.actors_[var_469_9.prefab_name] ~= nil then
						local var_469_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_9.prefab_name].transform, "story_v_out_325011", "325011114", "story_v_out_325011.awb")

						arg_466_1:RecordAudio("325011114", var_469_15)
						arg_466_1:RecordAudio("325011114", var_469_15)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_325011", "325011114", "story_v_out_325011.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_325011", "325011114", "story_v_out_325011.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_16 = math.max(var_469_7, arg_466_1.talkMaxDuration)

			if var_469_6 <= arg_466_1.time_ and arg_466_1.time_ < var_469_6 + var_469_16 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_6) / var_469_16

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_6 + var_469_16 and arg_466_1.time_ < var_469_6 + var_469_16 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play325011115 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 325011115
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play325011116(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["1077ui_story"].transform
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.var_.moveOldPos1077ui_story = var_473_0.localPosition

				local var_473_2 = GameObjectTools.GetOrAddComponent(var_473_0.gameObject, typeof(DynamicBoneHelper))

				if var_473_2 then
					var_473_2:EnableDynamicBone(false)
				end
			end

			local var_473_3 = 0.001

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_3 then
				local var_473_4 = (arg_470_1.time_ - var_473_1) / var_473_3
				local var_473_5 = Vector3.New(0, 100, 0)

				var_473_0.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1077ui_story, var_473_5, var_473_4)

				local var_473_6 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_6.x, var_473_6.y, var_473_6.z)

				local var_473_7 = var_473_0.localEulerAngles

				var_473_7.z = 0
				var_473_7.x = 0
				var_473_0.localEulerAngles = var_473_7
			end

			if arg_470_1.time_ >= var_473_1 + var_473_3 and arg_470_1.time_ < var_473_1 + var_473_3 + arg_473_0 then
				var_473_0.localPosition = Vector3.New(0, 100, 0)

				local var_473_8 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_8.x, var_473_8.y, var_473_8.z)

				local var_473_9 = var_473_0.localEulerAngles

				var_473_9.z = 0
				var_473_9.x = 0
				var_473_0.localEulerAngles = var_473_9

				local var_473_10 = GameObjectTools.GetOrAddComponent(var_473_0.gameObject, typeof(DynamicBoneHelper))

				if var_473_10 then
					var_473_10:EnableDynamicBone(true)
				end
			end

			local var_473_11 = 0
			local var_473_12 = 1.275

			if var_473_11 < arg_470_1.time_ and arg_470_1.time_ <= var_473_11 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_13 = arg_470_1:GetWordFromCfg(325011115)
				local var_473_14 = arg_470_1:FormatText(var_473_13.content)

				arg_470_1.text_.text = var_473_14

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_15 = 51
				local var_473_16 = utf8.len(var_473_14)
				local var_473_17 = var_473_15 <= 0 and var_473_12 or var_473_12 * (var_473_16 / var_473_15)

				if var_473_17 > 0 and var_473_12 < var_473_17 then
					arg_470_1.talkMaxDuration = var_473_17

					if var_473_17 + var_473_11 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_17 + var_473_11
					end
				end

				arg_470_1.text_.text = var_473_14
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_18 = math.max(var_473_12, arg_470_1.talkMaxDuration)

			if var_473_11 <= arg_470_1.time_ and arg_470_1.time_ < var_473_11 + var_473_18 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_11) / var_473_18

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_11 + var_473_18 and arg_470_1.time_ < var_473_11 + var_473_18 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play325011116 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 325011116
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play325011117(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0
			local var_477_1 = 0.85

			if var_477_0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_2 = arg_474_1:GetWordFromCfg(325011116)
				local var_477_3 = arg_474_1:FormatText(var_477_2.content)

				arg_474_1.text_.text = var_477_3

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_4 = 34
				local var_477_5 = utf8.len(var_477_3)
				local var_477_6 = var_477_4 <= 0 and var_477_1 or var_477_1 * (var_477_5 / var_477_4)

				if var_477_6 > 0 and var_477_1 < var_477_6 then
					arg_474_1.talkMaxDuration = var_477_6

					if var_477_6 + var_477_0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_6 + var_477_0
					end
				end

				arg_474_1.text_.text = var_477_3
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_7 = math.max(var_477_1, arg_474_1.talkMaxDuration)

			if var_477_0 <= arg_474_1.time_ and arg_474_1.time_ < var_477_0 + var_477_7 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_0) / var_477_7

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_0 + var_477_7 and arg_474_1.time_ < var_477_0 + var_477_7 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play325011117 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 325011117
		arg_478_1.duration_ = 2

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play325011118(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = "1069ui_story"

			if arg_478_1.actors_[var_481_0] == nil then
				local var_481_1 = Asset.Load("Char/" .. "1069ui_story")

				if not isNil(var_481_1) then
					local var_481_2 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_478_1.stage_.transform)

					var_481_2.name = var_481_0
					var_481_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_478_1.actors_[var_481_0] = var_481_2

					local var_481_3 = var_481_2:GetComponentInChildren(typeof(CharacterEffect))

					var_481_3.enabled = true

					local var_481_4 = GameObjectTools.GetOrAddComponent(var_481_2, typeof(DynamicBoneHelper))

					if var_481_4 then
						var_481_4:EnableDynamicBone(false)
					end

					arg_478_1:ShowWeapon(var_481_3.transform, false)

					arg_478_1.var_[var_481_0 .. "Animator"] = var_481_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_478_1.var_[var_481_0 .. "Animator"].applyRootMotion = true
					arg_478_1.var_[var_481_0 .. "LipSync"] = var_481_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_481_5 = arg_478_1.actors_["1069ui_story"].transform
			local var_481_6 = 0

			if var_481_6 < arg_478_1.time_ and arg_478_1.time_ <= var_481_6 + arg_481_0 then
				arg_478_1.var_.moveOldPos1069ui_story = var_481_5.localPosition
			end

			local var_481_7 = 0.001

			if var_481_6 <= arg_478_1.time_ and arg_478_1.time_ < var_481_6 + var_481_7 then
				local var_481_8 = (arg_478_1.time_ - var_481_6) / var_481_7
				local var_481_9 = Vector3.New(0, -1, -6)

				var_481_5.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1069ui_story, var_481_9, var_481_8)

				local var_481_10 = manager.ui.mainCamera.transform.position - var_481_5.position

				var_481_5.forward = Vector3.New(var_481_10.x, var_481_10.y, var_481_10.z)

				local var_481_11 = var_481_5.localEulerAngles

				var_481_11.z = 0
				var_481_11.x = 0
				var_481_5.localEulerAngles = var_481_11
			end

			if arg_478_1.time_ >= var_481_6 + var_481_7 and arg_478_1.time_ < var_481_6 + var_481_7 + arg_481_0 then
				var_481_5.localPosition = Vector3.New(0, -1, -6)

				local var_481_12 = manager.ui.mainCamera.transform.position - var_481_5.position

				var_481_5.forward = Vector3.New(var_481_12.x, var_481_12.y, var_481_12.z)

				local var_481_13 = var_481_5.localEulerAngles

				var_481_13.z = 0
				var_481_13.x = 0
				var_481_5.localEulerAngles = var_481_13
			end

			local var_481_14 = arg_478_1.actors_["1069ui_story"]
			local var_481_15 = 0

			if var_481_15 < arg_478_1.time_ and arg_478_1.time_ <= var_481_15 + arg_481_0 and not isNil(var_481_14) and arg_478_1.var_.characterEffect1069ui_story == nil then
				arg_478_1.var_.characterEffect1069ui_story = var_481_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_16 = 0.200000002980232

			if var_481_15 <= arg_478_1.time_ and arg_478_1.time_ < var_481_15 + var_481_16 and not isNil(var_481_14) then
				local var_481_17 = (arg_478_1.time_ - var_481_15) / var_481_16

				if arg_478_1.var_.characterEffect1069ui_story and not isNil(var_481_14) then
					arg_478_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= var_481_15 + var_481_16 and arg_478_1.time_ < var_481_15 + var_481_16 + arg_481_0 and not isNil(var_481_14) and arg_478_1.var_.characterEffect1069ui_story then
				arg_478_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_481_18 = 0

			if var_481_18 < arg_478_1.time_ and arg_478_1.time_ <= var_481_18 + arg_481_0 then
				arg_478_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_481_19 = 0

			if var_481_19 < arg_478_1.time_ and arg_478_1.time_ <= var_481_19 + arg_481_0 then
				arg_478_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_481_20 = 0
			local var_481_21 = 0.075

			if var_481_20 < arg_478_1.time_ and arg_478_1.time_ <= var_481_20 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_22 = arg_478_1:FormatText(StoryNameCfg[378].name)

				arg_478_1.leftNameTxt_.text = var_481_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_23 = arg_478_1:GetWordFromCfg(325011117)
				local var_481_24 = arg_478_1:FormatText(var_481_23.content)

				arg_478_1.text_.text = var_481_24

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_25 = 3
				local var_481_26 = utf8.len(var_481_24)
				local var_481_27 = var_481_25 <= 0 and var_481_21 or var_481_21 * (var_481_26 / var_481_25)

				if var_481_27 > 0 and var_481_21 < var_481_27 then
					arg_478_1.talkMaxDuration = var_481_27

					if var_481_27 + var_481_20 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_27 + var_481_20
					end
				end

				arg_478_1.text_.text = var_481_24
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011117", "story_v_out_325011.awb") ~= 0 then
					local var_481_28 = manager.audio:GetVoiceLength("story_v_out_325011", "325011117", "story_v_out_325011.awb") / 1000

					if var_481_28 + var_481_20 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_28 + var_481_20
					end

					if var_481_23.prefab_name ~= "" and arg_478_1.actors_[var_481_23.prefab_name] ~= nil then
						local var_481_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_23.prefab_name].transform, "story_v_out_325011", "325011117", "story_v_out_325011.awb")

						arg_478_1:RecordAudio("325011117", var_481_29)
						arg_478_1:RecordAudio("325011117", var_481_29)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_325011", "325011117", "story_v_out_325011.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_325011", "325011117", "story_v_out_325011.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_30 = math.max(var_481_21, arg_478_1.talkMaxDuration)

			if var_481_20 <= arg_478_1.time_ and arg_478_1.time_ < var_481_20 + var_481_30 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_20) / var_481_30

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_20 + var_481_30 and arg_478_1.time_ < var_481_20 + var_481_30 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_478_1:InitPlayNodeList()
	end,
	Play325011118 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 325011118
		arg_482_1.duration_ = 4.43

		local var_482_0 = {
			zh = 2.766,
			ja = 4.433
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play325011119(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = arg_482_1.actors_["1069ui_story"]
			local var_485_1 = 0

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect1069ui_story == nil then
				arg_482_1.var_.characterEffect1069ui_story = var_485_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_2 = 0.200000002980232

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_2 and not isNil(var_485_0) then
				local var_485_3 = (arg_482_1.time_ - var_485_1) / var_485_2

				if arg_482_1.var_.characterEffect1069ui_story and not isNil(var_485_0) then
					local var_485_4 = Mathf.Lerp(0, 0.5, var_485_3)

					arg_482_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_482_1.var_.characterEffect1069ui_story.fillRatio = var_485_4
				end
			end

			if arg_482_1.time_ >= var_485_1 + var_485_2 and arg_482_1.time_ < var_485_1 + var_485_2 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect1069ui_story then
				local var_485_5 = 0.5

				arg_482_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_482_1.var_.characterEffect1069ui_story.fillRatio = var_485_5
			end

			local var_485_6 = 0
			local var_485_7 = 0.2

			if var_485_6 < arg_482_1.time_ and arg_482_1.time_ <= var_485_6 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_8 = arg_482_1:FormatText(StoryNameCfg[1522].name)

				arg_482_1.leftNameTxt_.text = var_485_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_9 = arg_482_1:GetWordFromCfg(325011118)
				local var_485_10 = arg_482_1:FormatText(var_485_9.content)

				arg_482_1.text_.text = var_485_10

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_11 = 8
				local var_485_12 = utf8.len(var_485_10)
				local var_485_13 = var_485_11 <= 0 and var_485_7 or var_485_7 * (var_485_12 / var_485_11)

				if var_485_13 > 0 and var_485_7 < var_485_13 then
					arg_482_1.talkMaxDuration = var_485_13

					if var_485_13 + var_485_6 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_13 + var_485_6
					end
				end

				arg_482_1.text_.text = var_485_10
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011118", "story_v_out_325011.awb") ~= 0 then
					local var_485_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011118", "story_v_out_325011.awb") / 1000

					if var_485_14 + var_485_6 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_14 + var_485_6
					end

					if var_485_9.prefab_name ~= "" and arg_482_1.actors_[var_485_9.prefab_name] ~= nil then
						local var_485_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_9.prefab_name].transform, "story_v_out_325011", "325011118", "story_v_out_325011.awb")

						arg_482_1:RecordAudio("325011118", var_485_15)
						arg_482_1:RecordAudio("325011118", var_485_15)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_325011", "325011118", "story_v_out_325011.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_325011", "325011118", "story_v_out_325011.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_16 = math.max(var_485_7, arg_482_1.talkMaxDuration)

			if var_485_6 <= arg_482_1.time_ and arg_482_1.time_ < var_485_6 + var_485_16 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_6) / var_485_16

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_6 + var_485_16 and arg_482_1.time_ < var_485_6 + var_485_16 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play325011119 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 325011119
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play325011120(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["1069ui_story"].transform
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 then
				arg_486_1.var_.moveOldPos1069ui_story = var_489_0.localPosition
			end

			local var_489_2 = 0.001

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2
				local var_489_4 = Vector3.New(0, 100, 0)

				var_489_0.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos1069ui_story, var_489_4, var_489_3)

				local var_489_5 = manager.ui.mainCamera.transform.position - var_489_0.position

				var_489_0.forward = Vector3.New(var_489_5.x, var_489_5.y, var_489_5.z)

				local var_489_6 = var_489_0.localEulerAngles

				var_489_6.z = 0
				var_489_6.x = 0
				var_489_0.localEulerAngles = var_489_6
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 then
				var_489_0.localPosition = Vector3.New(0, 100, 0)

				local var_489_7 = manager.ui.mainCamera.transform.position - var_489_0.position

				var_489_0.forward = Vector3.New(var_489_7.x, var_489_7.y, var_489_7.z)

				local var_489_8 = var_489_0.localEulerAngles

				var_489_8.z = 0
				var_489_8.x = 0
				var_489_0.localEulerAngles = var_489_8
			end

			local var_489_9 = arg_486_1.actors_["1069ui_story"]
			local var_489_10 = 0

			if var_489_10 < arg_486_1.time_ and arg_486_1.time_ <= var_489_10 + arg_489_0 and not isNil(var_489_9) and arg_486_1.var_.characterEffect1069ui_story == nil then
				arg_486_1.var_.characterEffect1069ui_story = var_489_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_11 = 0.200000002980232

			if var_489_10 <= arg_486_1.time_ and arg_486_1.time_ < var_489_10 + var_489_11 and not isNil(var_489_9) then
				local var_489_12 = (arg_486_1.time_ - var_489_10) / var_489_11

				if arg_486_1.var_.characterEffect1069ui_story and not isNil(var_489_9) then
					arg_486_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= var_489_10 + var_489_11 and arg_486_1.time_ < var_489_10 + var_489_11 + arg_489_0 and not isNil(var_489_9) and arg_486_1.var_.characterEffect1069ui_story then
				arg_486_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_489_13 = 0.3
			local var_489_14 = 1

			if var_489_13 < arg_486_1.time_ and arg_486_1.time_ <= var_489_13 + arg_489_0 then
				local var_489_15 = "play"
				local var_489_16 = "effect"

				arg_486_1:AudioAction(var_489_15, var_489_16, "se_story_148", "se_story_148_footstep_crowd", "")
			end

			local var_489_17 = 0
			local var_489_18 = 1.175

			if var_489_17 < arg_486_1.time_ and arg_486_1.time_ <= var_489_17 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_19 = arg_486_1:GetWordFromCfg(325011119)
				local var_489_20 = arg_486_1:FormatText(var_489_19.content)

				arg_486_1.text_.text = var_489_20

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_21 = 47
				local var_489_22 = utf8.len(var_489_20)
				local var_489_23 = var_489_21 <= 0 and var_489_18 or var_489_18 * (var_489_22 / var_489_21)

				if var_489_23 > 0 and var_489_18 < var_489_23 then
					arg_486_1.talkMaxDuration = var_489_23

					if var_489_23 + var_489_17 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_23 + var_489_17
					end
				end

				arg_486_1.text_.text = var_489_20
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_24 = math.max(var_489_18, arg_486_1.talkMaxDuration)

			if var_489_17 <= arg_486_1.time_ and arg_486_1.time_ < var_489_17 + var_489_24 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_17) / var_489_24

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_17 + var_489_24 and arg_486_1.time_ < var_489_17 + var_489_24 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_486_1:InitPlayNodeList()
	end,
	Play325011120 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 325011120
		arg_490_1.duration_ = 6.7

		local var_490_0 = {
			zh = 3.7,
			ja = 6.7
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play325011121(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["1069ui_story"]
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect1069ui_story == nil then
				arg_490_1.var_.characterEffect1069ui_story = var_493_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_2 = 0.200000002980232

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_2 and not isNil(var_493_0) then
				local var_493_3 = (arg_490_1.time_ - var_493_1) / var_493_2

				if arg_490_1.var_.characterEffect1069ui_story and not isNil(var_493_0) then
					arg_490_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= var_493_1 + var_493_2 and arg_490_1.time_ < var_493_1 + var_493_2 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect1069ui_story then
				arg_490_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_493_4 = arg_490_1.actors_["1069ui_story"].transform
			local var_493_5 = 0

			if var_493_5 < arg_490_1.time_ and arg_490_1.time_ <= var_493_5 + arg_493_0 then
				arg_490_1.var_.moveOldPos1069ui_story = var_493_4.localPosition
			end

			local var_493_6 = 0.001

			if var_493_5 <= arg_490_1.time_ and arg_490_1.time_ < var_493_5 + var_493_6 then
				local var_493_7 = (arg_490_1.time_ - var_493_5) / var_493_6
				local var_493_8 = Vector3.New(0, -1, -6)

				var_493_4.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1069ui_story, var_493_8, var_493_7)

				local var_493_9 = manager.ui.mainCamera.transform.position - var_493_4.position

				var_493_4.forward = Vector3.New(var_493_9.x, var_493_9.y, var_493_9.z)

				local var_493_10 = var_493_4.localEulerAngles

				var_493_10.z = 0
				var_493_10.x = 0
				var_493_4.localEulerAngles = var_493_10
			end

			if arg_490_1.time_ >= var_493_5 + var_493_6 and arg_490_1.time_ < var_493_5 + var_493_6 + arg_493_0 then
				var_493_4.localPosition = Vector3.New(0, -1, -6)

				local var_493_11 = manager.ui.mainCamera.transform.position - var_493_4.position

				var_493_4.forward = Vector3.New(var_493_11.x, var_493_11.y, var_493_11.z)

				local var_493_12 = var_493_4.localEulerAngles

				var_493_12.z = 0
				var_493_12.x = 0
				var_493_4.localEulerAngles = var_493_12
			end

			local var_493_13 = 0

			if var_493_13 < arg_490_1.time_ and arg_490_1.time_ <= var_493_13 + arg_493_0 then
				arg_490_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_2")
			end

			local var_493_14 = 0
			local var_493_15 = 0.5

			if var_493_14 < arg_490_1.time_ and arg_490_1.time_ <= var_493_14 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_16 = arg_490_1:FormatText(StoryNameCfg[378].name)

				arg_490_1.leftNameTxt_.text = var_493_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_17 = arg_490_1:GetWordFromCfg(325011120)
				local var_493_18 = arg_490_1:FormatText(var_493_17.content)

				arg_490_1.text_.text = var_493_18

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_19 = 20
				local var_493_20 = utf8.len(var_493_18)
				local var_493_21 = var_493_19 <= 0 and var_493_15 or var_493_15 * (var_493_20 / var_493_19)

				if var_493_21 > 0 and var_493_15 < var_493_21 then
					arg_490_1.talkMaxDuration = var_493_21

					if var_493_21 + var_493_14 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_21 + var_493_14
					end
				end

				arg_490_1.text_.text = var_493_18
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011120", "story_v_out_325011.awb") ~= 0 then
					local var_493_22 = manager.audio:GetVoiceLength("story_v_out_325011", "325011120", "story_v_out_325011.awb") / 1000

					if var_493_22 + var_493_14 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_22 + var_493_14
					end

					if var_493_17.prefab_name ~= "" and arg_490_1.actors_[var_493_17.prefab_name] ~= nil then
						local var_493_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_17.prefab_name].transform, "story_v_out_325011", "325011120", "story_v_out_325011.awb")

						arg_490_1:RecordAudio("325011120", var_493_23)
						arg_490_1:RecordAudio("325011120", var_493_23)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_325011", "325011120", "story_v_out_325011.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_325011", "325011120", "story_v_out_325011.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_24 = math.max(var_493_15, arg_490_1.talkMaxDuration)

			if var_493_14 <= arg_490_1.time_ and arg_490_1.time_ < var_493_14 + var_493_24 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_14) / var_493_24

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_14 + var_493_24 and arg_490_1.time_ < var_493_14 + var_493_24 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play325011121 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 325011121
		arg_494_1.duration_ = 4.4

		local var_494_0 = {
			zh = 4.4,
			ja = 3.433
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play325011122(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["1069ui_story"]
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect1069ui_story == nil then
				arg_494_1.var_.characterEffect1069ui_story = var_497_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_2 = 0.200000002980232

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 and not isNil(var_497_0) then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2

				if arg_494_1.var_.characterEffect1069ui_story and not isNil(var_497_0) then
					local var_497_4 = Mathf.Lerp(0, 0.5, var_497_3)

					arg_494_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_494_1.var_.characterEffect1069ui_story.fillRatio = var_497_4
				end
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect1069ui_story then
				local var_497_5 = 0.5

				arg_494_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_494_1.var_.characterEffect1069ui_story.fillRatio = var_497_5
			end

			local var_497_6 = 0
			local var_497_7 = 0.375

			if var_497_6 < arg_494_1.time_ and arg_494_1.time_ <= var_497_6 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_8 = arg_494_1:FormatText(StoryNameCfg[1522].name)

				arg_494_1.leftNameTxt_.text = var_497_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_9 = arg_494_1:GetWordFromCfg(325011121)
				local var_497_10 = arg_494_1:FormatText(var_497_9.content)

				arg_494_1.text_.text = var_497_10

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_11 = 15
				local var_497_12 = utf8.len(var_497_10)
				local var_497_13 = var_497_11 <= 0 and var_497_7 or var_497_7 * (var_497_12 / var_497_11)

				if var_497_13 > 0 and var_497_7 < var_497_13 then
					arg_494_1.talkMaxDuration = var_497_13

					if var_497_13 + var_497_6 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_13 + var_497_6
					end
				end

				arg_494_1.text_.text = var_497_10
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011121", "story_v_out_325011.awb") ~= 0 then
					local var_497_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011121", "story_v_out_325011.awb") / 1000

					if var_497_14 + var_497_6 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_14 + var_497_6
					end

					if var_497_9.prefab_name ~= "" and arg_494_1.actors_[var_497_9.prefab_name] ~= nil then
						local var_497_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_9.prefab_name].transform, "story_v_out_325011", "325011121", "story_v_out_325011.awb")

						arg_494_1:RecordAudio("325011121", var_497_15)
						arg_494_1:RecordAudio("325011121", var_497_15)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_325011", "325011121", "story_v_out_325011.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_325011", "325011121", "story_v_out_325011.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_16 = math.max(var_497_7, arg_494_1.talkMaxDuration)

			if var_497_6 <= arg_494_1.time_ and arg_494_1.time_ < var_497_6 + var_497_16 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_6) / var_497_16

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_6 + var_497_16 and arg_494_1.time_ < var_497_6 + var_497_16 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play325011122 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 325011122
		arg_498_1.duration_ = 4.2

		local var_498_0 = {
			zh = 2.766,
			ja = 4.2
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play325011123(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["1069ui_story"]
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect1069ui_story == nil then
				arg_498_1.var_.characterEffect1069ui_story = var_501_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 and not isNil(var_501_0) then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2

				if arg_498_1.var_.characterEffect1069ui_story and not isNil(var_501_0) then
					arg_498_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect1069ui_story then
				arg_498_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_501_4 = 0

			if var_501_4 < arg_498_1.time_ and arg_498_1.time_ <= var_501_4 + arg_501_0 then
				arg_498_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_501_5 = 0

			if var_501_5 < arg_498_1.time_ and arg_498_1.time_ <= var_501_5 + arg_501_0 then
				arg_498_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_501_6 = 0
			local var_501_7 = 0.325

			if var_501_6 < arg_498_1.time_ and arg_498_1.time_ <= var_501_6 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_8 = arg_498_1:FormatText(StoryNameCfg[378].name)

				arg_498_1.leftNameTxt_.text = var_501_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_9 = arg_498_1:GetWordFromCfg(325011122)
				local var_501_10 = arg_498_1:FormatText(var_501_9.content)

				arg_498_1.text_.text = var_501_10

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_11 = 13
				local var_501_12 = utf8.len(var_501_10)
				local var_501_13 = var_501_11 <= 0 and var_501_7 or var_501_7 * (var_501_12 / var_501_11)

				if var_501_13 > 0 and var_501_7 < var_501_13 then
					arg_498_1.talkMaxDuration = var_501_13

					if var_501_13 + var_501_6 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_13 + var_501_6
					end
				end

				arg_498_1.text_.text = var_501_10
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011122", "story_v_out_325011.awb") ~= 0 then
					local var_501_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011122", "story_v_out_325011.awb") / 1000

					if var_501_14 + var_501_6 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_14 + var_501_6
					end

					if var_501_9.prefab_name ~= "" and arg_498_1.actors_[var_501_9.prefab_name] ~= nil then
						local var_501_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_9.prefab_name].transform, "story_v_out_325011", "325011122", "story_v_out_325011.awb")

						arg_498_1:RecordAudio("325011122", var_501_15)
						arg_498_1:RecordAudio("325011122", var_501_15)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_325011", "325011122", "story_v_out_325011.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_325011", "325011122", "story_v_out_325011.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_16 = math.max(var_501_7, arg_498_1.talkMaxDuration)

			if var_501_6 <= arg_498_1.time_ and arg_498_1.time_ < var_501_6 + var_501_16 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_6) / var_501_16

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_6 + var_501_16 and arg_498_1.time_ < var_501_6 + var_501_16 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play325011123 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 325011123
		arg_502_1.duration_ = 15.67

		local var_502_0 = {
			zh = 8.133,
			ja = 15.666
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play325011124(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = arg_502_1.actors_["1069ui_story"]
			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.characterEffect1069ui_story == nil then
				arg_502_1.var_.characterEffect1069ui_story = var_505_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_2 = 0.200000002980232

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_2 and not isNil(var_505_0) then
				local var_505_3 = (arg_502_1.time_ - var_505_1) / var_505_2

				if arg_502_1.var_.characterEffect1069ui_story and not isNil(var_505_0) then
					local var_505_4 = Mathf.Lerp(0, 0.5, var_505_3)

					arg_502_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_502_1.var_.characterEffect1069ui_story.fillRatio = var_505_4
				end
			end

			if arg_502_1.time_ >= var_505_1 + var_505_2 and arg_502_1.time_ < var_505_1 + var_505_2 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.characterEffect1069ui_story then
				local var_505_5 = 0.5

				arg_502_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_502_1.var_.characterEffect1069ui_story.fillRatio = var_505_5
			end

			local var_505_6 = 0
			local var_505_7 = 0.825

			if var_505_6 < arg_502_1.time_ and arg_502_1.time_ <= var_505_6 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_8 = arg_502_1:FormatText(StoryNameCfg[1522].name)

				arg_502_1.leftNameTxt_.text = var_505_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_9 = arg_502_1:GetWordFromCfg(325011123)
				local var_505_10 = arg_502_1:FormatText(var_505_9.content)

				arg_502_1.text_.text = var_505_10

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_11 = 33
				local var_505_12 = utf8.len(var_505_10)
				local var_505_13 = var_505_11 <= 0 and var_505_7 or var_505_7 * (var_505_12 / var_505_11)

				if var_505_13 > 0 and var_505_7 < var_505_13 then
					arg_502_1.talkMaxDuration = var_505_13

					if var_505_13 + var_505_6 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_13 + var_505_6
					end
				end

				arg_502_1.text_.text = var_505_10
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011123", "story_v_out_325011.awb") ~= 0 then
					local var_505_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011123", "story_v_out_325011.awb") / 1000

					if var_505_14 + var_505_6 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_14 + var_505_6
					end

					if var_505_9.prefab_name ~= "" and arg_502_1.actors_[var_505_9.prefab_name] ~= nil then
						local var_505_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_9.prefab_name].transform, "story_v_out_325011", "325011123", "story_v_out_325011.awb")

						arg_502_1:RecordAudio("325011123", var_505_15)
						arg_502_1:RecordAudio("325011123", var_505_15)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_325011", "325011123", "story_v_out_325011.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_325011", "325011123", "story_v_out_325011.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_16 = math.max(var_505_7, arg_502_1.talkMaxDuration)

			if var_505_6 <= arg_502_1.time_ and arg_502_1.time_ < var_505_6 + var_505_16 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_6) / var_505_16

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_6 + var_505_16 and arg_502_1.time_ < var_505_6 + var_505_16 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play325011124 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 325011124
		arg_506_1.duration_ = 5.13

		local var_506_0 = {
			zh = 4.766,
			ja = 5.133
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play325011125(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["1069ui_story"].transform
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 then
				arg_506_1.var_.moveOldPos1069ui_story = var_509_0.localPosition
			end

			local var_509_2 = 0.001

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_2 then
				local var_509_3 = (arg_506_1.time_ - var_509_1) / var_509_2
				local var_509_4 = Vector3.New(-0.7, -1, -6)

				var_509_0.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1069ui_story, var_509_4, var_509_3)

				local var_509_5 = manager.ui.mainCamera.transform.position - var_509_0.position

				var_509_0.forward = Vector3.New(var_509_5.x, var_509_5.y, var_509_5.z)

				local var_509_6 = var_509_0.localEulerAngles

				var_509_6.z = 0
				var_509_6.x = 0
				var_509_0.localEulerAngles = var_509_6
			end

			if arg_506_1.time_ >= var_509_1 + var_509_2 and arg_506_1.time_ < var_509_1 + var_509_2 + arg_509_0 then
				var_509_0.localPosition = Vector3.New(-0.7, -1, -6)

				local var_509_7 = manager.ui.mainCamera.transform.position - var_509_0.position

				var_509_0.forward = Vector3.New(var_509_7.x, var_509_7.y, var_509_7.z)

				local var_509_8 = var_509_0.localEulerAngles

				var_509_8.z = 0
				var_509_8.x = 0
				var_509_0.localEulerAngles = var_509_8
			end

			local var_509_9 = arg_506_1.actors_["1077ui_story"].transform
			local var_509_10 = 0

			if var_509_10 < arg_506_1.time_ and arg_506_1.time_ <= var_509_10 + arg_509_0 then
				arg_506_1.var_.moveOldPos1077ui_story = var_509_9.localPosition

				local var_509_11 = GameObjectTools.GetOrAddComponent(var_509_9.gameObject, typeof(DynamicBoneHelper))

				if var_509_11 then
					var_509_11:EnableDynamicBone(false)
				end
			end

			local var_509_12 = 0.001

			if var_509_10 <= arg_506_1.time_ and arg_506_1.time_ < var_509_10 + var_509_12 then
				local var_509_13 = (arg_506_1.time_ - var_509_10) / var_509_12
				local var_509_14 = Vector3.New(0.8, -1.02, -5.92)

				var_509_9.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1077ui_story, var_509_14, var_509_13)

				local var_509_15 = manager.ui.mainCamera.transform.position - var_509_9.position

				var_509_9.forward = Vector3.New(var_509_15.x, var_509_15.y, var_509_15.z)

				local var_509_16 = var_509_9.localEulerAngles

				var_509_16.z = 0
				var_509_16.x = 0
				var_509_9.localEulerAngles = var_509_16
			end

			if arg_506_1.time_ >= var_509_10 + var_509_12 and arg_506_1.time_ < var_509_10 + var_509_12 + arg_509_0 then
				var_509_9.localPosition = Vector3.New(0.8, -1.02, -5.92)

				local var_509_17 = manager.ui.mainCamera.transform.position - var_509_9.position

				var_509_9.forward = Vector3.New(var_509_17.x, var_509_17.y, var_509_17.z)

				local var_509_18 = var_509_9.localEulerAngles

				var_509_18.z = 0
				var_509_18.x = 0
				var_509_9.localEulerAngles = var_509_18

				local var_509_19 = GameObjectTools.GetOrAddComponent(var_509_9.gameObject, typeof(DynamicBoneHelper))

				if var_509_19 then
					var_509_19:EnableDynamicBone(true)
				end
			end

			local var_509_20 = arg_506_1.actors_["1077ui_story"]
			local var_509_21 = 0

			if var_509_21 < arg_506_1.time_ and arg_506_1.time_ <= var_509_21 + arg_509_0 and not isNil(var_509_20) and arg_506_1.var_.characterEffect1077ui_story == nil then
				arg_506_1.var_.characterEffect1077ui_story = var_509_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_22 = 0.200000002980232

			if var_509_21 <= arg_506_1.time_ and arg_506_1.time_ < var_509_21 + var_509_22 and not isNil(var_509_20) then
				local var_509_23 = (arg_506_1.time_ - var_509_21) / var_509_22

				if arg_506_1.var_.characterEffect1077ui_story and not isNil(var_509_20) then
					arg_506_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= var_509_21 + var_509_22 and arg_506_1.time_ < var_509_21 + var_509_22 + arg_509_0 and not isNil(var_509_20) and arg_506_1.var_.characterEffect1077ui_story then
				arg_506_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_509_24 = 0

			if var_509_24 < arg_506_1.time_ and arg_506_1.time_ <= var_509_24 + arg_509_0 then
				arg_506_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			local var_509_25 = 0
			local var_509_26 = 0.65

			if var_509_25 < arg_506_1.time_ and arg_506_1.time_ <= var_509_25 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_27 = arg_506_1:FormatText(StoryNameCfg[1467].name)

				arg_506_1.leftNameTxt_.text = var_509_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_28 = arg_506_1:GetWordFromCfg(325011124)
				local var_509_29 = arg_506_1:FormatText(var_509_28.content)

				arg_506_1.text_.text = var_509_29

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_30 = 26
				local var_509_31 = utf8.len(var_509_29)
				local var_509_32 = var_509_30 <= 0 and var_509_26 or var_509_26 * (var_509_31 / var_509_30)

				if var_509_32 > 0 and var_509_26 < var_509_32 then
					arg_506_1.talkMaxDuration = var_509_32

					if var_509_32 + var_509_25 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_32 + var_509_25
					end
				end

				arg_506_1.text_.text = var_509_29
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011124", "story_v_out_325011.awb") ~= 0 then
					local var_509_33 = manager.audio:GetVoiceLength("story_v_out_325011", "325011124", "story_v_out_325011.awb") / 1000

					if var_509_33 + var_509_25 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_33 + var_509_25
					end

					if var_509_28.prefab_name ~= "" and arg_506_1.actors_[var_509_28.prefab_name] ~= nil then
						local var_509_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_28.prefab_name].transform, "story_v_out_325011", "325011124", "story_v_out_325011.awb")

						arg_506_1:RecordAudio("325011124", var_509_34)
						arg_506_1:RecordAudio("325011124", var_509_34)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_325011", "325011124", "story_v_out_325011.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_325011", "325011124", "story_v_out_325011.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_35 = math.max(var_509_26, arg_506_1.talkMaxDuration)

			if var_509_25 <= arg_506_1.time_ and arg_506_1.time_ < var_509_25 + var_509_35 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_25) / var_509_35

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_25 + var_509_35 and arg_506_1.time_ < var_509_25 + var_509_35 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_506_1:InitPlayNodeList()
	end,
	Play325011125 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 325011125
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play325011126(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["1077ui_story"]
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect1077ui_story == nil then
				arg_510_1.var_.characterEffect1077ui_story = var_513_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_2 = 0.200000002980232

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 and not isNil(var_513_0) then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2

				if arg_510_1.var_.characterEffect1077ui_story and not isNil(var_513_0) then
					local var_513_4 = Mathf.Lerp(0, 0.5, var_513_3)

					arg_510_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_510_1.var_.characterEffect1077ui_story.fillRatio = var_513_4
				end
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect1077ui_story then
				local var_513_5 = 0.5

				arg_510_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_510_1.var_.characterEffect1077ui_story.fillRatio = var_513_5
			end

			local var_513_6 = 0
			local var_513_7 = 0.9

			if var_513_6 < arg_510_1.time_ and arg_510_1.time_ <= var_513_6 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_8 = arg_510_1:GetWordFromCfg(325011125)
				local var_513_9 = arg_510_1:FormatText(var_513_8.content)

				arg_510_1.text_.text = var_513_9

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_10 = 36
				local var_513_11 = utf8.len(var_513_9)
				local var_513_12 = var_513_10 <= 0 and var_513_7 or var_513_7 * (var_513_11 / var_513_10)

				if var_513_12 > 0 and var_513_7 < var_513_12 then
					arg_510_1.talkMaxDuration = var_513_12

					if var_513_12 + var_513_6 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_12 + var_513_6
					end
				end

				arg_510_1.text_.text = var_513_9
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_13 = math.max(var_513_7, arg_510_1.talkMaxDuration)

			if var_513_6 <= arg_510_1.time_ and arg_510_1.time_ < var_513_6 + var_513_13 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_6) / var_513_13

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_6 + var_513_13 and arg_510_1.time_ < var_513_6 + var_513_13 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play325011126 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 325011126
		arg_514_1.duration_ = 4.9

		local var_514_0 = {
			zh = 4.766,
			ja = 4.9
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play325011127(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["1069ui_story"]
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect1069ui_story == nil then
				arg_514_1.var_.characterEffect1069ui_story = var_517_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_2 = 0.200000002980232

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_2 and not isNil(var_517_0) then
				local var_517_3 = (arg_514_1.time_ - var_517_1) / var_517_2

				if arg_514_1.var_.characterEffect1069ui_story and not isNil(var_517_0) then
					arg_514_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= var_517_1 + var_517_2 and arg_514_1.time_ < var_517_1 + var_517_2 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect1069ui_story then
				arg_514_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_517_4 = 0
			local var_517_5 = 0.625

			if var_517_4 < arg_514_1.time_ and arg_514_1.time_ <= var_517_4 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_6 = arg_514_1:FormatText(StoryNameCfg[378].name)

				arg_514_1.leftNameTxt_.text = var_517_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_7 = arg_514_1:GetWordFromCfg(325011126)
				local var_517_8 = arg_514_1:FormatText(var_517_7.content)

				arg_514_1.text_.text = var_517_8

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_9 = 25
				local var_517_10 = utf8.len(var_517_8)
				local var_517_11 = var_517_9 <= 0 and var_517_5 or var_517_5 * (var_517_10 / var_517_9)

				if var_517_11 > 0 and var_517_5 < var_517_11 then
					arg_514_1.talkMaxDuration = var_517_11

					if var_517_11 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_11 + var_517_4
					end
				end

				arg_514_1.text_.text = var_517_8
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011126", "story_v_out_325011.awb") ~= 0 then
					local var_517_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011126", "story_v_out_325011.awb") / 1000

					if var_517_12 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_12 + var_517_4
					end

					if var_517_7.prefab_name ~= "" and arg_514_1.actors_[var_517_7.prefab_name] ~= nil then
						local var_517_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_7.prefab_name].transform, "story_v_out_325011", "325011126", "story_v_out_325011.awb")

						arg_514_1:RecordAudio("325011126", var_517_13)
						arg_514_1:RecordAudio("325011126", var_517_13)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_325011", "325011126", "story_v_out_325011.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_325011", "325011126", "story_v_out_325011.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_14 = math.max(var_517_5, arg_514_1.talkMaxDuration)

			if var_517_4 <= arg_514_1.time_ and arg_514_1.time_ < var_517_4 + var_517_14 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_4) / var_517_14

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_4 + var_517_14 and arg_514_1.time_ < var_517_4 + var_517_14 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play325011127 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 325011127
		arg_518_1.duration_ = 2

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play325011128(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["1077ui_story"]
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect1077ui_story == nil then
				arg_518_1.var_.characterEffect1077ui_story = var_521_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_2 = 0.200000002980232

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_2 and not isNil(var_521_0) then
				local var_521_3 = (arg_518_1.time_ - var_521_1) / var_521_2

				if arg_518_1.var_.characterEffect1077ui_story and not isNil(var_521_0) then
					arg_518_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= var_521_1 + var_521_2 and arg_518_1.time_ < var_521_1 + var_521_2 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect1077ui_story then
				arg_518_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_521_4 = arg_518_1.actors_["1069ui_story"]
			local var_521_5 = 0

			if var_521_5 < arg_518_1.time_ and arg_518_1.time_ <= var_521_5 + arg_521_0 and not isNil(var_521_4) and arg_518_1.var_.characterEffect1069ui_story == nil then
				arg_518_1.var_.characterEffect1069ui_story = var_521_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_6 = 0.200000002980232

			if var_521_5 <= arg_518_1.time_ and arg_518_1.time_ < var_521_5 + var_521_6 and not isNil(var_521_4) then
				local var_521_7 = (arg_518_1.time_ - var_521_5) / var_521_6

				if arg_518_1.var_.characterEffect1069ui_story and not isNil(var_521_4) then
					local var_521_8 = Mathf.Lerp(0, 0.5, var_521_7)

					arg_518_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1069ui_story.fillRatio = var_521_8
				end
			end

			if arg_518_1.time_ >= var_521_5 + var_521_6 and arg_518_1.time_ < var_521_5 + var_521_6 + arg_521_0 and not isNil(var_521_4) and arg_518_1.var_.characterEffect1069ui_story then
				local var_521_9 = 0.5

				arg_518_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1069ui_story.fillRatio = var_521_9
			end

			local var_521_10 = 0

			if var_521_10 < arg_518_1.time_ and arg_518_1.time_ <= var_521_10 + arg_521_0 then
				arg_518_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			local var_521_11 = 0

			if var_521_11 < arg_518_1.time_ and arg_518_1.time_ <= var_521_11 + arg_521_0 then
				arg_518_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_521_12 = 0
			local var_521_13 = 0.15

			if var_521_12 < arg_518_1.time_ and arg_518_1.time_ <= var_521_12 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_14 = arg_518_1:FormatText(StoryNameCfg[1467].name)

				arg_518_1.leftNameTxt_.text = var_521_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_15 = arg_518_1:GetWordFromCfg(325011127)
				local var_521_16 = arg_518_1:FormatText(var_521_15.content)

				arg_518_1.text_.text = var_521_16

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_17 = 6
				local var_521_18 = utf8.len(var_521_16)
				local var_521_19 = var_521_17 <= 0 and var_521_13 or var_521_13 * (var_521_18 / var_521_17)

				if var_521_19 > 0 and var_521_13 < var_521_19 then
					arg_518_1.talkMaxDuration = var_521_19

					if var_521_19 + var_521_12 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_19 + var_521_12
					end
				end

				arg_518_1.text_.text = var_521_16
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011127", "story_v_out_325011.awb") ~= 0 then
					local var_521_20 = manager.audio:GetVoiceLength("story_v_out_325011", "325011127", "story_v_out_325011.awb") / 1000

					if var_521_20 + var_521_12 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_20 + var_521_12
					end

					if var_521_15.prefab_name ~= "" and arg_518_1.actors_[var_521_15.prefab_name] ~= nil then
						local var_521_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_15.prefab_name].transform, "story_v_out_325011", "325011127", "story_v_out_325011.awb")

						arg_518_1:RecordAudio("325011127", var_521_21)
						arg_518_1:RecordAudio("325011127", var_521_21)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_325011", "325011127", "story_v_out_325011.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_325011", "325011127", "story_v_out_325011.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_22 = math.max(var_521_13, arg_518_1.talkMaxDuration)

			if var_521_12 <= arg_518_1.time_ and arg_518_1.time_ < var_521_12 + var_521_22 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_12) / var_521_22

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_12 + var_521_22 and arg_518_1.time_ < var_521_12 + var_521_22 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play325011128 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 325011128
		arg_522_1.duration_ = 3.1

		local var_522_0 = {
			zh = 2.4,
			ja = 3.1
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play325011129(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["1069ui_story"]
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.characterEffect1069ui_story == nil then
				arg_522_1.var_.characterEffect1069ui_story = var_525_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_2 = 0.200000002980232

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_2 and not isNil(var_525_0) then
				local var_525_3 = (arg_522_1.time_ - var_525_1) / var_525_2

				if arg_522_1.var_.characterEffect1069ui_story and not isNil(var_525_0) then
					arg_522_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= var_525_1 + var_525_2 and arg_522_1.time_ < var_525_1 + var_525_2 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.characterEffect1069ui_story then
				arg_522_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_525_4 = arg_522_1.actors_["1077ui_story"]
			local var_525_5 = 0

			if var_525_5 < arg_522_1.time_ and arg_522_1.time_ <= var_525_5 + arg_525_0 and not isNil(var_525_4) and arg_522_1.var_.characterEffect1077ui_story == nil then
				arg_522_1.var_.characterEffect1077ui_story = var_525_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_6 = 0.200000002980232

			if var_525_5 <= arg_522_1.time_ and arg_522_1.time_ < var_525_5 + var_525_6 and not isNil(var_525_4) then
				local var_525_7 = (arg_522_1.time_ - var_525_5) / var_525_6

				if arg_522_1.var_.characterEffect1077ui_story and not isNil(var_525_4) then
					local var_525_8 = Mathf.Lerp(0, 0.5, var_525_7)

					arg_522_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_522_1.var_.characterEffect1077ui_story.fillRatio = var_525_8
				end
			end

			if arg_522_1.time_ >= var_525_5 + var_525_6 and arg_522_1.time_ < var_525_5 + var_525_6 + arg_525_0 and not isNil(var_525_4) and arg_522_1.var_.characterEffect1077ui_story then
				local var_525_9 = 0.5

				arg_522_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_522_1.var_.characterEffect1077ui_story.fillRatio = var_525_9
			end

			local var_525_10 = 0

			if var_525_10 < arg_522_1.time_ and arg_522_1.time_ <= var_525_10 + arg_525_0 then
				arg_522_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action3_1")
			end

			local var_525_11 = 0

			if var_525_11 < arg_522_1.time_ and arg_522_1.time_ <= var_525_11 + arg_525_0 then
				arg_522_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_525_12 = 0
			local var_525_13 = 0.225

			if var_525_12 < arg_522_1.time_ and arg_522_1.time_ <= var_525_12 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_14 = arg_522_1:FormatText(StoryNameCfg[378].name)

				arg_522_1.leftNameTxt_.text = var_525_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_15 = arg_522_1:GetWordFromCfg(325011128)
				local var_525_16 = arg_522_1:FormatText(var_525_15.content)

				arg_522_1.text_.text = var_525_16

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_17 = 9
				local var_525_18 = utf8.len(var_525_16)
				local var_525_19 = var_525_17 <= 0 and var_525_13 or var_525_13 * (var_525_18 / var_525_17)

				if var_525_19 > 0 and var_525_13 < var_525_19 then
					arg_522_1.talkMaxDuration = var_525_19

					if var_525_19 + var_525_12 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_19 + var_525_12
					end
				end

				arg_522_1.text_.text = var_525_16
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011128", "story_v_out_325011.awb") ~= 0 then
					local var_525_20 = manager.audio:GetVoiceLength("story_v_out_325011", "325011128", "story_v_out_325011.awb") / 1000

					if var_525_20 + var_525_12 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_20 + var_525_12
					end

					if var_525_15.prefab_name ~= "" and arg_522_1.actors_[var_525_15.prefab_name] ~= nil then
						local var_525_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_15.prefab_name].transform, "story_v_out_325011", "325011128", "story_v_out_325011.awb")

						arg_522_1:RecordAudio("325011128", var_525_21)
						arg_522_1:RecordAudio("325011128", var_525_21)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_325011", "325011128", "story_v_out_325011.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_325011", "325011128", "story_v_out_325011.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_22 = math.max(var_525_13, arg_522_1.talkMaxDuration)

			if var_525_12 <= arg_522_1.time_ and arg_522_1.time_ < var_525_12 + var_525_22 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_12) / var_525_22

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_12 + var_525_22 and arg_522_1.time_ < var_525_12 + var_525_22 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play325011129 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 325011129
		arg_526_1.duration_ = 2.77

		local var_526_0 = {
			zh = 1.833,
			ja = 2.766
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play325011130(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = arg_526_1.actors_["1077ui_story"]
			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.characterEffect1077ui_story == nil then
				arg_526_1.var_.characterEffect1077ui_story = var_529_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_2 = 0.200000002980232

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_2 and not isNil(var_529_0) then
				local var_529_3 = (arg_526_1.time_ - var_529_1) / var_529_2

				if arg_526_1.var_.characterEffect1077ui_story and not isNil(var_529_0) then
					arg_526_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= var_529_1 + var_529_2 and arg_526_1.time_ < var_529_1 + var_529_2 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.characterEffect1077ui_story then
				arg_526_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_529_4 = arg_526_1.actors_["1069ui_story"]
			local var_529_5 = 0

			if var_529_5 < arg_526_1.time_ and arg_526_1.time_ <= var_529_5 + arg_529_0 and not isNil(var_529_4) and arg_526_1.var_.characterEffect1069ui_story == nil then
				arg_526_1.var_.characterEffect1069ui_story = var_529_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_6 = 0.200000002980232

			if var_529_5 <= arg_526_1.time_ and arg_526_1.time_ < var_529_5 + var_529_6 and not isNil(var_529_4) then
				local var_529_7 = (arg_526_1.time_ - var_529_5) / var_529_6

				if arg_526_1.var_.characterEffect1069ui_story and not isNil(var_529_4) then
					local var_529_8 = Mathf.Lerp(0, 0.5, var_529_7)

					arg_526_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_526_1.var_.characterEffect1069ui_story.fillRatio = var_529_8
				end
			end

			if arg_526_1.time_ >= var_529_5 + var_529_6 and arg_526_1.time_ < var_529_5 + var_529_6 + arg_529_0 and not isNil(var_529_4) and arg_526_1.var_.characterEffect1069ui_story then
				local var_529_9 = 0.5

				arg_526_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_526_1.var_.characterEffect1069ui_story.fillRatio = var_529_9
			end

			local var_529_10 = 0
			local var_529_11 = 0.125

			if var_529_10 < arg_526_1.time_ and arg_526_1.time_ <= var_529_10 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_12 = arg_526_1:FormatText(StoryNameCfg[1467].name)

				arg_526_1.leftNameTxt_.text = var_529_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_13 = arg_526_1:GetWordFromCfg(325011129)
				local var_529_14 = arg_526_1:FormatText(var_529_13.content)

				arg_526_1.text_.text = var_529_14

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_15 = 5
				local var_529_16 = utf8.len(var_529_14)
				local var_529_17 = var_529_15 <= 0 and var_529_11 or var_529_11 * (var_529_16 / var_529_15)

				if var_529_17 > 0 and var_529_11 < var_529_17 then
					arg_526_1.talkMaxDuration = var_529_17

					if var_529_17 + var_529_10 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_17 + var_529_10
					end
				end

				arg_526_1.text_.text = var_529_14
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011129", "story_v_out_325011.awb") ~= 0 then
					local var_529_18 = manager.audio:GetVoiceLength("story_v_out_325011", "325011129", "story_v_out_325011.awb") / 1000

					if var_529_18 + var_529_10 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_18 + var_529_10
					end

					if var_529_13.prefab_name ~= "" and arg_526_1.actors_[var_529_13.prefab_name] ~= nil then
						local var_529_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_13.prefab_name].transform, "story_v_out_325011", "325011129", "story_v_out_325011.awb")

						arg_526_1:RecordAudio("325011129", var_529_19)
						arg_526_1:RecordAudio("325011129", var_529_19)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_out_325011", "325011129", "story_v_out_325011.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_out_325011", "325011129", "story_v_out_325011.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_20 = math.max(var_529_11, arg_526_1.talkMaxDuration)

			if var_529_10 <= arg_526_1.time_ and arg_526_1.time_ < var_529_10 + var_529_20 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_10) / var_529_20

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_10 + var_529_20 and arg_526_1.time_ < var_529_10 + var_529_20 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play325011130 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 325011130
		arg_530_1.duration_ = 7.97

		local var_530_0 = {
			zh = 4.633,
			ja = 7.966
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play325011131(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["1069ui_story"]
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect1069ui_story == nil then
				arg_530_1.var_.characterEffect1069ui_story = var_533_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_2 = 0.200000002980232

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_2 and not isNil(var_533_0) then
				local var_533_3 = (arg_530_1.time_ - var_533_1) / var_533_2

				if arg_530_1.var_.characterEffect1069ui_story and not isNil(var_533_0) then
					arg_530_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_530_1.time_ >= var_533_1 + var_533_2 and arg_530_1.time_ < var_533_1 + var_533_2 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect1069ui_story then
				arg_530_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_533_4 = arg_530_1.actors_["1077ui_story"]
			local var_533_5 = 0

			if var_533_5 < arg_530_1.time_ and arg_530_1.time_ <= var_533_5 + arg_533_0 and not isNil(var_533_4) and arg_530_1.var_.characterEffect1077ui_story == nil then
				arg_530_1.var_.characterEffect1077ui_story = var_533_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_6 = 0.200000002980232

			if var_533_5 <= arg_530_1.time_ and arg_530_1.time_ < var_533_5 + var_533_6 and not isNil(var_533_4) then
				local var_533_7 = (arg_530_1.time_ - var_533_5) / var_533_6

				if arg_530_1.var_.characterEffect1077ui_story and not isNil(var_533_4) then
					local var_533_8 = Mathf.Lerp(0, 0.5, var_533_7)

					arg_530_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_530_1.var_.characterEffect1077ui_story.fillRatio = var_533_8
				end
			end

			if arg_530_1.time_ >= var_533_5 + var_533_6 and arg_530_1.time_ < var_533_5 + var_533_6 + arg_533_0 and not isNil(var_533_4) and arg_530_1.var_.characterEffect1077ui_story then
				local var_533_9 = 0.5

				arg_530_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_530_1.var_.characterEffect1077ui_story.fillRatio = var_533_9
			end

			local var_533_10 = 0
			local var_533_11 = 0.7

			if var_533_10 < arg_530_1.time_ and arg_530_1.time_ <= var_533_10 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_12 = arg_530_1:FormatText(StoryNameCfg[378].name)

				arg_530_1.leftNameTxt_.text = var_533_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_13 = arg_530_1:GetWordFromCfg(325011130)
				local var_533_14 = arg_530_1:FormatText(var_533_13.content)

				arg_530_1.text_.text = var_533_14

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_15 = 28
				local var_533_16 = utf8.len(var_533_14)
				local var_533_17 = var_533_15 <= 0 and var_533_11 or var_533_11 * (var_533_16 / var_533_15)

				if var_533_17 > 0 and var_533_11 < var_533_17 then
					arg_530_1.talkMaxDuration = var_533_17

					if var_533_17 + var_533_10 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_17 + var_533_10
					end
				end

				arg_530_1.text_.text = var_533_14
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011130", "story_v_out_325011.awb") ~= 0 then
					local var_533_18 = manager.audio:GetVoiceLength("story_v_out_325011", "325011130", "story_v_out_325011.awb") / 1000

					if var_533_18 + var_533_10 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_18 + var_533_10
					end

					if var_533_13.prefab_name ~= "" and arg_530_1.actors_[var_533_13.prefab_name] ~= nil then
						local var_533_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_13.prefab_name].transform, "story_v_out_325011", "325011130", "story_v_out_325011.awb")

						arg_530_1:RecordAudio("325011130", var_533_19)
						arg_530_1:RecordAudio("325011130", var_533_19)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_325011", "325011130", "story_v_out_325011.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_325011", "325011130", "story_v_out_325011.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_20 = math.max(var_533_11, arg_530_1.talkMaxDuration)

			if var_533_10 <= arg_530_1.time_ and arg_530_1.time_ < var_533_10 + var_533_20 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_10) / var_533_20

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_10 + var_533_20 and arg_530_1.time_ < var_533_10 + var_533_20 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play325011131 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 325011131
		arg_534_1.duration_ = 5

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play325011132(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = arg_534_1.actors_["1069ui_story"]
			local var_537_1 = 0

			if var_537_1 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect1069ui_story == nil then
				arg_534_1.var_.characterEffect1069ui_story = var_537_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_2 = 0.200000002980232

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_2 and not isNil(var_537_0) then
				local var_537_3 = (arg_534_1.time_ - var_537_1) / var_537_2

				if arg_534_1.var_.characterEffect1069ui_story and not isNil(var_537_0) then
					local var_537_4 = Mathf.Lerp(0, 0.5, var_537_3)

					arg_534_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_534_1.var_.characterEffect1069ui_story.fillRatio = var_537_4
				end
			end

			if arg_534_1.time_ >= var_537_1 + var_537_2 and arg_534_1.time_ < var_537_1 + var_537_2 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect1069ui_story then
				local var_537_5 = 0.5

				arg_534_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_534_1.var_.characterEffect1069ui_story.fillRatio = var_537_5
			end

			local var_537_6 = 0
			local var_537_7 = 0.875

			if var_537_6 < arg_534_1.time_ and arg_534_1.time_ <= var_537_6 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, false)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_8 = arg_534_1:GetWordFromCfg(325011131)
				local var_537_9 = arg_534_1:FormatText(var_537_8.content)

				arg_534_1.text_.text = var_537_9

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_10 = 35
				local var_537_11 = utf8.len(var_537_9)
				local var_537_12 = var_537_10 <= 0 and var_537_7 or var_537_7 * (var_537_11 / var_537_10)

				if var_537_12 > 0 and var_537_7 < var_537_12 then
					arg_534_1.talkMaxDuration = var_537_12

					if var_537_12 + var_537_6 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_12 + var_537_6
					end
				end

				arg_534_1.text_.text = var_537_9
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_13 = math.max(var_537_7, arg_534_1.talkMaxDuration)

			if var_537_6 <= arg_534_1.time_ and arg_534_1.time_ < var_537_6 + var_537_13 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_6) / var_537_13

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_6 + var_537_13 and arg_534_1.time_ < var_537_6 + var_537_13 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play325011132 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 325011132
		arg_538_1.duration_ = 6.9

		local var_538_0 = {
			zh = 4.633,
			ja = 6.9
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play325011133(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = 0
			local var_541_1 = 0.4

			if var_541_0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_0 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_2 = arg_538_1:FormatText(StoryNameCfg[1522].name)

				arg_538_1.leftNameTxt_.text = var_541_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, true)
				arg_538_1.iconController_:SetSelectedState("hero")

				arg_538_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_538_1.callingController_:SetSelectedState("normal")

				arg_538_1.keyicon_.color = Color.New(1, 1, 1)
				arg_538_1.icon_.color = Color.New(1, 1, 1)

				local var_541_3 = arg_538_1:GetWordFromCfg(325011132)
				local var_541_4 = arg_538_1:FormatText(var_541_3.content)

				arg_538_1.text_.text = var_541_4

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_5 = 16
				local var_541_6 = utf8.len(var_541_4)
				local var_541_7 = var_541_5 <= 0 and var_541_1 or var_541_1 * (var_541_6 / var_541_5)

				if var_541_7 > 0 and var_541_1 < var_541_7 then
					arg_538_1.talkMaxDuration = var_541_7

					if var_541_7 + var_541_0 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_7 + var_541_0
					end
				end

				arg_538_1.text_.text = var_541_4
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011132", "story_v_out_325011.awb") ~= 0 then
					local var_541_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011132", "story_v_out_325011.awb") / 1000

					if var_541_8 + var_541_0 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_8 + var_541_0
					end

					if var_541_3.prefab_name ~= "" and arg_538_1.actors_[var_541_3.prefab_name] ~= nil then
						local var_541_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_3.prefab_name].transform, "story_v_out_325011", "325011132", "story_v_out_325011.awb")

						arg_538_1:RecordAudio("325011132", var_541_9)
						arg_538_1:RecordAudio("325011132", var_541_9)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_out_325011", "325011132", "story_v_out_325011.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_out_325011", "325011132", "story_v_out_325011.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_10 = math.max(var_541_1, arg_538_1.talkMaxDuration)

			if var_541_0 <= arg_538_1.time_ and arg_538_1.time_ < var_541_0 + var_541_10 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_0) / var_541_10

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_0 + var_541_10 and arg_538_1.time_ < var_541_0 + var_541_10 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play325011133 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 325011133
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play325011134(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = arg_542_1.actors_["1077ui_story"].transform
			local var_545_1 = 0

			if var_545_1 < arg_542_1.time_ and arg_542_1.time_ <= var_545_1 + arg_545_0 then
				arg_542_1.var_.moveOldPos1077ui_story = var_545_0.localPosition

				local var_545_2 = GameObjectTools.GetOrAddComponent(var_545_0.gameObject, typeof(DynamicBoneHelper))

				if var_545_2 then
					var_545_2:EnableDynamicBone(false)
				end
			end

			local var_545_3 = 0.001

			if var_545_1 <= arg_542_1.time_ and arg_542_1.time_ < var_545_1 + var_545_3 then
				local var_545_4 = (arg_542_1.time_ - var_545_1) / var_545_3
				local var_545_5 = Vector3.New(0, 100, 0)

				var_545_0.localPosition = Vector3.Lerp(arg_542_1.var_.moveOldPos1077ui_story, var_545_5, var_545_4)

				local var_545_6 = manager.ui.mainCamera.transform.position - var_545_0.position

				var_545_0.forward = Vector3.New(var_545_6.x, var_545_6.y, var_545_6.z)

				local var_545_7 = var_545_0.localEulerAngles

				var_545_7.z = 0
				var_545_7.x = 0
				var_545_0.localEulerAngles = var_545_7
			end

			if arg_542_1.time_ >= var_545_1 + var_545_3 and arg_542_1.time_ < var_545_1 + var_545_3 + arg_545_0 then
				var_545_0.localPosition = Vector3.New(0, 100, 0)

				local var_545_8 = manager.ui.mainCamera.transform.position - var_545_0.position

				var_545_0.forward = Vector3.New(var_545_8.x, var_545_8.y, var_545_8.z)

				local var_545_9 = var_545_0.localEulerAngles

				var_545_9.z = 0
				var_545_9.x = 0
				var_545_0.localEulerAngles = var_545_9

				local var_545_10 = GameObjectTools.GetOrAddComponent(var_545_0.gameObject, typeof(DynamicBoneHelper))

				if var_545_10 then
					var_545_10:EnableDynamicBone(true)
				end
			end

			local var_545_11 = arg_542_1.actors_["1069ui_story"].transform
			local var_545_12 = 0

			if var_545_12 < arg_542_1.time_ and arg_542_1.time_ <= var_545_12 + arg_545_0 then
				arg_542_1.var_.moveOldPos1069ui_story = var_545_11.localPosition
			end

			local var_545_13 = 0.001

			if var_545_12 <= arg_542_1.time_ and arg_542_1.time_ < var_545_12 + var_545_13 then
				local var_545_14 = (arg_542_1.time_ - var_545_12) / var_545_13
				local var_545_15 = Vector3.New(0, 100, 0)

				var_545_11.localPosition = Vector3.Lerp(arg_542_1.var_.moveOldPos1069ui_story, var_545_15, var_545_14)

				local var_545_16 = manager.ui.mainCamera.transform.position - var_545_11.position

				var_545_11.forward = Vector3.New(var_545_16.x, var_545_16.y, var_545_16.z)

				local var_545_17 = var_545_11.localEulerAngles

				var_545_17.z = 0
				var_545_17.x = 0
				var_545_11.localEulerAngles = var_545_17
			end

			if arg_542_1.time_ >= var_545_12 + var_545_13 and arg_542_1.time_ < var_545_12 + var_545_13 + arg_545_0 then
				var_545_11.localPosition = Vector3.New(0, 100, 0)

				local var_545_18 = manager.ui.mainCamera.transform.position - var_545_11.position

				var_545_11.forward = Vector3.New(var_545_18.x, var_545_18.y, var_545_18.z)

				local var_545_19 = var_545_11.localEulerAngles

				var_545_19.z = 0
				var_545_19.x = 0
				var_545_11.localEulerAngles = var_545_19
			end

			local var_545_20 = 0
			local var_545_21 = 0.825

			if var_545_20 < arg_542_1.time_ and arg_542_1.time_ <= var_545_20 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, false)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_22 = arg_542_1:GetWordFromCfg(325011133)
				local var_545_23 = arg_542_1:FormatText(var_545_22.content)

				arg_542_1.text_.text = var_545_23

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_24 = 33
				local var_545_25 = utf8.len(var_545_23)
				local var_545_26 = var_545_24 <= 0 and var_545_21 or var_545_21 * (var_545_25 / var_545_24)

				if var_545_26 > 0 and var_545_21 < var_545_26 then
					arg_542_1.talkMaxDuration = var_545_26

					if var_545_26 + var_545_20 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_26 + var_545_20
					end
				end

				arg_542_1.text_.text = var_545_23
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_27 = math.max(var_545_21, arg_542_1.talkMaxDuration)

			if var_545_20 <= arg_542_1.time_ and arg_542_1.time_ < var_545_20 + var_545_27 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_20) / var_545_27

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_20 + var_545_27 and arg_542_1.time_ < var_545_20 + var_545_27 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_542_1:InitPlayNodeList()
	end,
	Play325011134 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 325011134
		arg_546_1.duration_ = 4.37

		local var_546_0 = {
			zh = 4.2,
			ja = 4.366
		}
		local var_546_1 = manager.audio:GetLocalizationFlag()

		if var_546_0[var_546_1] ~= nil then
			arg_546_1.duration_ = var_546_0[var_546_1]
		end

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play325011135(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0
			local var_549_1 = 0.475

			if var_549_0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				local var_549_2 = arg_546_1:FormatText(StoryNameCfg[1523].name)

				arg_546_1.leftNameTxt_.text = var_549_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, true)
				arg_546_1.iconController_:SetSelectedState("hero")

				arg_546_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_546_1.callingController_:SetSelectedState("normal")

				arg_546_1.keyicon_.color = Color.New(1, 1, 1)
				arg_546_1.icon_.color = Color.New(1, 1, 1)

				local var_549_3 = arg_546_1:GetWordFromCfg(325011134)
				local var_549_4 = arg_546_1:FormatText(var_549_3.content)

				arg_546_1.text_.text = var_549_4

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_5 = 19
				local var_549_6 = utf8.len(var_549_4)
				local var_549_7 = var_549_5 <= 0 and var_549_1 or var_549_1 * (var_549_6 / var_549_5)

				if var_549_7 > 0 and var_549_1 < var_549_7 then
					arg_546_1.talkMaxDuration = var_549_7

					if var_549_7 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_7 + var_549_0
					end
				end

				arg_546_1.text_.text = var_549_4
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011134", "story_v_out_325011.awb") ~= 0 then
					local var_549_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011134", "story_v_out_325011.awb") / 1000

					if var_549_8 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_8 + var_549_0
					end

					if var_549_3.prefab_name ~= "" and arg_546_1.actors_[var_549_3.prefab_name] ~= nil then
						local var_549_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_3.prefab_name].transform, "story_v_out_325011", "325011134", "story_v_out_325011.awb")

						arg_546_1:RecordAudio("325011134", var_549_9)
						arg_546_1:RecordAudio("325011134", var_549_9)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_out_325011", "325011134", "story_v_out_325011.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_out_325011", "325011134", "story_v_out_325011.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_10 = math.max(var_549_1, arg_546_1.talkMaxDuration)

			if var_549_0 <= arg_546_1.time_ and arg_546_1.time_ < var_549_0 + var_549_10 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_0) / var_549_10

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_0 + var_549_10 and arg_546_1.time_ < var_549_0 + var_549_10 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play325011135 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 325011135
		arg_550_1.duration_ = 3.83

		local var_550_0 = {
			zh = 3.833,
			ja = 3.533
		}
		local var_550_1 = manager.audio:GetLocalizationFlag()

		if var_550_0[var_550_1] ~= nil then
			arg_550_1.duration_ = var_550_0[var_550_1]
		end

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play325011136(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0
			local var_553_1 = 0.375

			if var_553_0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				local var_553_2 = arg_550_1:FormatText(StoryNameCfg[1524].name)

				arg_550_1.leftNameTxt_.text = var_553_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, true)
				arg_550_1.iconController_:SetSelectedState("hero")

				arg_550_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_550_1.callingController_:SetSelectedState("normal")

				arg_550_1.keyicon_.color = Color.New(1, 1, 1)
				arg_550_1.icon_.color = Color.New(1, 1, 1)

				local var_553_3 = arg_550_1:GetWordFromCfg(325011135)
				local var_553_4 = arg_550_1:FormatText(var_553_3.content)

				arg_550_1.text_.text = var_553_4

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_5 = 15
				local var_553_6 = utf8.len(var_553_4)
				local var_553_7 = var_553_5 <= 0 and var_553_1 or var_553_1 * (var_553_6 / var_553_5)

				if var_553_7 > 0 and var_553_1 < var_553_7 then
					arg_550_1.talkMaxDuration = var_553_7

					if var_553_7 + var_553_0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_7 + var_553_0
					end
				end

				arg_550_1.text_.text = var_553_4
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011135", "story_v_out_325011.awb") ~= 0 then
					local var_553_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011135", "story_v_out_325011.awb") / 1000

					if var_553_8 + var_553_0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_8 + var_553_0
					end

					if var_553_3.prefab_name ~= "" and arg_550_1.actors_[var_553_3.prefab_name] ~= nil then
						local var_553_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_550_1.actors_[var_553_3.prefab_name].transform, "story_v_out_325011", "325011135", "story_v_out_325011.awb")

						arg_550_1:RecordAudio("325011135", var_553_9)
						arg_550_1:RecordAudio("325011135", var_553_9)
					else
						arg_550_1:AudioAction("play", "voice", "story_v_out_325011", "325011135", "story_v_out_325011.awb")
					end

					arg_550_1:RecordHistoryTalkVoice("story_v_out_325011", "325011135", "story_v_out_325011.awb")
				end

				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_10 = math.max(var_553_1, arg_550_1.talkMaxDuration)

			if var_553_0 <= arg_550_1.time_ and arg_550_1.time_ < var_553_0 + var_553_10 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_0) / var_553_10

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_0 + var_553_10 and arg_550_1.time_ < var_553_0 + var_553_10 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play325011136 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 325011136
		arg_554_1.duration_ = 9.73

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play325011137(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0
			local var_557_1 = 1.175

			if var_557_0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_2 = arg_554_1:FormatText(StoryNameCfg[1524].name)

				arg_554_1.leftNameTxt_.text = var_557_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, true)
				arg_554_1.iconController_:SetSelectedState("hero")

				arg_554_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_554_1.callingController_:SetSelectedState("normal")

				arg_554_1.keyicon_.color = Color.New(1, 1, 1)
				arg_554_1.icon_.color = Color.New(1, 1, 1)

				local var_557_3 = arg_554_1:GetWordFromCfg(325011136)
				local var_557_4 = arg_554_1:FormatText(var_557_3.content)

				arg_554_1.text_.text = var_557_4

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_5 = 47
				local var_557_6 = utf8.len(var_557_4)
				local var_557_7 = var_557_5 <= 0 and var_557_1 or var_557_1 * (var_557_6 / var_557_5)

				if var_557_7 > 0 and var_557_1 < var_557_7 then
					arg_554_1.talkMaxDuration = var_557_7

					if var_557_7 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_7 + var_557_0
					end
				end

				arg_554_1.text_.text = var_557_4
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011136", "story_v_out_325011.awb") ~= 0 then
					local var_557_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011136", "story_v_out_325011.awb") / 1000

					if var_557_8 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_8 + var_557_0
					end

					if var_557_3.prefab_name ~= "" and arg_554_1.actors_[var_557_3.prefab_name] ~= nil then
						local var_557_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_3.prefab_name].transform, "story_v_out_325011", "325011136", "story_v_out_325011.awb")

						arg_554_1:RecordAudio("325011136", var_557_9)
						arg_554_1:RecordAudio("325011136", var_557_9)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_325011", "325011136", "story_v_out_325011.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_325011", "325011136", "story_v_out_325011.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_10 = math.max(var_557_1, arg_554_1.talkMaxDuration)

			if var_557_0 <= arg_554_1.time_ and arg_554_1.time_ < var_557_0 + var_557_10 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_0) / var_557_10

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_0 + var_557_10 and arg_554_1.time_ < var_557_0 + var_557_10 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play325011137 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 325011137
		arg_558_1.duration_ = 5.23

		local var_558_0 = {
			zh = 4.666,
			ja = 5.233
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play325011138(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0
			local var_561_1 = 0.425

			if var_561_0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_2 = arg_558_1:FormatText(StoryNameCfg[1522].name)

				arg_558_1.leftNameTxt_.text = var_561_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_3 = arg_558_1:GetWordFromCfg(325011137)
				local var_561_4 = arg_558_1:FormatText(var_561_3.content)

				arg_558_1.text_.text = var_561_4

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_5 = 17
				local var_561_6 = utf8.len(var_561_4)
				local var_561_7 = var_561_5 <= 0 and var_561_1 or var_561_1 * (var_561_6 / var_561_5)

				if var_561_7 > 0 and var_561_1 < var_561_7 then
					arg_558_1.talkMaxDuration = var_561_7

					if var_561_7 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_7 + var_561_0
					end
				end

				arg_558_1.text_.text = var_561_4
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011137", "story_v_out_325011.awb") ~= 0 then
					local var_561_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011137", "story_v_out_325011.awb") / 1000

					if var_561_8 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_8 + var_561_0
					end

					if var_561_3.prefab_name ~= "" and arg_558_1.actors_[var_561_3.prefab_name] ~= nil then
						local var_561_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_3.prefab_name].transform, "story_v_out_325011", "325011137", "story_v_out_325011.awb")

						arg_558_1:RecordAudio("325011137", var_561_9)
						arg_558_1:RecordAudio("325011137", var_561_9)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_325011", "325011137", "story_v_out_325011.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_325011", "325011137", "story_v_out_325011.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_10 = math.max(var_561_1, arg_558_1.talkMaxDuration)

			if var_561_0 <= arg_558_1.time_ and arg_558_1.time_ < var_561_0 + var_561_10 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_0) / var_561_10

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_0 + var_561_10 and arg_558_1.time_ < var_561_0 + var_561_10 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play325011138 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 325011138
		arg_562_1.duration_ = 3.6

		local var_562_0 = {
			zh = 2.933,
			ja = 3.6
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play325011139(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0
			local var_565_1 = 0.3

			if var_565_0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				local var_565_2 = arg_562_1:FormatText(StoryNameCfg[1523].name)

				arg_562_1.leftNameTxt_.text = var_565_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, true)
				arg_562_1.iconController_:SetSelectedState("hero")

				arg_562_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_562_1.callingController_:SetSelectedState("normal")

				arg_562_1.keyicon_.color = Color.New(1, 1, 1)
				arg_562_1.icon_.color = Color.New(1, 1, 1)

				local var_565_3 = arg_562_1:GetWordFromCfg(325011138)
				local var_565_4 = arg_562_1:FormatText(var_565_3.content)

				arg_562_1.text_.text = var_565_4

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_5 = 12
				local var_565_6 = utf8.len(var_565_4)
				local var_565_7 = var_565_5 <= 0 and var_565_1 or var_565_1 * (var_565_6 / var_565_5)

				if var_565_7 > 0 and var_565_1 < var_565_7 then
					arg_562_1.talkMaxDuration = var_565_7

					if var_565_7 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_7 + var_565_0
					end
				end

				arg_562_1.text_.text = var_565_4
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011138", "story_v_out_325011.awb") ~= 0 then
					local var_565_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011138", "story_v_out_325011.awb") / 1000

					if var_565_8 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_8 + var_565_0
					end

					if var_565_3.prefab_name ~= "" and arg_562_1.actors_[var_565_3.prefab_name] ~= nil then
						local var_565_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_3.prefab_name].transform, "story_v_out_325011", "325011138", "story_v_out_325011.awb")

						arg_562_1:RecordAudio("325011138", var_565_9)
						arg_562_1:RecordAudio("325011138", var_565_9)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_325011", "325011138", "story_v_out_325011.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_325011", "325011138", "story_v_out_325011.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_10 = math.max(var_565_1, arg_562_1.talkMaxDuration)

			if var_565_0 <= arg_562_1.time_ and arg_562_1.time_ < var_565_0 + var_565_10 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_0) / var_565_10

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_0 + var_565_10 and arg_562_1.time_ < var_565_0 + var_565_10 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play325011139 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 325011139
		arg_566_1.duration_ = 5

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play325011140(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 0
			local var_569_1 = 1.375

			if var_569_0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_0 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, false)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_2 = arg_566_1:GetWordFromCfg(325011139)
				local var_569_3 = arg_566_1:FormatText(var_569_2.content)

				arg_566_1.text_.text = var_569_3

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_4 = 55
				local var_569_5 = utf8.len(var_569_3)
				local var_569_6 = var_569_4 <= 0 and var_569_1 or var_569_1 * (var_569_5 / var_569_4)

				if var_569_6 > 0 and var_569_1 < var_569_6 then
					arg_566_1.talkMaxDuration = var_569_6

					if var_569_6 + var_569_0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_6 + var_569_0
					end
				end

				arg_566_1.text_.text = var_569_3
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)
				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_7 = math.max(var_569_1, arg_566_1.talkMaxDuration)

			if var_569_0 <= arg_566_1.time_ and arg_566_1.time_ < var_569_0 + var_569_7 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_0) / var_569_7

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_0 + var_569_7 and arg_566_1.time_ < var_569_0 + var_569_7 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play325011140 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 325011140
		arg_570_1.duration_ = 6.87

		local var_570_0 = {
			zh = 6.866,
			ja = 6.633
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

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
			local var_573_1 = 1

			if var_573_0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_0 + arg_573_0 then
				local var_573_2 = "play"
				local var_573_3 = "effect"

				arg_570_1:AudioAction(var_573_2, var_573_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_573_4 = 0
			local var_573_5 = 0.725

			if var_573_4 < arg_570_1.time_ and arg_570_1.time_ <= var_573_4 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				local var_573_6 = arg_570_1:FormatText(StoryNameCfg[1445].name)

				arg_570_1.leftNameTxt_.text = var_573_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, true)
				arg_570_1.iconController_:SetSelectedState("hero")

				arg_570_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_570_1.callingController_:SetSelectedState("normal")

				arg_570_1.keyicon_.color = Color.New(1, 1, 1)
				arg_570_1.icon_.color = Color.New(1, 1, 1)

				local var_573_7 = arg_570_1:GetWordFromCfg(325011140)
				local var_573_8 = arg_570_1:FormatText(var_573_7.content)

				arg_570_1.text_.text = var_573_8

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_9 = 29
				local var_573_10 = utf8.len(var_573_8)
				local var_573_11 = var_573_9 <= 0 and var_573_5 or var_573_5 * (var_573_10 / var_573_9)

				if var_573_11 > 0 and var_573_5 < var_573_11 then
					arg_570_1.talkMaxDuration = var_573_11

					if var_573_11 + var_573_4 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_11 + var_573_4
					end
				end

				arg_570_1.text_.text = var_573_8
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011140", "story_v_out_325011.awb") ~= 0 then
					local var_573_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011140", "story_v_out_325011.awb") / 1000

					if var_573_12 + var_573_4 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_12 + var_573_4
					end

					if var_573_7.prefab_name ~= "" and arg_570_1.actors_[var_573_7.prefab_name] ~= nil then
						local var_573_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_7.prefab_name].transform, "story_v_out_325011", "325011140", "story_v_out_325011.awb")

						arg_570_1:RecordAudio("325011140", var_573_13)
						arg_570_1:RecordAudio("325011140", var_573_13)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_325011", "325011140", "story_v_out_325011.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_325011", "325011140", "story_v_out_325011.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_14 = math.max(var_573_5, arg_570_1.talkMaxDuration)

			if var_573_4 <= arg_570_1.time_ and arg_570_1.time_ < var_573_4 + var_573_14 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_4) / var_573_14

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_4 + var_573_14 and arg_570_1.time_ < var_573_4 + var_573_14 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2015",
		"TextureConfig/Background/ST13"
	},
	voices = {
		"story_v_out_325011.awb"
	}
}
