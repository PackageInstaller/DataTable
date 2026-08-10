return {
	Play936041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 936041001
		arg_1_1.duration_ = 6.3

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play936041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "X206_i"

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
				local var_4_5 = arg_1_1.bgs_.X206_i

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
					if iter_4_0 ~= "X206_i" then
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

			local var_4_24 = "104402ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "104402ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "104402ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["104402ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos104402ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, -1, -5.93)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos104402ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1, -5.93)

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

			local var_4_40 = arg_1_1.actors_["104402ui_story"]
			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect104402ui_story == nil then
				arg_1_1.var_.characterEffect104402ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect104402ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect104402ui_story then
				arg_1_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			local var_4_45 = 1.8

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_4_46 = 0
			local var_4_47 = 0.3

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

			local var_4_52 = 0.3
			local var_4_53 = 1

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_54 = "play"
				local var_4_55 = "effect"

				arg_1_1:AudioAction(var_4_54, var_4_55, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_56 = 2
			local var_4_57 = 0.275

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_58 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_58:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[1367].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(936041001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 11
				local var_4_63 = utf8.len(var_4_61)
				local var_4_64 = var_4_62 <= 0 and var_4_57 or var_4_57 * (var_4_63 / var_4_62)

				if var_4_64 > 0 and var_4_57 < var_4_64 then
					arg_1_1.talkMaxDuration = var_4_64
					var_4_56 = var_4_56 + 0.3

					if var_4_64 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_56
					end
				end

				arg_1_1.text_.text = var_4_61
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041001", "story_v_side_old_936041.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041001", "story_v_side_old_936041.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_side_old_936041", "936041001", "story_v_side_old_936041.awb")

						arg_1_1:RecordAudio("936041001", var_4_66)
						arg_1_1:RecordAudio("936041001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041001", "story_v_side_old_936041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041001", "story_v_side_old_936041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_67 = var_4_56 + 0.3
			local var_4_68 = math.max(var_4_57, arg_1_1.talkMaxDuration)

			if var_4_67 <= arg_1_1.time_ and arg_1_1.time_ < var_4_67 + var_4_68 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_67) / var_4_68

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
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
	Play936041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 936041002
		arg_8_1.duration_ = 10.3

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play936041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			local var_11_1 = 0
			local var_11_2 = 1.175

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_3 = arg_8_1:FormatText(StoryNameCfg[1367].name)

				arg_8_1.leftNameTxt_.text = var_11_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_4 = arg_8_1:GetWordFromCfg(936041002)
				local var_11_5 = arg_8_1:FormatText(var_11_4.content)

				arg_8_1.text_.text = var_11_5

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_6 = 47
				local var_11_7 = utf8.len(var_11_5)
				local var_11_8 = var_11_6 <= 0 and var_11_2 or var_11_2 * (var_11_7 / var_11_6)

				if var_11_8 > 0 and var_11_2 < var_11_8 then
					arg_8_1.talkMaxDuration = var_11_8

					if var_11_8 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_5
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041002", "story_v_side_old_936041.awb") ~= 0 then
					local var_11_9 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041002", "story_v_side_old_936041.awb") / 1000

					if var_11_9 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_9 + var_11_1
					end

					if var_11_4.prefab_name ~= "" and arg_8_1.actors_[var_11_4.prefab_name] ~= nil then
						local var_11_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_4.prefab_name].transform, "story_v_side_old_936041", "936041002", "story_v_side_old_936041.awb")

						arg_8_1:RecordAudio("936041002", var_11_10)
						arg_8_1:RecordAudio("936041002", var_11_10)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041002", "story_v_side_old_936041.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041002", "story_v_side_old_936041.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_11 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_11 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_11

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_11 and arg_8_1.time_ < var_11_1 + var_11_11 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play936041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 936041003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play936041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["104402ui_story"].transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos104402ui_story = var_15_0.localPosition

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end
			end

			local var_15_3 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_3 then
				local var_15_4 = (arg_12_1.time_ - var_15_1) / var_15_3
				local var_15_5 = Vector3.New(0, 100, 0)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos104402ui_story, var_15_5, var_15_4)

				local var_15_6 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_6.x, var_15_6.y, var_15_6.z)

				local var_15_7 = var_15_0.localEulerAngles

				var_15_7.z = 0
				var_15_7.x = 0
				var_15_0.localEulerAngles = var_15_7
			end

			if arg_12_1.time_ >= var_15_1 + var_15_3 and arg_12_1.time_ < var_15_1 + var_15_3 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_15_11 = arg_12_1.actors_["104402ui_story"]
			local var_15_12 = 0

			if var_15_12 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 and not isNil(var_15_11) and arg_12_1.var_.characterEffect104402ui_story == nil then
				arg_12_1.var_.characterEffect104402ui_story = var_15_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_13 = 0.200000002980232

			if var_15_12 <= arg_12_1.time_ and arg_12_1.time_ < var_15_12 + var_15_13 and not isNil(var_15_11) then
				local var_15_14 = (arg_12_1.time_ - var_15_12) / var_15_13

				if arg_12_1.var_.characterEffect104402ui_story and not isNil(var_15_11) then
					local var_15_15 = Mathf.Lerp(0, 0.5, var_15_14)

					arg_12_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_12_1.var_.characterEffect104402ui_story.fillRatio = var_15_15
				end
			end

			if arg_12_1.time_ >= var_15_12 + var_15_13 and arg_12_1.time_ < var_15_12 + var_15_13 + arg_15_0 and not isNil(var_15_11) and arg_12_1.var_.characterEffect104402ui_story then
				local var_15_16 = 0.5

				arg_12_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_12_1.var_.characterEffect104402ui_story.fillRatio = var_15_16
			end

			local var_15_17 = 0
			local var_15_18 = 1.15

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_19 = arg_12_1:GetWordFromCfg(936041003)
				local var_15_20 = arg_12_1:FormatText(var_15_19.content)

				arg_12_1.text_.text = var_15_20

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_21 = 46
				local var_15_22 = utf8.len(var_15_20)
				local var_15_23 = var_15_21 <= 0 and var_15_18 or var_15_18 * (var_15_22 / var_15_21)

				if var_15_23 > 0 and var_15_18 < var_15_23 then
					arg_12_1.talkMaxDuration = var_15_23

					if var_15_23 + var_15_17 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_23 + var_15_17
					end
				end

				arg_12_1.text_.text = var_15_20
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_24 = math.max(var_15_18, arg_12_1.talkMaxDuration)

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_24 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_17) / var_15_24

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_17 + var_15_24 and arg_12_1.time_ < var_15_17 + var_15_24 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
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
	Play936041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 936041004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play936041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.05

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(936041004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 42
				local var_19_5 = utf8.len(var_19_3)
				local var_19_6 = var_19_4 <= 0 and var_19_1 or var_19_1 * (var_19_5 / var_19_4)

				if var_19_6 > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_7 and arg_16_1.time_ < var_19_0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play936041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 936041005
		arg_20_1.duration_ = 5.1

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play936041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["104402ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos104402ui_story = var_23_0.localPosition

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end
			end

			local var_23_3 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_3 then
				local var_23_4 = (arg_20_1.time_ - var_23_1) / var_23_3
				local var_23_5 = Vector3.New(0, -1, -5.93)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos104402ui_story, var_23_5, var_23_4)

				local var_23_6 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_6.x, var_23_6.y, var_23_6.z)

				local var_23_7 = var_23_0.localEulerAngles

				var_23_7.z = 0
				var_23_7.x = 0
				var_23_0.localEulerAngles = var_23_7
			end

			if arg_20_1.time_ >= var_23_1 + var_23_3 and arg_20_1.time_ < var_23_1 + var_23_3 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_23_8 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_8.x, var_23_8.y, var_23_8.z)

				local var_23_9 = var_23_0.localEulerAngles

				var_23_9.z = 0
				var_23_9.x = 0
				var_23_0.localEulerAngles = var_23_9

				local var_23_10 = GameObjectTools.GetOrAddComponent(var_23_0.gameObject, typeof(DynamicBoneHelper))

				if var_23_10 then
					var_23_10:EnableDynamicBone(true)
				end
			end

			local var_23_11 = arg_20_1.actors_["104402ui_story"]
			local var_23_12 = 0

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect104402ui_story == nil then
				arg_20_1.var_.characterEffect104402ui_story = var_23_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_13 = 0.200000002980232

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_13 and not isNil(var_23_11) then
				local var_23_14 = (arg_20_1.time_ - var_23_12) / var_23_13

				if arg_20_1.var_.characterEffect104402ui_story and not isNil(var_23_11) then
					arg_20_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_12 + var_23_13 and arg_20_1.time_ < var_23_12 + var_23_13 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect104402ui_story then
				arg_20_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_23_15 = 0

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action6_1")
			end

			local var_23_16 = 0

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_23_17 = 0
			local var_23_18 = 0.425

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_19 = arg_20_1:FormatText(StoryNameCfg[1367].name)

				arg_20_1.leftNameTxt_.text = var_23_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_20 = arg_20_1:GetWordFromCfg(936041005)
				local var_23_21 = arg_20_1:FormatText(var_23_20.content)

				arg_20_1.text_.text = var_23_21

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_22 = 17
				local var_23_23 = utf8.len(var_23_21)
				local var_23_24 = var_23_22 <= 0 and var_23_18 or var_23_18 * (var_23_23 / var_23_22)

				if var_23_24 > 0 and var_23_18 < var_23_24 then
					arg_20_1.talkMaxDuration = var_23_24

					if var_23_24 + var_23_17 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_24 + var_23_17
					end
				end

				arg_20_1.text_.text = var_23_21
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041005", "story_v_side_old_936041.awb") ~= 0 then
					local var_23_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041005", "story_v_side_old_936041.awb") / 1000

					if var_23_25 + var_23_17 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_25 + var_23_17
					end

					if var_23_20.prefab_name ~= "" and arg_20_1.actors_[var_23_20.prefab_name] ~= nil then
						local var_23_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_20.prefab_name].transform, "story_v_side_old_936041", "936041005", "story_v_side_old_936041.awb")

						arg_20_1:RecordAudio("936041005", var_23_26)
						arg_20_1:RecordAudio("936041005", var_23_26)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041005", "story_v_side_old_936041.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041005", "story_v_side_old_936041.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_27 = math.max(var_23_18, arg_20_1.talkMaxDuration)

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_27 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_17) / var_23_27

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_17 + var_23_27 and arg_20_1.time_ < var_23_17 + var_23_27 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play936041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 936041006
		arg_24_1.duration_ = 93

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play936041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["104402ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos104402ui_story = var_27_0.localPosition

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end
			end

			local var_27_3 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_3 then
				local var_27_4 = (arg_24_1.time_ - var_27_1) / var_27_3
				local var_27_5 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos104402ui_story, var_27_5, var_27_4)

				local var_27_6 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_6.x, var_27_6.y, var_27_6.z)

				local var_27_7 = var_27_0.localEulerAngles

				var_27_7.z = 0
				var_27_7.x = 0
				var_27_0.localEulerAngles = var_27_7
			end

			if arg_24_1.time_ >= var_27_1 + var_27_3 and arg_24_1.time_ < var_27_1 + var_27_3 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

				local var_27_8 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_8.x, var_27_8.y, var_27_8.z)

				local var_27_9 = var_27_0.localEulerAngles

				var_27_9.z = 0
				var_27_9.x = 0
				var_27_0.localEulerAngles = var_27_9

				local var_27_10 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_10 then
					var_27_10:EnableDynamicBone(true)
				end
			end

			local var_27_11 = "105401ui_story"

			if arg_24_1.actors_[var_27_11] == nil then
				local var_27_12 = Asset.Load("Char/" .. "105401ui_story")

				if not isNil(var_27_12) then
					local var_27_13 = Object.Instantiate(Asset.Load("Char/" .. "105401ui_story"), arg_24_1.stage_.transform)

					var_27_13.name = var_27_11
					var_27_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_11] = var_27_13

					local var_27_14 = var_27_13:GetComponentInChildren(typeof(CharacterEffect))

					var_27_14.enabled = true

					local var_27_15 = GameObjectTools.GetOrAddComponent(var_27_13, typeof(DynamicBoneHelper))

					if var_27_15 then
						var_27_15:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_14.transform, false)

					arg_24_1.var_[var_27_11 .. "Animator"] = var_27_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_11 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_11 .. "LipSync"] = var_27_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_16 = arg_24_1.actors_["105401ui_story"].transform
			local var_27_17 = 90.1333333333343

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 then
				arg_24_1.var_.moveOldPos105401ui_story = var_27_16.localPosition

				local var_27_18 = GameObjectTools.GetOrAddComponent(var_27_16.gameObject, typeof(DynamicBoneHelper))

				if var_27_18 then
					var_27_18:EnableDynamicBone(false)
				end
			end

			local var_27_19 = 0.001

			if var_27_17 <= arg_24_1.time_ and arg_24_1.time_ < var_27_17 + var_27_19 then
				local var_27_20 = (arg_24_1.time_ - var_27_17) / var_27_19
				local var_27_21 = Vector3.New(0, -0.985, -6)

				var_27_16.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos105401ui_story, var_27_21, var_27_20)

				local var_27_22 = manager.ui.mainCamera.transform.position - var_27_16.position

				var_27_16.forward = Vector3.New(var_27_22.x, var_27_22.y, var_27_22.z)

				local var_27_23 = var_27_16.localEulerAngles

				var_27_23.z = 0
				var_27_23.x = 0
				var_27_16.localEulerAngles = var_27_23
			end

			if arg_24_1.time_ >= var_27_17 + var_27_19 and arg_24_1.time_ < var_27_17 + var_27_19 + arg_27_0 then
				var_27_16.localPosition = Vector3.New(0, -0.985, -6)

				local var_27_24 = manager.ui.mainCamera.transform.position - var_27_16.position

				var_27_16.forward = Vector3.New(var_27_24.x, var_27_24.y, var_27_24.z)

				local var_27_25 = var_27_16.localEulerAngles

				var_27_25.z = 0
				var_27_25.x = 0
				var_27_16.localEulerAngles = var_27_25

				local var_27_26 = GameObjectTools.GetOrAddComponent(var_27_16.gameObject, typeof(DynamicBoneHelper))

				if var_27_26 then
					var_27_26:EnableDynamicBone(true)
				end
			end

			local var_27_27 = arg_24_1.actors_["105401ui_story"].transform
			local var_27_28 = 0

			if var_27_28 < arg_24_1.time_ and arg_24_1.time_ <= var_27_28 + arg_27_0 then
				arg_24_1.var_.moveOldPos105401ui_story = var_27_27.localPosition

				local var_27_29 = GameObjectTools.GetOrAddComponent(var_27_27.gameObject, typeof(DynamicBoneHelper))

				if var_27_29 then
					var_27_29:EnableDynamicBone(false)
				end
			end

			local var_27_30 = 0.001

			if var_27_28 <= arg_24_1.time_ and arg_24_1.time_ < var_27_28 + var_27_30 then
				local var_27_31 = (arg_24_1.time_ - var_27_28) / var_27_30
				local var_27_32 = Vector3.New(0, 100, 0)

				var_27_27.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos105401ui_story, var_27_32, var_27_31)

				local var_27_33 = manager.ui.mainCamera.transform.position - var_27_27.position

				var_27_27.forward = Vector3.New(var_27_33.x, var_27_33.y, var_27_33.z)

				local var_27_34 = var_27_27.localEulerAngles

				var_27_34.z = 0
				var_27_34.x = 0
				var_27_27.localEulerAngles = var_27_34
			end

			if arg_24_1.time_ >= var_27_28 + var_27_30 and arg_24_1.time_ < var_27_28 + var_27_30 + arg_27_0 then
				var_27_27.localPosition = Vector3.New(0, 100, 0)

				local var_27_35 = manager.ui.mainCamera.transform.position - var_27_27.position

				var_27_27.forward = Vector3.New(var_27_35.x, var_27_35.y, var_27_35.z)

				local var_27_36 = var_27_27.localEulerAngles

				var_27_36.z = 0
				var_27_36.x = 0
				var_27_27.localEulerAngles = var_27_36

				local var_27_37 = GameObjectTools.GetOrAddComponent(var_27_27.gameObject, typeof(DynamicBoneHelper))

				if var_27_37 then
					var_27_37:EnableDynamicBone(true)
				end
			end

			local var_27_38 = arg_24_1.actors_["105401ui_story"]
			local var_27_39 = 90.1333333333343

			if var_27_39 < arg_24_1.time_ and arg_24_1.time_ <= var_27_39 + arg_27_0 and not isNil(var_27_38) and arg_24_1.var_.characterEffect105401ui_story == nil then
				arg_24_1.var_.characterEffect105401ui_story = var_27_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_40 = 0.200000002980232

			if var_27_39 <= arg_24_1.time_ and arg_24_1.time_ < var_27_39 + var_27_40 and not isNil(var_27_38) then
				local var_27_41 = (arg_24_1.time_ - var_27_39) / var_27_40

				if arg_24_1.var_.characterEffect105401ui_story and not isNil(var_27_38) then
					arg_24_1.var_.characterEffect105401ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_39 + var_27_40 and arg_24_1.time_ < var_27_39 + var_27_40 + arg_27_0 and not isNil(var_27_38) and arg_24_1.var_.characterEffect105401ui_story then
				arg_24_1.var_.characterEffect105401ui_story.fillFlat = false
			end

			local var_27_42 = 90.1333333333343

			if var_27_42 < arg_24_1.time_ and arg_24_1.time_ <= var_27_42 + arg_27_0 then
				arg_24_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_27_43 = 90

			if var_27_43 < arg_24_1.time_ and arg_24_1.time_ <= var_27_43 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_44 = 2

			if var_27_43 <= arg_24_1.time_ and arg_24_1.time_ < var_27_43 + var_27_44 then
				local var_27_45 = (arg_24_1.time_ - var_27_43) / var_27_44
				local var_27_46 = Color.New(0, 0, 0)

				var_27_46.a = Mathf.Lerp(1, 0, var_27_45)
				arg_24_1.mask_.color = var_27_46
			end

			if arg_24_1.time_ >= var_27_43 + var_27_44 and arg_24_1.time_ < var_27_43 + var_27_44 + arg_27_0 then
				local var_27_47 = Color.New(0, 0, 0)
				local var_27_48 = 0

				arg_24_1.mask_.enabled = false
				var_27_47.a = var_27_48
				arg_24_1.mask_.color = var_27_47
			end

			local var_27_49 = 90.1333333333333

			if var_27_49 < arg_24_1.time_ and arg_24_1.time_ <= var_27_49 + arg_27_0 then
				arg_24_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_27_50 = 0

			if var_27_50 < arg_24_1.time_ and arg_24_1.time_ <= var_27_50 + arg_27_0 then
				SetActive(arg_24_1.dialog_, false)
				SetActive(arg_24_1.allBtn_.gameObject, false)
				arg_24_1.hideBtnsController_:SetSelectedIndex(1)
				arg_24_1:StopAllVoice()
				arg_24_1:PlayOnlyBgm()

				arg_24_1.marker = "tingliuyixia1"

				manager.video:Play("SofdecAsset/story/story_936041001.usm", function(arg_28_0)
					arg_24_1.time_ = var_27_50 + 89.9900000002235

					if arg_24_1.state_ == "pause" then
						arg_24_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_29_0)
					if arg_29_0 then
						arg_24_1.state_ = "pause"
					else
						arg_24_1.state_ = "playing"
					end
				end, 93604101)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_27_51 = 90

			if var_27_50 <= arg_24_1.time_ and arg_24_1.time_ < var_27_50 + var_27_51 then
				-- block empty
			end

			if arg_24_1.time_ >= var_27_50 + var_27_51 and arg_24_1.time_ < var_27_50 + var_27_51 + arg_27_0 then
				arg_24_1.marker = ""
			end

			local var_27_52 = 90

			if var_27_52 < arg_24_1.time_ and arg_24_1.time_ <= var_27_52 + arg_27_0 then
				SetActive(arg_24_1.dialog_, true)
				SetActive(arg_24_1.allBtn_.gameObject, true)
				arg_24_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_24_1.isInLoopVideo = false
			end

			local var_27_53 = 2.26666666666667

			if var_27_52 <= arg_24_1.time_ and arg_24_1.time_ < var_27_52 + var_27_53 then
				-- block empty
			end

			if arg_24_1.time_ >= var_27_52 + var_27_53 and arg_24_1.time_ < var_27_52 + var_27_53 + arg_27_0 then
				-- block empty
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_54 = 90
			local var_27_55 = 0.275

			if var_27_54 < arg_24_1.time_ and arg_24_1.time_ <= var_27_54 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_56 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_56:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_24_1.dialogCg_.alpha = arg_30_0
				end))
				var_27_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_57 = arg_24_1:FormatText(StoryNameCfg[1487].name)

				arg_24_1.leftNameTxt_.text = var_27_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_58 = arg_24_1:GetWordFromCfg(936041006)
				local var_27_59 = arg_24_1:FormatText(var_27_58.content)

				arg_24_1.text_.text = var_27_59

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_60 = 11
				local var_27_61 = utf8.len(var_27_59)
				local var_27_62 = var_27_60 <= 0 and var_27_55 or var_27_55 * (var_27_61 / var_27_60)

				if var_27_62 > 0 and var_27_55 < var_27_62 then
					arg_24_1.talkMaxDuration = var_27_62
					var_27_54 = var_27_54 + 0.3

					if var_27_62 + var_27_54 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_62 + var_27_54
					end
				end

				arg_24_1.text_.text = var_27_59
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041006", "story_v_side_old_936041.awb") ~= 0 then
					local var_27_63 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041006", "story_v_side_old_936041.awb") / 1000

					if var_27_63 + var_27_54 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_63 + var_27_54
					end

					if var_27_58.prefab_name ~= "" and arg_24_1.actors_[var_27_58.prefab_name] ~= nil then
						local var_27_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_58.prefab_name].transform, "story_v_side_old_936041", "936041006", "story_v_side_old_936041.awb")

						arg_24_1:RecordAudio("936041006", var_27_64)
						arg_24_1:RecordAudio("936041006", var_27_64)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041006", "story_v_side_old_936041.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041006", "story_v_side_old_936041.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_65 = var_27_54 + 0.3
			local var_27_66 = math.max(var_27_55, arg_24_1.talkMaxDuration)

			if var_27_65 <= arg_24_1.time_ and arg_24_1.time_ < var_27_65 + var_27_66 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_65) / var_27_66

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_65 + var_27_66 and arg_24_1.time_ < var_27_65 + var_27_66 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 90.1333333333343,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105401ui_story",
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
	Play936041007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 936041007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play936041008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["105401ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos105401ui_story = var_35_0.localPosition

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end
			end

			local var_35_3 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_3 then
				local var_35_4 = (arg_32_1.time_ - var_35_1) / var_35_3
				local var_35_5 = Vector3.New(0, 100, 0)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos105401ui_story, var_35_5, var_35_4)

				local var_35_6 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_6.x, var_35_6.y, var_35_6.z)

				local var_35_7 = var_35_0.localEulerAngles

				var_35_7.z = 0
				var_35_7.x = 0
				var_35_0.localEulerAngles = var_35_7
			end

			if arg_32_1.time_ >= var_35_1 + var_35_3 and arg_32_1.time_ < var_35_1 + var_35_3 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, 100, 0)

				local var_35_8 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_8.x, var_35_8.y, var_35_8.z)

				local var_35_9 = var_35_0.localEulerAngles

				var_35_9.z = 0
				var_35_9.x = 0
				var_35_0.localEulerAngles = var_35_9

				local var_35_10 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_10 then
					var_35_10:EnableDynamicBone(true)
				end
			end

			local var_35_11 = "614801ui_story"

			if arg_32_1.actors_[var_35_11] == nil then
				local var_35_12 = Asset.Load("Char/" .. "614801ui_story")

				if not isNil(var_35_12) then
					local var_35_13 = Object.Instantiate(Asset.Load("Char/" .. "614801ui_story"), arg_32_1.stage_.transform)

					var_35_13.name = var_35_11
					var_35_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_11] = var_35_13

					local var_35_14 = var_35_13:GetComponentInChildren(typeof(CharacterEffect))

					var_35_14.enabled = true

					local var_35_15 = GameObjectTools.GetOrAddComponent(var_35_13, typeof(DynamicBoneHelper))

					if var_35_15 then
						var_35_15:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_14.transform, false)

					arg_32_1.var_[var_35_11 .. "Animator"] = var_35_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_11 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_11 .. "LipSync"] = var_35_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_16 = arg_32_1.actors_["614801ui_story"]
			local var_35_17 = 0

			if var_35_17 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 and not isNil(var_35_16) and arg_32_1.var_.characterEffect614801ui_story == nil then
				arg_32_1.var_.characterEffect614801ui_story = var_35_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_18 = 0.200000002980232

			if var_35_17 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_18 and not isNil(var_35_16) then
				local var_35_19 = (arg_32_1.time_ - var_35_17) / var_35_18

				if arg_32_1.var_.characterEffect614801ui_story and not isNil(var_35_16) then
					local var_35_20 = Mathf.Lerp(0, 0.5, var_35_19)

					arg_32_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_32_1.var_.characterEffect614801ui_story.fillRatio = var_35_20
				end
			end

			if arg_32_1.time_ >= var_35_17 + var_35_18 and arg_32_1.time_ < var_35_17 + var_35_18 + arg_35_0 and not isNil(var_35_16) and arg_32_1.var_.characterEffect614801ui_story then
				local var_35_21 = 0.5

				arg_32_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_32_1.var_.characterEffect614801ui_story.fillRatio = var_35_21
			end

			local var_35_22 = 0
			local var_35_23 = 0.3

			if var_35_22 < arg_32_1.time_ and arg_32_1.time_ <= var_35_22 + arg_35_0 then
				local var_35_24 = "play"
				local var_35_25 = "music"

				arg_32_1:AudioAction(var_35_24, var_35_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_35_26 = ""
				local var_35_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_35_27 ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_27 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_27

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_27
						arg_32_1.bgmTxt2_.text = var_35_27
					end

					if arg_32_1.bgmTimer then
						arg_32_1.bgmTimer:Stop()

						arg_32_1.bgmTimer = nil
					end

					if arg_32_1.settingData.show_music_name == 1 then
						arg_32_1.musicController:SetSelectedState("show")
						arg_32_1.musicAnimator_:Play("open", 0, 0)

						if arg_32_1.settingData.music_time ~= 0 then
							arg_32_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_32_1.settingData.music_time), function()
								if arg_32_1 == nil or isNil(arg_32_1.bgmTxt_) then
									return
								end

								arg_32_1.musicController:SetSelectedState("hide")
								arg_32_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_35_28 = 0.433333333333333
			local var_35_29 = 1

			if var_35_28 < arg_32_1.time_ and arg_32_1.time_ <= var_35_28 + arg_35_0 then
				local var_35_30 = "play"
				local var_35_31 = "music"

				arg_32_1:AudioAction(var_35_30, var_35_31, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_35_32 = ""
				local var_35_33 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if var_35_33 ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_33 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_33

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_33
						arg_32_1.bgmTxt2_.text = var_35_33
					end

					if arg_32_1.bgmTimer then
						arg_32_1.bgmTimer:Stop()

						arg_32_1.bgmTimer = nil
					end

					if arg_32_1.settingData.show_music_name == 1 then
						arg_32_1.musicController:SetSelectedState("show")
						arg_32_1.musicAnimator_:Play("open", 0, 0)

						if arg_32_1.settingData.music_time ~= 0 then
							arg_32_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_32_1.settingData.music_time), function()
								if arg_32_1 == nil or isNil(arg_32_1.bgmTxt_) then
									return
								end

								arg_32_1.musicController:SetSelectedState("hide")
								arg_32_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_35_34 = 0
			local var_35_35 = 1.375

			if var_35_34 < arg_32_1.time_ and arg_32_1.time_ <= var_35_34 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_36 = arg_32_1:GetWordFromCfg(936041007)
				local var_35_37 = arg_32_1:FormatText(var_35_36.content)

				arg_32_1.text_.text = var_35_37

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_38 = 55
				local var_35_39 = utf8.len(var_35_37)
				local var_35_40 = var_35_38 <= 0 and var_35_35 or var_35_35 * (var_35_39 / var_35_38)

				if var_35_40 > 0 and var_35_35 < var_35_40 then
					arg_32_1.talkMaxDuration = var_35_40

					if var_35_40 + var_35_34 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_40 + var_35_34
					end
				end

				arg_32_1.text_.text = var_35_37
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_41 = math.max(var_35_35, arg_32_1.talkMaxDuration)

			if var_35_34 <= arg_32_1.time_ and arg_32_1.time_ < var_35_34 + var_35_41 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_34) / var_35_41

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_34 + var_35_41 and arg_32_1.time_ < var_35_34 + var_35_41 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105401ui_story",
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
	Play936041008 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 936041008
		arg_38_1.duration_ = 6.37

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play936041009(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = "121102ui_story"

			if arg_38_1.actors_[var_41_0] == nil then
				local var_41_1 = Asset.Load("Char/" .. "121102ui_story")

				if not isNil(var_41_1) then
					local var_41_2 = Object.Instantiate(Asset.Load("Char/" .. "121102ui_story"), arg_38_1.stage_.transform)

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

			local var_41_5 = arg_38_1.actors_["121102ui_story"].transform
			local var_41_6 = 0

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.var_.moveOldPos121102ui_story = var_41_5.localPosition

				local var_41_7 = GameObjectTools.GetOrAddComponent(var_41_5.gameObject, typeof(DynamicBoneHelper))

				if var_41_7 then
					var_41_7:EnableDynamicBone(false)
				end
			end

			local var_41_8 = 0.001

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_8 then
				local var_41_9 = (arg_38_1.time_ - var_41_6) / var_41_8
				local var_41_10 = Vector3.New(-0.7, -0.67, -6.07)

				var_41_5.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos121102ui_story, var_41_10, var_41_9)

				local var_41_11 = manager.ui.mainCamera.transform.position - var_41_5.position

				var_41_5.forward = Vector3.New(var_41_11.x, var_41_11.y, var_41_11.z)

				local var_41_12 = var_41_5.localEulerAngles

				var_41_12.z = 0
				var_41_12.x = 0
				var_41_5.localEulerAngles = var_41_12
			end

			if arg_38_1.time_ >= var_41_6 + var_41_8 and arg_38_1.time_ < var_41_6 + var_41_8 + arg_41_0 then
				var_41_5.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_41_13 = manager.ui.mainCamera.transform.position - var_41_5.position

				var_41_5.forward = Vector3.New(var_41_13.x, var_41_13.y, var_41_13.z)

				local var_41_14 = var_41_5.localEulerAngles

				var_41_14.z = 0
				var_41_14.x = 0
				var_41_5.localEulerAngles = var_41_14

				local var_41_15 = GameObjectTools.GetOrAddComponent(var_41_5.gameObject, typeof(DynamicBoneHelper))

				if var_41_15 then
					var_41_15:EnableDynamicBone(true)
				end
			end

			local var_41_16 = arg_38_1.actors_["121102ui_story"]
			local var_41_17 = 0

			if var_41_17 < arg_38_1.time_ and arg_38_1.time_ <= var_41_17 + arg_41_0 and not isNil(var_41_16) and arg_38_1.var_.characterEffect121102ui_story == nil then
				arg_38_1.var_.characterEffect121102ui_story = var_41_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_18 = 0.200000002980232

			if var_41_17 <= arg_38_1.time_ and arg_38_1.time_ < var_41_17 + var_41_18 and not isNil(var_41_16) then
				local var_41_19 = (arg_38_1.time_ - var_41_17) / var_41_18

				if arg_38_1.var_.characterEffect121102ui_story and not isNil(var_41_16) then
					arg_38_1.var_.characterEffect121102ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_17 + var_41_18 and arg_38_1.time_ < var_41_17 + var_41_18 + arg_41_0 and not isNil(var_41_16) and arg_38_1.var_.characterEffect121102ui_story then
				arg_38_1.var_.characterEffect121102ui_story.fillFlat = false
			end

			local var_41_20 = 0

			if var_41_20 < arg_38_1.time_ and arg_38_1.time_ <= var_41_20 + arg_41_0 then
				arg_38_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_41_21 = 0

			if var_41_21 < arg_38_1.time_ and arg_38_1.time_ <= var_41_21 + arg_41_0 then
				arg_38_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_41_22 = 0
			local var_41_23 = 0.725

			if var_41_22 < arg_38_1.time_ and arg_38_1.time_ <= var_41_22 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_24 = arg_38_1:FormatText(StoryNameCfg[37].name)

				arg_38_1.leftNameTxt_.text = var_41_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_25 = arg_38_1:GetWordFromCfg(936041008)
				local var_41_26 = arg_38_1:FormatText(var_41_25.content)

				arg_38_1.text_.text = var_41_26

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_27 = 29
				local var_41_28 = utf8.len(var_41_26)
				local var_41_29 = var_41_27 <= 0 and var_41_23 or var_41_23 * (var_41_28 / var_41_27)

				if var_41_29 > 0 and var_41_23 < var_41_29 then
					arg_38_1.talkMaxDuration = var_41_29

					if var_41_29 + var_41_22 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_29 + var_41_22
					end
				end

				arg_38_1.text_.text = var_41_26
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041008", "story_v_side_old_936041.awb") ~= 0 then
					local var_41_30 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041008", "story_v_side_old_936041.awb") / 1000

					if var_41_30 + var_41_22 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_30 + var_41_22
					end

					if var_41_25.prefab_name ~= "" and arg_38_1.actors_[var_41_25.prefab_name] ~= nil then
						local var_41_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_25.prefab_name].transform, "story_v_side_old_936041", "936041008", "story_v_side_old_936041.awb")

						arg_38_1:RecordAudio("936041008", var_41_31)
						arg_38_1:RecordAudio("936041008", var_41_31)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041008", "story_v_side_old_936041.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041008", "story_v_side_old_936041.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_32 = math.max(var_41_23, arg_38_1.talkMaxDuration)

			if var_41_22 <= arg_38_1.time_ and arg_38_1.time_ < var_41_22 + var_41_32 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_22) / var_41_32

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_22 + var_41_32 and arg_38_1.time_ < var_41_22 + var_41_32 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "121102ui_story",
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
	Play936041009 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 936041009
		arg_42_1.duration_ = 4.8

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play936041010(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["614801ui_story"].transform
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.var_.moveOldPos614801ui_story = var_45_0.localPosition

				local var_45_2 = GameObjectTools.GetOrAddComponent(var_45_0.gameObject, typeof(DynamicBoneHelper))

				if var_45_2 then
					var_45_2:EnableDynamicBone(false)
				end
			end

			local var_45_3 = 0.001

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_3 then
				local var_45_4 = (arg_42_1.time_ - var_45_1) / var_45_3
				local var_45_5 = Vector3.New(0.7, -0.985, -6)

				var_45_0.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos614801ui_story, var_45_5, var_45_4)

				local var_45_6 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_6.x, var_45_6.y, var_45_6.z)

				local var_45_7 = var_45_0.localEulerAngles

				var_45_7.z = 0
				var_45_7.x = 0
				var_45_0.localEulerAngles = var_45_7
			end

			if arg_42_1.time_ >= var_45_1 + var_45_3 and arg_42_1.time_ < var_45_1 + var_45_3 + arg_45_0 then
				var_45_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_45_8 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_8.x, var_45_8.y, var_45_8.z)

				local var_45_9 = var_45_0.localEulerAngles

				var_45_9.z = 0
				var_45_9.x = 0
				var_45_0.localEulerAngles = var_45_9

				local var_45_10 = GameObjectTools.GetOrAddComponent(var_45_0.gameObject, typeof(DynamicBoneHelper))

				if var_45_10 then
					var_45_10:EnableDynamicBone(true)
				end
			end

			local var_45_11 = arg_42_1.actors_["614801ui_story"]
			local var_45_12 = 0

			if var_45_12 < arg_42_1.time_ and arg_42_1.time_ <= var_45_12 + arg_45_0 and not isNil(var_45_11) and arg_42_1.var_.characterEffect614801ui_story == nil then
				arg_42_1.var_.characterEffect614801ui_story = var_45_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_13 = 0.200000002980232

			if var_45_12 <= arg_42_1.time_ and arg_42_1.time_ < var_45_12 + var_45_13 and not isNil(var_45_11) then
				local var_45_14 = (arg_42_1.time_ - var_45_12) / var_45_13

				if arg_42_1.var_.characterEffect614801ui_story and not isNil(var_45_11) then
					arg_42_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_12 + var_45_13 and arg_42_1.time_ < var_45_12 + var_45_13 + arg_45_0 and not isNil(var_45_11) and arg_42_1.var_.characterEffect614801ui_story then
				arg_42_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			local var_45_15 = arg_42_1.actors_["121102ui_story"]
			local var_45_16 = 0

			if var_45_16 < arg_42_1.time_ and arg_42_1.time_ <= var_45_16 + arg_45_0 and not isNil(var_45_15) and arg_42_1.var_.characterEffect121102ui_story == nil then
				arg_42_1.var_.characterEffect121102ui_story = var_45_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_17 = 0.200000002980232

			if var_45_16 <= arg_42_1.time_ and arg_42_1.time_ < var_45_16 + var_45_17 and not isNil(var_45_15) then
				local var_45_18 = (arg_42_1.time_ - var_45_16) / var_45_17

				if arg_42_1.var_.characterEffect121102ui_story and not isNil(var_45_15) then
					local var_45_19 = Mathf.Lerp(0, 0.5, var_45_18)

					arg_42_1.var_.characterEffect121102ui_story.fillFlat = true
					arg_42_1.var_.characterEffect121102ui_story.fillRatio = var_45_19
				end
			end

			if arg_42_1.time_ >= var_45_16 + var_45_17 and arg_42_1.time_ < var_45_16 + var_45_17 + arg_45_0 and not isNil(var_45_15) and arg_42_1.var_.characterEffect121102ui_story then
				local var_45_20 = 0.5

				arg_42_1.var_.characterEffect121102ui_story.fillFlat = true
				arg_42_1.var_.characterEffect121102ui_story.fillRatio = var_45_20
			end

			local var_45_21 = 0

			if var_45_21 < arg_42_1.time_ and arg_42_1.time_ <= var_45_21 + arg_45_0 then
				arg_42_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_45_22 = 0

			if var_45_22 < arg_42_1.time_ and arg_42_1.time_ <= var_45_22 + arg_45_0 then
				arg_42_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_45_23 = 0
			local var_45_24 = 0.6

			if var_45_23 < arg_42_1.time_ and arg_42_1.time_ <= var_45_23 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_25 = arg_42_1:FormatText(StoryNameCfg[1488].name)

				arg_42_1.leftNameTxt_.text = var_45_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_26 = arg_42_1:GetWordFromCfg(936041009)
				local var_45_27 = arg_42_1:FormatText(var_45_26.content)

				arg_42_1.text_.text = var_45_27

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_28 = 24
				local var_45_29 = utf8.len(var_45_27)
				local var_45_30 = var_45_28 <= 0 and var_45_24 or var_45_24 * (var_45_29 / var_45_28)

				if var_45_30 > 0 and var_45_24 < var_45_30 then
					arg_42_1.talkMaxDuration = var_45_30

					if var_45_30 + var_45_23 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_30 + var_45_23
					end
				end

				arg_42_1.text_.text = var_45_27
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041009", "story_v_side_old_936041.awb") ~= 0 then
					local var_45_31 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041009", "story_v_side_old_936041.awb") / 1000

					if var_45_31 + var_45_23 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_31 + var_45_23
					end

					if var_45_26.prefab_name ~= "" and arg_42_1.actors_[var_45_26.prefab_name] ~= nil then
						local var_45_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_26.prefab_name].transform, "story_v_side_old_936041", "936041009", "story_v_side_old_936041.awb")

						arg_42_1:RecordAudio("936041009", var_45_32)
						arg_42_1:RecordAudio("936041009", var_45_32)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041009", "story_v_side_old_936041.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041009", "story_v_side_old_936041.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_33 = math.max(var_45_24, arg_42_1.talkMaxDuration)

			if var_45_23 <= arg_42_1.time_ and arg_42_1.time_ < var_45_23 + var_45_33 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_23) / var_45_33

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_23 + var_45_33 and arg_42_1.time_ < var_45_23 + var_45_33 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play936041010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 936041010
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play936041011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["614801ui_story"].transform
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.var_.moveOldPos614801ui_story = var_49_0.localPosition

				local var_49_2 = GameObjectTools.GetOrAddComponent(var_49_0.gameObject, typeof(DynamicBoneHelper))

				if var_49_2 then
					var_49_2:EnableDynamicBone(false)
				end
			end

			local var_49_3 = 0.001

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_3 then
				local var_49_4 = (arg_46_1.time_ - var_49_1) / var_49_3
				local var_49_5 = Vector3.New(0, 100, 0)

				var_49_0.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos614801ui_story, var_49_5, var_49_4)

				local var_49_6 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_6.x, var_49_6.y, var_49_6.z)

				local var_49_7 = var_49_0.localEulerAngles

				var_49_7.z = 0
				var_49_7.x = 0
				var_49_0.localEulerAngles = var_49_7
			end

			if arg_46_1.time_ >= var_49_1 + var_49_3 and arg_46_1.time_ < var_49_1 + var_49_3 + arg_49_0 then
				var_49_0.localPosition = Vector3.New(0, 100, 0)

				local var_49_8 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_8.x, var_49_8.y, var_49_8.z)

				local var_49_9 = var_49_0.localEulerAngles

				var_49_9.z = 0
				var_49_9.x = 0
				var_49_0.localEulerAngles = var_49_9

				local var_49_10 = GameObjectTools.GetOrAddComponent(var_49_0.gameObject, typeof(DynamicBoneHelper))

				if var_49_10 then
					var_49_10:EnableDynamicBone(true)
				end
			end

			local var_49_11 = arg_46_1.actors_["121102ui_story"].transform
			local var_49_12 = 0

			if var_49_12 < arg_46_1.time_ and arg_46_1.time_ <= var_49_12 + arg_49_0 then
				arg_46_1.var_.moveOldPos121102ui_story = var_49_11.localPosition

				local var_49_13 = GameObjectTools.GetOrAddComponent(var_49_11.gameObject, typeof(DynamicBoneHelper))

				if var_49_13 then
					var_49_13:EnableDynamicBone(false)
				end
			end

			local var_49_14 = 0.001

			if var_49_12 <= arg_46_1.time_ and arg_46_1.time_ < var_49_12 + var_49_14 then
				local var_49_15 = (arg_46_1.time_ - var_49_12) / var_49_14
				local var_49_16 = Vector3.New(0, 100, 0)

				var_49_11.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos121102ui_story, var_49_16, var_49_15)

				local var_49_17 = manager.ui.mainCamera.transform.position - var_49_11.position

				var_49_11.forward = Vector3.New(var_49_17.x, var_49_17.y, var_49_17.z)

				local var_49_18 = var_49_11.localEulerAngles

				var_49_18.z = 0
				var_49_18.x = 0
				var_49_11.localEulerAngles = var_49_18
			end

			if arg_46_1.time_ >= var_49_12 + var_49_14 and arg_46_1.time_ < var_49_12 + var_49_14 + arg_49_0 then
				var_49_11.localPosition = Vector3.New(0, 100, 0)

				local var_49_19 = manager.ui.mainCamera.transform.position - var_49_11.position

				var_49_11.forward = Vector3.New(var_49_19.x, var_49_19.y, var_49_19.z)

				local var_49_20 = var_49_11.localEulerAngles

				var_49_20.z = 0
				var_49_20.x = 0
				var_49_11.localEulerAngles = var_49_20

				local var_49_21 = GameObjectTools.GetOrAddComponent(var_49_11.gameObject, typeof(DynamicBoneHelper))

				if var_49_21 then
					var_49_21:EnableDynamicBone(true)
				end
			end

			local var_49_22 = arg_46_1.actors_["105401ui_story"]
			local var_49_23 = 0

			if var_49_23 < arg_46_1.time_ and arg_46_1.time_ <= var_49_23 + arg_49_0 and not isNil(var_49_22) and arg_46_1.var_.characterEffect105401ui_story == nil then
				arg_46_1.var_.characterEffect105401ui_story = var_49_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_24 = 0.200000002980232

			if var_49_23 <= arg_46_1.time_ and arg_46_1.time_ < var_49_23 + var_49_24 and not isNil(var_49_22) then
				local var_49_25 = (arg_46_1.time_ - var_49_23) / var_49_24

				if arg_46_1.var_.characterEffect105401ui_story and not isNil(var_49_22) then
					local var_49_26 = Mathf.Lerp(0, 0.5, var_49_25)

					arg_46_1.var_.characterEffect105401ui_story.fillFlat = true
					arg_46_1.var_.characterEffect105401ui_story.fillRatio = var_49_26
				end
			end

			if arg_46_1.time_ >= var_49_23 + var_49_24 and arg_46_1.time_ < var_49_23 + var_49_24 + arg_49_0 and not isNil(var_49_22) and arg_46_1.var_.characterEffect105401ui_story then
				local var_49_27 = 0.5

				arg_46_1.var_.characterEffect105401ui_story.fillFlat = true
				arg_46_1.var_.characterEffect105401ui_story.fillRatio = var_49_27
			end

			local var_49_28 = 0
			local var_49_29 = 1.25

			if var_49_28 < arg_46_1.time_ and arg_46_1.time_ <= var_49_28 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_30 = arg_46_1:GetWordFromCfg(936041010)
				local var_49_31 = arg_46_1:FormatText(var_49_30.content)

				arg_46_1.text_.text = var_49_31

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_32 = 50
				local var_49_33 = utf8.len(var_49_31)
				local var_49_34 = var_49_32 <= 0 and var_49_29 or var_49_29 * (var_49_33 / var_49_32)

				if var_49_34 > 0 and var_49_29 < var_49_34 then
					arg_46_1.talkMaxDuration = var_49_34

					if var_49_34 + var_49_28 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_34 + var_49_28
					end
				end

				arg_46_1.text_.text = var_49_31
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_35 = math.max(var_49_29, arg_46_1.talkMaxDuration)

			if var_49_28 <= arg_46_1.time_ and arg_46_1.time_ < var_49_28 + var_49_35 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_28) / var_49_35

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_28 + var_49_35 and arg_46_1.time_ < var_49_28 + var_49_35 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play936041011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 936041011
		arg_50_1.duration_ = 5.93

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play936041012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["104402ui_story"].transform
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.var_.moveOldPos104402ui_story = var_53_0.localPosition

				local var_53_2 = GameObjectTools.GetOrAddComponent(var_53_0.gameObject, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(false)
				end
			end

			local var_53_3 = 0.001

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_3 then
				local var_53_4 = (arg_50_1.time_ - var_53_1) / var_53_3
				local var_53_5 = Vector3.New(0, -1, -5.93)

				var_53_0.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos104402ui_story, var_53_5, var_53_4)

				local var_53_6 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_6.x, var_53_6.y, var_53_6.z)

				local var_53_7 = var_53_0.localEulerAngles

				var_53_7.z = 0
				var_53_7.x = 0
				var_53_0.localEulerAngles = var_53_7
			end

			if arg_50_1.time_ >= var_53_1 + var_53_3 and arg_50_1.time_ < var_53_1 + var_53_3 + arg_53_0 then
				var_53_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_53_8 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_8.x, var_53_8.y, var_53_8.z)

				local var_53_9 = var_53_0.localEulerAngles

				var_53_9.z = 0
				var_53_9.x = 0
				var_53_0.localEulerAngles = var_53_9

				local var_53_10 = GameObjectTools.GetOrAddComponent(var_53_0.gameObject, typeof(DynamicBoneHelper))

				if var_53_10 then
					var_53_10:EnableDynamicBone(true)
				end
			end

			local var_53_11 = arg_50_1.actors_["104402ui_story"]
			local var_53_12 = 0

			if var_53_12 < arg_50_1.time_ and arg_50_1.time_ <= var_53_12 + arg_53_0 and not isNil(var_53_11) and arg_50_1.var_.characterEffect104402ui_story == nil then
				arg_50_1.var_.characterEffect104402ui_story = var_53_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_13 = 0.200000002980232

			if var_53_12 <= arg_50_1.time_ and arg_50_1.time_ < var_53_12 + var_53_13 and not isNil(var_53_11) then
				local var_53_14 = (arg_50_1.time_ - var_53_12) / var_53_13

				if arg_50_1.var_.characterEffect104402ui_story and not isNil(var_53_11) then
					arg_50_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_12 + var_53_13 and arg_50_1.time_ < var_53_12 + var_53_13 + arg_53_0 and not isNil(var_53_11) and arg_50_1.var_.characterEffect104402ui_story then
				arg_50_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_53_15 = 0

			if var_53_15 < arg_50_1.time_ and arg_50_1.time_ <= var_53_15 + arg_53_0 then
				arg_50_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			local var_53_16 = 0

			if var_53_16 < arg_50_1.time_ and arg_50_1.time_ <= var_53_16 + arg_53_0 then
				arg_50_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_53_17 = 0
			local var_53_18 = 0.625

			if var_53_17 < arg_50_1.time_ and arg_50_1.time_ <= var_53_17 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_19 = arg_50_1:FormatText(StoryNameCfg[1367].name)

				arg_50_1.leftNameTxt_.text = var_53_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_20 = arg_50_1:GetWordFromCfg(936041011)
				local var_53_21 = arg_50_1:FormatText(var_53_20.content)

				arg_50_1.text_.text = var_53_21

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_22 = 25
				local var_53_23 = utf8.len(var_53_21)
				local var_53_24 = var_53_22 <= 0 and var_53_18 or var_53_18 * (var_53_23 / var_53_22)

				if var_53_24 > 0 and var_53_18 < var_53_24 then
					arg_50_1.talkMaxDuration = var_53_24

					if var_53_24 + var_53_17 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_24 + var_53_17
					end
				end

				arg_50_1.text_.text = var_53_21
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041011", "story_v_side_old_936041.awb") ~= 0 then
					local var_53_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041011", "story_v_side_old_936041.awb") / 1000

					if var_53_25 + var_53_17 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_25 + var_53_17
					end

					if var_53_20.prefab_name ~= "" and arg_50_1.actors_[var_53_20.prefab_name] ~= nil then
						local var_53_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_20.prefab_name].transform, "story_v_side_old_936041", "936041011", "story_v_side_old_936041.awb")

						arg_50_1:RecordAudio("936041011", var_53_26)
						arg_50_1:RecordAudio("936041011", var_53_26)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041011", "story_v_side_old_936041.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041011", "story_v_side_old_936041.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_27 = math.max(var_53_18, arg_50_1.talkMaxDuration)

			if var_53_17 <= arg_50_1.time_ and arg_50_1.time_ < var_53_17 + var_53_27 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_17) / var_53_27

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_17 + var_53_27 and arg_50_1.time_ < var_53_17 + var_53_27 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
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
	Play936041012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 936041012
		arg_54_1.duration_ = 4.17

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play936041013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["104402ui_story"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos104402ui_story = var_57_0.localPosition

				local var_57_2 = GameObjectTools.GetOrAddComponent(var_57_0.gameObject, typeof(DynamicBoneHelper))

				if var_57_2 then
					var_57_2:EnableDynamicBone(false)
				end
			end

			local var_57_3 = 0.001

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_3 then
				local var_57_4 = (arg_54_1.time_ - var_57_1) / var_57_3
				local var_57_5 = Vector3.New(0, -1, -5.93)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos104402ui_story, var_57_5, var_57_4)

				local var_57_6 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_6.x, var_57_6.y, var_57_6.z)

				local var_57_7 = var_57_0.localEulerAngles

				var_57_7.z = 0
				var_57_7.x = 0
				var_57_0.localEulerAngles = var_57_7
			end

			if arg_54_1.time_ >= var_57_1 + var_57_3 and arg_54_1.time_ < var_57_1 + var_57_3 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_57_8 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_8.x, var_57_8.y, var_57_8.z)

				local var_57_9 = var_57_0.localEulerAngles

				var_57_9.z = 0
				var_57_9.x = 0
				var_57_0.localEulerAngles = var_57_9

				local var_57_10 = GameObjectTools.GetOrAddComponent(var_57_0.gameObject, typeof(DynamicBoneHelper))

				if var_57_10 then
					var_57_10:EnableDynamicBone(true)
				end
			end

			local var_57_11 = 0

			if var_57_11 < arg_54_1.time_ and arg_54_1.time_ <= var_57_11 + arg_57_0 then
				arg_54_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402actionlink/104402action435")
			end

			local var_57_12 = 0

			if var_57_12 < arg_54_1.time_ and arg_54_1.time_ <= var_57_12 + arg_57_0 then
				arg_54_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_57_13 = 0
			local var_57_14 = 0.55

			if var_57_13 < arg_54_1.time_ and arg_54_1.time_ <= var_57_13 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_15 = arg_54_1:FormatText(StoryNameCfg[1367].name)

				arg_54_1.leftNameTxt_.text = var_57_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_16 = arg_54_1:GetWordFromCfg(936041012)
				local var_57_17 = arg_54_1:FormatText(var_57_16.content)

				arg_54_1.text_.text = var_57_17

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_18 = 22
				local var_57_19 = utf8.len(var_57_17)
				local var_57_20 = var_57_18 <= 0 and var_57_14 or var_57_14 * (var_57_19 / var_57_18)

				if var_57_20 > 0 and var_57_14 < var_57_20 then
					arg_54_1.talkMaxDuration = var_57_20

					if var_57_20 + var_57_13 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_20 + var_57_13
					end
				end

				arg_54_1.text_.text = var_57_17
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041012", "story_v_side_old_936041.awb") ~= 0 then
					local var_57_21 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041012", "story_v_side_old_936041.awb") / 1000

					if var_57_21 + var_57_13 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_21 + var_57_13
					end

					if var_57_16.prefab_name ~= "" and arg_54_1.actors_[var_57_16.prefab_name] ~= nil then
						local var_57_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_16.prefab_name].transform, "story_v_side_old_936041", "936041012", "story_v_side_old_936041.awb")

						arg_54_1:RecordAudio("936041012", var_57_22)
						arg_54_1:RecordAudio("936041012", var_57_22)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041012", "story_v_side_old_936041.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041012", "story_v_side_old_936041.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_23 = math.max(var_57_14, arg_54_1.talkMaxDuration)

			if var_57_13 <= arg_54_1.time_ and arg_54_1.time_ < var_57_13 + var_57_23 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_13) / var_57_23

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_13 + var_57_23 and arg_54_1.time_ < var_57_13 + var_57_23 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play936041013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 936041013
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play936041014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["104402ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect104402ui_story == nil then
				arg_58_1.var_.characterEffect104402ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect104402ui_story and not isNil(var_61_0) then
					local var_61_4 = Mathf.Lerp(0, 0.5, var_61_3)

					arg_58_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_58_1.var_.characterEffect104402ui_story.fillRatio = var_61_4
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect104402ui_story then
				local var_61_5 = 0.5

				arg_58_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_58_1.var_.characterEffect104402ui_story.fillRatio = var_61_5
			end

			local var_61_6 = 0
			local var_61_7 = 0.825

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_8 = arg_58_1:FormatText(StoryNameCfg[7].name)

				arg_58_1.leftNameTxt_.text = var_61_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_9 = arg_58_1:GetWordFromCfg(936041013)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 33
				local var_61_12 = utf8.len(var_61_10)
				local var_61_13 = var_61_11 <= 0 and var_61_7 or var_61_7 * (var_61_12 / var_61_11)

				if var_61_13 > 0 and var_61_7 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_14 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_14 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_14

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_14 and arg_58_1.time_ < var_61_6 + var_61_14 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play936041014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 936041014
		arg_62_1.duration_ = 4.47

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play936041015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["104402ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect104402ui_story == nil then
				arg_62_1.var_.characterEffect104402ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect104402ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect104402ui_story then
				arg_62_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_65_4 = 0

			if var_65_4 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action5_2")
			end

			local var_65_5 = 0

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
				arg_62_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_65_6 = 0
			local var_65_7 = 0.425

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[1367].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_9 = arg_62_1:GetWordFromCfg(936041014)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 17
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

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041014", "story_v_side_old_936041.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041014", "story_v_side_old_936041.awb") / 1000

					if var_65_14 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_6
					end

					if var_65_9.prefab_name ~= "" and arg_62_1.actors_[var_65_9.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_9.prefab_name].transform, "story_v_side_old_936041", "936041014", "story_v_side_old_936041.awb")

						arg_62_1:RecordAudio("936041014", var_65_15)
						arg_62_1:RecordAudio("936041014", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041014", "story_v_side_old_936041.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041014", "story_v_side_old_936041.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_16 and arg_62_1.time_ < var_65_6 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play936041015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 936041015
		arg_66_1.duration_ = 5.5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play936041016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["104402ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos104402ui_story = var_69_0.localPosition

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_0.gameObject, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end
			end

			local var_69_3 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_3 then
				local var_69_4 = (arg_66_1.time_ - var_69_1) / var_69_3
				local var_69_5 = Vector3.New(0, -1, -5.93)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos104402ui_story, var_69_5, var_69_4)

				local var_69_6 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_6.x, var_69_6.y, var_69_6.z)

				local var_69_7 = var_69_0.localEulerAngles

				var_69_7.z = 0
				var_69_7.x = 0
				var_69_0.localEulerAngles = var_69_7
			end

			if arg_66_1.time_ >= var_69_1 + var_69_3 and arg_66_1.time_ < var_69_1 + var_69_3 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_69_8 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_8.x, var_69_8.y, var_69_8.z)

				local var_69_9 = var_69_0.localEulerAngles

				var_69_9.z = 0
				var_69_9.x = 0
				var_69_0.localEulerAngles = var_69_9

				local var_69_10 = GameObjectTools.GetOrAddComponent(var_69_0.gameObject, typeof(DynamicBoneHelper))

				if var_69_10 then
					var_69_10:EnableDynamicBone(true)
				end
			end

			local var_69_11 = 0

			if var_69_11 < arg_66_1.time_ and arg_66_1.time_ <= var_69_11 + arg_69_0 then
				arg_66_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			local var_69_12 = 0

			if var_69_12 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 then
				arg_66_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_69_13 = 0
			local var_69_14 = 0.675

			if var_69_13 < arg_66_1.time_ and arg_66_1.time_ <= var_69_13 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_15 = arg_66_1:FormatText(StoryNameCfg[1367].name)

				arg_66_1.leftNameTxt_.text = var_69_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_16 = arg_66_1:GetWordFromCfg(936041015)
				local var_69_17 = arg_66_1:FormatText(var_69_16.content)

				arg_66_1.text_.text = var_69_17

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_18 = 27
				local var_69_19 = utf8.len(var_69_17)
				local var_69_20 = var_69_18 <= 0 and var_69_14 or var_69_14 * (var_69_19 / var_69_18)

				if var_69_20 > 0 and var_69_14 < var_69_20 then
					arg_66_1.talkMaxDuration = var_69_20

					if var_69_20 + var_69_13 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_20 + var_69_13
					end
				end

				arg_66_1.text_.text = var_69_17
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041015", "story_v_side_old_936041.awb") ~= 0 then
					local var_69_21 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041015", "story_v_side_old_936041.awb") / 1000

					if var_69_21 + var_69_13 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_21 + var_69_13
					end

					if var_69_16.prefab_name ~= "" and arg_66_1.actors_[var_69_16.prefab_name] ~= nil then
						local var_69_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_16.prefab_name].transform, "story_v_side_old_936041", "936041015", "story_v_side_old_936041.awb")

						arg_66_1:RecordAudio("936041015", var_69_22)
						arg_66_1:RecordAudio("936041015", var_69_22)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041015", "story_v_side_old_936041.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041015", "story_v_side_old_936041.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_23 = math.max(var_69_14, arg_66_1.talkMaxDuration)

			if var_69_13 <= arg_66_1.time_ and arg_66_1.time_ < var_69_13 + var_69_23 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_13) / var_69_23

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_13 + var_69_23 and arg_66_1.time_ < var_69_13 + var_69_23 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play936041016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 936041016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play936041017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["104402ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect104402ui_story == nil then
				arg_70_1.var_.characterEffect104402ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect104402ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_70_1.var_.characterEffect104402ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect104402ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_70_1.var_.characterEffect104402ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 0.425

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

				local var_73_9 = arg_70_1:GetWordFromCfg(936041016)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 17
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
	Play936041017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 936041017
		arg_74_1.duration_ = 8.83

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play936041018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["104402ui_story"].transform
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.var_.moveOldPos104402ui_story = var_77_0.localPosition

				local var_77_2 = GameObjectTools.GetOrAddComponent(var_77_0.gameObject, typeof(DynamicBoneHelper))

				if var_77_2 then
					var_77_2:EnableDynamicBone(false)
				end
			end

			local var_77_3 = 0.001

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_3 then
				local var_77_4 = (arg_74_1.time_ - var_77_1) / var_77_3
				local var_77_5 = Vector3.New(0, -1, -5.93)

				var_77_0.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos104402ui_story, var_77_5, var_77_4)

				local var_77_6 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_6.x, var_77_6.y, var_77_6.z)

				local var_77_7 = var_77_0.localEulerAngles

				var_77_7.z = 0
				var_77_7.x = 0
				var_77_0.localEulerAngles = var_77_7
			end

			if arg_74_1.time_ >= var_77_1 + var_77_3 and arg_74_1.time_ < var_77_1 + var_77_3 + arg_77_0 then
				var_77_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_77_8 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_8.x, var_77_8.y, var_77_8.z)

				local var_77_9 = var_77_0.localEulerAngles

				var_77_9.z = 0
				var_77_9.x = 0
				var_77_0.localEulerAngles = var_77_9

				local var_77_10 = GameObjectTools.GetOrAddComponent(var_77_0.gameObject, typeof(DynamicBoneHelper))

				if var_77_10 then
					var_77_10:EnableDynamicBone(true)
				end
			end

			local var_77_11 = arg_74_1.actors_["104402ui_story"]
			local var_77_12 = 0

			if var_77_12 < arg_74_1.time_ and arg_74_1.time_ <= var_77_12 + arg_77_0 and not isNil(var_77_11) and arg_74_1.var_.characterEffect104402ui_story == nil then
				arg_74_1.var_.characterEffect104402ui_story = var_77_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_13 = 0.200000002980232

			if var_77_12 <= arg_74_1.time_ and arg_74_1.time_ < var_77_12 + var_77_13 and not isNil(var_77_11) then
				local var_77_14 = (arg_74_1.time_ - var_77_12) / var_77_13

				if arg_74_1.var_.characterEffect104402ui_story and not isNil(var_77_11) then
					arg_74_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_12 + var_77_13 and arg_74_1.time_ < var_77_12 + var_77_13 + arg_77_0 and not isNil(var_77_11) and arg_74_1.var_.characterEffect104402ui_story then
				arg_74_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_77_15 = 0

			if var_77_15 < arg_74_1.time_ and arg_74_1.time_ <= var_77_15 + arg_77_0 then
				arg_74_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_2")
			end

			local var_77_16 = 0

			if var_77_16 < arg_74_1.time_ and arg_74_1.time_ <= var_77_16 + arg_77_0 then
				arg_74_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_77_17 = 0
			local var_77_18 = 0.975

			if var_77_17 < arg_74_1.time_ and arg_74_1.time_ <= var_77_17 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_19 = arg_74_1:FormatText(StoryNameCfg[1367].name)

				arg_74_1.leftNameTxt_.text = var_77_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_20 = arg_74_1:GetWordFromCfg(936041017)
				local var_77_21 = arg_74_1:FormatText(var_77_20.content)

				arg_74_1.text_.text = var_77_21

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_22 = 39
				local var_77_23 = utf8.len(var_77_21)
				local var_77_24 = var_77_22 <= 0 and var_77_18 or var_77_18 * (var_77_23 / var_77_22)

				if var_77_24 > 0 and var_77_18 < var_77_24 then
					arg_74_1.talkMaxDuration = var_77_24

					if var_77_24 + var_77_17 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_24 + var_77_17
					end
				end

				arg_74_1.text_.text = var_77_21
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041017", "story_v_side_old_936041.awb") ~= 0 then
					local var_77_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041017", "story_v_side_old_936041.awb") / 1000

					if var_77_25 + var_77_17 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_25 + var_77_17
					end

					if var_77_20.prefab_name ~= "" and arg_74_1.actors_[var_77_20.prefab_name] ~= nil then
						local var_77_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_20.prefab_name].transform, "story_v_side_old_936041", "936041017", "story_v_side_old_936041.awb")

						arg_74_1:RecordAudio("936041017", var_77_26)
						arg_74_1:RecordAudio("936041017", var_77_26)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041017", "story_v_side_old_936041.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041017", "story_v_side_old_936041.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_27 = math.max(var_77_18, arg_74_1.talkMaxDuration)

			if var_77_17 <= arg_74_1.time_ and arg_74_1.time_ < var_77_17 + var_77_27 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_17) / var_77_27

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_17 + var_77_27 and arg_74_1.time_ < var_77_17 + var_77_27 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play936041018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 936041018
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play936041019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["104402ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect104402ui_story == nil then
				arg_78_1.var_.characterEffect104402ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect104402ui_story and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_78_1.var_.characterEffect104402ui_story.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect104402ui_story then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_78_1.var_.characterEffect104402ui_story.fillRatio = var_81_5
			end

			local var_81_6 = 0
			local var_81_7 = 0.4

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_8 = arg_78_1:FormatText(StoryNameCfg[7].name)

				arg_78_1.leftNameTxt_.text = var_81_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_9 = arg_78_1:GetWordFromCfg(936041018)
				local var_81_10 = arg_78_1:FormatText(var_81_9.content)

				arg_78_1.text_.text = var_81_10

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 16
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
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_14 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_14 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_14

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_14 and arg_78_1.time_ < var_81_6 + var_81_14 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play936041019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 936041019
		arg_82_1.duration_ = 9.97

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play936041020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["104402ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos104402ui_story = var_85_0.localPosition

				local var_85_2 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(false)
				end
			end

			local var_85_3 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_3 then
				local var_85_4 = (arg_82_1.time_ - var_85_1) / var_85_3
				local var_85_5 = Vector3.New(0, -1, -5.93)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos104402ui_story, var_85_5, var_85_4)

				local var_85_6 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_6.x, var_85_6.y, var_85_6.z)

				local var_85_7 = var_85_0.localEulerAngles

				var_85_7.z = 0
				var_85_7.x = 0
				var_85_0.localEulerAngles = var_85_7
			end

			if arg_82_1.time_ >= var_85_1 + var_85_3 and arg_82_1.time_ < var_85_1 + var_85_3 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_85_8 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_8.x, var_85_8.y, var_85_8.z)

				local var_85_9 = var_85_0.localEulerAngles

				var_85_9.z = 0
				var_85_9.x = 0
				var_85_0.localEulerAngles = var_85_9

				local var_85_10 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_10 then
					var_85_10:EnableDynamicBone(true)
				end
			end

			local var_85_11 = arg_82_1.actors_["104402ui_story"]
			local var_85_12 = 0

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect104402ui_story == nil then
				arg_82_1.var_.characterEffect104402ui_story = var_85_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_13 = 0.200000002980232

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_13 and not isNil(var_85_11) then
				local var_85_14 = (arg_82_1.time_ - var_85_12) / var_85_13

				if arg_82_1.var_.characterEffect104402ui_story and not isNil(var_85_11) then
					arg_82_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_12 + var_85_13 and arg_82_1.time_ < var_85_12 + var_85_13 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect104402ui_story then
				arg_82_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_85_15 = 0

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 then
				arg_82_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			local var_85_16 = 0

			if var_85_16 < arg_82_1.time_ and arg_82_1.time_ <= var_85_16 + arg_85_0 then
				arg_82_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_85_17 = 0
			local var_85_18 = 1.075

			if var_85_17 < arg_82_1.time_ and arg_82_1.time_ <= var_85_17 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_19 = arg_82_1:FormatText(StoryNameCfg[1367].name)

				arg_82_1.leftNameTxt_.text = var_85_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_20 = arg_82_1:GetWordFromCfg(936041019)
				local var_85_21 = arg_82_1:FormatText(var_85_20.content)

				arg_82_1.text_.text = var_85_21

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_22 = 43
				local var_85_23 = utf8.len(var_85_21)
				local var_85_24 = var_85_22 <= 0 and var_85_18 or var_85_18 * (var_85_23 / var_85_22)

				if var_85_24 > 0 and var_85_18 < var_85_24 then
					arg_82_1.talkMaxDuration = var_85_24

					if var_85_24 + var_85_17 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_24 + var_85_17
					end
				end

				arg_82_1.text_.text = var_85_21
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041019", "story_v_side_old_936041.awb") ~= 0 then
					local var_85_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041019", "story_v_side_old_936041.awb") / 1000

					if var_85_25 + var_85_17 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_25 + var_85_17
					end

					if var_85_20.prefab_name ~= "" and arg_82_1.actors_[var_85_20.prefab_name] ~= nil then
						local var_85_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_20.prefab_name].transform, "story_v_side_old_936041", "936041019", "story_v_side_old_936041.awb")

						arg_82_1:RecordAudio("936041019", var_85_26)
						arg_82_1:RecordAudio("936041019", var_85_26)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041019", "story_v_side_old_936041.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041019", "story_v_side_old_936041.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_27 = math.max(var_85_18, arg_82_1.talkMaxDuration)

			if var_85_17 <= arg_82_1.time_ and arg_82_1.time_ < var_85_17 + var_85_27 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_17) / var_85_27

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_17 + var_85_27 and arg_82_1.time_ < var_85_17 + var_85_27 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play936041020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 936041020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play936041021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["104402ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect104402ui_story == nil then
				arg_86_1.var_.characterEffect104402ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect104402ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_86_1.var_.characterEffect104402ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect104402ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_86_1.var_.characterEffect104402ui_story.fillRatio = var_89_5
			end

			local var_89_6 = 0
			local var_89_7 = 0.875

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_8 = arg_86_1:FormatText(StoryNameCfg[7].name)

				arg_86_1.leftNameTxt_.text = var_89_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_9 = arg_86_1:GetWordFromCfg(936041020)
				local var_89_10 = arg_86_1:FormatText(var_89_9.content)

				arg_86_1.text_.text = var_89_10

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 35
				local var_89_12 = utf8.len(var_89_10)
				local var_89_13 = var_89_11 <= 0 and var_89_7 or var_89_7 * (var_89_12 / var_89_11)

				if var_89_13 > 0 and var_89_7 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_10
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_14 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_14 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_14

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_14 and arg_86_1.time_ < var_89_6 + var_89_14 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play936041021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 936041021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play936041022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.625

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:GetWordFromCfg(936041021)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 25
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_8 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_8 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_8

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_8 and arg_90_1.time_ < var_93_0 + var_93_8 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play936041022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 936041022
		arg_94_1.duration_ = 2

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play936041023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["104402ui_story"].transform
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.var_.moveOldPos104402ui_story = var_97_0.localPosition

				local var_97_2 = GameObjectTools.GetOrAddComponent(var_97_0.gameObject, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(false)
				end
			end

			local var_97_3 = 0.001

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_3 then
				local var_97_4 = (arg_94_1.time_ - var_97_1) / var_97_3
				local var_97_5 = Vector3.New(0, -1, -5.93)

				var_97_0.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos104402ui_story, var_97_5, var_97_4)

				local var_97_6 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_6.x, var_97_6.y, var_97_6.z)

				local var_97_7 = var_97_0.localEulerAngles

				var_97_7.z = 0
				var_97_7.x = 0
				var_97_0.localEulerAngles = var_97_7
			end

			if arg_94_1.time_ >= var_97_1 + var_97_3 and arg_94_1.time_ < var_97_1 + var_97_3 + arg_97_0 then
				var_97_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_97_8 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_8.x, var_97_8.y, var_97_8.z)

				local var_97_9 = var_97_0.localEulerAngles

				var_97_9.z = 0
				var_97_9.x = 0
				var_97_0.localEulerAngles = var_97_9

				local var_97_10 = GameObjectTools.GetOrAddComponent(var_97_0.gameObject, typeof(DynamicBoneHelper))

				if var_97_10 then
					var_97_10:EnableDynamicBone(true)
				end
			end

			local var_97_11 = arg_94_1.actors_["104402ui_story"]
			local var_97_12 = 0

			if var_97_12 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 and not isNil(var_97_11) and arg_94_1.var_.characterEffect104402ui_story == nil then
				arg_94_1.var_.characterEffect104402ui_story = var_97_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_13 = 0.200000002980232

			if var_97_12 <= arg_94_1.time_ and arg_94_1.time_ < var_97_12 + var_97_13 and not isNil(var_97_11) then
				local var_97_14 = (arg_94_1.time_ - var_97_12) / var_97_13

				if arg_94_1.var_.characterEffect104402ui_story and not isNil(var_97_11) then
					arg_94_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_12 + var_97_13 and arg_94_1.time_ < var_97_12 + var_97_13 + arg_97_0 and not isNil(var_97_11) and arg_94_1.var_.characterEffect104402ui_story then
				arg_94_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_97_15 = 0

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			local var_97_16 = 0

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				arg_94_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_97_17 = 0
			local var_97_18 = 0.15

			if var_97_17 < arg_94_1.time_ and arg_94_1.time_ <= var_97_17 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_19 = arg_94_1:FormatText(StoryNameCfg[1367].name)

				arg_94_1.leftNameTxt_.text = var_97_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_20 = arg_94_1:GetWordFromCfg(936041022)
				local var_97_21 = arg_94_1:FormatText(var_97_20.content)

				arg_94_1.text_.text = var_97_21

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_22 = 6
				local var_97_23 = utf8.len(var_97_21)
				local var_97_24 = var_97_22 <= 0 and var_97_18 or var_97_18 * (var_97_23 / var_97_22)

				if var_97_24 > 0 and var_97_18 < var_97_24 then
					arg_94_1.talkMaxDuration = var_97_24

					if var_97_24 + var_97_17 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_24 + var_97_17
					end
				end

				arg_94_1.text_.text = var_97_21
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041022", "story_v_side_old_936041.awb") ~= 0 then
					local var_97_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041022", "story_v_side_old_936041.awb") / 1000

					if var_97_25 + var_97_17 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_25 + var_97_17
					end

					if var_97_20.prefab_name ~= "" and arg_94_1.actors_[var_97_20.prefab_name] ~= nil then
						local var_97_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_20.prefab_name].transform, "story_v_side_old_936041", "936041022", "story_v_side_old_936041.awb")

						arg_94_1:RecordAudio("936041022", var_97_26)
						arg_94_1:RecordAudio("936041022", var_97_26)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041022", "story_v_side_old_936041.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041022", "story_v_side_old_936041.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_27 = math.max(var_97_18, arg_94_1.talkMaxDuration)

			if var_97_17 <= arg_94_1.time_ and arg_94_1.time_ < var_97_17 + var_97_27 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_17) / var_97_27

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_17 + var_97_27 and arg_94_1.time_ < var_97_17 + var_97_27 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play936041023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 936041023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play936041024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["104402ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos104402ui_story = var_101_0.localPosition

				local var_101_2 = GameObjectTools.GetOrAddComponent(var_101_0.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(false)
				end
			end

			local var_101_3 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_3 then
				local var_101_4 = (arg_98_1.time_ - var_101_1) / var_101_3
				local var_101_5 = Vector3.New(0, 100, 0)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos104402ui_story, var_101_5, var_101_4)

				local var_101_6 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_6.x, var_101_6.y, var_101_6.z)

				local var_101_7 = var_101_0.localEulerAngles

				var_101_7.z = 0
				var_101_7.x = 0
				var_101_0.localEulerAngles = var_101_7
			end

			if arg_98_1.time_ >= var_101_1 + var_101_3 and arg_98_1.time_ < var_101_1 + var_101_3 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0, 100, 0)

				local var_101_8 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_8.x, var_101_8.y, var_101_8.z)

				local var_101_9 = var_101_0.localEulerAngles

				var_101_9.z = 0
				var_101_9.x = 0
				var_101_0.localEulerAngles = var_101_9

				local var_101_10 = GameObjectTools.GetOrAddComponent(var_101_0.gameObject, typeof(DynamicBoneHelper))

				if var_101_10 then
					var_101_10:EnableDynamicBone(true)
				end
			end

			local var_101_11 = arg_98_1.actors_["104402ui_story"]
			local var_101_12 = 0

			if var_101_12 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 and not isNil(var_101_11) and arg_98_1.var_.characterEffect104402ui_story == nil then
				arg_98_1.var_.characterEffect104402ui_story = var_101_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_13 = 0.200000002980232

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_13 and not isNil(var_101_11) then
				local var_101_14 = (arg_98_1.time_ - var_101_12) / var_101_13

				if arg_98_1.var_.characterEffect104402ui_story and not isNil(var_101_11) then
					local var_101_15 = Mathf.Lerp(0, 0.5, var_101_14)

					arg_98_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_98_1.var_.characterEffect104402ui_story.fillRatio = var_101_15
				end
			end

			if arg_98_1.time_ >= var_101_12 + var_101_13 and arg_98_1.time_ < var_101_12 + var_101_13 + arg_101_0 and not isNil(var_101_11) and arg_98_1.var_.characterEffect104402ui_story then
				local var_101_16 = 0.5

				arg_98_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_98_1.var_.characterEffect104402ui_story.fillRatio = var_101_16
			end

			local var_101_17 = 0.7
			local var_101_18 = 1

			if var_101_17 < arg_98_1.time_ and arg_98_1.time_ <= var_101_17 + arg_101_0 then
				local var_101_19 = "play"
				local var_101_20 = "effect"

				arg_98_1:AudioAction(var_101_19, var_101_20, "se_story_side_1033", "se_story_side_1033_footstep", "")
			end

			local var_101_21 = 0
			local var_101_22 = 1

			if var_101_21 < arg_98_1.time_ and arg_98_1.time_ <= var_101_21 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_23 = arg_98_1:GetWordFromCfg(936041023)
				local var_101_24 = arg_98_1:FormatText(var_101_23.content)

				arg_98_1.text_.text = var_101_24

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_25 = 40
				local var_101_26 = utf8.len(var_101_24)
				local var_101_27 = var_101_25 <= 0 and var_101_22 or var_101_22 * (var_101_26 / var_101_25)

				if var_101_27 > 0 and var_101_22 < var_101_27 then
					arg_98_1.talkMaxDuration = var_101_27

					if var_101_27 + var_101_21 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_27 + var_101_21
					end
				end

				arg_98_1.text_.text = var_101_24
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_28 = math.max(var_101_22, arg_98_1.talkMaxDuration)

			if var_101_21 <= arg_98_1.time_ and arg_98_1.time_ < var_101_21 + var_101_28 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_21) / var_101_28

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_21 + var_101_28 and arg_98_1.time_ < var_101_21 + var_101_28 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play936041024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 936041024
		arg_102_1.duration_ = 5.07

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play936041025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["104402ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos104402ui_story = var_105_0.localPosition

				local var_105_2 = GameObjectTools.GetOrAddComponent(var_105_0.gameObject, typeof(DynamicBoneHelper))

				if var_105_2 then
					var_105_2:EnableDynamicBone(false)
				end
			end

			local var_105_3 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_3 then
				local var_105_4 = (arg_102_1.time_ - var_105_1) / var_105_3
				local var_105_5 = Vector3.New(0, -1, -5.93)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos104402ui_story, var_105_5, var_105_4)

				local var_105_6 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_6.x, var_105_6.y, var_105_6.z)

				local var_105_7 = var_105_0.localEulerAngles

				var_105_7.z = 0
				var_105_7.x = 0
				var_105_0.localEulerAngles = var_105_7
			end

			if arg_102_1.time_ >= var_105_1 + var_105_3 and arg_102_1.time_ < var_105_1 + var_105_3 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_105_8 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_8.x, var_105_8.y, var_105_8.z)

				local var_105_9 = var_105_0.localEulerAngles

				var_105_9.z = 0
				var_105_9.x = 0
				var_105_0.localEulerAngles = var_105_9

				local var_105_10 = GameObjectTools.GetOrAddComponent(var_105_0.gameObject, typeof(DynamicBoneHelper))

				if var_105_10 then
					var_105_10:EnableDynamicBone(true)
				end
			end

			local var_105_11 = arg_102_1.actors_["104402ui_story"]
			local var_105_12 = 0

			if var_105_12 < arg_102_1.time_ and arg_102_1.time_ <= var_105_12 + arg_105_0 and not isNil(var_105_11) and arg_102_1.var_.characterEffect104402ui_story == nil then
				arg_102_1.var_.characterEffect104402ui_story = var_105_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_13 = 0.200000002980232

			if var_105_12 <= arg_102_1.time_ and arg_102_1.time_ < var_105_12 + var_105_13 and not isNil(var_105_11) then
				local var_105_14 = (arg_102_1.time_ - var_105_12) / var_105_13

				if arg_102_1.var_.characterEffect104402ui_story and not isNil(var_105_11) then
					arg_102_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_12 + var_105_13 and arg_102_1.time_ < var_105_12 + var_105_13 + arg_105_0 and not isNil(var_105_11) and arg_102_1.var_.characterEffect104402ui_story then
				arg_102_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_105_15 = 0

			if var_105_15 < arg_102_1.time_ and arg_102_1.time_ <= var_105_15 + arg_105_0 then
				arg_102_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402actionlink/104402action438")
			end

			local var_105_16 = 0

			if var_105_16 < arg_102_1.time_ and arg_102_1.time_ <= var_105_16 + arg_105_0 then
				arg_102_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_105_17 = 0
			local var_105_18 = 0.5

			if var_105_17 < arg_102_1.time_ and arg_102_1.time_ <= var_105_17 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_19 = arg_102_1:FormatText(StoryNameCfg[1367].name)

				arg_102_1.leftNameTxt_.text = var_105_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_20 = arg_102_1:GetWordFromCfg(936041024)
				local var_105_21 = arg_102_1:FormatText(var_105_20.content)

				arg_102_1.text_.text = var_105_21

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_22 = 20
				local var_105_23 = utf8.len(var_105_21)
				local var_105_24 = var_105_22 <= 0 and var_105_18 or var_105_18 * (var_105_23 / var_105_22)

				if var_105_24 > 0 and var_105_18 < var_105_24 then
					arg_102_1.talkMaxDuration = var_105_24

					if var_105_24 + var_105_17 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_24 + var_105_17
					end
				end

				arg_102_1.text_.text = var_105_21
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041024", "story_v_side_old_936041.awb") ~= 0 then
					local var_105_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041024", "story_v_side_old_936041.awb") / 1000

					if var_105_25 + var_105_17 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_25 + var_105_17
					end

					if var_105_20.prefab_name ~= "" and arg_102_1.actors_[var_105_20.prefab_name] ~= nil then
						local var_105_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_20.prefab_name].transform, "story_v_side_old_936041", "936041024", "story_v_side_old_936041.awb")

						arg_102_1:RecordAudio("936041024", var_105_26)
						arg_102_1:RecordAudio("936041024", var_105_26)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041024", "story_v_side_old_936041.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041024", "story_v_side_old_936041.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_27 = math.max(var_105_18, arg_102_1.talkMaxDuration)

			if var_105_17 <= arg_102_1.time_ and arg_102_1.time_ < var_105_17 + var_105_27 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_17) / var_105_27

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_17 + var_105_27 and arg_102_1.time_ < var_105_17 + var_105_27 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play936041025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 936041025
		arg_106_1.duration_ = 3.7

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play936041026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["104402ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos104402ui_story = var_109_0.localPosition

				local var_109_2 = GameObjectTools.GetOrAddComponent(var_109_0.gameObject, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(false)
				end
			end

			local var_109_3 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_3 then
				local var_109_4 = (arg_106_1.time_ - var_109_1) / var_109_3
				local var_109_5 = Vector3.New(0, -1, -5.93)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos104402ui_story, var_109_5, var_109_4)

				local var_109_6 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_6.x, var_109_6.y, var_109_6.z)

				local var_109_7 = var_109_0.localEulerAngles

				var_109_7.z = 0
				var_109_7.x = 0
				var_109_0.localEulerAngles = var_109_7
			end

			if arg_106_1.time_ >= var_109_1 + var_109_3 and arg_106_1.time_ < var_109_1 + var_109_3 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_109_8 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_8.x, var_109_8.y, var_109_8.z)

				local var_109_9 = var_109_0.localEulerAngles

				var_109_9.z = 0
				var_109_9.x = 0
				var_109_0.localEulerAngles = var_109_9

				local var_109_10 = GameObjectTools.GetOrAddComponent(var_109_0.gameObject, typeof(DynamicBoneHelper))

				if var_109_10 then
					var_109_10:EnableDynamicBone(true)
				end
			end

			local var_109_11 = 0

			if var_109_11 < arg_106_1.time_ and arg_106_1.time_ <= var_109_11 + arg_109_0 then
				arg_106_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_2")
			end

			local var_109_12 = 0

			if var_109_12 < arg_106_1.time_ and arg_106_1.time_ <= var_109_12 + arg_109_0 then
				arg_106_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_109_13 = 0
			local var_109_14 = 0.5

			if var_109_13 < arg_106_1.time_ and arg_106_1.time_ <= var_109_13 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_15 = arg_106_1:FormatText(StoryNameCfg[1367].name)

				arg_106_1.leftNameTxt_.text = var_109_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_16 = arg_106_1:GetWordFromCfg(936041025)
				local var_109_17 = arg_106_1:FormatText(var_109_16.content)

				arg_106_1.text_.text = var_109_17

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_18 = 20
				local var_109_19 = utf8.len(var_109_17)
				local var_109_20 = var_109_18 <= 0 and var_109_14 or var_109_14 * (var_109_19 / var_109_18)

				if var_109_20 > 0 and var_109_14 < var_109_20 then
					arg_106_1.talkMaxDuration = var_109_20

					if var_109_20 + var_109_13 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_20 + var_109_13
					end
				end

				arg_106_1.text_.text = var_109_17
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041025", "story_v_side_old_936041.awb") ~= 0 then
					local var_109_21 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041025", "story_v_side_old_936041.awb") / 1000

					if var_109_21 + var_109_13 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_21 + var_109_13
					end

					if var_109_16.prefab_name ~= "" and arg_106_1.actors_[var_109_16.prefab_name] ~= nil then
						local var_109_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_16.prefab_name].transform, "story_v_side_old_936041", "936041025", "story_v_side_old_936041.awb")

						arg_106_1:RecordAudio("936041025", var_109_22)
						arg_106_1:RecordAudio("936041025", var_109_22)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041025", "story_v_side_old_936041.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041025", "story_v_side_old_936041.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_23 = math.max(var_109_14, arg_106_1.talkMaxDuration)

			if var_109_13 <= arg_106_1.time_ and arg_106_1.time_ < var_109_13 + var_109_23 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_13) / var_109_23

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_13 + var_109_23 and arg_106_1.time_ < var_109_13 + var_109_23 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
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
	Play936041026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 936041026
		arg_110_1.duration_ = 5.47

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play936041027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = "X206_g"

			if arg_110_1.bgs_[var_113_0] == nil then
				local var_113_1 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_113_0)
				var_113_1.name = var_113_0
				var_113_1.transform.parent = arg_110_1.stage_.transform
				var_113_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_[var_113_0] = var_113_1
			end

			local var_113_2 = 2

			if var_113_2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				local var_113_3 = manager.ui.mainCamera.transform.localPosition
				local var_113_4 = Vector3.New(0, 0, 10) + Vector3.New(var_113_3.x, var_113_3.y, 0)
				local var_113_5 = arg_110_1.bgs_.X206_g

				var_113_5.transform.localPosition = var_113_4
				var_113_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_6 = var_113_5:GetComponent("SpriteRenderer")

				if var_113_6 and var_113_6.sprite then
					local var_113_7 = (var_113_5.transform.localPosition - var_113_3).z
					local var_113_8 = manager.ui.mainCameraCom_
					local var_113_9 = 2 * var_113_7 * Mathf.Tan(var_113_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_113_10 = var_113_9 * var_113_8.aspect
					local var_113_11 = var_113_6.sprite.bounds.size.x
					local var_113_12 = var_113_6.sprite.bounds.size.y
					local var_113_13 = var_113_10 / var_113_11
					local var_113_14 = var_113_9 / var_113_12
					local var_113_15 = var_113_14 < var_113_13 and var_113_13 or var_113_14

					var_113_5.transform.localScale = Vector3.New(var_113_15, var_113_15, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "X206_g" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_16 = 4

			if var_113_16 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			local var_113_17 = 0.3

			if arg_110_1.time_ >= var_113_16 + var_113_17 and arg_110_1.time_ < var_113_16 + var_113_17 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_18 = 0

			if var_113_18 < arg_110_1.time_ and arg_110_1.time_ <= var_113_18 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_19 = 2

			if var_113_18 <= arg_110_1.time_ and arg_110_1.time_ < var_113_18 + var_113_19 then
				local var_113_20 = (arg_110_1.time_ - var_113_18) / var_113_19
				local var_113_21 = Color.New(0, 0, 0)

				var_113_21.a = Mathf.Lerp(0, 1, var_113_20)
				arg_110_1.mask_.color = var_113_21
			end

			if arg_110_1.time_ >= var_113_18 + var_113_19 and arg_110_1.time_ < var_113_18 + var_113_19 + arg_113_0 then
				local var_113_22 = Color.New(0, 0, 0)

				var_113_22.a = 1
				arg_110_1.mask_.color = var_113_22
			end

			local var_113_23 = 2

			if var_113_23 < arg_110_1.time_ and arg_110_1.time_ <= var_113_23 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_24 = 2

			if var_113_23 <= arg_110_1.time_ and arg_110_1.time_ < var_113_23 + var_113_24 then
				local var_113_25 = (arg_110_1.time_ - var_113_23) / var_113_24
				local var_113_26 = Color.New(0, 0, 0)

				var_113_26.a = Mathf.Lerp(1, 0, var_113_25)
				arg_110_1.mask_.color = var_113_26
			end

			if arg_110_1.time_ >= var_113_23 + var_113_24 and arg_110_1.time_ < var_113_23 + var_113_24 + arg_113_0 then
				local var_113_27 = Color.New(0, 0, 0)
				local var_113_28 = 0

				arg_110_1.mask_.enabled = false
				var_113_27.a = var_113_28
				arg_110_1.mask_.color = var_113_27
			end

			local var_113_29 = arg_110_1.actors_["104402ui_story"].transform
			local var_113_30 = 1.96599999815226

			if var_113_30 < arg_110_1.time_ and arg_110_1.time_ <= var_113_30 + arg_113_0 then
				arg_110_1.var_.moveOldPos104402ui_story = var_113_29.localPosition

				local var_113_31 = GameObjectTools.GetOrAddComponent(var_113_29.gameObject, typeof(DynamicBoneHelper))

				if var_113_31 then
					var_113_31:EnableDynamicBone(false)
				end
			end

			local var_113_32 = 0.001

			if var_113_30 <= arg_110_1.time_ and arg_110_1.time_ < var_113_30 + var_113_32 then
				local var_113_33 = (arg_110_1.time_ - var_113_30) / var_113_32
				local var_113_34 = Vector3.New(0, 100, 0)

				var_113_29.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos104402ui_story, var_113_34, var_113_33)

				local var_113_35 = manager.ui.mainCamera.transform.position - var_113_29.position

				var_113_29.forward = Vector3.New(var_113_35.x, var_113_35.y, var_113_35.z)

				local var_113_36 = var_113_29.localEulerAngles

				var_113_36.z = 0
				var_113_36.x = 0
				var_113_29.localEulerAngles = var_113_36
			end

			if arg_110_1.time_ >= var_113_30 + var_113_32 and arg_110_1.time_ < var_113_30 + var_113_32 + arg_113_0 then
				var_113_29.localPosition = Vector3.New(0, 100, 0)

				local var_113_37 = manager.ui.mainCamera.transform.position - var_113_29.position

				var_113_29.forward = Vector3.New(var_113_37.x, var_113_37.y, var_113_37.z)

				local var_113_38 = var_113_29.localEulerAngles

				var_113_38.z = 0
				var_113_38.x = 0
				var_113_29.localEulerAngles = var_113_38

				local var_113_39 = GameObjectTools.GetOrAddComponent(var_113_29.gameObject, typeof(DynamicBoneHelper))

				if var_113_39 then
					var_113_39:EnableDynamicBone(true)
				end
			end

			local var_113_40 = arg_110_1.actors_["104402ui_story"]
			local var_113_41 = 1.96599999815226

			if var_113_41 < arg_110_1.time_ and arg_110_1.time_ <= var_113_41 + arg_113_0 and not isNil(var_113_40) and arg_110_1.var_.characterEffect104402ui_story == nil then
				arg_110_1.var_.characterEffect104402ui_story = var_113_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_42 = 0.034000001847744

			if var_113_41 <= arg_110_1.time_ and arg_110_1.time_ < var_113_41 + var_113_42 and not isNil(var_113_40) then
				local var_113_43 = (arg_110_1.time_ - var_113_41) / var_113_42

				if arg_110_1.var_.characterEffect104402ui_story and not isNil(var_113_40) then
					local var_113_44 = Mathf.Lerp(0, 0.5, var_113_43)

					arg_110_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_110_1.var_.characterEffect104402ui_story.fillRatio = var_113_44
				end
			end

			if arg_110_1.time_ >= var_113_41 + var_113_42 and arg_110_1.time_ < var_113_41 + var_113_42 + arg_113_0 and not isNil(var_113_40) and arg_110_1.var_.characterEffect104402ui_story then
				local var_113_45 = 0.5

				arg_110_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_110_1.var_.characterEffect104402ui_story.fillRatio = var_113_45
			end

			local var_113_46 = 0.133333333333333
			local var_113_47 = 1

			if var_113_46 < arg_110_1.time_ and arg_110_1.time_ <= var_113_46 + arg_113_0 then
				local var_113_48 = "stop"
				local var_113_49 = "effect"

				arg_110_1:AudioAction(var_113_48, var_113_49, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_113_50 = 1.66666666666667
			local var_113_51 = 1

			if var_113_50 < arg_110_1.time_ and arg_110_1.time_ <= var_113_50 + arg_113_0 then
				local var_113_52 = "play"
				local var_113_53 = "effect"

				arg_110_1:AudioAction(var_113_52, var_113_53, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_54 = 4
			local var_113_55 = 0.1

			if var_113_54 < arg_110_1.time_ and arg_110_1.time_ <= var_113_54 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_56 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_56:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_57 = arg_110_1:FormatText(StoryNameCfg[330].name)

				arg_110_1.leftNameTxt_.text = var_113_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_58 = arg_110_1:GetWordFromCfg(936041026)
				local var_113_59 = arg_110_1:FormatText(var_113_58.content)

				arg_110_1.text_.text = var_113_59

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_60 = 4
				local var_113_61 = utf8.len(var_113_59)
				local var_113_62 = var_113_60 <= 0 and var_113_55 or var_113_55 * (var_113_61 / var_113_60)

				if var_113_62 > 0 and var_113_55 < var_113_62 then
					arg_110_1.talkMaxDuration = var_113_62
					var_113_54 = var_113_54 + 0.3

					if var_113_62 + var_113_54 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_62 + var_113_54
					end
				end

				arg_110_1.text_.text = var_113_59
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041026", "story_v_side_old_936041.awb") ~= 0 then
					local var_113_63 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041026", "story_v_side_old_936041.awb") / 1000

					if var_113_63 + var_113_54 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_63 + var_113_54
					end

					if var_113_58.prefab_name ~= "" and arg_110_1.actors_[var_113_58.prefab_name] ~= nil then
						local var_113_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_58.prefab_name].transform, "story_v_side_old_936041", "936041026", "story_v_side_old_936041.awb")

						arg_110_1:RecordAudio("936041026", var_113_64)
						arg_110_1:RecordAudio("936041026", var_113_64)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041026", "story_v_side_old_936041.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041026", "story_v_side_old_936041.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_65 = var_113_54 + 0.3
			local var_113_66 = math.max(var_113_55, arg_110_1.talkMaxDuration)

			if var_113_65 <= arg_110_1.time_ and arg_110_1.time_ < var_113_65 + var_113_66 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_65) / var_113_66

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_65 + var_113_66 and arg_110_1.time_ < var_113_65 + var_113_66 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play936041027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 936041027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play936041028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 1

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				local var_119_2 = "play"
				local var_119_3 = "effect"

				arg_116_1:AudioAction(var_119_2, var_119_3, "se_story_221_00", "se_story_221_00_cheers", "")
			end

			local var_119_4 = 0
			local var_119_5 = 1.525

			if var_119_4 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(936041027)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_8 = 61
				local var_119_9 = utf8.len(var_119_7)
				local var_119_10 = var_119_8 <= 0 and var_119_5 or var_119_5 * (var_119_9 / var_119_8)

				if var_119_10 > 0 and var_119_5 < var_119_10 then
					arg_116_1.talkMaxDuration = var_119_10

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_11 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_11 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_11

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_11 and arg_116_1.time_ < var_119_4 + var_119_11 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play936041028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 936041028
		arg_120_1.duration_ = 4.8

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play936041029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["614801ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos614801ui_story = var_123_0.localPosition

				local var_123_2 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(false)
				end
			end

			local var_123_3 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_3 then
				local var_123_4 = (arg_120_1.time_ - var_123_1) / var_123_3
				local var_123_5 = Vector3.New(-0.7, -0.985, -6)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos614801ui_story, var_123_5, var_123_4)

				local var_123_6 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_6.x, var_123_6.y, var_123_6.z)

				local var_123_7 = var_123_0.localEulerAngles

				var_123_7.z = 0
				var_123_7.x = 0
				var_123_0.localEulerAngles = var_123_7
			end

			if arg_120_1.time_ >= var_123_1 + var_123_3 and arg_120_1.time_ < var_123_1 + var_123_3 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_123_8 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_8.x, var_123_8.y, var_123_8.z)

				local var_123_9 = var_123_0.localEulerAngles

				var_123_9.z = 0
				var_123_9.x = 0
				var_123_0.localEulerAngles = var_123_9

				local var_123_10 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_10 then
					var_123_10:EnableDynamicBone(true)
				end
			end

			local var_123_11 = arg_120_1.actors_["614801ui_story"]
			local var_123_12 = 0

			if var_123_12 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 and not isNil(var_123_11) and arg_120_1.var_.characterEffect614801ui_story == nil then
				arg_120_1.var_.characterEffect614801ui_story = var_123_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_13 = 0.200000002980232

			if var_123_12 <= arg_120_1.time_ and arg_120_1.time_ < var_123_12 + var_123_13 and not isNil(var_123_11) then
				local var_123_14 = (arg_120_1.time_ - var_123_12) / var_123_13

				if arg_120_1.var_.characterEffect614801ui_story and not isNil(var_123_11) then
					arg_120_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_12 + var_123_13 and arg_120_1.time_ < var_123_12 + var_123_13 + arg_123_0 and not isNil(var_123_11) and arg_120_1.var_.characterEffect614801ui_story then
				arg_120_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			local var_123_15 = 0

			if var_123_15 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				arg_120_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_123_16 = 0

			if var_123_16 < arg_120_1.time_ and arg_120_1.time_ <= var_123_16 + arg_123_0 then
				arg_120_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_123_17 = 0
			local var_123_18 = 0.7

			if var_123_17 < arg_120_1.time_ and arg_120_1.time_ <= var_123_17 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_19 = arg_120_1:FormatText(StoryNameCfg[1488].name)

				arg_120_1.leftNameTxt_.text = var_123_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_20 = arg_120_1:GetWordFromCfg(936041028)
				local var_123_21 = arg_120_1:FormatText(var_123_20.content)

				arg_120_1.text_.text = var_123_21

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_22 = 28
				local var_123_23 = utf8.len(var_123_21)
				local var_123_24 = var_123_22 <= 0 and var_123_18 or var_123_18 * (var_123_23 / var_123_22)

				if var_123_24 > 0 and var_123_18 < var_123_24 then
					arg_120_1.talkMaxDuration = var_123_24

					if var_123_24 + var_123_17 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_24 + var_123_17
					end
				end

				arg_120_1.text_.text = var_123_21
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041028", "story_v_side_old_936041.awb") ~= 0 then
					local var_123_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041028", "story_v_side_old_936041.awb") / 1000

					if var_123_25 + var_123_17 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_25 + var_123_17
					end

					if var_123_20.prefab_name ~= "" and arg_120_1.actors_[var_123_20.prefab_name] ~= nil then
						local var_123_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_20.prefab_name].transform, "story_v_side_old_936041", "936041028", "story_v_side_old_936041.awb")

						arg_120_1:RecordAudio("936041028", var_123_26)
						arg_120_1:RecordAudio("936041028", var_123_26)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041028", "story_v_side_old_936041.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041028", "story_v_side_old_936041.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_27 = math.max(var_123_18, arg_120_1.talkMaxDuration)

			if var_123_17 <= arg_120_1.time_ and arg_120_1.time_ < var_123_17 + var_123_27 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_17) / var_123_27

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_17 + var_123_27 and arg_120_1.time_ < var_123_17 + var_123_27 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "614801ui_story",
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
	Play936041029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 936041029
		arg_124_1.duration_ = 4.93

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play936041030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["121102ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos121102ui_story = var_127_0.localPosition

				local var_127_2 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(false)
				end
			end

			local var_127_3 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_3 then
				local var_127_4 = (arg_124_1.time_ - var_127_1) / var_127_3
				local var_127_5 = Vector3.New(0.7, -0.67, -6.07)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos121102ui_story, var_127_5, var_127_4)

				local var_127_6 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_6.x, var_127_6.y, var_127_6.z)

				local var_127_7 = var_127_0.localEulerAngles

				var_127_7.z = 0
				var_127_7.x = 0
				var_127_0.localEulerAngles = var_127_7
			end

			if arg_124_1.time_ >= var_127_1 + var_127_3 and arg_124_1.time_ < var_127_1 + var_127_3 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_127_8 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_8.x, var_127_8.y, var_127_8.z)

				local var_127_9 = var_127_0.localEulerAngles

				var_127_9.z = 0
				var_127_9.x = 0
				var_127_0.localEulerAngles = var_127_9

				local var_127_10 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_10 then
					var_127_10:EnableDynamicBone(true)
				end
			end

			local var_127_11 = arg_124_1.actors_["121102ui_story"]
			local var_127_12 = 0

			if var_127_12 < arg_124_1.time_ and arg_124_1.time_ <= var_127_12 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect121102ui_story == nil then
				arg_124_1.var_.characterEffect121102ui_story = var_127_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_13 = 0.200000002980232

			if var_127_12 <= arg_124_1.time_ and arg_124_1.time_ < var_127_12 + var_127_13 and not isNil(var_127_11) then
				local var_127_14 = (arg_124_1.time_ - var_127_12) / var_127_13

				if arg_124_1.var_.characterEffect121102ui_story and not isNil(var_127_11) then
					arg_124_1.var_.characterEffect121102ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_12 + var_127_13 and arg_124_1.time_ < var_127_12 + var_127_13 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect121102ui_story then
				arg_124_1.var_.characterEffect121102ui_story.fillFlat = false
			end

			local var_127_15 = 0

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_127_16 = 0

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_127_17 = arg_124_1.actors_["614801ui_story"]
			local var_127_18 = 0

			if var_127_18 < arg_124_1.time_ and arg_124_1.time_ <= var_127_18 + arg_127_0 and not isNil(var_127_17) and arg_124_1.var_.characterEffect614801ui_story == nil then
				arg_124_1.var_.characterEffect614801ui_story = var_127_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_19 = 0.200000002980232

			if var_127_18 <= arg_124_1.time_ and arg_124_1.time_ < var_127_18 + var_127_19 and not isNil(var_127_17) then
				local var_127_20 = (arg_124_1.time_ - var_127_18) / var_127_19

				if arg_124_1.var_.characterEffect614801ui_story and not isNil(var_127_17) then
					local var_127_21 = Mathf.Lerp(0, 0.5, var_127_20)

					arg_124_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_124_1.var_.characterEffect614801ui_story.fillRatio = var_127_21
				end
			end

			if arg_124_1.time_ >= var_127_18 + var_127_19 and arg_124_1.time_ < var_127_18 + var_127_19 + arg_127_0 and not isNil(var_127_17) and arg_124_1.var_.characterEffect614801ui_story then
				local var_127_22 = 0.5

				arg_124_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_124_1.var_.characterEffect614801ui_story.fillRatio = var_127_22
			end

			local var_127_23 = 0
			local var_127_24 = 0.625

			if var_127_23 < arg_124_1.time_ and arg_124_1.time_ <= var_127_23 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_25 = arg_124_1:FormatText(StoryNameCfg[37].name)

				arg_124_1.leftNameTxt_.text = var_127_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_26 = arg_124_1:GetWordFromCfg(936041029)
				local var_127_27 = arg_124_1:FormatText(var_127_26.content)

				arg_124_1.text_.text = var_127_27

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_28 = 25
				local var_127_29 = utf8.len(var_127_27)
				local var_127_30 = var_127_28 <= 0 and var_127_24 or var_127_24 * (var_127_29 / var_127_28)

				if var_127_30 > 0 and var_127_24 < var_127_30 then
					arg_124_1.talkMaxDuration = var_127_30

					if var_127_30 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_30 + var_127_23
					end
				end

				arg_124_1.text_.text = var_127_27
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041029", "story_v_side_old_936041.awb") ~= 0 then
					local var_127_31 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041029", "story_v_side_old_936041.awb") / 1000

					if var_127_31 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_31 + var_127_23
					end

					if var_127_26.prefab_name ~= "" and arg_124_1.actors_[var_127_26.prefab_name] ~= nil then
						local var_127_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_26.prefab_name].transform, "story_v_side_old_936041", "936041029", "story_v_side_old_936041.awb")

						arg_124_1:RecordAudio("936041029", var_127_32)
						arg_124_1:RecordAudio("936041029", var_127_32)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041029", "story_v_side_old_936041.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041029", "story_v_side_old_936041.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_33 = math.max(var_127_24, arg_124_1.talkMaxDuration)

			if var_127_23 <= arg_124_1.time_ and arg_124_1.time_ < var_127_23 + var_127_33 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_23) / var_127_33

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_23 + var_127_33 and arg_124_1.time_ < var_127_23 + var_127_33 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play936041030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 936041030
		arg_128_1.duration_ = 4.87

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play936041031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["121102ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect121102ui_story == nil then
				arg_128_1.var_.characterEffect121102ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect121102ui_story and not isNil(var_131_0) then
					local var_131_4 = Mathf.Lerp(0, 0.5, var_131_3)

					arg_128_1.var_.characterEffect121102ui_story.fillFlat = true
					arg_128_1.var_.characterEffect121102ui_story.fillRatio = var_131_4
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect121102ui_story then
				local var_131_5 = 0.5

				arg_128_1.var_.characterEffect121102ui_story.fillFlat = true
				arg_128_1.var_.characterEffect121102ui_story.fillRatio = var_131_5
			end

			local var_131_6 = arg_128_1.actors_["614801ui_story"]
			local var_131_7 = 0

			if var_131_7 < arg_128_1.time_ and arg_128_1.time_ <= var_131_7 + arg_131_0 and not isNil(var_131_6) and arg_128_1.var_.characterEffect614801ui_story == nil then
				arg_128_1.var_.characterEffect614801ui_story = var_131_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_8 = 0.200000002980232

			if var_131_7 <= arg_128_1.time_ and arg_128_1.time_ < var_131_7 + var_131_8 and not isNil(var_131_6) then
				local var_131_9 = (arg_128_1.time_ - var_131_7) / var_131_8

				if arg_128_1.var_.characterEffect614801ui_story and not isNil(var_131_6) then
					arg_128_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_7 + var_131_8 and arg_128_1.time_ < var_131_7 + var_131_8 + arg_131_0 and not isNil(var_131_6) and arg_128_1.var_.characterEffect614801ui_story then
				arg_128_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_131_11 = 0

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_131_12 = 0
			local var_131_13 = 0.55

			if var_131_12 < arg_128_1.time_ and arg_128_1.time_ <= var_131_12 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_14 = arg_128_1:FormatText(StoryNameCfg[1488].name)

				arg_128_1.leftNameTxt_.text = var_131_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_15 = arg_128_1:GetWordFromCfg(936041030)
				local var_131_16 = arg_128_1:FormatText(var_131_15.content)

				arg_128_1.text_.text = var_131_16

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_17 = 22
				local var_131_18 = utf8.len(var_131_16)
				local var_131_19 = var_131_17 <= 0 and var_131_13 or var_131_13 * (var_131_18 / var_131_17)

				if var_131_19 > 0 and var_131_13 < var_131_19 then
					arg_128_1.talkMaxDuration = var_131_19

					if var_131_19 + var_131_12 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_19 + var_131_12
					end
				end

				arg_128_1.text_.text = var_131_16
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041030", "story_v_side_old_936041.awb") ~= 0 then
					local var_131_20 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041030", "story_v_side_old_936041.awb") / 1000

					if var_131_20 + var_131_12 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_20 + var_131_12
					end

					if var_131_15.prefab_name ~= "" and arg_128_1.actors_[var_131_15.prefab_name] ~= nil then
						local var_131_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_15.prefab_name].transform, "story_v_side_old_936041", "936041030", "story_v_side_old_936041.awb")

						arg_128_1:RecordAudio("936041030", var_131_21)
						arg_128_1:RecordAudio("936041030", var_131_21)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041030", "story_v_side_old_936041.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041030", "story_v_side_old_936041.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_22 = math.max(var_131_13, arg_128_1.talkMaxDuration)

			if var_131_12 <= arg_128_1.time_ and arg_128_1.time_ < var_131_12 + var_131_22 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_12) / var_131_22

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_12 + var_131_22 and arg_128_1.time_ < var_131_12 + var_131_22 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play936041031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 936041031
		arg_132_1.duration_ = 5.6

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play936041032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["105401ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos105401ui_story = var_135_0.localPosition

				local var_135_2 = GameObjectTools.GetOrAddComponent(var_135_0.gameObject, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(false)
				end
			end

			local var_135_3 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_3 then
				local var_135_4 = (arg_132_1.time_ - var_135_1) / var_135_3
				local var_135_5 = Vector3.New(0.7, -0.985, -6)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos105401ui_story, var_135_5, var_135_4)

				local var_135_6 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_6.x, var_135_6.y, var_135_6.z)

				local var_135_7 = var_135_0.localEulerAngles

				var_135_7.z = 0
				var_135_7.x = 0
				var_135_0.localEulerAngles = var_135_7
			end

			if arg_132_1.time_ >= var_135_1 + var_135_3 and arg_132_1.time_ < var_135_1 + var_135_3 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_135_8 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_8.x, var_135_8.y, var_135_8.z)

				local var_135_9 = var_135_0.localEulerAngles

				var_135_9.z = 0
				var_135_9.x = 0
				var_135_0.localEulerAngles = var_135_9

				local var_135_10 = GameObjectTools.GetOrAddComponent(var_135_0.gameObject, typeof(DynamicBoneHelper))

				if var_135_10 then
					var_135_10:EnableDynamicBone(true)
				end
			end

			local var_135_11 = arg_132_1.actors_["121102ui_story"].transform
			local var_135_12 = 0

			if var_135_12 < arg_132_1.time_ and arg_132_1.time_ <= var_135_12 + arg_135_0 then
				arg_132_1.var_.moveOldPos121102ui_story = var_135_11.localPosition

				local var_135_13 = GameObjectTools.GetOrAddComponent(var_135_11.gameObject, typeof(DynamicBoneHelper))

				if var_135_13 then
					var_135_13:EnableDynamicBone(false)
				end
			end

			local var_135_14 = 0.001

			if var_135_12 <= arg_132_1.time_ and arg_132_1.time_ < var_135_12 + var_135_14 then
				local var_135_15 = (arg_132_1.time_ - var_135_12) / var_135_14
				local var_135_16 = Vector3.New(0, 100, 0)

				var_135_11.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos121102ui_story, var_135_16, var_135_15)

				local var_135_17 = manager.ui.mainCamera.transform.position - var_135_11.position

				var_135_11.forward = Vector3.New(var_135_17.x, var_135_17.y, var_135_17.z)

				local var_135_18 = var_135_11.localEulerAngles

				var_135_18.z = 0
				var_135_18.x = 0
				var_135_11.localEulerAngles = var_135_18
			end

			if arg_132_1.time_ >= var_135_12 + var_135_14 and arg_132_1.time_ < var_135_12 + var_135_14 + arg_135_0 then
				var_135_11.localPosition = Vector3.New(0, 100, 0)

				local var_135_19 = manager.ui.mainCamera.transform.position - var_135_11.position

				var_135_11.forward = Vector3.New(var_135_19.x, var_135_19.y, var_135_19.z)

				local var_135_20 = var_135_11.localEulerAngles

				var_135_20.z = 0
				var_135_20.x = 0
				var_135_11.localEulerAngles = var_135_20

				local var_135_21 = GameObjectTools.GetOrAddComponent(var_135_11.gameObject, typeof(DynamicBoneHelper))

				if var_135_21 then
					var_135_21:EnableDynamicBone(true)
				end
			end

			local var_135_22 = arg_132_1.actors_["105401ui_story"]
			local var_135_23 = 0

			if var_135_23 < arg_132_1.time_ and arg_132_1.time_ <= var_135_23 + arg_135_0 and not isNil(var_135_22) and arg_132_1.var_.characterEffect105401ui_story == nil then
				arg_132_1.var_.characterEffect105401ui_story = var_135_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_24 = 0.200000002980232

			if var_135_23 <= arg_132_1.time_ and arg_132_1.time_ < var_135_23 + var_135_24 and not isNil(var_135_22) then
				local var_135_25 = (arg_132_1.time_ - var_135_23) / var_135_24

				if arg_132_1.var_.characterEffect105401ui_story and not isNil(var_135_22) then
					arg_132_1.var_.characterEffect105401ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_23 + var_135_24 and arg_132_1.time_ < var_135_23 + var_135_24 + arg_135_0 and not isNil(var_135_22) and arg_132_1.var_.characterEffect105401ui_story then
				arg_132_1.var_.characterEffect105401ui_story.fillFlat = false
			end

			local var_135_26 = arg_132_1.actors_["614801ui_story"]
			local var_135_27 = 0

			if var_135_27 < arg_132_1.time_ and arg_132_1.time_ <= var_135_27 + arg_135_0 and not isNil(var_135_26) and arg_132_1.var_.characterEffect614801ui_story == nil then
				arg_132_1.var_.characterEffect614801ui_story = var_135_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_28 = 0.200000002980232

			if var_135_27 <= arg_132_1.time_ and arg_132_1.time_ < var_135_27 + var_135_28 and not isNil(var_135_26) then
				local var_135_29 = (arg_132_1.time_ - var_135_27) / var_135_28

				if arg_132_1.var_.characterEffect614801ui_story and not isNil(var_135_26) then
					local var_135_30 = Mathf.Lerp(0, 0.5, var_135_29)

					arg_132_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_132_1.var_.characterEffect614801ui_story.fillRatio = var_135_30
				end
			end

			if arg_132_1.time_ >= var_135_27 + var_135_28 and arg_132_1.time_ < var_135_27 + var_135_28 + arg_135_0 and not isNil(var_135_26) and arg_132_1.var_.characterEffect614801ui_story then
				local var_135_31 = 0.5

				arg_132_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_132_1.var_.characterEffect614801ui_story.fillRatio = var_135_31
			end

			local var_135_32 = 0

			if var_135_32 < arg_132_1.time_ and arg_132_1.time_ <= var_135_32 + arg_135_0 then
				arg_132_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_135_33 = 0

			if var_135_33 < arg_132_1.time_ and arg_132_1.time_ <= var_135_33 + arg_135_0 then
				arg_132_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_135_34 = 0
			local var_135_35 = 0.575

			if var_135_34 < arg_132_1.time_ and arg_132_1.time_ <= var_135_34 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_36 = arg_132_1:FormatText(StoryNameCfg[1487].name)

				arg_132_1.leftNameTxt_.text = var_135_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_37 = arg_132_1:GetWordFromCfg(936041031)
				local var_135_38 = arg_132_1:FormatText(var_135_37.content)

				arg_132_1.text_.text = var_135_38

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_39 = 23
				local var_135_40 = utf8.len(var_135_38)
				local var_135_41 = var_135_39 <= 0 and var_135_35 or var_135_35 * (var_135_40 / var_135_39)

				if var_135_41 > 0 and var_135_35 < var_135_41 then
					arg_132_1.talkMaxDuration = var_135_41

					if var_135_41 + var_135_34 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_41 + var_135_34
					end
				end

				arg_132_1.text_.text = var_135_38
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041031", "story_v_side_old_936041.awb") ~= 0 then
					local var_135_42 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041031", "story_v_side_old_936041.awb") / 1000

					if var_135_42 + var_135_34 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_42 + var_135_34
					end

					if var_135_37.prefab_name ~= "" and arg_132_1.actors_[var_135_37.prefab_name] ~= nil then
						local var_135_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_37.prefab_name].transform, "story_v_side_old_936041", "936041031", "story_v_side_old_936041.awb")

						arg_132_1:RecordAudio("936041031", var_135_43)
						arg_132_1:RecordAudio("936041031", var_135_43)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041031", "story_v_side_old_936041.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041031", "story_v_side_old_936041.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_44 = math.max(var_135_35, arg_132_1.talkMaxDuration)

			if var_135_34 <= arg_132_1.time_ and arg_132_1.time_ < var_135_34 + var_135_44 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_34) / var_135_44

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_34 + var_135_44 and arg_132_1.time_ < var_135_34 + var_135_44 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "121102ui_story",
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
	Play936041032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 936041032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play936041033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["614801ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos614801ui_story = var_139_0.localPosition

				local var_139_2 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(false)
				end
			end

			local var_139_3 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_3 then
				local var_139_4 = (arg_136_1.time_ - var_139_1) / var_139_3
				local var_139_5 = Vector3.New(0, 100, 0)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos614801ui_story, var_139_5, var_139_4)

				local var_139_6 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_6.x, var_139_6.y, var_139_6.z)

				local var_139_7 = var_139_0.localEulerAngles

				var_139_7.z = 0
				var_139_7.x = 0
				var_139_0.localEulerAngles = var_139_7
			end

			if arg_136_1.time_ >= var_139_1 + var_139_3 and arg_136_1.time_ < var_139_1 + var_139_3 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, 100, 0)

				local var_139_8 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_8.x, var_139_8.y, var_139_8.z)

				local var_139_9 = var_139_0.localEulerAngles

				var_139_9.z = 0
				var_139_9.x = 0
				var_139_0.localEulerAngles = var_139_9

				local var_139_10 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_10 then
					var_139_10:EnableDynamicBone(true)
				end
			end

			local var_139_11 = arg_136_1.actors_["105401ui_story"].transform
			local var_139_12 = 0

			if var_139_12 < arg_136_1.time_ and arg_136_1.time_ <= var_139_12 + arg_139_0 then
				arg_136_1.var_.moveOldPos105401ui_story = var_139_11.localPosition

				local var_139_13 = GameObjectTools.GetOrAddComponent(var_139_11.gameObject, typeof(DynamicBoneHelper))

				if var_139_13 then
					var_139_13:EnableDynamicBone(false)
				end
			end

			local var_139_14 = 0.001

			if var_139_12 <= arg_136_1.time_ and arg_136_1.time_ < var_139_12 + var_139_14 then
				local var_139_15 = (arg_136_1.time_ - var_139_12) / var_139_14
				local var_139_16 = Vector3.New(0, 100, 0)

				var_139_11.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos105401ui_story, var_139_16, var_139_15)

				local var_139_17 = manager.ui.mainCamera.transform.position - var_139_11.position

				var_139_11.forward = Vector3.New(var_139_17.x, var_139_17.y, var_139_17.z)

				local var_139_18 = var_139_11.localEulerAngles

				var_139_18.z = 0
				var_139_18.x = 0
				var_139_11.localEulerAngles = var_139_18
			end

			if arg_136_1.time_ >= var_139_12 + var_139_14 and arg_136_1.time_ < var_139_12 + var_139_14 + arg_139_0 then
				var_139_11.localPosition = Vector3.New(0, 100, 0)

				local var_139_19 = manager.ui.mainCamera.transform.position - var_139_11.position

				var_139_11.forward = Vector3.New(var_139_19.x, var_139_19.y, var_139_19.z)

				local var_139_20 = var_139_11.localEulerAngles

				var_139_20.z = 0
				var_139_20.x = 0
				var_139_11.localEulerAngles = var_139_20

				local var_139_21 = GameObjectTools.GetOrAddComponent(var_139_11.gameObject, typeof(DynamicBoneHelper))

				if var_139_21 then
					var_139_21:EnableDynamicBone(true)
				end
			end

			local var_139_22 = arg_136_1.actors_["614801ui_story"]
			local var_139_23 = 0

			if var_139_23 < arg_136_1.time_ and arg_136_1.time_ <= var_139_23 + arg_139_0 and not isNil(var_139_22) and arg_136_1.var_.characterEffect614801ui_story == nil then
				arg_136_1.var_.characterEffect614801ui_story = var_139_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_24 = 0.200000002980232

			if var_139_23 <= arg_136_1.time_ and arg_136_1.time_ < var_139_23 + var_139_24 and not isNil(var_139_22) then
				local var_139_25 = (arg_136_1.time_ - var_139_23) / var_139_24

				if arg_136_1.var_.characterEffect614801ui_story and not isNil(var_139_22) then
					local var_139_26 = Mathf.Lerp(0, 0.5, var_139_25)

					arg_136_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_136_1.var_.characterEffect614801ui_story.fillRatio = var_139_26
				end
			end

			if arg_136_1.time_ >= var_139_23 + var_139_24 and arg_136_1.time_ < var_139_23 + var_139_24 + arg_139_0 and not isNil(var_139_22) and arg_136_1.var_.characterEffect614801ui_story then
				local var_139_27 = 0.5

				arg_136_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_136_1.var_.characterEffect614801ui_story.fillRatio = var_139_27
			end

			local var_139_28 = 0
			local var_139_29 = 1.375

			if var_139_28 < arg_136_1.time_ and arg_136_1.time_ <= var_139_28 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_30 = arg_136_1:GetWordFromCfg(936041032)
				local var_139_31 = arg_136_1:FormatText(var_139_30.content)

				arg_136_1.text_.text = var_139_31

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_32 = 55
				local var_139_33 = utf8.len(var_139_31)
				local var_139_34 = var_139_32 <= 0 and var_139_29 or var_139_29 * (var_139_33 / var_139_32)

				if var_139_34 > 0 and var_139_29 < var_139_34 then
					arg_136_1.talkMaxDuration = var_139_34

					if var_139_34 + var_139_28 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_34 + var_139_28
					end
				end

				arg_136_1.text_.text = var_139_31
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_35 = math.max(var_139_29, arg_136_1.talkMaxDuration)

			if var_139_28 <= arg_136_1.time_ and arg_136_1.time_ < var_139_28 + var_139_35 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_28) / var_139_35

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_28 + var_139_35 and arg_136_1.time_ < var_139_28 + var_139_35 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105401ui_story",
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
	Play936041033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 936041033
		arg_140_1.duration_ = 2.17

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play936041034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["104402ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos104402ui_story = var_143_0.localPosition

				local var_143_2 = GameObjectTools.GetOrAddComponent(var_143_0.gameObject, typeof(DynamicBoneHelper))

				if var_143_2 then
					var_143_2:EnableDynamicBone(false)
				end
			end

			local var_143_3 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_3 then
				local var_143_4 = (arg_140_1.time_ - var_143_1) / var_143_3
				local var_143_5 = Vector3.New(0, -1, -5.93)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos104402ui_story, var_143_5, var_143_4)

				local var_143_6 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_6.x, var_143_6.y, var_143_6.z)

				local var_143_7 = var_143_0.localEulerAngles

				var_143_7.z = 0
				var_143_7.x = 0
				var_143_0.localEulerAngles = var_143_7
			end

			if arg_140_1.time_ >= var_143_1 + var_143_3 and arg_140_1.time_ < var_143_1 + var_143_3 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_143_8 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_8.x, var_143_8.y, var_143_8.z)

				local var_143_9 = var_143_0.localEulerAngles

				var_143_9.z = 0
				var_143_9.x = 0
				var_143_0.localEulerAngles = var_143_9

				local var_143_10 = GameObjectTools.GetOrAddComponent(var_143_0.gameObject, typeof(DynamicBoneHelper))

				if var_143_10 then
					var_143_10:EnableDynamicBone(true)
				end
			end

			local var_143_11 = arg_140_1.actors_["104402ui_story"]
			local var_143_12 = 0

			if var_143_12 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 and not isNil(var_143_11) and arg_140_1.var_.characterEffect104402ui_story == nil then
				arg_140_1.var_.characterEffect104402ui_story = var_143_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_13 = 0.200000002980232

			if var_143_12 <= arg_140_1.time_ and arg_140_1.time_ < var_143_12 + var_143_13 and not isNil(var_143_11) then
				local var_143_14 = (arg_140_1.time_ - var_143_12) / var_143_13

				if arg_140_1.var_.characterEffect104402ui_story and not isNil(var_143_11) then
					arg_140_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_12 + var_143_13 and arg_140_1.time_ < var_143_12 + var_143_13 + arg_143_0 and not isNil(var_143_11) and arg_140_1.var_.characterEffect104402ui_story then
				arg_140_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_143_15 = 0

			if var_143_15 < arg_140_1.time_ and arg_140_1.time_ <= var_143_15 + arg_143_0 then
				arg_140_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			local var_143_16 = 0

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 then
				arg_140_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_143_17 = 0
			local var_143_18 = 0.4

			if var_143_17 < arg_140_1.time_ and arg_140_1.time_ <= var_143_17 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_19 = arg_140_1:FormatText(StoryNameCfg[1367].name)

				arg_140_1.leftNameTxt_.text = var_143_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_20 = arg_140_1:GetWordFromCfg(936041033)
				local var_143_21 = arg_140_1:FormatText(var_143_20.content)

				arg_140_1.text_.text = var_143_21

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_22 = 16
				local var_143_23 = utf8.len(var_143_21)
				local var_143_24 = var_143_22 <= 0 and var_143_18 or var_143_18 * (var_143_23 / var_143_22)

				if var_143_24 > 0 and var_143_18 < var_143_24 then
					arg_140_1.talkMaxDuration = var_143_24

					if var_143_24 + var_143_17 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_24 + var_143_17
					end
				end

				arg_140_1.text_.text = var_143_21
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041033", "story_v_side_old_936041.awb") ~= 0 then
					local var_143_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041033", "story_v_side_old_936041.awb") / 1000

					if var_143_25 + var_143_17 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_25 + var_143_17
					end

					if var_143_20.prefab_name ~= "" and arg_140_1.actors_[var_143_20.prefab_name] ~= nil then
						local var_143_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_20.prefab_name].transform, "story_v_side_old_936041", "936041033", "story_v_side_old_936041.awb")

						arg_140_1:RecordAudio("936041033", var_143_26)
						arg_140_1:RecordAudio("936041033", var_143_26)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041033", "story_v_side_old_936041.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041033", "story_v_side_old_936041.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_27 = math.max(var_143_18, arg_140_1.talkMaxDuration)

			if var_143_17 <= arg_140_1.time_ and arg_140_1.time_ < var_143_17 + var_143_27 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_17) / var_143_27

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_17 + var_143_27 and arg_140_1.time_ < var_143_17 + var_143_27 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
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
	Play936041034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 936041034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play936041035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["104402ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos104402ui_story = var_147_0.localPosition

				local var_147_2 = GameObjectTools.GetOrAddComponent(var_147_0.gameObject, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(false)
				end
			end

			local var_147_3 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_3 then
				local var_147_4 = (arg_144_1.time_ - var_147_1) / var_147_3
				local var_147_5 = Vector3.New(0, 100, 0)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos104402ui_story, var_147_5, var_147_4)

				local var_147_6 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_6.x, var_147_6.y, var_147_6.z)

				local var_147_7 = var_147_0.localEulerAngles

				var_147_7.z = 0
				var_147_7.x = 0
				var_147_0.localEulerAngles = var_147_7
			end

			if arg_144_1.time_ >= var_147_1 + var_147_3 and arg_144_1.time_ < var_147_1 + var_147_3 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, 100, 0)

				local var_147_8 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_8.x, var_147_8.y, var_147_8.z)

				local var_147_9 = var_147_0.localEulerAngles

				var_147_9.z = 0
				var_147_9.x = 0
				var_147_0.localEulerAngles = var_147_9

				local var_147_10 = GameObjectTools.GetOrAddComponent(var_147_0.gameObject, typeof(DynamicBoneHelper))

				if var_147_10 then
					var_147_10:EnableDynamicBone(true)
				end
			end

			local var_147_11 = arg_144_1.actors_["104402ui_story"]
			local var_147_12 = 0

			if var_147_12 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 and not isNil(var_147_11) and arg_144_1.var_.characterEffect104402ui_story == nil then
				arg_144_1.var_.characterEffect104402ui_story = var_147_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_13 = 0.200000002980232

			if var_147_12 <= arg_144_1.time_ and arg_144_1.time_ < var_147_12 + var_147_13 and not isNil(var_147_11) then
				local var_147_14 = (arg_144_1.time_ - var_147_12) / var_147_13

				if arg_144_1.var_.characterEffect104402ui_story and not isNil(var_147_11) then
					local var_147_15 = Mathf.Lerp(0, 0.5, var_147_14)

					arg_144_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_144_1.var_.characterEffect104402ui_story.fillRatio = var_147_15
				end
			end

			if arg_144_1.time_ >= var_147_12 + var_147_13 and arg_144_1.time_ < var_147_12 + var_147_13 + arg_147_0 and not isNil(var_147_11) and arg_144_1.var_.characterEffect104402ui_story then
				local var_147_16 = 0.5

				arg_144_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_144_1.var_.characterEffect104402ui_story.fillRatio = var_147_16
			end

			local var_147_17 = 0.034000001847744
			local var_147_18 = 0.3

			if var_147_17 < arg_144_1.time_ and arg_144_1.time_ <= var_147_17 + arg_147_0 then
				local var_147_19 = "play"
				local var_147_20 = "music"

				arg_144_1:AudioAction(var_147_19, var_147_20, "ui_battle", "ui_battle_stopbgm", "")

				local var_147_21 = ""
				local var_147_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_147_22 ~= "" then
					if arg_144_1.bgmTxt_.text ~= var_147_22 and arg_144_1.bgmTxt_.text ~= "" then
						if arg_144_1.bgmTxt2_.text ~= "" then
							arg_144_1.bgmTxt_.text = arg_144_1.bgmTxt2_.text
						end

						arg_144_1.bgmTxt2_.text = var_147_22

						arg_144_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_144_1.bgmTxt_.text = var_147_22
						arg_144_1.bgmTxt2_.text = var_147_22
					end

					if arg_144_1.bgmTimer then
						arg_144_1.bgmTimer:Stop()

						arg_144_1.bgmTimer = nil
					end

					if arg_144_1.settingData.show_music_name == 1 then
						arg_144_1.musicController:SetSelectedState("show")
						arg_144_1.musicAnimator_:Play("open", 0, 0)

						if arg_144_1.settingData.music_time ~= 0 then
							arg_144_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_144_1.settingData.music_time), function()
								if arg_144_1 == nil or isNil(arg_144_1.bgmTxt_) then
									return
								end

								arg_144_1.musicController:SetSelectedState("hide")
								arg_144_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_147_23 = 0
			local var_147_24 = 1.325

			if var_147_23 < arg_144_1.time_ and arg_144_1.time_ <= var_147_23 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_25 = arg_144_1:GetWordFromCfg(936041034)
				local var_147_26 = arg_144_1:FormatText(var_147_25.content)

				arg_144_1.text_.text = var_147_26

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_27 = 53
				local var_147_28 = utf8.len(var_147_26)
				local var_147_29 = var_147_27 <= 0 and var_147_24 or var_147_24 * (var_147_28 / var_147_27)

				if var_147_29 > 0 and var_147_24 < var_147_29 then
					arg_144_1.talkMaxDuration = var_147_29

					if var_147_29 + var_147_23 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_29 + var_147_23
					end
				end

				arg_144_1.text_.text = var_147_26
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_30 = math.max(var_147_24, arg_144_1.talkMaxDuration)

			if var_147_23 <= arg_144_1.time_ and arg_144_1.time_ < var_147_23 + var_147_30 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_23) / var_147_30

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_23 + var_147_30 and arg_144_1.time_ < var_147_23 + var_147_30 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
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
	Play936041035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 936041035
		arg_149_1.duration_ = 8.67

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play936041036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = "ST15a"

			if arg_149_1.bgs_[var_152_0] == nil then
				local var_152_1 = Object.Instantiate(arg_149_1.paintGo_)

				var_152_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_152_0)
				var_152_1.name = var_152_0
				var_152_1.transform.parent = arg_149_1.stage_.transform
				var_152_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.bgs_[var_152_0] = var_152_1
			end

			local var_152_2 = 2

			if var_152_2 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				local var_152_3 = manager.ui.mainCamera.transform.localPosition
				local var_152_4 = Vector3.New(0, 0, 10) + Vector3.New(var_152_3.x, var_152_3.y, 0)
				local var_152_5 = arg_149_1.bgs_.ST15a

				var_152_5.transform.localPosition = var_152_4
				var_152_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_6 = var_152_5:GetComponent("SpriteRenderer")

				if var_152_6 and var_152_6.sprite then
					local var_152_7 = (var_152_5.transform.localPosition - var_152_3).z
					local var_152_8 = manager.ui.mainCameraCom_
					local var_152_9 = 2 * var_152_7 * Mathf.Tan(var_152_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_152_10 = var_152_9 * var_152_8.aspect
					local var_152_11 = var_152_6.sprite.bounds.size.x
					local var_152_12 = var_152_6.sprite.bounds.size.y
					local var_152_13 = var_152_10 / var_152_11
					local var_152_14 = var_152_9 / var_152_12
					local var_152_15 = var_152_14 < var_152_13 and var_152_13 or var_152_14

					var_152_5.transform.localScale = Vector3.New(var_152_15, var_152_15, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "ST15a" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_16 = 4.00000000298023

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			local var_152_17 = 0.3

			if arg_149_1.time_ >= var_152_16 + var_152_17 and arg_149_1.time_ < var_152_16 + var_152_17 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end

			local var_152_18 = 0

			if var_152_18 < arg_149_1.time_ and arg_149_1.time_ <= var_152_18 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_19 = 2

			if var_152_18 <= arg_149_1.time_ and arg_149_1.time_ < var_152_18 + var_152_19 then
				local var_152_20 = (arg_149_1.time_ - var_152_18) / var_152_19
				local var_152_21 = Color.New(0, 0, 0)

				var_152_21.a = Mathf.Lerp(0, 1, var_152_20)
				arg_149_1.mask_.color = var_152_21
			end

			if arg_149_1.time_ >= var_152_18 + var_152_19 and arg_149_1.time_ < var_152_18 + var_152_19 + arg_152_0 then
				local var_152_22 = Color.New(0, 0, 0)

				var_152_22.a = 1
				arg_149_1.mask_.color = var_152_22
			end

			local var_152_23 = 2

			if var_152_23 < arg_149_1.time_ and arg_149_1.time_ <= var_152_23 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_24 = 2

			if var_152_23 <= arg_149_1.time_ and arg_149_1.time_ < var_152_23 + var_152_24 then
				local var_152_25 = (arg_149_1.time_ - var_152_23) / var_152_24
				local var_152_26 = Color.New(0, 0, 0)

				var_152_26.a = Mathf.Lerp(1, 0, var_152_25)
				arg_149_1.mask_.color = var_152_26
			end

			if arg_149_1.time_ >= var_152_23 + var_152_24 and arg_149_1.time_ < var_152_23 + var_152_24 + arg_152_0 then
				local var_152_27 = Color.New(0, 0, 0)
				local var_152_28 = 0

				arg_149_1.mask_.enabled = false
				var_152_27.a = var_152_28
				arg_149_1.mask_.color = var_152_27
			end

			local var_152_29 = arg_149_1.actors_["104402ui_story"].transform
			local var_152_30 = 3.8

			if var_152_30 < arg_149_1.time_ and arg_149_1.time_ <= var_152_30 + arg_152_0 then
				arg_149_1.var_.moveOldPos104402ui_story = var_152_29.localPosition

				local var_152_31 = GameObjectTools.GetOrAddComponent(var_152_29.gameObject, typeof(DynamicBoneHelper))

				if var_152_31 then
					var_152_31:EnableDynamicBone(false)
				end
			end

			local var_152_32 = 0.001

			if var_152_30 <= arg_149_1.time_ and arg_149_1.time_ < var_152_30 + var_152_32 then
				local var_152_33 = (arg_149_1.time_ - var_152_30) / var_152_32
				local var_152_34 = Vector3.New(0, -1, -5.93)

				var_152_29.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos104402ui_story, var_152_34, var_152_33)

				local var_152_35 = manager.ui.mainCamera.transform.position - var_152_29.position

				var_152_29.forward = Vector3.New(var_152_35.x, var_152_35.y, var_152_35.z)

				local var_152_36 = var_152_29.localEulerAngles

				var_152_36.z = 0
				var_152_36.x = 0
				var_152_29.localEulerAngles = var_152_36
			end

			if arg_149_1.time_ >= var_152_30 + var_152_32 and arg_149_1.time_ < var_152_30 + var_152_32 + arg_152_0 then
				var_152_29.localPosition = Vector3.New(0, -1, -5.93)

				local var_152_37 = manager.ui.mainCamera.transform.position - var_152_29.position

				var_152_29.forward = Vector3.New(var_152_37.x, var_152_37.y, var_152_37.z)

				local var_152_38 = var_152_29.localEulerAngles

				var_152_38.z = 0
				var_152_38.x = 0
				var_152_29.localEulerAngles = var_152_38

				local var_152_39 = GameObjectTools.GetOrAddComponent(var_152_29.gameObject, typeof(DynamicBoneHelper))

				if var_152_39 then
					var_152_39:EnableDynamicBone(true)
				end
			end

			local var_152_40 = arg_149_1.actors_["104402ui_story"]
			local var_152_41 = 3.8

			if var_152_41 < arg_149_1.time_ and arg_149_1.time_ <= var_152_41 + arg_152_0 and not isNil(var_152_40) and arg_149_1.var_.characterEffect104402ui_story == nil then
				arg_149_1.var_.characterEffect104402ui_story = var_152_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_42 = 0.200000002980232

			if var_152_41 <= arg_149_1.time_ and arg_149_1.time_ < var_152_41 + var_152_42 and not isNil(var_152_40) then
				local var_152_43 = (arg_149_1.time_ - var_152_41) / var_152_42

				if arg_149_1.var_.characterEffect104402ui_story and not isNil(var_152_40) then
					arg_149_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_41 + var_152_42 and arg_149_1.time_ < var_152_41 + var_152_42 + arg_152_0 and not isNil(var_152_40) and arg_149_1.var_.characterEffect104402ui_story then
				arg_149_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_152_44 = 3.8

			if var_152_44 < arg_149_1.time_ and arg_149_1.time_ <= var_152_44 + arg_152_0 then
				arg_149_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			local var_152_45 = 3.8

			if var_152_45 < arg_149_1.time_ and arg_149_1.time_ <= var_152_45 + arg_152_0 then
				arg_149_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_152_46 = 1.63333333333333
			local var_152_47 = 1

			if var_152_46 < arg_149_1.time_ and arg_149_1.time_ <= var_152_46 + arg_152_0 then
				local var_152_48 = "play"
				local var_152_49 = "music"

				arg_149_1:AudioAction(var_152_48, var_152_49, "bgm_activity_5_0_scene_104402_story", "bgm_activity_5_0_scene_104402_story", "bgm_activity_5_0_scene_104402_story.awb")

				local var_152_50 = ""
				local var_152_51 = manager.audio:GetAudioName("bgm_activity_5_0_scene_104402_story", "bgm_activity_5_0_scene_104402_story")

				if var_152_51 ~= "" then
					if arg_149_1.bgmTxt_.text ~= var_152_51 and arg_149_1.bgmTxt_.text ~= "" then
						if arg_149_1.bgmTxt2_.text ~= "" then
							arg_149_1.bgmTxt_.text = arg_149_1.bgmTxt2_.text
						end

						arg_149_1.bgmTxt2_.text = var_152_51

						arg_149_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_149_1.bgmTxt_.text = var_152_51
						arg_149_1.bgmTxt2_.text = var_152_51
					end

					if arg_149_1.bgmTimer then
						arg_149_1.bgmTimer:Stop()

						arg_149_1.bgmTimer = nil
					end

					if arg_149_1.settingData.show_music_name == 1 then
						arg_149_1.musicController:SetSelectedState("show")
						arg_149_1.musicAnimator_:Play("open", 0, 0)

						if arg_149_1.settingData.music_time ~= 0 then
							arg_149_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_149_1.settingData.music_time), function()
								if arg_149_1 == nil or isNil(arg_149_1.bgmTxt_) then
									return
								end

								arg_149_1.musicController:SetSelectedState("hide")
								arg_149_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_152_52 = 0.133333333333333
			local var_152_53 = 1

			if var_152_52 < arg_149_1.time_ and arg_149_1.time_ <= var_152_52 + arg_152_0 then
				local var_152_54 = "stop"
				local var_152_55 = "effect"

				arg_149_1:AudioAction(var_152_54, var_152_55, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_152_56 = 1.63333333333333
			local var_152_57 = 1

			if var_152_56 < arg_149_1.time_ and arg_149_1.time_ <= var_152_56 + arg_152_0 then
				local var_152_58 = "play"
				local var_152_59 = "effect"

				arg_149_1:AudioAction(var_152_58, var_152_59, "se_story_side_1095", "se_story_side_1095_amb_beach_night", "")
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_60 = 4.00000000298023
			local var_152_61 = 0.55

			if var_152_60 < arg_149_1.time_ and arg_149_1.time_ <= var_152_60 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_62 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_62:setOnUpdate(LuaHelper.FloatAction(function(arg_154_0)
					arg_149_1.dialogCg_.alpha = arg_154_0
				end))
				var_152_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_63 = arg_149_1:FormatText(StoryNameCfg[1367].name)

				arg_149_1.leftNameTxt_.text = var_152_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_64 = arg_149_1:GetWordFromCfg(936041035)
				local var_152_65 = arg_149_1:FormatText(var_152_64.content)

				arg_149_1.text_.text = var_152_65

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_66 = 22
				local var_152_67 = utf8.len(var_152_65)
				local var_152_68 = var_152_66 <= 0 and var_152_61 or var_152_61 * (var_152_67 / var_152_66)

				if var_152_68 > 0 and var_152_61 < var_152_68 then
					arg_149_1.talkMaxDuration = var_152_68
					var_152_60 = var_152_60 + 0.3

					if var_152_68 + var_152_60 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_68 + var_152_60
					end
				end

				arg_149_1.text_.text = var_152_65
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041035", "story_v_side_old_936041.awb") ~= 0 then
					local var_152_69 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041035", "story_v_side_old_936041.awb") / 1000

					if var_152_69 + var_152_60 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_69 + var_152_60
					end

					if var_152_64.prefab_name ~= "" and arg_149_1.actors_[var_152_64.prefab_name] ~= nil then
						local var_152_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_64.prefab_name].transform, "story_v_side_old_936041", "936041035", "story_v_side_old_936041.awb")

						arg_149_1:RecordAudio("936041035", var_152_70)
						arg_149_1:RecordAudio("936041035", var_152_70)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041035", "story_v_side_old_936041.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041035", "story_v_side_old_936041.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_71 = var_152_60 + 0.3
			local var_152_72 = math.max(var_152_61, arg_149_1.talkMaxDuration)

			if var_152_71 <= arg_149_1.time_ and arg_149_1.time_ < var_152_71 + var_152_72 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_71) / var_152_72

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_71 + var_152_72 and arg_149_1.time_ < var_152_71 + var_152_72 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play936041036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 936041036
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play936041037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["104402ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos104402ui_story = var_159_0.localPosition

				local var_159_2 = GameObjectTools.GetOrAddComponent(var_159_0.gameObject, typeof(DynamicBoneHelper))

				if var_159_2 then
					var_159_2:EnableDynamicBone(false)
				end
			end

			local var_159_3 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_3 then
				local var_159_4 = (arg_156_1.time_ - var_159_1) / var_159_3
				local var_159_5 = Vector3.New(0, 100, 0)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos104402ui_story, var_159_5, var_159_4)

				local var_159_6 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_6.x, var_159_6.y, var_159_6.z)

				local var_159_7 = var_159_0.localEulerAngles

				var_159_7.z = 0
				var_159_7.x = 0
				var_159_0.localEulerAngles = var_159_7
			end

			if arg_156_1.time_ >= var_159_1 + var_159_3 and arg_156_1.time_ < var_159_1 + var_159_3 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0, 100, 0)

				local var_159_8 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_8.x, var_159_8.y, var_159_8.z)

				local var_159_9 = var_159_0.localEulerAngles

				var_159_9.z = 0
				var_159_9.x = 0
				var_159_0.localEulerAngles = var_159_9

				local var_159_10 = GameObjectTools.GetOrAddComponent(var_159_0.gameObject, typeof(DynamicBoneHelper))

				if var_159_10 then
					var_159_10:EnableDynamicBone(true)
				end
			end

			local var_159_11 = arg_156_1.actors_["104402ui_story"]
			local var_159_12 = 0

			if var_159_12 < arg_156_1.time_ and arg_156_1.time_ <= var_159_12 + arg_159_0 and not isNil(var_159_11) and arg_156_1.var_.characterEffect104402ui_story == nil then
				arg_156_1.var_.characterEffect104402ui_story = var_159_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_13 = 0.200000002980232

			if var_159_12 <= arg_156_1.time_ and arg_156_1.time_ < var_159_12 + var_159_13 and not isNil(var_159_11) then
				local var_159_14 = (arg_156_1.time_ - var_159_12) / var_159_13

				if arg_156_1.var_.characterEffect104402ui_story and not isNil(var_159_11) then
					local var_159_15 = Mathf.Lerp(0, 0.5, var_159_14)

					arg_156_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_156_1.var_.characterEffect104402ui_story.fillRatio = var_159_15
				end
			end

			if arg_156_1.time_ >= var_159_12 + var_159_13 and arg_156_1.time_ < var_159_12 + var_159_13 + arg_159_0 and not isNil(var_159_11) and arg_156_1.var_.characterEffect104402ui_story then
				local var_159_16 = 0.5

				arg_156_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_156_1.var_.characterEffect104402ui_story.fillRatio = var_159_16
			end

			local var_159_17 = 0
			local var_159_18 = 0.975

			if var_159_17 < arg_156_1.time_ and arg_156_1.time_ <= var_159_17 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_19 = arg_156_1:GetWordFromCfg(936041036)
				local var_159_20 = arg_156_1:FormatText(var_159_19.content)

				arg_156_1.text_.text = var_159_20

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_21 = 39
				local var_159_22 = utf8.len(var_159_20)
				local var_159_23 = var_159_21 <= 0 and var_159_18 or var_159_18 * (var_159_22 / var_159_21)

				if var_159_23 > 0 and var_159_18 < var_159_23 then
					arg_156_1.talkMaxDuration = var_159_23

					if var_159_23 + var_159_17 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_23 + var_159_17
					end
				end

				arg_156_1.text_.text = var_159_20
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_24 = math.max(var_159_18, arg_156_1.talkMaxDuration)

			if var_159_17 <= arg_156_1.time_ and arg_156_1.time_ < var_159_17 + var_159_24 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_17) / var_159_24

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_17 + var_159_24 and arg_156_1.time_ < var_159_17 + var_159_24 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
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
	Play936041037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 936041037
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play936041038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.6
			local var_163_1 = 1

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				local var_163_2 = "play"
				local var_163_3 = "effect"

				arg_160_1:AudioAction(var_163_2, var_163_3, "se_story_150", "se_story_150_footstep_slow", "")
			end

			local var_163_4 = 0
			local var_163_5 = 1.45

			if var_163_4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_6 = arg_160_1:GetWordFromCfg(936041037)
				local var_163_7 = arg_160_1:FormatText(var_163_6.content)

				arg_160_1.text_.text = var_163_7

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_8 = 58
				local var_163_9 = utf8.len(var_163_7)
				local var_163_10 = var_163_8 <= 0 and var_163_5 or var_163_5 * (var_163_9 / var_163_8)

				if var_163_10 > 0 and var_163_5 < var_163_10 then
					arg_160_1.talkMaxDuration = var_163_10

					if var_163_10 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_10 + var_163_4
					end
				end

				arg_160_1.text_.text = var_163_7
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_11 = math.max(var_163_5, arg_160_1.talkMaxDuration)

			if var_163_4 <= arg_160_1.time_ and arg_160_1.time_ < var_163_4 + var_163_11 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_4) / var_163_11

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_4 + var_163_11 and arg_160_1.time_ < var_163_4 + var_163_11 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play936041038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 936041038
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play936041039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 1.075

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[7].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_3 = arg_164_1:GetWordFromCfg(936041038)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 43
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_8 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_8 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_8

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_8 and arg_164_1.time_ < var_167_0 + var_167_8 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play936041039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 936041039
		arg_168_1.duration_ = 5.53

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play936041040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["104402ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos104402ui_story = var_171_0.localPosition

				local var_171_2 = GameObjectTools.GetOrAddComponent(var_171_0.gameObject, typeof(DynamicBoneHelper))

				if var_171_2 then
					var_171_2:EnableDynamicBone(false)
				end
			end

			local var_171_3 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_3 then
				local var_171_4 = (arg_168_1.time_ - var_171_1) / var_171_3
				local var_171_5 = Vector3.New(0, -1, -5.93)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos104402ui_story, var_171_5, var_171_4)

				local var_171_6 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_6.x, var_171_6.y, var_171_6.z)

				local var_171_7 = var_171_0.localEulerAngles

				var_171_7.z = 0
				var_171_7.x = 0
				var_171_0.localEulerAngles = var_171_7
			end

			if arg_168_1.time_ >= var_171_1 + var_171_3 and arg_168_1.time_ < var_171_1 + var_171_3 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_171_8 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_8.x, var_171_8.y, var_171_8.z)

				local var_171_9 = var_171_0.localEulerAngles

				var_171_9.z = 0
				var_171_9.x = 0
				var_171_0.localEulerAngles = var_171_9

				local var_171_10 = GameObjectTools.GetOrAddComponent(var_171_0.gameObject, typeof(DynamicBoneHelper))

				if var_171_10 then
					var_171_10:EnableDynamicBone(true)
				end
			end

			local var_171_11 = arg_168_1.actors_["104402ui_story"]
			local var_171_12 = 0

			if var_171_12 < arg_168_1.time_ and arg_168_1.time_ <= var_171_12 + arg_171_0 and not isNil(var_171_11) and arg_168_1.var_.characterEffect104402ui_story == nil then
				arg_168_1.var_.characterEffect104402ui_story = var_171_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_13 = 0.200000002980232

			if var_171_12 <= arg_168_1.time_ and arg_168_1.time_ < var_171_12 + var_171_13 and not isNil(var_171_11) then
				local var_171_14 = (arg_168_1.time_ - var_171_12) / var_171_13

				if arg_168_1.var_.characterEffect104402ui_story and not isNil(var_171_11) then
					arg_168_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_12 + var_171_13 and arg_168_1.time_ < var_171_12 + var_171_13 + arg_171_0 and not isNil(var_171_11) and arg_168_1.var_.characterEffect104402ui_story then
				arg_168_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_171_15 = 0

			if var_171_15 < arg_168_1.time_ and arg_168_1.time_ <= var_171_15 + arg_171_0 then
				arg_168_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			local var_171_16 = 0

			if var_171_16 < arg_168_1.time_ and arg_168_1.time_ <= var_171_16 + arg_171_0 then
				arg_168_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_171_17 = 0
			local var_171_18 = 0.625

			if var_171_17 < arg_168_1.time_ and arg_168_1.time_ <= var_171_17 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_19 = arg_168_1:FormatText(StoryNameCfg[1367].name)

				arg_168_1.leftNameTxt_.text = var_171_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_20 = arg_168_1:GetWordFromCfg(936041039)
				local var_171_21 = arg_168_1:FormatText(var_171_20.content)

				arg_168_1.text_.text = var_171_21

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_22 = 25
				local var_171_23 = utf8.len(var_171_21)
				local var_171_24 = var_171_22 <= 0 and var_171_18 or var_171_18 * (var_171_23 / var_171_22)

				if var_171_24 > 0 and var_171_18 < var_171_24 then
					arg_168_1.talkMaxDuration = var_171_24

					if var_171_24 + var_171_17 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_24 + var_171_17
					end
				end

				arg_168_1.text_.text = var_171_21
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041039", "story_v_side_old_936041.awb") ~= 0 then
					local var_171_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041039", "story_v_side_old_936041.awb") / 1000

					if var_171_25 + var_171_17 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_25 + var_171_17
					end

					if var_171_20.prefab_name ~= "" and arg_168_1.actors_[var_171_20.prefab_name] ~= nil then
						local var_171_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_20.prefab_name].transform, "story_v_side_old_936041", "936041039", "story_v_side_old_936041.awb")

						arg_168_1:RecordAudio("936041039", var_171_26)
						arg_168_1:RecordAudio("936041039", var_171_26)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041039", "story_v_side_old_936041.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041039", "story_v_side_old_936041.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_27 = math.max(var_171_18, arg_168_1.talkMaxDuration)

			if var_171_17 <= arg_168_1.time_ and arg_168_1.time_ < var_171_17 + var_171_27 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_17) / var_171_27

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_17 + var_171_27 and arg_168_1.time_ < var_171_17 + var_171_27 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play936041040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 936041040
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play936041041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["104402ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect104402ui_story == nil then
				arg_172_1.var_.characterEffect104402ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect104402ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_172_1.var_.characterEffect104402ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect104402ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_172_1.var_.characterEffect104402ui_story.fillRatio = var_175_5
			end

			local var_175_6 = 0
			local var_175_7 = 0.725

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_8 = arg_172_1:FormatText(StoryNameCfg[7].name)

				arg_172_1.leftNameTxt_.text = var_175_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_9 = arg_172_1:GetWordFromCfg(936041040)
				local var_175_10 = arg_172_1:FormatText(var_175_9.content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 29
				local var_175_12 = utf8.len(var_175_10)
				local var_175_13 = var_175_11 <= 0 and var_175_7 or var_175_7 * (var_175_12 / var_175_11)

				if var_175_13 > 0 and var_175_7 < var_175_13 then
					arg_172_1.talkMaxDuration = var_175_13

					if var_175_13 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_13 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_14 and arg_172_1.time_ < var_175_6 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play936041041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 936041041
		arg_176_1.duration_ = 5.07

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play936041042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["104402ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect104402ui_story == nil then
				arg_176_1.var_.characterEffect104402ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect104402ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect104402ui_story then
				arg_176_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_179_4 = 0

			if var_179_4 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_1")
			end

			local var_179_5 = 0

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_179_6 = 0
			local var_179_7 = 0.6

			if var_179_6 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_8 = arg_176_1:FormatText(StoryNameCfg[1367].name)

				arg_176_1.leftNameTxt_.text = var_179_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_9 = arg_176_1:GetWordFromCfg(936041041)
				local var_179_10 = arg_176_1:FormatText(var_179_9.content)

				arg_176_1.text_.text = var_179_10

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_11 = 24
				local var_179_12 = utf8.len(var_179_10)
				local var_179_13 = var_179_11 <= 0 and var_179_7 or var_179_7 * (var_179_12 / var_179_11)

				if var_179_13 > 0 and var_179_7 < var_179_13 then
					arg_176_1.talkMaxDuration = var_179_13

					if var_179_13 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_13 + var_179_6
					end
				end

				arg_176_1.text_.text = var_179_10
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041041", "story_v_side_old_936041.awb") ~= 0 then
					local var_179_14 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041041", "story_v_side_old_936041.awb") / 1000

					if var_179_14 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_14 + var_179_6
					end

					if var_179_9.prefab_name ~= "" and arg_176_1.actors_[var_179_9.prefab_name] ~= nil then
						local var_179_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_9.prefab_name].transform, "story_v_side_old_936041", "936041041", "story_v_side_old_936041.awb")

						arg_176_1:RecordAudio("936041041", var_179_15)
						arg_176_1:RecordAudio("936041041", var_179_15)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041041", "story_v_side_old_936041.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041041", "story_v_side_old_936041.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_16 = math.max(var_179_7, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_16 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_6) / var_179_16

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_16 and arg_176_1.time_ < var_179_6 + var_179_16 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play936041042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 936041042
		arg_180_1.duration_ = 4

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play936041043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["104402ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos104402ui_story = var_183_0.localPosition

				local var_183_2 = GameObjectTools.GetOrAddComponent(var_183_0.gameObject, typeof(DynamicBoneHelper))

				if var_183_2 then
					var_183_2:EnableDynamicBone(false)
				end
			end

			local var_183_3 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_3 then
				local var_183_4 = (arg_180_1.time_ - var_183_1) / var_183_3
				local var_183_5 = Vector3.New(0, -1, -5.93)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos104402ui_story, var_183_5, var_183_4)

				local var_183_6 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_6.x, var_183_6.y, var_183_6.z)

				local var_183_7 = var_183_0.localEulerAngles

				var_183_7.z = 0
				var_183_7.x = 0
				var_183_0.localEulerAngles = var_183_7
			end

			if arg_180_1.time_ >= var_183_1 + var_183_3 and arg_180_1.time_ < var_183_1 + var_183_3 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_183_8 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_8.x, var_183_8.y, var_183_8.z)

				local var_183_9 = var_183_0.localEulerAngles

				var_183_9.z = 0
				var_183_9.x = 0
				var_183_0.localEulerAngles = var_183_9

				local var_183_10 = GameObjectTools.GetOrAddComponent(var_183_0.gameObject, typeof(DynamicBoneHelper))

				if var_183_10 then
					var_183_10:EnableDynamicBone(true)
				end
			end

			local var_183_11 = 0

			if var_183_11 < arg_180_1.time_ and arg_180_1.time_ <= var_183_11 + arg_183_0 then
				arg_180_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_2")
			end

			local var_183_12 = 0

			if var_183_12 < arg_180_1.time_ and arg_180_1.time_ <= var_183_12 + arg_183_0 then
				arg_180_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_183_13 = 0
			local var_183_14 = 0.35

			if var_183_13 < arg_180_1.time_ and arg_180_1.time_ <= var_183_13 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_15 = arg_180_1:FormatText(StoryNameCfg[1367].name)

				arg_180_1.leftNameTxt_.text = var_183_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_16 = arg_180_1:GetWordFromCfg(936041042)
				local var_183_17 = arg_180_1:FormatText(var_183_16.content)

				arg_180_1.text_.text = var_183_17

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_18 = 14
				local var_183_19 = utf8.len(var_183_17)
				local var_183_20 = var_183_18 <= 0 and var_183_14 or var_183_14 * (var_183_19 / var_183_18)

				if var_183_20 > 0 and var_183_14 < var_183_20 then
					arg_180_1.talkMaxDuration = var_183_20

					if var_183_20 + var_183_13 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_20 + var_183_13
					end
				end

				arg_180_1.text_.text = var_183_17
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041042", "story_v_side_old_936041.awb") ~= 0 then
					local var_183_21 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041042", "story_v_side_old_936041.awb") / 1000

					if var_183_21 + var_183_13 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_21 + var_183_13
					end

					if var_183_16.prefab_name ~= "" and arg_180_1.actors_[var_183_16.prefab_name] ~= nil then
						local var_183_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_16.prefab_name].transform, "story_v_side_old_936041", "936041042", "story_v_side_old_936041.awb")

						arg_180_1:RecordAudio("936041042", var_183_22)
						arg_180_1:RecordAudio("936041042", var_183_22)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041042", "story_v_side_old_936041.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041042", "story_v_side_old_936041.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_23 = math.max(var_183_14, arg_180_1.talkMaxDuration)

			if var_183_13 <= arg_180_1.time_ and arg_180_1.time_ < var_183_13 + var_183_23 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_13) / var_183_23

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_13 + var_183_23 and arg_180_1.time_ < var_183_13 + var_183_23 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play936041043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 936041043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play936041044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["104402ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect104402ui_story == nil then
				arg_184_1.var_.characterEffect104402ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect104402ui_story and not isNil(var_187_0) then
					local var_187_4 = Mathf.Lerp(0, 0.5, var_187_3)

					arg_184_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_184_1.var_.characterEffect104402ui_story.fillRatio = var_187_4
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect104402ui_story then
				local var_187_5 = 0.5

				arg_184_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_184_1.var_.characterEffect104402ui_story.fillRatio = var_187_5
			end

			local var_187_6 = 0
			local var_187_7 = 0.3

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_8 = arg_184_1:FormatText(StoryNameCfg[7].name)

				arg_184_1.leftNameTxt_.text = var_187_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_9 = arg_184_1:GetWordFromCfg(936041043)
				local var_187_10 = arg_184_1:FormatText(var_187_9.content)

				arg_184_1.text_.text = var_187_10

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_11 = 12
				local var_187_12 = utf8.len(var_187_10)
				local var_187_13 = var_187_11 <= 0 and var_187_7 or var_187_7 * (var_187_12 / var_187_11)

				if var_187_13 > 0 and var_187_7 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_6
					end
				end

				arg_184_1.text_.text = var_187_10
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_14 = math.max(var_187_7, arg_184_1.talkMaxDuration)

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_14 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_6) / var_187_14

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_6 + var_187_14 and arg_184_1.time_ < var_187_6 + var_187_14 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play936041044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 936041044
		arg_188_1.duration_ = 2.03

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play936041045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["104402ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos104402ui_story = var_191_0.localPosition

				local var_191_2 = GameObjectTools.GetOrAddComponent(var_191_0.gameObject, typeof(DynamicBoneHelper))

				if var_191_2 then
					var_191_2:EnableDynamicBone(false)
				end
			end

			local var_191_3 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_3 then
				local var_191_4 = (arg_188_1.time_ - var_191_1) / var_191_3
				local var_191_5 = Vector3.New(0, -1, -5.93)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos104402ui_story, var_191_5, var_191_4)

				local var_191_6 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_6.x, var_191_6.y, var_191_6.z)

				local var_191_7 = var_191_0.localEulerAngles

				var_191_7.z = 0
				var_191_7.x = 0
				var_191_0.localEulerAngles = var_191_7
			end

			if arg_188_1.time_ >= var_191_1 + var_191_3 and arg_188_1.time_ < var_191_1 + var_191_3 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_191_8 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_8.x, var_191_8.y, var_191_8.z)

				local var_191_9 = var_191_0.localEulerAngles

				var_191_9.z = 0
				var_191_9.x = 0
				var_191_0.localEulerAngles = var_191_9

				local var_191_10 = GameObjectTools.GetOrAddComponent(var_191_0.gameObject, typeof(DynamicBoneHelper))

				if var_191_10 then
					var_191_10:EnableDynamicBone(true)
				end
			end

			local var_191_11 = arg_188_1.actors_["104402ui_story"]
			local var_191_12 = 0

			if var_191_12 < arg_188_1.time_ and arg_188_1.time_ <= var_191_12 + arg_191_0 and not isNil(var_191_11) and arg_188_1.var_.characterEffect104402ui_story == nil then
				arg_188_1.var_.characterEffect104402ui_story = var_191_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_13 = 0.200000002980232

			if var_191_12 <= arg_188_1.time_ and arg_188_1.time_ < var_191_12 + var_191_13 and not isNil(var_191_11) then
				local var_191_14 = (arg_188_1.time_ - var_191_12) / var_191_13

				if arg_188_1.var_.characterEffect104402ui_story and not isNil(var_191_11) then
					arg_188_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_12 + var_191_13 and arg_188_1.time_ < var_191_12 + var_191_13 + arg_191_0 and not isNil(var_191_11) and arg_188_1.var_.characterEffect104402ui_story then
				arg_188_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_191_15 = 0

			if var_191_15 < arg_188_1.time_ and arg_188_1.time_ <= var_191_15 + arg_191_0 then
				arg_188_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			local var_191_16 = 0

			if var_191_16 < arg_188_1.time_ and arg_188_1.time_ <= var_191_16 + arg_191_0 then
				arg_188_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_191_17 = 0
			local var_191_18 = 0.05

			if var_191_17 < arg_188_1.time_ and arg_188_1.time_ <= var_191_17 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_19 = arg_188_1:FormatText(StoryNameCfg[1367].name)

				arg_188_1.leftNameTxt_.text = var_191_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_20 = arg_188_1:GetWordFromCfg(936041044)
				local var_191_21 = arg_188_1:FormatText(var_191_20.content)

				arg_188_1.text_.text = var_191_21

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_22 = 2
				local var_191_23 = utf8.len(var_191_21)
				local var_191_24 = var_191_22 <= 0 and var_191_18 or var_191_18 * (var_191_23 / var_191_22)

				if var_191_24 > 0 and var_191_18 < var_191_24 then
					arg_188_1.talkMaxDuration = var_191_24

					if var_191_24 + var_191_17 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_24 + var_191_17
					end
				end

				arg_188_1.text_.text = var_191_21
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041044", "story_v_side_old_936041.awb") ~= 0 then
					local var_191_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041044", "story_v_side_old_936041.awb") / 1000

					if var_191_25 + var_191_17 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_25 + var_191_17
					end

					if var_191_20.prefab_name ~= "" and arg_188_1.actors_[var_191_20.prefab_name] ~= nil then
						local var_191_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_20.prefab_name].transform, "story_v_side_old_936041", "936041044", "story_v_side_old_936041.awb")

						arg_188_1:RecordAudio("936041044", var_191_26)
						arg_188_1:RecordAudio("936041044", var_191_26)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041044", "story_v_side_old_936041.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041044", "story_v_side_old_936041.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_27 = math.max(var_191_18, arg_188_1.talkMaxDuration)

			if var_191_17 <= arg_188_1.time_ and arg_188_1.time_ < var_191_17 + var_191_27 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_17) / var_191_27

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_17 + var_191_27 and arg_188_1.time_ < var_191_17 + var_191_27 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play936041045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 936041045
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play936041046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["104402ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect104402ui_story == nil then
				arg_192_1.var_.characterEffect104402ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.200000002980232

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect104402ui_story and not isNil(var_195_0) then
					local var_195_4 = Mathf.Lerp(0, 0.5, var_195_3)

					arg_192_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_192_1.var_.characterEffect104402ui_story.fillRatio = var_195_4
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect104402ui_story then
				local var_195_5 = 0.5

				arg_192_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_192_1.var_.characterEffect104402ui_story.fillRatio = var_195_5
			end

			local var_195_6 = 0
			local var_195_7 = 0.25

			if var_195_6 < arg_192_1.time_ and arg_192_1.time_ <= var_195_6 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_8 = arg_192_1:FormatText(StoryNameCfg[7].name)

				arg_192_1.leftNameTxt_.text = var_195_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_9 = arg_192_1:GetWordFromCfg(936041045)
				local var_195_10 = arg_192_1:FormatText(var_195_9.content)

				arg_192_1.text_.text = var_195_10

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_11 = 10
				local var_195_12 = utf8.len(var_195_10)
				local var_195_13 = var_195_11 <= 0 and var_195_7 or var_195_7 * (var_195_12 / var_195_11)

				if var_195_13 > 0 and var_195_7 < var_195_13 then
					arg_192_1.talkMaxDuration = var_195_13

					if var_195_13 + var_195_6 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_13 + var_195_6
					end
				end

				arg_192_1.text_.text = var_195_10
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_14 = math.max(var_195_7, arg_192_1.talkMaxDuration)

			if var_195_6 <= arg_192_1.time_ and arg_192_1.time_ < var_195_6 + var_195_14 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_6) / var_195_14

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_6 + var_195_14 and arg_192_1.time_ < var_195_6 + var_195_14 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play936041046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 936041046
		arg_196_1.duration_ = 2.53

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play936041047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["104402ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos104402ui_story = var_199_0.localPosition

				local var_199_2 = GameObjectTools.GetOrAddComponent(var_199_0.gameObject, typeof(DynamicBoneHelper))

				if var_199_2 then
					var_199_2:EnableDynamicBone(false)
				end
			end

			local var_199_3 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_3 then
				local var_199_4 = (arg_196_1.time_ - var_199_1) / var_199_3
				local var_199_5 = Vector3.New(0, -1, -5.93)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos104402ui_story, var_199_5, var_199_4)

				local var_199_6 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_6.x, var_199_6.y, var_199_6.z)

				local var_199_7 = var_199_0.localEulerAngles

				var_199_7.z = 0
				var_199_7.x = 0
				var_199_0.localEulerAngles = var_199_7
			end

			if arg_196_1.time_ >= var_199_1 + var_199_3 and arg_196_1.time_ < var_199_1 + var_199_3 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_199_8 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_8.x, var_199_8.y, var_199_8.z)

				local var_199_9 = var_199_0.localEulerAngles

				var_199_9.z = 0
				var_199_9.x = 0
				var_199_0.localEulerAngles = var_199_9

				local var_199_10 = GameObjectTools.GetOrAddComponent(var_199_0.gameObject, typeof(DynamicBoneHelper))

				if var_199_10 then
					var_199_10:EnableDynamicBone(true)
				end
			end

			local var_199_11 = arg_196_1.actors_["104402ui_story"]
			local var_199_12 = 0

			if var_199_12 < arg_196_1.time_ and arg_196_1.time_ <= var_199_12 + arg_199_0 and not isNil(var_199_11) and arg_196_1.var_.characterEffect104402ui_story == nil then
				arg_196_1.var_.characterEffect104402ui_story = var_199_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_13 = 0.200000002980232

			if var_199_12 <= arg_196_1.time_ and arg_196_1.time_ < var_199_12 + var_199_13 and not isNil(var_199_11) then
				local var_199_14 = (arg_196_1.time_ - var_199_12) / var_199_13

				if arg_196_1.var_.characterEffect104402ui_story and not isNil(var_199_11) then
					arg_196_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_12 + var_199_13 and arg_196_1.time_ < var_199_12 + var_199_13 + arg_199_0 and not isNil(var_199_11) and arg_196_1.var_.characterEffect104402ui_story then
				arg_196_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_199_15 = 0

			if var_199_15 < arg_196_1.time_ and arg_196_1.time_ <= var_199_15 + arg_199_0 then
				arg_196_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402actionlink/104402action438")
			end

			local var_199_16 = 0

			if var_199_16 < arg_196_1.time_ and arg_196_1.time_ <= var_199_16 + arg_199_0 then
				arg_196_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_199_17 = 0
			local var_199_18 = 0.15

			if var_199_17 < arg_196_1.time_ and arg_196_1.time_ <= var_199_17 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_19 = arg_196_1:FormatText(StoryNameCfg[1367].name)

				arg_196_1.leftNameTxt_.text = var_199_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_20 = arg_196_1:GetWordFromCfg(936041046)
				local var_199_21 = arg_196_1:FormatText(var_199_20.content)

				arg_196_1.text_.text = var_199_21

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_22 = 6
				local var_199_23 = utf8.len(var_199_21)
				local var_199_24 = var_199_22 <= 0 and var_199_18 or var_199_18 * (var_199_23 / var_199_22)

				if var_199_24 > 0 and var_199_18 < var_199_24 then
					arg_196_1.talkMaxDuration = var_199_24

					if var_199_24 + var_199_17 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_24 + var_199_17
					end
				end

				arg_196_1.text_.text = var_199_21
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041046", "story_v_side_old_936041.awb") ~= 0 then
					local var_199_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041046", "story_v_side_old_936041.awb") / 1000

					if var_199_25 + var_199_17 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_25 + var_199_17
					end

					if var_199_20.prefab_name ~= "" and arg_196_1.actors_[var_199_20.prefab_name] ~= nil then
						local var_199_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_20.prefab_name].transform, "story_v_side_old_936041", "936041046", "story_v_side_old_936041.awb")

						arg_196_1:RecordAudio("936041046", var_199_26)
						arg_196_1:RecordAudio("936041046", var_199_26)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041046", "story_v_side_old_936041.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041046", "story_v_side_old_936041.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_27 = math.max(var_199_18, arg_196_1.talkMaxDuration)

			if var_199_17 <= arg_196_1.time_ and arg_196_1.time_ < var_199_17 + var_199_27 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_17) / var_199_27

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_17 + var_199_27 and arg_196_1.time_ < var_199_17 + var_199_27 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play936041047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 936041047
		arg_200_1.duration_ = 4.17

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play936041048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["104402ui_story"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos104402ui_story = var_203_0.localPosition

				local var_203_2 = GameObjectTools.GetOrAddComponent(var_203_0.gameObject, typeof(DynamicBoneHelper))

				if var_203_2 then
					var_203_2:EnableDynamicBone(false)
				end
			end

			local var_203_3 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_3 then
				local var_203_4 = (arg_200_1.time_ - var_203_1) / var_203_3
				local var_203_5 = Vector3.New(0, -1, -5.93)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos104402ui_story, var_203_5, var_203_4)

				local var_203_6 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_6.x, var_203_6.y, var_203_6.z)

				local var_203_7 = var_203_0.localEulerAngles

				var_203_7.z = 0
				var_203_7.x = 0
				var_203_0.localEulerAngles = var_203_7
			end

			if arg_200_1.time_ >= var_203_1 + var_203_3 and arg_200_1.time_ < var_203_1 + var_203_3 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_203_8 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_8.x, var_203_8.y, var_203_8.z)

				local var_203_9 = var_203_0.localEulerAngles

				var_203_9.z = 0
				var_203_9.x = 0
				var_203_0.localEulerAngles = var_203_9

				local var_203_10 = GameObjectTools.GetOrAddComponent(var_203_0.gameObject, typeof(DynamicBoneHelper))

				if var_203_10 then
					var_203_10:EnableDynamicBone(true)
				end
			end

			local var_203_11 = 0

			if var_203_11 < arg_200_1.time_ and arg_200_1.time_ <= var_203_11 + arg_203_0 then
				arg_200_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_2")
			end

			local var_203_12 = 0

			if var_203_12 < arg_200_1.time_ and arg_200_1.time_ <= var_203_12 + arg_203_0 then
				arg_200_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_203_13 = 0
			local var_203_14 = 0.45

			if var_203_13 < arg_200_1.time_ and arg_200_1.time_ <= var_203_13 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_15 = arg_200_1:FormatText(StoryNameCfg[1367].name)

				arg_200_1.leftNameTxt_.text = var_203_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_16 = arg_200_1:GetWordFromCfg(936041047)
				local var_203_17 = arg_200_1:FormatText(var_203_16.content)

				arg_200_1.text_.text = var_203_17

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_18 = 18
				local var_203_19 = utf8.len(var_203_17)
				local var_203_20 = var_203_18 <= 0 and var_203_14 or var_203_14 * (var_203_19 / var_203_18)

				if var_203_20 > 0 and var_203_14 < var_203_20 then
					arg_200_1.talkMaxDuration = var_203_20

					if var_203_20 + var_203_13 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_20 + var_203_13
					end
				end

				arg_200_1.text_.text = var_203_17
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041047", "story_v_side_old_936041.awb") ~= 0 then
					local var_203_21 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041047", "story_v_side_old_936041.awb") / 1000

					if var_203_21 + var_203_13 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_21 + var_203_13
					end

					if var_203_16.prefab_name ~= "" and arg_200_1.actors_[var_203_16.prefab_name] ~= nil then
						local var_203_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_16.prefab_name].transform, "story_v_side_old_936041", "936041047", "story_v_side_old_936041.awb")

						arg_200_1:RecordAudio("936041047", var_203_22)
						arg_200_1:RecordAudio("936041047", var_203_22)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041047", "story_v_side_old_936041.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041047", "story_v_side_old_936041.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_23 = math.max(var_203_14, arg_200_1.talkMaxDuration)

			if var_203_13 <= arg_200_1.time_ and arg_200_1.time_ < var_203_13 + var_203_23 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_13) / var_203_23

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_13 + var_203_23 and arg_200_1.time_ < var_203_13 + var_203_23 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play936041048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 936041048
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play936041049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["104402ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect104402ui_story == nil then
				arg_204_1.var_.characterEffect104402ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect104402ui_story and not isNil(var_207_0) then
					local var_207_4 = Mathf.Lerp(0, 0.5, var_207_3)

					arg_204_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_204_1.var_.characterEffect104402ui_story.fillRatio = var_207_4
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect104402ui_story then
				local var_207_5 = 0.5

				arg_204_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_204_1.var_.characterEffect104402ui_story.fillRatio = var_207_5
			end

			local var_207_6 = 0
			local var_207_7 = 0.05

			if var_207_6 < arg_204_1.time_ and arg_204_1.time_ <= var_207_6 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_8 = arg_204_1:FormatText(StoryNameCfg[7].name)

				arg_204_1.leftNameTxt_.text = var_207_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_9 = arg_204_1:GetWordFromCfg(936041048)
				local var_207_10 = arg_204_1:FormatText(var_207_9.content)

				arg_204_1.text_.text = var_207_10

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_11 = 2
				local var_207_12 = utf8.len(var_207_10)
				local var_207_13 = var_207_11 <= 0 and var_207_7 or var_207_7 * (var_207_12 / var_207_11)

				if var_207_13 > 0 and var_207_7 < var_207_13 then
					arg_204_1.talkMaxDuration = var_207_13

					if var_207_13 + var_207_6 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_13 + var_207_6
					end
				end

				arg_204_1.text_.text = var_207_10
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_14 = math.max(var_207_7, arg_204_1.talkMaxDuration)

			if var_207_6 <= arg_204_1.time_ and arg_204_1.time_ < var_207_6 + var_207_14 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_6) / var_207_14

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_6 + var_207_14 and arg_204_1.time_ < var_207_6 + var_207_14 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play936041049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 936041049
		arg_208_1.duration_ = 9

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play936041050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = "SP93601"

			if arg_208_1.bgs_[var_211_0] == nil then
				local var_211_1 = Object.Instantiate(arg_208_1.paintGo_)

				var_211_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_211_0)
				var_211_1.name = var_211_0
				var_211_1.transform.parent = arg_208_1.stage_.transform
				var_211_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_208_1.bgs_[var_211_0] = var_211_1
			end

			local var_211_2 = 2

			if var_211_2 < arg_208_1.time_ and arg_208_1.time_ <= var_211_2 + arg_211_0 then
				local var_211_3 = manager.ui.mainCamera.transform.localPosition
				local var_211_4 = Vector3.New(0, 0, 10) + Vector3.New(var_211_3.x, var_211_3.y, 0)
				local var_211_5 = arg_208_1.bgs_.SP93601

				var_211_5.transform.localPosition = var_211_4
				var_211_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_211_6 = var_211_5:GetComponent("SpriteRenderer")

				if var_211_6 and var_211_6.sprite then
					local var_211_7 = (var_211_5.transform.localPosition - var_211_3).z
					local var_211_8 = manager.ui.mainCameraCom_
					local var_211_9 = 2 * var_211_7 * Mathf.Tan(var_211_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_211_10 = var_211_9 * var_211_8.aspect
					local var_211_11 = var_211_6.sprite.bounds.size.x
					local var_211_12 = var_211_6.sprite.bounds.size.y
					local var_211_13 = var_211_10 / var_211_11
					local var_211_14 = var_211_9 / var_211_12
					local var_211_15 = var_211_14 < var_211_13 and var_211_13 or var_211_14

					var_211_5.transform.localScale = Vector3.New(var_211_15, var_211_15, 0)
				end

				for iter_211_0, iter_211_1 in pairs(arg_208_1.bgs_) do
					if iter_211_0 ~= "SP93601" then
						iter_211_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_211_16 = 3.999999999999

			if var_211_16 < arg_208_1.time_ and arg_208_1.time_ <= var_211_16 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			local var_211_17 = 0.3

			if arg_208_1.time_ >= var_211_16 + var_211_17 and arg_208_1.time_ < var_211_16 + var_211_17 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			local var_211_18 = 0

			if var_211_18 < arg_208_1.time_ and arg_208_1.time_ <= var_211_18 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_19 = 2

			if var_211_18 <= arg_208_1.time_ and arg_208_1.time_ < var_211_18 + var_211_19 then
				local var_211_20 = (arg_208_1.time_ - var_211_18) / var_211_19
				local var_211_21 = Color.New(0, 0, 0)

				var_211_21.a = Mathf.Lerp(0, 1, var_211_20)
				arg_208_1.mask_.color = var_211_21
			end

			if arg_208_1.time_ >= var_211_18 + var_211_19 and arg_208_1.time_ < var_211_18 + var_211_19 + arg_211_0 then
				local var_211_22 = Color.New(0, 0, 0)

				var_211_22.a = 1
				arg_208_1.mask_.color = var_211_22
			end

			local var_211_23 = 2

			if var_211_23 < arg_208_1.time_ and arg_208_1.time_ <= var_211_23 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_24 = 2

			if var_211_23 <= arg_208_1.time_ and arg_208_1.time_ < var_211_23 + var_211_24 then
				local var_211_25 = (arg_208_1.time_ - var_211_23) / var_211_24
				local var_211_26 = Color.New(0, 0, 0)

				var_211_26.a = Mathf.Lerp(1, 0, var_211_25)
				arg_208_1.mask_.color = var_211_26
			end

			if arg_208_1.time_ >= var_211_23 + var_211_24 and arg_208_1.time_ < var_211_23 + var_211_24 + arg_211_0 then
				local var_211_27 = Color.New(0, 0, 0)
				local var_211_28 = 0

				arg_208_1.mask_.enabled = false
				var_211_27.a = var_211_28
				arg_208_1.mask_.color = var_211_27
			end

			local var_211_29 = arg_208_1.actors_["104402ui_story"].transform
			local var_211_30 = 1.96599999815226

			if var_211_30 < arg_208_1.time_ and arg_208_1.time_ <= var_211_30 + arg_211_0 then
				arg_208_1.var_.moveOldPos104402ui_story = var_211_29.localPosition

				local var_211_31 = GameObjectTools.GetOrAddComponent(var_211_29.gameObject, typeof(DynamicBoneHelper))

				if var_211_31 then
					var_211_31:EnableDynamicBone(false)
				end
			end

			local var_211_32 = 0.001

			if var_211_30 <= arg_208_1.time_ and arg_208_1.time_ < var_211_30 + var_211_32 then
				local var_211_33 = (arg_208_1.time_ - var_211_30) / var_211_32
				local var_211_34 = Vector3.New(0, 100, 0)

				var_211_29.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos104402ui_story, var_211_34, var_211_33)

				local var_211_35 = manager.ui.mainCamera.transform.position - var_211_29.position

				var_211_29.forward = Vector3.New(var_211_35.x, var_211_35.y, var_211_35.z)

				local var_211_36 = var_211_29.localEulerAngles

				var_211_36.z = 0
				var_211_36.x = 0
				var_211_29.localEulerAngles = var_211_36
			end

			if arg_208_1.time_ >= var_211_30 + var_211_32 and arg_208_1.time_ < var_211_30 + var_211_32 + arg_211_0 then
				var_211_29.localPosition = Vector3.New(0, 100, 0)

				local var_211_37 = manager.ui.mainCamera.transform.position - var_211_29.position

				var_211_29.forward = Vector3.New(var_211_37.x, var_211_37.y, var_211_37.z)

				local var_211_38 = var_211_29.localEulerAngles

				var_211_38.z = 0
				var_211_38.x = 0
				var_211_29.localEulerAngles = var_211_38

				local var_211_39 = GameObjectTools.GetOrAddComponent(var_211_29.gameObject, typeof(DynamicBoneHelper))

				if var_211_39 then
					var_211_39:EnableDynamicBone(true)
				end
			end

			local var_211_40 = arg_208_1.bgs_.SP93601.transform
			local var_211_41 = 2

			if var_211_41 < arg_208_1.time_ and arg_208_1.time_ <= var_211_41 + arg_211_0 then
				arg_208_1.var_.moveOldPosSP93601 = var_211_40.localPosition
			end

			local var_211_42 = 2

			if var_211_41 <= arg_208_1.time_ and arg_208_1.time_ < var_211_41 + var_211_42 then
				local var_211_43 = (arg_208_1.time_ - var_211_41) / var_211_42
				local var_211_44 = Vector3.New(0, -1, -1)

				var_211_40.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPosSP93601, var_211_44, var_211_43)
			end

			if arg_208_1.time_ >= var_211_41 + var_211_42 and arg_208_1.time_ < var_211_41 + var_211_42 + arg_211_0 then
				var_211_40.localPosition = Vector3.New(0, -1, -1)
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_45 = 4
			local var_211_46 = 1.425

			if var_211_45 < arg_208_1.time_ and arg_208_1.time_ <= var_211_45 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_47 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_47:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_48 = arg_208_1:GetWordFromCfg(936041049)
				local var_211_49 = arg_208_1:FormatText(var_211_48.content)

				arg_208_1.text_.text = var_211_49

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_50 = 57
				local var_211_51 = utf8.len(var_211_49)
				local var_211_52 = var_211_50 <= 0 and var_211_46 or var_211_46 * (var_211_51 / var_211_50)

				if var_211_52 > 0 and var_211_46 < var_211_52 then
					arg_208_1.talkMaxDuration = var_211_52
					var_211_45 = var_211_45 + 0.3

					if var_211_52 + var_211_45 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_52 + var_211_45
					end
				end

				arg_208_1.text_.text = var_211_49
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_53 = var_211_45 + 0.3
			local var_211_54 = math.max(var_211_46, arg_208_1.talkMaxDuration)

			if var_211_53 <= arg_208_1.time_ and arg_208_1.time_ < var_211_53 + var_211_54 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_53) / var_211_54

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_53 + var_211_54 and arg_208_1.time_ < var_211_53 + var_211_54 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93601",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-0.14, 0.95, -2.18),
					endPos = Vector3.New(0, -1, -1),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play936041050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 936041050
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play936041051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.225

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[7].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(936041050)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 9
				local var_217_6 = utf8.len(var_217_4)
				local var_217_7 = var_217_5 <= 0 and var_217_1 or var_217_1 * (var_217_6 / var_217_5)

				if var_217_7 > 0 and var_217_1 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_8 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_8 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_8

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_8 and arg_214_1.time_ < var_217_0 + var_217_8 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play936041051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 936041051
		arg_218_1.duration_ = 9.43

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play936041052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 0.925

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_2 = arg_218_1:FormatText(StoryNameCfg[1367].name)

				arg_218_1.leftNameTxt_.text = var_221_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_3 = arg_218_1:GetWordFromCfg(936041051)
				local var_221_4 = arg_218_1:FormatText(var_221_3.content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 37
				local var_221_6 = utf8.len(var_221_4)
				local var_221_7 = var_221_5 <= 0 and var_221_1 or var_221_1 * (var_221_6 / var_221_5)

				if var_221_7 > 0 and var_221_1 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_4
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041051", "story_v_side_old_936041.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041051", "story_v_side_old_936041.awb") / 1000

					if var_221_8 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_0
					end

					if var_221_3.prefab_name ~= "" and arg_218_1.actors_[var_221_3.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_3.prefab_name].transform, "story_v_side_old_936041", "936041051", "story_v_side_old_936041.awb")

						arg_218_1:RecordAudio("936041051", var_221_9)
						arg_218_1:RecordAudio("936041051", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041051", "story_v_side_old_936041.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041051", "story_v_side_old_936041.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_10 and arg_218_1.time_ < var_221_0 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play936041052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 936041052
		arg_222_1.duration_ = 4.1

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play936041053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.45

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[1367].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_3 = arg_222_1:GetWordFromCfg(936041052)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 18
				local var_225_6 = utf8.len(var_225_4)
				local var_225_7 = var_225_5 <= 0 and var_225_1 or var_225_1 * (var_225_6 / var_225_5)

				if var_225_7 > 0 and var_225_1 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_4
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041052", "story_v_side_old_936041.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041052", "story_v_side_old_936041.awb") / 1000

					if var_225_8 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_0
					end

					if var_225_3.prefab_name ~= "" and arg_222_1.actors_[var_225_3.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_3.prefab_name].transform, "story_v_side_old_936041", "936041052", "story_v_side_old_936041.awb")

						arg_222_1:RecordAudio("936041052", var_225_9)
						arg_222_1:RecordAudio("936041052", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041052", "story_v_side_old_936041.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041052", "story_v_side_old_936041.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_10 and arg_222_1.time_ < var_225_0 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play936041053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 936041053
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play936041054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 1.025

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_2 = arg_226_1:GetWordFromCfg(936041053)
				local var_229_3 = arg_226_1:FormatText(var_229_2.content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_4 = 41
				local var_229_5 = utf8.len(var_229_3)
				local var_229_6 = var_229_4 <= 0 and var_229_1 or var_229_1 * (var_229_5 / var_229_4)

				if var_229_6 > 0 and var_229_1 < var_229_6 then
					arg_226_1.talkMaxDuration = var_229_6

					if var_229_6 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_6 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_7 and arg_226_1.time_ < var_229_0 + var_229_7 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play936041054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 936041054
		arg_230_1.duration_ = 9.1

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play936041055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0
			local var_233_1 = 1

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_2 = arg_230_1:FormatText(StoryNameCfg[1367].name)

				arg_230_1.leftNameTxt_.text = var_233_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_3 = arg_230_1:GetWordFromCfg(936041054)
				local var_233_4 = arg_230_1:FormatText(var_233_3.content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041054", "story_v_side_old_936041.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041054", "story_v_side_old_936041.awb") / 1000

					if var_233_8 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_0
					end

					if var_233_3.prefab_name ~= "" and arg_230_1.actors_[var_233_3.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_3.prefab_name].transform, "story_v_side_old_936041", "936041054", "story_v_side_old_936041.awb")

						arg_230_1:RecordAudio("936041054", var_233_9)
						arg_230_1:RecordAudio("936041054", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041054", "story_v_side_old_936041.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041054", "story_v_side_old_936041.awb")
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
	Play936041055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 936041055
		arg_234_1.duration_ = 7.67

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play936041056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0
			local var_237_1 = 0.825

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_2 = arg_234_1:FormatText(StoryNameCfg[1367].name)

				arg_234_1.leftNameTxt_.text = var_237_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_3 = arg_234_1:GetWordFromCfg(936041055)
				local var_237_4 = arg_234_1:FormatText(var_237_3.content)

				arg_234_1.text_.text = var_237_4

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 33
				local var_237_6 = utf8.len(var_237_4)
				local var_237_7 = var_237_5 <= 0 and var_237_1 or var_237_1 * (var_237_6 / var_237_5)

				if var_237_7 > 0 and var_237_1 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_0
					end
				end

				arg_234_1.text_.text = var_237_4
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041055", "story_v_side_old_936041.awb") ~= 0 then
					local var_237_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041055", "story_v_side_old_936041.awb") / 1000

					if var_237_8 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_0
					end

					if var_237_3.prefab_name ~= "" and arg_234_1.actors_[var_237_3.prefab_name] ~= nil then
						local var_237_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_3.prefab_name].transform, "story_v_side_old_936041", "936041055", "story_v_side_old_936041.awb")

						arg_234_1:RecordAudio("936041055", var_237_9)
						arg_234_1:RecordAudio("936041055", var_237_9)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041055", "story_v_side_old_936041.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041055", "story_v_side_old_936041.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_1, arg_234_1.talkMaxDuration)

			if var_237_0 <= arg_234_1.time_ and arg_234_1.time_ < var_237_0 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_0) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_0 + var_237_10 and arg_234_1.time_ < var_237_0 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play936041056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 936041056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play936041057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 0.15

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_2 = arg_238_1:FormatText(StoryNameCfg[7].name)

				arg_238_1.leftNameTxt_.text = var_241_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:GetWordFromCfg(936041056)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 6
				local var_241_6 = utf8.len(var_241_4)
				local var_241_7 = var_241_5 <= 0 and var_241_1 or var_241_1 * (var_241_6 / var_241_5)

				if var_241_7 > 0 and var_241_1 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_8 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_8 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_8

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_8 and arg_238_1.time_ < var_241_0 + var_241_8 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play936041057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 936041057
		arg_242_1.duration_ = 2.56

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play936041058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.bgs_.SP93601.transform
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.var_.moveOldPosSP93601 = var_245_0.localPosition
			end

			local var_245_2 = 0.7

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2
				local var_245_4 = Vector3.New(0.1, -1, -1.5)

				var_245_0.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPosSP93601, var_245_4, var_245_3)
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 then
				var_245_0.localPosition = Vector3.New(0.1, -1, -1.5)
			end

			local var_245_5 = arg_242_1.bgs_.SP93601.transform
			local var_245_6 = 0.866666666666667

			if var_245_6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.var_.moveOldPosSP93601 = var_245_5.localPosition
			end

			local var_245_7 = 0.733333333333333

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_7 then
				local var_245_8 = (arg_242_1.time_ - var_245_6) / var_245_7
				local var_245_9 = Vector3.New(0.25, -1, -2)

				var_245_5.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPosSP93601, var_245_9, var_245_8)
			end

			if arg_242_1.time_ >= var_245_6 + var_245_7 and arg_242_1.time_ < var_245_6 + var_245_7 + arg_245_0 then
				var_245_5.localPosition = Vector3.New(0.25, -1, -2)
			end

			local var_245_10 = arg_242_1.bgs_.SP93601.transform
			local var_245_11 = 1.73333333333333

			if var_245_11 < arg_242_1.time_ and arg_242_1.time_ <= var_245_11 + arg_245_0 then
				arg_242_1.var_.moveOldPosSP93601 = var_245_10.localPosition
			end

			local var_245_12 = 0.733333333333333

			if var_245_11 <= arg_242_1.time_ and arg_242_1.time_ < var_245_11 + var_245_12 then
				local var_245_13 = (arg_242_1.time_ - var_245_11) / var_245_12
				local var_245_14 = Vector3.New(0.35, -1, -2.5)

				var_245_10.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPosSP93601, var_245_14, var_245_13)
			end

			if arg_242_1.time_ >= var_245_11 + var_245_12 and arg_242_1.time_ < var_245_11 + var_245_12 + arg_245_0 then
				var_245_10.localPosition = Vector3.New(0.35, -1, -2.5)
			end

			local var_245_15 = 0

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1.allBtn_.enabled = false
			end

			local var_245_16 = 2.55833333333333

			if arg_242_1.time_ >= var_245_15 + var_245_16 and arg_242_1.time_ < var_245_15 + var_245_16 + arg_245_0 then
				arg_242_1.allBtn_.enabled = true
			end

			local var_245_17 = 0
			local var_245_18 = 0.15

			if var_245_17 < arg_242_1.time_ and arg_242_1.time_ <= var_245_17 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_19 = arg_242_1:FormatText(StoryNameCfg[1367].name)

				arg_242_1.leftNameTxt_.text = var_245_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_20 = arg_242_1:GetWordFromCfg(936041057)
				local var_245_21 = arg_242_1:FormatText(var_245_20.content)

				arg_242_1.text_.text = var_245_21

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_22 = 6
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

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041057", "story_v_side_old_936041.awb") ~= 0 then
					local var_245_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041057", "story_v_side_old_936041.awb") / 1000

					if var_245_25 + var_245_17 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_25 + var_245_17
					end

					if var_245_20.prefab_name ~= "" and arg_242_1.actors_[var_245_20.prefab_name] ~= nil then
						local var_245_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_20.prefab_name].transform, "story_v_side_old_936041", "936041057", "story_v_side_old_936041.awb")

						arg_242_1:RecordAudio("936041057", var_245_26)
						arg_242_1:RecordAudio("936041057", var_245_26)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041057", "story_v_side_old_936041.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041057", "story_v_side_old_936041.awb")
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
				needEase = true,
				actorName = "SP93601",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.7,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, -1, -1),
					endPos = Vector3.New(0.1, -1, -1.5),
					easeType = LeanTweenType.easeInOutCubic
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93601",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.733333333333333,
				startTime = 0.866666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0.1, -1, -1.5),
					endPos = Vector3.New(0.25, -1, -2),
					easeType = LeanTweenType.easeInOutCubic
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93601",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.733333333333333,
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0.25, -1, -2),
					endPos = Vector3.New(0.35, -1, -2.5),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play936041058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 936041058
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play936041059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 1.25

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_2 = arg_246_1:GetWordFromCfg(936041058)
				local var_249_3 = arg_246_1:FormatText(var_249_2.content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 50
				local var_249_5 = utf8.len(var_249_3)
				local var_249_6 = var_249_4 <= 0 and var_249_1 or var_249_1 * (var_249_5 / var_249_4)

				if var_249_6 > 0 and var_249_1 < var_249_6 then
					arg_246_1.talkMaxDuration = var_249_6

					if var_249_6 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_6 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_7 and arg_246_1.time_ < var_249_0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play936041059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 936041059
		arg_250_1.duration_ = 6.03

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play936041060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.75

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_2 = arg_250_1:FormatText(StoryNameCfg[1367].name)

				arg_250_1.leftNameTxt_.text = var_253_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_3 = arg_250_1:GetWordFromCfg(936041059)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 30
				local var_253_6 = utf8.len(var_253_4)
				local var_253_7 = var_253_5 <= 0 and var_253_1 or var_253_1 * (var_253_6 / var_253_5)

				if var_253_7 > 0 and var_253_1 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041059", "story_v_side_old_936041.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041059", "story_v_side_old_936041.awb") / 1000

					if var_253_8 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_0
					end

					if var_253_3.prefab_name ~= "" and arg_250_1.actors_[var_253_3.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_3.prefab_name].transform, "story_v_side_old_936041", "936041059", "story_v_side_old_936041.awb")

						arg_250_1:RecordAudio("936041059", var_253_9)
						arg_250_1:RecordAudio("936041059", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041059", "story_v_side_old_936041.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041059", "story_v_side_old_936041.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_10 and arg_250_1.time_ < var_253_0 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play936041060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 936041060
		arg_254_1.duration_ = 8.97

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play936041061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0
			local var_257_1 = 1

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_2 = arg_254_1:FormatText(StoryNameCfg[1367].name)

				arg_254_1.leftNameTxt_.text = var_257_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_3 = arg_254_1:GetWordFromCfg(936041060)
				local var_257_4 = arg_254_1:FormatText(var_257_3.content)

				arg_254_1.text_.text = var_257_4

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 40
				local var_257_6 = utf8.len(var_257_4)
				local var_257_7 = var_257_5 <= 0 and var_257_1 or var_257_1 * (var_257_6 / var_257_5)

				if var_257_7 > 0 and var_257_1 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_0
					end
				end

				arg_254_1.text_.text = var_257_4
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041060", "story_v_side_old_936041.awb") ~= 0 then
					local var_257_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041060", "story_v_side_old_936041.awb") / 1000

					if var_257_8 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_8 + var_257_0
					end

					if var_257_3.prefab_name ~= "" and arg_254_1.actors_[var_257_3.prefab_name] ~= nil then
						local var_257_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_3.prefab_name].transform, "story_v_side_old_936041", "936041060", "story_v_side_old_936041.awb")

						arg_254_1:RecordAudio("936041060", var_257_9)
						arg_254_1:RecordAudio("936041060", var_257_9)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041060", "story_v_side_old_936041.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041060", "story_v_side_old_936041.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_10 = math.max(var_257_1, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_10 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_0) / var_257_10

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_10 and arg_254_1.time_ < var_257_0 + var_257_10 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play936041061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 936041061
		arg_258_1.duration_ = 4.5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play936041062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.425

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[1367].name)

				arg_258_1.leftNameTxt_.text = var_261_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_3 = arg_258_1:GetWordFromCfg(936041061)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 17
				local var_261_6 = utf8.len(var_261_4)
				local var_261_7 = var_261_5 <= 0 and var_261_1 or var_261_1 * (var_261_6 / var_261_5)

				if var_261_7 > 0 and var_261_1 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041061", "story_v_side_old_936041.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041061", "story_v_side_old_936041.awb") / 1000

					if var_261_8 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_0
					end

					if var_261_3.prefab_name ~= "" and arg_258_1.actors_[var_261_3.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_3.prefab_name].transform, "story_v_side_old_936041", "936041061", "story_v_side_old_936041.awb")

						arg_258_1:RecordAudio("936041061", var_261_9)
						arg_258_1:RecordAudio("936041061", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041061", "story_v_side_old_936041.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041061", "story_v_side_old_936041.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_10 and arg_258_1.time_ < var_261_0 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play936041062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 936041062
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play936041063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 0.15

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_2 = arg_262_1:FormatText(StoryNameCfg[7].name)

				arg_262_1.leftNameTxt_.text = var_265_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_3 = arg_262_1:GetWordFromCfg(936041062)
				local var_265_4 = arg_262_1:FormatText(var_265_3.content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 6
				local var_265_6 = utf8.len(var_265_4)
				local var_265_7 = var_265_5 <= 0 and var_265_1 or var_265_1 * (var_265_6 / var_265_5)

				if var_265_7 > 0 and var_265_1 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_4
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_8 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_8 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_8

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_8 and arg_262_1.time_ < var_265_0 + var_265_8 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play936041063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 936041063
		arg_266_1.duration_ = 3.1

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play936041064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.3

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[1367].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_3 = arg_266_1:GetWordFromCfg(936041063)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 12
				local var_269_6 = utf8.len(var_269_4)
				local var_269_7 = var_269_5 <= 0 and var_269_1 or var_269_1 * (var_269_6 / var_269_5)

				if var_269_7 > 0 and var_269_1 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041063", "story_v_side_old_936041.awb") ~= 0 then
					local var_269_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041063", "story_v_side_old_936041.awb") / 1000

					if var_269_8 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_8 + var_269_0
					end

					if var_269_3.prefab_name ~= "" and arg_266_1.actors_[var_269_3.prefab_name] ~= nil then
						local var_269_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_3.prefab_name].transform, "story_v_side_old_936041", "936041063", "story_v_side_old_936041.awb")

						arg_266_1:RecordAudio("936041063", var_269_9)
						arg_266_1:RecordAudio("936041063", var_269_9)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041063", "story_v_side_old_936041.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041063", "story_v_side_old_936041.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_10 and arg_266_1.time_ < var_269_0 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play936041064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 936041064
		arg_270_1.duration_ = 9

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play936041065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_1 = 2

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_1 then
				local var_273_2 = (arg_270_1.time_ - var_273_0) / var_273_1
				local var_273_3 = Color.New(0, 0, 0)

				var_273_3.a = Mathf.Lerp(0, 1, var_273_2)
				arg_270_1.mask_.color = var_273_3
			end

			if arg_270_1.time_ >= var_273_0 + var_273_1 and arg_270_1.time_ < var_273_0 + var_273_1 + arg_273_0 then
				local var_273_4 = Color.New(0, 0, 0)

				var_273_4.a = 1
				arg_270_1.mask_.color = var_273_4
			end

			local var_273_5 = 2

			if var_273_5 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_6 = 2

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_6 then
				local var_273_7 = (arg_270_1.time_ - var_273_5) / var_273_6
				local var_273_8 = Color.New(0, 0, 0)

				var_273_8.a = Mathf.Lerp(1, 0, var_273_7)
				arg_270_1.mask_.color = var_273_8
			end

			if arg_270_1.time_ >= var_273_5 + var_273_6 and arg_270_1.time_ < var_273_5 + var_273_6 + arg_273_0 then
				local var_273_9 = Color.New(0, 0, 0)
				local var_273_10 = 0

				arg_270_1.mask_.enabled = false
				var_273_9.a = var_273_10
				arg_270_1.mask_.color = var_273_9
			end

			local var_273_11 = 2

			if var_273_11 < arg_270_1.time_ and arg_270_1.time_ <= var_273_11 + arg_273_0 then
				local var_273_12 = manager.ui.mainCamera.transform.localPosition
				local var_273_13 = Vector3.New(0, 0, 10) + Vector3.New(var_273_12.x, var_273_12.y, 0)
				local var_273_14 = arg_270_1.bgs_.SP93601

				var_273_14.transform.localPosition = var_273_13
				var_273_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_273_15 = var_273_14:GetComponent("SpriteRenderer")

				if var_273_15 and var_273_15.sprite then
					local var_273_16 = (var_273_14.transform.localPosition - var_273_12).z
					local var_273_17 = manager.ui.mainCameraCom_
					local var_273_18 = 2 * var_273_16 * Mathf.Tan(var_273_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_273_19 = var_273_18 * var_273_17.aspect
					local var_273_20 = var_273_15.sprite.bounds.size.x
					local var_273_21 = var_273_15.sprite.bounds.size.y
					local var_273_22 = var_273_19 / var_273_20
					local var_273_23 = var_273_18 / var_273_21
					local var_273_24 = var_273_23 < var_273_22 and var_273_22 or var_273_23

					var_273_14.transform.localScale = Vector3.New(var_273_24, var_273_24, 0)
				end

				for iter_273_0, iter_273_1 in pairs(arg_270_1.bgs_) do
					if iter_273_0 ~= "SP93601" then
						iter_273_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_273_25 = arg_270_1.bgs_.SP93601.transform
			local var_273_26 = 2

			if var_273_26 < arg_270_1.time_ and arg_270_1.time_ <= var_273_26 + arg_273_0 then
				arg_270_1.var_.moveOldPosSP93601 = var_273_25.localPosition
			end

			local var_273_27 = 1.7

			if var_273_26 <= arg_270_1.time_ and arg_270_1.time_ < var_273_26 + var_273_27 then
				local var_273_28 = (arg_270_1.time_ - var_273_26) / var_273_27
				local var_273_29 = Vector3.New(0, 1, 10)

				var_273_25.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPosSP93601, var_273_29, var_273_28)
			end

			if arg_270_1.time_ >= var_273_26 + var_273_27 and arg_270_1.time_ < var_273_26 + var_273_27 + arg_273_0 then
				var_273_25.localPosition = Vector3.New(0, 1, 10)
			end

			local var_273_30 = 4
			local var_273_31 = 0.725

			if var_273_30 < arg_270_1.time_ and arg_270_1.time_ <= var_273_30 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_32 = arg_270_1:GetWordFromCfg(936041064)
				local var_273_33 = arg_270_1:FormatText(var_273_32.content)

				arg_270_1.text_.text = var_273_33

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_34 = 29
				local var_273_35 = utf8.len(var_273_33)
				local var_273_36 = var_273_34 <= 0 and var_273_31 or var_273_31 * (var_273_35 / var_273_34)

				if var_273_36 > 0 and var_273_31 < var_273_36 then
					arg_270_1.talkMaxDuration = var_273_36

					if var_273_36 + var_273_30 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_36 + var_273_30
					end
				end

				arg_270_1.text_.text = var_273_33
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_37 = math.max(var_273_31, arg_270_1.talkMaxDuration)

			if var_273_30 <= arg_270_1.time_ and arg_270_1.time_ < var_273_30 + var_273_37 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_30) / var_273_37

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_30 + var_273_37 and arg_270_1.time_ < var_273_30 + var_273_37 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93601",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.7,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play936041065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 936041065
		arg_274_1.duration_ = 4.27

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play936041066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.3

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_2 = arg_274_1:FormatText(StoryNameCfg[1367].name)

				arg_274_1.leftNameTxt_.text = var_277_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_3 = arg_274_1:GetWordFromCfg(936041065)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 12
				local var_277_6 = utf8.len(var_277_4)
				local var_277_7 = var_277_5 <= 0 and var_277_1 or var_277_1 * (var_277_6 / var_277_5)

				if var_277_7 > 0 and var_277_1 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041065", "story_v_side_old_936041.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041065", "story_v_side_old_936041.awb") / 1000

					if var_277_8 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_0
					end

					if var_277_3.prefab_name ~= "" and arg_274_1.actors_[var_277_3.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_3.prefab_name].transform, "story_v_side_old_936041", "936041065", "story_v_side_old_936041.awb")

						arg_274_1:RecordAudio("936041065", var_277_9)
						arg_274_1:RecordAudio("936041065", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041065", "story_v_side_old_936041.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041065", "story_v_side_old_936041.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_10 and arg_274_1.time_ < var_277_0 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play936041066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 936041066
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play936041067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.25

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[7].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:GetWordFromCfg(936041066)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 10
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_8 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_8 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_8

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_8 and arg_278_1.time_ < var_281_0 + var_281_8 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play936041067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 936041067
		arg_282_1.duration_ = 4.87

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play936041068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 0.6

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_2 = arg_282_1:FormatText(StoryNameCfg[1367].name)

				arg_282_1.leftNameTxt_.text = var_285_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_3 = arg_282_1:GetWordFromCfg(936041067)
				local var_285_4 = arg_282_1:FormatText(var_285_3.content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 24
				local var_285_6 = utf8.len(var_285_4)
				local var_285_7 = var_285_5 <= 0 and var_285_1 or var_285_1 * (var_285_6 / var_285_5)

				if var_285_7 > 0 and var_285_1 < var_285_7 then
					arg_282_1.talkMaxDuration = var_285_7

					if var_285_7 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_7 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041067", "story_v_side_old_936041.awb") ~= 0 then
					local var_285_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041067", "story_v_side_old_936041.awb") / 1000

					if var_285_8 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_8 + var_285_0
					end

					if var_285_3.prefab_name ~= "" and arg_282_1.actors_[var_285_3.prefab_name] ~= nil then
						local var_285_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_3.prefab_name].transform, "story_v_side_old_936041", "936041067", "story_v_side_old_936041.awb")

						arg_282_1:RecordAudio("936041067", var_285_9)
						arg_282_1:RecordAudio("936041067", var_285_9)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041067", "story_v_side_old_936041.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041067", "story_v_side_old_936041.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_10 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_10 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_10

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_10 and arg_282_1.time_ < var_285_0 + var_285_10 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play936041068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 936041068
		arg_286_1.duration_ = 7.57

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play936041069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.8

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[1367].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_3 = arg_286_1:GetWordFromCfg(936041068)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 32
				local var_289_6 = utf8.len(var_289_4)
				local var_289_7 = var_289_5 <= 0 and var_289_1 or var_289_1 * (var_289_6 / var_289_5)

				if var_289_7 > 0 and var_289_1 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041068", "story_v_side_old_936041.awb") ~= 0 then
					local var_289_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041068", "story_v_side_old_936041.awb") / 1000

					if var_289_8 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_0
					end

					if var_289_3.prefab_name ~= "" and arg_286_1.actors_[var_289_3.prefab_name] ~= nil then
						local var_289_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_3.prefab_name].transform, "story_v_side_old_936041", "936041068", "story_v_side_old_936041.awb")

						arg_286_1:RecordAudio("936041068", var_289_9)
						arg_286_1:RecordAudio("936041068", var_289_9)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041068", "story_v_side_old_936041.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041068", "story_v_side_old_936041.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_10 and arg_286_1.time_ < var_289_0 + var_289_10 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play936041069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 936041069
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play936041070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 0.575

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[7].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:GetWordFromCfg(936041069)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 23
				local var_293_6 = utf8.len(var_293_4)
				local var_293_7 = var_293_5 <= 0 and var_293_1 or var_293_1 * (var_293_6 / var_293_5)

				if var_293_7 > 0 and var_293_1 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_8 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_8 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_8

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_8 and arg_290_1.time_ < var_293_0 + var_293_8 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play936041070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 936041070
		arg_294_1.duration_ = 4.27

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play936041071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.4

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_2 = arg_294_1:FormatText(StoryNameCfg[1367].name)

				arg_294_1.leftNameTxt_.text = var_297_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_3 = arg_294_1:GetWordFromCfg(936041070)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 16
				local var_297_6 = utf8.len(var_297_4)
				local var_297_7 = var_297_5 <= 0 and var_297_1 or var_297_1 * (var_297_6 / var_297_5)

				if var_297_7 > 0 and var_297_1 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_4
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041070", "story_v_side_old_936041.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041070", "story_v_side_old_936041.awb") / 1000

					if var_297_8 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_0
					end

					if var_297_3.prefab_name ~= "" and arg_294_1.actors_[var_297_3.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_3.prefab_name].transform, "story_v_side_old_936041", "936041070", "story_v_side_old_936041.awb")

						arg_294_1:RecordAudio("936041070", var_297_9)
						arg_294_1:RecordAudio("936041070", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041070", "story_v_side_old_936041.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041070", "story_v_side_old_936041.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_10 and arg_294_1.time_ < var_297_0 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play936041071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 936041071
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play936041072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.525

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_2 = arg_298_1:FormatText(StoryNameCfg[7].name)

				arg_298_1.leftNameTxt_.text = var_301_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_3 = arg_298_1:GetWordFromCfg(936041071)
				local var_301_4 = arg_298_1:FormatText(var_301_3.content)

				arg_298_1.text_.text = var_301_4

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 21
				local var_301_6 = utf8.len(var_301_4)
				local var_301_7 = var_301_5 <= 0 and var_301_1 or var_301_1 * (var_301_6 / var_301_5)

				if var_301_7 > 0 and var_301_1 < var_301_7 then
					arg_298_1.talkMaxDuration = var_301_7

					if var_301_7 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_7 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_4
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_8 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_8 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_8

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_8 and arg_298_1.time_ < var_301_0 + var_301_8 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play936041072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 936041072
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play936041073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0
			local var_305_1 = 0.425

			if var_305_0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_2 = arg_302_1:FormatText(StoryNameCfg[7].name)

				arg_302_1.leftNameTxt_.text = var_305_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_3 = arg_302_1:GetWordFromCfg(936041072)
				local var_305_4 = arg_302_1:FormatText(var_305_3.content)

				arg_302_1.text_.text = var_305_4

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_5 = 17
				local var_305_6 = utf8.len(var_305_4)
				local var_305_7 = var_305_5 <= 0 and var_305_1 or var_305_1 * (var_305_6 / var_305_5)

				if var_305_7 > 0 and var_305_1 < var_305_7 then
					arg_302_1.talkMaxDuration = var_305_7

					if var_305_7 + var_305_0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_7 + var_305_0
					end
				end

				arg_302_1.text_.text = var_305_4
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_8 = math.max(var_305_1, arg_302_1.talkMaxDuration)

			if var_305_0 <= arg_302_1.time_ and arg_302_1.time_ < var_305_0 + var_305_8 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_0) / var_305_8

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_0 + var_305_8 and arg_302_1.time_ < var_305_0 + var_305_8 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play936041073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 936041073
		arg_306_1.duration_ = 3.8

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play936041074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 0.375

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_2 = arg_306_1:FormatText(StoryNameCfg[1367].name)

				arg_306_1.leftNameTxt_.text = var_309_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_3 = arg_306_1:GetWordFromCfg(936041073)
				local var_309_4 = arg_306_1:FormatText(var_309_3.content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 15
				local var_309_6 = utf8.len(var_309_4)
				local var_309_7 = var_309_5 <= 0 and var_309_1 or var_309_1 * (var_309_6 / var_309_5)

				if var_309_7 > 0 and var_309_1 < var_309_7 then
					arg_306_1.talkMaxDuration = var_309_7

					if var_309_7 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_7 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_4
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041073", "story_v_side_old_936041.awb") ~= 0 then
					local var_309_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041073", "story_v_side_old_936041.awb") / 1000

					if var_309_8 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_8 + var_309_0
					end

					if var_309_3.prefab_name ~= "" and arg_306_1.actors_[var_309_3.prefab_name] ~= nil then
						local var_309_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_3.prefab_name].transform, "story_v_side_old_936041", "936041073", "story_v_side_old_936041.awb")

						arg_306_1:RecordAudio("936041073", var_309_9)
						arg_306_1:RecordAudio("936041073", var_309_9)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041073", "story_v_side_old_936041.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041073", "story_v_side_old_936041.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_10 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_10 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_10

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_10 and arg_306_1.time_ < var_309_0 + var_309_10 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play936041074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 936041074
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play936041075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0
			local var_313_1 = 1.125

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_2 = arg_310_1:FormatText(StoryNameCfg[7].name)

				arg_310_1.leftNameTxt_.text = var_313_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_3 = arg_310_1:GetWordFromCfg(936041074)
				local var_313_4 = arg_310_1:FormatText(var_313_3.content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 45
				local var_313_6 = utf8.len(var_313_4)
				local var_313_7 = var_313_5 <= 0 and var_313_1 or var_313_1 * (var_313_6 / var_313_5)

				if var_313_7 > 0 and var_313_1 < var_313_7 then
					arg_310_1.talkMaxDuration = var_313_7

					if var_313_7 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_0
					end
				end

				arg_310_1.text_.text = var_313_4
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_8 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_8 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_8

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_8 and arg_310_1.time_ < var_313_0 + var_313_8 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play936041075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 936041075
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play936041076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0
			local var_317_1 = 1.6

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_2 = arg_314_1:FormatText(StoryNameCfg[7].name)

				arg_314_1.leftNameTxt_.text = var_317_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_3 = arg_314_1:GetWordFromCfg(936041075)
				local var_317_4 = arg_314_1:FormatText(var_317_3.content)

				arg_314_1.text_.text = var_317_4

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 64
				local var_317_6 = utf8.len(var_317_4)
				local var_317_7 = var_317_5 <= 0 and var_317_1 or var_317_1 * (var_317_6 / var_317_5)

				if var_317_7 > 0 and var_317_1 < var_317_7 then
					arg_314_1.talkMaxDuration = var_317_7

					if var_317_7 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_7 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_4
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_8 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_8 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_8

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_8 and arg_314_1.time_ < var_317_0 + var_317_8 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play936041076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 936041076
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play936041077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 1.125

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[7].name)

				arg_318_1.leftNameTxt_.text = var_321_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_3 = arg_318_1:GetWordFromCfg(936041076)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 45
				local var_321_6 = utf8.len(var_321_4)
				local var_321_7 = var_321_5 <= 0 and var_321_1 or var_321_1 * (var_321_6 / var_321_5)

				if var_321_7 > 0 and var_321_1 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_8 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_8 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_8

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_8 and arg_318_1.time_ < var_321_0 + var_321_8 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play936041077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 936041077
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play936041078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 0.525

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_2 = arg_322_1:FormatText(StoryNameCfg[7].name)

				arg_322_1.leftNameTxt_.text = var_325_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_3 = arg_322_1:GetWordFromCfg(936041077)
				local var_325_4 = arg_322_1:FormatText(var_325_3.content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 21
				local var_325_6 = utf8.len(var_325_4)
				local var_325_7 = var_325_5 <= 0 and var_325_1 or var_325_1 * (var_325_6 / var_325_5)

				if var_325_7 > 0 and var_325_1 < var_325_7 then
					arg_322_1.talkMaxDuration = var_325_7

					if var_325_7 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_4
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_8 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_8 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_8

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_8 and arg_322_1.time_ < var_325_0 + var_325_8 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play936041078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 936041078
		arg_326_1.duration_ = 3.8

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play936041079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.375

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[1367].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_3 = arg_326_1:GetWordFromCfg(936041078)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041078", "story_v_side_old_936041.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041078", "story_v_side_old_936041.awb") / 1000

					if var_329_8 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_0
					end

					if var_329_3.prefab_name ~= "" and arg_326_1.actors_[var_329_3.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_3.prefab_name].transform, "story_v_side_old_936041", "936041078", "story_v_side_old_936041.awb")

						arg_326_1:RecordAudio("936041078", var_329_9)
						arg_326_1:RecordAudio("936041078", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041078", "story_v_side_old_936041.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041078", "story_v_side_old_936041.awb")
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
	Play936041079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 936041079
		arg_330_1.duration_ = 4.63

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play936041080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.55

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_2 = arg_330_1:FormatText(StoryNameCfg[1367].name)

				arg_330_1.leftNameTxt_.text = var_333_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_3 = arg_330_1:GetWordFromCfg(936041079)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 22
				local var_333_6 = utf8.len(var_333_4)
				local var_333_7 = var_333_5 <= 0 and var_333_1 or var_333_1 * (var_333_6 / var_333_5)

				if var_333_7 > 0 and var_333_1 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_4
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041079", "story_v_side_old_936041.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041079", "story_v_side_old_936041.awb") / 1000

					if var_333_8 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_0
					end

					if var_333_3.prefab_name ~= "" and arg_330_1.actors_[var_333_3.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_3.prefab_name].transform, "story_v_side_old_936041", "936041079", "story_v_side_old_936041.awb")

						arg_330_1:RecordAudio("936041079", var_333_9)
						arg_330_1:RecordAudio("936041079", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041079", "story_v_side_old_936041.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041079", "story_v_side_old_936041.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_10 and arg_330_1.time_ < var_333_0 + var_333_10 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play936041080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 936041080
		arg_334_1.duration_ = 4.97

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play936041081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.575

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_2 = arg_334_1:FormatText(StoryNameCfg[1367].name)

				arg_334_1.leftNameTxt_.text = var_337_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_3 = arg_334_1:GetWordFromCfg(936041080)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 23
				local var_337_6 = utf8.len(var_337_4)
				local var_337_7 = var_337_5 <= 0 and var_337_1 or var_337_1 * (var_337_6 / var_337_5)

				if var_337_7 > 0 and var_337_1 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041080", "story_v_side_old_936041.awb") ~= 0 then
					local var_337_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041080", "story_v_side_old_936041.awb") / 1000

					if var_337_8 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_8 + var_337_0
					end

					if var_337_3.prefab_name ~= "" and arg_334_1.actors_[var_337_3.prefab_name] ~= nil then
						local var_337_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_3.prefab_name].transform, "story_v_side_old_936041", "936041080", "story_v_side_old_936041.awb")

						arg_334_1:RecordAudio("936041080", var_337_9)
						arg_334_1:RecordAudio("936041080", var_337_9)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041080", "story_v_side_old_936041.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041080", "story_v_side_old_936041.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_10 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_10 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_10

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_10 and arg_334_1.time_ < var_337_0 + var_337_10 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play936041081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 936041081
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play936041082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.133333333333333
			local var_341_1 = 1

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				local var_341_2 = "play"
				local var_341_3 = "effect"

				arg_338_1:AudioAction(var_341_2, var_341_3, "ui_skip", "ui_bgm_66", "")
			end

			local var_341_4 = 0
			local var_341_5 = 0.65

			if var_341_4 < arg_338_1.time_ and arg_338_1.time_ <= var_341_4 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_6 = arg_338_1:FormatText(StoryNameCfg[7].name)

				arg_338_1.leftNameTxt_.text = var_341_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_7 = arg_338_1:GetWordFromCfg(936041081)
				local var_341_8 = arg_338_1:FormatText(var_341_7.content)

				arg_338_1.text_.text = var_341_8

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_9 = 26
				local var_341_10 = utf8.len(var_341_8)
				local var_341_11 = var_341_9 <= 0 and var_341_5 or var_341_5 * (var_341_10 / var_341_9)

				if var_341_11 > 0 and var_341_5 < var_341_11 then
					arg_338_1.talkMaxDuration = var_341_11

					if var_341_11 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_11 + var_341_4
					end
				end

				arg_338_1.text_.text = var_341_8
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_12 = math.max(var_341_5, arg_338_1.talkMaxDuration)

			if var_341_4 <= arg_338_1.time_ and arg_338_1.time_ < var_341_4 + var_341_12 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_4) / var_341_12

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_4 + var_341_12 and arg_338_1.time_ < var_341_4 + var_341_12 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play936041082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 936041082
		arg_342_1.duration_ = 5.13

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play936041083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 0.375

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_2 = arg_342_1:FormatText(StoryNameCfg[1367].name)

				arg_342_1.leftNameTxt_.text = var_345_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_3 = arg_342_1:GetWordFromCfg(936041082)
				local var_345_4 = arg_342_1:FormatText(var_345_3.content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041082", "story_v_side_old_936041.awb") ~= 0 then
					local var_345_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041082", "story_v_side_old_936041.awb") / 1000

					if var_345_8 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_8 + var_345_0
					end

					if var_345_3.prefab_name ~= "" and arg_342_1.actors_[var_345_3.prefab_name] ~= nil then
						local var_345_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_3.prefab_name].transform, "story_v_side_old_936041", "936041082", "story_v_side_old_936041.awb")

						arg_342_1:RecordAudio("936041082", var_345_9)
						arg_342_1:RecordAudio("936041082", var_345_9)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041082", "story_v_side_old_936041.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041082", "story_v_side_old_936041.awb")
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
	Play936041083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 936041083
		arg_346_1.duration_ = 6.43

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play936041084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.bgs_.SP93601.transform
			local var_349_1 = 1

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.var_.moveOldPosSP93601 = var_349_0.localPosition
			end

			local var_349_2 = 2.06666666666667

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2
				local var_349_4 = Vector3.New(0, 1, 0.5)

				var_349_0.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPosSP93601, var_349_4, var_349_3)
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 then
				var_349_0.localPosition = Vector3.New(0, 1, 0.5)
			end

			local var_349_5
			local var_349_6 = 1

			if var_349_6 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				local var_349_7 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_349_7 then
					var_349_7.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_349_7.radialBlurScale = 0
					var_349_7.radialBlurGradient = 1
					var_349_7.radialBlurIntensity = 1

					if var_349_5 then
						var_349_7.radialBlurTarget = var_349_5.transform
					end
				end
			end

			local var_349_8 = 2.06666666666667

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_8 then
				local var_349_9 = (arg_346_1.time_ - var_349_6) / var_349_8
				local var_349_10 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_349_10 then
					var_349_10.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_349_10.radialBlurScale = Mathf.Lerp(0, 0.3, var_349_9)
					var_349_10.radialBlurGradient = Mathf.Lerp(1, 1, var_349_9)
					var_349_10.radialBlurIntensity = Mathf.Lerp(1, 1, var_349_9)
				end
			end

			if arg_346_1.time_ >= var_349_6 + var_349_8 and arg_346_1.time_ < var_349_6 + var_349_8 + arg_349_0 then
				local var_349_11 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_349_11 then
					var_349_11.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_349_11.radialBlurScale = 0.3
					var_349_11.radialBlurGradient = 1
					var_349_11.radialBlurIntensity = 1
				end
			end

			local var_349_12 = 0

			if var_349_12 < arg_346_1.time_ and arg_346_1.time_ <= var_349_12 + arg_349_0 then
				arg_346_1.mask_.enabled = true
				arg_346_1.mask_.raycastTarget = true

				arg_346_1:SetGaussion(false)
			end

			local var_349_13 = 1

			if var_349_12 <= arg_346_1.time_ and arg_346_1.time_ < var_349_12 + var_349_13 then
				local var_349_14 = (arg_346_1.time_ - var_349_12) / var_349_13
				local var_349_15 = Color.New(0, 0, 0)

				var_349_15.a = Mathf.Lerp(0, 1, var_349_14)
				arg_346_1.mask_.color = var_349_15
			end

			if arg_346_1.time_ >= var_349_12 + var_349_13 and arg_346_1.time_ < var_349_12 + var_349_13 + arg_349_0 then
				local var_349_16 = Color.New(0, 0, 0)

				var_349_16.a = 1
				arg_346_1.mask_.color = var_349_16
			end

			local var_349_17 = 1

			if var_349_17 < arg_346_1.time_ and arg_346_1.time_ <= var_349_17 + arg_349_0 then
				arg_346_1.mask_.enabled = true
				arg_346_1.mask_.raycastTarget = true

				arg_346_1:SetGaussion(false)
			end

			local var_349_18 = 1

			if var_349_17 <= arg_346_1.time_ and arg_346_1.time_ < var_349_17 + var_349_18 then
				local var_349_19 = (arg_346_1.time_ - var_349_17) / var_349_18
				local var_349_20 = Color.New(0, 0, 0)

				var_349_20.a = Mathf.Lerp(1, 0, var_349_19)
				arg_346_1.mask_.color = var_349_20
			end

			if arg_346_1.time_ >= var_349_17 + var_349_18 and arg_346_1.time_ < var_349_17 + var_349_18 + arg_349_0 then
				local var_349_21 = Color.New(0, 0, 0)
				local var_349_22 = 0

				arg_346_1.mask_.enabled = false
				var_349_21.a = var_349_22
				arg_346_1.mask_.color = var_349_21
			end

			local var_349_23 = 0.133333333333333
			local var_349_24 = 1

			if var_349_23 < arg_346_1.time_ and arg_346_1.time_ <= var_349_23 + arg_349_0 then
				local var_349_25 = "play"
				local var_349_26 = "effect"

				arg_346_1:AudioAction(var_349_25, var_349_26, "ui_skip", "ui_bgm_33", "")
			end

			local var_349_27 = 1.43333333333333
			local var_349_28 = 1.5

			if var_349_27 < arg_346_1.time_ and arg_346_1.time_ <= var_349_27 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_29 = arg_346_1:GetWordFromCfg(936041083)
				local var_349_30 = arg_346_1:FormatText(var_349_29.content)

				arg_346_1.text_.text = var_349_30

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_31 = 60
				local var_349_32 = utf8.len(var_349_30)
				local var_349_33 = var_349_31 <= 0 and var_349_28 or var_349_28 * (var_349_32 / var_349_31)

				if var_349_33 > 0 and var_349_28 < var_349_33 then
					arg_346_1.talkMaxDuration = var_349_33

					if var_349_33 + var_349_27 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_33 + var_349_27
					end
				end

				arg_346_1.text_.text = var_349_30
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_34 = math.max(var_349_28, arg_346_1.talkMaxDuration)

			if var_349_27 <= arg_346_1.time_ and arg_346_1.time_ < var_349_27 + var_349_34 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_27) / var_349_34

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_27 + var_349_34 and arg_346_1.time_ < var_349_27 + var_349_34 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93601",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.06666666666667,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 1),
					endPos = Vector3.New(0, 1, 0.5),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play936041084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 936041084
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play936041085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 1.125

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_2 = arg_350_1:GetWordFromCfg(936041084)
				local var_353_3 = arg_350_1:FormatText(var_353_2.content)

				arg_350_1.text_.text = var_353_3

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_4 = 45
				local var_353_5 = utf8.len(var_353_3)
				local var_353_6 = var_353_4 <= 0 and var_353_1 or var_353_1 * (var_353_5 / var_353_4)

				if var_353_6 > 0 and var_353_1 < var_353_6 then
					arg_350_1.talkMaxDuration = var_353_6

					if var_353_6 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_6 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_3
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_7 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_7 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_7

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_7 and arg_350_1.time_ < var_353_0 + var_353_7 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play936041085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 936041085
		arg_354_1.duration_ = 9

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play936041086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = "STblack"

			if arg_354_1.bgs_[var_357_0] == nil then
				local var_357_1 = Object.Instantiate(arg_354_1.paintGo_)

				var_357_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_357_0)
				var_357_1.name = var_357_0
				var_357_1.transform.parent = arg_354_1.stage_.transform
				var_357_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_354_1.bgs_[var_357_0] = var_357_1
			end

			local var_357_2 = 2

			if var_357_2 < arg_354_1.time_ and arg_354_1.time_ <= var_357_2 + arg_357_0 then
				local var_357_3 = manager.ui.mainCamera.transform.localPosition
				local var_357_4 = Vector3.New(0, 0, 10) + Vector3.New(var_357_3.x, var_357_3.y, 0)
				local var_357_5 = arg_354_1.bgs_.STblack

				var_357_5.transform.localPosition = var_357_4
				var_357_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_357_6 = var_357_5:GetComponent("SpriteRenderer")

				if var_357_6 and var_357_6.sprite then
					local var_357_7 = (var_357_5.transform.localPosition - var_357_3).z
					local var_357_8 = manager.ui.mainCameraCom_
					local var_357_9 = 2 * var_357_7 * Mathf.Tan(var_357_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_357_10 = var_357_9 * var_357_8.aspect
					local var_357_11 = var_357_6.sprite.bounds.size.x
					local var_357_12 = var_357_6.sprite.bounds.size.y
					local var_357_13 = var_357_10 / var_357_11
					local var_357_14 = var_357_9 / var_357_12
					local var_357_15 = var_357_14 < var_357_13 and var_357_13 or var_357_14

					var_357_5.transform.localScale = Vector3.New(var_357_15, var_357_15, 0)
				end

				for iter_357_0, iter_357_1 in pairs(arg_354_1.bgs_) do
					if iter_357_0 ~= "STblack" then
						iter_357_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_357_16 = 4

			if var_357_16 < arg_354_1.time_ and arg_354_1.time_ <= var_357_16 + arg_357_0 then
				arg_354_1.allBtn_.enabled = false
			end

			local var_357_17 = 0.3

			if arg_354_1.time_ >= var_357_16 + var_357_17 and arg_354_1.time_ < var_357_16 + var_357_17 + arg_357_0 then
				arg_354_1.allBtn_.enabled = true
			end

			local var_357_18 = 0

			if var_357_18 < arg_354_1.time_ and arg_354_1.time_ <= var_357_18 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_19 = 2

			if var_357_18 <= arg_354_1.time_ and arg_354_1.time_ < var_357_18 + var_357_19 then
				local var_357_20 = (arg_354_1.time_ - var_357_18) / var_357_19
				local var_357_21 = Color.New(1, 1, 1)

				var_357_21.a = Mathf.Lerp(0, 1, var_357_20)
				arg_354_1.mask_.color = var_357_21
			end

			if arg_354_1.time_ >= var_357_18 + var_357_19 and arg_354_1.time_ < var_357_18 + var_357_19 + arg_357_0 then
				local var_357_22 = Color.New(1, 1, 1)

				var_357_22.a = 1
				arg_354_1.mask_.color = var_357_22
			end

			local var_357_23 = 2

			if var_357_23 < arg_354_1.time_ and arg_354_1.time_ <= var_357_23 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_24 = 2

			if var_357_23 <= arg_354_1.time_ and arg_354_1.time_ < var_357_23 + var_357_24 then
				local var_357_25 = (arg_354_1.time_ - var_357_23) / var_357_24
				local var_357_26 = Color.New(1, 1, 1)

				var_357_26.a = Mathf.Lerp(1, 0, var_357_25)
				arg_354_1.mask_.color = var_357_26
			end

			if arg_354_1.time_ >= var_357_23 + var_357_24 and arg_354_1.time_ < var_357_23 + var_357_24 + arg_357_0 then
				local var_357_27 = Color.New(1, 1, 1)
				local var_357_28 = 0

				arg_354_1.mask_.enabled = false
				var_357_27.a = var_357_28
				arg_354_1.mask_.color = var_357_27
			end

			if arg_354_1.frameCnt_ <= 1 then
				arg_354_1.dialog_:SetActive(false)
			end

			local var_357_29 = 4
			local var_357_30 = 0.575

			if var_357_29 < arg_354_1.time_ and arg_354_1.time_ <= var_357_29 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0

				arg_354_1.dialog_:SetActive(true)

				arg_354_1.dialogCg_.alpha = 0

				local var_357_31 = LeanTween.value(arg_354_1.dialog_, 0, 1, 0.3)

				var_357_31:setOnUpdate(LuaHelper.FloatAction(function(arg_358_0)
					arg_354_1.dialogCg_.alpha = arg_358_0
				end))
				var_357_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_354_1.dialog_)
					var_357_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_354_1.duration_ = arg_354_1.duration_ + 0.3

				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_32 = arg_354_1:GetWordFromCfg(936041085)
				local var_357_33 = arg_354_1:FormatText(var_357_32.content)

				arg_354_1.text_.text = var_357_33

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_34 = 23
				local var_357_35 = utf8.len(var_357_33)
				local var_357_36 = var_357_34 <= 0 and var_357_30 or var_357_30 * (var_357_35 / var_357_34)

				if var_357_36 > 0 and var_357_30 < var_357_36 then
					arg_354_1.talkMaxDuration = var_357_36
					var_357_29 = var_357_29 + 0.3

					if var_357_36 + var_357_29 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_36 + var_357_29
					end
				end

				arg_354_1.text_.text = var_357_33
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_37 = var_357_29 + 0.3
			local var_357_38 = math.max(var_357_30, arg_354_1.talkMaxDuration)

			if var_357_37 <= arg_354_1.time_ and arg_354_1.time_ < var_357_37 + var_357_38 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_37) / var_357_38

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_37 + var_357_38 and arg_354_1.time_ < var_357_37 + var_357_38 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play936041086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 936041086
		arg_360_1.duration_ = 6.73

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play936041087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 1
			local var_363_1 = 0.3

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				local var_363_2 = "play"
				local var_363_3 = "music"

				arg_360_1:AudioAction(var_363_2, var_363_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_363_4 = ""
				local var_363_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_363_5 ~= "" then
					if arg_360_1.bgmTxt_.text ~= var_363_5 and arg_360_1.bgmTxt_.text ~= "" then
						if arg_360_1.bgmTxt2_.text ~= "" then
							arg_360_1.bgmTxt_.text = arg_360_1.bgmTxt2_.text
						end

						arg_360_1.bgmTxt2_.text = var_363_5

						arg_360_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_360_1.bgmTxt_.text = var_363_5
						arg_360_1.bgmTxt2_.text = var_363_5
					end

					if arg_360_1.bgmTimer then
						arg_360_1.bgmTimer:Stop()

						arg_360_1.bgmTimer = nil
					end

					if arg_360_1.settingData.show_music_name == 1 then
						arg_360_1.musicController:SetSelectedState("show")
						arg_360_1.musicAnimator_:Play("open", 0, 0)

						if arg_360_1.settingData.music_time ~= 0 then
							arg_360_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_360_1.settingData.music_time), function()
								if arg_360_1 == nil or isNil(arg_360_1.bgmTxt_) then
									return
								end

								arg_360_1.musicController:SetSelectedState("hide")
								arg_360_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_363_6 = 0
			local var_363_7 = 0.325

			if var_363_6 < arg_360_1.time_ and arg_360_1.time_ <= var_363_6 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_8 = arg_360_1:FormatText(StoryNameCfg[1367].name)

				arg_360_1.leftNameTxt_.text = var_363_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1044")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_9 = arg_360_1:GetWordFromCfg(936041086)
				local var_363_10 = arg_360_1:FormatText(var_363_9.content)

				arg_360_1.text_.text = var_363_10

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_11 = 13
				local var_363_12 = utf8.len(var_363_10)
				local var_363_13 = var_363_11 <= 0 and var_363_7 or var_363_7 * (var_363_12 / var_363_11)

				if var_363_13 > 0 and var_363_7 < var_363_13 then
					arg_360_1.talkMaxDuration = var_363_13

					if var_363_13 + var_363_6 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_13 + var_363_6
					end
				end

				arg_360_1.text_.text = var_363_10
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041086", "story_v_side_old_936041.awb") ~= 0 then
					local var_363_14 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041086", "story_v_side_old_936041.awb") / 1000

					if var_363_14 + var_363_6 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_14 + var_363_6
					end

					if var_363_9.prefab_name ~= "" and arg_360_1.actors_[var_363_9.prefab_name] ~= nil then
						local var_363_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_9.prefab_name].transform, "story_v_side_old_936041", "936041086", "story_v_side_old_936041.awb")

						arg_360_1:RecordAudio("936041086", var_363_15)
						arg_360_1:RecordAudio("936041086", var_363_15)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041086", "story_v_side_old_936041.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041086", "story_v_side_old_936041.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_16 = math.max(var_363_7, arg_360_1.talkMaxDuration)

			if var_363_6 <= arg_360_1.time_ and arg_360_1.time_ < var_363_6 + var_363_16 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_6) / var_363_16

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_6 + var_363_16 and arg_360_1.time_ < var_363_6 + var_363_16 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play936041087 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 936041087
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play936041088(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["104402ui_story"].transform
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.var_.moveOldPos104402ui_story = var_368_0.localPosition

				local var_368_2 = GameObjectTools.GetOrAddComponent(var_368_0.gameObject, typeof(DynamicBoneHelper))

				if var_368_2 then
					var_368_2:EnableDynamicBone(false)
				end
			end

			local var_368_3 = 0.001

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_3 then
				local var_368_4 = (arg_365_1.time_ - var_368_1) / var_368_3
				local var_368_5 = Vector3.New(0, 100, 0)

				var_368_0.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos104402ui_story, var_368_5, var_368_4)

				local var_368_6 = manager.ui.mainCamera.transform.position - var_368_0.position

				var_368_0.forward = Vector3.New(var_368_6.x, var_368_6.y, var_368_6.z)

				local var_368_7 = var_368_0.localEulerAngles

				var_368_7.z = 0
				var_368_7.x = 0
				var_368_0.localEulerAngles = var_368_7
			end

			if arg_365_1.time_ >= var_368_1 + var_368_3 and arg_365_1.time_ < var_368_1 + var_368_3 + arg_368_0 then
				var_368_0.localPosition = Vector3.New(0, 100, 0)

				local var_368_8 = manager.ui.mainCamera.transform.position - var_368_0.position

				var_368_0.forward = Vector3.New(var_368_8.x, var_368_8.y, var_368_8.z)

				local var_368_9 = var_368_0.localEulerAngles

				var_368_9.z = 0
				var_368_9.x = 0
				var_368_0.localEulerAngles = var_368_9

				local var_368_10 = GameObjectTools.GetOrAddComponent(var_368_0.gameObject, typeof(DynamicBoneHelper))

				if var_368_10 then
					var_368_10:EnableDynamicBone(true)
				end
			end

			local var_368_11 = arg_365_1.actors_["104402ui_story"]
			local var_368_12 = 0

			if var_368_12 < arg_365_1.time_ and arg_365_1.time_ <= var_368_12 + arg_368_0 and not isNil(var_368_11) and arg_365_1.var_.characterEffect104402ui_story == nil then
				arg_365_1.var_.characterEffect104402ui_story = var_368_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_13 = 0.200000002980232

			if var_368_12 <= arg_365_1.time_ and arg_365_1.time_ < var_368_12 + var_368_13 and not isNil(var_368_11) then
				local var_368_14 = (arg_365_1.time_ - var_368_12) / var_368_13

				if arg_365_1.var_.characterEffect104402ui_story and not isNil(var_368_11) then
					local var_368_15 = Mathf.Lerp(0, 0.5, var_368_14)

					arg_365_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_365_1.var_.characterEffect104402ui_story.fillRatio = var_368_15
				end
			end

			if arg_365_1.time_ >= var_368_12 + var_368_13 and arg_365_1.time_ < var_368_12 + var_368_13 + arg_368_0 and not isNil(var_368_11) and arg_365_1.var_.characterEffect104402ui_story then
				local var_368_16 = 0.5

				arg_365_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_365_1.var_.characterEffect104402ui_story.fillRatio = var_368_16
			end

			local var_368_17 = 0
			local var_368_18 = 0.85

			if var_368_17 < arg_365_1.time_ and arg_365_1.time_ <= var_368_17 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_19 = arg_365_1:GetWordFromCfg(936041087)
				local var_368_20 = arg_365_1:FormatText(var_368_19.content)

				arg_365_1.text_.text = var_368_20

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_21 = 34
				local var_368_22 = utf8.len(var_368_20)
				local var_368_23 = var_368_21 <= 0 and var_368_18 or var_368_18 * (var_368_22 / var_368_21)

				if var_368_23 > 0 and var_368_18 < var_368_23 then
					arg_365_1.talkMaxDuration = var_368_23

					if var_368_23 + var_368_17 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_23 + var_368_17
					end
				end

				arg_365_1.text_.text = var_368_20
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_24 = math.max(var_368_18, arg_365_1.talkMaxDuration)

			if var_368_17 <= arg_365_1.time_ and arg_365_1.time_ < var_368_17 + var_368_24 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_17) / var_368_24

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_17 + var_368_24 and arg_365_1.time_ < var_368_17 + var_368_24 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
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
	Play936041088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 936041088
		arg_369_1.duration_ = 7

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play936041089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				local var_372_1 = manager.ui.mainCamera.transform.localPosition
				local var_372_2 = Vector3.New(0, 0, 10) + Vector3.New(var_372_1.x, var_372_1.y, 0)
				local var_372_3 = arg_369_1.bgs_.X206_g

				var_372_3.transform.localPosition = var_372_2
				var_372_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_372_4 = var_372_3:GetComponent("SpriteRenderer")

				if var_372_4 and var_372_4.sprite then
					local var_372_5 = (var_372_3.transform.localPosition - var_372_1).z
					local var_372_6 = manager.ui.mainCameraCom_
					local var_372_7 = 2 * var_372_5 * Mathf.Tan(var_372_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_372_8 = var_372_7 * var_372_6.aspect
					local var_372_9 = var_372_4.sprite.bounds.size.x
					local var_372_10 = var_372_4.sprite.bounds.size.y
					local var_372_11 = var_372_8 / var_372_9
					local var_372_12 = var_372_7 / var_372_10
					local var_372_13 = var_372_12 < var_372_11 and var_372_11 or var_372_12

					var_372_3.transform.localScale = Vector3.New(var_372_13, var_372_13, 0)
				end

				for iter_372_0, iter_372_1 in pairs(arg_369_1.bgs_) do
					if iter_372_0 ~= "X206_g" then
						iter_372_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_372_14 = 2

			if var_372_14 < arg_369_1.time_ and arg_369_1.time_ <= var_372_14 + arg_372_0 then
				arg_369_1.allBtn_.enabled = false
			end

			local var_372_15 = 0.3

			if arg_369_1.time_ >= var_372_14 + var_372_15 and arg_369_1.time_ < var_372_14 + var_372_15 + arg_372_0 then
				arg_369_1.allBtn_.enabled = true
			end

			local var_372_16 = 0

			if var_372_16 < arg_369_1.time_ and arg_369_1.time_ <= var_372_16 + arg_372_0 then
				arg_369_1.mask_.enabled = true
				arg_369_1.mask_.raycastTarget = true

				arg_369_1:SetGaussion(false)
			end

			local var_372_17 = 2

			if var_372_16 <= arg_369_1.time_ and arg_369_1.time_ < var_372_16 + var_372_17 then
				local var_372_18 = (arg_369_1.time_ - var_372_16) / var_372_17
				local var_372_19 = Color.New(0, 0, 0)

				var_372_19.a = Mathf.Lerp(1, 0, var_372_18)
				arg_369_1.mask_.color = var_372_19
			end

			if arg_369_1.time_ >= var_372_16 + var_372_17 and arg_369_1.time_ < var_372_16 + var_372_17 + arg_372_0 then
				local var_372_20 = Color.New(0, 0, 0)
				local var_372_21 = 0

				arg_369_1.mask_.enabled = false
				var_372_20.a = var_372_21
				arg_369_1.mask_.color = var_372_20
			end

			local var_372_22
			local var_372_23 = 0

			if var_372_23 < arg_369_1.time_ and arg_369_1.time_ <= var_372_23 + arg_372_0 then
				local var_372_24 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_372_24 then
					var_372_24.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_372_24.radialBlurScale = 0
					var_372_24.radialBlurGradient = 1
					var_372_24.radialBlurIntensity = 1

					if var_372_22 then
						var_372_24.radialBlurTarget = var_372_22.transform
					end
				end
			end

			local var_372_25 = 0.166666666666667

			if var_372_23 <= arg_369_1.time_ and arg_369_1.time_ < var_372_23 + var_372_25 then
				local var_372_26 = (arg_369_1.time_ - var_372_23) / var_372_25
				local var_372_27 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_372_27 then
					var_372_27.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_372_27.radialBlurScale = Mathf.Lerp(0, 0, var_372_26)
					var_372_27.radialBlurGradient = Mathf.Lerp(1, 1, var_372_26)
					var_372_27.radialBlurIntensity = Mathf.Lerp(1, 1, var_372_26)
				end
			end

			if arg_369_1.time_ >= var_372_23 + var_372_25 and arg_369_1.time_ < var_372_23 + var_372_25 + arg_372_0 then
				local var_372_28 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_372_28 then
					var_372_28.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_372_28.radialBlurScale = 0
					var_372_28.radialBlurGradient = 1
					var_372_28.radialBlurIntensity = 1
				end
			end

			local var_372_29 = 0.166666666666667
			local var_372_30 = 1

			if var_372_29 < arg_369_1.time_ and arg_369_1.time_ <= var_372_29 + arg_372_0 then
				local var_372_31 = "play"
				local var_372_32 = "music"

				arg_369_1:AudioAction(var_372_31, var_372_32, "bgm_activity_5_0_scene_104402_room", "bgm_activity_5_0_scene_104402_room", "bgm_activity_5_0_scene_104402_room.awb")

				local var_372_33 = ""
				local var_372_34 = manager.audio:GetAudioName("bgm_activity_5_0_scene_104402_room", "bgm_activity_5_0_scene_104402_room")

				if var_372_34 ~= "" then
					if arg_369_1.bgmTxt_.text ~= var_372_34 and arg_369_1.bgmTxt_.text ~= "" then
						if arg_369_1.bgmTxt2_.text ~= "" then
							arg_369_1.bgmTxt_.text = arg_369_1.bgmTxt2_.text
						end

						arg_369_1.bgmTxt2_.text = var_372_34

						arg_369_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_369_1.bgmTxt_.text = var_372_34
						arg_369_1.bgmTxt2_.text = var_372_34
					end

					if arg_369_1.bgmTimer then
						arg_369_1.bgmTimer:Stop()

						arg_369_1.bgmTimer = nil
					end

					if arg_369_1.settingData.show_music_name == 1 then
						arg_369_1.musicController:SetSelectedState("show")
						arg_369_1.musicAnimator_:Play("open", 0, 0)

						if arg_369_1.settingData.music_time ~= 0 then
							arg_369_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_369_1.settingData.music_time), function()
								if arg_369_1 == nil or isNil(arg_369_1.bgmTxt_) then
									return
								end

								arg_369_1.musicController:SetSelectedState("hide")
								arg_369_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_372_35 = 0.133333333333333
			local var_372_36 = 1

			if var_372_35 < arg_369_1.time_ and arg_369_1.time_ <= var_372_35 + arg_372_0 then
				local var_372_37 = "play"
				local var_372_38 = "effect"

				arg_369_1:AudioAction(var_372_37, var_372_38, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_372_39 = 0.034000001847744
			local var_372_40 = 1

			if var_372_39 < arg_369_1.time_ and arg_369_1.time_ <= var_372_39 + arg_372_0 then
				local var_372_41 = "stop"
				local var_372_42 = "effect"

				arg_369_1:AudioAction(var_372_41, var_372_42, "se_story_side_1095", "se_story_side_1095_amb_beach_night", "")
			end

			local var_372_43 = 0
			local var_372_44 = 1

			if var_372_43 < arg_369_1.time_ and arg_369_1.time_ <= var_372_43 + arg_372_0 then
				local var_372_45 = "play"
				local var_372_46 = "effect"

				arg_369_1:AudioAction(var_372_45, var_372_46, "ui_skip", "ui_bgm_100", "")
			end

			if arg_369_1.frameCnt_ <= 1 then
				arg_369_1.dialog_:SetActive(false)
			end

			local var_372_47 = 2
			local var_372_48 = 0.6

			if var_372_47 < arg_369_1.time_ and arg_369_1.time_ <= var_372_47 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0

				arg_369_1.dialog_:SetActive(true)

				arg_369_1.dialogCg_.alpha = 0

				local var_372_49 = LeanTween.value(arg_369_1.dialog_, 0, 1, 0.3)

				var_372_49:setOnUpdate(LuaHelper.FloatAction(function(arg_374_0)
					arg_369_1.dialogCg_.alpha = arg_374_0
				end))
				var_372_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_369_1.dialog_)
					var_372_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_369_1.duration_ = arg_369_1.duration_ + 0.3

				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_50 = arg_369_1:FormatText(StoryNameCfg[7].name)

				arg_369_1.leftNameTxt_.text = var_372_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_51 = arg_369_1:GetWordFromCfg(936041088)
				local var_372_52 = arg_369_1:FormatText(var_372_51.content)

				arg_369_1.text_.text = var_372_52

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_53 = 24
				local var_372_54 = utf8.len(var_372_52)
				local var_372_55 = var_372_53 <= 0 and var_372_48 or var_372_48 * (var_372_54 / var_372_53)

				if var_372_55 > 0 and var_372_48 < var_372_55 then
					arg_369_1.talkMaxDuration = var_372_55
					var_372_47 = var_372_47 + 0.3

					if var_372_55 + var_372_47 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_55 + var_372_47
					end
				end

				arg_369_1.text_.text = var_372_52
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_56 = var_372_47 + 0.3
			local var_372_57 = math.max(var_372_48, arg_369_1.talkMaxDuration)

			if var_372_56 <= arg_369_1.time_ and arg_369_1.time_ < var_372_56 + var_372_57 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_56) / var_372_57

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_56 + var_372_57 and arg_369_1.time_ < var_372_56 + var_372_57 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play936041089 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 936041089
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play936041090(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 1.025

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_2 = arg_376_1:GetWordFromCfg(936041089)
				local var_379_3 = arg_376_1:FormatText(var_379_2.content)

				arg_376_1.text_.text = var_379_3

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 41
				local var_379_5 = utf8.len(var_379_3)
				local var_379_6 = var_379_4 <= 0 and var_379_1 or var_379_1 * (var_379_5 / var_379_4)

				if var_379_6 > 0 and var_379_1 < var_379_6 then
					arg_376_1.talkMaxDuration = var_379_6

					if var_379_6 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_6 + var_379_0
					end
				end

				arg_376_1.text_.text = var_379_3
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_7 and arg_376_1.time_ < var_379_0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play936041090 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 936041090
		arg_380_1.duration_ = 8.57

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play936041091(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["614801ui_story"].transform
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.var_.moveOldPos614801ui_story = var_383_0.localPosition

				local var_383_2 = GameObjectTools.GetOrAddComponent(var_383_0.gameObject, typeof(DynamicBoneHelper))

				if var_383_2 then
					var_383_2:EnableDynamicBone(false)
				end
			end

			local var_383_3 = 0.001

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_3 then
				local var_383_4 = (arg_380_1.time_ - var_383_1) / var_383_3
				local var_383_5 = Vector3.New(-0.7, -0.985, -6)

				var_383_0.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos614801ui_story, var_383_5, var_383_4)

				local var_383_6 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_6.x, var_383_6.y, var_383_6.z)

				local var_383_7 = var_383_0.localEulerAngles

				var_383_7.z = 0
				var_383_7.x = 0
				var_383_0.localEulerAngles = var_383_7
			end

			if arg_380_1.time_ >= var_383_1 + var_383_3 and arg_380_1.time_ < var_383_1 + var_383_3 + arg_383_0 then
				var_383_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_383_8 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_8.x, var_383_8.y, var_383_8.z)

				local var_383_9 = var_383_0.localEulerAngles

				var_383_9.z = 0
				var_383_9.x = 0
				var_383_0.localEulerAngles = var_383_9

				local var_383_10 = GameObjectTools.GetOrAddComponent(var_383_0.gameObject, typeof(DynamicBoneHelper))

				if var_383_10 then
					var_383_10:EnableDynamicBone(true)
				end
			end

			local var_383_11 = arg_380_1.actors_["614801ui_story"]
			local var_383_12 = 0

			if var_383_12 < arg_380_1.time_ and arg_380_1.time_ <= var_383_12 + arg_383_0 and not isNil(var_383_11) and arg_380_1.var_.characterEffect614801ui_story == nil then
				arg_380_1.var_.characterEffect614801ui_story = var_383_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_13 = 0.200000002980232

			if var_383_12 <= arg_380_1.time_ and arg_380_1.time_ < var_383_12 + var_383_13 and not isNil(var_383_11) then
				local var_383_14 = (arg_380_1.time_ - var_383_12) / var_383_13

				if arg_380_1.var_.characterEffect614801ui_story and not isNil(var_383_11) then
					arg_380_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_12 + var_383_13 and arg_380_1.time_ < var_383_12 + var_383_13 + arg_383_0 and not isNil(var_383_11) and arg_380_1.var_.characterEffect614801ui_story then
				arg_380_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			local var_383_15 = 0

			if var_383_15 < arg_380_1.time_ and arg_380_1.time_ <= var_383_15 + arg_383_0 then
				arg_380_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_383_16 = 0

			if var_383_16 < arg_380_1.time_ and arg_380_1.time_ <= var_383_16 + arg_383_0 then
				arg_380_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_383_17 = 0
			local var_383_18 = 1.025

			if var_383_17 < arg_380_1.time_ and arg_380_1.time_ <= var_383_17 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_19 = arg_380_1:FormatText(StoryNameCfg[1488].name)

				arg_380_1.leftNameTxt_.text = var_383_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_20 = arg_380_1:GetWordFromCfg(936041090)
				local var_383_21 = arg_380_1:FormatText(var_383_20.content)

				arg_380_1.text_.text = var_383_21

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_22 = 41
				local var_383_23 = utf8.len(var_383_21)
				local var_383_24 = var_383_22 <= 0 and var_383_18 or var_383_18 * (var_383_23 / var_383_22)

				if var_383_24 > 0 and var_383_18 < var_383_24 then
					arg_380_1.talkMaxDuration = var_383_24

					if var_383_24 + var_383_17 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_24 + var_383_17
					end
				end

				arg_380_1.text_.text = var_383_21
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041090", "story_v_side_old_936041.awb") ~= 0 then
					local var_383_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041090", "story_v_side_old_936041.awb") / 1000

					if var_383_25 + var_383_17 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_25 + var_383_17
					end

					if var_383_20.prefab_name ~= "" and arg_380_1.actors_[var_383_20.prefab_name] ~= nil then
						local var_383_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_20.prefab_name].transform, "story_v_side_old_936041", "936041090", "story_v_side_old_936041.awb")

						arg_380_1:RecordAudio("936041090", var_383_26)
						arg_380_1:RecordAudio("936041090", var_383_26)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041090", "story_v_side_old_936041.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041090", "story_v_side_old_936041.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_27 = math.max(var_383_18, arg_380_1.talkMaxDuration)

			if var_383_17 <= arg_380_1.time_ and arg_380_1.time_ < var_383_17 + var_383_27 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_17) / var_383_27

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_17 + var_383_27 and arg_380_1.time_ < var_383_17 + var_383_27 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play936041091 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 936041091
		arg_384_1.duration_ = 2

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play936041092(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["104402ui_story"].transform
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.var_.moveOldPos104402ui_story = var_387_0.localPosition

				local var_387_2 = GameObjectTools.GetOrAddComponent(var_387_0.gameObject, typeof(DynamicBoneHelper))

				if var_387_2 then
					var_387_2:EnableDynamicBone(false)
				end
			end

			local var_387_3 = 0.001

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_3 then
				local var_387_4 = (arg_384_1.time_ - var_387_1) / var_387_3
				local var_387_5 = Vector3.New(0.7, -1, -5.93)

				var_387_0.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos104402ui_story, var_387_5, var_387_4)

				local var_387_6 = manager.ui.mainCamera.transform.position - var_387_0.position

				var_387_0.forward = Vector3.New(var_387_6.x, var_387_6.y, var_387_6.z)

				local var_387_7 = var_387_0.localEulerAngles

				var_387_7.z = 0
				var_387_7.x = 0
				var_387_0.localEulerAngles = var_387_7
			end

			if arg_384_1.time_ >= var_387_1 + var_387_3 and arg_384_1.time_ < var_387_1 + var_387_3 + arg_387_0 then
				var_387_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_387_8 = manager.ui.mainCamera.transform.position - var_387_0.position

				var_387_0.forward = Vector3.New(var_387_8.x, var_387_8.y, var_387_8.z)

				local var_387_9 = var_387_0.localEulerAngles

				var_387_9.z = 0
				var_387_9.x = 0
				var_387_0.localEulerAngles = var_387_9

				local var_387_10 = GameObjectTools.GetOrAddComponent(var_387_0.gameObject, typeof(DynamicBoneHelper))

				if var_387_10 then
					var_387_10:EnableDynamicBone(true)
				end
			end

			local var_387_11 = arg_384_1.actors_["104402ui_story"]
			local var_387_12 = 0

			if var_387_12 < arg_384_1.time_ and arg_384_1.time_ <= var_387_12 + arg_387_0 and not isNil(var_387_11) and arg_384_1.var_.characterEffect104402ui_story == nil then
				arg_384_1.var_.characterEffect104402ui_story = var_387_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_13 = 0.200000002980232

			if var_387_12 <= arg_384_1.time_ and arg_384_1.time_ < var_387_12 + var_387_13 and not isNil(var_387_11) then
				local var_387_14 = (arg_384_1.time_ - var_387_12) / var_387_13

				if arg_384_1.var_.characterEffect104402ui_story and not isNil(var_387_11) then
					arg_384_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= var_387_12 + var_387_13 and arg_384_1.time_ < var_387_12 + var_387_13 + arg_387_0 and not isNil(var_387_11) and arg_384_1.var_.characterEffect104402ui_story then
				arg_384_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_387_15 = arg_384_1.actors_["614801ui_story"]
			local var_387_16 = 0

			if var_387_16 < arg_384_1.time_ and arg_384_1.time_ <= var_387_16 + arg_387_0 and not isNil(var_387_15) and arg_384_1.var_.characterEffect614801ui_story == nil then
				arg_384_1.var_.characterEffect614801ui_story = var_387_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_17 = 0.200000002980232

			if var_387_16 <= arg_384_1.time_ and arg_384_1.time_ < var_387_16 + var_387_17 and not isNil(var_387_15) then
				local var_387_18 = (arg_384_1.time_ - var_387_16) / var_387_17

				if arg_384_1.var_.characterEffect614801ui_story and not isNil(var_387_15) then
					local var_387_19 = Mathf.Lerp(0, 0.5, var_387_18)

					arg_384_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_384_1.var_.characterEffect614801ui_story.fillRatio = var_387_19
				end
			end

			if arg_384_1.time_ >= var_387_16 + var_387_17 and arg_384_1.time_ < var_387_16 + var_387_17 + arg_387_0 and not isNil(var_387_15) and arg_384_1.var_.characterEffect614801ui_story then
				local var_387_20 = 0.5

				arg_384_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_384_1.var_.characterEffect614801ui_story.fillRatio = var_387_20
			end

			local var_387_21 = 0

			if var_387_21 < arg_384_1.time_ and arg_384_1.time_ <= var_387_21 + arg_387_0 then
				arg_384_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			local var_387_22 = 0

			if var_387_22 < arg_384_1.time_ and arg_384_1.time_ <= var_387_22 + arg_387_0 then
				arg_384_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_387_23 = 0
			local var_387_24 = 0.1

			if var_387_23 < arg_384_1.time_ and arg_384_1.time_ <= var_387_23 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_25 = arg_384_1:FormatText(StoryNameCfg[1367].name)

				arg_384_1.leftNameTxt_.text = var_387_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_26 = arg_384_1:GetWordFromCfg(936041091)
				local var_387_27 = arg_384_1:FormatText(var_387_26.content)

				arg_384_1.text_.text = var_387_27

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_28 = 4
				local var_387_29 = utf8.len(var_387_27)
				local var_387_30 = var_387_28 <= 0 and var_387_24 or var_387_24 * (var_387_29 / var_387_28)

				if var_387_30 > 0 and var_387_24 < var_387_30 then
					arg_384_1.talkMaxDuration = var_387_30

					if var_387_30 + var_387_23 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_30 + var_387_23
					end
				end

				arg_384_1.text_.text = var_387_27
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041091", "story_v_side_old_936041.awb") ~= 0 then
					local var_387_31 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041091", "story_v_side_old_936041.awb") / 1000

					if var_387_31 + var_387_23 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_31 + var_387_23
					end

					if var_387_26.prefab_name ~= "" and arg_384_1.actors_[var_387_26.prefab_name] ~= nil then
						local var_387_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_26.prefab_name].transform, "story_v_side_old_936041", "936041091", "story_v_side_old_936041.awb")

						arg_384_1:RecordAudio("936041091", var_387_32)
						arg_384_1:RecordAudio("936041091", var_387_32)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041091", "story_v_side_old_936041.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041091", "story_v_side_old_936041.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_33 = math.max(var_387_24, arg_384_1.talkMaxDuration)

			if var_387_23 <= arg_384_1.time_ and arg_384_1.time_ < var_387_23 + var_387_33 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_23) / var_387_33

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_23 + var_387_33 and arg_384_1.time_ < var_387_23 + var_387_33 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play936041092 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 936041092
		arg_388_1.duration_ = 6.17

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play936041093(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["104402ui_story"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect104402ui_story == nil then
				arg_388_1.var_.characterEffect104402ui_story = var_391_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.characterEffect104402ui_story and not isNil(var_391_0) then
					local var_391_4 = Mathf.Lerp(0, 0.5, var_391_3)

					arg_388_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_388_1.var_.characterEffect104402ui_story.fillRatio = var_391_4
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect104402ui_story then
				local var_391_5 = 0.5

				arg_388_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_388_1.var_.characterEffect104402ui_story.fillRatio = var_391_5
			end

			local var_391_6 = 0

			if var_391_6 < arg_388_1.time_ and arg_388_1.time_ <= var_391_6 + arg_391_0 then
				arg_388_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_391_7 = 0

			if var_391_7 < arg_388_1.time_ and arg_388_1.time_ <= var_391_7 + arg_391_0 then
				arg_388_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_391_8 = arg_388_1.actors_["614801ui_story"]
			local var_391_9 = 0

			if var_391_9 < arg_388_1.time_ and arg_388_1.time_ <= var_391_9 + arg_391_0 and not isNil(var_391_8) and arg_388_1.var_.characterEffect614801ui_story == nil then
				arg_388_1.var_.characterEffect614801ui_story = var_391_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_10 = 0.200000002980232

			if var_391_9 <= arg_388_1.time_ and arg_388_1.time_ < var_391_9 + var_391_10 and not isNil(var_391_8) then
				local var_391_11 = (arg_388_1.time_ - var_391_9) / var_391_10

				if arg_388_1.var_.characterEffect614801ui_story and not isNil(var_391_8) then
					arg_388_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= var_391_9 + var_391_10 and arg_388_1.time_ < var_391_9 + var_391_10 + arg_391_0 and not isNil(var_391_8) and arg_388_1.var_.characterEffect614801ui_story then
				arg_388_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			local var_391_12 = 0
			local var_391_13 = 0.5

			if var_391_12 < arg_388_1.time_ and arg_388_1.time_ <= var_391_12 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_14 = arg_388_1:FormatText(StoryNameCfg[1488].name)

				arg_388_1.leftNameTxt_.text = var_391_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_15 = arg_388_1:GetWordFromCfg(936041092)
				local var_391_16 = arg_388_1:FormatText(var_391_15.content)

				arg_388_1.text_.text = var_391_16

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_17 = 20
				local var_391_18 = utf8.len(var_391_16)
				local var_391_19 = var_391_17 <= 0 and var_391_13 or var_391_13 * (var_391_18 / var_391_17)

				if var_391_19 > 0 and var_391_13 < var_391_19 then
					arg_388_1.talkMaxDuration = var_391_19

					if var_391_19 + var_391_12 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_19 + var_391_12
					end
				end

				arg_388_1.text_.text = var_391_16
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041092", "story_v_side_old_936041.awb") ~= 0 then
					local var_391_20 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041092", "story_v_side_old_936041.awb") / 1000

					if var_391_20 + var_391_12 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_20 + var_391_12
					end

					if var_391_15.prefab_name ~= "" and arg_388_1.actors_[var_391_15.prefab_name] ~= nil then
						local var_391_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_15.prefab_name].transform, "story_v_side_old_936041", "936041092", "story_v_side_old_936041.awb")

						arg_388_1:RecordAudio("936041092", var_391_21)
						arg_388_1:RecordAudio("936041092", var_391_21)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041092", "story_v_side_old_936041.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041092", "story_v_side_old_936041.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_22 = math.max(var_391_13, arg_388_1.talkMaxDuration)

			if var_391_12 <= arg_388_1.time_ and arg_388_1.time_ < var_391_12 + var_391_22 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_12) / var_391_22

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_12 + var_391_22 and arg_388_1.time_ < var_391_12 + var_391_22 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play936041093 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 936041093
		arg_392_1.duration_ = 5.87

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play936041094(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["104402ui_story"].transform
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.var_.moveOldPos104402ui_story = var_395_0.localPosition

				local var_395_2 = GameObjectTools.GetOrAddComponent(var_395_0.gameObject, typeof(DynamicBoneHelper))

				if var_395_2 then
					var_395_2:EnableDynamicBone(false)
				end
			end

			local var_395_3 = 0.001

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_3 then
				local var_395_4 = (arg_392_1.time_ - var_395_1) / var_395_3
				local var_395_5 = Vector3.New(0.7, -1, -5.93)

				var_395_0.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos104402ui_story, var_395_5, var_395_4)

				local var_395_6 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_6.x, var_395_6.y, var_395_6.z)

				local var_395_7 = var_395_0.localEulerAngles

				var_395_7.z = 0
				var_395_7.x = 0
				var_395_0.localEulerAngles = var_395_7
			end

			if arg_392_1.time_ >= var_395_1 + var_395_3 and arg_392_1.time_ < var_395_1 + var_395_3 + arg_395_0 then
				var_395_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_395_8 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_8.x, var_395_8.y, var_395_8.z)

				local var_395_9 = var_395_0.localEulerAngles

				var_395_9.z = 0
				var_395_9.x = 0
				var_395_0.localEulerAngles = var_395_9

				local var_395_10 = GameObjectTools.GetOrAddComponent(var_395_0.gameObject, typeof(DynamicBoneHelper))

				if var_395_10 then
					var_395_10:EnableDynamicBone(true)
				end
			end

			local var_395_11 = arg_392_1.actors_["104402ui_story"]
			local var_395_12 = 0

			if var_395_12 < arg_392_1.time_ and arg_392_1.time_ <= var_395_12 + arg_395_0 and not isNil(var_395_11) and arg_392_1.var_.characterEffect104402ui_story == nil then
				arg_392_1.var_.characterEffect104402ui_story = var_395_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_13 = 0.200000002980232

			if var_395_12 <= arg_392_1.time_ and arg_392_1.time_ < var_395_12 + var_395_13 and not isNil(var_395_11) then
				local var_395_14 = (arg_392_1.time_ - var_395_12) / var_395_13

				if arg_392_1.var_.characterEffect104402ui_story and not isNil(var_395_11) then
					arg_392_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_12 + var_395_13 and arg_392_1.time_ < var_395_12 + var_395_13 + arg_395_0 and not isNil(var_395_11) and arg_392_1.var_.characterEffect104402ui_story then
				arg_392_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_395_15 = arg_392_1.actors_["614801ui_story"]
			local var_395_16 = 0

			if var_395_16 < arg_392_1.time_ and arg_392_1.time_ <= var_395_16 + arg_395_0 and not isNil(var_395_15) and arg_392_1.var_.characterEffect614801ui_story == nil then
				arg_392_1.var_.characterEffect614801ui_story = var_395_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_17 = 0.200000002980232

			if var_395_16 <= arg_392_1.time_ and arg_392_1.time_ < var_395_16 + var_395_17 and not isNil(var_395_15) then
				local var_395_18 = (arg_392_1.time_ - var_395_16) / var_395_17

				if arg_392_1.var_.characterEffect614801ui_story and not isNil(var_395_15) then
					local var_395_19 = Mathf.Lerp(0, 0.5, var_395_18)

					arg_392_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_392_1.var_.characterEffect614801ui_story.fillRatio = var_395_19
				end
			end

			if arg_392_1.time_ >= var_395_16 + var_395_17 and arg_392_1.time_ < var_395_16 + var_395_17 + arg_395_0 and not isNil(var_395_15) and arg_392_1.var_.characterEffect614801ui_story then
				local var_395_20 = 0.5

				arg_392_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_392_1.var_.characterEffect614801ui_story.fillRatio = var_395_20
			end

			local var_395_21 = 0

			if var_395_21 < arg_392_1.time_ and arg_392_1.time_ <= var_395_21 + arg_395_0 then
				arg_392_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402actionlink/104402action435")
			end

			local var_395_22 = 0

			if var_395_22 < arg_392_1.time_ and arg_392_1.time_ <= var_395_22 + arg_395_0 then
				arg_392_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_395_23 = 0
			local var_395_24 = 0.725

			if var_395_23 < arg_392_1.time_ and arg_392_1.time_ <= var_395_23 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_25 = arg_392_1:FormatText(StoryNameCfg[1367].name)

				arg_392_1.leftNameTxt_.text = var_395_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_26 = arg_392_1:GetWordFromCfg(936041093)
				local var_395_27 = arg_392_1:FormatText(var_395_26.content)

				arg_392_1.text_.text = var_395_27

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_28 = 29
				local var_395_29 = utf8.len(var_395_27)
				local var_395_30 = var_395_28 <= 0 and var_395_24 or var_395_24 * (var_395_29 / var_395_28)

				if var_395_30 > 0 and var_395_24 < var_395_30 then
					arg_392_1.talkMaxDuration = var_395_30

					if var_395_30 + var_395_23 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_30 + var_395_23
					end
				end

				arg_392_1.text_.text = var_395_27
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041093", "story_v_side_old_936041.awb") ~= 0 then
					local var_395_31 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041093", "story_v_side_old_936041.awb") / 1000

					if var_395_31 + var_395_23 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_31 + var_395_23
					end

					if var_395_26.prefab_name ~= "" and arg_392_1.actors_[var_395_26.prefab_name] ~= nil then
						local var_395_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_26.prefab_name].transform, "story_v_side_old_936041", "936041093", "story_v_side_old_936041.awb")

						arg_392_1:RecordAudio("936041093", var_395_32)
						arg_392_1:RecordAudio("936041093", var_395_32)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041093", "story_v_side_old_936041.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041093", "story_v_side_old_936041.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_33 = math.max(var_395_24, arg_392_1.talkMaxDuration)

			if var_395_23 <= arg_392_1.time_ and arg_392_1.time_ < var_395_23 + var_395_33 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_23) / var_395_33

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_23 + var_395_33 and arg_392_1.time_ < var_395_23 + var_395_33 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
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
	Play936041094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 936041094
		arg_396_1.duration_ = 2

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play936041095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["105401ui_story"].transform
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.var_.moveOldPos105401ui_story = var_399_0.localPosition

				local var_399_2 = GameObjectTools.GetOrAddComponent(var_399_0.gameObject, typeof(DynamicBoneHelper))

				if var_399_2 then
					var_399_2:EnableDynamicBone(false)
				end
			end

			local var_399_3 = 0.001

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_3 then
				local var_399_4 = (arg_396_1.time_ - var_399_1) / var_399_3
				local var_399_5 = Vector3.New(0.7, -0.985, -6)

				var_399_0.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos105401ui_story, var_399_5, var_399_4)

				local var_399_6 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_6.x, var_399_6.y, var_399_6.z)

				local var_399_7 = var_399_0.localEulerAngles

				var_399_7.z = 0
				var_399_7.x = 0
				var_399_0.localEulerAngles = var_399_7
			end

			if arg_396_1.time_ >= var_399_1 + var_399_3 and arg_396_1.time_ < var_399_1 + var_399_3 + arg_399_0 then
				var_399_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_399_8 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_8.x, var_399_8.y, var_399_8.z)

				local var_399_9 = var_399_0.localEulerAngles

				var_399_9.z = 0
				var_399_9.x = 0
				var_399_0.localEulerAngles = var_399_9

				local var_399_10 = GameObjectTools.GetOrAddComponent(var_399_0.gameObject, typeof(DynamicBoneHelper))

				if var_399_10 then
					var_399_10:EnableDynamicBone(true)
				end
			end

			local var_399_11 = arg_396_1.actors_["104402ui_story"].transform
			local var_399_12 = 0

			if var_399_12 < arg_396_1.time_ and arg_396_1.time_ <= var_399_12 + arg_399_0 then
				arg_396_1.var_.moveOldPos104402ui_story = var_399_11.localPosition

				local var_399_13 = GameObjectTools.GetOrAddComponent(var_399_11.gameObject, typeof(DynamicBoneHelper))

				if var_399_13 then
					var_399_13:EnableDynamicBone(false)
				end
			end

			local var_399_14 = 0.001

			if var_399_12 <= arg_396_1.time_ and arg_396_1.time_ < var_399_12 + var_399_14 then
				local var_399_15 = (arg_396_1.time_ - var_399_12) / var_399_14
				local var_399_16 = Vector3.New(0, 100, 0)

				var_399_11.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos104402ui_story, var_399_16, var_399_15)

				local var_399_17 = manager.ui.mainCamera.transform.position - var_399_11.position

				var_399_11.forward = Vector3.New(var_399_17.x, var_399_17.y, var_399_17.z)

				local var_399_18 = var_399_11.localEulerAngles

				var_399_18.z = 0
				var_399_18.x = 0
				var_399_11.localEulerAngles = var_399_18
			end

			if arg_396_1.time_ >= var_399_12 + var_399_14 and arg_396_1.time_ < var_399_12 + var_399_14 + arg_399_0 then
				var_399_11.localPosition = Vector3.New(0, 100, 0)

				local var_399_19 = manager.ui.mainCamera.transform.position - var_399_11.position

				var_399_11.forward = Vector3.New(var_399_19.x, var_399_19.y, var_399_19.z)

				local var_399_20 = var_399_11.localEulerAngles

				var_399_20.z = 0
				var_399_20.x = 0
				var_399_11.localEulerAngles = var_399_20

				local var_399_21 = GameObjectTools.GetOrAddComponent(var_399_11.gameObject, typeof(DynamicBoneHelper))

				if var_399_21 then
					var_399_21:EnableDynamicBone(true)
				end
			end

			local var_399_22 = arg_396_1.actors_["105401ui_story"]
			local var_399_23 = 0

			if var_399_23 < arg_396_1.time_ and arg_396_1.time_ <= var_399_23 + arg_399_0 and not isNil(var_399_22) and arg_396_1.var_.characterEffect105401ui_story == nil then
				arg_396_1.var_.characterEffect105401ui_story = var_399_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_24 = 0.200000002980232

			if var_399_23 <= arg_396_1.time_ and arg_396_1.time_ < var_399_23 + var_399_24 and not isNil(var_399_22) then
				local var_399_25 = (arg_396_1.time_ - var_399_23) / var_399_24

				if arg_396_1.var_.characterEffect105401ui_story and not isNil(var_399_22) then
					arg_396_1.var_.characterEffect105401ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= var_399_23 + var_399_24 and arg_396_1.time_ < var_399_23 + var_399_24 + arg_399_0 and not isNil(var_399_22) and arg_396_1.var_.characterEffect105401ui_story then
				arg_396_1.var_.characterEffect105401ui_story.fillFlat = false
			end

			local var_399_26 = arg_396_1.actors_["104402ui_story"]
			local var_399_27 = 0

			if var_399_27 < arg_396_1.time_ and arg_396_1.time_ <= var_399_27 + arg_399_0 and not isNil(var_399_26) and arg_396_1.var_.characterEffect104402ui_story == nil then
				arg_396_1.var_.characterEffect104402ui_story = var_399_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_28 = 0.200000002980232

			if var_399_27 <= arg_396_1.time_ and arg_396_1.time_ < var_399_27 + var_399_28 and not isNil(var_399_26) then
				local var_399_29 = (arg_396_1.time_ - var_399_27) / var_399_28

				if arg_396_1.var_.characterEffect104402ui_story and not isNil(var_399_26) then
					local var_399_30 = Mathf.Lerp(0, 0.5, var_399_29)

					arg_396_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_396_1.var_.characterEffect104402ui_story.fillRatio = var_399_30
				end
			end

			if arg_396_1.time_ >= var_399_27 + var_399_28 and arg_396_1.time_ < var_399_27 + var_399_28 + arg_399_0 and not isNil(var_399_26) and arg_396_1.var_.characterEffect104402ui_story then
				local var_399_31 = 0.5

				arg_396_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_396_1.var_.characterEffect104402ui_story.fillRatio = var_399_31
			end

			local var_399_32 = 0

			if var_399_32 < arg_396_1.time_ and arg_396_1.time_ <= var_399_32 + arg_399_0 then
				arg_396_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_399_33 = 0

			if var_399_33 < arg_396_1.time_ and arg_396_1.time_ <= var_399_33 + arg_399_0 then
				arg_396_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_399_34 = arg_396_1.actors_["614801ui_story"].transform
			local var_399_35 = 0

			if var_399_35 < arg_396_1.time_ and arg_396_1.time_ <= var_399_35 + arg_399_0 then
				arg_396_1.var_.moveOldPos614801ui_story = var_399_34.localPosition

				local var_399_36 = GameObjectTools.GetOrAddComponent(var_399_34.gameObject, typeof(DynamicBoneHelper))

				if var_399_36 then
					var_399_36:EnableDynamicBone(false)
				end
			end

			local var_399_37 = 0.001

			if var_399_35 <= arg_396_1.time_ and arg_396_1.time_ < var_399_35 + var_399_37 then
				local var_399_38 = (arg_396_1.time_ - var_399_35) / var_399_37
				local var_399_39 = Vector3.New(0, 100, 0)

				var_399_34.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos614801ui_story, var_399_39, var_399_38)

				local var_399_40 = manager.ui.mainCamera.transform.position - var_399_34.position

				var_399_34.forward = Vector3.New(var_399_40.x, var_399_40.y, var_399_40.z)

				local var_399_41 = var_399_34.localEulerAngles

				var_399_41.z = 0
				var_399_41.x = 0
				var_399_34.localEulerAngles = var_399_41
			end

			if arg_396_1.time_ >= var_399_35 + var_399_37 and arg_396_1.time_ < var_399_35 + var_399_37 + arg_399_0 then
				var_399_34.localPosition = Vector3.New(0, 100, 0)

				local var_399_42 = manager.ui.mainCamera.transform.position - var_399_34.position

				var_399_34.forward = Vector3.New(var_399_42.x, var_399_42.y, var_399_42.z)

				local var_399_43 = var_399_34.localEulerAngles

				var_399_43.z = 0
				var_399_43.x = 0
				var_399_34.localEulerAngles = var_399_43

				local var_399_44 = GameObjectTools.GetOrAddComponent(var_399_34.gameObject, typeof(DynamicBoneHelper))

				if var_399_44 then
					var_399_44:EnableDynamicBone(true)
				end
			end

			local var_399_45 = 0
			local var_399_46 = 0.05

			if var_399_45 < arg_396_1.time_ and arg_396_1.time_ <= var_399_45 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_47 = arg_396_1:FormatText(StoryNameCfg[1487].name)

				arg_396_1.leftNameTxt_.text = var_399_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_48 = arg_396_1:GetWordFromCfg(936041094)
				local var_399_49 = arg_396_1:FormatText(var_399_48.content)

				arg_396_1.text_.text = var_399_49

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_50 = 2
				local var_399_51 = utf8.len(var_399_49)
				local var_399_52 = var_399_50 <= 0 and var_399_46 or var_399_46 * (var_399_51 / var_399_50)

				if var_399_52 > 0 and var_399_46 < var_399_52 then
					arg_396_1.talkMaxDuration = var_399_52

					if var_399_52 + var_399_45 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_52 + var_399_45
					end
				end

				arg_396_1.text_.text = var_399_49
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041094", "story_v_side_old_936041.awb") ~= 0 then
					local var_399_53 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041094", "story_v_side_old_936041.awb") / 1000

					if var_399_53 + var_399_45 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_53 + var_399_45
					end

					if var_399_48.prefab_name ~= "" and arg_396_1.actors_[var_399_48.prefab_name] ~= nil then
						local var_399_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_48.prefab_name].transform, "story_v_side_old_936041", "936041094", "story_v_side_old_936041.awb")

						arg_396_1:RecordAudio("936041094", var_399_54)
						arg_396_1:RecordAudio("936041094", var_399_54)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041094", "story_v_side_old_936041.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041094", "story_v_side_old_936041.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_55 = math.max(var_399_46, arg_396_1.talkMaxDuration)

			if var_399_45 <= arg_396_1.time_ and arg_396_1.time_ < var_399_45 + var_399_55 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_45) / var_399_55

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_45 + var_399_55 and arg_396_1.time_ < var_399_45 + var_399_55 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "614801ui_story",
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
	Play936041095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 936041095
		arg_400_1.duration_ = 2

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play936041096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["121102ui_story"].transform
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.var_.moveOldPos121102ui_story = var_403_0.localPosition

				local var_403_2 = GameObjectTools.GetOrAddComponent(var_403_0.gameObject, typeof(DynamicBoneHelper))

				if var_403_2 then
					var_403_2:EnableDynamicBone(false)
				end
			end

			local var_403_3 = 0.001

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_3 then
				local var_403_4 = (arg_400_1.time_ - var_403_1) / var_403_3
				local var_403_5 = Vector3.New(-0.7, -0.67, -6.07)

				var_403_0.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos121102ui_story, var_403_5, var_403_4)

				local var_403_6 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_6.x, var_403_6.y, var_403_6.z)

				local var_403_7 = var_403_0.localEulerAngles

				var_403_7.z = 0
				var_403_7.x = 0
				var_403_0.localEulerAngles = var_403_7
			end

			if arg_400_1.time_ >= var_403_1 + var_403_3 and arg_400_1.time_ < var_403_1 + var_403_3 + arg_403_0 then
				var_403_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_403_8 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_8.x, var_403_8.y, var_403_8.z)

				local var_403_9 = var_403_0.localEulerAngles

				var_403_9.z = 0
				var_403_9.x = 0
				var_403_0.localEulerAngles = var_403_9

				local var_403_10 = GameObjectTools.GetOrAddComponent(var_403_0.gameObject, typeof(DynamicBoneHelper))

				if var_403_10 then
					var_403_10:EnableDynamicBone(true)
				end
			end

			local var_403_11 = arg_400_1.actors_["105401ui_story"].transform
			local var_403_12 = 0

			if var_403_12 < arg_400_1.time_ and arg_400_1.time_ <= var_403_12 + arg_403_0 then
				arg_400_1.var_.moveOldPos105401ui_story = var_403_11.localPosition

				local var_403_13 = GameObjectTools.GetOrAddComponent(var_403_11.gameObject, typeof(DynamicBoneHelper))

				if var_403_13 then
					var_403_13:EnableDynamicBone(false)
				end
			end

			local var_403_14 = 0.001

			if var_403_12 <= arg_400_1.time_ and arg_400_1.time_ < var_403_12 + var_403_14 then
				local var_403_15 = (arg_400_1.time_ - var_403_12) / var_403_14
				local var_403_16 = Vector3.New(0, 100, 0)

				var_403_11.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos105401ui_story, var_403_16, var_403_15)

				local var_403_17 = manager.ui.mainCamera.transform.position - var_403_11.position

				var_403_11.forward = Vector3.New(var_403_17.x, var_403_17.y, var_403_17.z)

				local var_403_18 = var_403_11.localEulerAngles

				var_403_18.z = 0
				var_403_18.x = 0
				var_403_11.localEulerAngles = var_403_18
			end

			if arg_400_1.time_ >= var_403_12 + var_403_14 and arg_400_1.time_ < var_403_12 + var_403_14 + arg_403_0 then
				var_403_11.localPosition = Vector3.New(0, 100, 0)

				local var_403_19 = manager.ui.mainCamera.transform.position - var_403_11.position

				var_403_11.forward = Vector3.New(var_403_19.x, var_403_19.y, var_403_19.z)

				local var_403_20 = var_403_11.localEulerAngles

				var_403_20.z = 0
				var_403_20.x = 0
				var_403_11.localEulerAngles = var_403_20

				local var_403_21 = GameObjectTools.GetOrAddComponent(var_403_11.gameObject, typeof(DynamicBoneHelper))

				if var_403_21 then
					var_403_21:EnableDynamicBone(true)
				end
			end

			local var_403_22 = arg_400_1.actors_["121102ui_story"]
			local var_403_23 = 0

			if var_403_23 < arg_400_1.time_ and arg_400_1.time_ <= var_403_23 + arg_403_0 and not isNil(var_403_22) and arg_400_1.var_.characterEffect121102ui_story == nil then
				arg_400_1.var_.characterEffect121102ui_story = var_403_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_24 = 0.200000002980232

			if var_403_23 <= arg_400_1.time_ and arg_400_1.time_ < var_403_23 + var_403_24 and not isNil(var_403_22) then
				local var_403_25 = (arg_400_1.time_ - var_403_23) / var_403_24

				if arg_400_1.var_.characterEffect121102ui_story and not isNil(var_403_22) then
					arg_400_1.var_.characterEffect121102ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= var_403_23 + var_403_24 and arg_400_1.time_ < var_403_23 + var_403_24 + arg_403_0 and not isNil(var_403_22) and arg_400_1.var_.characterEffect121102ui_story then
				arg_400_1.var_.characterEffect121102ui_story.fillFlat = false
			end

			local var_403_26 = arg_400_1.actors_["614801ui_story"]
			local var_403_27 = 0

			if var_403_27 < arg_400_1.time_ and arg_400_1.time_ <= var_403_27 + arg_403_0 and not isNil(var_403_26) and arg_400_1.var_.characterEffect614801ui_story == nil then
				arg_400_1.var_.characterEffect614801ui_story = var_403_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_28 = 0.200000002980232

			if var_403_27 <= arg_400_1.time_ and arg_400_1.time_ < var_403_27 + var_403_28 and not isNil(var_403_26) then
				local var_403_29 = (arg_400_1.time_ - var_403_27) / var_403_28

				if arg_400_1.var_.characterEffect614801ui_story and not isNil(var_403_26) then
					local var_403_30 = Mathf.Lerp(0, 0.5, var_403_29)

					arg_400_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_400_1.var_.characterEffect614801ui_story.fillRatio = var_403_30
				end
			end

			if arg_400_1.time_ >= var_403_27 + var_403_28 and arg_400_1.time_ < var_403_27 + var_403_28 + arg_403_0 and not isNil(var_403_26) and arg_400_1.var_.characterEffect614801ui_story then
				local var_403_31 = 0.5

				arg_400_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_400_1.var_.characterEffect614801ui_story.fillRatio = var_403_31
			end

			local var_403_32 = 0

			if var_403_32 < arg_400_1.time_ and arg_400_1.time_ <= var_403_32 + arg_403_0 then
				arg_400_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			local var_403_33 = 0

			if var_403_33 < arg_400_1.time_ and arg_400_1.time_ <= var_403_33 + arg_403_0 then
				arg_400_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_403_34 = 0
			local var_403_35 = 0.05

			if var_403_34 < arg_400_1.time_ and arg_400_1.time_ <= var_403_34 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_36 = arg_400_1:FormatText(StoryNameCfg[37].name)

				arg_400_1.leftNameTxt_.text = var_403_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_37 = arg_400_1:GetWordFromCfg(936041095)
				local var_403_38 = arg_400_1:FormatText(var_403_37.content)

				arg_400_1.text_.text = var_403_38

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_39 = 2
				local var_403_40 = utf8.len(var_403_38)
				local var_403_41 = var_403_39 <= 0 and var_403_35 or var_403_35 * (var_403_40 / var_403_39)

				if var_403_41 > 0 and var_403_35 < var_403_41 then
					arg_400_1.talkMaxDuration = var_403_41

					if var_403_41 + var_403_34 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_41 + var_403_34
					end
				end

				arg_400_1.text_.text = var_403_38
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041095", "story_v_side_old_936041.awb") ~= 0 then
					local var_403_42 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041095", "story_v_side_old_936041.awb") / 1000

					if var_403_42 + var_403_34 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_42 + var_403_34
					end

					if var_403_37.prefab_name ~= "" and arg_400_1.actors_[var_403_37.prefab_name] ~= nil then
						local var_403_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_37.prefab_name].transform, "story_v_side_old_936041", "936041095", "story_v_side_old_936041.awb")

						arg_400_1:RecordAudio("936041095", var_403_43)
						arg_400_1:RecordAudio("936041095", var_403_43)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041095", "story_v_side_old_936041.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041095", "story_v_side_old_936041.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_44 = math.max(var_403_35, arg_400_1.talkMaxDuration)

			if var_403_34 <= arg_400_1.time_ and arg_400_1.time_ < var_403_34 + var_403_44 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_34) / var_403_44

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_34 + var_403_44 and arg_400_1.time_ < var_403_34 + var_403_44 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105401ui_story",
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
	Play936041096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 936041096
		arg_404_1.duration_ = 3.37

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play936041097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["104402ui_story"].transform
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1.var_.moveOldPos104402ui_story = var_407_0.localPosition

				local var_407_2 = GameObjectTools.GetOrAddComponent(var_407_0.gameObject, typeof(DynamicBoneHelper))

				if var_407_2 then
					var_407_2:EnableDynamicBone(false)
				end
			end

			local var_407_3 = 0.001

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_3 then
				local var_407_4 = (arg_404_1.time_ - var_407_1) / var_407_3
				local var_407_5 = Vector3.New(0.7, -1, -5.93)

				var_407_0.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos104402ui_story, var_407_5, var_407_4)

				local var_407_6 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_6.x, var_407_6.y, var_407_6.z)

				local var_407_7 = var_407_0.localEulerAngles

				var_407_7.z = 0
				var_407_7.x = 0
				var_407_0.localEulerAngles = var_407_7
			end

			if arg_404_1.time_ >= var_407_1 + var_407_3 and arg_404_1.time_ < var_407_1 + var_407_3 + arg_407_0 then
				var_407_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_407_8 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_8.x, var_407_8.y, var_407_8.z)

				local var_407_9 = var_407_0.localEulerAngles

				var_407_9.z = 0
				var_407_9.x = 0
				var_407_0.localEulerAngles = var_407_9

				local var_407_10 = GameObjectTools.GetOrAddComponent(var_407_0.gameObject, typeof(DynamicBoneHelper))

				if var_407_10 then
					var_407_10:EnableDynamicBone(true)
				end
			end

			local var_407_11 = arg_404_1.actors_["614801ui_story"].transform
			local var_407_12 = 0

			if var_407_12 < arg_404_1.time_ and arg_404_1.time_ <= var_407_12 + arg_407_0 then
				arg_404_1.var_.moveOldPos614801ui_story = var_407_11.localPosition

				local var_407_13 = GameObjectTools.GetOrAddComponent(var_407_11.gameObject, typeof(DynamicBoneHelper))

				if var_407_13 then
					var_407_13:EnableDynamicBone(false)
				end
			end

			local var_407_14 = 0.001

			if var_407_12 <= arg_404_1.time_ and arg_404_1.time_ < var_407_12 + var_407_14 then
				local var_407_15 = (arg_404_1.time_ - var_407_12) / var_407_14
				local var_407_16 = Vector3.New(0, 100, 0)

				var_407_11.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos614801ui_story, var_407_16, var_407_15)

				local var_407_17 = manager.ui.mainCamera.transform.position - var_407_11.position

				var_407_11.forward = Vector3.New(var_407_17.x, var_407_17.y, var_407_17.z)

				local var_407_18 = var_407_11.localEulerAngles

				var_407_18.z = 0
				var_407_18.x = 0
				var_407_11.localEulerAngles = var_407_18
			end

			if arg_404_1.time_ >= var_407_12 + var_407_14 and arg_404_1.time_ < var_407_12 + var_407_14 + arg_407_0 then
				var_407_11.localPosition = Vector3.New(0, 100, 0)

				local var_407_19 = manager.ui.mainCamera.transform.position - var_407_11.position

				var_407_11.forward = Vector3.New(var_407_19.x, var_407_19.y, var_407_19.z)

				local var_407_20 = var_407_11.localEulerAngles

				var_407_20.z = 0
				var_407_20.x = 0
				var_407_11.localEulerAngles = var_407_20

				local var_407_21 = GameObjectTools.GetOrAddComponent(var_407_11.gameObject, typeof(DynamicBoneHelper))

				if var_407_21 then
					var_407_21:EnableDynamicBone(true)
				end
			end

			local var_407_22 = arg_404_1.actors_["104402ui_story"]
			local var_407_23 = 0

			if var_407_23 < arg_404_1.time_ and arg_404_1.time_ <= var_407_23 + arg_407_0 and not isNil(var_407_22) and arg_404_1.var_.characterEffect104402ui_story == nil then
				arg_404_1.var_.characterEffect104402ui_story = var_407_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_24 = 0.200000002980232

			if var_407_23 <= arg_404_1.time_ and arg_404_1.time_ < var_407_23 + var_407_24 and not isNil(var_407_22) then
				local var_407_25 = (arg_404_1.time_ - var_407_23) / var_407_24

				if arg_404_1.var_.characterEffect104402ui_story and not isNil(var_407_22) then
					arg_404_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= var_407_23 + var_407_24 and arg_404_1.time_ < var_407_23 + var_407_24 + arg_407_0 and not isNil(var_407_22) and arg_404_1.var_.characterEffect104402ui_story then
				arg_404_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_407_26 = arg_404_1.actors_["121102ui_story"]
			local var_407_27 = 0

			if var_407_27 < arg_404_1.time_ and arg_404_1.time_ <= var_407_27 + arg_407_0 and not isNil(var_407_26) and arg_404_1.var_.characterEffect121102ui_story == nil then
				arg_404_1.var_.characterEffect121102ui_story = var_407_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_28 = 0.200000002980232

			if var_407_27 <= arg_404_1.time_ and arg_404_1.time_ < var_407_27 + var_407_28 and not isNil(var_407_26) then
				local var_407_29 = (arg_404_1.time_ - var_407_27) / var_407_28

				if arg_404_1.var_.characterEffect121102ui_story and not isNil(var_407_26) then
					local var_407_30 = Mathf.Lerp(0, 0.5, var_407_29)

					arg_404_1.var_.characterEffect121102ui_story.fillFlat = true
					arg_404_1.var_.characterEffect121102ui_story.fillRatio = var_407_30
				end
			end

			if arg_404_1.time_ >= var_407_27 + var_407_28 and arg_404_1.time_ < var_407_27 + var_407_28 + arg_407_0 and not isNil(var_407_26) and arg_404_1.var_.characterEffect121102ui_story then
				local var_407_31 = 0.5

				arg_404_1.var_.characterEffect121102ui_story.fillFlat = true
				arg_404_1.var_.characterEffect121102ui_story.fillRatio = var_407_31
			end

			local var_407_32 = 0

			if var_407_32 < arg_404_1.time_ and arg_404_1.time_ <= var_407_32 + arg_407_0 then
				arg_404_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_1")
			end

			local var_407_33 = 0

			if var_407_33 < arg_404_1.time_ and arg_404_1.time_ <= var_407_33 + arg_407_0 then
				arg_404_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_407_34 = 0
			local var_407_35 = 0.325

			if var_407_34 < arg_404_1.time_ and arg_404_1.time_ <= var_407_34 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_36 = arg_404_1:FormatText(StoryNameCfg[1367].name)

				arg_404_1.leftNameTxt_.text = var_407_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_37 = arg_404_1:GetWordFromCfg(936041096)
				local var_407_38 = arg_404_1:FormatText(var_407_37.content)

				arg_404_1.text_.text = var_407_38

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_39 = 13
				local var_407_40 = utf8.len(var_407_38)
				local var_407_41 = var_407_39 <= 0 and var_407_35 or var_407_35 * (var_407_40 / var_407_39)

				if var_407_41 > 0 and var_407_35 < var_407_41 then
					arg_404_1.talkMaxDuration = var_407_41

					if var_407_41 + var_407_34 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_41 + var_407_34
					end
				end

				arg_404_1.text_.text = var_407_38
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041096", "story_v_side_old_936041.awb") ~= 0 then
					local var_407_42 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041096", "story_v_side_old_936041.awb") / 1000

					if var_407_42 + var_407_34 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_42 + var_407_34
					end

					if var_407_37.prefab_name ~= "" and arg_404_1.actors_[var_407_37.prefab_name] ~= nil then
						local var_407_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_37.prefab_name].transform, "story_v_side_old_936041", "936041096", "story_v_side_old_936041.awb")

						arg_404_1:RecordAudio("936041096", var_407_43)
						arg_404_1:RecordAudio("936041096", var_407_43)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041096", "story_v_side_old_936041.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041096", "story_v_side_old_936041.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_44 = math.max(var_407_35, arg_404_1.talkMaxDuration)

			if var_407_34 <= arg_404_1.time_ and arg_404_1.time_ < var_407_34 + var_407_44 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_34) / var_407_44

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_34 + var_407_44 and arg_404_1.time_ < var_407_34 + var_407_44 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "614801ui_story",
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
	Play936041097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 936041097
		arg_408_1.duration_ = 6.97

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play936041098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["121102ui_story"].transform
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.var_.moveOldPos121102ui_story = var_411_0.localPosition

				local var_411_2 = GameObjectTools.GetOrAddComponent(var_411_0.gameObject, typeof(DynamicBoneHelper))

				if var_411_2 then
					var_411_2:EnableDynamicBone(false)
				end
			end

			local var_411_3 = 0.001

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_3 then
				local var_411_4 = (arg_408_1.time_ - var_411_1) / var_411_3
				local var_411_5 = Vector3.New(-0.7, -0.67, -6.07)

				var_411_0.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos121102ui_story, var_411_5, var_411_4)

				local var_411_6 = manager.ui.mainCamera.transform.position - var_411_0.position

				var_411_0.forward = Vector3.New(var_411_6.x, var_411_6.y, var_411_6.z)

				local var_411_7 = var_411_0.localEulerAngles

				var_411_7.z = 0
				var_411_7.x = 0
				var_411_0.localEulerAngles = var_411_7
			end

			if arg_408_1.time_ >= var_411_1 + var_411_3 and arg_408_1.time_ < var_411_1 + var_411_3 + arg_411_0 then
				var_411_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_411_8 = manager.ui.mainCamera.transform.position - var_411_0.position

				var_411_0.forward = Vector3.New(var_411_8.x, var_411_8.y, var_411_8.z)

				local var_411_9 = var_411_0.localEulerAngles

				var_411_9.z = 0
				var_411_9.x = 0
				var_411_0.localEulerAngles = var_411_9

				local var_411_10 = GameObjectTools.GetOrAddComponent(var_411_0.gameObject, typeof(DynamicBoneHelper))

				if var_411_10 then
					var_411_10:EnableDynamicBone(true)
				end
			end

			local var_411_11 = arg_408_1.actors_["121102ui_story"]
			local var_411_12 = 0

			if var_411_12 < arg_408_1.time_ and arg_408_1.time_ <= var_411_12 + arg_411_0 and not isNil(var_411_11) and arg_408_1.var_.characterEffect121102ui_story == nil then
				arg_408_1.var_.characterEffect121102ui_story = var_411_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_13 = 0.200000002980232

			if var_411_12 <= arg_408_1.time_ and arg_408_1.time_ < var_411_12 + var_411_13 and not isNil(var_411_11) then
				local var_411_14 = (arg_408_1.time_ - var_411_12) / var_411_13

				if arg_408_1.var_.characterEffect121102ui_story and not isNil(var_411_11) then
					arg_408_1.var_.characterEffect121102ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= var_411_12 + var_411_13 and arg_408_1.time_ < var_411_12 + var_411_13 + arg_411_0 and not isNil(var_411_11) and arg_408_1.var_.characterEffect121102ui_story then
				arg_408_1.var_.characterEffect121102ui_story.fillFlat = false
			end

			local var_411_15 = arg_408_1.actors_["104402ui_story"]
			local var_411_16 = 0

			if var_411_16 < arg_408_1.time_ and arg_408_1.time_ <= var_411_16 + arg_411_0 and not isNil(var_411_15) and arg_408_1.var_.characterEffect104402ui_story == nil then
				arg_408_1.var_.characterEffect104402ui_story = var_411_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_17 = 0.200000002980232

			if var_411_16 <= arg_408_1.time_ and arg_408_1.time_ < var_411_16 + var_411_17 and not isNil(var_411_15) then
				local var_411_18 = (arg_408_1.time_ - var_411_16) / var_411_17

				if arg_408_1.var_.characterEffect104402ui_story and not isNil(var_411_15) then
					local var_411_19 = Mathf.Lerp(0, 0.5, var_411_18)

					arg_408_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_408_1.var_.characterEffect104402ui_story.fillRatio = var_411_19
				end
			end

			if arg_408_1.time_ >= var_411_16 + var_411_17 and arg_408_1.time_ < var_411_16 + var_411_17 + arg_411_0 and not isNil(var_411_15) and arg_408_1.var_.characterEffect104402ui_story then
				local var_411_20 = 0.5

				arg_408_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_408_1.var_.characterEffect104402ui_story.fillRatio = var_411_20
			end

			local var_411_21 = 0

			if var_411_21 < arg_408_1.time_ and arg_408_1.time_ <= var_411_21 + arg_411_0 then
				arg_408_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_411_22 = 0

			if var_411_22 < arg_408_1.time_ and arg_408_1.time_ <= var_411_22 + arg_411_0 then
				arg_408_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_411_23 = 0
			local var_411_24 = 0.575

			if var_411_23 < arg_408_1.time_ and arg_408_1.time_ <= var_411_23 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_25 = arg_408_1:FormatText(StoryNameCfg[37].name)

				arg_408_1.leftNameTxt_.text = var_411_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_26 = arg_408_1:GetWordFromCfg(936041097)
				local var_411_27 = arg_408_1:FormatText(var_411_26.content)

				arg_408_1.text_.text = var_411_27

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_28 = 23
				local var_411_29 = utf8.len(var_411_27)
				local var_411_30 = var_411_28 <= 0 and var_411_24 or var_411_24 * (var_411_29 / var_411_28)

				if var_411_30 > 0 and var_411_24 < var_411_30 then
					arg_408_1.talkMaxDuration = var_411_30

					if var_411_30 + var_411_23 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_30 + var_411_23
					end
				end

				arg_408_1.text_.text = var_411_27
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041097", "story_v_side_old_936041.awb") ~= 0 then
					local var_411_31 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041097", "story_v_side_old_936041.awb") / 1000

					if var_411_31 + var_411_23 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_31 + var_411_23
					end

					if var_411_26.prefab_name ~= "" and arg_408_1.actors_[var_411_26.prefab_name] ~= nil then
						local var_411_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_26.prefab_name].transform, "story_v_side_old_936041", "936041097", "story_v_side_old_936041.awb")

						arg_408_1:RecordAudio("936041097", var_411_32)
						arg_408_1:RecordAudio("936041097", var_411_32)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041097", "story_v_side_old_936041.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041097", "story_v_side_old_936041.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_33 = math.max(var_411_24, arg_408_1.talkMaxDuration)

			if var_411_23 <= arg_408_1.time_ and arg_408_1.time_ < var_411_23 + var_411_33 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_23) / var_411_33

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_23 + var_411_33 and arg_408_1.time_ < var_411_23 + var_411_33 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "121102ui_story",
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
	Play936041098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 936041098
		arg_412_1.duration_ = 4

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play936041099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["104402ui_story"].transform
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.var_.moveOldPos104402ui_story = var_415_0.localPosition

				local var_415_2 = GameObjectTools.GetOrAddComponent(var_415_0.gameObject, typeof(DynamicBoneHelper))

				if var_415_2 then
					var_415_2:EnableDynamicBone(false)
				end
			end

			local var_415_3 = 0.001

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_3 then
				local var_415_4 = (arg_412_1.time_ - var_415_1) / var_415_3
				local var_415_5 = Vector3.New(0.7, -1, -5.93)

				var_415_0.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos104402ui_story, var_415_5, var_415_4)

				local var_415_6 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_6.x, var_415_6.y, var_415_6.z)

				local var_415_7 = var_415_0.localEulerAngles

				var_415_7.z = 0
				var_415_7.x = 0
				var_415_0.localEulerAngles = var_415_7
			end

			if arg_412_1.time_ >= var_415_1 + var_415_3 and arg_412_1.time_ < var_415_1 + var_415_3 + arg_415_0 then
				var_415_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_415_8 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_8.x, var_415_8.y, var_415_8.z)

				local var_415_9 = var_415_0.localEulerAngles

				var_415_9.z = 0
				var_415_9.x = 0
				var_415_0.localEulerAngles = var_415_9

				local var_415_10 = GameObjectTools.GetOrAddComponent(var_415_0.gameObject, typeof(DynamicBoneHelper))

				if var_415_10 then
					var_415_10:EnableDynamicBone(true)
				end
			end

			local var_415_11 = arg_412_1.actors_["104402ui_story"]
			local var_415_12 = 0

			if var_415_12 < arg_412_1.time_ and arg_412_1.time_ <= var_415_12 + arg_415_0 and not isNil(var_415_11) and arg_412_1.var_.characterEffect104402ui_story == nil then
				arg_412_1.var_.characterEffect104402ui_story = var_415_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_13 = 0.200000002980232

			if var_415_12 <= arg_412_1.time_ and arg_412_1.time_ < var_415_12 + var_415_13 and not isNil(var_415_11) then
				local var_415_14 = (arg_412_1.time_ - var_415_12) / var_415_13

				if arg_412_1.var_.characterEffect104402ui_story and not isNil(var_415_11) then
					arg_412_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= var_415_12 + var_415_13 and arg_412_1.time_ < var_415_12 + var_415_13 + arg_415_0 and not isNil(var_415_11) and arg_412_1.var_.characterEffect104402ui_story then
				arg_412_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_415_15 = arg_412_1.actors_["121102ui_story"]
			local var_415_16 = 0

			if var_415_16 < arg_412_1.time_ and arg_412_1.time_ <= var_415_16 + arg_415_0 and not isNil(var_415_15) and arg_412_1.var_.characterEffect121102ui_story == nil then
				arg_412_1.var_.characterEffect121102ui_story = var_415_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_17 = 0.200000002980232

			if var_415_16 <= arg_412_1.time_ and arg_412_1.time_ < var_415_16 + var_415_17 and not isNil(var_415_15) then
				local var_415_18 = (arg_412_1.time_ - var_415_16) / var_415_17

				if arg_412_1.var_.characterEffect121102ui_story and not isNil(var_415_15) then
					local var_415_19 = Mathf.Lerp(0, 0.5, var_415_18)

					arg_412_1.var_.characterEffect121102ui_story.fillFlat = true
					arg_412_1.var_.characterEffect121102ui_story.fillRatio = var_415_19
				end
			end

			if arg_412_1.time_ >= var_415_16 + var_415_17 and arg_412_1.time_ < var_415_16 + var_415_17 + arg_415_0 and not isNil(var_415_15) and arg_412_1.var_.characterEffect121102ui_story then
				local var_415_20 = 0.5

				arg_412_1.var_.characterEffect121102ui_story.fillFlat = true
				arg_412_1.var_.characterEffect121102ui_story.fillRatio = var_415_20
			end

			local var_415_21 = 0

			if var_415_21 < arg_412_1.time_ and arg_412_1.time_ <= var_415_21 + arg_415_0 then
				arg_412_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_2")
			end

			local var_415_22 = 2

			if var_415_22 < arg_412_1.time_ and arg_412_1.time_ <= var_415_22 + arg_415_0 then
				arg_412_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			local var_415_23 = 0

			if var_415_23 < arg_412_1.time_ and arg_412_1.time_ <= var_415_23 + arg_415_0 then
				arg_412_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_415_24 = 0
			local var_415_25 = 0.125

			if var_415_24 < arg_412_1.time_ and arg_412_1.time_ <= var_415_24 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_26 = arg_412_1:FormatText(StoryNameCfg[1367].name)

				arg_412_1.leftNameTxt_.text = var_415_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_27 = arg_412_1:GetWordFromCfg(936041098)
				local var_415_28 = arg_412_1:FormatText(var_415_27.content)

				arg_412_1.text_.text = var_415_28

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_29 = 5
				local var_415_30 = utf8.len(var_415_28)
				local var_415_31 = var_415_29 <= 0 and var_415_25 or var_415_25 * (var_415_30 / var_415_29)

				if var_415_31 > 0 and var_415_25 < var_415_31 then
					arg_412_1.talkMaxDuration = var_415_31

					if var_415_31 + var_415_24 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_31 + var_415_24
					end
				end

				arg_412_1.text_.text = var_415_28
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041098", "story_v_side_old_936041.awb") ~= 0 then
					local var_415_32 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041098", "story_v_side_old_936041.awb") / 1000

					if var_415_32 + var_415_24 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_32 + var_415_24
					end

					if var_415_27.prefab_name ~= "" and arg_412_1.actors_[var_415_27.prefab_name] ~= nil then
						local var_415_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_27.prefab_name].transform, "story_v_side_old_936041", "936041098", "story_v_side_old_936041.awb")

						arg_412_1:RecordAudio("936041098", var_415_33)
						arg_412_1:RecordAudio("936041098", var_415_33)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041098", "story_v_side_old_936041.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041098", "story_v_side_old_936041.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_34 = math.max(var_415_25, arg_412_1.talkMaxDuration)

			if var_415_24 <= arg_412_1.time_ and arg_412_1.time_ < var_415_24 + var_415_34 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_24) / var_415_34

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_24 + var_415_34 and arg_412_1.time_ < var_415_24 + var_415_34 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
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
	Play936041099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 936041099
		arg_416_1.duration_ = 2

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play936041100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_419_1 = 0
			local var_419_2 = 0.1

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_3 = arg_416_1:FormatText(StoryNameCfg[1367].name)

				arg_416_1.leftNameTxt_.text = var_419_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_4 = arg_416_1:GetWordFromCfg(936041099)
				local var_419_5 = arg_416_1:FormatText(var_419_4.content)

				arg_416_1.text_.text = var_419_5

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_6 = 4
				local var_419_7 = utf8.len(var_419_5)
				local var_419_8 = var_419_6 <= 0 and var_419_2 or var_419_2 * (var_419_7 / var_419_6)

				if var_419_8 > 0 and var_419_2 < var_419_8 then
					arg_416_1.talkMaxDuration = var_419_8

					if var_419_8 + var_419_1 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_8 + var_419_1
					end
				end

				arg_416_1.text_.text = var_419_5
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041099", "story_v_side_old_936041.awb") ~= 0 then
					local var_419_9 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041099", "story_v_side_old_936041.awb") / 1000

					if var_419_9 + var_419_1 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_9 + var_419_1
					end

					if var_419_4.prefab_name ~= "" and arg_416_1.actors_[var_419_4.prefab_name] ~= nil then
						local var_419_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_4.prefab_name].transform, "story_v_side_old_936041", "936041099", "story_v_side_old_936041.awb")

						arg_416_1:RecordAudio("936041099", var_419_10)
						arg_416_1:RecordAudio("936041099", var_419_10)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041099", "story_v_side_old_936041.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041099", "story_v_side_old_936041.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_11 = math.max(var_419_2, arg_416_1.talkMaxDuration)

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_11 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_1) / var_419_11

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_1 + var_419_11 and arg_416_1.time_ < var_419_1 + var_419_11 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play936041100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 936041100
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play936041101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["104402ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect104402ui_story == nil then
				arg_420_1.var_.characterEffect104402ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect104402ui_story and not isNil(var_423_0) then
					local var_423_4 = Mathf.Lerp(0, 0.5, var_423_3)

					arg_420_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_420_1.var_.characterEffect104402ui_story.fillRatio = var_423_4
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect104402ui_story then
				local var_423_5 = 0.5

				arg_420_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_420_1.var_.characterEffect104402ui_story.fillRatio = var_423_5
			end

			local var_423_6 = 0
			local var_423_7 = 0.475

			if var_423_6 < arg_420_1.time_ and arg_420_1.time_ <= var_423_6 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_8 = arg_420_1:FormatText(StoryNameCfg[7].name)

				arg_420_1.leftNameTxt_.text = var_423_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_420_1.callingController_:SetSelectedState("normal")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_9 = arg_420_1:GetWordFromCfg(936041100)
				local var_423_10 = arg_420_1:FormatText(var_423_9.content)

				arg_420_1.text_.text = var_423_10

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_11 = 19
				local var_423_12 = utf8.len(var_423_10)
				local var_423_13 = var_423_11 <= 0 and var_423_7 or var_423_7 * (var_423_12 / var_423_11)

				if var_423_13 > 0 and var_423_7 < var_423_13 then
					arg_420_1.talkMaxDuration = var_423_13

					if var_423_13 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_13 + var_423_6
					end
				end

				arg_420_1.text_.text = var_423_10
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_14 = math.max(var_423_7, arg_420_1.talkMaxDuration)

			if var_423_6 <= arg_420_1.time_ and arg_420_1.time_ < var_423_6 + var_423_14 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_6) / var_423_14

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_6 + var_423_14 and arg_420_1.time_ < var_423_6 + var_423_14 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play936041101 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 936041101
		arg_424_1.duration_ = 3.23

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play936041102(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["614801ui_story"].transform
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.var_.moveOldPos614801ui_story = var_427_0.localPosition

				local var_427_2 = GameObjectTools.GetOrAddComponent(var_427_0.gameObject, typeof(DynamicBoneHelper))

				if var_427_2 then
					var_427_2:EnableDynamicBone(false)
				end
			end

			local var_427_3 = 0.001

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_3 then
				local var_427_4 = (arg_424_1.time_ - var_427_1) / var_427_3
				local var_427_5 = Vector3.New(-0.7, -0.985, -6)

				var_427_0.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos614801ui_story, var_427_5, var_427_4)

				local var_427_6 = manager.ui.mainCamera.transform.position - var_427_0.position

				var_427_0.forward = Vector3.New(var_427_6.x, var_427_6.y, var_427_6.z)

				local var_427_7 = var_427_0.localEulerAngles

				var_427_7.z = 0
				var_427_7.x = 0
				var_427_0.localEulerAngles = var_427_7
			end

			if arg_424_1.time_ >= var_427_1 + var_427_3 and arg_424_1.time_ < var_427_1 + var_427_3 + arg_427_0 then
				var_427_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_427_8 = manager.ui.mainCamera.transform.position - var_427_0.position

				var_427_0.forward = Vector3.New(var_427_8.x, var_427_8.y, var_427_8.z)

				local var_427_9 = var_427_0.localEulerAngles

				var_427_9.z = 0
				var_427_9.x = 0
				var_427_0.localEulerAngles = var_427_9

				local var_427_10 = GameObjectTools.GetOrAddComponent(var_427_0.gameObject, typeof(DynamicBoneHelper))

				if var_427_10 then
					var_427_10:EnableDynamicBone(true)
				end
			end

			local var_427_11 = arg_424_1.actors_["121102ui_story"].transform
			local var_427_12 = 0

			if var_427_12 < arg_424_1.time_ and arg_424_1.time_ <= var_427_12 + arg_427_0 then
				arg_424_1.var_.moveOldPos121102ui_story = var_427_11.localPosition

				local var_427_13 = GameObjectTools.GetOrAddComponent(var_427_11.gameObject, typeof(DynamicBoneHelper))

				if var_427_13 then
					var_427_13:EnableDynamicBone(false)
				end
			end

			local var_427_14 = 0.001

			if var_427_12 <= arg_424_1.time_ and arg_424_1.time_ < var_427_12 + var_427_14 then
				local var_427_15 = (arg_424_1.time_ - var_427_12) / var_427_14
				local var_427_16 = Vector3.New(0, 100, 0)

				var_427_11.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos121102ui_story, var_427_16, var_427_15)

				local var_427_17 = manager.ui.mainCamera.transform.position - var_427_11.position

				var_427_11.forward = Vector3.New(var_427_17.x, var_427_17.y, var_427_17.z)

				local var_427_18 = var_427_11.localEulerAngles

				var_427_18.z = 0
				var_427_18.x = 0
				var_427_11.localEulerAngles = var_427_18
			end

			if arg_424_1.time_ >= var_427_12 + var_427_14 and arg_424_1.time_ < var_427_12 + var_427_14 + arg_427_0 then
				var_427_11.localPosition = Vector3.New(0, 100, 0)

				local var_427_19 = manager.ui.mainCamera.transform.position - var_427_11.position

				var_427_11.forward = Vector3.New(var_427_19.x, var_427_19.y, var_427_19.z)

				local var_427_20 = var_427_11.localEulerAngles

				var_427_20.z = 0
				var_427_20.x = 0
				var_427_11.localEulerAngles = var_427_20

				local var_427_21 = GameObjectTools.GetOrAddComponent(var_427_11.gameObject, typeof(DynamicBoneHelper))

				if var_427_21 then
					var_427_21:EnableDynamicBone(true)
				end
			end

			local var_427_22 = arg_424_1.actors_["614801ui_story"]
			local var_427_23 = 0

			if var_427_23 < arg_424_1.time_ and arg_424_1.time_ <= var_427_23 + arg_427_0 and not isNil(var_427_22) and arg_424_1.var_.characterEffect614801ui_story == nil then
				arg_424_1.var_.characterEffect614801ui_story = var_427_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_24 = 0.200000002980232

			if var_427_23 <= arg_424_1.time_ and arg_424_1.time_ < var_427_23 + var_427_24 and not isNil(var_427_22) then
				local var_427_25 = (arg_424_1.time_ - var_427_23) / var_427_24

				if arg_424_1.var_.characterEffect614801ui_story and not isNil(var_427_22) then
					arg_424_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= var_427_23 + var_427_24 and arg_424_1.time_ < var_427_23 + var_427_24 + arg_427_0 and not isNil(var_427_22) and arg_424_1.var_.characterEffect614801ui_story then
				arg_424_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			local var_427_26 = 0

			if var_427_26 < arg_424_1.time_ and arg_424_1.time_ <= var_427_26 + arg_427_0 then
				arg_424_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_427_27 = 0

			if var_427_27 < arg_424_1.time_ and arg_424_1.time_ <= var_427_27 + arg_427_0 then
				arg_424_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_427_28 = 0
			local var_427_29 = 0.475

			if var_427_28 < arg_424_1.time_ and arg_424_1.time_ <= var_427_28 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_30 = arg_424_1:FormatText(StoryNameCfg[1488].name)

				arg_424_1.leftNameTxt_.text = var_427_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_31 = arg_424_1:GetWordFromCfg(936041101)
				local var_427_32 = arg_424_1:FormatText(var_427_31.content)

				arg_424_1.text_.text = var_427_32

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_33 = 19
				local var_427_34 = utf8.len(var_427_32)
				local var_427_35 = var_427_33 <= 0 and var_427_29 or var_427_29 * (var_427_34 / var_427_33)

				if var_427_35 > 0 and var_427_29 < var_427_35 then
					arg_424_1.talkMaxDuration = var_427_35

					if var_427_35 + var_427_28 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_35 + var_427_28
					end
				end

				arg_424_1.text_.text = var_427_32
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041101", "story_v_side_old_936041.awb") ~= 0 then
					local var_427_36 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041101", "story_v_side_old_936041.awb") / 1000

					if var_427_36 + var_427_28 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_36 + var_427_28
					end

					if var_427_31.prefab_name ~= "" and arg_424_1.actors_[var_427_31.prefab_name] ~= nil then
						local var_427_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_31.prefab_name].transform, "story_v_side_old_936041", "936041101", "story_v_side_old_936041.awb")

						arg_424_1:RecordAudio("936041101", var_427_37)
						arg_424_1:RecordAudio("936041101", var_427_37)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041101", "story_v_side_old_936041.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041101", "story_v_side_old_936041.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_38 = math.max(var_427_29, arg_424_1.talkMaxDuration)

			if var_427_28 <= arg_424_1.time_ and arg_424_1.time_ < var_427_28 + var_427_38 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_28) / var_427_38

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_28 + var_427_38 and arg_424_1.time_ < var_427_28 + var_427_38 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "121102ui_story",
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
	Play936041102 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 936041102
		arg_428_1.duration_ = 5.53

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play936041103(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["104402ui_story"].transform
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.var_.moveOldPos104402ui_story = var_431_0.localPosition

				local var_431_2 = GameObjectTools.GetOrAddComponent(var_431_0.gameObject, typeof(DynamicBoneHelper))

				if var_431_2 then
					var_431_2:EnableDynamicBone(false)
				end
			end

			local var_431_3 = 0.001

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_3 then
				local var_431_4 = (arg_428_1.time_ - var_431_1) / var_431_3
				local var_431_5 = Vector3.New(0.7, -1, -5.93)

				var_431_0.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos104402ui_story, var_431_5, var_431_4)

				local var_431_6 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_6.x, var_431_6.y, var_431_6.z)

				local var_431_7 = var_431_0.localEulerAngles

				var_431_7.z = 0
				var_431_7.x = 0
				var_431_0.localEulerAngles = var_431_7
			end

			if arg_428_1.time_ >= var_431_1 + var_431_3 and arg_428_1.time_ < var_431_1 + var_431_3 + arg_431_0 then
				var_431_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_431_8 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_8.x, var_431_8.y, var_431_8.z)

				local var_431_9 = var_431_0.localEulerAngles

				var_431_9.z = 0
				var_431_9.x = 0
				var_431_0.localEulerAngles = var_431_9

				local var_431_10 = GameObjectTools.GetOrAddComponent(var_431_0.gameObject, typeof(DynamicBoneHelper))

				if var_431_10 then
					var_431_10:EnableDynamicBone(true)
				end
			end

			local var_431_11 = arg_428_1.actors_["104402ui_story"]
			local var_431_12 = 0

			if var_431_12 < arg_428_1.time_ and arg_428_1.time_ <= var_431_12 + arg_431_0 and not isNil(var_431_11) and arg_428_1.var_.characterEffect104402ui_story == nil then
				arg_428_1.var_.characterEffect104402ui_story = var_431_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_13 = 0.200000002980232

			if var_431_12 <= arg_428_1.time_ and arg_428_1.time_ < var_431_12 + var_431_13 and not isNil(var_431_11) then
				local var_431_14 = (arg_428_1.time_ - var_431_12) / var_431_13

				if arg_428_1.var_.characterEffect104402ui_story and not isNil(var_431_11) then
					arg_428_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= var_431_12 + var_431_13 and arg_428_1.time_ < var_431_12 + var_431_13 + arg_431_0 and not isNil(var_431_11) and arg_428_1.var_.characterEffect104402ui_story then
				arg_428_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_431_15 = arg_428_1.actors_["105401ui_story"]
			local var_431_16 = 0

			if var_431_16 < arg_428_1.time_ and arg_428_1.time_ <= var_431_16 + arg_431_0 and not isNil(var_431_15) and arg_428_1.var_.characterEffect105401ui_story == nil then
				arg_428_1.var_.characterEffect105401ui_story = var_431_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_17 = 0.200000002980232

			if var_431_16 <= arg_428_1.time_ and arg_428_1.time_ < var_431_16 + var_431_17 and not isNil(var_431_15) then
				local var_431_18 = (arg_428_1.time_ - var_431_16) / var_431_17

				if arg_428_1.var_.characterEffect105401ui_story and not isNil(var_431_15) then
					local var_431_19 = Mathf.Lerp(0, 0.5, var_431_18)

					arg_428_1.var_.characterEffect105401ui_story.fillFlat = true
					arg_428_1.var_.characterEffect105401ui_story.fillRatio = var_431_19
				end
			end

			if arg_428_1.time_ >= var_431_16 + var_431_17 and arg_428_1.time_ < var_431_16 + var_431_17 + arg_431_0 and not isNil(var_431_15) and arg_428_1.var_.characterEffect105401ui_story then
				local var_431_20 = 0.5

				arg_428_1.var_.characterEffect105401ui_story.fillFlat = true
				arg_428_1.var_.characterEffect105401ui_story.fillRatio = var_431_20
			end

			local var_431_21 = 0

			if var_431_21 < arg_428_1.time_ and arg_428_1.time_ <= var_431_21 + arg_431_0 then
				arg_428_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action6_1")
			end

			local var_431_22 = 0

			if var_431_22 < arg_428_1.time_ and arg_428_1.time_ <= var_431_22 + arg_431_0 then
				arg_428_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_431_23 = 0
			local var_431_24 = 0.625

			if var_431_23 < arg_428_1.time_ and arg_428_1.time_ <= var_431_23 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_25 = arg_428_1:FormatText(StoryNameCfg[1367].name)

				arg_428_1.leftNameTxt_.text = var_431_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_26 = arg_428_1:GetWordFromCfg(936041102)
				local var_431_27 = arg_428_1:FormatText(var_431_26.content)

				arg_428_1.text_.text = var_431_27

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_28 = 25
				local var_431_29 = utf8.len(var_431_27)
				local var_431_30 = var_431_28 <= 0 and var_431_24 or var_431_24 * (var_431_29 / var_431_28)

				if var_431_30 > 0 and var_431_24 < var_431_30 then
					arg_428_1.talkMaxDuration = var_431_30

					if var_431_30 + var_431_23 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_30 + var_431_23
					end
				end

				arg_428_1.text_.text = var_431_27
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041102", "story_v_side_old_936041.awb") ~= 0 then
					local var_431_31 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041102", "story_v_side_old_936041.awb") / 1000

					if var_431_31 + var_431_23 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_31 + var_431_23
					end

					if var_431_26.prefab_name ~= "" and arg_428_1.actors_[var_431_26.prefab_name] ~= nil then
						local var_431_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_26.prefab_name].transform, "story_v_side_old_936041", "936041102", "story_v_side_old_936041.awb")

						arg_428_1:RecordAudio("936041102", var_431_32)
						arg_428_1:RecordAudio("936041102", var_431_32)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041102", "story_v_side_old_936041.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041102", "story_v_side_old_936041.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_33 = math.max(var_431_24, arg_428_1.talkMaxDuration)

			if var_431_23 <= arg_428_1.time_ and arg_428_1.time_ < var_431_23 + var_431_33 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_23) / var_431_33

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_23 + var_431_33 and arg_428_1.time_ < var_431_23 + var_431_33 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
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
	Play936041103 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 936041103
		arg_432_1.duration_ = 5.03

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play936041104(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["104402ui_story"].transform
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 then
				arg_432_1.var_.moveOldPos104402ui_story = var_435_0.localPosition

				local var_435_2 = GameObjectTools.GetOrAddComponent(var_435_0.gameObject, typeof(DynamicBoneHelper))

				if var_435_2 then
					var_435_2:EnableDynamicBone(false)
				end
			end

			local var_435_3 = 0.001

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_3 then
				local var_435_4 = (arg_432_1.time_ - var_435_1) / var_435_3
				local var_435_5 = Vector3.New(0.7, -1, -5.93)

				var_435_0.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos104402ui_story, var_435_5, var_435_4)

				local var_435_6 = manager.ui.mainCamera.transform.position - var_435_0.position

				var_435_0.forward = Vector3.New(var_435_6.x, var_435_6.y, var_435_6.z)

				local var_435_7 = var_435_0.localEulerAngles

				var_435_7.z = 0
				var_435_7.x = 0
				var_435_0.localEulerAngles = var_435_7
			end

			if arg_432_1.time_ >= var_435_1 + var_435_3 and arg_432_1.time_ < var_435_1 + var_435_3 + arg_435_0 then
				var_435_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_435_8 = manager.ui.mainCamera.transform.position - var_435_0.position

				var_435_0.forward = Vector3.New(var_435_8.x, var_435_8.y, var_435_8.z)

				local var_435_9 = var_435_0.localEulerAngles

				var_435_9.z = 0
				var_435_9.x = 0
				var_435_0.localEulerAngles = var_435_9

				local var_435_10 = GameObjectTools.GetOrAddComponent(var_435_0.gameObject, typeof(DynamicBoneHelper))

				if var_435_10 then
					var_435_10:EnableDynamicBone(true)
				end
			end

			local var_435_11 = 0

			if var_435_11 < arg_432_1.time_ and arg_432_1.time_ <= var_435_11 + arg_435_0 then
				arg_432_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action6_2")
			end

			local var_435_12 = 0

			if var_435_12 < arg_432_1.time_ and arg_432_1.time_ <= var_435_12 + arg_435_0 then
				arg_432_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_435_13 = 0
			local var_435_14 = 0.45

			if var_435_13 < arg_432_1.time_ and arg_432_1.time_ <= var_435_13 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_15 = arg_432_1:FormatText(StoryNameCfg[1367].name)

				arg_432_1.leftNameTxt_.text = var_435_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_16 = arg_432_1:GetWordFromCfg(936041103)
				local var_435_17 = arg_432_1:FormatText(var_435_16.content)

				arg_432_1.text_.text = var_435_17

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_18 = 18
				local var_435_19 = utf8.len(var_435_17)
				local var_435_20 = var_435_18 <= 0 and var_435_14 or var_435_14 * (var_435_19 / var_435_18)

				if var_435_20 > 0 and var_435_14 < var_435_20 then
					arg_432_1.talkMaxDuration = var_435_20

					if var_435_20 + var_435_13 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_20 + var_435_13
					end
				end

				arg_432_1.text_.text = var_435_17
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041103", "story_v_side_old_936041.awb") ~= 0 then
					local var_435_21 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041103", "story_v_side_old_936041.awb") / 1000

					if var_435_21 + var_435_13 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_21 + var_435_13
					end

					if var_435_16.prefab_name ~= "" and arg_432_1.actors_[var_435_16.prefab_name] ~= nil then
						local var_435_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_16.prefab_name].transform, "story_v_side_old_936041", "936041103", "story_v_side_old_936041.awb")

						arg_432_1:RecordAudio("936041103", var_435_22)
						arg_432_1:RecordAudio("936041103", var_435_22)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041103", "story_v_side_old_936041.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041103", "story_v_side_old_936041.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_23 = math.max(var_435_14, arg_432_1.talkMaxDuration)

			if var_435_13 <= arg_432_1.time_ and arg_432_1.time_ < var_435_13 + var_435_23 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_13) / var_435_23

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_13 + var_435_23 and arg_432_1.time_ < var_435_13 + var_435_23 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play936041104 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 936041104
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play936041105(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["104402ui_story"].transform
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 then
				arg_436_1.var_.moveOldPos104402ui_story = var_439_0.localPosition

				local var_439_2 = GameObjectTools.GetOrAddComponent(var_439_0.gameObject, typeof(DynamicBoneHelper))

				if var_439_2 then
					var_439_2:EnableDynamicBone(false)
				end
			end

			local var_439_3 = 0.001

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_3 then
				local var_439_4 = (arg_436_1.time_ - var_439_1) / var_439_3
				local var_439_5 = Vector3.New(0, 100, 0)

				var_439_0.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos104402ui_story, var_439_5, var_439_4)

				local var_439_6 = manager.ui.mainCamera.transform.position - var_439_0.position

				var_439_0.forward = Vector3.New(var_439_6.x, var_439_6.y, var_439_6.z)

				local var_439_7 = var_439_0.localEulerAngles

				var_439_7.z = 0
				var_439_7.x = 0
				var_439_0.localEulerAngles = var_439_7
			end

			if arg_436_1.time_ >= var_439_1 + var_439_3 and arg_436_1.time_ < var_439_1 + var_439_3 + arg_439_0 then
				var_439_0.localPosition = Vector3.New(0, 100, 0)

				local var_439_8 = manager.ui.mainCamera.transform.position - var_439_0.position

				var_439_0.forward = Vector3.New(var_439_8.x, var_439_8.y, var_439_8.z)

				local var_439_9 = var_439_0.localEulerAngles

				var_439_9.z = 0
				var_439_9.x = 0
				var_439_0.localEulerAngles = var_439_9

				local var_439_10 = GameObjectTools.GetOrAddComponent(var_439_0.gameObject, typeof(DynamicBoneHelper))

				if var_439_10 then
					var_439_10:EnableDynamicBone(true)
				end
			end

			local var_439_11 = arg_436_1.actors_["614801ui_story"].transform
			local var_439_12 = 0

			if var_439_12 < arg_436_1.time_ and arg_436_1.time_ <= var_439_12 + arg_439_0 then
				arg_436_1.var_.moveOldPos614801ui_story = var_439_11.localPosition

				local var_439_13 = GameObjectTools.GetOrAddComponent(var_439_11.gameObject, typeof(DynamicBoneHelper))

				if var_439_13 then
					var_439_13:EnableDynamicBone(false)
				end
			end

			local var_439_14 = 0.001

			if var_439_12 <= arg_436_1.time_ and arg_436_1.time_ < var_439_12 + var_439_14 then
				local var_439_15 = (arg_436_1.time_ - var_439_12) / var_439_14
				local var_439_16 = Vector3.New(0, 100, 0)

				var_439_11.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos614801ui_story, var_439_16, var_439_15)

				local var_439_17 = manager.ui.mainCamera.transform.position - var_439_11.position

				var_439_11.forward = Vector3.New(var_439_17.x, var_439_17.y, var_439_17.z)

				local var_439_18 = var_439_11.localEulerAngles

				var_439_18.z = 0
				var_439_18.x = 0
				var_439_11.localEulerAngles = var_439_18
			end

			if arg_436_1.time_ >= var_439_12 + var_439_14 and arg_436_1.time_ < var_439_12 + var_439_14 + arg_439_0 then
				var_439_11.localPosition = Vector3.New(0, 100, 0)

				local var_439_19 = manager.ui.mainCamera.transform.position - var_439_11.position

				var_439_11.forward = Vector3.New(var_439_19.x, var_439_19.y, var_439_19.z)

				local var_439_20 = var_439_11.localEulerAngles

				var_439_20.z = 0
				var_439_20.x = 0
				var_439_11.localEulerAngles = var_439_20

				local var_439_21 = GameObjectTools.GetOrAddComponent(var_439_11.gameObject, typeof(DynamicBoneHelper))

				if var_439_21 then
					var_439_21:EnableDynamicBone(true)
				end
			end

			local var_439_22 = arg_436_1.actors_["614801ui_story"]
			local var_439_23 = 0

			if var_439_23 < arg_436_1.time_ and arg_436_1.time_ <= var_439_23 + arg_439_0 and not isNil(var_439_22) and arg_436_1.var_.characterEffect614801ui_story == nil then
				arg_436_1.var_.characterEffect614801ui_story = var_439_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_24 = 0.200000002980232

			if var_439_23 <= arg_436_1.time_ and arg_436_1.time_ < var_439_23 + var_439_24 and not isNil(var_439_22) then
				local var_439_25 = (arg_436_1.time_ - var_439_23) / var_439_24

				if arg_436_1.var_.characterEffect614801ui_story and not isNil(var_439_22) then
					arg_436_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= var_439_23 + var_439_24 and arg_436_1.time_ < var_439_23 + var_439_24 + arg_439_0 and not isNil(var_439_22) and arg_436_1.var_.characterEffect614801ui_story then
				arg_436_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			local var_439_26 = 0
			local var_439_27 = 0.875

			if var_439_26 < arg_436_1.time_ and arg_436_1.time_ <= var_439_26 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_28 = arg_436_1:GetWordFromCfg(936041104)
				local var_439_29 = arg_436_1:FormatText(var_439_28.content)

				arg_436_1.text_.text = var_439_29

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_30 = 35
				local var_439_31 = utf8.len(var_439_29)
				local var_439_32 = var_439_30 <= 0 and var_439_27 or var_439_27 * (var_439_31 / var_439_30)

				if var_439_32 > 0 and var_439_27 < var_439_32 then
					arg_436_1.talkMaxDuration = var_439_32

					if var_439_32 + var_439_26 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_32 + var_439_26
					end
				end

				arg_436_1.text_.text = var_439_29
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_33 = math.max(var_439_27, arg_436_1.talkMaxDuration)

			if var_439_26 <= arg_436_1.time_ and arg_436_1.time_ < var_439_26 + var_439_33 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_26) / var_439_33

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_26 + var_439_33 and arg_436_1.time_ < var_439_26 + var_439_33 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play936041105 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 936041105
		arg_440_1.duration_ = 9.3

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play936041106(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = "ST2201"

			if arg_440_1.bgs_[var_443_0] == nil then
				local var_443_1 = Object.Instantiate(arg_440_1.paintGo_)

				var_443_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_443_0)
				var_443_1.name = var_443_0
				var_443_1.transform.parent = arg_440_1.stage_.transform
				var_443_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_440_1.bgs_[var_443_0] = var_443_1
			end

			local var_443_2 = 2.00000000298023

			if var_443_2 < arg_440_1.time_ and arg_440_1.time_ <= var_443_2 + arg_443_0 then
				local var_443_3 = manager.ui.mainCamera.transform.localPosition
				local var_443_4 = Vector3.New(0, 0, 10) + Vector3.New(var_443_3.x, var_443_3.y, 0)
				local var_443_5 = arg_440_1.bgs_.ST2201

				var_443_5.transform.localPosition = var_443_4
				var_443_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_443_6 = var_443_5:GetComponent("SpriteRenderer")

				if var_443_6 and var_443_6.sprite then
					local var_443_7 = (var_443_5.transform.localPosition - var_443_3).z
					local var_443_8 = manager.ui.mainCameraCom_
					local var_443_9 = 2 * var_443_7 * Mathf.Tan(var_443_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_443_10 = var_443_9 * var_443_8.aspect
					local var_443_11 = var_443_6.sprite.bounds.size.x
					local var_443_12 = var_443_6.sprite.bounds.size.y
					local var_443_13 = var_443_10 / var_443_11
					local var_443_14 = var_443_9 / var_443_12
					local var_443_15 = var_443_14 < var_443_13 and var_443_13 or var_443_14

					var_443_5.transform.localScale = Vector3.New(var_443_15, var_443_15, 0)
				end

				for iter_443_0, iter_443_1 in pairs(arg_440_1.bgs_) do
					if iter_443_0 ~= "ST2201" then
						iter_443_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_443_16 = 3.999999999999

			if var_443_16 < arg_440_1.time_ and arg_440_1.time_ <= var_443_16 + arg_443_0 then
				arg_440_1.allBtn_.enabled = false
			end

			local var_443_17 = 0.3

			if arg_440_1.time_ >= var_443_16 + var_443_17 and arg_440_1.time_ < var_443_16 + var_443_17 + arg_443_0 then
				arg_440_1.allBtn_.enabled = true
			end

			local var_443_18 = 0

			if var_443_18 < arg_440_1.time_ and arg_440_1.time_ <= var_443_18 + arg_443_0 then
				arg_440_1.mask_.enabled = true
				arg_440_1.mask_.raycastTarget = true

				arg_440_1:SetGaussion(false)
			end

			local var_443_19 = 2

			if var_443_18 <= arg_440_1.time_ and arg_440_1.time_ < var_443_18 + var_443_19 then
				local var_443_20 = (arg_440_1.time_ - var_443_18) / var_443_19
				local var_443_21 = Color.New(0, 0, 0)

				var_443_21.a = Mathf.Lerp(0, 1, var_443_20)
				arg_440_1.mask_.color = var_443_21
			end

			if arg_440_1.time_ >= var_443_18 + var_443_19 and arg_440_1.time_ < var_443_18 + var_443_19 + arg_443_0 then
				local var_443_22 = Color.New(0, 0, 0)

				var_443_22.a = 1
				arg_440_1.mask_.color = var_443_22
			end

			local var_443_23 = 2

			if var_443_23 < arg_440_1.time_ and arg_440_1.time_ <= var_443_23 + arg_443_0 then
				arg_440_1.mask_.enabled = true
				arg_440_1.mask_.raycastTarget = true

				arg_440_1:SetGaussion(false)
			end

			local var_443_24 = 2

			if var_443_23 <= arg_440_1.time_ and arg_440_1.time_ < var_443_23 + var_443_24 then
				local var_443_25 = (arg_440_1.time_ - var_443_23) / var_443_24
				local var_443_26 = Color.New(0, 0, 0)

				var_443_26.a = Mathf.Lerp(1, 0, var_443_25)
				arg_440_1.mask_.color = var_443_26
			end

			if arg_440_1.time_ >= var_443_23 + var_443_24 and arg_440_1.time_ < var_443_23 + var_443_24 + arg_443_0 then
				local var_443_27 = Color.New(0, 0, 0)
				local var_443_28 = 0

				arg_440_1.mask_.enabled = false
				var_443_27.a = var_443_28
				arg_440_1.mask_.color = var_443_27
			end

			local var_443_29 = "1033ui_story"

			if arg_440_1.actors_[var_443_29] == nil then
				local var_443_30 = Asset.Load("Char/" .. "1033ui_story")

				if not isNil(var_443_30) then
					local var_443_31 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_440_1.stage_.transform)

					var_443_31.name = var_443_29
					var_443_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_440_1.actors_[var_443_29] = var_443_31

					local var_443_32 = var_443_31:GetComponentInChildren(typeof(CharacterEffect))

					var_443_32.enabled = true

					local var_443_33 = GameObjectTools.GetOrAddComponent(var_443_31, typeof(DynamicBoneHelper))

					if var_443_33 then
						var_443_33:EnableDynamicBone(false)
					end

					arg_440_1:ShowWeapon(var_443_32.transform, false)

					arg_440_1.var_[var_443_29 .. "Animator"] = var_443_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_440_1.var_[var_443_29 .. "Animator"].applyRootMotion = true
					arg_440_1.var_[var_443_29 .. "LipSync"] = var_443_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_443_34 = arg_440_1.actors_["1033ui_story"].transform
			local var_443_35 = 3.8

			if var_443_35 < arg_440_1.time_ and arg_440_1.time_ <= var_443_35 + arg_443_0 then
				arg_440_1.var_.moveOldPos1033ui_story = var_443_34.localPosition
			end

			local var_443_36 = 0.001

			if var_443_35 <= arg_440_1.time_ and arg_440_1.time_ < var_443_35 + var_443_36 then
				local var_443_37 = (arg_440_1.time_ - var_443_35) / var_443_36
				local var_443_38 = Vector3.New(0, -1.01, -6.13)

				var_443_34.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1033ui_story, var_443_38, var_443_37)

				local var_443_39 = manager.ui.mainCamera.transform.position - var_443_34.position

				var_443_34.forward = Vector3.New(var_443_39.x, var_443_39.y, var_443_39.z)

				local var_443_40 = var_443_34.localEulerAngles

				var_443_40.z = 0
				var_443_40.x = 0
				var_443_34.localEulerAngles = var_443_40
			end

			if arg_440_1.time_ >= var_443_35 + var_443_36 and arg_440_1.time_ < var_443_35 + var_443_36 + arg_443_0 then
				var_443_34.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_443_41 = manager.ui.mainCamera.transform.position - var_443_34.position

				var_443_34.forward = Vector3.New(var_443_41.x, var_443_41.y, var_443_41.z)

				local var_443_42 = var_443_34.localEulerAngles

				var_443_42.z = 0
				var_443_42.x = 0
				var_443_34.localEulerAngles = var_443_42
			end

			local var_443_43 = arg_440_1.actors_["1033ui_story"]
			local var_443_44 = 3.8

			if var_443_44 < arg_440_1.time_ and arg_440_1.time_ <= var_443_44 + arg_443_0 and not isNil(var_443_43) and arg_440_1.var_.characterEffect1033ui_story == nil then
				arg_440_1.var_.characterEffect1033ui_story = var_443_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_45 = 0.200000002980232

			if var_443_44 <= arg_440_1.time_ and arg_440_1.time_ < var_443_44 + var_443_45 and not isNil(var_443_43) then
				local var_443_46 = (arg_440_1.time_ - var_443_44) / var_443_45

				if arg_440_1.var_.characterEffect1033ui_story and not isNil(var_443_43) then
					arg_440_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= var_443_44 + var_443_45 and arg_440_1.time_ < var_443_44 + var_443_45 + arg_443_0 and not isNil(var_443_43) and arg_440_1.var_.characterEffect1033ui_story then
				arg_440_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_443_47 = 3.8

			if var_443_47 < arg_440_1.time_ and arg_440_1.time_ <= var_443_47 + arg_443_0 then
				arg_440_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			local var_443_48 = 3.8

			if var_443_48 < arg_440_1.time_ and arg_440_1.time_ <= var_443_48 + arg_443_0 then
				arg_440_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_443_49 = 0.266666666666667
			local var_443_50 = 1

			if var_443_49 < arg_440_1.time_ and arg_440_1.time_ <= var_443_49 + arg_443_0 then
				local var_443_51 = "stop"
				local var_443_52 = "effect"

				arg_440_1:AudioAction(var_443_51, var_443_52, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_443_53 = 1.6
			local var_443_54 = 1

			if var_443_53 < arg_440_1.time_ and arg_440_1.time_ <= var_443_53 + arg_443_0 then
				local var_443_55 = "play"
				local var_443_56 = "effect"

				arg_440_1:AudioAction(var_443_55, var_443_56, "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_440_1.frameCnt_ <= 1 then
				arg_440_1.dialog_:SetActive(false)
			end

			local var_443_57 = 3.999999999999
			local var_443_58 = 0.65

			if var_443_57 < arg_440_1.time_ and arg_440_1.time_ <= var_443_57 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0

				arg_440_1.dialog_:SetActive(true)

				arg_440_1.dialogCg_.alpha = 0

				local var_443_59 = LeanTween.value(arg_440_1.dialog_, 0, 1, 0.3)

				var_443_59:setOnUpdate(LuaHelper.FloatAction(function(arg_444_0)
					arg_440_1.dialogCg_.alpha = arg_444_0
				end))
				var_443_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_440_1.dialog_)
					var_443_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_440_1.duration_ = arg_440_1.duration_ + 0.3

				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_60 = arg_440_1:FormatText(StoryNameCfg[236].name)

				arg_440_1.leftNameTxt_.text = var_443_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_61 = arg_440_1:GetWordFromCfg(936041105)
				local var_443_62 = arg_440_1:FormatText(var_443_61.content)

				arg_440_1.text_.text = var_443_62

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_63 = 26
				local var_443_64 = utf8.len(var_443_62)
				local var_443_65 = var_443_63 <= 0 and var_443_58 or var_443_58 * (var_443_64 / var_443_63)

				if var_443_65 > 0 and var_443_58 < var_443_65 then
					arg_440_1.talkMaxDuration = var_443_65
					var_443_57 = var_443_57 + 0.3

					if var_443_65 + var_443_57 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_65 + var_443_57
					end
				end

				arg_440_1.text_.text = var_443_62
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041105", "story_v_side_old_936041.awb") ~= 0 then
					local var_443_66 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041105", "story_v_side_old_936041.awb") / 1000

					if var_443_66 + var_443_57 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_66 + var_443_57
					end

					if var_443_61.prefab_name ~= "" and arg_440_1.actors_[var_443_61.prefab_name] ~= nil then
						local var_443_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_61.prefab_name].transform, "story_v_side_old_936041", "936041105", "story_v_side_old_936041.awb")

						arg_440_1:RecordAudio("936041105", var_443_67)
						arg_440_1:RecordAudio("936041105", var_443_67)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041105", "story_v_side_old_936041.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041105", "story_v_side_old_936041.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_68 = var_443_57 + 0.3
			local var_443_69 = math.max(var_443_58, arg_440_1.talkMaxDuration)

			if var_443_68 <= arg_440_1.time_ and arg_440_1.time_ < var_443_68 + var_443_69 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_68) / var_443_69

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_68 + var_443_69 and arg_440_1.time_ < var_443_68 + var_443_69 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play936041106 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 936041106
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play936041107(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["1033ui_story"].transform
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 then
				arg_446_1.var_.moveOldPos1033ui_story = var_449_0.localPosition
			end

			local var_449_2 = 0.001

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2
				local var_449_4 = Vector3.New(0, 100, 0)

				var_449_0.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos1033ui_story, var_449_4, var_449_3)

				local var_449_5 = manager.ui.mainCamera.transform.position - var_449_0.position

				var_449_0.forward = Vector3.New(var_449_5.x, var_449_5.y, var_449_5.z)

				local var_449_6 = var_449_0.localEulerAngles

				var_449_6.z = 0
				var_449_6.x = 0
				var_449_0.localEulerAngles = var_449_6
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 then
				var_449_0.localPosition = Vector3.New(0, 100, 0)

				local var_449_7 = manager.ui.mainCamera.transform.position - var_449_0.position

				var_449_0.forward = Vector3.New(var_449_7.x, var_449_7.y, var_449_7.z)

				local var_449_8 = var_449_0.localEulerAngles

				var_449_8.z = 0
				var_449_8.x = 0
				var_449_0.localEulerAngles = var_449_8
			end

			local var_449_9 = arg_446_1.actors_["1033ui_story"]
			local var_449_10 = 0

			if var_449_10 < arg_446_1.time_ and arg_446_1.time_ <= var_449_10 + arg_449_0 and not isNil(var_449_9) and arg_446_1.var_.characterEffect1033ui_story == nil then
				arg_446_1.var_.characterEffect1033ui_story = var_449_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_11 = 0.200000002980232

			if var_449_10 <= arg_446_1.time_ and arg_446_1.time_ < var_449_10 + var_449_11 and not isNil(var_449_9) then
				local var_449_12 = (arg_446_1.time_ - var_449_10) / var_449_11

				if arg_446_1.var_.characterEffect1033ui_story and not isNil(var_449_9) then
					local var_449_13 = Mathf.Lerp(0, 0.5, var_449_12)

					arg_446_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1033ui_story.fillRatio = var_449_13
				end
			end

			if arg_446_1.time_ >= var_449_10 + var_449_11 and arg_446_1.time_ < var_449_10 + var_449_11 + arg_449_0 and not isNil(var_449_9) and arg_446_1.var_.characterEffect1033ui_story then
				local var_449_14 = 0.5

				arg_446_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1033ui_story.fillRatio = var_449_14
			end

			local var_449_15 = 0
			local var_449_16 = 0.875

			if var_449_15 < arg_446_1.time_ and arg_446_1.time_ <= var_449_15 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_17 = arg_446_1:GetWordFromCfg(936041106)
				local var_449_18 = arg_446_1:FormatText(var_449_17.content)

				arg_446_1.text_.text = var_449_18

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_19 = 35
				local var_449_20 = utf8.len(var_449_18)
				local var_449_21 = var_449_19 <= 0 and var_449_16 or var_449_16 * (var_449_20 / var_449_19)

				if var_449_21 > 0 and var_449_16 < var_449_21 then
					arg_446_1.talkMaxDuration = var_449_21

					if var_449_21 + var_449_15 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_21 + var_449_15
					end
				end

				arg_446_1.text_.text = var_449_18
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_22 = math.max(var_449_16, arg_446_1.talkMaxDuration)

			if var_449_15 <= arg_446_1.time_ and arg_446_1.time_ < var_449_15 + var_449_22 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_15) / var_449_22

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_15 + var_449_22 and arg_446_1.time_ < var_449_15 + var_449_22 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play936041107 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 936041107
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play936041108(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0
			local var_453_1 = 0.375

			if var_453_0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_2 = arg_450_1:FormatText(StoryNameCfg[7].name)

				arg_450_1.leftNameTxt_.text = var_453_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_3 = arg_450_1:GetWordFromCfg(936041107)
				local var_453_4 = arg_450_1:FormatText(var_453_3.content)

				arg_450_1.text_.text = var_453_4

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 15
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
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_8 = math.max(var_453_1, arg_450_1.talkMaxDuration)

			if var_453_0 <= arg_450_1.time_ and arg_450_1.time_ < var_453_0 + var_453_8 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_0) / var_453_8

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_0 + var_453_8 and arg_450_1.time_ < var_453_0 + var_453_8 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play936041108 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 936041108
		arg_454_1.duration_ = 5.33

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play936041109(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = "1066ui_story"

			if arg_454_1.actors_[var_457_0] == nil then
				local var_457_1 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_457_1) then
					local var_457_2 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_454_1.stage_.transform)

					var_457_2.name = var_457_0
					var_457_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_454_1.actors_[var_457_0] = var_457_2

					local var_457_3 = var_457_2:GetComponentInChildren(typeof(CharacterEffect))

					var_457_3.enabled = true

					local var_457_4 = GameObjectTools.GetOrAddComponent(var_457_2, typeof(DynamicBoneHelper))

					if var_457_4 then
						var_457_4:EnableDynamicBone(false)
					end

					arg_454_1:ShowWeapon(var_457_3.transform, false)

					arg_454_1.var_[var_457_0 .. "Animator"] = var_457_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_454_1.var_[var_457_0 .. "Animator"].applyRootMotion = true
					arg_454_1.var_[var_457_0 .. "LipSync"] = var_457_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_457_5 = arg_454_1.actors_["1066ui_story"].transform
			local var_457_6 = 0

			if var_457_6 < arg_454_1.time_ and arg_454_1.time_ <= var_457_6 + arg_457_0 then
				arg_454_1.var_.moveOldPos1066ui_story = var_457_5.localPosition
			end

			local var_457_7 = 0.001

			if var_457_6 <= arg_454_1.time_ and arg_454_1.time_ < var_457_6 + var_457_7 then
				local var_457_8 = (arg_454_1.time_ - var_457_6) / var_457_7
				local var_457_9 = Vector3.New(-0.7, -0.77, -6.1)

				var_457_5.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos1066ui_story, var_457_9, var_457_8)

				local var_457_10 = manager.ui.mainCamera.transform.position - var_457_5.position

				var_457_5.forward = Vector3.New(var_457_10.x, var_457_10.y, var_457_10.z)

				local var_457_11 = var_457_5.localEulerAngles

				var_457_11.z = 0
				var_457_11.x = 0
				var_457_5.localEulerAngles = var_457_11
			end

			if arg_454_1.time_ >= var_457_6 + var_457_7 and arg_454_1.time_ < var_457_6 + var_457_7 + arg_457_0 then
				var_457_5.localPosition = Vector3.New(-0.7, -0.77, -6.1)

				local var_457_12 = manager.ui.mainCamera.transform.position - var_457_5.position

				var_457_5.forward = Vector3.New(var_457_12.x, var_457_12.y, var_457_12.z)

				local var_457_13 = var_457_5.localEulerAngles

				var_457_13.z = 0
				var_457_13.x = 0
				var_457_5.localEulerAngles = var_457_13
			end

			local var_457_14 = arg_454_1.actors_["1066ui_story"]
			local var_457_15 = 0

			if var_457_15 < arg_454_1.time_ and arg_454_1.time_ <= var_457_15 + arg_457_0 and not isNil(var_457_14) and arg_454_1.var_.characterEffect1066ui_story == nil then
				arg_454_1.var_.characterEffect1066ui_story = var_457_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_16 = 0.200000002980232

			if var_457_15 <= arg_454_1.time_ and arg_454_1.time_ < var_457_15 + var_457_16 and not isNil(var_457_14) then
				local var_457_17 = (arg_454_1.time_ - var_457_15) / var_457_16

				if arg_454_1.var_.characterEffect1066ui_story and not isNil(var_457_14) then
					arg_454_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= var_457_15 + var_457_16 and arg_454_1.time_ < var_457_15 + var_457_16 + arg_457_0 and not isNil(var_457_14) and arg_454_1.var_.characterEffect1066ui_story then
				arg_454_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_457_18 = 0

			if var_457_18 < arg_454_1.time_ and arg_454_1.time_ <= var_457_18 + arg_457_0 then
				arg_454_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			local var_457_19 = 0

			if var_457_19 < arg_454_1.time_ and arg_454_1.time_ <= var_457_19 + arg_457_0 then
				arg_454_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_457_20 = 0
			local var_457_21 = 0.5

			if var_457_20 < arg_454_1.time_ and arg_454_1.time_ <= var_457_20 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_22 = arg_454_1:FormatText(StoryNameCfg[32].name)

				arg_454_1.leftNameTxt_.text = var_457_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_23 = arg_454_1:GetWordFromCfg(936041108)
				local var_457_24 = arg_454_1:FormatText(var_457_23.content)

				arg_454_1.text_.text = var_457_24

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_25 = 20
				local var_457_26 = utf8.len(var_457_24)
				local var_457_27 = var_457_25 <= 0 and var_457_21 or var_457_21 * (var_457_26 / var_457_25)

				if var_457_27 > 0 and var_457_21 < var_457_27 then
					arg_454_1.talkMaxDuration = var_457_27

					if var_457_27 + var_457_20 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_27 + var_457_20
					end
				end

				arg_454_1.text_.text = var_457_24
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041108", "story_v_side_old_936041.awb") ~= 0 then
					local var_457_28 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041108", "story_v_side_old_936041.awb") / 1000

					if var_457_28 + var_457_20 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_28 + var_457_20
					end

					if var_457_23.prefab_name ~= "" and arg_454_1.actors_[var_457_23.prefab_name] ~= nil then
						local var_457_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_23.prefab_name].transform, "story_v_side_old_936041", "936041108", "story_v_side_old_936041.awb")

						arg_454_1:RecordAudio("936041108", var_457_29)
						arg_454_1:RecordAudio("936041108", var_457_29)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041108", "story_v_side_old_936041.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041108", "story_v_side_old_936041.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_30 = math.max(var_457_21, arg_454_1.talkMaxDuration)

			if var_457_20 <= arg_454_1.time_ and arg_454_1.time_ < var_457_20 + var_457_30 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_20) / var_457_30

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_20 + var_457_30 and arg_454_1.time_ < var_457_20 + var_457_30 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play936041109 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 936041109
		arg_458_1.duration_ = 6

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play936041110(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["104402ui_story"].transform
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1.var_.moveOldPos104402ui_story = var_461_0.localPosition

				local var_461_2 = GameObjectTools.GetOrAddComponent(var_461_0.gameObject, typeof(DynamicBoneHelper))

				if var_461_2 then
					var_461_2:EnableDynamicBone(false)
				end
			end

			local var_461_3 = 0.001

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_3 then
				local var_461_4 = (arg_458_1.time_ - var_461_1) / var_461_3
				local var_461_5 = Vector3.New(0.7, -1, -5.93)

				var_461_0.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos104402ui_story, var_461_5, var_461_4)

				local var_461_6 = manager.ui.mainCamera.transform.position - var_461_0.position

				var_461_0.forward = Vector3.New(var_461_6.x, var_461_6.y, var_461_6.z)

				local var_461_7 = var_461_0.localEulerAngles

				var_461_7.z = 0
				var_461_7.x = 0
				var_461_0.localEulerAngles = var_461_7
			end

			if arg_458_1.time_ >= var_461_1 + var_461_3 and arg_458_1.time_ < var_461_1 + var_461_3 + arg_461_0 then
				var_461_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_461_8 = manager.ui.mainCamera.transform.position - var_461_0.position

				var_461_0.forward = Vector3.New(var_461_8.x, var_461_8.y, var_461_8.z)

				local var_461_9 = var_461_0.localEulerAngles

				var_461_9.z = 0
				var_461_9.x = 0
				var_461_0.localEulerAngles = var_461_9

				local var_461_10 = GameObjectTools.GetOrAddComponent(var_461_0.gameObject, typeof(DynamicBoneHelper))

				if var_461_10 then
					var_461_10:EnableDynamicBone(true)
				end
			end

			local var_461_11 = arg_458_1.actors_["104402ui_story"]
			local var_461_12 = 0

			if var_461_12 < arg_458_1.time_ and arg_458_1.time_ <= var_461_12 + arg_461_0 and not isNil(var_461_11) and arg_458_1.var_.characterEffect104402ui_story == nil then
				arg_458_1.var_.characterEffect104402ui_story = var_461_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_13 = 0.200000002980232

			if var_461_12 <= arg_458_1.time_ and arg_458_1.time_ < var_461_12 + var_461_13 and not isNil(var_461_11) then
				local var_461_14 = (arg_458_1.time_ - var_461_12) / var_461_13

				if arg_458_1.var_.characterEffect104402ui_story and not isNil(var_461_11) then
					arg_458_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= var_461_12 + var_461_13 and arg_458_1.time_ < var_461_12 + var_461_13 + arg_461_0 and not isNil(var_461_11) and arg_458_1.var_.characterEffect104402ui_story then
				arg_458_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_461_15 = arg_458_1.actors_["1066ui_story"]
			local var_461_16 = 0

			if var_461_16 < arg_458_1.time_ and arg_458_1.time_ <= var_461_16 + arg_461_0 and not isNil(var_461_15) and arg_458_1.var_.characterEffect1066ui_story == nil then
				arg_458_1.var_.characterEffect1066ui_story = var_461_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_17 = 0.200000002980232

			if var_461_16 <= arg_458_1.time_ and arg_458_1.time_ < var_461_16 + var_461_17 and not isNil(var_461_15) then
				local var_461_18 = (arg_458_1.time_ - var_461_16) / var_461_17

				if arg_458_1.var_.characterEffect1066ui_story and not isNil(var_461_15) then
					local var_461_19 = Mathf.Lerp(0, 0.5, var_461_18)

					arg_458_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1066ui_story.fillRatio = var_461_19
				end
			end

			if arg_458_1.time_ >= var_461_16 + var_461_17 and arg_458_1.time_ < var_461_16 + var_461_17 + arg_461_0 and not isNil(var_461_15) and arg_458_1.var_.characterEffect1066ui_story then
				local var_461_20 = 0.5

				arg_458_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1066ui_story.fillRatio = var_461_20
			end

			local var_461_21 = 0

			if var_461_21 < arg_458_1.time_ and arg_458_1.time_ <= var_461_21 + arg_461_0 then
				arg_458_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			local var_461_22 = 0

			if var_461_22 < arg_458_1.time_ and arg_458_1.time_ <= var_461_22 + arg_461_0 then
				arg_458_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_461_23 = 0
			local var_461_24 = 0.725

			if var_461_23 < arg_458_1.time_ and arg_458_1.time_ <= var_461_23 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_25 = arg_458_1:FormatText(StoryNameCfg[1367].name)

				arg_458_1.leftNameTxt_.text = var_461_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_26 = arg_458_1:GetWordFromCfg(936041109)
				local var_461_27 = arg_458_1:FormatText(var_461_26.content)

				arg_458_1.text_.text = var_461_27

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_28 = 29
				local var_461_29 = utf8.len(var_461_27)
				local var_461_30 = var_461_28 <= 0 and var_461_24 or var_461_24 * (var_461_29 / var_461_28)

				if var_461_30 > 0 and var_461_24 < var_461_30 then
					arg_458_1.talkMaxDuration = var_461_30

					if var_461_30 + var_461_23 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_30 + var_461_23
					end
				end

				arg_458_1.text_.text = var_461_27
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041109", "story_v_side_old_936041.awb") ~= 0 then
					local var_461_31 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041109", "story_v_side_old_936041.awb") / 1000

					if var_461_31 + var_461_23 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_31 + var_461_23
					end

					if var_461_26.prefab_name ~= "" and arg_458_1.actors_[var_461_26.prefab_name] ~= nil then
						local var_461_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_26.prefab_name].transform, "story_v_side_old_936041", "936041109", "story_v_side_old_936041.awb")

						arg_458_1:RecordAudio("936041109", var_461_32)
						arg_458_1:RecordAudio("936041109", var_461_32)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041109", "story_v_side_old_936041.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041109", "story_v_side_old_936041.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_33 = math.max(var_461_24, arg_458_1.talkMaxDuration)

			if var_461_23 <= arg_458_1.time_ and arg_458_1.time_ < var_461_23 + var_461_33 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_23) / var_461_33

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_23 + var_461_33 and arg_458_1.time_ < var_461_23 + var_461_33 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play936041110 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 936041110
		arg_462_1.duration_ = 5.4

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play936041111(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["104402ui_story"].transform
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.var_.moveOldPos104402ui_story = var_465_0.localPosition

				local var_465_2 = GameObjectTools.GetOrAddComponent(var_465_0.gameObject, typeof(DynamicBoneHelper))

				if var_465_2 then
					var_465_2:EnableDynamicBone(false)
				end
			end

			local var_465_3 = 0.001

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_3 then
				local var_465_4 = (arg_462_1.time_ - var_465_1) / var_465_3
				local var_465_5 = Vector3.New(0.7, -1, -5.93)

				var_465_0.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos104402ui_story, var_465_5, var_465_4)

				local var_465_6 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_6.x, var_465_6.y, var_465_6.z)

				local var_465_7 = var_465_0.localEulerAngles

				var_465_7.z = 0
				var_465_7.x = 0
				var_465_0.localEulerAngles = var_465_7
			end

			if arg_462_1.time_ >= var_465_1 + var_465_3 and arg_462_1.time_ < var_465_1 + var_465_3 + arg_465_0 then
				var_465_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_465_8 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_8.x, var_465_8.y, var_465_8.z)

				local var_465_9 = var_465_0.localEulerAngles

				var_465_9.z = 0
				var_465_9.x = 0
				var_465_0.localEulerAngles = var_465_9

				local var_465_10 = GameObjectTools.GetOrAddComponent(var_465_0.gameObject, typeof(DynamicBoneHelper))

				if var_465_10 then
					var_465_10:EnableDynamicBone(true)
				end
			end

			local var_465_11 = 0

			if var_465_11 < arg_462_1.time_ and arg_462_1.time_ <= var_465_11 + arg_465_0 then
				arg_462_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			local var_465_12 = 0

			if var_465_12 < arg_462_1.time_ and arg_462_1.time_ <= var_465_12 + arg_465_0 then
				arg_462_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_465_13 = 0
			local var_465_14 = 0.625

			if var_465_13 < arg_462_1.time_ and arg_462_1.time_ <= var_465_13 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_15 = arg_462_1:FormatText(StoryNameCfg[1367].name)

				arg_462_1.leftNameTxt_.text = var_465_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_16 = arg_462_1:GetWordFromCfg(936041110)
				local var_465_17 = arg_462_1:FormatText(var_465_16.content)

				arg_462_1.text_.text = var_465_17

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_18 = 25
				local var_465_19 = utf8.len(var_465_17)
				local var_465_20 = var_465_18 <= 0 and var_465_14 or var_465_14 * (var_465_19 / var_465_18)

				if var_465_20 > 0 and var_465_14 < var_465_20 then
					arg_462_1.talkMaxDuration = var_465_20

					if var_465_20 + var_465_13 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_20 + var_465_13
					end
				end

				arg_462_1.text_.text = var_465_17
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041110", "story_v_side_old_936041.awb") ~= 0 then
					local var_465_21 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041110", "story_v_side_old_936041.awb") / 1000

					if var_465_21 + var_465_13 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_21 + var_465_13
					end

					if var_465_16.prefab_name ~= "" and arg_462_1.actors_[var_465_16.prefab_name] ~= nil then
						local var_465_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_16.prefab_name].transform, "story_v_side_old_936041", "936041110", "story_v_side_old_936041.awb")

						arg_462_1:RecordAudio("936041110", var_465_22)
						arg_462_1:RecordAudio("936041110", var_465_22)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041110", "story_v_side_old_936041.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041110", "story_v_side_old_936041.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_23 = math.max(var_465_14, arg_462_1.talkMaxDuration)

			if var_465_13 <= arg_462_1.time_ and arg_462_1.time_ < var_465_13 + var_465_23 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_13) / var_465_23

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_13 + var_465_23 and arg_462_1.time_ < var_465_13 + var_465_23 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play936041111 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 936041111
		arg_466_1.duration_ = 5.7

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play936041112(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1066ui_story"].transform
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.var_.moveOldPos1066ui_story = var_469_0.localPosition
			end

			local var_469_2 = 0.001

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2
				local var_469_4 = Vector3.New(-0.7, -0.77, -6.1)

				var_469_0.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos1066ui_story, var_469_4, var_469_3)

				local var_469_5 = manager.ui.mainCamera.transform.position - var_469_0.position

				var_469_0.forward = Vector3.New(var_469_5.x, var_469_5.y, var_469_5.z)

				local var_469_6 = var_469_0.localEulerAngles

				var_469_6.z = 0
				var_469_6.x = 0
				var_469_0.localEulerAngles = var_469_6
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 then
				var_469_0.localPosition = Vector3.New(-0.7, -0.77, -6.1)

				local var_469_7 = manager.ui.mainCamera.transform.position - var_469_0.position

				var_469_0.forward = Vector3.New(var_469_7.x, var_469_7.y, var_469_7.z)

				local var_469_8 = var_469_0.localEulerAngles

				var_469_8.z = 0
				var_469_8.x = 0
				var_469_0.localEulerAngles = var_469_8
			end

			local var_469_9 = arg_466_1.actors_["1066ui_story"]
			local var_469_10 = 0

			if var_469_10 < arg_466_1.time_ and arg_466_1.time_ <= var_469_10 + arg_469_0 and not isNil(var_469_9) and arg_466_1.var_.characterEffect1066ui_story == nil then
				arg_466_1.var_.characterEffect1066ui_story = var_469_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_11 = 0.200000002980232

			if var_469_10 <= arg_466_1.time_ and arg_466_1.time_ < var_469_10 + var_469_11 and not isNil(var_469_9) then
				local var_469_12 = (arg_466_1.time_ - var_469_10) / var_469_11

				if arg_466_1.var_.characterEffect1066ui_story and not isNil(var_469_9) then
					arg_466_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= var_469_10 + var_469_11 and arg_466_1.time_ < var_469_10 + var_469_11 + arg_469_0 and not isNil(var_469_9) and arg_466_1.var_.characterEffect1066ui_story then
				arg_466_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_469_13 = arg_466_1.actors_["104402ui_story"]
			local var_469_14 = 0

			if var_469_14 < arg_466_1.time_ and arg_466_1.time_ <= var_469_14 + arg_469_0 and not isNil(var_469_13) and arg_466_1.var_.characterEffect104402ui_story == nil then
				arg_466_1.var_.characterEffect104402ui_story = var_469_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_15 = 0.200000002980232

			if var_469_14 <= arg_466_1.time_ and arg_466_1.time_ < var_469_14 + var_469_15 and not isNil(var_469_13) then
				local var_469_16 = (arg_466_1.time_ - var_469_14) / var_469_15

				if arg_466_1.var_.characterEffect104402ui_story and not isNil(var_469_13) then
					local var_469_17 = Mathf.Lerp(0, 0.5, var_469_16)

					arg_466_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_466_1.var_.characterEffect104402ui_story.fillRatio = var_469_17
				end
			end

			if arg_466_1.time_ >= var_469_14 + var_469_15 and arg_466_1.time_ < var_469_14 + var_469_15 + arg_469_0 and not isNil(var_469_13) and arg_466_1.var_.characterEffect104402ui_story then
				local var_469_18 = 0.5

				arg_466_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_466_1.var_.characterEffect104402ui_story.fillRatio = var_469_18
			end

			local var_469_19 = 0

			if var_469_19 < arg_466_1.time_ and arg_466_1.time_ <= var_469_19 + arg_469_0 then
				arg_466_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			local var_469_20 = 0

			if var_469_20 < arg_466_1.time_ and arg_466_1.time_ <= var_469_20 + arg_469_0 then
				arg_466_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_469_21 = 0
			local var_469_22 = 0.5

			if var_469_21 < arg_466_1.time_ and arg_466_1.time_ <= var_469_21 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_23 = arg_466_1:FormatText(StoryNameCfg[32].name)

				arg_466_1.leftNameTxt_.text = var_469_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_24 = arg_466_1:GetWordFromCfg(936041111)
				local var_469_25 = arg_466_1:FormatText(var_469_24.content)

				arg_466_1.text_.text = var_469_25

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_26 = 20
				local var_469_27 = utf8.len(var_469_25)
				local var_469_28 = var_469_26 <= 0 and var_469_22 or var_469_22 * (var_469_27 / var_469_26)

				if var_469_28 > 0 and var_469_22 < var_469_28 then
					arg_466_1.talkMaxDuration = var_469_28

					if var_469_28 + var_469_21 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_28 + var_469_21
					end
				end

				arg_466_1.text_.text = var_469_25
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041111", "story_v_side_old_936041.awb") ~= 0 then
					local var_469_29 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041111", "story_v_side_old_936041.awb") / 1000

					if var_469_29 + var_469_21 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_29 + var_469_21
					end

					if var_469_24.prefab_name ~= "" and arg_466_1.actors_[var_469_24.prefab_name] ~= nil then
						local var_469_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_24.prefab_name].transform, "story_v_side_old_936041", "936041111", "story_v_side_old_936041.awb")

						arg_466_1:RecordAudio("936041111", var_469_30)
						arg_466_1:RecordAudio("936041111", var_469_30)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041111", "story_v_side_old_936041.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041111", "story_v_side_old_936041.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_31 = math.max(var_469_22, arg_466_1.talkMaxDuration)

			if var_469_21 <= arg_466_1.time_ and arg_466_1.time_ < var_469_21 + var_469_31 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_21) / var_469_31

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_21 + var_469_31 and arg_466_1.time_ < var_469_21 + var_469_31 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_466_1:InitPlayNodeList()
	end,
	Play936041112 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 936041112
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play936041113(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["1066ui_story"]
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect1066ui_story == nil then
				arg_470_1.var_.characterEffect1066ui_story = var_473_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_2 = 0.200000002980232

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 and not isNil(var_473_0) then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2

				if arg_470_1.var_.characterEffect1066ui_story and not isNil(var_473_0) then
					local var_473_4 = Mathf.Lerp(0, 0.5, var_473_3)

					arg_470_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_470_1.var_.characterEffect1066ui_story.fillRatio = var_473_4
				end
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect1066ui_story then
				local var_473_5 = 0.5

				arg_470_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_470_1.var_.characterEffect1066ui_story.fillRatio = var_473_5
			end

			local var_473_6 = 0
			local var_473_7 = 0.175

			if var_473_6 < arg_470_1.time_ and arg_470_1.time_ <= var_473_6 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_8 = arg_470_1:FormatText(StoryNameCfg[7].name)

				arg_470_1.leftNameTxt_.text = var_473_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, true)
				arg_470_1.iconController_:SetSelectedState("hero")

				arg_470_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_470_1.callingController_:SetSelectedState("normal")

				arg_470_1.keyicon_.color = Color.New(1, 1, 1)
				arg_470_1.icon_.color = Color.New(1, 1, 1)

				local var_473_9 = arg_470_1:GetWordFromCfg(936041112)
				local var_473_10 = arg_470_1:FormatText(var_473_9.content)

				arg_470_1.text_.text = var_473_10

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_11 = 7
				local var_473_12 = utf8.len(var_473_10)
				local var_473_13 = var_473_11 <= 0 and var_473_7 or var_473_7 * (var_473_12 / var_473_11)

				if var_473_13 > 0 and var_473_7 < var_473_13 then
					arg_470_1.talkMaxDuration = var_473_13

					if var_473_13 + var_473_6 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_13 + var_473_6
					end
				end

				arg_470_1.text_.text = var_473_10
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_14 = math.max(var_473_7, arg_470_1.talkMaxDuration)

			if var_473_6 <= arg_470_1.time_ and arg_470_1.time_ < var_473_6 + var_473_14 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_6) / var_473_14

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_6 + var_473_14 and arg_470_1.time_ < var_473_6 + var_473_14 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play936041113 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 936041113
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play936041114(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["1066ui_story"].transform
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.var_.moveOldPos1066ui_story = var_477_0.localPosition
			end

			local var_477_2 = 0.001

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2
				local var_477_4 = Vector3.New(0, 100, 0)

				var_477_0.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1066ui_story, var_477_4, var_477_3)

				local var_477_5 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_5.x, var_477_5.y, var_477_5.z)

				local var_477_6 = var_477_0.localEulerAngles

				var_477_6.z = 0
				var_477_6.x = 0
				var_477_0.localEulerAngles = var_477_6
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 then
				var_477_0.localPosition = Vector3.New(0, 100, 0)

				local var_477_7 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_7.x, var_477_7.y, var_477_7.z)

				local var_477_8 = var_477_0.localEulerAngles

				var_477_8.z = 0
				var_477_8.x = 0
				var_477_0.localEulerAngles = var_477_8
			end

			local var_477_9 = arg_474_1.actors_["104402ui_story"].transform
			local var_477_10 = 0

			if var_477_10 < arg_474_1.time_ and arg_474_1.time_ <= var_477_10 + arg_477_0 then
				arg_474_1.var_.moveOldPos104402ui_story = var_477_9.localPosition

				local var_477_11 = GameObjectTools.GetOrAddComponent(var_477_9.gameObject, typeof(DynamicBoneHelper))

				if var_477_11 then
					var_477_11:EnableDynamicBone(false)
				end
			end

			local var_477_12 = 0.001

			if var_477_10 <= arg_474_1.time_ and arg_474_1.time_ < var_477_10 + var_477_12 then
				local var_477_13 = (arg_474_1.time_ - var_477_10) / var_477_12
				local var_477_14 = Vector3.New(0, 100, 0)

				var_477_9.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos104402ui_story, var_477_14, var_477_13)

				local var_477_15 = manager.ui.mainCamera.transform.position - var_477_9.position

				var_477_9.forward = Vector3.New(var_477_15.x, var_477_15.y, var_477_15.z)

				local var_477_16 = var_477_9.localEulerAngles

				var_477_16.z = 0
				var_477_16.x = 0
				var_477_9.localEulerAngles = var_477_16
			end

			if arg_474_1.time_ >= var_477_10 + var_477_12 and arg_474_1.time_ < var_477_10 + var_477_12 + arg_477_0 then
				var_477_9.localPosition = Vector3.New(0, 100, 0)

				local var_477_17 = manager.ui.mainCamera.transform.position - var_477_9.position

				var_477_9.forward = Vector3.New(var_477_17.x, var_477_17.y, var_477_17.z)

				local var_477_18 = var_477_9.localEulerAngles

				var_477_18.z = 0
				var_477_18.x = 0
				var_477_9.localEulerAngles = var_477_18

				local var_477_19 = GameObjectTools.GetOrAddComponent(var_477_9.gameObject, typeof(DynamicBoneHelper))

				if var_477_19 then
					var_477_19:EnableDynamicBone(true)
				end
			end

			local var_477_20 = 0
			local var_477_21 = 1

			if var_477_20 < arg_474_1.time_ and arg_474_1.time_ <= var_477_20 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_22 = arg_474_1:GetWordFromCfg(936041113)
				local var_477_23 = arg_474_1:FormatText(var_477_22.content)

				arg_474_1.text_.text = var_477_23

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_24 = 40
				local var_477_25 = utf8.len(var_477_23)
				local var_477_26 = var_477_24 <= 0 and var_477_21 or var_477_21 * (var_477_25 / var_477_24)

				if var_477_26 > 0 and var_477_21 < var_477_26 then
					arg_474_1.talkMaxDuration = var_477_26

					if var_477_26 + var_477_20 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_26 + var_477_20
					end
				end

				arg_474_1.text_.text = var_477_23
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_27 = math.max(var_477_21, arg_474_1.talkMaxDuration)

			if var_477_20 <= arg_474_1.time_ and arg_474_1.time_ < var_477_20 + var_477_27 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_20) / var_477_27

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_20 + var_477_27 and arg_474_1.time_ < var_477_20 + var_477_27 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play936041114 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 936041114
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play936041115(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 1

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				local var_481_2 = "play"
				local var_481_3 = "effect"

				arg_478_1:AudioAction(var_481_2, var_481_3, "se_story_1311", "se_story_1311_machine03", "")
			end

			local var_481_4 = 0
			local var_481_5 = 0.575

			if var_481_4 < arg_478_1.time_ and arg_478_1.time_ <= var_481_4 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_6 = arg_478_1:GetWordFromCfg(936041114)
				local var_481_7 = arg_478_1:FormatText(var_481_6.content)

				arg_478_1.text_.text = var_481_7

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_8 = 23
				local var_481_9 = utf8.len(var_481_7)
				local var_481_10 = var_481_8 <= 0 and var_481_5 or var_481_5 * (var_481_9 / var_481_8)

				if var_481_10 > 0 and var_481_5 < var_481_10 then
					arg_478_1.talkMaxDuration = var_481_10

					if var_481_10 + var_481_4 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_10 + var_481_4
					end
				end

				arg_478_1.text_.text = var_481_7
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_11 = math.max(var_481_5, arg_478_1.talkMaxDuration)

			if var_481_4 <= arg_478_1.time_ and arg_478_1.time_ < var_481_4 + var_481_11 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_4) / var_481_11

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_4 + var_481_11 and arg_478_1.time_ < var_481_4 + var_481_11 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play936041115 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 936041115
		arg_482_1.duration_ = 9

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play936041116(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = "H08f"

			if arg_482_1.bgs_[var_485_0] == nil then
				local var_485_1 = Object.Instantiate(arg_482_1.paintGo_)

				var_485_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_485_0)
				var_485_1.name = var_485_0
				var_485_1.transform.parent = arg_482_1.stage_.transform
				var_485_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_482_1.bgs_[var_485_0] = var_485_1
			end

			local var_485_2 = 2

			if var_485_2 < arg_482_1.time_ and arg_482_1.time_ <= var_485_2 + arg_485_0 then
				local var_485_3 = manager.ui.mainCamera.transform.localPosition
				local var_485_4 = Vector3.New(0, 0, 10) + Vector3.New(var_485_3.x, var_485_3.y, 0)
				local var_485_5 = arg_482_1.bgs_.H08f

				var_485_5.transform.localPosition = var_485_4
				var_485_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_485_6 = var_485_5:GetComponent("SpriteRenderer")

				if var_485_6 and var_485_6.sprite then
					local var_485_7 = (var_485_5.transform.localPosition - var_485_3).z
					local var_485_8 = manager.ui.mainCameraCom_
					local var_485_9 = 2 * var_485_7 * Mathf.Tan(var_485_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_485_10 = var_485_9 * var_485_8.aspect
					local var_485_11 = var_485_6.sprite.bounds.size.x
					local var_485_12 = var_485_6.sprite.bounds.size.y
					local var_485_13 = var_485_10 / var_485_11
					local var_485_14 = var_485_9 / var_485_12
					local var_485_15 = var_485_14 < var_485_13 and var_485_13 or var_485_14

					var_485_5.transform.localScale = Vector3.New(var_485_15, var_485_15, 0)
				end

				for iter_485_0, iter_485_1 in pairs(arg_482_1.bgs_) do
					if iter_485_0 ~= "H08f" then
						iter_485_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_485_16 = 4

			if var_485_16 < arg_482_1.time_ and arg_482_1.time_ <= var_485_16 + arg_485_0 then
				arg_482_1.allBtn_.enabled = false
			end

			local var_485_17 = 0.3

			if arg_482_1.time_ >= var_485_16 + var_485_17 and arg_482_1.time_ < var_485_16 + var_485_17 + arg_485_0 then
				arg_482_1.allBtn_.enabled = true
			end

			local var_485_18 = 0

			if var_485_18 < arg_482_1.time_ and arg_482_1.time_ <= var_485_18 + arg_485_0 then
				arg_482_1.mask_.enabled = true
				arg_482_1.mask_.raycastTarget = true

				arg_482_1:SetGaussion(false)
			end

			local var_485_19 = 2

			if var_485_18 <= arg_482_1.time_ and arg_482_1.time_ < var_485_18 + var_485_19 then
				local var_485_20 = (arg_482_1.time_ - var_485_18) / var_485_19
				local var_485_21 = Color.New(0, 0, 0)

				var_485_21.a = Mathf.Lerp(0, 1, var_485_20)
				arg_482_1.mask_.color = var_485_21
			end

			if arg_482_1.time_ >= var_485_18 + var_485_19 and arg_482_1.time_ < var_485_18 + var_485_19 + arg_485_0 then
				local var_485_22 = Color.New(0, 0, 0)

				var_485_22.a = 1
				arg_482_1.mask_.color = var_485_22
			end

			local var_485_23 = 2

			if var_485_23 < arg_482_1.time_ and arg_482_1.time_ <= var_485_23 + arg_485_0 then
				arg_482_1.mask_.enabled = true
				arg_482_1.mask_.raycastTarget = true

				arg_482_1:SetGaussion(false)
			end

			local var_485_24 = 2

			if var_485_23 <= arg_482_1.time_ and arg_482_1.time_ < var_485_23 + var_485_24 then
				local var_485_25 = (arg_482_1.time_ - var_485_23) / var_485_24
				local var_485_26 = Color.New(0, 0, 0)

				var_485_26.a = Mathf.Lerp(1, 0, var_485_25)
				arg_482_1.mask_.color = var_485_26
			end

			if arg_482_1.time_ >= var_485_23 + var_485_24 and arg_482_1.time_ < var_485_23 + var_485_24 + arg_485_0 then
				local var_485_27 = Color.New(0, 0, 0)
				local var_485_28 = 0

				arg_482_1.mask_.enabled = false
				var_485_27.a = var_485_28
				arg_482_1.mask_.color = var_485_27
			end

			local var_485_29 = 0.2
			local var_485_30 = 1

			if var_485_29 < arg_482_1.time_ and arg_482_1.time_ <= var_485_29 + arg_485_0 then
				local var_485_31 = "stop"
				local var_485_32 = "effect"

				arg_482_1:AudioAction(var_485_31, var_485_32, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_485_33 = 1.66666666666667
			local var_485_34 = 1

			if var_485_33 < arg_482_1.time_ and arg_482_1.time_ <= var_485_33 + arg_485_0 then
				local var_485_35 = "play"
				local var_485_36 = "effect"

				arg_482_1:AudioAction(var_485_35, var_485_36, "se_story_141", "se_story_141_boxing_amb_cheer06_loop", "")
			end

			if arg_482_1.frameCnt_ <= 1 then
				arg_482_1.dialog_:SetActive(false)
			end

			local var_485_37 = 4
			local var_485_38 = 0.1

			if var_485_37 < arg_482_1.time_ and arg_482_1.time_ <= var_485_37 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0

				arg_482_1.dialog_:SetActive(true)

				arg_482_1.dialogCg_.alpha = 0

				local var_485_39 = LeanTween.value(arg_482_1.dialog_, 0, 1, 0.3)

				var_485_39:setOnUpdate(LuaHelper.FloatAction(function(arg_486_0)
					arg_482_1.dialogCg_.alpha = arg_486_0
				end))
				var_485_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_482_1.dialog_)
					var_485_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_482_1.duration_ = arg_482_1.duration_ + 0.3

				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_40 = arg_482_1:FormatText(StoryNameCfg[7].name)

				arg_482_1.leftNameTxt_.text = var_485_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_41 = arg_482_1:GetWordFromCfg(936041115)
				local var_485_42 = arg_482_1:FormatText(var_485_41.content)

				arg_482_1.text_.text = var_485_42

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_43 = 4
				local var_485_44 = utf8.len(var_485_42)
				local var_485_45 = var_485_43 <= 0 and var_485_38 or var_485_38 * (var_485_44 / var_485_43)

				if var_485_45 > 0 and var_485_38 < var_485_45 then
					arg_482_1.talkMaxDuration = var_485_45
					var_485_37 = var_485_37 + 0.3

					if var_485_45 + var_485_37 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_45 + var_485_37
					end
				end

				arg_482_1.text_.text = var_485_42
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_46 = var_485_37 + 0.3
			local var_485_47 = math.max(var_485_38, arg_482_1.talkMaxDuration)

			if var_485_46 <= arg_482_1.time_ and arg_482_1.time_ < var_485_46 + var_485_47 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_46) / var_485_47

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_46 + var_485_47 and arg_482_1.time_ < var_485_46 + var_485_47 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play936041116 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 936041116
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play936041117(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 0
			local var_491_1 = 1.375

			if var_491_0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, false)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_2 = arg_488_1:GetWordFromCfg(936041116)
				local var_491_3 = arg_488_1:FormatText(var_491_2.content)

				arg_488_1.text_.text = var_491_3

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_4 = 55
				local var_491_5 = utf8.len(var_491_3)
				local var_491_6 = var_491_4 <= 0 and var_491_1 or var_491_1 * (var_491_5 / var_491_4)

				if var_491_6 > 0 and var_491_1 < var_491_6 then
					arg_488_1.talkMaxDuration = var_491_6

					if var_491_6 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_6 + var_491_0
					end
				end

				arg_488_1.text_.text = var_491_3
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_7 = math.max(var_491_1, arg_488_1.talkMaxDuration)

			if var_491_0 <= arg_488_1.time_ and arg_488_1.time_ < var_491_0 + var_491_7 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_0) / var_491_7

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_0 + var_491_7 and arg_488_1.time_ < var_491_0 + var_491_7 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play936041117 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 936041117
		arg_492_1.duration_ = 2

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play936041118(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["104402ui_story"].transform
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 then
				arg_492_1.var_.moveOldPos104402ui_story = var_495_0.localPosition

				local var_495_2 = GameObjectTools.GetOrAddComponent(var_495_0.gameObject, typeof(DynamicBoneHelper))

				if var_495_2 then
					var_495_2:EnableDynamicBone(false)
				end
			end

			local var_495_3 = 0.001

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_3 then
				local var_495_4 = (arg_492_1.time_ - var_495_1) / var_495_3
				local var_495_5 = Vector3.New(0, -1, -5.93)

				var_495_0.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos104402ui_story, var_495_5, var_495_4)

				local var_495_6 = manager.ui.mainCamera.transform.position - var_495_0.position

				var_495_0.forward = Vector3.New(var_495_6.x, var_495_6.y, var_495_6.z)

				local var_495_7 = var_495_0.localEulerAngles

				var_495_7.z = 0
				var_495_7.x = 0
				var_495_0.localEulerAngles = var_495_7
			end

			if arg_492_1.time_ >= var_495_1 + var_495_3 and arg_492_1.time_ < var_495_1 + var_495_3 + arg_495_0 then
				var_495_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_495_8 = manager.ui.mainCamera.transform.position - var_495_0.position

				var_495_0.forward = Vector3.New(var_495_8.x, var_495_8.y, var_495_8.z)

				local var_495_9 = var_495_0.localEulerAngles

				var_495_9.z = 0
				var_495_9.x = 0
				var_495_0.localEulerAngles = var_495_9

				local var_495_10 = GameObjectTools.GetOrAddComponent(var_495_0.gameObject, typeof(DynamicBoneHelper))

				if var_495_10 then
					var_495_10:EnableDynamicBone(true)
				end
			end

			local var_495_11 = arg_492_1.actors_["104402ui_story"]
			local var_495_12 = 0

			if var_495_12 < arg_492_1.time_ and arg_492_1.time_ <= var_495_12 + arg_495_0 and not isNil(var_495_11) and arg_492_1.var_.characterEffect104402ui_story == nil then
				arg_492_1.var_.characterEffect104402ui_story = var_495_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_13 = 0.200000002980232

			if var_495_12 <= arg_492_1.time_ and arg_492_1.time_ < var_495_12 + var_495_13 and not isNil(var_495_11) then
				local var_495_14 = (arg_492_1.time_ - var_495_12) / var_495_13

				if arg_492_1.var_.characterEffect104402ui_story and not isNil(var_495_11) then
					arg_492_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_492_1.time_ >= var_495_12 + var_495_13 and arg_492_1.time_ < var_495_12 + var_495_13 + arg_495_0 and not isNil(var_495_11) and arg_492_1.var_.characterEffect104402ui_story then
				arg_492_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_495_15 = 0

			if var_495_15 < arg_492_1.time_ and arg_492_1.time_ <= var_495_15 + arg_495_0 then
				arg_492_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			local var_495_16 = 0

			if var_495_16 < arg_492_1.time_ and arg_492_1.time_ <= var_495_16 + arg_495_0 then
				arg_492_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_495_17 = 0
			local var_495_18 = 0.125

			if var_495_17 < arg_492_1.time_ and arg_492_1.time_ <= var_495_17 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_19 = arg_492_1:FormatText(StoryNameCfg[1367].name)

				arg_492_1.leftNameTxt_.text = var_495_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_20 = arg_492_1:GetWordFromCfg(936041117)
				local var_495_21 = arg_492_1:FormatText(var_495_20.content)

				arg_492_1.text_.text = var_495_21

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_22 = 5
				local var_495_23 = utf8.len(var_495_21)
				local var_495_24 = var_495_22 <= 0 and var_495_18 or var_495_18 * (var_495_23 / var_495_22)

				if var_495_24 > 0 and var_495_18 < var_495_24 then
					arg_492_1.talkMaxDuration = var_495_24

					if var_495_24 + var_495_17 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_24 + var_495_17
					end
				end

				arg_492_1.text_.text = var_495_21
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041117", "story_v_side_old_936041.awb") ~= 0 then
					local var_495_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041117", "story_v_side_old_936041.awb") / 1000

					if var_495_25 + var_495_17 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_25 + var_495_17
					end

					if var_495_20.prefab_name ~= "" and arg_492_1.actors_[var_495_20.prefab_name] ~= nil then
						local var_495_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_20.prefab_name].transform, "story_v_side_old_936041", "936041117", "story_v_side_old_936041.awb")

						arg_492_1:RecordAudio("936041117", var_495_26)
						arg_492_1:RecordAudio("936041117", var_495_26)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041117", "story_v_side_old_936041.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041117", "story_v_side_old_936041.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_27 = math.max(var_495_18, arg_492_1.talkMaxDuration)

			if var_495_17 <= arg_492_1.time_ and arg_492_1.time_ < var_495_17 + var_495_27 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_17) / var_495_27

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_17 + var_495_27 and arg_492_1.time_ < var_495_17 + var_495_27 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play936041118 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 936041118
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play936041119(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["104402ui_story"].transform
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 then
				arg_496_1.var_.moveOldPos104402ui_story = var_499_0.localPosition

				local var_499_2 = GameObjectTools.GetOrAddComponent(var_499_0.gameObject, typeof(DynamicBoneHelper))

				if var_499_2 then
					var_499_2:EnableDynamicBone(false)
				end
			end

			local var_499_3 = 0.001

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_3 then
				local var_499_4 = (arg_496_1.time_ - var_499_1) / var_499_3
				local var_499_5 = Vector3.New(0, 100, 0)

				var_499_0.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos104402ui_story, var_499_5, var_499_4)

				local var_499_6 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_6.x, var_499_6.y, var_499_6.z)

				local var_499_7 = var_499_0.localEulerAngles

				var_499_7.z = 0
				var_499_7.x = 0
				var_499_0.localEulerAngles = var_499_7
			end

			if arg_496_1.time_ >= var_499_1 + var_499_3 and arg_496_1.time_ < var_499_1 + var_499_3 + arg_499_0 then
				var_499_0.localPosition = Vector3.New(0, 100, 0)

				local var_499_8 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_8.x, var_499_8.y, var_499_8.z)

				local var_499_9 = var_499_0.localEulerAngles

				var_499_9.z = 0
				var_499_9.x = 0
				var_499_0.localEulerAngles = var_499_9

				local var_499_10 = GameObjectTools.GetOrAddComponent(var_499_0.gameObject, typeof(DynamicBoneHelper))

				if var_499_10 then
					var_499_10:EnableDynamicBone(true)
				end
			end

			local var_499_11 = arg_496_1.actors_["104402ui_story"]
			local var_499_12 = 0

			if var_499_12 < arg_496_1.time_ and arg_496_1.time_ <= var_499_12 + arg_499_0 and not isNil(var_499_11) and arg_496_1.var_.characterEffect104402ui_story == nil then
				arg_496_1.var_.characterEffect104402ui_story = var_499_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_13 = 0.200000002980232

			if var_499_12 <= arg_496_1.time_ and arg_496_1.time_ < var_499_12 + var_499_13 and not isNil(var_499_11) then
				local var_499_14 = (arg_496_1.time_ - var_499_12) / var_499_13

				if arg_496_1.var_.characterEffect104402ui_story and not isNil(var_499_11) then
					local var_499_15 = Mathf.Lerp(0, 0.5, var_499_14)

					arg_496_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_496_1.var_.characterEffect104402ui_story.fillRatio = var_499_15
				end
			end

			if arg_496_1.time_ >= var_499_12 + var_499_13 and arg_496_1.time_ < var_499_12 + var_499_13 + arg_499_0 and not isNil(var_499_11) and arg_496_1.var_.characterEffect104402ui_story then
				local var_499_16 = 0.5

				arg_496_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_496_1.var_.characterEffect104402ui_story.fillRatio = var_499_16
			end

			local var_499_17 = 0
			local var_499_18 = 1

			if var_499_17 < arg_496_1.time_ and arg_496_1.time_ <= var_499_17 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_19 = arg_496_1:GetWordFromCfg(936041118)
				local var_499_20 = arg_496_1:FormatText(var_499_19.content)

				arg_496_1.text_.text = var_499_20

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_21 = 40
				local var_499_22 = utf8.len(var_499_20)
				local var_499_23 = var_499_21 <= 0 and var_499_18 or var_499_18 * (var_499_22 / var_499_21)

				if var_499_23 > 0 and var_499_18 < var_499_23 then
					arg_496_1.talkMaxDuration = var_499_23

					if var_499_23 + var_499_17 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_23 + var_499_17
					end
				end

				arg_496_1.text_.text = var_499_20
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_24 = math.max(var_499_18, arg_496_1.talkMaxDuration)

			if var_499_17 <= arg_496_1.time_ and arg_496_1.time_ < var_499_17 + var_499_24 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_17) / var_499_24

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_17 + var_499_24 and arg_496_1.time_ < var_499_17 + var_499_24 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
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
	Play936041119 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 936041119
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play936041120(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 0.225

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

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_3 = arg_500_1:GetWordFromCfg(936041119)
				local var_503_4 = arg_500_1:FormatText(var_503_3.content)

				arg_500_1.text_.text = var_503_4

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_5 = 9
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
	Play936041120 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 936041120
		arg_504_1.duration_ = 2

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play936041121(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = arg_504_1.actors_["104402ui_story"].transform
			local var_507_1 = 0

			if var_507_1 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 then
				arg_504_1.var_.moveOldPos104402ui_story = var_507_0.localPosition

				local var_507_2 = GameObjectTools.GetOrAddComponent(var_507_0.gameObject, typeof(DynamicBoneHelper))

				if var_507_2 then
					var_507_2:EnableDynamicBone(false)
				end
			end

			local var_507_3 = 0.001

			if var_507_1 <= arg_504_1.time_ and arg_504_1.time_ < var_507_1 + var_507_3 then
				local var_507_4 = (arg_504_1.time_ - var_507_1) / var_507_3
				local var_507_5 = Vector3.New(0, -1, -5.93)

				var_507_0.localPosition = Vector3.Lerp(arg_504_1.var_.moveOldPos104402ui_story, var_507_5, var_507_4)

				local var_507_6 = manager.ui.mainCamera.transform.position - var_507_0.position

				var_507_0.forward = Vector3.New(var_507_6.x, var_507_6.y, var_507_6.z)

				local var_507_7 = var_507_0.localEulerAngles

				var_507_7.z = 0
				var_507_7.x = 0
				var_507_0.localEulerAngles = var_507_7
			end

			if arg_504_1.time_ >= var_507_1 + var_507_3 and arg_504_1.time_ < var_507_1 + var_507_3 + arg_507_0 then
				var_507_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_507_8 = manager.ui.mainCamera.transform.position - var_507_0.position

				var_507_0.forward = Vector3.New(var_507_8.x, var_507_8.y, var_507_8.z)

				local var_507_9 = var_507_0.localEulerAngles

				var_507_9.z = 0
				var_507_9.x = 0
				var_507_0.localEulerAngles = var_507_9

				local var_507_10 = GameObjectTools.GetOrAddComponent(var_507_0.gameObject, typeof(DynamicBoneHelper))

				if var_507_10 then
					var_507_10:EnableDynamicBone(true)
				end
			end

			local var_507_11 = arg_504_1.actors_["104402ui_story"]
			local var_507_12 = 0

			if var_507_12 < arg_504_1.time_ and arg_504_1.time_ <= var_507_12 + arg_507_0 and not isNil(var_507_11) and arg_504_1.var_.characterEffect104402ui_story == nil then
				arg_504_1.var_.characterEffect104402ui_story = var_507_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_13 = 0.200000002980232

			if var_507_12 <= arg_504_1.time_ and arg_504_1.time_ < var_507_12 + var_507_13 and not isNil(var_507_11) then
				local var_507_14 = (arg_504_1.time_ - var_507_12) / var_507_13

				if arg_504_1.var_.characterEffect104402ui_story and not isNil(var_507_11) then
					arg_504_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_504_1.time_ >= var_507_12 + var_507_13 and arg_504_1.time_ < var_507_12 + var_507_13 + arg_507_0 and not isNil(var_507_11) and arg_504_1.var_.characterEffect104402ui_story then
				arg_504_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_507_15 = 0

			if var_507_15 < arg_504_1.time_ and arg_504_1.time_ <= var_507_15 + arg_507_0 then
				arg_504_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_1")
			end

			local var_507_16 = 0

			if var_507_16 < arg_504_1.time_ and arg_504_1.time_ <= var_507_16 + arg_507_0 then
				arg_504_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_507_17 = 0
			local var_507_18 = 0.225

			if var_507_17 < arg_504_1.time_ and arg_504_1.time_ <= var_507_17 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_19 = arg_504_1:FormatText(StoryNameCfg[1367].name)

				arg_504_1.leftNameTxt_.text = var_507_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_20 = arg_504_1:GetWordFromCfg(936041120)
				local var_507_21 = arg_504_1:FormatText(var_507_20.content)

				arg_504_1.text_.text = var_507_21

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_22 = 9
				local var_507_23 = utf8.len(var_507_21)
				local var_507_24 = var_507_22 <= 0 and var_507_18 or var_507_18 * (var_507_23 / var_507_22)

				if var_507_24 > 0 and var_507_18 < var_507_24 then
					arg_504_1.talkMaxDuration = var_507_24

					if var_507_24 + var_507_17 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_24 + var_507_17
					end
				end

				arg_504_1.text_.text = var_507_21
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041120", "story_v_side_old_936041.awb") ~= 0 then
					local var_507_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041120", "story_v_side_old_936041.awb") / 1000

					if var_507_25 + var_507_17 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_25 + var_507_17
					end

					if var_507_20.prefab_name ~= "" and arg_504_1.actors_[var_507_20.prefab_name] ~= nil then
						local var_507_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_20.prefab_name].transform, "story_v_side_old_936041", "936041120", "story_v_side_old_936041.awb")

						arg_504_1:RecordAudio("936041120", var_507_26)
						arg_504_1:RecordAudio("936041120", var_507_26)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041120", "story_v_side_old_936041.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041120", "story_v_side_old_936041.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_27 = math.max(var_507_18, arg_504_1.talkMaxDuration)

			if var_507_17 <= arg_504_1.time_ and arg_504_1.time_ < var_507_17 + var_507_27 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_17) / var_507_27

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_17 + var_507_27 and arg_504_1.time_ < var_507_17 + var_507_27 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_504_1:InitPlayNodeList()
	end,
	Play936041121 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 936041121
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play936041122(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.actors_["104402ui_story"]
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.characterEffect104402ui_story == nil then
				arg_508_1.var_.characterEffect104402ui_story = var_511_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_2 = 0.200000002980232

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_2 and not isNil(var_511_0) then
				local var_511_3 = (arg_508_1.time_ - var_511_1) / var_511_2

				if arg_508_1.var_.characterEffect104402ui_story and not isNil(var_511_0) then
					local var_511_4 = Mathf.Lerp(0, 0.5, var_511_3)

					arg_508_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_508_1.var_.characterEffect104402ui_story.fillRatio = var_511_4
				end
			end

			if arg_508_1.time_ >= var_511_1 + var_511_2 and arg_508_1.time_ < var_511_1 + var_511_2 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.characterEffect104402ui_story then
				local var_511_5 = 0.5

				arg_508_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_508_1.var_.characterEffect104402ui_story.fillRatio = var_511_5
			end

			local var_511_6 = 0
			local var_511_7 = 0.15

			if var_511_6 < arg_508_1.time_ and arg_508_1.time_ <= var_511_6 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_8 = arg_508_1:FormatText(StoryNameCfg[7].name)

				arg_508_1.leftNameTxt_.text = var_511_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_9 = arg_508_1:GetWordFromCfg(936041121)
				local var_511_10 = arg_508_1:FormatText(var_511_9.content)

				arg_508_1.text_.text = var_511_10

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_11 = 6
				local var_511_12 = utf8.len(var_511_10)
				local var_511_13 = var_511_11 <= 0 and var_511_7 or var_511_7 * (var_511_12 / var_511_11)

				if var_511_13 > 0 and var_511_7 < var_511_13 then
					arg_508_1.talkMaxDuration = var_511_13

					if var_511_13 + var_511_6 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_13 + var_511_6
					end
				end

				arg_508_1.text_.text = var_511_10
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_14 = math.max(var_511_7, arg_508_1.talkMaxDuration)

			if var_511_6 <= arg_508_1.time_ and arg_508_1.time_ < var_511_6 + var_511_14 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_6) / var_511_14

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_6 + var_511_14 and arg_508_1.time_ < var_511_6 + var_511_14 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play936041122 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 936041122
		arg_512_1.duration_ = 2.17

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play936041123(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = arg_512_1.actors_["121102ui_story"].transform
			local var_515_1 = 0

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 then
				arg_512_1.var_.moveOldPos121102ui_story = var_515_0.localPosition

				local var_515_2 = GameObjectTools.GetOrAddComponent(var_515_0.gameObject, typeof(DynamicBoneHelper))

				if var_515_2 then
					var_515_2:EnableDynamicBone(false)
				end
			end

			local var_515_3 = 0.001

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_3 then
				local var_515_4 = (arg_512_1.time_ - var_515_1) / var_515_3
				local var_515_5 = Vector3.New(0.7, -0.67, -6.07)

				var_515_0.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos121102ui_story, var_515_5, var_515_4)

				local var_515_6 = manager.ui.mainCamera.transform.position - var_515_0.position

				var_515_0.forward = Vector3.New(var_515_6.x, var_515_6.y, var_515_6.z)

				local var_515_7 = var_515_0.localEulerAngles

				var_515_7.z = 0
				var_515_7.x = 0
				var_515_0.localEulerAngles = var_515_7
			end

			if arg_512_1.time_ >= var_515_1 + var_515_3 and arg_512_1.time_ < var_515_1 + var_515_3 + arg_515_0 then
				var_515_0.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_515_8 = manager.ui.mainCamera.transform.position - var_515_0.position

				var_515_0.forward = Vector3.New(var_515_8.x, var_515_8.y, var_515_8.z)

				local var_515_9 = var_515_0.localEulerAngles

				var_515_9.z = 0
				var_515_9.x = 0
				var_515_0.localEulerAngles = var_515_9

				local var_515_10 = GameObjectTools.GetOrAddComponent(var_515_0.gameObject, typeof(DynamicBoneHelper))

				if var_515_10 then
					var_515_10:EnableDynamicBone(true)
				end
			end

			local var_515_11 = arg_512_1.actors_["104402ui_story"].transform
			local var_515_12 = 0

			if var_515_12 < arg_512_1.time_ and arg_512_1.time_ <= var_515_12 + arg_515_0 then
				arg_512_1.var_.moveOldPos104402ui_story = var_515_11.localPosition

				local var_515_13 = GameObjectTools.GetOrAddComponent(var_515_11.gameObject, typeof(DynamicBoneHelper))

				if var_515_13 then
					var_515_13:EnableDynamicBone(false)
				end
			end

			local var_515_14 = 0.001

			if var_515_12 <= arg_512_1.time_ and arg_512_1.time_ < var_515_12 + var_515_14 then
				local var_515_15 = (arg_512_1.time_ - var_515_12) / var_515_14
				local var_515_16 = Vector3.New(-0.7, -1, -5.93)

				var_515_11.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos104402ui_story, var_515_16, var_515_15)

				local var_515_17 = manager.ui.mainCamera.transform.position - var_515_11.position

				var_515_11.forward = Vector3.New(var_515_17.x, var_515_17.y, var_515_17.z)

				local var_515_18 = var_515_11.localEulerAngles

				var_515_18.z = 0
				var_515_18.x = 0
				var_515_11.localEulerAngles = var_515_18
			end

			if arg_512_1.time_ >= var_515_12 + var_515_14 and arg_512_1.time_ < var_515_12 + var_515_14 + arg_515_0 then
				var_515_11.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_515_19 = manager.ui.mainCamera.transform.position - var_515_11.position

				var_515_11.forward = Vector3.New(var_515_19.x, var_515_19.y, var_515_19.z)

				local var_515_20 = var_515_11.localEulerAngles

				var_515_20.z = 0
				var_515_20.x = 0
				var_515_11.localEulerAngles = var_515_20

				local var_515_21 = GameObjectTools.GetOrAddComponent(var_515_11.gameObject, typeof(DynamicBoneHelper))

				if var_515_21 then
					var_515_21:EnableDynamicBone(true)
				end
			end

			local var_515_22 = arg_512_1.actors_["121102ui_story"]
			local var_515_23 = 0

			if var_515_23 < arg_512_1.time_ and arg_512_1.time_ <= var_515_23 + arg_515_0 and not isNil(var_515_22) and arg_512_1.var_.characterEffect121102ui_story == nil then
				arg_512_1.var_.characterEffect121102ui_story = var_515_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_24 = 0.200000002980232

			if var_515_23 <= arg_512_1.time_ and arg_512_1.time_ < var_515_23 + var_515_24 and not isNil(var_515_22) then
				local var_515_25 = (arg_512_1.time_ - var_515_23) / var_515_24

				if arg_512_1.var_.characterEffect121102ui_story and not isNil(var_515_22) then
					arg_512_1.var_.characterEffect121102ui_story.fillFlat = false
				end
			end

			if arg_512_1.time_ >= var_515_23 + var_515_24 and arg_512_1.time_ < var_515_23 + var_515_24 + arg_515_0 and not isNil(var_515_22) and arg_512_1.var_.characterEffect121102ui_story then
				arg_512_1.var_.characterEffect121102ui_story.fillFlat = false
			end

			local var_515_26 = 0

			if var_515_26 < arg_512_1.time_ and arg_512_1.time_ <= var_515_26 + arg_515_0 then
				arg_512_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_515_27 = 0

			if var_515_27 < arg_512_1.time_ and arg_512_1.time_ <= var_515_27 + arg_515_0 then
				arg_512_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_515_28 = 0
			local var_515_29 = 0.225

			if var_515_28 < arg_512_1.time_ and arg_512_1.time_ <= var_515_28 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_30 = arg_512_1:FormatText(StoryNameCfg[37].name)

				arg_512_1.leftNameTxt_.text = var_515_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_31 = arg_512_1:GetWordFromCfg(936041122)
				local var_515_32 = arg_512_1:FormatText(var_515_31.content)

				arg_512_1.text_.text = var_515_32

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_33 = 9
				local var_515_34 = utf8.len(var_515_32)
				local var_515_35 = var_515_33 <= 0 and var_515_29 or var_515_29 * (var_515_34 / var_515_33)

				if var_515_35 > 0 and var_515_29 < var_515_35 then
					arg_512_1.talkMaxDuration = var_515_35

					if var_515_35 + var_515_28 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_35 + var_515_28
					end
				end

				arg_512_1.text_.text = var_515_32
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041122", "story_v_side_old_936041.awb") ~= 0 then
					local var_515_36 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041122", "story_v_side_old_936041.awb") / 1000

					if var_515_36 + var_515_28 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_36 + var_515_28
					end

					if var_515_31.prefab_name ~= "" and arg_512_1.actors_[var_515_31.prefab_name] ~= nil then
						local var_515_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_31.prefab_name].transform, "story_v_side_old_936041", "936041122", "story_v_side_old_936041.awb")

						arg_512_1:RecordAudio("936041122", var_515_37)
						arg_512_1:RecordAudio("936041122", var_515_37)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041122", "story_v_side_old_936041.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041122", "story_v_side_old_936041.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_38 = math.max(var_515_29, arg_512_1.talkMaxDuration)

			if var_515_28 <= arg_512_1.time_ and arg_512_1.time_ < var_515_28 + var_515_38 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_28) / var_515_38

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_28 + var_515_38 and arg_512_1.time_ < var_515_28 + var_515_38 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_512_1:InitPlayNodeList()
	end,
	Play936041123 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 936041123
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play936041124(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = arg_516_1.actors_["121102ui_story"]
			local var_519_1 = 0

			if var_519_1 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 and not isNil(var_519_0) and arg_516_1.var_.characterEffect121102ui_story == nil then
				arg_516_1.var_.characterEffect121102ui_story = var_519_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_2 = 0.200000002980232

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_2 and not isNil(var_519_0) then
				local var_519_3 = (arg_516_1.time_ - var_519_1) / var_519_2

				if arg_516_1.var_.characterEffect121102ui_story and not isNil(var_519_0) then
					local var_519_4 = Mathf.Lerp(0, 0.5, var_519_3)

					arg_516_1.var_.characterEffect121102ui_story.fillFlat = true
					arg_516_1.var_.characterEffect121102ui_story.fillRatio = var_519_4
				end
			end

			if arg_516_1.time_ >= var_519_1 + var_519_2 and arg_516_1.time_ < var_519_1 + var_519_2 + arg_519_0 and not isNil(var_519_0) and arg_516_1.var_.characterEffect121102ui_story then
				local var_519_5 = 0.5

				arg_516_1.var_.characterEffect121102ui_story.fillFlat = true
				arg_516_1.var_.characterEffect121102ui_story.fillRatio = var_519_5
			end

			local var_519_6 = 0
			local var_519_7 = 1.1

			if var_519_6 < arg_516_1.time_ and arg_516_1.time_ <= var_519_6 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, false)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_8 = arg_516_1:GetWordFromCfg(936041123)
				local var_519_9 = arg_516_1:FormatText(var_519_8.content)

				arg_516_1.text_.text = var_519_9

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_10 = 44
				local var_519_11 = utf8.len(var_519_9)
				local var_519_12 = var_519_10 <= 0 and var_519_7 or var_519_7 * (var_519_11 / var_519_10)

				if var_519_12 > 0 and var_519_7 < var_519_12 then
					arg_516_1.talkMaxDuration = var_519_12

					if var_519_12 + var_519_6 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_12 + var_519_6
					end
				end

				arg_516_1.text_.text = var_519_9
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_13 = math.max(var_519_7, arg_516_1.talkMaxDuration)

			if var_519_6 <= arg_516_1.time_ and arg_516_1.time_ < var_519_6 + var_519_13 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_6) / var_519_13

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_6 + var_519_13 and arg_516_1.time_ < var_519_6 + var_519_13 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play936041124 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 936041124
		arg_520_1.duration_ = 3.53

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play936041125(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = arg_520_1.actors_["121102ui_story"].transform
			local var_523_1 = 0

			if var_523_1 < arg_520_1.time_ and arg_520_1.time_ <= var_523_1 + arg_523_0 then
				arg_520_1.var_.moveOldPos121102ui_story = var_523_0.localPosition

				local var_523_2 = GameObjectTools.GetOrAddComponent(var_523_0.gameObject, typeof(DynamicBoneHelper))

				if var_523_2 then
					var_523_2:EnableDynamicBone(false)
				end
			end

			local var_523_3 = 0.001

			if var_523_1 <= arg_520_1.time_ and arg_520_1.time_ < var_523_1 + var_523_3 then
				local var_523_4 = (arg_520_1.time_ - var_523_1) / var_523_3
				local var_523_5 = Vector3.New(0, 100, 0)

				var_523_0.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos121102ui_story, var_523_5, var_523_4)

				local var_523_6 = manager.ui.mainCamera.transform.position - var_523_0.position

				var_523_0.forward = Vector3.New(var_523_6.x, var_523_6.y, var_523_6.z)

				local var_523_7 = var_523_0.localEulerAngles

				var_523_7.z = 0
				var_523_7.x = 0
				var_523_0.localEulerAngles = var_523_7
			end

			if arg_520_1.time_ >= var_523_1 + var_523_3 and arg_520_1.time_ < var_523_1 + var_523_3 + arg_523_0 then
				var_523_0.localPosition = Vector3.New(0, 100, 0)

				local var_523_8 = manager.ui.mainCamera.transform.position - var_523_0.position

				var_523_0.forward = Vector3.New(var_523_8.x, var_523_8.y, var_523_8.z)

				local var_523_9 = var_523_0.localEulerAngles

				var_523_9.z = 0
				var_523_9.x = 0
				var_523_0.localEulerAngles = var_523_9

				local var_523_10 = GameObjectTools.GetOrAddComponent(var_523_0.gameObject, typeof(DynamicBoneHelper))

				if var_523_10 then
					var_523_10:EnableDynamicBone(true)
				end
			end

			local var_523_11 = arg_520_1.actors_["104402ui_story"].transform
			local var_523_12 = 0

			if var_523_12 < arg_520_1.time_ and arg_520_1.time_ <= var_523_12 + arg_523_0 then
				arg_520_1.var_.moveOldPos104402ui_story = var_523_11.localPosition

				local var_523_13 = GameObjectTools.GetOrAddComponent(var_523_11.gameObject, typeof(DynamicBoneHelper))

				if var_523_13 then
					var_523_13:EnableDynamicBone(false)
				end
			end

			local var_523_14 = 0.001

			if var_523_12 <= arg_520_1.time_ and arg_520_1.time_ < var_523_12 + var_523_14 then
				local var_523_15 = (arg_520_1.time_ - var_523_12) / var_523_14
				local var_523_16 = Vector3.New(0, 100, 0)

				var_523_11.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos104402ui_story, var_523_16, var_523_15)

				local var_523_17 = manager.ui.mainCamera.transform.position - var_523_11.position

				var_523_11.forward = Vector3.New(var_523_17.x, var_523_17.y, var_523_17.z)

				local var_523_18 = var_523_11.localEulerAngles

				var_523_18.z = 0
				var_523_18.x = 0
				var_523_11.localEulerAngles = var_523_18
			end

			if arg_520_1.time_ >= var_523_12 + var_523_14 and arg_520_1.time_ < var_523_12 + var_523_14 + arg_523_0 then
				var_523_11.localPosition = Vector3.New(0, 100, 0)

				local var_523_19 = manager.ui.mainCamera.transform.position - var_523_11.position

				var_523_11.forward = Vector3.New(var_523_19.x, var_523_19.y, var_523_19.z)

				local var_523_20 = var_523_11.localEulerAngles

				var_523_20.z = 0
				var_523_20.x = 0
				var_523_11.localEulerAngles = var_523_20

				local var_523_21 = GameObjectTools.GetOrAddComponent(var_523_11.gameObject, typeof(DynamicBoneHelper))

				if var_523_21 then
					var_523_21:EnableDynamicBone(true)
				end
			end

			local var_523_22 = arg_520_1.actors_["105401ui_story"]
			local var_523_23 = 0

			if var_523_23 < arg_520_1.time_ and arg_520_1.time_ <= var_523_23 + arg_523_0 and not isNil(var_523_22) and arg_520_1.var_.characterEffect105401ui_story == nil then
				arg_520_1.var_.characterEffect105401ui_story = var_523_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_523_24 = 0.200000002980232

			if var_523_23 <= arg_520_1.time_ and arg_520_1.time_ < var_523_23 + var_523_24 and not isNil(var_523_22) then
				local var_523_25 = (arg_520_1.time_ - var_523_23) / var_523_24

				if arg_520_1.var_.characterEffect105401ui_story and not isNil(var_523_22) then
					arg_520_1.var_.characterEffect105401ui_story.fillFlat = false
				end
			end

			if arg_520_1.time_ >= var_523_23 + var_523_24 and arg_520_1.time_ < var_523_23 + var_523_24 + arg_523_0 and not isNil(var_523_22) and arg_520_1.var_.characterEffect105401ui_story then
				arg_520_1.var_.characterEffect105401ui_story.fillFlat = false
			end

			local var_523_26 = 0

			if var_523_26 < arg_520_1.time_ and arg_520_1.time_ <= var_523_26 + arg_523_0 then
				arg_520_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action7_1")
			end

			local var_523_27 = 0

			if var_523_27 < arg_520_1.time_ and arg_520_1.time_ <= var_523_27 + arg_523_0 then
				arg_520_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_523_28 = arg_520_1.actors_["105401ui_story"].transform
			local var_523_29 = 0

			if var_523_29 < arg_520_1.time_ and arg_520_1.time_ <= var_523_29 + arg_523_0 then
				arg_520_1.var_.moveOldPos105401ui_story = var_523_28.localPosition

				local var_523_30 = GameObjectTools.GetOrAddComponent(var_523_28.gameObject, typeof(DynamicBoneHelper))

				if var_523_30 then
					var_523_30:EnableDynamicBone(false)
				end
			end

			local var_523_31 = 0.001

			if var_523_29 <= arg_520_1.time_ and arg_520_1.time_ < var_523_29 + var_523_31 then
				local var_523_32 = (arg_520_1.time_ - var_523_29) / var_523_31
				local var_523_33 = Vector3.New(0, -0.985, -6)

				var_523_28.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos105401ui_story, var_523_33, var_523_32)

				local var_523_34 = manager.ui.mainCamera.transform.position - var_523_28.position

				var_523_28.forward = Vector3.New(var_523_34.x, var_523_34.y, var_523_34.z)

				local var_523_35 = var_523_28.localEulerAngles

				var_523_35.z = 0
				var_523_35.x = 0
				var_523_28.localEulerAngles = var_523_35
			end

			if arg_520_1.time_ >= var_523_29 + var_523_31 and arg_520_1.time_ < var_523_29 + var_523_31 + arg_523_0 then
				var_523_28.localPosition = Vector3.New(0, -0.985, -6)

				local var_523_36 = manager.ui.mainCamera.transform.position - var_523_28.position

				var_523_28.forward = Vector3.New(var_523_36.x, var_523_36.y, var_523_36.z)

				local var_523_37 = var_523_28.localEulerAngles

				var_523_37.z = 0
				var_523_37.x = 0
				var_523_28.localEulerAngles = var_523_37

				local var_523_38 = GameObjectTools.GetOrAddComponent(var_523_28.gameObject, typeof(DynamicBoneHelper))

				if var_523_38 then
					var_523_38:EnableDynamicBone(true)
				end
			end

			local var_523_39 = 0
			local var_523_40 = 0.475

			if var_523_39 < arg_520_1.time_ and arg_520_1.time_ <= var_523_39 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_41 = arg_520_1:FormatText(StoryNameCfg[1487].name)

				arg_520_1.leftNameTxt_.text = var_523_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_42 = arg_520_1:GetWordFromCfg(936041124)
				local var_523_43 = arg_520_1:FormatText(var_523_42.content)

				arg_520_1.text_.text = var_523_43

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_44 = 19
				local var_523_45 = utf8.len(var_523_43)
				local var_523_46 = var_523_44 <= 0 and var_523_40 or var_523_40 * (var_523_45 / var_523_44)

				if var_523_46 > 0 and var_523_40 < var_523_46 then
					arg_520_1.talkMaxDuration = var_523_46

					if var_523_46 + var_523_39 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_46 + var_523_39
					end
				end

				arg_520_1.text_.text = var_523_43
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041124", "story_v_side_old_936041.awb") ~= 0 then
					local var_523_47 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041124", "story_v_side_old_936041.awb") / 1000

					if var_523_47 + var_523_39 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_47 + var_523_39
					end

					if var_523_42.prefab_name ~= "" and arg_520_1.actors_[var_523_42.prefab_name] ~= nil then
						local var_523_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_42.prefab_name].transform, "story_v_side_old_936041", "936041124", "story_v_side_old_936041.awb")

						arg_520_1:RecordAudio("936041124", var_523_48)
						arg_520_1:RecordAudio("936041124", var_523_48)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041124", "story_v_side_old_936041.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041124", "story_v_side_old_936041.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_49 = math.max(var_523_40, arg_520_1.talkMaxDuration)

			if var_523_39 <= arg_520_1.time_ and arg_520_1.time_ < var_523_39 + var_523_49 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_39) / var_523_49

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_39 + var_523_49 and arg_520_1.time_ < var_523_39 + var_523_49 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_520_1:InitPlayNodeList()
	end,
	Play936041125 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 936041125
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play936041126(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = arg_524_1.actors_["105401ui_story"]
			local var_527_1 = 0

			if var_527_1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.characterEffect105401ui_story == nil then
				arg_524_1.var_.characterEffect105401ui_story = var_527_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_2 = 0.200000002980232

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_2 and not isNil(var_527_0) then
				local var_527_3 = (arg_524_1.time_ - var_527_1) / var_527_2

				if arg_524_1.var_.characterEffect105401ui_story and not isNil(var_527_0) then
					local var_527_4 = Mathf.Lerp(0, 0.5, var_527_3)

					arg_524_1.var_.characterEffect105401ui_story.fillFlat = true
					arg_524_1.var_.characterEffect105401ui_story.fillRatio = var_527_4
				end
			end

			if arg_524_1.time_ >= var_527_1 + var_527_2 and arg_524_1.time_ < var_527_1 + var_527_2 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.characterEffect105401ui_story then
				local var_527_5 = 0.5

				arg_524_1.var_.characterEffect105401ui_story.fillFlat = true
				arg_524_1.var_.characterEffect105401ui_story.fillRatio = var_527_5
			end

			local var_527_6 = 0
			local var_527_7 = 0.25

			if var_527_6 < arg_524_1.time_ and arg_524_1.time_ <= var_527_6 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_8 = arg_524_1:FormatText(StoryNameCfg[7].name)

				arg_524_1.leftNameTxt_.text = var_527_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_9 = arg_524_1:GetWordFromCfg(936041125)
				local var_527_10 = arg_524_1:FormatText(var_527_9.content)

				arg_524_1.text_.text = var_527_10

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_11 = 10
				local var_527_12 = utf8.len(var_527_10)
				local var_527_13 = var_527_11 <= 0 and var_527_7 or var_527_7 * (var_527_12 / var_527_11)

				if var_527_13 > 0 and var_527_7 < var_527_13 then
					arg_524_1.talkMaxDuration = var_527_13

					if var_527_13 + var_527_6 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_13 + var_527_6
					end
				end

				arg_524_1.text_.text = var_527_10
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_14 = math.max(var_527_7, arg_524_1.talkMaxDuration)

			if var_527_6 <= arg_524_1.time_ and arg_524_1.time_ < var_527_6 + var_527_14 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_6) / var_527_14

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_6 + var_527_14 and arg_524_1.time_ < var_527_6 + var_527_14 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play936041126 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 936041126
		arg_528_1.duration_ = 4.5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play936041127(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = arg_528_1.actors_["104402ui_story"].transform
			local var_531_1 = 0

			if var_531_1 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 then
				arg_528_1.var_.moveOldPos104402ui_story = var_531_0.localPosition

				local var_531_2 = GameObjectTools.GetOrAddComponent(var_531_0.gameObject, typeof(DynamicBoneHelper))

				if var_531_2 then
					var_531_2:EnableDynamicBone(false)
				end
			end

			local var_531_3 = 0.001

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_3 then
				local var_531_4 = (arg_528_1.time_ - var_531_1) / var_531_3
				local var_531_5 = Vector3.New(0, -1, -5.93)

				var_531_0.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos104402ui_story, var_531_5, var_531_4)

				local var_531_6 = manager.ui.mainCamera.transform.position - var_531_0.position

				var_531_0.forward = Vector3.New(var_531_6.x, var_531_6.y, var_531_6.z)

				local var_531_7 = var_531_0.localEulerAngles

				var_531_7.z = 0
				var_531_7.x = 0
				var_531_0.localEulerAngles = var_531_7
			end

			if arg_528_1.time_ >= var_531_1 + var_531_3 and arg_528_1.time_ < var_531_1 + var_531_3 + arg_531_0 then
				var_531_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_531_8 = manager.ui.mainCamera.transform.position - var_531_0.position

				var_531_0.forward = Vector3.New(var_531_8.x, var_531_8.y, var_531_8.z)

				local var_531_9 = var_531_0.localEulerAngles

				var_531_9.z = 0
				var_531_9.x = 0
				var_531_0.localEulerAngles = var_531_9

				local var_531_10 = GameObjectTools.GetOrAddComponent(var_531_0.gameObject, typeof(DynamicBoneHelper))

				if var_531_10 then
					var_531_10:EnableDynamicBone(true)
				end
			end

			local var_531_11 = arg_528_1.actors_["104402ui_story"]
			local var_531_12 = 0

			if var_531_12 < arg_528_1.time_ and arg_528_1.time_ <= var_531_12 + arg_531_0 and not isNil(var_531_11) and arg_528_1.var_.characterEffect104402ui_story == nil then
				arg_528_1.var_.characterEffect104402ui_story = var_531_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_13 = 0.200000002980232

			if var_531_12 <= arg_528_1.time_ and arg_528_1.time_ < var_531_12 + var_531_13 and not isNil(var_531_11) then
				local var_531_14 = (arg_528_1.time_ - var_531_12) / var_531_13

				if arg_528_1.var_.characterEffect104402ui_story and not isNil(var_531_11) then
					arg_528_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_528_1.time_ >= var_531_12 + var_531_13 and arg_528_1.time_ < var_531_12 + var_531_13 + arg_531_0 and not isNil(var_531_11) and arg_528_1.var_.characterEffect104402ui_story then
				arg_528_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_531_15 = 0

			if var_531_15 < arg_528_1.time_ and arg_528_1.time_ <= var_531_15 + arg_531_0 then
				arg_528_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action5_1")
			end

			local var_531_16 = 0

			if var_531_16 < arg_528_1.time_ and arg_528_1.time_ <= var_531_16 + arg_531_0 then
				arg_528_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_531_17 = arg_528_1.actors_["105401ui_story"].transform
			local var_531_18 = 0

			if var_531_18 < arg_528_1.time_ and arg_528_1.time_ <= var_531_18 + arg_531_0 then
				arg_528_1.var_.moveOldPos105401ui_story = var_531_17.localPosition

				local var_531_19 = GameObjectTools.GetOrAddComponent(var_531_17.gameObject, typeof(DynamicBoneHelper))

				if var_531_19 then
					var_531_19:EnableDynamicBone(false)
				end
			end

			local var_531_20 = 0.001

			if var_531_18 <= arg_528_1.time_ and arg_528_1.time_ < var_531_18 + var_531_20 then
				local var_531_21 = (arg_528_1.time_ - var_531_18) / var_531_20
				local var_531_22 = Vector3.New(0, 100, 0)

				var_531_17.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos105401ui_story, var_531_22, var_531_21)

				local var_531_23 = manager.ui.mainCamera.transform.position - var_531_17.position

				var_531_17.forward = Vector3.New(var_531_23.x, var_531_23.y, var_531_23.z)

				local var_531_24 = var_531_17.localEulerAngles

				var_531_24.z = 0
				var_531_24.x = 0
				var_531_17.localEulerAngles = var_531_24
			end

			if arg_528_1.time_ >= var_531_18 + var_531_20 and arg_528_1.time_ < var_531_18 + var_531_20 + arg_531_0 then
				var_531_17.localPosition = Vector3.New(0, 100, 0)

				local var_531_25 = manager.ui.mainCamera.transform.position - var_531_17.position

				var_531_17.forward = Vector3.New(var_531_25.x, var_531_25.y, var_531_25.z)

				local var_531_26 = var_531_17.localEulerAngles

				var_531_26.z = 0
				var_531_26.x = 0
				var_531_17.localEulerAngles = var_531_26

				local var_531_27 = GameObjectTools.GetOrAddComponent(var_531_17.gameObject, typeof(DynamicBoneHelper))

				if var_531_27 then
					var_531_27:EnableDynamicBone(true)
				end
			end

			local var_531_28 = 0
			local var_531_29 = 0.4

			if var_531_28 < arg_528_1.time_ and arg_528_1.time_ <= var_531_28 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_30 = arg_528_1:FormatText(StoryNameCfg[1367].name)

				arg_528_1.leftNameTxt_.text = var_531_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_31 = arg_528_1:GetWordFromCfg(936041126)
				local var_531_32 = arg_528_1:FormatText(var_531_31.content)

				arg_528_1.text_.text = var_531_32

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_33 = 16
				local var_531_34 = utf8.len(var_531_32)
				local var_531_35 = var_531_33 <= 0 and var_531_29 or var_531_29 * (var_531_34 / var_531_33)

				if var_531_35 > 0 and var_531_29 < var_531_35 then
					arg_528_1.talkMaxDuration = var_531_35

					if var_531_35 + var_531_28 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_35 + var_531_28
					end
				end

				arg_528_1.text_.text = var_531_32
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041126", "story_v_side_old_936041.awb") ~= 0 then
					local var_531_36 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041126", "story_v_side_old_936041.awb") / 1000

					if var_531_36 + var_531_28 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_36 + var_531_28
					end

					if var_531_31.prefab_name ~= "" and arg_528_1.actors_[var_531_31.prefab_name] ~= nil then
						local var_531_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_31.prefab_name].transform, "story_v_side_old_936041", "936041126", "story_v_side_old_936041.awb")

						arg_528_1:RecordAudio("936041126", var_531_37)
						arg_528_1:RecordAudio("936041126", var_531_37)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041126", "story_v_side_old_936041.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041126", "story_v_side_old_936041.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_38 = math.max(var_531_29, arg_528_1.talkMaxDuration)

			if var_531_28 <= arg_528_1.time_ and arg_528_1.time_ < var_531_28 + var_531_38 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_28) / var_531_38

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_28 + var_531_38 and arg_528_1.time_ < var_531_28 + var_531_38 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_528_1:InitPlayNodeList()
	end,
	Play936041127 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 936041127
		arg_532_1.duration_ = 4.87

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play936041128(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = arg_532_1.actors_["104402ui_story"].transform
			local var_535_1 = 0

			if var_535_1 < arg_532_1.time_ and arg_532_1.time_ <= var_535_1 + arg_535_0 then
				arg_532_1.var_.moveOldPos104402ui_story = var_535_0.localPosition

				local var_535_2 = GameObjectTools.GetOrAddComponent(var_535_0.gameObject, typeof(DynamicBoneHelper))

				if var_535_2 then
					var_535_2:EnableDynamicBone(false)
				end
			end

			local var_535_3 = 0.001

			if var_535_1 <= arg_532_1.time_ and arg_532_1.time_ < var_535_1 + var_535_3 then
				local var_535_4 = (arg_532_1.time_ - var_535_1) / var_535_3
				local var_535_5 = Vector3.New(0, -1, -5.93)

				var_535_0.localPosition = Vector3.Lerp(arg_532_1.var_.moveOldPos104402ui_story, var_535_5, var_535_4)

				local var_535_6 = manager.ui.mainCamera.transform.position - var_535_0.position

				var_535_0.forward = Vector3.New(var_535_6.x, var_535_6.y, var_535_6.z)

				local var_535_7 = var_535_0.localEulerAngles

				var_535_7.z = 0
				var_535_7.x = 0
				var_535_0.localEulerAngles = var_535_7
			end

			if arg_532_1.time_ >= var_535_1 + var_535_3 and arg_532_1.time_ < var_535_1 + var_535_3 + arg_535_0 then
				var_535_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_535_8 = manager.ui.mainCamera.transform.position - var_535_0.position

				var_535_0.forward = Vector3.New(var_535_8.x, var_535_8.y, var_535_8.z)

				local var_535_9 = var_535_0.localEulerAngles

				var_535_9.z = 0
				var_535_9.x = 0
				var_535_0.localEulerAngles = var_535_9

				local var_535_10 = GameObjectTools.GetOrAddComponent(var_535_0.gameObject, typeof(DynamicBoneHelper))

				if var_535_10 then
					var_535_10:EnableDynamicBone(true)
				end
			end

			local var_535_11 = 0

			if var_535_11 < arg_532_1.time_ and arg_532_1.time_ <= var_535_11 + arg_535_0 then
				arg_532_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action5_2")
			end

			local var_535_12 = 0

			if var_535_12 < arg_532_1.time_ and arg_532_1.time_ <= var_535_12 + arg_535_0 then
				arg_532_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_535_13 = 0
			local var_535_14 = 0.55

			if var_535_13 < arg_532_1.time_ and arg_532_1.time_ <= var_535_13 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_15 = arg_532_1:FormatText(StoryNameCfg[1367].name)

				arg_532_1.leftNameTxt_.text = var_535_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_16 = arg_532_1:GetWordFromCfg(936041127)
				local var_535_17 = arg_532_1:FormatText(var_535_16.content)

				arg_532_1.text_.text = var_535_17

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_18 = 22
				local var_535_19 = utf8.len(var_535_17)
				local var_535_20 = var_535_18 <= 0 and var_535_14 or var_535_14 * (var_535_19 / var_535_18)

				if var_535_20 > 0 and var_535_14 < var_535_20 then
					arg_532_1.talkMaxDuration = var_535_20

					if var_535_20 + var_535_13 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_20 + var_535_13
					end
				end

				arg_532_1.text_.text = var_535_17
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041127", "story_v_side_old_936041.awb") ~= 0 then
					local var_535_21 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041127", "story_v_side_old_936041.awb") / 1000

					if var_535_21 + var_535_13 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_21 + var_535_13
					end

					if var_535_16.prefab_name ~= "" and arg_532_1.actors_[var_535_16.prefab_name] ~= nil then
						local var_535_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_16.prefab_name].transform, "story_v_side_old_936041", "936041127", "story_v_side_old_936041.awb")

						arg_532_1:RecordAudio("936041127", var_535_22)
						arg_532_1:RecordAudio("936041127", var_535_22)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041127", "story_v_side_old_936041.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041127", "story_v_side_old_936041.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_23 = math.max(var_535_14, arg_532_1.talkMaxDuration)

			if var_535_13 <= arg_532_1.time_ and arg_532_1.time_ < var_535_13 + var_535_23 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_13) / var_535_23

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_13 + var_535_23 and arg_532_1.time_ < var_535_13 + var_535_23 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_532_1:InitPlayNodeList()
	end,
	Play936041128 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 936041128
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play936041129(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = arg_536_1.actors_["104402ui_story"].transform
			local var_539_1 = 0

			if var_539_1 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 then
				arg_536_1.var_.moveOldPos104402ui_story = var_539_0.localPosition

				local var_539_2 = GameObjectTools.GetOrAddComponent(var_539_0.gameObject, typeof(DynamicBoneHelper))

				if var_539_2 then
					var_539_2:EnableDynamicBone(false)
				end
			end

			local var_539_3 = 0.001

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_3 then
				local var_539_4 = (arg_536_1.time_ - var_539_1) / var_539_3
				local var_539_5 = Vector3.New(0, 100, 0)

				var_539_0.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos104402ui_story, var_539_5, var_539_4)

				local var_539_6 = manager.ui.mainCamera.transform.position - var_539_0.position

				var_539_0.forward = Vector3.New(var_539_6.x, var_539_6.y, var_539_6.z)

				local var_539_7 = var_539_0.localEulerAngles

				var_539_7.z = 0
				var_539_7.x = 0
				var_539_0.localEulerAngles = var_539_7
			end

			if arg_536_1.time_ >= var_539_1 + var_539_3 and arg_536_1.time_ < var_539_1 + var_539_3 + arg_539_0 then
				var_539_0.localPosition = Vector3.New(0, 100, 0)

				local var_539_8 = manager.ui.mainCamera.transform.position - var_539_0.position

				var_539_0.forward = Vector3.New(var_539_8.x, var_539_8.y, var_539_8.z)

				local var_539_9 = var_539_0.localEulerAngles

				var_539_9.z = 0
				var_539_9.x = 0
				var_539_0.localEulerAngles = var_539_9

				local var_539_10 = GameObjectTools.GetOrAddComponent(var_539_0.gameObject, typeof(DynamicBoneHelper))

				if var_539_10 then
					var_539_10:EnableDynamicBone(true)
				end
			end

			local var_539_11 = arg_536_1.actors_["104402ui_story"]
			local var_539_12 = 0

			if var_539_12 < arg_536_1.time_ and arg_536_1.time_ <= var_539_12 + arg_539_0 and not isNil(var_539_11) and arg_536_1.var_.characterEffect104402ui_story == nil then
				arg_536_1.var_.characterEffect104402ui_story = var_539_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_13 = 0.200000002980232

			if var_539_12 <= arg_536_1.time_ and arg_536_1.time_ < var_539_12 + var_539_13 and not isNil(var_539_11) then
				local var_539_14 = (arg_536_1.time_ - var_539_12) / var_539_13

				if arg_536_1.var_.characterEffect104402ui_story and not isNil(var_539_11) then
					local var_539_15 = Mathf.Lerp(0, 0.5, var_539_14)

					arg_536_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_536_1.var_.characterEffect104402ui_story.fillRatio = var_539_15
				end
			end

			if arg_536_1.time_ >= var_539_12 + var_539_13 and arg_536_1.time_ < var_539_12 + var_539_13 + arg_539_0 and not isNil(var_539_11) and arg_536_1.var_.characterEffect104402ui_story then
				local var_539_16 = 0.5

				arg_536_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_536_1.var_.characterEffect104402ui_story.fillRatio = var_539_16
			end

			local var_539_17 = 0.833333333333333
			local var_539_18 = 1

			if var_539_17 < arg_536_1.time_ and arg_536_1.time_ <= var_539_17 + arg_539_0 then
				local var_539_19 = "play"
				local var_539_20 = "effect"

				arg_536_1:AudioAction(var_539_19, var_539_20, "se_story_140", "se_story_140_hug02", "")
			end

			local var_539_21 = 0
			local var_539_22 = 1.15

			if var_539_21 < arg_536_1.time_ and arg_536_1.time_ <= var_539_21 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, false)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_23 = arg_536_1:GetWordFromCfg(936041128)
				local var_539_24 = arg_536_1:FormatText(var_539_23.content)

				arg_536_1.text_.text = var_539_24

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_25 = 46
				local var_539_26 = utf8.len(var_539_24)
				local var_539_27 = var_539_25 <= 0 and var_539_22 or var_539_22 * (var_539_26 / var_539_25)

				if var_539_27 > 0 and var_539_22 < var_539_27 then
					arg_536_1.talkMaxDuration = var_539_27

					if var_539_27 + var_539_21 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_27 + var_539_21
					end
				end

				arg_536_1.text_.text = var_539_24
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_28 = math.max(var_539_22, arg_536_1.talkMaxDuration)

			if var_539_21 <= arg_536_1.time_ and arg_536_1.time_ < var_539_21 + var_539_28 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_21) / var_539_28

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_21 + var_539_28 and arg_536_1.time_ < var_539_21 + var_539_28 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_536_1:InitPlayNodeList()
	end,
	Play936041129 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 936041129
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play936041130(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0
			local var_543_1 = 0.15

			if var_543_0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_2 = arg_540_1:FormatText(StoryNameCfg[7].name)

				arg_540_1.leftNameTxt_.text = var_543_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_3 = arg_540_1:GetWordFromCfg(936041129)
				local var_543_4 = arg_540_1:FormatText(var_543_3.content)

				arg_540_1.text_.text = var_543_4

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_5 = 6
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
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_8 = math.max(var_543_1, arg_540_1.talkMaxDuration)

			if var_543_0 <= arg_540_1.time_ and arg_540_1.time_ < var_543_0 + var_543_8 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_0) / var_543_8

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_0 + var_543_8 and arg_540_1.time_ < var_543_0 + var_543_8 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play936041130 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 936041130
		arg_544_1.duration_ = 7.8

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play936041131(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = arg_544_1.actors_["104402ui_story"].transform
			local var_547_1 = 0

			if var_547_1 < arg_544_1.time_ and arg_544_1.time_ <= var_547_1 + arg_547_0 then
				arg_544_1.var_.moveOldPos104402ui_story = var_547_0.localPosition

				local var_547_2 = GameObjectTools.GetOrAddComponent(var_547_0.gameObject, typeof(DynamicBoneHelper))

				if var_547_2 then
					var_547_2:EnableDynamicBone(false)
				end
			end

			local var_547_3 = 0.001

			if var_547_1 <= arg_544_1.time_ and arg_544_1.time_ < var_547_1 + var_547_3 then
				local var_547_4 = (arg_544_1.time_ - var_547_1) / var_547_3
				local var_547_5 = Vector3.New(0, -1, -5.93)

				var_547_0.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos104402ui_story, var_547_5, var_547_4)

				local var_547_6 = manager.ui.mainCamera.transform.position - var_547_0.position

				var_547_0.forward = Vector3.New(var_547_6.x, var_547_6.y, var_547_6.z)

				local var_547_7 = var_547_0.localEulerAngles

				var_547_7.z = 0
				var_547_7.x = 0
				var_547_0.localEulerAngles = var_547_7
			end

			if arg_544_1.time_ >= var_547_1 + var_547_3 and arg_544_1.time_ < var_547_1 + var_547_3 + arg_547_0 then
				var_547_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_547_8 = manager.ui.mainCamera.transform.position - var_547_0.position

				var_547_0.forward = Vector3.New(var_547_8.x, var_547_8.y, var_547_8.z)

				local var_547_9 = var_547_0.localEulerAngles

				var_547_9.z = 0
				var_547_9.x = 0
				var_547_0.localEulerAngles = var_547_9

				local var_547_10 = GameObjectTools.GetOrAddComponent(var_547_0.gameObject, typeof(DynamicBoneHelper))

				if var_547_10 then
					var_547_10:EnableDynamicBone(true)
				end
			end

			local var_547_11 = arg_544_1.actors_["104402ui_story"]
			local var_547_12 = 0

			if var_547_12 < arg_544_1.time_ and arg_544_1.time_ <= var_547_12 + arg_547_0 and not isNil(var_547_11) and arg_544_1.var_.characterEffect104402ui_story == nil then
				arg_544_1.var_.characterEffect104402ui_story = var_547_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_13 = 0.200000002980232

			if var_547_12 <= arg_544_1.time_ and arg_544_1.time_ < var_547_12 + var_547_13 and not isNil(var_547_11) then
				local var_547_14 = (arg_544_1.time_ - var_547_12) / var_547_13

				if arg_544_1.var_.characterEffect104402ui_story and not isNil(var_547_11) then
					arg_544_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_544_1.time_ >= var_547_12 + var_547_13 and arg_544_1.time_ < var_547_12 + var_547_13 + arg_547_0 and not isNil(var_547_11) and arg_544_1.var_.characterEffect104402ui_story then
				arg_544_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_547_15 = 0

			if var_547_15 < arg_544_1.time_ and arg_544_1.time_ <= var_547_15 + arg_547_0 then
				arg_544_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			local var_547_16 = 0

			if var_547_16 < arg_544_1.time_ and arg_544_1.time_ <= var_547_16 + arg_547_0 then
				arg_544_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_547_17 = 0
			local var_547_18 = 1

			if var_547_17 < arg_544_1.time_ and arg_544_1.time_ <= var_547_17 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_19 = arg_544_1:FormatText(StoryNameCfg[1367].name)

				arg_544_1.leftNameTxt_.text = var_547_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_20 = arg_544_1:GetWordFromCfg(936041130)
				local var_547_21 = arg_544_1:FormatText(var_547_20.content)

				arg_544_1.text_.text = var_547_21

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_22 = 40
				local var_547_23 = utf8.len(var_547_21)
				local var_547_24 = var_547_22 <= 0 and var_547_18 or var_547_18 * (var_547_23 / var_547_22)

				if var_547_24 > 0 and var_547_18 < var_547_24 then
					arg_544_1.talkMaxDuration = var_547_24

					if var_547_24 + var_547_17 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_24 + var_547_17
					end
				end

				arg_544_1.text_.text = var_547_21
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041130", "story_v_side_old_936041.awb") ~= 0 then
					local var_547_25 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041130", "story_v_side_old_936041.awb") / 1000

					if var_547_25 + var_547_17 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_25 + var_547_17
					end

					if var_547_20.prefab_name ~= "" and arg_544_1.actors_[var_547_20.prefab_name] ~= nil then
						local var_547_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_20.prefab_name].transform, "story_v_side_old_936041", "936041130", "story_v_side_old_936041.awb")

						arg_544_1:RecordAudio("936041130", var_547_26)
						arg_544_1:RecordAudio("936041130", var_547_26)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041130", "story_v_side_old_936041.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041130", "story_v_side_old_936041.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_27 = math.max(var_547_18, arg_544_1.talkMaxDuration)

			if var_547_17 <= arg_544_1.time_ and arg_544_1.time_ < var_547_17 + var_547_27 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_17) / var_547_27

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_17 + var_547_27 and arg_544_1.time_ < var_547_17 + var_547_27 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_544_1:InitPlayNodeList()
	end,
	Play936041131 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 936041131
		arg_548_1.duration_ = 3.93

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play936041132(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0

			if var_551_0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_0 + arg_551_0 then
				arg_548_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_1")
			end

			local var_551_1 = 0

			if var_551_1 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 then
				arg_548_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_551_2 = 0
			local var_551_3 = 0.5

			if var_551_2 < arg_548_1.time_ and arg_548_1.time_ <= var_551_2 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				local var_551_4 = arg_548_1:FormatText(StoryNameCfg[1367].name)

				arg_548_1.leftNameTxt_.text = var_551_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_5 = arg_548_1:GetWordFromCfg(936041131)
				local var_551_6 = arg_548_1:FormatText(var_551_5.content)

				arg_548_1.text_.text = var_551_6

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_7 = 20
				local var_551_8 = utf8.len(var_551_6)
				local var_551_9 = var_551_7 <= 0 and var_551_3 or var_551_3 * (var_551_8 / var_551_7)

				if var_551_9 > 0 and var_551_3 < var_551_9 then
					arg_548_1.talkMaxDuration = var_551_9

					if var_551_9 + var_551_2 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_9 + var_551_2
					end
				end

				arg_548_1.text_.text = var_551_6
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041131", "story_v_side_old_936041.awb") ~= 0 then
					local var_551_10 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041131", "story_v_side_old_936041.awb") / 1000

					if var_551_10 + var_551_2 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_10 + var_551_2
					end

					if var_551_5.prefab_name ~= "" and arg_548_1.actors_[var_551_5.prefab_name] ~= nil then
						local var_551_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_5.prefab_name].transform, "story_v_side_old_936041", "936041131", "story_v_side_old_936041.awb")

						arg_548_1:RecordAudio("936041131", var_551_11)
						arg_548_1:RecordAudio("936041131", var_551_11)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041131", "story_v_side_old_936041.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041131", "story_v_side_old_936041.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_12 = math.max(var_551_3, arg_548_1.talkMaxDuration)

			if var_551_2 <= arg_548_1.time_ and arg_548_1.time_ < var_551_2 + var_551_12 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_2) / var_551_12

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_2 + var_551_12 and arg_548_1.time_ < var_551_2 + var_551_12 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play936041132 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 936041132
		arg_552_1.duration_ = 4.1

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
			arg_552_1.auto_ = false
		end

		function arg_552_1.playNext_(arg_554_0)
			arg_552_1.onStoryFinished_()
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = arg_552_1.actors_["104402ui_story"].transform
			local var_555_1 = 0

			if var_555_1 < arg_552_1.time_ and arg_552_1.time_ <= var_555_1 + arg_555_0 then
				arg_552_1.var_.moveOldPos104402ui_story = var_555_0.localPosition

				local var_555_2 = GameObjectTools.GetOrAddComponent(var_555_0.gameObject, typeof(DynamicBoneHelper))

				if var_555_2 then
					var_555_2:EnableDynamicBone(false)
				end
			end

			local var_555_3 = 0.001

			if var_555_1 <= arg_552_1.time_ and arg_552_1.time_ < var_555_1 + var_555_3 then
				local var_555_4 = (arg_552_1.time_ - var_555_1) / var_555_3
				local var_555_5 = Vector3.New(0, -1, -5.93)

				var_555_0.localPosition = Vector3.Lerp(arg_552_1.var_.moveOldPos104402ui_story, var_555_5, var_555_4)

				local var_555_6 = manager.ui.mainCamera.transform.position - var_555_0.position

				var_555_0.forward = Vector3.New(var_555_6.x, var_555_6.y, var_555_6.z)

				local var_555_7 = var_555_0.localEulerAngles

				var_555_7.z = 0
				var_555_7.x = 0
				var_555_0.localEulerAngles = var_555_7
			end

			if arg_552_1.time_ >= var_555_1 + var_555_3 and arg_552_1.time_ < var_555_1 + var_555_3 + arg_555_0 then
				var_555_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_555_8 = manager.ui.mainCamera.transform.position - var_555_0.position

				var_555_0.forward = Vector3.New(var_555_8.x, var_555_8.y, var_555_8.z)

				local var_555_9 = var_555_0.localEulerAngles

				var_555_9.z = 0
				var_555_9.x = 0
				var_555_0.localEulerAngles = var_555_9

				local var_555_10 = GameObjectTools.GetOrAddComponent(var_555_0.gameObject, typeof(DynamicBoneHelper))

				if var_555_10 then
					var_555_10:EnableDynamicBone(true)
				end
			end

			local var_555_11 = 0

			if var_555_11 < arg_552_1.time_ and arg_552_1.time_ <= var_555_11 + arg_555_0 then
				arg_552_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402actionlink/104402action486")
			end

			local var_555_12 = 0

			if var_555_12 < arg_552_1.time_ and arg_552_1.time_ <= var_555_12 + arg_555_0 then
				arg_552_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_555_13 = 0
			local var_555_14 = 0.45

			if var_555_13 < arg_552_1.time_ and arg_552_1.time_ <= var_555_13 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_15 = arg_552_1:FormatText(StoryNameCfg[1367].name)

				arg_552_1.leftNameTxt_.text = var_555_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_16 = arg_552_1:GetWordFromCfg(936041132)
				local var_555_17 = arg_552_1:FormatText(var_555_16.content)

				arg_552_1.text_.text = var_555_17

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_18 = 18
				local var_555_19 = utf8.len(var_555_17)
				local var_555_20 = var_555_18 <= 0 and var_555_14 or var_555_14 * (var_555_19 / var_555_18)

				if var_555_20 > 0 and var_555_14 < var_555_20 then
					arg_552_1.talkMaxDuration = var_555_20

					if var_555_20 + var_555_13 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_20 + var_555_13
					end
				end

				arg_552_1.text_.text = var_555_17
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041132", "story_v_side_old_936041.awb") ~= 0 then
					local var_555_21 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041132", "story_v_side_old_936041.awb") / 1000

					if var_555_21 + var_555_13 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_21 + var_555_13
					end

					if var_555_16.prefab_name ~= "" and arg_552_1.actors_[var_555_16.prefab_name] ~= nil then
						local var_555_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_16.prefab_name].transform, "story_v_side_old_936041", "936041132", "story_v_side_old_936041.awb")

						arg_552_1:RecordAudio("936041132", var_555_22)
						arg_552_1:RecordAudio("936041132", var_555_22)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041132", "story_v_side_old_936041.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041132", "story_v_side_old_936041.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_23 = math.max(var_555_14, arg_552_1.talkMaxDuration)

			if var_555_13 <= arg_552_1.time_ and arg_552_1.time_ < var_555_13 + var_555_23 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_13) / var_555_23

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_13 + var_555_23 and arg_552_1.time_ < var_555_13 + var_555_23 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_552_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/X206_i",
		"SofdecAsset/story/story_936041001.usm",
		"TextureConfig/Background/X206_g",
		"TextureConfig/Background/ST15a",
		"TextureConfig/Background/SP93601",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST2201",
		"TextureConfig/Background/H08f"
	},
	voices = {
		"story_v_side_old_936041.awb"
	},
	skipMarkers = {
		936041006
	}
}
