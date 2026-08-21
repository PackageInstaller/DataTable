return {
	Play324162001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324162001
		arg_1_1.duration_ = 4.4

		local var_1_0 = {
			zh = 4.266,
			ja = 4.4
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
				arg_1_0:Play324162002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J27i"

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
				local var_4_5 = arg_1_1.bgs_.J27i

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
					if iter_4_0 ~= "J27i" then
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
			local var_4_30 = 1.76666666666667

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
				local var_4_34 = Vector3.New(-0.7, -0.985, -6)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos6148ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(-0.7, -0.985, -6)

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
			local var_4_41 = 1.76666666666667

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

			local var_4_44 = 1.76666666666667

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_4_45 = 1.76666666666667

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_4_46 = 0.1
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "effect"

				arg_1_1:AudioAction(var_4_48, var_4_49, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_4_50 = 0
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "effect"

				arg_1_1:AudioAction(var_4_52, var_4_53, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_54 = 1
			local var_4_55 = 1

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_56 = "play"
				local var_4_57 = "music"

				arg_1_1:AudioAction(var_4_56, var_4_57, "bgm_activity_5_0_story_dilao", "bgm_activity_5_0_story_dilao", "bgm_activity_5_0_story_dilao.awb")

				local var_4_58 = ""
				local var_4_59 = manager.audio:GetAudioName("bgm_activity_5_0_story_dilao", "bgm_activity_5_0_story_dilao")

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

			local var_4_60 = 2
			local var_4_61 = 0.25

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

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[1488].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(324162001)
				local var_4_65 = arg_1_1:FormatText(var_4_64.content)

				arg_1_1.text_.text = var_4_65

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_66 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_324162", "324162001", "story_v_out_324162.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_out_324162", "324162001", "story_v_out_324162.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_out_324162", "324162001", "story_v_out_324162.awb")

						arg_1_1:RecordAudio("324162001", var_4_70)
						arg_1_1:RecordAudio("324162001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324162", "324162001", "story_v_out_324162.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324162", "324162001", "story_v_out_324162.awb")
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play324162002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324162002
		arg_8_1.duration_ = 2.03

		local var_8_0 = {
			zh = 2.033,
			ja = 1.999999999999
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
				arg_8_0:Play324162003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1054ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_8_1.stage_.transform)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

					var_11_3.enabled = true

					local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

					if var_11_4 then
						var_11_4:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_3.transform, false)

					arg_8_1.var_[var_11_0 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_0 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_0 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_5 = arg_8_1.actors_["1054ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1054ui_story = var_11_5.localPosition

				local var_11_7 = GameObjectTools.GetOrAddComponent(var_11_5.gameObject, typeof(DynamicBoneHelper))

				if var_11_7 then
					var_11_7:EnableDynamicBone(false)
				end
			end

			local var_11_8 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_8 then
				local var_11_9 = (arg_8_1.time_ - var_11_6) / var_11_8
				local var_11_10 = Vector3.New(0.7, -0.985, -6)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1054ui_story, var_11_10, var_11_9)

				local var_11_11 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_11.x, var_11_11.y, var_11_11.z)

				local var_11_12 = var_11_5.localEulerAngles

				var_11_12.z = 0
				var_11_12.x = 0
				var_11_5.localEulerAngles = var_11_12
			end

			if arg_8_1.time_ >= var_11_6 + var_11_8 and arg_8_1.time_ < var_11_6 + var_11_8 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_11_13 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_13.x, var_11_13.y, var_11_13.z)

				local var_11_14 = var_11_5.localEulerAngles

				var_11_14.z = 0
				var_11_14.x = 0
				var_11_5.localEulerAngles = var_11_14

				local var_11_15 = GameObjectTools.GetOrAddComponent(var_11_5.gameObject, typeof(DynamicBoneHelper))

				if var_11_15 then
					var_11_15:EnableDynamicBone(true)
				end
			end

			local var_11_16 = arg_8_1.actors_["6148ui_story"]
			local var_11_17 = 0

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect6148ui_story == nil then
				arg_8_1.var_.characterEffect6148ui_story = var_11_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_18 = 0.200000002980232

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_18 and not isNil(var_11_16) then
				local var_11_19 = (arg_8_1.time_ - var_11_17) / var_11_18

				if arg_8_1.var_.characterEffect6148ui_story and not isNil(var_11_16) then
					local var_11_20 = Mathf.Lerp(0, 0.5, var_11_19)

					arg_8_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect6148ui_story.fillRatio = var_11_20
				end
			end

			if arg_8_1.time_ >= var_11_17 + var_11_18 and arg_8_1.time_ < var_11_17 + var_11_18 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect6148ui_story then
				local var_11_21 = 0.5

				arg_8_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect6148ui_story.fillRatio = var_11_21
			end

			local var_11_22 = 0

			if var_11_22 < arg_8_1.time_ and arg_8_1.time_ <= var_11_22 + arg_11_0 then
				arg_8_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_11_23 = 0

			if var_11_23 < arg_8_1.time_ and arg_8_1.time_ <= var_11_23 + arg_11_0 then
				arg_8_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_11_24 = arg_8_1.actors_["1054ui_story"]
			local var_11_25 = 0

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 and not isNil(var_11_24) and arg_8_1.var_.characterEffect1054ui_story == nil then
				arg_8_1.var_.characterEffect1054ui_story = var_11_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_26 = 0.200000002980232

			if var_11_25 <= arg_8_1.time_ and arg_8_1.time_ < var_11_25 + var_11_26 and not isNil(var_11_24) then
				local var_11_27 = (arg_8_1.time_ - var_11_25) / var_11_26

				if arg_8_1.var_.characterEffect1054ui_story and not isNil(var_11_24) then
					arg_8_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_25 + var_11_26 and arg_8_1.time_ < var_11_25 + var_11_26 + arg_11_0 and not isNil(var_11_24) and arg_8_1.var_.characterEffect1054ui_story then
				arg_8_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_11_28 = 0
			local var_11_29 = 0.2

			if var_11_28 < arg_8_1.time_ and arg_8_1.time_ <= var_11_28 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_30 = arg_8_1:FormatText(StoryNameCfg[1487].name)

				arg_8_1.leftNameTxt_.text = var_11_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_31 = arg_8_1:GetWordFromCfg(324162002)
				local var_11_32 = arg_8_1:FormatText(var_11_31.content)

				arg_8_1.text_.text = var_11_32

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_33 = 8
				local var_11_34 = utf8.len(var_11_32)
				local var_11_35 = var_11_33 <= 0 and var_11_29 or var_11_29 * (var_11_34 / var_11_33)

				if var_11_35 > 0 and var_11_29 < var_11_35 then
					arg_8_1.talkMaxDuration = var_11_35

					if var_11_35 + var_11_28 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_35 + var_11_28
					end
				end

				arg_8_1.text_.text = var_11_32
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324162", "324162002", "story_v_out_324162.awb") ~= 0 then
					local var_11_36 = manager.audio:GetVoiceLength("story_v_out_324162", "324162002", "story_v_out_324162.awb") / 1000

					if var_11_36 + var_11_28 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_36 + var_11_28
					end

					if var_11_31.prefab_name ~= "" and arg_8_1.actors_[var_11_31.prefab_name] ~= nil then
						local var_11_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_31.prefab_name].transform, "story_v_out_324162", "324162002", "story_v_out_324162.awb")

						arg_8_1:RecordAudio("324162002", var_11_37)
						arg_8_1:RecordAudio("324162002", var_11_37)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324162", "324162002", "story_v_out_324162.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324162", "324162002", "story_v_out_324162.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_38 = math.max(var_11_29, arg_8_1.talkMaxDuration)

			if var_11_28 <= arg_8_1.time_ and arg_8_1.time_ < var_11_28 + var_11_38 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_28) / var_11_38

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_28 + var_11_38 and arg_8_1.time_ < var_11_28 + var_11_38 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play324162003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324162003
		arg_12_1.duration_ = 2.17

		local var_12_0 = {
			zh = 1.666,
			ja = 2.166
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
				arg_12_0:Play324162004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1054ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1054ui_story == nil then
				arg_12_1.var_.characterEffect1054ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1054ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1054ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1054ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1054ui_story.fillRatio = var_15_5
			end

			local var_15_6 = arg_12_1.actors_["6148ui_story"]
			local var_15_7 = 0

			if var_15_7 < arg_12_1.time_ and arg_12_1.time_ <= var_15_7 + arg_15_0 and not isNil(var_15_6) and arg_12_1.var_.characterEffect6148ui_story == nil then
				arg_12_1.var_.characterEffect6148ui_story = var_15_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_8 = 0.200000002980232

			if var_15_7 <= arg_12_1.time_ and arg_12_1.time_ < var_15_7 + var_15_8 and not isNil(var_15_6) then
				local var_15_9 = (arg_12_1.time_ - var_15_7) / var_15_8

				if arg_12_1.var_.characterEffect6148ui_story and not isNil(var_15_6) then
					arg_12_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_7 + var_15_8 and arg_12_1.time_ < var_15_7 + var_15_8 + arg_15_0 and not isNil(var_15_6) and arg_12_1.var_.characterEffect6148ui_story then
				arg_12_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_15_10 = 0
			local var_15_11 = 0.15

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_12 = arg_12_1:FormatText(StoryNameCfg[1488].name)

				arg_12_1.leftNameTxt_.text = var_15_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_13 = arg_12_1:GetWordFromCfg(324162003)
				local var_15_14 = arg_12_1:FormatText(var_15_13.content)

				arg_12_1.text_.text = var_15_14

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 6
				local var_15_16 = utf8.len(var_15_14)
				local var_15_17 = var_15_15 <= 0 and var_15_11 or var_15_11 * (var_15_16 / var_15_15)

				if var_15_17 > 0 and var_15_11 < var_15_17 then
					arg_12_1.talkMaxDuration = var_15_17

					if var_15_17 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_17 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_14
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324162", "324162003", "story_v_out_324162.awb") ~= 0 then
					local var_15_18 = manager.audio:GetVoiceLength("story_v_out_324162", "324162003", "story_v_out_324162.awb") / 1000

					if var_15_18 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_18 + var_15_10
					end

					if var_15_13.prefab_name ~= "" and arg_12_1.actors_[var_15_13.prefab_name] ~= nil then
						local var_15_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_13.prefab_name].transform, "story_v_out_324162", "324162003", "story_v_out_324162.awb")

						arg_12_1:RecordAudio("324162003", var_15_19)
						arg_12_1:RecordAudio("324162003", var_15_19)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_324162", "324162003", "story_v_out_324162.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_324162", "324162003", "story_v_out_324162.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_20 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_20 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_20

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_20 and arg_12_1.time_ < var_15_10 + var_15_20 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324162004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324162004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324162005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1054ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos1054ui_story = var_19_0.localPosition

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end
			end

			local var_19_3 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1054ui_story, var_19_5, var_19_4)

				local var_19_6 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_6.x, var_19_6.y, var_19_6.z)

				local var_19_7 = var_19_0.localEulerAngles

				var_19_7.z = 0
				var_19_7.x = 0
				var_19_0.localEulerAngles = var_19_7
			end

			if arg_16_1.time_ >= var_19_1 + var_19_3 and arg_16_1.time_ < var_19_1 + var_19_3 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, 100, 0)

				local var_19_8 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_8.x, var_19_8.y, var_19_8.z)

				local var_19_9 = var_19_0.localEulerAngles

				var_19_9.z = 0
				var_19_9.x = 0
				var_19_0.localEulerAngles = var_19_9

				local var_19_10 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_10 then
					var_19_10:EnableDynamicBone(true)
				end
			end

			local var_19_11 = arg_16_1.actors_["6148ui_story"].transform
			local var_19_12 = 0

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.var_.moveOldPos6148ui_story = var_19_11.localPosition

				local var_19_13 = GameObjectTools.GetOrAddComponent(var_19_11.gameObject, typeof(DynamicBoneHelper))

				if var_19_13 then
					var_19_13:EnableDynamicBone(false)
				end
			end

			local var_19_14 = 0.001

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_14 then
				local var_19_15 = (arg_16_1.time_ - var_19_12) / var_19_14
				local var_19_16 = Vector3.New(0, 100, 0)

				var_19_11.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos6148ui_story, var_19_16, var_19_15)

				local var_19_17 = manager.ui.mainCamera.transform.position - var_19_11.position

				var_19_11.forward = Vector3.New(var_19_17.x, var_19_17.y, var_19_17.z)

				local var_19_18 = var_19_11.localEulerAngles

				var_19_18.z = 0
				var_19_18.x = 0
				var_19_11.localEulerAngles = var_19_18
			end

			if arg_16_1.time_ >= var_19_12 + var_19_14 and arg_16_1.time_ < var_19_12 + var_19_14 + arg_19_0 then
				var_19_11.localPosition = Vector3.New(0, 100, 0)

				local var_19_19 = manager.ui.mainCamera.transform.position - var_19_11.position

				var_19_11.forward = Vector3.New(var_19_19.x, var_19_19.y, var_19_19.z)

				local var_19_20 = var_19_11.localEulerAngles

				var_19_20.z = 0
				var_19_20.x = 0
				var_19_11.localEulerAngles = var_19_20

				local var_19_21 = GameObjectTools.GetOrAddComponent(var_19_11.gameObject, typeof(DynamicBoneHelper))

				if var_19_21 then
					var_19_21:EnableDynamicBone(true)
				end
			end

			local var_19_22 = "1037ui_story"

			if arg_16_1.actors_[var_19_22] == nil then
				local var_19_23 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_19_23) then
					local var_19_24 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_16_1.stage_.transform)

					var_19_24.name = var_19_22
					var_19_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_22] = var_19_24

					local var_19_25 = var_19_24:GetComponentInChildren(typeof(CharacterEffect))

					var_19_25.enabled = true

					local var_19_26 = GameObjectTools.GetOrAddComponent(var_19_24, typeof(DynamicBoneHelper))

					if var_19_26 then
						var_19_26:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_25.transform, false)

					arg_16_1.var_[var_19_22 .. "Animator"] = var_19_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_22 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_22 .. "LipSync"] = var_19_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_27 = arg_16_1.actors_["1037ui_story"]
			local var_19_28 = 0

			if var_19_28 < arg_16_1.time_ and arg_16_1.time_ <= var_19_28 + arg_19_0 and not isNil(var_19_27) and arg_16_1.var_.characterEffect1037ui_story == nil then
				arg_16_1.var_.characterEffect1037ui_story = var_19_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_29 = 0.200000002980232

			if var_19_28 <= arg_16_1.time_ and arg_16_1.time_ < var_19_28 + var_19_29 and not isNil(var_19_27) then
				local var_19_30 = (arg_16_1.time_ - var_19_28) / var_19_29

				if arg_16_1.var_.characterEffect1037ui_story and not isNil(var_19_27) then
					local var_19_31 = Mathf.Lerp(0, 0.5, var_19_30)

					arg_16_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1037ui_story.fillRatio = var_19_31
				end
			end

			if arg_16_1.time_ >= var_19_28 + var_19_29 and arg_16_1.time_ < var_19_28 + var_19_29 + arg_19_0 and not isNil(var_19_27) and arg_16_1.var_.characterEffect1037ui_story then
				local var_19_32 = 0.5

				arg_16_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1037ui_story.fillRatio = var_19_32
			end

			local var_19_33 = 0
			local var_19_34 = 1.025

			if var_19_33 < arg_16_1.time_ and arg_16_1.time_ <= var_19_33 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_35 = arg_16_1:GetWordFromCfg(324162004)
				local var_19_36 = arg_16_1:FormatText(var_19_35.content)

				arg_16_1.text_.text = var_19_36

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_37 = 41
				local var_19_38 = utf8.len(var_19_36)
				local var_19_39 = var_19_37 <= 0 and var_19_34 or var_19_34 * (var_19_38 / var_19_37)

				if var_19_39 > 0 and var_19_34 < var_19_39 then
					arg_16_1.talkMaxDuration = var_19_39

					if var_19_39 + var_19_33 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_39 + var_19_33
					end
				end

				arg_16_1.text_.text = var_19_36
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_40 = math.max(var_19_34, arg_16_1.talkMaxDuration)

			if var_19_33 <= arg_16_1.time_ and arg_16_1.time_ < var_19_33 + var_19_40 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_33) / var_19_40

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_33 + var_19_40 and arg_16_1.time_ < var_19_33 + var_19_40 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play324162005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324162005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324162006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.7

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(324162005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 28
				local var_23_5 = utf8.len(var_23_3)
				local var_23_6 = var_23_4 <= 0 and var_23_1 or var_23_1 * (var_23_5 / var_23_4)

				if var_23_6 > 0 and var_23_1 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_7 and arg_20_1.time_ < var_23_0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324162006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324162006
		arg_24_1.duration_ = 5.63

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324162007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.0333333333333333

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			local var_27_1 = 1.33333333333333

			if arg_24_1.time_ >= var_27_0 + var_27_1 and arg_24_1.time_ < var_27_0 + var_27_1 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end

			local var_27_2 = 0.1
			local var_27_3 = 1

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				local var_27_4 = "play"
				local var_27_5 = "effect"

				arg_24_1:AudioAction(var_27_4, var_27_5, "se_story_140", "se_story_140_amb_drone04", "")
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_6 = 0.633333333333333
			local var_27_7 = 0.9

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_8 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_8:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_24_1.dialogCg_.alpha = arg_28_0
				end))
				var_27_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_9 = arg_24_1:GetWordFromCfg(324162006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 36
				local var_27_12 = utf8.len(var_27_10)
				local var_27_13 = var_27_11 <= 0 and var_27_7 or var_27_7 * (var_27_12 / var_27_11)

				if var_27_13 > 0 and var_27_7 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13
					var_27_6 = var_27_6 + 0.3

					if var_27_13 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = var_27_6 + 0.3
			local var_27_15 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_14 <= arg_24_1.time_ and arg_24_1.time_ < var_27_14 + var_27_15 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_14) / var_27_15

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_14 + var_27_15 and arg_24_1.time_ < var_27_14 + var_27_15 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 0.5,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.9,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play324162007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 324162007
		arg_30_1.duration_ = 2.57

		local var_30_0 = {
			zh = 1.833,
			ja = 2.566
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play324162008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.125

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_2 = arg_30_1:FormatText(StoryNameCfg[1487].name)

				arg_30_1.leftNameTxt_.text = var_33_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_3 = arg_30_1:GetWordFromCfg(324162007)
				local var_33_4 = arg_30_1:FormatText(var_33_3.content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 5
				local var_33_6 = utf8.len(var_33_4)
				local var_33_7 = var_33_5 <= 0 and var_33_1 or var_33_1 * (var_33_6 / var_33_5)

				if var_33_7 > 0 and var_33_1 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324162", "324162007", "story_v_out_324162.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_324162", "324162007", "story_v_out_324162.awb") / 1000

					if var_33_8 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_0
					end

					if var_33_3.prefab_name ~= "" and arg_30_1.actors_[var_33_3.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_3.prefab_name].transform, "story_v_out_324162", "324162007", "story_v_out_324162.awb")

						arg_30_1:RecordAudio("324162007", var_33_9)
						arg_30_1:RecordAudio("324162007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_324162", "324162007", "story_v_out_324162.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_324162", "324162007", "story_v_out_324162.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_10 and arg_30_1.time_ < var_33_0 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play324162008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 324162008
		arg_34_1.duration_ = 3.2

		local var_34_0 = {
			zh = 3.2,
			ja = 3.1
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play324162009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = "1075ui_story"

			if arg_34_1.actors_[var_37_0] == nil then
				local var_37_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_37_1) then
					local var_37_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_34_1.stage_.transform)

					var_37_2.name = var_37_0
					var_37_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_34_1.actors_[var_37_0] = var_37_2

					local var_37_3 = var_37_2:GetComponentInChildren(typeof(CharacterEffect))

					var_37_3.enabled = true

					local var_37_4 = GameObjectTools.GetOrAddComponent(var_37_2, typeof(DynamicBoneHelper))

					if var_37_4 then
						var_37_4:EnableDynamicBone(false)
					end

					arg_34_1:ShowWeapon(var_37_3.transform, false)

					arg_34_1.var_[var_37_0 .. "Animator"] = var_37_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_34_1.var_[var_37_0 .. "Animator"].applyRootMotion = true
					arg_34_1.var_[var_37_0 .. "LipSync"] = var_37_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_37_5 = arg_34_1.actors_["1075ui_story"].transform
			local var_37_6 = 0

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.var_.moveOldPos1075ui_story = var_37_5.localPosition
			end

			local var_37_7 = 0.001

			if var_37_6 <= arg_34_1.time_ and arg_34_1.time_ < var_37_6 + var_37_7 then
				local var_37_8 = (arg_34_1.time_ - var_37_6) / var_37_7
				local var_37_9 = Vector3.New(0, -1.055, -6.16)

				var_37_5.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1075ui_story, var_37_9, var_37_8)

				local var_37_10 = manager.ui.mainCamera.transform.position - var_37_5.position

				var_37_5.forward = Vector3.New(var_37_10.x, var_37_10.y, var_37_10.z)

				local var_37_11 = var_37_5.localEulerAngles

				var_37_11.z = 0
				var_37_11.x = 0
				var_37_5.localEulerAngles = var_37_11
			end

			if arg_34_1.time_ >= var_37_6 + var_37_7 and arg_34_1.time_ < var_37_6 + var_37_7 + arg_37_0 then
				var_37_5.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_37_12 = manager.ui.mainCamera.transform.position - var_37_5.position

				var_37_5.forward = Vector3.New(var_37_12.x, var_37_12.y, var_37_12.z)

				local var_37_13 = var_37_5.localEulerAngles

				var_37_13.z = 0
				var_37_13.x = 0
				var_37_5.localEulerAngles = var_37_13
			end

			local var_37_14 = arg_34_1.actors_["1075ui_story"]
			local var_37_15 = 0

			if var_37_15 < arg_34_1.time_ and arg_34_1.time_ <= var_37_15 + arg_37_0 and not isNil(var_37_14) and arg_34_1.var_.characterEffect1075ui_story == nil then
				arg_34_1.var_.characterEffect1075ui_story = var_37_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_16 = 0.200000002980232

			if var_37_15 <= arg_34_1.time_ and arg_34_1.time_ < var_37_15 + var_37_16 and not isNil(var_37_14) then
				local var_37_17 = (arg_34_1.time_ - var_37_15) / var_37_16

				if arg_34_1.var_.characterEffect1075ui_story and not isNil(var_37_14) then
					arg_34_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_15 + var_37_16 and arg_34_1.time_ < var_37_15 + var_37_16 + arg_37_0 and not isNil(var_37_14) and arg_34_1.var_.characterEffect1075ui_story then
				arg_34_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_37_18 = "1036ui_story"

			if arg_34_1.actors_[var_37_18] == nil then
				local var_37_19 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_37_19) then
					local var_37_20 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_34_1.stage_.transform)

					var_37_20.name = var_37_18
					var_37_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_34_1.actors_[var_37_18] = var_37_20

					local var_37_21 = var_37_20:GetComponentInChildren(typeof(CharacterEffect))

					var_37_21.enabled = true

					local var_37_22 = GameObjectTools.GetOrAddComponent(var_37_20, typeof(DynamicBoneHelper))

					if var_37_22 then
						var_37_22:EnableDynamicBone(false)
					end

					arg_34_1:ShowWeapon(var_37_21.transform, false)

					arg_34_1.var_[var_37_18 .. "Animator"] = var_37_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_34_1.var_[var_37_18 .. "Animator"].applyRootMotion = true
					arg_34_1.var_[var_37_18 .. "LipSync"] = var_37_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_37_23 = arg_34_1.actors_["1036ui_story"]
			local var_37_24 = 0

			if var_37_24 < arg_34_1.time_ and arg_34_1.time_ <= var_37_24 + arg_37_0 and not isNil(var_37_23) and arg_34_1.var_.characterEffect1036ui_story == nil then
				arg_34_1.var_.characterEffect1036ui_story = var_37_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_25 = 0.200000002980232

			if var_37_24 <= arg_34_1.time_ and arg_34_1.time_ < var_37_24 + var_37_25 and not isNil(var_37_23) then
				local var_37_26 = (arg_34_1.time_ - var_37_24) / var_37_25

				if arg_34_1.var_.characterEffect1036ui_story and not isNil(var_37_23) then
					local var_37_27 = Mathf.Lerp(0, 0.5, var_37_26)

					arg_34_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1036ui_story.fillRatio = var_37_27
				end
			end

			if arg_34_1.time_ >= var_37_24 + var_37_25 and arg_34_1.time_ < var_37_24 + var_37_25 + arg_37_0 and not isNil(var_37_23) and arg_34_1.var_.characterEffect1036ui_story then
				local var_37_28 = 0.5

				arg_34_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1036ui_story.fillRatio = var_37_28
			end

			local var_37_29 = 0

			if var_37_29 < arg_34_1.time_ and arg_34_1.time_ <= var_37_29 + arg_37_0 then
				arg_34_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_37_30 = 0

			if var_37_30 < arg_34_1.time_ and arg_34_1.time_ <= var_37_30 + arg_37_0 then
				arg_34_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_37_31 = 0
			local var_37_32 = 0.35

			if var_37_31 < arg_34_1.time_ and arg_34_1.time_ <= var_37_31 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_33 = arg_34_1:FormatText(StoryNameCfg[381].name)

				arg_34_1.leftNameTxt_.text = var_37_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_34 = arg_34_1:GetWordFromCfg(324162008)
				local var_37_35 = arg_34_1:FormatText(var_37_34.content)

				arg_34_1.text_.text = var_37_35

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_36 = 14
				local var_37_37 = utf8.len(var_37_35)
				local var_37_38 = var_37_36 <= 0 and var_37_32 or var_37_32 * (var_37_37 / var_37_36)

				if var_37_38 > 0 and var_37_32 < var_37_38 then
					arg_34_1.talkMaxDuration = var_37_38

					if var_37_38 + var_37_31 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_38 + var_37_31
					end
				end

				arg_34_1.text_.text = var_37_35
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324162", "324162008", "story_v_out_324162.awb") ~= 0 then
					local var_37_39 = manager.audio:GetVoiceLength("story_v_out_324162", "324162008", "story_v_out_324162.awb") / 1000

					if var_37_39 + var_37_31 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_39 + var_37_31
					end

					if var_37_34.prefab_name ~= "" and arg_34_1.actors_[var_37_34.prefab_name] ~= nil then
						local var_37_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_34.prefab_name].transform, "story_v_out_324162", "324162008", "story_v_out_324162.awb")

						arg_34_1:RecordAudio("324162008", var_37_40)
						arg_34_1:RecordAudio("324162008", var_37_40)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_324162", "324162008", "story_v_out_324162.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_324162", "324162008", "story_v_out_324162.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_41 = math.max(var_37_32, arg_34_1.talkMaxDuration)

			if var_37_31 <= arg_34_1.time_ and arg_34_1.time_ < var_37_31 + var_37_41 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_31) / var_37_41

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_31 + var_37_41 and arg_34_1.time_ < var_37_31 + var_37_41 + arg_37_0 then
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
	Play324162009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 324162009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play324162010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1036ui_story"].transform
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.var_.moveOldPos1036ui_story = var_41_0.localPosition
			end

			local var_41_2 = 0.001

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2
				local var_41_4 = Vector3.New(0, 100, 0)

				var_41_0.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1036ui_story, var_41_4, var_41_3)

				local var_41_5 = manager.ui.mainCamera.transform.position - var_41_0.position

				var_41_0.forward = Vector3.New(var_41_5.x, var_41_5.y, var_41_5.z)

				local var_41_6 = var_41_0.localEulerAngles

				var_41_6.z = 0
				var_41_6.x = 0
				var_41_0.localEulerAngles = var_41_6
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 then
				var_41_0.localPosition = Vector3.New(0, 100, 0)

				local var_41_7 = manager.ui.mainCamera.transform.position - var_41_0.position

				var_41_0.forward = Vector3.New(var_41_7.x, var_41_7.y, var_41_7.z)

				local var_41_8 = var_41_0.localEulerAngles

				var_41_8.z = 0
				var_41_8.x = 0
				var_41_0.localEulerAngles = var_41_8
			end

			local var_41_9 = arg_38_1.actors_["1075ui_story"].transform
			local var_41_10 = 0

			if var_41_10 < arg_38_1.time_ and arg_38_1.time_ <= var_41_10 + arg_41_0 then
				arg_38_1.var_.moveOldPos1075ui_story = var_41_9.localPosition
			end

			local var_41_11 = 0.001

			if var_41_10 <= arg_38_1.time_ and arg_38_1.time_ < var_41_10 + var_41_11 then
				local var_41_12 = (arg_38_1.time_ - var_41_10) / var_41_11
				local var_41_13 = Vector3.New(0, 100, 0)

				var_41_9.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1075ui_story, var_41_13, var_41_12)

				local var_41_14 = manager.ui.mainCamera.transform.position - var_41_9.position

				var_41_9.forward = Vector3.New(var_41_14.x, var_41_14.y, var_41_14.z)

				local var_41_15 = var_41_9.localEulerAngles

				var_41_15.z = 0
				var_41_15.x = 0
				var_41_9.localEulerAngles = var_41_15
			end

			if arg_38_1.time_ >= var_41_10 + var_41_11 and arg_38_1.time_ < var_41_10 + var_41_11 + arg_41_0 then
				var_41_9.localPosition = Vector3.New(0, 100, 0)

				local var_41_16 = manager.ui.mainCamera.transform.position - var_41_9.position

				var_41_9.forward = Vector3.New(var_41_16.x, var_41_16.y, var_41_16.z)

				local var_41_17 = var_41_9.localEulerAngles

				var_41_17.z = 0
				var_41_17.x = 0
				var_41_9.localEulerAngles = var_41_17
			end

			local var_41_18 = arg_38_1.actors_["1075ui_story"]
			local var_41_19 = 0

			if var_41_19 < arg_38_1.time_ and arg_38_1.time_ <= var_41_19 + arg_41_0 and not isNil(var_41_18) and arg_38_1.var_.characterEffect1075ui_story == nil then
				arg_38_1.var_.characterEffect1075ui_story = var_41_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_20 = 0.200000002980232

			if var_41_19 <= arg_38_1.time_ and arg_38_1.time_ < var_41_19 + var_41_20 and not isNil(var_41_18) then
				local var_41_21 = (arg_38_1.time_ - var_41_19) / var_41_20

				if arg_38_1.var_.characterEffect1075ui_story and not isNil(var_41_18) then
					local var_41_22 = Mathf.Lerp(0, 0.5, var_41_21)

					arg_38_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1075ui_story.fillRatio = var_41_22
				end
			end

			if arg_38_1.time_ >= var_41_19 + var_41_20 and arg_38_1.time_ < var_41_19 + var_41_20 + arg_41_0 and not isNil(var_41_18) and arg_38_1.var_.characterEffect1075ui_story then
				local var_41_23 = 0.5

				arg_38_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1075ui_story.fillRatio = var_41_23
			end

			local var_41_24 = 0
			local var_41_25 = 1.375

			if var_41_24 < arg_38_1.time_ and arg_38_1.time_ <= var_41_24 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_26 = arg_38_1:GetWordFromCfg(324162009)
				local var_41_27 = arg_38_1:FormatText(var_41_26.content)

				arg_38_1.text_.text = var_41_27

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_28 = 55
				local var_41_29 = utf8.len(var_41_27)
				local var_41_30 = var_41_28 <= 0 and var_41_25 or var_41_25 * (var_41_29 / var_41_28)

				if var_41_30 > 0 and var_41_25 < var_41_30 then
					arg_38_1.talkMaxDuration = var_41_30

					if var_41_30 + var_41_24 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_30 + var_41_24
					end
				end

				arg_38_1.text_.text = var_41_27
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_31 = math.max(var_41_25, arg_38_1.talkMaxDuration)

			if var_41_24 <= arg_38_1.time_ and arg_38_1.time_ < var_41_24 + var_41_31 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_24) / var_41_31

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_24 + var_41_31 and arg_38_1.time_ < var_41_24 + var_41_31 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
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

		arg_38_1:InitPlayNodeList()
	end,
	Play324162010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 324162010
		arg_42_1.duration_ = 10

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play324162011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = manager.ui.mainCamera.transform
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				local var_45_2 = arg_42_1.var_.effect3434
				local var_45_3
				local var_45_4 = var_45_0

				if not var_45_2 then
					var_45_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), var_45_4)
					var_45_2.name = "3434"
					arg_42_1.var_.effect3434 = var_45_2
				else
					var_45_2.transform:SetParent(var_45_4)
				end

				var_45_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_45_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_45_5 = manager.ui.mainCamera.transform
			local var_45_6 = 5

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				local var_45_7 = arg_42_1.var_.effect3434

				if var_45_7 then
					Object.Destroy(var_45_7)

					arg_42_1.var_.effect3434 = nil
				end
			end

			local var_45_8 = 3.60822483003176e-16

			if var_45_8 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			local var_45_9 = 1.83333333333333

			if arg_42_1.time_ >= var_45_8 + var_45_9 and arg_42_1.time_ < var_45_8 + var_45_9 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			local var_45_10 = 0.1
			local var_45_11 = 1

			if var_45_10 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 then
				local var_45_12 = "play"
				local var_45_13 = "effect"

				arg_42_1:AudioAction(var_45_12, var_45_13, "se_story_150", "se_story_150_space01", "")
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_14 = 1.36666666666667
			local var_45_15 = 0.9

			if var_45_14 < arg_42_1.time_ and arg_42_1.time_ <= var_45_14 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_16 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_16:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_17 = arg_42_1:GetWordFromCfg(324162010)
				local var_45_18 = arg_42_1:FormatText(var_45_17.content)

				arg_42_1.text_.text = var_45_18

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_19 = 36
				local var_45_20 = utf8.len(var_45_18)
				local var_45_21 = var_45_19 <= 0 and var_45_15 or var_45_15 * (var_45_20 / var_45_19)

				if var_45_21 > 0 and var_45_15 < var_45_21 then
					arg_42_1.talkMaxDuration = var_45_21
					var_45_14 = var_45_14 + 0.3

					if var_45_21 + var_45_14 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_21 + var_45_14
					end
				end

				arg_42_1.text_.text = var_45_18
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_22 = var_45_14 + 0.3
			local var_45_23 = math.max(var_45_15, arg_42_1.talkMaxDuration)

			if var_45_22 <= arg_42_1.time_ and arg_42_1.time_ < var_45_22 + var_45_23 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_22) / var_45_23

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_22 + var_45_23 and arg_42_1.time_ < var_45_22 + var_45_23 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play324162011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324162011
		arg_48_1.duration_ = 2.3

		local var_48_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_48_0:Play324162012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "1071ui_story"

			if arg_48_1.actors_[var_51_0] == nil then
				local var_51_1 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_51_1) then
					local var_51_2 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_48_1.stage_.transform)

					var_51_2.name = var_51_0
					var_51_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_48_1.actors_[var_51_0] = var_51_2

					local var_51_3 = var_51_2:GetComponentInChildren(typeof(CharacterEffect))

					var_51_3.enabled = true

					local var_51_4 = GameObjectTools.GetOrAddComponent(var_51_2, typeof(DynamicBoneHelper))

					if var_51_4 then
						var_51_4:EnableDynamicBone(false)
					end

					arg_48_1:ShowWeapon(var_51_3.transform, false)

					arg_48_1.var_[var_51_0 .. "Animator"] = var_51_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_48_1.var_[var_51_0 .. "Animator"].applyRootMotion = true
					arg_48_1.var_[var_51_0 .. "LipSync"] = var_51_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_51_5 = arg_48_1.actors_["1071ui_story"].transform
			local var_51_6 = 0

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.var_.moveOldPos1071ui_story = var_51_5.localPosition
			end

			local var_51_7 = 0.001

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_7 then
				local var_51_8 = (arg_48_1.time_ - var_51_6) / var_51_7
				local var_51_9 = Vector3.New(0, -1.05, -6.2)

				var_51_5.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1071ui_story, var_51_9, var_51_8)

				local var_51_10 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_10.x, var_51_10.y, var_51_10.z)

				local var_51_11 = var_51_5.localEulerAngles

				var_51_11.z = 0
				var_51_11.x = 0
				var_51_5.localEulerAngles = var_51_11
			end

			if arg_48_1.time_ >= var_51_6 + var_51_7 and arg_48_1.time_ < var_51_6 + var_51_7 + arg_51_0 then
				var_51_5.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_51_12 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_12.x, var_51_12.y, var_51_12.z)

				local var_51_13 = var_51_5.localEulerAngles

				var_51_13.z = 0
				var_51_13.x = 0
				var_51_5.localEulerAngles = var_51_13
			end

			local var_51_14 = arg_48_1.actors_["1071ui_story"]
			local var_51_15 = 0

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 and not isNil(var_51_14) and arg_48_1.var_.characterEffect1071ui_story == nil then
				arg_48_1.var_.characterEffect1071ui_story = var_51_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_16 = 0.200000002980232

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_16 and not isNil(var_51_14) then
				local var_51_17 = (arg_48_1.time_ - var_51_15) / var_51_16

				if arg_48_1.var_.characterEffect1071ui_story and not isNil(var_51_14) then
					arg_48_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_15 + var_51_16 and arg_48_1.time_ < var_51_15 + var_51_16 + arg_51_0 and not isNil(var_51_14) and arg_48_1.var_.characterEffect1071ui_story then
				arg_48_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_51_18 = 0

			if var_51_18 < arg_48_1.time_ and arg_48_1.time_ <= var_51_18 + arg_51_0 then
				arg_48_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_51_19 = 0

			if var_51_19 < arg_48_1.time_ and arg_48_1.time_ <= var_51_19 + arg_51_0 then
				arg_48_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_51_20 = 0
			local var_51_21 = 0.225

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_22 = arg_48_1:FormatText(StoryNameCfg[384].name)

				arg_48_1.leftNameTxt_.text = var_51_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_23 = arg_48_1:GetWordFromCfg(324162011)
				local var_51_24 = arg_48_1:FormatText(var_51_23.content)

				arg_48_1.text_.text = var_51_24

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_25 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_324162", "324162011", "story_v_out_324162.awb") ~= 0 then
					local var_51_28 = manager.audio:GetVoiceLength("story_v_out_324162", "324162011", "story_v_out_324162.awb") / 1000

					if var_51_28 + var_51_20 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_28 + var_51_20
					end

					if var_51_23.prefab_name ~= "" and arg_48_1.actors_[var_51_23.prefab_name] ~= nil then
						local var_51_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_23.prefab_name].transform, "story_v_out_324162", "324162011", "story_v_out_324162.awb")

						arg_48_1:RecordAudio("324162011", var_51_29)
						arg_48_1:RecordAudio("324162011", var_51_29)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324162", "324162011", "story_v_out_324162.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324162", "324162011", "story_v_out_324162.awb")
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
				actorName = "1071ui_story",
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
	Play324162012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324162012
		arg_52_1.duration_ = 6

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play324162013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1071ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1071ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1071ui_story, var_55_4, var_55_3)

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

			local var_55_9 = arg_52_1.actors_["1071ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1071ui_story == nil then
				arg_52_1.var_.characterEffect1071ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.200000002980232

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect1071ui_story and not isNil(var_55_9) then
					local var_55_13 = Mathf.Lerp(0, 0.5, var_55_12)

					arg_52_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1071ui_story.fillRatio = var_55_13
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1071ui_story then
				local var_55_14 = 0.5

				arg_52_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1071ui_story.fillRatio = var_55_14
			end

			local var_55_15 = 0.1
			local var_55_16 = 1

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				local var_55_17 = "play"
				local var_55_18 = "effect"

				arg_52_1:AudioAction(var_55_17, var_55_18, "se_story_150", "se_story_150_attack", "")
			end

			local var_55_19 = manager.ui.mainCamera.transform
			local var_55_20 = 0

			if var_55_20 < arg_52_1.time_ and arg_52_1.time_ <= var_55_20 + arg_55_0 then
				local var_55_21 = arg_52_1.var_.effect432424234
				local var_55_22
				local var_55_23 = var_55_19

				if not var_55_21 then
					var_55_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu3"), var_55_23)
					var_55_21.name = "4234"
					arg_52_1.var_.effect432424234 = var_55_21
				else
					var_55_21.transform:SetParent(var_55_23)
				end

				var_55_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_55_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_55_24 = manager.ui.mainCamera.transform
			local var_55_25 = 0.766666666666667

			if var_55_25 < arg_52_1.time_ and arg_52_1.time_ <= var_55_25 + arg_55_0 then
				local var_55_26 = arg_52_1.var_.effect432424234

				if var_55_26 then
					Object.Destroy(var_55_26)

					arg_52_1.var_.effect432424234 = nil
				end
			end

			local var_55_27 = 0.5

			if var_55_27 < arg_52_1.time_ and arg_52_1.time_ <= var_55_27 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_28 = 0.6

			if var_55_27 <= arg_52_1.time_ and arg_52_1.time_ < var_55_27 + var_55_28 then
				local var_55_29 = (arg_52_1.time_ - var_55_27) / var_55_28
				local var_55_30 = Color.New(1, 1, 1)

				var_55_30.a = Mathf.Lerp(1, 0, var_55_29)
				arg_52_1.mask_.color = var_55_30
			end

			if arg_52_1.time_ >= var_55_27 + var_55_28 and arg_52_1.time_ < var_55_27 + var_55_28 + arg_55_0 then
				local var_55_31 = Color.New(1, 1, 1)
				local var_55_32 = 0

				arg_52_1.mask_.enabled = false
				var_55_31.a = var_55_32
				arg_52_1.mask_.color = var_55_31
			end

			local var_55_33 = 0

			if var_55_33 < arg_52_1.time_ and arg_52_1.time_ <= var_55_33 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			local var_55_34 = 1.36666666666667

			if arg_52_1.time_ >= var_55_33 + var_55_34 and arg_52_1.time_ < var_55_33 + var_55_34 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_35 = 1
			local var_55_36 = 1.6

			if var_55_35 < arg_52_1.time_ and arg_52_1.time_ <= var_55_35 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_37 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_37:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_38 = arg_52_1:GetWordFromCfg(324162012)
				local var_55_39 = arg_52_1:FormatText(var_55_38.content)

				arg_52_1.text_.text = var_55_39

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_40 = 64
				local var_55_41 = utf8.len(var_55_39)
				local var_55_42 = var_55_40 <= 0 and var_55_36 or var_55_36 * (var_55_41 / var_55_40)

				if var_55_42 > 0 and var_55_36 < var_55_42 then
					arg_52_1.talkMaxDuration = var_55_42
					var_55_35 = var_55_35 + 0.3

					if var_55_42 + var_55_35 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_42 + var_55_35
					end
				end

				arg_52_1.text_.text = var_55_39
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_43 = var_55_35 + 0.3
			local var_55_44 = math.max(var_55_36, arg_52_1.talkMaxDuration)

			if var_55_43 <= arg_52_1.time_ and arg_52_1.time_ < var_55_43 + var_55_44 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_43) / var_55_44

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_43 + var_55_44 and arg_52_1.time_ < var_55_43 + var_55_44 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play324162013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324162013
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play324162014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 1.05

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_2 = arg_58_1:GetWordFromCfg(324162013)
				local var_61_3 = arg_58_1:FormatText(var_61_2.content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 42
				local var_61_5 = utf8.len(var_61_3)
				local var_61_6 = var_61_4 <= 0 and var_61_1 or var_61_1 * (var_61_5 / var_61_4)

				if var_61_6 > 0 and var_61_1 < var_61_6 then
					arg_58_1.talkMaxDuration = var_61_6

					if var_61_6 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_7 and arg_58_1.time_ < var_61_0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play324162014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324162014
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
			arg_62_1.auto_ = false
		end

		function arg_62_1.playNext_(arg_64_0)
			arg_62_1.onStoryFinished_()
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.1
			local var_65_1 = 1

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				local var_65_2 = "play"
				local var_65_3 = "effect"

				arg_62_1:AudioAction(var_65_2, var_65_3, "se_story_150", "se_story_150_space02", "")
			end

			local var_65_4 = 0
			local var_65_5 = 1.025

			if var_65_4 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_6 = arg_62_1:GetWordFromCfg(324162014)
				local var_65_7 = arg_62_1:FormatText(var_65_6.content)

				arg_62_1.text_.text = var_65_7

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_8 = 41
				local var_65_9 = utf8.len(var_65_7)
				local var_65_10 = var_65_8 <= 0 and var_65_5 or var_65_5 * (var_65_9 / var_65_8)

				if var_65_10 > 0 and var_65_5 < var_65_10 then
					arg_62_1.talkMaxDuration = var_65_10

					if var_65_10 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_4
					end
				end

				arg_62_1.text_.text = var_65_7
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_11 = math.max(var_65_5, arg_62_1.talkMaxDuration)

			if var_65_4 <= arg_62_1.time_ and arg_62_1.time_ < var_65_4 + var_65_11 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_4) / var_65_11

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_4 + var_65_11 and arg_62_1.time_ < var_65_4 + var_65_11 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J27i"
	},
	voices = {
		"story_v_out_324162.awb"
	}
}
