return {
	Play426041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 426041001
		arg_1_1.duration_ = 15.1

		local var_1_0 = {
			zh = 9.833,
			ja = 15.1
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
				arg_1_0:Play426041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2007a"

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
				local var_4_5 = arg_1_1.bgs_.ST2007a

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
					if iter_4_0 ~= "ST2007a" then
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

			local var_4_24 = "6148ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["6148ui_story"].transform
			local var_4_30 = 2

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos6148ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, -0.985, -6)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos6148ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.985, -6)

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

			local var_4_40 = arg_1_1.actors_["6148ui_story"]
			local var_4_41 = 2

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect6148ui_story == nil then
				arg_1_1.var_.characterEffect6148ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect6148ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect6148ui_story then
				arg_1_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_4_44 = 2

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_4_45 = 2

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
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

			local var_4_52 = 0.433333333333333
			local var_4_53 = 1

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_54 = "play"
				local var_4_55 = "music"

				arg_1_1:AudioAction(var_4_54, var_4_55, "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet.awb")

				local var_4_56 = ""
				local var_4_57 = manager.audio:GetAudioName("bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet")

				if var_4_57 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_57 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_57

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_57
						arg_1_1.bgmTxt2_.text = var_4_57
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

			local var_4_58 = 0.133333333333333
			local var_4_59 = 1

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				local var_4_60 = "play"
				local var_4_61 = "effect"

				arg_1_1:AudioAction(var_4_60, var_4_61, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_62 = 2
			local var_4_63 = 0.85

			if var_4_62 < arg_1_1.time_ and arg_1_1.time_ <= var_4_62 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_64 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_64:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_65 = arg_1_1:FormatText(StoryNameCfg[1488].name)

				arg_1_1.leftNameTxt_.text = var_4_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_66 = arg_1_1:GetWordFromCfg(426041001)
				local var_4_67 = arg_1_1:FormatText(var_4_66.content)

				arg_1_1.text_.text = var_4_67

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_68 = 34
				local var_4_69 = utf8.len(var_4_67)
				local var_4_70 = var_4_68 <= 0 and var_4_63 or var_4_63 * (var_4_69 / var_4_68)

				if var_4_70 > 0 and var_4_63 < var_4_70 then
					arg_1_1.talkMaxDuration = var_4_70
					var_4_62 = var_4_62 + 0.3

					if var_4_70 + var_4_62 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_62
					end
				end

				arg_1_1.text_.text = var_4_67
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041001", "story_v_out_426041.awb") ~= 0 then
					local var_4_71 = manager.audio:GetVoiceLength("story_v_out_426041", "426041001", "story_v_out_426041.awb") / 1000

					if var_4_71 + var_4_62 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_71 + var_4_62
					end

					if var_4_66.prefab_name ~= "" and arg_1_1.actors_[var_4_66.prefab_name] ~= nil then
						local var_4_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_66.prefab_name].transform, "story_v_out_426041", "426041001", "story_v_out_426041.awb")

						arg_1_1:RecordAudio("426041001", var_4_72)
						arg_1_1:RecordAudio("426041001", var_4_72)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_426041", "426041001", "story_v_out_426041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_426041", "426041001", "story_v_out_426041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_73 = var_4_62 + 0.3
			local var_4_74 = math.max(var_4_63, arg_1_1.talkMaxDuration)

			if var_4_73 <= arg_1_1.time_ and arg_1_1.time_ < var_4_73 + var_4_74 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_73) / var_4_74

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_73 + var_4_74 and arg_1_1.time_ < var_4_73 + var_4_74 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play426041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 426041002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play426041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["6148ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect6148ui_story == nil then
				arg_9_1.var_.characterEffect6148ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect6148ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_9_1.var_.characterEffect6148ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect6148ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_9_1.var_.characterEffect6148ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 0.475

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

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_9 = arg_9_1:GetWordFromCfg(426041002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 19
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
	Play426041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 426041003
		arg_13_1.duration_ = 3.37

		local var_13_0 = {
			zh = 2.066,
			ja = 3.366
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
				arg_13_0:Play426041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["6148ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos6148ui_story = var_16_0.localPosition

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0.gameObject, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end
			end

			local var_16_3 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_3 then
				local var_16_4 = (arg_13_1.time_ - var_16_1) / var_16_3
				local var_16_5 = Vector3.New(0, -0.985, -6)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos6148ui_story, var_16_5, var_16_4)

				local var_16_6 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_6.x, var_16_6.y, var_16_6.z)

				local var_16_7 = var_16_0.localEulerAngles

				var_16_7.z = 0
				var_16_7.x = 0
				var_16_0.localEulerAngles = var_16_7
			end

			if arg_13_1.time_ >= var_16_1 + var_16_3 and arg_13_1.time_ < var_16_1 + var_16_3 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_16_8 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_8.x, var_16_8.y, var_16_8.z)

				local var_16_9 = var_16_0.localEulerAngles

				var_16_9.z = 0
				var_16_9.x = 0
				var_16_0.localEulerAngles = var_16_9

				local var_16_10 = GameObjectTools.GetOrAddComponent(var_16_0.gameObject, typeof(DynamicBoneHelper))

				if var_16_10 then
					var_16_10:EnableDynamicBone(true)
				end
			end

			local var_16_11 = arg_13_1.actors_["6148ui_story"]
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.characterEffect6148ui_story == nil then
				arg_13_1.var_.characterEffect6148ui_story = var_16_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_13 = 0.200000002980232

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_13 and not isNil(var_16_11) then
				local var_16_14 = (arg_13_1.time_ - var_16_12) / var_16_13

				if arg_13_1.var_.characterEffect6148ui_story and not isNil(var_16_11) then
					arg_13_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_12 + var_16_13 and arg_13_1.time_ < var_16_12 + var_16_13 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.characterEffect6148ui_story then
				arg_13_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_16_16 = 0
			local var_16_17 = 0.3

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_18 = arg_13_1:FormatText(StoryNameCfg[1488].name)

				arg_13_1.leftNameTxt_.text = var_16_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_19 = arg_13_1:GetWordFromCfg(426041003)
				local var_16_20 = arg_13_1:FormatText(var_16_19.content)

				arg_13_1.text_.text = var_16_20

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_21 = 12
				local var_16_22 = utf8.len(var_16_20)
				local var_16_23 = var_16_21 <= 0 and var_16_17 or var_16_17 * (var_16_22 / var_16_21)

				if var_16_23 > 0 and var_16_17 < var_16_23 then
					arg_13_1.talkMaxDuration = var_16_23

					if var_16_23 + var_16_16 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_16
					end
				end

				arg_13_1.text_.text = var_16_20
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041003", "story_v_out_426041.awb") ~= 0 then
					local var_16_24 = manager.audio:GetVoiceLength("story_v_out_426041", "426041003", "story_v_out_426041.awb") / 1000

					if var_16_24 + var_16_16 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_24 + var_16_16
					end

					if var_16_19.prefab_name ~= "" and arg_13_1.actors_[var_16_19.prefab_name] ~= nil then
						local var_16_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_19.prefab_name].transform, "story_v_out_426041", "426041003", "story_v_out_426041.awb")

						arg_13_1:RecordAudio("426041003", var_16_25)
						arg_13_1:RecordAudio("426041003", var_16_25)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_426041", "426041003", "story_v_out_426041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_426041", "426041003", "story_v_out_426041.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_26 = math.max(var_16_17, arg_13_1.talkMaxDuration)

			if var_16_16 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_26 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_16) / var_16_26

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_16 + var_16_26 and arg_13_1.time_ < var_16_16 + var_16_26 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 426041004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play426041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["6148ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos6148ui_story = var_20_0.localPosition

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0.gameObject, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end
			end

			local var_20_3 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_3 then
				local var_20_4 = (arg_17_1.time_ - var_20_1) / var_20_3
				local var_20_5 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos6148ui_story, var_20_5, var_20_4)

				local var_20_6 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_6.x, var_20_6.y, var_20_6.z)

				local var_20_7 = var_20_0.localEulerAngles

				var_20_7.z = 0
				var_20_7.x = 0
				var_20_0.localEulerAngles = var_20_7
			end

			if arg_17_1.time_ >= var_20_1 + var_20_3 and arg_17_1.time_ < var_20_1 + var_20_3 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, 100, 0)

				local var_20_8 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_8.x, var_20_8.y, var_20_8.z)

				local var_20_9 = var_20_0.localEulerAngles

				var_20_9.z = 0
				var_20_9.x = 0
				var_20_0.localEulerAngles = var_20_9

				local var_20_10 = GameObjectTools.GetOrAddComponent(var_20_0.gameObject, typeof(DynamicBoneHelper))

				if var_20_10 then
					var_20_10:EnableDynamicBone(true)
				end
			end

			local var_20_11 = arg_17_1.actors_["6148ui_story"]
			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.characterEffect6148ui_story == nil then
				arg_17_1.var_.characterEffect6148ui_story = var_20_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_13 = 0.200000002980232

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_13 and not isNil(var_20_11) then
				local var_20_14 = (arg_17_1.time_ - var_20_12) / var_20_13

				if arg_17_1.var_.characterEffect6148ui_story and not isNil(var_20_11) then
					local var_20_15 = Mathf.Lerp(0, 0.5, var_20_14)

					arg_17_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_17_1.var_.characterEffect6148ui_story.fillRatio = var_20_15
				end
			end

			if arg_17_1.time_ >= var_20_12 + var_20_13 and arg_17_1.time_ < var_20_12 + var_20_13 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.characterEffect6148ui_story then
				local var_20_16 = 0.5

				arg_17_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_17_1.var_.characterEffect6148ui_story.fillRatio = var_20_16
			end

			local var_20_17 = 0
			local var_20_18 = 1.175

			if var_20_17 < arg_17_1.time_ and arg_17_1.time_ <= var_20_17 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_19 = arg_17_1:GetWordFromCfg(426041004)
				local var_20_20 = arg_17_1:FormatText(var_20_19.content)

				arg_17_1.text_.text = var_20_20

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_21 = 47
				local var_20_22 = utf8.len(var_20_20)
				local var_20_23 = var_20_21 <= 0 and var_20_18 or var_20_18 * (var_20_22 / var_20_21)

				if var_20_23 > 0 and var_20_18 < var_20_23 then
					arg_17_1.talkMaxDuration = var_20_23

					if var_20_23 + var_20_17 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_17
					end
				end

				arg_17_1.text_.text = var_20_20
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_24 = math.max(var_20_18, arg_17_1.talkMaxDuration)

			if var_20_17 <= arg_17_1.time_ and arg_17_1.time_ < var_20_17 + var_20_24 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_17) / var_20_24

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_17 + var_20_24 and arg_17_1.time_ < var_20_17 + var_20_24 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 426041005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play426041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.125

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(426041005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 5
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_8 and arg_21_1.time_ < var_24_0 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play426041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 426041006
		arg_25_1.duration_ = 6.3

		local var_25_0 = {
			zh = 2.766,
			ja = 6.3
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play426041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["6148ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos6148ui_story = var_28_0.localPosition

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0.gameObject, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end
			end

			local var_28_3 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_3 then
				local var_28_4 = (arg_25_1.time_ - var_28_1) / var_28_3
				local var_28_5 = Vector3.New(0, -0.985, -6)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos6148ui_story, var_28_5, var_28_4)

				local var_28_6 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_6.x, var_28_6.y, var_28_6.z)

				local var_28_7 = var_28_0.localEulerAngles

				var_28_7.z = 0
				var_28_7.x = 0
				var_28_0.localEulerAngles = var_28_7
			end

			if arg_25_1.time_ >= var_28_1 + var_28_3 and arg_25_1.time_ < var_28_1 + var_28_3 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_28_8 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_8.x, var_28_8.y, var_28_8.z)

				local var_28_9 = var_28_0.localEulerAngles

				var_28_9.z = 0
				var_28_9.x = 0
				var_28_0.localEulerAngles = var_28_9

				local var_28_10 = GameObjectTools.GetOrAddComponent(var_28_0.gameObject, typeof(DynamicBoneHelper))

				if var_28_10 then
					var_28_10:EnableDynamicBone(true)
				end
			end

			local var_28_11 = arg_25_1.actors_["6148ui_story"]
			local var_28_12 = 0

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.characterEffect6148ui_story == nil then
				arg_25_1.var_.characterEffect6148ui_story = var_28_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_13 = 0.200000002980232

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_13 and not isNil(var_28_11) then
				local var_28_14 = (arg_25_1.time_ - var_28_12) / var_28_13

				if arg_25_1.var_.characterEffect6148ui_story and not isNil(var_28_11) then
					arg_25_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_12 + var_28_13 and arg_25_1.time_ < var_28_12 + var_28_13 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.characterEffect6148ui_story then
				arg_25_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_28_17 = 0
			local var_28_18 = 0.35

			if var_28_17 < arg_25_1.time_ and arg_25_1.time_ <= var_28_17 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_19 = arg_25_1:FormatText(StoryNameCfg[1488].name)

				arg_25_1.leftNameTxt_.text = var_28_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_20 = arg_25_1:GetWordFromCfg(426041006)
				local var_28_21 = arg_25_1:FormatText(var_28_20.content)

				arg_25_1.text_.text = var_28_21

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_22 = 14
				local var_28_23 = utf8.len(var_28_21)
				local var_28_24 = var_28_22 <= 0 and var_28_18 or var_28_18 * (var_28_23 / var_28_22)

				if var_28_24 > 0 and var_28_18 < var_28_24 then
					arg_25_1.talkMaxDuration = var_28_24

					if var_28_24 + var_28_17 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_24 + var_28_17
					end
				end

				arg_25_1.text_.text = var_28_21
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041006", "story_v_out_426041.awb") ~= 0 then
					local var_28_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041006", "story_v_out_426041.awb") / 1000

					if var_28_25 + var_28_17 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_25 + var_28_17
					end

					if var_28_20.prefab_name ~= "" and arg_25_1.actors_[var_28_20.prefab_name] ~= nil then
						local var_28_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_20.prefab_name].transform, "story_v_out_426041", "426041006", "story_v_out_426041.awb")

						arg_25_1:RecordAudio("426041006", var_28_26)
						arg_25_1:RecordAudio("426041006", var_28_26)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_426041", "426041006", "story_v_out_426041.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_426041", "426041006", "story_v_out_426041.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_27 = math.max(var_28_18, arg_25_1.talkMaxDuration)

			if var_28_17 <= arg_25_1.time_ and arg_25_1.time_ < var_28_17 + var_28_27 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_17) / var_28_27

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_17 + var_28_27 and arg_25_1.time_ < var_28_17 + var_28_27 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 426041007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play426041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["6148ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect6148ui_story == nil then
				arg_29_1.var_.characterEffect6148ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect6148ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_29_1.var_.characterEffect6148ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect6148ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_29_1.var_.characterEffect6148ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 0.25

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_9 = arg_29_1:GetWordFromCfg(426041007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 10
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_7 or var_32_7 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_7 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_14 and arg_29_1.time_ < var_32_6 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play426041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 426041008
		arg_33_1.duration_ = 5.5

		local var_33_0 = {
			zh = 5.233,
			ja = 5.5
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
				arg_33_0:Play426041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["6148ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos6148ui_story = var_36_0.localPosition

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0.gameObject, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end
			end

			local var_36_3 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_3 then
				local var_36_4 = (arg_33_1.time_ - var_36_1) / var_36_3
				local var_36_5 = Vector3.New(0, -0.985, -6)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos6148ui_story, var_36_5, var_36_4)

				local var_36_6 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_6.x, var_36_6.y, var_36_6.z)

				local var_36_7 = var_36_0.localEulerAngles

				var_36_7.z = 0
				var_36_7.x = 0
				var_36_0.localEulerAngles = var_36_7
			end

			if arg_33_1.time_ >= var_36_1 + var_36_3 and arg_33_1.time_ < var_36_1 + var_36_3 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_36_8 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_8.x, var_36_8.y, var_36_8.z)

				local var_36_9 = var_36_0.localEulerAngles

				var_36_9.z = 0
				var_36_9.x = 0
				var_36_0.localEulerAngles = var_36_9

				local var_36_10 = GameObjectTools.GetOrAddComponent(var_36_0.gameObject, typeof(DynamicBoneHelper))

				if var_36_10 then
					var_36_10:EnableDynamicBone(true)
				end
			end

			local var_36_11 = arg_33_1.actors_["6148ui_story"]
			local var_36_12 = 0

			if var_36_12 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 and not isNil(var_36_11) and arg_33_1.var_.characterEffect6148ui_story == nil then
				arg_33_1.var_.characterEffect6148ui_story = var_36_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_13 = 0.200000002980232

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_13 and not isNil(var_36_11) then
				local var_36_14 = (arg_33_1.time_ - var_36_12) / var_36_13

				if arg_33_1.var_.characterEffect6148ui_story and not isNil(var_36_11) then
					arg_33_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_12 + var_36_13 and arg_33_1.time_ < var_36_12 + var_36_13 + arg_36_0 and not isNil(var_36_11) and arg_33_1.var_.characterEffect6148ui_story then
				arg_33_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action3_1")
			end

			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_36_17 = 0
			local var_36_18 = 0.625

			if var_36_17 < arg_33_1.time_ and arg_33_1.time_ <= var_36_17 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_19 = arg_33_1:FormatText(StoryNameCfg[1488].name)

				arg_33_1.leftNameTxt_.text = var_36_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_20 = arg_33_1:GetWordFromCfg(426041008)
				local var_36_21 = arg_33_1:FormatText(var_36_20.content)

				arg_33_1.text_.text = var_36_21

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_22 = 25
				local var_36_23 = utf8.len(var_36_21)
				local var_36_24 = var_36_22 <= 0 and var_36_18 or var_36_18 * (var_36_23 / var_36_22)

				if var_36_24 > 0 and var_36_18 < var_36_24 then
					arg_33_1.talkMaxDuration = var_36_24

					if var_36_24 + var_36_17 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_24 + var_36_17
					end
				end

				arg_33_1.text_.text = var_36_21
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041008", "story_v_out_426041.awb") ~= 0 then
					local var_36_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041008", "story_v_out_426041.awb") / 1000

					if var_36_25 + var_36_17 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_25 + var_36_17
					end

					if var_36_20.prefab_name ~= "" and arg_33_1.actors_[var_36_20.prefab_name] ~= nil then
						local var_36_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_20.prefab_name].transform, "story_v_out_426041", "426041008", "story_v_out_426041.awb")

						arg_33_1:RecordAudio("426041008", var_36_26)
						arg_33_1:RecordAudio("426041008", var_36_26)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_426041", "426041008", "story_v_out_426041.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_426041", "426041008", "story_v_out_426041.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_27 = math.max(var_36_18, arg_33_1.talkMaxDuration)

			if var_36_17 <= arg_33_1.time_ and arg_33_1.time_ < var_36_17 + var_36_27 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_17) / var_36_27

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_17 + var_36_27 and arg_33_1.time_ < var_36_17 + var_36_27 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play426041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 426041009
		arg_37_1.duration_ = 10.5

		local var_37_0 = {
			zh = 4.733,
			ja = 10.5
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
				arg_37_0:Play426041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["6148ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos6148ui_story = var_40_0.localPosition

				local var_40_2 = GameObjectTools.GetOrAddComponent(var_40_0.gameObject, typeof(DynamicBoneHelper))

				if var_40_2 then
					var_40_2:EnableDynamicBone(false)
				end
			end

			local var_40_3 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_3 then
				local var_40_4 = (arg_37_1.time_ - var_40_1) / var_40_3
				local var_40_5 = Vector3.New(0, -0.985, -6)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos6148ui_story, var_40_5, var_40_4)

				local var_40_6 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_6.x, var_40_6.y, var_40_6.z)

				local var_40_7 = var_40_0.localEulerAngles

				var_40_7.z = 0
				var_40_7.x = 0
				var_40_0.localEulerAngles = var_40_7
			end

			if arg_37_1.time_ >= var_40_1 + var_40_3 and arg_37_1.time_ < var_40_1 + var_40_3 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_40_8 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_8.x, var_40_8.y, var_40_8.z)

				local var_40_9 = var_40_0.localEulerAngles

				var_40_9.z = 0
				var_40_9.x = 0
				var_40_0.localEulerAngles = var_40_9

				local var_40_10 = GameObjectTools.GetOrAddComponent(var_40_0.gameObject, typeof(DynamicBoneHelper))

				if var_40_10 then
					var_40_10:EnableDynamicBone(true)
				end
			end

			local var_40_11 = 0

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action3_2")
			end

			local var_40_12 = 0

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_40_13 = 0
			local var_40_14 = 0.525

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_15 = arg_37_1:FormatText(StoryNameCfg[1488].name)

				arg_37_1.leftNameTxt_.text = var_40_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_16 = arg_37_1:GetWordFromCfg(426041009)
				local var_40_17 = arg_37_1:FormatText(var_40_16.content)

				arg_37_1.text_.text = var_40_17

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_18 = 21
				local var_40_19 = utf8.len(var_40_17)
				local var_40_20 = var_40_18 <= 0 and var_40_14 or var_40_14 * (var_40_19 / var_40_18)

				if var_40_20 > 0 and var_40_14 < var_40_20 then
					arg_37_1.talkMaxDuration = var_40_20

					if var_40_20 + var_40_13 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_13
					end
				end

				arg_37_1.text_.text = var_40_17
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041009", "story_v_out_426041.awb") ~= 0 then
					local var_40_21 = manager.audio:GetVoiceLength("story_v_out_426041", "426041009", "story_v_out_426041.awb") / 1000

					if var_40_21 + var_40_13 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_21 + var_40_13
					end

					if var_40_16.prefab_name ~= "" and arg_37_1.actors_[var_40_16.prefab_name] ~= nil then
						local var_40_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_16.prefab_name].transform, "story_v_out_426041", "426041009", "story_v_out_426041.awb")

						arg_37_1:RecordAudio("426041009", var_40_22)
						arg_37_1:RecordAudio("426041009", var_40_22)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_426041", "426041009", "story_v_out_426041.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_426041", "426041009", "story_v_out_426041.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_23 = math.max(var_40_14, arg_37_1.talkMaxDuration)

			if var_40_13 <= arg_37_1.time_ and arg_37_1.time_ < var_40_13 + var_40_23 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_13) / var_40_23

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_13 + var_40_23 and arg_37_1.time_ < var_40_13 + var_40_23 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play426041010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 426041010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play426041011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["6148ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos6148ui_story = var_44_0.localPosition

				local var_44_2 = GameObjectTools.GetOrAddComponent(var_44_0.gameObject, typeof(DynamicBoneHelper))

				if var_44_2 then
					var_44_2:EnableDynamicBone(false)
				end
			end

			local var_44_3 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_3 then
				local var_44_4 = (arg_41_1.time_ - var_44_1) / var_44_3
				local var_44_5 = Vector3.New(0, 100, 0)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos6148ui_story, var_44_5, var_44_4)

				local var_44_6 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_6.x, var_44_6.y, var_44_6.z)

				local var_44_7 = var_44_0.localEulerAngles

				var_44_7.z = 0
				var_44_7.x = 0
				var_44_0.localEulerAngles = var_44_7
			end

			if arg_41_1.time_ >= var_44_1 + var_44_3 and arg_41_1.time_ < var_44_1 + var_44_3 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, 100, 0)

				local var_44_8 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_8.x, var_44_8.y, var_44_8.z)

				local var_44_9 = var_44_0.localEulerAngles

				var_44_9.z = 0
				var_44_9.x = 0
				var_44_0.localEulerAngles = var_44_9

				local var_44_10 = GameObjectTools.GetOrAddComponent(var_44_0.gameObject, typeof(DynamicBoneHelper))

				if var_44_10 then
					var_44_10:EnableDynamicBone(true)
				end
			end

			local var_44_11 = arg_41_1.actors_["6148ui_story"]
			local var_44_12 = 0

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 and not isNil(var_44_11) and arg_41_1.var_.characterEffect6148ui_story == nil then
				arg_41_1.var_.characterEffect6148ui_story = var_44_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_13 = 0.200000002980232

			if var_44_12 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_13 and not isNil(var_44_11) then
				local var_44_14 = (arg_41_1.time_ - var_44_12) / var_44_13

				if arg_41_1.var_.characterEffect6148ui_story and not isNil(var_44_11) then
					local var_44_15 = Mathf.Lerp(0, 0.5, var_44_14)

					arg_41_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_41_1.var_.characterEffect6148ui_story.fillRatio = var_44_15
				end
			end

			if arg_41_1.time_ >= var_44_12 + var_44_13 and arg_41_1.time_ < var_44_12 + var_44_13 + arg_44_0 and not isNil(var_44_11) and arg_41_1.var_.characterEffect6148ui_story then
				local var_44_16 = 0.5

				arg_41_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_41_1.var_.characterEffect6148ui_story.fillRatio = var_44_16
			end

			local var_44_17 = 0.133333333333333
			local var_44_18 = 1

			if var_44_17 < arg_41_1.time_ and arg_41_1.time_ <= var_44_17 + arg_44_0 then
				local var_44_19 = "play"
				local var_44_20 = "effect"

				arg_41_1:AudioAction(var_44_19, var_44_20, "se_story_150", "se_story_150_rummage", "")
			end

			local var_44_21 = 0
			local var_44_22 = 0.875

			if var_44_21 < arg_41_1.time_ and arg_41_1.time_ <= var_44_21 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_23 = arg_41_1:GetWordFromCfg(426041010)
				local var_44_24 = arg_41_1:FormatText(var_44_23.content)

				arg_41_1.text_.text = var_44_24

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_25 = 35
				local var_44_26 = utf8.len(var_44_24)
				local var_44_27 = var_44_25 <= 0 and var_44_22 or var_44_22 * (var_44_26 / var_44_25)

				if var_44_27 > 0 and var_44_22 < var_44_27 then
					arg_41_1.talkMaxDuration = var_44_27

					if var_44_27 + var_44_21 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_27 + var_44_21
					end
				end

				arg_41_1.text_.text = var_44_24
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_28 = math.max(var_44_22, arg_41_1.talkMaxDuration)

			if var_44_21 <= arg_41_1.time_ and arg_41_1.time_ < var_44_21 + var_44_28 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_21) / var_44_28

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_21 + var_44_28 and arg_41_1.time_ < var_44_21 + var_44_28 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play426041011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 426041011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play426041012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.4
			local var_48_1 = 1

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				local var_48_2 = "play"
				local var_48_3 = "effect"

				arg_45_1:AudioAction(var_48_2, var_48_3, "se_story_150", "se_story_150_put", "")
			end

			local var_48_4 = 0
			local var_48_5 = 0.75

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(426041011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_8 = 30
				local var_48_9 = utf8.len(var_48_7)
				local var_48_10 = var_48_8 <= 0 and var_48_5 or var_48_5 * (var_48_9 / var_48_8)

				if var_48_10 > 0 and var_48_5 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_11 and arg_45_1.time_ < var_48_4 + var_48_11 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play426041012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 426041012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play426041013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.45

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

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(426041012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 18
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
	Play426041013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 426041013
		arg_53_1.duration_ = 12.9

		local var_53_0 = {
			zh = 9.266,
			ja = 12.9
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
				arg_53_0:Play426041014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["6148ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos6148ui_story = var_56_0.localPosition

				local var_56_2 = GameObjectTools.GetOrAddComponent(var_56_0.gameObject, typeof(DynamicBoneHelper))

				if var_56_2 then
					var_56_2:EnableDynamicBone(false)
				end
			end

			local var_56_3 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_3 then
				local var_56_4 = (arg_53_1.time_ - var_56_1) / var_56_3
				local var_56_5 = Vector3.New(0, -0.985, -6)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos6148ui_story, var_56_5, var_56_4)

				local var_56_6 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_6.x, var_56_6.y, var_56_6.z)

				local var_56_7 = var_56_0.localEulerAngles

				var_56_7.z = 0
				var_56_7.x = 0
				var_56_0.localEulerAngles = var_56_7
			end

			if arg_53_1.time_ >= var_56_1 + var_56_3 and arg_53_1.time_ < var_56_1 + var_56_3 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_56_8 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_8.x, var_56_8.y, var_56_8.z)

				local var_56_9 = var_56_0.localEulerAngles

				var_56_9.z = 0
				var_56_9.x = 0
				var_56_0.localEulerAngles = var_56_9

				local var_56_10 = GameObjectTools.GetOrAddComponent(var_56_0.gameObject, typeof(DynamicBoneHelper))

				if var_56_10 then
					var_56_10:EnableDynamicBone(true)
				end
			end

			local var_56_11 = arg_53_1.actors_["6148ui_story"]
			local var_56_12 = 0

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.characterEffect6148ui_story == nil then
				arg_53_1.var_.characterEffect6148ui_story = var_56_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_13 = 0.200000002980232

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_13 and not isNil(var_56_11) then
				local var_56_14 = (arg_53_1.time_ - var_56_12) / var_56_13

				if arg_53_1.var_.characterEffect6148ui_story and not isNil(var_56_11) then
					arg_53_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_12 + var_56_13 and arg_53_1.time_ < var_56_12 + var_56_13 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.characterEffect6148ui_story then
				arg_53_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_56_15 = 0

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_56_17 = 0
			local var_56_18 = 1.15

			if var_56_17 < arg_53_1.time_ and arg_53_1.time_ <= var_56_17 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_19 = arg_53_1:FormatText(StoryNameCfg[1488].name)

				arg_53_1.leftNameTxt_.text = var_56_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_20 = arg_53_1:GetWordFromCfg(426041013)
				local var_56_21 = arg_53_1:FormatText(var_56_20.content)

				arg_53_1.text_.text = var_56_21

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_22 = 46
				local var_56_23 = utf8.len(var_56_21)
				local var_56_24 = var_56_22 <= 0 and var_56_18 or var_56_18 * (var_56_23 / var_56_22)

				if var_56_24 > 0 and var_56_18 < var_56_24 then
					arg_53_1.talkMaxDuration = var_56_24

					if var_56_24 + var_56_17 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_24 + var_56_17
					end
				end

				arg_53_1.text_.text = var_56_21
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041013", "story_v_out_426041.awb") ~= 0 then
					local var_56_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041013", "story_v_out_426041.awb") / 1000

					if var_56_25 + var_56_17 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_25 + var_56_17
					end

					if var_56_20.prefab_name ~= "" and arg_53_1.actors_[var_56_20.prefab_name] ~= nil then
						local var_56_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_20.prefab_name].transform, "story_v_out_426041", "426041013", "story_v_out_426041.awb")

						arg_53_1:RecordAudio("426041013", var_56_26)
						arg_53_1:RecordAudio("426041013", var_56_26)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_426041", "426041013", "story_v_out_426041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_426041", "426041013", "story_v_out_426041.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_27 = math.max(var_56_18, arg_53_1.talkMaxDuration)

			if var_56_17 <= arg_53_1.time_ and arg_53_1.time_ < var_56_17 + var_56_27 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_17) / var_56_27

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_17 + var_56_27 and arg_53_1.time_ < var_56_17 + var_56_27 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play426041014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 426041014
		arg_57_1.duration_ = 11.83

		local var_57_0 = {
			zh = 8.833,
			ja = 11.833
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
				arg_57_0:Play426041015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.15

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[1488].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(426041014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041014", "story_v_out_426041.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_426041", "426041014", "story_v_out_426041.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_426041", "426041014", "story_v_out_426041.awb")

						arg_57_1:RecordAudio("426041014", var_60_9)
						arg_57_1:RecordAudio("426041014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_426041", "426041014", "story_v_out_426041.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_426041", "426041014", "story_v_out_426041.awb")
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
	Play426041015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 426041015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play426041016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["6148ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect6148ui_story == nil then
				arg_61_1.var_.characterEffect6148ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect6148ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_61_1.var_.characterEffect6148ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect6148ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_61_1.var_.characterEffect6148ui_story.fillRatio = var_64_5
			end

			local var_64_6 = 0
			local var_64_7 = 0.675

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[7].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_9 = arg_61_1:GetWordFromCfg(426041015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 27
				local var_64_12 = utf8.len(var_64_10)
				local var_64_13 = var_64_11 <= 0 and var_64_7 or var_64_7 * (var_64_12 / var_64_11)

				if var_64_13 > 0 and var_64_7 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_14 and arg_61_1.time_ < var_64_6 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play426041016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 426041016
		arg_65_1.duration_ = 12.27

		local var_65_0 = {
			zh = 7.3,
			ja = 12.266
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play426041017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["6148ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect6148ui_story == nil then
				arg_65_1.var_.characterEffect6148ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect6148ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect6148ui_story then
				arg_65_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_68_4 = 0

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_68_5 = 0
			local var_68_6 = 0.9

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_7 = arg_65_1:FormatText(StoryNameCfg[1488].name)

				arg_65_1.leftNameTxt_.text = var_68_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(426041016)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 36
				local var_68_11 = utf8.len(var_68_9)
				local var_68_12 = var_68_10 <= 0 and var_68_6 or var_68_6 * (var_68_11 / var_68_10)

				if var_68_12 > 0 and var_68_6 < var_68_12 then
					arg_65_1.talkMaxDuration = var_68_12

					if var_68_12 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041016", "story_v_out_426041.awb") ~= 0 then
					local var_68_13 = manager.audio:GetVoiceLength("story_v_out_426041", "426041016", "story_v_out_426041.awb") / 1000

					if var_68_13 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_5
					end

					if var_68_8.prefab_name ~= "" and arg_65_1.actors_[var_68_8.prefab_name] ~= nil then
						local var_68_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_8.prefab_name].transform, "story_v_out_426041", "426041016", "story_v_out_426041.awb")

						arg_65_1:RecordAudio("426041016", var_68_14)
						arg_65_1:RecordAudio("426041016", var_68_14)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_426041", "426041016", "story_v_out_426041.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_426041", "426041016", "story_v_out_426041.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_15 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_15 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_15

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_15 and arg_65_1.time_ < var_68_5 + var_68_15 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play426041017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 426041017
		arg_69_1.duration_ = 4.57

		local var_69_0 = {
			zh = 3.166,
			ja = 4.566
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
				arg_69_0:Play426041018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_72_1 = 0
			local var_72_2 = 0.475

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_3 = arg_69_1:FormatText(StoryNameCfg[1488].name)

				arg_69_1.leftNameTxt_.text = var_72_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(426041017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 19
				local var_72_7 = utf8.len(var_72_5)
				local var_72_8 = var_72_6 <= 0 and var_72_2 or var_72_2 * (var_72_7 / var_72_6)

				if var_72_8 > 0 and var_72_2 < var_72_8 then
					arg_69_1.talkMaxDuration = var_72_8

					if var_72_8 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041017", "story_v_out_426041.awb") ~= 0 then
					local var_72_9 = manager.audio:GetVoiceLength("story_v_out_426041", "426041017", "story_v_out_426041.awb") / 1000

					if var_72_9 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_1
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_426041", "426041017", "story_v_out_426041.awb")

						arg_69_1:RecordAudio("426041017", var_72_10)
						arg_69_1:RecordAudio("426041017", var_72_10)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_426041", "426041017", "story_v_out_426041.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_426041", "426041017", "story_v_out_426041.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_11 and arg_69_1.time_ < var_72_1 + var_72_11 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play426041018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 426041018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play426041019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["6148ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect6148ui_story == nil then
				arg_73_1.var_.characterEffect6148ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect6148ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_73_1.var_.characterEffect6148ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect6148ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_73_1.var_.characterEffect6148ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.8

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(426041018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 32
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
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play426041019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 426041019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play426041020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["6148ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos6148ui_story = var_80_0.localPosition

				local var_80_2 = GameObjectTools.GetOrAddComponent(var_80_0.gameObject, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(false)
				end
			end

			local var_80_3 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_3 then
				local var_80_4 = (arg_77_1.time_ - var_80_1) / var_80_3
				local var_80_5 = Vector3.New(0, 100, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos6148ui_story, var_80_5, var_80_4)

				local var_80_6 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_6.x, var_80_6.y, var_80_6.z)

				local var_80_7 = var_80_0.localEulerAngles

				var_80_7.z = 0
				var_80_7.x = 0
				var_80_0.localEulerAngles = var_80_7
			end

			if arg_77_1.time_ >= var_80_1 + var_80_3 and arg_77_1.time_ < var_80_1 + var_80_3 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, 100, 0)

				local var_80_8 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_8.x, var_80_8.y, var_80_8.z)

				local var_80_9 = var_80_0.localEulerAngles

				var_80_9.z = 0
				var_80_9.x = 0
				var_80_0.localEulerAngles = var_80_9

				local var_80_10 = GameObjectTools.GetOrAddComponent(var_80_0.gameObject, typeof(DynamicBoneHelper))

				if var_80_10 then
					var_80_10:EnableDynamicBone(true)
				end
			end

			local var_80_11 = 0
			local var_80_12 = 0.7

			if var_80_11 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_13 = arg_77_1:GetWordFromCfg(426041019)
				local var_80_14 = arg_77_1:FormatText(var_80_13.content)

				arg_77_1.text_.text = var_80_14

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 28
				local var_80_16 = utf8.len(var_80_14)
				local var_80_17 = var_80_15 <= 0 and var_80_12 or var_80_12 * (var_80_16 / var_80_15)

				if var_80_17 > 0 and var_80_12 < var_80_17 then
					arg_77_1.talkMaxDuration = var_80_17

					if var_80_17 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_11
					end
				end

				arg_77_1.text_.text = var_80_14
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_18 = math.max(var_80_12, arg_77_1.talkMaxDuration)

			if var_80_11 <= arg_77_1.time_ and arg_77_1.time_ < var_80_11 + var_80_18 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_11) / var_80_18

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_11 + var_80_18 and arg_77_1.time_ < var_80_11 + var_80_18 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play426041020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 426041020
		arg_81_1.duration_ = 7.77

		local var_81_0 = {
			zh = 5.2,
			ja = 7.766
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play426041021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["6148ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos6148ui_story = var_84_0.localPosition

				local var_84_2 = GameObjectTools.GetOrAddComponent(var_84_0.gameObject, typeof(DynamicBoneHelper))

				if var_84_2 then
					var_84_2:EnableDynamicBone(false)
				end
			end

			local var_84_3 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_3 then
				local var_84_4 = (arg_81_1.time_ - var_84_1) / var_84_3
				local var_84_5 = Vector3.New(0, -0.985, -6)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos6148ui_story, var_84_5, var_84_4)

				local var_84_6 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_6.x, var_84_6.y, var_84_6.z)

				local var_84_7 = var_84_0.localEulerAngles

				var_84_7.z = 0
				var_84_7.x = 0
				var_84_0.localEulerAngles = var_84_7
			end

			if arg_81_1.time_ >= var_84_1 + var_84_3 and arg_81_1.time_ < var_84_1 + var_84_3 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_84_8 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_8.x, var_84_8.y, var_84_8.z)

				local var_84_9 = var_84_0.localEulerAngles

				var_84_9.z = 0
				var_84_9.x = 0
				var_84_0.localEulerAngles = var_84_9

				local var_84_10 = GameObjectTools.GetOrAddComponent(var_84_0.gameObject, typeof(DynamicBoneHelper))

				if var_84_10 then
					var_84_10:EnableDynamicBone(true)
				end
			end

			local var_84_11 = arg_81_1.actors_["6148ui_story"]
			local var_84_12 = 0

			if var_84_12 < arg_81_1.time_ and arg_81_1.time_ <= var_84_12 + arg_84_0 and not isNil(var_84_11) and arg_81_1.var_.characterEffect6148ui_story == nil then
				arg_81_1.var_.characterEffect6148ui_story = var_84_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_13 = 0.200000002980232

			if var_84_12 <= arg_81_1.time_ and arg_81_1.time_ < var_84_12 + var_84_13 and not isNil(var_84_11) then
				local var_84_14 = (arg_81_1.time_ - var_84_12) / var_84_13

				if arg_81_1.var_.characterEffect6148ui_story and not isNil(var_84_11) then
					arg_81_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_12 + var_84_13 and arg_81_1.time_ < var_84_12 + var_84_13 + arg_84_0 and not isNil(var_84_11) and arg_81_1.var_.characterEffect6148ui_story then
				arg_81_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_84_15 = 0

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action8_1")
			end

			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_84_17 = 0
			local var_84_18 = 0.75

			if var_84_17 < arg_81_1.time_ and arg_81_1.time_ <= var_84_17 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_19 = arg_81_1:FormatText(StoryNameCfg[1488].name)

				arg_81_1.leftNameTxt_.text = var_84_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_20 = arg_81_1:GetWordFromCfg(426041020)
				local var_84_21 = arg_81_1:FormatText(var_84_20.content)

				arg_81_1.text_.text = var_84_21

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_22 = 30
				local var_84_23 = utf8.len(var_84_21)
				local var_84_24 = var_84_22 <= 0 and var_84_18 or var_84_18 * (var_84_23 / var_84_22)

				if var_84_24 > 0 and var_84_18 < var_84_24 then
					arg_81_1.talkMaxDuration = var_84_24

					if var_84_24 + var_84_17 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_24 + var_84_17
					end
				end

				arg_81_1.text_.text = var_84_21
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041020", "story_v_out_426041.awb") ~= 0 then
					local var_84_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041020", "story_v_out_426041.awb") / 1000

					if var_84_25 + var_84_17 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_25 + var_84_17
					end

					if var_84_20.prefab_name ~= "" and arg_81_1.actors_[var_84_20.prefab_name] ~= nil then
						local var_84_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_20.prefab_name].transform, "story_v_out_426041", "426041020", "story_v_out_426041.awb")

						arg_81_1:RecordAudio("426041020", var_84_26)
						arg_81_1:RecordAudio("426041020", var_84_26)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_426041", "426041020", "story_v_out_426041.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_426041", "426041020", "story_v_out_426041.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_27 = math.max(var_84_18, arg_81_1.talkMaxDuration)

			if var_84_17 <= arg_81_1.time_ and arg_81_1.time_ < var_84_17 + var_84_27 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_17) / var_84_27

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_17 + var_84_27 and arg_81_1.time_ < var_84_17 + var_84_27 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play426041021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 426041021
		arg_85_1.duration_ = 9.3

		local var_85_0 = {
			zh = 6.533,
			ja = 9.3
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
				arg_85_0:Play426041022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action8_2")
			end

			local var_88_1 = 0
			local var_88_2 = 0.925

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_3 = arg_85_1:FormatText(StoryNameCfg[1488].name)

				arg_85_1.leftNameTxt_.text = var_88_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_4 = arg_85_1:GetWordFromCfg(426041021)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 37
				local var_88_7 = utf8.len(var_88_5)
				local var_88_8 = var_88_6 <= 0 and var_88_2 or var_88_2 * (var_88_7 / var_88_6)

				if var_88_8 > 0 and var_88_2 < var_88_8 then
					arg_85_1.talkMaxDuration = var_88_8

					if var_88_8 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041021", "story_v_out_426041.awb") ~= 0 then
					local var_88_9 = manager.audio:GetVoiceLength("story_v_out_426041", "426041021", "story_v_out_426041.awb") / 1000

					if var_88_9 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_1
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_out_426041", "426041021", "story_v_out_426041.awb")

						arg_85_1:RecordAudio("426041021", var_88_10)
						arg_85_1:RecordAudio("426041021", var_88_10)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_426041", "426041021", "story_v_out_426041.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_426041", "426041021", "story_v_out_426041.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_11 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_11 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_11

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_11 and arg_85_1.time_ < var_88_1 + var_88_11 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play426041022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 426041022
		arg_89_1.duration_ = 9

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play426041023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = "J27h"

			if arg_89_1.bgs_[var_92_0] == nil then
				local var_92_1 = Object.Instantiate(arg_89_1.paintGo_)

				var_92_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_92_0)
				var_92_1.name = var_92_0
				var_92_1.transform.parent = arg_89_1.stage_.transform
				var_92_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.bgs_[var_92_0] = var_92_1
			end

			local var_92_2 = 2

			if var_92_2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				local var_92_3 = manager.ui.mainCamera.transform.localPosition
				local var_92_4 = Vector3.New(0, 0, 10) + Vector3.New(var_92_3.x, var_92_3.y, 0)
				local var_92_5 = arg_89_1.bgs_.J27h

				var_92_5.transform.localPosition = var_92_4
				var_92_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_6 = var_92_5:GetComponent("SpriteRenderer")

				if var_92_6 and var_92_6.sprite then
					local var_92_7 = (var_92_5.transform.localPosition - var_92_3).z
					local var_92_8 = manager.ui.mainCameraCom_
					local var_92_9 = 2 * var_92_7 * Mathf.Tan(var_92_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_92_10 = var_92_9 * var_92_8.aspect
					local var_92_11 = var_92_6.sprite.bounds.size.x
					local var_92_12 = var_92_6.sprite.bounds.size.y
					local var_92_13 = var_92_10 / var_92_11
					local var_92_14 = var_92_9 / var_92_12
					local var_92_15 = var_92_14 < var_92_13 and var_92_13 or var_92_14

					var_92_5.transform.localScale = Vector3.New(var_92_15, var_92_15, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "J27h" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_16 = 4

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			local var_92_17 = 0.3

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			local var_92_18 = 0

			if var_92_18 < arg_89_1.time_ and arg_89_1.time_ <= var_92_18 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_19 = 2

			if var_92_18 <= arg_89_1.time_ and arg_89_1.time_ < var_92_18 + var_92_19 then
				local var_92_20 = (arg_89_1.time_ - var_92_18) / var_92_19
				local var_92_21 = Color.New(0, 0, 0)

				var_92_21.a = Mathf.Lerp(0, 1, var_92_20)
				arg_89_1.mask_.color = var_92_21
			end

			if arg_89_1.time_ >= var_92_18 + var_92_19 and arg_89_1.time_ < var_92_18 + var_92_19 + arg_92_0 then
				local var_92_22 = Color.New(0, 0, 0)

				var_92_22.a = 1
				arg_89_1.mask_.color = var_92_22
			end

			local var_92_23 = 2

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_24 = 2

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_24 then
				local var_92_25 = (arg_89_1.time_ - var_92_23) / var_92_24
				local var_92_26 = Color.New(0, 0, 0)

				var_92_26.a = Mathf.Lerp(1, 0, var_92_25)
				arg_89_1.mask_.color = var_92_26
			end

			if arg_89_1.time_ >= var_92_23 + var_92_24 and arg_89_1.time_ < var_92_23 + var_92_24 + arg_92_0 then
				local var_92_27 = Color.New(0, 0, 0)
				local var_92_28 = 0

				arg_89_1.mask_.enabled = false
				var_92_27.a = var_92_28
				arg_89_1.mask_.color = var_92_27
			end

			local var_92_29 = arg_89_1.actors_["6148ui_story"].transform
			local var_92_30 = 1.96599999815226

			if var_92_30 < arg_89_1.time_ and arg_89_1.time_ <= var_92_30 + arg_92_0 then
				arg_89_1.var_.moveOldPos6148ui_story = var_92_29.localPosition

				local var_92_31 = GameObjectTools.GetOrAddComponent(var_92_29.gameObject, typeof(DynamicBoneHelper))

				if var_92_31 then
					var_92_31:EnableDynamicBone(false)
				end
			end

			local var_92_32 = 0.001

			if var_92_30 <= arg_89_1.time_ and arg_89_1.time_ < var_92_30 + var_92_32 then
				local var_92_33 = (arg_89_1.time_ - var_92_30) / var_92_32
				local var_92_34 = Vector3.New(0, 100, 0)

				var_92_29.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos6148ui_story, var_92_34, var_92_33)

				local var_92_35 = manager.ui.mainCamera.transform.position - var_92_29.position

				var_92_29.forward = Vector3.New(var_92_35.x, var_92_35.y, var_92_35.z)

				local var_92_36 = var_92_29.localEulerAngles

				var_92_36.z = 0
				var_92_36.x = 0
				var_92_29.localEulerAngles = var_92_36
			end

			if arg_89_1.time_ >= var_92_30 + var_92_32 and arg_89_1.time_ < var_92_30 + var_92_32 + arg_92_0 then
				var_92_29.localPosition = Vector3.New(0, 100, 0)

				local var_92_37 = manager.ui.mainCamera.transform.position - var_92_29.position

				var_92_29.forward = Vector3.New(var_92_37.x, var_92_37.y, var_92_37.z)

				local var_92_38 = var_92_29.localEulerAngles

				var_92_38.z = 0
				var_92_38.x = 0
				var_92_29.localEulerAngles = var_92_38

				local var_92_39 = GameObjectTools.GetOrAddComponent(var_92_29.gameObject, typeof(DynamicBoneHelper))

				if var_92_39 then
					var_92_39:EnableDynamicBone(true)
				end
			end

			local var_92_40 = arg_89_1.actors_["6148ui_story"]
			local var_92_41 = 1.96599999815226

			if var_92_41 < arg_89_1.time_ and arg_89_1.time_ <= var_92_41 + arg_92_0 and not isNil(var_92_40) and arg_89_1.var_.characterEffect6148ui_story == nil then
				arg_89_1.var_.characterEffect6148ui_story = var_92_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_42 = 0.034000001847744

			if var_92_41 <= arg_89_1.time_ and arg_89_1.time_ < var_92_41 + var_92_42 and not isNil(var_92_40) then
				local var_92_43 = (arg_89_1.time_ - var_92_41) / var_92_42

				if arg_89_1.var_.characterEffect6148ui_story and not isNil(var_92_40) then
					local var_92_44 = Mathf.Lerp(0, 0.5, var_92_43)

					arg_89_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_89_1.var_.characterEffect6148ui_story.fillRatio = var_92_44
				end
			end

			if arg_89_1.time_ >= var_92_41 + var_92_42 and arg_89_1.time_ < var_92_41 + var_92_42 + arg_92_0 and not isNil(var_92_40) and arg_89_1.var_.characterEffect6148ui_story then
				local var_92_45 = 0.5

				arg_89_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_89_1.var_.characterEffect6148ui_story.fillRatio = var_92_45
			end

			local var_92_46 = 2
			local var_92_47 = 1

			if var_92_46 < arg_89_1.time_ and arg_89_1.time_ <= var_92_46 + arg_92_0 then
				local var_92_48 = "stop"
				local var_92_49 = "effect"

				arg_89_1:AudioAction(var_92_48, var_92_49, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_92_50 = 2.43333333333333
			local var_92_51 = 1

			if var_92_50 < arg_89_1.time_ and arg_89_1.time_ <= var_92_50 + arg_92_0 then
				local var_92_52 = "play"
				local var_92_53 = "effect"

				arg_89_1:AudioAction(var_92_52, var_92_53, "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_54 = 4
			local var_92_55 = 0.65

			if var_92_54 < arg_89_1.time_ and arg_89_1.time_ <= var_92_54 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_56 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_56:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_57 = arg_89_1:GetWordFromCfg(426041022)
				local var_92_58 = arg_89_1:FormatText(var_92_57.content)

				arg_89_1.text_.text = var_92_58

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_59 = 26
				local var_92_60 = utf8.len(var_92_58)
				local var_92_61 = var_92_59 <= 0 and var_92_55 or var_92_55 * (var_92_60 / var_92_59)

				if var_92_61 > 0 and var_92_55 < var_92_61 then
					arg_89_1.talkMaxDuration = var_92_61
					var_92_54 = var_92_54 + 0.3

					if var_92_61 + var_92_54 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_61 + var_92_54
					end
				end

				arg_89_1.text_.text = var_92_58
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_62 = var_92_54 + 0.3
			local var_92_63 = math.max(var_92_55, arg_89_1.talkMaxDuration)

			if var_92_62 <= arg_89_1.time_ and arg_89_1.time_ < var_92_62 + var_92_63 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_62) / var_92_63

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_62 + var_92_63 and arg_89_1.time_ < var_92_62 + var_92_63 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play426041023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 426041023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play426041024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 1.075

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_2 = arg_95_1:GetWordFromCfg(426041023)
				local var_98_3 = arg_95_1:FormatText(var_98_2.content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 43
				local var_98_5 = utf8.len(var_98_3)
				local var_98_6 = var_98_4 <= 0 and var_98_1 or var_98_1 * (var_98_5 / var_98_4)

				if var_98_6 > 0 and var_98_1 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_7 and arg_95_1.time_ < var_98_0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play426041024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 426041024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play426041025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1.05

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:GetWordFromCfg(426041024)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 42
				local var_102_5 = utf8.len(var_102_3)
				local var_102_6 = var_102_4 <= 0 and var_102_1 or var_102_1 * (var_102_5 / var_102_4)

				if var_102_6 > 0 and var_102_1 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_7 and arg_99_1.time_ < var_102_0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play426041025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 426041025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play426041026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.475

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[7].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:GetWordFromCfg(426041025)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 19
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_8 and arg_103_1.time_ < var_106_0 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play426041026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 426041026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play426041027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.85

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

				local var_110_2 = arg_107_1:GetWordFromCfg(426041026)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 34
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
	Play426041027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 426041027
		arg_111_1.duration_ = 3.4

		local var_111_0 = {
			zh = 2.366,
			ja = 3.4
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
				arg_111_0:Play426041028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = "1054ui_story"

			if arg_111_1.actors_[var_114_0] == nil then
				local var_114_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_114_1) then
					local var_114_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_111_1.stage_.transform)

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

			local var_114_5 = arg_111_1.actors_["1054ui_story"].transform
			local var_114_6 = 0

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.var_.moveOldPos1054ui_story = var_114_5.localPosition

				local var_114_7 = GameObjectTools.GetOrAddComponent(var_114_5.gameObject, typeof(DynamicBoneHelper))

				if var_114_7 then
					var_114_7:EnableDynamicBone(false)
				end
			end

			local var_114_8 = 0.001

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_8 then
				local var_114_9 = (arg_111_1.time_ - var_114_6) / var_114_8
				local var_114_10 = Vector3.New(0, -0.985, -6)

				var_114_5.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1054ui_story, var_114_10, var_114_9)

				local var_114_11 = manager.ui.mainCamera.transform.position - var_114_5.position

				var_114_5.forward = Vector3.New(var_114_11.x, var_114_11.y, var_114_11.z)

				local var_114_12 = var_114_5.localEulerAngles

				var_114_12.z = 0
				var_114_12.x = 0
				var_114_5.localEulerAngles = var_114_12
			end

			if arg_111_1.time_ >= var_114_6 + var_114_8 and arg_111_1.time_ < var_114_6 + var_114_8 + arg_114_0 then
				var_114_5.localPosition = Vector3.New(0, -0.985, -6)

				local var_114_13 = manager.ui.mainCamera.transform.position - var_114_5.position

				var_114_5.forward = Vector3.New(var_114_13.x, var_114_13.y, var_114_13.z)

				local var_114_14 = var_114_5.localEulerAngles

				var_114_14.z = 0
				var_114_14.x = 0
				var_114_5.localEulerAngles = var_114_14

				local var_114_15 = GameObjectTools.GetOrAddComponent(var_114_5.gameObject, typeof(DynamicBoneHelper))

				if var_114_15 then
					var_114_15:EnableDynamicBone(true)
				end
			end

			local var_114_16 = arg_111_1.actors_["1054ui_story"]
			local var_114_17 = 0

			if var_114_17 < arg_111_1.time_ and arg_111_1.time_ <= var_114_17 + arg_114_0 and not isNil(var_114_16) and arg_111_1.var_.characterEffect1054ui_story == nil then
				arg_111_1.var_.characterEffect1054ui_story = var_114_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_18 = 0.200000002980232

			if var_114_17 <= arg_111_1.time_ and arg_111_1.time_ < var_114_17 + var_114_18 and not isNil(var_114_16) then
				local var_114_19 = (arg_111_1.time_ - var_114_17) / var_114_18

				if arg_111_1.var_.characterEffect1054ui_story and not isNil(var_114_16) then
					arg_111_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_17 + var_114_18 and arg_111_1.time_ < var_114_17 + var_114_18 + arg_114_0 and not isNil(var_114_16) and arg_111_1.var_.characterEffect1054ui_story then
				arg_111_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_114_20 = 0

			if var_114_20 < arg_111_1.time_ and arg_111_1.time_ <= var_114_20 + arg_114_0 then
				arg_111_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_114_21 = 0

			if var_114_21 < arg_111_1.time_ and arg_111_1.time_ <= var_114_21 + arg_114_0 then
				arg_111_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_114_22 = 0
			local var_114_23 = 0.25

			if var_114_22 < arg_111_1.time_ and arg_111_1.time_ <= var_114_22 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_24 = arg_111_1:FormatText(StoryNameCfg[1487].name)

				arg_111_1.leftNameTxt_.text = var_114_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_25 = arg_111_1:GetWordFromCfg(426041027)
				local var_114_26 = arg_111_1:FormatText(var_114_25.content)

				arg_111_1.text_.text = var_114_26

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_27 = 10
				local var_114_28 = utf8.len(var_114_26)
				local var_114_29 = var_114_27 <= 0 and var_114_23 or var_114_23 * (var_114_28 / var_114_27)

				if var_114_29 > 0 and var_114_23 < var_114_29 then
					arg_111_1.talkMaxDuration = var_114_29

					if var_114_29 + var_114_22 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_29 + var_114_22
					end
				end

				arg_111_1.text_.text = var_114_26
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041027", "story_v_out_426041.awb") ~= 0 then
					local var_114_30 = manager.audio:GetVoiceLength("story_v_out_426041", "426041027", "story_v_out_426041.awb") / 1000

					if var_114_30 + var_114_22 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_30 + var_114_22
					end

					if var_114_25.prefab_name ~= "" and arg_111_1.actors_[var_114_25.prefab_name] ~= nil then
						local var_114_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_25.prefab_name].transform, "story_v_out_426041", "426041027", "story_v_out_426041.awb")

						arg_111_1:RecordAudio("426041027", var_114_31)
						arg_111_1:RecordAudio("426041027", var_114_31)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_426041", "426041027", "story_v_out_426041.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_426041", "426041027", "story_v_out_426041.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_32 = math.max(var_114_23, arg_111_1.talkMaxDuration)

			if var_114_22 <= arg_111_1.time_ and arg_111_1.time_ < var_114_22 + var_114_32 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_22) / var_114_32

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_22 + var_114_32 and arg_111_1.time_ < var_114_22 + var_114_32 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426041028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 426041028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play426041029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1054ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1054ui_story == nil then
				arg_115_1.var_.characterEffect1054ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1054ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1054ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1054ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1054ui_story.fillRatio = var_118_5
			end

			local var_118_6 = 0
			local var_118_7 = 0.425

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_8 = arg_115_1:FormatText(StoryNameCfg[7].name)

				arg_115_1.leftNameTxt_.text = var_118_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_9 = arg_115_1:GetWordFromCfg(426041028)
				local var_118_10 = arg_115_1:FormatText(var_118_9.content)

				arg_115_1.text_.text = var_118_10

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 17
				local var_118_12 = utf8.len(var_118_10)
				local var_118_13 = var_118_11 <= 0 and var_118_7 or var_118_7 * (var_118_12 / var_118_11)

				if var_118_13 > 0 and var_118_7 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_10
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_14 and arg_115_1.time_ < var_118_6 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play426041029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 426041029
		arg_119_1.duration_ = 3.87

		local var_119_0 = {
			zh = 3.866,
			ja = 2.3
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
				arg_119_0:Play426041030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1054ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1054ui_story = var_122_0.localPosition

				local var_122_2 = GameObjectTools.GetOrAddComponent(var_122_0.gameObject, typeof(DynamicBoneHelper))

				if var_122_2 then
					var_122_2:EnableDynamicBone(false)
				end
			end

			local var_122_3 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_3 then
				local var_122_4 = (arg_119_1.time_ - var_122_1) / var_122_3
				local var_122_5 = Vector3.New(0, -0.985, -6)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1054ui_story, var_122_5, var_122_4)

				local var_122_6 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_6.x, var_122_6.y, var_122_6.z)

				local var_122_7 = var_122_0.localEulerAngles

				var_122_7.z = 0
				var_122_7.x = 0
				var_122_0.localEulerAngles = var_122_7
			end

			if arg_119_1.time_ >= var_122_1 + var_122_3 and arg_119_1.time_ < var_122_1 + var_122_3 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_122_8 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_8.x, var_122_8.y, var_122_8.z)

				local var_122_9 = var_122_0.localEulerAngles

				var_122_9.z = 0
				var_122_9.x = 0
				var_122_0.localEulerAngles = var_122_9

				local var_122_10 = GameObjectTools.GetOrAddComponent(var_122_0.gameObject, typeof(DynamicBoneHelper))

				if var_122_10 then
					var_122_10:EnableDynamicBone(true)
				end
			end

			local var_122_11 = arg_119_1.actors_["1054ui_story"]
			local var_122_12 = 0

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 and not isNil(var_122_11) and arg_119_1.var_.characterEffect1054ui_story == nil then
				arg_119_1.var_.characterEffect1054ui_story = var_122_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_13 = 0.200000002980232

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_13 and not isNil(var_122_11) then
				local var_122_14 = (arg_119_1.time_ - var_122_12) / var_122_13

				if arg_119_1.var_.characterEffect1054ui_story and not isNil(var_122_11) then
					arg_119_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_12 + var_122_13 and arg_119_1.time_ < var_122_12 + var_122_13 + arg_122_0 and not isNil(var_122_11) and arg_119_1.var_.characterEffect1054ui_story then
				arg_119_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_122_15 = 0

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			local var_122_16 = 0

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_122_17 = 0
			local var_122_18 = 0.3

			if var_122_17 < arg_119_1.time_ and arg_119_1.time_ <= var_122_17 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_19 = arg_119_1:FormatText(StoryNameCfg[1487].name)

				arg_119_1.leftNameTxt_.text = var_122_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_20 = arg_119_1:GetWordFromCfg(426041029)
				local var_122_21 = arg_119_1:FormatText(var_122_20.content)

				arg_119_1.text_.text = var_122_21

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_22 = 12
				local var_122_23 = utf8.len(var_122_21)
				local var_122_24 = var_122_22 <= 0 and var_122_18 or var_122_18 * (var_122_23 / var_122_22)

				if var_122_24 > 0 and var_122_18 < var_122_24 then
					arg_119_1.talkMaxDuration = var_122_24

					if var_122_24 + var_122_17 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_24 + var_122_17
					end
				end

				arg_119_1.text_.text = var_122_21
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041029", "story_v_out_426041.awb") ~= 0 then
					local var_122_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041029", "story_v_out_426041.awb") / 1000

					if var_122_25 + var_122_17 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_25 + var_122_17
					end

					if var_122_20.prefab_name ~= "" and arg_119_1.actors_[var_122_20.prefab_name] ~= nil then
						local var_122_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_20.prefab_name].transform, "story_v_out_426041", "426041029", "story_v_out_426041.awb")

						arg_119_1:RecordAudio("426041029", var_122_26)
						arg_119_1:RecordAudio("426041029", var_122_26)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_426041", "426041029", "story_v_out_426041.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_426041", "426041029", "story_v_out_426041.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_27 = math.max(var_122_18, arg_119_1.talkMaxDuration)

			if var_122_17 <= arg_119_1.time_ and arg_119_1.time_ < var_122_17 + var_122_27 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_17) / var_122_27

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_17 + var_122_27 and arg_119_1.time_ < var_122_17 + var_122_27 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play426041030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 426041030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play426041031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1054ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1054ui_story = var_126_0.localPosition

				local var_126_2 = GameObjectTools.GetOrAddComponent(var_126_0.gameObject, typeof(DynamicBoneHelper))

				if var_126_2 then
					var_126_2:EnableDynamicBone(false)
				end
			end

			local var_126_3 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_3 then
				local var_126_4 = (arg_123_1.time_ - var_126_1) / var_126_3
				local var_126_5 = Vector3.New(0, 100, 0)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1054ui_story, var_126_5, var_126_4)

				local var_126_6 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_6.x, var_126_6.y, var_126_6.z)

				local var_126_7 = var_126_0.localEulerAngles

				var_126_7.z = 0
				var_126_7.x = 0
				var_126_0.localEulerAngles = var_126_7
			end

			if arg_123_1.time_ >= var_126_1 + var_126_3 and arg_123_1.time_ < var_126_1 + var_126_3 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, 100, 0)

				local var_126_8 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_8.x, var_126_8.y, var_126_8.z)

				local var_126_9 = var_126_0.localEulerAngles

				var_126_9.z = 0
				var_126_9.x = 0
				var_126_0.localEulerAngles = var_126_9

				local var_126_10 = GameObjectTools.GetOrAddComponent(var_126_0.gameObject, typeof(DynamicBoneHelper))

				if var_126_10 then
					var_126_10:EnableDynamicBone(true)
				end
			end

			local var_126_11 = arg_123_1.actors_["1054ui_story"]
			local var_126_12 = 0

			if var_126_12 < arg_123_1.time_ and arg_123_1.time_ <= var_126_12 + arg_126_0 and not isNil(var_126_11) and arg_123_1.var_.characterEffect1054ui_story == nil then
				arg_123_1.var_.characterEffect1054ui_story = var_126_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_13 = 0.200000002980232

			if var_126_12 <= arg_123_1.time_ and arg_123_1.time_ < var_126_12 + var_126_13 and not isNil(var_126_11) then
				local var_126_14 = (arg_123_1.time_ - var_126_12) / var_126_13

				if arg_123_1.var_.characterEffect1054ui_story and not isNil(var_126_11) then
					local var_126_15 = Mathf.Lerp(0, 0.5, var_126_14)

					arg_123_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1054ui_story.fillRatio = var_126_15
				end
			end

			if arg_123_1.time_ >= var_126_12 + var_126_13 and arg_123_1.time_ < var_126_12 + var_126_13 + arg_126_0 and not isNil(var_126_11) and arg_123_1.var_.characterEffect1054ui_story then
				local var_126_16 = 0.5

				arg_123_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1054ui_story.fillRatio = var_126_16
			end

			local var_126_17 = 0
			local var_126_18 = 0.875

			if var_126_17 < arg_123_1.time_ and arg_123_1.time_ <= var_126_17 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_19 = arg_123_1:GetWordFromCfg(426041030)
				local var_126_20 = arg_123_1:FormatText(var_126_19.content)

				arg_123_1.text_.text = var_126_20

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_21 = 35
				local var_126_22 = utf8.len(var_126_20)
				local var_126_23 = var_126_21 <= 0 and var_126_18 or var_126_18 * (var_126_22 / var_126_21)

				if var_126_23 > 0 and var_126_18 < var_126_23 then
					arg_123_1.talkMaxDuration = var_126_23

					if var_126_23 + var_126_17 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_17
					end
				end

				arg_123_1.text_.text = var_126_20
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_24 = math.max(var_126_18, arg_123_1.talkMaxDuration)

			if var_126_17 <= arg_123_1.time_ and arg_123_1.time_ < var_126_17 + var_126_24 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_17) / var_126_24

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_17 + var_126_24 and arg_123_1.time_ < var_126_17 + var_126_24 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426041031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 426041031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play426041032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.1

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(426041031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 4
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_8 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_8 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_8

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_8 and arg_127_1.time_ < var_130_0 + var_130_8 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play426041032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 426041032
		arg_131_1.duration_ = 2.7

		local var_131_0 = {
			zh = 2.7,
			ja = 2.3
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
				arg_131_0:Play426041033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1054ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1054ui_story = var_134_0.localPosition

				local var_134_2 = GameObjectTools.GetOrAddComponent(var_134_0.gameObject, typeof(DynamicBoneHelper))

				if var_134_2 then
					var_134_2:EnableDynamicBone(false)
				end
			end

			local var_134_3 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_3 then
				local var_134_4 = (arg_131_1.time_ - var_134_1) / var_134_3
				local var_134_5 = Vector3.New(0, -0.985, -6)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1054ui_story, var_134_5, var_134_4)

				local var_134_6 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_6.x, var_134_6.y, var_134_6.z)

				local var_134_7 = var_134_0.localEulerAngles

				var_134_7.z = 0
				var_134_7.x = 0
				var_134_0.localEulerAngles = var_134_7
			end

			if arg_131_1.time_ >= var_134_1 + var_134_3 and arg_131_1.time_ < var_134_1 + var_134_3 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_134_8 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_8.x, var_134_8.y, var_134_8.z)

				local var_134_9 = var_134_0.localEulerAngles

				var_134_9.z = 0
				var_134_9.x = 0
				var_134_0.localEulerAngles = var_134_9

				local var_134_10 = GameObjectTools.GetOrAddComponent(var_134_0.gameObject, typeof(DynamicBoneHelper))

				if var_134_10 then
					var_134_10:EnableDynamicBone(true)
				end
			end

			local var_134_11 = arg_131_1.actors_["1054ui_story"]
			local var_134_12 = 0

			if var_134_12 < arg_131_1.time_ and arg_131_1.time_ <= var_134_12 + arg_134_0 and not isNil(var_134_11) and arg_131_1.var_.characterEffect1054ui_story == nil then
				arg_131_1.var_.characterEffect1054ui_story = var_134_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_13 = 0.200000002980232

			if var_134_12 <= arg_131_1.time_ and arg_131_1.time_ < var_134_12 + var_134_13 and not isNil(var_134_11) then
				local var_134_14 = (arg_131_1.time_ - var_134_12) / var_134_13

				if arg_131_1.var_.characterEffect1054ui_story and not isNil(var_134_11) then
					arg_131_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_12 + var_134_13 and arg_131_1.time_ < var_134_12 + var_134_13 + arg_134_0 and not isNil(var_134_11) and arg_131_1.var_.characterEffect1054ui_story then
				arg_131_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_134_15 = 0

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_134_16 = 0

			if var_134_16 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 then
				arg_131_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_134_17 = 0
			local var_134_18 = 0.175

			if var_134_17 < arg_131_1.time_ and arg_131_1.time_ <= var_134_17 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_19 = arg_131_1:FormatText(StoryNameCfg[1487].name)

				arg_131_1.leftNameTxt_.text = var_134_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_20 = arg_131_1:GetWordFromCfg(426041032)
				local var_134_21 = arg_131_1:FormatText(var_134_20.content)

				arg_131_1.text_.text = var_134_21

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_22 = 7
				local var_134_23 = utf8.len(var_134_21)
				local var_134_24 = var_134_22 <= 0 and var_134_18 or var_134_18 * (var_134_23 / var_134_22)

				if var_134_24 > 0 and var_134_18 < var_134_24 then
					arg_131_1.talkMaxDuration = var_134_24

					if var_134_24 + var_134_17 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_24 + var_134_17
					end
				end

				arg_131_1.text_.text = var_134_21
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041032", "story_v_out_426041.awb") ~= 0 then
					local var_134_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041032", "story_v_out_426041.awb") / 1000

					if var_134_25 + var_134_17 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_25 + var_134_17
					end

					if var_134_20.prefab_name ~= "" and arg_131_1.actors_[var_134_20.prefab_name] ~= nil then
						local var_134_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_20.prefab_name].transform, "story_v_out_426041", "426041032", "story_v_out_426041.awb")

						arg_131_1:RecordAudio("426041032", var_134_26)
						arg_131_1:RecordAudio("426041032", var_134_26)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_426041", "426041032", "story_v_out_426041.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_426041", "426041032", "story_v_out_426041.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_27 = math.max(var_134_18, arg_131_1.talkMaxDuration)

			if var_134_17 <= arg_131_1.time_ and arg_131_1.time_ < var_134_17 + var_134_27 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_17) / var_134_27

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_17 + var_134_27 and arg_131_1.time_ < var_134_17 + var_134_27 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play426041033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 426041033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play426041034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1054ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1054ui_story == nil then
				arg_135_1.var_.characterEffect1054ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1054ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1054ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1054ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1054ui_story.fillRatio = var_138_5
			end

			local var_138_6 = 0
			local var_138_7 = 0.5

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_8 = arg_135_1:FormatText(StoryNameCfg[7].name)

				arg_135_1.leftNameTxt_.text = var_138_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_9 = arg_135_1:GetWordFromCfg(426041033)
				local var_138_10 = arg_135_1:FormatText(var_138_9.content)

				arg_135_1.text_.text = var_138_10

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_11 = 20
				local var_138_12 = utf8.len(var_138_10)
				local var_138_13 = var_138_11 <= 0 and var_138_7 or var_138_7 * (var_138_12 / var_138_11)

				if var_138_13 > 0 and var_138_7 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_10
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_14 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_14 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_14

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_14 and arg_135_1.time_ < var_138_6 + var_138_14 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play426041034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 426041034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play426041035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.575

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[7].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(426041034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 23
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_8 and arg_139_1.time_ < var_142_0 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play426041035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 426041035
		arg_143_1.duration_ = 4.5

		local var_143_0 = {
			zh = 4.5,
			ja = 3.966
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play426041036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1054ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos1054ui_story = var_146_0.localPosition

				local var_146_2 = GameObjectTools.GetOrAddComponent(var_146_0.gameObject, typeof(DynamicBoneHelper))

				if var_146_2 then
					var_146_2:EnableDynamicBone(false)
				end
			end

			local var_146_3 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_3 then
				local var_146_4 = (arg_143_1.time_ - var_146_1) / var_146_3
				local var_146_5 = Vector3.New(0, -0.985, -6)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1054ui_story, var_146_5, var_146_4)

				local var_146_6 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_6.x, var_146_6.y, var_146_6.z)

				local var_146_7 = var_146_0.localEulerAngles

				var_146_7.z = 0
				var_146_7.x = 0
				var_146_0.localEulerAngles = var_146_7
			end

			if arg_143_1.time_ >= var_146_1 + var_146_3 and arg_143_1.time_ < var_146_1 + var_146_3 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_146_8 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_8.x, var_146_8.y, var_146_8.z)

				local var_146_9 = var_146_0.localEulerAngles

				var_146_9.z = 0
				var_146_9.x = 0
				var_146_0.localEulerAngles = var_146_9

				local var_146_10 = GameObjectTools.GetOrAddComponent(var_146_0.gameObject, typeof(DynamicBoneHelper))

				if var_146_10 then
					var_146_10:EnableDynamicBone(true)
				end
			end

			local var_146_11 = arg_143_1.actors_["1054ui_story"]
			local var_146_12 = 0

			if var_146_12 < arg_143_1.time_ and arg_143_1.time_ <= var_146_12 + arg_146_0 and not isNil(var_146_11) and arg_143_1.var_.characterEffect1054ui_story == nil then
				arg_143_1.var_.characterEffect1054ui_story = var_146_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_13 = 0.200000002980232

			if var_146_12 <= arg_143_1.time_ and arg_143_1.time_ < var_146_12 + var_146_13 and not isNil(var_146_11) then
				local var_146_14 = (arg_143_1.time_ - var_146_12) / var_146_13

				if arg_143_1.var_.characterEffect1054ui_story and not isNil(var_146_11) then
					arg_143_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_12 + var_146_13 and arg_143_1.time_ < var_146_12 + var_146_13 + arg_146_0 and not isNil(var_146_11) and arg_143_1.var_.characterEffect1054ui_story then
				arg_143_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_146_15 = 0

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 then
				arg_143_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_146_16 = 0

			if var_146_16 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 then
				arg_143_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_146_17 = 0
			local var_146_18 = 0.425

			if var_146_17 < arg_143_1.time_ and arg_143_1.time_ <= var_146_17 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_19 = arg_143_1:FormatText(StoryNameCfg[1487].name)

				arg_143_1.leftNameTxt_.text = var_146_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_20 = arg_143_1:GetWordFromCfg(426041035)
				local var_146_21 = arg_143_1:FormatText(var_146_20.content)

				arg_143_1.text_.text = var_146_21

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_22 = 17
				local var_146_23 = utf8.len(var_146_21)
				local var_146_24 = var_146_22 <= 0 and var_146_18 or var_146_18 * (var_146_23 / var_146_22)

				if var_146_24 > 0 and var_146_18 < var_146_24 then
					arg_143_1.talkMaxDuration = var_146_24

					if var_146_24 + var_146_17 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_24 + var_146_17
					end
				end

				arg_143_1.text_.text = var_146_21
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041035", "story_v_out_426041.awb") ~= 0 then
					local var_146_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041035", "story_v_out_426041.awb") / 1000

					if var_146_25 + var_146_17 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_25 + var_146_17
					end

					if var_146_20.prefab_name ~= "" and arg_143_1.actors_[var_146_20.prefab_name] ~= nil then
						local var_146_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_20.prefab_name].transform, "story_v_out_426041", "426041035", "story_v_out_426041.awb")

						arg_143_1:RecordAudio("426041035", var_146_26)
						arg_143_1:RecordAudio("426041035", var_146_26)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_426041", "426041035", "story_v_out_426041.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_426041", "426041035", "story_v_out_426041.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_27 = math.max(var_146_18, arg_143_1.talkMaxDuration)

			if var_146_17 <= arg_143_1.time_ and arg_143_1.time_ < var_146_17 + var_146_27 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_17) / var_146_27

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_17 + var_146_27 and arg_143_1.time_ < var_146_17 + var_146_27 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play426041036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 426041036
		arg_147_1.duration_ = 11.2

		local var_147_0 = {
			zh = 10.266,
			ja = 11.2
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
				arg_147_0:Play426041037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.75

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[1487].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(426041036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 30
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041036", "story_v_out_426041.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_426041", "426041036", "story_v_out_426041.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_426041", "426041036", "story_v_out_426041.awb")

						arg_147_1:RecordAudio("426041036", var_150_9)
						arg_147_1:RecordAudio("426041036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_426041", "426041036", "story_v_out_426041.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_426041", "426041036", "story_v_out_426041.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play426041037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 426041037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play426041038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1054ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1054ui_story == nil then
				arg_151_1.var_.characterEffect1054ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1054ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1054ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1054ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1054ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 1.1

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

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(426041037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 44
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
	Play426041038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 426041038
		arg_155_1.duration_ = 3.23

		local var_155_0 = {
			zh = 3.233,
			ja = 2.2
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play426041039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1054ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos1054ui_story = var_158_0.localPosition

				local var_158_2 = GameObjectTools.GetOrAddComponent(var_158_0.gameObject, typeof(DynamicBoneHelper))

				if var_158_2 then
					var_158_2:EnableDynamicBone(false)
				end
			end

			local var_158_3 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_3 then
				local var_158_4 = (arg_155_1.time_ - var_158_1) / var_158_3
				local var_158_5 = Vector3.New(0, -0.985, -6)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1054ui_story, var_158_5, var_158_4)

				local var_158_6 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_6.x, var_158_6.y, var_158_6.z)

				local var_158_7 = var_158_0.localEulerAngles

				var_158_7.z = 0
				var_158_7.x = 0
				var_158_0.localEulerAngles = var_158_7
			end

			if arg_155_1.time_ >= var_158_1 + var_158_3 and arg_155_1.time_ < var_158_1 + var_158_3 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_158_8 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_8.x, var_158_8.y, var_158_8.z)

				local var_158_9 = var_158_0.localEulerAngles

				var_158_9.z = 0
				var_158_9.x = 0
				var_158_0.localEulerAngles = var_158_9

				local var_158_10 = GameObjectTools.GetOrAddComponent(var_158_0.gameObject, typeof(DynamicBoneHelper))

				if var_158_10 then
					var_158_10:EnableDynamicBone(true)
				end
			end

			local var_158_11 = arg_155_1.actors_["1054ui_story"]
			local var_158_12 = 0

			if var_158_12 < arg_155_1.time_ and arg_155_1.time_ <= var_158_12 + arg_158_0 and not isNil(var_158_11) and arg_155_1.var_.characterEffect1054ui_story == nil then
				arg_155_1.var_.characterEffect1054ui_story = var_158_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_13 = 0.200000002980232

			if var_158_12 <= arg_155_1.time_ and arg_155_1.time_ < var_158_12 + var_158_13 and not isNil(var_158_11) then
				local var_158_14 = (arg_155_1.time_ - var_158_12) / var_158_13

				if arg_155_1.var_.characterEffect1054ui_story and not isNil(var_158_11) then
					arg_155_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_12 + var_158_13 and arg_155_1.time_ < var_158_12 + var_158_13 + arg_158_0 and not isNil(var_158_11) and arg_155_1.var_.characterEffect1054ui_story then
				arg_155_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_158_15 = 0

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action435")
			end

			local var_158_16 = 0

			if var_158_16 < arg_155_1.time_ and arg_155_1.time_ <= var_158_16 + arg_158_0 then
				arg_155_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoB", "EmotionTimelineAnimator")
			end

			local var_158_17 = 0
			local var_158_18 = 0.15

			if var_158_17 < arg_155_1.time_ and arg_155_1.time_ <= var_158_17 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_19 = arg_155_1:FormatText(StoryNameCfg[1487].name)

				arg_155_1.leftNameTxt_.text = var_158_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_20 = arg_155_1:GetWordFromCfg(426041038)
				local var_158_21 = arg_155_1:FormatText(var_158_20.content)

				arg_155_1.text_.text = var_158_21

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_22 = 6
				local var_158_23 = utf8.len(var_158_21)
				local var_158_24 = var_158_22 <= 0 and var_158_18 or var_158_18 * (var_158_23 / var_158_22)

				if var_158_24 > 0 and var_158_18 < var_158_24 then
					arg_155_1.talkMaxDuration = var_158_24

					if var_158_24 + var_158_17 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_24 + var_158_17
					end
				end

				arg_155_1.text_.text = var_158_21
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041038", "story_v_out_426041.awb") ~= 0 then
					local var_158_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041038", "story_v_out_426041.awb") / 1000

					if var_158_25 + var_158_17 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_25 + var_158_17
					end

					if var_158_20.prefab_name ~= "" and arg_155_1.actors_[var_158_20.prefab_name] ~= nil then
						local var_158_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_20.prefab_name].transform, "story_v_out_426041", "426041038", "story_v_out_426041.awb")

						arg_155_1:RecordAudio("426041038", var_158_26)
						arg_155_1:RecordAudio("426041038", var_158_26)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_426041", "426041038", "story_v_out_426041.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_426041", "426041038", "story_v_out_426041.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_27 = math.max(var_158_18, arg_155_1.talkMaxDuration)

			if var_158_17 <= arg_155_1.time_ and arg_155_1.time_ < var_158_17 + var_158_27 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_17) / var_158_27

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_17 + var_158_27 and arg_155_1.time_ < var_158_17 + var_158_27 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play426041039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 426041039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play426041040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1054ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1054ui_story == nil then
				arg_159_1.var_.characterEffect1054ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1054ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1054ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1054ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1054ui_story.fillRatio = var_162_5
			end

			local var_162_6 = 0
			local var_162_7 = 0.675

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_8 = arg_159_1:FormatText(StoryNameCfg[7].name)

				arg_159_1.leftNameTxt_.text = var_162_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_9 = arg_159_1:GetWordFromCfg(426041039)
				local var_162_10 = arg_159_1:FormatText(var_162_9.content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 27
				local var_162_12 = utf8.len(var_162_10)
				local var_162_13 = var_162_11 <= 0 and var_162_7 or var_162_7 * (var_162_12 / var_162_11)

				if var_162_13 > 0 and var_162_7 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_10
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play426041040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 426041040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play426041041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1054ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos1054ui_story = var_166_0.localPosition

				local var_166_2 = GameObjectTools.GetOrAddComponent(var_166_0.gameObject, typeof(DynamicBoneHelper))

				if var_166_2 then
					var_166_2:EnableDynamicBone(false)
				end
			end

			local var_166_3 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_3 then
				local var_166_4 = (arg_163_1.time_ - var_166_1) / var_166_3
				local var_166_5 = Vector3.New(0, 100, 0)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1054ui_story, var_166_5, var_166_4)

				local var_166_6 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_6.x, var_166_6.y, var_166_6.z)

				local var_166_7 = var_166_0.localEulerAngles

				var_166_7.z = 0
				var_166_7.x = 0
				var_166_0.localEulerAngles = var_166_7
			end

			if arg_163_1.time_ >= var_166_1 + var_166_3 and arg_163_1.time_ < var_166_1 + var_166_3 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, 100, 0)

				local var_166_8 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_8.x, var_166_8.y, var_166_8.z)

				local var_166_9 = var_166_0.localEulerAngles

				var_166_9.z = 0
				var_166_9.x = 0
				var_166_0.localEulerAngles = var_166_9

				local var_166_10 = GameObjectTools.GetOrAddComponent(var_166_0.gameObject, typeof(DynamicBoneHelper))

				if var_166_10 then
					var_166_10:EnableDynamicBone(true)
				end
			end

			local var_166_11 = 0
			local var_166_12 = 0.65

			if var_166_11 < arg_163_1.time_ and arg_163_1.time_ <= var_166_11 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_13 = arg_163_1:GetWordFromCfg(426041040)
				local var_166_14 = arg_163_1:FormatText(var_166_13.content)

				arg_163_1.text_.text = var_166_14

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_15 = 26
				local var_166_16 = utf8.len(var_166_14)
				local var_166_17 = var_166_15 <= 0 and var_166_12 or var_166_12 * (var_166_16 / var_166_15)

				if var_166_17 > 0 and var_166_12 < var_166_17 then
					arg_163_1.talkMaxDuration = var_166_17

					if var_166_17 + var_166_11 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_17 + var_166_11
					end
				end

				arg_163_1.text_.text = var_166_14
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_18 = math.max(var_166_12, arg_163_1.talkMaxDuration)

			if var_166_11 <= arg_163_1.time_ and arg_163_1.time_ < var_166_11 + var_166_18 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_11) / var_166_18

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_11 + var_166_18 and arg_163_1.time_ < var_166_11 + var_166_18 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play426041041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 426041041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play426041042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.925

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[7].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(426041041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 37
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_8 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_8 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_8

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_8 and arg_167_1.time_ < var_170_0 + var_170_8 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play426041042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 426041042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play426041043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.75

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[7].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(426041042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 30
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_8 and arg_171_1.time_ < var_174_0 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play426041043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 426041043
		arg_175_1.duration_ = 5.07

		local var_175_0 = {
			zh = 4.666,
			ja = 5.066
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play426041044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1054ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1054ui_story = var_178_0.localPosition

				local var_178_2 = GameObjectTools.GetOrAddComponent(var_178_0.gameObject, typeof(DynamicBoneHelper))

				if var_178_2 then
					var_178_2:EnableDynamicBone(false)
				end
			end

			local var_178_3 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_3 then
				local var_178_4 = (arg_175_1.time_ - var_178_1) / var_178_3
				local var_178_5 = Vector3.New(0, -0.985, -6)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1054ui_story, var_178_5, var_178_4)

				local var_178_6 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_6.x, var_178_6.y, var_178_6.z)

				local var_178_7 = var_178_0.localEulerAngles

				var_178_7.z = 0
				var_178_7.x = 0
				var_178_0.localEulerAngles = var_178_7
			end

			if arg_175_1.time_ >= var_178_1 + var_178_3 and arg_175_1.time_ < var_178_1 + var_178_3 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_178_8 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_8.x, var_178_8.y, var_178_8.z)

				local var_178_9 = var_178_0.localEulerAngles

				var_178_9.z = 0
				var_178_9.x = 0
				var_178_0.localEulerAngles = var_178_9

				local var_178_10 = GameObjectTools.GetOrAddComponent(var_178_0.gameObject, typeof(DynamicBoneHelper))

				if var_178_10 then
					var_178_10:EnableDynamicBone(true)
				end
			end

			local var_178_11 = arg_175_1.actors_["1054ui_story"]
			local var_178_12 = 0

			if var_178_12 < arg_175_1.time_ and arg_175_1.time_ <= var_178_12 + arg_178_0 and not isNil(var_178_11) and arg_175_1.var_.characterEffect1054ui_story == nil then
				arg_175_1.var_.characterEffect1054ui_story = var_178_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_13 = 0.200000002980232

			if var_178_12 <= arg_175_1.time_ and arg_175_1.time_ < var_178_12 + var_178_13 and not isNil(var_178_11) then
				local var_178_14 = (arg_175_1.time_ - var_178_12) / var_178_13

				if arg_175_1.var_.characterEffect1054ui_story and not isNil(var_178_11) then
					arg_175_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_12 + var_178_13 and arg_175_1.time_ < var_178_12 + var_178_13 + arg_178_0 and not isNil(var_178_11) and arg_175_1.var_.characterEffect1054ui_story then
				arg_175_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_178_15 = 0

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_178_17 = 0
			local var_178_18 = 0.425

			if var_178_17 < arg_175_1.time_ and arg_175_1.time_ <= var_178_17 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_19 = arg_175_1:FormatText(StoryNameCfg[1487].name)

				arg_175_1.leftNameTxt_.text = var_178_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_20 = arg_175_1:GetWordFromCfg(426041043)
				local var_178_21 = arg_175_1:FormatText(var_178_20.content)

				arg_175_1.text_.text = var_178_21

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_22 = 17
				local var_178_23 = utf8.len(var_178_21)
				local var_178_24 = var_178_22 <= 0 and var_178_18 or var_178_18 * (var_178_23 / var_178_22)

				if var_178_24 > 0 and var_178_18 < var_178_24 then
					arg_175_1.talkMaxDuration = var_178_24

					if var_178_24 + var_178_17 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_24 + var_178_17
					end
				end

				arg_175_1.text_.text = var_178_21
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041043", "story_v_out_426041.awb") ~= 0 then
					local var_178_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041043", "story_v_out_426041.awb") / 1000

					if var_178_25 + var_178_17 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_25 + var_178_17
					end

					if var_178_20.prefab_name ~= "" and arg_175_1.actors_[var_178_20.prefab_name] ~= nil then
						local var_178_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_20.prefab_name].transform, "story_v_out_426041", "426041043", "story_v_out_426041.awb")

						arg_175_1:RecordAudio("426041043", var_178_26)
						arg_175_1:RecordAudio("426041043", var_178_26)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_426041", "426041043", "story_v_out_426041.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_426041", "426041043", "story_v_out_426041.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_27 = math.max(var_178_18, arg_175_1.talkMaxDuration)

			if var_178_17 <= arg_175_1.time_ and arg_175_1.time_ < var_178_17 + var_178_27 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_17) / var_178_27

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_17 + var_178_27 and arg_175_1.time_ < var_178_17 + var_178_27 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play426041044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 426041044
		arg_179_1.duration_ = 6.07

		local var_179_0 = {
			zh = 5.633,
			ja = 6.066
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play426041045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.45

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[1487].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(426041044)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 18
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041044", "story_v_out_426041.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_426041", "426041044", "story_v_out_426041.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_426041", "426041044", "story_v_out_426041.awb")

						arg_179_1:RecordAudio("426041044", var_182_9)
						arg_179_1:RecordAudio("426041044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_426041", "426041044", "story_v_out_426041.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_426041", "426041044", "story_v_out_426041.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play426041045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 426041045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play426041046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1054ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1054ui_story = var_186_0.localPosition

				local var_186_2 = GameObjectTools.GetOrAddComponent(var_186_0.gameObject, typeof(DynamicBoneHelper))

				if var_186_2 then
					var_186_2:EnableDynamicBone(false)
				end
			end

			local var_186_3 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_3 then
				local var_186_4 = (arg_183_1.time_ - var_186_1) / var_186_3
				local var_186_5 = Vector3.New(0, 100, 0)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1054ui_story, var_186_5, var_186_4)

				local var_186_6 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_6.x, var_186_6.y, var_186_6.z)

				local var_186_7 = var_186_0.localEulerAngles

				var_186_7.z = 0
				var_186_7.x = 0
				var_186_0.localEulerAngles = var_186_7
			end

			if arg_183_1.time_ >= var_186_1 + var_186_3 and arg_183_1.time_ < var_186_1 + var_186_3 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, 100, 0)

				local var_186_8 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_8.x, var_186_8.y, var_186_8.z)

				local var_186_9 = var_186_0.localEulerAngles

				var_186_9.z = 0
				var_186_9.x = 0
				var_186_0.localEulerAngles = var_186_9

				local var_186_10 = GameObjectTools.GetOrAddComponent(var_186_0.gameObject, typeof(DynamicBoneHelper))

				if var_186_10 then
					var_186_10:EnableDynamicBone(true)
				end
			end

			local var_186_11 = arg_183_1.actors_["1054ui_story"]
			local var_186_12 = 0

			if var_186_12 < arg_183_1.time_ and arg_183_1.time_ <= var_186_12 + arg_186_0 and not isNil(var_186_11) and arg_183_1.var_.characterEffect1054ui_story == nil then
				arg_183_1.var_.characterEffect1054ui_story = var_186_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_13 = 0.200000002980232

			if var_186_12 <= arg_183_1.time_ and arg_183_1.time_ < var_186_12 + var_186_13 and not isNil(var_186_11) then
				local var_186_14 = (arg_183_1.time_ - var_186_12) / var_186_13

				if arg_183_1.var_.characterEffect1054ui_story and not isNil(var_186_11) then
					local var_186_15 = Mathf.Lerp(0, 0.5, var_186_14)

					arg_183_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1054ui_story.fillRatio = var_186_15
				end
			end

			if arg_183_1.time_ >= var_186_12 + var_186_13 and arg_183_1.time_ < var_186_12 + var_186_13 + arg_186_0 and not isNil(var_186_11) and arg_183_1.var_.characterEffect1054ui_story then
				local var_186_16 = 0.5

				arg_183_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1054ui_story.fillRatio = var_186_16
			end

			local var_186_17 = 0
			local var_186_18 = 1.2

			if var_186_17 < arg_183_1.time_ and arg_183_1.time_ <= var_186_17 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_19 = arg_183_1:GetWordFromCfg(426041045)
				local var_186_20 = arg_183_1:FormatText(var_186_19.content)

				arg_183_1.text_.text = var_186_20

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_21 = 48
				local var_186_22 = utf8.len(var_186_20)
				local var_186_23 = var_186_21 <= 0 and var_186_18 or var_186_18 * (var_186_22 / var_186_21)

				if var_186_23 > 0 and var_186_18 < var_186_23 then
					arg_183_1.talkMaxDuration = var_186_23

					if var_186_23 + var_186_17 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_17
					end
				end

				arg_183_1.text_.text = var_186_20
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_24 = math.max(var_186_18, arg_183_1.talkMaxDuration)

			if var_186_17 <= arg_183_1.time_ and arg_183_1.time_ < var_186_17 + var_186_24 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_17) / var_186_24

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_17 + var_186_24 and arg_183_1.time_ < var_186_17 + var_186_24 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play426041046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 426041046
		arg_187_1.duration_ = 11.4

		local var_187_0 = {
			zh = 6.365999999999,
			ja = 11.399999999999
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
				arg_187_0:Play426041047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.833333333333333

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				local var_190_1 = manager.ui.mainCamera.transform.localPosition
				local var_190_2 = Vector3.New(0, 0, 10) + Vector3.New(var_190_1.x, var_190_1.y, 0)
				local var_190_3 = arg_187_1.bgs_.ST2007a

				var_190_3.transform.localPosition = var_190_2
				var_190_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_4 = var_190_3:GetComponent("SpriteRenderer")

				if var_190_4 and var_190_4.sprite then
					local var_190_5 = (var_190_3.transform.localPosition - var_190_1).z
					local var_190_6 = manager.ui.mainCameraCom_
					local var_190_7 = 2 * var_190_5 * Mathf.Tan(var_190_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_190_8 = var_190_7 * var_190_6.aspect
					local var_190_9 = var_190_4.sprite.bounds.size.x
					local var_190_10 = var_190_4.sprite.bounds.size.y
					local var_190_11 = var_190_8 / var_190_9
					local var_190_12 = var_190_7 / var_190_10
					local var_190_13 = var_190_12 < var_190_11 and var_190_11 or var_190_12

					var_190_3.transform.localScale = Vector3.New(var_190_13, var_190_13, 0)
				end

				for iter_190_0, iter_190_1 in pairs(arg_187_1.bgs_) do
					if iter_190_0 ~= "ST2007a" then
						iter_190_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_190_14 = 2

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			local var_190_15 = 0.3

			if arg_187_1.time_ >= var_190_14 + var_190_15 and arg_187_1.time_ < var_190_14 + var_190_15 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_16 = arg_187_1.actors_["6148ui_story"].transform
			local var_190_17 = 2.2

			if var_190_17 < arg_187_1.time_ and arg_187_1.time_ <= var_190_17 + arg_190_0 then
				arg_187_1.var_.moveOldPos6148ui_story = var_190_16.localPosition

				local var_190_18 = GameObjectTools.GetOrAddComponent(var_190_16.gameObject, typeof(DynamicBoneHelper))

				if var_190_18 then
					var_190_18:EnableDynamicBone(false)
				end
			end

			local var_190_19 = 0.001

			if var_190_17 <= arg_187_1.time_ and arg_187_1.time_ < var_190_17 + var_190_19 then
				local var_190_20 = (arg_187_1.time_ - var_190_17) / var_190_19
				local var_190_21 = Vector3.New(0, -0.985, -6)

				var_190_16.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos6148ui_story, var_190_21, var_190_20)

				local var_190_22 = manager.ui.mainCamera.transform.position - var_190_16.position

				var_190_16.forward = Vector3.New(var_190_22.x, var_190_22.y, var_190_22.z)

				local var_190_23 = var_190_16.localEulerAngles

				var_190_23.z = 0
				var_190_23.x = 0
				var_190_16.localEulerAngles = var_190_23
			end

			if arg_187_1.time_ >= var_190_17 + var_190_19 and arg_187_1.time_ < var_190_17 + var_190_19 + arg_190_0 then
				var_190_16.localPosition = Vector3.New(0, -0.985, -6)

				local var_190_24 = manager.ui.mainCamera.transform.position - var_190_16.position

				var_190_16.forward = Vector3.New(var_190_24.x, var_190_24.y, var_190_24.z)

				local var_190_25 = var_190_16.localEulerAngles

				var_190_25.z = 0
				var_190_25.x = 0
				var_190_16.localEulerAngles = var_190_25

				local var_190_26 = GameObjectTools.GetOrAddComponent(var_190_16.gameObject, typeof(DynamicBoneHelper))

				if var_190_26 then
					var_190_26:EnableDynamicBone(true)
				end
			end

			local var_190_27 = arg_187_1.actors_["6148ui_story"]
			local var_190_28 = 2.2

			if var_190_28 < arg_187_1.time_ and arg_187_1.time_ <= var_190_28 + arg_190_0 and not isNil(var_190_27) and arg_187_1.var_.characterEffect6148ui_story == nil then
				arg_187_1.var_.characterEffect6148ui_story = var_190_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_29 = 0.200000002980232

			if var_190_28 <= arg_187_1.time_ and arg_187_1.time_ < var_190_28 + var_190_29 and not isNil(var_190_27) then
				local var_190_30 = (arg_187_1.time_ - var_190_28) / var_190_29

				if arg_187_1.var_.characterEffect6148ui_story and not isNil(var_190_27) then
					arg_187_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_28 + var_190_29 and arg_187_1.time_ < var_190_28 + var_190_29 + arg_190_0 and not isNil(var_190_27) and arg_187_1.var_.characterEffect6148ui_story then
				arg_187_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_190_31 = 2.2

			if var_190_31 < arg_187_1.time_ and arg_187_1.time_ <= var_190_31 + arg_190_0 then
				arg_187_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_190_32 = 2.2

			if var_190_32 < arg_187_1.time_ and arg_187_1.time_ <= var_190_32 + arg_190_0 then
				arg_187_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_190_33 = 0.6
			local var_190_34 = 1

			if var_190_33 < arg_187_1.time_ and arg_187_1.time_ <= var_190_33 + arg_190_0 then
				local var_190_35 = "stop"
				local var_190_36 = "effect"

				arg_187_1:AudioAction(var_190_35, var_190_36, "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			local var_190_37 = 1.09099999815226
			local var_190_38 = 1

			if var_190_37 < arg_187_1.time_ and arg_187_1.time_ <= var_190_37 + arg_190_0 then
				local var_190_39 = "play"
				local var_190_40 = "effect"

				arg_187_1:AudioAction(var_190_39, var_190_40, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_190_41 = manager.ui.mainCamera.transform
			local var_190_42 = 0

			if var_190_42 < arg_187_1.time_ and arg_187_1.time_ <= var_190_42 + arg_190_0 then
				local var_190_43 = arg_187_1.var_.effectchifanzhuanchang1
				local var_190_44
				local var_190_45 = var_190_41

				if not var_190_43 then
					var_190_43 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_190_45)
					var_190_43.name = "chifanzhuanchang1"
					arg_187_1.var_.effectchifanzhuanchang1 = var_190_43
				else
					var_190_43.transform:SetParent(var_190_45)
				end

				var_190_43.transform.localPosition = Vector3.New(0, 0, 0)
				var_190_43.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_190_46 = 1.7777777777777777
				local var_190_47 = Screen.width / Screen.height
				local var_190_48 = var_190_47 / var_190_46
				local var_190_49 = Mathf.Max(var_190_46 / var_190_47, 1)

				var_190_43.transform.localScale = Vector3.New(var_190_43.transform.localScale.x * var_190_48, var_190_43.transform.localScale.y * var_190_49, var_190_43.transform.localScale.z)
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_50 = 1.999999999999
			local var_190_51 = 0.525

			if var_190_50 < arg_187_1.time_ and arg_187_1.time_ <= var_190_50 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_52 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_52:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_53 = arg_187_1:FormatText(StoryNameCfg[1488].name)

				arg_187_1.leftNameTxt_.text = var_190_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_54 = arg_187_1:GetWordFromCfg(426041046)
				local var_190_55 = arg_187_1:FormatText(var_190_54.content)

				arg_187_1.text_.text = var_190_55

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_56 = 21
				local var_190_57 = utf8.len(var_190_55)
				local var_190_58 = var_190_56 <= 0 and var_190_51 or var_190_51 * (var_190_57 / var_190_56)

				if var_190_58 > 0 and var_190_51 < var_190_58 then
					arg_187_1.talkMaxDuration = var_190_58
					var_190_50 = var_190_50 + 0.3

					if var_190_58 + var_190_50 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_58 + var_190_50
					end
				end

				arg_187_1.text_.text = var_190_55
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041046", "story_v_out_426041.awb") ~= 0 then
					local var_190_59 = manager.audio:GetVoiceLength("story_v_out_426041", "426041046", "story_v_out_426041.awb") / 1000

					if var_190_59 + var_190_50 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_59 + var_190_50
					end

					if var_190_54.prefab_name ~= "" and arg_187_1.actors_[var_190_54.prefab_name] ~= nil then
						local var_190_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_54.prefab_name].transform, "story_v_out_426041", "426041046", "story_v_out_426041.awb")

						arg_187_1:RecordAudio("426041046", var_190_60)
						arg_187_1:RecordAudio("426041046", var_190_60)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_426041", "426041046", "story_v_out_426041.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_426041", "426041046", "story_v_out_426041.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_61 = var_190_50 + 0.3
			local var_190_62 = math.max(var_190_51, arg_187_1.talkMaxDuration)

			if var_190_61 <= arg_187_1.time_ and arg_187_1.time_ < var_190_61 + var_190_62 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_61) / var_190_62

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_61 + var_190_62 and arg_187_1.time_ < var_190_61 + var_190_62 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play426041047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 426041047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play426041048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["6148ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect6148ui_story == nil then
				arg_193_1.var_.characterEffect6148ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect6148ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_193_1.var_.characterEffect6148ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect6148ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_193_1.var_.characterEffect6148ui_story.fillRatio = var_196_5
			end

			local var_196_6 = 0
			local var_196_7 = 0.125

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

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_9 = arg_193_1:GetWordFromCfg(426041047)
				local var_196_10 = arg_193_1:FormatText(var_196_9.content)

				arg_193_1.text_.text = var_196_10

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 5
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
	Play426041048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 426041048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play426041049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["6148ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos6148ui_story = var_200_0.localPosition

				local var_200_2 = GameObjectTools.GetOrAddComponent(var_200_0.gameObject, typeof(DynamicBoneHelper))

				if var_200_2 then
					var_200_2:EnableDynamicBone(false)
				end
			end

			local var_200_3 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_3 then
				local var_200_4 = (arg_197_1.time_ - var_200_1) / var_200_3
				local var_200_5 = Vector3.New(0, 100, 0)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos6148ui_story, var_200_5, var_200_4)

				local var_200_6 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_6.x, var_200_6.y, var_200_6.z)

				local var_200_7 = var_200_0.localEulerAngles

				var_200_7.z = 0
				var_200_7.x = 0
				var_200_0.localEulerAngles = var_200_7
			end

			if arg_197_1.time_ >= var_200_1 + var_200_3 and arg_197_1.time_ < var_200_1 + var_200_3 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, 100, 0)

				local var_200_8 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_8.x, var_200_8.y, var_200_8.z)

				local var_200_9 = var_200_0.localEulerAngles

				var_200_9.z = 0
				var_200_9.x = 0
				var_200_0.localEulerAngles = var_200_9

				local var_200_10 = GameObjectTools.GetOrAddComponent(var_200_0.gameObject, typeof(DynamicBoneHelper))

				if var_200_10 then
					var_200_10:EnableDynamicBone(true)
				end
			end

			local var_200_11 = 0
			local var_200_12 = 1.075

			if var_200_11 < arg_197_1.time_ and arg_197_1.time_ <= var_200_11 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_13 = arg_197_1:GetWordFromCfg(426041048)
				local var_200_14 = arg_197_1:FormatText(var_200_13.content)

				arg_197_1.text_.text = var_200_14

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_15 = 43
				local var_200_16 = utf8.len(var_200_14)
				local var_200_17 = var_200_15 <= 0 and var_200_12 or var_200_12 * (var_200_16 / var_200_15)

				if var_200_17 > 0 and var_200_12 < var_200_17 then
					arg_197_1.talkMaxDuration = var_200_17

					if var_200_17 + var_200_11 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_17 + var_200_11
					end
				end

				arg_197_1.text_.text = var_200_14
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_18 = math.max(var_200_12, arg_197_1.talkMaxDuration)

			if var_200_11 <= arg_197_1.time_ and arg_197_1.time_ < var_200_11 + var_200_18 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_11) / var_200_18

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_11 + var_200_18 and arg_197_1.time_ < var_200_11 + var_200_18 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play426041049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 426041049
		arg_201_1.duration_ = 11.13

		local var_201_0 = {
			zh = 7.066,
			ja = 11.133
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
				arg_201_0:Play426041050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["6148ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos6148ui_story = var_204_0.localPosition

				local var_204_2 = GameObjectTools.GetOrAddComponent(var_204_0.gameObject, typeof(DynamicBoneHelper))

				if var_204_2 then
					var_204_2:EnableDynamicBone(false)
				end
			end

			local var_204_3 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_3 then
				local var_204_4 = (arg_201_1.time_ - var_204_1) / var_204_3
				local var_204_5 = Vector3.New(0, -0.985, -6)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos6148ui_story, var_204_5, var_204_4)

				local var_204_6 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_6.x, var_204_6.y, var_204_6.z)

				local var_204_7 = var_204_0.localEulerAngles

				var_204_7.z = 0
				var_204_7.x = 0
				var_204_0.localEulerAngles = var_204_7
			end

			if arg_201_1.time_ >= var_204_1 + var_204_3 and arg_201_1.time_ < var_204_1 + var_204_3 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_204_8 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_8.x, var_204_8.y, var_204_8.z)

				local var_204_9 = var_204_0.localEulerAngles

				var_204_9.z = 0
				var_204_9.x = 0
				var_204_0.localEulerAngles = var_204_9

				local var_204_10 = GameObjectTools.GetOrAddComponent(var_204_0.gameObject, typeof(DynamicBoneHelper))

				if var_204_10 then
					var_204_10:EnableDynamicBone(true)
				end
			end

			local var_204_11 = arg_201_1.actors_["6148ui_story"]
			local var_204_12 = 0

			if var_204_12 < arg_201_1.time_ and arg_201_1.time_ <= var_204_12 + arg_204_0 and not isNil(var_204_11) and arg_201_1.var_.characterEffect6148ui_story == nil then
				arg_201_1.var_.characterEffect6148ui_story = var_204_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_13 = 0.200000002980232

			if var_204_12 <= arg_201_1.time_ and arg_201_1.time_ < var_204_12 + var_204_13 and not isNil(var_204_11) then
				local var_204_14 = (arg_201_1.time_ - var_204_12) / var_204_13

				if arg_201_1.var_.characterEffect6148ui_story and not isNil(var_204_11) then
					arg_201_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_12 + var_204_13 and arg_201_1.time_ < var_204_12 + var_204_13 + arg_204_0 and not isNil(var_204_11) and arg_201_1.var_.characterEffect6148ui_story then
				arg_201_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_204_15 = 0

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 then
				arg_201_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_204_17 = 0
			local var_204_18 = 0.825

			if var_204_17 < arg_201_1.time_ and arg_201_1.time_ <= var_204_17 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_19 = arg_201_1:FormatText(StoryNameCfg[1488].name)

				arg_201_1.leftNameTxt_.text = var_204_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_20 = arg_201_1:GetWordFromCfg(426041049)
				local var_204_21 = arg_201_1:FormatText(var_204_20.content)

				arg_201_1.text_.text = var_204_21

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_22 = 33
				local var_204_23 = utf8.len(var_204_21)
				local var_204_24 = var_204_22 <= 0 and var_204_18 or var_204_18 * (var_204_23 / var_204_22)

				if var_204_24 > 0 and var_204_18 < var_204_24 then
					arg_201_1.talkMaxDuration = var_204_24

					if var_204_24 + var_204_17 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_24 + var_204_17
					end
				end

				arg_201_1.text_.text = var_204_21
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041049", "story_v_out_426041.awb") ~= 0 then
					local var_204_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041049", "story_v_out_426041.awb") / 1000

					if var_204_25 + var_204_17 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_25 + var_204_17
					end

					if var_204_20.prefab_name ~= "" and arg_201_1.actors_[var_204_20.prefab_name] ~= nil then
						local var_204_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_20.prefab_name].transform, "story_v_out_426041", "426041049", "story_v_out_426041.awb")

						arg_201_1:RecordAudio("426041049", var_204_26)
						arg_201_1:RecordAudio("426041049", var_204_26)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_426041", "426041049", "story_v_out_426041.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_426041", "426041049", "story_v_out_426041.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_27 = math.max(var_204_18, arg_201_1.talkMaxDuration)

			if var_204_17 <= arg_201_1.time_ and arg_201_1.time_ < var_204_17 + var_204_27 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_17) / var_204_27

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_17 + var_204_27 and arg_201_1.time_ < var_204_17 + var_204_27 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play426041050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 426041050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play426041051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["6148ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect6148ui_story == nil then
				arg_205_1.var_.characterEffect6148ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect6148ui_story and not isNil(var_208_0) then
					local var_208_4 = Mathf.Lerp(0, 0.5, var_208_3)

					arg_205_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_205_1.var_.characterEffect6148ui_story.fillRatio = var_208_4
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect6148ui_story then
				local var_208_5 = 0.5

				arg_205_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_205_1.var_.characterEffect6148ui_story.fillRatio = var_208_5
			end

			local var_208_6 = 0
			local var_208_7 = 0.8

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

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_9 = arg_205_1:GetWordFromCfg(426041050)
				local var_208_10 = arg_205_1:FormatText(var_208_9.content)

				arg_205_1.text_.text = var_208_10

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_11 = 32
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
	Play426041051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 426041051
		arg_209_1.duration_ = 4.9

		local var_209_0 = {
			zh = 2.633,
			ja = 4.9
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
				arg_209_0:Play426041052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["6148ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos6148ui_story = var_212_0.localPosition

				local var_212_2 = GameObjectTools.GetOrAddComponent(var_212_0.gameObject, typeof(DynamicBoneHelper))

				if var_212_2 then
					var_212_2:EnableDynamicBone(false)
				end
			end

			local var_212_3 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_3 then
				local var_212_4 = (arg_209_1.time_ - var_212_1) / var_212_3
				local var_212_5 = Vector3.New(0, -0.985, -6)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos6148ui_story, var_212_5, var_212_4)

				local var_212_6 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_6.x, var_212_6.y, var_212_6.z)

				local var_212_7 = var_212_0.localEulerAngles

				var_212_7.z = 0
				var_212_7.x = 0
				var_212_0.localEulerAngles = var_212_7
			end

			if arg_209_1.time_ >= var_212_1 + var_212_3 and arg_209_1.time_ < var_212_1 + var_212_3 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_212_8 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_8.x, var_212_8.y, var_212_8.z)

				local var_212_9 = var_212_0.localEulerAngles

				var_212_9.z = 0
				var_212_9.x = 0
				var_212_0.localEulerAngles = var_212_9

				local var_212_10 = GameObjectTools.GetOrAddComponent(var_212_0.gameObject, typeof(DynamicBoneHelper))

				if var_212_10 then
					var_212_10:EnableDynamicBone(true)
				end
			end

			local var_212_11 = arg_209_1.actors_["6148ui_story"]
			local var_212_12 = 0

			if var_212_12 < arg_209_1.time_ and arg_209_1.time_ <= var_212_12 + arg_212_0 and not isNil(var_212_11) and arg_209_1.var_.characterEffect6148ui_story == nil then
				arg_209_1.var_.characterEffect6148ui_story = var_212_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_13 = 0.200000002980232

			if var_212_12 <= arg_209_1.time_ and arg_209_1.time_ < var_212_12 + var_212_13 and not isNil(var_212_11) then
				local var_212_14 = (arg_209_1.time_ - var_212_12) / var_212_13

				if arg_209_1.var_.characterEffect6148ui_story and not isNil(var_212_11) then
					arg_209_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_12 + var_212_13 and arg_209_1.time_ < var_212_12 + var_212_13 + arg_212_0 and not isNil(var_212_11) and arg_209_1.var_.characterEffect6148ui_story then
				arg_209_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_212_15 = 0

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 then
				arg_209_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_212_17 = 0
			local var_212_18 = 0.35

			if var_212_17 < arg_209_1.time_ and arg_209_1.time_ <= var_212_17 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_19 = arg_209_1:FormatText(StoryNameCfg[1488].name)

				arg_209_1.leftNameTxt_.text = var_212_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_20 = arg_209_1:GetWordFromCfg(426041051)
				local var_212_21 = arg_209_1:FormatText(var_212_20.content)

				arg_209_1.text_.text = var_212_21

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_22 = 14
				local var_212_23 = utf8.len(var_212_21)
				local var_212_24 = var_212_22 <= 0 and var_212_18 or var_212_18 * (var_212_23 / var_212_22)

				if var_212_24 > 0 and var_212_18 < var_212_24 then
					arg_209_1.talkMaxDuration = var_212_24

					if var_212_24 + var_212_17 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_24 + var_212_17
					end
				end

				arg_209_1.text_.text = var_212_21
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041051", "story_v_out_426041.awb") ~= 0 then
					local var_212_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041051", "story_v_out_426041.awb") / 1000

					if var_212_25 + var_212_17 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_25 + var_212_17
					end

					if var_212_20.prefab_name ~= "" and arg_209_1.actors_[var_212_20.prefab_name] ~= nil then
						local var_212_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_20.prefab_name].transform, "story_v_out_426041", "426041051", "story_v_out_426041.awb")

						arg_209_1:RecordAudio("426041051", var_212_26)
						arg_209_1:RecordAudio("426041051", var_212_26)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_426041", "426041051", "story_v_out_426041.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_426041", "426041051", "story_v_out_426041.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_27 = math.max(var_212_18, arg_209_1.talkMaxDuration)

			if var_212_17 <= arg_209_1.time_ and arg_209_1.time_ < var_212_17 + var_212_27 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_17) / var_212_27

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_17 + var_212_27 and arg_209_1.time_ < var_212_17 + var_212_27 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426041052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 426041052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play426041053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["6148ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos6148ui_story = var_216_0.localPosition

				local var_216_2 = GameObjectTools.GetOrAddComponent(var_216_0.gameObject, typeof(DynamicBoneHelper))

				if var_216_2 then
					var_216_2:EnableDynamicBone(false)
				end
			end

			local var_216_3 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_3 then
				local var_216_4 = (arg_213_1.time_ - var_216_1) / var_216_3
				local var_216_5 = Vector3.New(0, 100, 0)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos6148ui_story, var_216_5, var_216_4)

				local var_216_6 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_6.x, var_216_6.y, var_216_6.z)

				local var_216_7 = var_216_0.localEulerAngles

				var_216_7.z = 0
				var_216_7.x = 0
				var_216_0.localEulerAngles = var_216_7
			end

			if arg_213_1.time_ >= var_216_1 + var_216_3 and arg_213_1.time_ < var_216_1 + var_216_3 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, 100, 0)

				local var_216_8 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_8.x, var_216_8.y, var_216_8.z)

				local var_216_9 = var_216_0.localEulerAngles

				var_216_9.z = 0
				var_216_9.x = 0
				var_216_0.localEulerAngles = var_216_9

				local var_216_10 = GameObjectTools.GetOrAddComponent(var_216_0.gameObject, typeof(DynamicBoneHelper))

				if var_216_10 then
					var_216_10:EnableDynamicBone(true)
				end
			end

			local var_216_11 = arg_213_1.actors_["6148ui_story"]
			local var_216_12 = 0

			if var_216_12 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 and not isNil(var_216_11) and arg_213_1.var_.characterEffect6148ui_story == nil then
				arg_213_1.var_.characterEffect6148ui_story = var_216_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_13 = 0.200000002980232

			if var_216_12 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_13 and not isNil(var_216_11) then
				local var_216_14 = (arg_213_1.time_ - var_216_12) / var_216_13

				if arg_213_1.var_.characterEffect6148ui_story and not isNil(var_216_11) then
					local var_216_15 = Mathf.Lerp(0, 0.5, var_216_14)

					arg_213_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_213_1.var_.characterEffect6148ui_story.fillRatio = var_216_15
				end
			end

			if arg_213_1.time_ >= var_216_12 + var_216_13 and arg_213_1.time_ < var_216_12 + var_216_13 + arg_216_0 and not isNil(var_216_11) and arg_213_1.var_.characterEffect6148ui_story then
				local var_216_16 = 0.5

				arg_213_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_213_1.var_.characterEffect6148ui_story.fillRatio = var_216_16
			end

			local var_216_17 = 0
			local var_216_18 = 0.9

			if var_216_17 < arg_213_1.time_ and arg_213_1.time_ <= var_216_17 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_19 = arg_213_1:GetWordFromCfg(426041052)
				local var_216_20 = arg_213_1:FormatText(var_216_19.content)

				arg_213_1.text_.text = var_216_20

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_21 = 36
				local var_216_22 = utf8.len(var_216_20)
				local var_216_23 = var_216_21 <= 0 and var_216_18 or var_216_18 * (var_216_22 / var_216_21)

				if var_216_23 > 0 and var_216_18 < var_216_23 then
					arg_213_1.talkMaxDuration = var_216_23

					if var_216_23 + var_216_17 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_23 + var_216_17
					end
				end

				arg_213_1.text_.text = var_216_20
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_24 = math.max(var_216_18, arg_213_1.talkMaxDuration)

			if var_216_17 <= arg_213_1.time_ and arg_213_1.time_ < var_216_17 + var_216_24 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_17) / var_216_24

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_17 + var_216_24 and arg_213_1.time_ < var_216_17 + var_216_24 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play426041053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 426041053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play426041054(arg_217_1)
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

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(426041053)
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
	Play426041054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 426041054
		arg_221_1.duration_ = 9.2

		local var_221_0 = {
			zh = 7.4,
			ja = 9.2
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
				arg_221_0:Play426041055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["6148ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos6148ui_story = var_224_0.localPosition

				local var_224_2 = GameObjectTools.GetOrAddComponent(var_224_0.gameObject, typeof(DynamicBoneHelper))

				if var_224_2 then
					var_224_2:EnableDynamicBone(false)
				end
			end

			local var_224_3 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_3 then
				local var_224_4 = (arg_221_1.time_ - var_224_1) / var_224_3
				local var_224_5 = Vector3.New(0, -0.985, -6)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos6148ui_story, var_224_5, var_224_4)

				local var_224_6 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_6.x, var_224_6.y, var_224_6.z)

				local var_224_7 = var_224_0.localEulerAngles

				var_224_7.z = 0
				var_224_7.x = 0
				var_224_0.localEulerAngles = var_224_7
			end

			if arg_221_1.time_ >= var_224_1 + var_224_3 and arg_221_1.time_ < var_224_1 + var_224_3 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_224_8 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_8.x, var_224_8.y, var_224_8.z)

				local var_224_9 = var_224_0.localEulerAngles

				var_224_9.z = 0
				var_224_9.x = 0
				var_224_0.localEulerAngles = var_224_9

				local var_224_10 = GameObjectTools.GetOrAddComponent(var_224_0.gameObject, typeof(DynamicBoneHelper))

				if var_224_10 then
					var_224_10:EnableDynamicBone(true)
				end
			end

			local var_224_11 = arg_221_1.actors_["6148ui_story"]
			local var_224_12 = 0

			if var_224_12 < arg_221_1.time_ and arg_221_1.time_ <= var_224_12 + arg_224_0 and not isNil(var_224_11) and arg_221_1.var_.characterEffect6148ui_story == nil then
				arg_221_1.var_.characterEffect6148ui_story = var_224_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_13 = 0.200000002980232

			if var_224_12 <= arg_221_1.time_ and arg_221_1.time_ < var_224_12 + var_224_13 and not isNil(var_224_11) then
				local var_224_14 = (arg_221_1.time_ - var_224_12) / var_224_13

				if arg_221_1.var_.characterEffect6148ui_story and not isNil(var_224_11) then
					arg_221_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_12 + var_224_13 and arg_221_1.time_ < var_224_12 + var_224_13 + arg_224_0 and not isNil(var_224_11) and arg_221_1.var_.characterEffect6148ui_story then
				arg_221_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_224_15 = 0

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 then
				arg_221_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_224_17 = 0
			local var_224_18 = 0.9

			if var_224_17 < arg_221_1.time_ and arg_221_1.time_ <= var_224_17 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_19 = arg_221_1:FormatText(StoryNameCfg[1488].name)

				arg_221_1.leftNameTxt_.text = var_224_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_20 = arg_221_1:GetWordFromCfg(426041054)
				local var_224_21 = arg_221_1:FormatText(var_224_20.content)

				arg_221_1.text_.text = var_224_21

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_22 = 36
				local var_224_23 = utf8.len(var_224_21)
				local var_224_24 = var_224_22 <= 0 and var_224_18 or var_224_18 * (var_224_23 / var_224_22)

				if var_224_24 > 0 and var_224_18 < var_224_24 then
					arg_221_1.talkMaxDuration = var_224_24

					if var_224_24 + var_224_17 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_24 + var_224_17
					end
				end

				arg_221_1.text_.text = var_224_21
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041054", "story_v_out_426041.awb") ~= 0 then
					local var_224_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041054", "story_v_out_426041.awb") / 1000

					if var_224_25 + var_224_17 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_25 + var_224_17
					end

					if var_224_20.prefab_name ~= "" and arg_221_1.actors_[var_224_20.prefab_name] ~= nil then
						local var_224_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_20.prefab_name].transform, "story_v_out_426041", "426041054", "story_v_out_426041.awb")

						arg_221_1:RecordAudio("426041054", var_224_26)
						arg_221_1:RecordAudio("426041054", var_224_26)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_426041", "426041054", "story_v_out_426041.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_426041", "426041054", "story_v_out_426041.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_27 = math.max(var_224_18, arg_221_1.talkMaxDuration)

			if var_224_17 <= arg_221_1.time_ and arg_221_1.time_ < var_224_17 + var_224_27 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_17) / var_224_27

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_17 + var_224_27 and arg_221_1.time_ < var_224_17 + var_224_27 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426041055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 426041055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play426041056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["6148ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect6148ui_story == nil then
				arg_225_1.var_.characterEffect6148ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect6148ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_225_1.var_.characterEffect6148ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect6148ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_225_1.var_.characterEffect6148ui_story.fillRatio = var_228_5
			end

			local var_228_6 = 0
			local var_228_7 = 0.7

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_8 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_9 = arg_225_1:GetWordFromCfg(426041055)
				local var_228_10 = arg_225_1:FormatText(var_228_9.content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 28
				local var_228_12 = utf8.len(var_228_10)
				local var_228_13 = var_228_11 <= 0 and var_228_7 or var_228_7 * (var_228_12 / var_228_11)

				if var_228_13 > 0 and var_228_7 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_10
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play426041056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 426041056
		arg_229_1.duration_ = 14.93

		local var_229_0 = {
			zh = 8.833,
			ja = 14.933
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
				arg_229_0:Play426041057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["6148ui_story"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos6148ui_story = var_232_0.localPosition

				local var_232_2 = GameObjectTools.GetOrAddComponent(var_232_0.gameObject, typeof(DynamicBoneHelper))

				if var_232_2 then
					var_232_2:EnableDynamicBone(false)
				end
			end

			local var_232_3 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_3 then
				local var_232_4 = (arg_229_1.time_ - var_232_1) / var_232_3
				local var_232_5 = Vector3.New(0, -0.985, -6)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos6148ui_story, var_232_5, var_232_4)

				local var_232_6 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_6.x, var_232_6.y, var_232_6.z)

				local var_232_7 = var_232_0.localEulerAngles

				var_232_7.z = 0
				var_232_7.x = 0
				var_232_0.localEulerAngles = var_232_7
			end

			if arg_229_1.time_ >= var_232_1 + var_232_3 and arg_229_1.time_ < var_232_1 + var_232_3 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_232_8 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_8.x, var_232_8.y, var_232_8.z)

				local var_232_9 = var_232_0.localEulerAngles

				var_232_9.z = 0
				var_232_9.x = 0
				var_232_0.localEulerAngles = var_232_9

				local var_232_10 = GameObjectTools.GetOrAddComponent(var_232_0.gameObject, typeof(DynamicBoneHelper))

				if var_232_10 then
					var_232_10:EnableDynamicBone(true)
				end
			end

			local var_232_11 = arg_229_1.actors_["6148ui_story"]
			local var_232_12 = 0

			if var_232_12 < arg_229_1.time_ and arg_229_1.time_ <= var_232_12 + arg_232_0 and not isNil(var_232_11) and arg_229_1.var_.characterEffect6148ui_story == nil then
				arg_229_1.var_.characterEffect6148ui_story = var_232_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_13 = 0.200000002980232

			if var_232_12 <= arg_229_1.time_ and arg_229_1.time_ < var_232_12 + var_232_13 and not isNil(var_232_11) then
				local var_232_14 = (arg_229_1.time_ - var_232_12) / var_232_13

				if arg_229_1.var_.characterEffect6148ui_story and not isNil(var_232_11) then
					arg_229_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_12 + var_232_13 and arg_229_1.time_ < var_232_12 + var_232_13 + arg_232_0 and not isNil(var_232_11) and arg_229_1.var_.characterEffect6148ui_story then
				arg_229_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_232_15 = 0

			if var_232_15 < arg_229_1.time_ and arg_229_1.time_ <= var_232_15 + arg_232_0 then
				arg_229_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_232_16 = 0

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 then
				arg_229_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_232_17 = 0
			local var_232_18 = 1.125

			if var_232_17 < arg_229_1.time_ and arg_229_1.time_ <= var_232_17 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_19 = arg_229_1:FormatText(StoryNameCfg[1488].name)

				arg_229_1.leftNameTxt_.text = var_232_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_20 = arg_229_1:GetWordFromCfg(426041056)
				local var_232_21 = arg_229_1:FormatText(var_232_20.content)

				arg_229_1.text_.text = var_232_21

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_22 = 45
				local var_232_23 = utf8.len(var_232_21)
				local var_232_24 = var_232_22 <= 0 and var_232_18 or var_232_18 * (var_232_23 / var_232_22)

				if var_232_24 > 0 and var_232_18 < var_232_24 then
					arg_229_1.talkMaxDuration = var_232_24

					if var_232_24 + var_232_17 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_24 + var_232_17
					end
				end

				arg_229_1.text_.text = var_232_21
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041056", "story_v_out_426041.awb") ~= 0 then
					local var_232_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041056", "story_v_out_426041.awb") / 1000

					if var_232_25 + var_232_17 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_25 + var_232_17
					end

					if var_232_20.prefab_name ~= "" and arg_229_1.actors_[var_232_20.prefab_name] ~= nil then
						local var_232_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_20.prefab_name].transform, "story_v_out_426041", "426041056", "story_v_out_426041.awb")

						arg_229_1:RecordAudio("426041056", var_232_26)
						arg_229_1:RecordAudio("426041056", var_232_26)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_426041", "426041056", "story_v_out_426041.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_426041", "426041056", "story_v_out_426041.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_27 = math.max(var_232_18, arg_229_1.talkMaxDuration)

			if var_232_17 <= arg_229_1.time_ and arg_229_1.time_ < var_232_17 + var_232_27 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_17) / var_232_27

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_17 + var_232_27 and arg_229_1.time_ < var_232_17 + var_232_27 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play426041057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 426041057
		arg_233_1.duration_ = 10.73

		local var_233_0 = {
			zh = 10.266,
			ja = 10.733
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
				arg_233_0:Play426041058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 1.275

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[1488].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_3 = arg_233_1:GetWordFromCfg(426041057)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 51
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041057", "story_v_out_426041.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_426041", "426041057", "story_v_out_426041.awb") / 1000

					if var_236_8 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_0
					end

					if var_236_3.prefab_name ~= "" and arg_233_1.actors_[var_236_3.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_3.prefab_name].transform, "story_v_out_426041", "426041057", "story_v_out_426041.awb")

						arg_233_1:RecordAudio("426041057", var_236_9)
						arg_233_1:RecordAudio("426041057", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_426041", "426041057", "story_v_out_426041.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_426041", "426041057", "story_v_out_426041.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_10 and arg_233_1.time_ < var_236_0 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play426041058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 426041058
		arg_237_1.duration_ = 7.8

		local var_237_0 = {
			zh = 5.9,
			ja = 7.8
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
				arg_237_0:Play426041059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["6148ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos6148ui_story = var_240_0.localPosition

				local var_240_2 = GameObjectTools.GetOrAddComponent(var_240_0.gameObject, typeof(DynamicBoneHelper))

				if var_240_2 then
					var_240_2:EnableDynamicBone(false)
				end
			end

			local var_240_3 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_3 then
				local var_240_4 = (arg_237_1.time_ - var_240_1) / var_240_3
				local var_240_5 = Vector3.New(0, -0.985, -6)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos6148ui_story, var_240_5, var_240_4)

				local var_240_6 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_6.x, var_240_6.y, var_240_6.z)

				local var_240_7 = var_240_0.localEulerAngles

				var_240_7.z = 0
				var_240_7.x = 0
				var_240_0.localEulerAngles = var_240_7
			end

			if arg_237_1.time_ >= var_240_1 + var_240_3 and arg_237_1.time_ < var_240_1 + var_240_3 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_240_8 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_8.x, var_240_8.y, var_240_8.z)

				local var_240_9 = var_240_0.localEulerAngles

				var_240_9.z = 0
				var_240_9.x = 0
				var_240_0.localEulerAngles = var_240_9

				local var_240_10 = GameObjectTools.GetOrAddComponent(var_240_0.gameObject, typeof(DynamicBoneHelper))

				if var_240_10 then
					var_240_10:EnableDynamicBone(true)
				end
			end

			local var_240_11 = 0

			if var_240_11 < arg_237_1.time_ and arg_237_1.time_ <= var_240_11 + arg_240_0 then
				arg_237_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_240_12 = 0

			if var_240_12 < arg_237_1.time_ and arg_237_1.time_ <= var_240_12 + arg_240_0 then
				arg_237_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_240_13 = 0
			local var_240_14 = 0.725

			if var_240_13 < arg_237_1.time_ and arg_237_1.time_ <= var_240_13 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_15 = arg_237_1:FormatText(StoryNameCfg[1488].name)

				arg_237_1.leftNameTxt_.text = var_240_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_16 = arg_237_1:GetWordFromCfg(426041058)
				local var_240_17 = arg_237_1:FormatText(var_240_16.content)

				arg_237_1.text_.text = var_240_17

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_18 = 29
				local var_240_19 = utf8.len(var_240_17)
				local var_240_20 = var_240_18 <= 0 and var_240_14 or var_240_14 * (var_240_19 / var_240_18)

				if var_240_20 > 0 and var_240_14 < var_240_20 then
					arg_237_1.talkMaxDuration = var_240_20

					if var_240_20 + var_240_13 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_20 + var_240_13
					end
				end

				arg_237_1.text_.text = var_240_17
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041058", "story_v_out_426041.awb") ~= 0 then
					local var_240_21 = manager.audio:GetVoiceLength("story_v_out_426041", "426041058", "story_v_out_426041.awb") / 1000

					if var_240_21 + var_240_13 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_21 + var_240_13
					end

					if var_240_16.prefab_name ~= "" and arg_237_1.actors_[var_240_16.prefab_name] ~= nil then
						local var_240_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_16.prefab_name].transform, "story_v_out_426041", "426041058", "story_v_out_426041.awb")

						arg_237_1:RecordAudio("426041058", var_240_22)
						arg_237_1:RecordAudio("426041058", var_240_22)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_426041", "426041058", "story_v_out_426041.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_426041", "426041058", "story_v_out_426041.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_23 = math.max(var_240_14, arg_237_1.talkMaxDuration)

			if var_240_13 <= arg_237_1.time_ and arg_237_1.time_ < var_240_13 + var_240_23 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_13) / var_240_23

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_13 + var_240_23 and arg_237_1.time_ < var_240_13 + var_240_23 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426041059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 426041059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play426041060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["6148ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos6148ui_story = var_244_0.localPosition

				local var_244_2 = GameObjectTools.GetOrAddComponent(var_244_0.gameObject, typeof(DynamicBoneHelper))

				if var_244_2 then
					var_244_2:EnableDynamicBone(false)
				end
			end

			local var_244_3 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_3 then
				local var_244_4 = (arg_241_1.time_ - var_244_1) / var_244_3
				local var_244_5 = Vector3.New(0, 100, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos6148ui_story, var_244_5, var_244_4)

				local var_244_6 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_6.x, var_244_6.y, var_244_6.z)

				local var_244_7 = var_244_0.localEulerAngles

				var_244_7.z = 0
				var_244_7.x = 0
				var_244_0.localEulerAngles = var_244_7
			end

			if arg_241_1.time_ >= var_244_1 + var_244_3 and arg_241_1.time_ < var_244_1 + var_244_3 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, 100, 0)

				local var_244_8 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_8.x, var_244_8.y, var_244_8.z)

				local var_244_9 = var_244_0.localEulerAngles

				var_244_9.z = 0
				var_244_9.x = 0
				var_244_0.localEulerAngles = var_244_9

				local var_244_10 = GameObjectTools.GetOrAddComponent(var_244_0.gameObject, typeof(DynamicBoneHelper))

				if var_244_10 then
					var_244_10:EnableDynamicBone(true)
				end
			end

			local var_244_11 = arg_241_1.actors_["6148ui_story"]
			local var_244_12 = 0

			if var_244_12 < arg_241_1.time_ and arg_241_1.time_ <= var_244_12 + arg_244_0 and not isNil(var_244_11) and arg_241_1.var_.characterEffect6148ui_story == nil then
				arg_241_1.var_.characterEffect6148ui_story = var_244_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_13 = 0.200000002980232

			if var_244_12 <= arg_241_1.time_ and arg_241_1.time_ < var_244_12 + var_244_13 and not isNil(var_244_11) then
				local var_244_14 = (arg_241_1.time_ - var_244_12) / var_244_13

				if arg_241_1.var_.characterEffect6148ui_story and not isNil(var_244_11) then
					local var_244_15 = Mathf.Lerp(0, 0.5, var_244_14)

					arg_241_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_241_1.var_.characterEffect6148ui_story.fillRatio = var_244_15
				end
			end

			if arg_241_1.time_ >= var_244_12 + var_244_13 and arg_241_1.time_ < var_244_12 + var_244_13 + arg_244_0 and not isNil(var_244_11) and arg_241_1.var_.characterEffect6148ui_story then
				local var_244_16 = 0.5

				arg_241_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_241_1.var_.characterEffect6148ui_story.fillRatio = var_244_16
			end

			local var_244_17 = 0
			local var_244_18 = 0.925

			if var_244_17 < arg_241_1.time_ and arg_241_1.time_ <= var_244_17 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_19 = arg_241_1:GetWordFromCfg(426041059)
				local var_244_20 = arg_241_1:FormatText(var_244_19.content)

				arg_241_1.text_.text = var_244_20

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_21 = 37
				local var_244_22 = utf8.len(var_244_20)
				local var_244_23 = var_244_21 <= 0 and var_244_18 or var_244_18 * (var_244_22 / var_244_21)

				if var_244_23 > 0 and var_244_18 < var_244_23 then
					arg_241_1.talkMaxDuration = var_244_23

					if var_244_23 + var_244_17 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_23 + var_244_17
					end
				end

				arg_241_1.text_.text = var_244_20
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_24 = math.max(var_244_18, arg_241_1.talkMaxDuration)

			if var_244_17 <= arg_241_1.time_ and arg_241_1.time_ < var_244_17 + var_244_24 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_17) / var_244_24

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_17 + var_244_24 and arg_241_1.time_ < var_244_17 + var_244_24 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426041060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 426041060
		arg_245_1.duration_ = 12

		local var_245_0 = {
			zh = 9.4,
			ja = 12
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play426041061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["6148ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos6148ui_story = var_248_0.localPosition

				local var_248_2 = GameObjectTools.GetOrAddComponent(var_248_0.gameObject, typeof(DynamicBoneHelper))

				if var_248_2 then
					var_248_2:EnableDynamicBone(false)
				end
			end

			local var_248_3 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_3 then
				local var_248_4 = (arg_245_1.time_ - var_248_1) / var_248_3
				local var_248_5 = Vector3.New(0, -0.985, -6)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos6148ui_story, var_248_5, var_248_4)

				local var_248_6 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_6.x, var_248_6.y, var_248_6.z)

				local var_248_7 = var_248_0.localEulerAngles

				var_248_7.z = 0
				var_248_7.x = 0
				var_248_0.localEulerAngles = var_248_7
			end

			if arg_245_1.time_ >= var_248_1 + var_248_3 and arg_245_1.time_ < var_248_1 + var_248_3 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_248_8 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_8.x, var_248_8.y, var_248_8.z)

				local var_248_9 = var_248_0.localEulerAngles

				var_248_9.z = 0
				var_248_9.x = 0
				var_248_0.localEulerAngles = var_248_9

				local var_248_10 = GameObjectTools.GetOrAddComponent(var_248_0.gameObject, typeof(DynamicBoneHelper))

				if var_248_10 then
					var_248_10:EnableDynamicBone(true)
				end
			end

			local var_248_11 = arg_245_1.actors_["6148ui_story"]
			local var_248_12 = 0

			if var_248_12 < arg_245_1.time_ and arg_245_1.time_ <= var_248_12 + arg_248_0 and not isNil(var_248_11) and arg_245_1.var_.characterEffect6148ui_story == nil then
				arg_245_1.var_.characterEffect6148ui_story = var_248_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_13 = 0.200000002980232

			if var_248_12 <= arg_245_1.time_ and arg_245_1.time_ < var_248_12 + var_248_13 and not isNil(var_248_11) then
				local var_248_14 = (arg_245_1.time_ - var_248_12) / var_248_13

				if arg_245_1.var_.characterEffect6148ui_story and not isNil(var_248_11) then
					arg_245_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_12 + var_248_13 and arg_245_1.time_ < var_248_12 + var_248_13 + arg_248_0 and not isNil(var_248_11) and arg_245_1.var_.characterEffect6148ui_story then
				arg_245_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_248_15 = 0

			if var_248_15 < arg_245_1.time_ and arg_245_1.time_ <= var_248_15 + arg_248_0 then
				arg_245_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_248_16 = 0

			if var_248_16 < arg_245_1.time_ and arg_245_1.time_ <= var_248_16 + arg_248_0 then
				arg_245_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_248_17 = 0
			local var_248_18 = 1.025

			if var_248_17 < arg_245_1.time_ and arg_245_1.time_ <= var_248_17 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_19 = arg_245_1:FormatText(StoryNameCfg[1488].name)

				arg_245_1.leftNameTxt_.text = var_248_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_20 = arg_245_1:GetWordFromCfg(426041060)
				local var_248_21 = arg_245_1:FormatText(var_248_20.content)

				arg_245_1.text_.text = var_248_21

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_22 = 41
				local var_248_23 = utf8.len(var_248_21)
				local var_248_24 = var_248_22 <= 0 and var_248_18 or var_248_18 * (var_248_23 / var_248_22)

				if var_248_24 > 0 and var_248_18 < var_248_24 then
					arg_245_1.talkMaxDuration = var_248_24

					if var_248_24 + var_248_17 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_24 + var_248_17
					end
				end

				arg_245_1.text_.text = var_248_21
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041060", "story_v_out_426041.awb") ~= 0 then
					local var_248_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041060", "story_v_out_426041.awb") / 1000

					if var_248_25 + var_248_17 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_25 + var_248_17
					end

					if var_248_20.prefab_name ~= "" and arg_245_1.actors_[var_248_20.prefab_name] ~= nil then
						local var_248_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_20.prefab_name].transform, "story_v_out_426041", "426041060", "story_v_out_426041.awb")

						arg_245_1:RecordAudio("426041060", var_248_26)
						arg_245_1:RecordAudio("426041060", var_248_26)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_426041", "426041060", "story_v_out_426041.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_426041", "426041060", "story_v_out_426041.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_27 = math.max(var_248_18, arg_245_1.talkMaxDuration)

			if var_248_17 <= arg_245_1.time_ and arg_245_1.time_ < var_248_17 + var_248_27 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_17) / var_248_27

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_17 + var_248_27 and arg_245_1.time_ < var_248_17 + var_248_27 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play426041061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 426041061
		arg_249_1.duration_ = 5.2

		local var_249_0 = {
			zh = 5.2,
			ja = 4.5
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
				arg_249_0:Play426041062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_252_1 = 0
			local var_252_2 = 0.75

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_3 = arg_249_1:FormatText(StoryNameCfg[1488].name)

				arg_249_1.leftNameTxt_.text = var_252_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_4 = arg_249_1:GetWordFromCfg(426041061)
				local var_252_5 = arg_249_1:FormatText(var_252_4.content)

				arg_249_1.text_.text = var_252_5

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_6 = 30
				local var_252_7 = utf8.len(var_252_5)
				local var_252_8 = var_252_6 <= 0 and var_252_2 or var_252_2 * (var_252_7 / var_252_6)

				if var_252_8 > 0 and var_252_2 < var_252_8 then
					arg_249_1.talkMaxDuration = var_252_8

					if var_252_8 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_5
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041061", "story_v_out_426041.awb") ~= 0 then
					local var_252_9 = manager.audio:GetVoiceLength("story_v_out_426041", "426041061", "story_v_out_426041.awb") / 1000

					if var_252_9 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_1
					end

					if var_252_4.prefab_name ~= "" and arg_249_1.actors_[var_252_4.prefab_name] ~= nil then
						local var_252_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_4.prefab_name].transform, "story_v_out_426041", "426041061", "story_v_out_426041.awb")

						arg_249_1:RecordAudio("426041061", var_252_10)
						arg_249_1:RecordAudio("426041061", var_252_10)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_426041", "426041061", "story_v_out_426041.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_426041", "426041061", "story_v_out_426041.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_11 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_11 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_11

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_11 and arg_249_1.time_ < var_252_1 + var_252_11 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play426041062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 426041062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play426041063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["6148ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect6148ui_story == nil then
				arg_253_1.var_.characterEffect6148ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect6148ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_253_1.var_.characterEffect6148ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect6148ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_253_1.var_.characterEffect6148ui_story.fillRatio = var_256_5
			end

			local var_256_6 = 0
			local var_256_7 = 0.475

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_8 = arg_253_1:FormatText(StoryNameCfg[7].name)

				arg_253_1.leftNameTxt_.text = var_256_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_9 = arg_253_1:GetWordFromCfg(426041062)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 19
				local var_256_12 = utf8.len(var_256_10)
				local var_256_13 = var_256_11 <= 0 and var_256_7 or var_256_7 * (var_256_12 / var_256_11)

				if var_256_13 > 0 and var_256_7 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_10
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_14 and arg_253_1.time_ < var_256_6 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play426041063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 426041063
		arg_257_1.duration_ = 10.33

		local var_257_0 = {
			zh = 10.033,
			ja = 10.333
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
				arg_257_0:Play426041064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["6148ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos6148ui_story = var_260_0.localPosition

				local var_260_2 = GameObjectTools.GetOrAddComponent(var_260_0.gameObject, typeof(DynamicBoneHelper))

				if var_260_2 then
					var_260_2:EnableDynamicBone(false)
				end
			end

			local var_260_3 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_3 then
				local var_260_4 = (arg_257_1.time_ - var_260_1) / var_260_3
				local var_260_5 = Vector3.New(0, -0.985, -6)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos6148ui_story, var_260_5, var_260_4)

				local var_260_6 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_6.x, var_260_6.y, var_260_6.z)

				local var_260_7 = var_260_0.localEulerAngles

				var_260_7.z = 0
				var_260_7.x = 0
				var_260_0.localEulerAngles = var_260_7
			end

			if arg_257_1.time_ >= var_260_1 + var_260_3 and arg_257_1.time_ < var_260_1 + var_260_3 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_260_8 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_8.x, var_260_8.y, var_260_8.z)

				local var_260_9 = var_260_0.localEulerAngles

				var_260_9.z = 0
				var_260_9.x = 0
				var_260_0.localEulerAngles = var_260_9

				local var_260_10 = GameObjectTools.GetOrAddComponent(var_260_0.gameObject, typeof(DynamicBoneHelper))

				if var_260_10 then
					var_260_10:EnableDynamicBone(true)
				end
			end

			local var_260_11 = arg_257_1.actors_["6148ui_story"]
			local var_260_12 = 0

			if var_260_12 < arg_257_1.time_ and arg_257_1.time_ <= var_260_12 + arg_260_0 and not isNil(var_260_11) and arg_257_1.var_.characterEffect6148ui_story == nil then
				arg_257_1.var_.characterEffect6148ui_story = var_260_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_13 = 0.200000002980232

			if var_260_12 <= arg_257_1.time_ and arg_257_1.time_ < var_260_12 + var_260_13 and not isNil(var_260_11) then
				local var_260_14 = (arg_257_1.time_ - var_260_12) / var_260_13

				if arg_257_1.var_.characterEffect6148ui_story and not isNil(var_260_11) then
					arg_257_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_12 + var_260_13 and arg_257_1.time_ < var_260_12 + var_260_13 + arg_260_0 and not isNil(var_260_11) and arg_257_1.var_.characterEffect6148ui_story then
				arg_257_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_260_15 = 0

			if var_260_15 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 then
				arg_257_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_260_16 = 0

			if var_260_16 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 then
				arg_257_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_260_17 = 0
			local var_260_18 = 1.05

			if var_260_17 < arg_257_1.time_ and arg_257_1.time_ <= var_260_17 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_19 = arg_257_1:FormatText(StoryNameCfg[1488].name)

				arg_257_1.leftNameTxt_.text = var_260_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_20 = arg_257_1:GetWordFromCfg(426041063)
				local var_260_21 = arg_257_1:FormatText(var_260_20.content)

				arg_257_1.text_.text = var_260_21

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_22 = 42
				local var_260_23 = utf8.len(var_260_21)
				local var_260_24 = var_260_22 <= 0 and var_260_18 or var_260_18 * (var_260_23 / var_260_22)

				if var_260_24 > 0 and var_260_18 < var_260_24 then
					arg_257_1.talkMaxDuration = var_260_24

					if var_260_24 + var_260_17 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_24 + var_260_17
					end
				end

				arg_257_1.text_.text = var_260_21
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041063", "story_v_out_426041.awb") ~= 0 then
					local var_260_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041063", "story_v_out_426041.awb") / 1000

					if var_260_25 + var_260_17 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_25 + var_260_17
					end

					if var_260_20.prefab_name ~= "" and arg_257_1.actors_[var_260_20.prefab_name] ~= nil then
						local var_260_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_20.prefab_name].transform, "story_v_out_426041", "426041063", "story_v_out_426041.awb")

						arg_257_1:RecordAudio("426041063", var_260_26)
						arg_257_1:RecordAudio("426041063", var_260_26)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_426041", "426041063", "story_v_out_426041.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_426041", "426041063", "story_v_out_426041.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_27 = math.max(var_260_18, arg_257_1.talkMaxDuration)

			if var_260_17 <= arg_257_1.time_ and arg_257_1.time_ < var_260_17 + var_260_27 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_17) / var_260_27

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_17 + var_260_27 and arg_257_1.time_ < var_260_17 + var_260_27 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play426041064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 426041064
		arg_261_1.duration_ = 12.07

		local var_261_0 = {
			zh = 8.5,
			ja = 12.066
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play426041065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1054ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1054ui_story = var_264_0.localPosition

				local var_264_2 = GameObjectTools.GetOrAddComponent(var_264_0.gameObject, typeof(DynamicBoneHelper))

				if var_264_2 then
					var_264_2:EnableDynamicBone(false)
				end
			end

			local var_264_3 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_3 then
				local var_264_4 = (arg_261_1.time_ - var_264_1) / var_264_3
				local var_264_5 = Vector3.New(0.7, -0.985, -6)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1054ui_story, var_264_5, var_264_4)

				local var_264_6 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_6.x, var_264_6.y, var_264_6.z)

				local var_264_7 = var_264_0.localEulerAngles

				var_264_7.z = 0
				var_264_7.x = 0
				var_264_0.localEulerAngles = var_264_7
			end

			if arg_261_1.time_ >= var_264_1 + var_264_3 and arg_261_1.time_ < var_264_1 + var_264_3 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_264_8 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_8.x, var_264_8.y, var_264_8.z)

				local var_264_9 = var_264_0.localEulerAngles

				var_264_9.z = 0
				var_264_9.x = 0
				var_264_0.localEulerAngles = var_264_9

				local var_264_10 = GameObjectTools.GetOrAddComponent(var_264_0.gameObject, typeof(DynamicBoneHelper))

				if var_264_10 then
					var_264_10:EnableDynamicBone(true)
				end
			end

			local var_264_11 = arg_261_1.actors_["1054ui_story"]
			local var_264_12 = 0

			if var_264_12 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 and not isNil(var_264_11) and arg_261_1.var_.characterEffect1054ui_story == nil then
				arg_261_1.var_.characterEffect1054ui_story = var_264_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_13 = 0.200000002980232

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_13 and not isNil(var_264_11) then
				local var_264_14 = (arg_261_1.time_ - var_264_12) / var_264_13

				if arg_261_1.var_.characterEffect1054ui_story and not isNil(var_264_11) then
					arg_261_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_12 + var_264_13 and arg_261_1.time_ < var_264_12 + var_264_13 + arg_264_0 and not isNil(var_264_11) and arg_261_1.var_.characterEffect1054ui_story then
				arg_261_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_264_15 = arg_261_1.actors_["6148ui_story"]
			local var_264_16 = 0

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.characterEffect6148ui_story == nil then
				arg_261_1.var_.characterEffect6148ui_story = var_264_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_17 = 0.200000002980232

			if var_264_16 <= arg_261_1.time_ and arg_261_1.time_ < var_264_16 + var_264_17 and not isNil(var_264_15) then
				local var_264_18 = (arg_261_1.time_ - var_264_16) / var_264_17

				if arg_261_1.var_.characterEffect6148ui_story and not isNil(var_264_15) then
					local var_264_19 = Mathf.Lerp(0, 0.5, var_264_18)

					arg_261_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_261_1.var_.characterEffect6148ui_story.fillRatio = var_264_19
				end
			end

			if arg_261_1.time_ >= var_264_16 + var_264_17 and arg_261_1.time_ < var_264_16 + var_264_17 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.characterEffect6148ui_story then
				local var_264_20 = 0.5

				arg_261_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_261_1.var_.characterEffect6148ui_story.fillRatio = var_264_20
			end

			local var_264_21 = 0

			if var_264_21 < arg_261_1.time_ and arg_261_1.time_ <= var_264_21 + arg_264_0 then
				arg_261_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_264_22 = 0

			if var_264_22 < arg_261_1.time_ and arg_261_1.time_ <= var_264_22 + arg_264_0 then
				arg_261_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_264_23 = arg_261_1.actors_["6148ui_story"].transform
			local var_264_24 = 0

			if var_264_24 < arg_261_1.time_ and arg_261_1.time_ <= var_264_24 + arg_264_0 then
				arg_261_1.var_.moveOldPos6148ui_story = var_264_23.localPosition

				local var_264_25 = GameObjectTools.GetOrAddComponent(var_264_23.gameObject, typeof(DynamicBoneHelper))

				if var_264_25 then
					var_264_25:EnableDynamicBone(false)
				end
			end

			local var_264_26 = 0.001

			if var_264_24 <= arg_261_1.time_ and arg_261_1.time_ < var_264_24 + var_264_26 then
				local var_264_27 = (arg_261_1.time_ - var_264_24) / var_264_26
				local var_264_28 = Vector3.New(-0.7, -0.985, -6)

				var_264_23.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos6148ui_story, var_264_28, var_264_27)

				local var_264_29 = manager.ui.mainCamera.transform.position - var_264_23.position

				var_264_23.forward = Vector3.New(var_264_29.x, var_264_29.y, var_264_29.z)

				local var_264_30 = var_264_23.localEulerAngles

				var_264_30.z = 0
				var_264_30.x = 0
				var_264_23.localEulerAngles = var_264_30
			end

			if arg_261_1.time_ >= var_264_24 + var_264_26 and arg_261_1.time_ < var_264_24 + var_264_26 + arg_264_0 then
				var_264_23.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_264_31 = manager.ui.mainCamera.transform.position - var_264_23.position

				var_264_23.forward = Vector3.New(var_264_31.x, var_264_31.y, var_264_31.z)

				local var_264_32 = var_264_23.localEulerAngles

				var_264_32.z = 0
				var_264_32.x = 0
				var_264_23.localEulerAngles = var_264_32

				local var_264_33 = GameObjectTools.GetOrAddComponent(var_264_23.gameObject, typeof(DynamicBoneHelper))

				if var_264_33 then
					var_264_33:EnableDynamicBone(true)
				end
			end

			local var_264_34 = 0
			local var_264_35 = 0.8

			if var_264_34 < arg_261_1.time_ and arg_261_1.time_ <= var_264_34 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_36 = arg_261_1:FormatText(StoryNameCfg[1487].name)

				arg_261_1.leftNameTxt_.text = var_264_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_37 = arg_261_1:GetWordFromCfg(426041064)
				local var_264_38 = arg_261_1:FormatText(var_264_37.content)

				arg_261_1.text_.text = var_264_38

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_39 = 32
				local var_264_40 = utf8.len(var_264_38)
				local var_264_41 = var_264_39 <= 0 and var_264_35 or var_264_35 * (var_264_40 / var_264_39)

				if var_264_41 > 0 and var_264_35 < var_264_41 then
					arg_261_1.talkMaxDuration = var_264_41

					if var_264_41 + var_264_34 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_41 + var_264_34
					end
				end

				arg_261_1.text_.text = var_264_38
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041064", "story_v_out_426041.awb") ~= 0 then
					local var_264_42 = manager.audio:GetVoiceLength("story_v_out_426041", "426041064", "story_v_out_426041.awb") / 1000

					if var_264_42 + var_264_34 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_42 + var_264_34
					end

					if var_264_37.prefab_name ~= "" and arg_261_1.actors_[var_264_37.prefab_name] ~= nil then
						local var_264_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_37.prefab_name].transform, "story_v_out_426041", "426041064", "story_v_out_426041.awb")

						arg_261_1:RecordAudio("426041064", var_264_43)
						arg_261_1:RecordAudio("426041064", var_264_43)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_426041", "426041064", "story_v_out_426041.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_426041", "426041064", "story_v_out_426041.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_44 = math.max(var_264_35, arg_261_1.talkMaxDuration)

			if var_264_34 <= arg_261_1.time_ and arg_261_1.time_ < var_264_34 + var_264_44 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_34) / var_264_44

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_34 + var_264_44 and arg_261_1.time_ < var_264_34 + var_264_44 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play426041065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 426041065
		arg_265_1.duration_ = 5.67

		local var_265_0 = {
			zh = 4.233,
			ja = 5.666
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
				arg_265_0:Play426041066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["6148ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos6148ui_story = var_268_0.localPosition

				local var_268_2 = GameObjectTools.GetOrAddComponent(var_268_0.gameObject, typeof(DynamicBoneHelper))

				if var_268_2 then
					var_268_2:EnableDynamicBone(false)
				end
			end

			local var_268_3 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_3 then
				local var_268_4 = (arg_265_1.time_ - var_268_1) / var_268_3
				local var_268_5 = Vector3.New(-0.7, -0.985, -6)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos6148ui_story, var_268_5, var_268_4)

				local var_268_6 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_6.x, var_268_6.y, var_268_6.z)

				local var_268_7 = var_268_0.localEulerAngles

				var_268_7.z = 0
				var_268_7.x = 0
				var_268_0.localEulerAngles = var_268_7
			end

			if arg_265_1.time_ >= var_268_1 + var_268_3 and arg_265_1.time_ < var_268_1 + var_268_3 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_268_8 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_8.x, var_268_8.y, var_268_8.z)

				local var_268_9 = var_268_0.localEulerAngles

				var_268_9.z = 0
				var_268_9.x = 0
				var_268_0.localEulerAngles = var_268_9

				local var_268_10 = GameObjectTools.GetOrAddComponent(var_268_0.gameObject, typeof(DynamicBoneHelper))

				if var_268_10 then
					var_268_10:EnableDynamicBone(true)
				end
			end

			local var_268_11 = arg_265_1.actors_["6148ui_story"]
			local var_268_12 = 0

			if var_268_12 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 and not isNil(var_268_11) and arg_265_1.var_.characterEffect6148ui_story == nil then
				arg_265_1.var_.characterEffect6148ui_story = var_268_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_13 = 0.200000002980232

			if var_268_12 <= arg_265_1.time_ and arg_265_1.time_ < var_268_12 + var_268_13 and not isNil(var_268_11) then
				local var_268_14 = (arg_265_1.time_ - var_268_12) / var_268_13

				if arg_265_1.var_.characterEffect6148ui_story and not isNil(var_268_11) then
					arg_265_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_12 + var_268_13 and arg_265_1.time_ < var_268_12 + var_268_13 + arg_268_0 and not isNil(var_268_11) and arg_265_1.var_.characterEffect6148ui_story then
				arg_265_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_268_15 = arg_265_1.actors_["1054ui_story"]
			local var_268_16 = 0

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.characterEffect1054ui_story == nil then
				arg_265_1.var_.characterEffect1054ui_story = var_268_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_17 = 0.200000002980232

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_17 and not isNil(var_268_15) then
				local var_268_18 = (arg_265_1.time_ - var_268_16) / var_268_17

				if arg_265_1.var_.characterEffect1054ui_story and not isNil(var_268_15) then
					local var_268_19 = Mathf.Lerp(0, 0.5, var_268_18)

					arg_265_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1054ui_story.fillRatio = var_268_19
				end
			end

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.characterEffect1054ui_story then
				local var_268_20 = 0.5

				arg_265_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1054ui_story.fillRatio = var_268_20
			end

			local var_268_21 = 0

			if var_268_21 < arg_265_1.time_ and arg_265_1.time_ <= var_268_21 + arg_268_0 then
				arg_265_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_268_22 = 0

			if var_268_22 < arg_265_1.time_ and arg_265_1.time_ <= var_268_22 + arg_268_0 then
				arg_265_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_268_23 = 0
			local var_268_24 = 0.375

			if var_268_23 < arg_265_1.time_ and arg_265_1.time_ <= var_268_23 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_25 = arg_265_1:FormatText(StoryNameCfg[1488].name)

				arg_265_1.leftNameTxt_.text = var_268_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_26 = arg_265_1:GetWordFromCfg(426041065)
				local var_268_27 = arg_265_1:FormatText(var_268_26.content)

				arg_265_1.text_.text = var_268_27

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_28 = 15
				local var_268_29 = utf8.len(var_268_27)
				local var_268_30 = var_268_28 <= 0 and var_268_24 or var_268_24 * (var_268_29 / var_268_28)

				if var_268_30 > 0 and var_268_24 < var_268_30 then
					arg_265_1.talkMaxDuration = var_268_30

					if var_268_30 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_30 + var_268_23
					end
				end

				arg_265_1.text_.text = var_268_27
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041065", "story_v_out_426041.awb") ~= 0 then
					local var_268_31 = manager.audio:GetVoiceLength("story_v_out_426041", "426041065", "story_v_out_426041.awb") / 1000

					if var_268_31 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_31 + var_268_23
					end

					if var_268_26.prefab_name ~= "" and arg_265_1.actors_[var_268_26.prefab_name] ~= nil then
						local var_268_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_26.prefab_name].transform, "story_v_out_426041", "426041065", "story_v_out_426041.awb")

						arg_265_1:RecordAudio("426041065", var_268_32)
						arg_265_1:RecordAudio("426041065", var_268_32)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_426041", "426041065", "story_v_out_426041.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_426041", "426041065", "story_v_out_426041.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_33 = math.max(var_268_24, arg_265_1.talkMaxDuration)

			if var_268_23 <= arg_265_1.time_ and arg_265_1.time_ < var_268_23 + var_268_33 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_23) / var_268_33

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_23 + var_268_33 and arg_265_1.time_ < var_268_23 + var_268_33 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play426041066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 426041066
		arg_269_1.duration_ = 7.73

		local var_269_0 = {
			zh = 6,
			ja = 7.733
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play426041067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1054ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1054ui_story = var_272_0.localPosition

				local var_272_2 = GameObjectTools.GetOrAddComponent(var_272_0.gameObject, typeof(DynamicBoneHelper))

				if var_272_2 then
					var_272_2:EnableDynamicBone(false)
				end
			end

			local var_272_3 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_3 then
				local var_272_4 = (arg_269_1.time_ - var_272_1) / var_272_3
				local var_272_5 = Vector3.New(0.7, -0.985, -6)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1054ui_story, var_272_5, var_272_4)

				local var_272_6 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_6.x, var_272_6.y, var_272_6.z)

				local var_272_7 = var_272_0.localEulerAngles

				var_272_7.z = 0
				var_272_7.x = 0
				var_272_0.localEulerAngles = var_272_7
			end

			if arg_269_1.time_ >= var_272_1 + var_272_3 and arg_269_1.time_ < var_272_1 + var_272_3 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_272_8 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_8.x, var_272_8.y, var_272_8.z)

				local var_272_9 = var_272_0.localEulerAngles

				var_272_9.z = 0
				var_272_9.x = 0
				var_272_0.localEulerAngles = var_272_9

				local var_272_10 = GameObjectTools.GetOrAddComponent(var_272_0.gameObject, typeof(DynamicBoneHelper))

				if var_272_10 then
					var_272_10:EnableDynamicBone(true)
				end
			end

			local var_272_11 = arg_269_1.actors_["1054ui_story"]
			local var_272_12 = 0

			if var_272_12 < arg_269_1.time_ and arg_269_1.time_ <= var_272_12 + arg_272_0 and not isNil(var_272_11) and arg_269_1.var_.characterEffect1054ui_story == nil then
				arg_269_1.var_.characterEffect1054ui_story = var_272_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_13 = 0.200000002980232

			if var_272_12 <= arg_269_1.time_ and arg_269_1.time_ < var_272_12 + var_272_13 and not isNil(var_272_11) then
				local var_272_14 = (arg_269_1.time_ - var_272_12) / var_272_13

				if arg_269_1.var_.characterEffect1054ui_story and not isNil(var_272_11) then
					arg_269_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_12 + var_272_13 and arg_269_1.time_ < var_272_12 + var_272_13 + arg_272_0 and not isNil(var_272_11) and arg_269_1.var_.characterEffect1054ui_story then
				arg_269_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_272_15 = arg_269_1.actors_["6148ui_story"]
			local var_272_16 = 0

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.characterEffect6148ui_story == nil then
				arg_269_1.var_.characterEffect6148ui_story = var_272_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_17 = 0.200000002980232

			if var_272_16 <= arg_269_1.time_ and arg_269_1.time_ < var_272_16 + var_272_17 and not isNil(var_272_15) then
				local var_272_18 = (arg_269_1.time_ - var_272_16) / var_272_17

				if arg_269_1.var_.characterEffect6148ui_story and not isNil(var_272_15) then
					local var_272_19 = Mathf.Lerp(0, 0.5, var_272_18)

					arg_269_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_269_1.var_.characterEffect6148ui_story.fillRatio = var_272_19
				end
			end

			if arg_269_1.time_ >= var_272_16 + var_272_17 and arg_269_1.time_ < var_272_16 + var_272_17 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.characterEffect6148ui_story then
				local var_272_20 = 0.5

				arg_269_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_269_1.var_.characterEffect6148ui_story.fillRatio = var_272_20
			end

			local var_272_21 = 0

			if var_272_21 < arg_269_1.time_ and arg_269_1.time_ <= var_272_21 + arg_272_0 then
				arg_269_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_272_22 = 0

			if var_272_22 < arg_269_1.time_ and arg_269_1.time_ <= var_272_22 + arg_272_0 then
				arg_269_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_272_23 = 0
			local var_272_24 = 0.425

			if var_272_23 < arg_269_1.time_ and arg_269_1.time_ <= var_272_23 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_25 = arg_269_1:FormatText(StoryNameCfg[1487].name)

				arg_269_1.leftNameTxt_.text = var_272_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_26 = arg_269_1:GetWordFromCfg(426041066)
				local var_272_27 = arg_269_1:FormatText(var_272_26.content)

				arg_269_1.text_.text = var_272_27

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_28 = 17
				local var_272_29 = utf8.len(var_272_27)
				local var_272_30 = var_272_28 <= 0 and var_272_24 or var_272_24 * (var_272_29 / var_272_28)

				if var_272_30 > 0 and var_272_24 < var_272_30 then
					arg_269_1.talkMaxDuration = var_272_30

					if var_272_30 + var_272_23 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_30 + var_272_23
					end
				end

				arg_269_1.text_.text = var_272_27
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041066", "story_v_out_426041.awb") ~= 0 then
					local var_272_31 = manager.audio:GetVoiceLength("story_v_out_426041", "426041066", "story_v_out_426041.awb") / 1000

					if var_272_31 + var_272_23 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_31 + var_272_23
					end

					if var_272_26.prefab_name ~= "" and arg_269_1.actors_[var_272_26.prefab_name] ~= nil then
						local var_272_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_26.prefab_name].transform, "story_v_out_426041", "426041066", "story_v_out_426041.awb")

						arg_269_1:RecordAudio("426041066", var_272_32)
						arg_269_1:RecordAudio("426041066", var_272_32)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_426041", "426041066", "story_v_out_426041.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_426041", "426041066", "story_v_out_426041.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_33 = math.max(var_272_24, arg_269_1.talkMaxDuration)

			if var_272_23 <= arg_269_1.time_ and arg_269_1.time_ < var_272_23 + var_272_33 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_23) / var_272_33

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_23 + var_272_33 and arg_269_1.time_ < var_272_23 + var_272_33 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play426041067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 426041067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play426041068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1054ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1054ui_story = var_276_0.localPosition

				local var_276_2 = GameObjectTools.GetOrAddComponent(var_276_0.gameObject, typeof(DynamicBoneHelper))

				if var_276_2 then
					var_276_2:EnableDynamicBone(false)
				end
			end

			local var_276_3 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_3 then
				local var_276_4 = (arg_273_1.time_ - var_276_1) / var_276_3
				local var_276_5 = Vector3.New(0, 100, 0)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1054ui_story, var_276_5, var_276_4)

				local var_276_6 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_6.x, var_276_6.y, var_276_6.z)

				local var_276_7 = var_276_0.localEulerAngles

				var_276_7.z = 0
				var_276_7.x = 0
				var_276_0.localEulerAngles = var_276_7
			end

			if arg_273_1.time_ >= var_276_1 + var_276_3 and arg_273_1.time_ < var_276_1 + var_276_3 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, 100, 0)

				local var_276_8 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_8.x, var_276_8.y, var_276_8.z)

				local var_276_9 = var_276_0.localEulerAngles

				var_276_9.z = 0
				var_276_9.x = 0
				var_276_0.localEulerAngles = var_276_9

				local var_276_10 = GameObjectTools.GetOrAddComponent(var_276_0.gameObject, typeof(DynamicBoneHelper))

				if var_276_10 then
					var_276_10:EnableDynamicBone(true)
				end
			end

			local var_276_11 = arg_273_1.actors_["1054ui_story"]
			local var_276_12 = 0

			if var_276_12 < arg_273_1.time_ and arg_273_1.time_ <= var_276_12 + arg_276_0 and not isNil(var_276_11) and arg_273_1.var_.characterEffect1054ui_story == nil then
				arg_273_1.var_.characterEffect1054ui_story = var_276_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_13 = 0.200000002980232

			if var_276_12 <= arg_273_1.time_ and arg_273_1.time_ < var_276_12 + var_276_13 and not isNil(var_276_11) then
				local var_276_14 = (arg_273_1.time_ - var_276_12) / var_276_13

				if arg_273_1.var_.characterEffect1054ui_story and not isNil(var_276_11) then
					local var_276_15 = Mathf.Lerp(0, 0.5, var_276_14)

					arg_273_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1054ui_story.fillRatio = var_276_15
				end
			end

			if arg_273_1.time_ >= var_276_12 + var_276_13 and arg_273_1.time_ < var_276_12 + var_276_13 + arg_276_0 and not isNil(var_276_11) and arg_273_1.var_.characterEffect1054ui_story then
				local var_276_16 = 0.5

				arg_273_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1054ui_story.fillRatio = var_276_16
			end

			local var_276_17 = arg_273_1.actors_["6148ui_story"].transform
			local var_276_18 = 0

			if var_276_18 < arg_273_1.time_ and arg_273_1.time_ <= var_276_18 + arg_276_0 then
				arg_273_1.var_.moveOldPos6148ui_story = var_276_17.localPosition

				local var_276_19 = GameObjectTools.GetOrAddComponent(var_276_17.gameObject, typeof(DynamicBoneHelper))

				if var_276_19 then
					var_276_19:EnableDynamicBone(false)
				end
			end

			local var_276_20 = 0.001

			if var_276_18 <= arg_273_1.time_ and arg_273_1.time_ < var_276_18 + var_276_20 then
				local var_276_21 = (arg_273_1.time_ - var_276_18) / var_276_20
				local var_276_22 = Vector3.New(0, 100, 0)

				var_276_17.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos6148ui_story, var_276_22, var_276_21)

				local var_276_23 = manager.ui.mainCamera.transform.position - var_276_17.position

				var_276_17.forward = Vector3.New(var_276_23.x, var_276_23.y, var_276_23.z)

				local var_276_24 = var_276_17.localEulerAngles

				var_276_24.z = 0
				var_276_24.x = 0
				var_276_17.localEulerAngles = var_276_24
			end

			if arg_273_1.time_ >= var_276_18 + var_276_20 and arg_273_1.time_ < var_276_18 + var_276_20 + arg_276_0 then
				var_276_17.localPosition = Vector3.New(0, 100, 0)

				local var_276_25 = manager.ui.mainCamera.transform.position - var_276_17.position

				var_276_17.forward = Vector3.New(var_276_25.x, var_276_25.y, var_276_25.z)

				local var_276_26 = var_276_17.localEulerAngles

				var_276_26.z = 0
				var_276_26.x = 0
				var_276_17.localEulerAngles = var_276_26

				local var_276_27 = GameObjectTools.GetOrAddComponent(var_276_17.gameObject, typeof(DynamicBoneHelper))

				if var_276_27 then
					var_276_27:EnableDynamicBone(true)
				end
			end

			local var_276_28 = 0
			local var_276_29 = 1.05

			if var_276_28 < arg_273_1.time_ and arg_273_1.time_ <= var_276_28 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_30 = arg_273_1:GetWordFromCfg(426041067)
				local var_276_31 = arg_273_1:FormatText(var_276_30.content)

				arg_273_1.text_.text = var_276_31

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_32 = 42
				local var_276_33 = utf8.len(var_276_31)
				local var_276_34 = var_276_32 <= 0 and var_276_29 or var_276_29 * (var_276_33 / var_276_32)

				if var_276_34 > 0 and var_276_29 < var_276_34 then
					arg_273_1.talkMaxDuration = var_276_34

					if var_276_34 + var_276_28 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_34 + var_276_28
					end
				end

				arg_273_1.text_.text = var_276_31
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_35 = math.max(var_276_29, arg_273_1.talkMaxDuration)

			if var_276_28 <= arg_273_1.time_ and arg_273_1.time_ < var_276_28 + var_276_35 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_28) / var_276_35

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_28 + var_276_35 and arg_273_1.time_ < var_276_28 + var_276_35 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426041068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 426041068
		arg_277_1.duration_ = 5.67

		local var_277_0 = {
			zh = 3.733,
			ja = 5.666
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play426041069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["6148ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos6148ui_story = var_280_0.localPosition

				local var_280_2 = GameObjectTools.GetOrAddComponent(var_280_0.gameObject, typeof(DynamicBoneHelper))

				if var_280_2 then
					var_280_2:EnableDynamicBone(false)
				end
			end

			local var_280_3 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_3 then
				local var_280_4 = (arg_277_1.time_ - var_280_1) / var_280_3
				local var_280_5 = Vector3.New(0, -0.985, -6)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos6148ui_story, var_280_5, var_280_4)

				local var_280_6 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_6.x, var_280_6.y, var_280_6.z)

				local var_280_7 = var_280_0.localEulerAngles

				var_280_7.z = 0
				var_280_7.x = 0
				var_280_0.localEulerAngles = var_280_7
			end

			if arg_277_1.time_ >= var_280_1 + var_280_3 and arg_277_1.time_ < var_280_1 + var_280_3 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_280_8 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_8.x, var_280_8.y, var_280_8.z)

				local var_280_9 = var_280_0.localEulerAngles

				var_280_9.z = 0
				var_280_9.x = 0
				var_280_0.localEulerAngles = var_280_9

				local var_280_10 = GameObjectTools.GetOrAddComponent(var_280_0.gameObject, typeof(DynamicBoneHelper))

				if var_280_10 then
					var_280_10:EnableDynamicBone(true)
				end
			end

			local var_280_11 = arg_277_1.actors_["6148ui_story"]
			local var_280_12 = 0

			if var_280_12 < arg_277_1.time_ and arg_277_1.time_ <= var_280_12 + arg_280_0 and not isNil(var_280_11) and arg_277_1.var_.characterEffect6148ui_story == nil then
				arg_277_1.var_.characterEffect6148ui_story = var_280_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_13 = 0.200000002980232

			if var_280_12 <= arg_277_1.time_ and arg_277_1.time_ < var_280_12 + var_280_13 and not isNil(var_280_11) then
				local var_280_14 = (arg_277_1.time_ - var_280_12) / var_280_13

				if arg_277_1.var_.characterEffect6148ui_story and not isNil(var_280_11) then
					arg_277_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_12 + var_280_13 and arg_277_1.time_ < var_280_12 + var_280_13 + arg_280_0 and not isNil(var_280_11) and arg_277_1.var_.characterEffect6148ui_story then
				arg_277_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_280_15 = 0

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_280_16 = 0

			if var_280_16 < arg_277_1.time_ and arg_277_1.time_ <= var_280_16 + arg_280_0 then
				arg_277_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_280_17 = 0
			local var_280_18 = 0.425

			if var_280_17 < arg_277_1.time_ and arg_277_1.time_ <= var_280_17 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_19 = arg_277_1:FormatText(StoryNameCfg[1488].name)

				arg_277_1.leftNameTxt_.text = var_280_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_20 = arg_277_1:GetWordFromCfg(426041068)
				local var_280_21 = arg_277_1:FormatText(var_280_20.content)

				arg_277_1.text_.text = var_280_21

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_22 = 17
				local var_280_23 = utf8.len(var_280_21)
				local var_280_24 = var_280_22 <= 0 and var_280_18 or var_280_18 * (var_280_23 / var_280_22)

				if var_280_24 > 0 and var_280_18 < var_280_24 then
					arg_277_1.talkMaxDuration = var_280_24

					if var_280_24 + var_280_17 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_24 + var_280_17
					end
				end

				arg_277_1.text_.text = var_280_21
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041068", "story_v_out_426041.awb") ~= 0 then
					local var_280_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041068", "story_v_out_426041.awb") / 1000

					if var_280_25 + var_280_17 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_25 + var_280_17
					end

					if var_280_20.prefab_name ~= "" and arg_277_1.actors_[var_280_20.prefab_name] ~= nil then
						local var_280_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_20.prefab_name].transform, "story_v_out_426041", "426041068", "story_v_out_426041.awb")

						arg_277_1:RecordAudio("426041068", var_280_26)
						arg_277_1:RecordAudio("426041068", var_280_26)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_426041", "426041068", "story_v_out_426041.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_426041", "426041068", "story_v_out_426041.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_27 = math.max(var_280_18, arg_277_1.talkMaxDuration)

			if var_280_17 <= arg_277_1.time_ and arg_277_1.time_ < var_280_17 + var_280_27 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_17) / var_280_27

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_17 + var_280_27 and arg_277_1.time_ < var_280_17 + var_280_27 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play426041069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 426041069
		arg_281_1.duration_ = 6.07

		local var_281_0 = {
			zh = 4.5,
			ja = 6.066
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play426041070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["6148ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos6148ui_story = var_284_0.localPosition

				local var_284_2 = GameObjectTools.GetOrAddComponent(var_284_0.gameObject, typeof(DynamicBoneHelper))

				if var_284_2 then
					var_284_2:EnableDynamicBone(false)
				end
			end

			local var_284_3 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_3 then
				local var_284_4 = (arg_281_1.time_ - var_284_1) / var_284_3
				local var_284_5 = Vector3.New(0, -0.985, -6)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos6148ui_story, var_284_5, var_284_4)

				local var_284_6 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_6.x, var_284_6.y, var_284_6.z)

				local var_284_7 = var_284_0.localEulerAngles

				var_284_7.z = 0
				var_284_7.x = 0
				var_284_0.localEulerAngles = var_284_7
			end

			if arg_281_1.time_ >= var_284_1 + var_284_3 and arg_281_1.time_ < var_284_1 + var_284_3 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_284_8 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_8.x, var_284_8.y, var_284_8.z)

				local var_284_9 = var_284_0.localEulerAngles

				var_284_9.z = 0
				var_284_9.x = 0
				var_284_0.localEulerAngles = var_284_9

				local var_284_10 = GameObjectTools.GetOrAddComponent(var_284_0.gameObject, typeof(DynamicBoneHelper))

				if var_284_10 then
					var_284_10:EnableDynamicBone(true)
				end
			end

			local var_284_11 = 0

			if var_284_11 < arg_281_1.time_ and arg_281_1.time_ <= var_284_11 + arg_284_0 then
				arg_281_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_284_12 = 0

			if var_284_12 < arg_281_1.time_ and arg_281_1.time_ <= var_284_12 + arg_284_0 then
				arg_281_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_284_13 = 0
			local var_284_14 = 0.6

			if var_284_13 < arg_281_1.time_ and arg_281_1.time_ <= var_284_13 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_15 = arg_281_1:FormatText(StoryNameCfg[1488].name)

				arg_281_1.leftNameTxt_.text = var_284_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_16 = arg_281_1:GetWordFromCfg(426041069)
				local var_284_17 = arg_281_1:FormatText(var_284_16.content)

				arg_281_1.text_.text = var_284_17

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_18 = 24
				local var_284_19 = utf8.len(var_284_17)
				local var_284_20 = var_284_18 <= 0 and var_284_14 or var_284_14 * (var_284_19 / var_284_18)

				if var_284_20 > 0 and var_284_14 < var_284_20 then
					arg_281_1.talkMaxDuration = var_284_20

					if var_284_20 + var_284_13 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_20 + var_284_13
					end
				end

				arg_281_1.text_.text = var_284_17
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041069", "story_v_out_426041.awb") ~= 0 then
					local var_284_21 = manager.audio:GetVoiceLength("story_v_out_426041", "426041069", "story_v_out_426041.awb") / 1000

					if var_284_21 + var_284_13 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_21 + var_284_13
					end

					if var_284_16.prefab_name ~= "" and arg_281_1.actors_[var_284_16.prefab_name] ~= nil then
						local var_284_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_16.prefab_name].transform, "story_v_out_426041", "426041069", "story_v_out_426041.awb")

						arg_281_1:RecordAudio("426041069", var_284_22)
						arg_281_1:RecordAudio("426041069", var_284_22)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_426041", "426041069", "story_v_out_426041.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_426041", "426041069", "story_v_out_426041.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_23 = math.max(var_284_14, arg_281_1.talkMaxDuration)

			if var_284_13 <= arg_281_1.time_ and arg_281_1.time_ < var_284_13 + var_284_23 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_13) / var_284_23

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_13 + var_284_23 and arg_281_1.time_ < var_284_13 + var_284_23 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426041070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 426041070
		arg_285_1.duration_ = 9.83

		local var_285_0 = {
			zh = 9.833,
			ja = 8.1
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
				arg_285_0:Play426041071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1054ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1054ui_story = var_288_0.localPosition

				local var_288_2 = GameObjectTools.GetOrAddComponent(var_288_0.gameObject, typeof(DynamicBoneHelper))

				if var_288_2 then
					var_288_2:EnableDynamicBone(false)
				end
			end

			local var_288_3 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_3 then
				local var_288_4 = (arg_285_1.time_ - var_288_1) / var_288_3
				local var_288_5 = Vector3.New(0.7, -0.985, -6)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1054ui_story, var_288_5, var_288_4)

				local var_288_6 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_6.x, var_288_6.y, var_288_6.z)

				local var_288_7 = var_288_0.localEulerAngles

				var_288_7.z = 0
				var_288_7.x = 0
				var_288_0.localEulerAngles = var_288_7
			end

			if arg_285_1.time_ >= var_288_1 + var_288_3 and arg_285_1.time_ < var_288_1 + var_288_3 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_288_8 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_8.x, var_288_8.y, var_288_8.z)

				local var_288_9 = var_288_0.localEulerAngles

				var_288_9.z = 0
				var_288_9.x = 0
				var_288_0.localEulerAngles = var_288_9

				local var_288_10 = GameObjectTools.GetOrAddComponent(var_288_0.gameObject, typeof(DynamicBoneHelper))

				if var_288_10 then
					var_288_10:EnableDynamicBone(true)
				end
			end

			local var_288_11 = arg_285_1.actors_["1054ui_story"]
			local var_288_12 = 0

			if var_288_12 < arg_285_1.time_ and arg_285_1.time_ <= var_288_12 + arg_288_0 and not isNil(var_288_11) and arg_285_1.var_.characterEffect1054ui_story == nil then
				arg_285_1.var_.characterEffect1054ui_story = var_288_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_13 = 0.200000002980232

			if var_288_12 <= arg_285_1.time_ and arg_285_1.time_ < var_288_12 + var_288_13 and not isNil(var_288_11) then
				local var_288_14 = (arg_285_1.time_ - var_288_12) / var_288_13

				if arg_285_1.var_.characterEffect1054ui_story and not isNil(var_288_11) then
					arg_285_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_12 + var_288_13 and arg_285_1.time_ < var_288_12 + var_288_13 + arg_288_0 and not isNil(var_288_11) and arg_285_1.var_.characterEffect1054ui_story then
				arg_285_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_288_15 = arg_285_1.actors_["6148ui_story"]
			local var_288_16 = 0

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 and not isNil(var_288_15) and arg_285_1.var_.characterEffect6148ui_story == nil then
				arg_285_1.var_.characterEffect6148ui_story = var_288_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_17 = 0.200000002980232

			if var_288_16 <= arg_285_1.time_ and arg_285_1.time_ < var_288_16 + var_288_17 and not isNil(var_288_15) then
				local var_288_18 = (arg_285_1.time_ - var_288_16) / var_288_17

				if arg_285_1.var_.characterEffect6148ui_story and not isNil(var_288_15) then
					local var_288_19 = Mathf.Lerp(0, 0.5, var_288_18)

					arg_285_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_285_1.var_.characterEffect6148ui_story.fillRatio = var_288_19
				end
			end

			if arg_285_1.time_ >= var_288_16 + var_288_17 and arg_285_1.time_ < var_288_16 + var_288_17 + arg_288_0 and not isNil(var_288_15) and arg_285_1.var_.characterEffect6148ui_story then
				local var_288_20 = 0.5

				arg_285_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_285_1.var_.characterEffect6148ui_story.fillRatio = var_288_20
			end

			local var_288_21 = 0

			if var_288_21 < arg_285_1.time_ and arg_285_1.time_ <= var_288_21 + arg_288_0 then
				arg_285_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_288_22 = 0

			if var_288_22 < arg_285_1.time_ and arg_285_1.time_ <= var_288_22 + arg_288_0 then
				arg_285_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_288_23 = arg_285_1.actors_["6148ui_story"].transform
			local var_288_24 = 0

			if var_288_24 < arg_285_1.time_ and arg_285_1.time_ <= var_288_24 + arg_288_0 then
				arg_285_1.var_.moveOldPos6148ui_story = var_288_23.localPosition

				local var_288_25 = GameObjectTools.GetOrAddComponent(var_288_23.gameObject, typeof(DynamicBoneHelper))

				if var_288_25 then
					var_288_25:EnableDynamicBone(false)
				end
			end

			local var_288_26 = 0.001

			if var_288_24 <= arg_285_1.time_ and arg_285_1.time_ < var_288_24 + var_288_26 then
				local var_288_27 = (arg_285_1.time_ - var_288_24) / var_288_26
				local var_288_28 = Vector3.New(-0.7, -0.985, -6)

				var_288_23.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos6148ui_story, var_288_28, var_288_27)

				local var_288_29 = manager.ui.mainCamera.transform.position - var_288_23.position

				var_288_23.forward = Vector3.New(var_288_29.x, var_288_29.y, var_288_29.z)

				local var_288_30 = var_288_23.localEulerAngles

				var_288_30.z = 0
				var_288_30.x = 0
				var_288_23.localEulerAngles = var_288_30
			end

			if arg_285_1.time_ >= var_288_24 + var_288_26 and arg_285_1.time_ < var_288_24 + var_288_26 + arg_288_0 then
				var_288_23.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_288_31 = manager.ui.mainCamera.transform.position - var_288_23.position

				var_288_23.forward = Vector3.New(var_288_31.x, var_288_31.y, var_288_31.z)

				local var_288_32 = var_288_23.localEulerAngles

				var_288_32.z = 0
				var_288_32.x = 0
				var_288_23.localEulerAngles = var_288_32

				local var_288_33 = GameObjectTools.GetOrAddComponent(var_288_23.gameObject, typeof(DynamicBoneHelper))

				if var_288_33 then
					var_288_33:EnableDynamicBone(true)
				end
			end

			local var_288_34 = 0
			local var_288_35 = 0.775

			if var_288_34 < arg_285_1.time_ and arg_285_1.time_ <= var_288_34 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_36 = arg_285_1:FormatText(StoryNameCfg[1487].name)

				arg_285_1.leftNameTxt_.text = var_288_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_37 = arg_285_1:GetWordFromCfg(426041070)
				local var_288_38 = arg_285_1:FormatText(var_288_37.content)

				arg_285_1.text_.text = var_288_38

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_39 = 31
				local var_288_40 = utf8.len(var_288_38)
				local var_288_41 = var_288_39 <= 0 and var_288_35 or var_288_35 * (var_288_40 / var_288_39)

				if var_288_41 > 0 and var_288_35 < var_288_41 then
					arg_285_1.talkMaxDuration = var_288_41

					if var_288_41 + var_288_34 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_41 + var_288_34
					end
				end

				arg_285_1.text_.text = var_288_38
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041070", "story_v_out_426041.awb") ~= 0 then
					local var_288_42 = manager.audio:GetVoiceLength("story_v_out_426041", "426041070", "story_v_out_426041.awb") / 1000

					if var_288_42 + var_288_34 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_42 + var_288_34
					end

					if var_288_37.prefab_name ~= "" and arg_285_1.actors_[var_288_37.prefab_name] ~= nil then
						local var_288_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_37.prefab_name].transform, "story_v_out_426041", "426041070", "story_v_out_426041.awb")

						arg_285_1:RecordAudio("426041070", var_288_43)
						arg_285_1:RecordAudio("426041070", var_288_43)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_426041", "426041070", "story_v_out_426041.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_426041", "426041070", "story_v_out_426041.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_44 = math.max(var_288_35, arg_285_1.talkMaxDuration)

			if var_288_34 <= arg_285_1.time_ and arg_285_1.time_ < var_288_34 + var_288_44 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_34) / var_288_44

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_34 + var_288_44 and arg_285_1.time_ < var_288_34 + var_288_44 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426041071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 426041071
		arg_289_1.duration_ = 9.1

		local var_289_0 = {
			zh = 6.1,
			ja = 9.1
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play426041072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["6148ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos6148ui_story = var_292_0.localPosition

				local var_292_2 = GameObjectTools.GetOrAddComponent(var_292_0.gameObject, typeof(DynamicBoneHelper))

				if var_292_2 then
					var_292_2:EnableDynamicBone(false)
				end
			end

			local var_292_3 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_3 then
				local var_292_4 = (arg_289_1.time_ - var_292_1) / var_292_3
				local var_292_5 = Vector3.New(-0.7, -0.985, -6)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos6148ui_story, var_292_5, var_292_4)

				local var_292_6 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_6.x, var_292_6.y, var_292_6.z)

				local var_292_7 = var_292_0.localEulerAngles

				var_292_7.z = 0
				var_292_7.x = 0
				var_292_0.localEulerAngles = var_292_7
			end

			if arg_289_1.time_ >= var_292_1 + var_292_3 and arg_289_1.time_ < var_292_1 + var_292_3 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_292_8 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_8.x, var_292_8.y, var_292_8.z)

				local var_292_9 = var_292_0.localEulerAngles

				var_292_9.z = 0
				var_292_9.x = 0
				var_292_0.localEulerAngles = var_292_9

				local var_292_10 = GameObjectTools.GetOrAddComponent(var_292_0.gameObject, typeof(DynamicBoneHelper))

				if var_292_10 then
					var_292_10:EnableDynamicBone(true)
				end
			end

			local var_292_11 = arg_289_1.actors_["6148ui_story"]
			local var_292_12 = 0

			if var_292_12 < arg_289_1.time_ and arg_289_1.time_ <= var_292_12 + arg_292_0 and not isNil(var_292_11) and arg_289_1.var_.characterEffect6148ui_story == nil then
				arg_289_1.var_.characterEffect6148ui_story = var_292_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_13 = 0.200000002980232

			if var_292_12 <= arg_289_1.time_ and arg_289_1.time_ < var_292_12 + var_292_13 and not isNil(var_292_11) then
				local var_292_14 = (arg_289_1.time_ - var_292_12) / var_292_13

				if arg_289_1.var_.characterEffect6148ui_story and not isNil(var_292_11) then
					arg_289_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_12 + var_292_13 and arg_289_1.time_ < var_292_12 + var_292_13 + arg_292_0 and not isNil(var_292_11) and arg_289_1.var_.characterEffect6148ui_story then
				arg_289_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_292_15 = arg_289_1.actors_["1054ui_story"]
			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.characterEffect1054ui_story == nil then
				arg_289_1.var_.characterEffect1054ui_story = var_292_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_17 = 0.200000002980232

			if var_292_16 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_17 and not isNil(var_292_15) then
				local var_292_18 = (arg_289_1.time_ - var_292_16) / var_292_17

				if arg_289_1.var_.characterEffect1054ui_story and not isNil(var_292_15) then
					local var_292_19 = Mathf.Lerp(0, 0.5, var_292_18)

					arg_289_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1054ui_story.fillRatio = var_292_19
				end
			end

			if arg_289_1.time_ >= var_292_16 + var_292_17 and arg_289_1.time_ < var_292_16 + var_292_17 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.characterEffect1054ui_story then
				local var_292_20 = 0.5

				arg_289_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1054ui_story.fillRatio = var_292_20
			end

			local var_292_21 = 0

			if var_292_21 < arg_289_1.time_ and arg_289_1.time_ <= var_292_21 + arg_292_0 then
				arg_289_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_292_22 = 0

			if var_292_22 < arg_289_1.time_ and arg_289_1.time_ <= var_292_22 + arg_292_0 then
				arg_289_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_292_23 = 0
			local var_292_24 = 0.75

			if var_292_23 < arg_289_1.time_ and arg_289_1.time_ <= var_292_23 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_25 = arg_289_1:FormatText(StoryNameCfg[1488].name)

				arg_289_1.leftNameTxt_.text = var_292_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_26 = arg_289_1:GetWordFromCfg(426041071)
				local var_292_27 = arg_289_1:FormatText(var_292_26.content)

				arg_289_1.text_.text = var_292_27

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_28 = 30
				local var_292_29 = utf8.len(var_292_27)
				local var_292_30 = var_292_28 <= 0 and var_292_24 or var_292_24 * (var_292_29 / var_292_28)

				if var_292_30 > 0 and var_292_24 < var_292_30 then
					arg_289_1.talkMaxDuration = var_292_30

					if var_292_30 + var_292_23 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_30 + var_292_23
					end
				end

				arg_289_1.text_.text = var_292_27
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041071", "story_v_out_426041.awb") ~= 0 then
					local var_292_31 = manager.audio:GetVoiceLength("story_v_out_426041", "426041071", "story_v_out_426041.awb") / 1000

					if var_292_31 + var_292_23 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_31 + var_292_23
					end

					if var_292_26.prefab_name ~= "" and arg_289_1.actors_[var_292_26.prefab_name] ~= nil then
						local var_292_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_26.prefab_name].transform, "story_v_out_426041", "426041071", "story_v_out_426041.awb")

						arg_289_1:RecordAudio("426041071", var_292_32)
						arg_289_1:RecordAudio("426041071", var_292_32)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_426041", "426041071", "story_v_out_426041.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_426041", "426041071", "story_v_out_426041.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_33 = math.max(var_292_24, arg_289_1.talkMaxDuration)

			if var_292_23 <= arg_289_1.time_ and arg_289_1.time_ < var_292_23 + var_292_33 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_23) / var_292_33

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_23 + var_292_33 and arg_289_1.time_ < var_292_23 + var_292_33 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play426041072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 426041072
		arg_293_1.duration_ = 3.17

		local var_293_0 = {
			zh = 3.1,
			ja = 3.166
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
				arg_293_0:Play426041073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["6148ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos6148ui_story = var_296_0.localPosition

				local var_296_2 = GameObjectTools.GetOrAddComponent(var_296_0.gameObject, typeof(DynamicBoneHelper))

				if var_296_2 then
					var_296_2:EnableDynamicBone(false)
				end
			end

			local var_296_3 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_3 then
				local var_296_4 = (arg_293_1.time_ - var_296_1) / var_296_3
				local var_296_5 = Vector3.New(-0.7, -0.985, -6)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos6148ui_story, var_296_5, var_296_4)

				local var_296_6 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_6.x, var_296_6.y, var_296_6.z)

				local var_296_7 = var_296_0.localEulerAngles

				var_296_7.z = 0
				var_296_7.x = 0
				var_296_0.localEulerAngles = var_296_7
			end

			if arg_293_1.time_ >= var_296_1 + var_296_3 and arg_293_1.time_ < var_296_1 + var_296_3 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_296_8 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_8.x, var_296_8.y, var_296_8.z)

				local var_296_9 = var_296_0.localEulerAngles

				var_296_9.z = 0
				var_296_9.x = 0
				var_296_0.localEulerAngles = var_296_9

				local var_296_10 = GameObjectTools.GetOrAddComponent(var_296_0.gameObject, typeof(DynamicBoneHelper))

				if var_296_10 then
					var_296_10:EnableDynamicBone(true)
				end
			end

			local var_296_11 = 0

			if var_296_11 < arg_293_1.time_ and arg_293_1.time_ <= var_296_11 + arg_296_0 then
				arg_293_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_296_12 = 0
			local var_296_13 = 0.35

			if var_296_12 < arg_293_1.time_ and arg_293_1.time_ <= var_296_12 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_14 = arg_293_1:FormatText(StoryNameCfg[1488].name)

				arg_293_1.leftNameTxt_.text = var_296_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_15 = arg_293_1:GetWordFromCfg(426041072)
				local var_296_16 = arg_293_1:FormatText(var_296_15.content)

				arg_293_1.text_.text = var_296_16

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_17 = 14
				local var_296_18 = utf8.len(var_296_16)
				local var_296_19 = var_296_17 <= 0 and var_296_13 or var_296_13 * (var_296_18 / var_296_17)

				if var_296_19 > 0 and var_296_13 < var_296_19 then
					arg_293_1.talkMaxDuration = var_296_19

					if var_296_19 + var_296_12 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_19 + var_296_12
					end
				end

				arg_293_1.text_.text = var_296_16
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041072", "story_v_out_426041.awb") ~= 0 then
					local var_296_20 = manager.audio:GetVoiceLength("story_v_out_426041", "426041072", "story_v_out_426041.awb") / 1000

					if var_296_20 + var_296_12 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_20 + var_296_12
					end

					if var_296_15.prefab_name ~= "" and arg_293_1.actors_[var_296_15.prefab_name] ~= nil then
						local var_296_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_15.prefab_name].transform, "story_v_out_426041", "426041072", "story_v_out_426041.awb")

						arg_293_1:RecordAudio("426041072", var_296_21)
						arg_293_1:RecordAudio("426041072", var_296_21)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_426041", "426041072", "story_v_out_426041.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_426041", "426041072", "story_v_out_426041.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_22 = math.max(var_296_13, arg_293_1.talkMaxDuration)

			if var_296_12 <= arg_293_1.time_ and arg_293_1.time_ < var_296_12 + var_296_22 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_12) / var_296_22

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_12 + var_296_22 and arg_293_1.time_ < var_296_12 + var_296_22 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play426041073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 426041073
		arg_297_1.duration_ = 4.8

		local var_297_0 = {
			zh = 4.8,
			ja = 3.566
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
				arg_297_0:Play426041074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1054ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1054ui_story = var_300_0.localPosition

				local var_300_2 = GameObjectTools.GetOrAddComponent(var_300_0.gameObject, typeof(DynamicBoneHelper))

				if var_300_2 then
					var_300_2:EnableDynamicBone(false)
				end
			end

			local var_300_3 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_3 then
				local var_300_4 = (arg_297_1.time_ - var_300_1) / var_300_3
				local var_300_5 = Vector3.New(0.7, -0.985, -6)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1054ui_story, var_300_5, var_300_4)

				local var_300_6 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_6.x, var_300_6.y, var_300_6.z)

				local var_300_7 = var_300_0.localEulerAngles

				var_300_7.z = 0
				var_300_7.x = 0
				var_300_0.localEulerAngles = var_300_7
			end

			if arg_297_1.time_ >= var_300_1 + var_300_3 and arg_297_1.time_ < var_300_1 + var_300_3 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_300_8 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_8.x, var_300_8.y, var_300_8.z)

				local var_300_9 = var_300_0.localEulerAngles

				var_300_9.z = 0
				var_300_9.x = 0
				var_300_0.localEulerAngles = var_300_9

				local var_300_10 = GameObjectTools.GetOrAddComponent(var_300_0.gameObject, typeof(DynamicBoneHelper))

				if var_300_10 then
					var_300_10:EnableDynamicBone(true)
				end
			end

			local var_300_11 = arg_297_1.actors_["1054ui_story"]
			local var_300_12 = 0

			if var_300_12 < arg_297_1.time_ and arg_297_1.time_ <= var_300_12 + arg_300_0 and not isNil(var_300_11) and arg_297_1.var_.characterEffect1054ui_story == nil then
				arg_297_1.var_.characterEffect1054ui_story = var_300_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_13 = 0.200000002980232

			if var_300_12 <= arg_297_1.time_ and arg_297_1.time_ < var_300_12 + var_300_13 and not isNil(var_300_11) then
				local var_300_14 = (arg_297_1.time_ - var_300_12) / var_300_13

				if arg_297_1.var_.characterEffect1054ui_story and not isNil(var_300_11) then
					arg_297_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_12 + var_300_13 and arg_297_1.time_ < var_300_12 + var_300_13 + arg_300_0 and not isNil(var_300_11) and arg_297_1.var_.characterEffect1054ui_story then
				arg_297_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_300_15 = arg_297_1.actors_["6148ui_story"]
			local var_300_16 = 0

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.characterEffect6148ui_story == nil then
				arg_297_1.var_.characterEffect6148ui_story = var_300_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_17 = 0.200000002980232

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_17 and not isNil(var_300_15) then
				local var_300_18 = (arg_297_1.time_ - var_300_16) / var_300_17

				if arg_297_1.var_.characterEffect6148ui_story and not isNil(var_300_15) then
					local var_300_19 = Mathf.Lerp(0, 0.5, var_300_18)

					arg_297_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_297_1.var_.characterEffect6148ui_story.fillRatio = var_300_19
				end
			end

			if arg_297_1.time_ >= var_300_16 + var_300_17 and arg_297_1.time_ < var_300_16 + var_300_17 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.characterEffect6148ui_story then
				local var_300_20 = 0.5

				arg_297_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_297_1.var_.characterEffect6148ui_story.fillRatio = var_300_20
			end

			local var_300_21 = 0

			if var_300_21 < arg_297_1.time_ and arg_297_1.time_ <= var_300_21 + arg_300_0 then
				arg_297_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			local var_300_22 = 0

			if var_300_22 < arg_297_1.time_ and arg_297_1.time_ <= var_300_22 + arg_300_0 then
				arg_297_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_300_23 = 0
			local var_300_24 = 0.475

			if var_300_23 < arg_297_1.time_ and arg_297_1.time_ <= var_300_23 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_25 = arg_297_1:FormatText(StoryNameCfg[1487].name)

				arg_297_1.leftNameTxt_.text = var_300_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_26 = arg_297_1:GetWordFromCfg(426041073)
				local var_300_27 = arg_297_1:FormatText(var_300_26.content)

				arg_297_1.text_.text = var_300_27

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_28 = 19
				local var_300_29 = utf8.len(var_300_27)
				local var_300_30 = var_300_28 <= 0 and var_300_24 or var_300_24 * (var_300_29 / var_300_28)

				if var_300_30 > 0 and var_300_24 < var_300_30 then
					arg_297_1.talkMaxDuration = var_300_30

					if var_300_30 + var_300_23 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_30 + var_300_23
					end
				end

				arg_297_1.text_.text = var_300_27
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041073", "story_v_out_426041.awb") ~= 0 then
					local var_300_31 = manager.audio:GetVoiceLength("story_v_out_426041", "426041073", "story_v_out_426041.awb") / 1000

					if var_300_31 + var_300_23 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_31 + var_300_23
					end

					if var_300_26.prefab_name ~= "" and arg_297_1.actors_[var_300_26.prefab_name] ~= nil then
						local var_300_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_26.prefab_name].transform, "story_v_out_426041", "426041073", "story_v_out_426041.awb")

						arg_297_1:RecordAudio("426041073", var_300_32)
						arg_297_1:RecordAudio("426041073", var_300_32)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_426041", "426041073", "story_v_out_426041.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_426041", "426041073", "story_v_out_426041.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_33 = math.max(var_300_24, arg_297_1.talkMaxDuration)

			if var_300_23 <= arg_297_1.time_ and arg_297_1.time_ < var_300_23 + var_300_33 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_23) / var_300_33

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_23 + var_300_33 and arg_297_1.time_ < var_300_23 + var_300_33 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426041074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 426041074
		arg_301_1.duration_ = 2.63

		local var_301_0 = {
			zh = 2.266,
			ja = 2.633
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play426041075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["6148ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos6148ui_story = var_304_0.localPosition

				local var_304_2 = GameObjectTools.GetOrAddComponent(var_304_0.gameObject, typeof(DynamicBoneHelper))

				if var_304_2 then
					var_304_2:EnableDynamicBone(false)
				end
			end

			local var_304_3 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_3 then
				local var_304_4 = (arg_301_1.time_ - var_304_1) / var_304_3
				local var_304_5 = Vector3.New(-0.7, -0.985, -6)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos6148ui_story, var_304_5, var_304_4)

				local var_304_6 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_6.x, var_304_6.y, var_304_6.z)

				local var_304_7 = var_304_0.localEulerAngles

				var_304_7.z = 0
				var_304_7.x = 0
				var_304_0.localEulerAngles = var_304_7
			end

			if arg_301_1.time_ >= var_304_1 + var_304_3 and arg_301_1.time_ < var_304_1 + var_304_3 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_304_8 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_8.x, var_304_8.y, var_304_8.z)

				local var_304_9 = var_304_0.localEulerAngles

				var_304_9.z = 0
				var_304_9.x = 0
				var_304_0.localEulerAngles = var_304_9

				local var_304_10 = GameObjectTools.GetOrAddComponent(var_304_0.gameObject, typeof(DynamicBoneHelper))

				if var_304_10 then
					var_304_10:EnableDynamicBone(true)
				end
			end

			local var_304_11 = arg_301_1.actors_["6148ui_story"]
			local var_304_12 = 0

			if var_304_12 < arg_301_1.time_ and arg_301_1.time_ <= var_304_12 + arg_304_0 and not isNil(var_304_11) and arg_301_1.var_.characterEffect6148ui_story == nil then
				arg_301_1.var_.characterEffect6148ui_story = var_304_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_13 = 0.200000002980232

			if var_304_12 <= arg_301_1.time_ and arg_301_1.time_ < var_304_12 + var_304_13 and not isNil(var_304_11) then
				local var_304_14 = (arg_301_1.time_ - var_304_12) / var_304_13

				if arg_301_1.var_.characterEffect6148ui_story and not isNil(var_304_11) then
					arg_301_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_12 + var_304_13 and arg_301_1.time_ < var_304_12 + var_304_13 + arg_304_0 and not isNil(var_304_11) and arg_301_1.var_.characterEffect6148ui_story then
				arg_301_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_304_15 = arg_301_1.actors_["1054ui_story"]
			local var_304_16 = 0

			if var_304_16 < arg_301_1.time_ and arg_301_1.time_ <= var_304_16 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.characterEffect1054ui_story == nil then
				arg_301_1.var_.characterEffect1054ui_story = var_304_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_17 = 0.200000002980232

			if var_304_16 <= arg_301_1.time_ and arg_301_1.time_ < var_304_16 + var_304_17 and not isNil(var_304_15) then
				local var_304_18 = (arg_301_1.time_ - var_304_16) / var_304_17

				if arg_301_1.var_.characterEffect1054ui_story and not isNil(var_304_15) then
					local var_304_19 = Mathf.Lerp(0, 0.5, var_304_18)

					arg_301_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1054ui_story.fillRatio = var_304_19
				end
			end

			if arg_301_1.time_ >= var_304_16 + var_304_17 and arg_301_1.time_ < var_304_16 + var_304_17 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.characterEffect1054ui_story then
				local var_304_20 = 0.5

				arg_301_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1054ui_story.fillRatio = var_304_20
			end

			local var_304_21 = 0

			if var_304_21 < arg_301_1.time_ and arg_301_1.time_ <= var_304_21 + arg_304_0 then
				arg_301_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_304_22 = 0

			if var_304_22 < arg_301_1.time_ and arg_301_1.time_ <= var_304_22 + arg_304_0 then
				arg_301_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_304_23 = 0
			local var_304_24 = 0.2

			if var_304_23 < arg_301_1.time_ and arg_301_1.time_ <= var_304_23 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_25 = arg_301_1:FormatText(StoryNameCfg[1488].name)

				arg_301_1.leftNameTxt_.text = var_304_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_26 = arg_301_1:GetWordFromCfg(426041074)
				local var_304_27 = arg_301_1:FormatText(var_304_26.content)

				arg_301_1.text_.text = var_304_27

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_28 = 8
				local var_304_29 = utf8.len(var_304_27)
				local var_304_30 = var_304_28 <= 0 and var_304_24 or var_304_24 * (var_304_29 / var_304_28)

				if var_304_30 > 0 and var_304_24 < var_304_30 then
					arg_301_1.talkMaxDuration = var_304_30

					if var_304_30 + var_304_23 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_30 + var_304_23
					end
				end

				arg_301_1.text_.text = var_304_27
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041074", "story_v_out_426041.awb") ~= 0 then
					local var_304_31 = manager.audio:GetVoiceLength("story_v_out_426041", "426041074", "story_v_out_426041.awb") / 1000

					if var_304_31 + var_304_23 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_31 + var_304_23
					end

					if var_304_26.prefab_name ~= "" and arg_301_1.actors_[var_304_26.prefab_name] ~= nil then
						local var_304_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_26.prefab_name].transform, "story_v_out_426041", "426041074", "story_v_out_426041.awb")

						arg_301_1:RecordAudio("426041074", var_304_32)
						arg_301_1:RecordAudio("426041074", var_304_32)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_426041", "426041074", "story_v_out_426041.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_426041", "426041074", "story_v_out_426041.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_33 = math.max(var_304_24, arg_301_1.talkMaxDuration)

			if var_304_23 <= arg_301_1.time_ and arg_301_1.time_ < var_304_23 + var_304_33 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_23) / var_304_33

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_23 + var_304_33 and arg_301_1.time_ < var_304_23 + var_304_33 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426041075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 426041075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play426041076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["6148ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect6148ui_story == nil then
				arg_305_1.var_.characterEffect6148ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect6148ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_305_1.var_.characterEffect6148ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect6148ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_305_1.var_.characterEffect6148ui_story.fillRatio = var_308_5
			end

			local var_308_6 = 0
			local var_308_7 = 1.175

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_8 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_9 = arg_305_1:GetWordFromCfg(426041075)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 47
				local var_308_12 = utf8.len(var_308_10)
				local var_308_13 = var_308_11 <= 0 and var_308_7 or var_308_7 * (var_308_12 / var_308_11)

				if var_308_13 > 0 and var_308_7 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_6
					end
				end

				arg_305_1.text_.text = var_308_10
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_14 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_14 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_14

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_14 and arg_305_1.time_ < var_308_6 + var_308_14 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play426041076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 426041076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play426041077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.575

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

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(426041076)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 23
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
	Play426041077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 426041077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play426041078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1054ui_story"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos1054ui_story = var_316_0.localPosition

				local var_316_2 = GameObjectTools.GetOrAddComponent(var_316_0.gameObject, typeof(DynamicBoneHelper))

				if var_316_2 then
					var_316_2:EnableDynamicBone(false)
				end
			end

			local var_316_3 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_3 then
				local var_316_4 = (arg_313_1.time_ - var_316_1) / var_316_3
				local var_316_5 = Vector3.New(0, 100, 0)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1054ui_story, var_316_5, var_316_4)

				local var_316_6 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_6.x, var_316_6.y, var_316_6.z)

				local var_316_7 = var_316_0.localEulerAngles

				var_316_7.z = 0
				var_316_7.x = 0
				var_316_0.localEulerAngles = var_316_7
			end

			if arg_313_1.time_ >= var_316_1 + var_316_3 and arg_313_1.time_ < var_316_1 + var_316_3 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, 100, 0)

				local var_316_8 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_8.x, var_316_8.y, var_316_8.z)

				local var_316_9 = var_316_0.localEulerAngles

				var_316_9.z = 0
				var_316_9.x = 0
				var_316_0.localEulerAngles = var_316_9

				local var_316_10 = GameObjectTools.GetOrAddComponent(var_316_0.gameObject, typeof(DynamicBoneHelper))

				if var_316_10 then
					var_316_10:EnableDynamicBone(true)
				end
			end

			local var_316_11 = arg_313_1.actors_["6148ui_story"].transform
			local var_316_12 = 0

			if var_316_12 < arg_313_1.time_ and arg_313_1.time_ <= var_316_12 + arg_316_0 then
				arg_313_1.var_.moveOldPos6148ui_story = var_316_11.localPosition

				local var_316_13 = GameObjectTools.GetOrAddComponent(var_316_11.gameObject, typeof(DynamicBoneHelper))

				if var_316_13 then
					var_316_13:EnableDynamicBone(false)
				end
			end

			local var_316_14 = 0.001

			if var_316_12 <= arg_313_1.time_ and arg_313_1.time_ < var_316_12 + var_316_14 then
				local var_316_15 = (arg_313_1.time_ - var_316_12) / var_316_14
				local var_316_16 = Vector3.New(0, 100, 0)

				var_316_11.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos6148ui_story, var_316_16, var_316_15)

				local var_316_17 = manager.ui.mainCamera.transform.position - var_316_11.position

				var_316_11.forward = Vector3.New(var_316_17.x, var_316_17.y, var_316_17.z)

				local var_316_18 = var_316_11.localEulerAngles

				var_316_18.z = 0
				var_316_18.x = 0
				var_316_11.localEulerAngles = var_316_18
			end

			if arg_313_1.time_ >= var_316_12 + var_316_14 and arg_313_1.time_ < var_316_12 + var_316_14 + arg_316_0 then
				var_316_11.localPosition = Vector3.New(0, 100, 0)

				local var_316_19 = manager.ui.mainCamera.transform.position - var_316_11.position

				var_316_11.forward = Vector3.New(var_316_19.x, var_316_19.y, var_316_19.z)

				local var_316_20 = var_316_11.localEulerAngles

				var_316_20.z = 0
				var_316_20.x = 0
				var_316_11.localEulerAngles = var_316_20

				local var_316_21 = GameObjectTools.GetOrAddComponent(var_316_11.gameObject, typeof(DynamicBoneHelper))

				if var_316_21 then
					var_316_21:EnableDynamicBone(true)
				end
			end

			local var_316_22 = 0
			local var_316_23 = 0.525

			if var_316_22 < arg_313_1.time_ and arg_313_1.time_ <= var_316_22 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_24 = arg_313_1:GetWordFromCfg(426041077)
				local var_316_25 = arg_313_1:FormatText(var_316_24.content)

				arg_313_1.text_.text = var_316_25

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_26 = 21
				local var_316_27 = utf8.len(var_316_25)
				local var_316_28 = var_316_26 <= 0 and var_316_23 or var_316_23 * (var_316_27 / var_316_26)

				if var_316_28 > 0 and var_316_23 < var_316_28 then
					arg_313_1.talkMaxDuration = var_316_28

					if var_316_28 + var_316_22 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_28 + var_316_22
					end
				end

				arg_313_1.text_.text = var_316_25
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_29 = math.max(var_316_23, arg_313_1.talkMaxDuration)

			if var_316_22 <= arg_313_1.time_ and arg_313_1.time_ < var_316_22 + var_316_29 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_22) / var_316_29

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_22 + var_316_29 and arg_313_1.time_ < var_316_22 + var_316_29 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play426041078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 426041078
		arg_317_1.duration_ = 8

		local var_317_0 = {
			zh = 7.5,
			ja = 8
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play426041079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["6148ui_story"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos6148ui_story = var_320_0.localPosition

				local var_320_2 = GameObjectTools.GetOrAddComponent(var_320_0.gameObject, typeof(DynamicBoneHelper))

				if var_320_2 then
					var_320_2:EnableDynamicBone(false)
				end
			end

			local var_320_3 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_3 then
				local var_320_4 = (arg_317_1.time_ - var_320_1) / var_320_3
				local var_320_5 = Vector3.New(0, -0.985, -6)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos6148ui_story, var_320_5, var_320_4)

				local var_320_6 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_6.x, var_320_6.y, var_320_6.z)

				local var_320_7 = var_320_0.localEulerAngles

				var_320_7.z = 0
				var_320_7.x = 0
				var_320_0.localEulerAngles = var_320_7
			end

			if arg_317_1.time_ >= var_320_1 + var_320_3 and arg_317_1.time_ < var_320_1 + var_320_3 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_320_8 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_8.x, var_320_8.y, var_320_8.z)

				local var_320_9 = var_320_0.localEulerAngles

				var_320_9.z = 0
				var_320_9.x = 0
				var_320_0.localEulerAngles = var_320_9

				local var_320_10 = GameObjectTools.GetOrAddComponent(var_320_0.gameObject, typeof(DynamicBoneHelper))

				if var_320_10 then
					var_320_10:EnableDynamicBone(true)
				end
			end

			local var_320_11 = arg_317_1.actors_["6148ui_story"]
			local var_320_12 = 0

			if var_320_12 < arg_317_1.time_ and arg_317_1.time_ <= var_320_12 + arg_320_0 and not isNil(var_320_11) and arg_317_1.var_.characterEffect6148ui_story == nil then
				arg_317_1.var_.characterEffect6148ui_story = var_320_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_13 = 0.200000002980232

			if var_320_12 <= arg_317_1.time_ and arg_317_1.time_ < var_320_12 + var_320_13 and not isNil(var_320_11) then
				local var_320_14 = (arg_317_1.time_ - var_320_12) / var_320_13

				if arg_317_1.var_.characterEffect6148ui_story and not isNil(var_320_11) then
					arg_317_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_12 + var_320_13 and arg_317_1.time_ < var_320_12 + var_320_13 + arg_320_0 and not isNil(var_320_11) and arg_317_1.var_.characterEffect6148ui_story then
				arg_317_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_320_15 = 0

			if var_320_15 < arg_317_1.time_ and arg_317_1.time_ <= var_320_15 + arg_320_0 then
				arg_317_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_320_16 = 0

			if var_320_16 < arg_317_1.time_ and arg_317_1.time_ <= var_320_16 + arg_320_0 then
				arg_317_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_320_17 = 0
			local var_320_18 = 0.95

			if var_320_17 < arg_317_1.time_ and arg_317_1.time_ <= var_320_17 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_19 = arg_317_1:FormatText(StoryNameCfg[1488].name)

				arg_317_1.leftNameTxt_.text = var_320_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_20 = arg_317_1:GetWordFromCfg(426041078)
				local var_320_21 = arg_317_1:FormatText(var_320_20.content)

				arg_317_1.text_.text = var_320_21

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_22 = 38
				local var_320_23 = utf8.len(var_320_21)
				local var_320_24 = var_320_22 <= 0 and var_320_18 or var_320_18 * (var_320_23 / var_320_22)

				if var_320_24 > 0 and var_320_18 < var_320_24 then
					arg_317_1.talkMaxDuration = var_320_24

					if var_320_24 + var_320_17 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_24 + var_320_17
					end
				end

				arg_317_1.text_.text = var_320_21
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041078", "story_v_out_426041.awb") ~= 0 then
					local var_320_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041078", "story_v_out_426041.awb") / 1000

					if var_320_25 + var_320_17 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_25 + var_320_17
					end

					if var_320_20.prefab_name ~= "" and arg_317_1.actors_[var_320_20.prefab_name] ~= nil then
						local var_320_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_20.prefab_name].transform, "story_v_out_426041", "426041078", "story_v_out_426041.awb")

						arg_317_1:RecordAudio("426041078", var_320_26)
						arg_317_1:RecordAudio("426041078", var_320_26)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_426041", "426041078", "story_v_out_426041.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_426041", "426041078", "story_v_out_426041.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_27 = math.max(var_320_18, arg_317_1.talkMaxDuration)

			if var_320_17 <= arg_317_1.time_ and arg_317_1.time_ < var_320_17 + var_320_27 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_17) / var_320_27

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_17 + var_320_27 and arg_317_1.time_ < var_320_17 + var_320_27 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play426041079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 426041079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play426041080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["6148ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect6148ui_story == nil then
				arg_321_1.var_.characterEffect6148ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect6148ui_story and not isNil(var_324_0) then
					local var_324_4 = Mathf.Lerp(0, 0.5, var_324_3)

					arg_321_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_321_1.var_.characterEffect6148ui_story.fillRatio = var_324_4
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect6148ui_story then
				local var_324_5 = 0.5

				arg_321_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_321_1.var_.characterEffect6148ui_story.fillRatio = var_324_5
			end

			local var_324_6 = 0
			local var_324_7 = 0.35

			if var_324_6 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_8 = arg_321_1:FormatText(StoryNameCfg[7].name)

				arg_321_1.leftNameTxt_.text = var_324_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_9 = arg_321_1:GetWordFromCfg(426041079)
				local var_324_10 = arg_321_1:FormatText(var_324_9.content)

				arg_321_1.text_.text = var_324_10

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 14
				local var_324_12 = utf8.len(var_324_10)
				local var_324_13 = var_324_11 <= 0 and var_324_7 or var_324_7 * (var_324_12 / var_324_11)

				if var_324_13 > 0 and var_324_7 < var_324_13 then
					arg_321_1.talkMaxDuration = var_324_13

					if var_324_13 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_6
					end
				end

				arg_321_1.text_.text = var_324_10
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_14 = math.max(var_324_7, arg_321_1.talkMaxDuration)

			if var_324_6 <= arg_321_1.time_ and arg_321_1.time_ < var_324_6 + var_324_14 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_6) / var_324_14

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_6 + var_324_14 and arg_321_1.time_ < var_324_6 + var_324_14 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play426041080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 426041080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play426041081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 1.125

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[7].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:GetWordFromCfg(426041080)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 45
				local var_328_6 = utf8.len(var_328_4)
				local var_328_7 = var_328_5 <= 0 and var_328_1 or var_328_1 * (var_328_6 / var_328_5)

				if var_328_7 > 0 and var_328_1 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_8 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_8 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_8

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_8 and arg_325_1.time_ < var_328_0 + var_328_8 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play426041081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 426041081
		arg_329_1.duration_ = 6.87

		local var_329_0 = {
			zh = 3.8,
			ja = 6.866
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play426041082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["6148ui_story"].transform
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.var_.moveOldPos6148ui_story = var_332_0.localPosition

				local var_332_2 = GameObjectTools.GetOrAddComponent(var_332_0.gameObject, typeof(DynamicBoneHelper))

				if var_332_2 then
					var_332_2:EnableDynamicBone(false)
				end
			end

			local var_332_3 = 0.001

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_3 then
				local var_332_4 = (arg_329_1.time_ - var_332_1) / var_332_3
				local var_332_5 = Vector3.New(0, -0.985, -6)

				var_332_0.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos6148ui_story, var_332_5, var_332_4)

				local var_332_6 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_6.x, var_332_6.y, var_332_6.z)

				local var_332_7 = var_332_0.localEulerAngles

				var_332_7.z = 0
				var_332_7.x = 0
				var_332_0.localEulerAngles = var_332_7
			end

			if arg_329_1.time_ >= var_332_1 + var_332_3 and arg_329_1.time_ < var_332_1 + var_332_3 + arg_332_0 then
				var_332_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_332_8 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_8.x, var_332_8.y, var_332_8.z)

				local var_332_9 = var_332_0.localEulerAngles

				var_332_9.z = 0
				var_332_9.x = 0
				var_332_0.localEulerAngles = var_332_9

				local var_332_10 = GameObjectTools.GetOrAddComponent(var_332_0.gameObject, typeof(DynamicBoneHelper))

				if var_332_10 then
					var_332_10:EnableDynamicBone(true)
				end
			end

			local var_332_11 = arg_329_1.actors_["6148ui_story"]
			local var_332_12 = 0

			if var_332_12 < arg_329_1.time_ and arg_329_1.time_ <= var_332_12 + arg_332_0 and not isNil(var_332_11) and arg_329_1.var_.characterEffect6148ui_story == nil then
				arg_329_1.var_.characterEffect6148ui_story = var_332_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_13 = 0.200000002980232

			if var_332_12 <= arg_329_1.time_ and arg_329_1.time_ < var_332_12 + var_332_13 and not isNil(var_332_11) then
				local var_332_14 = (arg_329_1.time_ - var_332_12) / var_332_13

				if arg_329_1.var_.characterEffect6148ui_story and not isNil(var_332_11) then
					arg_329_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_12 + var_332_13 and arg_329_1.time_ < var_332_12 + var_332_13 + arg_332_0 and not isNil(var_332_11) and arg_329_1.var_.characterEffect6148ui_story then
				arg_329_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_332_15 = 0

			if var_332_15 < arg_329_1.time_ and arg_329_1.time_ <= var_332_15 + arg_332_0 then
				arg_329_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_332_16 = 0

			if var_332_16 < arg_329_1.time_ and arg_329_1.time_ <= var_332_16 + arg_332_0 then
				arg_329_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_332_17 = 0
			local var_332_18 = 0.425

			if var_332_17 < arg_329_1.time_ and arg_329_1.time_ <= var_332_17 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_19 = arg_329_1:FormatText(StoryNameCfg[1488].name)

				arg_329_1.leftNameTxt_.text = var_332_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_20 = arg_329_1:GetWordFromCfg(426041081)
				local var_332_21 = arg_329_1:FormatText(var_332_20.content)

				arg_329_1.text_.text = var_332_21

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_22 = 17
				local var_332_23 = utf8.len(var_332_21)
				local var_332_24 = var_332_22 <= 0 and var_332_18 or var_332_18 * (var_332_23 / var_332_22)

				if var_332_24 > 0 and var_332_18 < var_332_24 then
					arg_329_1.talkMaxDuration = var_332_24

					if var_332_24 + var_332_17 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_24 + var_332_17
					end
				end

				arg_329_1.text_.text = var_332_21
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041081", "story_v_out_426041.awb") ~= 0 then
					local var_332_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041081", "story_v_out_426041.awb") / 1000

					if var_332_25 + var_332_17 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_25 + var_332_17
					end

					if var_332_20.prefab_name ~= "" and arg_329_1.actors_[var_332_20.prefab_name] ~= nil then
						local var_332_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_20.prefab_name].transform, "story_v_out_426041", "426041081", "story_v_out_426041.awb")

						arg_329_1:RecordAudio("426041081", var_332_26)
						arg_329_1:RecordAudio("426041081", var_332_26)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_426041", "426041081", "story_v_out_426041.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_426041", "426041081", "story_v_out_426041.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_27 = math.max(var_332_18, arg_329_1.talkMaxDuration)

			if var_332_17 <= arg_329_1.time_ and arg_329_1.time_ < var_332_17 + var_332_27 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_17) / var_332_27

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_17 + var_332_27 and arg_329_1.time_ < var_332_17 + var_332_27 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play426041082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 426041082
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play426041083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["6148ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect6148ui_story == nil then
				arg_333_1.var_.characterEffect6148ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect6148ui_story and not isNil(var_336_0) then
					local var_336_4 = Mathf.Lerp(0, 0.5, var_336_3)

					arg_333_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_333_1.var_.characterEffect6148ui_story.fillRatio = var_336_4
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect6148ui_story then
				local var_336_5 = 0.5

				arg_333_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_333_1.var_.characterEffect6148ui_story.fillRatio = var_336_5
			end

			local var_336_6 = 0
			local var_336_7 = 0.725

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_8 = arg_333_1:FormatText(StoryNameCfg[7].name)

				arg_333_1.leftNameTxt_.text = var_336_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_9 = arg_333_1:GetWordFromCfg(426041082)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 29
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
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_14 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_14 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_14

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_14 and arg_333_1.time_ < var_336_6 + var_336_14 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play426041083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 426041083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play426041084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 0.75

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(426041083)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 30
				local var_340_6 = utf8.len(var_340_4)
				local var_340_7 = var_340_5 <= 0 and var_340_1 or var_340_1 * (var_340_6 / var_340_5)

				if var_340_7 > 0 and var_340_1 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_8 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_8 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_8

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_8 and arg_337_1.time_ < var_340_0 + var_340_8 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play426041084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 426041084
		arg_341_1.duration_ = 2.4

		local var_341_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_341_0:Play426041085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["6148ui_story"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos6148ui_story = var_344_0.localPosition

				local var_344_2 = GameObjectTools.GetOrAddComponent(var_344_0.gameObject, typeof(DynamicBoneHelper))

				if var_344_2 then
					var_344_2:EnableDynamicBone(false)
				end
			end

			local var_344_3 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_3 then
				local var_344_4 = (arg_341_1.time_ - var_344_1) / var_344_3
				local var_344_5 = Vector3.New(0, -0.985, -6)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos6148ui_story, var_344_5, var_344_4)

				local var_344_6 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_6.x, var_344_6.y, var_344_6.z)

				local var_344_7 = var_344_0.localEulerAngles

				var_344_7.z = 0
				var_344_7.x = 0
				var_344_0.localEulerAngles = var_344_7
			end

			if arg_341_1.time_ >= var_344_1 + var_344_3 and arg_341_1.time_ < var_344_1 + var_344_3 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_344_8 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_8.x, var_344_8.y, var_344_8.z)

				local var_344_9 = var_344_0.localEulerAngles

				var_344_9.z = 0
				var_344_9.x = 0
				var_344_0.localEulerAngles = var_344_9

				local var_344_10 = GameObjectTools.GetOrAddComponent(var_344_0.gameObject, typeof(DynamicBoneHelper))

				if var_344_10 then
					var_344_10:EnableDynamicBone(true)
				end
			end

			local var_344_11 = arg_341_1.actors_["6148ui_story"]
			local var_344_12 = 0

			if var_344_12 < arg_341_1.time_ and arg_341_1.time_ <= var_344_12 + arg_344_0 and not isNil(var_344_11) and arg_341_1.var_.characterEffect6148ui_story == nil then
				arg_341_1.var_.characterEffect6148ui_story = var_344_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_13 = 0.200000002980232

			if var_344_12 <= arg_341_1.time_ and arg_341_1.time_ < var_344_12 + var_344_13 and not isNil(var_344_11) then
				local var_344_14 = (arg_341_1.time_ - var_344_12) / var_344_13

				if arg_341_1.var_.characterEffect6148ui_story and not isNil(var_344_11) then
					arg_341_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_12 + var_344_13 and arg_341_1.time_ < var_344_12 + var_344_13 + arg_344_0 and not isNil(var_344_11) and arg_341_1.var_.characterEffect6148ui_story then
				arg_341_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_344_15 = 0

			if var_344_15 < arg_341_1.time_ and arg_341_1.time_ <= var_344_15 + arg_344_0 then
				arg_341_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_344_16 = 0

			if var_344_16 < arg_341_1.time_ and arg_341_1.time_ <= var_344_16 + arg_344_0 then
				arg_341_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_344_17 = 0
			local var_344_18 = 0.15

			if var_344_17 < arg_341_1.time_ and arg_341_1.time_ <= var_344_17 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_19 = arg_341_1:FormatText(StoryNameCfg[1488].name)

				arg_341_1.leftNameTxt_.text = var_344_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_20 = arg_341_1:GetWordFromCfg(426041084)
				local var_344_21 = arg_341_1:FormatText(var_344_20.content)

				arg_341_1.text_.text = var_344_21

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_22 = 6
				local var_344_23 = utf8.len(var_344_21)
				local var_344_24 = var_344_22 <= 0 and var_344_18 or var_344_18 * (var_344_23 / var_344_22)

				if var_344_24 > 0 and var_344_18 < var_344_24 then
					arg_341_1.talkMaxDuration = var_344_24

					if var_344_24 + var_344_17 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_24 + var_344_17
					end
				end

				arg_341_1.text_.text = var_344_21
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041084", "story_v_out_426041.awb") ~= 0 then
					local var_344_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041084", "story_v_out_426041.awb") / 1000

					if var_344_25 + var_344_17 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_25 + var_344_17
					end

					if var_344_20.prefab_name ~= "" and arg_341_1.actors_[var_344_20.prefab_name] ~= nil then
						local var_344_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_20.prefab_name].transform, "story_v_out_426041", "426041084", "story_v_out_426041.awb")

						arg_341_1:RecordAudio("426041084", var_344_26)
						arg_341_1:RecordAudio("426041084", var_344_26)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_426041", "426041084", "story_v_out_426041.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_426041", "426041084", "story_v_out_426041.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_27 = math.max(var_344_18, arg_341_1.talkMaxDuration)

			if var_344_17 <= arg_341_1.time_ and arg_341_1.time_ < var_344_17 + var_344_27 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_17) / var_344_27

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_17 + var_344_27 and arg_341_1.time_ < var_344_17 + var_344_27 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play426041085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 426041085
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play426041086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["6148ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect6148ui_story == nil then
				arg_345_1.var_.characterEffect6148ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect6148ui_story and not isNil(var_348_0) then
					local var_348_4 = Mathf.Lerp(0, 0.5, var_348_3)

					arg_345_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_345_1.var_.characterEffect6148ui_story.fillRatio = var_348_4
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect6148ui_story then
				local var_348_5 = 0.5

				arg_345_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_345_1.var_.characterEffect6148ui_story.fillRatio = var_348_5
			end

			local var_348_6 = 0
			local var_348_7 = 1.025

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

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_9 = arg_345_1:GetWordFromCfg(426041085)
				local var_348_10 = arg_345_1:FormatText(var_348_9.content)

				arg_345_1.text_.text = var_348_10

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 41
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
	Play426041086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 426041086
		arg_349_1.duration_ = 4.57

		local var_349_0 = {
			zh = 4.566,
			ja = 3.533
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
				arg_349_0:Play426041087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["6148ui_story"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos6148ui_story = var_352_0.localPosition

				local var_352_2 = GameObjectTools.GetOrAddComponent(var_352_0.gameObject, typeof(DynamicBoneHelper))

				if var_352_2 then
					var_352_2:EnableDynamicBone(false)
				end
			end

			local var_352_3 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_3 then
				local var_352_4 = (arg_349_1.time_ - var_352_1) / var_352_3
				local var_352_5 = Vector3.New(0, -0.985, -6)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos6148ui_story, var_352_5, var_352_4)

				local var_352_6 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_6.x, var_352_6.y, var_352_6.z)

				local var_352_7 = var_352_0.localEulerAngles

				var_352_7.z = 0
				var_352_7.x = 0
				var_352_0.localEulerAngles = var_352_7
			end

			if arg_349_1.time_ >= var_352_1 + var_352_3 and arg_349_1.time_ < var_352_1 + var_352_3 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_352_8 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_8.x, var_352_8.y, var_352_8.z)

				local var_352_9 = var_352_0.localEulerAngles

				var_352_9.z = 0
				var_352_9.x = 0
				var_352_0.localEulerAngles = var_352_9

				local var_352_10 = GameObjectTools.GetOrAddComponent(var_352_0.gameObject, typeof(DynamicBoneHelper))

				if var_352_10 then
					var_352_10:EnableDynamicBone(true)
				end
			end

			local var_352_11 = arg_349_1.actors_["6148ui_story"]
			local var_352_12 = 0

			if var_352_12 < arg_349_1.time_ and arg_349_1.time_ <= var_352_12 + arg_352_0 and not isNil(var_352_11) and arg_349_1.var_.characterEffect6148ui_story == nil then
				arg_349_1.var_.characterEffect6148ui_story = var_352_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_13 = 0.200000002980232

			if var_352_12 <= arg_349_1.time_ and arg_349_1.time_ < var_352_12 + var_352_13 and not isNil(var_352_11) then
				local var_352_14 = (arg_349_1.time_ - var_352_12) / var_352_13

				if arg_349_1.var_.characterEffect6148ui_story and not isNil(var_352_11) then
					arg_349_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_12 + var_352_13 and arg_349_1.time_ < var_352_12 + var_352_13 + arg_352_0 and not isNil(var_352_11) and arg_349_1.var_.characterEffect6148ui_story then
				arg_349_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_352_15 = 0

			if var_352_15 < arg_349_1.time_ and arg_349_1.time_ <= var_352_15 + arg_352_0 then
				arg_349_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_352_16 = 0

			if var_352_16 < arg_349_1.time_ and arg_349_1.time_ <= var_352_16 + arg_352_0 then
				arg_349_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_352_17 = 0
			local var_352_18 = 0.55

			if var_352_17 < arg_349_1.time_ and arg_349_1.time_ <= var_352_17 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_19 = arg_349_1:FormatText(StoryNameCfg[1488].name)

				arg_349_1.leftNameTxt_.text = var_352_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_20 = arg_349_1:GetWordFromCfg(426041086)
				local var_352_21 = arg_349_1:FormatText(var_352_20.content)

				arg_349_1.text_.text = var_352_21

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_22 = 22
				local var_352_23 = utf8.len(var_352_21)
				local var_352_24 = var_352_22 <= 0 and var_352_18 or var_352_18 * (var_352_23 / var_352_22)

				if var_352_24 > 0 and var_352_18 < var_352_24 then
					arg_349_1.talkMaxDuration = var_352_24

					if var_352_24 + var_352_17 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_24 + var_352_17
					end
				end

				arg_349_1.text_.text = var_352_21
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041086", "story_v_out_426041.awb") ~= 0 then
					local var_352_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041086", "story_v_out_426041.awb") / 1000

					if var_352_25 + var_352_17 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_25 + var_352_17
					end

					if var_352_20.prefab_name ~= "" and arg_349_1.actors_[var_352_20.prefab_name] ~= nil then
						local var_352_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_20.prefab_name].transform, "story_v_out_426041", "426041086", "story_v_out_426041.awb")

						arg_349_1:RecordAudio("426041086", var_352_26)
						arg_349_1:RecordAudio("426041086", var_352_26)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_426041", "426041086", "story_v_out_426041.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_426041", "426041086", "story_v_out_426041.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_27 = math.max(var_352_18, arg_349_1.talkMaxDuration)

			if var_352_17 <= arg_349_1.time_ and arg_349_1.time_ < var_352_17 + var_352_27 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_17) / var_352_27

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_17 + var_352_27 and arg_349_1.time_ < var_352_17 + var_352_27 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play426041087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 426041087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play426041088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["6148ui_story"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect6148ui_story == nil then
				arg_353_1.var_.characterEffect6148ui_story = var_356_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.characterEffect6148ui_story and not isNil(var_356_0) then
					local var_356_4 = Mathf.Lerp(0, 0.5, var_356_3)

					arg_353_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_353_1.var_.characterEffect6148ui_story.fillRatio = var_356_4
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect6148ui_story then
				local var_356_5 = 0.5

				arg_353_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_353_1.var_.characterEffect6148ui_story.fillRatio = var_356_5
			end

			local var_356_6 = 0
			local var_356_7 = 0.775

			if var_356_6 < arg_353_1.time_ and arg_353_1.time_ <= var_356_6 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_8 = arg_353_1:FormatText(StoryNameCfg[7].name)

				arg_353_1.leftNameTxt_.text = var_356_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_9 = arg_353_1:GetWordFromCfg(426041087)
				local var_356_10 = arg_353_1:FormatText(var_356_9.content)

				arg_353_1.text_.text = var_356_10

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_11 = 31
				local var_356_12 = utf8.len(var_356_10)
				local var_356_13 = var_356_11 <= 0 and var_356_7 or var_356_7 * (var_356_12 / var_356_11)

				if var_356_13 > 0 and var_356_7 < var_356_13 then
					arg_353_1.talkMaxDuration = var_356_13

					if var_356_13 + var_356_6 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_13 + var_356_6
					end
				end

				arg_353_1.text_.text = var_356_10
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_14 = math.max(var_356_7, arg_353_1.talkMaxDuration)

			if var_356_6 <= arg_353_1.time_ and arg_353_1.time_ < var_356_6 + var_356_14 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_6) / var_356_14

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_6 + var_356_14 and arg_353_1.time_ < var_356_6 + var_356_14 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play426041088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 426041088
		arg_357_1.duration_ = 2.37

		local var_357_0 = {
			zh = 1.999999999999,
			ja = 2.366
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
				arg_357_0:Play426041089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1054ui_story"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos1054ui_story = var_360_0.localPosition

				local var_360_2 = GameObjectTools.GetOrAddComponent(var_360_0.gameObject, typeof(DynamicBoneHelper))

				if var_360_2 then
					var_360_2:EnableDynamicBone(false)
				end
			end

			local var_360_3 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_3 then
				local var_360_4 = (arg_357_1.time_ - var_360_1) / var_360_3
				local var_360_5 = Vector3.New(0.7, -0.985, -6)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1054ui_story, var_360_5, var_360_4)

				local var_360_6 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_6.x, var_360_6.y, var_360_6.z)

				local var_360_7 = var_360_0.localEulerAngles

				var_360_7.z = 0
				var_360_7.x = 0
				var_360_0.localEulerAngles = var_360_7
			end

			if arg_357_1.time_ >= var_360_1 + var_360_3 and arg_357_1.time_ < var_360_1 + var_360_3 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_360_8 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_8.x, var_360_8.y, var_360_8.z)

				local var_360_9 = var_360_0.localEulerAngles

				var_360_9.z = 0
				var_360_9.x = 0
				var_360_0.localEulerAngles = var_360_9

				local var_360_10 = GameObjectTools.GetOrAddComponent(var_360_0.gameObject, typeof(DynamicBoneHelper))

				if var_360_10 then
					var_360_10:EnableDynamicBone(true)
				end
			end

			local var_360_11 = 0

			if var_360_11 < arg_357_1.time_ and arg_357_1.time_ <= var_360_11 + arg_360_0 then
				arg_357_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_360_12 = 0

			if var_360_12 < arg_357_1.time_ and arg_357_1.time_ <= var_360_12 + arg_360_0 then
				arg_357_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_360_13 = arg_357_1.actors_["6148ui_story"].transform
			local var_360_14 = 0

			if var_360_14 < arg_357_1.time_ and arg_357_1.time_ <= var_360_14 + arg_360_0 then
				arg_357_1.var_.moveOldPos6148ui_story = var_360_13.localPosition

				local var_360_15 = GameObjectTools.GetOrAddComponent(var_360_13.gameObject, typeof(DynamicBoneHelper))

				if var_360_15 then
					var_360_15:EnableDynamicBone(false)
				end
			end

			local var_360_16 = 0.001

			if var_360_14 <= arg_357_1.time_ and arg_357_1.time_ < var_360_14 + var_360_16 then
				local var_360_17 = (arg_357_1.time_ - var_360_14) / var_360_16
				local var_360_18 = Vector3.New(-0.7, -0.985, -6)

				var_360_13.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos6148ui_story, var_360_18, var_360_17)

				local var_360_19 = manager.ui.mainCamera.transform.position - var_360_13.position

				var_360_13.forward = Vector3.New(var_360_19.x, var_360_19.y, var_360_19.z)

				local var_360_20 = var_360_13.localEulerAngles

				var_360_20.z = 0
				var_360_20.x = 0
				var_360_13.localEulerAngles = var_360_20
			end

			if arg_357_1.time_ >= var_360_14 + var_360_16 and arg_357_1.time_ < var_360_14 + var_360_16 + arg_360_0 then
				var_360_13.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_360_21 = manager.ui.mainCamera.transform.position - var_360_13.position

				var_360_13.forward = Vector3.New(var_360_21.x, var_360_21.y, var_360_21.z)

				local var_360_22 = var_360_13.localEulerAngles

				var_360_22.z = 0
				var_360_22.x = 0
				var_360_13.localEulerAngles = var_360_22

				local var_360_23 = GameObjectTools.GetOrAddComponent(var_360_13.gameObject, typeof(DynamicBoneHelper))

				if var_360_23 then
					var_360_23:EnableDynamicBone(true)
				end
			end

			local var_360_24 = 0

			if var_360_24 < arg_357_1.time_ and arg_357_1.time_ <= var_360_24 + arg_360_0 then
				arg_357_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_360_25 = 0

			if var_360_25 < arg_357_1.time_ and arg_357_1.time_ <= var_360_25 + arg_360_0 then
				arg_357_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_360_26 = arg_357_1.actors_["1054ui_story"]
			local var_360_27 = 0

			if var_360_27 < arg_357_1.time_ and arg_357_1.time_ <= var_360_27 + arg_360_0 and not isNil(var_360_26) and arg_357_1.var_.characterEffect1054ui_story == nil then
				arg_357_1.var_.characterEffect1054ui_story = var_360_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_28 = 0.200000002980232

			if var_360_27 <= arg_357_1.time_ and arg_357_1.time_ < var_360_27 + var_360_28 and not isNil(var_360_26) then
				local var_360_29 = (arg_357_1.time_ - var_360_27) / var_360_28

				if arg_357_1.var_.characterEffect1054ui_story and not isNil(var_360_26) then
					arg_357_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_27 + var_360_28 and arg_357_1.time_ < var_360_27 + var_360_28 + arg_360_0 and not isNil(var_360_26) and arg_357_1.var_.characterEffect1054ui_story then
				arg_357_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_360_30 = arg_357_1.actors_["6148ui_story"]
			local var_360_31 = 0

			if var_360_31 < arg_357_1.time_ and arg_357_1.time_ <= var_360_31 + arg_360_0 and not isNil(var_360_30) and arg_357_1.var_.characterEffect6148ui_story == nil then
				arg_357_1.var_.characterEffect6148ui_story = var_360_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_32 = 0.200000002980232

			if var_360_31 <= arg_357_1.time_ and arg_357_1.time_ < var_360_31 + var_360_32 and not isNil(var_360_30) then
				local var_360_33 = (arg_357_1.time_ - var_360_31) / var_360_32

				if arg_357_1.var_.characterEffect6148ui_story and not isNil(var_360_30) then
					arg_357_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_31 + var_360_32 and arg_357_1.time_ < var_360_31 + var_360_32 + arg_360_0 and not isNil(var_360_30) and arg_357_1.var_.characterEffect6148ui_story then
				arg_357_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_360_34 = 0
			local var_360_35 = 0.075

			if var_360_34 < arg_357_1.time_ and arg_357_1.time_ <= var_360_34 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_36 = arg_357_1:FormatText(StoryNameCfg[1489].name)

				arg_357_1.leftNameTxt_.text = var_360_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_37 = arg_357_1:GetWordFromCfg(426041088)
				local var_360_38 = arg_357_1:FormatText(var_360_37.content)

				arg_357_1.text_.text = var_360_38

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_39 = 3
				local var_360_40 = utf8.len(var_360_38)
				local var_360_41 = var_360_39 <= 0 and var_360_35 or var_360_35 * (var_360_40 / var_360_39)

				if var_360_41 > 0 and var_360_35 < var_360_41 then
					arg_357_1.talkMaxDuration = var_360_41

					if var_360_41 + var_360_34 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_41 + var_360_34
					end
				end

				arg_357_1.text_.text = var_360_38
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041088", "story_v_out_426041.awb") ~= 0 then
					local var_360_42 = manager.audio:GetVoiceLength("story_v_out_426041", "426041088", "story_v_out_426041.awb") / 1000

					if var_360_42 + var_360_34 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_42 + var_360_34
					end

					if var_360_37.prefab_name ~= "" and arg_357_1.actors_[var_360_37.prefab_name] ~= nil then
						local var_360_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_37.prefab_name].transform, "story_v_out_426041", "426041088", "story_v_out_426041.awb")

						arg_357_1:RecordAudio("426041088", var_360_43)
						arg_357_1:RecordAudio("426041088", var_360_43)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_426041", "426041088", "story_v_out_426041.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_426041", "426041088", "story_v_out_426041.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_44 = math.max(var_360_35, arg_357_1.talkMaxDuration)

			if var_360_34 <= arg_357_1.time_ and arg_357_1.time_ < var_360_34 + var_360_44 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_34) / var_360_44

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_34 + var_360_44 and arg_357_1.time_ < var_360_34 + var_360_44 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play426041089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 426041089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play426041090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1054ui_story"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1054ui_story == nil then
				arg_361_1.var_.characterEffect1054ui_story = var_364_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.characterEffect1054ui_story and not isNil(var_364_0) then
					local var_364_4 = Mathf.Lerp(0, 0.5, var_364_3)

					arg_361_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1054ui_story.fillRatio = var_364_4
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1054ui_story then
				local var_364_5 = 0.5

				arg_361_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1054ui_story.fillRatio = var_364_5
			end

			local var_364_6 = arg_361_1.actors_["6148ui_story"]
			local var_364_7 = 0

			if var_364_7 < arg_361_1.time_ and arg_361_1.time_ <= var_364_7 + arg_364_0 and not isNil(var_364_6) and arg_361_1.var_.characterEffect6148ui_story == nil then
				arg_361_1.var_.characterEffect6148ui_story = var_364_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_8 = 0.200000002980232

			if var_364_7 <= arg_361_1.time_ and arg_361_1.time_ < var_364_7 + var_364_8 and not isNil(var_364_6) then
				local var_364_9 = (arg_361_1.time_ - var_364_7) / var_364_8

				if arg_361_1.var_.characterEffect6148ui_story and not isNil(var_364_6) then
					local var_364_10 = Mathf.Lerp(0, 0.5, var_364_9)

					arg_361_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_361_1.var_.characterEffect6148ui_story.fillRatio = var_364_10
				end
			end

			if arg_361_1.time_ >= var_364_7 + var_364_8 and arg_361_1.time_ < var_364_7 + var_364_8 + arg_364_0 and not isNil(var_364_6) and arg_361_1.var_.characterEffect6148ui_story then
				local var_364_11 = 0.5

				arg_361_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_361_1.var_.characterEffect6148ui_story.fillRatio = var_364_11
			end

			local var_364_12 = 0
			local var_364_13 = 0.825

			if var_364_12 < arg_361_1.time_ and arg_361_1.time_ <= var_364_12 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_14 = arg_361_1:FormatText(StoryNameCfg[7].name)

				arg_361_1.leftNameTxt_.text = var_364_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_15 = arg_361_1:GetWordFromCfg(426041089)
				local var_364_16 = arg_361_1:FormatText(var_364_15.content)

				arg_361_1.text_.text = var_364_16

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_17 = 33
				local var_364_18 = utf8.len(var_364_16)
				local var_364_19 = var_364_17 <= 0 and var_364_13 or var_364_13 * (var_364_18 / var_364_17)

				if var_364_19 > 0 and var_364_13 < var_364_19 then
					arg_361_1.talkMaxDuration = var_364_19

					if var_364_19 + var_364_12 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_19 + var_364_12
					end
				end

				arg_361_1.text_.text = var_364_16
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_20 = math.max(var_364_13, arg_361_1.talkMaxDuration)

			if var_364_12 <= arg_361_1.time_ and arg_361_1.time_ < var_364_12 + var_364_20 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_12) / var_364_20

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_12 + var_364_20 and arg_361_1.time_ < var_364_12 + var_364_20 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play426041090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 426041090
		arg_365_1.duration_ = 2.2

		local var_365_0 = {
			zh = 1.833,
			ja = 2.2
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
				arg_365_0:Play426041091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1054ui_story"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1054ui_story == nil then
				arg_365_1.var_.characterEffect1054ui_story = var_368_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.characterEffect1054ui_story and not isNil(var_368_0) then
					arg_365_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1054ui_story then
				arg_365_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_368_4 = arg_365_1.actors_["6148ui_story"]
			local var_368_5 = 0

			if var_368_5 < arg_365_1.time_ and arg_365_1.time_ <= var_368_5 + arg_368_0 and not isNil(var_368_4) and arg_365_1.var_.characterEffect6148ui_story == nil then
				arg_365_1.var_.characterEffect6148ui_story = var_368_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_6 = 0.200000002980232

			if var_368_5 <= arg_365_1.time_ and arg_365_1.time_ < var_368_5 + var_368_6 and not isNil(var_368_4) then
				local var_368_7 = (arg_365_1.time_ - var_368_5) / var_368_6

				if arg_365_1.var_.characterEffect6148ui_story and not isNil(var_368_4) then
					arg_365_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_5 + var_368_6 and arg_365_1.time_ < var_368_5 + var_368_6 + arg_368_0 and not isNil(var_368_4) and arg_365_1.var_.characterEffect6148ui_story then
				arg_365_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_368_8 = 0
			local var_368_9 = 0.075

			if var_368_8 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_10 = arg_365_1:FormatText(StoryNameCfg[1489].name)

				arg_365_1.leftNameTxt_.text = var_368_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_11 = arg_365_1:GetWordFromCfg(426041090)
				local var_368_12 = arg_365_1:FormatText(var_368_11.content)

				arg_365_1.text_.text = var_368_12

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_13 = 3
				local var_368_14 = utf8.len(var_368_12)
				local var_368_15 = var_368_13 <= 0 and var_368_9 or var_368_9 * (var_368_14 / var_368_13)

				if var_368_15 > 0 and var_368_9 < var_368_15 then
					arg_365_1.talkMaxDuration = var_368_15

					if var_368_15 + var_368_8 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_15 + var_368_8
					end
				end

				arg_365_1.text_.text = var_368_12
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041090", "story_v_out_426041.awb") ~= 0 then
					local var_368_16 = manager.audio:GetVoiceLength("story_v_out_426041", "426041090", "story_v_out_426041.awb") / 1000

					if var_368_16 + var_368_8 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_16 + var_368_8
					end

					if var_368_11.prefab_name ~= "" and arg_365_1.actors_[var_368_11.prefab_name] ~= nil then
						local var_368_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_11.prefab_name].transform, "story_v_out_426041", "426041090", "story_v_out_426041.awb")

						arg_365_1:RecordAudio("426041090", var_368_17)
						arg_365_1:RecordAudio("426041090", var_368_17)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_426041", "426041090", "story_v_out_426041.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_426041", "426041090", "story_v_out_426041.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_18 = math.max(var_368_9, arg_365_1.talkMaxDuration)

			if var_368_8 <= arg_365_1.time_ and arg_365_1.time_ < var_368_8 + var_368_18 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_8) / var_368_18

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_8 + var_368_18 and arg_365_1.time_ < var_368_8 + var_368_18 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play426041091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 426041091
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play426041092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1054ui_story"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1054ui_story == nil then
				arg_369_1.var_.characterEffect1054ui_story = var_372_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.characterEffect1054ui_story and not isNil(var_372_0) then
					local var_372_4 = Mathf.Lerp(0, 0.5, var_372_3)

					arg_369_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1054ui_story.fillRatio = var_372_4
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1054ui_story then
				local var_372_5 = 0.5

				arg_369_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1054ui_story.fillRatio = var_372_5
			end

			local var_372_6 = arg_369_1.actors_["6148ui_story"]
			local var_372_7 = 0

			if var_372_7 < arg_369_1.time_ and arg_369_1.time_ <= var_372_7 + arg_372_0 and not isNil(var_372_6) and arg_369_1.var_.characterEffect6148ui_story == nil then
				arg_369_1.var_.characterEffect6148ui_story = var_372_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_8 = 0.200000002980232

			if var_372_7 <= arg_369_1.time_ and arg_369_1.time_ < var_372_7 + var_372_8 and not isNil(var_372_6) then
				local var_372_9 = (arg_369_1.time_ - var_372_7) / var_372_8

				if arg_369_1.var_.characterEffect6148ui_story and not isNil(var_372_6) then
					local var_372_10 = Mathf.Lerp(0, 0.5, var_372_9)

					arg_369_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_369_1.var_.characterEffect6148ui_story.fillRatio = var_372_10
				end
			end

			if arg_369_1.time_ >= var_372_7 + var_372_8 and arg_369_1.time_ < var_372_7 + var_372_8 + arg_372_0 and not isNil(var_372_6) and arg_369_1.var_.characterEffect6148ui_story then
				local var_372_11 = 0.5

				arg_369_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_369_1.var_.characterEffect6148ui_story.fillRatio = var_372_11
			end

			local var_372_12 = 0
			local var_372_13 = 0.85

			if var_372_12 < arg_369_1.time_ and arg_369_1.time_ <= var_372_12 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_14 = arg_369_1:FormatText(StoryNameCfg[7].name)

				arg_369_1.leftNameTxt_.text = var_372_14

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

				local var_372_15 = arg_369_1:GetWordFromCfg(426041091)
				local var_372_16 = arg_369_1:FormatText(var_372_15.content)

				arg_369_1.text_.text = var_372_16

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_17 = 34
				local var_372_18 = utf8.len(var_372_16)
				local var_372_19 = var_372_17 <= 0 and var_372_13 or var_372_13 * (var_372_18 / var_372_17)

				if var_372_19 > 0 and var_372_13 < var_372_19 then
					arg_369_1.talkMaxDuration = var_372_19

					if var_372_19 + var_372_12 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_19 + var_372_12
					end
				end

				arg_369_1.text_.text = var_372_16
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_20 = math.max(var_372_13, arg_369_1.talkMaxDuration)

			if var_372_12 <= arg_369_1.time_ and arg_369_1.time_ < var_372_12 + var_372_20 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_12) / var_372_20

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_12 + var_372_20 and arg_369_1.time_ < var_372_12 + var_372_20 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play426041092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 426041092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play426041093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1054ui_story"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos1054ui_story = var_376_0.localPosition

				local var_376_2 = GameObjectTools.GetOrAddComponent(var_376_0.gameObject, typeof(DynamicBoneHelper))

				if var_376_2 then
					var_376_2:EnableDynamicBone(false)
				end
			end

			local var_376_3 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_3 then
				local var_376_4 = (arg_373_1.time_ - var_376_1) / var_376_3
				local var_376_5 = Vector3.New(0, 100, 0)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1054ui_story, var_376_5, var_376_4)

				local var_376_6 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_6.x, var_376_6.y, var_376_6.z)

				local var_376_7 = var_376_0.localEulerAngles

				var_376_7.z = 0
				var_376_7.x = 0
				var_376_0.localEulerAngles = var_376_7
			end

			if arg_373_1.time_ >= var_376_1 + var_376_3 and arg_373_1.time_ < var_376_1 + var_376_3 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(0, 100, 0)

				local var_376_8 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_8.x, var_376_8.y, var_376_8.z)

				local var_376_9 = var_376_0.localEulerAngles

				var_376_9.z = 0
				var_376_9.x = 0
				var_376_0.localEulerAngles = var_376_9

				local var_376_10 = GameObjectTools.GetOrAddComponent(var_376_0.gameObject, typeof(DynamicBoneHelper))

				if var_376_10 then
					var_376_10:EnableDynamicBone(true)
				end
			end

			local var_376_11 = arg_373_1.actors_["6148ui_story"].transform
			local var_376_12 = 0

			if var_376_12 < arg_373_1.time_ and arg_373_1.time_ <= var_376_12 + arg_376_0 then
				arg_373_1.var_.moveOldPos6148ui_story = var_376_11.localPosition

				local var_376_13 = GameObjectTools.GetOrAddComponent(var_376_11.gameObject, typeof(DynamicBoneHelper))

				if var_376_13 then
					var_376_13:EnableDynamicBone(false)
				end
			end

			local var_376_14 = 0.001

			if var_376_12 <= arg_373_1.time_ and arg_373_1.time_ < var_376_12 + var_376_14 then
				local var_376_15 = (arg_373_1.time_ - var_376_12) / var_376_14
				local var_376_16 = Vector3.New(0, 100, 0)

				var_376_11.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos6148ui_story, var_376_16, var_376_15)

				local var_376_17 = manager.ui.mainCamera.transform.position - var_376_11.position

				var_376_11.forward = Vector3.New(var_376_17.x, var_376_17.y, var_376_17.z)

				local var_376_18 = var_376_11.localEulerAngles

				var_376_18.z = 0
				var_376_18.x = 0
				var_376_11.localEulerAngles = var_376_18
			end

			if arg_373_1.time_ >= var_376_12 + var_376_14 and arg_373_1.time_ < var_376_12 + var_376_14 + arg_376_0 then
				var_376_11.localPosition = Vector3.New(0, 100, 0)

				local var_376_19 = manager.ui.mainCamera.transform.position - var_376_11.position

				var_376_11.forward = Vector3.New(var_376_19.x, var_376_19.y, var_376_19.z)

				local var_376_20 = var_376_11.localEulerAngles

				var_376_20.z = 0
				var_376_20.x = 0
				var_376_11.localEulerAngles = var_376_20

				local var_376_21 = GameObjectTools.GetOrAddComponent(var_376_11.gameObject, typeof(DynamicBoneHelper))

				if var_376_21 then
					var_376_21:EnableDynamicBone(true)
				end
			end

			local var_376_22 = 0
			local var_376_23 = 0.725

			if var_376_22 < arg_373_1.time_ and arg_373_1.time_ <= var_376_22 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_24 = arg_373_1:GetWordFromCfg(426041092)
				local var_376_25 = arg_373_1:FormatText(var_376_24.content)

				arg_373_1.text_.text = var_376_25

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_26 = 29
				local var_376_27 = utf8.len(var_376_25)
				local var_376_28 = var_376_26 <= 0 and var_376_23 or var_376_23 * (var_376_27 / var_376_26)

				if var_376_28 > 0 and var_376_23 < var_376_28 then
					arg_373_1.talkMaxDuration = var_376_28

					if var_376_28 + var_376_22 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_28 + var_376_22
					end
				end

				arg_373_1.text_.text = var_376_25
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_29 = math.max(var_376_23, arg_373_1.talkMaxDuration)

			if var_376_22 <= arg_373_1.time_ and arg_373_1.time_ < var_376_22 + var_376_29 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_22) / var_376_29

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_22 + var_376_29 and arg_373_1.time_ < var_376_22 + var_376_29 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play426041093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 426041093
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play426041094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0
			local var_380_1 = 1.05

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_2 = arg_377_1:GetWordFromCfg(426041093)
				local var_380_3 = arg_377_1:FormatText(var_380_2.content)

				arg_377_1.text_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_4 = 42
				local var_380_5 = utf8.len(var_380_3)
				local var_380_6 = var_380_4 <= 0 and var_380_1 or var_380_1 * (var_380_5 / var_380_4)

				if var_380_6 > 0 and var_380_1 < var_380_6 then
					arg_377_1.talkMaxDuration = var_380_6

					if var_380_6 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_6 + var_380_0
					end
				end

				arg_377_1.text_.text = var_380_3
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_7 = math.max(var_380_1, arg_377_1.talkMaxDuration)

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_7 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_0) / var_380_7

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_0 + var_380_7 and arg_377_1.time_ < var_380_0 + var_380_7 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play426041094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 426041094
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play426041095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0
			local var_384_1 = 0.4

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_2 = arg_381_1:FormatText(StoryNameCfg[7].name)

				arg_381_1.leftNameTxt_.text = var_384_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_3 = arg_381_1:GetWordFromCfg(426041094)
				local var_384_4 = arg_381_1:FormatText(var_384_3.content)

				arg_381_1.text_.text = var_384_4

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 16
				local var_384_6 = utf8.len(var_384_4)
				local var_384_7 = var_384_5 <= 0 and var_384_1 or var_384_1 * (var_384_6 / var_384_5)

				if var_384_7 > 0 and var_384_1 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_4
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_8 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_8 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_8

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_8 and arg_381_1.time_ < var_384_0 + var_384_8 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play426041095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 426041095
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play426041096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0
			local var_388_1 = 1.15

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_2 = arg_385_1:GetWordFromCfg(426041095)
				local var_388_3 = arg_385_1:FormatText(var_388_2.content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 46
				local var_388_5 = utf8.len(var_388_3)
				local var_388_6 = var_388_4 <= 0 and var_388_1 or var_388_1 * (var_388_5 / var_388_4)

				if var_388_6 > 0 and var_388_1 < var_388_6 then
					arg_385_1.talkMaxDuration = var_388_6

					if var_388_6 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_6 + var_388_0
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_1, arg_385_1.talkMaxDuration)

			if var_388_0 <= arg_385_1.time_ and arg_385_1.time_ < var_388_0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_0 + var_388_7 and arg_385_1.time_ < var_388_0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play426041096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 426041096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play426041097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 0.525

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_2 = arg_389_1:FormatText(StoryNameCfg[7].name)

				arg_389_1.leftNameTxt_.text = var_392_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_3 = arg_389_1:GetWordFromCfg(426041096)
				local var_392_4 = arg_389_1:FormatText(var_392_3.content)

				arg_389_1.text_.text = var_392_4

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 21
				local var_392_6 = utf8.len(var_392_4)
				local var_392_7 = var_392_5 <= 0 and var_392_1 or var_392_1 * (var_392_6 / var_392_5)

				if var_392_7 > 0 and var_392_1 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_4
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_8 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_8 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_8

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_8 and arg_389_1.time_ < var_392_0 + var_392_8 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play426041097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 426041097
		arg_393_1.duration_ = 3.53

		local var_393_0 = {
			zh = 3.533,
			ja = 2.366
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
				arg_393_0:Play426041098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1054ui_story"].transform
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.var_.moveOldPos1054ui_story = var_396_0.localPosition

				local var_396_2 = GameObjectTools.GetOrAddComponent(var_396_0.gameObject, typeof(DynamicBoneHelper))

				if var_396_2 then
					var_396_2:EnableDynamicBone(false)
				end
			end

			local var_396_3 = 0.001

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_3 then
				local var_396_4 = (arg_393_1.time_ - var_396_1) / var_396_3
				local var_396_5 = Vector3.New(0.7, -0.985, -6)

				var_396_0.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1054ui_story, var_396_5, var_396_4)

				local var_396_6 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_6.x, var_396_6.y, var_396_6.z)

				local var_396_7 = var_396_0.localEulerAngles

				var_396_7.z = 0
				var_396_7.x = 0
				var_396_0.localEulerAngles = var_396_7
			end

			if arg_393_1.time_ >= var_396_1 + var_396_3 and arg_393_1.time_ < var_396_1 + var_396_3 + arg_396_0 then
				var_396_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_396_8 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_8.x, var_396_8.y, var_396_8.z)

				local var_396_9 = var_396_0.localEulerAngles

				var_396_9.z = 0
				var_396_9.x = 0
				var_396_0.localEulerAngles = var_396_9

				local var_396_10 = GameObjectTools.GetOrAddComponent(var_396_0.gameObject, typeof(DynamicBoneHelper))

				if var_396_10 then
					var_396_10:EnableDynamicBone(true)
				end
			end

			local var_396_11 = 0

			if var_396_11 < arg_393_1.time_ and arg_393_1.time_ <= var_396_11 + arg_396_0 then
				arg_393_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_396_12 = 0

			if var_396_12 < arg_393_1.time_ and arg_393_1.time_ <= var_396_12 + arg_396_0 then
				arg_393_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_396_13 = arg_393_1.actors_["6148ui_story"].transform
			local var_396_14 = 0

			if var_396_14 < arg_393_1.time_ and arg_393_1.time_ <= var_396_14 + arg_396_0 then
				arg_393_1.var_.moveOldPos6148ui_story = var_396_13.localPosition

				local var_396_15 = GameObjectTools.GetOrAddComponent(var_396_13.gameObject, typeof(DynamicBoneHelper))

				if var_396_15 then
					var_396_15:EnableDynamicBone(false)
				end
			end

			local var_396_16 = 0.001

			if var_396_14 <= arg_393_1.time_ and arg_393_1.time_ < var_396_14 + var_396_16 then
				local var_396_17 = (arg_393_1.time_ - var_396_14) / var_396_16
				local var_396_18 = Vector3.New(-0.7, -0.985, -6)

				var_396_13.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos6148ui_story, var_396_18, var_396_17)

				local var_396_19 = manager.ui.mainCamera.transform.position - var_396_13.position

				var_396_13.forward = Vector3.New(var_396_19.x, var_396_19.y, var_396_19.z)

				local var_396_20 = var_396_13.localEulerAngles

				var_396_20.z = 0
				var_396_20.x = 0
				var_396_13.localEulerAngles = var_396_20
			end

			if arg_393_1.time_ >= var_396_14 + var_396_16 and arg_393_1.time_ < var_396_14 + var_396_16 + arg_396_0 then
				var_396_13.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_396_21 = manager.ui.mainCamera.transform.position - var_396_13.position

				var_396_13.forward = Vector3.New(var_396_21.x, var_396_21.y, var_396_21.z)

				local var_396_22 = var_396_13.localEulerAngles

				var_396_22.z = 0
				var_396_22.x = 0
				var_396_13.localEulerAngles = var_396_22

				local var_396_23 = GameObjectTools.GetOrAddComponent(var_396_13.gameObject, typeof(DynamicBoneHelper))

				if var_396_23 then
					var_396_23:EnableDynamicBone(true)
				end
			end

			local var_396_24 = 0

			if var_396_24 < arg_393_1.time_ and arg_393_1.time_ <= var_396_24 + arg_396_0 then
				arg_393_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_396_25 = 0

			if var_396_25 < arg_393_1.time_ and arg_393_1.time_ <= var_396_25 + arg_396_0 then
				arg_393_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_396_26 = arg_393_1.actors_["1054ui_story"]
			local var_396_27 = 0

			if var_396_27 < arg_393_1.time_ and arg_393_1.time_ <= var_396_27 + arg_396_0 and not isNil(var_396_26) and arg_393_1.var_.characterEffect1054ui_story == nil then
				arg_393_1.var_.characterEffect1054ui_story = var_396_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_28 = 0.200000002980232

			if var_396_27 <= arg_393_1.time_ and arg_393_1.time_ < var_396_27 + var_396_28 and not isNil(var_396_26) then
				local var_396_29 = (arg_393_1.time_ - var_396_27) / var_396_28

				if arg_393_1.var_.characterEffect1054ui_story and not isNil(var_396_26) then
					arg_393_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= var_396_27 + var_396_28 and arg_393_1.time_ < var_396_27 + var_396_28 + arg_396_0 and not isNil(var_396_26) and arg_393_1.var_.characterEffect1054ui_story then
				arg_393_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_396_30 = arg_393_1.actors_["6148ui_story"]
			local var_396_31 = 0

			if var_396_31 < arg_393_1.time_ and arg_393_1.time_ <= var_396_31 + arg_396_0 and not isNil(var_396_30) and arg_393_1.var_.characterEffect6148ui_story == nil then
				arg_393_1.var_.characterEffect6148ui_story = var_396_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_32 = 0.200000002980232

			if var_396_31 <= arg_393_1.time_ and arg_393_1.time_ < var_396_31 + var_396_32 and not isNil(var_396_30) then
				local var_396_33 = (arg_393_1.time_ - var_396_31) / var_396_32

				if arg_393_1.var_.characterEffect6148ui_story and not isNil(var_396_30) then
					arg_393_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= var_396_31 + var_396_32 and arg_393_1.time_ < var_396_31 + var_396_32 + arg_396_0 and not isNil(var_396_30) and arg_393_1.var_.characterEffect6148ui_story then
				arg_393_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_396_34 = 0
			local var_396_35 = 0.075

			if var_396_34 < arg_393_1.time_ and arg_393_1.time_ <= var_396_34 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_36 = arg_393_1:FormatText(StoryNameCfg[1489].name)

				arg_393_1.leftNameTxt_.text = var_396_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_37 = arg_393_1:GetWordFromCfg(426041097)
				local var_396_38 = arg_393_1:FormatText(var_396_37.content)

				arg_393_1.text_.text = var_396_38

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_39 = 3
				local var_396_40 = utf8.len(var_396_38)
				local var_396_41 = var_396_39 <= 0 and var_396_35 or var_396_35 * (var_396_40 / var_396_39)

				if var_396_41 > 0 and var_396_35 < var_396_41 then
					arg_393_1.talkMaxDuration = var_396_41

					if var_396_41 + var_396_34 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_41 + var_396_34
					end
				end

				arg_393_1.text_.text = var_396_38
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041097", "story_v_out_426041.awb") ~= 0 then
					local var_396_42 = manager.audio:GetVoiceLength("story_v_out_426041", "426041097", "story_v_out_426041.awb") / 1000

					if var_396_42 + var_396_34 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_42 + var_396_34
					end

					if var_396_37.prefab_name ~= "" and arg_393_1.actors_[var_396_37.prefab_name] ~= nil then
						local var_396_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_37.prefab_name].transform, "story_v_out_426041", "426041097", "story_v_out_426041.awb")

						arg_393_1:RecordAudio("426041097", var_396_43)
						arg_393_1:RecordAudio("426041097", var_396_43)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_426041", "426041097", "story_v_out_426041.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_426041", "426041097", "story_v_out_426041.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_44 = math.max(var_396_35, arg_393_1.talkMaxDuration)

			if var_396_34 <= arg_393_1.time_ and arg_393_1.time_ < var_396_34 + var_396_44 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_34) / var_396_44

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_34 + var_396_44 and arg_393_1.time_ < var_396_34 + var_396_44 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play426041098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 426041098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play426041099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1054ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1054ui_story == nil then
				arg_397_1.var_.characterEffect1054ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1054ui_story and not isNil(var_400_0) then
					local var_400_4 = Mathf.Lerp(0, 0.5, var_400_3)

					arg_397_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1054ui_story.fillRatio = var_400_4
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1054ui_story then
				local var_400_5 = 0.5

				arg_397_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1054ui_story.fillRatio = var_400_5
			end

			local var_400_6 = arg_397_1.actors_["6148ui_story"]
			local var_400_7 = 0

			if var_400_7 < arg_397_1.time_ and arg_397_1.time_ <= var_400_7 + arg_400_0 and not isNil(var_400_6) and arg_397_1.var_.characterEffect6148ui_story == nil then
				arg_397_1.var_.characterEffect6148ui_story = var_400_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_8 = 0.200000002980232

			if var_400_7 <= arg_397_1.time_ and arg_397_1.time_ < var_400_7 + var_400_8 and not isNil(var_400_6) then
				local var_400_9 = (arg_397_1.time_ - var_400_7) / var_400_8

				if arg_397_1.var_.characterEffect6148ui_story and not isNil(var_400_6) then
					local var_400_10 = Mathf.Lerp(0, 0.5, var_400_9)

					arg_397_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_397_1.var_.characterEffect6148ui_story.fillRatio = var_400_10
				end
			end

			if arg_397_1.time_ >= var_400_7 + var_400_8 and arg_397_1.time_ < var_400_7 + var_400_8 + arg_400_0 and not isNil(var_400_6) and arg_397_1.var_.characterEffect6148ui_story then
				local var_400_11 = 0.5

				arg_397_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_397_1.var_.characterEffect6148ui_story.fillRatio = var_400_11
			end

			local var_400_12 = 0
			local var_400_13 = 0.175

			if var_400_12 < arg_397_1.time_ and arg_397_1.time_ <= var_400_12 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_14 = arg_397_1:FormatText(StoryNameCfg[7].name)

				arg_397_1.leftNameTxt_.text = var_400_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_15 = arg_397_1:GetWordFromCfg(426041098)
				local var_400_16 = arg_397_1:FormatText(var_400_15.content)

				arg_397_1.text_.text = var_400_16

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_17 = 7
				local var_400_18 = utf8.len(var_400_16)
				local var_400_19 = var_400_17 <= 0 and var_400_13 or var_400_13 * (var_400_18 / var_400_17)

				if var_400_19 > 0 and var_400_13 < var_400_19 then
					arg_397_1.talkMaxDuration = var_400_19

					if var_400_19 + var_400_12 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_19 + var_400_12
					end
				end

				arg_397_1.text_.text = var_400_16
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_20 = math.max(var_400_13, arg_397_1.talkMaxDuration)

			if var_400_12 <= arg_397_1.time_ and arg_397_1.time_ < var_400_12 + var_400_20 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_12) / var_400_20

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_12 + var_400_20 and arg_397_1.time_ < var_400_12 + var_400_20 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play426041099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 426041099
		arg_401_1.duration_ = 3.73

		local var_401_0 = {
			zh = 3.4,
			ja = 3.733
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
				arg_401_0:Play426041100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1054ui_story"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos1054ui_story = var_404_0.localPosition

				local var_404_2 = GameObjectTools.GetOrAddComponent(var_404_0.gameObject, typeof(DynamicBoneHelper))

				if var_404_2 then
					var_404_2:EnableDynamicBone(false)
				end
			end

			local var_404_3 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_3 then
				local var_404_4 = (arg_401_1.time_ - var_404_1) / var_404_3
				local var_404_5 = Vector3.New(0.7, -0.985, -6)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1054ui_story, var_404_5, var_404_4)

				local var_404_6 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_6.x, var_404_6.y, var_404_6.z)

				local var_404_7 = var_404_0.localEulerAngles

				var_404_7.z = 0
				var_404_7.x = 0
				var_404_0.localEulerAngles = var_404_7
			end

			if arg_401_1.time_ >= var_404_1 + var_404_3 and arg_401_1.time_ < var_404_1 + var_404_3 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_404_8 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_8.x, var_404_8.y, var_404_8.z)

				local var_404_9 = var_404_0.localEulerAngles

				var_404_9.z = 0
				var_404_9.x = 0
				var_404_0.localEulerAngles = var_404_9

				local var_404_10 = GameObjectTools.GetOrAddComponent(var_404_0.gameObject, typeof(DynamicBoneHelper))

				if var_404_10 then
					var_404_10:EnableDynamicBone(true)
				end
			end

			local var_404_11 = arg_401_1.actors_["1054ui_story"]
			local var_404_12 = 0

			if var_404_12 < arg_401_1.time_ and arg_401_1.time_ <= var_404_12 + arg_404_0 and not isNil(var_404_11) and arg_401_1.var_.characterEffect1054ui_story == nil then
				arg_401_1.var_.characterEffect1054ui_story = var_404_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_13 = 0.200000002980232

			if var_404_12 <= arg_401_1.time_ and arg_401_1.time_ < var_404_12 + var_404_13 and not isNil(var_404_11) then
				local var_404_14 = (arg_401_1.time_ - var_404_12) / var_404_13

				if arg_401_1.var_.characterEffect1054ui_story and not isNil(var_404_11) then
					arg_401_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= var_404_12 + var_404_13 and arg_401_1.time_ < var_404_12 + var_404_13 + arg_404_0 and not isNil(var_404_11) and arg_401_1.var_.characterEffect1054ui_story then
				arg_401_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_404_15 = 0

			if var_404_15 < arg_401_1.time_ and arg_401_1.time_ <= var_404_15 + arg_404_0 then
				arg_401_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			local var_404_16 = 0

			if var_404_16 < arg_401_1.time_ and arg_401_1.time_ <= var_404_16 + arg_404_0 then
				arg_401_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_404_17 = 0
			local var_404_18 = 0.275

			if var_404_17 < arg_401_1.time_ and arg_401_1.time_ <= var_404_17 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_19 = arg_401_1:FormatText(StoryNameCfg[1487].name)

				arg_401_1.leftNameTxt_.text = var_404_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_20 = arg_401_1:GetWordFromCfg(426041099)
				local var_404_21 = arg_401_1:FormatText(var_404_20.content)

				arg_401_1.text_.text = var_404_21

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_22 = 11
				local var_404_23 = utf8.len(var_404_21)
				local var_404_24 = var_404_22 <= 0 and var_404_18 or var_404_18 * (var_404_23 / var_404_22)

				if var_404_24 > 0 and var_404_18 < var_404_24 then
					arg_401_1.talkMaxDuration = var_404_24

					if var_404_24 + var_404_17 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_24 + var_404_17
					end
				end

				arg_401_1.text_.text = var_404_21
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041099", "story_v_out_426041.awb") ~= 0 then
					local var_404_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041099", "story_v_out_426041.awb") / 1000

					if var_404_25 + var_404_17 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_25 + var_404_17
					end

					if var_404_20.prefab_name ~= "" and arg_401_1.actors_[var_404_20.prefab_name] ~= nil then
						local var_404_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_20.prefab_name].transform, "story_v_out_426041", "426041099", "story_v_out_426041.awb")

						arg_401_1:RecordAudio("426041099", var_404_26)
						arg_401_1:RecordAudio("426041099", var_404_26)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_426041", "426041099", "story_v_out_426041.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_426041", "426041099", "story_v_out_426041.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_27 = math.max(var_404_18, arg_401_1.talkMaxDuration)

			if var_404_17 <= arg_401_1.time_ and arg_401_1.time_ < var_404_17 + var_404_27 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_17) / var_404_27

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_17 + var_404_27 and arg_401_1.time_ < var_404_17 + var_404_27 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426041100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 426041100
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play426041101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1054ui_story"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1054ui_story == nil then
				arg_405_1.var_.characterEffect1054ui_story = var_408_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.characterEffect1054ui_story and not isNil(var_408_0) then
					local var_408_4 = Mathf.Lerp(0, 0.5, var_408_3)

					arg_405_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1054ui_story.fillRatio = var_408_4
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1054ui_story then
				local var_408_5 = 0.5

				arg_405_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1054ui_story.fillRatio = var_408_5
			end

			local var_408_6 = 0
			local var_408_7 = 0.35

			if var_408_6 < arg_405_1.time_ and arg_405_1.time_ <= var_408_6 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_8 = arg_405_1:FormatText(StoryNameCfg[7].name)

				arg_405_1.leftNameTxt_.text = var_408_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_9 = arg_405_1:GetWordFromCfg(426041100)
				local var_408_10 = arg_405_1:FormatText(var_408_9.content)

				arg_405_1.text_.text = var_408_10

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_11 = 14
				local var_408_12 = utf8.len(var_408_10)
				local var_408_13 = var_408_11 <= 0 and var_408_7 or var_408_7 * (var_408_12 / var_408_11)

				if var_408_13 > 0 and var_408_7 < var_408_13 then
					arg_405_1.talkMaxDuration = var_408_13

					if var_408_13 + var_408_6 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_13 + var_408_6
					end
				end

				arg_405_1.text_.text = var_408_10
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_14 = math.max(var_408_7, arg_405_1.talkMaxDuration)

			if var_408_6 <= arg_405_1.time_ and arg_405_1.time_ < var_408_6 + var_408_14 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_6) / var_408_14

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_6 + var_408_14 and arg_405_1.time_ < var_408_6 + var_408_14 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play426041101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 426041101
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play426041102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1054ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos1054ui_story = var_412_0.localPosition

				local var_412_2 = GameObjectTools.GetOrAddComponent(var_412_0.gameObject, typeof(DynamicBoneHelper))

				if var_412_2 then
					var_412_2:EnableDynamicBone(false)
				end
			end

			local var_412_3 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_3 then
				local var_412_4 = (arg_409_1.time_ - var_412_1) / var_412_3
				local var_412_5 = Vector3.New(0, 100, 0)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1054ui_story, var_412_5, var_412_4)

				local var_412_6 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_6.x, var_412_6.y, var_412_6.z)

				local var_412_7 = var_412_0.localEulerAngles

				var_412_7.z = 0
				var_412_7.x = 0
				var_412_0.localEulerAngles = var_412_7
			end

			if arg_409_1.time_ >= var_412_1 + var_412_3 and arg_409_1.time_ < var_412_1 + var_412_3 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, 100, 0)

				local var_412_8 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_8.x, var_412_8.y, var_412_8.z)

				local var_412_9 = var_412_0.localEulerAngles

				var_412_9.z = 0
				var_412_9.x = 0
				var_412_0.localEulerAngles = var_412_9

				local var_412_10 = GameObjectTools.GetOrAddComponent(var_412_0.gameObject, typeof(DynamicBoneHelper))

				if var_412_10 then
					var_412_10:EnableDynamicBone(true)
				end
			end

			local var_412_11 = arg_409_1.actors_["6148ui_story"].transform
			local var_412_12 = 0

			if var_412_12 < arg_409_1.time_ and arg_409_1.time_ <= var_412_12 + arg_412_0 then
				arg_409_1.var_.moveOldPos6148ui_story = var_412_11.localPosition

				local var_412_13 = GameObjectTools.GetOrAddComponent(var_412_11.gameObject, typeof(DynamicBoneHelper))

				if var_412_13 then
					var_412_13:EnableDynamicBone(false)
				end
			end

			local var_412_14 = 0.001

			if var_412_12 <= arg_409_1.time_ and arg_409_1.time_ < var_412_12 + var_412_14 then
				local var_412_15 = (arg_409_1.time_ - var_412_12) / var_412_14
				local var_412_16 = Vector3.New(0, 100, 0)

				var_412_11.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos6148ui_story, var_412_16, var_412_15)

				local var_412_17 = manager.ui.mainCamera.transform.position - var_412_11.position

				var_412_11.forward = Vector3.New(var_412_17.x, var_412_17.y, var_412_17.z)

				local var_412_18 = var_412_11.localEulerAngles

				var_412_18.z = 0
				var_412_18.x = 0
				var_412_11.localEulerAngles = var_412_18
			end

			if arg_409_1.time_ >= var_412_12 + var_412_14 and arg_409_1.time_ < var_412_12 + var_412_14 + arg_412_0 then
				var_412_11.localPosition = Vector3.New(0, 100, 0)

				local var_412_19 = manager.ui.mainCamera.transform.position - var_412_11.position

				var_412_11.forward = Vector3.New(var_412_19.x, var_412_19.y, var_412_19.z)

				local var_412_20 = var_412_11.localEulerAngles

				var_412_20.z = 0
				var_412_20.x = 0
				var_412_11.localEulerAngles = var_412_20

				local var_412_21 = GameObjectTools.GetOrAddComponent(var_412_11.gameObject, typeof(DynamicBoneHelper))

				if var_412_21 then
					var_412_21:EnableDynamicBone(true)
				end
			end

			local var_412_22 = 0
			local var_412_23 = 0.6

			if var_412_22 < arg_409_1.time_ and arg_409_1.time_ <= var_412_22 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_24 = arg_409_1:GetWordFromCfg(426041101)
				local var_412_25 = arg_409_1:FormatText(var_412_24.content)

				arg_409_1.text_.text = var_412_25

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_26 = 24
				local var_412_27 = utf8.len(var_412_25)
				local var_412_28 = var_412_26 <= 0 and var_412_23 or var_412_23 * (var_412_27 / var_412_26)

				if var_412_28 > 0 and var_412_23 < var_412_28 then
					arg_409_1.talkMaxDuration = var_412_28

					if var_412_28 + var_412_22 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_28 + var_412_22
					end
				end

				arg_409_1.text_.text = var_412_25
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_29 = math.max(var_412_23, arg_409_1.talkMaxDuration)

			if var_412_22 <= arg_409_1.time_ and arg_409_1.time_ < var_412_22 + var_412_29 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_22) / var_412_29

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_22 + var_412_29 and arg_409_1.time_ < var_412_22 + var_412_29 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426041102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 426041102
		arg_413_1.duration_ = 6.27

		local var_413_0 = {
			zh = 2.633,
			ja = 6.266
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play426041103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["6148ui_story"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos6148ui_story = var_416_0.localPosition

				local var_416_2 = GameObjectTools.GetOrAddComponent(var_416_0.gameObject, typeof(DynamicBoneHelper))

				if var_416_2 then
					var_416_2:EnableDynamicBone(false)
				end
			end

			local var_416_3 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_3 then
				local var_416_4 = (arg_413_1.time_ - var_416_1) / var_416_3
				local var_416_5 = Vector3.New(0, -0.985, -6)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos6148ui_story, var_416_5, var_416_4)

				local var_416_6 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_6.x, var_416_6.y, var_416_6.z)

				local var_416_7 = var_416_0.localEulerAngles

				var_416_7.z = 0
				var_416_7.x = 0
				var_416_0.localEulerAngles = var_416_7
			end

			if arg_413_1.time_ >= var_416_1 + var_416_3 and arg_413_1.time_ < var_416_1 + var_416_3 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_416_8 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_8.x, var_416_8.y, var_416_8.z)

				local var_416_9 = var_416_0.localEulerAngles

				var_416_9.z = 0
				var_416_9.x = 0
				var_416_0.localEulerAngles = var_416_9

				local var_416_10 = GameObjectTools.GetOrAddComponent(var_416_0.gameObject, typeof(DynamicBoneHelper))

				if var_416_10 then
					var_416_10:EnableDynamicBone(true)
				end
			end

			local var_416_11 = arg_413_1.actors_["6148ui_story"]
			local var_416_12 = 0

			if var_416_12 < arg_413_1.time_ and arg_413_1.time_ <= var_416_12 + arg_416_0 and not isNil(var_416_11) and arg_413_1.var_.characterEffect6148ui_story == nil then
				arg_413_1.var_.characterEffect6148ui_story = var_416_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_13 = 0.200000002980232

			if var_416_12 <= arg_413_1.time_ and arg_413_1.time_ < var_416_12 + var_416_13 and not isNil(var_416_11) then
				local var_416_14 = (arg_413_1.time_ - var_416_12) / var_416_13

				if arg_413_1.var_.characterEffect6148ui_story and not isNil(var_416_11) then
					arg_413_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= var_416_12 + var_416_13 and arg_413_1.time_ < var_416_12 + var_416_13 + arg_416_0 and not isNil(var_416_11) and arg_413_1.var_.characterEffect6148ui_story then
				arg_413_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_416_15 = 0

			if var_416_15 < arg_413_1.time_ and arg_413_1.time_ <= var_416_15 + arg_416_0 then
				arg_413_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_416_16 = 0

			if var_416_16 < arg_413_1.time_ and arg_413_1.time_ <= var_416_16 + arg_416_0 then
				arg_413_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_416_17 = 0
			local var_416_18 = 0.25

			if var_416_17 < arg_413_1.time_ and arg_413_1.time_ <= var_416_17 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_19 = arg_413_1:FormatText(StoryNameCfg[1488].name)

				arg_413_1.leftNameTxt_.text = var_416_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_20 = arg_413_1:GetWordFromCfg(426041102)
				local var_416_21 = arg_413_1:FormatText(var_416_20.content)

				arg_413_1.text_.text = var_416_21

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_22 = 10
				local var_416_23 = utf8.len(var_416_21)
				local var_416_24 = var_416_22 <= 0 and var_416_18 or var_416_18 * (var_416_23 / var_416_22)

				if var_416_24 > 0 and var_416_18 < var_416_24 then
					arg_413_1.talkMaxDuration = var_416_24

					if var_416_24 + var_416_17 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_24 + var_416_17
					end
				end

				arg_413_1.text_.text = var_416_21
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041102", "story_v_out_426041.awb") ~= 0 then
					local var_416_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041102", "story_v_out_426041.awb") / 1000

					if var_416_25 + var_416_17 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_25 + var_416_17
					end

					if var_416_20.prefab_name ~= "" and arg_413_1.actors_[var_416_20.prefab_name] ~= nil then
						local var_416_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_20.prefab_name].transform, "story_v_out_426041", "426041102", "story_v_out_426041.awb")

						arg_413_1:RecordAudio("426041102", var_416_26)
						arg_413_1:RecordAudio("426041102", var_416_26)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_426041", "426041102", "story_v_out_426041.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_426041", "426041102", "story_v_out_426041.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_27 = math.max(var_416_18, arg_413_1.talkMaxDuration)

			if var_416_17 <= arg_413_1.time_ and arg_413_1.time_ < var_416_17 + var_416_27 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_17) / var_416_27

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_17 + var_416_27 and arg_413_1.time_ < var_416_17 + var_416_27 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play426041103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 426041103
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play426041104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["6148ui_story"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect6148ui_story == nil then
				arg_417_1.var_.characterEffect6148ui_story = var_420_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 and not isNil(var_420_0) then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2

				if arg_417_1.var_.characterEffect6148ui_story and not isNil(var_420_0) then
					local var_420_4 = Mathf.Lerp(0, 0.5, var_420_3)

					arg_417_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_417_1.var_.characterEffect6148ui_story.fillRatio = var_420_4
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect6148ui_story then
				local var_420_5 = 0.5

				arg_417_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_417_1.var_.characterEffect6148ui_story.fillRatio = var_420_5
			end

			local var_420_6 = 0
			local var_420_7 = 0.675

			if var_420_6 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_8 = arg_417_1:FormatText(StoryNameCfg[7].name)

				arg_417_1.leftNameTxt_.text = var_420_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_9 = arg_417_1:GetWordFromCfg(426041103)
				local var_420_10 = arg_417_1:FormatText(var_420_9.content)

				arg_417_1.text_.text = var_420_10

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_11 = 27
				local var_420_12 = utf8.len(var_420_10)
				local var_420_13 = var_420_11 <= 0 and var_420_7 or var_420_7 * (var_420_12 / var_420_11)

				if var_420_13 > 0 and var_420_7 < var_420_13 then
					arg_417_1.talkMaxDuration = var_420_13

					if var_420_13 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_13 + var_420_6
					end
				end

				arg_417_1.text_.text = var_420_10
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_14 = math.max(var_420_7, arg_417_1.talkMaxDuration)

			if var_420_6 <= arg_417_1.time_ and arg_417_1.time_ < var_420_6 + var_420_14 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_6) / var_420_14

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_6 + var_420_14 and arg_417_1.time_ < var_420_6 + var_420_14 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play426041104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 426041104
		arg_421_1.duration_ = 6.2

		local var_421_0 = {
			zh = 5.833,
			ja = 6.2
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
				arg_421_0:Play426041105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["6148ui_story"].transform
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.var_.moveOldPos6148ui_story = var_424_0.localPosition

				local var_424_2 = GameObjectTools.GetOrAddComponent(var_424_0.gameObject, typeof(DynamicBoneHelper))

				if var_424_2 then
					var_424_2:EnableDynamicBone(false)
				end
			end

			local var_424_3 = 0.001

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_3 then
				local var_424_4 = (arg_421_1.time_ - var_424_1) / var_424_3
				local var_424_5 = Vector3.New(0, -0.985, -6)

				var_424_0.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos6148ui_story, var_424_5, var_424_4)

				local var_424_6 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_6.x, var_424_6.y, var_424_6.z)

				local var_424_7 = var_424_0.localEulerAngles

				var_424_7.z = 0
				var_424_7.x = 0
				var_424_0.localEulerAngles = var_424_7
			end

			if arg_421_1.time_ >= var_424_1 + var_424_3 and arg_421_1.time_ < var_424_1 + var_424_3 + arg_424_0 then
				var_424_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_424_8 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_8.x, var_424_8.y, var_424_8.z)

				local var_424_9 = var_424_0.localEulerAngles

				var_424_9.z = 0
				var_424_9.x = 0
				var_424_0.localEulerAngles = var_424_9

				local var_424_10 = GameObjectTools.GetOrAddComponent(var_424_0.gameObject, typeof(DynamicBoneHelper))

				if var_424_10 then
					var_424_10:EnableDynamicBone(true)
				end
			end

			local var_424_11 = arg_421_1.actors_["6148ui_story"]
			local var_424_12 = 0

			if var_424_12 < arg_421_1.time_ and arg_421_1.time_ <= var_424_12 + arg_424_0 and not isNil(var_424_11) and arg_421_1.var_.characterEffect6148ui_story == nil then
				arg_421_1.var_.characterEffect6148ui_story = var_424_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_13 = 0.200000002980232

			if var_424_12 <= arg_421_1.time_ and arg_421_1.time_ < var_424_12 + var_424_13 and not isNil(var_424_11) then
				local var_424_14 = (arg_421_1.time_ - var_424_12) / var_424_13

				if arg_421_1.var_.characterEffect6148ui_story and not isNil(var_424_11) then
					arg_421_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= var_424_12 + var_424_13 and arg_421_1.time_ < var_424_12 + var_424_13 + arg_424_0 and not isNil(var_424_11) and arg_421_1.var_.characterEffect6148ui_story then
				arg_421_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_424_15 = 0

			if var_424_15 < arg_421_1.time_ and arg_421_1.time_ <= var_424_15 + arg_424_0 then
				arg_421_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			local var_424_16 = 0.034000001847744

			if var_424_16 < arg_421_1.time_ and arg_421_1.time_ <= var_424_16 + arg_424_0 then
				arg_421_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_424_17 = 0
			local var_424_18 = 0.625

			if var_424_17 < arg_421_1.time_ and arg_421_1.time_ <= var_424_17 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_19 = arg_421_1:FormatText(StoryNameCfg[1488].name)

				arg_421_1.leftNameTxt_.text = var_424_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_20 = arg_421_1:GetWordFromCfg(426041104)
				local var_424_21 = arg_421_1:FormatText(var_424_20.content)

				arg_421_1.text_.text = var_424_21

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_22 = 25
				local var_424_23 = utf8.len(var_424_21)
				local var_424_24 = var_424_22 <= 0 and var_424_18 or var_424_18 * (var_424_23 / var_424_22)

				if var_424_24 > 0 and var_424_18 < var_424_24 then
					arg_421_1.talkMaxDuration = var_424_24

					if var_424_24 + var_424_17 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_24 + var_424_17
					end
				end

				arg_421_1.text_.text = var_424_21
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041104", "story_v_out_426041.awb") ~= 0 then
					local var_424_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041104", "story_v_out_426041.awb") / 1000

					if var_424_25 + var_424_17 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_25 + var_424_17
					end

					if var_424_20.prefab_name ~= "" and arg_421_1.actors_[var_424_20.prefab_name] ~= nil then
						local var_424_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_20.prefab_name].transform, "story_v_out_426041", "426041104", "story_v_out_426041.awb")

						arg_421_1:RecordAudio("426041104", var_424_26)
						arg_421_1:RecordAudio("426041104", var_424_26)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_426041", "426041104", "story_v_out_426041.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_426041", "426041104", "story_v_out_426041.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_27 = math.max(var_424_18, arg_421_1.talkMaxDuration)

			if var_424_17 <= arg_421_1.time_ and arg_421_1.time_ < var_424_17 + var_424_27 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_17) / var_424_27

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_17 + var_424_27 and arg_421_1.time_ < var_424_17 + var_424_27 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426041105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 426041105
		arg_425_1.duration_ = 2

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play426041106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1054ui_story"].transform
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.var_.moveOldPos1054ui_story = var_428_0.localPosition

				local var_428_2 = GameObjectTools.GetOrAddComponent(var_428_0.gameObject, typeof(DynamicBoneHelper))

				if var_428_2 then
					var_428_2:EnableDynamicBone(false)
				end
			end

			local var_428_3 = 0.001

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_3 then
				local var_428_4 = (arg_425_1.time_ - var_428_1) / var_428_3
				local var_428_5 = Vector3.New(0.7, -0.985, -6)

				var_428_0.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1054ui_story, var_428_5, var_428_4)

				local var_428_6 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_6.x, var_428_6.y, var_428_6.z)

				local var_428_7 = var_428_0.localEulerAngles

				var_428_7.z = 0
				var_428_7.x = 0
				var_428_0.localEulerAngles = var_428_7
			end

			if arg_425_1.time_ >= var_428_1 + var_428_3 and arg_425_1.time_ < var_428_1 + var_428_3 + arg_428_0 then
				var_428_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_428_8 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_8.x, var_428_8.y, var_428_8.z)

				local var_428_9 = var_428_0.localEulerAngles

				var_428_9.z = 0
				var_428_9.x = 0
				var_428_0.localEulerAngles = var_428_9

				local var_428_10 = GameObjectTools.GetOrAddComponent(var_428_0.gameObject, typeof(DynamicBoneHelper))

				if var_428_10 then
					var_428_10:EnableDynamicBone(true)
				end
			end

			local var_428_11 = arg_425_1.actors_["1054ui_story"]
			local var_428_12 = 0

			if var_428_12 < arg_425_1.time_ and arg_425_1.time_ <= var_428_12 + arg_428_0 and not isNil(var_428_11) and arg_425_1.var_.characterEffect1054ui_story == nil then
				arg_425_1.var_.characterEffect1054ui_story = var_428_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_13 = 0.200000002980232

			if var_428_12 <= arg_425_1.time_ and arg_425_1.time_ < var_428_12 + var_428_13 and not isNil(var_428_11) then
				local var_428_14 = (arg_425_1.time_ - var_428_12) / var_428_13

				if arg_425_1.var_.characterEffect1054ui_story and not isNil(var_428_11) then
					arg_425_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= var_428_12 + var_428_13 and arg_425_1.time_ < var_428_12 + var_428_13 + arg_428_0 and not isNil(var_428_11) and arg_425_1.var_.characterEffect1054ui_story then
				arg_425_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_428_15 = arg_425_1.actors_["6148ui_story"]
			local var_428_16 = 0

			if var_428_16 < arg_425_1.time_ and arg_425_1.time_ <= var_428_16 + arg_428_0 and not isNil(var_428_15) and arg_425_1.var_.characterEffect6148ui_story == nil then
				arg_425_1.var_.characterEffect6148ui_story = var_428_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_17 = 0.200000002980232

			if var_428_16 <= arg_425_1.time_ and arg_425_1.time_ < var_428_16 + var_428_17 and not isNil(var_428_15) then
				local var_428_18 = (arg_425_1.time_ - var_428_16) / var_428_17

				if arg_425_1.var_.characterEffect6148ui_story and not isNil(var_428_15) then
					local var_428_19 = Mathf.Lerp(0, 0.5, var_428_18)

					arg_425_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_425_1.var_.characterEffect6148ui_story.fillRatio = var_428_19
				end
			end

			if arg_425_1.time_ >= var_428_16 + var_428_17 and arg_425_1.time_ < var_428_16 + var_428_17 + arg_428_0 and not isNil(var_428_15) and arg_425_1.var_.characterEffect6148ui_story then
				local var_428_20 = 0.5

				arg_425_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_425_1.var_.characterEffect6148ui_story.fillRatio = var_428_20
			end

			local var_428_21 = 0

			if var_428_21 < arg_425_1.time_ and arg_425_1.time_ <= var_428_21 + arg_428_0 then
				arg_425_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_428_22 = 0

			if var_428_22 < arg_425_1.time_ and arg_425_1.time_ <= var_428_22 + arg_428_0 then
				arg_425_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_428_23 = arg_425_1.actors_["6148ui_story"].transform
			local var_428_24 = 0

			if var_428_24 < arg_425_1.time_ and arg_425_1.time_ <= var_428_24 + arg_428_0 then
				arg_425_1.var_.moveOldPos6148ui_story = var_428_23.localPosition

				local var_428_25 = GameObjectTools.GetOrAddComponent(var_428_23.gameObject, typeof(DynamicBoneHelper))

				if var_428_25 then
					var_428_25:EnableDynamicBone(false)
				end
			end

			local var_428_26 = 0.001

			if var_428_24 <= arg_425_1.time_ and arg_425_1.time_ < var_428_24 + var_428_26 then
				local var_428_27 = (arg_425_1.time_ - var_428_24) / var_428_26
				local var_428_28 = Vector3.New(-0.7, -0.985, -6)

				var_428_23.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos6148ui_story, var_428_28, var_428_27)

				local var_428_29 = manager.ui.mainCamera.transform.position - var_428_23.position

				var_428_23.forward = Vector3.New(var_428_29.x, var_428_29.y, var_428_29.z)

				local var_428_30 = var_428_23.localEulerAngles

				var_428_30.z = 0
				var_428_30.x = 0
				var_428_23.localEulerAngles = var_428_30
			end

			if arg_425_1.time_ >= var_428_24 + var_428_26 and arg_425_1.time_ < var_428_24 + var_428_26 + arg_428_0 then
				var_428_23.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_428_31 = manager.ui.mainCamera.transform.position - var_428_23.position

				var_428_23.forward = Vector3.New(var_428_31.x, var_428_31.y, var_428_31.z)

				local var_428_32 = var_428_23.localEulerAngles

				var_428_32.z = 0
				var_428_32.x = 0
				var_428_23.localEulerAngles = var_428_32

				local var_428_33 = GameObjectTools.GetOrAddComponent(var_428_23.gameObject, typeof(DynamicBoneHelper))

				if var_428_33 then
					var_428_33:EnableDynamicBone(true)
				end
			end

			local var_428_34 = 0
			local var_428_35 = 0.075

			if var_428_34 < arg_425_1.time_ and arg_425_1.time_ <= var_428_34 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_36 = arg_425_1:FormatText(StoryNameCfg[1487].name)

				arg_425_1.leftNameTxt_.text = var_428_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_37 = arg_425_1:GetWordFromCfg(426041105)
				local var_428_38 = arg_425_1:FormatText(var_428_37.content)

				arg_425_1.text_.text = var_428_38

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_39 = 3
				local var_428_40 = utf8.len(var_428_38)
				local var_428_41 = var_428_39 <= 0 and var_428_35 or var_428_35 * (var_428_40 / var_428_39)

				if var_428_41 > 0 and var_428_35 < var_428_41 then
					arg_425_1.talkMaxDuration = var_428_41

					if var_428_41 + var_428_34 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_41 + var_428_34
					end
				end

				arg_425_1.text_.text = var_428_38
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041105", "story_v_out_426041.awb") ~= 0 then
					local var_428_42 = manager.audio:GetVoiceLength("story_v_out_426041", "426041105", "story_v_out_426041.awb") / 1000

					if var_428_42 + var_428_34 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_42 + var_428_34
					end

					if var_428_37.prefab_name ~= "" and arg_425_1.actors_[var_428_37.prefab_name] ~= nil then
						local var_428_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_37.prefab_name].transform, "story_v_out_426041", "426041105", "story_v_out_426041.awb")

						arg_425_1:RecordAudio("426041105", var_428_43)
						arg_425_1:RecordAudio("426041105", var_428_43)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_426041", "426041105", "story_v_out_426041.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_426041", "426041105", "story_v_out_426041.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_44 = math.max(var_428_35, arg_425_1.talkMaxDuration)

			if var_428_34 <= arg_425_1.time_ and arg_425_1.time_ < var_428_34 + var_428_44 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_34) / var_428_44

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_34 + var_428_44 and arg_425_1.time_ < var_428_34 + var_428_44 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play426041106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 426041106
		arg_429_1.duration_ = 7.9

		local var_429_0 = {
			zh = 7.6,
			ja = 7.9
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play426041107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["6148ui_story"].transform
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.var_.moveOldPos6148ui_story = var_432_0.localPosition

				local var_432_2 = GameObjectTools.GetOrAddComponent(var_432_0.gameObject, typeof(DynamicBoneHelper))

				if var_432_2 then
					var_432_2:EnableDynamicBone(false)
				end
			end

			local var_432_3 = 0.001

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_3 then
				local var_432_4 = (arg_429_1.time_ - var_432_1) / var_432_3
				local var_432_5 = Vector3.New(-0.7, -0.985, -6)

				var_432_0.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos6148ui_story, var_432_5, var_432_4)

				local var_432_6 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_6.x, var_432_6.y, var_432_6.z)

				local var_432_7 = var_432_0.localEulerAngles

				var_432_7.z = 0
				var_432_7.x = 0
				var_432_0.localEulerAngles = var_432_7
			end

			if arg_429_1.time_ >= var_432_1 + var_432_3 and arg_429_1.time_ < var_432_1 + var_432_3 + arg_432_0 then
				var_432_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_432_8 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_8.x, var_432_8.y, var_432_8.z)

				local var_432_9 = var_432_0.localEulerAngles

				var_432_9.z = 0
				var_432_9.x = 0
				var_432_0.localEulerAngles = var_432_9

				local var_432_10 = GameObjectTools.GetOrAddComponent(var_432_0.gameObject, typeof(DynamicBoneHelper))

				if var_432_10 then
					var_432_10:EnableDynamicBone(true)
				end
			end

			local var_432_11 = arg_429_1.actors_["6148ui_story"]
			local var_432_12 = 0

			if var_432_12 < arg_429_1.time_ and arg_429_1.time_ <= var_432_12 + arg_432_0 and not isNil(var_432_11) and arg_429_1.var_.characterEffect6148ui_story == nil then
				arg_429_1.var_.characterEffect6148ui_story = var_432_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_13 = 0.200000002980232

			if var_432_12 <= arg_429_1.time_ and arg_429_1.time_ < var_432_12 + var_432_13 and not isNil(var_432_11) then
				local var_432_14 = (arg_429_1.time_ - var_432_12) / var_432_13

				if arg_429_1.var_.characterEffect6148ui_story and not isNil(var_432_11) then
					arg_429_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= var_432_12 + var_432_13 and arg_429_1.time_ < var_432_12 + var_432_13 + arg_432_0 and not isNil(var_432_11) and arg_429_1.var_.characterEffect6148ui_story then
				arg_429_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_432_15 = arg_429_1.actors_["1054ui_story"]
			local var_432_16 = 0

			if var_432_16 < arg_429_1.time_ and arg_429_1.time_ <= var_432_16 + arg_432_0 and not isNil(var_432_15) and arg_429_1.var_.characterEffect1054ui_story == nil then
				arg_429_1.var_.characterEffect1054ui_story = var_432_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_17 = 0.200000002980232

			if var_432_16 <= arg_429_1.time_ and arg_429_1.time_ < var_432_16 + var_432_17 and not isNil(var_432_15) then
				local var_432_18 = (arg_429_1.time_ - var_432_16) / var_432_17

				if arg_429_1.var_.characterEffect1054ui_story and not isNil(var_432_15) then
					local var_432_19 = Mathf.Lerp(0, 0.5, var_432_18)

					arg_429_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1054ui_story.fillRatio = var_432_19
				end
			end

			if arg_429_1.time_ >= var_432_16 + var_432_17 and arg_429_1.time_ < var_432_16 + var_432_17 + arg_432_0 and not isNil(var_432_15) and arg_429_1.var_.characterEffect1054ui_story then
				local var_432_20 = 0.5

				arg_429_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1054ui_story.fillRatio = var_432_20
			end

			local var_432_21 = 0

			if var_432_21 < arg_429_1.time_ and arg_429_1.time_ <= var_432_21 + arg_432_0 then
				arg_429_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_432_22 = 0

			if var_432_22 < arg_429_1.time_ and arg_429_1.time_ <= var_432_22 + arg_432_0 then
				arg_429_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_432_23 = 0
			local var_432_24 = 0.775

			if var_432_23 < arg_429_1.time_ and arg_429_1.time_ <= var_432_23 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_25 = arg_429_1:FormatText(StoryNameCfg[1488].name)

				arg_429_1.leftNameTxt_.text = var_432_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_26 = arg_429_1:GetWordFromCfg(426041106)
				local var_432_27 = arg_429_1:FormatText(var_432_26.content)

				arg_429_1.text_.text = var_432_27

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_28 = 31
				local var_432_29 = utf8.len(var_432_27)
				local var_432_30 = var_432_28 <= 0 and var_432_24 or var_432_24 * (var_432_29 / var_432_28)

				if var_432_30 > 0 and var_432_24 < var_432_30 then
					arg_429_1.talkMaxDuration = var_432_30

					if var_432_30 + var_432_23 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_30 + var_432_23
					end
				end

				arg_429_1.text_.text = var_432_27
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041106", "story_v_out_426041.awb") ~= 0 then
					local var_432_31 = manager.audio:GetVoiceLength("story_v_out_426041", "426041106", "story_v_out_426041.awb") / 1000

					if var_432_31 + var_432_23 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_31 + var_432_23
					end

					if var_432_26.prefab_name ~= "" and arg_429_1.actors_[var_432_26.prefab_name] ~= nil then
						local var_432_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_26.prefab_name].transform, "story_v_out_426041", "426041106", "story_v_out_426041.awb")

						arg_429_1:RecordAudio("426041106", var_432_32)
						arg_429_1:RecordAudio("426041106", var_432_32)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_426041", "426041106", "story_v_out_426041.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_426041", "426041106", "story_v_out_426041.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_33 = math.max(var_432_24, arg_429_1.talkMaxDuration)

			if var_432_23 <= arg_429_1.time_ and arg_429_1.time_ < var_432_23 + var_432_33 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_23) / var_432_33

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_23 + var_432_33 and arg_429_1.time_ < var_432_23 + var_432_33 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play426041107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 426041107
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play426041108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1054ui_story"].transform
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.var_.moveOldPos1054ui_story = var_436_0.localPosition

				local var_436_2 = GameObjectTools.GetOrAddComponent(var_436_0.gameObject, typeof(DynamicBoneHelper))

				if var_436_2 then
					var_436_2:EnableDynamicBone(false)
				end
			end

			local var_436_3 = 0.001

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_3 then
				local var_436_4 = (arg_433_1.time_ - var_436_1) / var_436_3
				local var_436_5 = Vector3.New(0, 100, 0)

				var_436_0.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1054ui_story, var_436_5, var_436_4)

				local var_436_6 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_6.x, var_436_6.y, var_436_6.z)

				local var_436_7 = var_436_0.localEulerAngles

				var_436_7.z = 0
				var_436_7.x = 0
				var_436_0.localEulerAngles = var_436_7
			end

			if arg_433_1.time_ >= var_436_1 + var_436_3 and arg_433_1.time_ < var_436_1 + var_436_3 + arg_436_0 then
				var_436_0.localPosition = Vector3.New(0, 100, 0)

				local var_436_8 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_8.x, var_436_8.y, var_436_8.z)

				local var_436_9 = var_436_0.localEulerAngles

				var_436_9.z = 0
				var_436_9.x = 0
				var_436_0.localEulerAngles = var_436_9

				local var_436_10 = GameObjectTools.GetOrAddComponent(var_436_0.gameObject, typeof(DynamicBoneHelper))

				if var_436_10 then
					var_436_10:EnableDynamicBone(true)
				end
			end

			local var_436_11 = arg_433_1.actors_["6148ui_story"]
			local var_436_12 = 0

			if var_436_12 < arg_433_1.time_ and arg_433_1.time_ <= var_436_12 + arg_436_0 and not isNil(var_436_11) and arg_433_1.var_.characterEffect6148ui_story == nil then
				arg_433_1.var_.characterEffect6148ui_story = var_436_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_13 = 0.200000002980232

			if var_436_12 <= arg_433_1.time_ and arg_433_1.time_ < var_436_12 + var_436_13 and not isNil(var_436_11) then
				local var_436_14 = (arg_433_1.time_ - var_436_12) / var_436_13

				if arg_433_1.var_.characterEffect6148ui_story and not isNil(var_436_11) then
					local var_436_15 = Mathf.Lerp(0, 0.5, var_436_14)

					arg_433_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_433_1.var_.characterEffect6148ui_story.fillRatio = var_436_15
				end
			end

			if arg_433_1.time_ >= var_436_12 + var_436_13 and arg_433_1.time_ < var_436_12 + var_436_13 + arg_436_0 and not isNil(var_436_11) and arg_433_1.var_.characterEffect6148ui_story then
				local var_436_16 = 0.5

				arg_433_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_433_1.var_.characterEffect6148ui_story.fillRatio = var_436_16
			end

			local var_436_17 = 0.6
			local var_436_18 = 1

			if var_436_17 < arg_433_1.time_ and arg_433_1.time_ <= var_436_17 + arg_436_0 then
				local var_436_19 = "play"
				local var_436_20 = "effect"

				arg_433_1:AudioAction(var_436_19, var_436_20, "se_story_150", "se_story_150_chair", "")
			end

			local var_436_21 = arg_433_1.actors_["6148ui_story"].transform
			local var_436_22 = 0

			if var_436_22 < arg_433_1.time_ and arg_433_1.time_ <= var_436_22 + arg_436_0 then
				arg_433_1.var_.moveOldPos6148ui_story = var_436_21.localPosition

				local var_436_23 = GameObjectTools.GetOrAddComponent(var_436_21.gameObject, typeof(DynamicBoneHelper))

				if var_436_23 then
					var_436_23:EnableDynamicBone(false)
				end
			end

			local var_436_24 = 0.001

			if var_436_22 <= arg_433_1.time_ and arg_433_1.time_ < var_436_22 + var_436_24 then
				local var_436_25 = (arg_433_1.time_ - var_436_22) / var_436_24
				local var_436_26 = Vector3.New(0, 100, 0)

				var_436_21.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos6148ui_story, var_436_26, var_436_25)

				local var_436_27 = manager.ui.mainCamera.transform.position - var_436_21.position

				var_436_21.forward = Vector3.New(var_436_27.x, var_436_27.y, var_436_27.z)

				local var_436_28 = var_436_21.localEulerAngles

				var_436_28.z = 0
				var_436_28.x = 0
				var_436_21.localEulerAngles = var_436_28
			end

			if arg_433_1.time_ >= var_436_22 + var_436_24 and arg_433_1.time_ < var_436_22 + var_436_24 + arg_436_0 then
				var_436_21.localPosition = Vector3.New(0, 100, 0)

				local var_436_29 = manager.ui.mainCamera.transform.position - var_436_21.position

				var_436_21.forward = Vector3.New(var_436_29.x, var_436_29.y, var_436_29.z)

				local var_436_30 = var_436_21.localEulerAngles

				var_436_30.z = 0
				var_436_30.x = 0
				var_436_21.localEulerAngles = var_436_30

				local var_436_31 = GameObjectTools.GetOrAddComponent(var_436_21.gameObject, typeof(DynamicBoneHelper))

				if var_436_31 then
					var_436_31:EnableDynamicBone(true)
				end
			end

			local var_436_32 = 0
			local var_436_33 = 0.85

			if var_436_32 < arg_433_1.time_ and arg_433_1.time_ <= var_436_32 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_34 = arg_433_1:GetWordFromCfg(426041107)
				local var_436_35 = arg_433_1:FormatText(var_436_34.content)

				arg_433_1.text_.text = var_436_35

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_36 = 34
				local var_436_37 = utf8.len(var_436_35)
				local var_436_38 = var_436_36 <= 0 and var_436_33 or var_436_33 * (var_436_37 / var_436_36)

				if var_436_38 > 0 and var_436_33 < var_436_38 then
					arg_433_1.talkMaxDuration = var_436_38

					if var_436_38 + var_436_32 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_38 + var_436_32
					end
				end

				arg_433_1.text_.text = var_436_35
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_39 = math.max(var_436_33, arg_433_1.talkMaxDuration)

			if var_436_32 <= arg_433_1.time_ and arg_433_1.time_ < var_436_32 + var_436_39 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_32) / var_436_39

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_32 + var_436_39 and arg_433_1.time_ < var_436_32 + var_436_39 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play426041108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 426041108
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play426041109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0
			local var_440_1 = 0.525

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_2 = arg_437_1:FormatText(StoryNameCfg[7].name)

				arg_437_1.leftNameTxt_.text = var_440_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_3 = arg_437_1:GetWordFromCfg(426041108)
				local var_440_4 = arg_437_1:FormatText(var_440_3.content)

				arg_437_1.text_.text = var_440_4

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 21
				local var_440_6 = utf8.len(var_440_4)
				local var_440_7 = var_440_5 <= 0 and var_440_1 or var_440_1 * (var_440_6 / var_440_5)

				if var_440_7 > 0 and var_440_1 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_0
					end
				end

				arg_437_1.text_.text = var_440_4
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_8 = math.max(var_440_1, arg_437_1.talkMaxDuration)

			if var_440_0 <= arg_437_1.time_ and arg_437_1.time_ < var_440_0 + var_440_8 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_0) / var_440_8

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_0 + var_440_8 and arg_437_1.time_ < var_440_0 + var_440_8 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play426041109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 426041109
		arg_441_1.duration_ = 5.1

		local var_441_0 = {
			zh = 5.1,
			ja = 4.966
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
				arg_441_0:Play426041110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["6148ui_story"].transform
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.var_.moveOldPos6148ui_story = var_444_0.localPosition

				local var_444_2 = GameObjectTools.GetOrAddComponent(var_444_0.gameObject, typeof(DynamicBoneHelper))

				if var_444_2 then
					var_444_2:EnableDynamicBone(false)
				end
			end

			local var_444_3 = 0.001

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_3 then
				local var_444_4 = (arg_441_1.time_ - var_444_1) / var_444_3
				local var_444_5 = Vector3.New(0, -0.985, -6)

				var_444_0.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos6148ui_story, var_444_5, var_444_4)

				local var_444_6 = manager.ui.mainCamera.transform.position - var_444_0.position

				var_444_0.forward = Vector3.New(var_444_6.x, var_444_6.y, var_444_6.z)

				local var_444_7 = var_444_0.localEulerAngles

				var_444_7.z = 0
				var_444_7.x = 0
				var_444_0.localEulerAngles = var_444_7
			end

			if arg_441_1.time_ >= var_444_1 + var_444_3 and arg_441_1.time_ < var_444_1 + var_444_3 + arg_444_0 then
				var_444_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_444_8 = manager.ui.mainCamera.transform.position - var_444_0.position

				var_444_0.forward = Vector3.New(var_444_8.x, var_444_8.y, var_444_8.z)

				local var_444_9 = var_444_0.localEulerAngles

				var_444_9.z = 0
				var_444_9.x = 0
				var_444_0.localEulerAngles = var_444_9

				local var_444_10 = GameObjectTools.GetOrAddComponent(var_444_0.gameObject, typeof(DynamicBoneHelper))

				if var_444_10 then
					var_444_10:EnableDynamicBone(true)
				end
			end

			local var_444_11 = arg_441_1.actors_["6148ui_story"]
			local var_444_12 = 0

			if var_444_12 < arg_441_1.time_ and arg_441_1.time_ <= var_444_12 + arg_444_0 and not isNil(var_444_11) and arg_441_1.var_.characterEffect6148ui_story == nil then
				arg_441_1.var_.characterEffect6148ui_story = var_444_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_13 = 0.200000002980232

			if var_444_12 <= arg_441_1.time_ and arg_441_1.time_ < var_444_12 + var_444_13 and not isNil(var_444_11) then
				local var_444_14 = (arg_441_1.time_ - var_444_12) / var_444_13

				if arg_441_1.var_.characterEffect6148ui_story and not isNil(var_444_11) then
					arg_441_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= var_444_12 + var_444_13 and arg_441_1.time_ < var_444_12 + var_444_13 + arg_444_0 and not isNil(var_444_11) and arg_441_1.var_.characterEffect6148ui_story then
				arg_441_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_444_15 = 0

			if var_444_15 < arg_441_1.time_ and arg_441_1.time_ <= var_444_15 + arg_444_0 then
				arg_441_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_444_16 = 0

			if var_444_16 < arg_441_1.time_ and arg_441_1.time_ <= var_444_16 + arg_444_0 then
				arg_441_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_444_17 = 0
			local var_444_18 = 0.4

			if var_444_17 < arg_441_1.time_ and arg_441_1.time_ <= var_444_17 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_19 = arg_441_1:FormatText(StoryNameCfg[1488].name)

				arg_441_1.leftNameTxt_.text = var_444_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_20 = arg_441_1:GetWordFromCfg(426041109)
				local var_444_21 = arg_441_1:FormatText(var_444_20.content)

				arg_441_1.text_.text = var_444_21

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_22 = 16
				local var_444_23 = utf8.len(var_444_21)
				local var_444_24 = var_444_22 <= 0 and var_444_18 or var_444_18 * (var_444_23 / var_444_22)

				if var_444_24 > 0 and var_444_18 < var_444_24 then
					arg_441_1.talkMaxDuration = var_444_24

					if var_444_24 + var_444_17 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_24 + var_444_17
					end
				end

				arg_441_1.text_.text = var_444_21
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041109", "story_v_out_426041.awb") ~= 0 then
					local var_444_25 = manager.audio:GetVoiceLength("story_v_out_426041", "426041109", "story_v_out_426041.awb") / 1000

					if var_444_25 + var_444_17 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_25 + var_444_17
					end

					if var_444_20.prefab_name ~= "" and arg_441_1.actors_[var_444_20.prefab_name] ~= nil then
						local var_444_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_20.prefab_name].transform, "story_v_out_426041", "426041109", "story_v_out_426041.awb")

						arg_441_1:RecordAudio("426041109", var_444_26)
						arg_441_1:RecordAudio("426041109", var_444_26)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_426041", "426041109", "story_v_out_426041.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_426041", "426041109", "story_v_out_426041.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_27 = math.max(var_444_18, arg_441_1.talkMaxDuration)

			if var_444_17 <= arg_441_1.time_ and arg_441_1.time_ < var_444_17 + var_444_27 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_17) / var_444_27

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_17 + var_444_27 and arg_441_1.time_ < var_444_17 + var_444_27 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play426041110 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 426041110
		arg_445_1.duration_ = 2.8

		local var_445_0 = {
			zh = 2.7,
			ja = 2.8
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
			arg_445_1.auto_ = false
		end

		function arg_445_1.playNext_(arg_447_0)
			arg_445_1.onStoryFinished_()
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 0.225

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_2 = arg_445_1:FormatText(StoryNameCfg[1488].name)

				arg_445_1.leftNameTxt_.text = var_448_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_3 = arg_445_1:GetWordFromCfg(426041110)
				local var_448_4 = arg_445_1:FormatText(var_448_3.content)

				arg_445_1.text_.text = var_448_4

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 9
				local var_448_6 = utf8.len(var_448_4)
				local var_448_7 = var_448_5 <= 0 and var_448_1 or var_448_1 * (var_448_6 / var_448_5)

				if var_448_7 > 0 and var_448_1 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_4
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426041", "426041110", "story_v_out_426041.awb") ~= 0 then
					local var_448_8 = manager.audio:GetVoiceLength("story_v_out_426041", "426041110", "story_v_out_426041.awb") / 1000

					if var_448_8 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_8 + var_448_0
					end

					if var_448_3.prefab_name ~= "" and arg_445_1.actors_[var_448_3.prefab_name] ~= nil then
						local var_448_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_3.prefab_name].transform, "story_v_out_426041", "426041110", "story_v_out_426041.awb")

						arg_445_1:RecordAudio("426041110", var_448_9)
						arg_445_1:RecordAudio("426041110", var_448_9)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_426041", "426041110", "story_v_out_426041.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_426041", "426041110", "story_v_out_426041.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_10 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_10 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_10

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_10 and arg_445_1.time_ < var_448_0 + var_448_10 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2007a",
		"TextureConfig/Background/J27h"
	},
	voices = {
		"story_v_out_426041.awb"
	}
}
