return {
	Play1102002001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1102002001
		arg_1_1.duration_ = 4.67

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1102002002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST12"

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
				local var_4_5 = arg_1_1.bgs_.ST12

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
					if iter_4_0 ~= "ST12" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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

			local var_4_24 = "1029ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1029ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1029ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -1.09, -6.2)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1029ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1029ui_story"]
			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1029ui_story == nil then
				arg_1_1.var_.characterEffect1029ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1029ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1029ui_story then
				arg_1_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0
			local var_4_45 = 0.2

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

			local var_4_50 = 0.4
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_side_daily08", "bgm_side_daily08", "bgm_side_daily08.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_side_daily08", "bgm_side_daily08")

				if var_4_55 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_55 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_55

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_55
						arg_1_1.bgmTxt2_.text = var_4_55
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

			local var_4_56 = 0.2
			local var_4_57 = 1

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				local var_4_58 = "play"
				local var_4_59 = "effect"

				arg_1_1:AudioAction(var_4_58, var_4_59, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_60 = 2.00000000298023
			local var_4_61 = 0.35

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_62 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_62:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[319].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(1102002001)
				local var_4_65 = arg_1_1:FormatText(var_4_64.content)

				arg_1_1.text_.text = var_4_65

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_66 = 14
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002001", "story_v_side_new_1102002.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002001", "story_v_side_new_1102002.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_side_new_1102002", "1102002001", "story_v_side_new_1102002.awb")

						arg_1_1:RecordAudio("1102002001", var_4_70)
						arg_1_1:RecordAudio("1102002001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002001", "story_v_side_new_1102002.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002001", "story_v_side_new_1102002.awb")
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
				actorName = "1029ui_story",
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
	Play1102002002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1102002002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1102002003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1029ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1029ui_story == nil then
				arg_9_1.var_.characterEffect1029ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect1029ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1029ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1029ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1029ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 0.275

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

				local var_12_9 = arg_9_1:GetWordFromCfg(1102002002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 11
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
	Play1102002003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1102002003
		arg_13_1.duration_ = 3.7

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1102002004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1029ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1029ui_story == nil then
				arg_13_1.var_.characterEffect1029ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1029ui_story and not isNil(var_16_0) then
					arg_13_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1029ui_story then
				arg_13_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_16_4 = 0
			local var_16_5 = 0.425

			if var_16_4 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_6 = arg_13_1:FormatText(StoryNameCfg[319].name)

				arg_13_1.leftNameTxt_.text = var_16_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:GetWordFromCfg(1102002003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 17
				local var_16_10 = utf8.len(var_16_8)
				local var_16_11 = var_16_9 <= 0 and var_16_5 or var_16_5 * (var_16_10 / var_16_9)

				if var_16_11 > 0 and var_16_5 < var_16_11 then
					arg_13_1.talkMaxDuration = var_16_11

					if var_16_11 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002003", "story_v_side_new_1102002.awb") ~= 0 then
					local var_16_12 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002003", "story_v_side_new_1102002.awb") / 1000

					if var_16_12 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_4
					end

					if var_16_7.prefab_name ~= "" and arg_13_1.actors_[var_16_7.prefab_name] ~= nil then
						local var_16_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_7.prefab_name].transform, "story_v_side_new_1102002", "1102002003", "story_v_side_new_1102002.awb")

						arg_13_1:RecordAudio("1102002003", var_16_13)
						arg_13_1:RecordAudio("1102002003", var_16_13)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002003", "story_v_side_new_1102002.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002003", "story_v_side_new_1102002.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_14 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_14 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_14

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_14 and arg_13_1.time_ < var_16_4 + var_16_14 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1102002004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1102002004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1102002005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1029ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1029ui_story == nil then
				arg_17_1.var_.characterEffect1029ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1029ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1029ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1029ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1029ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 1.175

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:GetWordFromCfg(1102002004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 47
				local var_20_11 = utf8.len(var_20_9)
				local var_20_12 = var_20_10 <= 0 and var_20_7 or var_20_7 * (var_20_11 / var_20_10)

				if var_20_12 > 0 and var_20_7 < var_20_12 then
					arg_17_1.talkMaxDuration = var_20_12

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_13 and arg_17_1.time_ < var_20_6 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1102002005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1102002005
		arg_21_1.duration_ = 7.23

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1102002006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1029ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1029ui_story == nil then
				arg_21_1.var_.characterEffect1029ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1029ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1029ui_story then
				arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_24_4 = 0

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_2")
			end

			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_24_6 = 0
			local var_24_7 = 0.8

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[319].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_9 = arg_21_1:GetWordFromCfg(1102002005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 32
				local var_24_12 = utf8.len(var_24_10)
				local var_24_13 = var_24_11 <= 0 and var_24_7 or var_24_7 * (var_24_12 / var_24_11)

				if var_24_13 > 0 and var_24_7 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002005", "story_v_side_new_1102002.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002005", "story_v_side_new_1102002.awb") / 1000

					if var_24_14 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_6
					end

					if var_24_9.prefab_name ~= "" and arg_21_1.actors_[var_24_9.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_9.prefab_name].transform, "story_v_side_new_1102002", "1102002005", "story_v_side_new_1102002.awb")

						arg_21_1:RecordAudio("1102002005", var_24_15)
						arg_21_1:RecordAudio("1102002005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002005", "story_v_side_new_1102002.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002005", "story_v_side_new_1102002.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_16 and arg_21_1.time_ < var_24_6 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1102002006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1102002006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1102002007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1029ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1029ui_story == nil then
				arg_25_1.var_.characterEffect1029ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1029ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1029ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1029ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1029ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 1

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(1102002006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 40
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_7 or var_28_7 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_7 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1102002007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1102002007
		arg_29_1.duration_ = 2.5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1102002008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1029ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1029ui_story == nil then
				arg_29_1.var_.characterEffect1029ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1029ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1029ui_story then
				arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_5 = 0
			local var_32_6 = 0.325

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_7 = arg_29_1:FormatText(StoryNameCfg[319].name)

				arg_29_1.leftNameTxt_.text = var_32_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(1102002007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 13
				local var_32_11 = utf8.len(var_32_9)
				local var_32_12 = var_32_10 <= 0 and var_32_6 or var_32_6 * (var_32_11 / var_32_10)

				if var_32_12 > 0 and var_32_6 < var_32_12 then
					arg_29_1.talkMaxDuration = var_32_12

					if var_32_12 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002007", "story_v_side_new_1102002.awb") ~= 0 then
					local var_32_13 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002007", "story_v_side_new_1102002.awb") / 1000

					if var_32_13 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_5
					end

					if var_32_8.prefab_name ~= "" and arg_29_1.actors_[var_32_8.prefab_name] ~= nil then
						local var_32_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_8.prefab_name].transform, "story_v_side_new_1102002", "1102002007", "story_v_side_new_1102002.awb")

						arg_29_1:RecordAudio("1102002007", var_32_14)
						arg_29_1:RecordAudio("1102002007", var_32_14)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002007", "story_v_side_new_1102002.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002007", "story_v_side_new_1102002.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_15 = math.max(var_32_6, arg_29_1.talkMaxDuration)

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_15 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_5) / var_32_15

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_5 + var_32_15 and arg_29_1.time_ < var_32_5 + var_32_15 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1102002008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1102002008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1102002009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1029ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1029ui_story == nil then
				arg_33_1.var_.characterEffect1029ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1029ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1029ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1029ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1029ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 1.275

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(1102002008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 51
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1102002009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1102002009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1102002010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.975

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(1102002009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 39
				local var_40_5 = utf8.len(var_40_3)
				local var_40_6 = var_40_4 <= 0 and var_40_1 or var_40_1 * (var_40_5 / var_40_4)

				if var_40_6 > 0 and var_40_1 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_7 and arg_37_1.time_ < var_40_0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1102002010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1102002010
		arg_41_1.duration_ = 8.5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1102002011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1029ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1029ui_story == nil then
				arg_41_1.var_.characterEffect1029ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1029ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1029ui_story then
				arg_41_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_44_6 = 0
			local var_44_7 = 0.6

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[319].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:GetWordFromCfg(1102002010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 24
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002010", "story_v_side_new_1102002.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002010", "story_v_side_new_1102002.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_side_new_1102002", "1102002010", "story_v_side_new_1102002.awb")

						arg_41_1:RecordAudio("1102002010", var_44_15)
						arg_41_1:RecordAudio("1102002010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002010", "story_v_side_new_1102002.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002010", "story_v_side_new_1102002.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_16 and arg_41_1.time_ < var_44_6 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1102002011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1102002011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1102002012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1029ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1029ui_story == nil then
				arg_45_1.var_.characterEffect1029ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1029ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1029ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1029ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1029ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.225

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_9 = arg_45_1:GetWordFromCfg(1102002011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 9
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1102002012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1102002012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1102002013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.05

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(1102002012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 2
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_8 and arg_49_1.time_ < var_52_0 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1102002013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1102002013
		arg_53_1.duration_ = 5.13

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1102002014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "STblack"

			if arg_53_1.bgs_[var_56_0] == nil then
				local var_56_1 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_56_0)
				var_56_1.name = var_56_0
				var_56_1.transform.parent = arg_53_1.stage_.transform
				var_56_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_[var_56_0] = var_56_1
			end

			local var_56_2 = 2

			if var_56_2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				local var_56_3 = manager.ui.mainCamera.transform.localPosition
				local var_56_4 = Vector3.New(0, 0, 10) + Vector3.New(var_56_3.x, var_56_3.y, 0)
				local var_56_5 = arg_53_1.bgs_.STblack

				var_56_5.transform.localPosition = var_56_4
				var_56_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_6 = var_56_5:GetComponent("SpriteRenderer")

				if var_56_6 and var_56_6.sprite then
					local var_56_7 = (var_56_5.transform.localPosition - var_56_3).z
					local var_56_8 = manager.ui.mainCameraCom_
					local var_56_9 = 2 * var_56_7 * Mathf.Tan(var_56_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_56_10 = var_56_9 * var_56_8.aspect
					local var_56_11 = var_56_6.sprite.bounds.size.x
					local var_56_12 = var_56_6.sprite.bounds.size.y
					local var_56_13 = var_56_10 / var_56_11
					local var_56_14 = var_56_9 / var_56_12
					local var_56_15 = var_56_14 < var_56_13 and var_56_13 or var_56_14

					var_56_5.transform.localScale = Vector3.New(var_56_15, var_56_15, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "STblack" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_16 = 4

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			local var_56_17 = 0.3

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_18 = 0

			if var_56_18 < arg_53_1.time_ and arg_53_1.time_ <= var_56_18 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_19 = 2

			if var_56_18 <= arg_53_1.time_ and arg_53_1.time_ < var_56_18 + var_56_19 then
				local var_56_20 = (arg_53_1.time_ - var_56_18) / var_56_19
				local var_56_21 = Color.New(0, 0, 0)

				var_56_21.a = Mathf.Lerp(0, 1, var_56_20)
				arg_53_1.mask_.color = var_56_21
			end

			if arg_53_1.time_ >= var_56_18 + var_56_19 and arg_53_1.time_ < var_56_18 + var_56_19 + arg_56_0 then
				local var_56_22 = Color.New(0, 0, 0)

				var_56_22.a = 1
				arg_53_1.mask_.color = var_56_22
			end

			local var_56_23 = 2

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_24 = 2

			if var_56_23 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_24 then
				local var_56_25 = (arg_53_1.time_ - var_56_23) / var_56_24
				local var_56_26 = Color.New(0, 0, 0)

				var_56_26.a = Mathf.Lerp(1, 0, var_56_25)
				arg_53_1.mask_.color = var_56_26
			end

			if arg_53_1.time_ >= var_56_23 + var_56_24 and arg_53_1.time_ < var_56_23 + var_56_24 + arg_56_0 then
				local var_56_27 = Color.New(0, 0, 0)
				local var_56_28 = 0

				arg_53_1.mask_.enabled = false
				var_56_27.a = var_56_28
				arg_53_1.mask_.color = var_56_27
			end

			local var_56_29 = arg_53_1.actors_["1029ui_story"].transform
			local var_56_30 = 1.96599999815226

			if var_56_30 < arg_53_1.time_ and arg_53_1.time_ <= var_56_30 + arg_56_0 then
				arg_53_1.var_.moveOldPos1029ui_story = var_56_29.localPosition
			end

			local var_56_31 = 0.001

			if var_56_30 <= arg_53_1.time_ and arg_53_1.time_ < var_56_30 + var_56_31 then
				local var_56_32 = (arg_53_1.time_ - var_56_30) / var_56_31
				local var_56_33 = Vector3.New(0, 100, 0)

				var_56_29.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1029ui_story, var_56_33, var_56_32)

				local var_56_34 = manager.ui.mainCamera.transform.position - var_56_29.position

				var_56_29.forward = Vector3.New(var_56_34.x, var_56_34.y, var_56_34.z)

				local var_56_35 = var_56_29.localEulerAngles

				var_56_35.z = 0
				var_56_35.x = 0
				var_56_29.localEulerAngles = var_56_35
			end

			if arg_53_1.time_ >= var_56_30 + var_56_31 and arg_53_1.time_ < var_56_30 + var_56_31 + arg_56_0 then
				var_56_29.localPosition = Vector3.New(0, 100, 0)

				local var_56_36 = manager.ui.mainCamera.transform.position - var_56_29.position

				var_56_29.forward = Vector3.New(var_56_36.x, var_56_36.y, var_56_36.z)

				local var_56_37 = var_56_29.localEulerAngles

				var_56_37.z = 0
				var_56_37.x = 0
				var_56_29.localEulerAngles = var_56_37
			end

			local var_56_38 = 0
			local var_56_39 = 0.2

			if var_56_38 < arg_53_1.time_ and arg_53_1.time_ <= var_56_38 + arg_56_0 then
				local var_56_40 = "play"
				local var_56_41 = "music"

				arg_53_1:AudioAction(var_56_40, var_56_41, "ui_battle", "ui_battle_stopbgm", "")

				local var_56_42 = ""
				local var_56_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_56_43 ~= "" then
					if arg_53_1.bgmTxt_.text ~= var_56_43 and arg_53_1.bgmTxt_.text ~= "" then
						if arg_53_1.bgmTxt2_.text ~= "" then
							arg_53_1.bgmTxt_.text = arg_53_1.bgmTxt2_.text
						end

						arg_53_1.bgmTxt2_.text = var_56_43

						arg_53_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_53_1.bgmTxt_.text = var_56_43
						arg_53_1.bgmTxt2_.text = var_56_43
					end

					if arg_53_1.bgmTimer then
						arg_53_1.bgmTimer:Stop()

						arg_53_1.bgmTimer = nil
					end

					if arg_53_1.settingData.show_music_name == 1 then
						arg_53_1.musicController:SetSelectedState("show")
						arg_53_1.musicAnimator_:Play("open", 0, 0)

						if arg_53_1.settingData.music_time ~= 0 then
							arg_53_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_53_1.settingData.music_time), function()
								if arg_53_1 == nil or isNil(arg_53_1.bgmTxt_) then
									return
								end

								arg_53_1.musicController:SetSelectedState("hide")
								arg_53_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_44 = 4
			local var_56_45 = 0.075

			if var_56_44 < arg_53_1.time_ and arg_53_1.time_ <= var_56_44 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_46 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_46:setOnUpdate(LuaHelper.FloatAction(function(arg_58_0)
					arg_53_1.dialogCg_.alpha = arg_58_0
				end))
				var_56_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_47 = arg_53_1:FormatText(StoryNameCfg[36].name)

				arg_53_1.leftNameTxt_.text = var_56_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_48 = arg_53_1:GetWordFromCfg(1102002013)
				local var_56_49 = arg_53_1:FormatText(var_56_48.content)

				arg_53_1.text_.text = var_56_49

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_50 = 3
				local var_56_51 = utf8.len(var_56_49)
				local var_56_52 = var_56_50 <= 0 and var_56_45 or var_56_45 * (var_56_51 / var_56_50)

				if var_56_52 > 0 and var_56_45 < var_56_52 then
					arg_53_1.talkMaxDuration = var_56_52
					var_56_44 = var_56_44 + 0.3

					if var_56_52 + var_56_44 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_52 + var_56_44
					end
				end

				arg_53_1.text_.text = var_56_49
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002013", "story_v_side_new_1102002.awb") ~= 0 then
					local var_56_53 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002013", "story_v_side_new_1102002.awb") / 1000

					if var_56_53 + var_56_44 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_53 + var_56_44
					end

					if var_56_48.prefab_name ~= "" and arg_53_1.actors_[var_56_48.prefab_name] ~= nil then
						local var_56_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_48.prefab_name].transform, "story_v_side_new_1102002", "1102002013", "story_v_side_new_1102002.awb")

						arg_53_1:RecordAudio("1102002013", var_56_54)
						arg_53_1:RecordAudio("1102002013", var_56_54)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002013", "story_v_side_new_1102002.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002013", "story_v_side_new_1102002.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_55 = var_56_44 + 0.3
			local var_56_56 = math.max(var_56_45, arg_53_1.talkMaxDuration)

			if var_56_55 <= arg_53_1.time_ and arg_53_1.time_ < var_56_55 + var_56_56 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_55) / var_56_56

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_55 + var_56_56 and arg_53_1.time_ < var_56_55 + var_56_56 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play1102002014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1102002014
		arg_60_1.duration_ = 7

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1102002015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "ST61"

			if arg_60_1.bgs_[var_63_0] == nil then
				local var_63_1 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_63_0)
				var_63_1.name = var_63_0
				var_63_1.transform.parent = arg_60_1.stage_.transform
				var_63_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_[var_63_0] = var_63_1
			end

			local var_63_2 = 0

			if var_63_2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				local var_63_3 = manager.ui.mainCamera.transform.localPosition
				local var_63_4 = Vector3.New(0, 0, 10) + Vector3.New(var_63_3.x, var_63_3.y, 0)
				local var_63_5 = arg_60_1.bgs_.ST61

				var_63_5.transform.localPosition = var_63_4
				var_63_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_6 = var_63_5:GetComponent("SpriteRenderer")

				if var_63_6 and var_63_6.sprite then
					local var_63_7 = (var_63_5.transform.localPosition - var_63_3).z
					local var_63_8 = manager.ui.mainCameraCom_
					local var_63_9 = 2 * var_63_7 * Mathf.Tan(var_63_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_63_10 = var_63_9 * var_63_8.aspect
					local var_63_11 = var_63_6.sprite.bounds.size.x
					local var_63_12 = var_63_6.sprite.bounds.size.y
					local var_63_13 = var_63_10 / var_63_11
					local var_63_14 = var_63_9 / var_63_12
					local var_63_15 = var_63_14 < var_63_13 and var_63_13 or var_63_14

					var_63_5.transform.localScale = Vector3.New(var_63_15, var_63_15, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "ST61" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_16 = 2

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			local var_63_17 = 0.3

			if arg_60_1.time_ >= var_63_16 + var_63_17 and arg_60_1.time_ < var_63_16 + var_63_17 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			local var_63_18 = 0

			if var_63_18 < arg_60_1.time_ and arg_60_1.time_ <= var_63_18 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_19 = 2

			if var_63_18 <= arg_60_1.time_ and arg_60_1.time_ < var_63_18 + var_63_19 then
				local var_63_20 = (arg_60_1.time_ - var_63_18) / var_63_19
				local var_63_21 = Color.New(0, 0, 0)

				var_63_21.a = Mathf.Lerp(1, 0, var_63_20)
				arg_60_1.mask_.color = var_63_21
			end

			if arg_60_1.time_ >= var_63_18 + var_63_19 and arg_60_1.time_ < var_63_18 + var_63_19 + arg_63_0 then
				local var_63_22 = Color.New(0, 0, 0)
				local var_63_23 = 0

				arg_60_1.mask_.enabled = false
				var_63_22.a = var_63_23
				arg_60_1.mask_.color = var_63_22
			end

			local var_63_24 = 0.125
			local var_63_25 = 1

			if var_63_24 < arg_60_1.time_ and arg_60_1.time_ <= var_63_24 + arg_63_0 then
				local var_63_26 = "stop"
				local var_63_27 = "effect"

				arg_60_1:AudioAction(var_63_26, var_63_27, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_63_28 = 0.125
			local var_63_29 = 1

			if var_63_28 < arg_60_1.time_ and arg_60_1.time_ <= var_63_28 + arg_63_0 then
				local var_63_30 = "play"
				local var_63_31 = "effect"

				arg_60_1:AudioAction(var_63_30, var_63_31, "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			local var_63_32 = 0
			local var_63_33 = 0.2

			if var_63_32 < arg_60_1.time_ and arg_60_1.time_ <= var_63_32 + arg_63_0 then
				local var_63_34 = "play"
				local var_63_35 = "music"

				arg_60_1:AudioAction(var_63_34, var_63_35, "ui_battle", "ui_battle_stopbgm", "")

				local var_63_36 = ""
				local var_63_37 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_63_37 ~= "" then
					if arg_60_1.bgmTxt_.text ~= var_63_37 and arg_60_1.bgmTxt_.text ~= "" then
						if arg_60_1.bgmTxt2_.text ~= "" then
							arg_60_1.bgmTxt_.text = arg_60_1.bgmTxt2_.text
						end

						arg_60_1.bgmTxt2_.text = var_63_37

						arg_60_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_60_1.bgmTxt_.text = var_63_37
						arg_60_1.bgmTxt2_.text = var_63_37
					end

					if arg_60_1.bgmTimer then
						arg_60_1.bgmTimer:Stop()

						arg_60_1.bgmTimer = nil
					end

					if arg_60_1.settingData.show_music_name == 1 then
						arg_60_1.musicController:SetSelectedState("show")
						arg_60_1.musicAnimator_:Play("open", 0, 0)

						if arg_60_1.settingData.music_time ~= 0 then
							arg_60_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_60_1.settingData.music_time), function()
								if arg_60_1 == nil or isNil(arg_60_1.bgmTxt_) then
									return
								end

								arg_60_1.musicController:SetSelectedState("hide")
								arg_60_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_63_38 = 0.4
			local var_63_39 = 1

			if var_63_38 < arg_60_1.time_ and arg_60_1.time_ <= var_63_38 + arg_63_0 then
				local var_63_40 = "play"
				local var_63_41 = "music"

				arg_60_1:AudioAction(var_63_40, var_63_41, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_63_42 = ""
				local var_63_43 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if var_63_43 ~= "" then
					if arg_60_1.bgmTxt_.text ~= var_63_43 and arg_60_1.bgmTxt_.text ~= "" then
						if arg_60_1.bgmTxt2_.text ~= "" then
							arg_60_1.bgmTxt_.text = arg_60_1.bgmTxt2_.text
						end

						arg_60_1.bgmTxt2_.text = var_63_43

						arg_60_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_60_1.bgmTxt_.text = var_63_43
						arg_60_1.bgmTxt2_.text = var_63_43
					end

					if arg_60_1.bgmTimer then
						arg_60_1.bgmTimer:Stop()

						arg_60_1.bgmTimer = nil
					end

					if arg_60_1.settingData.show_music_name == 1 then
						arg_60_1.musicController:SetSelectedState("show")
						arg_60_1.musicAnimator_:Play("open", 0, 0)

						if arg_60_1.settingData.music_time ~= 0 then
							arg_60_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_60_1.settingData.music_time), function()
								if arg_60_1 == nil or isNil(arg_60_1.bgmTxt_) then
									return
								end

								arg_60_1.musicController:SetSelectedState("hide")
								arg_60_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_44 = 2
			local var_63_45 = 0.075

			if var_63_44 < arg_60_1.time_ and arg_60_1.time_ <= var_63_44 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_46 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_46:setOnUpdate(LuaHelper.FloatAction(function(arg_66_0)
					arg_60_1.dialogCg_.alpha = arg_66_0
				end))
				var_63_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_47 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_48 = arg_60_1:GetWordFromCfg(1102002014)
				local var_63_49 = arg_60_1:FormatText(var_63_48.content)

				arg_60_1.text_.text = var_63_49

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_50 = 3
				local var_63_51 = utf8.len(var_63_49)
				local var_63_52 = var_63_50 <= 0 and var_63_45 or var_63_45 * (var_63_51 / var_63_50)

				if var_63_52 > 0 and var_63_45 < var_63_52 then
					arg_60_1.talkMaxDuration = var_63_52
					var_63_44 = var_63_44 + 0.3

					if var_63_52 + var_63_44 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_52 + var_63_44
					end
				end

				arg_60_1.text_.text = var_63_49
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_53 = var_63_44 + 0.3
			local var_63_54 = math.max(var_63_45, arg_60_1.talkMaxDuration)

			if var_63_53 <= arg_60_1.time_ and arg_60_1.time_ < var_63_53 + var_63_54 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_53) / var_63_54

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_53 + var_63_54 and arg_60_1.time_ < var_63_53 + var_63_54 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play1102002015 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1102002015
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1102002016(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 1.025

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(1102002015)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 41
				local var_71_5 = utf8.len(var_71_3)
				local var_71_6 = var_71_4 <= 0 and var_71_1 or var_71_1 * (var_71_5 / var_71_4)

				if var_71_6 > 0 and var_71_1 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_7 and arg_68_1.time_ < var_71_0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play1102002016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1102002016
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1102002017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 1.025

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(1102002016)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 41
				local var_75_5 = utf8.len(var_75_3)
				local var_75_6 = var_75_4 <= 0 and var_75_1 or var_75_1 * (var_75_5 / var_75_4)

				if var_75_6 > 0 and var_75_1 < var_75_6 then
					arg_72_1.talkMaxDuration = var_75_6

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_7 and arg_72_1.time_ < var_75_0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1102002017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1102002017
		arg_76_1.duration_ = 3.4

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1102002018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = "1089ui_story"

			if arg_76_1.actors_[var_79_0] == nil then
				local var_79_1 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_79_1) then
					local var_79_2 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_76_1.stage_.transform)

					var_79_2.name = var_79_0
					var_79_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_76_1.actors_[var_79_0] = var_79_2

					local var_79_3 = var_79_2:GetComponentInChildren(typeof(CharacterEffect))

					var_79_3.enabled = true

					local var_79_4 = GameObjectTools.GetOrAddComponent(var_79_2, typeof(DynamicBoneHelper))

					if var_79_4 then
						var_79_4:EnableDynamicBone(false)
					end

					arg_76_1:ShowWeapon(var_79_3.transform, false)

					arg_76_1.var_[var_79_0 .. "Animator"] = var_79_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_76_1.var_[var_79_0 .. "Animator"].applyRootMotion = true
					arg_76_1.var_[var_79_0 .. "LipSync"] = var_79_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_79_5 = arg_76_1.actors_["1089ui_story"].transform
			local var_79_6 = 0

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.var_.moveOldPos1089ui_story = var_79_5.localPosition
			end

			local var_79_7 = 0.001

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_7 then
				local var_79_8 = (arg_76_1.time_ - var_79_6) / var_79_7
				local var_79_9 = Vector3.New(0, -1.1, -6.17)

				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1089ui_story, var_79_9, var_79_8)

				local var_79_10 = manager.ui.mainCamera.transform.position - var_79_5.position

				var_79_5.forward = Vector3.New(var_79_10.x, var_79_10.y, var_79_10.z)

				local var_79_11 = var_79_5.localEulerAngles

				var_79_11.z = 0
				var_79_11.x = 0
				var_79_5.localEulerAngles = var_79_11
			end

			if arg_76_1.time_ >= var_79_6 + var_79_7 and arg_76_1.time_ < var_79_6 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_79_12 = manager.ui.mainCamera.transform.position - var_79_5.position

				var_79_5.forward = Vector3.New(var_79_12.x, var_79_12.y, var_79_12.z)

				local var_79_13 = var_79_5.localEulerAngles

				var_79_13.z = 0
				var_79_13.x = 0
				var_79_5.localEulerAngles = var_79_13
			end

			local var_79_14 = arg_76_1.actors_["1089ui_story"]
			local var_79_15 = 0

			if var_79_15 < arg_76_1.time_ and arg_76_1.time_ <= var_79_15 + arg_79_0 and not isNil(var_79_14) and arg_76_1.var_.characterEffect1089ui_story == nil then
				arg_76_1.var_.characterEffect1089ui_story = var_79_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_16 = 0.200000002980232

			if var_79_15 <= arg_76_1.time_ and arg_76_1.time_ < var_79_15 + var_79_16 and not isNil(var_79_14) then
				local var_79_17 = (arg_76_1.time_ - var_79_15) / var_79_16

				if arg_76_1.var_.characterEffect1089ui_story and not isNil(var_79_14) then
					arg_76_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_15 + var_79_16 and arg_76_1.time_ < var_79_15 + var_79_16 + arg_79_0 and not isNil(var_79_14) and arg_76_1.var_.characterEffect1089ui_story then
				arg_76_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_79_18 = 0

			if var_79_18 < arg_76_1.time_ and arg_76_1.time_ <= var_79_18 + arg_79_0 then
				arg_76_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_79_19 = 0

			if var_79_19 < arg_76_1.time_ and arg_76_1.time_ <= var_79_19 + arg_79_0 then
				arg_76_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_20 = 0
			local var_79_21 = 0.275

			if var_79_20 < arg_76_1.time_ and arg_76_1.time_ <= var_79_20 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_22 = arg_76_1:FormatText(StoryNameCfg[1031].name)

				arg_76_1.leftNameTxt_.text = var_79_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_23 = arg_76_1:GetWordFromCfg(1102002017)
				local var_79_24 = arg_76_1:FormatText(var_79_23.content)

				arg_76_1.text_.text = var_79_24

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_25 = 11
				local var_79_26 = utf8.len(var_79_24)
				local var_79_27 = var_79_25 <= 0 and var_79_21 or var_79_21 * (var_79_26 / var_79_25)

				if var_79_27 > 0 and var_79_21 < var_79_27 then
					arg_76_1.talkMaxDuration = var_79_27

					if var_79_27 + var_79_20 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_27 + var_79_20
					end
				end

				arg_76_1.text_.text = var_79_24
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002017", "story_v_side_new_1102002.awb") ~= 0 then
					local var_79_28 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002017", "story_v_side_new_1102002.awb") / 1000

					if var_79_28 + var_79_20 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_28 + var_79_20
					end

					if var_79_23.prefab_name ~= "" and arg_76_1.actors_[var_79_23.prefab_name] ~= nil then
						local var_79_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_23.prefab_name].transform, "story_v_side_new_1102002", "1102002017", "story_v_side_new_1102002.awb")

						arg_76_1:RecordAudio("1102002017", var_79_29)
						arg_76_1:RecordAudio("1102002017", var_79_29)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002017", "story_v_side_new_1102002.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002017", "story_v_side_new_1102002.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_30 = math.max(var_79_21, arg_76_1.talkMaxDuration)

			if var_79_20 <= arg_76_1.time_ and arg_76_1.time_ < var_79_20 + var_79_30 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_20) / var_79_30

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_20 + var_79_30 and arg_76_1.time_ < var_79_20 + var_79_30 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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
	Play1102002018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1102002018
		arg_80_1.duration_ = 6.23

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1102002019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_83_2 = 0
			local var_83_3 = 0.55

			if var_83_2 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_4 = arg_80_1:FormatText(StoryNameCfg[1031].name)

				arg_80_1.leftNameTxt_.text = var_83_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_5 = arg_80_1:GetWordFromCfg(1102002018)
				local var_83_6 = arg_80_1:FormatText(var_83_5.content)

				arg_80_1.text_.text = var_83_6

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_7 = 22
				local var_83_8 = utf8.len(var_83_6)
				local var_83_9 = var_83_7 <= 0 and var_83_3 or var_83_3 * (var_83_8 / var_83_7)

				if var_83_9 > 0 and var_83_3 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_2
					end
				end

				arg_80_1.text_.text = var_83_6
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002018", "story_v_side_new_1102002.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002018", "story_v_side_new_1102002.awb") / 1000

					if var_83_10 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_2
					end

					if var_83_5.prefab_name ~= "" and arg_80_1.actors_[var_83_5.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_5.prefab_name].transform, "story_v_side_new_1102002", "1102002018", "story_v_side_new_1102002.awb")

						arg_80_1:RecordAudio("1102002018", var_83_11)
						arg_80_1:RecordAudio("1102002018", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002018", "story_v_side_new_1102002.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002018", "story_v_side_new_1102002.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_3, arg_80_1.talkMaxDuration)

			if var_83_2 <= arg_80_1.time_ and arg_80_1.time_ < var_83_2 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_2) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_2 + var_83_12 and arg_80_1.time_ < var_83_2 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play1102002019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1102002019
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1102002020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1089ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1089ui_story == nil then
				arg_84_1.var_.characterEffect1089ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1089ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1089ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1089ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1089ui_story.fillRatio = var_87_5
			end

			local var_87_6 = 0
			local var_87_7 = 0.325

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[7].name)

				arg_84_1.leftNameTxt_.text = var_87_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_9 = arg_84_1:GetWordFromCfg(1102002019)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 13
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
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_14 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_14 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_14

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_14 and arg_84_1.time_ < var_87_6 + var_87_14 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play1102002020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1102002020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1102002021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1.05

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[7].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:GetWordFromCfg(1102002020)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 42
				local var_91_6 = utf8.len(var_91_4)
				local var_91_7 = var_91_5 <= 0 and var_91_1 or var_91_1 * (var_91_6 / var_91_5)

				if var_91_7 > 0 and var_91_1 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_8 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_8 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_8

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_8 and arg_88_1.time_ < var_91_0 + var_91_8 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play1102002021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1102002021
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1102002022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1089ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1089ui_story = var_95_0.localPosition
			end

			local var_95_2 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2
				local var_95_4 = Vector3.New(0, 100, 0)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1089ui_story, var_95_4, var_95_3)

				local var_95_5 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_5.x, var_95_5.y, var_95_5.z)

				local var_95_6 = var_95_0.localEulerAngles

				var_95_6.z = 0
				var_95_6.x = 0
				var_95_0.localEulerAngles = var_95_6
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, 100, 0)

				local var_95_7 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_7.x, var_95_7.y, var_95_7.z)

				local var_95_8 = var_95_0.localEulerAngles

				var_95_8.z = 0
				var_95_8.x = 0
				var_95_0.localEulerAngles = var_95_8
			end

			local var_95_9 = 0
			local var_95_10 = 1.2

			if var_95_9 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_11 = arg_92_1:GetWordFromCfg(1102002021)
				local var_95_12 = arg_92_1:FormatText(var_95_11.content)

				arg_92_1.text_.text = var_95_12

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 48
				local var_95_14 = utf8.len(var_95_12)
				local var_95_15 = var_95_13 <= 0 and var_95_10 or var_95_10 * (var_95_14 / var_95_13)

				if var_95_15 > 0 and var_95_10 < var_95_15 then
					arg_92_1.talkMaxDuration = var_95_15

					if var_95_15 + var_95_9 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_15 + var_95_9
					end
				end

				arg_92_1.text_.text = var_95_12
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_10, arg_92_1.talkMaxDuration)

			if var_95_9 <= arg_92_1.time_ and arg_92_1.time_ < var_95_9 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_9) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_9 + var_95_16 and arg_92_1.time_ < var_95_9 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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
	Play1102002022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1102002022
		arg_96_1.duration_ = 4.4

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1102002023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1089ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1089ui_story = var_99_0.localPosition
			end

			local var_99_2 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2
				local var_99_4 = Vector3.New(0, -1.1, -6.17)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1089ui_story, var_99_4, var_99_3)

				local var_99_5 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_5.x, var_99_5.y, var_99_5.z)

				local var_99_6 = var_99_0.localEulerAngles

				var_99_6.z = 0
				var_99_6.x = 0
				var_99_0.localEulerAngles = var_99_6
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_99_7 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_7.x, var_99_7.y, var_99_7.z)

				local var_99_8 = var_99_0.localEulerAngles

				var_99_8.z = 0
				var_99_8.x = 0
				var_99_0.localEulerAngles = var_99_8
			end

			local var_99_9 = arg_96_1.actors_["1089ui_story"]
			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1089ui_story == nil then
				arg_96_1.var_.characterEffect1089ui_story = var_99_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_11 = 0.200000002980232

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_11 and not isNil(var_99_9) then
				local var_99_12 = (arg_96_1.time_ - var_99_10) / var_99_11

				if arg_96_1.var_.characterEffect1089ui_story and not isNil(var_99_9) then
					arg_96_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_10 + var_99_11 and arg_96_1.time_ < var_99_10 + var_99_11 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1089ui_story then
				arg_96_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_99_13 = 0

			if var_99_13 < arg_96_1.time_ and arg_96_1.time_ <= var_99_13 + arg_99_0 then
				arg_96_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			local var_99_14 = 0

			if var_99_14 < arg_96_1.time_ and arg_96_1.time_ <= var_99_14 + arg_99_0 then
				arg_96_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_99_15 = 0
			local var_99_16 = 0.425

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_17 = arg_96_1:FormatText(StoryNameCfg[1031].name)

				arg_96_1.leftNameTxt_.text = var_99_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(1102002022)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_20 = 17
				local var_99_21 = utf8.len(var_99_19)
				local var_99_22 = var_99_20 <= 0 and var_99_16 or var_99_16 * (var_99_21 / var_99_20)

				if var_99_22 > 0 and var_99_16 < var_99_22 then
					arg_96_1.talkMaxDuration = var_99_22

					if var_99_22 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_15
					end
				end

				arg_96_1.text_.text = var_99_19
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002022", "story_v_side_new_1102002.awb") ~= 0 then
					local var_99_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002022", "story_v_side_new_1102002.awb") / 1000

					if var_99_23 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_15
					end

					if var_99_18.prefab_name ~= "" and arg_96_1.actors_[var_99_18.prefab_name] ~= nil then
						local var_99_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_18.prefab_name].transform, "story_v_side_new_1102002", "1102002022", "story_v_side_new_1102002.awb")

						arg_96_1:RecordAudio("1102002022", var_99_24)
						arg_96_1:RecordAudio("1102002022", var_99_24)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002022", "story_v_side_new_1102002.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002022", "story_v_side_new_1102002.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_25 = math.max(var_99_16, arg_96_1.talkMaxDuration)

			if var_99_15 <= arg_96_1.time_ and arg_96_1.time_ < var_99_15 + var_99_25 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_15) / var_99_25

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_15 + var_99_25 and arg_96_1.time_ < var_99_15 + var_99_25 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play1102002023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1102002023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1102002024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1089ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1089ui_story == nil then
				arg_100_1.var_.characterEffect1089ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1089ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1089ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1089ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1089ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 0.15

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

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_9 = arg_100_1:GetWordFromCfg(1102002023)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 6
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
	Play1102002024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1102002024
		arg_104_1.duration_ = 3.53

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1102002025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1089ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1089ui_story == nil then
				arg_104_1.var_.characterEffect1089ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1089ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1089ui_story then
				arg_104_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_107_4 = 0

			if var_107_4 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_107_6 = 0
			local var_107_7 = 0.325

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_8 = arg_104_1:FormatText(StoryNameCfg[1031].name)

				arg_104_1.leftNameTxt_.text = var_107_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_9 = arg_104_1:GetWordFromCfg(1102002024)
				local var_107_10 = arg_104_1:FormatText(var_107_9.content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 13
				local var_107_12 = utf8.len(var_107_10)
				local var_107_13 = var_107_11 <= 0 and var_107_7 or var_107_7 * (var_107_12 / var_107_11)

				if var_107_13 > 0 and var_107_7 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002024", "story_v_side_new_1102002.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002024", "story_v_side_new_1102002.awb") / 1000

					if var_107_14 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_6
					end

					if var_107_9.prefab_name ~= "" and arg_104_1.actors_[var_107_9.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_9.prefab_name].transform, "story_v_side_new_1102002", "1102002024", "story_v_side_new_1102002.awb")

						arg_104_1:RecordAudio("1102002024", var_107_15)
						arg_104_1:RecordAudio("1102002024", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002024", "story_v_side_new_1102002.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002024", "story_v_side_new_1102002.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_16 and arg_104_1.time_ < var_107_6 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play1102002025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1102002025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1102002026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1089ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1089ui_story == nil then
				arg_108_1.var_.characterEffect1089ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1089ui_story and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1089ui_story.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1089ui_story then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1089ui_story.fillRatio = var_111_5
			end

			local var_111_6 = 0
			local var_111_7 = 0.75

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_8 = arg_108_1:GetWordFromCfg(1102002025)
				local var_111_9 = arg_108_1:FormatText(var_111_8.content)

				arg_108_1.text_.text = var_111_9

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_10 = 30
				local var_111_11 = utf8.len(var_111_9)
				local var_111_12 = var_111_10 <= 0 and var_111_7 or var_111_7 * (var_111_11 / var_111_10)

				if var_111_12 > 0 and var_111_7 < var_111_12 then
					arg_108_1.talkMaxDuration = var_111_12

					if var_111_12 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_12 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_9
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_13 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_13 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_13

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_13 and arg_108_1.time_ < var_111_6 + var_111_13 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play1102002026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1102002026
		arg_112_1.duration_ = 6.9

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1102002027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1089ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1089ui_story == nil then
				arg_112_1.var_.characterEffect1089ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1089ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1089ui_story then
				arg_112_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_115_4 = 0

			if var_115_4 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_2")
			end

			local var_115_5 = 0

			if var_115_5 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_115_6 = 0
			local var_115_7 = 0.725

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_8 = arg_112_1:FormatText(StoryNameCfg[1031].name)

				arg_112_1.leftNameTxt_.text = var_115_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_9 = arg_112_1:GetWordFromCfg(1102002026)
				local var_115_10 = arg_112_1:FormatText(var_115_9.content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_11 = 29
				local var_115_12 = utf8.len(var_115_10)
				local var_115_13 = var_115_11 <= 0 and var_115_7 or var_115_7 * (var_115_12 / var_115_11)

				if var_115_13 > 0 and var_115_7 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_10
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002026", "story_v_side_new_1102002.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002026", "story_v_side_new_1102002.awb") / 1000

					if var_115_14 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_6
					end

					if var_115_9.prefab_name ~= "" and arg_112_1.actors_[var_115_9.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_9.prefab_name].transform, "story_v_side_new_1102002", "1102002026", "story_v_side_new_1102002.awb")

						arg_112_1:RecordAudio("1102002026", var_115_15)
						arg_112_1:RecordAudio("1102002026", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002026", "story_v_side_new_1102002.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002026", "story_v_side_new_1102002.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_16 and arg_112_1.time_ < var_115_6 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play1102002027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1102002027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1102002028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1089ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1089ui_story == nil then
				arg_116_1.var_.characterEffect1089ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1089ui_story and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1089ui_story.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1089ui_story then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1089ui_story.fillRatio = var_119_5
			end

			local var_119_6 = 0
			local var_119_7 = 0.175

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_8 = arg_116_1:FormatText(StoryNameCfg[7].name)

				arg_116_1.leftNameTxt_.text = var_119_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_9 = arg_116_1:GetWordFromCfg(1102002027)
				local var_119_10 = arg_116_1:FormatText(var_119_9.content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 7
				local var_119_12 = utf8.len(var_119_10)
				local var_119_13 = var_119_11 <= 0 and var_119_7 or var_119_7 * (var_119_12 / var_119_11)

				if var_119_13 > 0 and var_119_7 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_10
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_14 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_14 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_14

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_14 and arg_116_1.time_ < var_119_6 + var_119_14 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play1102002028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1102002028
		arg_120_1.duration_ = 1

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1102002029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1089ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1089ui_story == nil then
				arg_120_1.var_.characterEffect1089ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1089ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1089ui_story then
				arg_120_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_123_4 = 0

			if var_123_4 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_123_5 = 0

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_6 = 0
			local var_123_7 = 0.05

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_8 = arg_120_1:FormatText(StoryNameCfg[1031].name)

				arg_120_1.leftNameTxt_.text = var_123_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_9 = arg_120_1:GetWordFromCfg(1102002028)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 2
				local var_123_12 = utf8.len(var_123_10)
				local var_123_13 = var_123_11 <= 0 and var_123_7 or var_123_7 * (var_123_12 / var_123_11)

				if var_123_13 > 0 and var_123_7 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002028", "story_v_side_new_1102002.awb") ~= 0 then
					local var_123_14 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002028", "story_v_side_new_1102002.awb") / 1000

					if var_123_14 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_6
					end

					if var_123_9.prefab_name ~= "" and arg_120_1.actors_[var_123_9.prefab_name] ~= nil then
						local var_123_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_9.prefab_name].transform, "story_v_side_new_1102002", "1102002028", "story_v_side_new_1102002.awb")

						arg_120_1:RecordAudio("1102002028", var_123_15)
						arg_120_1:RecordAudio("1102002028", var_123_15)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002028", "story_v_side_new_1102002.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002028", "story_v_side_new_1102002.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_16 and arg_120_1.time_ < var_123_6 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1102002029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1102002029
		arg_124_1.duration_ = 8.37

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1102002030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.975

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[1031].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(1102002029)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002029", "story_v_side_new_1102002.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002029", "story_v_side_new_1102002.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_side_new_1102002", "1102002029", "story_v_side_new_1102002.awb")

						arg_124_1:RecordAudio("1102002029", var_127_9)
						arg_124_1:RecordAudio("1102002029", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002029", "story_v_side_new_1102002.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002029", "story_v_side_new_1102002.awb")
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
	Play1102002030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1102002030
		arg_128_1.duration_ = 12.3

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1102002031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 1.225

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[1031].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:GetWordFromCfg(1102002030)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 49
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002030", "story_v_side_new_1102002.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002030", "story_v_side_new_1102002.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_side_new_1102002", "1102002030", "story_v_side_new_1102002.awb")

						arg_128_1:RecordAudio("1102002030", var_131_9)
						arg_128_1:RecordAudio("1102002030", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002030", "story_v_side_new_1102002.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002030", "story_v_side_new_1102002.awb")
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
	Play1102002031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1102002031
		arg_132_1.duration_ = 7.33

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1102002032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_135_1 = 0
			local var_135_2 = 0.875

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_3 = arg_132_1:FormatText(StoryNameCfg[1031].name)

				arg_132_1.leftNameTxt_.text = var_135_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_4 = arg_132_1:GetWordFromCfg(1102002031)
				local var_135_5 = arg_132_1:FormatText(var_135_4.content)

				arg_132_1.text_.text = var_135_5

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_6 = 35
				local var_135_7 = utf8.len(var_135_5)
				local var_135_8 = var_135_6 <= 0 and var_135_2 or var_135_2 * (var_135_7 / var_135_6)

				if var_135_8 > 0 and var_135_2 < var_135_8 then
					arg_132_1.talkMaxDuration = var_135_8

					if var_135_8 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_5
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002031", "story_v_side_new_1102002.awb") ~= 0 then
					local var_135_9 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002031", "story_v_side_new_1102002.awb") / 1000

					if var_135_9 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_1
					end

					if var_135_4.prefab_name ~= "" and arg_132_1.actors_[var_135_4.prefab_name] ~= nil then
						local var_135_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_4.prefab_name].transform, "story_v_side_new_1102002", "1102002031", "story_v_side_new_1102002.awb")

						arg_132_1:RecordAudio("1102002031", var_135_10)
						arg_132_1:RecordAudio("1102002031", var_135_10)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002031", "story_v_side_new_1102002.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002031", "story_v_side_new_1102002.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_11 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_11 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_11

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_11 and arg_132_1.time_ < var_135_1 + var_135_11 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1102002032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1102002032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1102002033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1089ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1089ui_story == nil then
				arg_136_1.var_.characterEffect1089ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1089ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1089ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1089ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1089ui_story.fillRatio = var_139_5
			end

			local var_139_6 = 0
			local var_139_7 = 0.475

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_8 = arg_136_1:FormatText(StoryNameCfg[7].name)

				arg_136_1.leftNameTxt_.text = var_139_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_9 = arg_136_1:GetWordFromCfg(1102002032)
				local var_139_10 = arg_136_1:FormatText(var_139_9.content)

				arg_136_1.text_.text = var_139_10

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 19
				local var_139_12 = utf8.len(var_139_10)
				local var_139_13 = var_139_11 <= 0 and var_139_7 or var_139_7 * (var_139_12 / var_139_11)

				if var_139_13 > 0 and var_139_7 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_10
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_14 and arg_136_1.time_ < var_139_6 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play1102002033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1102002033
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1102002034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 1.125

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_2 = arg_140_1:GetWordFromCfg(1102002033)
				local var_143_3 = arg_140_1:FormatText(var_143_2.content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 45
				local var_143_5 = utf8.len(var_143_3)
				local var_143_6 = var_143_4 <= 0 and var_143_1 or var_143_1 * (var_143_5 / var_143_4)

				if var_143_6 > 0 and var_143_1 < var_143_6 then
					arg_140_1.talkMaxDuration = var_143_6

					if var_143_6 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_6 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_7 and arg_140_1.time_ < var_143_0 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1102002034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1102002034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1102002035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.65

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(1102002034)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 26
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_8 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_8 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_8

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_8 and arg_144_1.time_ < var_147_0 + var_147_8 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1102002035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1102002035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1102002036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1089ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1089ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, 100, 0)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1089ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, 100, 0)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = 0.125
			local var_151_10 = 1

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				local var_151_11 = "play"
				local var_151_12 = "effect"

				arg_148_1:AudioAction(var_151_11, var_151_12, "se_story_side_1075", "se_story_side_1075_door", "")
			end

			local var_151_13 = 0
			local var_151_14 = 0.4

			if var_151_13 < arg_148_1.time_ and arg_148_1.time_ <= var_151_13 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_15 = arg_148_1:GetWordFromCfg(1102002035)
				local var_151_16 = arg_148_1:FormatText(var_151_15.content)

				arg_148_1.text_.text = var_151_16

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_17 = 16
				local var_151_18 = utf8.len(var_151_16)
				local var_151_19 = var_151_17 <= 0 and var_151_14 or var_151_14 * (var_151_18 / var_151_17)

				if var_151_19 > 0 and var_151_14 < var_151_19 then
					arg_148_1.talkMaxDuration = var_151_19

					if var_151_19 + var_151_13 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_19 + var_151_13
					end
				end

				arg_148_1.text_.text = var_151_16
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_20 = math.max(var_151_14, arg_148_1.talkMaxDuration)

			if var_151_13 <= arg_148_1.time_ and arg_148_1.time_ < var_151_13 + var_151_20 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_13) / var_151_20

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_13 + var_151_20 and arg_148_1.time_ < var_151_13 + var_151_20 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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
	Play1102002036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1102002036
		arg_152_1.duration_ = 4.2

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1102002037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1089ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos1089ui_story = var_155_0.localPosition
			end

			local var_155_2 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2
				local var_155_4 = Vector3.New(0, -1.1, -6.17)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1089ui_story, var_155_4, var_155_3)

				local var_155_5 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_5.x, var_155_5.y, var_155_5.z)

				local var_155_6 = var_155_0.localEulerAngles

				var_155_6.z = 0
				var_155_6.x = 0
				var_155_0.localEulerAngles = var_155_6
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_155_7 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_7.x, var_155_7.y, var_155_7.z)

				local var_155_8 = var_155_0.localEulerAngles

				var_155_8.z = 0
				var_155_8.x = 0
				var_155_0.localEulerAngles = var_155_8
			end

			local var_155_9 = arg_152_1.actors_["1089ui_story"]
			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1089ui_story == nil then
				arg_152_1.var_.characterEffect1089ui_story = var_155_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_11 = 0.200000002980232

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_11 and not isNil(var_155_9) then
				local var_155_12 = (arg_152_1.time_ - var_155_10) / var_155_11

				if arg_152_1.var_.characterEffect1089ui_story and not isNil(var_155_9) then
					arg_152_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_10 + var_155_11 and arg_152_1.time_ < var_155_10 + var_155_11 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1089ui_story then
				arg_152_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_155_13 = 0

			if var_155_13 < arg_152_1.time_ and arg_152_1.time_ <= var_155_13 + arg_155_0 then
				arg_152_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			local var_155_14 = 0

			if var_155_14 < arg_152_1.time_ and arg_152_1.time_ <= var_155_14 + arg_155_0 then
				arg_152_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_155_15 = 0
			local var_155_16 = 0.35

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_17 = arg_152_1:FormatText(StoryNameCfg[1031].name)

				arg_152_1.leftNameTxt_.text = var_155_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_18 = arg_152_1:GetWordFromCfg(1102002036)
				local var_155_19 = arg_152_1:FormatText(var_155_18.content)

				arg_152_1.text_.text = var_155_19

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_20 = 14
				local var_155_21 = utf8.len(var_155_19)
				local var_155_22 = var_155_20 <= 0 and var_155_16 or var_155_16 * (var_155_21 / var_155_20)

				if var_155_22 > 0 and var_155_16 < var_155_22 then
					arg_152_1.talkMaxDuration = var_155_22

					if var_155_22 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_22 + var_155_15
					end
				end

				arg_152_1.text_.text = var_155_19
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002036", "story_v_side_new_1102002.awb") ~= 0 then
					local var_155_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002036", "story_v_side_new_1102002.awb") / 1000

					if var_155_23 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_23 + var_155_15
					end

					if var_155_18.prefab_name ~= "" and arg_152_1.actors_[var_155_18.prefab_name] ~= nil then
						local var_155_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_18.prefab_name].transform, "story_v_side_new_1102002", "1102002036", "story_v_side_new_1102002.awb")

						arg_152_1:RecordAudio("1102002036", var_155_24)
						arg_152_1:RecordAudio("1102002036", var_155_24)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002036", "story_v_side_new_1102002.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002036", "story_v_side_new_1102002.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_25 = math.max(var_155_16, arg_152_1.talkMaxDuration)

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_25 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_15) / var_155_25

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_15 + var_155_25 and arg_152_1.time_ < var_155_15 + var_155_25 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play1102002037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1102002037
		arg_156_1.duration_ = 10.23

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1102002038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = "ST0505"

			if arg_156_1.bgs_[var_159_0] == nil then
				local var_159_1 = Object.Instantiate(arg_156_1.paintGo_)

				var_159_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_159_0)
				var_159_1.name = var_159_0
				var_159_1.transform.parent = arg_156_1.stage_.transform
				var_159_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_[var_159_0] = var_159_1
			end

			local var_159_2 = 2

			if var_159_2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_2 + arg_159_0 then
				local var_159_3 = manager.ui.mainCamera.transform.localPosition
				local var_159_4 = Vector3.New(0, 0, 10) + Vector3.New(var_159_3.x, var_159_3.y, 0)
				local var_159_5 = arg_156_1.bgs_.ST0505

				var_159_5.transform.localPosition = var_159_4
				var_159_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_6 = var_159_5:GetComponent("SpriteRenderer")

				if var_159_6 and var_159_6.sprite then
					local var_159_7 = (var_159_5.transform.localPosition - var_159_3).z
					local var_159_8 = manager.ui.mainCameraCom_
					local var_159_9 = 2 * var_159_7 * Mathf.Tan(var_159_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_159_10 = var_159_9 * var_159_8.aspect
					local var_159_11 = var_159_6.sprite.bounds.size.x
					local var_159_12 = var_159_6.sprite.bounds.size.y
					local var_159_13 = var_159_10 / var_159_11
					local var_159_14 = var_159_9 / var_159_12
					local var_159_15 = var_159_14 < var_159_13 and var_159_13 or var_159_14

					var_159_5.transform.localScale = Vector3.New(var_159_15, var_159_15, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "ST0505" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_16 = 3.999999999999

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			local var_159_17 = 0.3

			if arg_156_1.time_ >= var_159_16 + var_159_17 and arg_156_1.time_ < var_159_16 + var_159_17 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end

			local var_159_18 = 0

			if var_159_18 < arg_156_1.time_ and arg_156_1.time_ <= var_159_18 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_19 = 2

			if var_159_18 <= arg_156_1.time_ and arg_156_1.time_ < var_159_18 + var_159_19 then
				local var_159_20 = (arg_156_1.time_ - var_159_18) / var_159_19
				local var_159_21 = Color.New(0, 0, 0)

				var_159_21.a = Mathf.Lerp(0, 1, var_159_20)
				arg_156_1.mask_.color = var_159_21
			end

			if arg_156_1.time_ >= var_159_18 + var_159_19 and arg_156_1.time_ < var_159_18 + var_159_19 + arg_159_0 then
				local var_159_22 = Color.New(0, 0, 0)

				var_159_22.a = 1
				arg_156_1.mask_.color = var_159_22
			end

			local var_159_23 = 2

			if var_159_23 < arg_156_1.time_ and arg_156_1.time_ <= var_159_23 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_24 = 2

			if var_159_23 <= arg_156_1.time_ and arg_156_1.time_ < var_159_23 + var_159_24 then
				local var_159_25 = (arg_156_1.time_ - var_159_23) / var_159_24
				local var_159_26 = Color.New(0, 0, 0)

				var_159_26.a = Mathf.Lerp(1, 0, var_159_25)
				arg_156_1.mask_.color = var_159_26
			end

			if arg_156_1.time_ >= var_159_23 + var_159_24 and arg_156_1.time_ < var_159_23 + var_159_24 + arg_159_0 then
				local var_159_27 = Color.New(0, 0, 0)
				local var_159_28 = 0

				arg_156_1.mask_.enabled = false
				var_159_27.a = var_159_28
				arg_156_1.mask_.color = var_159_27
			end

			local var_159_29 = arg_156_1.actors_["1089ui_story"].transform
			local var_159_30 = 1.96599999815226

			if var_159_30 < arg_156_1.time_ and arg_156_1.time_ <= var_159_30 + arg_159_0 then
				arg_156_1.var_.moveOldPos1089ui_story = var_159_29.localPosition
			end

			local var_159_31 = 0.001

			if var_159_30 <= arg_156_1.time_ and arg_156_1.time_ < var_159_30 + var_159_31 then
				local var_159_32 = (arg_156_1.time_ - var_159_30) / var_159_31
				local var_159_33 = Vector3.New(0, 100, 0)

				var_159_29.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1089ui_story, var_159_33, var_159_32)

				local var_159_34 = manager.ui.mainCamera.transform.position - var_159_29.position

				var_159_29.forward = Vector3.New(var_159_34.x, var_159_34.y, var_159_34.z)

				local var_159_35 = var_159_29.localEulerAngles

				var_159_35.z = 0
				var_159_35.x = 0
				var_159_29.localEulerAngles = var_159_35
			end

			if arg_156_1.time_ >= var_159_30 + var_159_31 and arg_156_1.time_ < var_159_30 + var_159_31 + arg_159_0 then
				var_159_29.localPosition = Vector3.New(0, 100, 0)

				local var_159_36 = manager.ui.mainCamera.transform.position - var_159_29.position

				var_159_29.forward = Vector3.New(var_159_36.x, var_159_36.y, var_159_36.z)

				local var_159_37 = var_159_29.localEulerAngles

				var_159_37.z = 0
				var_159_37.x = 0
				var_159_29.localEulerAngles = var_159_37
			end

			local var_159_38 = 2

			arg_156_1.isInRecall_ = false

			if var_159_38 < arg_156_1.time_ and arg_156_1.time_ <= var_159_38 + arg_159_0 then
				arg_156_1.screenFilterGo_:SetActive(true)

				arg_156_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_159_2, iter_159_3 in pairs(arg_156_1.actors_) do
					local var_159_39 = iter_159_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_159_4, iter_159_5 in ipairs(var_159_39) do
						if iter_159_5.color.r > 0.51 then
							iter_159_5.color = Color.New(1, 1, 1)
						else
							iter_159_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_159_40 = 0.2

			if var_159_38 <= arg_156_1.time_ and arg_156_1.time_ < var_159_38 + var_159_40 then
				local var_159_41 = (arg_156_1.time_ - var_159_38) / var_159_40

				arg_156_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_159_41)
			end

			if arg_156_1.time_ >= var_159_38 + var_159_40 and arg_156_1.time_ < var_159_38 + var_159_40 + arg_159_0 then
				arg_156_1.screenFilterEffect_.weight = 1
			end

			local var_159_42 = 0.366666666666667
			local var_159_43 = 1

			if var_159_42 < arg_156_1.time_ and arg_156_1.time_ <= var_159_42 + arg_159_0 then
				local var_159_44 = "stop"
				local var_159_45 = "effect"

				arg_156_1:AudioAction(var_159_44, var_159_45, "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			local var_159_46 = 1.63333333333333
			local var_159_47 = 1

			if var_159_46 < arg_156_1.time_ and arg_156_1.time_ <= var_159_46 + arg_159_0 then
				local var_159_48 = "play"
				local var_159_49 = "effect"

				arg_156_1:AudioAction(var_159_48, var_159_49, "se_story_140", "se_story_140_amb_room02", "")
			end

			if arg_156_1.frameCnt_ <= 1 then
				arg_156_1.dialog_:SetActive(false)
			end

			local var_159_50 = 3.999999999999
			local var_159_51 = 0.775

			if var_159_50 < arg_156_1.time_ and arg_156_1.time_ <= var_159_50 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				arg_156_1.dialog_:SetActive(true)

				arg_156_1.dialogCg_.alpha = 0

				local var_159_52 = LeanTween.value(arg_156_1.dialog_, 0, 1, 0.3)

				var_159_52:setOnUpdate(LuaHelper.FloatAction(function(arg_160_0)
					arg_156_1.dialogCg_.alpha = arg_160_0
				end))
				var_159_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_156_1.dialog_)
					var_159_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_156_1.duration_ = arg_156_1.duration_ + 0.3

				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_53 = arg_156_1:FormatText(StoryNameCfg[1031].name)

				arg_156_1.leftNameTxt_.text = var_159_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_156_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_159_54 = arg_156_1:GetWordFromCfg(1102002037)
				local var_159_55 = arg_156_1:FormatText(var_159_54.content)

				arg_156_1.text_.text = var_159_55

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_56 = 31
				local var_159_57 = utf8.len(var_159_55)
				local var_159_58 = var_159_56 <= 0 and var_159_51 or var_159_51 * (var_159_57 / var_159_56)

				if var_159_58 > 0 and var_159_51 < var_159_58 then
					arg_156_1.talkMaxDuration = var_159_58
					var_159_50 = var_159_50 + 0.3

					if var_159_58 + var_159_50 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_58 + var_159_50
					end
				end

				arg_156_1.text_.text = var_159_55
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002037", "story_v_side_new_1102002.awb") ~= 0 then
					local var_159_59 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002037", "story_v_side_new_1102002.awb") / 1000

					if var_159_59 + var_159_50 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_59 + var_159_50
					end

					if var_159_54.prefab_name ~= "" and arg_156_1.actors_[var_159_54.prefab_name] ~= nil then
						local var_159_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_54.prefab_name].transform, "story_v_side_new_1102002", "1102002037", "story_v_side_new_1102002.awb")

						arg_156_1:RecordAudio("1102002037", var_159_60)
						arg_156_1:RecordAudio("1102002037", var_159_60)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002037", "story_v_side_new_1102002.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002037", "story_v_side_new_1102002.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_61 = var_159_50 + 0.3
			local var_159_62 = math.max(var_159_51, arg_156_1.talkMaxDuration)

			if var_159_61 <= arg_156_1.time_ and arg_156_1.time_ < var_159_61 + var_159_62 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_61) / var_159_62

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_61 + var_159_62 and arg_156_1.time_ < var_159_61 + var_159_62 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play1102002038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1102002038
		arg_162_1.duration_ = 8.8

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1102002039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 2

			arg_162_1.isInRecall_ = false

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.screenFilterGo_:SetActive(false)

				for iter_165_0, iter_165_1 in pairs(arg_162_1.actors_) do
					local var_165_1 = iter_165_1:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_165_2, iter_165_3 in ipairs(var_165_1) do
						if iter_165_3.color.r > 0.51 then
							iter_165_3.color = Color.New(1, 1, 1)
						else
							iter_165_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_165_2 = 0.1833333

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_2 then
				local var_165_3 = (arg_162_1.time_ - var_165_0) / var_165_2

				arg_162_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_165_3)
			end

			if arg_162_1.time_ >= var_165_0 + var_165_2 and arg_162_1.time_ < var_165_0 + var_165_2 + arg_165_0 then
				arg_162_1.screenFilterEffect_.weight = 0
			end

			local var_165_4 = 0

			if var_165_4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_5 = 2

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_5 then
				local var_165_6 = (arg_162_1.time_ - var_165_4) / var_165_5
				local var_165_7 = Color.New(0, 0, 0)

				var_165_7.a = Mathf.Lerp(0, 1, var_165_6)
				arg_162_1.mask_.color = var_165_7
			end

			if arg_162_1.time_ >= var_165_4 + var_165_5 and arg_162_1.time_ < var_165_4 + var_165_5 + arg_165_0 then
				local var_165_8 = Color.New(0, 0, 0)

				var_165_8.a = 1
				arg_162_1.mask_.color = var_165_8
			end

			local var_165_9 = 2

			if var_165_9 < arg_162_1.time_ and arg_162_1.time_ <= var_165_9 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_10 = 2

			if var_165_9 <= arg_162_1.time_ and arg_162_1.time_ < var_165_9 + var_165_10 then
				local var_165_11 = (arg_162_1.time_ - var_165_9) / var_165_10
				local var_165_12 = Color.New(0, 0, 0)

				var_165_12.a = Mathf.Lerp(1, 0, var_165_11)
				arg_162_1.mask_.color = var_165_12
			end

			if arg_162_1.time_ >= var_165_9 + var_165_10 and arg_162_1.time_ < var_165_9 + var_165_10 + arg_165_0 then
				local var_165_13 = Color.New(0, 0, 0)
				local var_165_14 = 0

				arg_162_1.mask_.enabled = false
				var_165_13.a = var_165_14
				arg_162_1.mask_.color = var_165_13
			end

			if arg_162_1.frameCnt_ <= 1 then
				arg_162_1.dialog_:SetActive(false)
			end

			local var_165_15 = 3.8
			local var_165_16 = 1.725

			if var_165_15 < arg_162_1.time_ and arg_162_1.time_ <= var_165_15 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0

				arg_162_1.dialog_:SetActive(true)

				arg_162_1.dialogCg_.alpha = 0

				local var_165_17 = LeanTween.value(arg_162_1.dialog_, 0, 1, 0.3)

				var_165_17:setOnUpdate(LuaHelper.FloatAction(function(arg_166_0)
					arg_162_1.dialogCg_.alpha = arg_166_0
				end))
				var_165_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_162_1.dialog_)
					var_165_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_162_1.duration_ = arg_162_1.duration_ + 0.3

				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_18 = arg_162_1:GetWordFromCfg(1102002038)
				local var_165_19 = arg_162_1:FormatText(var_165_18.content)

				arg_162_1.text_.text = var_165_19

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_20 = 69
				local var_165_21 = utf8.len(var_165_19)
				local var_165_22 = var_165_20 <= 0 and var_165_16 or var_165_16 * (var_165_21 / var_165_20)

				if var_165_22 > 0 and var_165_16 < var_165_22 then
					arg_162_1.talkMaxDuration = var_165_22
					var_165_15 = var_165_15 + 0.3

					if var_165_22 + var_165_15 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_22 + var_165_15
					end
				end

				arg_162_1.text_.text = var_165_19
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_23 = var_165_15 + 0.3
			local var_165_24 = math.max(var_165_16, arg_162_1.talkMaxDuration)

			if var_165_23 <= arg_162_1.time_ and arg_162_1.time_ < var_165_23 + var_165_24 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_23) / var_165_24

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_23 + var_165_24 and arg_162_1.time_ < var_165_23 + var_165_24 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play1102002039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1102002039
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1102002040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.836552398744971
			local var_171_1 = 1

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				local var_171_2 = "play"
				local var_171_3 = "effect"

				arg_168_1:AudioAction(var_171_2, var_171_3, "se_story_side_1033", "se_story_1033_button", "")
			end

			local var_171_4 = 0
			local var_171_5 = 1.15

			if var_171_4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_6 = arg_168_1:GetWordFromCfg(1102002039)
				local var_171_7 = arg_168_1:FormatText(var_171_6.content)

				arg_168_1.text_.text = var_171_7

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_8 = 46
				local var_171_9 = utf8.len(var_171_7)
				local var_171_10 = var_171_8 <= 0 and var_171_5 or var_171_5 * (var_171_9 / var_171_8)

				if var_171_10 > 0 and var_171_5 < var_171_10 then
					arg_168_1.talkMaxDuration = var_171_10

					if var_171_10 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_10 + var_171_4
					end
				end

				arg_168_1.text_.text = var_171_7
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_11 = math.max(var_171_5, arg_168_1.talkMaxDuration)

			if var_171_4 <= arg_168_1.time_ and arg_168_1.time_ < var_171_4 + var_171_11 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_4) / var_171_11

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_4 + var_171_11 and arg_168_1.time_ < var_171_4 + var_171_11 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1102002040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1102002040
		arg_172_1.duration_ = 9

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1102002041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 2

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				local var_175_1 = manager.ui.mainCamera.transform.localPosition
				local var_175_2 = Vector3.New(0, 0, 10) + Vector3.New(var_175_1.x, var_175_1.y, 0)
				local var_175_3 = arg_172_1.bgs_.STblack

				var_175_3.transform.localPosition = var_175_2
				var_175_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_175_4 = var_175_3:GetComponent("SpriteRenderer")

				if var_175_4 and var_175_4.sprite then
					local var_175_5 = (var_175_3.transform.localPosition - var_175_1).z
					local var_175_6 = manager.ui.mainCameraCom_
					local var_175_7 = 2 * var_175_5 * Mathf.Tan(var_175_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_175_8 = var_175_7 * var_175_6.aspect
					local var_175_9 = var_175_4.sprite.bounds.size.x
					local var_175_10 = var_175_4.sprite.bounds.size.y
					local var_175_11 = var_175_8 / var_175_9
					local var_175_12 = var_175_7 / var_175_10
					local var_175_13 = var_175_12 < var_175_11 and var_175_11 or var_175_12

					var_175_3.transform.localScale = Vector3.New(var_175_13, var_175_13, 0)
				end

				for iter_175_0, iter_175_1 in pairs(arg_172_1.bgs_) do
					if iter_175_0 ~= "STblack" then
						iter_175_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_175_14 = 4

			if var_175_14 < arg_172_1.time_ and arg_172_1.time_ <= var_175_14 + arg_175_0 then
				arg_172_1.allBtn_.enabled = false
			end

			local var_175_15 = 0.3

			if arg_172_1.time_ >= var_175_14 + var_175_15 and arg_172_1.time_ < var_175_14 + var_175_15 + arg_175_0 then
				arg_172_1.allBtn_.enabled = true
			end

			local var_175_16 = 0

			if var_175_16 < arg_172_1.time_ and arg_172_1.time_ <= var_175_16 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_17 = 2

			if var_175_16 <= arg_172_1.time_ and arg_172_1.time_ < var_175_16 + var_175_17 then
				local var_175_18 = (arg_172_1.time_ - var_175_16) / var_175_17
				local var_175_19 = Color.New(0, 0, 0)

				var_175_19.a = Mathf.Lerp(0, 1, var_175_18)
				arg_172_1.mask_.color = var_175_19
			end

			if arg_172_1.time_ >= var_175_16 + var_175_17 and arg_172_1.time_ < var_175_16 + var_175_17 + arg_175_0 then
				local var_175_20 = Color.New(0, 0, 0)

				var_175_20.a = 1
				arg_172_1.mask_.color = var_175_20
			end

			local var_175_21 = 2

			if var_175_21 < arg_172_1.time_ and arg_172_1.time_ <= var_175_21 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_22 = 2

			if var_175_21 <= arg_172_1.time_ and arg_172_1.time_ < var_175_21 + var_175_22 then
				local var_175_23 = (arg_172_1.time_ - var_175_21) / var_175_22
				local var_175_24 = Color.New(0, 0, 0)

				var_175_24.a = Mathf.Lerp(1, 0, var_175_23)
				arg_172_1.mask_.color = var_175_24
			end

			if arg_172_1.time_ >= var_175_21 + var_175_22 and arg_172_1.time_ < var_175_21 + var_175_22 + arg_175_0 then
				local var_175_25 = Color.New(0, 0, 0)
				local var_175_26 = 0

				arg_172_1.mask_.enabled = false
				var_175_25.a = var_175_26
				arg_172_1.mask_.color = var_175_25
			end

			local var_175_27 = arg_172_1.actors_["1089ui_story"].transform
			local var_175_28 = 1.966

			if var_175_28 < arg_172_1.time_ and arg_172_1.time_ <= var_175_28 + arg_175_0 then
				arg_172_1.var_.moveOldPos1089ui_story = var_175_27.localPosition
			end

			local var_175_29 = 0.001

			if var_175_28 <= arg_172_1.time_ and arg_172_1.time_ < var_175_28 + var_175_29 then
				local var_175_30 = (arg_172_1.time_ - var_175_28) / var_175_29
				local var_175_31 = Vector3.New(0, 100, 0)

				var_175_27.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1089ui_story, var_175_31, var_175_30)

				local var_175_32 = manager.ui.mainCamera.transform.position - var_175_27.position

				var_175_27.forward = Vector3.New(var_175_32.x, var_175_32.y, var_175_32.z)

				local var_175_33 = var_175_27.localEulerAngles

				var_175_33.z = 0
				var_175_33.x = 0
				var_175_27.localEulerAngles = var_175_33
			end

			if arg_172_1.time_ >= var_175_28 + var_175_29 and arg_172_1.time_ < var_175_28 + var_175_29 + arg_175_0 then
				var_175_27.localPosition = Vector3.New(0, 100, 0)

				local var_175_34 = manager.ui.mainCamera.transform.position - var_175_27.position

				var_175_27.forward = Vector3.New(var_175_34.x, var_175_34.y, var_175_34.z)

				local var_175_35 = var_175_27.localEulerAngles

				var_175_35.z = 0
				var_175_35.x = 0
				var_175_27.localEulerAngles = var_175_35
			end

			local var_175_36 = 0.5
			local var_175_37 = 1

			if var_175_36 < arg_172_1.time_ and arg_172_1.time_ <= var_175_36 + arg_175_0 then
				local var_175_38 = "stop"
				local var_175_39 = "effect"

				arg_172_1:AudioAction(var_175_38, var_175_39, "se_story_140", "se_story_140_amb_room02", "")
			end

			local var_175_40 = 1.5
			local var_175_41 = 1

			if var_175_40 < arg_172_1.time_ and arg_172_1.time_ <= var_175_40 + arg_175_0 then
				local var_175_42 = "play"
				local var_175_43 = "effect"

				arg_172_1:AudioAction(var_175_42, var_175_43, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_175_44 = 0
			local var_175_45 = 0.2

			if var_175_44 < arg_172_1.time_ and arg_172_1.time_ <= var_175_44 + arg_175_0 then
				local var_175_46 = "play"
				local var_175_47 = "music"

				arg_172_1:AudioAction(var_175_46, var_175_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_175_48 = ""
				local var_175_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_175_49 ~= "" then
					if arg_172_1.bgmTxt_.text ~= var_175_49 and arg_172_1.bgmTxt_.text ~= "" then
						if arg_172_1.bgmTxt2_.text ~= "" then
							arg_172_1.bgmTxt_.text = arg_172_1.bgmTxt2_.text
						end

						arg_172_1.bgmTxt2_.text = var_175_49

						arg_172_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_172_1.bgmTxt_.text = var_175_49
						arg_172_1.bgmTxt2_.text = var_175_49
					end

					if arg_172_1.bgmTimer then
						arg_172_1.bgmTimer:Stop()

						arg_172_1.bgmTimer = nil
					end

					if arg_172_1.settingData.show_music_name == 1 then
						arg_172_1.musicController:SetSelectedState("show")
						arg_172_1.musicAnimator_:Play("open", 0, 0)

						if arg_172_1.settingData.music_time ~= 0 then
							arg_172_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_172_1.settingData.music_time), function()
								if arg_172_1 == nil or isNil(arg_172_1.bgmTxt_) then
									return
								end

								arg_172_1.musicController:SetSelectedState("hide")
								arg_172_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_172_1.frameCnt_ <= 1 then
				arg_172_1.dialog_:SetActive(false)
			end

			local var_175_50 = 4
			local var_175_51 = 0.25

			if var_175_50 < arg_172_1.time_ and arg_172_1.time_ <= var_175_50 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				arg_172_1.dialog_:SetActive(true)

				arg_172_1.dialogCg_.alpha = 0

				local var_175_52 = LeanTween.value(arg_172_1.dialog_, 0, 1, 0.3)

				var_175_52:setOnUpdate(LuaHelper.FloatAction(function(arg_177_0)
					arg_172_1.dialogCg_.alpha = arg_177_0
				end))
				var_175_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_172_1.dialog_)
					var_175_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_172_1.duration_ = arg_172_1.duration_ + 0.3

				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_53 = arg_172_1:GetWordFromCfg(1102002040)
				local var_175_54 = arg_172_1:FormatText(var_175_53.content)

				arg_172_1.text_.text = var_175_54

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_55 = 10
				local var_175_56 = utf8.len(var_175_54)
				local var_175_57 = var_175_55 <= 0 and var_175_51 or var_175_51 * (var_175_56 / var_175_55)

				if var_175_57 > 0 and var_175_51 < var_175_57 then
					arg_172_1.talkMaxDuration = var_175_57
					var_175_50 = var_175_50 + 0.3

					if var_175_57 + var_175_50 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_57 + var_175_50
					end
				end

				arg_172_1.text_.text = var_175_54
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_58 = var_175_50 + 0.3
			local var_175_59 = math.max(var_175_51, arg_172_1.talkMaxDuration)

			if var_175_58 <= arg_172_1.time_ and arg_172_1.time_ < var_175_58 + var_175_59 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_58) / var_175_59

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_58 + var_175_59 and arg_172_1.time_ < var_175_58 + var_175_59 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play1102002041 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1102002041
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1102002042(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 1.25

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

				local var_182_2 = arg_179_1:GetWordFromCfg(1102002041)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 50
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
	Play1102002042 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1102002042
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1102002043(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.275

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_2 = arg_183_1:GetWordFromCfg(1102002042)
				local var_186_3 = arg_183_1:FormatText(var_186_2.content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 11
				local var_186_5 = utf8.len(var_186_3)
				local var_186_6 = var_186_4 <= 0 and var_186_1 or var_186_1 * (var_186_5 / var_186_4)

				if var_186_6 > 0 and var_186_1 < var_186_6 then
					arg_183_1.talkMaxDuration = var_186_6

					if var_186_6 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_7 and arg_183_1.time_ < var_186_0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1102002043 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1102002043
		arg_187_1.duration_ = 2.57

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1102002044(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.275

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[36].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:GetWordFromCfg(1102002043)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 11
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_1 or var_190_1 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_1 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002043", "story_v_side_new_1102002.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002043", "story_v_side_new_1102002.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_side_new_1102002", "1102002043", "story_v_side_new_1102002.awb")

						arg_187_1:RecordAudio("1102002043", var_190_9)
						arg_187_1:RecordAudio("1102002043", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002043", "story_v_side_new_1102002.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002043", "story_v_side_new_1102002.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_10 and arg_187_1.time_ < var_190_0 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1102002044 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1102002044
		arg_191_1.duration_ = 5.73

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1102002045(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = "L02h"

			if arg_191_1.bgs_[var_194_0] == nil then
				local var_194_1 = Object.Instantiate(arg_191_1.paintGo_)

				var_194_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_194_0)
				var_194_1.name = var_194_0
				var_194_1.transform.parent = arg_191_1.stage_.transform
				var_194_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.bgs_[var_194_0] = var_194_1
			end

			local var_194_2 = 0

			if var_194_2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				local var_194_3 = manager.ui.mainCamera.transform.localPosition
				local var_194_4 = Vector3.New(0, 0, 10) + Vector3.New(var_194_3.x, var_194_3.y, 0)
				local var_194_5 = arg_191_1.bgs_.L02h

				var_194_5.transform.localPosition = var_194_4
				var_194_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_6 = var_194_5:GetComponent("SpriteRenderer")

				if var_194_6 and var_194_6.sprite then
					local var_194_7 = (var_194_5.transform.localPosition - var_194_3).z
					local var_194_8 = manager.ui.mainCameraCom_
					local var_194_9 = 2 * var_194_7 * Mathf.Tan(var_194_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_194_10 = var_194_9 * var_194_8.aspect
					local var_194_11 = var_194_6.sprite.bounds.size.x
					local var_194_12 = var_194_6.sprite.bounds.size.y
					local var_194_13 = var_194_10 / var_194_11
					local var_194_14 = var_194_9 / var_194_12
					local var_194_15 = var_194_14 < var_194_13 and var_194_13 or var_194_14

					var_194_5.transform.localScale = Vector3.New(var_194_15, var_194_15, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "L02h" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_16 = 2.00000000298023

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1.allBtn_.enabled = false
			end

			local var_194_17 = 0.3

			if arg_191_1.time_ >= var_194_16 + var_194_17 and arg_191_1.time_ < var_194_16 + var_194_17 + arg_194_0 then
				arg_191_1.allBtn_.enabled = true
			end

			local var_194_18 = 0

			if var_194_18 < arg_191_1.time_ and arg_191_1.time_ <= var_194_18 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_19 = 2

			if var_194_18 <= arg_191_1.time_ and arg_191_1.time_ < var_194_18 + var_194_19 then
				local var_194_20 = (arg_191_1.time_ - var_194_18) / var_194_19
				local var_194_21 = Color.New(0, 0, 0)

				var_194_21.a = Mathf.Lerp(1, 0, var_194_20)
				arg_191_1.mask_.color = var_194_21
			end

			if arg_191_1.time_ >= var_194_18 + var_194_19 and arg_191_1.time_ < var_194_18 + var_194_19 + arg_194_0 then
				local var_194_22 = Color.New(0, 0, 0)
				local var_194_23 = 0

				arg_191_1.mask_.enabled = false
				var_194_22.a = var_194_23
				arg_191_1.mask_.color = var_194_22
			end

			local var_194_24 = "1020ui_story"

			if arg_191_1.actors_[var_194_24] == nil then
				local var_194_25 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_194_25) then
					local var_194_26 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_191_1.stage_.transform)

					var_194_26.name = var_194_24
					var_194_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_191_1.actors_[var_194_24] = var_194_26

					local var_194_27 = var_194_26:GetComponentInChildren(typeof(CharacterEffect))

					var_194_27.enabled = true

					local var_194_28 = GameObjectTools.GetOrAddComponent(var_194_26, typeof(DynamicBoneHelper))

					if var_194_28 then
						var_194_28:EnableDynamicBone(false)
					end

					arg_191_1:ShowWeapon(var_194_27.transform, false)

					arg_191_1.var_[var_194_24 .. "Animator"] = var_194_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_191_1.var_[var_194_24 .. "Animator"].applyRootMotion = true
					arg_191_1.var_[var_194_24 .. "LipSync"] = var_194_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_194_29 = arg_191_1.actors_["1020ui_story"].transform
			local var_194_30 = 1.8

			if var_194_30 < arg_191_1.time_ and arg_191_1.time_ <= var_194_30 + arg_194_0 then
				arg_191_1.var_.moveOldPos1020ui_story = var_194_29.localPosition
			end

			local var_194_31 = 0.001

			if var_194_30 <= arg_191_1.time_ and arg_191_1.time_ < var_194_30 + var_194_31 then
				local var_194_32 = (arg_191_1.time_ - var_194_30) / var_194_31
				local var_194_33 = Vector3.New(0, -0.85, -6.25)

				var_194_29.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1020ui_story, var_194_33, var_194_32)

				local var_194_34 = manager.ui.mainCamera.transform.position - var_194_29.position

				var_194_29.forward = Vector3.New(var_194_34.x, var_194_34.y, var_194_34.z)

				local var_194_35 = var_194_29.localEulerAngles

				var_194_35.z = 0
				var_194_35.x = 0
				var_194_29.localEulerAngles = var_194_35
			end

			if arg_191_1.time_ >= var_194_30 + var_194_31 and arg_191_1.time_ < var_194_30 + var_194_31 + arg_194_0 then
				var_194_29.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_194_36 = manager.ui.mainCamera.transform.position - var_194_29.position

				var_194_29.forward = Vector3.New(var_194_36.x, var_194_36.y, var_194_36.z)

				local var_194_37 = var_194_29.localEulerAngles

				var_194_37.z = 0
				var_194_37.x = 0
				var_194_29.localEulerAngles = var_194_37
			end

			local var_194_38 = arg_191_1.actors_["1020ui_story"]
			local var_194_39 = 1.8

			if var_194_39 < arg_191_1.time_ and arg_191_1.time_ <= var_194_39 + arg_194_0 and not isNil(var_194_38) and arg_191_1.var_.characterEffect1020ui_story == nil then
				arg_191_1.var_.characterEffect1020ui_story = var_194_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_40 = 0.200000002980232

			if var_194_39 <= arg_191_1.time_ and arg_191_1.time_ < var_194_39 + var_194_40 and not isNil(var_194_38) then
				local var_194_41 = (arg_191_1.time_ - var_194_39) / var_194_40

				if arg_191_1.var_.characterEffect1020ui_story and not isNil(var_194_38) then
					arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_39 + var_194_40 and arg_191_1.time_ < var_194_39 + var_194_40 + arg_194_0 and not isNil(var_194_38) and arg_191_1.var_.characterEffect1020ui_story then
				arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_194_42 = 1.8

			if var_194_42 < arg_191_1.time_ and arg_191_1.time_ <= var_194_42 + arg_194_0 then
				arg_191_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_194_43 = 1.8

			if var_194_43 < arg_191_1.time_ and arg_191_1.time_ <= var_194_43 + arg_194_0 then
				arg_191_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_194_44 = 0
			local var_194_45 = 1

			if var_194_44 < arg_191_1.time_ and arg_191_1.time_ <= var_194_44 + arg_194_0 then
				local var_194_46 = "stop"
				local var_194_47 = "effect"

				arg_191_1:AudioAction(var_194_46, var_194_47, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_194_48 = 0.125
			local var_194_49 = 1

			if var_194_48 < arg_191_1.time_ and arg_191_1.time_ <= var_194_48 + arg_194_0 then
				local var_194_50 = "play"
				local var_194_51 = "effect"

				arg_191_1:AudioAction(var_194_50, var_194_51, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_194_52 = 0
			local var_194_53 = 0.2

			if var_194_52 < arg_191_1.time_ and arg_191_1.time_ <= var_194_52 + arg_194_0 then
				local var_194_54 = "play"
				local var_194_55 = "music"

				arg_191_1:AudioAction(var_194_54, var_194_55, "ui_battle", "ui_battle_stopbgm", "")

				local var_194_56 = ""
				local var_194_57 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_194_57 ~= "" then
					if arg_191_1.bgmTxt_.text ~= var_194_57 and arg_191_1.bgmTxt_.text ~= "" then
						if arg_191_1.bgmTxt2_.text ~= "" then
							arg_191_1.bgmTxt_.text = arg_191_1.bgmTxt2_.text
						end

						arg_191_1.bgmTxt2_.text = var_194_57

						arg_191_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_191_1.bgmTxt_.text = var_194_57
						arg_191_1.bgmTxt2_.text = var_194_57
					end

					if arg_191_1.bgmTimer then
						arg_191_1.bgmTimer:Stop()

						arg_191_1.bgmTimer = nil
					end

					if arg_191_1.settingData.show_music_name == 1 then
						arg_191_1.musicController:SetSelectedState("show")
						arg_191_1.musicAnimator_:Play("open", 0, 0)

						if arg_191_1.settingData.music_time ~= 0 then
							arg_191_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_191_1.settingData.music_time), function()
								if arg_191_1 == nil or isNil(arg_191_1.bgmTxt_) then
									return
								end

								arg_191_1.musicController:SetSelectedState("hide")
								arg_191_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_194_58 = 0.4
			local var_194_59 = 1

			if var_194_58 < arg_191_1.time_ and arg_191_1.time_ <= var_194_58 + arg_194_0 then
				local var_194_60 = "play"
				local var_194_61 = "music"

				arg_191_1:AudioAction(var_194_60, var_194_61, "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic.awb")

				local var_194_62 = ""
				local var_194_63 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic")

				if var_194_63 ~= "" then
					if arg_191_1.bgmTxt_.text ~= var_194_63 and arg_191_1.bgmTxt_.text ~= "" then
						if arg_191_1.bgmTxt2_.text ~= "" then
							arg_191_1.bgmTxt_.text = arg_191_1.bgmTxt2_.text
						end

						arg_191_1.bgmTxt2_.text = var_194_63

						arg_191_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_191_1.bgmTxt_.text = var_194_63
						arg_191_1.bgmTxt2_.text = var_194_63
					end

					if arg_191_1.bgmTimer then
						arg_191_1.bgmTimer:Stop()

						arg_191_1.bgmTimer = nil
					end

					if arg_191_1.settingData.show_music_name == 1 then
						arg_191_1.musicController:SetSelectedState("show")
						arg_191_1.musicAnimator_:Play("open", 0, 0)

						if arg_191_1.settingData.music_time ~= 0 then
							arg_191_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_191_1.settingData.music_time), function()
								if arg_191_1 == nil or isNil(arg_191_1.bgmTxt_) then
									return
								end

								arg_191_1.musicController:SetSelectedState("hide")
								arg_191_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_191_1.frameCnt_ <= 1 then
				arg_191_1.dialog_:SetActive(false)
			end

			local var_194_64 = 2
			local var_194_65 = 0.5

			if var_194_64 < arg_191_1.time_ and arg_191_1.time_ <= var_194_64 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				arg_191_1.dialog_:SetActive(true)

				arg_191_1.dialogCg_.alpha = 0

				local var_194_66 = LeanTween.value(arg_191_1.dialog_, 0, 1, 0.3)

				var_194_66:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_191_1.dialogCg_.alpha = arg_197_0
				end))
				var_194_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_191_1.dialog_)
					var_194_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_191_1.duration_ = arg_191_1.duration_ + 0.3

				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_67 = arg_191_1:FormatText(StoryNameCfg[613].name)

				arg_191_1.leftNameTxt_.text = var_194_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_68 = arg_191_1:GetWordFromCfg(1102002044)
				local var_194_69 = arg_191_1:FormatText(var_194_68.content)

				arg_191_1.text_.text = var_194_69

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_70 = 20
				local var_194_71 = utf8.len(var_194_69)
				local var_194_72 = var_194_70 <= 0 and var_194_65 or var_194_65 * (var_194_71 / var_194_70)

				if var_194_72 > 0 and var_194_65 < var_194_72 then
					arg_191_1.talkMaxDuration = var_194_72
					var_194_64 = var_194_64 + 0.3

					if var_194_72 + var_194_64 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_72 + var_194_64
					end
				end

				arg_191_1.text_.text = var_194_69
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002044", "story_v_side_new_1102002.awb") ~= 0 then
					local var_194_73 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002044", "story_v_side_new_1102002.awb") / 1000

					if var_194_73 + var_194_64 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_73 + var_194_64
					end

					if var_194_68.prefab_name ~= "" and arg_191_1.actors_[var_194_68.prefab_name] ~= nil then
						local var_194_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_68.prefab_name].transform, "story_v_side_new_1102002", "1102002044", "story_v_side_new_1102002.awb")

						arg_191_1:RecordAudio("1102002044", var_194_74)
						arg_191_1:RecordAudio("1102002044", var_194_74)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002044", "story_v_side_new_1102002.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002044", "story_v_side_new_1102002.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_75 = var_194_64 + 0.3
			local var_194_76 = math.max(var_194_65, arg_191_1.talkMaxDuration)

			if var_194_75 <= arg_191_1.time_ and arg_191_1.time_ < var_194_75 + var_194_76 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_75) / var_194_76

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_75 + var_194_76 and arg_191_1.time_ < var_194_75 + var_194_76 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play1102002045 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1102002045
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1102002046(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1020ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1020ui_story == nil then
				arg_199_1.var_.characterEffect1020ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1020ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1020ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1020ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1020ui_story.fillRatio = var_202_5
			end

			local var_202_6 = 0
			local var_202_7 = 0.2

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_8 = arg_199_1:FormatText(StoryNameCfg[7].name)

				arg_199_1.leftNameTxt_.text = var_202_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_9 = arg_199_1:GetWordFromCfg(1102002045)
				local var_202_10 = arg_199_1:FormatText(var_202_9.content)

				arg_199_1.text_.text = var_202_10

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 8
				local var_202_12 = utf8.len(var_202_10)
				local var_202_13 = var_202_11 <= 0 and var_202_7 or var_202_7 * (var_202_12 / var_202_11)

				if var_202_13 > 0 and var_202_7 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_10
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_14 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_14 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_14

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_14 and arg_199_1.time_ < var_202_6 + var_202_14 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1102002046 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1102002046
		arg_203_1.duration_ = 5.03

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1102002047(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1020ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1020ui_story == nil then
				arg_203_1.var_.characterEffect1020ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1020ui_story and not isNil(var_206_0) then
					arg_203_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1020ui_story then
				arg_203_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_206_4 = 0

			if var_206_4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action464")
			end

			local var_206_5 = 0

			if var_206_5 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_206_6 = 0
			local var_206_7 = 0.625

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_8 = arg_203_1:FormatText(StoryNameCfg[613].name)

				arg_203_1.leftNameTxt_.text = var_206_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_9 = arg_203_1:GetWordFromCfg(1102002046)
				local var_206_10 = arg_203_1:FormatText(var_206_9.content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 25
				local var_206_12 = utf8.len(var_206_10)
				local var_206_13 = var_206_11 <= 0 and var_206_7 or var_206_7 * (var_206_12 / var_206_11)

				if var_206_13 > 0 and var_206_7 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_10
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002046", "story_v_side_new_1102002.awb") ~= 0 then
					local var_206_14 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002046", "story_v_side_new_1102002.awb") / 1000

					if var_206_14 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_14 + var_206_6
					end

					if var_206_9.prefab_name ~= "" and arg_203_1.actors_[var_206_9.prefab_name] ~= nil then
						local var_206_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_9.prefab_name].transform, "story_v_side_new_1102002", "1102002046", "story_v_side_new_1102002.awb")

						arg_203_1:RecordAudio("1102002046", var_206_15)
						arg_203_1:RecordAudio("1102002046", var_206_15)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002046", "story_v_side_new_1102002.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002046", "story_v_side_new_1102002.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_16 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_16 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_16

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_16 and arg_203_1.time_ < var_206_6 + var_206_16 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1102002047 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1102002047
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1102002048(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1020ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1020ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0, 100, 0)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1020ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, 100, 0)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["1020ui_story"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1020ui_story == nil then
				arg_207_1.var_.characterEffect1020ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 and not isNil(var_210_9) then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect1020ui_story and not isNil(var_210_9) then
					local var_210_13 = Mathf.Lerp(0, 0.5, var_210_12)

					arg_207_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1020ui_story.fillRatio = var_210_13
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1020ui_story then
				local var_210_14 = 0.5

				arg_207_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1020ui_story.fillRatio = var_210_14
			end

			local var_210_15 = 0
			local var_210_16 = 1

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_17 = arg_207_1:GetWordFromCfg(1102002047)
				local var_210_18 = arg_207_1:FormatText(var_210_17.content)

				arg_207_1.text_.text = var_210_18

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_19 = 40
				local var_210_20 = utf8.len(var_210_18)
				local var_210_21 = var_210_19 <= 0 and var_210_16 or var_210_16 * (var_210_20 / var_210_19)

				if var_210_21 > 0 and var_210_16 < var_210_21 then
					arg_207_1.talkMaxDuration = var_210_21

					if var_210_21 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_21 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_18
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_22 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_22 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_15) / var_210_22

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_15 + var_210_22 and arg_207_1.time_ < var_210_15 + var_210_22 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play1102002048 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1102002048
		arg_211_1.duration_ = 4.2

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1102002049(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1020ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1020ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, -0.85, -6.25)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1020ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = arg_211_1.actors_["1020ui_story"]
			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1020ui_story == nil then
				arg_211_1.var_.characterEffect1020ui_story = var_214_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_11 = 0.200000002980232

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_11 and not isNil(var_214_9) then
				local var_214_12 = (arg_211_1.time_ - var_214_10) / var_214_11

				if arg_211_1.var_.characterEffect1020ui_story and not isNil(var_214_9) then
					arg_211_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_10 + var_214_11 and arg_211_1.time_ < var_214_10 + var_214_11 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1020ui_story then
				arg_211_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_214_13 = 0

			if var_214_13 < arg_211_1.time_ and arg_211_1.time_ <= var_214_13 + arg_214_0 then
				arg_211_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			local var_214_14 = 0

			if var_214_14 < arg_211_1.time_ and arg_211_1.time_ <= var_214_14 + arg_214_0 then
				arg_211_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_214_15 = 0
			local var_214_16 = 0.45

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_17 = arg_211_1:FormatText(StoryNameCfg[613].name)

				arg_211_1.leftNameTxt_.text = var_214_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_18 = arg_211_1:GetWordFromCfg(1102002048)
				local var_214_19 = arg_211_1:FormatText(var_214_18.content)

				arg_211_1.text_.text = var_214_19

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_20 = 18
				local var_214_21 = utf8.len(var_214_19)
				local var_214_22 = var_214_20 <= 0 and var_214_16 or var_214_16 * (var_214_21 / var_214_20)

				if var_214_22 > 0 and var_214_16 < var_214_22 then
					arg_211_1.talkMaxDuration = var_214_22

					if var_214_22 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_22 + var_214_15
					end
				end

				arg_211_1.text_.text = var_214_19
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002048", "story_v_side_new_1102002.awb") ~= 0 then
					local var_214_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002048", "story_v_side_new_1102002.awb") / 1000

					if var_214_23 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_23 + var_214_15
					end

					if var_214_18.prefab_name ~= "" and arg_211_1.actors_[var_214_18.prefab_name] ~= nil then
						local var_214_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_18.prefab_name].transform, "story_v_side_new_1102002", "1102002048", "story_v_side_new_1102002.awb")

						arg_211_1:RecordAudio("1102002048", var_214_24)
						arg_211_1:RecordAudio("1102002048", var_214_24)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002048", "story_v_side_new_1102002.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002048", "story_v_side_new_1102002.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_25 = math.max(var_214_16, arg_211_1.talkMaxDuration)

			if var_214_15 <= arg_211_1.time_ and arg_211_1.time_ < var_214_15 + var_214_25 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_15) / var_214_25

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_15 + var_214_25 and arg_211_1.time_ < var_214_15 + var_214_25 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play1102002049 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1102002049
		arg_215_1.duration_ = 5.73

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1102002050(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				local var_218_1 = manager.ui.mainCamera.transform.localPosition
				local var_218_2 = Vector3.New(0, 0, 10) + Vector3.New(var_218_1.x, var_218_1.y, 0)
				local var_218_3 = arg_215_1.bgs_.L02h

				var_218_3.transform.localPosition = var_218_2
				var_218_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_4 = var_218_3:GetComponent("SpriteRenderer")

				if var_218_4 and var_218_4.sprite then
					local var_218_5 = (var_218_3.transform.localPosition - var_218_1).z
					local var_218_6 = manager.ui.mainCameraCom_
					local var_218_7 = 2 * var_218_5 * Mathf.Tan(var_218_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_218_8 = var_218_7 * var_218_6.aspect
					local var_218_9 = var_218_4.sprite.bounds.size.x
					local var_218_10 = var_218_4.sprite.bounds.size.y
					local var_218_11 = var_218_8 / var_218_9
					local var_218_12 = var_218_7 / var_218_10
					local var_218_13 = var_218_12 < var_218_11 and var_218_11 or var_218_12

					var_218_3.transform.localScale = Vector3.New(var_218_13, var_218_13, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "L02h" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_14 = "H03b"

			if arg_215_1.bgs_[var_218_14] == nil then
				local var_218_15 = Object.Instantiate(arg_215_1.paintGo_)

				var_218_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_218_14)
				var_218_15.name = var_218_14
				var_218_15.transform.parent = arg_215_1.stage_.transform
				var_218_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.bgs_[var_218_14] = var_218_15
			end

			local var_218_16 = 1.50066666851441

			if var_218_16 < arg_215_1.time_ and arg_215_1.time_ <= var_218_16 + arg_218_0 then
				local var_218_17 = manager.ui.mainCamera.transform.localPosition
				local var_218_18 = Vector3.New(0, 0, 10) + Vector3.New(var_218_17.x, var_218_17.y, 0)
				local var_218_19 = arg_215_1.bgs_.H03b

				var_218_19.transform.localPosition = var_218_18
				var_218_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_20 = var_218_19:GetComponent("SpriteRenderer")

				if var_218_20 and var_218_20.sprite then
					local var_218_21 = (var_218_19.transform.localPosition - var_218_17).z
					local var_218_22 = manager.ui.mainCameraCom_
					local var_218_23 = 2 * var_218_21 * Mathf.Tan(var_218_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_218_24 = var_218_23 * var_218_22.aspect
					local var_218_25 = var_218_20.sprite.bounds.size.x
					local var_218_26 = var_218_20.sprite.bounds.size.y
					local var_218_27 = var_218_24 / var_218_25
					local var_218_28 = var_218_23 / var_218_26
					local var_218_29 = var_218_28 < var_218_27 and var_218_27 or var_218_28

					var_218_19.transform.localScale = Vector3.New(var_218_29, var_218_29, 0)
				end

				for iter_218_2, iter_218_3 in pairs(arg_215_1.bgs_) do
					if iter_218_2 ~= "H03b" then
						iter_218_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_30 = 3.00066666851441

			if var_218_30 < arg_215_1.time_ and arg_215_1.time_ <= var_218_30 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			local var_218_31 = 0.3

			if arg_215_1.time_ >= var_218_30 + var_218_31 and arg_215_1.time_ < var_218_30 + var_218_31 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			local var_218_32 = 3.00066666851441

			if var_218_32 < arg_215_1.time_ and arg_215_1.time_ <= var_218_32 + arg_218_0 then
				arg_215_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_218_33 = 3.00066666851441

			if var_218_33 < arg_215_1.time_ and arg_215_1.time_ <= var_218_33 + arg_218_0 then
				arg_215_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_218_34 = arg_215_1.actors_["1020ui_story"].transform
			local var_218_35 = 1.18333333333333

			if var_218_35 < arg_215_1.time_ and arg_215_1.time_ <= var_218_35 + arg_218_0 then
				arg_215_1.var_.moveOldPos1020ui_story = var_218_34.localPosition
			end

			local var_218_36 = 0.001

			if var_218_35 <= arg_215_1.time_ and arg_215_1.time_ < var_218_35 + var_218_36 then
				local var_218_37 = (arg_215_1.time_ - var_218_35) / var_218_36
				local var_218_38 = Vector3.New(0, 100, 0)

				var_218_34.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1020ui_story, var_218_38, var_218_37)

				local var_218_39 = manager.ui.mainCamera.transform.position - var_218_34.position

				var_218_34.forward = Vector3.New(var_218_39.x, var_218_39.y, var_218_39.z)

				local var_218_40 = var_218_34.localEulerAngles

				var_218_40.z = 0
				var_218_40.x = 0
				var_218_34.localEulerAngles = var_218_40
			end

			if arg_215_1.time_ >= var_218_35 + var_218_36 and arg_215_1.time_ < var_218_35 + var_218_36 + arg_218_0 then
				var_218_34.localPosition = Vector3.New(0, 100, 0)

				local var_218_41 = manager.ui.mainCamera.transform.position - var_218_34.position

				var_218_34.forward = Vector3.New(var_218_41.x, var_218_41.y, var_218_41.z)

				local var_218_42 = var_218_34.localEulerAngles

				var_218_42.z = 0
				var_218_42.x = 0
				var_218_34.localEulerAngles = var_218_42
			end

			local var_218_43 = arg_215_1.actors_["1020ui_story"].transform
			local var_218_44 = 3.06733333518108

			if var_218_44 < arg_215_1.time_ and arg_215_1.time_ <= var_218_44 + arg_218_0 then
				arg_215_1.var_.moveOldPos1020ui_story = var_218_43.localPosition
			end

			local var_218_45 = 0.001

			if var_218_44 <= arg_215_1.time_ and arg_215_1.time_ < var_218_44 + var_218_45 then
				local var_218_46 = (arg_215_1.time_ - var_218_44) / var_218_45
				local var_218_47 = Vector3.New(0, -0.85, -6.25)

				var_218_43.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1020ui_story, var_218_47, var_218_46)

				local var_218_48 = manager.ui.mainCamera.transform.position - var_218_43.position

				var_218_43.forward = Vector3.New(var_218_48.x, var_218_48.y, var_218_48.z)

				local var_218_49 = var_218_43.localEulerAngles

				var_218_49.z = 0
				var_218_49.x = 0
				var_218_43.localEulerAngles = var_218_49
			end

			if arg_215_1.time_ >= var_218_44 + var_218_45 and arg_215_1.time_ < var_218_44 + var_218_45 + arg_218_0 then
				var_218_43.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_218_50 = manager.ui.mainCamera.transform.position - var_218_43.position

				var_218_43.forward = Vector3.New(var_218_50.x, var_218_50.y, var_218_50.z)

				local var_218_51 = var_218_43.localEulerAngles

				var_218_51.z = 0
				var_218_51.x = 0
				var_218_43.localEulerAngles = var_218_51
			end

			local var_218_52 = manager.ui.mainCamera.transform
			local var_218_53 = 0

			if var_218_53 < arg_215_1.time_ and arg_215_1.time_ <= var_218_53 + arg_218_0 then
				local var_218_54 = arg_215_1.var_.effect213213231213213
				local var_218_55
				local var_218_56 = var_218_52

				if not var_218_54 then
					var_218_54 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_218_56)
					var_218_54.name = "213213231213213"
					arg_215_1.var_.effect213213231213213 = var_218_54
				else
					var_218_54.transform:SetParent(var_218_56)
				end

				var_218_54.transform.localPosition = Vector3.New(0, 0, 0)
				var_218_54.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_218_57 = manager.ui.mainCameraCom_
				local var_218_58 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_218_57.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_218_59 = var_218_54.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_218_60 = 15
				local var_218_61 = 2 * var_218_60 * Mathf.Tan(var_218_57.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_218_57.aspect
				local var_218_62 = 1
				local var_218_63 = 1.7777777777777777

				if var_218_63 < var_218_57.aspect then
					var_218_62 = var_218_61 / (2 * var_218_60 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_218_63)
				end

				for iter_218_4, iter_218_5 in ipairs(var_218_59) do
					local var_218_64 = iter_218_5.transform.localScale

					iter_218_5.transform.localScale = Vector3.New(var_218_64.x / var_218_58 * var_218_62, var_218_64.y / var_218_58, var_218_64.z)
				end
			end

			local var_218_65 = manager.ui.mainCamera.transform
			local var_218_66 = 1.50066666851441

			if var_218_66 < arg_215_1.time_ and arg_215_1.time_ <= var_218_66 + arg_218_0 then
				local var_218_67 = arg_215_1.var_.effect213213231213213

				if var_218_67 then
					Object.Destroy(var_218_67)

					arg_215_1.var_.effect213213231213213 = nil
				end
			end

			local var_218_68 = manager.ui.mainCamera.transform
			local var_218_69 = 1.50066666851441

			if var_218_69 < arg_215_1.time_ and arg_215_1.time_ <= var_218_69 + arg_218_0 then
				local var_218_70 = arg_215_1.var_.effect213222222123213
				local var_218_71
				local var_218_72 = var_218_68

				if not var_218_70 then
					var_218_70 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_218_72)
					var_218_70.name = "213222222123213"
					arg_215_1.var_.effect213222222123213 = var_218_70
				else
					var_218_70.transform:SetParent(var_218_72)
				end

				var_218_70.transform.localPosition = Vector3.New(0, 0, 0)
				var_218_70.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_218_73 = manager.ui.mainCameraCom_
				local var_218_74 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_218_73.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_218_75 = var_218_70.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_218_76 = 15
				local var_218_77 = 2 * var_218_76 * Mathf.Tan(var_218_73.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_218_73.aspect
				local var_218_78 = 1
				local var_218_79 = 1.7777777777777777

				if var_218_79 < var_218_73.aspect then
					var_218_78 = var_218_77 / (2 * var_218_76 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_218_79)
				end

				for iter_218_6, iter_218_7 in ipairs(var_218_75) do
					local var_218_80 = iter_218_7.transform.localScale

					iter_218_7.transform.localScale = Vector3.New(var_218_80.x / var_218_74 * var_218_78, var_218_80.y / var_218_74, var_218_80.z)
				end
			end

			local var_218_81 = 0.183333333333333
			local var_218_82 = 1

			if var_218_81 < arg_215_1.time_ and arg_215_1.time_ <= var_218_81 + arg_218_0 then
				local var_218_83 = "stop"
				local var_218_84 = "effect"

				arg_215_1:AudioAction(var_218_83, var_218_84, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_218_85 = 1.50066666851441
			local var_218_86 = 1

			if var_218_85 < arg_215_1.time_ and arg_215_1.time_ <= var_218_85 + arg_218_0 then
				local var_218_87 = "play"
				local var_218_88 = "effect"

				arg_215_1:AudioAction(var_218_87, var_218_88, "se_story_side_1020", "se_story_side_1020_amb_river", "")
			end

			local var_218_89 = 0
			local var_218_90 = 1

			if var_218_89 < arg_215_1.time_ and arg_215_1.time_ <= var_218_89 + arg_218_0 then
				local var_218_91 = "play"
				local var_218_92 = "effect"

				arg_215_1:AudioAction(var_218_91, var_218_92, "se_story_side_1020", "se_story_side_1020_whoosh", "")
			end

			if arg_215_1.frameCnt_ <= 1 then
				arg_215_1.dialog_:SetActive(false)
			end

			local var_218_93 = 3.00066666851441
			local var_218_94 = 0.125

			if var_218_93 < arg_215_1.time_ and arg_215_1.time_ <= var_218_93 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_95 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_95:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_95:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_95:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_96 = arg_215_1:FormatText(StoryNameCfg[613].name)

				arg_215_1.leftNameTxt_.text = var_218_96

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_97 = arg_215_1:GetWordFromCfg(1102002049)
				local var_218_98 = arg_215_1:FormatText(var_218_97.content)

				arg_215_1.text_.text = var_218_98

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_99 = 5
				local var_218_100 = utf8.len(var_218_98)
				local var_218_101 = var_218_99 <= 0 and var_218_94 or var_218_94 * (var_218_100 / var_218_99)

				if var_218_101 > 0 and var_218_94 < var_218_101 then
					arg_215_1.talkMaxDuration = var_218_101
					var_218_93 = var_218_93 + 0.3

					if var_218_101 + var_218_93 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_101 + var_218_93
					end
				end

				arg_215_1.text_.text = var_218_98
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002049", "story_v_side_new_1102002.awb") ~= 0 then
					local var_218_102 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002049", "story_v_side_new_1102002.awb") / 1000

					if var_218_102 + var_218_93 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_102 + var_218_93
					end

					if var_218_97.prefab_name ~= "" and arg_215_1.actors_[var_218_97.prefab_name] ~= nil then
						local var_218_103 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_97.prefab_name].transform, "story_v_side_new_1102002", "1102002049", "story_v_side_new_1102002.awb")

						arg_215_1:RecordAudio("1102002049", var_218_103)
						arg_215_1:RecordAudio("1102002049", var_218_103)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002049", "story_v_side_new_1102002.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002049", "story_v_side_new_1102002.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_104 = var_218_93 + 0.3
			local var_218_105 = math.max(var_218_94, arg_215_1.talkMaxDuration)

			if var_218_104 <= arg_215_1.time_ and arg_215_1.time_ < var_218_104 + var_218_105 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_104) / var_218_105

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_104 + var_218_105 and arg_215_1.time_ < var_218_104 + var_218_105 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.18333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.06733333518108,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play1102002050 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1102002050
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1102002051(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1020ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1020ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, 100, 0)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1020ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, 100, 0)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = arg_221_1.actors_["1020ui_story"]
			local var_224_10 = 0

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1020ui_story == nil then
				arg_221_1.var_.characterEffect1020ui_story = var_224_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.200000002980232

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_11 and not isNil(var_224_9) then
				local var_224_12 = (arg_221_1.time_ - var_224_10) / var_224_11

				if arg_221_1.var_.characterEffect1020ui_story and not isNil(var_224_9) then
					local var_224_13 = Mathf.Lerp(0, 0.5, var_224_12)

					arg_221_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1020ui_story.fillRatio = var_224_13
				end
			end

			if arg_221_1.time_ >= var_224_10 + var_224_11 and arg_221_1.time_ < var_224_10 + var_224_11 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1020ui_story then
				local var_224_14 = 0.5

				arg_221_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1020ui_story.fillRatio = var_224_14
			end

			local var_224_15 = 0
			local var_224_16 = 0.6

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_17 = arg_221_1:GetWordFromCfg(1102002050)
				local var_224_18 = arg_221_1:FormatText(var_224_17.content)

				arg_221_1.text_.text = var_224_18

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_19 = 24
				local var_224_20 = utf8.len(var_224_18)
				local var_224_21 = var_224_19 <= 0 and var_224_16 or var_224_16 * (var_224_20 / var_224_19)

				if var_224_21 > 0 and var_224_16 < var_224_21 then
					arg_221_1.talkMaxDuration = var_224_21

					if var_224_21 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_21 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_18
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_22 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_22 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_15) / var_224_22

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_15 + var_224_22 and arg_221_1.time_ < var_224_15 + var_224_22 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102002051 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1102002051
		arg_225_1.duration_ = 9.5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1102002052(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1020ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1020ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0, -0.85, -6.25)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1020ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = arg_225_1.actors_["1020ui_story"]
			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1020ui_story == nil then
				arg_225_1.var_.characterEffect1020ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_11 = 0.200000002980232

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_11 and not isNil(var_228_9) then
				local var_228_12 = (arg_225_1.time_ - var_228_10) / var_228_11

				if arg_225_1.var_.characterEffect1020ui_story and not isNil(var_228_9) then
					arg_225_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_10 + var_228_11 and arg_225_1.time_ < var_228_10 + var_228_11 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1020ui_story then
				arg_225_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_228_13 = 0

			if var_228_13 < arg_225_1.time_ and arg_225_1.time_ <= var_228_13 + arg_228_0 then
				arg_225_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action438")
			end

			local var_228_14 = 0

			if var_228_14 < arg_225_1.time_ and arg_225_1.time_ <= var_228_14 + arg_228_0 then
				arg_225_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_228_15 = 0
			local var_228_16 = 1

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_17 = arg_225_1:FormatText(StoryNameCfg[613].name)

				arg_225_1.leftNameTxt_.text = var_228_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_18 = arg_225_1:GetWordFromCfg(1102002051)
				local var_228_19 = arg_225_1:FormatText(var_228_18.content)

				arg_225_1.text_.text = var_228_19

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_20 = 40
				local var_228_21 = utf8.len(var_228_19)
				local var_228_22 = var_228_20 <= 0 and var_228_16 or var_228_16 * (var_228_21 / var_228_20)

				if var_228_22 > 0 and var_228_16 < var_228_22 then
					arg_225_1.talkMaxDuration = var_228_22

					if var_228_22 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_22 + var_228_15
					end
				end

				arg_225_1.text_.text = var_228_19
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002051", "story_v_side_new_1102002.awb") ~= 0 then
					local var_228_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002051", "story_v_side_new_1102002.awb") / 1000

					if var_228_23 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_23 + var_228_15
					end

					if var_228_18.prefab_name ~= "" and arg_225_1.actors_[var_228_18.prefab_name] ~= nil then
						local var_228_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_18.prefab_name].transform, "story_v_side_new_1102002", "1102002051", "story_v_side_new_1102002.awb")

						arg_225_1:RecordAudio("1102002051", var_228_24)
						arg_225_1:RecordAudio("1102002051", var_228_24)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002051", "story_v_side_new_1102002.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002051", "story_v_side_new_1102002.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_25 = math.max(var_228_16, arg_225_1.talkMaxDuration)

			if var_228_15 <= arg_225_1.time_ and arg_225_1.time_ < var_228_15 + var_228_25 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_15) / var_228_25

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_15 + var_228_25 and arg_225_1.time_ < var_228_15 + var_228_25 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play1102002052 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1102002052
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1102002053(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1020ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1020ui_story == nil then
				arg_229_1.var_.characterEffect1020ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1020ui_story and not isNil(var_232_0) then
					local var_232_4 = Mathf.Lerp(0, 0.5, var_232_3)

					arg_229_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1020ui_story.fillRatio = var_232_4
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1020ui_story then
				local var_232_5 = 0.5

				arg_229_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1020ui_story.fillRatio = var_232_5
			end

			local var_232_6 = 0
			local var_232_7 = 1.225

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_8 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_9 = arg_229_1:GetWordFromCfg(1102002052)
				local var_232_10 = arg_229_1:FormatText(var_232_9.content)

				arg_229_1.text_.text = var_232_10

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 49
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
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_14 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_14 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_6) / var_232_14

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_6 + var_232_14 and arg_229_1.time_ < var_232_6 + var_232_14 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1102002053 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1102002053
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1102002054(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1020ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1020ui_story = var_236_0.localPosition
			end

			local var_236_2 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2
				local var_236_4 = Vector3.New(0, 100, 0)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1020ui_story, var_236_4, var_236_3)

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

			local var_236_9 = 0
			local var_236_10 = 0.725

			if var_236_9 < arg_233_1.time_ and arg_233_1.time_ <= var_236_9 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_11 = arg_233_1:GetWordFromCfg(1102002053)
				local var_236_12 = arg_233_1:FormatText(var_236_11.content)

				arg_233_1.text_.text = var_236_12

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 29
				local var_236_14 = utf8.len(var_236_12)
				local var_236_15 = var_236_13 <= 0 and var_236_10 or var_236_10 * (var_236_14 / var_236_13)

				if var_236_15 > 0 and var_236_10 < var_236_15 then
					arg_233_1.talkMaxDuration = var_236_15

					if var_236_15 + var_236_9 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_15 + var_236_9
					end
				end

				arg_233_1.text_.text = var_236_12
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_16 = math.max(var_236_10, arg_233_1.talkMaxDuration)

			if var_236_9 <= arg_233_1.time_ and arg_233_1.time_ < var_236_9 + var_236_16 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_9) / var_236_16

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_9 + var_236_16 and arg_233_1.time_ < var_236_9 + var_236_16 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102002054 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1102002054
		arg_237_1.duration_ = 2.33

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1102002055(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1020ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1020ui_story = var_240_0.localPosition
			end

			local var_240_2 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2
				local var_240_4 = Vector3.New(0, -0.85, -6.25)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1020ui_story, var_240_4, var_240_3)

				local var_240_5 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_5.x, var_240_5.y, var_240_5.z)

				local var_240_6 = var_240_0.localEulerAngles

				var_240_6.z = 0
				var_240_6.x = 0
				var_240_0.localEulerAngles = var_240_6
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_240_7 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_7.x, var_240_7.y, var_240_7.z)

				local var_240_8 = var_240_0.localEulerAngles

				var_240_8.z = 0
				var_240_8.x = 0
				var_240_0.localEulerAngles = var_240_8
			end

			local var_240_9 = arg_237_1.actors_["1020ui_story"]
			local var_240_10 = 0

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect1020ui_story == nil then
				arg_237_1.var_.characterEffect1020ui_story = var_240_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_11 = 0.200000002980232

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_11 and not isNil(var_240_9) then
				local var_240_12 = (arg_237_1.time_ - var_240_10) / var_240_11

				if arg_237_1.var_.characterEffect1020ui_story and not isNil(var_240_9) then
					arg_237_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_10 + var_240_11 and arg_237_1.time_ < var_240_10 + var_240_11 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect1020ui_story then
				arg_237_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_240_13 = 0

			if var_240_13 < arg_237_1.time_ and arg_237_1.time_ <= var_240_13 + arg_240_0 then
				arg_237_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_240_14 = 0

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				arg_237_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_240_15 = 0
			local var_240_16 = 0.125

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_17 = arg_237_1:FormatText(StoryNameCfg[613].name)

				arg_237_1.leftNameTxt_.text = var_240_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_18 = arg_237_1:GetWordFromCfg(1102002054)
				local var_240_19 = arg_237_1:FormatText(var_240_18.content)

				arg_237_1.text_.text = var_240_19

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_20 = 5
				local var_240_21 = utf8.len(var_240_19)
				local var_240_22 = var_240_20 <= 0 and var_240_16 or var_240_16 * (var_240_21 / var_240_20)

				if var_240_22 > 0 and var_240_16 < var_240_22 then
					arg_237_1.talkMaxDuration = var_240_22

					if var_240_22 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_22 + var_240_15
					end
				end

				arg_237_1.text_.text = var_240_19
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002054", "story_v_side_new_1102002.awb") ~= 0 then
					local var_240_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002054", "story_v_side_new_1102002.awb") / 1000

					if var_240_23 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_23 + var_240_15
					end

					if var_240_18.prefab_name ~= "" and arg_237_1.actors_[var_240_18.prefab_name] ~= nil then
						local var_240_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_18.prefab_name].transform, "story_v_side_new_1102002", "1102002054", "story_v_side_new_1102002.awb")

						arg_237_1:RecordAudio("1102002054", var_240_24)
						arg_237_1:RecordAudio("1102002054", var_240_24)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002054", "story_v_side_new_1102002.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002054", "story_v_side_new_1102002.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_25 = math.max(var_240_16, arg_237_1.talkMaxDuration)

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_25 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_15) / var_240_25

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_15 + var_240_25 and arg_237_1.time_ < var_240_15 + var_240_25 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1102002055 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1102002055
		arg_241_1.duration_ = 2

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1102002056(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_244_1 = 0
			local var_244_2 = 0.25

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_3 = arg_241_1:FormatText(StoryNameCfg[613].name)

				arg_241_1.leftNameTxt_.text = var_244_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_4 = arg_241_1:GetWordFromCfg(1102002055)
				local var_244_5 = arg_241_1:FormatText(var_244_4.content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_6 = 10
				local var_244_7 = utf8.len(var_244_5)
				local var_244_8 = var_244_6 <= 0 and var_244_2 or var_244_2 * (var_244_7 / var_244_6)

				if var_244_8 > 0 and var_244_2 < var_244_8 then
					arg_241_1.talkMaxDuration = var_244_8

					if var_244_8 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002055", "story_v_side_new_1102002.awb") ~= 0 then
					local var_244_9 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002055", "story_v_side_new_1102002.awb") / 1000

					if var_244_9 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_1
					end

					if var_244_4.prefab_name ~= "" and arg_241_1.actors_[var_244_4.prefab_name] ~= nil then
						local var_244_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_4.prefab_name].transform, "story_v_side_new_1102002", "1102002055", "story_v_side_new_1102002.awb")

						arg_241_1:RecordAudio("1102002055", var_244_10)
						arg_241_1:RecordAudio("1102002055", var_244_10)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002055", "story_v_side_new_1102002.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002055", "story_v_side_new_1102002.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_11 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_11 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_11

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_11 and arg_241_1.time_ < var_244_1 + var_244_11 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1102002056 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1102002056
		arg_245_1.duration_ = 7.23

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1102002057(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				local var_248_1 = manager.ui.mainCamera.transform.localPosition
				local var_248_2 = Vector3.New(0, 0, 10) + Vector3.New(var_248_1.x, var_248_1.y, 0)
				local var_248_3 = arg_245_1.bgs_.H03b

				var_248_3.transform.localPosition = var_248_2
				var_248_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_248_4 = var_248_3:GetComponent("SpriteRenderer")

				if var_248_4 and var_248_4.sprite then
					local var_248_5 = (var_248_3.transform.localPosition - var_248_1).z
					local var_248_6 = manager.ui.mainCameraCom_
					local var_248_7 = 2 * var_248_5 * Mathf.Tan(var_248_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_248_8 = var_248_7 * var_248_6.aspect
					local var_248_9 = var_248_4.sprite.bounds.size.x
					local var_248_10 = var_248_4.sprite.bounds.size.y
					local var_248_11 = var_248_8 / var_248_9
					local var_248_12 = var_248_7 / var_248_10
					local var_248_13 = var_248_12 < var_248_11 and var_248_11 or var_248_12

					var_248_3.transform.localScale = Vector3.New(var_248_13, var_248_13, 0)
				end

				for iter_248_0, iter_248_1 in pairs(arg_245_1.bgs_) do
					if iter_248_0 ~= "H03b" then
						iter_248_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_248_14 = "H05"

			if arg_245_1.bgs_[var_248_14] == nil then
				local var_248_15 = Object.Instantiate(arg_245_1.paintGo_)

				var_248_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_248_14)
				var_248_15.name = var_248_14
				var_248_15.transform.parent = arg_245_1.stage_.transform
				var_248_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_245_1.bgs_[var_248_14] = var_248_15
			end

			local var_248_16 = 1.500667

			if var_248_16 < arg_245_1.time_ and arg_245_1.time_ <= var_248_16 + arg_248_0 then
				local var_248_17 = manager.ui.mainCamera.transform.localPosition
				local var_248_18 = Vector3.New(0, 0, 10) + Vector3.New(var_248_17.x, var_248_17.y, 0)
				local var_248_19 = arg_245_1.bgs_.H05

				var_248_19.transform.localPosition = var_248_18
				var_248_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_248_20 = var_248_19:GetComponent("SpriteRenderer")

				if var_248_20 and var_248_20.sprite then
					local var_248_21 = (var_248_19.transform.localPosition - var_248_17).z
					local var_248_22 = manager.ui.mainCameraCom_
					local var_248_23 = 2 * var_248_21 * Mathf.Tan(var_248_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_248_24 = var_248_23 * var_248_22.aspect
					local var_248_25 = var_248_20.sprite.bounds.size.x
					local var_248_26 = var_248_20.sprite.bounds.size.y
					local var_248_27 = var_248_24 / var_248_25
					local var_248_28 = var_248_23 / var_248_26
					local var_248_29 = var_248_28 < var_248_27 and var_248_27 or var_248_28

					var_248_19.transform.localScale = Vector3.New(var_248_29, var_248_29, 0)
				end

				for iter_248_2, iter_248_3 in pairs(arg_245_1.bgs_) do
					if iter_248_2 ~= "H05" then
						iter_248_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_248_30 = 3.000667

			if var_248_30 < arg_245_1.time_ and arg_245_1.time_ <= var_248_30 + arg_248_0 then
				arg_245_1.allBtn_.enabled = false
			end

			local var_248_31 = 0.3

			if arg_245_1.time_ >= var_248_30 + var_248_31 and arg_245_1.time_ < var_248_30 + var_248_31 + arg_248_0 then
				arg_245_1.allBtn_.enabled = true
			end

			local var_248_32 = arg_245_1.actors_["1020ui_story"].transform
			local var_248_33 = 2.5

			if var_248_33 < arg_245_1.time_ and arg_245_1.time_ <= var_248_33 + arg_248_0 then
				arg_245_1.var_.moveOldPos1020ui_story = var_248_32.localPosition
			end

			local var_248_34 = 0.001

			if var_248_33 <= arg_245_1.time_ and arg_245_1.time_ < var_248_33 + var_248_34 then
				local var_248_35 = (arg_245_1.time_ - var_248_33) / var_248_34
				local var_248_36 = Vector3.New(0, -0.85, -6.25)

				var_248_32.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1020ui_story, var_248_36, var_248_35)

				local var_248_37 = manager.ui.mainCamera.transform.position - var_248_32.position

				var_248_32.forward = Vector3.New(var_248_37.x, var_248_37.y, var_248_37.z)

				local var_248_38 = var_248_32.localEulerAngles

				var_248_38.z = 0
				var_248_38.x = 0
				var_248_32.localEulerAngles = var_248_38
			end

			if arg_245_1.time_ >= var_248_33 + var_248_34 and arg_245_1.time_ < var_248_33 + var_248_34 + arg_248_0 then
				var_248_32.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_248_39 = manager.ui.mainCamera.transform.position - var_248_32.position

				var_248_32.forward = Vector3.New(var_248_39.x, var_248_39.y, var_248_39.z)

				local var_248_40 = var_248_32.localEulerAngles

				var_248_40.z = 0
				var_248_40.x = 0
				var_248_32.localEulerAngles = var_248_40
			end

			local var_248_41 = 2.5

			if var_248_41 < arg_245_1.time_ and arg_245_1.time_ <= var_248_41 + arg_248_0 then
				arg_245_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_248_42 = 2.5

			if var_248_42 < arg_245_1.time_ and arg_245_1.time_ <= var_248_42 + arg_248_0 then
				arg_245_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_248_43 = manager.ui.mainCamera.transform
			local var_248_44 = 0

			if var_248_44 < arg_245_1.time_ and arg_245_1.time_ <= var_248_44 + arg_248_0 then
				local var_248_45 = arg_245_1.var_.effect213213231213213
				local var_248_46
				local var_248_47 = var_248_43

				if not var_248_45 then
					var_248_45 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_248_47)
					var_248_45.name = "213213231213213"
					arg_245_1.var_.effect213213231213213 = var_248_45
				else
					var_248_45.transform:SetParent(var_248_47)
				end

				var_248_45.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_45.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_248_48 = manager.ui.mainCameraCom_
				local var_248_49 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_248_48.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_248_50 = var_248_45.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_248_51 = 15
				local var_248_52 = 2 * var_248_51 * Mathf.Tan(var_248_48.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_248_48.aspect
				local var_248_53 = 1
				local var_248_54 = 1.7777777777777777

				if var_248_54 < var_248_48.aspect then
					var_248_53 = var_248_52 / (2 * var_248_51 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_248_54)
				end

				for iter_248_4, iter_248_5 in ipairs(var_248_50) do
					local var_248_55 = iter_248_5.transform.localScale

					iter_248_5.transform.localScale = Vector3.New(var_248_55.x / var_248_49 * var_248_53, var_248_55.y / var_248_49, var_248_55.z)
				end
			end

			local var_248_56 = manager.ui.mainCamera.transform
			local var_248_57 = 1.50066666851441

			if var_248_57 < arg_245_1.time_ and arg_245_1.time_ <= var_248_57 + arg_248_0 then
				local var_248_58 = arg_245_1.var_.effect213213231213213

				if var_248_58 then
					Object.Destroy(var_248_58)

					arg_245_1.var_.effect213213231213213 = nil
				end
			end

			local var_248_59 = manager.ui.mainCamera.transform
			local var_248_60 = 1.50066666851441

			if var_248_60 < arg_245_1.time_ and arg_245_1.time_ <= var_248_60 + arg_248_0 then
				local var_248_61 = arg_245_1.var_.effect213222222123213
				local var_248_62
				local var_248_63 = var_248_59

				if not var_248_61 then
					var_248_61 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_248_63)
					var_248_61.name = "213222222123213"
					arg_245_1.var_.effect213222222123213 = var_248_61
				else
					var_248_61.transform:SetParent(var_248_63)
				end

				var_248_61.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_61.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_248_64 = manager.ui.mainCameraCom_
				local var_248_65 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_248_64.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_248_66 = var_248_61.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_248_67 = 15
				local var_248_68 = 2 * var_248_67 * Mathf.Tan(var_248_64.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_248_64.aspect
				local var_248_69 = 1
				local var_248_70 = 1.7777777777777777

				if var_248_70 < var_248_64.aspect then
					var_248_69 = var_248_68 / (2 * var_248_67 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_248_70)
				end

				for iter_248_6, iter_248_7 in ipairs(var_248_66) do
					local var_248_71 = iter_248_7.transform.localScale

					iter_248_7.transform.localScale = Vector3.New(var_248_71.x / var_248_65 * var_248_69, var_248_71.y / var_248_65, var_248_71.z)
				end
			end

			local var_248_72 = arg_245_1.actors_["1020ui_story"].transform
			local var_248_73 = 1.16599999815226

			if var_248_73 < arg_245_1.time_ and arg_245_1.time_ <= var_248_73 + arg_248_0 then
				arg_245_1.var_.moveOldPos1020ui_story = var_248_72.localPosition
			end

			local var_248_74 = 0.001

			if var_248_73 <= arg_245_1.time_ and arg_245_1.time_ < var_248_73 + var_248_74 then
				local var_248_75 = (arg_245_1.time_ - var_248_73) / var_248_74
				local var_248_76 = Vector3.New(0, 100, 0)

				var_248_72.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1020ui_story, var_248_76, var_248_75)

				local var_248_77 = manager.ui.mainCamera.transform.position - var_248_72.position

				var_248_72.forward = Vector3.New(var_248_77.x, var_248_77.y, var_248_77.z)

				local var_248_78 = var_248_72.localEulerAngles

				var_248_78.z = 0
				var_248_78.x = 0
				var_248_72.localEulerAngles = var_248_78
			end

			if arg_245_1.time_ >= var_248_73 + var_248_74 and arg_245_1.time_ < var_248_73 + var_248_74 + arg_248_0 then
				var_248_72.localPosition = Vector3.New(0, 100, 0)

				local var_248_79 = manager.ui.mainCamera.transform.position - var_248_72.position

				var_248_72.forward = Vector3.New(var_248_79.x, var_248_79.y, var_248_79.z)

				local var_248_80 = var_248_72.localEulerAngles

				var_248_80.z = 0
				var_248_80.x = 0
				var_248_72.localEulerAngles = var_248_80
			end

			local var_248_81 = 0.125
			local var_248_82 = 1

			if var_248_81 < arg_245_1.time_ and arg_245_1.time_ <= var_248_81 + arg_248_0 then
				local var_248_83 = "stop"
				local var_248_84 = "effect"

				arg_245_1:AudioAction(var_248_83, var_248_84, "se_story_side_1020", "se_story_side_1020_amb_river", "")
			end

			local var_248_85 = 0
			local var_248_86 = 1

			if var_248_85 < arg_245_1.time_ and arg_245_1.time_ <= var_248_85 + arg_248_0 then
				local var_248_87 = "play"
				local var_248_88 = "effect"

				arg_245_1:AudioAction(var_248_87, var_248_88, "se_story_side_1020", "se_story_side_1020_whoosh", "")
			end

			local var_248_89 = 1.2
			local var_248_90 = 1

			if var_248_89 < arg_245_1.time_ and arg_245_1.time_ <= var_248_89 + arg_248_0 then
				local var_248_91 = "play"
				local var_248_92 = "effect"

				arg_245_1:AudioAction(var_248_91, var_248_92, "se_story_133", "se_story_133_sea", "")
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_93 = 2.5
			local var_248_94 = 0.375

			if var_248_93 < arg_245_1.time_ and arg_245_1.time_ <= var_248_93 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_95 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_95:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_95:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_95:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_96 = arg_245_1:FormatText(StoryNameCfg[613].name)

				arg_245_1.leftNameTxt_.text = var_248_96

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_97 = arg_245_1:GetWordFromCfg(1102002056)
				local var_248_98 = arg_245_1:FormatText(var_248_97.content)

				arg_245_1.text_.text = var_248_98

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_99 = 15
				local var_248_100 = utf8.len(var_248_98)
				local var_248_101 = var_248_99 <= 0 and var_248_94 or var_248_94 * (var_248_100 / var_248_99)

				if var_248_101 > 0 and var_248_94 < var_248_101 then
					arg_245_1.talkMaxDuration = var_248_101
					var_248_93 = var_248_93 + 0.3

					if var_248_101 + var_248_93 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_101 + var_248_93
					end
				end

				arg_245_1.text_.text = var_248_98
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002056", "story_v_side_new_1102002.awb") ~= 0 then
					local var_248_102 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002056", "story_v_side_new_1102002.awb") / 1000

					if var_248_102 + var_248_93 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_102 + var_248_93
					end

					if var_248_97.prefab_name ~= "" and arg_245_1.actors_[var_248_97.prefab_name] ~= nil then
						local var_248_103 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_97.prefab_name].transform, "story_v_side_new_1102002", "1102002056", "story_v_side_new_1102002.awb")

						arg_245_1:RecordAudio("1102002056", var_248_103)
						arg_245_1:RecordAudio("1102002056", var_248_103)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002056", "story_v_side_new_1102002.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002056", "story_v_side_new_1102002.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_104 = var_248_93 + 0.3
			local var_248_105 = math.max(var_248_94, arg_245_1.talkMaxDuration)

			if var_248_104 <= arg_245_1.time_ and arg_245_1.time_ < var_248_104 + var_248_105 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_104) / var_248_105

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_104 + var_248_105 and arg_245_1.time_ < var_248_104 + var_248_105 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.16599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play1102002057 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1102002057
		arg_251_1.duration_ = 7

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1102002058(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_254_2 = 0
			local var_254_3 = 0.775

			if var_254_2 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_4 = arg_251_1:FormatText(StoryNameCfg[613].name)

				arg_251_1.leftNameTxt_.text = var_254_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_5 = arg_251_1:GetWordFromCfg(1102002057)
				local var_254_6 = arg_251_1:FormatText(var_254_5.content)

				arg_251_1.text_.text = var_254_6

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_7 = 31
				local var_254_8 = utf8.len(var_254_6)
				local var_254_9 = var_254_7 <= 0 and var_254_3 or var_254_3 * (var_254_8 / var_254_7)

				if var_254_9 > 0 and var_254_3 < var_254_9 then
					arg_251_1.talkMaxDuration = var_254_9

					if var_254_9 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_9 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_6
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002057", "story_v_side_new_1102002.awb") ~= 0 then
					local var_254_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002057", "story_v_side_new_1102002.awb") / 1000

					if var_254_10 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_2
					end

					if var_254_5.prefab_name ~= "" and arg_251_1.actors_[var_254_5.prefab_name] ~= nil then
						local var_254_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_5.prefab_name].transform, "story_v_side_new_1102002", "1102002057", "story_v_side_new_1102002.awb")

						arg_251_1:RecordAudio("1102002057", var_254_11)
						arg_251_1:RecordAudio("1102002057", var_254_11)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002057", "story_v_side_new_1102002.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002057", "story_v_side_new_1102002.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_12 = math.max(var_254_3, arg_251_1.talkMaxDuration)

			if var_254_2 <= arg_251_1.time_ and arg_251_1.time_ < var_254_2 + var_254_12 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_2) / var_254_12

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_2 + var_254_12 and arg_251_1.time_ < var_254_2 + var_254_12 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1102002058 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1102002058
		arg_255_1.duration_ = 4.47

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1102002059(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action438")
			end

			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_258_2 = 0
			local var_258_3 = 0.525

			if var_258_2 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_4 = arg_255_1:FormatText(StoryNameCfg[613].name)

				arg_255_1.leftNameTxt_.text = var_258_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_5 = arg_255_1:GetWordFromCfg(1102002058)
				local var_258_6 = arg_255_1:FormatText(var_258_5.content)

				arg_255_1.text_.text = var_258_6

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_7 = 21
				local var_258_8 = utf8.len(var_258_6)
				local var_258_9 = var_258_7 <= 0 and var_258_3 or var_258_3 * (var_258_8 / var_258_7)

				if var_258_9 > 0 and var_258_3 < var_258_9 then
					arg_255_1.talkMaxDuration = var_258_9

					if var_258_9 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_9 + var_258_2
					end
				end

				arg_255_1.text_.text = var_258_6
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002058", "story_v_side_new_1102002.awb") ~= 0 then
					local var_258_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002058", "story_v_side_new_1102002.awb") / 1000

					if var_258_10 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_2
					end

					if var_258_5.prefab_name ~= "" and arg_255_1.actors_[var_258_5.prefab_name] ~= nil then
						local var_258_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_5.prefab_name].transform, "story_v_side_new_1102002", "1102002058", "story_v_side_new_1102002.awb")

						arg_255_1:RecordAudio("1102002058", var_258_11)
						arg_255_1:RecordAudio("1102002058", var_258_11)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002058", "story_v_side_new_1102002.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002058", "story_v_side_new_1102002.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_12 = math.max(var_258_3, arg_255_1.talkMaxDuration)

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_12 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_2) / var_258_12

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_2 + var_258_12 and arg_255_1.time_ < var_258_2 + var_258_12 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1102002059 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1102002059
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1102002060(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1020ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1020ui_story == nil then
				arg_259_1.var_.characterEffect1020ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect1020ui_story and not isNil(var_262_0) then
					local var_262_4 = Mathf.Lerp(0, 0.5, var_262_3)

					arg_259_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1020ui_story.fillRatio = var_262_4
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1020ui_story then
				local var_262_5 = 0.5

				arg_259_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1020ui_story.fillRatio = var_262_5
			end

			local var_262_6 = 0
			local var_262_7 = 0.55

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_8 = arg_259_1:FormatText(StoryNameCfg[7].name)

				arg_259_1.leftNameTxt_.text = var_262_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_9 = arg_259_1:GetWordFromCfg(1102002059)
				local var_262_10 = arg_259_1:FormatText(var_262_9.content)

				arg_259_1.text_.text = var_262_10

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 22
				local var_262_12 = utf8.len(var_262_10)
				local var_262_13 = var_262_11 <= 0 and var_262_7 or var_262_7 * (var_262_12 / var_262_11)

				if var_262_13 > 0 and var_262_7 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13

					if var_262_13 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_10
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_14 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_14 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_14

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_14 and arg_259_1.time_ < var_262_6 + var_262_14 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1102002060 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1102002060
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1102002061(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1020ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1020ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(0, 100, 0)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1020ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, 100, 0)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = 0
			local var_266_10 = 1.075

			if var_266_9 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_11 = arg_263_1:GetWordFromCfg(1102002060)
				local var_266_12 = arg_263_1:FormatText(var_266_11.content)

				arg_263_1.text_.text = var_266_12

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_13 = 43
				local var_266_14 = utf8.len(var_266_12)
				local var_266_15 = var_266_13 <= 0 and var_266_10 or var_266_10 * (var_266_14 / var_266_13)

				if var_266_15 > 0 and var_266_10 < var_266_15 then
					arg_263_1.talkMaxDuration = var_266_15

					if var_266_15 + var_266_9 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_15 + var_266_9
					end
				end

				arg_263_1.text_.text = var_266_12
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_16 = math.max(var_266_10, arg_263_1.talkMaxDuration)

			if var_266_9 <= arg_263_1.time_ and arg_263_1.time_ < var_266_9 + var_266_16 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_9) / var_266_16

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_9 + var_266_16 and arg_263_1.time_ < var_266_9 + var_266_16 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play1102002061 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1102002061
		arg_267_1.duration_ = 7.73

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1102002062(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				local var_270_1 = manager.ui.mainCamera.transform.localPosition
				local var_270_2 = Vector3.New(0, 0, 10) + Vector3.New(var_270_1.x, var_270_1.y, 0)
				local var_270_3 = arg_267_1.bgs_.H05

				var_270_3.transform.localPosition = var_270_2
				var_270_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_270_4 = var_270_3:GetComponent("SpriteRenderer")

				if var_270_4 and var_270_4.sprite then
					local var_270_5 = (var_270_3.transform.localPosition - var_270_1).z
					local var_270_6 = manager.ui.mainCameraCom_
					local var_270_7 = 2 * var_270_5 * Mathf.Tan(var_270_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_270_8 = var_270_7 * var_270_6.aspect
					local var_270_9 = var_270_4.sprite.bounds.size.x
					local var_270_10 = var_270_4.sprite.bounds.size.y
					local var_270_11 = var_270_8 / var_270_9
					local var_270_12 = var_270_7 / var_270_10
					local var_270_13 = var_270_12 < var_270_11 and var_270_11 or var_270_12

					var_270_3.transform.localScale = Vector3.New(var_270_13, var_270_13, 0)
				end

				for iter_270_0, iter_270_1 in pairs(arg_267_1.bgs_) do
					if iter_270_0 ~= "H05" then
						iter_270_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_270_14 = "H02"

			if arg_267_1.bgs_[var_270_14] == nil then
				local var_270_15 = Object.Instantiate(arg_267_1.paintGo_)

				var_270_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_270_14)
				var_270_15.name = var_270_14
				var_270_15.transform.parent = arg_267_1.stage_.transform
				var_270_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.bgs_[var_270_14] = var_270_15
			end

			local var_270_16 = 1.50066666851441

			if var_270_16 < arg_267_1.time_ and arg_267_1.time_ <= var_270_16 + arg_270_0 then
				local var_270_17 = manager.ui.mainCamera.transform.localPosition
				local var_270_18 = Vector3.New(0, 0, 10) + Vector3.New(var_270_17.x, var_270_17.y, 0)
				local var_270_19 = arg_267_1.bgs_.H02

				var_270_19.transform.localPosition = var_270_18
				var_270_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_270_20 = var_270_19:GetComponent("SpriteRenderer")

				if var_270_20 and var_270_20.sprite then
					local var_270_21 = (var_270_19.transform.localPosition - var_270_17).z
					local var_270_22 = manager.ui.mainCameraCom_
					local var_270_23 = 2 * var_270_21 * Mathf.Tan(var_270_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_270_24 = var_270_23 * var_270_22.aspect
					local var_270_25 = var_270_20.sprite.bounds.size.x
					local var_270_26 = var_270_20.sprite.bounds.size.y
					local var_270_27 = var_270_24 / var_270_25
					local var_270_28 = var_270_23 / var_270_26
					local var_270_29 = var_270_28 < var_270_27 and var_270_27 or var_270_28

					var_270_19.transform.localScale = Vector3.New(var_270_29, var_270_29, 0)
				end

				for iter_270_2, iter_270_3 in pairs(arg_267_1.bgs_) do
					if iter_270_2 ~= "H02" then
						iter_270_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_270_30 = 2.72566666851441

			if var_270_30 < arg_267_1.time_ and arg_267_1.time_ <= var_270_30 + arg_270_0 then
				arg_267_1.allBtn_.enabled = false
			end

			local var_270_31 = 0.3

			if arg_267_1.time_ >= var_270_30 + var_270_31 and arg_267_1.time_ < var_270_30 + var_270_31 + arg_270_0 then
				arg_267_1.allBtn_.enabled = true
			end

			local var_270_32 = manager.ui.mainCamera.transform
			local var_270_33 = 0

			if var_270_33 < arg_267_1.time_ and arg_267_1.time_ <= var_270_33 + arg_270_0 then
				local var_270_34 = arg_267_1.var_.effect213213231213213
				local var_270_35
				local var_270_36 = var_270_32

				if not var_270_34 then
					var_270_34 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_270_36)
					var_270_34.name = "213213231213213"
					arg_267_1.var_.effect213213231213213 = var_270_34
				else
					var_270_34.transform:SetParent(var_270_36)
				end

				var_270_34.transform.localPosition = Vector3.New(0, 0, 0)
				var_270_34.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_270_37 = manager.ui.mainCameraCom_
				local var_270_38 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_270_37.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_270_39 = var_270_34.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_270_40 = 15
				local var_270_41 = 2 * var_270_40 * Mathf.Tan(var_270_37.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_270_37.aspect
				local var_270_42 = 1
				local var_270_43 = 1.7777777777777777

				if var_270_43 < var_270_37.aspect then
					var_270_42 = var_270_41 / (2 * var_270_40 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_270_43)
				end

				for iter_270_4, iter_270_5 in ipairs(var_270_39) do
					local var_270_44 = iter_270_5.transform.localScale

					iter_270_5.transform.localScale = Vector3.New(var_270_44.x / var_270_38 * var_270_42, var_270_44.y / var_270_38, var_270_44.z)
				end
			end

			local var_270_45 = manager.ui.mainCamera.transform
			local var_270_46 = 1.50066666851441

			if var_270_46 < arg_267_1.time_ and arg_267_1.time_ <= var_270_46 + arg_270_0 then
				local var_270_47 = arg_267_1.var_.effect213213231213213

				if var_270_47 then
					Object.Destroy(var_270_47)

					arg_267_1.var_.effect213213231213213 = nil
				end
			end

			local var_270_48 = manager.ui.mainCamera.transform
			local var_270_49 = 1.50066666851441

			if var_270_49 < arg_267_1.time_ and arg_267_1.time_ <= var_270_49 + arg_270_0 then
				local var_270_50 = arg_267_1.var_.effect213222222123213
				local var_270_51
				local var_270_52 = var_270_48

				if not var_270_50 then
					var_270_50 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_270_52)
					var_270_50.name = "213222222123213"
					arg_267_1.var_.effect213222222123213 = var_270_50
				else
					var_270_50.transform:SetParent(var_270_52)
				end

				var_270_50.transform.localPosition = Vector3.New(0, 0, 0)
				var_270_50.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_270_53 = manager.ui.mainCameraCom_
				local var_270_54 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_270_53.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_270_55 = var_270_50.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_270_56 = 15
				local var_270_57 = 2 * var_270_56 * Mathf.Tan(var_270_53.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_270_53.aspect
				local var_270_58 = 1
				local var_270_59 = 1.7777777777777777

				if var_270_59 < var_270_53.aspect then
					var_270_58 = var_270_57 / (2 * var_270_56 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_270_59)
				end

				for iter_270_6, iter_270_7 in ipairs(var_270_55) do
					local var_270_60 = iter_270_7.transform.localScale

					iter_270_7.transform.localScale = Vector3.New(var_270_60.x / var_270_54 * var_270_58, var_270_60.y / var_270_54, var_270_60.z)
				end
			end

			if arg_267_1.frameCnt_ <= 1 then
				arg_267_1.dialog_:SetActive(false)
			end

			local var_270_61 = 2.72566666851441
			local var_270_62 = 0.775

			if var_270_61 < arg_267_1.time_ and arg_267_1.time_ <= var_270_61 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0

				arg_267_1.dialog_:SetActive(true)

				arg_267_1.dialogCg_.alpha = 0

				local var_270_63 = LeanTween.value(arg_267_1.dialog_, 0, 1, 0.3)

				var_270_63:setOnUpdate(LuaHelper.FloatAction(function(arg_271_0)
					arg_267_1.dialogCg_.alpha = arg_271_0
				end))
				var_270_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_267_1.dialog_)
					var_270_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_267_1.duration_ = arg_267_1.duration_ + 0.3

				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_64 = arg_267_1:GetWordFromCfg(1102002061)
				local var_270_65 = arg_267_1:FormatText(var_270_64.content)

				arg_267_1.text_.text = var_270_65

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_66 = 31
				local var_270_67 = utf8.len(var_270_65)
				local var_270_68 = var_270_66 <= 0 and var_270_62 or var_270_62 * (var_270_67 / var_270_66)

				if var_270_68 > 0 and var_270_62 < var_270_68 then
					arg_267_1.talkMaxDuration = var_270_68
					var_270_61 = var_270_61 + 0.3

					if var_270_68 + var_270_61 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_68 + var_270_61
					end
				end

				arg_267_1.text_.text = var_270_65
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_69 = var_270_61 + 0.3
			local var_270_70 = math.max(var_270_62, arg_267_1.talkMaxDuration)

			if var_270_69 <= arg_267_1.time_ and arg_267_1.time_ < var_270_69 + var_270_70 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_69) / var_270_70

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_69 + var_270_70 and arg_267_1.time_ < var_270_69 + var_270_70 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1102002062 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1102002062
		arg_273_1.duration_ = 3.83

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1102002063(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1020ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1020ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0, -0.85, -6.25)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1020ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = arg_273_1.actors_["1020ui_story"]
			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect1020ui_story == nil then
				arg_273_1.var_.characterEffect1020ui_story = var_276_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_11 = 0.200000002980232

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_11 and not isNil(var_276_9) then
				local var_276_12 = (arg_273_1.time_ - var_276_10) / var_276_11

				if arg_273_1.var_.characterEffect1020ui_story and not isNil(var_276_9) then
					arg_273_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_10 + var_276_11 and arg_273_1.time_ < var_276_10 + var_276_11 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect1020ui_story then
				arg_273_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_276_13 = 0

			if var_276_13 < arg_273_1.time_ and arg_273_1.time_ <= var_276_13 + arg_276_0 then
				arg_273_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_276_14 = 0

			if var_276_14 < arg_273_1.time_ and arg_273_1.time_ <= var_276_14 + arg_276_0 then
				arg_273_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_276_15 = 0
			local var_276_16 = 0.375

			if var_276_15 < arg_273_1.time_ and arg_273_1.time_ <= var_276_15 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_17 = arg_273_1:FormatText(StoryNameCfg[613].name)

				arg_273_1.leftNameTxt_.text = var_276_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_18 = arg_273_1:GetWordFromCfg(1102002062)
				local var_276_19 = arg_273_1:FormatText(var_276_18.content)

				arg_273_1.text_.text = var_276_19

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_20 = 15
				local var_276_21 = utf8.len(var_276_19)
				local var_276_22 = var_276_20 <= 0 and var_276_16 or var_276_16 * (var_276_21 / var_276_20)

				if var_276_22 > 0 and var_276_16 < var_276_22 then
					arg_273_1.talkMaxDuration = var_276_22

					if var_276_22 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_22 + var_276_15
					end
				end

				arg_273_1.text_.text = var_276_19
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002062", "story_v_side_new_1102002.awb") ~= 0 then
					local var_276_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002062", "story_v_side_new_1102002.awb") / 1000

					if var_276_23 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_23 + var_276_15
					end

					if var_276_18.prefab_name ~= "" and arg_273_1.actors_[var_276_18.prefab_name] ~= nil then
						local var_276_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_18.prefab_name].transform, "story_v_side_new_1102002", "1102002062", "story_v_side_new_1102002.awb")

						arg_273_1:RecordAudio("1102002062", var_276_24)
						arg_273_1:RecordAudio("1102002062", var_276_24)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002062", "story_v_side_new_1102002.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002062", "story_v_side_new_1102002.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_25 = math.max(var_276_16, arg_273_1.talkMaxDuration)

			if var_276_15 <= arg_273_1.time_ and arg_273_1.time_ < var_276_15 + var_276_25 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_15) / var_276_25

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_15 + var_276_25 and arg_273_1.time_ < var_276_15 + var_276_25 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102002063 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1102002063
		arg_277_1.duration_ = 6.87

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1102002064(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action423")
			end

			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_280_2 = 0
			local var_280_3 = 0.65

			if var_280_2 < arg_277_1.time_ and arg_277_1.time_ <= var_280_2 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_4 = arg_277_1:FormatText(StoryNameCfg[613].name)

				arg_277_1.leftNameTxt_.text = var_280_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_5 = arg_277_1:GetWordFromCfg(1102002063)
				local var_280_6 = arg_277_1:FormatText(var_280_5.content)

				arg_277_1.text_.text = var_280_6

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_7 = 26
				local var_280_8 = utf8.len(var_280_6)
				local var_280_9 = var_280_7 <= 0 and var_280_3 or var_280_3 * (var_280_8 / var_280_7)

				if var_280_9 > 0 and var_280_3 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_2
					end
				end

				arg_277_1.text_.text = var_280_6
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002063", "story_v_side_new_1102002.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002063", "story_v_side_new_1102002.awb") / 1000

					if var_280_10 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_2
					end

					if var_280_5.prefab_name ~= "" and arg_277_1.actors_[var_280_5.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_5.prefab_name].transform, "story_v_side_new_1102002", "1102002063", "story_v_side_new_1102002.awb")

						arg_277_1:RecordAudio("1102002063", var_280_11)
						arg_277_1:RecordAudio("1102002063", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002063", "story_v_side_new_1102002.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002063", "story_v_side_new_1102002.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_3, arg_277_1.talkMaxDuration)

			if var_280_2 <= arg_277_1.time_ and arg_277_1.time_ < var_280_2 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_2) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_2 + var_280_12 and arg_277_1.time_ < var_280_2 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1102002064 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1102002064
		arg_281_1.duration_ = 5.3

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1102002065(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_284_2 = 0
			local var_284_3 = 0.45

			if var_284_2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_4 = arg_281_1:FormatText(StoryNameCfg[613].name)

				arg_281_1.leftNameTxt_.text = var_284_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_5 = arg_281_1:GetWordFromCfg(1102002064)
				local var_284_6 = arg_281_1:FormatText(var_284_5.content)

				arg_281_1.text_.text = var_284_6

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 18
				local var_284_8 = utf8.len(var_284_6)
				local var_284_9 = var_284_7 <= 0 and var_284_3 or var_284_3 * (var_284_8 / var_284_7)

				if var_284_9 > 0 and var_284_3 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_6
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002064", "story_v_side_new_1102002.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002064", "story_v_side_new_1102002.awb") / 1000

					if var_284_10 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_2
					end

					if var_284_5.prefab_name ~= "" and arg_281_1.actors_[var_284_5.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_5.prefab_name].transform, "story_v_side_new_1102002", "1102002064", "story_v_side_new_1102002.awb")

						arg_281_1:RecordAudio("1102002064", var_284_11)
						arg_281_1:RecordAudio("1102002064", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002064", "story_v_side_new_1102002.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002064", "story_v_side_new_1102002.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_12 and arg_281_1.time_ < var_284_2 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play1102002065 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1102002065
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1102002066(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1020ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1020ui_story == nil then
				arg_285_1.var_.characterEffect1020ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect1020ui_story and not isNil(var_288_0) then
					local var_288_4 = Mathf.Lerp(0, 0.5, var_288_3)

					arg_285_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1020ui_story.fillRatio = var_288_4
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1020ui_story then
				local var_288_5 = 0.5

				arg_285_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1020ui_story.fillRatio = var_288_5
			end

			local var_288_6 = 0
			local var_288_7 = 0.625

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_8 = arg_285_1:GetWordFromCfg(1102002065)
				local var_288_9 = arg_285_1:FormatText(var_288_8.content)

				arg_285_1.text_.text = var_288_9

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_10 = 25
				local var_288_11 = utf8.len(var_288_9)
				local var_288_12 = var_288_10 <= 0 and var_288_7 or var_288_7 * (var_288_11 / var_288_10)

				if var_288_12 > 0 and var_288_7 < var_288_12 then
					arg_285_1.talkMaxDuration = var_288_12

					if var_288_12 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_12 + var_288_6
					end
				end

				arg_285_1.text_.text = var_288_9
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_13 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_13 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_13

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_13 and arg_285_1.time_ < var_288_6 + var_288_13 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1102002066 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1102002066
		arg_289_1.duration_ = 2.5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1102002067(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1020ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1020ui_story == nil then
				arg_289_1.var_.characterEffect1020ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1020ui_story and not isNil(var_292_0) then
					arg_289_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1020ui_story then
				arg_289_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_292_4 = 0

			if var_292_4 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_292_5 = 0

			if var_292_5 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_292_6 = 0
			local var_292_7 = 0.3

			if var_292_6 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_8 = arg_289_1:FormatText(StoryNameCfg[613].name)

				arg_289_1.leftNameTxt_.text = var_292_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_9 = arg_289_1:GetWordFromCfg(1102002066)
				local var_292_10 = arg_289_1:FormatText(var_292_9.content)

				arg_289_1.text_.text = var_292_10

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_11 = 12
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002066", "story_v_side_new_1102002.awb") ~= 0 then
					local var_292_14 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002066", "story_v_side_new_1102002.awb") / 1000

					if var_292_14 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_6
					end

					if var_292_9.prefab_name ~= "" and arg_289_1.actors_[var_292_9.prefab_name] ~= nil then
						local var_292_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_9.prefab_name].transform, "story_v_side_new_1102002", "1102002066", "story_v_side_new_1102002.awb")

						arg_289_1:RecordAudio("1102002066", var_292_15)
						arg_289_1:RecordAudio("1102002066", var_292_15)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002066", "story_v_side_new_1102002.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002066", "story_v_side_new_1102002.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_16 = math.max(var_292_7, arg_289_1.talkMaxDuration)

			if var_292_6 <= arg_289_1.time_ and arg_289_1.time_ < var_292_6 + var_292_16 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_6) / var_292_16

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_6 + var_292_16 and arg_289_1.time_ < var_292_6 + var_292_16 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1102002067 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1102002067
		arg_293_1.duration_ = 12.2

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1102002068(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 1.125

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_2 = arg_293_1:FormatText(StoryNameCfg[613].name)

				arg_293_1.leftNameTxt_.text = var_296_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_3 = arg_293_1:GetWordFromCfg(1102002067)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 45
				local var_296_6 = utf8.len(var_296_4)
				local var_296_7 = var_296_5 <= 0 and var_296_1 or var_296_1 * (var_296_6 / var_296_5)

				if var_296_7 > 0 and var_296_1 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002067", "story_v_side_new_1102002.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002067", "story_v_side_new_1102002.awb") / 1000

					if var_296_8 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_0
					end

					if var_296_3.prefab_name ~= "" and arg_293_1.actors_[var_296_3.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_3.prefab_name].transform, "story_v_side_new_1102002", "1102002067", "story_v_side_new_1102002.awb")

						arg_293_1:RecordAudio("1102002067", var_296_9)
						arg_293_1:RecordAudio("1102002067", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002067", "story_v_side_new_1102002.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002067", "story_v_side_new_1102002.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_10 and arg_293_1.time_ < var_296_0 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1102002068 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1102002068
		arg_297_1.duration_ = 7.1

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1102002069(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_2")
			end

			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_300_2 = 0
			local var_300_3 = 0.6

			if var_300_2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_4 = arg_297_1:FormatText(StoryNameCfg[613].name)

				arg_297_1.leftNameTxt_.text = var_300_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_5 = arg_297_1:GetWordFromCfg(1102002068)
				local var_300_6 = arg_297_1:FormatText(var_300_5.content)

				arg_297_1.text_.text = var_300_6

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 24
				local var_300_8 = utf8.len(var_300_6)
				local var_300_9 = var_300_7 <= 0 and var_300_3 or var_300_3 * (var_300_8 / var_300_7)

				if var_300_9 > 0 and var_300_3 < var_300_9 then
					arg_297_1.talkMaxDuration = var_300_9

					if var_300_9 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_6
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002068", "story_v_side_new_1102002.awb") ~= 0 then
					local var_300_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002068", "story_v_side_new_1102002.awb") / 1000

					if var_300_10 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_2
					end

					if var_300_5.prefab_name ~= "" and arg_297_1.actors_[var_300_5.prefab_name] ~= nil then
						local var_300_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_5.prefab_name].transform, "story_v_side_new_1102002", "1102002068", "story_v_side_new_1102002.awb")

						arg_297_1:RecordAudio("1102002068", var_300_11)
						arg_297_1:RecordAudio("1102002068", var_300_11)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002068", "story_v_side_new_1102002.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002068", "story_v_side_new_1102002.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_12 = math.max(var_300_3, arg_297_1.talkMaxDuration)

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_12 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_2) / var_300_12

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_2 + var_300_12 and arg_297_1.time_ < var_300_2 + var_300_12 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1102002069 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1102002069
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1102002070(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1020ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1020ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0, 100, 0)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1020ui_story, var_304_4, var_304_3)

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

			local var_304_9 = arg_301_1.actors_["1020ui_story"]
			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1020ui_story == nil then
				arg_301_1.var_.characterEffect1020ui_story = var_304_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_11 = 0.200000002980232

			if var_304_10 <= arg_301_1.time_ and arg_301_1.time_ < var_304_10 + var_304_11 and not isNil(var_304_9) then
				local var_304_12 = (arg_301_1.time_ - var_304_10) / var_304_11

				if arg_301_1.var_.characterEffect1020ui_story and not isNil(var_304_9) then
					local var_304_13 = Mathf.Lerp(0, 0.5, var_304_12)

					arg_301_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1020ui_story.fillRatio = var_304_13
				end
			end

			if arg_301_1.time_ >= var_304_10 + var_304_11 and arg_301_1.time_ < var_304_10 + var_304_11 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1020ui_story then
				local var_304_14 = 0.5

				arg_301_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1020ui_story.fillRatio = var_304_14
			end

			local var_304_15 = 0
			local var_304_16 = 0.725

			if var_304_15 < arg_301_1.time_ and arg_301_1.time_ <= var_304_15 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_17 = arg_301_1:FormatText(StoryNameCfg[7].name)

				arg_301_1.leftNameTxt_.text = var_304_17

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

				local var_304_18 = arg_301_1:GetWordFromCfg(1102002069)
				local var_304_19 = arg_301_1:FormatText(var_304_18.content)

				arg_301_1.text_.text = var_304_19

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_20 = 29
				local var_304_21 = utf8.len(var_304_19)
				local var_304_22 = var_304_20 <= 0 and var_304_16 or var_304_16 * (var_304_21 / var_304_20)

				if var_304_22 > 0 and var_304_16 < var_304_22 then
					arg_301_1.talkMaxDuration = var_304_22

					if var_304_22 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_22 + var_304_15
					end
				end

				arg_301_1.text_.text = var_304_19
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_23 = math.max(var_304_16, arg_301_1.talkMaxDuration)

			if var_304_15 <= arg_301_1.time_ and arg_301_1.time_ < var_304_15 + var_304_23 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_15) / var_304_23

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_15 + var_304_23 and arg_301_1.time_ < var_304_15 + var_304_23 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102002070 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1102002070
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1102002071(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.525

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(1102002070)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 21
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_8 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_8

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_8 and arg_305_1.time_ < var_308_0 + var_308_8 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1102002071 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1102002071
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1102002072(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.1

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

				local var_312_3 = arg_309_1:GetWordFromCfg(1102002071)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 4
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
	Play1102002072 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1102002072
		arg_313_1.duration_ = 7.3

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1102002073(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.299999999999

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				local var_316_1 = manager.ui.mainCamera.transform.localPosition
				local var_316_2 = Vector3.New(0, 0, 10) + Vector3.New(var_316_1.x, var_316_1.y, 0)
				local var_316_3 = arg_313_1.bgs_.STblack

				var_316_3.transform.localPosition = var_316_2
				var_316_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_316_4 = var_316_3:GetComponent("SpriteRenderer")

				if var_316_4 and var_316_4.sprite then
					local var_316_5 = (var_316_3.transform.localPosition - var_316_1).z
					local var_316_6 = manager.ui.mainCameraCom_
					local var_316_7 = 2 * var_316_5 * Mathf.Tan(var_316_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_316_8 = var_316_7 * var_316_6.aspect
					local var_316_9 = var_316_4.sprite.bounds.size.x
					local var_316_10 = var_316_4.sprite.bounds.size.y
					local var_316_11 = var_316_8 / var_316_9
					local var_316_12 = var_316_7 / var_316_10
					local var_316_13 = var_316_12 < var_316_11 and var_316_11 or var_316_12

					var_316_3.transform.localScale = Vector3.New(var_316_13, var_316_13, 0)
				end

				for iter_316_0, iter_316_1 in pairs(arg_313_1.bgs_) do
					if iter_316_0 ~= "STblack" then
						iter_316_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_316_14 = 0

			if var_316_14 < arg_313_1.time_ and arg_313_1.time_ <= var_316_14 + arg_316_0 then
				arg_313_1.allBtn_.enabled = false
			end

			local var_316_15 = 0.3

			if arg_313_1.time_ >= var_316_14 + var_316_15 and arg_313_1.time_ < var_316_14 + var_316_15 + arg_316_0 then
				arg_313_1.allBtn_.enabled = true
			end

			local var_316_16 = 0.3

			if var_316_16 < arg_313_1.time_ and arg_313_1.time_ <= var_316_16 + arg_316_0 then
				arg_313_1.mask_.enabled = true
				arg_313_1.mask_.raycastTarget = true

				arg_313_1:SetGaussion(false)
			end

			local var_316_17 = 2

			if var_316_16 <= arg_313_1.time_ and arg_313_1.time_ < var_316_16 + var_316_17 then
				local var_316_18 = (arg_313_1.time_ - var_316_16) / var_316_17
				local var_316_19 = Color.New(1, 1, 1)

				var_316_19.a = Mathf.Lerp(1, 0, var_316_18)
				arg_313_1.mask_.color = var_316_19
			end

			if arg_313_1.time_ >= var_316_16 + var_316_17 and arg_313_1.time_ < var_316_16 + var_316_17 + arg_316_0 then
				local var_316_20 = Color.New(1, 1, 1)
				local var_316_21 = 0

				arg_313_1.mask_.enabled = false
				var_316_20.a = var_316_21
				arg_313_1.mask_.color = var_316_20
			end

			local var_316_22 = 0.1
			local var_316_23 = 1

			if var_316_22 < arg_313_1.time_ and arg_313_1.time_ <= var_316_22 + arg_316_0 then
				local var_316_24 = "play"
				local var_316_25 = "effect"

				arg_313_1:AudioAction(var_316_24, var_316_25, "se_story_140", "se_story_140_amb_lfe", "")
			end

			local var_316_26 = 0
			local var_316_27 = 1

			if var_316_26 < arg_313_1.time_ and arg_313_1.time_ <= var_316_26 + arg_316_0 then
				local var_316_28 = "stop"
				local var_316_29 = "effect"

				arg_313_1:AudioAction(var_316_28, var_316_29, "se_story_133", "se_story_133_sea", "")
			end

			local var_316_30 = 0
			local var_316_31 = 0.2

			if var_316_30 < arg_313_1.time_ and arg_313_1.time_ <= var_316_30 + arg_316_0 then
				local var_316_32 = "play"
				local var_316_33 = "music"

				arg_313_1:AudioAction(var_316_32, var_316_33, "ui_battle", "ui_battle_stopbgm", "")

				local var_316_34 = ""
				local var_316_35 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_316_35 ~= "" then
					if arg_313_1.bgmTxt_.text ~= var_316_35 and arg_313_1.bgmTxt_.text ~= "" then
						if arg_313_1.bgmTxt2_.text ~= "" then
							arg_313_1.bgmTxt_.text = arg_313_1.bgmTxt2_.text
						end

						arg_313_1.bgmTxt2_.text = var_316_35

						arg_313_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_313_1.bgmTxt_.text = var_316_35
						arg_313_1.bgmTxt2_.text = var_316_35
					end

					if arg_313_1.bgmTimer then
						arg_313_1.bgmTimer:Stop()

						arg_313_1.bgmTimer = nil
					end

					if arg_313_1.settingData.show_music_name == 1 then
						arg_313_1.musicController:SetSelectedState("show")
						arg_313_1.musicAnimator_:Play("open", 0, 0)

						if arg_313_1.settingData.music_time ~= 0 then
							arg_313_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_313_1.settingData.music_time), function()
								if arg_313_1 == nil or isNil(arg_313_1.bgmTxt_) then
									return
								end

								arg_313_1.musicController:SetSelectedState("hide")
								arg_313_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_316_36 = 0.299999999999
			local var_316_37 = 1

			if var_316_36 < arg_313_1.time_ and arg_313_1.time_ <= var_316_36 + arg_316_0 then
				local var_316_38 = "play"
				local var_316_39 = "effect"

				arg_313_1:AudioAction(var_316_38, var_316_39, "se_story_side_1020", "se_story_side_1020_glass", "")
			end

			local var_316_40 = manager.ui.mainCamera.transform
			local var_316_41 = 0.299999999999

			if var_316_41 < arg_313_1.time_ and arg_313_1.time_ <= var_316_41 + arg_316_0 then
				local var_316_42 = arg_313_1.var_.effectriguangposui
				local var_316_43
				local var_316_44 = var_316_40

				if not var_316_42 then
					var_316_42 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_posui"), var_316_44)
					var_316_42.name = "riguangposui"
					arg_313_1.var_.effectriguangposui = var_316_42
				else
					var_316_42.transform:SetParent(var_316_44)
				end

				var_316_42.transform.localPosition = Vector3.New(0, 0, 0)
				var_316_42.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_316_45 = manager.ui.mainCamera.transform
			local var_316_46 = 2.3

			if var_316_46 < arg_313_1.time_ and arg_313_1.time_ <= var_316_46 + arg_316_0 then
				local var_316_47 = arg_313_1.var_.effectriguangposui

				if var_316_47 then
					Object.Destroy(var_316_47)

					arg_313_1.var_.effectriguangposui = nil
				end
			end

			if arg_313_1.frameCnt_ <= 1 then
				arg_313_1.dialog_:SetActive(false)
			end

			local var_316_48 = 2.299999999999
			local var_316_49 = 0.425

			if var_316_48 < arg_313_1.time_ and arg_313_1.time_ <= var_316_48 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0

				arg_313_1.dialog_:SetActive(true)

				arg_313_1.dialogCg_.alpha = 0

				local var_316_50 = LeanTween.value(arg_313_1.dialog_, 0, 1, 0.3)

				var_316_50:setOnUpdate(LuaHelper.FloatAction(function(arg_318_0)
					arg_313_1.dialogCg_.alpha = arg_318_0
				end))
				var_316_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_313_1.dialog_)
					var_316_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_313_1.duration_ = arg_313_1.duration_ + 0.3

				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_51 = arg_313_1:GetWordFromCfg(1102002072)
				local var_316_52 = arg_313_1:FormatText(var_316_51.content)

				arg_313_1.text_.text = var_316_52

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_53 = 17
				local var_316_54 = utf8.len(var_316_52)
				local var_316_55 = var_316_53 <= 0 and var_316_49 or var_316_49 * (var_316_54 / var_316_53)

				if var_316_55 > 0 and var_316_49 < var_316_55 then
					arg_313_1.talkMaxDuration = var_316_55
					var_316_48 = var_316_48 + 0.3

					if var_316_55 + var_316_48 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_55 + var_316_48
					end
				end

				arg_313_1.text_.text = var_316_52
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_56 = var_316_48 + 0.3
			local var_316_57 = math.max(var_316_49, arg_313_1.talkMaxDuration)

			if var_316_56 <= arg_313_1.time_ and arg_313_1.time_ < var_316_56 + var_316_57 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_56) / var_316_57

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_56 + var_316_57 and arg_313_1.time_ < var_316_56 + var_316_57 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1102002073 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1102002073
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1102002074(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 0.975

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

				local var_323_2 = arg_320_1:GetWordFromCfg(1102002073)
				local var_323_3 = arg_320_1:FormatText(var_323_2.content)

				arg_320_1.text_.text = var_323_3

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 39
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
	Play1102002074 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1102002074
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1102002075(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 0.25

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_2 = arg_324_1:GetWordFromCfg(1102002074)
				local var_327_3 = arg_324_1:FormatText(var_327_2.content)

				arg_324_1.text_.text = var_327_3

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 10
				local var_327_5 = utf8.len(var_327_3)
				local var_327_6 = var_327_4 <= 0 and var_327_1 or var_327_1 * (var_327_5 / var_327_4)

				if var_327_6 > 0 and var_327_1 < var_327_6 then
					arg_324_1.talkMaxDuration = var_327_6

					if var_327_6 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_6 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_3
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_7 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_7 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_7

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_7 and arg_324_1.time_ < var_327_0 + var_327_7 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1102002075 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1102002075
		arg_328_1.duration_ = 7

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1102002076(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				local var_331_1 = manager.ui.mainCamera.transform.localPosition
				local var_331_2 = Vector3.New(0, 0, 10) + Vector3.New(var_331_1.x, var_331_1.y, 0)
				local var_331_3 = arg_328_1.bgs_.L02h

				var_331_3.transform.localPosition = var_331_2
				var_331_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_331_4 = var_331_3:GetComponent("SpriteRenderer")

				if var_331_4 and var_331_4.sprite then
					local var_331_5 = (var_331_3.transform.localPosition - var_331_1).z
					local var_331_6 = manager.ui.mainCameraCom_
					local var_331_7 = 2 * var_331_5 * Mathf.Tan(var_331_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_331_8 = var_331_7 * var_331_6.aspect
					local var_331_9 = var_331_4.sprite.bounds.size.x
					local var_331_10 = var_331_4.sprite.bounds.size.y
					local var_331_11 = var_331_8 / var_331_9
					local var_331_12 = var_331_7 / var_331_10
					local var_331_13 = var_331_12 < var_331_11 and var_331_11 or var_331_12

					var_331_3.transform.localScale = Vector3.New(var_331_13, var_331_13, 0)
				end

				for iter_331_0, iter_331_1 in pairs(arg_328_1.bgs_) do
					if iter_331_0 ~= "L02h" then
						iter_331_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_331_14 = 2

			if var_331_14 < arg_328_1.time_ and arg_328_1.time_ <= var_331_14 + arg_331_0 then
				arg_328_1.allBtn_.enabled = false
			end

			local var_331_15 = 0.333333333333333

			if arg_328_1.time_ >= var_331_14 + var_331_15 and arg_328_1.time_ < var_331_14 + var_331_15 + arg_331_0 then
				arg_328_1.allBtn_.enabled = true
			end

			local var_331_16 = 0

			if var_331_16 < arg_328_1.time_ and arg_328_1.time_ <= var_331_16 + arg_331_0 then
				arg_328_1.mask_.enabled = true
				arg_328_1.mask_.raycastTarget = true

				arg_328_1:SetGaussion(false)
			end

			local var_331_17 = 2

			if var_331_16 <= arg_328_1.time_ and arg_328_1.time_ < var_331_16 + var_331_17 then
				local var_331_18 = (arg_328_1.time_ - var_331_16) / var_331_17
				local var_331_19 = Color.New(0, 0, 0)

				var_331_19.a = Mathf.Lerp(1, 0, var_331_18)
				arg_328_1.mask_.color = var_331_19
			end

			if arg_328_1.time_ >= var_331_16 + var_331_17 and arg_328_1.time_ < var_331_16 + var_331_17 + arg_331_0 then
				local var_331_20 = Color.New(0, 0, 0)
				local var_331_21 = 0

				arg_328_1.mask_.enabled = false
				var_331_20.a = var_331_21
				arg_328_1.mask_.color = var_331_20
			end

			local var_331_22 = 0
			local var_331_23 = 1

			if var_331_22 < arg_328_1.time_ and arg_328_1.time_ <= var_331_22 + arg_331_0 then
				local var_331_24 = "stop"
				local var_331_25 = "effect"

				arg_328_1:AudioAction(var_331_24, var_331_25, "se_story_140", "se_story_140_amb_lfe", "")
			end

			local var_331_26 = 0.125
			local var_331_27 = 1

			if var_331_26 < arg_328_1.time_ and arg_328_1.time_ <= var_331_26 + arg_331_0 then
				local var_331_28 = "play"
				local var_331_29 = "effect"

				arg_328_1:AudioAction(var_331_28, var_331_29, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_331_30 = 0
			local var_331_31 = 0.2

			if var_331_30 < arg_328_1.time_ and arg_328_1.time_ <= var_331_30 + arg_331_0 then
				local var_331_32 = "play"
				local var_331_33 = "music"

				arg_328_1:AudioAction(var_331_32, var_331_33, "ui_battle", "ui_battle_stopbgm", "")

				local var_331_34 = ""
				local var_331_35 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_331_35 ~= "" then
					if arg_328_1.bgmTxt_.text ~= var_331_35 and arg_328_1.bgmTxt_.text ~= "" then
						if arg_328_1.bgmTxt2_.text ~= "" then
							arg_328_1.bgmTxt_.text = arg_328_1.bgmTxt2_.text
						end

						arg_328_1.bgmTxt2_.text = var_331_35

						arg_328_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_328_1.bgmTxt_.text = var_331_35
						arg_328_1.bgmTxt2_.text = var_331_35
					end

					if arg_328_1.bgmTimer then
						arg_328_1.bgmTimer:Stop()

						arg_328_1.bgmTimer = nil
					end

					if arg_328_1.settingData.show_music_name == 1 then
						arg_328_1.musicController:SetSelectedState("show")
						arg_328_1.musicAnimator_:Play("open", 0, 0)

						if arg_328_1.settingData.music_time ~= 0 then
							arg_328_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_328_1.settingData.music_time), function()
								if arg_328_1 == nil or isNil(arg_328_1.bgmTxt_) then
									return
								end

								arg_328_1.musicController:SetSelectedState("hide")
								arg_328_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_331_36 = 0.333333333333333
			local var_331_37 = 1

			if var_331_36 < arg_328_1.time_ and arg_328_1.time_ <= var_331_36 + arg_331_0 then
				local var_331_38 = "play"
				local var_331_39 = "music"

				arg_328_1:AudioAction(var_331_38, var_331_39, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_331_40 = ""
				local var_331_41 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if var_331_41 ~= "" then
					if arg_328_1.bgmTxt_.text ~= var_331_41 and arg_328_1.bgmTxt_.text ~= "" then
						if arg_328_1.bgmTxt2_.text ~= "" then
							arg_328_1.bgmTxt_.text = arg_328_1.bgmTxt2_.text
						end

						arg_328_1.bgmTxt2_.text = var_331_41

						arg_328_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_328_1.bgmTxt_.text = var_331_41
						arg_328_1.bgmTxt2_.text = var_331_41
					end

					if arg_328_1.bgmTimer then
						arg_328_1.bgmTimer:Stop()

						arg_328_1.bgmTimer = nil
					end

					if arg_328_1.settingData.show_music_name == 1 then
						arg_328_1.musicController:SetSelectedState("show")
						arg_328_1.musicAnimator_:Play("open", 0, 0)

						if arg_328_1.settingData.music_time ~= 0 then
							arg_328_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_328_1.settingData.music_time), function()
								if arg_328_1 == nil or isNil(arg_328_1.bgmTxt_) then
									return
								end

								arg_328_1.musicController:SetSelectedState("hide")
								arg_328_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_328_1.frameCnt_ <= 1 then
				arg_328_1.dialog_:SetActive(false)
			end

			local var_331_42 = 2
			local var_331_43 = 0.25

			if var_331_42 < arg_328_1.time_ and arg_328_1.time_ <= var_331_42 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0

				arg_328_1.dialog_:SetActive(true)

				arg_328_1.dialogCg_.alpha = 0

				local var_331_44 = LeanTween.value(arg_328_1.dialog_, 0, 1, 0.3)

				var_331_44:setOnUpdate(LuaHelper.FloatAction(function(arg_334_0)
					arg_328_1.dialogCg_.alpha = arg_334_0
				end))
				var_331_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_328_1.dialog_)
					var_331_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_328_1.duration_ = arg_328_1.duration_ + 0.3

				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_45 = arg_328_1:GetWordFromCfg(1102002075)
				local var_331_46 = arg_328_1:FormatText(var_331_45.content)

				arg_328_1.text_.text = var_331_46

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_47 = 10
				local var_331_48 = utf8.len(var_331_46)
				local var_331_49 = var_331_47 <= 0 and var_331_43 or var_331_43 * (var_331_48 / var_331_47)

				if var_331_49 > 0 and var_331_43 < var_331_49 then
					arg_328_1.talkMaxDuration = var_331_49
					var_331_42 = var_331_42 + 0.3

					if var_331_49 + var_331_42 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_49 + var_331_42
					end
				end

				arg_328_1.text_.text = var_331_46
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_50 = var_331_42 + 0.3
			local var_331_51 = math.max(var_331_43, arg_328_1.talkMaxDuration)

			if var_331_50 <= arg_328_1.time_ and arg_328_1.time_ < var_331_50 + var_331_51 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_50) / var_331_51

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_50 + var_331_51 and arg_328_1.time_ < var_331_50 + var_331_51 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play1102002076 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1102002076
		arg_336_1.duration_ = 5.07

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1102002077(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1020ui_story"].transform
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.var_.moveOldPos1020ui_story = var_339_0.localPosition
			end

			local var_339_2 = 0.001

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2
				local var_339_4 = Vector3.New(0, -0.85, -6.25)

				var_339_0.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1020ui_story, var_339_4, var_339_3)

				local var_339_5 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_5.x, var_339_5.y, var_339_5.z)

				local var_339_6 = var_339_0.localEulerAngles

				var_339_6.z = 0
				var_339_6.x = 0
				var_339_0.localEulerAngles = var_339_6
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 then
				var_339_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_339_7 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_7.x, var_339_7.y, var_339_7.z)

				local var_339_8 = var_339_0.localEulerAngles

				var_339_8.z = 0
				var_339_8.x = 0
				var_339_0.localEulerAngles = var_339_8
			end

			local var_339_9 = arg_336_1.actors_["1020ui_story"]
			local var_339_10 = 0

			if var_339_10 < arg_336_1.time_ and arg_336_1.time_ <= var_339_10 + arg_339_0 and not isNil(var_339_9) and arg_336_1.var_.characterEffect1020ui_story == nil then
				arg_336_1.var_.characterEffect1020ui_story = var_339_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_11 = 0.200000002980232

			if var_339_10 <= arg_336_1.time_ and arg_336_1.time_ < var_339_10 + var_339_11 and not isNil(var_339_9) then
				local var_339_12 = (arg_336_1.time_ - var_339_10) / var_339_11

				if arg_336_1.var_.characterEffect1020ui_story and not isNil(var_339_9) then
					arg_336_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_10 + var_339_11 and arg_336_1.time_ < var_339_10 + var_339_11 + arg_339_0 and not isNil(var_339_9) and arg_336_1.var_.characterEffect1020ui_story then
				arg_336_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_339_13 = 0

			if var_339_13 < arg_336_1.time_ and arg_336_1.time_ <= var_339_13 + arg_339_0 then
				arg_336_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_339_14 = 0

			if var_339_14 < arg_336_1.time_ and arg_336_1.time_ <= var_339_14 + arg_339_0 then
				arg_336_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_339_15 = 0
			local var_339_16 = 0.575

			if var_339_15 < arg_336_1.time_ and arg_336_1.time_ <= var_339_15 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_17 = arg_336_1:FormatText(StoryNameCfg[613].name)

				arg_336_1.leftNameTxt_.text = var_339_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_18 = arg_336_1:GetWordFromCfg(1102002076)
				local var_339_19 = arg_336_1:FormatText(var_339_18.content)

				arg_336_1.text_.text = var_339_19

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_20 = 23
				local var_339_21 = utf8.len(var_339_19)
				local var_339_22 = var_339_20 <= 0 and var_339_16 or var_339_16 * (var_339_21 / var_339_20)

				if var_339_22 > 0 and var_339_16 < var_339_22 then
					arg_336_1.talkMaxDuration = var_339_22

					if var_339_22 + var_339_15 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_22 + var_339_15
					end
				end

				arg_336_1.text_.text = var_339_19
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002076", "story_v_side_new_1102002.awb") ~= 0 then
					local var_339_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002076", "story_v_side_new_1102002.awb") / 1000

					if var_339_23 + var_339_15 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_23 + var_339_15
					end

					if var_339_18.prefab_name ~= "" and arg_336_1.actors_[var_339_18.prefab_name] ~= nil then
						local var_339_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_18.prefab_name].transform, "story_v_side_new_1102002", "1102002076", "story_v_side_new_1102002.awb")

						arg_336_1:RecordAudio("1102002076", var_339_24)
						arg_336_1:RecordAudio("1102002076", var_339_24)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002076", "story_v_side_new_1102002.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002076", "story_v_side_new_1102002.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_25 = math.max(var_339_16, arg_336_1.talkMaxDuration)

			if var_339_15 <= arg_336_1.time_ and arg_336_1.time_ < var_339_15 + var_339_25 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_15) / var_339_25

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_15 + var_339_25 and arg_336_1.time_ < var_339_15 + var_339_25 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play1102002077 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1102002077
		arg_340_1.duration_ = 9.2

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1102002078(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 0.8

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_2 = arg_340_1:FormatText(StoryNameCfg[613].name)

				arg_340_1.leftNameTxt_.text = var_343_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_3 = arg_340_1:GetWordFromCfg(1102002077)
				local var_343_4 = arg_340_1:FormatText(var_343_3.content)

				arg_340_1.text_.text = var_343_4

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002077", "story_v_side_new_1102002.awb") ~= 0 then
					local var_343_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002077", "story_v_side_new_1102002.awb") / 1000

					if var_343_8 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_8 + var_343_0
					end

					if var_343_3.prefab_name ~= "" and arg_340_1.actors_[var_343_3.prefab_name] ~= nil then
						local var_343_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_3.prefab_name].transform, "story_v_side_new_1102002", "1102002077", "story_v_side_new_1102002.awb")

						arg_340_1:RecordAudio("1102002077", var_343_9)
						arg_340_1:RecordAudio("1102002077", var_343_9)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002077", "story_v_side_new_1102002.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002077", "story_v_side_new_1102002.awb")
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
	Play1102002078 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1102002078
		arg_344_1.duration_ = 4.37

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1102002079(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_347_2 = 0
			local var_347_3 = 0.375

			if var_347_2 < arg_344_1.time_ and arg_344_1.time_ <= var_347_2 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_4 = arg_344_1:FormatText(StoryNameCfg[613].name)

				arg_344_1.leftNameTxt_.text = var_347_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_5 = arg_344_1:GetWordFromCfg(1102002078)
				local var_347_6 = arg_344_1:FormatText(var_347_5.content)

				arg_344_1.text_.text = var_347_6

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_7 = 15
				local var_347_8 = utf8.len(var_347_6)
				local var_347_9 = var_347_7 <= 0 and var_347_3 or var_347_3 * (var_347_8 / var_347_7)

				if var_347_9 > 0 and var_347_3 < var_347_9 then
					arg_344_1.talkMaxDuration = var_347_9

					if var_347_9 + var_347_2 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_9 + var_347_2
					end
				end

				arg_344_1.text_.text = var_347_6
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002078", "story_v_side_new_1102002.awb") ~= 0 then
					local var_347_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002078", "story_v_side_new_1102002.awb") / 1000

					if var_347_10 + var_347_2 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_10 + var_347_2
					end

					if var_347_5.prefab_name ~= "" and arg_344_1.actors_[var_347_5.prefab_name] ~= nil then
						local var_347_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_5.prefab_name].transform, "story_v_side_new_1102002", "1102002078", "story_v_side_new_1102002.awb")

						arg_344_1:RecordAudio("1102002078", var_347_11)
						arg_344_1:RecordAudio("1102002078", var_347_11)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002078", "story_v_side_new_1102002.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002078", "story_v_side_new_1102002.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_12 = math.max(var_347_3, arg_344_1.talkMaxDuration)

			if var_347_2 <= arg_344_1.time_ and arg_344_1.time_ < var_347_2 + var_347_12 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_2) / var_347_12

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_2 + var_347_12 and arg_344_1.time_ < var_347_2 + var_347_12 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play1102002079 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1102002079
		arg_348_1.duration_ = 9

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1102002080(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = "H02a"

			if arg_348_1.bgs_[var_351_0] == nil then
				local var_351_1 = Object.Instantiate(arg_348_1.paintGo_)

				var_351_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_351_0)
				var_351_1.name = var_351_0
				var_351_1.transform.parent = arg_348_1.stage_.transform
				var_351_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_348_1.bgs_[var_351_0] = var_351_1
			end

			local var_351_2 = 2

			if var_351_2 < arg_348_1.time_ and arg_348_1.time_ <= var_351_2 + arg_351_0 then
				local var_351_3 = manager.ui.mainCamera.transform.localPosition
				local var_351_4 = Vector3.New(0, 0, 10) + Vector3.New(var_351_3.x, var_351_3.y, 0)
				local var_351_5 = arg_348_1.bgs_.H02a

				var_351_5.transform.localPosition = var_351_4
				var_351_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_351_6 = var_351_5:GetComponent("SpriteRenderer")

				if var_351_6 and var_351_6.sprite then
					local var_351_7 = (var_351_5.transform.localPosition - var_351_3).z
					local var_351_8 = manager.ui.mainCameraCom_
					local var_351_9 = 2 * var_351_7 * Mathf.Tan(var_351_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_351_10 = var_351_9 * var_351_8.aspect
					local var_351_11 = var_351_6.sprite.bounds.size.x
					local var_351_12 = var_351_6.sprite.bounds.size.y
					local var_351_13 = var_351_10 / var_351_11
					local var_351_14 = var_351_9 / var_351_12
					local var_351_15 = var_351_14 < var_351_13 and var_351_13 or var_351_14

					var_351_5.transform.localScale = Vector3.New(var_351_15, var_351_15, 0)
				end

				for iter_351_0, iter_351_1 in pairs(arg_348_1.bgs_) do
					if iter_351_0 ~= "H02a" then
						iter_351_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_351_16 = 3.999999999999

			if var_351_16 < arg_348_1.time_ and arg_348_1.time_ <= var_351_16 + arg_351_0 then
				arg_348_1.allBtn_.enabled = false
			end

			local var_351_17 = 0.3

			if arg_348_1.time_ >= var_351_16 + var_351_17 and arg_348_1.time_ < var_351_16 + var_351_17 + arg_351_0 then
				arg_348_1.allBtn_.enabled = true
			end

			local var_351_18 = 0

			if var_351_18 < arg_348_1.time_ and arg_348_1.time_ <= var_351_18 + arg_351_0 then
				arg_348_1.mask_.enabled = true
				arg_348_1.mask_.raycastTarget = true

				arg_348_1:SetGaussion(false)
			end

			local var_351_19 = 2

			if var_351_18 <= arg_348_1.time_ and arg_348_1.time_ < var_351_18 + var_351_19 then
				local var_351_20 = (arg_348_1.time_ - var_351_18) / var_351_19
				local var_351_21 = Color.New(0, 0, 0)

				var_351_21.a = Mathf.Lerp(0, 1, var_351_20)
				arg_348_1.mask_.color = var_351_21
			end

			if arg_348_1.time_ >= var_351_18 + var_351_19 and arg_348_1.time_ < var_351_18 + var_351_19 + arg_351_0 then
				local var_351_22 = Color.New(0, 0, 0)

				var_351_22.a = 1
				arg_348_1.mask_.color = var_351_22
			end

			local var_351_23 = 2

			if var_351_23 < arg_348_1.time_ and arg_348_1.time_ <= var_351_23 + arg_351_0 then
				arg_348_1.mask_.enabled = true
				arg_348_1.mask_.raycastTarget = true

				arg_348_1:SetGaussion(false)
			end

			local var_351_24 = 2

			if var_351_23 <= arg_348_1.time_ and arg_348_1.time_ < var_351_23 + var_351_24 then
				local var_351_25 = (arg_348_1.time_ - var_351_23) / var_351_24
				local var_351_26 = Color.New(0, 0, 0)

				var_351_26.a = Mathf.Lerp(1, 0, var_351_25)
				arg_348_1.mask_.color = var_351_26
			end

			if arg_348_1.time_ >= var_351_23 + var_351_24 and arg_348_1.time_ < var_351_23 + var_351_24 + arg_351_0 then
				local var_351_27 = Color.New(0, 0, 0)
				local var_351_28 = 0

				arg_348_1.mask_.enabled = false
				var_351_27.a = var_351_28
				arg_348_1.mask_.color = var_351_27
			end

			local var_351_29 = arg_348_1.actors_["1020ui_story"].transform
			local var_351_30 = 1.96599999815226

			if var_351_30 < arg_348_1.time_ and arg_348_1.time_ <= var_351_30 + arg_351_0 then
				arg_348_1.var_.moveOldPos1020ui_story = var_351_29.localPosition
			end

			local var_351_31 = 0.001

			if var_351_30 <= arg_348_1.time_ and arg_348_1.time_ < var_351_30 + var_351_31 then
				local var_351_32 = (arg_348_1.time_ - var_351_30) / var_351_31
				local var_351_33 = Vector3.New(0, 100, 0)

				var_351_29.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1020ui_story, var_351_33, var_351_32)

				local var_351_34 = manager.ui.mainCamera.transform.position - var_351_29.position

				var_351_29.forward = Vector3.New(var_351_34.x, var_351_34.y, var_351_34.z)

				local var_351_35 = var_351_29.localEulerAngles

				var_351_35.z = 0
				var_351_35.x = 0
				var_351_29.localEulerAngles = var_351_35
			end

			if arg_348_1.time_ >= var_351_30 + var_351_31 and arg_348_1.time_ < var_351_30 + var_351_31 + arg_351_0 then
				var_351_29.localPosition = Vector3.New(0, 100, 0)

				local var_351_36 = manager.ui.mainCamera.transform.position - var_351_29.position

				var_351_29.forward = Vector3.New(var_351_36.x, var_351_36.y, var_351_36.z)

				local var_351_37 = var_351_29.localEulerAngles

				var_351_37.z = 0
				var_351_37.x = 0
				var_351_29.localEulerAngles = var_351_37
			end

			local var_351_38 = arg_348_1.actors_["1020ui_story"]
			local var_351_39 = 1.96599999815226

			if var_351_39 < arg_348_1.time_ and arg_348_1.time_ <= var_351_39 + arg_351_0 and not isNil(var_351_38) and arg_348_1.var_.characterEffect1020ui_story == nil then
				arg_348_1.var_.characterEffect1020ui_story = var_351_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_40 = 0.034000001847744

			if var_351_39 <= arg_348_1.time_ and arg_348_1.time_ < var_351_39 + var_351_40 and not isNil(var_351_38) then
				local var_351_41 = (arg_348_1.time_ - var_351_39) / var_351_40

				if arg_348_1.var_.characterEffect1020ui_story and not isNil(var_351_38) then
					local var_351_42 = Mathf.Lerp(0, 0.5, var_351_41)

					arg_348_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_348_1.var_.characterEffect1020ui_story.fillRatio = var_351_42
				end
			end

			if arg_348_1.time_ >= var_351_39 + var_351_40 and arg_348_1.time_ < var_351_39 + var_351_40 + arg_351_0 and not isNil(var_351_38) and arg_348_1.var_.characterEffect1020ui_story then
				local var_351_43 = 0.5

				arg_348_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_348_1.var_.characterEffect1020ui_story.fillRatio = var_351_43
			end

			local var_351_44 = 0.466666666666667
			local var_351_45 = 1

			if var_351_44 < arg_348_1.time_ and arg_348_1.time_ <= var_351_44 + arg_351_0 then
				local var_351_46 = "stop"
				local var_351_47 = "effect"

				arg_348_1:AudioAction(var_351_46, var_351_47, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_351_48 = 1.63333333333333
			local var_351_49 = 1

			if var_351_48 < arg_348_1.time_ and arg_348_1.time_ <= var_351_48 + arg_351_0 then
				local var_351_50 = "play"
				local var_351_51 = "effect"

				arg_348_1:AudioAction(var_351_50, var_351_51, "se_story_side_1020", "se_story_side_1020_amb_sea_night", "")
			end

			if arg_348_1.frameCnt_ <= 1 then
				arg_348_1.dialog_:SetActive(false)
			end

			local var_351_52 = 3.999999999999
			local var_351_53 = 0.275

			if var_351_52 < arg_348_1.time_ and arg_348_1.time_ <= var_351_52 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0

				arg_348_1.dialog_:SetActive(true)

				arg_348_1.dialogCg_.alpha = 0

				local var_351_54 = LeanTween.value(arg_348_1.dialog_, 0, 1, 0.3)

				var_351_54:setOnUpdate(LuaHelper.FloatAction(function(arg_352_0)
					arg_348_1.dialogCg_.alpha = arg_352_0
				end))
				var_351_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_348_1.dialog_)
					var_351_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_348_1.duration_ = arg_348_1.duration_ + 0.3

				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_55 = arg_348_1:GetWordFromCfg(1102002079)
				local var_351_56 = arg_348_1:FormatText(var_351_55.content)

				arg_348_1.text_.text = var_351_56

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_57 = 11
				local var_351_58 = utf8.len(var_351_56)
				local var_351_59 = var_351_57 <= 0 and var_351_53 or var_351_53 * (var_351_58 / var_351_57)

				if var_351_59 > 0 and var_351_53 < var_351_59 then
					arg_348_1.talkMaxDuration = var_351_59
					var_351_52 = var_351_52 + 0.3

					if var_351_59 + var_351_52 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_59 + var_351_52
					end
				end

				arg_348_1.text_.text = var_351_56
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_60 = var_351_52 + 0.3
			local var_351_61 = math.max(var_351_53, arg_348_1.talkMaxDuration)

			if var_351_60 <= arg_348_1.time_ and arg_348_1.time_ < var_351_60 + var_351_61 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_60) / var_351_61

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_60 + var_351_61 and arg_348_1.time_ < var_351_60 + var_351_61 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play1102002080 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1102002080
		arg_354_1.duration_ = 5.67

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1102002081(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1020ui_story"].transform
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.var_.moveOldPos1020ui_story = var_357_0.localPosition
			end

			local var_357_2 = 0.001

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2
				local var_357_4 = Vector3.New(0, -0.85, -6.25)

				var_357_0.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1020ui_story, var_357_4, var_357_3)

				local var_357_5 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_5.x, var_357_5.y, var_357_5.z)

				local var_357_6 = var_357_0.localEulerAngles

				var_357_6.z = 0
				var_357_6.x = 0
				var_357_0.localEulerAngles = var_357_6
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 then
				var_357_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_357_7 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_7.x, var_357_7.y, var_357_7.z)

				local var_357_8 = var_357_0.localEulerAngles

				var_357_8.z = 0
				var_357_8.x = 0
				var_357_0.localEulerAngles = var_357_8
			end

			local var_357_9 = arg_354_1.actors_["1020ui_story"]
			local var_357_10 = 0

			if var_357_10 < arg_354_1.time_ and arg_354_1.time_ <= var_357_10 + arg_357_0 and not isNil(var_357_9) and arg_354_1.var_.characterEffect1020ui_story == nil then
				arg_354_1.var_.characterEffect1020ui_story = var_357_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_11 = 0.200000002980232

			if var_357_10 <= arg_354_1.time_ and arg_354_1.time_ < var_357_10 + var_357_11 and not isNil(var_357_9) then
				local var_357_12 = (arg_354_1.time_ - var_357_10) / var_357_11

				if arg_354_1.var_.characterEffect1020ui_story and not isNil(var_357_9) then
					arg_354_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= var_357_10 + var_357_11 and arg_354_1.time_ < var_357_10 + var_357_11 + arg_357_0 and not isNil(var_357_9) and arg_354_1.var_.characterEffect1020ui_story then
				arg_354_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_357_13 = 0

			if var_357_13 < arg_354_1.time_ and arg_354_1.time_ <= var_357_13 + arg_357_0 then
				arg_354_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_357_14 = 0

			if var_357_14 < arg_354_1.time_ and arg_354_1.time_ <= var_357_14 + arg_357_0 then
				arg_354_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_357_15 = 0
			local var_357_16 = 0.65

			if var_357_15 < arg_354_1.time_ and arg_354_1.time_ <= var_357_15 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_17 = arg_354_1:FormatText(StoryNameCfg[613].name)

				arg_354_1.leftNameTxt_.text = var_357_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_18 = arg_354_1:GetWordFromCfg(1102002080)
				local var_357_19 = arg_354_1:FormatText(var_357_18.content)

				arg_354_1.text_.text = var_357_19

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_20 = 26
				local var_357_21 = utf8.len(var_357_19)
				local var_357_22 = var_357_20 <= 0 and var_357_16 or var_357_16 * (var_357_21 / var_357_20)

				if var_357_22 > 0 and var_357_16 < var_357_22 then
					arg_354_1.talkMaxDuration = var_357_22

					if var_357_22 + var_357_15 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_22 + var_357_15
					end
				end

				arg_354_1.text_.text = var_357_19
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002080", "story_v_side_new_1102002.awb") ~= 0 then
					local var_357_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002080", "story_v_side_new_1102002.awb") / 1000

					if var_357_23 + var_357_15 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_23 + var_357_15
					end

					if var_357_18.prefab_name ~= "" and arg_354_1.actors_[var_357_18.prefab_name] ~= nil then
						local var_357_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_18.prefab_name].transform, "story_v_side_new_1102002", "1102002080", "story_v_side_new_1102002.awb")

						arg_354_1:RecordAudio("1102002080", var_357_24)
						arg_354_1:RecordAudio("1102002080", var_357_24)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002080", "story_v_side_new_1102002.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002080", "story_v_side_new_1102002.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_25 = math.max(var_357_16, arg_354_1.talkMaxDuration)

			if var_357_15 <= arg_354_1.time_ and arg_354_1.time_ < var_357_15 + var_357_25 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_15) / var_357_25

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_15 + var_357_25 and arg_354_1.time_ < var_357_15 + var_357_25 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play1102002081 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1102002081
		arg_358_1.duration_ = 3.2

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1102002082(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 0.375

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[613].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_3 = arg_358_1:GetWordFromCfg(1102002081)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 15
				local var_361_6 = utf8.len(var_361_4)
				local var_361_7 = var_361_5 <= 0 and var_361_1 or var_361_1 * (var_361_6 / var_361_5)

				if var_361_7 > 0 and var_361_1 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_4
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002081", "story_v_side_new_1102002.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002081", "story_v_side_new_1102002.awb") / 1000

					if var_361_8 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_0
					end

					if var_361_3.prefab_name ~= "" and arg_358_1.actors_[var_361_3.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_3.prefab_name].transform, "story_v_side_new_1102002", "1102002081", "story_v_side_new_1102002.awb")

						arg_358_1:RecordAudio("1102002081", var_361_9)
						arg_358_1:RecordAudio("1102002081", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002081", "story_v_side_new_1102002.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002081", "story_v_side_new_1102002.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_10 and arg_358_1.time_ < var_361_0 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1102002082 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1102002082
		arg_362_1.duration_ = 2.67

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1102002083(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action5_1")
			end

			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_365_2 = 0
			local var_365_3 = 0.25

			if var_365_2 < arg_362_1.time_ and arg_362_1.time_ <= var_365_2 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_4 = arg_362_1:FormatText(StoryNameCfg[613].name)

				arg_362_1.leftNameTxt_.text = var_365_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_5 = arg_362_1:GetWordFromCfg(1102002082)
				local var_365_6 = arg_362_1:FormatText(var_365_5.content)

				arg_362_1.text_.text = var_365_6

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_7 = 10
				local var_365_8 = utf8.len(var_365_6)
				local var_365_9 = var_365_7 <= 0 and var_365_3 or var_365_3 * (var_365_8 / var_365_7)

				if var_365_9 > 0 and var_365_3 < var_365_9 then
					arg_362_1.talkMaxDuration = var_365_9

					if var_365_9 + var_365_2 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_9 + var_365_2
					end
				end

				arg_362_1.text_.text = var_365_6
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002082", "story_v_side_new_1102002.awb") ~= 0 then
					local var_365_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002082", "story_v_side_new_1102002.awb") / 1000

					if var_365_10 + var_365_2 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_10 + var_365_2
					end

					if var_365_5.prefab_name ~= "" and arg_362_1.actors_[var_365_5.prefab_name] ~= nil then
						local var_365_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_5.prefab_name].transform, "story_v_side_new_1102002", "1102002082", "story_v_side_new_1102002.awb")

						arg_362_1:RecordAudio("1102002082", var_365_11)
						arg_362_1:RecordAudio("1102002082", var_365_11)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002082", "story_v_side_new_1102002.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002082", "story_v_side_new_1102002.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_12 = math.max(var_365_3, arg_362_1.talkMaxDuration)

			if var_365_2 <= arg_362_1.time_ and arg_362_1.time_ < var_365_2 + var_365_12 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_2) / var_365_12

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_2 + var_365_12 and arg_362_1.time_ < var_365_2 + var_365_12 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1102002083 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1102002083
		arg_366_1.duration_ = 7

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1102002084(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = "H04"

			if arg_366_1.bgs_[var_369_0] == nil then
				local var_369_1 = Object.Instantiate(arg_366_1.paintGo_)

				var_369_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_369_0)
				var_369_1.name = var_369_0
				var_369_1.transform.parent = arg_366_1.stage_.transform
				var_369_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_366_1.bgs_[var_369_0] = var_369_1
			end

			local var_369_2 = 0

			if var_369_2 < arg_366_1.time_ and arg_366_1.time_ <= var_369_2 + arg_369_0 then
				local var_369_3 = manager.ui.mainCamera.transform.localPosition
				local var_369_4 = Vector3.New(0, 0, 10) + Vector3.New(var_369_3.x, var_369_3.y, 0)
				local var_369_5 = arg_366_1.bgs_.H04

				var_369_5.transform.localPosition = var_369_4
				var_369_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_369_6 = var_369_5:GetComponent("SpriteRenderer")

				if var_369_6 and var_369_6.sprite then
					local var_369_7 = (var_369_5.transform.localPosition - var_369_3).z
					local var_369_8 = manager.ui.mainCameraCom_
					local var_369_9 = 2 * var_369_7 * Mathf.Tan(var_369_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_369_10 = var_369_9 * var_369_8.aspect
					local var_369_11 = var_369_6.sprite.bounds.size.x
					local var_369_12 = var_369_6.sprite.bounds.size.y
					local var_369_13 = var_369_10 / var_369_11
					local var_369_14 = var_369_9 / var_369_12
					local var_369_15 = var_369_14 < var_369_13 and var_369_13 or var_369_14

					var_369_5.transform.localScale = Vector3.New(var_369_15, var_369_15, 0)
				end

				for iter_369_0, iter_369_1 in pairs(arg_366_1.bgs_) do
					if iter_369_0 ~= "H04" then
						iter_369_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_369_16 = 2

			if var_369_16 < arg_366_1.time_ and arg_366_1.time_ <= var_369_16 + arg_369_0 then
				arg_366_1.allBtn_.enabled = false
			end

			local var_369_17 = 0.3

			if arg_366_1.time_ >= var_369_16 + var_369_17 and arg_366_1.time_ < var_369_16 + var_369_17 + arg_369_0 then
				arg_366_1.allBtn_.enabled = true
			end

			local var_369_18 = 0

			if var_369_18 < arg_366_1.time_ and arg_366_1.time_ <= var_369_18 + arg_369_0 then
				arg_366_1.mask_.enabled = true
				arg_366_1.mask_.raycastTarget = true

				arg_366_1:SetGaussion(false)
			end

			local var_369_19 = 2

			if var_369_18 <= arg_366_1.time_ and arg_366_1.time_ < var_369_18 + var_369_19 then
				local var_369_20 = (arg_366_1.time_ - var_369_18) / var_369_19
				local var_369_21 = Color.New(0, 0, 0)

				var_369_21.a = Mathf.Lerp(1, 0, var_369_20)
				arg_366_1.mask_.color = var_369_21
			end

			if arg_366_1.time_ >= var_369_18 + var_369_19 and arg_366_1.time_ < var_369_18 + var_369_19 + arg_369_0 then
				local var_369_22 = Color.New(0, 0, 0)
				local var_369_23 = 0

				arg_366_1.mask_.enabled = false
				var_369_22.a = var_369_23
				arg_366_1.mask_.color = var_369_22
			end

			local var_369_24 = arg_366_1.actors_["1020ui_story"].transform
			local var_369_25 = 0

			if var_369_25 < arg_366_1.time_ and arg_366_1.time_ <= var_369_25 + arg_369_0 then
				arg_366_1.var_.moveOldPos1020ui_story = var_369_24.localPosition
			end

			local var_369_26 = 0.001

			if var_369_25 <= arg_366_1.time_ and arg_366_1.time_ < var_369_25 + var_369_26 then
				local var_369_27 = (arg_366_1.time_ - var_369_25) / var_369_26
				local var_369_28 = Vector3.New(0, 100, 0)

				var_369_24.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1020ui_story, var_369_28, var_369_27)

				local var_369_29 = manager.ui.mainCamera.transform.position - var_369_24.position

				var_369_24.forward = Vector3.New(var_369_29.x, var_369_29.y, var_369_29.z)

				local var_369_30 = var_369_24.localEulerAngles

				var_369_30.z = 0
				var_369_30.x = 0
				var_369_24.localEulerAngles = var_369_30
			end

			if arg_366_1.time_ >= var_369_25 + var_369_26 and arg_366_1.time_ < var_369_25 + var_369_26 + arg_369_0 then
				var_369_24.localPosition = Vector3.New(0, 100, 0)

				local var_369_31 = manager.ui.mainCamera.transform.position - var_369_24.position

				var_369_24.forward = Vector3.New(var_369_31.x, var_369_31.y, var_369_31.z)

				local var_369_32 = var_369_24.localEulerAngles

				var_369_32.z = 0
				var_369_32.x = 0
				var_369_24.localEulerAngles = var_369_32
			end

			local var_369_33 = arg_366_1.actors_["1020ui_story"]
			local var_369_34 = 0

			if var_369_34 < arg_366_1.time_ and arg_366_1.time_ <= var_369_34 + arg_369_0 and not isNil(var_369_33) and arg_366_1.var_.characterEffect1020ui_story == nil then
				arg_366_1.var_.characterEffect1020ui_story = var_369_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_35 = 0.075

			if var_369_34 <= arg_366_1.time_ and arg_366_1.time_ < var_369_34 + var_369_35 and not isNil(var_369_33) then
				local var_369_36 = (arg_366_1.time_ - var_369_34) / var_369_35

				if arg_366_1.var_.characterEffect1020ui_story and not isNil(var_369_33) then
					local var_369_37 = Mathf.Lerp(0, 0.5, var_369_36)

					arg_366_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_366_1.var_.characterEffect1020ui_story.fillRatio = var_369_37
				end
			end

			if arg_366_1.time_ >= var_369_34 + var_369_35 and arg_366_1.time_ < var_369_34 + var_369_35 + arg_369_0 and not isNil(var_369_33) and arg_366_1.var_.characterEffect1020ui_story then
				local var_369_38 = 0.5

				arg_366_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_366_1.var_.characterEffect1020ui_story.fillRatio = var_369_38
			end

			local var_369_39 = manager.ui.mainCamera.transform
			local var_369_40 = 0

			if var_369_40 < arg_366_1.time_ and arg_366_1.time_ <= var_369_40 + arg_369_0 then
				local var_369_41 = arg_366_1.var_.effecthuiyi3
				local var_369_42
				local var_369_43 = var_369_39

				if not var_369_41 then
					var_369_41 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_369_43)
					var_369_41.name = "huiyi3"
					arg_366_1.var_.effecthuiyi3 = var_369_41
				else
					var_369_41.transform:SetParent(var_369_43)
				end

				var_369_41.transform.localPosition = Vector3.New(0, 0, 0)
				var_369_41.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_369_44 = 0
			local var_369_45 = 1

			if var_369_44 < arg_366_1.time_ and arg_366_1.time_ <= var_369_44 + arg_369_0 then
				local var_369_46 = "stop"
				local var_369_47 = "effect"

				arg_366_1:AudioAction(var_369_46, var_369_47, "se_story_side_1020", "se_story_side_1020_amb_sea_night", "")
			end

			local var_369_48 = 0.125
			local var_369_49 = 1

			if var_369_48 < arg_366_1.time_ and arg_366_1.time_ <= var_369_48 + arg_369_0 then
				local var_369_50 = "play"
				local var_369_51 = "effect"

				arg_366_1:AudioAction(var_369_50, var_369_51, "se_story_141", "se_story_141_boxing_amb_cheer04_loop", "")
			end

			if arg_366_1.frameCnt_ <= 1 then
				arg_366_1.dialog_:SetActive(false)
			end

			local var_369_52 = 2
			local var_369_53 = 0.075

			if var_369_52 < arg_366_1.time_ and arg_366_1.time_ <= var_369_52 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0

				arg_366_1.dialog_:SetActive(true)

				arg_366_1.dialogCg_.alpha = 0

				local var_369_54 = LeanTween.value(arg_366_1.dialog_, 0, 1, 0.3)

				var_369_54:setOnUpdate(LuaHelper.FloatAction(function(arg_370_0)
					arg_366_1.dialogCg_.alpha = arg_370_0
				end))
				var_369_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_366_1.dialog_)
					var_369_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_366_1.duration_ = arg_366_1.duration_ + 0.3

				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_55 = arg_366_1:GetWordFromCfg(1102002083)
				local var_369_56 = arg_366_1:FormatText(var_369_55.content)

				arg_366_1.text_.text = var_369_56

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_57 = 3
				local var_369_58 = utf8.len(var_369_56)
				local var_369_59 = var_369_57 <= 0 and var_369_53 or var_369_53 * (var_369_58 / var_369_57)

				if var_369_59 > 0 and var_369_53 < var_369_59 then
					arg_366_1.talkMaxDuration = var_369_59
					var_369_52 = var_369_52 + 0.3

					if var_369_59 + var_369_52 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_59 + var_369_52
					end
				end

				arg_366_1.text_.text = var_369_56
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_60 = var_369_52 + 0.3
			local var_369_61 = math.max(var_369_53, arg_366_1.talkMaxDuration)

			if var_369_60 <= arg_366_1.time_ and arg_366_1.time_ < var_369_60 + var_369_61 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_60) / var_369_61

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_60 + var_369_61 and arg_366_1.time_ < var_369_60 + var_369_61 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102002084 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1102002084
		arg_372_1.duration_ = 6.5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1102002085(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["1020ui_story"].transform
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.var_.moveOldPos1020ui_story = var_375_0.localPosition
			end

			local var_375_2 = 0.001

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2
				local var_375_4 = Vector3.New(0, -0.85, -6.25)

				var_375_0.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1020ui_story, var_375_4, var_375_3)

				local var_375_5 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_5.x, var_375_5.y, var_375_5.z)

				local var_375_6 = var_375_0.localEulerAngles

				var_375_6.z = 0
				var_375_6.x = 0
				var_375_0.localEulerAngles = var_375_6
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 then
				var_375_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_375_7 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_7.x, var_375_7.y, var_375_7.z)

				local var_375_8 = var_375_0.localEulerAngles

				var_375_8.z = 0
				var_375_8.x = 0
				var_375_0.localEulerAngles = var_375_8
			end

			local var_375_9 = arg_372_1.actors_["1020ui_story"]
			local var_375_10 = 0

			if var_375_10 < arg_372_1.time_ and arg_372_1.time_ <= var_375_10 + arg_375_0 and not isNil(var_375_9) and arg_372_1.var_.characterEffect1020ui_story == nil then
				arg_372_1.var_.characterEffect1020ui_story = var_375_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_11 = 0.200000002980232

			if var_375_10 <= arg_372_1.time_ and arg_372_1.time_ < var_375_10 + var_375_11 and not isNil(var_375_9) then
				local var_375_12 = (arg_372_1.time_ - var_375_10) / var_375_11

				if arg_372_1.var_.characterEffect1020ui_story and not isNil(var_375_9) then
					arg_372_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= var_375_10 + var_375_11 and arg_372_1.time_ < var_375_10 + var_375_11 + arg_375_0 and not isNil(var_375_9) and arg_372_1.var_.characterEffect1020ui_story then
				arg_372_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_375_13 = 0

			if var_375_13 < arg_372_1.time_ and arg_372_1.time_ <= var_375_13 + arg_375_0 then
				arg_372_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_375_14 = 0

			if var_375_14 < arg_372_1.time_ and arg_372_1.time_ <= var_375_14 + arg_375_0 then
				arg_372_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_375_15 = 0
			local var_375_16 = 0.6

			if var_375_15 < arg_372_1.time_ and arg_372_1.time_ <= var_375_15 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_17 = arg_372_1:FormatText(StoryNameCfg[613].name)

				arg_372_1.leftNameTxt_.text = var_375_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_18 = arg_372_1:GetWordFromCfg(1102002084)
				local var_375_19 = arg_372_1:FormatText(var_375_18.content)

				arg_372_1.text_.text = var_375_19

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_20 = 24
				local var_375_21 = utf8.len(var_375_19)
				local var_375_22 = var_375_20 <= 0 and var_375_16 or var_375_16 * (var_375_21 / var_375_20)

				if var_375_22 > 0 and var_375_16 < var_375_22 then
					arg_372_1.talkMaxDuration = var_375_22

					if var_375_22 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_22 + var_375_15
					end
				end

				arg_372_1.text_.text = var_375_19
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002084", "story_v_side_new_1102002.awb") ~= 0 then
					local var_375_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002084", "story_v_side_new_1102002.awb") / 1000

					if var_375_23 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_23 + var_375_15
					end

					if var_375_18.prefab_name ~= "" and arg_372_1.actors_[var_375_18.prefab_name] ~= nil then
						local var_375_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_18.prefab_name].transform, "story_v_side_new_1102002", "1102002084", "story_v_side_new_1102002.awb")

						arg_372_1:RecordAudio("1102002084", var_375_24)
						arg_372_1:RecordAudio("1102002084", var_375_24)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002084", "story_v_side_new_1102002.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002084", "story_v_side_new_1102002.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_25 = math.max(var_375_16, arg_372_1.talkMaxDuration)

			if var_375_15 <= arg_372_1.time_ and arg_372_1.time_ < var_375_15 + var_375_25 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_15) / var_375_25

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_15 + var_375_25 and arg_372_1.time_ < var_375_15 + var_375_25 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play1102002085 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1102002085
		arg_376_1.duration_ = 5.27

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1102002086(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 0.375

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_2 = arg_376_1:FormatText(StoryNameCfg[613].name)

				arg_376_1.leftNameTxt_.text = var_379_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_3 = arg_376_1:GetWordFromCfg(1102002085)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002085", "story_v_side_new_1102002.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002085", "story_v_side_new_1102002.awb") / 1000

					if var_379_8 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_0
					end

					if var_379_3.prefab_name ~= "" and arg_376_1.actors_[var_379_3.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_3.prefab_name].transform, "story_v_side_new_1102002", "1102002085", "story_v_side_new_1102002.awb")

						arg_376_1:RecordAudio("1102002085", var_379_9)
						arg_376_1:RecordAudio("1102002085", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002085", "story_v_side_new_1102002.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002085", "story_v_side_new_1102002.awb")
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
	Play1102002086 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1102002086
		arg_380_1.duration_ = 5.83

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1102002087(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_383_1 = 0
			local var_383_2 = 0.5

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_3 = arg_380_1:FormatText(StoryNameCfg[613].name)

				arg_380_1.leftNameTxt_.text = var_383_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_4 = arg_380_1:GetWordFromCfg(1102002086)
				local var_383_5 = arg_380_1:FormatText(var_383_4.content)

				arg_380_1.text_.text = var_383_5

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_6 = 20
				local var_383_7 = utf8.len(var_383_5)
				local var_383_8 = var_383_6 <= 0 and var_383_2 or var_383_2 * (var_383_7 / var_383_6)

				if var_383_8 > 0 and var_383_2 < var_383_8 then
					arg_380_1.talkMaxDuration = var_383_8

					if var_383_8 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_8 + var_383_1
					end
				end

				arg_380_1.text_.text = var_383_5
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002086", "story_v_side_new_1102002.awb") ~= 0 then
					local var_383_9 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002086", "story_v_side_new_1102002.awb") / 1000

					if var_383_9 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_9 + var_383_1
					end

					if var_383_4.prefab_name ~= "" and arg_380_1.actors_[var_383_4.prefab_name] ~= nil then
						local var_383_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_4.prefab_name].transform, "story_v_side_new_1102002", "1102002086", "story_v_side_new_1102002.awb")

						arg_380_1:RecordAudio("1102002086", var_383_10)
						arg_380_1:RecordAudio("1102002086", var_383_10)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002086", "story_v_side_new_1102002.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002086", "story_v_side_new_1102002.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_11 = math.max(var_383_2, arg_380_1.talkMaxDuration)

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_11 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_1) / var_383_11

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_1 + var_383_11 and arg_380_1.time_ < var_383_1 + var_383_11 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1102002087 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1102002087
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1102002088(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["1020ui_story"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect1020ui_story == nil then
				arg_384_1.var_.characterEffect1020ui_story = var_387_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.characterEffect1020ui_story and not isNil(var_387_0) then
					local var_387_4 = Mathf.Lerp(0, 0.5, var_387_3)

					arg_384_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_384_1.var_.characterEffect1020ui_story.fillRatio = var_387_4
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect1020ui_story then
				local var_387_5 = 0.5

				arg_384_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_384_1.var_.characterEffect1020ui_story.fillRatio = var_387_5
			end

			local var_387_6 = 0
			local var_387_7 = 0.15

			if var_387_6 < arg_384_1.time_ and arg_384_1.time_ <= var_387_6 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_8 = arg_384_1:FormatText(StoryNameCfg[7].name)

				arg_384_1.leftNameTxt_.text = var_387_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_9 = arg_384_1:GetWordFromCfg(1102002087)
				local var_387_10 = arg_384_1:FormatText(var_387_9.content)

				arg_384_1.text_.text = var_387_10

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_11 = 6
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
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_14 = math.max(var_387_7, arg_384_1.talkMaxDuration)

			if var_387_6 <= arg_384_1.time_ and arg_384_1.time_ < var_387_6 + var_387_14 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_6) / var_387_14

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_6 + var_387_14 and arg_384_1.time_ < var_387_6 + var_387_14 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1102002088 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1102002088
		arg_388_1.duration_ = 10.8

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1102002089(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 3

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				local var_391_1 = manager.ui.mainCamera.transform.localPosition
				local var_391_2 = Vector3.New(0, 0, 10) + Vector3.New(var_391_1.x, var_391_1.y, 0)
				local var_391_3 = arg_388_1.bgs_.STblack

				var_391_3.transform.localPosition = var_391_2
				var_391_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_391_4 = var_391_3:GetComponent("SpriteRenderer")

				if var_391_4 and var_391_4.sprite then
					local var_391_5 = (var_391_3.transform.localPosition - var_391_1).z
					local var_391_6 = manager.ui.mainCameraCom_
					local var_391_7 = 2 * var_391_5 * Mathf.Tan(var_391_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_391_8 = var_391_7 * var_391_6.aspect
					local var_391_9 = var_391_4.sprite.bounds.size.x
					local var_391_10 = var_391_4.sprite.bounds.size.y
					local var_391_11 = var_391_8 / var_391_9
					local var_391_12 = var_391_7 / var_391_10
					local var_391_13 = var_391_12 < var_391_11 and var_391_11 or var_391_12

					var_391_3.transform.localScale = Vector3.New(var_391_13, var_391_13, 0)
				end

				for iter_391_0, iter_391_1 in pairs(arg_388_1.bgs_) do
					if iter_391_0 ~= "STblack" then
						iter_391_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_391_14 = 6

			if var_391_14 < arg_388_1.time_ and arg_388_1.time_ <= var_391_14 + arg_391_0 then
				arg_388_1.allBtn_.enabled = false
			end

			local var_391_15 = 0.3

			if arg_388_1.time_ >= var_391_14 + var_391_15 and arg_388_1.time_ < var_391_14 + var_391_15 + arg_391_0 then
				arg_388_1.allBtn_.enabled = true
			end

			local var_391_16 = 0

			if var_391_16 < arg_388_1.time_ and arg_388_1.time_ <= var_391_16 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_17 = 3

			if var_391_16 <= arg_388_1.time_ and arg_388_1.time_ < var_391_16 + var_391_17 then
				local var_391_18 = (arg_388_1.time_ - var_391_16) / var_391_17
				local var_391_19 = Color.New(0, 0, 0)

				var_391_19.a = Mathf.Lerp(0, 1, var_391_18)
				arg_388_1.mask_.color = var_391_19
			end

			if arg_388_1.time_ >= var_391_16 + var_391_17 and arg_388_1.time_ < var_391_16 + var_391_17 + arg_391_0 then
				local var_391_20 = Color.New(0, 0, 0)

				var_391_20.a = 1
				arg_388_1.mask_.color = var_391_20
			end

			local var_391_21 = 3

			if var_391_21 < arg_388_1.time_ and arg_388_1.time_ <= var_391_21 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_22 = 3

			if var_391_21 <= arg_388_1.time_ and arg_388_1.time_ < var_391_21 + var_391_22 then
				local var_391_23 = (arg_388_1.time_ - var_391_21) / var_391_22
				local var_391_24 = Color.New(0, 0, 0)

				var_391_24.a = Mathf.Lerp(1, 0, var_391_23)
				arg_388_1.mask_.color = var_391_24
			end

			if arg_388_1.time_ >= var_391_21 + var_391_22 and arg_388_1.time_ < var_391_21 + var_391_22 + arg_391_0 then
				local var_391_25 = Color.New(0, 0, 0)
				local var_391_26 = 0

				arg_388_1.mask_.enabled = false
				var_391_25.a = var_391_26
				arg_388_1.mask_.color = var_391_25
			end

			local var_391_27 = arg_388_1.actors_["1020ui_story"].transform
			local var_391_28 = 2.96599999815226

			if var_391_28 < arg_388_1.time_ and arg_388_1.time_ <= var_391_28 + arg_391_0 then
				arg_388_1.var_.moveOldPos1020ui_story = var_391_27.localPosition
			end

			local var_391_29 = 0.001

			if var_391_28 <= arg_388_1.time_ and arg_388_1.time_ < var_391_28 + var_391_29 then
				local var_391_30 = (arg_388_1.time_ - var_391_28) / var_391_29
				local var_391_31 = Vector3.New(0, 100, 0)

				var_391_27.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1020ui_story, var_391_31, var_391_30)

				local var_391_32 = manager.ui.mainCamera.transform.position - var_391_27.position

				var_391_27.forward = Vector3.New(var_391_32.x, var_391_32.y, var_391_32.z)

				local var_391_33 = var_391_27.localEulerAngles

				var_391_33.z = 0
				var_391_33.x = 0
				var_391_27.localEulerAngles = var_391_33
			end

			if arg_388_1.time_ >= var_391_28 + var_391_29 and arg_388_1.time_ < var_391_28 + var_391_29 + arg_391_0 then
				var_391_27.localPosition = Vector3.New(0, 100, 0)

				local var_391_34 = manager.ui.mainCamera.transform.position - var_391_27.position

				var_391_27.forward = Vector3.New(var_391_34.x, var_391_34.y, var_391_34.z)

				local var_391_35 = var_391_27.localEulerAngles

				var_391_35.z = 0
				var_391_35.x = 0
				var_391_27.localEulerAngles = var_391_35
			end

			local var_391_36 = 0.633333333333333
			local var_391_37 = 1

			if var_391_36 < arg_388_1.time_ and arg_388_1.time_ <= var_391_36 + arg_391_0 then
				local var_391_38 = "stop"
				local var_391_39 = "effect"

				arg_388_1:AudioAction(var_391_38, var_391_39, "se_story_141", "se_story_141_boxing_amb_cheer04_loop", "")
			end

			local var_391_40 = 2.6
			local var_391_41 = 1

			if var_391_40 < arg_388_1.time_ and arg_388_1.time_ <= var_391_40 + arg_391_0 then
				local var_391_42 = "play"
				local var_391_43 = "effect"

				arg_388_1:AudioAction(var_391_42, var_391_43, "se_story_140", "se_story_140_amb_rewind_loop", "")
			end

			if arg_388_1.frameCnt_ <= 1 then
				arg_388_1.dialog_:SetActive(false)
			end

			local var_391_44 = 5.8
			local var_391_45 = 0.95

			if var_391_44 < arg_388_1.time_ and arg_388_1.time_ <= var_391_44 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0

				arg_388_1.dialog_:SetActive(true)

				arg_388_1.dialogCg_.alpha = 0

				local var_391_46 = LeanTween.value(arg_388_1.dialog_, 0, 1, 0.3)

				var_391_46:setOnUpdate(LuaHelper.FloatAction(function(arg_392_0)
					arg_388_1.dialogCg_.alpha = arg_392_0
				end))
				var_391_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_388_1.dialog_)
					var_391_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_388_1.duration_ = arg_388_1.duration_ + 0.3

				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_47 = arg_388_1:GetWordFromCfg(1102002088)
				local var_391_48 = arg_388_1:FormatText(var_391_47.content)

				arg_388_1.text_.text = var_391_48

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_49 = 38
				local var_391_50 = utf8.len(var_391_48)
				local var_391_51 = var_391_49 <= 0 and var_391_45 or var_391_45 * (var_391_50 / var_391_49)

				if var_391_51 > 0 and var_391_45 < var_391_51 then
					arg_388_1.talkMaxDuration = var_391_51
					var_391_44 = var_391_44 + 0.3

					if var_391_51 + var_391_44 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_51 + var_391_44
					end
				end

				arg_388_1.text_.text = var_391_48
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_52 = var_391_44 + 0.3
			local var_391_53 = math.max(var_391_45, arg_388_1.talkMaxDuration)

			if var_391_52 <= arg_388_1.time_ and arg_388_1.time_ < var_391_52 + var_391_53 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_52) / var_391_53

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_52 + var_391_53 and arg_388_1.time_ < var_391_52 + var_391_53 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play1102002089 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1102002089
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1102002090(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 0.325

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_2 = arg_394_1:GetWordFromCfg(1102002089)
				local var_397_3 = arg_394_1:FormatText(var_397_2.content)

				arg_394_1.text_.text = var_397_3

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_4 = 13
				local var_397_5 = utf8.len(var_397_3)
				local var_397_6 = var_397_4 <= 0 and var_397_1 or var_397_1 * (var_397_5 / var_397_4)

				if var_397_6 > 0 and var_397_1 < var_397_6 then
					arg_394_1.talkMaxDuration = var_397_6

					if var_397_6 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_6 + var_397_0
					end
				end

				arg_394_1.text_.text = var_397_3
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_1, arg_394_1.talkMaxDuration)

			if var_397_0 <= arg_394_1.time_ and arg_394_1.time_ < var_397_0 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_0) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_0 + var_397_7 and arg_394_1.time_ < var_397_0 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1102002090 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1102002090
		arg_398_1.duration_ = 5.53

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1102002091(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1020ui_story"].transform
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.var_.moveOldPos1020ui_story = var_401_0.localPosition
			end

			local var_401_2 = 0.001

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2
				local var_401_4 = Vector3.New(0, -0.85, -6.25)

				var_401_0.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1020ui_story, var_401_4, var_401_3)

				local var_401_5 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_5.x, var_401_5.y, var_401_5.z)

				local var_401_6 = var_401_0.localEulerAngles

				var_401_6.z = 0
				var_401_6.x = 0
				var_401_0.localEulerAngles = var_401_6
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 then
				var_401_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_401_7 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_7.x, var_401_7.y, var_401_7.z)

				local var_401_8 = var_401_0.localEulerAngles

				var_401_8.z = 0
				var_401_8.x = 0
				var_401_0.localEulerAngles = var_401_8
			end

			local var_401_9 = arg_398_1.actors_["1020ui_story"]
			local var_401_10 = 0

			if var_401_10 < arg_398_1.time_ and arg_398_1.time_ <= var_401_10 + arg_401_0 and not isNil(var_401_9) and arg_398_1.var_.characterEffect1020ui_story == nil then
				arg_398_1.var_.characterEffect1020ui_story = var_401_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_11 = 0.200000002980232

			if var_401_10 <= arg_398_1.time_ and arg_398_1.time_ < var_401_10 + var_401_11 and not isNil(var_401_9) then
				local var_401_12 = (arg_398_1.time_ - var_401_10) / var_401_11

				if arg_398_1.var_.characterEffect1020ui_story and not isNil(var_401_9) then
					arg_398_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= var_401_10 + var_401_11 and arg_398_1.time_ < var_401_10 + var_401_11 + arg_401_0 and not isNil(var_401_9) and arg_398_1.var_.characterEffect1020ui_story then
				arg_398_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_401_13 = 0

			if var_401_13 < arg_398_1.time_ and arg_398_1.time_ <= var_401_13 + arg_401_0 then
				arg_398_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_401_14 = 0

			if var_401_14 < arg_398_1.time_ and arg_398_1.time_ <= var_401_14 + arg_401_0 then
				arg_398_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_401_15 = 0
			local var_401_16 = 0.425

			if var_401_15 < arg_398_1.time_ and arg_398_1.time_ <= var_401_15 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0

				arg_398_1.dialog_:SetActive(true)

				arg_398_1.dialogCg_.alpha = 0

				local var_401_17 = LeanTween.value(arg_398_1.dialog_, 0, 1, 0.3)

				var_401_17:setOnUpdate(LuaHelper.FloatAction(function(arg_402_0)
					arg_398_1.dialogCg_.alpha = arg_402_0
				end))
				var_401_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_398_1.dialog_)
					var_401_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_398_1.duration_ = arg_398_1.duration_ + 0.3

				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_18 = arg_398_1:FormatText(StoryNameCfg[613].name)

				arg_398_1.leftNameTxt_.text = var_401_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_19 = arg_398_1:GetWordFromCfg(1102002090)
				local var_401_20 = arg_398_1:FormatText(var_401_19.content)

				arg_398_1.text_.text = var_401_20

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_21 = 17
				local var_401_22 = utf8.len(var_401_20)
				local var_401_23 = var_401_21 <= 0 and var_401_16 or var_401_16 * (var_401_22 / var_401_21)

				if var_401_23 > 0 and var_401_16 < var_401_23 then
					arg_398_1.talkMaxDuration = var_401_23
					var_401_15 = var_401_15 + 0.3

					if var_401_23 + var_401_15 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_23 + var_401_15
					end
				end

				arg_398_1.text_.text = var_401_20
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002090", "story_v_side_new_1102002.awb") ~= 0 then
					local var_401_24 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002090", "story_v_side_new_1102002.awb") / 1000

					if var_401_24 + var_401_15 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_24 + var_401_15
					end

					if var_401_19.prefab_name ~= "" and arg_398_1.actors_[var_401_19.prefab_name] ~= nil then
						local var_401_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_19.prefab_name].transform, "story_v_side_new_1102002", "1102002090", "story_v_side_new_1102002.awb")

						arg_398_1:RecordAudio("1102002090", var_401_25)
						arg_398_1:RecordAudio("1102002090", var_401_25)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002090", "story_v_side_new_1102002.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002090", "story_v_side_new_1102002.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_26 = var_401_15 + 0.3
			local var_401_27 = math.max(var_401_16, arg_398_1.talkMaxDuration)

			if var_401_26 <= arg_398_1.time_ and arg_398_1.time_ < var_401_26 + var_401_27 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_26) / var_401_27

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_26 + var_401_27 and arg_398_1.time_ < var_401_26 + var_401_27 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102002091 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1102002091
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1102002092(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1020ui_story"].transform
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1.var_.moveOldPos1020ui_story = var_407_0.localPosition
			end

			local var_407_2 = 0.001

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2
				local var_407_4 = Vector3.New(0, 100, 0)

				var_407_0.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1020ui_story, var_407_4, var_407_3)

				local var_407_5 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_5.x, var_407_5.y, var_407_5.z)

				local var_407_6 = var_407_0.localEulerAngles

				var_407_6.z = 0
				var_407_6.x = 0
				var_407_0.localEulerAngles = var_407_6
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 then
				var_407_0.localPosition = Vector3.New(0, 100, 0)

				local var_407_7 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_7.x, var_407_7.y, var_407_7.z)

				local var_407_8 = var_407_0.localEulerAngles

				var_407_8.z = 0
				var_407_8.x = 0
				var_407_0.localEulerAngles = var_407_8
			end

			local var_407_9 = arg_404_1.actors_["1020ui_story"]
			local var_407_10 = 0

			if var_407_10 < arg_404_1.time_ and arg_404_1.time_ <= var_407_10 + arg_407_0 and not isNil(var_407_9) and arg_404_1.var_.characterEffect1020ui_story == nil then
				arg_404_1.var_.characterEffect1020ui_story = var_407_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_11 = 0.200000002980232

			if var_407_10 <= arg_404_1.time_ and arg_404_1.time_ < var_407_10 + var_407_11 and not isNil(var_407_9) then
				local var_407_12 = (arg_404_1.time_ - var_407_10) / var_407_11

				if arg_404_1.var_.characterEffect1020ui_story and not isNil(var_407_9) then
					local var_407_13 = Mathf.Lerp(0, 0.5, var_407_12)

					arg_404_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1020ui_story.fillRatio = var_407_13
				end
			end

			if arg_404_1.time_ >= var_407_10 + var_407_11 and arg_404_1.time_ < var_407_10 + var_407_11 + arg_407_0 and not isNil(var_407_9) and arg_404_1.var_.characterEffect1020ui_story then
				local var_407_14 = 0.5

				arg_404_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1020ui_story.fillRatio = var_407_14
			end

			local var_407_15 = 0
			local var_407_16 = 0.675

			if var_407_15 < arg_404_1.time_ and arg_404_1.time_ <= var_407_15 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_17 = arg_404_1:FormatText(StoryNameCfg[7].name)

				arg_404_1.leftNameTxt_.text = var_407_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_18 = arg_404_1:GetWordFromCfg(1102002091)
				local var_407_19 = arg_404_1:FormatText(var_407_18.content)

				arg_404_1.text_.text = var_407_19

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_20 = 27
				local var_407_21 = utf8.len(var_407_19)
				local var_407_22 = var_407_20 <= 0 and var_407_16 or var_407_16 * (var_407_21 / var_407_20)

				if var_407_22 > 0 and var_407_16 < var_407_22 then
					arg_404_1.talkMaxDuration = var_407_22

					if var_407_22 + var_407_15 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_22 + var_407_15
					end
				end

				arg_404_1.text_.text = var_407_19
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_23 = math.max(var_407_16, arg_404_1.talkMaxDuration)

			if var_407_15 <= arg_404_1.time_ and arg_404_1.time_ < var_407_15 + var_407_23 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_15) / var_407_23

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_15 + var_407_23 and arg_404_1.time_ < var_407_15 + var_407_23 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play1102002092 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1102002092
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1102002093(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.425

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_2 = arg_408_1:FormatText(StoryNameCfg[7].name)

				arg_408_1.leftNameTxt_.text = var_411_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_3 = arg_408_1:GetWordFromCfg(1102002092)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 17
				local var_411_6 = utf8.len(var_411_4)
				local var_411_7 = var_411_5 <= 0 and var_411_1 or var_411_1 * (var_411_6 / var_411_5)

				if var_411_7 > 0 and var_411_1 < var_411_7 then
					arg_408_1.talkMaxDuration = var_411_7

					if var_411_7 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_7 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_4
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_8 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_8 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_8

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_8 and arg_408_1.time_ < var_411_0 + var_411_8 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1102002093 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1102002093
		arg_412_1.duration_ = 10.63

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1102002094(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["1020ui_story"].transform
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.var_.moveOldPos1020ui_story = var_415_0.localPosition
			end

			local var_415_2 = 0.001

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2
				local var_415_4 = Vector3.New(0, -0.85, -6.25)

				var_415_0.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1020ui_story, var_415_4, var_415_3)

				local var_415_5 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_5.x, var_415_5.y, var_415_5.z)

				local var_415_6 = var_415_0.localEulerAngles

				var_415_6.z = 0
				var_415_6.x = 0
				var_415_0.localEulerAngles = var_415_6
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 then
				var_415_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_415_7 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_7.x, var_415_7.y, var_415_7.z)

				local var_415_8 = var_415_0.localEulerAngles

				var_415_8.z = 0
				var_415_8.x = 0
				var_415_0.localEulerAngles = var_415_8
			end

			local var_415_9 = arg_412_1.actors_["1020ui_story"]
			local var_415_10 = 0

			if var_415_10 < arg_412_1.time_ and arg_412_1.time_ <= var_415_10 + arg_415_0 and not isNil(var_415_9) and arg_412_1.var_.characterEffect1020ui_story == nil then
				arg_412_1.var_.characterEffect1020ui_story = var_415_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_11 = 0.200000002980232

			if var_415_10 <= arg_412_1.time_ and arg_412_1.time_ < var_415_10 + var_415_11 and not isNil(var_415_9) then
				local var_415_12 = (arg_412_1.time_ - var_415_10) / var_415_11

				if arg_412_1.var_.characterEffect1020ui_story and not isNil(var_415_9) then
					arg_412_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= var_415_10 + var_415_11 and arg_412_1.time_ < var_415_10 + var_415_11 + arg_415_0 and not isNil(var_415_9) and arg_412_1.var_.characterEffect1020ui_story then
				arg_412_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_415_13 = 0

			if var_415_13 < arg_412_1.time_ and arg_412_1.time_ <= var_415_13 + arg_415_0 then
				arg_412_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_415_14 = 0

			if var_415_14 < arg_412_1.time_ and arg_412_1.time_ <= var_415_14 + arg_415_0 then
				arg_412_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_415_15 = 0
			local var_415_16 = 0.75

			if var_415_15 < arg_412_1.time_ and arg_412_1.time_ <= var_415_15 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_17 = arg_412_1:FormatText(StoryNameCfg[613].name)

				arg_412_1.leftNameTxt_.text = var_415_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_18 = arg_412_1:GetWordFromCfg(1102002093)
				local var_415_19 = arg_412_1:FormatText(var_415_18.content)

				arg_412_1.text_.text = var_415_19

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_20 = 30
				local var_415_21 = utf8.len(var_415_19)
				local var_415_22 = var_415_20 <= 0 and var_415_16 or var_415_16 * (var_415_21 / var_415_20)

				if var_415_22 > 0 and var_415_16 < var_415_22 then
					arg_412_1.talkMaxDuration = var_415_22

					if var_415_22 + var_415_15 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_22 + var_415_15
					end
				end

				arg_412_1.text_.text = var_415_19
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002093", "story_v_side_new_1102002.awb") ~= 0 then
					local var_415_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002093", "story_v_side_new_1102002.awb") / 1000

					if var_415_23 + var_415_15 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_23 + var_415_15
					end

					if var_415_18.prefab_name ~= "" and arg_412_1.actors_[var_415_18.prefab_name] ~= nil then
						local var_415_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_18.prefab_name].transform, "story_v_side_new_1102002", "1102002093", "story_v_side_new_1102002.awb")

						arg_412_1:RecordAudio("1102002093", var_415_24)
						arg_412_1:RecordAudio("1102002093", var_415_24)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002093", "story_v_side_new_1102002.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002093", "story_v_side_new_1102002.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_25 = math.max(var_415_16, arg_412_1.talkMaxDuration)

			if var_415_15 <= arg_412_1.time_ and arg_412_1.time_ < var_415_15 + var_415_25 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_15) / var_415_25

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_15 + var_415_25 and arg_412_1.time_ < var_415_15 + var_415_25 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play1102002094 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1102002094
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1102002095(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["1020ui_story"].transform
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 then
				arg_416_1.var_.moveOldPos1020ui_story = var_419_0.localPosition
			end

			local var_419_2 = 0.001

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2
				local var_419_4 = Vector3.New(0, 100, 0)

				var_419_0.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos1020ui_story, var_419_4, var_419_3)

				local var_419_5 = manager.ui.mainCamera.transform.position - var_419_0.position

				var_419_0.forward = Vector3.New(var_419_5.x, var_419_5.y, var_419_5.z)

				local var_419_6 = var_419_0.localEulerAngles

				var_419_6.z = 0
				var_419_6.x = 0
				var_419_0.localEulerAngles = var_419_6
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 then
				var_419_0.localPosition = Vector3.New(0, 100, 0)

				local var_419_7 = manager.ui.mainCamera.transform.position - var_419_0.position

				var_419_0.forward = Vector3.New(var_419_7.x, var_419_7.y, var_419_7.z)

				local var_419_8 = var_419_0.localEulerAngles

				var_419_8.z = 0
				var_419_8.x = 0
				var_419_0.localEulerAngles = var_419_8
			end

			local var_419_9 = arg_416_1.actors_["1020ui_story"]
			local var_419_10 = 0

			if var_419_10 < arg_416_1.time_ and arg_416_1.time_ <= var_419_10 + arg_419_0 and not isNil(var_419_9) and arg_416_1.var_.characterEffect1020ui_story == nil then
				arg_416_1.var_.characterEffect1020ui_story = var_419_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_11 = 0.200000002980232

			if var_419_10 <= arg_416_1.time_ and arg_416_1.time_ < var_419_10 + var_419_11 and not isNil(var_419_9) then
				local var_419_12 = (arg_416_1.time_ - var_419_10) / var_419_11

				if arg_416_1.var_.characterEffect1020ui_story and not isNil(var_419_9) then
					local var_419_13 = Mathf.Lerp(0, 0.5, var_419_12)

					arg_416_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_416_1.var_.characterEffect1020ui_story.fillRatio = var_419_13
				end
			end

			if arg_416_1.time_ >= var_419_10 + var_419_11 and arg_416_1.time_ < var_419_10 + var_419_11 + arg_419_0 and not isNil(var_419_9) and arg_416_1.var_.characterEffect1020ui_story then
				local var_419_14 = 0.5

				arg_416_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_416_1.var_.characterEffect1020ui_story.fillRatio = var_419_14
			end

			local var_419_15 = 0
			local var_419_16 = 0.15

			if var_419_15 < arg_416_1.time_ and arg_416_1.time_ <= var_419_15 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_17 = arg_416_1:FormatText(StoryNameCfg[7].name)

				arg_416_1.leftNameTxt_.text = var_419_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_18 = arg_416_1:GetWordFromCfg(1102002094)
				local var_419_19 = arg_416_1:FormatText(var_419_18.content)

				arg_416_1.text_.text = var_419_19

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_20 = 6
				local var_419_21 = utf8.len(var_419_19)
				local var_419_22 = var_419_20 <= 0 and var_419_16 or var_419_16 * (var_419_21 / var_419_20)

				if var_419_22 > 0 and var_419_16 < var_419_22 then
					arg_416_1.talkMaxDuration = var_419_22

					if var_419_22 + var_419_15 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_22 + var_419_15
					end
				end

				arg_416_1.text_.text = var_419_19
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_23 = math.max(var_419_16, arg_416_1.talkMaxDuration)

			if var_419_15 <= arg_416_1.time_ and arg_416_1.time_ < var_419_15 + var_419_23 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_15) / var_419_23

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_15 + var_419_23 and arg_416_1.time_ < var_419_15 + var_419_23 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	Play1102002095 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1102002095
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1102002096(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0
			local var_423_1 = 1

			if var_423_0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_2 = arg_420_1:GetWordFromCfg(1102002095)
				local var_423_3 = arg_420_1:FormatText(var_423_2.content)

				arg_420_1.text_.text = var_423_3

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_4 = 40
				local var_423_5 = utf8.len(var_423_3)
				local var_423_6 = var_423_4 <= 0 and var_423_1 or var_423_1 * (var_423_5 / var_423_4)

				if var_423_6 > 0 and var_423_1 < var_423_6 then
					arg_420_1.talkMaxDuration = var_423_6

					if var_423_6 + var_423_0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_6 + var_423_0
					end
				end

				arg_420_1.text_.text = var_423_3
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_7 = math.max(var_423_1, arg_420_1.talkMaxDuration)

			if var_423_0 <= arg_420_1.time_ and arg_420_1.time_ < var_423_0 + var_423_7 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_0) / var_423_7

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_0 + var_423_7 and arg_420_1.time_ < var_423_0 + var_423_7 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play1102002096 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1102002096
		arg_424_1.duration_ = 8.7

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1102002097(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["1020ui_story"].transform
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.var_.moveOldPos1020ui_story = var_427_0.localPosition
			end

			local var_427_2 = 0.001

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2
				local var_427_4 = Vector3.New(0, -0.85, -6.25)

				var_427_0.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1020ui_story, var_427_4, var_427_3)

				local var_427_5 = manager.ui.mainCamera.transform.position - var_427_0.position

				var_427_0.forward = Vector3.New(var_427_5.x, var_427_5.y, var_427_5.z)

				local var_427_6 = var_427_0.localEulerAngles

				var_427_6.z = 0
				var_427_6.x = 0
				var_427_0.localEulerAngles = var_427_6
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 then
				var_427_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_427_7 = manager.ui.mainCamera.transform.position - var_427_0.position

				var_427_0.forward = Vector3.New(var_427_7.x, var_427_7.y, var_427_7.z)

				local var_427_8 = var_427_0.localEulerAngles

				var_427_8.z = 0
				var_427_8.x = 0
				var_427_0.localEulerAngles = var_427_8
			end

			local var_427_9 = arg_424_1.actors_["1020ui_story"]
			local var_427_10 = 0

			if var_427_10 < arg_424_1.time_ and arg_424_1.time_ <= var_427_10 + arg_427_0 and not isNil(var_427_9) and arg_424_1.var_.characterEffect1020ui_story == nil then
				arg_424_1.var_.characterEffect1020ui_story = var_427_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_11 = 0.200000002980232

			if var_427_10 <= arg_424_1.time_ and arg_424_1.time_ < var_427_10 + var_427_11 and not isNil(var_427_9) then
				local var_427_12 = (arg_424_1.time_ - var_427_10) / var_427_11

				if arg_424_1.var_.characterEffect1020ui_story and not isNil(var_427_9) then
					arg_424_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= var_427_10 + var_427_11 and arg_424_1.time_ < var_427_10 + var_427_11 + arg_427_0 and not isNil(var_427_9) and arg_424_1.var_.characterEffect1020ui_story then
				arg_424_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_427_13 = 0

			if var_427_13 < arg_424_1.time_ and arg_424_1.time_ <= var_427_13 + arg_427_0 then
				arg_424_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_427_14 = 0

			if var_427_14 < arg_424_1.time_ and arg_424_1.time_ <= var_427_14 + arg_427_0 then
				arg_424_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_427_15 = 0
			local var_427_16 = 0.9

			if var_427_15 < arg_424_1.time_ and arg_424_1.time_ <= var_427_15 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_17 = arg_424_1:FormatText(StoryNameCfg[613].name)

				arg_424_1.leftNameTxt_.text = var_427_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_18 = arg_424_1:GetWordFromCfg(1102002096)
				local var_427_19 = arg_424_1:FormatText(var_427_18.content)

				arg_424_1.text_.text = var_427_19

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_20 = 36
				local var_427_21 = utf8.len(var_427_19)
				local var_427_22 = var_427_20 <= 0 and var_427_16 or var_427_16 * (var_427_21 / var_427_20)

				if var_427_22 > 0 and var_427_16 < var_427_22 then
					arg_424_1.talkMaxDuration = var_427_22

					if var_427_22 + var_427_15 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_22 + var_427_15
					end
				end

				arg_424_1.text_.text = var_427_19
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002096", "story_v_side_new_1102002.awb") ~= 0 then
					local var_427_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002096", "story_v_side_new_1102002.awb") / 1000

					if var_427_23 + var_427_15 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_23 + var_427_15
					end

					if var_427_18.prefab_name ~= "" and arg_424_1.actors_[var_427_18.prefab_name] ~= nil then
						local var_427_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_18.prefab_name].transform, "story_v_side_new_1102002", "1102002096", "story_v_side_new_1102002.awb")

						arg_424_1:RecordAudio("1102002096", var_427_24)
						arg_424_1:RecordAudio("1102002096", var_427_24)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002096", "story_v_side_new_1102002.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002096", "story_v_side_new_1102002.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_25 = math.max(var_427_16, arg_424_1.talkMaxDuration)

			if var_427_15 <= arg_424_1.time_ and arg_424_1.time_ < var_427_15 + var_427_25 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_15) / var_427_25

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_15 + var_427_25 and arg_424_1.time_ < var_427_15 + var_427_25 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play1102002097 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1102002097
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1102002098(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["1020ui_story"].transform
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.var_.moveOldPos1020ui_story = var_431_0.localPosition
			end

			local var_431_2 = 0.001

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2
				local var_431_4 = Vector3.New(0, 100, 0)

				var_431_0.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1020ui_story, var_431_4, var_431_3)

				local var_431_5 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_5.x, var_431_5.y, var_431_5.z)

				local var_431_6 = var_431_0.localEulerAngles

				var_431_6.z = 0
				var_431_6.x = 0
				var_431_0.localEulerAngles = var_431_6
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 then
				var_431_0.localPosition = Vector3.New(0, 100, 0)

				local var_431_7 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_7.x, var_431_7.y, var_431_7.z)

				local var_431_8 = var_431_0.localEulerAngles

				var_431_8.z = 0
				var_431_8.x = 0
				var_431_0.localEulerAngles = var_431_8
			end

			local var_431_9 = arg_428_1.actors_["1020ui_story"]
			local var_431_10 = 0

			if var_431_10 < arg_428_1.time_ and arg_428_1.time_ <= var_431_10 + arg_431_0 and not isNil(var_431_9) and arg_428_1.var_.characterEffect1020ui_story == nil then
				arg_428_1.var_.characterEffect1020ui_story = var_431_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_11 = 0.200000002980232

			if var_431_10 <= arg_428_1.time_ and arg_428_1.time_ < var_431_10 + var_431_11 and not isNil(var_431_9) then
				local var_431_12 = (arg_428_1.time_ - var_431_10) / var_431_11

				if arg_428_1.var_.characterEffect1020ui_story and not isNil(var_431_9) then
					local var_431_13 = Mathf.Lerp(0, 0.5, var_431_12)

					arg_428_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_428_1.var_.characterEffect1020ui_story.fillRatio = var_431_13
				end
			end

			if arg_428_1.time_ >= var_431_10 + var_431_11 and arg_428_1.time_ < var_431_10 + var_431_11 + arg_431_0 and not isNil(var_431_9) and arg_428_1.var_.characterEffect1020ui_story then
				local var_431_14 = 0.5

				arg_428_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_428_1.var_.characterEffect1020ui_story.fillRatio = var_431_14
			end

			local var_431_15 = 0
			local var_431_16 = 0.15

			if var_431_15 < arg_428_1.time_ and arg_428_1.time_ <= var_431_15 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_17 = arg_428_1:FormatText(StoryNameCfg[7].name)

				arg_428_1.leftNameTxt_.text = var_431_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_18 = arg_428_1:GetWordFromCfg(1102002097)
				local var_431_19 = arg_428_1:FormatText(var_431_18.content)

				arg_428_1.text_.text = var_431_19

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_20 = 6
				local var_431_21 = utf8.len(var_431_19)
				local var_431_22 = var_431_20 <= 0 and var_431_16 or var_431_16 * (var_431_21 / var_431_20)

				if var_431_22 > 0 and var_431_16 < var_431_22 then
					arg_428_1.talkMaxDuration = var_431_22

					if var_431_22 + var_431_15 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_22 + var_431_15
					end
				end

				arg_428_1.text_.text = var_431_19
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_23 = math.max(var_431_16, arg_428_1.talkMaxDuration)

			if var_431_15 <= arg_428_1.time_ and arg_428_1.time_ < var_431_15 + var_431_23 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_15) / var_431_23

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_15 + var_431_23 and arg_428_1.time_ < var_431_15 + var_431_23 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play1102002098 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1102002098
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1102002099(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 0.725

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_2 = arg_432_1:GetWordFromCfg(1102002098)
				local var_435_3 = arg_432_1:FormatText(var_435_2.content)

				arg_432_1.text_.text = var_435_3

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_4 = 29
				local var_435_5 = utf8.len(var_435_3)
				local var_435_6 = var_435_4 <= 0 and var_435_1 or var_435_1 * (var_435_5 / var_435_4)

				if var_435_6 > 0 and var_435_1 < var_435_6 then
					arg_432_1.talkMaxDuration = var_435_6

					if var_435_6 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_6 + var_435_0
					end
				end

				arg_432_1.text_.text = var_435_3
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_7 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_7 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_7

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_7 and arg_432_1.time_ < var_435_0 + var_435_7 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1102002099 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1102002099
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1102002100(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0
			local var_439_1 = 0.25

			if var_439_0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_2 = arg_436_1:GetWordFromCfg(1102002099)
				local var_439_3 = arg_436_1:FormatText(var_439_2.content)

				arg_436_1.text_.text = var_439_3

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_4 = 10
				local var_439_5 = utf8.len(var_439_3)
				local var_439_6 = var_439_4 <= 0 and var_439_1 or var_439_1 * (var_439_5 / var_439_4)

				if var_439_6 > 0 and var_439_1 < var_439_6 then
					arg_436_1.talkMaxDuration = var_439_6

					if var_439_6 + var_439_0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_6 + var_439_0
					end
				end

				arg_436_1.text_.text = var_439_3
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_7 = math.max(var_439_1, arg_436_1.talkMaxDuration)

			if var_439_0 <= arg_436_1.time_ and arg_436_1.time_ < var_439_0 + var_439_7 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_0) / var_439_7

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_0 + var_439_7 and arg_436_1.time_ < var_439_0 + var_439_7 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1102002100 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1102002100
		arg_440_1.duration_ = 5.67

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1102002101(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["1020ui_story"].transform
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.var_.moveOldPos1020ui_story = var_443_0.localPosition
			end

			local var_443_2 = 0.001

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2
				local var_443_4 = Vector3.New(0, -0.85, -6.25)

				var_443_0.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1020ui_story, var_443_4, var_443_3)

				local var_443_5 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_5.x, var_443_5.y, var_443_5.z)

				local var_443_6 = var_443_0.localEulerAngles

				var_443_6.z = 0
				var_443_6.x = 0
				var_443_0.localEulerAngles = var_443_6
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 then
				var_443_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_443_7 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_7.x, var_443_7.y, var_443_7.z)

				local var_443_8 = var_443_0.localEulerAngles

				var_443_8.z = 0
				var_443_8.x = 0
				var_443_0.localEulerAngles = var_443_8
			end

			local var_443_9 = arg_440_1.actors_["1020ui_story"]
			local var_443_10 = 0

			if var_443_10 < arg_440_1.time_ and arg_440_1.time_ <= var_443_10 + arg_443_0 and not isNil(var_443_9) and arg_440_1.var_.characterEffect1020ui_story == nil then
				arg_440_1.var_.characterEffect1020ui_story = var_443_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_11 = 0.200000002980232

			if var_443_10 <= arg_440_1.time_ and arg_440_1.time_ < var_443_10 + var_443_11 and not isNil(var_443_9) then
				local var_443_12 = (arg_440_1.time_ - var_443_10) / var_443_11

				if arg_440_1.var_.characterEffect1020ui_story and not isNil(var_443_9) then
					arg_440_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= var_443_10 + var_443_11 and arg_440_1.time_ < var_443_10 + var_443_11 + arg_443_0 and not isNil(var_443_9) and arg_440_1.var_.characterEffect1020ui_story then
				arg_440_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_443_13 = 0

			if var_443_13 < arg_440_1.time_ and arg_440_1.time_ <= var_443_13 + arg_443_0 then
				arg_440_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_443_14 = 0

			if var_443_14 < arg_440_1.time_ and arg_440_1.time_ <= var_443_14 + arg_443_0 then
				arg_440_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_443_15 = 0
			local var_443_16 = 0.475

			if var_443_15 < arg_440_1.time_ and arg_440_1.time_ <= var_443_15 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_17 = arg_440_1:FormatText(StoryNameCfg[613].name)

				arg_440_1.leftNameTxt_.text = var_443_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_18 = arg_440_1:GetWordFromCfg(1102002100)
				local var_443_19 = arg_440_1:FormatText(var_443_18.content)

				arg_440_1.text_.text = var_443_19

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_20 = 19
				local var_443_21 = utf8.len(var_443_19)
				local var_443_22 = var_443_20 <= 0 and var_443_16 or var_443_16 * (var_443_21 / var_443_20)

				if var_443_22 > 0 and var_443_16 < var_443_22 then
					arg_440_1.talkMaxDuration = var_443_22

					if var_443_22 + var_443_15 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_22 + var_443_15
					end
				end

				arg_440_1.text_.text = var_443_19
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002100", "story_v_side_new_1102002.awb") ~= 0 then
					local var_443_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002100", "story_v_side_new_1102002.awb") / 1000

					if var_443_23 + var_443_15 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_23 + var_443_15
					end

					if var_443_18.prefab_name ~= "" and arg_440_1.actors_[var_443_18.prefab_name] ~= nil then
						local var_443_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_18.prefab_name].transform, "story_v_side_new_1102002", "1102002100", "story_v_side_new_1102002.awb")

						arg_440_1:RecordAudio("1102002100", var_443_24)
						arg_440_1:RecordAudio("1102002100", var_443_24)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002100", "story_v_side_new_1102002.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002100", "story_v_side_new_1102002.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_25 = math.max(var_443_16, arg_440_1.talkMaxDuration)

			if var_443_15 <= arg_440_1.time_ and arg_440_1.time_ < var_443_15 + var_443_25 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_15) / var_443_25

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_15 + var_443_25 and arg_440_1.time_ < var_443_15 + var_443_25 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play1102002101 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1102002101
		arg_444_1.duration_ = 1

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1102002102(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0
			local var_447_1 = 0.1

			if var_447_0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_2 = arg_444_1:FormatText(StoryNameCfg[613].name)

				arg_444_1.leftNameTxt_.text = var_447_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_3 = arg_444_1:GetWordFromCfg(1102002101)
				local var_447_4 = arg_444_1:FormatText(var_447_3.content)

				arg_444_1.text_.text = var_447_4

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_5 = 4
				local var_447_6 = utf8.len(var_447_4)
				local var_447_7 = var_447_5 <= 0 and var_447_1 or var_447_1 * (var_447_6 / var_447_5)

				if var_447_7 > 0 and var_447_1 < var_447_7 then
					arg_444_1.talkMaxDuration = var_447_7

					if var_447_7 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_7 + var_447_0
					end
				end

				arg_444_1.text_.text = var_447_4
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002101", "story_v_side_new_1102002.awb") ~= 0 then
					local var_447_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002101", "story_v_side_new_1102002.awb") / 1000

					if var_447_8 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_8 + var_447_0
					end

					if var_447_3.prefab_name ~= "" and arg_444_1.actors_[var_447_3.prefab_name] ~= nil then
						local var_447_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_3.prefab_name].transform, "story_v_side_new_1102002", "1102002101", "story_v_side_new_1102002.awb")

						arg_444_1:RecordAudio("1102002101", var_447_9)
						arg_444_1:RecordAudio("1102002101", var_447_9)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002101", "story_v_side_new_1102002.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002101", "story_v_side_new_1102002.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_10 = math.max(var_447_1, arg_444_1.talkMaxDuration)

			if var_447_0 <= arg_444_1.time_ and arg_444_1.time_ < var_447_0 + var_447_10 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_0) / var_447_10

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_0 + var_447_10 and arg_444_1.time_ < var_447_0 + var_447_10 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play1102002102 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1102002102
		arg_448_1.duration_ = 2

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1102002103(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 then
				arg_448_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_451_2 = 0
			local var_451_3 = 0.15

			if var_451_2 < arg_448_1.time_ and arg_448_1.time_ <= var_451_2 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_4 = arg_448_1:FormatText(StoryNameCfg[613].name)

				arg_448_1.leftNameTxt_.text = var_451_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_5 = arg_448_1:GetWordFromCfg(1102002102)
				local var_451_6 = arg_448_1:FormatText(var_451_5.content)

				arg_448_1.text_.text = var_451_6

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_7 = 6
				local var_451_8 = utf8.len(var_451_6)
				local var_451_9 = var_451_7 <= 0 and var_451_3 or var_451_3 * (var_451_8 / var_451_7)

				if var_451_9 > 0 and var_451_3 < var_451_9 then
					arg_448_1.talkMaxDuration = var_451_9

					if var_451_9 + var_451_2 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_9 + var_451_2
					end
				end

				arg_448_1.text_.text = var_451_6
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002102", "story_v_side_new_1102002.awb") ~= 0 then
					local var_451_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002102", "story_v_side_new_1102002.awb") / 1000

					if var_451_10 + var_451_2 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_10 + var_451_2
					end

					if var_451_5.prefab_name ~= "" and arg_448_1.actors_[var_451_5.prefab_name] ~= nil then
						local var_451_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_5.prefab_name].transform, "story_v_side_new_1102002", "1102002102", "story_v_side_new_1102002.awb")

						arg_448_1:RecordAudio("1102002102", var_451_11)
						arg_448_1:RecordAudio("1102002102", var_451_11)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002102", "story_v_side_new_1102002.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002102", "story_v_side_new_1102002.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_12 = math.max(var_451_3, arg_448_1.talkMaxDuration)

			if var_451_2 <= arg_448_1.time_ and arg_448_1.time_ < var_451_2 + var_451_12 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_2) / var_451_12

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_2 + var_451_12 and arg_448_1.time_ < var_451_2 + var_451_12 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play1102002103 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1102002103
		arg_452_1.duration_ = 1

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"

			SetActive(arg_452_1.choicesGo_, true)

			for iter_453_0, iter_453_1 in ipairs(arg_452_1.choices_) do
				local var_453_0 = iter_453_0 <= 1

				SetActive(iter_453_1.go, var_453_0)
			end

			arg_452_1.choices_[1].txt.text = arg_452_1:FormatText(StoryChoiceCfg[1193].name)
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1102002104(arg_452_1)
			end

			arg_452_1:RecordChoiceLog(1102002103, 1193)
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["1020ui_story"].transform
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 then
				arg_452_1.var_.moveOldPos1020ui_story = var_455_0.localPosition
			end

			local var_455_2 = 0.001

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2
				local var_455_4 = Vector3.New(0, 100, 0)

				var_455_0.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1020ui_story, var_455_4, var_455_3)

				local var_455_5 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_5.x, var_455_5.y, var_455_5.z)

				local var_455_6 = var_455_0.localEulerAngles

				var_455_6.z = 0
				var_455_6.x = 0
				var_455_0.localEulerAngles = var_455_6
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 then
				var_455_0.localPosition = Vector3.New(0, 100, 0)

				local var_455_7 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_7.x, var_455_7.y, var_455_7.z)

				local var_455_8 = var_455_0.localEulerAngles

				var_455_8.z = 0
				var_455_8.x = 0
				var_455_0.localEulerAngles = var_455_8
			end

			local var_455_9 = arg_452_1.actors_["1020ui_story"]
			local var_455_10 = 0

			if var_455_10 < arg_452_1.time_ and arg_452_1.time_ <= var_455_10 + arg_455_0 and not isNil(var_455_9) and arg_452_1.var_.characterEffect1020ui_story == nil then
				arg_452_1.var_.characterEffect1020ui_story = var_455_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_11 = 0.200000002980232

			if var_455_10 <= arg_452_1.time_ and arg_452_1.time_ < var_455_10 + var_455_11 and not isNil(var_455_9) then
				local var_455_12 = (arg_452_1.time_ - var_455_10) / var_455_11

				if arg_452_1.var_.characterEffect1020ui_story and not isNil(var_455_9) then
					local var_455_13 = Mathf.Lerp(0, 0.5, var_455_12)

					arg_452_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_452_1.var_.characterEffect1020ui_story.fillRatio = var_455_13
				end
			end

			if arg_452_1.time_ >= var_455_10 + var_455_11 and arg_452_1.time_ < var_455_10 + var_455_11 + arg_455_0 and not isNil(var_455_9) and arg_452_1.var_.characterEffect1020ui_story then
				local var_455_14 = 0.5

				arg_452_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_452_1.var_.characterEffect1020ui_story.fillRatio = var_455_14
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play1102002104 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1102002104
		arg_456_1.duration_ = 6

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1102002105(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["1020ui_story"].transform
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 then
				arg_456_1.var_.moveOldPos1020ui_story = var_459_0.localPosition
			end

			local var_459_2 = 0.001

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2
				local var_459_4 = Vector3.New(0, -0.85, -6.25)

				var_459_0.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1020ui_story, var_459_4, var_459_3)

				local var_459_5 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_5.x, var_459_5.y, var_459_5.z)

				local var_459_6 = var_459_0.localEulerAngles

				var_459_6.z = 0
				var_459_6.x = 0
				var_459_0.localEulerAngles = var_459_6
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 then
				var_459_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_459_7 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_7.x, var_459_7.y, var_459_7.z)

				local var_459_8 = var_459_0.localEulerAngles

				var_459_8.z = 0
				var_459_8.x = 0
				var_459_0.localEulerAngles = var_459_8
			end

			local var_459_9 = arg_456_1.actors_["1020ui_story"].transform
			local var_459_10 = 3

			if var_459_10 < arg_456_1.time_ and arg_456_1.time_ <= var_459_10 + arg_459_0 then
				arg_456_1.var_.moveOldPos1020ui_story = var_459_9.localPosition
			end

			local var_459_11 = 0.001

			if var_459_10 <= arg_456_1.time_ and arg_456_1.time_ < var_459_10 + var_459_11 then
				local var_459_12 = (arg_456_1.time_ - var_459_10) / var_459_11
				local var_459_13 = Vector3.New(0, 100, 0)

				var_459_9.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1020ui_story, var_459_13, var_459_12)

				local var_459_14 = manager.ui.mainCamera.transform.position - var_459_9.position

				var_459_9.forward = Vector3.New(var_459_14.x, var_459_14.y, var_459_14.z)

				local var_459_15 = var_459_9.localEulerAngles

				var_459_15.z = 0
				var_459_15.x = 0
				var_459_9.localEulerAngles = var_459_15
			end

			if arg_456_1.time_ >= var_459_10 + var_459_11 and arg_456_1.time_ < var_459_10 + var_459_11 + arg_459_0 then
				var_459_9.localPosition = Vector3.New(0, 100, 0)

				local var_459_16 = manager.ui.mainCamera.transform.position - var_459_9.position

				var_459_9.forward = Vector3.New(var_459_16.x, var_459_16.y, var_459_16.z)

				local var_459_17 = var_459_9.localEulerAngles

				var_459_17.z = 0
				var_459_17.x = 0
				var_459_9.localEulerAngles = var_459_17
			end

			local var_459_18 = arg_456_1.actors_["1020ui_story"]
			local var_459_19 = 0

			if var_459_19 < arg_456_1.time_ and arg_456_1.time_ <= var_459_19 + arg_459_0 and not isNil(var_459_18) and arg_456_1.var_.characterEffect1020ui_story == nil then
				arg_456_1.var_.characterEffect1020ui_story = var_459_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_20 = 0.2

			if var_459_19 <= arg_456_1.time_ and arg_456_1.time_ < var_459_19 + var_459_20 and not isNil(var_459_18) then
				local var_459_21 = (arg_456_1.time_ - var_459_19) / var_459_20

				if arg_456_1.var_.characterEffect1020ui_story and not isNil(var_459_18) then
					arg_456_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= var_459_19 + var_459_20 and arg_456_1.time_ < var_459_19 + var_459_20 + arg_459_0 and not isNil(var_459_18) and arg_456_1.var_.characterEffect1020ui_story then
				arg_456_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_459_22 = 0

			if var_459_22 < arg_456_1.time_ and arg_456_1.time_ <= var_459_22 + arg_459_0 then
				arg_456_1.mask_.enabled = true
				arg_456_1.mask_.raycastTarget = true

				arg_456_1:SetGaussion(false)
			end

			local var_459_23 = 3

			if var_459_22 <= arg_456_1.time_ and arg_456_1.time_ < var_459_22 + var_459_23 then
				local var_459_24 = (arg_456_1.time_ - var_459_22) / var_459_23
				local var_459_25 = Color.New(0, 0, 0)

				var_459_25.a = Mathf.Lerp(0, 1, var_459_24)
				arg_456_1.mask_.color = var_459_25
			end

			if arg_456_1.time_ >= var_459_22 + var_459_23 and arg_456_1.time_ < var_459_22 + var_459_23 + arg_459_0 then
				local var_459_26 = Color.New(0, 0, 0)

				var_459_26.a = 1
				arg_456_1.mask_.color = var_459_26
			end

			local var_459_27 = 3

			if var_459_27 < arg_456_1.time_ and arg_456_1.time_ <= var_459_27 + arg_459_0 then
				arg_456_1.mask_.enabled = true
				arg_456_1.mask_.raycastTarget = true

				arg_456_1:SetGaussion(false)
			end

			local var_459_28 = 3

			if var_459_27 <= arg_456_1.time_ and arg_456_1.time_ < var_459_27 + var_459_28 then
				local var_459_29 = (arg_456_1.time_ - var_459_27) / var_459_28
				local var_459_30 = Color.New(0, 0, 0)

				var_459_30.a = Mathf.Lerp(1, 0, var_459_29)
				arg_456_1.mask_.color = var_459_30
			end

			if arg_456_1.time_ >= var_459_27 + var_459_28 and arg_456_1.time_ < var_459_27 + var_459_28 + arg_459_0 then
				local var_459_31 = Color.New(0, 0, 0)
				local var_459_32 = 0

				arg_456_1.mask_.enabled = false
				var_459_31.a = var_459_32
				arg_456_1.mask_.color = var_459_31
			end

			local var_459_33 = 3

			if var_459_33 < arg_456_1.time_ and arg_456_1.time_ <= var_459_33 + arg_459_0 then
				local var_459_34 = manager.ui.mainCamera.transform.localPosition
				local var_459_35 = Vector3.New(0, 0, 10) + Vector3.New(var_459_34.x, var_459_34.y, 0)
				local var_459_36 = arg_456_1.bgs_.STblack

				var_459_36.transform.localPosition = var_459_35
				var_459_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_459_37 = var_459_36:GetComponent("SpriteRenderer")

				if var_459_37 and var_459_37.sprite then
					local var_459_38 = (var_459_36.transform.localPosition - var_459_34).z
					local var_459_39 = manager.ui.mainCameraCom_
					local var_459_40 = 2 * var_459_38 * Mathf.Tan(var_459_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_459_41 = var_459_40 * var_459_39.aspect
					local var_459_42 = var_459_37.sprite.bounds.size.x
					local var_459_43 = var_459_37.sprite.bounds.size.y
					local var_459_44 = var_459_41 / var_459_42
					local var_459_45 = var_459_40 / var_459_43
					local var_459_46 = var_459_45 < var_459_44 and var_459_44 or var_459_45

					var_459_36.transform.localScale = Vector3.New(var_459_46, var_459_46, 0)
				end

				for iter_459_0, iter_459_1 in pairs(arg_456_1.bgs_) do
					if iter_459_0 ~= "STblack" then
						iter_459_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_459_47 = 0
			local var_459_48 = 0.225

			if var_459_47 < arg_456_1.time_ and arg_456_1.time_ <= var_459_47 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_49 = arg_456_1:FormatText(StoryNameCfg[613].name)

				arg_456_1.leftNameTxt_.text = var_459_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_50 = arg_456_1:GetWordFromCfg(1102002104)
				local var_459_51 = arg_456_1:FormatText(var_459_50.content)

				arg_456_1.text_.text = var_459_51

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_52 = 9
				local var_459_53 = utf8.len(var_459_51)
				local var_459_54 = var_459_52 <= 0 and var_459_48 or var_459_48 * (var_459_53 / var_459_52)

				if var_459_54 > 0 and var_459_48 < var_459_54 then
					arg_456_1.talkMaxDuration = var_459_54

					if var_459_54 + var_459_47 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_54 + var_459_47
					end
				end

				arg_456_1.text_.text = var_459_51
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002104", "story_v_side_new_1102002.awb") ~= 0 then
					local var_459_55 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002104", "story_v_side_new_1102002.awb") / 1000

					if var_459_55 + var_459_47 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_55 + var_459_47
					end

					if var_459_50.prefab_name ~= "" and arg_456_1.actors_[var_459_50.prefab_name] ~= nil then
						local var_459_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_50.prefab_name].transform, "story_v_side_new_1102002", "1102002104", "story_v_side_new_1102002.awb")

						arg_456_1:RecordAudio("1102002104", var_459_56)
						arg_456_1:RecordAudio("1102002104", var_459_56)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002104", "story_v_side_new_1102002.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002104", "story_v_side_new_1102002.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_57 = math.max(var_459_48, arg_456_1.talkMaxDuration)

			if var_459_47 <= arg_456_1.time_ and arg_456_1.time_ < var_459_47 + var_459_57 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_47) / var_459_57

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_47 + var_459_57 and arg_456_1.time_ < var_459_47 + var_459_57 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play1102002105 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1102002105
		arg_460_1.duration_ = 7

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1102002106(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				local var_463_1 = manager.ui.mainCamera.transform.localPosition
				local var_463_2 = Vector3.New(0, 0, 10) + Vector3.New(var_463_1.x, var_463_1.y, 0)
				local var_463_3 = arg_460_1.bgs_.ST0505

				var_463_3.transform.localPosition = var_463_2
				var_463_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_463_4 = var_463_3:GetComponent("SpriteRenderer")

				if var_463_4 and var_463_4.sprite then
					local var_463_5 = (var_463_3.transform.localPosition - var_463_1).z
					local var_463_6 = manager.ui.mainCameraCom_
					local var_463_7 = 2 * var_463_5 * Mathf.Tan(var_463_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_463_8 = var_463_7 * var_463_6.aspect
					local var_463_9 = var_463_4.sprite.bounds.size.x
					local var_463_10 = var_463_4.sprite.bounds.size.y
					local var_463_11 = var_463_8 / var_463_9
					local var_463_12 = var_463_7 / var_463_10
					local var_463_13 = var_463_12 < var_463_11 and var_463_11 or var_463_12

					var_463_3.transform.localScale = Vector3.New(var_463_13, var_463_13, 0)
				end

				for iter_463_0, iter_463_1 in pairs(arg_460_1.bgs_) do
					if iter_463_0 ~= "ST0505" then
						iter_463_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_463_14 = 1.999999999999

			if var_463_14 < arg_460_1.time_ and arg_460_1.time_ <= var_463_14 + arg_463_0 then
				arg_460_1.allBtn_.enabled = false
			end

			local var_463_15 = 0.3

			if arg_460_1.time_ >= var_463_14 + var_463_15 and arg_460_1.time_ < var_463_14 + var_463_15 + arg_463_0 then
				arg_460_1.allBtn_.enabled = true
			end

			local var_463_16 = 0

			if var_463_16 < arg_460_1.time_ and arg_460_1.time_ <= var_463_16 + arg_463_0 then
				arg_460_1.mask_.enabled = true
				arg_460_1.mask_.raycastTarget = true

				arg_460_1:SetGaussion(false)
			end

			local var_463_17 = 2

			if var_463_16 <= arg_460_1.time_ and arg_460_1.time_ < var_463_16 + var_463_17 then
				local var_463_18 = (arg_460_1.time_ - var_463_16) / var_463_17
				local var_463_19 = Color.New(1, 1, 1)

				var_463_19.a = Mathf.Lerp(1, 0, var_463_18)
				arg_460_1.mask_.color = var_463_19
			end

			if arg_460_1.time_ >= var_463_16 + var_463_17 and arg_460_1.time_ < var_463_16 + var_463_17 + arg_463_0 then
				local var_463_20 = Color.New(1, 1, 1)
				local var_463_21 = 0

				arg_460_1.mask_.enabled = false
				var_463_20.a = var_463_21
				arg_460_1.mask_.color = var_463_20
			end

			local var_463_22 = manager.ui.mainCamera.transform
			local var_463_23 = 1.999999999999

			if var_463_23 < arg_460_1.time_ and arg_460_1.time_ <= var_463_23 + arg_463_0 then
				arg_460_1.var_.shakeOldPos = var_463_22.localPosition
			end

			local var_463_24 = 0.5

			if var_463_23 <= arg_460_1.time_ and arg_460_1.time_ < var_463_23 + var_463_24 then
				local var_463_25 = (arg_460_1.time_ - var_463_23) / 0.066
				local var_463_26, var_463_27 = math.modf(var_463_25)

				var_463_22.localPosition = Vector3.New(var_463_27 * 0.13, var_463_27 * 0.13, var_463_27 * 0.13) + arg_460_1.var_.shakeOldPos
			end

			if arg_460_1.time_ >= var_463_23 + var_463_24 and arg_460_1.time_ < var_463_23 + var_463_24 + arg_463_0 then
				var_463_22.localPosition = arg_460_1.var_.shakeOldPos
			end

			local var_463_28 = 1.999999999999

			if var_463_28 < arg_460_1.time_ and arg_460_1.time_ <= var_463_28 + arg_463_0 then
				arg_460_1.allBtn_.enabled = false
			end

			local var_463_29 = 0.5

			if arg_460_1.time_ >= var_463_28 + var_463_29 and arg_460_1.time_ < var_463_28 + var_463_29 + arg_463_0 then
				arg_460_1.allBtn_.enabled = true
			end

			local var_463_30 = 0
			local var_463_31 = 1

			if var_463_30 < arg_460_1.time_ and arg_460_1.time_ <= var_463_30 + arg_463_0 then
				local var_463_32 = "play"
				local var_463_33 = "effect"

				arg_460_1:AudioAction(var_463_32, var_463_33, "se_story_140", "se_story_140_amb_room02", "")
			end

			local var_463_34 = 0
			local var_463_35 = 1

			if var_463_34 < arg_460_1.time_ and arg_460_1.time_ <= var_463_34 + arg_463_0 then
				local var_463_36 = "play"
				local var_463_37 = "effect"

				arg_460_1:AudioAction(var_463_36, var_463_37, "se_story_side_1020", "se_story_side_1020_whoosh02", "")
			end

			local var_463_38 = 0
			local var_463_39 = 1

			if var_463_38 < arg_460_1.time_ and arg_460_1.time_ <= var_463_38 + arg_463_0 then
				local var_463_40 = "stop"
				local var_463_41 = "effect"

				arg_460_1:AudioAction(var_463_40, var_463_41, "se_story_140", "se_story_140_amb_rewind_loop", "")
			end

			if arg_460_1.frameCnt_ <= 1 then
				arg_460_1.dialog_:SetActive(false)
			end

			local var_463_42 = 2
			local var_463_43 = 0.075

			if var_463_42 < arg_460_1.time_ and arg_460_1.time_ <= var_463_42 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0

				arg_460_1.dialog_:SetActive(true)

				arg_460_1.dialogCg_.alpha = 0

				local var_463_44 = LeanTween.value(arg_460_1.dialog_, 0, 1, 0.3)

				var_463_44:setOnUpdate(LuaHelper.FloatAction(function(arg_464_0)
					arg_460_1.dialogCg_.alpha = arg_464_0
				end))
				var_463_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_460_1.dialog_)
					var_463_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_460_1.duration_ = arg_460_1.duration_ + 0.3

				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_45 = arg_460_1:FormatText(StoryNameCfg[7].name)

				arg_460_1.leftNameTxt_.text = var_463_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_46 = arg_460_1:GetWordFromCfg(1102002105)
				local var_463_47 = arg_460_1:FormatText(var_463_46.content)

				arg_460_1.text_.text = var_463_47

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_48 = 3
				local var_463_49 = utf8.len(var_463_47)
				local var_463_50 = var_463_48 <= 0 and var_463_43 or var_463_43 * (var_463_49 / var_463_48)

				if var_463_50 > 0 and var_463_43 < var_463_50 then
					arg_460_1.talkMaxDuration = var_463_50
					var_463_42 = var_463_42 + 0.3

					if var_463_50 + var_463_42 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_50 + var_463_42
					end
				end

				arg_460_1.text_.text = var_463_47
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_51 = var_463_42 + 0.3
			local var_463_52 = math.max(var_463_43, arg_460_1.talkMaxDuration)

			if var_463_51 <= arg_460_1.time_ and arg_460_1.time_ < var_463_51 + var_463_52 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_51) / var_463_52

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_51 + var_463_52 and arg_460_1.time_ < var_463_51 + var_463_52 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play1102002106 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1102002106
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1102002107(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0
			local var_469_1 = 0.625

			if var_469_0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, false)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_2 = arg_466_1:GetWordFromCfg(1102002106)
				local var_469_3 = arg_466_1:FormatText(var_469_2.content)

				arg_466_1.text_.text = var_469_3

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_4 = 25
				local var_469_5 = utf8.len(var_469_3)
				local var_469_6 = var_469_4 <= 0 and var_469_1 or var_469_1 * (var_469_5 / var_469_4)

				if var_469_6 > 0 and var_469_1 < var_469_6 then
					arg_466_1.talkMaxDuration = var_469_6

					if var_469_6 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_6 + var_469_0
					end
				end

				arg_466_1.text_.text = var_469_3
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_7 = math.max(var_469_1, arg_466_1.talkMaxDuration)

			if var_469_0 <= arg_466_1.time_ and arg_466_1.time_ < var_469_0 + var_469_7 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_0) / var_469_7

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_0 + var_469_7 and arg_466_1.time_ < var_469_0 + var_469_7 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1102002107 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1102002107
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1102002108(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0
			local var_473_1 = 0.25

			if var_473_0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_2 = arg_470_1:FormatText(StoryNameCfg[7].name)

				arg_470_1.leftNameTxt_.text = var_473_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, true)
				arg_470_1.iconController_:SetSelectedState("hero")

				arg_470_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_470_1.callingController_:SetSelectedState("normal")

				arg_470_1.keyicon_.color = Color.New(1, 1, 1)
				arg_470_1.icon_.color = Color.New(1, 1, 1)

				local var_473_3 = arg_470_1:GetWordFromCfg(1102002107)
				local var_473_4 = arg_470_1:FormatText(var_473_3.content)

				arg_470_1.text_.text = var_473_4

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_5 = 10
				local var_473_6 = utf8.len(var_473_4)
				local var_473_7 = var_473_5 <= 0 and var_473_1 or var_473_1 * (var_473_6 / var_473_5)

				if var_473_7 > 0 and var_473_1 < var_473_7 then
					arg_470_1.talkMaxDuration = var_473_7

					if var_473_7 + var_473_0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_7 + var_473_0
					end
				end

				arg_470_1.text_.text = var_473_4
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_8 = math.max(var_473_1, arg_470_1.talkMaxDuration)

			if var_473_0 <= arg_470_1.time_ and arg_470_1.time_ < var_473_0 + var_473_8 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_0) / var_473_8

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_0 + var_473_8 and arg_470_1.time_ < var_473_0 + var_473_8 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play1102002108 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1102002108
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1102002109(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0
			local var_477_1 = 0.925

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

				local var_477_2 = arg_474_1:GetWordFromCfg(1102002108)
				local var_477_3 = arg_474_1:FormatText(var_477_2.content)

				arg_474_1.text_.text = var_477_3

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_4 = 37
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
	Play1102002109 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1102002109
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1102002110(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 1.65

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_2 = arg_478_1:GetWordFromCfg(1102002109)
				local var_481_3 = arg_478_1:FormatText(var_481_2.content)

				arg_478_1.text_.text = var_481_3

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_4 = 66
				local var_481_5 = utf8.len(var_481_3)
				local var_481_6 = var_481_4 <= 0 and var_481_1 or var_481_1 * (var_481_5 / var_481_4)

				if var_481_6 > 0 and var_481_1 < var_481_6 then
					arg_478_1.talkMaxDuration = var_481_6

					if var_481_6 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_6 + var_481_0
					end
				end

				arg_478_1.text_.text = var_481_3
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_7 = math.max(var_481_1, arg_478_1.talkMaxDuration)

			if var_481_0 <= arg_478_1.time_ and arg_478_1.time_ < var_481_0 + var_481_7 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_0) / var_481_7

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_0 + var_481_7 and arg_478_1.time_ < var_481_0 + var_481_7 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play1102002110 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1102002110
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1102002111(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 0.65

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_2 = arg_482_1:FormatText(StoryNameCfg[7].name)

				arg_482_1.leftNameTxt_.text = var_485_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_3 = arg_482_1:GetWordFromCfg(1102002110)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 26
				local var_485_6 = utf8.len(var_485_4)
				local var_485_7 = var_485_5 <= 0 and var_485_1 or var_485_1 * (var_485_6 / var_485_5)

				if var_485_7 > 0 and var_485_1 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_0
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_8 = math.max(var_485_1, arg_482_1.talkMaxDuration)

			if var_485_0 <= arg_482_1.time_ and arg_482_1.time_ < var_485_0 + var_485_8 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_0) / var_485_8

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_0 + var_485_8 and arg_482_1.time_ < var_485_0 + var_485_8 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1102002111 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1102002111
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1102002112(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0
			local var_489_1 = 0.375

			if var_489_0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_2 = arg_486_1:FormatText(StoryNameCfg[7].name)

				arg_486_1.leftNameTxt_.text = var_489_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_3 = arg_486_1:GetWordFromCfg(1102002111)
				local var_489_4 = arg_486_1:FormatText(var_489_3.content)

				arg_486_1.text_.text = var_489_4

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_5 = 15
				local var_489_6 = utf8.len(var_489_4)
				local var_489_7 = var_489_5 <= 0 and var_489_1 or var_489_1 * (var_489_6 / var_489_5)

				if var_489_7 > 0 and var_489_1 < var_489_7 then
					arg_486_1.talkMaxDuration = var_489_7

					if var_489_7 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_7 + var_489_0
					end
				end

				arg_486_1.text_.text = var_489_4
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_8 = math.max(var_489_1, arg_486_1.talkMaxDuration)

			if var_489_0 <= arg_486_1.time_ and arg_486_1.time_ < var_489_0 + var_489_8 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_0) / var_489_8

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_0 + var_489_8 and arg_486_1.time_ < var_489_0 + var_489_8 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play1102002112 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1102002112
		arg_490_1.duration_ = 12.5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1102002113(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 2.00000000298023

			if var_493_0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				local var_493_1 = manager.ui.mainCamera.transform.localPosition
				local var_493_2 = Vector3.New(0, 0, 10) + Vector3.New(var_493_1.x, var_493_1.y, 0)
				local var_493_3 = arg_490_1.bgs_.ST12

				var_493_3.transform.localPosition = var_493_2
				var_493_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_493_4 = var_493_3:GetComponent("SpriteRenderer")

				if var_493_4 and var_493_4.sprite then
					local var_493_5 = (var_493_3.transform.localPosition - var_493_1).z
					local var_493_6 = manager.ui.mainCameraCom_
					local var_493_7 = 2 * var_493_5 * Mathf.Tan(var_493_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_493_8 = var_493_7 * var_493_6.aspect
					local var_493_9 = var_493_4.sprite.bounds.size.x
					local var_493_10 = var_493_4.sprite.bounds.size.y
					local var_493_11 = var_493_8 / var_493_9
					local var_493_12 = var_493_7 / var_493_10
					local var_493_13 = var_493_12 < var_493_11 and var_493_11 or var_493_12

					var_493_3.transform.localScale = Vector3.New(var_493_13, var_493_13, 0)
				end

				for iter_493_0, iter_493_1 in pairs(arg_490_1.bgs_) do
					if iter_493_0 ~= "ST12" then
						iter_493_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_493_14 = 4

			if var_493_14 < arg_490_1.time_ and arg_490_1.time_ <= var_493_14 + arg_493_0 then
				arg_490_1.allBtn_.enabled = false
			end

			local var_493_15 = 0.3

			if arg_490_1.time_ >= var_493_14 + var_493_15 and arg_490_1.time_ < var_493_14 + var_493_15 + arg_493_0 then
				arg_490_1.allBtn_.enabled = true
			end

			local var_493_16 = 0

			if var_493_16 < arg_490_1.time_ and arg_490_1.time_ <= var_493_16 + arg_493_0 then
				arg_490_1.mask_.enabled = true
				arg_490_1.mask_.raycastTarget = true

				arg_490_1:SetGaussion(false)
			end

			local var_493_17 = 2

			if var_493_16 <= arg_490_1.time_ and arg_490_1.time_ < var_493_16 + var_493_17 then
				local var_493_18 = (arg_490_1.time_ - var_493_16) / var_493_17
				local var_493_19 = Color.New(0, 0, 0)

				var_493_19.a = Mathf.Lerp(0, 1, var_493_18)
				arg_490_1.mask_.color = var_493_19
			end

			if arg_490_1.time_ >= var_493_16 + var_493_17 and arg_490_1.time_ < var_493_16 + var_493_17 + arg_493_0 then
				local var_493_20 = Color.New(0, 0, 0)

				var_493_20.a = 1
				arg_490_1.mask_.color = var_493_20
			end

			local var_493_21 = 2

			if var_493_21 < arg_490_1.time_ and arg_490_1.time_ <= var_493_21 + arg_493_0 then
				arg_490_1.mask_.enabled = true
				arg_490_1.mask_.raycastTarget = true

				arg_490_1:SetGaussion(false)
			end

			local var_493_22 = 2

			if var_493_21 <= arg_490_1.time_ and arg_490_1.time_ < var_493_21 + var_493_22 then
				local var_493_23 = (arg_490_1.time_ - var_493_21) / var_493_22
				local var_493_24 = Color.New(0, 0, 0)

				var_493_24.a = Mathf.Lerp(1, 0, var_493_23)
				arg_490_1.mask_.color = var_493_24
			end

			if arg_490_1.time_ >= var_493_21 + var_493_22 and arg_490_1.time_ < var_493_21 + var_493_22 + arg_493_0 then
				local var_493_25 = Color.New(0, 0, 0)
				local var_493_26 = 0

				arg_490_1.mask_.enabled = false
				var_493_25.a = var_493_26
				arg_490_1.mask_.color = var_493_25
			end

			local var_493_27 = arg_490_1.actors_["1029ui_story"].transform
			local var_493_28 = 3.8

			if var_493_28 < arg_490_1.time_ and arg_490_1.time_ <= var_493_28 + arg_493_0 then
				arg_490_1.var_.moveOldPos1029ui_story = var_493_27.localPosition
			end

			local var_493_29 = 0.001

			if var_493_28 <= arg_490_1.time_ and arg_490_1.time_ < var_493_28 + var_493_29 then
				local var_493_30 = (arg_490_1.time_ - var_493_28) / var_493_29
				local var_493_31 = Vector3.New(0, -1.09, -6.2)

				var_493_27.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1029ui_story, var_493_31, var_493_30)

				local var_493_32 = manager.ui.mainCamera.transform.position - var_493_27.position

				var_493_27.forward = Vector3.New(var_493_32.x, var_493_32.y, var_493_32.z)

				local var_493_33 = var_493_27.localEulerAngles

				var_493_33.z = 0
				var_493_33.x = 0
				var_493_27.localEulerAngles = var_493_33
			end

			if arg_490_1.time_ >= var_493_28 + var_493_29 and arg_490_1.time_ < var_493_28 + var_493_29 + arg_493_0 then
				var_493_27.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_493_34 = manager.ui.mainCamera.transform.position - var_493_27.position

				var_493_27.forward = Vector3.New(var_493_34.x, var_493_34.y, var_493_34.z)

				local var_493_35 = var_493_27.localEulerAngles

				var_493_35.z = 0
				var_493_35.x = 0
				var_493_27.localEulerAngles = var_493_35
			end

			local var_493_36 = arg_490_1.actors_["1029ui_story"]
			local var_493_37 = 3.8

			if var_493_37 < arg_490_1.time_ and arg_490_1.time_ <= var_493_37 + arg_493_0 and not isNil(var_493_36) and arg_490_1.var_.characterEffect1029ui_story == nil then
				arg_490_1.var_.characterEffect1029ui_story = var_493_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_38 = 0.200000002980232

			if var_493_37 <= arg_490_1.time_ and arg_490_1.time_ < var_493_37 + var_493_38 and not isNil(var_493_36) then
				local var_493_39 = (arg_490_1.time_ - var_493_37) / var_493_38

				if arg_490_1.var_.characterEffect1029ui_story and not isNil(var_493_36) then
					arg_490_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= var_493_37 + var_493_38 and arg_490_1.time_ < var_493_37 + var_493_38 + arg_493_0 and not isNil(var_493_36) and arg_490_1.var_.characterEffect1029ui_story then
				arg_490_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_493_40 = 3.8

			if var_493_40 < arg_490_1.time_ and arg_490_1.time_ <= var_493_40 + arg_493_0 then
				arg_490_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_493_41 = 3.8

			if var_493_41 < arg_490_1.time_ and arg_490_1.time_ <= var_493_41 + arg_493_0 then
				arg_490_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_493_42 = 2.00000000298023

			arg_490_1.isInRecall_ = false

			if var_493_42 < arg_490_1.time_ and arg_490_1.time_ <= var_493_42 + arg_493_0 then
				arg_490_1.screenFilterGo_:SetActive(true)

				arg_490_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_493_2, iter_493_3 in pairs(arg_490_1.actors_) do
					local var_493_43 = iter_493_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_493_4, iter_493_5 in ipairs(var_493_43) do
						if iter_493_5.color.r > 0.51 then
							iter_493_5.color = Color.New(1, 1, 1)
						else
							iter_493_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_493_44 = 0.1

			if var_493_42 <= arg_490_1.time_ and arg_490_1.time_ < var_493_42 + var_493_44 then
				local var_493_45 = (arg_490_1.time_ - var_493_42) / var_493_44

				arg_490_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_493_45)
			end

			if arg_490_1.time_ >= var_493_42 + var_493_44 and arg_490_1.time_ < var_493_42 + var_493_44 + arg_493_0 then
				arg_490_1.screenFilterEffect_.weight = 1
			end

			local var_493_46 = 0.266666666666667
			local var_493_47 = 1

			if var_493_46 < arg_490_1.time_ and arg_490_1.time_ <= var_493_46 + arg_493_0 then
				local var_493_48 = "stop"
				local var_493_49 = "effect"

				arg_490_1:AudioAction(var_493_48, var_493_49, "se_story_140", "se_story_140_amb_room02", "")
			end

			local var_493_50 = 1.66666666666667
			local var_493_51 = 1

			if var_493_50 < arg_490_1.time_ and arg_490_1.time_ <= var_493_50 + arg_493_0 then
				local var_493_52 = "play"
				local var_493_53 = "effect"

				arg_490_1:AudioAction(var_493_52, var_493_53, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_490_1.frameCnt_ <= 1 then
				arg_490_1.dialog_:SetActive(false)
			end

			local var_493_54 = 4.00000000298023
			local var_493_55 = 0.6

			if var_493_54 < arg_490_1.time_ and arg_490_1.time_ <= var_493_54 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0

				arg_490_1.dialog_:SetActive(true)

				arg_490_1.dialogCg_.alpha = 0

				local var_493_56 = LeanTween.value(arg_490_1.dialog_, 0, 1, 0.3)

				var_493_56:setOnUpdate(LuaHelper.FloatAction(function(arg_494_0)
					arg_490_1.dialogCg_.alpha = arg_494_0
				end))
				var_493_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_490_1.dialog_)
					var_493_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_490_1.duration_ = arg_490_1.duration_ + 0.3

				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_57 = arg_490_1:FormatText(StoryNameCfg[319].name)

				arg_490_1.leftNameTxt_.text = var_493_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_58 = arg_490_1:GetWordFromCfg(1102002112)
				local var_493_59 = arg_490_1:FormatText(var_493_58.content)

				arg_490_1.text_.text = var_493_59

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_60 = 24
				local var_493_61 = utf8.len(var_493_59)
				local var_493_62 = var_493_60 <= 0 and var_493_55 or var_493_55 * (var_493_61 / var_493_60)

				if var_493_62 > 0 and var_493_55 < var_493_62 then
					arg_490_1.talkMaxDuration = var_493_62
					var_493_54 = var_493_54 + 0.3

					if var_493_62 + var_493_54 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_62 + var_493_54
					end
				end

				arg_490_1.text_.text = var_493_59
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002112", "story_v_side_new_1102002.awb") ~= 0 then
					local var_493_63 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002112", "story_v_side_new_1102002.awb") / 1000

					if var_493_63 + var_493_54 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_63 + var_493_54
					end

					if var_493_58.prefab_name ~= "" and arg_490_1.actors_[var_493_58.prefab_name] ~= nil then
						local var_493_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_58.prefab_name].transform, "story_v_side_new_1102002", "1102002112", "story_v_side_new_1102002.awb")

						arg_490_1:RecordAudio("1102002112", var_493_64)
						arg_490_1:RecordAudio("1102002112", var_493_64)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002112", "story_v_side_new_1102002.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002112", "story_v_side_new_1102002.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_65 = var_493_54 + 0.3
			local var_493_66 = math.max(var_493_55, arg_490_1.talkMaxDuration)

			if var_493_65 <= arg_490_1.time_ and arg_490_1.time_ < var_493_65 + var_493_66 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_65) / var_493_66

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_65 + var_493_66 and arg_490_1.time_ < var_493_65 + var_493_66 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play1102002113 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 1102002113
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play1102002114(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["1029ui_story"].transform
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 then
				arg_496_1.var_.moveOldPos1029ui_story = var_499_0.localPosition
			end

			local var_499_2 = 0.001

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_2 then
				local var_499_3 = (arg_496_1.time_ - var_499_1) / var_499_2
				local var_499_4 = Vector3.New(0, 100, 0)

				var_499_0.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos1029ui_story, var_499_4, var_499_3)

				local var_499_5 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_5.x, var_499_5.y, var_499_5.z)

				local var_499_6 = var_499_0.localEulerAngles

				var_499_6.z = 0
				var_499_6.x = 0
				var_499_0.localEulerAngles = var_499_6
			end

			if arg_496_1.time_ >= var_499_1 + var_499_2 and arg_496_1.time_ < var_499_1 + var_499_2 + arg_499_0 then
				var_499_0.localPosition = Vector3.New(0, 100, 0)

				local var_499_7 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_7.x, var_499_7.y, var_499_7.z)

				local var_499_8 = var_499_0.localEulerAngles

				var_499_8.z = 0
				var_499_8.x = 0
				var_499_0.localEulerAngles = var_499_8
			end

			local var_499_9 = arg_496_1.actors_["1029ui_story"]
			local var_499_10 = 0

			if var_499_10 < arg_496_1.time_ and arg_496_1.time_ <= var_499_10 + arg_499_0 and not isNil(var_499_9) and arg_496_1.var_.characterEffect1029ui_story == nil then
				arg_496_1.var_.characterEffect1029ui_story = var_499_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_11 = 0.200000002980232

			if var_499_10 <= arg_496_1.time_ and arg_496_1.time_ < var_499_10 + var_499_11 and not isNil(var_499_9) then
				local var_499_12 = (arg_496_1.time_ - var_499_10) / var_499_11

				if arg_496_1.var_.characterEffect1029ui_story and not isNil(var_499_9) then
					local var_499_13 = Mathf.Lerp(0, 0.5, var_499_12)

					arg_496_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_496_1.var_.characterEffect1029ui_story.fillRatio = var_499_13
				end
			end

			if arg_496_1.time_ >= var_499_10 + var_499_11 and arg_496_1.time_ < var_499_10 + var_499_11 + arg_499_0 and not isNil(var_499_9) and arg_496_1.var_.characterEffect1029ui_story then
				local var_499_14 = 0.5

				arg_496_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_496_1.var_.characterEffect1029ui_story.fillRatio = var_499_14
			end

			local var_499_15 = 0
			local var_499_16 = 0.225

			if var_499_15 < arg_496_1.time_ and arg_496_1.time_ <= var_499_15 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_17 = arg_496_1:FormatText(StoryNameCfg[7].name)

				arg_496_1.leftNameTxt_.text = var_499_17

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

				local var_499_18 = arg_496_1:GetWordFromCfg(1102002113)
				local var_499_19 = arg_496_1:FormatText(var_499_18.content)

				arg_496_1.text_.text = var_499_19

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_20 = 9
				local var_499_21 = utf8.len(var_499_19)
				local var_499_22 = var_499_20 <= 0 and var_499_16 or var_499_16 * (var_499_21 / var_499_20)

				if var_499_22 > 0 and var_499_16 < var_499_22 then
					arg_496_1.talkMaxDuration = var_499_22

					if var_499_22 + var_499_15 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_22 + var_499_15
					end
				end

				arg_496_1.text_.text = var_499_19
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_23 = math.max(var_499_16, arg_496_1.talkMaxDuration)

			if var_499_15 <= arg_496_1.time_ and arg_496_1.time_ < var_499_15 + var_499_23 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_15) / var_499_23

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_15 + var_499_23 and arg_496_1.time_ < var_499_15 + var_499_23 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play1102002114 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1102002114
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1102002115(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 1.275

			if var_503_0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_2 = arg_500_1:GetWordFromCfg(1102002114)
				local var_503_3 = arg_500_1:FormatText(var_503_2.content)

				arg_500_1.text_.text = var_503_3

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_4 = 51
				local var_503_5 = utf8.len(var_503_3)
				local var_503_6 = var_503_4 <= 0 and var_503_1 or var_503_1 * (var_503_5 / var_503_4)

				if var_503_6 > 0 and var_503_1 < var_503_6 then
					arg_500_1.talkMaxDuration = var_503_6

					if var_503_6 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_6 + var_503_0
					end
				end

				arg_500_1.text_.text = var_503_3
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_7 = math.max(var_503_1, arg_500_1.talkMaxDuration)

			if var_503_0 <= arg_500_1.time_ and arg_500_1.time_ < var_503_0 + var_503_7 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_0) / var_503_7

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_0 + var_503_7 and arg_500_1.time_ < var_503_0 + var_503_7 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play1102002115 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1102002115
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play1102002116(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 1.175

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, false)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_2 = arg_504_1:GetWordFromCfg(1102002115)
				local var_507_3 = arg_504_1:FormatText(var_507_2.content)

				arg_504_1.text_.text = var_507_3

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_4 = 47
				local var_507_5 = utf8.len(var_507_3)
				local var_507_6 = var_507_4 <= 0 and var_507_1 or var_507_1 * (var_507_5 / var_507_4)

				if var_507_6 > 0 and var_507_1 < var_507_6 then
					arg_504_1.talkMaxDuration = var_507_6

					if var_507_6 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_6 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_3
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_7 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_7 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_7

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_7 and arg_504_1.time_ < var_507_0 + var_507_7 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play1102002116 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1102002116
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1102002117(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0
			local var_511_1 = 0.475

			if var_511_0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, false)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_2 = arg_508_1:GetWordFromCfg(1102002116)
				local var_511_3 = arg_508_1:FormatText(var_511_2.content)

				arg_508_1.text_.text = var_511_3

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_4 = 19
				local var_511_5 = utf8.len(var_511_3)
				local var_511_6 = var_511_4 <= 0 and var_511_1 or var_511_1 * (var_511_5 / var_511_4)

				if var_511_6 > 0 and var_511_1 < var_511_6 then
					arg_508_1.talkMaxDuration = var_511_6

					if var_511_6 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_6 + var_511_0
					end
				end

				arg_508_1.text_.text = var_511_3
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_7 = math.max(var_511_1, arg_508_1.talkMaxDuration)

			if var_511_0 <= arg_508_1.time_ and arg_508_1.time_ < var_511_0 + var_511_7 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_0) / var_511_7

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_0 + var_511_7 and arg_508_1.time_ < var_511_0 + var_511_7 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play1102002117 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1102002117
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play1102002118(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = 0
			local var_515_1 = 0.2

			if var_515_0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_0 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_2 = arg_512_1:FormatText(StoryNameCfg[7].name)

				arg_512_1.leftNameTxt_.text = var_515_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, true)
				arg_512_1.iconController_:SetSelectedState("hero")

				arg_512_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_512_1.callingController_:SetSelectedState("normal")

				arg_512_1.keyicon_.color = Color.New(1, 1, 1)
				arg_512_1.icon_.color = Color.New(1, 1, 1)

				local var_515_3 = arg_512_1:GetWordFromCfg(1102002117)
				local var_515_4 = arg_512_1:FormatText(var_515_3.content)

				arg_512_1.text_.text = var_515_4

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_5 = 8
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
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_8 = math.max(var_515_1, arg_512_1.talkMaxDuration)

			if var_515_0 <= arg_512_1.time_ and arg_512_1.time_ < var_515_0 + var_515_8 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_0) / var_515_8

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_0 + var_515_8 and arg_512_1.time_ < var_515_0 + var_515_8 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play1102002118 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 1102002118
		arg_516_1.duration_ = 7.17

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play1102002119(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 2

			if var_519_0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_0 + arg_519_0 then
				local var_519_1 = manager.ui.mainCamera.transform.localPosition
				local var_519_2 = Vector3.New(0, 0, 10) + Vector3.New(var_519_1.x, var_519_1.y, 0)
				local var_519_3 = arg_516_1.bgs_.STblack

				var_519_3.transform.localPosition = var_519_2
				var_519_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_519_4 = var_519_3:GetComponent("SpriteRenderer")

				if var_519_4 and var_519_4.sprite then
					local var_519_5 = (var_519_3.transform.localPosition - var_519_1).z
					local var_519_6 = manager.ui.mainCameraCom_
					local var_519_7 = 2 * var_519_5 * Mathf.Tan(var_519_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_519_8 = var_519_7 * var_519_6.aspect
					local var_519_9 = var_519_4.sprite.bounds.size.x
					local var_519_10 = var_519_4.sprite.bounds.size.y
					local var_519_11 = var_519_8 / var_519_9
					local var_519_12 = var_519_7 / var_519_10
					local var_519_13 = var_519_12 < var_519_11 and var_519_11 or var_519_12

					var_519_3.transform.localScale = Vector3.New(var_519_13, var_519_13, 0)
				end

				for iter_519_0, iter_519_1 in pairs(arg_516_1.bgs_) do
					if iter_519_0 ~= "STblack" then
						iter_519_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_519_14 = 3.999999999999

			if var_519_14 < arg_516_1.time_ and arg_516_1.time_ <= var_519_14 + arg_519_0 then
				arg_516_1.allBtn_.enabled = false
			end

			local var_519_15 = 0.3

			if arg_516_1.time_ >= var_519_14 + var_519_15 and arg_516_1.time_ < var_519_14 + var_519_15 + arg_519_0 then
				arg_516_1.allBtn_.enabled = true
			end

			local var_519_16 = 0

			if var_519_16 < arg_516_1.time_ and arg_516_1.time_ <= var_519_16 + arg_519_0 then
				arg_516_1.mask_.enabled = true
				arg_516_1.mask_.raycastTarget = true

				arg_516_1:SetGaussion(false)
			end

			local var_519_17 = 2

			if var_519_16 <= arg_516_1.time_ and arg_516_1.time_ < var_519_16 + var_519_17 then
				local var_519_18 = (arg_516_1.time_ - var_519_16) / var_519_17
				local var_519_19 = Color.New(0, 0, 0)

				var_519_19.a = Mathf.Lerp(0, 1, var_519_18)
				arg_516_1.mask_.color = var_519_19
			end

			if arg_516_1.time_ >= var_519_16 + var_519_17 and arg_516_1.time_ < var_519_16 + var_519_17 + arg_519_0 then
				local var_519_20 = Color.New(0, 0, 0)

				var_519_20.a = 1
				arg_516_1.mask_.color = var_519_20
			end

			local var_519_21 = 2

			if var_519_21 < arg_516_1.time_ and arg_516_1.time_ <= var_519_21 + arg_519_0 then
				arg_516_1.mask_.enabled = true
				arg_516_1.mask_.raycastTarget = true

				arg_516_1:SetGaussion(false)
			end

			local var_519_22 = 2

			if var_519_21 <= arg_516_1.time_ and arg_516_1.time_ < var_519_21 + var_519_22 then
				local var_519_23 = (arg_516_1.time_ - var_519_21) / var_519_22
				local var_519_24 = Color.New(0, 0, 0)

				var_519_24.a = Mathf.Lerp(1, 0, var_519_23)
				arg_516_1.mask_.color = var_519_24
			end

			if arg_516_1.time_ >= var_519_21 + var_519_22 and arg_516_1.time_ < var_519_21 + var_519_22 + arg_519_0 then
				local var_519_25 = Color.New(0, 0, 0)
				local var_519_26 = 0

				arg_516_1.mask_.enabled = false
				var_519_25.a = var_519_26
				arg_516_1.mask_.color = var_519_25
			end

			local var_519_27 = arg_516_1.actors_["1020ui_story"]
			local var_519_28 = 4

			if var_519_28 < arg_516_1.time_ and arg_516_1.time_ <= var_519_28 + arg_519_0 and not isNil(var_519_27) and arg_516_1.var_.characterEffect1020ui_story == nil then
				arg_516_1.var_.characterEffect1020ui_story = var_519_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_29 = 0.200000002980232

			if var_519_28 <= arg_516_1.time_ and arg_516_1.time_ < var_519_28 + var_519_29 and not isNil(var_519_27) then
				local var_519_30 = (arg_516_1.time_ - var_519_28) / var_519_29

				if arg_516_1.var_.characterEffect1020ui_story and not isNil(var_519_27) then
					arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= var_519_28 + var_519_29 and arg_516_1.time_ < var_519_28 + var_519_29 + arg_519_0 and not isNil(var_519_27) and arg_516_1.var_.characterEffect1020ui_story then
				arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_519_31 = arg_516_1.actors_["1020ui_story"].transform
			local var_519_32 = 3.9

			if var_519_32 < arg_516_1.time_ and arg_516_1.time_ <= var_519_32 + arg_519_0 then
				arg_516_1.var_.moveOldPos1020ui_story = var_519_31.localPosition
			end

			local var_519_33 = 0.001

			if var_519_32 <= arg_516_1.time_ and arg_516_1.time_ < var_519_32 + var_519_33 then
				local var_519_34 = (arg_516_1.time_ - var_519_32) / var_519_33
				local var_519_35 = Vector3.New(0, -0.85, -6.25)

				var_519_31.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1020ui_story, var_519_35, var_519_34)

				local var_519_36 = manager.ui.mainCamera.transform.position - var_519_31.position

				var_519_31.forward = Vector3.New(var_519_36.x, var_519_36.y, var_519_36.z)

				local var_519_37 = var_519_31.localEulerAngles

				var_519_37.z = 0
				var_519_37.x = 0
				var_519_31.localEulerAngles = var_519_37
			end

			if arg_516_1.time_ >= var_519_32 + var_519_33 and arg_516_1.time_ < var_519_32 + var_519_33 + arg_519_0 then
				var_519_31.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_519_38 = manager.ui.mainCamera.transform.position - var_519_31.position

				var_519_31.forward = Vector3.New(var_519_38.x, var_519_38.y, var_519_38.z)

				local var_519_39 = var_519_31.localEulerAngles

				var_519_39.z = 0
				var_519_39.x = 0
				var_519_31.localEulerAngles = var_519_39
			end

			local var_519_40 = 3.9

			if var_519_40 < arg_516_1.time_ and arg_516_1.time_ <= var_519_40 + arg_519_0 then
				arg_516_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_519_41 = 3.9

			if var_519_41 < arg_516_1.time_ and arg_516_1.time_ <= var_519_41 + arg_519_0 then
				arg_516_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_519_42 = arg_516_1.actors_["1020ui_story"]
			local var_519_43 = 3.9

			if var_519_43 < arg_516_1.time_ and arg_516_1.time_ <= var_519_43 + arg_519_0 and not isNil(var_519_42) and arg_516_1.var_.characterEffect1020ui_story == nil then
				arg_516_1.var_.characterEffect1020ui_story = var_519_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_44 = 0.2

			if var_519_43 <= arg_516_1.time_ and arg_516_1.time_ < var_519_43 + var_519_44 and not isNil(var_519_42) then
				local var_519_45 = (arg_516_1.time_ - var_519_43) / var_519_44

				if arg_516_1.var_.characterEffect1020ui_story and not isNil(var_519_42) then
					arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= var_519_43 + var_519_44 and arg_516_1.time_ < var_519_43 + var_519_44 + arg_519_0 and not isNil(var_519_42) and arg_516_1.var_.characterEffect1020ui_story then
				arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if arg_516_1.frameCnt_ <= 1 then
				arg_516_1.dialog_:SetActive(false)
			end

			local var_519_46 = 4
			local var_519_47 = 0.375

			if var_519_46 < arg_516_1.time_ and arg_516_1.time_ <= var_519_46 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0

				arg_516_1.dialog_:SetActive(true)

				arg_516_1.dialogCg_.alpha = 0

				local var_519_48 = LeanTween.value(arg_516_1.dialog_, 0, 1, 0.3)

				var_519_48:setOnUpdate(LuaHelper.FloatAction(function(arg_520_0)
					arg_516_1.dialogCg_.alpha = arg_520_0
				end))
				var_519_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_516_1.dialog_)
					var_519_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_516_1.duration_ = arg_516_1.duration_ + 0.3

				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_49 = arg_516_1:FormatText(StoryNameCfg[613].name)

				arg_516_1.leftNameTxt_.text = var_519_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_50 = arg_516_1:GetWordFromCfg(1102002118)
				local var_519_51 = arg_516_1:FormatText(var_519_50.content)

				arg_516_1.text_.text = var_519_51

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_52 = 15
				local var_519_53 = utf8.len(var_519_51)
				local var_519_54 = var_519_52 <= 0 and var_519_47 or var_519_47 * (var_519_53 / var_519_52)

				if var_519_54 > 0 and var_519_47 < var_519_54 then
					arg_516_1.talkMaxDuration = var_519_54
					var_519_46 = var_519_46 + 0.3

					if var_519_54 + var_519_46 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_54 + var_519_46
					end
				end

				arg_516_1.text_.text = var_519_51
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002118", "story_v_side_new_1102002.awb") ~= 0 then
					local var_519_55 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002118", "story_v_side_new_1102002.awb") / 1000

					if var_519_55 + var_519_46 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_55 + var_519_46
					end

					if var_519_50.prefab_name ~= "" and arg_516_1.actors_[var_519_50.prefab_name] ~= nil then
						local var_519_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_50.prefab_name].transform, "story_v_side_new_1102002", "1102002118", "story_v_side_new_1102002.awb")

						arg_516_1:RecordAudio("1102002118", var_519_56)
						arg_516_1:RecordAudio("1102002118", var_519_56)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002118", "story_v_side_new_1102002.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002118", "story_v_side_new_1102002.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_57 = var_519_46 + 0.3
			local var_519_58 = math.max(var_519_47, arg_516_1.talkMaxDuration)

			if var_519_57 <= arg_516_1.time_ and arg_516_1.time_ < var_519_57 + var_519_58 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_57) / var_519_58

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_57 + var_519_58 and arg_516_1.time_ < var_519_57 + var_519_58 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play1102002119 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 1102002119
		arg_522_1.duration_ = 9

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play1102002120(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = 2

			if var_525_0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_0 + arg_525_0 then
				local var_525_1 = manager.ui.mainCamera.transform.localPosition
				local var_525_2 = Vector3.New(0, 0, 10) + Vector3.New(var_525_1.x, var_525_1.y, 0)
				local var_525_3 = arg_522_1.bgs_.ST12

				var_525_3.transform.localPosition = var_525_2
				var_525_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_525_4 = var_525_3:GetComponent("SpriteRenderer")

				if var_525_4 and var_525_4.sprite then
					local var_525_5 = (var_525_3.transform.localPosition - var_525_1).z
					local var_525_6 = manager.ui.mainCameraCom_
					local var_525_7 = 2 * var_525_5 * Mathf.Tan(var_525_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_525_8 = var_525_7 * var_525_6.aspect
					local var_525_9 = var_525_4.sprite.bounds.size.x
					local var_525_10 = var_525_4.sprite.bounds.size.y
					local var_525_11 = var_525_8 / var_525_9
					local var_525_12 = var_525_7 / var_525_10
					local var_525_13 = var_525_12 < var_525_11 and var_525_11 or var_525_12

					var_525_3.transform.localScale = Vector3.New(var_525_13, var_525_13, 0)
				end

				for iter_525_0, iter_525_1 in pairs(arg_522_1.bgs_) do
					if iter_525_0 ~= "ST12" then
						iter_525_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_525_14 = 4

			if var_525_14 < arg_522_1.time_ and arg_522_1.time_ <= var_525_14 + arg_525_0 then
				arg_522_1.allBtn_.enabled = false
			end

			local var_525_15 = 0.3

			if arg_522_1.time_ >= var_525_14 + var_525_15 and arg_522_1.time_ < var_525_14 + var_525_15 + arg_525_0 then
				arg_522_1.allBtn_.enabled = true
			end

			local var_525_16 = 0

			if var_525_16 < arg_522_1.time_ and arg_522_1.time_ <= var_525_16 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_17 = 2

			if var_525_16 <= arg_522_1.time_ and arg_522_1.time_ < var_525_16 + var_525_17 then
				local var_525_18 = (arg_522_1.time_ - var_525_16) / var_525_17
				local var_525_19 = Color.New(0, 0, 0)

				var_525_19.a = Mathf.Lerp(0, 1, var_525_18)
				arg_522_1.mask_.color = var_525_19
			end

			if arg_522_1.time_ >= var_525_16 + var_525_17 and arg_522_1.time_ < var_525_16 + var_525_17 + arg_525_0 then
				local var_525_20 = Color.New(0, 0, 0)

				var_525_20.a = 1
				arg_522_1.mask_.color = var_525_20
			end

			local var_525_21 = 2

			if var_525_21 < arg_522_1.time_ and arg_522_1.time_ <= var_525_21 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_22 = 2

			if var_525_21 <= arg_522_1.time_ and arg_522_1.time_ < var_525_21 + var_525_22 then
				local var_525_23 = (arg_522_1.time_ - var_525_21) / var_525_22
				local var_525_24 = Color.New(0, 0, 0)

				var_525_24.a = Mathf.Lerp(1, 0, var_525_23)
				arg_522_1.mask_.color = var_525_24
			end

			if arg_522_1.time_ >= var_525_21 + var_525_22 and arg_522_1.time_ < var_525_21 + var_525_22 + arg_525_0 then
				local var_525_25 = Color.New(0, 0, 0)
				local var_525_26 = 0

				arg_522_1.mask_.enabled = false
				var_525_25.a = var_525_26
				arg_522_1.mask_.color = var_525_25
			end

			local var_525_27 = arg_522_1.actors_["1020ui_story"]
			local var_525_28 = 4

			if var_525_28 < arg_522_1.time_ and arg_522_1.time_ <= var_525_28 + arg_525_0 and not isNil(var_525_27) and arg_522_1.var_.characterEffect1020ui_story == nil then
				arg_522_1.var_.characterEffect1020ui_story = var_525_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_29 = 0.200000002980232

			if var_525_28 <= arg_522_1.time_ and arg_522_1.time_ < var_525_28 + var_525_29 and not isNil(var_525_27) then
				local var_525_30 = (arg_522_1.time_ - var_525_28) / var_525_29

				if arg_522_1.var_.characterEffect1020ui_story and not isNil(var_525_27) then
					local var_525_31 = Mathf.Lerp(0, 0.5, var_525_30)

					arg_522_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_522_1.var_.characterEffect1020ui_story.fillRatio = var_525_31
				end
			end

			if arg_522_1.time_ >= var_525_28 + var_525_29 and arg_522_1.time_ < var_525_28 + var_525_29 + arg_525_0 and not isNil(var_525_27) and arg_522_1.var_.characterEffect1020ui_story then
				local var_525_32 = 0.5

				arg_522_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_522_1.var_.characterEffect1020ui_story.fillRatio = var_525_32
			end

			local var_525_33 = arg_522_1.actors_["1020ui_story"].transform
			local var_525_34 = 1.966

			if var_525_34 < arg_522_1.time_ and arg_522_1.time_ <= var_525_34 + arg_525_0 then
				arg_522_1.var_.moveOldPos1020ui_story = var_525_33.localPosition
			end

			local var_525_35 = 0.001

			if var_525_34 <= arg_522_1.time_ and arg_522_1.time_ < var_525_34 + var_525_35 then
				local var_525_36 = (arg_522_1.time_ - var_525_34) / var_525_35
				local var_525_37 = Vector3.New(0, 100, 0)

				var_525_33.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos1020ui_story, var_525_37, var_525_36)

				local var_525_38 = manager.ui.mainCamera.transform.position - var_525_33.position

				var_525_33.forward = Vector3.New(var_525_38.x, var_525_38.y, var_525_38.z)

				local var_525_39 = var_525_33.localEulerAngles

				var_525_39.z = 0
				var_525_39.x = 0
				var_525_33.localEulerAngles = var_525_39
			end

			if arg_522_1.time_ >= var_525_34 + var_525_35 and arg_522_1.time_ < var_525_34 + var_525_35 + arg_525_0 then
				var_525_33.localPosition = Vector3.New(0, 100, 0)

				local var_525_40 = manager.ui.mainCamera.transform.position - var_525_33.position

				var_525_33.forward = Vector3.New(var_525_40.x, var_525_40.y, var_525_40.z)

				local var_525_41 = var_525_33.localEulerAngles

				var_525_41.z = 0
				var_525_41.x = 0
				var_525_33.localEulerAngles = var_525_41
			end

			if arg_522_1.frameCnt_ <= 1 then
				arg_522_1.dialog_:SetActive(false)
			end

			local var_525_42 = 4
			local var_525_43 = 0.55

			if var_525_42 < arg_522_1.time_ and arg_522_1.time_ <= var_525_42 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0

				arg_522_1.dialog_:SetActive(true)

				arg_522_1.dialogCg_.alpha = 0

				local var_525_44 = LeanTween.value(arg_522_1.dialog_, 0, 1, 0.3)

				var_525_44:setOnUpdate(LuaHelper.FloatAction(function(arg_526_0)
					arg_522_1.dialogCg_.alpha = arg_526_0
				end))
				var_525_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_522_1.dialog_)
					var_525_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_522_1.duration_ = arg_522_1.duration_ + 0.3

				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_45 = arg_522_1:FormatText(StoryNameCfg[7].name)

				arg_522_1.leftNameTxt_.text = var_525_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_522_1.callingController_:SetSelectedState("normal")

				arg_522_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_522_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_525_46 = arg_522_1:GetWordFromCfg(1102002119)
				local var_525_47 = arg_522_1:FormatText(var_525_46.content)

				arg_522_1.text_.text = var_525_47

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_48 = 22
				local var_525_49 = utf8.len(var_525_47)
				local var_525_50 = var_525_48 <= 0 and var_525_43 or var_525_43 * (var_525_49 / var_525_48)

				if var_525_50 > 0 and var_525_43 < var_525_50 then
					arg_522_1.talkMaxDuration = var_525_50
					var_525_42 = var_525_42 + 0.3

					if var_525_50 + var_525_42 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_50 + var_525_42
					end
				end

				arg_522_1.text_.text = var_525_47
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_51 = var_525_42 + 0.3
			local var_525_52 = math.max(var_525_43, arg_522_1.talkMaxDuration)

			if var_525_51 <= arg_522_1.time_ and arg_522_1.time_ < var_525_51 + var_525_52 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_51) / var_525_52

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_51 + var_525_52 and arg_522_1.time_ < var_525_51 + var_525_52 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_522_1:InitPlayNodeList()
	end,
	Play1102002120 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1102002120
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1102002121(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0
			local var_531_1 = 1.4

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_2 = arg_528_1:FormatText(StoryNameCfg[7].name)

				arg_528_1.leftNameTxt_.text = var_531_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, true)
				arg_528_1.iconController_:SetSelectedState("hero")

				arg_528_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_528_1.callingController_:SetSelectedState("normal")

				arg_528_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_528_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_531_3 = arg_528_1:GetWordFromCfg(1102002120)
				local var_531_4 = arg_528_1:FormatText(var_531_3.content)

				arg_528_1.text_.text = var_531_4

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_5 = 56
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
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_8 = math.max(var_531_1, arg_528_1.talkMaxDuration)

			if var_531_0 <= arg_528_1.time_ and arg_528_1.time_ < var_531_0 + var_531_8 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_0) / var_531_8

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_0 + var_531_8 and arg_528_1.time_ < var_531_0 + var_531_8 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play1102002121 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1102002121
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1102002122(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 0.6

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_2 = arg_532_1:FormatText(StoryNameCfg[7].name)

				arg_532_1.leftNameTxt_.text = var_535_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_532_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_535_3 = arg_532_1:GetWordFromCfg(1102002121)
				local var_535_4 = arg_532_1:FormatText(var_535_3.content)

				arg_532_1.text_.text = var_535_4

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 24
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
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_8 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_8 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_8

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_8 and arg_532_1.time_ < var_535_0 + var_535_8 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1102002122 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1102002122
		arg_536_1.duration_ = 9

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1102002123(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 2

			if var_539_0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_0 + arg_539_0 then
				local var_539_1 = manager.ui.mainCamera.transform.localPosition
				local var_539_2 = Vector3.New(0, 0, 10) + Vector3.New(var_539_1.x, var_539_1.y, 0)
				local var_539_3 = arg_536_1.bgs_.ST0505

				var_539_3.transform.localPosition = var_539_2
				var_539_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_539_4 = var_539_3:GetComponent("SpriteRenderer")

				if var_539_4 and var_539_4.sprite then
					local var_539_5 = (var_539_3.transform.localPosition - var_539_1).z
					local var_539_6 = manager.ui.mainCameraCom_
					local var_539_7 = 2 * var_539_5 * Mathf.Tan(var_539_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_539_8 = var_539_7 * var_539_6.aspect
					local var_539_9 = var_539_4.sprite.bounds.size.x
					local var_539_10 = var_539_4.sprite.bounds.size.y
					local var_539_11 = var_539_8 / var_539_9
					local var_539_12 = var_539_7 / var_539_10
					local var_539_13 = var_539_12 < var_539_11 and var_539_11 or var_539_12

					var_539_3.transform.localScale = Vector3.New(var_539_13, var_539_13, 0)
				end

				for iter_539_0, iter_539_1 in pairs(arg_536_1.bgs_) do
					if iter_539_0 ~= "ST0505" then
						iter_539_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_539_14 = 4

			if var_539_14 < arg_536_1.time_ and arg_536_1.time_ <= var_539_14 + arg_539_0 then
				arg_536_1.allBtn_.enabled = false
			end

			local var_539_15 = 0.3

			if arg_536_1.time_ >= var_539_14 + var_539_15 and arg_536_1.time_ < var_539_14 + var_539_15 + arg_539_0 then
				arg_536_1.allBtn_.enabled = true
			end

			local var_539_16 = 0

			if var_539_16 < arg_536_1.time_ and arg_536_1.time_ <= var_539_16 + arg_539_0 then
				arg_536_1.mask_.enabled = true
				arg_536_1.mask_.raycastTarget = true

				arg_536_1:SetGaussion(false)
			end

			local var_539_17 = 2

			if var_539_16 <= arg_536_1.time_ and arg_536_1.time_ < var_539_16 + var_539_17 then
				local var_539_18 = (arg_536_1.time_ - var_539_16) / var_539_17
				local var_539_19 = Color.New(0, 0, 0)

				var_539_19.a = Mathf.Lerp(0, 1, var_539_18)
				arg_536_1.mask_.color = var_539_19
			end

			if arg_536_1.time_ >= var_539_16 + var_539_17 and arg_536_1.time_ < var_539_16 + var_539_17 + arg_539_0 then
				local var_539_20 = Color.New(0, 0, 0)

				var_539_20.a = 1
				arg_536_1.mask_.color = var_539_20
			end

			local var_539_21 = 2

			if var_539_21 < arg_536_1.time_ and arg_536_1.time_ <= var_539_21 + arg_539_0 then
				arg_536_1.mask_.enabled = true
				arg_536_1.mask_.raycastTarget = true

				arg_536_1:SetGaussion(false)
			end

			local var_539_22 = 2

			if var_539_21 <= arg_536_1.time_ and arg_536_1.time_ < var_539_21 + var_539_22 then
				local var_539_23 = (arg_536_1.time_ - var_539_21) / var_539_22
				local var_539_24 = Color.New(0, 0, 0)

				var_539_24.a = Mathf.Lerp(1, 0, var_539_23)
				arg_536_1.mask_.color = var_539_24
			end

			if arg_536_1.time_ >= var_539_21 + var_539_22 and arg_536_1.time_ < var_539_21 + var_539_22 + arg_539_0 then
				local var_539_25 = Color.New(0, 0, 0)
				local var_539_26 = 0

				arg_536_1.mask_.enabled = false
				var_539_25.a = var_539_26
				arg_536_1.mask_.color = var_539_25
			end

			local var_539_27 = 2

			arg_536_1.isInRecall_ = false

			if var_539_27 < arg_536_1.time_ and arg_536_1.time_ <= var_539_27 + arg_539_0 then
				arg_536_1.screenFilterGo_:SetActive(false)

				for iter_539_2, iter_539_3 in pairs(arg_536_1.actors_) do
					local var_539_28 = iter_539_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_539_4, iter_539_5 in ipairs(var_539_28) do
						if iter_539_5.color.r > 0.51 then
							iter_539_5.color = Color.New(1, 1, 1)
						else
							iter_539_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_539_29 = 0.1

			if var_539_27 <= arg_536_1.time_ and arg_536_1.time_ < var_539_27 + var_539_29 then
				local var_539_30 = (arg_536_1.time_ - var_539_27) / var_539_29

				arg_536_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_539_30)
			end

			if arg_536_1.time_ >= var_539_27 + var_539_29 and arg_536_1.time_ < var_539_27 + var_539_29 + arg_539_0 then
				arg_536_1.screenFilterEffect_.weight = 0
			end

			local var_539_31 = 0.125
			local var_539_32 = 1

			if var_539_31 < arg_536_1.time_ and arg_536_1.time_ <= var_539_31 + arg_539_0 then
				local var_539_33 = "stop"
				local var_539_34 = "effect"

				arg_536_1:AudioAction(var_539_33, var_539_34, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_539_35 = 1.63333333333333
			local var_539_36 = 1

			if var_539_35 < arg_536_1.time_ and arg_536_1.time_ <= var_539_35 + arg_539_0 then
				local var_539_37 = "play"
				local var_539_38 = "effect"

				arg_536_1:AudioAction(var_539_37, var_539_38, "se_story_140", "se_story_140_amb_room02", "")
			end

			if arg_536_1.frameCnt_ <= 1 then
				arg_536_1.dialog_:SetActive(false)
			end

			local var_539_39 = 4
			local var_539_40 = 0.2

			if var_539_39 < arg_536_1.time_ and arg_536_1.time_ <= var_539_39 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0

				arg_536_1.dialog_:SetActive(true)

				arg_536_1.dialogCg_.alpha = 0

				local var_539_41 = LeanTween.value(arg_536_1.dialog_, 0, 1, 0.3)

				var_539_41:setOnUpdate(LuaHelper.FloatAction(function(arg_540_0)
					arg_536_1.dialogCg_.alpha = arg_540_0
				end))
				var_539_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_536_1.dialog_)
					var_539_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_536_1.duration_ = arg_536_1.duration_ + 0.3

				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_42 = arg_536_1:FormatText(StoryNameCfg[7].name)

				arg_536_1.leftNameTxt_.text = var_539_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_43 = arg_536_1:GetWordFromCfg(1102002122)
				local var_539_44 = arg_536_1:FormatText(var_539_43.content)

				arg_536_1.text_.text = var_539_44

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_45 = 8
				local var_539_46 = utf8.len(var_539_44)
				local var_539_47 = var_539_45 <= 0 and var_539_40 or var_539_40 * (var_539_46 / var_539_45)

				if var_539_47 > 0 and var_539_40 < var_539_47 then
					arg_536_1.talkMaxDuration = var_539_47
					var_539_39 = var_539_39 + 0.3

					if var_539_47 + var_539_39 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_47 + var_539_39
					end
				end

				arg_536_1.text_.text = var_539_44
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_48 = var_539_39 + 0.3
			local var_539_49 = math.max(var_539_40, arg_536_1.talkMaxDuration)

			if var_539_48 <= arg_536_1.time_ and arg_536_1.time_ < var_539_48 + var_539_49 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_48) / var_539_49

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_48 + var_539_49 and arg_536_1.time_ < var_539_48 + var_539_49 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play1102002123 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 1102002123
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play1102002124(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0
			local var_545_1 = 0.7

			if var_545_0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, false)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_2 = arg_542_1:GetWordFromCfg(1102002123)
				local var_545_3 = arg_542_1:FormatText(var_545_2.content)

				arg_542_1.text_.text = var_545_3

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_4 = 28
				local var_545_5 = utf8.len(var_545_3)
				local var_545_6 = var_545_4 <= 0 and var_545_1 or var_545_1 * (var_545_5 / var_545_4)

				if var_545_6 > 0 and var_545_1 < var_545_6 then
					arg_542_1.talkMaxDuration = var_545_6

					if var_545_6 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_6 + var_545_0
					end
				end

				arg_542_1.text_.text = var_545_3
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_7 = math.max(var_545_1, arg_542_1.talkMaxDuration)

			if var_545_0 <= arg_542_1.time_ and arg_542_1.time_ < var_545_0 + var_545_7 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_0) / var_545_7

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_0 + var_545_7 and arg_542_1.time_ < var_545_0 + var_545_7 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play1102002124 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 1102002124
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play1102002125(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0
			local var_549_1 = 0.2

			if var_549_0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_0 + arg_549_0 then
				local var_549_2 = "play"
				local var_549_3 = "music"

				arg_546_1:AudioAction(var_549_2, var_549_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_549_4 = ""
				local var_549_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_549_5 ~= "" then
					if arg_546_1.bgmTxt_.text ~= var_549_5 and arg_546_1.bgmTxt_.text ~= "" then
						if arg_546_1.bgmTxt2_.text ~= "" then
							arg_546_1.bgmTxt_.text = arg_546_1.bgmTxt2_.text
						end

						arg_546_1.bgmTxt2_.text = var_549_5

						arg_546_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_546_1.bgmTxt_.text = var_549_5
						arg_546_1.bgmTxt2_.text = var_549_5
					end

					if arg_546_1.bgmTimer then
						arg_546_1.bgmTimer:Stop()

						arg_546_1.bgmTimer = nil
					end

					if arg_546_1.settingData.show_music_name == 1 then
						arg_546_1.musicController:SetSelectedState("show")
						arg_546_1.musicAnimator_:Play("open", 0, 0)

						if arg_546_1.settingData.music_time ~= 0 then
							arg_546_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_546_1.settingData.music_time), function()
								if arg_546_1 == nil or isNil(arg_546_1.bgmTxt_) then
									return
								end

								arg_546_1.musicController:SetSelectedState("hide")
								arg_546_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_549_6 = 0
			local var_549_7 = 1

			if var_549_6 < arg_546_1.time_ and arg_546_1.time_ <= var_549_6 + arg_549_0 then
				local var_549_8 = "play"
				local var_549_9 = "effect"

				arg_546_1:AudioAction(var_549_8, var_549_9, "se_story_141", "se_story_141_door", "")
			end

			local var_549_10 = 0
			local var_549_11 = 0.25

			if var_549_10 < arg_546_1.time_ and arg_546_1.time_ <= var_549_10 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				local var_549_12 = arg_546_1:FormatText(StoryNameCfg[7].name)

				arg_546_1.leftNameTxt_.text = var_549_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, true)
				arg_546_1.iconController_:SetSelectedState("hero")

				arg_546_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_546_1.callingController_:SetSelectedState("normal")

				arg_546_1.keyicon_.color = Color.New(1, 1, 1)
				arg_546_1.icon_.color = Color.New(1, 1, 1)

				local var_549_13 = arg_546_1:GetWordFromCfg(1102002124)
				local var_549_14 = arg_546_1:FormatText(var_549_13.content)

				arg_546_1.text_.text = var_549_14

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_15 = 10
				local var_549_16 = utf8.len(var_549_14)
				local var_549_17 = var_549_15 <= 0 and var_549_11 or var_549_11 * (var_549_16 / var_549_15)

				if var_549_17 > 0 and var_549_11 < var_549_17 then
					arg_546_1.talkMaxDuration = var_549_17

					if var_549_17 + var_549_10 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_17 + var_549_10
					end
				end

				arg_546_1.text_.text = var_549_14
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_18 = math.max(var_549_11, arg_546_1.talkMaxDuration)

			if var_549_10 <= arg_546_1.time_ and arg_546_1.time_ < var_549_10 + var_549_18 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_10) / var_549_18

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_10 + var_549_18 and arg_546_1.time_ < var_549_10 + var_549_18 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play1102002125 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1102002125
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1102002126(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0
			local var_554_1 = 1

			if var_554_0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_0 + arg_554_0 then
				local var_554_2 = "play"
				local var_554_3 = "effect"

				arg_551_1:AudioAction(var_554_2, var_554_3, "se_story_side_1068", "se_story_1068_footstep", "")
			end

			local var_554_4 = 0
			local var_554_5 = 0.425

			if var_554_4 < arg_551_1.time_ and arg_551_1.time_ <= var_554_4 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, false)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_6 = arg_551_1:GetWordFromCfg(1102002125)
				local var_554_7 = arg_551_1:FormatText(var_554_6.content)

				arg_551_1.text_.text = var_554_7

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_8 = 17
				local var_554_9 = utf8.len(var_554_7)
				local var_554_10 = var_554_8 <= 0 and var_554_5 or var_554_5 * (var_554_9 / var_554_8)

				if var_554_10 > 0 and var_554_5 < var_554_10 then
					arg_551_1.talkMaxDuration = var_554_10

					if var_554_10 + var_554_4 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_10 + var_554_4
					end
				end

				arg_551_1.text_.text = var_554_7
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_11 = math.max(var_554_5, arg_551_1.talkMaxDuration)

			if var_554_4 <= arg_551_1.time_ and arg_551_1.time_ < var_554_4 + var_554_11 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_4) / var_554_11

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_4 + var_554_11 and arg_551_1.time_ < var_554_4 + var_554_11 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play1102002126 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1102002126
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1102002127(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0
			local var_558_1 = 0.45

			if var_558_0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_2 = arg_555_1:GetWordFromCfg(1102002126)
				local var_558_3 = arg_555_1:FormatText(var_558_2.content)

				arg_555_1.text_.text = var_558_3

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_4 = 18
				local var_558_5 = utf8.len(var_558_3)
				local var_558_6 = var_558_4 <= 0 and var_558_1 or var_558_1 * (var_558_5 / var_558_4)

				if var_558_6 > 0 and var_558_1 < var_558_6 then
					arg_555_1.talkMaxDuration = var_558_6

					if var_558_6 + var_558_0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_6 + var_558_0
					end
				end

				arg_555_1.text_.text = var_558_3
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_7 = math.max(var_558_1, arg_555_1.talkMaxDuration)

			if var_558_0 <= arg_555_1.time_ and arg_555_1.time_ < var_558_0 + var_558_7 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_0) / var_558_7

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_0 + var_558_7 and arg_555_1.time_ < var_558_0 + var_558_7 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play1102002127 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1102002127
		arg_559_1.duration_ = 5.47

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1102002128(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = arg_559_1.actors_["1020ui_story"].transform
			local var_562_1 = 0

			if var_562_1 < arg_559_1.time_ and arg_559_1.time_ <= var_562_1 + arg_562_0 then
				arg_559_1.var_.moveOldPos1020ui_story = var_562_0.localPosition
			end

			local var_562_2 = 0.001

			if var_562_1 <= arg_559_1.time_ and arg_559_1.time_ < var_562_1 + var_562_2 then
				local var_562_3 = (arg_559_1.time_ - var_562_1) / var_562_2
				local var_562_4 = Vector3.New(0, -0.85, -6.25)

				var_562_0.localPosition = Vector3.Lerp(arg_559_1.var_.moveOldPos1020ui_story, var_562_4, var_562_3)

				local var_562_5 = manager.ui.mainCamera.transform.position - var_562_0.position

				var_562_0.forward = Vector3.New(var_562_5.x, var_562_5.y, var_562_5.z)

				local var_562_6 = var_562_0.localEulerAngles

				var_562_6.z = 0
				var_562_6.x = 0
				var_562_0.localEulerAngles = var_562_6
			end

			if arg_559_1.time_ >= var_562_1 + var_562_2 and arg_559_1.time_ < var_562_1 + var_562_2 + arg_562_0 then
				var_562_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_562_7 = manager.ui.mainCamera.transform.position - var_562_0.position

				var_562_0.forward = Vector3.New(var_562_7.x, var_562_7.y, var_562_7.z)

				local var_562_8 = var_562_0.localEulerAngles

				var_562_8.z = 0
				var_562_8.x = 0
				var_562_0.localEulerAngles = var_562_8
			end

			local var_562_9 = arg_559_1.actors_["1020ui_story"]
			local var_562_10 = 0

			if var_562_10 < arg_559_1.time_ and arg_559_1.time_ <= var_562_10 + arg_562_0 and not isNil(var_562_9) and arg_559_1.var_.characterEffect1020ui_story == nil then
				arg_559_1.var_.characterEffect1020ui_story = var_562_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_11 = 0.200000002980232

			if var_562_10 <= arg_559_1.time_ and arg_559_1.time_ < var_562_10 + var_562_11 and not isNil(var_562_9) then
				local var_562_12 = (arg_559_1.time_ - var_562_10) / var_562_11

				if arg_559_1.var_.characterEffect1020ui_story and not isNil(var_562_9) then
					arg_559_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_559_1.time_ >= var_562_10 + var_562_11 and arg_559_1.time_ < var_562_10 + var_562_11 + arg_562_0 and not isNil(var_562_9) and arg_559_1.var_.characterEffect1020ui_story then
				arg_559_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_562_13 = 0

			if var_562_13 < arg_559_1.time_ and arg_559_1.time_ <= var_562_13 + arg_562_0 then
				arg_559_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_562_14 = 0

			if var_562_14 < arg_559_1.time_ and arg_559_1.time_ <= var_562_14 + arg_562_0 then
				arg_559_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_562_15 = 0
			local var_562_16 = 0.6

			if var_562_15 < arg_559_1.time_ and arg_559_1.time_ <= var_562_15 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				local var_562_17 = arg_559_1:FormatText(StoryNameCfg[613].name)

				arg_559_1.leftNameTxt_.text = var_562_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_18 = arg_559_1:GetWordFromCfg(1102002127)
				local var_562_19 = arg_559_1:FormatText(var_562_18.content)

				arg_559_1.text_.text = var_562_19

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_20 = 24
				local var_562_21 = utf8.len(var_562_19)
				local var_562_22 = var_562_20 <= 0 and var_562_16 or var_562_16 * (var_562_21 / var_562_20)

				if var_562_22 > 0 and var_562_16 < var_562_22 then
					arg_559_1.talkMaxDuration = var_562_22

					if var_562_22 + var_562_15 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_22 + var_562_15
					end
				end

				arg_559_1.text_.text = var_562_19
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002127", "story_v_side_new_1102002.awb") ~= 0 then
					local var_562_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002127", "story_v_side_new_1102002.awb") / 1000

					if var_562_23 + var_562_15 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_23 + var_562_15
					end

					if var_562_18.prefab_name ~= "" and arg_559_1.actors_[var_562_18.prefab_name] ~= nil then
						local var_562_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_18.prefab_name].transform, "story_v_side_new_1102002", "1102002127", "story_v_side_new_1102002.awb")

						arg_559_1:RecordAudio("1102002127", var_562_24)
						arg_559_1:RecordAudio("1102002127", var_562_24)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002127", "story_v_side_new_1102002.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002127", "story_v_side_new_1102002.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_25 = math.max(var_562_16, arg_559_1.talkMaxDuration)

			if var_562_15 <= arg_559_1.time_ and arg_559_1.time_ < var_562_15 + var_562_25 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_15) / var_562_25

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_15 + var_562_25 and arg_559_1.time_ < var_562_15 + var_562_25 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_559_1:InitPlayNodeList()
	end,
	Play1102002128 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1102002128
		arg_563_1.duration_ = 4.17

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
			arg_563_1.auto_ = false
		end

		function arg_563_1.playNext_(arg_565_0)
			arg_563_1.onStoryFinished_()
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0

			if var_566_0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_0 + arg_566_0 then
				arg_563_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_566_1 = 0

			if var_566_1 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 then
				arg_563_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_566_2 = 0
			local var_566_3 = 0.275

			if var_566_2 < arg_563_1.time_ and arg_563_1.time_ <= var_566_2 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_4 = arg_563_1:FormatText(StoryNameCfg[613].name)

				arg_563_1.leftNameTxt_.text = var_566_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_5 = arg_563_1:GetWordFromCfg(1102002128)
				local var_566_6 = arg_563_1:FormatText(var_566_5.content)

				arg_563_1.text_.text = var_566_6

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_7 = 11
				local var_566_8 = utf8.len(var_566_6)
				local var_566_9 = var_566_7 <= 0 and var_566_3 or var_566_3 * (var_566_8 / var_566_7)

				if var_566_9 > 0 and var_566_3 < var_566_9 then
					arg_563_1.talkMaxDuration = var_566_9

					if var_566_9 + var_566_2 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_9 + var_566_2
					end
				end

				arg_563_1.text_.text = var_566_6
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002128", "story_v_side_new_1102002.awb") ~= 0 then
					local var_566_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002128", "story_v_side_new_1102002.awb") / 1000

					if var_566_10 + var_566_2 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_10 + var_566_2
					end

					if var_566_5.prefab_name ~= "" and arg_563_1.actors_[var_566_5.prefab_name] ~= nil then
						local var_566_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_5.prefab_name].transform, "story_v_side_new_1102002", "1102002128", "story_v_side_new_1102002.awb")

						arg_563_1:RecordAudio("1102002128", var_566_11)
						arg_563_1:RecordAudio("1102002128", var_566_11)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002128", "story_v_side_new_1102002.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002128", "story_v_side_new_1102002.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_12 = math.max(var_566_3, arg_563_1.talkMaxDuration)

			if var_566_2 <= arg_563_1.time_ and arg_563_1.time_ < var_566_2 + var_566_12 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_2) / var_566_12

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_2 + var_566_12 and arg_563_1.time_ < var_566_2 + var_566_12 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/ST0505",
		"TextureConfig/Background/L02h",
		"TextureConfig/Background/H03b",
		"TextureConfig/Background/H05",
		"TextureConfig/Background/H02",
		"TextureConfig/Background/H02a",
		"TextureConfig/Background/H04"
	},
	voices = {
		"story_v_side_new_1102002.awb"
	}
}
