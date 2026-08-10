return {
	Play325601001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325601001
		arg_1_1.duration_ = 8.1

		local var_1_0 = {
			zh = 5.6,
			ja = 8.1
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
				arg_1_0:Play325601002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J26h"

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
				local var_4_5 = arg_1_1.bgs_.J26h

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
					if iter_4_0 ~= "J26h" then
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

			local var_4_24 = "1170ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1170ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1170ui_story"].transform
			local var_4_30 = 1.81367490021512

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1170ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0.03, -0.95, -6.08)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1170ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0.03, -0.95, -6.08)

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

			local var_4_40 = arg_1_1.actors_["1170ui_story"]
			local var_4_41 = 1.81367490021512

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect1170ui_story == nil then
				arg_1_1.var_.characterEffect1170ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect1170ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect1170ui_story then
				arg_1_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_4_44 = 1.81367490021512

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action6_1")
			end

			local var_4_45 = 1.81367490021512

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoB", "EmotionTimelineAnimator")
			end

			local var_4_46 = 0.1
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "effect"

				arg_1_1:AudioAction(var_4_48, var_4_49, "se_story_148", "se_story_148_amb_wind", "")
			end

			local var_4_50 = 0
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_56 = 2
			local var_4_57 = 0.525

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

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[318].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(325601001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601001", "story_v_out_325601.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_325601", "325601001", "story_v_out_325601.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_325601", "325601001", "story_v_out_325601.awb")

						arg_1_1:RecordAudio("325601001", var_4_66)
						arg_1_1:RecordAudio("325601001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325601", "325601001", "story_v_out_325601.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325601", "325601001", "story_v_out_325601.awb")
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
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.81367490021512,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325601002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325601002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325601003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1170ui_story"].transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.moveOldPos1170ui_story = var_11_0.localPosition

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end
			end

			local var_11_3 = 0.001

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_3 then
				local var_11_4 = (arg_8_1.time_ - var_11_1) / var_11_3
				local var_11_5 = Vector3.New(0, 100, 0)

				var_11_0.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1170ui_story, var_11_5, var_11_4)

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

			local var_11_11 = arg_8_1.actors_["1170ui_story"]
			local var_11_12 = 0

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect1170ui_story == nil then
				arg_8_1.var_.characterEffect1170ui_story = var_11_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_13 = 0.200000002980232

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_13 and not isNil(var_11_11) then
				local var_11_14 = (arg_8_1.time_ - var_11_12) / var_11_13

				if arg_8_1.var_.characterEffect1170ui_story and not isNil(var_11_11) then
					local var_11_15 = Mathf.Lerp(0, 0.5, var_11_14)

					arg_8_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1170ui_story.fillRatio = var_11_15
				end
			end

			if arg_8_1.time_ >= var_11_12 + var_11_13 and arg_8_1.time_ < var_11_12 + var_11_13 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect1170ui_story then
				local var_11_16 = 0.5

				arg_8_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1170ui_story.fillRatio = var_11_16
			end

			local var_11_17 = 0
			local var_11_18 = 1.225

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

				local var_11_19 = arg_8_1:GetWordFromCfg(325601002)
				local var_11_20 = arg_8_1:FormatText(var_11_19.content)

				arg_8_1.text_.text = var_11_20

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_21 = 49
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
				actorName = "1170ui_story",
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
	Play325601003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325601003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325601004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.35

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(325601003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 54
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325601004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325601004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325601005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.7

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[7].name)

				arg_16_1.leftNameTxt_.text = var_19_2

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

				local var_19_3 = arg_16_1:GetWordFromCfg(325601004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 28
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_8 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_8 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_8

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_8 and arg_16_1.time_ < var_19_0 + var_19_8 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play325601005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325601005
		arg_20_1.duration_ = 4.37

		local var_20_0 = {
			zh = 2.466,
			ja = 4.366
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
				arg_20_0:Play325601006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1170ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1170ui_story = var_23_0.localPosition

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end
			end

			local var_23_3 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_3 then
				local var_23_4 = (arg_20_1.time_ - var_23_1) / var_23_3
				local var_23_5 = Vector3.New(0.03, -0.95, -6.08)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1170ui_story, var_23_5, var_23_4)

				local var_23_6 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_6.x, var_23_6.y, var_23_6.z)

				local var_23_7 = var_23_0.localEulerAngles

				var_23_7.z = 0
				var_23_7.x = 0
				var_23_0.localEulerAngles = var_23_7
			end

			if arg_20_1.time_ >= var_23_1 + var_23_3 and arg_20_1.time_ < var_23_1 + var_23_3 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0.03, -0.95, -6.08)

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

			local var_23_11 = arg_20_1.actors_["1170ui_story"]
			local var_23_12 = 0

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect1170ui_story == nil then
				arg_20_1.var_.characterEffect1170ui_story = var_23_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_13 = 0.200000002980232

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_13 and not isNil(var_23_11) then
				local var_23_14 = (arg_20_1.time_ - var_23_12) / var_23_13

				if arg_20_1.var_.characterEffect1170ui_story and not isNil(var_23_11) then
					arg_20_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_12 + var_23_13 and arg_20_1.time_ < var_23_12 + var_23_13 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect1170ui_story then
				arg_20_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_23_15 = 0
			local var_23_16 = 0.3

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_17 = arg_20_1:FormatText(StoryNameCfg[318].name)

				arg_20_1.leftNameTxt_.text = var_23_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_18 = arg_20_1:GetWordFromCfg(325601005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_20 = 12
				local var_23_21 = utf8.len(var_23_19)
				local var_23_22 = var_23_20 <= 0 and var_23_16 or var_23_16 * (var_23_21 / var_23_20)

				if var_23_22 > 0 and var_23_16 < var_23_22 then
					arg_20_1.talkMaxDuration = var_23_22

					if var_23_22 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_15
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601005", "story_v_out_325601.awb") ~= 0 then
					local var_23_23 = manager.audio:GetVoiceLength("story_v_out_325601", "325601005", "story_v_out_325601.awb") / 1000

					if var_23_23 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_15
					end

					if var_23_18.prefab_name ~= "" and arg_20_1.actors_[var_23_18.prefab_name] ~= nil then
						local var_23_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_18.prefab_name].transform, "story_v_out_325601", "325601005", "story_v_out_325601.awb")

						arg_20_1:RecordAudio("325601005", var_23_24)
						arg_20_1:RecordAudio("325601005", var_23_24)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325601", "325601005", "story_v_out_325601.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325601", "325601005", "story_v_out_325601.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_25 = math.max(var_23_16, arg_20_1.talkMaxDuration)

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_25 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_15) / var_23_25

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_15 + var_23_25 and arg_20_1.time_ < var_23_15 + var_23_25 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
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
	Play325601006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325601006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325601007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1170ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1170ui_story == nil then
				arg_24_1.var_.characterEffect1170ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1170ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1170ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1170ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1170ui_story.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 0.4

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[7].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_9 = arg_24_1:GetWordFromCfg(325601006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 16
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
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_14 and arg_24_1.time_ < var_27_6 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325601007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325601007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325601008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.825

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(325601007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 33
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
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_8 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_8 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_8

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_8 and arg_28_1.time_ < var_31_0 + var_31_8 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325601008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325601008
		arg_32_1.duration_ = 9.67

		local var_32_0 = {
			zh = 6.433,
			ja = 9.666
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
				arg_32_0:Play325601009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1170ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1170ui_story == nil then
				arg_32_1.var_.characterEffect1170ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1170ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1170ui_story then
				arg_32_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_35_4 = 0

			if var_35_4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170actionlink/1170action465")
			end

			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_35_6 = 0
			local var_35_7 = 0.7

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_8 = arg_32_1:FormatText(StoryNameCfg[318].name)

				arg_32_1.leftNameTxt_.text = var_35_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_9 = arg_32_1:GetWordFromCfg(325601008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 28
				local var_35_12 = utf8.len(var_35_10)
				local var_35_13 = var_35_11 <= 0 and var_35_7 or var_35_7 * (var_35_12 / var_35_11)

				if var_35_13 > 0 and var_35_7 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601008", "story_v_out_325601.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_out_325601", "325601008", "story_v_out_325601.awb") / 1000

					if var_35_14 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_6
					end

					if var_35_9.prefab_name ~= "" and arg_32_1.actors_[var_35_9.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_9.prefab_name].transform, "story_v_out_325601", "325601008", "story_v_out_325601.awb")

						arg_32_1:RecordAudio("325601008", var_35_15)
						arg_32_1:RecordAudio("325601008", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325601", "325601008", "story_v_out_325601.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325601", "325601008", "story_v_out_325601.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_16 and arg_32_1.time_ < var_35_6 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325601009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325601009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325601010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1170ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1170ui_story == nil then
				arg_36_1.var_.characterEffect1170ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1170ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1170ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1170ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1170ui_story.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 0.875

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[7].name)

				arg_36_1.leftNameTxt_.text = var_39_8

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

				local var_39_9 = arg_36_1:GetWordFromCfg(325601009)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 35
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
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play325601010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325601010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325601011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.55

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_2

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

				local var_43_3 = arg_40_1:GetWordFromCfg(325601010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 22
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
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325601011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325601011
		arg_44_1.duration_ = 2

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325601012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "10170ui_story"

			if arg_44_1.actors_[var_47_0] == nil then
				local var_47_1 = Asset.Load("Char/" .. "10170ui_story")

				if not isNil(var_47_1) then
					local var_47_2 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_44_1.stage_.transform)

					var_47_2.name = var_47_0
					var_47_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_44_1.actors_[var_47_0] = var_47_2

					local var_47_3 = var_47_2:GetComponentInChildren(typeof(CharacterEffect))

					var_47_3.enabled = true

					local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_2, typeof(DynamicBoneHelper))

					if var_47_4 then
						var_47_4:EnableDynamicBone(false)
					end

					arg_44_1:ShowWeapon(var_47_3.transform, false)

					arg_44_1.var_[var_47_0 .. "Animator"] = var_47_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_44_1.var_[var_47_0 .. "Animator"].applyRootMotion = true
					arg_44_1.var_[var_47_0 .. "LipSync"] = var_47_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_47_5 = arg_44_1.actors_["10170ui_story"].transform
			local var_47_6 = 0

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.var_.moveOldPos10170ui_story = var_47_5.localPosition

				local var_47_7 = GameObjectTools.GetOrAddComponent(var_47_5.gameObject, typeof(DynamicBoneHelper))

				if var_47_7 then
					var_47_7:EnableDynamicBone(false)
				end
			end

			local var_47_8 = 0.001

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_8 then
				local var_47_9 = (arg_44_1.time_ - var_47_6) / var_47_8
				local var_47_10 = Vector3.New(0, -1.03, -6.05)

				var_47_5.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10170ui_story, var_47_10, var_47_9)

				local var_47_11 = manager.ui.mainCamera.transform.position - var_47_5.position

				var_47_5.forward = Vector3.New(var_47_11.x, var_47_11.y, var_47_11.z)

				local var_47_12 = var_47_5.localEulerAngles

				var_47_12.z = 0
				var_47_12.x = 0
				var_47_5.localEulerAngles = var_47_12
			end

			if arg_44_1.time_ >= var_47_6 + var_47_8 and arg_44_1.time_ < var_47_6 + var_47_8 + arg_47_0 then
				var_47_5.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_47_13 = manager.ui.mainCamera.transform.position - var_47_5.position

				var_47_5.forward = Vector3.New(var_47_13.x, var_47_13.y, var_47_13.z)

				local var_47_14 = var_47_5.localEulerAngles

				var_47_14.z = 0
				var_47_14.x = 0
				var_47_5.localEulerAngles = var_47_14

				local var_47_15 = GameObjectTools.GetOrAddComponent(var_47_5.gameObject, typeof(DynamicBoneHelper))

				if var_47_15 then
					var_47_15:EnableDynamicBone(true)
				end
			end

			local var_47_16 = arg_44_1.actors_["1170ui_story"].transform
			local var_47_17 = 0

			if var_47_17 < arg_44_1.time_ and arg_44_1.time_ <= var_47_17 + arg_47_0 then
				arg_44_1.var_.moveOldPos1170ui_story = var_47_16.localPosition

				local var_47_18 = GameObjectTools.GetOrAddComponent(var_47_16.gameObject, typeof(DynamicBoneHelper))

				if var_47_18 then
					var_47_18:EnableDynamicBone(false)
				end
			end

			local var_47_19 = 0.001

			if var_47_17 <= arg_44_1.time_ and arg_44_1.time_ < var_47_17 + var_47_19 then
				local var_47_20 = (arg_44_1.time_ - var_47_17) / var_47_19
				local var_47_21 = Vector3.New(0, 100, 0)

				var_47_16.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1170ui_story, var_47_21, var_47_20)

				local var_47_22 = manager.ui.mainCamera.transform.position - var_47_16.position

				var_47_16.forward = Vector3.New(var_47_22.x, var_47_22.y, var_47_22.z)

				local var_47_23 = var_47_16.localEulerAngles

				var_47_23.z = 0
				var_47_23.x = 0
				var_47_16.localEulerAngles = var_47_23
			end

			if arg_44_1.time_ >= var_47_17 + var_47_19 and arg_44_1.time_ < var_47_17 + var_47_19 + arg_47_0 then
				var_47_16.localPosition = Vector3.New(0, 100, 0)

				local var_47_24 = manager.ui.mainCamera.transform.position - var_47_16.position

				var_47_16.forward = Vector3.New(var_47_24.x, var_47_24.y, var_47_24.z)

				local var_47_25 = var_47_16.localEulerAngles

				var_47_25.z = 0
				var_47_25.x = 0
				var_47_16.localEulerAngles = var_47_25

				local var_47_26 = GameObjectTools.GetOrAddComponent(var_47_16.gameObject, typeof(DynamicBoneHelper))

				if var_47_26 then
					var_47_26:EnableDynamicBone(true)
				end
			end

			local var_47_27 = arg_44_1.actors_["10170ui_story"]
			local var_47_28 = 0

			if var_47_28 < arg_44_1.time_ and arg_44_1.time_ <= var_47_28 + arg_47_0 and not isNil(var_47_27) and arg_44_1.var_.characterEffect10170ui_story == nil then
				arg_44_1.var_.characterEffect10170ui_story = var_47_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_29 = 0.200000002980232

			if var_47_28 <= arg_44_1.time_ and arg_44_1.time_ < var_47_28 + var_47_29 and not isNil(var_47_27) then
				local var_47_30 = (arg_44_1.time_ - var_47_28) / var_47_29

				if arg_44_1.var_.characterEffect10170ui_story and not isNil(var_47_27) then
					arg_44_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_28 + var_47_29 and arg_44_1.time_ < var_47_28 + var_47_29 + arg_47_0 and not isNil(var_47_27) and arg_44_1.var_.characterEffect10170ui_story then
				arg_44_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_47_31 = 0

			if var_47_31 < arg_44_1.time_ and arg_44_1.time_ <= var_47_31 + arg_47_0 then
				arg_44_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_47_32 = 0

			if var_47_32 < arg_44_1.time_ and arg_44_1.time_ <= var_47_32 + arg_47_0 then
				arg_44_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_47_33 = 0
			local var_47_34 = 0.075

			if var_47_33 < arg_44_1.time_ and arg_44_1.time_ <= var_47_33 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_35 = arg_44_1:FormatText(StoryNameCfg[1450].name)

				arg_44_1.leftNameTxt_.text = var_47_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_36 = arg_44_1:GetWordFromCfg(325601011)
				local var_47_37 = arg_44_1:FormatText(var_47_36.content)

				arg_44_1.text_.text = var_47_37

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_38 = 3
				local var_47_39 = utf8.len(var_47_37)
				local var_47_40 = var_47_38 <= 0 and var_47_34 or var_47_34 * (var_47_39 / var_47_38)

				if var_47_40 > 0 and var_47_34 < var_47_40 then
					arg_44_1.talkMaxDuration = var_47_40

					if var_47_40 + var_47_33 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_40 + var_47_33
					end
				end

				arg_44_1.text_.text = var_47_37
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601011", "story_v_out_325601.awb") ~= 0 then
					local var_47_41 = manager.audio:GetVoiceLength("story_v_out_325601", "325601011", "story_v_out_325601.awb") / 1000

					if var_47_41 + var_47_33 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_41 + var_47_33
					end

					if var_47_36.prefab_name ~= "" and arg_44_1.actors_[var_47_36.prefab_name] ~= nil then
						local var_47_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_36.prefab_name].transform, "story_v_out_325601", "325601011", "story_v_out_325601.awb")

						arg_44_1:RecordAudio("325601011", var_47_42)
						arg_44_1:RecordAudio("325601011", var_47_42)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325601", "325601011", "story_v_out_325601.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325601", "325601011", "story_v_out_325601.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_43 = math.max(var_47_34, arg_44_1.talkMaxDuration)

			if var_47_33 <= arg_44_1.time_ and arg_44_1.time_ < var_47_33 + var_47_43 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_33) / var_47_43

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_33 + var_47_43 and arg_44_1.time_ < var_47_33 + var_47_43 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
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
	Play325601012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325601012
		arg_48_1.duration_ = 3.3

		local var_48_0 = {
			zh = 3.3,
			ja = 1.999999999999
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
				arg_48_0:Play325601013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10170ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos10170ui_story = var_51_0.localPosition

				local var_51_2 = GameObjectTools.GetOrAddComponent(var_51_0.gameObject, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(false)
				end
			end

			local var_51_3 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_3 then
				local var_51_4 = (arg_48_1.time_ - var_51_1) / var_51_3
				local var_51_5 = Vector3.New(0, 100, 0)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10170ui_story, var_51_5, var_51_4)

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

			local var_51_11 = arg_48_1.actors_["1170ui_story"].transform
			local var_51_12 = 0

			if var_51_12 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 then
				arg_48_1.var_.moveOldPos1170ui_story = var_51_11.localPosition

				local var_51_13 = GameObjectTools.GetOrAddComponent(var_51_11.gameObject, typeof(DynamicBoneHelper))

				if var_51_13 then
					var_51_13:EnableDynamicBone(false)
				end
			end

			local var_51_14 = 0.001

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_14 then
				local var_51_15 = (arg_48_1.time_ - var_51_12) / var_51_14
				local var_51_16 = Vector3.New(0.03, -0.95, -6.08)

				var_51_11.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1170ui_story, var_51_16, var_51_15)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_11.position

				var_51_11.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_11.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_11.localEulerAngles = var_51_18
			end

			if arg_48_1.time_ >= var_51_12 + var_51_14 and arg_48_1.time_ < var_51_12 + var_51_14 + arg_51_0 then
				var_51_11.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_51_19 = manager.ui.mainCamera.transform.position - var_51_11.position

				var_51_11.forward = Vector3.New(var_51_19.x, var_51_19.y, var_51_19.z)

				local var_51_20 = var_51_11.localEulerAngles

				var_51_20.z = 0
				var_51_20.x = 0
				var_51_11.localEulerAngles = var_51_20

				local var_51_21 = GameObjectTools.GetOrAddComponent(var_51_11.gameObject, typeof(DynamicBoneHelper))

				if var_51_21 then
					var_51_21:EnableDynamicBone(true)
				end
			end

			local var_51_22 = arg_48_1.actors_["1170ui_story"]
			local var_51_23 = 0

			if var_51_23 < arg_48_1.time_ and arg_48_1.time_ <= var_51_23 + arg_51_0 and not isNil(var_51_22) and arg_48_1.var_.characterEffect1170ui_story == nil then
				arg_48_1.var_.characterEffect1170ui_story = var_51_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_24 = 0.200000002980232

			if var_51_23 <= arg_48_1.time_ and arg_48_1.time_ < var_51_23 + var_51_24 and not isNil(var_51_22) then
				local var_51_25 = (arg_48_1.time_ - var_51_23) / var_51_24

				if arg_48_1.var_.characterEffect1170ui_story and not isNil(var_51_22) then
					arg_48_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_23 + var_51_24 and arg_48_1.time_ < var_51_23 + var_51_24 + arg_51_0 and not isNil(var_51_22) and arg_48_1.var_.characterEffect1170ui_story then
				arg_48_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_51_26 = arg_48_1.actors_["10170ui_story"]
			local var_51_27 = 0

			if var_51_27 < arg_48_1.time_ and arg_48_1.time_ <= var_51_27 + arg_51_0 and not isNil(var_51_26) and arg_48_1.var_.characterEffect10170ui_story == nil then
				arg_48_1.var_.characterEffect10170ui_story = var_51_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_28 = 0.200000002980232

			if var_51_27 <= arg_48_1.time_ and arg_48_1.time_ < var_51_27 + var_51_28 and not isNil(var_51_26) then
				local var_51_29 = (arg_48_1.time_ - var_51_27) / var_51_28

				if arg_48_1.var_.characterEffect10170ui_story and not isNil(var_51_26) then
					local var_51_30 = Mathf.Lerp(0, 0.5, var_51_29)

					arg_48_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10170ui_story.fillRatio = var_51_30
				end
			end

			if arg_48_1.time_ >= var_51_27 + var_51_28 and arg_48_1.time_ < var_51_27 + var_51_28 + arg_51_0 and not isNil(var_51_26) and arg_48_1.var_.characterEffect10170ui_story then
				local var_51_31 = 0.5

				arg_48_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10170ui_story.fillRatio = var_51_31
			end

			local var_51_32 = 0

			if var_51_32 < arg_48_1.time_ and arg_48_1.time_ <= var_51_32 + arg_51_0 then
				arg_48_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action5_2")
			end

			local var_51_33 = 0

			if var_51_33 < arg_48_1.time_ and arg_48_1.time_ <= var_51_33 + arg_51_0 then
				arg_48_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaB", "EmotionTimelineAnimator")
			end

			local var_51_34 = 0
			local var_51_35 = 0.2

			if var_51_34 < arg_48_1.time_ and arg_48_1.time_ <= var_51_34 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_36 = arg_48_1:FormatText(StoryNameCfg[318].name)

				arg_48_1.leftNameTxt_.text = var_51_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_37 = arg_48_1:GetWordFromCfg(325601012)
				local var_51_38 = arg_48_1:FormatText(var_51_37.content)

				arg_48_1.text_.text = var_51_38

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_39 = 8
				local var_51_40 = utf8.len(var_51_38)
				local var_51_41 = var_51_39 <= 0 and var_51_35 or var_51_35 * (var_51_40 / var_51_39)

				if var_51_41 > 0 and var_51_35 < var_51_41 then
					arg_48_1.talkMaxDuration = var_51_41

					if var_51_41 + var_51_34 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_41 + var_51_34
					end
				end

				arg_48_1.text_.text = var_51_38
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601012", "story_v_out_325601.awb") ~= 0 then
					local var_51_42 = manager.audio:GetVoiceLength("story_v_out_325601", "325601012", "story_v_out_325601.awb") / 1000

					if var_51_42 + var_51_34 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_42 + var_51_34
					end

					if var_51_37.prefab_name ~= "" and arg_48_1.actors_[var_51_37.prefab_name] ~= nil then
						local var_51_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_37.prefab_name].transform, "story_v_out_325601", "325601012", "story_v_out_325601.awb")

						arg_48_1:RecordAudio("325601012", var_51_43)
						arg_48_1:RecordAudio("325601012", var_51_43)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325601", "325601012", "story_v_out_325601.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325601", "325601012", "story_v_out_325601.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_44 = math.max(var_51_35, arg_48_1.talkMaxDuration)

			if var_51_34 <= arg_48_1.time_ and arg_48_1.time_ < var_51_34 + var_51_44 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_34) / var_51_44

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_34 + var_51_44 and arg_48_1.time_ < var_51_34 + var_51_44 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
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
	Play325601013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325601013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325601014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1170ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1170ui_story == nil then
				arg_52_1.var_.characterEffect1170ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1170ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1170ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1170ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1170ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 0.65

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_8

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

				local var_55_9 = arg_52_1:GetWordFromCfg(325601013)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 26
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
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_14 and arg_52_1.time_ < var_55_6 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325601014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325601014
		arg_56_1.duration_ = 7.1

		local var_56_0 = {
			zh = 5.5,
			ja = 7.1
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
				arg_56_0:Play325601015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1170ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1170ui_story == nil then
				arg_56_1.var_.characterEffect1170ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1170ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1170ui_story then
				arg_56_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_59_4 = 0

			if var_59_4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action2_1")
			end

			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_59_6 = 0
			local var_59_7 = 0.575

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[318].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_9 = arg_56_1:GetWordFromCfg(325601014)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601014", "story_v_out_325601.awb") ~= 0 then
					local var_59_14 = manager.audio:GetVoiceLength("story_v_out_325601", "325601014", "story_v_out_325601.awb") / 1000

					if var_59_14 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_6
					end

					if var_59_9.prefab_name ~= "" and arg_56_1.actors_[var_59_9.prefab_name] ~= nil then
						local var_59_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_9.prefab_name].transform, "story_v_out_325601", "325601014", "story_v_out_325601.awb")

						arg_56_1:RecordAudio("325601014", var_59_15)
						arg_56_1:RecordAudio("325601014", var_59_15)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325601", "325601014", "story_v_out_325601.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325601", "325601014", "story_v_out_325601.awb")
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
	Play325601015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325601015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play325601016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1170ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1170ui_story == nil then
				arg_60_1.var_.characterEffect1170ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1170ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1170ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1170ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1170ui_story.fillRatio = var_63_5
			end

			local var_63_6 = "1071ui_story"

			if arg_60_1.actors_[var_63_6] == nil then
				local var_63_7 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_63_7) then
					local var_63_8 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_60_1.stage_.transform)

					var_63_8.name = var_63_6
					var_63_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_60_1.actors_[var_63_6] = var_63_8

					local var_63_9 = var_63_8:GetComponentInChildren(typeof(CharacterEffect))

					var_63_9.enabled = true

					local var_63_10 = GameObjectTools.GetOrAddComponent(var_63_8, typeof(DynamicBoneHelper))

					if var_63_10 then
						var_63_10:EnableDynamicBone(false)
					end

					arg_60_1:ShowWeapon(var_63_9.transform, false)

					arg_60_1.var_[var_63_6 .. "Animator"] = var_63_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_60_1.var_[var_63_6 .. "Animator"].applyRootMotion = true
					arg_60_1.var_[var_63_6 .. "LipSync"] = var_63_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_63_12 = 0
			local var_63_13 = 0.8

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_14 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_14

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

				local var_63_15 = arg_60_1:GetWordFromCfg(325601015)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 32
				local var_63_18 = utf8.len(var_63_16)
				local var_63_19 = var_63_17 <= 0 and var_63_13 or var_63_13 * (var_63_18 / var_63_17)

				if var_63_19 > 0 and var_63_13 < var_63_19 then
					arg_60_1.talkMaxDuration = var_63_19

					if var_63_19 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_12
					end
				end

				arg_60_1.text_.text = var_63_16
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_20 = math.max(var_63_13, arg_60_1.talkMaxDuration)

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_20 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_12) / var_63_20

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_12 + var_63_20 and arg_60_1.time_ < var_63_12 + var_63_20 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play325601016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325601016
		arg_64_1.duration_ = 4.3

		local var_64_0 = {
			zh = 3.366,
			ja = 4.3
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
				arg_64_0:Play325601017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1071ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1071ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, -1.05, -6.2)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1071ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1170ui_story"].transform
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.var_.moveOldPos1170ui_story = var_67_9.localPosition

				local var_67_11 = GameObjectTools.GetOrAddComponent(var_67_9.gameObject, typeof(DynamicBoneHelper))

				if var_67_11 then
					var_67_11:EnableDynamicBone(false)
				end
			end

			local var_67_12 = 0.001

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_10) / var_67_12
				local var_67_14 = Vector3.New(0, 100, 0)

				var_67_9.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1170ui_story, var_67_14, var_67_13)

				local var_67_15 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_15.x, var_67_15.y, var_67_15.z)

				local var_67_16 = var_67_9.localEulerAngles

				var_67_16.z = 0
				var_67_16.x = 0
				var_67_9.localEulerAngles = var_67_16
			end

			if arg_64_1.time_ >= var_67_10 + var_67_12 and arg_64_1.time_ < var_67_10 + var_67_12 + arg_67_0 then
				var_67_9.localPosition = Vector3.New(0, 100, 0)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_9.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_9.localEulerAngles = var_67_18

				local var_67_19 = GameObjectTools.GetOrAddComponent(var_67_9.gameObject, typeof(DynamicBoneHelper))

				if var_67_19 then
					var_67_19:EnableDynamicBone(true)
				end
			end

			local var_67_20 = arg_64_1.actors_["1071ui_story"]
			local var_67_21 = 0

			if var_67_21 < arg_64_1.time_ and arg_64_1.time_ <= var_67_21 + arg_67_0 and not isNil(var_67_20) and arg_64_1.var_.characterEffect1071ui_story == nil then
				arg_64_1.var_.characterEffect1071ui_story = var_67_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_22 = 0.200000002980232

			if var_67_21 <= arg_64_1.time_ and arg_64_1.time_ < var_67_21 + var_67_22 and not isNil(var_67_20) then
				local var_67_23 = (arg_64_1.time_ - var_67_21) / var_67_22

				if arg_64_1.var_.characterEffect1071ui_story and not isNil(var_67_20) then
					arg_64_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_21 + var_67_22 and arg_64_1.time_ < var_67_21 + var_67_22 + arg_67_0 and not isNil(var_67_20) and arg_64_1.var_.characterEffect1071ui_story then
				arg_64_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_67_24 = 0

			if var_67_24 < arg_64_1.time_ and arg_64_1.time_ <= var_67_24 + arg_67_0 then
				arg_64_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_67_25 = 0
			local var_67_26 = 0.45

			if var_67_25 < arg_64_1.time_ and arg_64_1.time_ <= var_67_25 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_27 = arg_64_1:FormatText(StoryNameCfg[384].name)

				arg_64_1.leftNameTxt_.text = var_67_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_28 = arg_64_1:GetWordFromCfg(325601016)
				local var_67_29 = arg_64_1:FormatText(var_67_28.content)

				arg_64_1.text_.text = var_67_29

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_30 = 18
				local var_67_31 = utf8.len(var_67_29)
				local var_67_32 = var_67_30 <= 0 and var_67_26 or var_67_26 * (var_67_31 / var_67_30)

				if var_67_32 > 0 and var_67_26 < var_67_32 then
					arg_64_1.talkMaxDuration = var_67_32

					if var_67_32 + var_67_25 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_32 + var_67_25
					end
				end

				arg_64_1.text_.text = var_67_29
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601016", "story_v_out_325601.awb") ~= 0 then
					local var_67_33 = manager.audio:GetVoiceLength("story_v_out_325601", "325601016", "story_v_out_325601.awb") / 1000

					if var_67_33 + var_67_25 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_33 + var_67_25
					end

					if var_67_28.prefab_name ~= "" and arg_64_1.actors_[var_67_28.prefab_name] ~= nil then
						local var_67_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_28.prefab_name].transform, "story_v_out_325601", "325601016", "story_v_out_325601.awb")

						arg_64_1:RecordAudio("325601016", var_67_34)
						arg_64_1:RecordAudio("325601016", var_67_34)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325601", "325601016", "story_v_out_325601.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325601", "325601016", "story_v_out_325601.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_35 = math.max(var_67_26, arg_64_1.talkMaxDuration)

			if var_67_25 <= arg_64_1.time_ and arg_64_1.time_ < var_67_25 + var_67_35 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_25) / var_67_35

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_25 + var_67_35 and arg_64_1.time_ < var_67_25 + var_67_35 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
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
	Play325601017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325601017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play325601018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1071ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1071ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, 100, 0)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1071ui_story, var_71_4, var_71_3)

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

			local var_71_9 = arg_68_1.actors_["1071ui_story"]
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1071ui_story == nil then
				arg_68_1.var_.characterEffect1071ui_story = var_71_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_11 = 0.200000002980232

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 and not isNil(var_71_9) then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11

				if arg_68_1.var_.characterEffect1071ui_story and not isNil(var_71_9) then
					local var_71_13 = Mathf.Lerp(0, 0.5, var_71_12)

					arg_68_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1071ui_story.fillRatio = var_71_13
				end
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1071ui_story then
				local var_71_14 = 0.5

				arg_68_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1071ui_story.fillRatio = var_71_14
			end

			local var_71_15 = 0
			local var_71_16 = 0.5

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_17 = arg_68_1:FormatText(StoryNameCfg[7].name)

				arg_68_1.leftNameTxt_.text = var_71_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_18 = arg_68_1:GetWordFromCfg(325601017)
				local var_71_19 = arg_68_1:FormatText(var_71_18.content)

				arg_68_1.text_.text = var_71_19

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_20 = 20
				local var_71_21 = utf8.len(var_71_19)
				local var_71_22 = var_71_20 <= 0 and var_71_16 or var_71_16 * (var_71_21 / var_71_20)

				if var_71_22 > 0 and var_71_16 < var_71_22 then
					arg_68_1.talkMaxDuration = var_71_22

					if var_71_22 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_22 + var_71_15
					end
				end

				arg_68_1.text_.text = var_71_19
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_23 = math.max(var_71_16, arg_68_1.talkMaxDuration)

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_23 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_15) / var_71_23

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_15 + var_71_23 and arg_68_1.time_ < var_71_15 + var_71_23 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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

		arg_68_1:InitPlayNodeList()
	end,
	Play325601018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325601018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play325601019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.45

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[7].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:GetWordFromCfg(325601018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 18
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_8 and arg_72_1.time_ < var_75_0 + var_75_8 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play325601019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325601019
		arg_76_1.duration_ = 3.43

		local var_76_0 = {
			zh = 2.4,
			ja = 3.433
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
				arg_76_0:Play325601020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10170ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos10170ui_story = var_79_0.localPosition

				local var_79_2 = GameObjectTools.GetOrAddComponent(var_79_0.gameObject, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(false)
				end
			end

			local var_79_3 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_3 then
				local var_79_4 = (arg_76_1.time_ - var_79_1) / var_79_3
				local var_79_5 = Vector3.New(0, -1.03, -6.05)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10170ui_story, var_79_5, var_79_4)

				local var_79_6 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_6.x, var_79_6.y, var_79_6.z)

				local var_79_7 = var_79_0.localEulerAngles

				var_79_7.z = 0
				var_79_7.x = 0
				var_79_0.localEulerAngles = var_79_7
			end

			if arg_76_1.time_ >= var_79_1 + var_79_3 and arg_76_1.time_ < var_79_1 + var_79_3 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_79_8 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_8.x, var_79_8.y, var_79_8.z)

				local var_79_9 = var_79_0.localEulerAngles

				var_79_9.z = 0
				var_79_9.x = 0
				var_79_0.localEulerAngles = var_79_9

				local var_79_10 = GameObjectTools.GetOrAddComponent(var_79_0.gameObject, typeof(DynamicBoneHelper))

				if var_79_10 then
					var_79_10:EnableDynamicBone(true)
				end
			end

			local var_79_11 = arg_76_1.actors_["10170ui_story"]
			local var_79_12 = 0

			if var_79_12 < arg_76_1.time_ and arg_76_1.time_ <= var_79_12 + arg_79_0 and not isNil(var_79_11) and arg_76_1.var_.characterEffect10170ui_story == nil then
				arg_76_1.var_.characterEffect10170ui_story = var_79_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_13 = 0.200000002980232

			if var_79_12 <= arg_76_1.time_ and arg_76_1.time_ < var_79_12 + var_79_13 and not isNil(var_79_11) then
				local var_79_14 = (arg_76_1.time_ - var_79_12) / var_79_13

				if arg_76_1.var_.characterEffect10170ui_story and not isNil(var_79_11) then
					arg_76_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_12 + var_79_13 and arg_76_1.time_ < var_79_12 + var_79_13 + arg_79_0 and not isNil(var_79_11) and arg_76_1.var_.characterEffect10170ui_story then
				arg_76_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_79_15 = arg_76_1.actors_["1071ui_story"].transform
			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.var_.moveOldPos1071ui_story = var_79_15.localPosition
			end

			local var_79_17 = 0.001

			if var_79_16 <= arg_76_1.time_ and arg_76_1.time_ < var_79_16 + var_79_17 then
				local var_79_18 = (arg_76_1.time_ - var_79_16) / var_79_17
				local var_79_19 = Vector3.New(0, 100, 0)

				var_79_15.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1071ui_story, var_79_19, var_79_18)

				local var_79_20 = manager.ui.mainCamera.transform.position - var_79_15.position

				var_79_15.forward = Vector3.New(var_79_20.x, var_79_20.y, var_79_20.z)

				local var_79_21 = var_79_15.localEulerAngles

				var_79_21.z = 0
				var_79_21.x = 0
				var_79_15.localEulerAngles = var_79_21
			end

			if arg_76_1.time_ >= var_79_16 + var_79_17 and arg_76_1.time_ < var_79_16 + var_79_17 + arg_79_0 then
				var_79_15.localPosition = Vector3.New(0, 100, 0)

				local var_79_22 = manager.ui.mainCamera.transform.position - var_79_15.position

				var_79_15.forward = Vector3.New(var_79_22.x, var_79_22.y, var_79_22.z)

				local var_79_23 = var_79_15.localEulerAngles

				var_79_23.z = 0
				var_79_23.x = 0
				var_79_15.localEulerAngles = var_79_23
			end

			local var_79_24 = 0

			if var_79_24 < arg_76_1.time_ and arg_76_1.time_ <= var_79_24 + arg_79_0 then
				arg_76_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_79_25 = 0

			if var_79_25 < arg_76_1.time_ and arg_76_1.time_ <= var_79_25 + arg_79_0 then
				arg_76_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_79_26 = 0
			local var_79_27 = 0.225

			if var_79_26 < arg_76_1.time_ and arg_76_1.time_ <= var_79_26 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_28 = arg_76_1:FormatText(StoryNameCfg[1450].name)

				arg_76_1.leftNameTxt_.text = var_79_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_29 = arg_76_1:GetWordFromCfg(325601019)
				local var_79_30 = arg_76_1:FormatText(var_79_29.content)

				arg_76_1.text_.text = var_79_30

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_31 = 9
				local var_79_32 = utf8.len(var_79_30)
				local var_79_33 = var_79_31 <= 0 and var_79_27 or var_79_27 * (var_79_32 / var_79_31)

				if var_79_33 > 0 and var_79_27 < var_79_33 then
					arg_76_1.talkMaxDuration = var_79_33

					if var_79_33 + var_79_26 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_33 + var_79_26
					end
				end

				arg_76_1.text_.text = var_79_30
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601019", "story_v_out_325601.awb") ~= 0 then
					local var_79_34 = manager.audio:GetVoiceLength("story_v_out_325601", "325601019", "story_v_out_325601.awb") / 1000

					if var_79_34 + var_79_26 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_34 + var_79_26
					end

					if var_79_29.prefab_name ~= "" and arg_76_1.actors_[var_79_29.prefab_name] ~= nil then
						local var_79_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_29.prefab_name].transform, "story_v_out_325601", "325601019", "story_v_out_325601.awb")

						arg_76_1:RecordAudio("325601019", var_79_35)
						arg_76_1:RecordAudio("325601019", var_79_35)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325601", "325601019", "story_v_out_325601.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325601", "325601019", "story_v_out_325601.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_36 = math.max(var_79_27, arg_76_1.talkMaxDuration)

			if var_79_26 <= arg_76_1.time_ and arg_76_1.time_ < var_79_26 + var_79_36 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_26) / var_79_36

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_26 + var_79_36 and arg_76_1.time_ < var_79_26 + var_79_36 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_76_1:InitPlayNodeList()
	end,
	Play325601020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325601020
		arg_80_1.duration_ = 5.7

		local var_80_0 = {
			zh = 5.466,
			ja = 5.7
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
				arg_80_0:Play325601021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10170ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos10170ui_story = var_83_0.localPosition

				local var_83_2 = GameObjectTools.GetOrAddComponent(var_83_0.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(false)
				end
			end

			local var_83_3 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_3 then
				local var_83_4 = (arg_80_1.time_ - var_83_1) / var_83_3
				local var_83_5 = Vector3.New(-0.7, -1.03, -6.05)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10170ui_story, var_83_5, var_83_4)

				local var_83_6 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_6.x, var_83_6.y, var_83_6.z)

				local var_83_7 = var_83_0.localEulerAngles

				var_83_7.z = 0
				var_83_7.x = 0
				var_83_0.localEulerAngles = var_83_7
			end

			if arg_80_1.time_ >= var_83_1 + var_83_3 and arg_80_1.time_ < var_83_1 + var_83_3 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(-0.7, -1.03, -6.05)

				local var_83_8 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_8.x, var_83_8.y, var_83_8.z)

				local var_83_9 = var_83_0.localEulerAngles

				var_83_9.z = 0
				var_83_9.x = 0
				var_83_0.localEulerAngles = var_83_9

				local var_83_10 = GameObjectTools.GetOrAddComponent(var_83_0.gameObject, typeof(DynamicBoneHelper))

				if var_83_10 then
					var_83_10:EnableDynamicBone(true)
				end
			end

			local var_83_11 = arg_80_1.actors_["1071ui_story"].transform
			local var_83_12 = 0

			if var_83_12 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
				arg_80_1.var_.moveOldPos1071ui_story = var_83_11.localPosition
			end

			local var_83_13 = 0.001

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_13 then
				local var_83_14 = (arg_80_1.time_ - var_83_12) / var_83_13
				local var_83_15 = Vector3.New(0.7, -1.05, -6.2)

				var_83_11.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1071ui_story, var_83_15, var_83_14)

				local var_83_16 = manager.ui.mainCamera.transform.position - var_83_11.position

				var_83_11.forward = Vector3.New(var_83_16.x, var_83_16.y, var_83_16.z)

				local var_83_17 = var_83_11.localEulerAngles

				var_83_17.z = 0
				var_83_17.x = 0
				var_83_11.localEulerAngles = var_83_17
			end

			if arg_80_1.time_ >= var_83_12 + var_83_13 and arg_80_1.time_ < var_83_12 + var_83_13 + arg_83_0 then
				var_83_11.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_83_18 = manager.ui.mainCamera.transform.position - var_83_11.position

				var_83_11.forward = Vector3.New(var_83_18.x, var_83_18.y, var_83_18.z)

				local var_83_19 = var_83_11.localEulerAngles

				var_83_19.z = 0
				var_83_19.x = 0
				var_83_11.localEulerAngles = var_83_19
			end

			local var_83_20 = arg_80_1.actors_["1071ui_story"]
			local var_83_21 = 0

			if var_83_21 < arg_80_1.time_ and arg_80_1.time_ <= var_83_21 + arg_83_0 and not isNil(var_83_20) and arg_80_1.var_.characterEffect1071ui_story == nil then
				arg_80_1.var_.characterEffect1071ui_story = var_83_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_22 = 0.200000002980232

			if var_83_21 <= arg_80_1.time_ and arg_80_1.time_ < var_83_21 + var_83_22 and not isNil(var_83_20) then
				local var_83_23 = (arg_80_1.time_ - var_83_21) / var_83_22

				if arg_80_1.var_.characterEffect1071ui_story and not isNil(var_83_20) then
					arg_80_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_21 + var_83_22 and arg_80_1.time_ < var_83_21 + var_83_22 + arg_83_0 and not isNil(var_83_20) and arg_80_1.var_.characterEffect1071ui_story then
				arg_80_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_83_24 = arg_80_1.actors_["10170ui_story"]
			local var_83_25 = 0

			if var_83_25 < arg_80_1.time_ and arg_80_1.time_ <= var_83_25 + arg_83_0 and not isNil(var_83_24) and arg_80_1.var_.characterEffect10170ui_story == nil then
				arg_80_1.var_.characterEffect10170ui_story = var_83_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_26 = 0.200000002980232

			if var_83_25 <= arg_80_1.time_ and arg_80_1.time_ < var_83_25 + var_83_26 and not isNil(var_83_24) then
				local var_83_27 = (arg_80_1.time_ - var_83_25) / var_83_26

				if arg_80_1.var_.characterEffect10170ui_story and not isNil(var_83_24) then
					local var_83_28 = Mathf.Lerp(0, 0.5, var_83_27)

					arg_80_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10170ui_story.fillRatio = var_83_28
				end
			end

			if arg_80_1.time_ >= var_83_25 + var_83_26 and arg_80_1.time_ < var_83_25 + var_83_26 + arg_83_0 and not isNil(var_83_24) and arg_80_1.var_.characterEffect10170ui_story then
				local var_83_29 = 0.5

				arg_80_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10170ui_story.fillRatio = var_83_29
			end

			local var_83_30 = 0
			local var_83_31 = 0.675

			if var_83_30 < arg_80_1.time_ and arg_80_1.time_ <= var_83_30 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_32 = arg_80_1:FormatText(StoryNameCfg[384].name)

				arg_80_1.leftNameTxt_.text = var_83_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_33 = arg_80_1:GetWordFromCfg(325601020)
				local var_83_34 = arg_80_1:FormatText(var_83_33.content)

				arg_80_1.text_.text = var_83_34

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_35 = 27
				local var_83_36 = utf8.len(var_83_34)
				local var_83_37 = var_83_35 <= 0 and var_83_31 or var_83_31 * (var_83_36 / var_83_35)

				if var_83_37 > 0 and var_83_31 < var_83_37 then
					arg_80_1.talkMaxDuration = var_83_37

					if var_83_37 + var_83_30 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_37 + var_83_30
					end
				end

				arg_80_1.text_.text = var_83_34
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601020", "story_v_out_325601.awb") ~= 0 then
					local var_83_38 = manager.audio:GetVoiceLength("story_v_out_325601", "325601020", "story_v_out_325601.awb") / 1000

					if var_83_38 + var_83_30 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_38 + var_83_30
					end

					if var_83_33.prefab_name ~= "" and arg_80_1.actors_[var_83_33.prefab_name] ~= nil then
						local var_83_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_33.prefab_name].transform, "story_v_out_325601", "325601020", "story_v_out_325601.awb")

						arg_80_1:RecordAudio("325601020", var_83_39)
						arg_80_1:RecordAudio("325601020", var_83_39)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_325601", "325601020", "story_v_out_325601.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_325601", "325601020", "story_v_out_325601.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_40 = math.max(var_83_31, arg_80_1.talkMaxDuration)

			if var_83_30 <= arg_80_1.time_ and arg_80_1.time_ < var_83_30 + var_83_40 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_30) / var_83_40

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_30 + var_83_40 and arg_80_1.time_ < var_83_30 + var_83_40 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_80_1:InitPlayNodeList()
	end,
	Play325601021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325601021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play325601022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1071ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1071ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(0, 100, 0)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1071ui_story, var_87_4, var_87_3)

				local var_87_5 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_5.x, var_87_5.y, var_87_5.z)

				local var_87_6 = var_87_0.localEulerAngles

				var_87_6.z = 0
				var_87_6.x = 0
				var_87_0.localEulerAngles = var_87_6
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, 100, 0)

				local var_87_7 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_7.x, var_87_7.y, var_87_7.z)

				local var_87_8 = var_87_0.localEulerAngles

				var_87_8.z = 0
				var_87_8.x = 0
				var_87_0.localEulerAngles = var_87_8
			end

			local var_87_9 = arg_84_1.actors_["10170ui_story"].transform
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.var_.moveOldPos10170ui_story = var_87_9.localPosition

				local var_87_11 = GameObjectTools.GetOrAddComponent(var_87_9.gameObject, typeof(DynamicBoneHelper))

				if var_87_11 then
					var_87_11:EnableDynamicBone(false)
				end
			end

			local var_87_12 = 0.001

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_12 then
				local var_87_13 = (arg_84_1.time_ - var_87_10) / var_87_12
				local var_87_14 = Vector3.New(0, 100, 0)

				var_87_9.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10170ui_story, var_87_14, var_87_13)

				local var_87_15 = manager.ui.mainCamera.transform.position - var_87_9.position

				var_87_9.forward = Vector3.New(var_87_15.x, var_87_15.y, var_87_15.z)

				local var_87_16 = var_87_9.localEulerAngles

				var_87_16.z = 0
				var_87_16.x = 0
				var_87_9.localEulerAngles = var_87_16
			end

			if arg_84_1.time_ >= var_87_10 + var_87_12 and arg_84_1.time_ < var_87_10 + var_87_12 + arg_87_0 then
				var_87_9.localPosition = Vector3.New(0, 100, 0)

				local var_87_17 = manager.ui.mainCamera.transform.position - var_87_9.position

				var_87_9.forward = Vector3.New(var_87_17.x, var_87_17.y, var_87_17.z)

				local var_87_18 = var_87_9.localEulerAngles

				var_87_18.z = 0
				var_87_18.x = 0
				var_87_9.localEulerAngles = var_87_18

				local var_87_19 = GameObjectTools.GetOrAddComponent(var_87_9.gameObject, typeof(DynamicBoneHelper))

				if var_87_19 then
					var_87_19:EnableDynamicBone(true)
				end
			end

			local var_87_20 = arg_84_1.actors_["1071ui_story"]
			local var_87_21 = 0

			if var_87_21 < arg_84_1.time_ and arg_84_1.time_ <= var_87_21 + arg_87_0 and not isNil(var_87_20) and arg_84_1.var_.characterEffect1071ui_story == nil then
				arg_84_1.var_.characterEffect1071ui_story = var_87_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_22 = 0.200000002980232

			if var_87_21 <= arg_84_1.time_ and arg_84_1.time_ < var_87_21 + var_87_22 and not isNil(var_87_20) then
				local var_87_23 = (arg_84_1.time_ - var_87_21) / var_87_22

				if arg_84_1.var_.characterEffect1071ui_story and not isNil(var_87_20) then
					local var_87_24 = Mathf.Lerp(0, 0.5, var_87_23)

					arg_84_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1071ui_story.fillRatio = var_87_24
				end
			end

			if arg_84_1.time_ >= var_87_21 + var_87_22 and arg_84_1.time_ < var_87_21 + var_87_22 + arg_87_0 and not isNil(var_87_20) and arg_84_1.var_.characterEffect1071ui_story then
				local var_87_25 = 0.5

				arg_84_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1071ui_story.fillRatio = var_87_25
			end

			local var_87_26 = 0
			local var_87_27 = 0.725

			if var_87_26 < arg_84_1.time_ and arg_84_1.time_ <= var_87_26 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_28 = arg_84_1:FormatText(StoryNameCfg[7].name)

				arg_84_1.leftNameTxt_.text = var_87_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_29 = arg_84_1:GetWordFromCfg(325601021)
				local var_87_30 = arg_84_1:FormatText(var_87_29.content)

				arg_84_1.text_.text = var_87_30

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_31 = 29
				local var_87_32 = utf8.len(var_87_30)
				local var_87_33 = var_87_31 <= 0 and var_87_27 or var_87_27 * (var_87_32 / var_87_31)

				if var_87_33 > 0 and var_87_27 < var_87_33 then
					arg_84_1.talkMaxDuration = var_87_33

					if var_87_33 + var_87_26 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_33 + var_87_26
					end
				end

				arg_84_1.text_.text = var_87_30
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_34 = math.max(var_87_27, arg_84_1.talkMaxDuration)

			if var_87_26 <= arg_84_1.time_ and arg_84_1.time_ < var_87_26 + var_87_34 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_26) / var_87_34

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_26 + var_87_34 and arg_84_1.time_ < var_87_26 + var_87_34 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play325601022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325601022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play325601023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.5

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

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:GetWordFromCfg(325601022)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 20
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
	Play325601023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325601023
		arg_92_1.duration_ = 3.13

		local var_92_0 = {
			zh = 3.066,
			ja = 3.133
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
				arg_92_0:Play325601024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1170ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1170ui_story = var_95_0.localPosition

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end
			end

			local var_95_3 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_3 then
				local var_95_4 = (arg_92_1.time_ - var_95_1) / var_95_3
				local var_95_5 = Vector3.New(0.03, -0.95, -6.08)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1170ui_story, var_95_5, var_95_4)

				local var_95_6 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_6.x, var_95_6.y, var_95_6.z)

				local var_95_7 = var_95_0.localEulerAngles

				var_95_7.z = 0
				var_95_7.x = 0
				var_95_0.localEulerAngles = var_95_7
			end

			if arg_92_1.time_ >= var_95_1 + var_95_3 and arg_92_1.time_ < var_95_1 + var_95_3 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_95_8 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_8.x, var_95_8.y, var_95_8.z)

				local var_95_9 = var_95_0.localEulerAngles

				var_95_9.z = 0
				var_95_9.x = 0
				var_95_0.localEulerAngles = var_95_9

				local var_95_10 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_10 then
					var_95_10:EnableDynamicBone(true)
				end
			end

			local var_95_11 = arg_92_1.actors_["1170ui_story"]
			local var_95_12 = 0

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect1170ui_story == nil then
				arg_92_1.var_.characterEffect1170ui_story = var_95_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_13 = 0.200000002980232

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_13 and not isNil(var_95_11) then
				local var_95_14 = (arg_92_1.time_ - var_95_12) / var_95_13

				if arg_92_1.var_.characterEffect1170ui_story and not isNil(var_95_11) then
					arg_92_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_12 + var_95_13 and arg_92_1.time_ < var_95_12 + var_95_13 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect1170ui_story then
				arg_92_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_95_15 = 0

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 then
				arg_92_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_1")
			end

			local var_95_16 = 0

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_95_17 = 0
			local var_95_18 = 0.325

			if var_95_17 < arg_92_1.time_ and arg_92_1.time_ <= var_95_17 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_19 = arg_92_1:FormatText(StoryNameCfg[318].name)

				arg_92_1.leftNameTxt_.text = var_95_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_20 = arg_92_1:GetWordFromCfg(325601023)
				local var_95_21 = arg_92_1:FormatText(var_95_20.content)

				arg_92_1.text_.text = var_95_21

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_22 = 13
				local var_95_23 = utf8.len(var_95_21)
				local var_95_24 = var_95_22 <= 0 and var_95_18 or var_95_18 * (var_95_23 / var_95_22)

				if var_95_24 > 0 and var_95_18 < var_95_24 then
					arg_92_1.talkMaxDuration = var_95_24

					if var_95_24 + var_95_17 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_24 + var_95_17
					end
				end

				arg_92_1.text_.text = var_95_21
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601023", "story_v_out_325601.awb") ~= 0 then
					local var_95_25 = manager.audio:GetVoiceLength("story_v_out_325601", "325601023", "story_v_out_325601.awb") / 1000

					if var_95_25 + var_95_17 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_25 + var_95_17
					end

					if var_95_20.prefab_name ~= "" and arg_92_1.actors_[var_95_20.prefab_name] ~= nil then
						local var_95_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_20.prefab_name].transform, "story_v_out_325601", "325601023", "story_v_out_325601.awb")

						arg_92_1:RecordAudio("325601023", var_95_26)
						arg_92_1:RecordAudio("325601023", var_95_26)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325601", "325601023", "story_v_out_325601.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325601", "325601023", "story_v_out_325601.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_27 = math.max(var_95_18, arg_92_1.talkMaxDuration)

			if var_95_17 <= arg_92_1.time_ and arg_92_1.time_ < var_95_17 + var_95_27 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_17) / var_95_27

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_17 + var_95_27 and arg_92_1.time_ < var_95_17 + var_95_27 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
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
	Play325601024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325601024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325601025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1170ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1170ui_story = var_99_0.localPosition

				local var_99_2 = GameObjectTools.GetOrAddComponent(var_99_0.gameObject, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(false)
				end
			end

			local var_99_3 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_3 then
				local var_99_4 = (arg_96_1.time_ - var_99_1) / var_99_3
				local var_99_5 = Vector3.New(0, 100, 0)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1170ui_story, var_99_5, var_99_4)

				local var_99_6 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_6.x, var_99_6.y, var_99_6.z)

				local var_99_7 = var_99_0.localEulerAngles

				var_99_7.z = 0
				var_99_7.x = 0
				var_99_0.localEulerAngles = var_99_7
			end

			if arg_96_1.time_ >= var_99_1 + var_99_3 and arg_96_1.time_ < var_99_1 + var_99_3 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, 100, 0)

				local var_99_8 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_8.x, var_99_8.y, var_99_8.z)

				local var_99_9 = var_99_0.localEulerAngles

				var_99_9.z = 0
				var_99_9.x = 0
				var_99_0.localEulerAngles = var_99_9

				local var_99_10 = GameObjectTools.GetOrAddComponent(var_99_0.gameObject, typeof(DynamicBoneHelper))

				if var_99_10 then
					var_99_10:EnableDynamicBone(true)
				end
			end

			local var_99_11 = arg_96_1.actors_["1170ui_story"]
			local var_99_12 = 0

			if var_99_12 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 and not isNil(var_99_11) and arg_96_1.var_.characterEffect1170ui_story == nil then
				arg_96_1.var_.characterEffect1170ui_story = var_99_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_13 = 0.200000002980232

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_13 and not isNil(var_99_11) then
				local var_99_14 = (arg_96_1.time_ - var_99_12) / var_99_13

				if arg_96_1.var_.characterEffect1170ui_story and not isNil(var_99_11) then
					local var_99_15 = Mathf.Lerp(0, 0.5, var_99_14)

					arg_96_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1170ui_story.fillRatio = var_99_15
				end
			end

			if arg_96_1.time_ >= var_99_12 + var_99_13 and arg_96_1.time_ < var_99_12 + var_99_13 + arg_99_0 and not isNil(var_99_11) and arg_96_1.var_.characterEffect1170ui_story then
				local var_99_16 = 0.5

				arg_96_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1170ui_story.fillRatio = var_99_16
			end

			local var_99_17 = 0
			local var_99_18 = 0.525

			if var_99_17 < arg_96_1.time_ and arg_96_1.time_ <= var_99_17 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_19 = arg_96_1:FormatText(StoryNameCfg[7].name)

				arg_96_1.leftNameTxt_.text = var_99_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_20 = arg_96_1:GetWordFromCfg(325601024)
				local var_99_21 = arg_96_1:FormatText(var_99_20.content)

				arg_96_1.text_.text = var_99_21

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_22 = 21
				local var_99_23 = utf8.len(var_99_21)
				local var_99_24 = var_99_22 <= 0 and var_99_18 or var_99_18 * (var_99_23 / var_99_22)

				if var_99_24 > 0 and var_99_18 < var_99_24 then
					arg_96_1.talkMaxDuration = var_99_24

					if var_99_24 + var_99_17 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_24 + var_99_17
					end
				end

				arg_96_1.text_.text = var_99_21
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_25 = math.max(var_99_18, arg_96_1.talkMaxDuration)

			if var_99_17 <= arg_96_1.time_ and arg_96_1.time_ < var_99_17 + var_99_25 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_17) / var_99_25

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_17 + var_99_25 and arg_96_1.time_ < var_99_17 + var_99_25 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
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
	Play325601025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325601025
		arg_100_1.duration_ = 5.28

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play325601026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = manager.ui.mainCamera.transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				local var_103_2 = arg_100_1.var_.effectdakailiefeng1
				local var_103_3
				local var_103_4 = var_103_0

				if not var_103_2 then
					var_103_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_liefeng_keep"), var_103_4)
					var_103_2.name = "dakailiefeng1"
					arg_100_1.var_.effectdakailiefeng1 = var_103_2
				else
					var_103_2.transform:SetParent(var_103_4)
				end

				var_103_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_103_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1.allBtn_.enabled = false
			end

			local var_103_6 = 2

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 then
				arg_100_1.allBtn_.enabled = true
			end

			local var_103_7 = 0
			local var_103_8 = 1.999999999999

			if var_103_7 < arg_100_1.time_ and arg_100_1.time_ <= var_103_7 + arg_103_0 then
				local var_103_9 = "play"
				local var_103_10 = "effect"

				arg_100_1:AudioAction(var_103_9, var_103_10, "se_story_126_01", "se_story_126_01_Portal", "")
			end

			if arg_100_1.frameCnt_ <= 1 then
				arg_100_1.dialog_:SetActive(false)
			end

			local var_103_11 = 0.275
			local var_103_12 = 0.725

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0

				arg_100_1.dialog_:SetActive(true)

				arg_100_1.dialogCg_.alpha = 0

				local var_103_13 = LeanTween.value(arg_100_1.dialog_, 0, 1, 0.3)

				var_103_13:setOnUpdate(LuaHelper.FloatAction(function(arg_104_0)
					arg_100_1.dialogCg_.alpha = arg_104_0
				end))
				var_103_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_100_1.dialog_)
					var_103_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_100_1.duration_ = arg_100_1.duration_ + 0.3

				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_14 = arg_100_1:GetWordFromCfg(325601025)
				local var_103_15 = arg_100_1:FormatText(var_103_14.content)

				arg_100_1.text_.text = var_103_15

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_16 = 29
				local var_103_17 = utf8.len(var_103_15)
				local var_103_18 = var_103_16 <= 0 and var_103_12 or var_103_12 * (var_103_17 / var_103_16)

				if var_103_18 > 0 and var_103_12 < var_103_18 then
					arg_100_1.talkMaxDuration = var_103_18
					var_103_11 = var_103_11 + 0.3

					if var_103_18 + var_103_11 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_18 + var_103_11
					end
				end

				arg_100_1.text_.text = var_103_15
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_19 = var_103_11 + 0.3
			local var_103_20 = math.max(var_103_12, arg_100_1.talkMaxDuration)

			if var_103_19 <= arg_100_1.time_ and arg_100_1.time_ < var_103_19 + var_103_20 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_19) / var_103_20

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_19 + var_103_20 and arg_100_1.time_ < var_103_19 + var_103_20 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play325601026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325601026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play325601027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.525

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[7].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(325601026)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 21
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_8 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_8 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_8

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_8 and arg_106_1.time_ < var_109_0 + var_109_8 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play325601027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325601027
		arg_110_1.duration_ = 9.8

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play325601028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = "J25f"

			if arg_110_1.bgs_[var_113_0] == nil then
				local var_113_1 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_113_0)
				var_113_1.name = var_113_0
				var_113_1.transform.parent = arg_110_1.stage_.transform
				var_113_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_[var_113_0] = var_113_1
			end

			local var_113_2 = 3.966666666666

			if var_113_2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				local var_113_3 = manager.ui.mainCamera.transform.localPosition
				local var_113_4 = Vector3.New(0, 0, 10) + Vector3.New(var_113_3.x, var_113_3.y, 0)
				local var_113_5 = arg_110_1.bgs_.J25f

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
					if iter_113_0 ~= "J25f" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_16 = 4.79999999999933

			if var_113_16 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			local var_113_17 = 0.3

			if arg_110_1.time_ >= var_113_16 + var_113_17 and arg_110_1.time_ < var_113_16 + var_113_17 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_18 = manager.ui.mainCamera.transform
			local var_113_19 = 0

			if var_113_19 < arg_110_1.time_ and arg_110_1.time_ <= var_113_19 + arg_113_0 then
				local var_113_20 = arg_110_1.var_.effectdakailiefeng2
				local var_113_21
				local var_113_22 = var_113_18

				if not var_113_20 then
					var_113_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_liefeng_out"), var_113_22)
					var_113_20.name = "dakailiefeng2"
					arg_110_1.var_.effectdakailiefeng2 = var_113_20
				else
					var_113_20.transform:SetParent(var_113_22)
				end

				var_113_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_113_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_113_23 = 0

			if var_113_23 < arg_110_1.time_ and arg_110_1.time_ <= var_113_23 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			local var_113_24 = 2

			if arg_110_1.time_ >= var_113_23 + var_113_24 and arg_110_1.time_ < var_113_23 + var_113_24 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_25 = manager.ui.mainCamera.transform
			local var_113_26 = 0

			if var_113_26 < arg_110_1.time_ and arg_110_1.time_ <= var_113_26 + arg_113_0 then
				local var_113_27 = arg_110_1.var_.effectdakailiefeng1

				if var_113_27 then
					Object.Destroy(var_113_27)

					arg_110_1.var_.effectdakailiefeng1 = nil
				end
			end

			local var_113_28 = 0

			if var_113_28 < arg_110_1.time_ and arg_110_1.time_ <= var_113_28 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_29 = 0.8

			if var_113_28 <= arg_110_1.time_ and arg_110_1.time_ < var_113_28 + var_113_29 then
				local var_113_30 = (arg_110_1.time_ - var_113_28) / var_113_29
				local var_113_31 = Color.New(0, 0, 0)

				var_113_31.a = Mathf.Lerp(0, 1, var_113_30)
				arg_110_1.mask_.color = var_113_31
			end

			if arg_110_1.time_ >= var_113_28 + var_113_29 and arg_110_1.time_ < var_113_28 + var_113_29 + arg_113_0 then
				local var_113_32 = Color.New(0, 0, 0)

				var_113_32.a = 1
				arg_110_1.mask_.color = var_113_32
			end

			local var_113_33 = manager.ui.mainCamera.transform
			local var_113_34 = 0.8

			if var_113_34 < arg_110_1.time_ and arg_110_1.time_ <= var_113_34 + arg_113_0 then
				local var_113_35 = arg_110_1.var_.effectdakailiefeng3
				local var_113_36
				local var_113_37 = var_113_33

				if not var_113_35 then
					var_113_35 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blckspace1"), var_113_37)
					var_113_35.name = "dakailiefeng3"
					arg_110_1.var_.effectdakailiefeng3 = var_113_35
				else
					var_113_35.transform:SetParent(var_113_37)
				end

				var_113_35.transform.localPosition = Vector3.New(0, 0, 0)
				var_113_35.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_113_38 = 1.7777777777777777
				local var_113_39 = Screen.width / Screen.height
				local var_113_40 = var_113_39 / var_113_38
				local var_113_41 = Mathf.Max(var_113_38 / var_113_39, 1)

				var_113_35.transform.localScale = Vector3.New(var_113_35.transform.localScale.x * var_113_40, var_113_35.transform.localScale.y * var_113_41, var_113_35.transform.localScale.z)
			end

			local var_113_42 = manager.ui.mainCamera.transform
			local var_113_43 = 3.966666666666

			if var_113_43 < arg_110_1.time_ and arg_110_1.time_ <= var_113_43 + arg_113_0 then
				local var_113_44 = arg_110_1.var_.effectdakailiefeng3

				if var_113_44 then
					Object.Destroy(var_113_44)

					arg_110_1.var_.effectdakailiefeng3 = nil
				end
			end

			local var_113_45 = "STblack"

			if arg_110_1.bgs_[var_113_45] == nil then
				local var_113_46 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_46:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_113_45)
				var_113_46.name = var_113_45
				var_113_46.transform.parent = arg_110_1.stage_.transform
				var_113_46.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_[var_113_45] = var_113_46
			end

			local var_113_47 = 0.8

			if var_113_47 < arg_110_1.time_ and arg_110_1.time_ <= var_113_47 + arg_113_0 then
				local var_113_48 = manager.ui.mainCamera.transform.localPosition
				local var_113_49 = Vector3.New(0, 0, 10) + Vector3.New(var_113_48.x, var_113_48.y, 0)
				local var_113_50 = arg_110_1.bgs_.STblack

				var_113_50.transform.localPosition = var_113_49
				var_113_50.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_51 = var_113_50:GetComponent("SpriteRenderer")

				if var_113_51 and var_113_51.sprite then
					local var_113_52 = (var_113_50.transform.localPosition - var_113_48).z
					local var_113_53 = manager.ui.mainCameraCom_
					local var_113_54 = 2 * var_113_52 * Mathf.Tan(var_113_53.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_113_55 = var_113_54 * var_113_53.aspect
					local var_113_56 = var_113_51.sprite.bounds.size.x
					local var_113_57 = var_113_51.sprite.bounds.size.y
					local var_113_58 = var_113_55 / var_113_56
					local var_113_59 = var_113_54 / var_113_57
					local var_113_60 = var_113_59 < var_113_58 and var_113_58 or var_113_59

					var_113_50.transform.localScale = Vector3.New(var_113_60, var_113_60, 0)
				end

				for iter_113_2, iter_113_3 in pairs(arg_110_1.bgs_) do
					if iter_113_2 ~= "STblack" then
						iter_113_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_61 = 0.8

			if var_113_61 < arg_110_1.time_ and arg_110_1.time_ <= var_113_61 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_62 = 0.2

			if var_113_61 <= arg_110_1.time_ and arg_110_1.time_ < var_113_61 + var_113_62 then
				local var_113_63 = (arg_110_1.time_ - var_113_61) / var_113_62
				local var_113_64 = Color.New(0, 0, 0)

				var_113_64.a = Mathf.Lerp(1, 0, var_113_63)
				arg_110_1.mask_.color = var_113_64
			end

			if arg_110_1.time_ >= var_113_61 + var_113_62 and arg_110_1.time_ < var_113_61 + var_113_62 + arg_113_0 then
				local var_113_65 = Color.New(0, 0, 0)
				local var_113_66 = 0

				arg_110_1.mask_.enabled = false
				var_113_65.a = var_113_66
				arg_110_1.mask_.color = var_113_65
			end

			local var_113_67 = 3.166666666666

			if var_113_67 < arg_110_1.time_ and arg_110_1.time_ <= var_113_67 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_68 = 0.8

			if var_113_67 <= arg_110_1.time_ and arg_110_1.time_ < var_113_67 + var_113_68 then
				local var_113_69 = (arg_110_1.time_ - var_113_67) / var_113_68
				local var_113_70 = Color.New(0, 0, 0)

				var_113_70.a = Mathf.Lerp(0, 1, var_113_69)
				arg_110_1.mask_.color = var_113_70
			end

			if arg_110_1.time_ >= var_113_67 + var_113_68 and arg_110_1.time_ < var_113_67 + var_113_68 + arg_113_0 then
				local var_113_71 = Color.New(0, 0, 0)

				var_113_71.a = 1
				arg_110_1.mask_.color = var_113_71
			end

			local var_113_72 = 3.966666666666

			if var_113_72 < arg_110_1.time_ and arg_110_1.time_ <= var_113_72 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_73 = 0.833333333333333

			if var_113_72 <= arg_110_1.time_ and arg_110_1.time_ < var_113_72 + var_113_73 then
				local var_113_74 = (arg_110_1.time_ - var_113_72) / var_113_73
				local var_113_75 = Color.New(0, 0, 0)

				var_113_75.a = Mathf.Lerp(1, 0, var_113_74)
				arg_110_1.mask_.color = var_113_75
			end

			if arg_110_1.time_ >= var_113_72 + var_113_73 and arg_110_1.time_ < var_113_72 + var_113_73 + arg_113_0 then
				local var_113_76 = Color.New(0, 0, 0)
				local var_113_77 = 0

				arg_110_1.mask_.enabled = false
				var_113_76.a = var_113_77
				arg_110_1.mask_.color = var_113_76
			end

			local var_113_78 = 0

			if var_113_78 < arg_110_1.time_ and arg_110_1.time_ <= var_113_78 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			local var_113_79 = 4.79999999999933

			if arg_110_1.time_ >= var_113_78 + var_113_79 and arg_110_1.time_ < var_113_78 + var_113_79 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_80 = 0.1
			local var_113_81 = 1

			if var_113_80 < arg_110_1.time_ and arg_110_1.time_ <= var_113_80 + arg_113_0 then
				local var_113_82 = "stop"
				local var_113_83 = "effect"

				arg_110_1:AudioAction(var_113_82, var_113_83, "se_story_148", "se_story_148_amb_wind", "")
			end

			local var_113_84 = 0.1
			local var_113_85 = 1

			if var_113_84 < arg_110_1.time_ and arg_110_1.time_ <= var_113_84 + arg_113_0 then
				local var_113_86 = "play"
				local var_113_87 = "effect"

				arg_110_1:AudioAction(var_113_86, var_113_87, "se_story_121_00", "se_story_121_00_dooropen_loop", "")
			end

			local var_113_88 = 0
			local var_113_89 = 1

			if var_113_88 < arg_110_1.time_ and arg_110_1.time_ <= var_113_88 + arg_113_0 then
				local var_113_90 = "play"
				local var_113_91 = "music"

				arg_110_1:AudioAction(var_113_90, var_113_91, "bgm_activity_5_1_story_boss", "bgm_activity_5_1_story_boss", "bgm_activity_5_1_story_boss.awb")

				local var_113_92 = ""
				local var_113_93 = manager.audio:GetAudioName("bgm_activity_5_1_story_boss", "bgm_activity_5_1_story_boss")

				if var_113_93 ~= "" then
					if arg_110_1.bgmTxt_.text ~= var_113_93 and arg_110_1.bgmTxt_.text ~= "" then
						if arg_110_1.bgmTxt2_.text ~= "" then
							arg_110_1.bgmTxt_.text = arg_110_1.bgmTxt2_.text
						end

						arg_110_1.bgmTxt2_.text = var_113_93

						arg_110_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_110_1.bgmTxt_.text = var_113_93
						arg_110_1.bgmTxt2_.text = var_113_93
					end

					if arg_110_1.bgmTimer then
						arg_110_1.bgmTimer:Stop()

						arg_110_1.bgmTimer = nil
					end

					if arg_110_1.settingData.show_music_name == 1 then
						arg_110_1.musicController:SetSelectedState("show")
						arg_110_1.musicAnimator_:Play("open", 0, 0)

						if arg_110_1.settingData.music_time ~= 0 then
							arg_110_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_110_1.settingData.music_time), function()
								if arg_110_1 == nil or isNil(arg_110_1.bgmTxt_) then
									return
								end

								arg_110_1.musicController:SetSelectedState("hide")
								arg_110_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_94 = 4.79999999999933
			local var_113_95 = 1.35

			if var_113_94 < arg_110_1.time_ and arg_110_1.time_ <= var_113_94 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_96 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_96:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_110_1.dialogCg_.alpha = arg_115_0
				end))
				var_113_96:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_96:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_97 = arg_110_1:GetWordFromCfg(325601027)
				local var_113_98 = arg_110_1:FormatText(var_113_97.content)

				arg_110_1.text_.text = var_113_98

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_99 = 54
				local var_113_100 = utf8.len(var_113_98)
				local var_113_101 = var_113_99 <= 0 and var_113_95 or var_113_95 * (var_113_100 / var_113_99)

				if var_113_101 > 0 and var_113_95 < var_113_101 then
					arg_110_1.talkMaxDuration = var_113_101
					var_113_94 = var_113_94 + 0.3

					if var_113_101 + var_113_94 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_101 + var_113_94
					end
				end

				arg_110_1.text_.text = var_113_98
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_102 = var_113_94 + 0.3
			local var_113_103 = math.max(var_113_95, arg_110_1.talkMaxDuration)

			if var_113_102 <= arg_110_1.time_ and arg_110_1.time_ < var_113_102 + var_113_103 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_102) / var_113_103

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_102 + var_113_103 and arg_110_1.time_ < var_113_102 + var_113_103 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play325601028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 325601028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play325601029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 1.475

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_2 = arg_117_1:GetWordFromCfg(325601028)
				local var_120_3 = arg_117_1:FormatText(var_120_2.content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 59
				local var_120_5 = utf8.len(var_120_3)
				local var_120_6 = var_120_4 <= 0 and var_120_1 or var_120_1 * (var_120_5 / var_120_4)

				if var_120_6 > 0 and var_120_1 < var_120_6 then
					arg_117_1.talkMaxDuration = var_120_6

					if var_120_6 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_7 and arg_117_1.time_ < var_120_0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play325601029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 325601029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play325601030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.1

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[7].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(325601029)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 4
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_8 and arg_121_1.time_ < var_124_0 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play325601030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 325601030
		arg_125_1.duration_ = 3.77

		local var_125_0 = {
			zh = 3.766,
			ja = 3.7
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play325601031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = "10180ui_story"

			if arg_125_1.actors_[var_128_0] == nil then
				local var_128_1 = Asset.Load("Char/" .. "10180ui_story")

				if not isNil(var_128_1) then
					local var_128_2 = Object.Instantiate(Asset.Load("Char/" .. "10180ui_story"), arg_125_1.stage_.transform)

					var_128_2.name = var_128_0
					var_128_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_125_1.actors_[var_128_0] = var_128_2

					local var_128_3 = var_128_2:GetComponentInChildren(typeof(CharacterEffect))

					var_128_3.enabled = true

					local var_128_4 = GameObjectTools.GetOrAddComponent(var_128_2, typeof(DynamicBoneHelper))

					if var_128_4 then
						var_128_4:EnableDynamicBone(false)
					end

					arg_125_1:ShowWeapon(var_128_3.transform, false)

					arg_125_1.var_[var_128_0 .. "Animator"] = var_128_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_125_1.var_[var_128_0 .. "Animator"].applyRootMotion = true
					arg_125_1.var_[var_128_0 .. "LipSync"] = var_128_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_128_5 = arg_125_1.actors_["10180ui_story"].transform
			local var_128_6 = 0

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.var_.moveOldPos10180ui_story = var_128_5.localPosition

				local var_128_7 = GameObjectTools.GetOrAddComponent(var_128_5.gameObject, typeof(DynamicBoneHelper))

				if var_128_7 then
					var_128_7:EnableDynamicBone(false)
				end
			end

			local var_128_8 = 0.001

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_8 then
				local var_128_9 = (arg_125_1.time_ - var_128_6) / var_128_8
				local var_128_10 = Vector3.New(-0.03, -1.09, -6.14)

				var_128_5.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10180ui_story, var_128_10, var_128_9)

				local var_128_11 = manager.ui.mainCamera.transform.position - var_128_5.position

				var_128_5.forward = Vector3.New(var_128_11.x, var_128_11.y, var_128_11.z)

				local var_128_12 = var_128_5.localEulerAngles

				var_128_12.z = 0
				var_128_12.x = 0
				var_128_5.localEulerAngles = var_128_12
			end

			if arg_125_1.time_ >= var_128_6 + var_128_8 and arg_125_1.time_ < var_128_6 + var_128_8 + arg_128_0 then
				var_128_5.localPosition = Vector3.New(-0.03, -1.09, -6.14)

				local var_128_13 = manager.ui.mainCamera.transform.position - var_128_5.position

				var_128_5.forward = Vector3.New(var_128_13.x, var_128_13.y, var_128_13.z)

				local var_128_14 = var_128_5.localEulerAngles

				var_128_14.z = 0
				var_128_14.x = 0
				var_128_5.localEulerAngles = var_128_14

				local var_128_15 = GameObjectTools.GetOrAddComponent(var_128_5.gameObject, typeof(DynamicBoneHelper))

				if var_128_15 then
					var_128_15:EnableDynamicBone(true)
				end
			end

			local var_128_16 = arg_125_1.actors_["10180ui_story"]
			local var_128_17 = 0

			if var_128_17 < arg_125_1.time_ and arg_125_1.time_ <= var_128_17 + arg_128_0 and not isNil(var_128_16) and arg_125_1.var_.characterEffect10180ui_story == nil then
				arg_125_1.var_.characterEffect10180ui_story = var_128_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_18 = 0.200000002980232

			if var_128_17 <= arg_125_1.time_ and arg_125_1.time_ < var_128_17 + var_128_18 and not isNil(var_128_16) then
				local var_128_19 = (arg_125_1.time_ - var_128_17) / var_128_18

				if arg_125_1.var_.characterEffect10180ui_story and not isNil(var_128_16) then
					arg_125_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_17 + var_128_18 and arg_125_1.time_ < var_128_17 + var_128_18 + arg_128_0 and not isNil(var_128_16) and arg_125_1.var_.characterEffect10180ui_story then
				arg_125_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_128_20 = 0

			if var_128_20 < arg_125_1.time_ and arg_125_1.time_ <= var_128_20 + arg_128_0 then
				arg_125_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action1_1")
			end

			local var_128_21 = 0

			if var_128_21 < arg_125_1.time_ and arg_125_1.time_ <= var_128_21 + arg_128_0 then
				arg_125_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_128_22 = 0
			local var_128_23 = 0.325

			if var_128_22 < arg_125_1.time_ and arg_125_1.time_ <= var_128_22 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_24 = arg_125_1:FormatText(StoryNameCfg[1503].name)

				arg_125_1.leftNameTxt_.text = var_128_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_25 = arg_125_1:GetWordFromCfg(325601030)
				local var_128_26 = arg_125_1:FormatText(var_128_25.content)

				arg_125_1.text_.text = var_128_26

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_27 = 13
				local var_128_28 = utf8.len(var_128_26)
				local var_128_29 = var_128_27 <= 0 and var_128_23 or var_128_23 * (var_128_28 / var_128_27)

				if var_128_29 > 0 and var_128_23 < var_128_29 then
					arg_125_1.talkMaxDuration = var_128_29

					if var_128_29 + var_128_22 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_29 + var_128_22
					end
				end

				arg_125_1.text_.text = var_128_26
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601030", "story_v_out_325601.awb") ~= 0 then
					local var_128_30 = manager.audio:GetVoiceLength("story_v_out_325601", "325601030", "story_v_out_325601.awb") / 1000

					if var_128_30 + var_128_22 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_30 + var_128_22
					end

					if var_128_25.prefab_name ~= "" and arg_125_1.actors_[var_128_25.prefab_name] ~= nil then
						local var_128_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_25.prefab_name].transform, "story_v_out_325601", "325601030", "story_v_out_325601.awb")

						arg_125_1:RecordAudio("325601030", var_128_31)
						arg_125_1:RecordAudio("325601030", var_128_31)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_325601", "325601030", "story_v_out_325601.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_325601", "325601030", "story_v_out_325601.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_32 = math.max(var_128_23, arg_125_1.talkMaxDuration)

			if var_128_22 <= arg_125_1.time_ and arg_125_1.time_ < var_128_22 + var_128_32 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_22) / var_128_32

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_22 + var_128_32 and arg_125_1.time_ < var_128_22 + var_128_32 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play325601031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 325601031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play325601032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10180ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10180ui_story == nil then
				arg_129_1.var_.characterEffect10180ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect10180ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10180ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10180ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10180ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 0.575

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_8 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_9 = arg_129_1:GetWordFromCfg(325601031)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 23
				local var_132_12 = utf8.len(var_132_10)
				local var_132_13 = var_132_11 <= 0 and var_132_7 or var_132_7 * (var_132_12 / var_132_11)

				if var_132_13 > 0 and var_132_7 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play325601032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 325601032
		arg_133_1.duration_ = 10.03

		local var_133_0 = {
			zh = 6.5,
			ja = 10.033
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play325601033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10180ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10180ui_story == nil then
				arg_133_1.var_.characterEffect10180ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect10180ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10180ui_story then
				arg_133_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_136_4 = 0
			local var_136_5 = 0.5

			if var_136_4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_6 = arg_133_1:FormatText(StoryNameCfg[1503].name)

				arg_133_1.leftNameTxt_.text = var_136_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_7 = arg_133_1:GetWordFromCfg(325601032)
				local var_136_8 = arg_133_1:FormatText(var_136_7.content)

				arg_133_1.text_.text = var_136_8

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 20
				local var_136_10 = utf8.len(var_136_8)
				local var_136_11 = var_136_9 <= 0 and var_136_5 or var_136_5 * (var_136_10 / var_136_9)

				if var_136_11 > 0 and var_136_5 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_8
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601032", "story_v_out_325601.awb") ~= 0 then
					local var_136_12 = manager.audio:GetVoiceLength("story_v_out_325601", "325601032", "story_v_out_325601.awb") / 1000

					if var_136_12 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_4
					end

					if var_136_7.prefab_name ~= "" and arg_133_1.actors_[var_136_7.prefab_name] ~= nil then
						local var_136_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_7.prefab_name].transform, "story_v_out_325601", "325601032", "story_v_out_325601.awb")

						arg_133_1:RecordAudio("325601032", var_136_13)
						arg_133_1:RecordAudio("325601032", var_136_13)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_325601", "325601032", "story_v_out_325601.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_325601", "325601032", "story_v_out_325601.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_14 and arg_133_1.time_ < var_136_4 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play325601033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 325601033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play325601034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10180ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect10180ui_story == nil then
				arg_137_1.var_.characterEffect10180ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect10180ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10180ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect10180ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10180ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 0.25

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_9 = arg_137_1:GetWordFromCfg(325601033)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 10
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_7 or var_140_7 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_7 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play325601034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 325601034
		arg_141_1.duration_ = 13.23

		local var_141_0 = {
			zh = 8.833,
			ja = 13.233
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play325601035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10180ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10180ui_story == nil then
				arg_141_1.var_.characterEffect10180ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect10180ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10180ui_story then
				arg_141_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_144_4 = 0

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action8_1")
			end

			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_144_6 = 0
			local var_144_7 = 0.775

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_8 = arg_141_1:FormatText(StoryNameCfg[1503].name)

				arg_141_1.leftNameTxt_.text = var_144_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_9 = arg_141_1:GetWordFromCfg(325601034)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 31
				local var_144_12 = utf8.len(var_144_10)
				local var_144_13 = var_144_11 <= 0 and var_144_7 or var_144_7 * (var_144_12 / var_144_11)

				if var_144_13 > 0 and var_144_7 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601034", "story_v_out_325601.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_325601", "325601034", "story_v_out_325601.awb") / 1000

					if var_144_14 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_6
					end

					if var_144_9.prefab_name ~= "" and arg_141_1.actors_[var_144_9.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_9.prefab_name].transform, "story_v_out_325601", "325601034", "story_v_out_325601.awb")

						arg_141_1:RecordAudio("325601034", var_144_15)
						arg_141_1:RecordAudio("325601034", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_325601", "325601034", "story_v_out_325601.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_325601", "325601034", "story_v_out_325601.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_16 and arg_141_1.time_ < var_144_6 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play325601035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 325601035
		arg_145_1.duration_ = 9.37

		local var_145_0 = {
			zh = 7.533,
			ja = 9.366
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play325601036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.675

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[1503].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(325601035)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 27
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601035", "story_v_out_325601.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_325601", "325601035", "story_v_out_325601.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_325601", "325601035", "story_v_out_325601.awb")

						arg_145_1:RecordAudio("325601035", var_148_9)
						arg_145_1:RecordAudio("325601035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_325601", "325601035", "story_v_out_325601.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_325601", "325601035", "story_v_out_325601.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play325601036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 325601036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play325601037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10180ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos10180ui_story = var_152_0.localPosition

				local var_152_2 = GameObjectTools.GetOrAddComponent(var_152_0.gameObject, typeof(DynamicBoneHelper))

				if var_152_2 then
					var_152_2:EnableDynamicBone(false)
				end
			end

			local var_152_3 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_3 then
				local var_152_4 = (arg_149_1.time_ - var_152_1) / var_152_3
				local var_152_5 = Vector3.New(0, 100, 0)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10180ui_story, var_152_5, var_152_4)

				local var_152_6 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_6.x, var_152_6.y, var_152_6.z)

				local var_152_7 = var_152_0.localEulerAngles

				var_152_7.z = 0
				var_152_7.x = 0
				var_152_0.localEulerAngles = var_152_7
			end

			if arg_149_1.time_ >= var_152_1 + var_152_3 and arg_149_1.time_ < var_152_1 + var_152_3 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, 100, 0)

				local var_152_8 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_8.x, var_152_8.y, var_152_8.z)

				local var_152_9 = var_152_0.localEulerAngles

				var_152_9.z = 0
				var_152_9.x = 0
				var_152_0.localEulerAngles = var_152_9

				local var_152_10 = GameObjectTools.GetOrAddComponent(var_152_0.gameObject, typeof(DynamicBoneHelper))

				if var_152_10 then
					var_152_10:EnableDynamicBone(true)
				end
			end

			local var_152_11 = arg_149_1.actors_["10180ui_story"]
			local var_152_12 = 0

			if var_152_12 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 and not isNil(var_152_11) and arg_149_1.var_.characterEffect10180ui_story == nil then
				arg_149_1.var_.characterEffect10180ui_story = var_152_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_13 = 0.200000002980232

			if var_152_12 <= arg_149_1.time_ and arg_149_1.time_ < var_152_12 + var_152_13 and not isNil(var_152_11) then
				local var_152_14 = (arg_149_1.time_ - var_152_12) / var_152_13

				if arg_149_1.var_.characterEffect10180ui_story and not isNil(var_152_11) then
					local var_152_15 = Mathf.Lerp(0, 0.5, var_152_14)

					arg_149_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10180ui_story.fillRatio = var_152_15
				end
			end

			if arg_149_1.time_ >= var_152_12 + var_152_13 and arg_149_1.time_ < var_152_12 + var_152_13 + arg_152_0 and not isNil(var_152_11) and arg_149_1.var_.characterEffect10180ui_story then
				local var_152_16 = 0.5

				arg_149_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10180ui_story.fillRatio = var_152_16
			end

			local var_152_17 = 0
			local var_152_18 = 1.125

			if var_152_17 < arg_149_1.time_ and arg_149_1.time_ <= var_152_17 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_19 = arg_149_1:GetWordFromCfg(325601036)
				local var_152_20 = arg_149_1:FormatText(var_152_19.content)

				arg_149_1.text_.text = var_152_20

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_21 = 45
				local var_152_22 = utf8.len(var_152_20)
				local var_152_23 = var_152_21 <= 0 and var_152_18 or var_152_18 * (var_152_22 / var_152_21)

				if var_152_23 > 0 and var_152_18 < var_152_23 then
					arg_149_1.talkMaxDuration = var_152_23

					if var_152_23 + var_152_17 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_23 + var_152_17
					end
				end

				arg_149_1.text_.text = var_152_20
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_24 = math.max(var_152_18, arg_149_1.talkMaxDuration)

			if var_152_17 <= arg_149_1.time_ and arg_149_1.time_ < var_152_17 + var_152_24 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_17) / var_152_24

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_17 + var_152_24 and arg_149_1.time_ < var_152_17 + var_152_24 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play325601037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 325601037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play325601038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.9

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_2 = arg_153_1:GetWordFromCfg(325601037)
				local var_156_3 = arg_153_1:FormatText(var_156_2.content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 36
				local var_156_5 = utf8.len(var_156_3)
				local var_156_6 = var_156_4 <= 0 and var_156_1 or var_156_1 * (var_156_5 / var_156_4)

				if var_156_6 > 0 and var_156_1 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_7 and arg_153_1.time_ < var_156_0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play325601038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 325601038
		arg_157_1.duration_ = 3.37

		local var_157_0 = {
			zh = 3.366,
			ja = 2.8
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play325601039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10180ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10180ui_story = var_160_0.localPosition

				local var_160_2 = GameObjectTools.GetOrAddComponent(var_160_0.gameObject, typeof(DynamicBoneHelper))

				if var_160_2 then
					var_160_2:EnableDynamicBone(false)
				end
			end

			local var_160_3 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_3 then
				local var_160_4 = (arg_157_1.time_ - var_160_1) / var_160_3
				local var_160_5 = Vector3.New(-0.03, -1.09, -6.14)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10180ui_story, var_160_5, var_160_4)

				local var_160_6 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_6.x, var_160_6.y, var_160_6.z)

				local var_160_7 = var_160_0.localEulerAngles

				var_160_7.z = 0
				var_160_7.x = 0
				var_160_0.localEulerAngles = var_160_7
			end

			if arg_157_1.time_ >= var_160_1 + var_160_3 and arg_157_1.time_ < var_160_1 + var_160_3 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(-0.03, -1.09, -6.14)

				local var_160_8 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_8.x, var_160_8.y, var_160_8.z)

				local var_160_9 = var_160_0.localEulerAngles

				var_160_9.z = 0
				var_160_9.x = 0
				var_160_0.localEulerAngles = var_160_9

				local var_160_10 = GameObjectTools.GetOrAddComponent(var_160_0.gameObject, typeof(DynamicBoneHelper))

				if var_160_10 then
					var_160_10:EnableDynamicBone(true)
				end
			end

			local var_160_11 = arg_157_1.actors_["10180ui_story"]
			local var_160_12 = 0

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 and not isNil(var_160_11) and arg_157_1.var_.characterEffect10180ui_story == nil then
				arg_157_1.var_.characterEffect10180ui_story = var_160_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_13 = 0.200000002980232

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_13 and not isNil(var_160_11) then
				local var_160_14 = (arg_157_1.time_ - var_160_12) / var_160_13

				if arg_157_1.var_.characterEffect10180ui_story and not isNil(var_160_11) then
					arg_157_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_12 + var_160_13 and arg_157_1.time_ < var_160_12 + var_160_13 + arg_160_0 and not isNil(var_160_11) and arg_157_1.var_.characterEffect10180ui_story then
				arg_157_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_160_15 = 0

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action8_2")
			end

			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_160_17 = 0
			local var_160_18 = 0.25

			if var_160_17 < arg_157_1.time_ and arg_157_1.time_ <= var_160_17 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_19 = arg_157_1:FormatText(StoryNameCfg[1503].name)

				arg_157_1.leftNameTxt_.text = var_160_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_20 = arg_157_1:GetWordFromCfg(325601038)
				local var_160_21 = arg_157_1:FormatText(var_160_20.content)

				arg_157_1.text_.text = var_160_21

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_22 = 10
				local var_160_23 = utf8.len(var_160_21)
				local var_160_24 = var_160_22 <= 0 and var_160_18 or var_160_18 * (var_160_23 / var_160_22)

				if var_160_24 > 0 and var_160_18 < var_160_24 then
					arg_157_1.talkMaxDuration = var_160_24

					if var_160_24 + var_160_17 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_24 + var_160_17
					end
				end

				arg_157_1.text_.text = var_160_21
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601038", "story_v_out_325601.awb") ~= 0 then
					local var_160_25 = manager.audio:GetVoiceLength("story_v_out_325601", "325601038", "story_v_out_325601.awb") / 1000

					if var_160_25 + var_160_17 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_25 + var_160_17
					end

					if var_160_20.prefab_name ~= "" and arg_157_1.actors_[var_160_20.prefab_name] ~= nil then
						local var_160_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_20.prefab_name].transform, "story_v_out_325601", "325601038", "story_v_out_325601.awb")

						arg_157_1:RecordAudio("325601038", var_160_26)
						arg_157_1:RecordAudio("325601038", var_160_26)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_325601", "325601038", "story_v_out_325601.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_325601", "325601038", "story_v_out_325601.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_27 = math.max(var_160_18, arg_157_1.talkMaxDuration)

			if var_160_17 <= arg_157_1.time_ and arg_157_1.time_ < var_160_17 + var_160_27 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_17) / var_160_27

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_17 + var_160_27 and arg_157_1.time_ < var_160_17 + var_160_27 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play325601039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 325601039
		arg_161_1.duration_ = 3.53

		local var_161_0 = {
			zh = 2.7,
			ja = 3.533
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play325601040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10180ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos10180ui_story = var_164_0.localPosition

				local var_164_2 = GameObjectTools.GetOrAddComponent(var_164_0.gameObject, typeof(DynamicBoneHelper))

				if var_164_2 then
					var_164_2:EnableDynamicBone(false)
				end
			end

			local var_164_3 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_3 then
				local var_164_4 = (arg_161_1.time_ - var_164_1) / var_164_3
				local var_164_5 = Vector3.New(-0.8, -1.09, -6.14)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10180ui_story, var_164_5, var_164_4)

				local var_164_6 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_6.x, var_164_6.y, var_164_6.z)

				local var_164_7 = var_164_0.localEulerAngles

				var_164_7.z = 0
				var_164_7.x = 0
				var_164_0.localEulerAngles = var_164_7
			end

			if arg_161_1.time_ >= var_164_1 + var_164_3 and arg_161_1.time_ < var_164_1 + var_164_3 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(-0.8, -1.09, -6.14)

				local var_164_8 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_8.x, var_164_8.y, var_164_8.z)

				local var_164_9 = var_164_0.localEulerAngles

				var_164_9.z = 0
				var_164_9.x = 0
				var_164_0.localEulerAngles = var_164_9

				local var_164_10 = GameObjectTools.GetOrAddComponent(var_164_0.gameObject, typeof(DynamicBoneHelper))

				if var_164_10 then
					var_164_10:EnableDynamicBone(true)
				end
			end

			local var_164_11 = arg_161_1.actors_["10170ui_story"].transform
			local var_164_12 = 0

			if var_164_12 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 then
				arg_161_1.var_.moveOldPos10170ui_story = var_164_11.localPosition

				local var_164_13 = GameObjectTools.GetOrAddComponent(var_164_11.gameObject, typeof(DynamicBoneHelper))

				if var_164_13 then
					var_164_13:EnableDynamicBone(false)
				end
			end

			local var_164_14 = 0.001

			if var_164_12 <= arg_161_1.time_ and arg_161_1.time_ < var_164_12 + var_164_14 then
				local var_164_15 = (arg_161_1.time_ - var_164_12) / var_164_14
				local var_164_16 = Vector3.New(0.7, -1.03, -6.05)

				var_164_11.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10170ui_story, var_164_16, var_164_15)

				local var_164_17 = manager.ui.mainCamera.transform.position - var_164_11.position

				var_164_11.forward = Vector3.New(var_164_17.x, var_164_17.y, var_164_17.z)

				local var_164_18 = var_164_11.localEulerAngles

				var_164_18.z = 0
				var_164_18.x = 0
				var_164_11.localEulerAngles = var_164_18
			end

			if arg_161_1.time_ >= var_164_12 + var_164_14 and arg_161_1.time_ < var_164_12 + var_164_14 + arg_164_0 then
				var_164_11.localPosition = Vector3.New(0.7, -1.03, -6.05)

				local var_164_19 = manager.ui.mainCamera.transform.position - var_164_11.position

				var_164_11.forward = Vector3.New(var_164_19.x, var_164_19.y, var_164_19.z)

				local var_164_20 = var_164_11.localEulerAngles

				var_164_20.z = 0
				var_164_20.x = 0
				var_164_11.localEulerAngles = var_164_20

				local var_164_21 = GameObjectTools.GetOrAddComponent(var_164_11.gameObject, typeof(DynamicBoneHelper))

				if var_164_21 then
					var_164_21:EnableDynamicBone(true)
				end
			end

			local var_164_22 = arg_161_1.actors_["10170ui_story"]
			local var_164_23 = 0

			if var_164_23 < arg_161_1.time_ and arg_161_1.time_ <= var_164_23 + arg_164_0 and not isNil(var_164_22) and arg_161_1.var_.characterEffect10170ui_story == nil then
				arg_161_1.var_.characterEffect10170ui_story = var_164_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_24 = 0.200000002980232

			if var_164_23 <= arg_161_1.time_ and arg_161_1.time_ < var_164_23 + var_164_24 and not isNil(var_164_22) then
				local var_164_25 = (arg_161_1.time_ - var_164_23) / var_164_24

				if arg_161_1.var_.characterEffect10170ui_story and not isNil(var_164_22) then
					arg_161_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_23 + var_164_24 and arg_161_1.time_ < var_164_23 + var_164_24 + arg_164_0 and not isNil(var_164_22) and arg_161_1.var_.characterEffect10170ui_story then
				arg_161_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_164_26 = arg_161_1.actors_["10180ui_story"]
			local var_164_27 = 0

			if var_164_27 < arg_161_1.time_ and arg_161_1.time_ <= var_164_27 + arg_164_0 and not isNil(var_164_26) and arg_161_1.var_.characterEffect10180ui_story == nil then
				arg_161_1.var_.characterEffect10180ui_story = var_164_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_28 = 0.200000002980232

			if var_164_27 <= arg_161_1.time_ and arg_161_1.time_ < var_164_27 + var_164_28 and not isNil(var_164_26) then
				local var_164_29 = (arg_161_1.time_ - var_164_27) / var_164_28

				if arg_161_1.var_.characterEffect10180ui_story and not isNil(var_164_26) then
					local var_164_30 = Mathf.Lerp(0, 0.5, var_164_29)

					arg_161_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10180ui_story.fillRatio = var_164_30
				end
			end

			if arg_161_1.time_ >= var_164_27 + var_164_28 and arg_161_1.time_ < var_164_27 + var_164_28 + arg_164_0 and not isNil(var_164_26) and arg_161_1.var_.characterEffect10180ui_story then
				local var_164_31 = 0.5

				arg_161_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10180ui_story.fillRatio = var_164_31
			end

			local var_164_32 = 0

			if var_164_32 < arg_161_1.time_ and arg_161_1.time_ <= var_164_32 + arg_164_0 then
				arg_161_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_164_33 = 0

			if var_164_33 < arg_161_1.time_ and arg_161_1.time_ <= var_164_33 + arg_164_0 then
				arg_161_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_164_34 = 0
			local var_164_35 = 0.25

			if var_164_34 < arg_161_1.time_ and arg_161_1.time_ <= var_164_34 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_36 = arg_161_1:FormatText(StoryNameCfg[1450].name)

				arg_161_1.leftNameTxt_.text = var_164_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_37 = arg_161_1:GetWordFromCfg(325601039)
				local var_164_38 = arg_161_1:FormatText(var_164_37.content)

				arg_161_1.text_.text = var_164_38

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_39 = 10
				local var_164_40 = utf8.len(var_164_38)
				local var_164_41 = var_164_39 <= 0 and var_164_35 or var_164_35 * (var_164_40 / var_164_39)

				if var_164_41 > 0 and var_164_35 < var_164_41 then
					arg_161_1.talkMaxDuration = var_164_41

					if var_164_41 + var_164_34 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_41 + var_164_34
					end
				end

				arg_161_1.text_.text = var_164_38
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601039", "story_v_out_325601.awb") ~= 0 then
					local var_164_42 = manager.audio:GetVoiceLength("story_v_out_325601", "325601039", "story_v_out_325601.awb") / 1000

					if var_164_42 + var_164_34 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_42 + var_164_34
					end

					if var_164_37.prefab_name ~= "" and arg_161_1.actors_[var_164_37.prefab_name] ~= nil then
						local var_164_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_37.prefab_name].transform, "story_v_out_325601", "325601039", "story_v_out_325601.awb")

						arg_161_1:RecordAudio("325601039", var_164_43)
						arg_161_1:RecordAudio("325601039", var_164_43)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_325601", "325601039", "story_v_out_325601.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_325601", "325601039", "story_v_out_325601.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_44 = math.max(var_164_35, arg_161_1.talkMaxDuration)

			if var_164_34 <= arg_161_1.time_ and arg_161_1.time_ < var_164_34 + var_164_44 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_34) / var_164_44

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_34 + var_164_44 and arg_161_1.time_ < var_164_34 + var_164_44 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play325601040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 325601040
		arg_165_1.duration_ = 17.33

		local var_165_0 = {
			zh = 10.866,
			ja = 17.333
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play325601041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10180ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10180ui_story == nil then
				arg_165_1.var_.characterEffect10180ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect10180ui_story and not isNil(var_168_0) then
					arg_165_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10180ui_story then
				arg_165_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_168_4 = arg_165_1.actors_["10170ui_story"]
			local var_168_5 = 0

			if var_168_5 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect10170ui_story == nil then
				arg_165_1.var_.characterEffect10170ui_story = var_168_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_6 = 0.200000002980232

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_6 and not isNil(var_168_4) then
				local var_168_7 = (arg_165_1.time_ - var_168_5) / var_168_6

				if arg_165_1.var_.characterEffect10170ui_story and not isNil(var_168_4) then
					local var_168_8 = Mathf.Lerp(0, 0.5, var_168_7)

					arg_165_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10170ui_story.fillRatio = var_168_8
				end
			end

			if arg_165_1.time_ >= var_168_5 + var_168_6 and arg_165_1.time_ < var_168_5 + var_168_6 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect10170ui_story then
				local var_168_9 = 0.5

				arg_165_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10170ui_story.fillRatio = var_168_9
			end

			local var_168_10 = 0
			local var_168_11 = 0.9

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_12 = arg_165_1:FormatText(StoryNameCfg[1503].name)

				arg_165_1.leftNameTxt_.text = var_168_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_13 = arg_165_1:GetWordFromCfg(325601040)
				local var_168_14 = arg_165_1:FormatText(var_168_13.content)

				arg_165_1.text_.text = var_168_14

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_15 = 36
				local var_168_16 = utf8.len(var_168_14)
				local var_168_17 = var_168_15 <= 0 and var_168_11 or var_168_11 * (var_168_16 / var_168_15)

				if var_168_17 > 0 and var_168_11 < var_168_17 then
					arg_165_1.talkMaxDuration = var_168_17

					if var_168_17 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_17 + var_168_10
					end
				end

				arg_165_1.text_.text = var_168_14
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601040", "story_v_out_325601.awb") ~= 0 then
					local var_168_18 = manager.audio:GetVoiceLength("story_v_out_325601", "325601040", "story_v_out_325601.awb") / 1000

					if var_168_18 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_18 + var_168_10
					end

					if var_168_13.prefab_name ~= "" and arg_165_1.actors_[var_168_13.prefab_name] ~= nil then
						local var_168_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_13.prefab_name].transform, "story_v_out_325601", "325601040", "story_v_out_325601.awb")

						arg_165_1:RecordAudio("325601040", var_168_19)
						arg_165_1:RecordAudio("325601040", var_168_19)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_325601", "325601040", "story_v_out_325601.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_325601", "325601040", "story_v_out_325601.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_20 = math.max(var_168_11, arg_165_1.talkMaxDuration)

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_20 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_10) / var_168_20

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_10 + var_168_20 and arg_165_1.time_ < var_168_10 + var_168_20 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play325601041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 325601041
		arg_169_1.duration_ = 20.9

		local var_169_0 = {
			zh = 7,
			ja = 20.9
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play325601042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action19_1")
			end

			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_172_2 = 0
			local var_172_3 = 0.6

			if var_172_2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_4 = arg_169_1:FormatText(StoryNameCfg[1503].name)

				arg_169_1.leftNameTxt_.text = var_172_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_5 = arg_169_1:GetWordFromCfg(325601041)
				local var_172_6 = arg_169_1:FormatText(var_172_5.content)

				arg_169_1.text_.text = var_172_6

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 24
				local var_172_8 = utf8.len(var_172_6)
				local var_172_9 = var_172_7 <= 0 and var_172_3 or var_172_3 * (var_172_8 / var_172_7)

				if var_172_9 > 0 and var_172_3 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_6
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601041", "story_v_out_325601.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_325601", "325601041", "story_v_out_325601.awb") / 1000

					if var_172_10 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_2
					end

					if var_172_5.prefab_name ~= "" and arg_169_1.actors_[var_172_5.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_5.prefab_name].transform, "story_v_out_325601", "325601041", "story_v_out_325601.awb")

						arg_169_1:RecordAudio("325601041", var_172_11)
						arg_169_1:RecordAudio("325601041", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_325601", "325601041", "story_v_out_325601.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_325601", "325601041", "story_v_out_325601.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_12 and arg_169_1.time_ < var_172_2 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play325601042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 325601042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play325601043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10180ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect10180ui_story == nil then
				arg_173_1.var_.characterEffect10180ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect10180ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10180ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect10180ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10180ui_story.fillRatio = var_176_5
			end

			local var_176_6 = 0
			local var_176_7 = 1.15

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_8 = arg_173_1:FormatText(StoryNameCfg[7].name)

				arg_173_1.leftNameTxt_.text = var_176_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_9 = arg_173_1:GetWordFromCfg(325601042)
				local var_176_10 = arg_173_1:FormatText(var_176_9.content)

				arg_173_1.text_.text = var_176_10

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 46
				local var_176_12 = utf8.len(var_176_10)
				local var_176_13 = var_176_11 <= 0 and var_176_7 or var_176_7 * (var_176_12 / var_176_11)

				if var_176_13 > 0 and var_176_7 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_10
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_14 and arg_173_1.time_ < var_176_6 + var_176_14 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play325601043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 325601043
		arg_177_1.duration_ = 11.67

		local var_177_0 = {
			zh = 11.666,
			ja = 8.733
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play325601044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10180ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10180ui_story == nil then
				arg_177_1.var_.characterEffect10180ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect10180ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10180ui_story then
				arg_177_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_180_4 = 0

			if var_180_4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action19_2")
			end

			local var_180_5 = 0

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_180_6 = 0
			local var_180_7 = 0.95

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_8 = arg_177_1:FormatText(StoryNameCfg[1503].name)

				arg_177_1.leftNameTxt_.text = var_180_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_9 = arg_177_1:GetWordFromCfg(325601043)
				local var_180_10 = arg_177_1:FormatText(var_180_9.content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 38
				local var_180_12 = utf8.len(var_180_10)
				local var_180_13 = var_180_11 <= 0 and var_180_7 or var_180_7 * (var_180_12 / var_180_11)

				if var_180_13 > 0 and var_180_7 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601043", "story_v_out_325601.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_out_325601", "325601043", "story_v_out_325601.awb") / 1000

					if var_180_14 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_6
					end

					if var_180_9.prefab_name ~= "" and arg_177_1.actors_[var_180_9.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_9.prefab_name].transform, "story_v_out_325601", "325601043", "story_v_out_325601.awb")

						arg_177_1:RecordAudio("325601043", var_180_15)
						arg_177_1:RecordAudio("325601043", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_325601", "325601043", "story_v_out_325601.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_325601", "325601043", "story_v_out_325601.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_16 and arg_177_1.time_ < var_180_6 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play325601044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 325601044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play325601045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10180ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10180ui_story == nil then
				arg_181_1.var_.characterEffect10180ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect10180ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10180ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10180ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10180ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 0.35

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_8 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_9 = arg_181_1:GetWordFromCfg(325601044)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 14
				local var_184_12 = utf8.len(var_184_10)
				local var_184_13 = var_184_11 <= 0 and var_184_7 or var_184_7 * (var_184_12 / var_184_11)

				if var_184_13 > 0 and var_184_7 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play325601045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 325601045
		arg_185_1.duration_ = 13

		local var_185_0 = {
			zh = 8.5,
			ja = 13
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play325601046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10180ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect10180ui_story == nil then
				arg_185_1.var_.characterEffect10180ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect10180ui_story and not isNil(var_188_0) then
					arg_185_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect10180ui_story then
				arg_185_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_188_4 = 0
			local var_188_5 = 0.75

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_6 = arg_185_1:FormatText(StoryNameCfg[1503].name)

				arg_185_1.leftNameTxt_.text = var_188_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_7 = arg_185_1:GetWordFromCfg(325601045)
				local var_188_8 = arg_185_1:FormatText(var_188_7.content)

				arg_185_1.text_.text = var_188_8

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 30
				local var_188_10 = utf8.len(var_188_8)
				local var_188_11 = var_188_9 <= 0 and var_188_5 or var_188_5 * (var_188_10 / var_188_9)

				if var_188_11 > 0 and var_188_5 < var_188_11 then
					arg_185_1.talkMaxDuration = var_188_11

					if var_188_11 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_11 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_8
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601045", "story_v_out_325601.awb") ~= 0 then
					local var_188_12 = manager.audio:GetVoiceLength("story_v_out_325601", "325601045", "story_v_out_325601.awb") / 1000

					if var_188_12 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_12 + var_188_4
					end

					if var_188_7.prefab_name ~= "" and arg_185_1.actors_[var_188_7.prefab_name] ~= nil then
						local var_188_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_7.prefab_name].transform, "story_v_out_325601", "325601045", "story_v_out_325601.awb")

						arg_185_1:RecordAudio("325601045", var_188_13)
						arg_185_1:RecordAudio("325601045", var_188_13)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_325601", "325601045", "story_v_out_325601.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_325601", "325601045", "story_v_out_325601.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_14 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_14 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_14

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_14 and arg_185_1.time_ < var_188_4 + var_188_14 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play325601046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 325601046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play325601047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10180ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10180ui_story == nil then
				arg_189_1.var_.characterEffect10180ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect10180ui_story and not isNil(var_192_0) then
					local var_192_4 = Mathf.Lerp(0, 0.5, var_192_3)

					arg_189_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_189_1.var_.characterEffect10180ui_story.fillRatio = var_192_4
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10180ui_story then
				local var_192_5 = 0.5

				arg_189_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_189_1.var_.characterEffect10180ui_story.fillRatio = var_192_5
			end

			local var_192_6 = 0
			local var_192_7 = 1.375

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_8 = arg_189_1:GetWordFromCfg(325601046)
				local var_192_9 = arg_189_1:FormatText(var_192_8.content)

				arg_189_1.text_.text = var_192_9

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 55
				local var_192_11 = utf8.len(var_192_9)
				local var_192_12 = var_192_10 <= 0 and var_192_7 or var_192_7 * (var_192_11 / var_192_10)

				if var_192_12 > 0 and var_192_7 < var_192_12 then
					arg_189_1.talkMaxDuration = var_192_12

					if var_192_12 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_9
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_13 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_13 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_13

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_13 and arg_189_1.time_ < var_192_6 + var_192_13 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play325601047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 325601047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play325601048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.7

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(325601047)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 28
				local var_196_5 = utf8.len(var_196_3)
				local var_196_6 = var_196_4 <= 0 and var_196_1 or var_196_1 * (var_196_5 / var_196_4)

				if var_196_6 > 0 and var_196_1 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_7 and arg_193_1.time_ < var_196_0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play325601048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 325601048
		arg_197_1.duration_ = 3.67

		local var_197_0 = {
			zh = 2.533,
			ja = 3.666
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play325601049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10180ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect10180ui_story == nil then
				arg_197_1.var_.characterEffect10180ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect10180ui_story and not isNil(var_200_0) then
					arg_197_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect10180ui_story then
				arg_197_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_200_4 = 0
			local var_200_5 = 0.2

			if var_200_4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_6 = arg_197_1:FormatText(StoryNameCfg[1503].name)

				arg_197_1.leftNameTxt_.text = var_200_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_7 = arg_197_1:GetWordFromCfg(325601048)
				local var_200_8 = arg_197_1:FormatText(var_200_7.content)

				arg_197_1.text_.text = var_200_8

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 8
				local var_200_10 = utf8.len(var_200_8)
				local var_200_11 = var_200_9 <= 0 and var_200_5 or var_200_5 * (var_200_10 / var_200_9)

				if var_200_11 > 0 and var_200_5 < var_200_11 then
					arg_197_1.talkMaxDuration = var_200_11

					if var_200_11 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_8
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601048", "story_v_out_325601.awb") ~= 0 then
					local var_200_12 = manager.audio:GetVoiceLength("story_v_out_325601", "325601048", "story_v_out_325601.awb") / 1000

					if var_200_12 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_12 + var_200_4
					end

					if var_200_7.prefab_name ~= "" and arg_197_1.actors_[var_200_7.prefab_name] ~= nil then
						local var_200_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_7.prefab_name].transform, "story_v_out_325601", "325601048", "story_v_out_325601.awb")

						arg_197_1:RecordAudio("325601048", var_200_13)
						arg_197_1:RecordAudio("325601048", var_200_13)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_325601", "325601048", "story_v_out_325601.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_325601", "325601048", "story_v_out_325601.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_14 and arg_197_1.time_ < var_200_4 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play325601049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 325601049
		arg_201_1.duration_ = 1.97

		local var_201_0 = {
			zh = 1.966,
			ja = 1.8
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
				arg_201_0:Play325601050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10170ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect10170ui_story == nil then
				arg_201_1.var_.characterEffect10170ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect10170ui_story and not isNil(var_204_0) then
					arg_201_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect10170ui_story then
				arg_201_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_204_4 = arg_201_1.actors_["10180ui_story"]
			local var_204_5 = 0

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect10180ui_story == nil then
				arg_201_1.var_.characterEffect10180ui_story = var_204_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_6 = 0.200000002980232

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_6 and not isNil(var_204_4) then
				local var_204_7 = (arg_201_1.time_ - var_204_5) / var_204_6

				if arg_201_1.var_.characterEffect10180ui_story and not isNil(var_204_4) then
					local var_204_8 = Mathf.Lerp(0, 0.5, var_204_7)

					arg_201_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10180ui_story.fillRatio = var_204_8
				end
			end

			if arg_201_1.time_ >= var_204_5 + var_204_6 and arg_201_1.time_ < var_204_5 + var_204_6 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect10180ui_story then
				local var_204_9 = 0.5

				arg_201_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10180ui_story.fillRatio = var_204_9
			end

			local var_204_10 = 0
			local var_204_11 = 0.25

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_12 = arg_201_1:FormatText(StoryNameCfg[1450].name)

				arg_201_1.leftNameTxt_.text = var_204_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_13 = arg_201_1:GetWordFromCfg(325601049)
				local var_204_14 = arg_201_1:FormatText(var_204_13.content)

				arg_201_1.text_.text = var_204_14

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_15 = 10
				local var_204_16 = utf8.len(var_204_14)
				local var_204_17 = var_204_15 <= 0 and var_204_11 or var_204_11 * (var_204_16 / var_204_15)

				if var_204_17 > 0 and var_204_11 < var_204_17 then
					arg_201_1.talkMaxDuration = var_204_17

					if var_204_17 + var_204_10 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_17 + var_204_10
					end
				end

				arg_201_1.text_.text = var_204_14
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601049", "story_v_out_325601.awb") ~= 0 then
					local var_204_18 = manager.audio:GetVoiceLength("story_v_out_325601", "325601049", "story_v_out_325601.awb") / 1000

					if var_204_18 + var_204_10 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_18 + var_204_10
					end

					if var_204_13.prefab_name ~= "" and arg_201_1.actors_[var_204_13.prefab_name] ~= nil then
						local var_204_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_13.prefab_name].transform, "story_v_out_325601", "325601049", "story_v_out_325601.awb")

						arg_201_1:RecordAudio("325601049", var_204_19)
						arg_201_1:RecordAudio("325601049", var_204_19)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_325601", "325601049", "story_v_out_325601.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_325601", "325601049", "story_v_out_325601.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_20 = math.max(var_204_11, arg_201_1.talkMaxDuration)

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_20 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_10) / var_204_20

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_10 + var_204_20 and arg_201_1.time_ < var_204_10 + var_204_20 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play325601050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 325601050
		arg_205_1.duration_ = 12.13

		local var_205_0 = {
			zh = 5.466,
			ja = 12.133
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play325601051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10180ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect10180ui_story == nil then
				arg_205_1.var_.characterEffect10180ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect10180ui_story and not isNil(var_208_0) then
					arg_205_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect10180ui_story then
				arg_205_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_208_4 = arg_205_1.actors_["10170ui_story"]
			local var_208_5 = 0

			if var_208_5 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect10170ui_story == nil then
				arg_205_1.var_.characterEffect10170ui_story = var_208_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_6 = 0.200000002980232

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_6 and not isNil(var_208_4) then
				local var_208_7 = (arg_205_1.time_ - var_208_5) / var_208_6

				if arg_205_1.var_.characterEffect10170ui_story and not isNil(var_208_4) then
					local var_208_8 = Mathf.Lerp(0, 0.5, var_208_7)

					arg_205_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_205_1.var_.characterEffect10170ui_story.fillRatio = var_208_8
				end
			end

			if arg_205_1.time_ >= var_208_5 + var_208_6 and arg_205_1.time_ < var_208_5 + var_208_6 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect10170ui_story then
				local var_208_9 = 0.5

				arg_205_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_205_1.var_.characterEffect10170ui_story.fillRatio = var_208_9
			end

			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 then
				arg_205_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action4_1")
			end

			local var_208_11 = 0

			if var_208_11 < arg_205_1.time_ and arg_205_1.time_ <= var_208_11 + arg_208_0 then
				arg_205_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_208_12 = 0
			local var_208_13 = 0.525

			if var_208_12 < arg_205_1.time_ and arg_205_1.time_ <= var_208_12 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_14 = arg_205_1:FormatText(StoryNameCfg[1503].name)

				arg_205_1.leftNameTxt_.text = var_208_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_15 = arg_205_1:GetWordFromCfg(325601050)
				local var_208_16 = arg_205_1:FormatText(var_208_15.content)

				arg_205_1.text_.text = var_208_16

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_17 = 21
				local var_208_18 = utf8.len(var_208_16)
				local var_208_19 = var_208_17 <= 0 and var_208_13 or var_208_13 * (var_208_18 / var_208_17)

				if var_208_19 > 0 and var_208_13 < var_208_19 then
					arg_205_1.talkMaxDuration = var_208_19

					if var_208_19 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_19 + var_208_12
					end
				end

				arg_205_1.text_.text = var_208_16
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601050", "story_v_out_325601.awb") ~= 0 then
					local var_208_20 = manager.audio:GetVoiceLength("story_v_out_325601", "325601050", "story_v_out_325601.awb") / 1000

					if var_208_20 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_20 + var_208_12
					end

					if var_208_15.prefab_name ~= "" and arg_205_1.actors_[var_208_15.prefab_name] ~= nil then
						local var_208_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_15.prefab_name].transform, "story_v_out_325601", "325601050", "story_v_out_325601.awb")

						arg_205_1:RecordAudio("325601050", var_208_21)
						arg_205_1:RecordAudio("325601050", var_208_21)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_325601", "325601050", "story_v_out_325601.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_325601", "325601050", "story_v_out_325601.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_22 = math.max(var_208_13, arg_205_1.talkMaxDuration)

			if var_208_12 <= arg_205_1.time_ and arg_205_1.time_ < var_208_12 + var_208_22 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_12) / var_208_22

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_12 + var_208_22 and arg_205_1.time_ < var_208_12 + var_208_22 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play325601051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 325601051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play325601052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10180ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos10180ui_story = var_212_0.localPosition

				local var_212_2 = GameObjectTools.GetOrAddComponent(var_212_0.gameObject, typeof(DynamicBoneHelper))

				if var_212_2 then
					var_212_2:EnableDynamicBone(false)
				end
			end

			local var_212_3 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_3 then
				local var_212_4 = (arg_209_1.time_ - var_212_1) / var_212_3
				local var_212_5 = Vector3.New(0, 100, 0)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10180ui_story, var_212_5, var_212_4)

				local var_212_6 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_6.x, var_212_6.y, var_212_6.z)

				local var_212_7 = var_212_0.localEulerAngles

				var_212_7.z = 0
				var_212_7.x = 0
				var_212_0.localEulerAngles = var_212_7
			end

			if arg_209_1.time_ >= var_212_1 + var_212_3 and arg_209_1.time_ < var_212_1 + var_212_3 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_212_11 = arg_209_1.actors_["10170ui_story"].transform
			local var_212_12 = 0

			if var_212_12 < arg_209_1.time_ and arg_209_1.time_ <= var_212_12 + arg_212_0 then
				arg_209_1.var_.moveOldPos10170ui_story = var_212_11.localPosition

				local var_212_13 = GameObjectTools.GetOrAddComponent(var_212_11.gameObject, typeof(DynamicBoneHelper))

				if var_212_13 then
					var_212_13:EnableDynamicBone(false)
				end
			end

			local var_212_14 = 0.001

			if var_212_12 <= arg_209_1.time_ and arg_209_1.time_ < var_212_12 + var_212_14 then
				local var_212_15 = (arg_209_1.time_ - var_212_12) / var_212_14
				local var_212_16 = Vector3.New(0, 100, 0)

				var_212_11.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10170ui_story, var_212_16, var_212_15)

				local var_212_17 = manager.ui.mainCamera.transform.position - var_212_11.position

				var_212_11.forward = Vector3.New(var_212_17.x, var_212_17.y, var_212_17.z)

				local var_212_18 = var_212_11.localEulerAngles

				var_212_18.z = 0
				var_212_18.x = 0
				var_212_11.localEulerAngles = var_212_18
			end

			if arg_209_1.time_ >= var_212_12 + var_212_14 and arg_209_1.time_ < var_212_12 + var_212_14 + arg_212_0 then
				var_212_11.localPosition = Vector3.New(0, 100, 0)

				local var_212_19 = manager.ui.mainCamera.transform.position - var_212_11.position

				var_212_11.forward = Vector3.New(var_212_19.x, var_212_19.y, var_212_19.z)

				local var_212_20 = var_212_11.localEulerAngles

				var_212_20.z = 0
				var_212_20.x = 0
				var_212_11.localEulerAngles = var_212_20

				local var_212_21 = GameObjectTools.GetOrAddComponent(var_212_11.gameObject, typeof(DynamicBoneHelper))

				if var_212_21 then
					var_212_21:EnableDynamicBone(true)
				end
			end

			local var_212_22 = arg_209_1.actors_["10180ui_story"]
			local var_212_23 = 0

			if var_212_23 < arg_209_1.time_ and arg_209_1.time_ <= var_212_23 + arg_212_0 and not isNil(var_212_22) and arg_209_1.var_.characterEffect10180ui_story == nil then
				arg_209_1.var_.characterEffect10180ui_story = var_212_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_24 = 0.200000002980232

			if var_212_23 <= arg_209_1.time_ and arg_209_1.time_ < var_212_23 + var_212_24 and not isNil(var_212_22) then
				local var_212_25 = (arg_209_1.time_ - var_212_23) / var_212_24

				if arg_209_1.var_.characterEffect10180ui_story and not isNil(var_212_22) then
					local var_212_26 = Mathf.Lerp(0, 0.5, var_212_25)

					arg_209_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_209_1.var_.characterEffect10180ui_story.fillRatio = var_212_26
				end
			end

			if arg_209_1.time_ >= var_212_23 + var_212_24 and arg_209_1.time_ < var_212_23 + var_212_24 + arg_212_0 and not isNil(var_212_22) and arg_209_1.var_.characterEffect10180ui_story then
				local var_212_27 = 0.5

				arg_209_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_209_1.var_.characterEffect10180ui_story.fillRatio = var_212_27
			end

			local var_212_28 = 0.1
			local var_212_29 = 1

			if var_212_28 < arg_209_1.time_ and arg_209_1.time_ <= var_212_28 + arg_212_0 then
				local var_212_30 = "play"
				local var_212_31 = "effect"

				arg_209_1:AudioAction(var_212_30, var_212_31, "se_story_145", "se_story_145_magic_whoosh01", "")
			end

			local var_212_32 = 0
			local var_212_33 = 1

			if var_212_32 < arg_209_1.time_ and arg_209_1.time_ <= var_212_32 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_34 = arg_209_1:GetWordFromCfg(325601051)
				local var_212_35 = arg_209_1:FormatText(var_212_34.content)

				arg_209_1.text_.text = var_212_35

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_36 = 40
				local var_212_37 = utf8.len(var_212_35)
				local var_212_38 = var_212_36 <= 0 and var_212_33 or var_212_33 * (var_212_37 / var_212_36)

				if var_212_38 > 0 and var_212_33 < var_212_38 then
					arg_209_1.talkMaxDuration = var_212_38

					if var_212_38 + var_212_32 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_38 + var_212_32
					end
				end

				arg_209_1.text_.text = var_212_35
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_39 = math.max(var_212_33, arg_209_1.talkMaxDuration)

			if var_212_32 <= arg_209_1.time_ and arg_209_1.time_ < var_212_32 + var_212_39 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_32) / var_212_39

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_32 + var_212_39 and arg_209_1.time_ < var_212_32 + var_212_39 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play325601052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 325601052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play325601053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.05

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[1535].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3071")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(325601052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 2
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_8 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_8 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_8

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_8 and arg_213_1.time_ < var_216_0 + var_216_8 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play325601053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 325601053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play325601054(arg_217_1)
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

				local var_220_3 = arg_217_1:GetWordFromCfg(325601053)
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
	Play325601054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 325601054
		arg_221_1.duration_ = 2

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play325601055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10170ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10170ui_story = var_224_0.localPosition

				local var_224_2 = GameObjectTools.GetOrAddComponent(var_224_0.gameObject, typeof(DynamicBoneHelper))

				if var_224_2 then
					var_224_2:EnableDynamicBone(false)
				end
			end

			local var_224_3 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_3 then
				local var_224_4 = (arg_221_1.time_ - var_224_1) / var_224_3
				local var_224_5 = Vector3.New(0, -1.03, -6.05)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10170ui_story, var_224_5, var_224_4)

				local var_224_6 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_6.x, var_224_6.y, var_224_6.z)

				local var_224_7 = var_224_0.localEulerAngles

				var_224_7.z = 0
				var_224_7.x = 0
				var_224_0.localEulerAngles = var_224_7
			end

			if arg_221_1.time_ >= var_224_1 + var_224_3 and arg_221_1.time_ < var_224_1 + var_224_3 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -1.03, -6.05)

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

			local var_224_11 = arg_221_1.actors_["10170ui_story"]
			local var_224_12 = 0

			if var_224_12 < arg_221_1.time_ and arg_221_1.time_ <= var_224_12 + arg_224_0 and not isNil(var_224_11) and arg_221_1.var_.characterEffect10170ui_story == nil then
				arg_221_1.var_.characterEffect10170ui_story = var_224_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_13 = 0.200000002980232

			if var_224_12 <= arg_221_1.time_ and arg_221_1.time_ < var_224_12 + var_224_13 and not isNil(var_224_11) then
				local var_224_14 = (arg_221_1.time_ - var_224_12) / var_224_13

				if arg_221_1.var_.characterEffect10170ui_story and not isNil(var_224_11) then
					arg_221_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_12 + var_224_13 and arg_221_1.time_ < var_224_12 + var_224_13 + arg_224_0 and not isNil(var_224_11) and arg_221_1.var_.characterEffect10170ui_story then
				arg_221_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_224_15 = 0

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 then
				arg_221_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_224_17 = 0
			local var_224_18 = 0.15

			if var_224_17 < arg_221_1.time_ and arg_221_1.time_ <= var_224_17 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_19 = arg_221_1:FormatText(StoryNameCfg[1450].name)

				arg_221_1.leftNameTxt_.text = var_224_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_20 = arg_221_1:GetWordFromCfg(325601054)
				local var_224_21 = arg_221_1:FormatText(var_224_20.content)

				arg_221_1.text_.text = var_224_21

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_22 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601054", "story_v_out_325601.awb") ~= 0 then
					local var_224_25 = manager.audio:GetVoiceLength("story_v_out_325601", "325601054", "story_v_out_325601.awb") / 1000

					if var_224_25 + var_224_17 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_25 + var_224_17
					end

					if var_224_20.prefab_name ~= "" and arg_221_1.actors_[var_224_20.prefab_name] ~= nil then
						local var_224_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_20.prefab_name].transform, "story_v_out_325601", "325601054", "story_v_out_325601.awb")

						arg_221_1:RecordAudio("325601054", var_224_26)
						arg_221_1:RecordAudio("325601054", var_224_26)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_325601", "325601054", "story_v_out_325601.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_325601", "325601054", "story_v_out_325601.awb")
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
				actorName = "10170ui_story",
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
	Play325601055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 325601055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play325601056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10170ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect10170ui_story == nil then
				arg_225_1.var_.characterEffect10170ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect10170ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10170ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect10170ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10170ui_story.fillRatio = var_228_5
			end

			local var_228_6 = 0
			local var_228_7 = 0.375

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

				local var_228_9 = arg_225_1:GetWordFromCfg(325601055)
				local var_228_10 = arg_225_1:FormatText(var_228_9.content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 15
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
	Play325601056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 325601056
		arg_229_1.duration_ = 5.7

		local var_229_0 = {
			zh = 3.666,
			ja = 5.7
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
				arg_229_0:Play325601057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10170ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect10170ui_story == nil then
				arg_229_1.var_.characterEffect10170ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect10170ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect10170ui_story then
				arg_229_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_232_4 = 0
			local var_232_5 = 0.425

			if var_232_4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_6 = arg_229_1:FormatText(StoryNameCfg[1450].name)

				arg_229_1.leftNameTxt_.text = var_232_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_7 = arg_229_1:GetWordFromCfg(325601056)
				local var_232_8 = arg_229_1:FormatText(var_232_7.content)

				arg_229_1.text_.text = var_232_8

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 17
				local var_232_10 = utf8.len(var_232_8)
				local var_232_11 = var_232_9 <= 0 and var_232_5 or var_232_5 * (var_232_10 / var_232_9)

				if var_232_11 > 0 and var_232_5 < var_232_11 then
					arg_229_1.talkMaxDuration = var_232_11

					if var_232_11 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_11 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_8
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601056", "story_v_out_325601.awb") ~= 0 then
					local var_232_12 = manager.audio:GetVoiceLength("story_v_out_325601", "325601056", "story_v_out_325601.awb") / 1000

					if var_232_12 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_12 + var_232_4
					end

					if var_232_7.prefab_name ~= "" and arg_229_1.actors_[var_232_7.prefab_name] ~= nil then
						local var_232_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_7.prefab_name].transform, "story_v_out_325601", "325601056", "story_v_out_325601.awb")

						arg_229_1:RecordAudio("325601056", var_232_13)
						arg_229_1:RecordAudio("325601056", var_232_13)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_325601", "325601056", "story_v_out_325601.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_325601", "325601056", "story_v_out_325601.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_14 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_14 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_14

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_14 and arg_229_1.time_ < var_232_4 + var_232_14 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play325601057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 325601057
		arg_233_1.duration_ = 6.43

		local var_233_0 = {
			zh = 3.466,
			ja = 6.433
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
				arg_233_0:Play325601058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10170ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos10170ui_story = var_236_0.localPosition

				local var_236_2 = GameObjectTools.GetOrAddComponent(var_236_0.gameObject, typeof(DynamicBoneHelper))

				if var_236_2 then
					var_236_2:EnableDynamicBone(false)
				end
			end

			local var_236_3 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_3 then
				local var_236_4 = (arg_233_1.time_ - var_236_1) / var_236_3
				local var_236_5 = Vector3.New(-0.7, -1.03, -6.05)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10170ui_story, var_236_5, var_236_4)

				local var_236_6 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_6.x, var_236_6.y, var_236_6.z)

				local var_236_7 = var_236_0.localEulerAngles

				var_236_7.z = 0
				var_236_7.x = 0
				var_236_0.localEulerAngles = var_236_7
			end

			if arg_233_1.time_ >= var_236_1 + var_236_3 and arg_233_1.time_ < var_236_1 + var_236_3 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(-0.7, -1.03, -6.05)

				local var_236_8 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_8.x, var_236_8.y, var_236_8.z)

				local var_236_9 = var_236_0.localEulerAngles

				var_236_9.z = 0
				var_236_9.x = 0
				var_236_0.localEulerAngles = var_236_9

				local var_236_10 = GameObjectTools.GetOrAddComponent(var_236_0.gameObject, typeof(DynamicBoneHelper))

				if var_236_10 then
					var_236_10:EnableDynamicBone(true)
				end
			end

			local var_236_11 = arg_233_1.actors_["10180ui_story"].transform
			local var_236_12 = 0

			if var_236_12 < arg_233_1.time_ and arg_233_1.time_ <= var_236_12 + arg_236_0 then
				arg_233_1.var_.moveOldPos10180ui_story = var_236_11.localPosition

				local var_236_13 = GameObjectTools.GetOrAddComponent(var_236_11.gameObject, typeof(DynamicBoneHelper))

				if var_236_13 then
					var_236_13:EnableDynamicBone(false)
				end
			end

			local var_236_14 = 0.001

			if var_236_12 <= arg_233_1.time_ and arg_233_1.time_ < var_236_12 + var_236_14 then
				local var_236_15 = (arg_233_1.time_ - var_236_12) / var_236_14
				local var_236_16 = Vector3.New(0.8, -1.09, -6.14)

				var_236_11.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10180ui_story, var_236_16, var_236_15)

				local var_236_17 = manager.ui.mainCamera.transform.position - var_236_11.position

				var_236_11.forward = Vector3.New(var_236_17.x, var_236_17.y, var_236_17.z)

				local var_236_18 = var_236_11.localEulerAngles

				var_236_18.z = 0
				var_236_18.x = 0
				var_236_11.localEulerAngles = var_236_18
			end

			if arg_233_1.time_ >= var_236_12 + var_236_14 and arg_233_1.time_ < var_236_12 + var_236_14 + arg_236_0 then
				var_236_11.localPosition = Vector3.New(0.8, -1.09, -6.14)

				local var_236_19 = manager.ui.mainCamera.transform.position - var_236_11.position

				var_236_11.forward = Vector3.New(var_236_19.x, var_236_19.y, var_236_19.z)

				local var_236_20 = var_236_11.localEulerAngles

				var_236_20.z = 0
				var_236_20.x = 0
				var_236_11.localEulerAngles = var_236_20

				local var_236_21 = GameObjectTools.GetOrAddComponent(var_236_11.gameObject, typeof(DynamicBoneHelper))

				if var_236_21 then
					var_236_21:EnableDynamicBone(true)
				end
			end

			local var_236_22 = arg_233_1.actors_["10180ui_story"]
			local var_236_23 = 0

			if var_236_23 < arg_233_1.time_ and arg_233_1.time_ <= var_236_23 + arg_236_0 and not isNil(var_236_22) and arg_233_1.var_.characterEffect10180ui_story == nil then
				arg_233_1.var_.characterEffect10180ui_story = var_236_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_24 = 0.200000002980232

			if var_236_23 <= arg_233_1.time_ and arg_233_1.time_ < var_236_23 + var_236_24 and not isNil(var_236_22) then
				local var_236_25 = (arg_233_1.time_ - var_236_23) / var_236_24

				if arg_233_1.var_.characterEffect10180ui_story and not isNil(var_236_22) then
					arg_233_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_23 + var_236_24 and arg_233_1.time_ < var_236_23 + var_236_24 + arg_236_0 and not isNil(var_236_22) and arg_233_1.var_.characterEffect10180ui_story then
				arg_233_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_236_26 = arg_233_1.actors_["10170ui_story"]
			local var_236_27 = 0

			if var_236_27 < arg_233_1.time_ and arg_233_1.time_ <= var_236_27 + arg_236_0 and not isNil(var_236_26) and arg_233_1.var_.characterEffect10170ui_story == nil then
				arg_233_1.var_.characterEffect10170ui_story = var_236_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_28 = 0.200000002980232

			if var_236_27 <= arg_233_1.time_ and arg_233_1.time_ < var_236_27 + var_236_28 and not isNil(var_236_26) then
				local var_236_29 = (arg_233_1.time_ - var_236_27) / var_236_28

				if arg_233_1.var_.characterEffect10170ui_story and not isNil(var_236_26) then
					local var_236_30 = Mathf.Lerp(0, 0.5, var_236_29)

					arg_233_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_233_1.var_.characterEffect10170ui_story.fillRatio = var_236_30
				end
			end

			if arg_233_1.time_ >= var_236_27 + var_236_28 and arg_233_1.time_ < var_236_27 + var_236_28 + arg_236_0 and not isNil(var_236_26) and arg_233_1.var_.characterEffect10170ui_story then
				local var_236_31 = 0.5

				arg_233_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_233_1.var_.characterEffect10170ui_story.fillRatio = var_236_31
			end

			local var_236_32 = 0

			if var_236_32 < arg_233_1.time_ and arg_233_1.time_ <= var_236_32 + arg_236_0 then
				arg_233_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action4_2")
			end

			local var_236_33 = 0

			if var_236_33 < arg_233_1.time_ and arg_233_1.time_ <= var_236_33 + arg_236_0 then
				arg_233_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_236_34 = 0
			local var_236_35 = 0.35

			if var_236_34 < arg_233_1.time_ and arg_233_1.time_ <= var_236_34 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_36 = arg_233_1:FormatText(StoryNameCfg[1503].name)

				arg_233_1.leftNameTxt_.text = var_236_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_37 = arg_233_1:GetWordFromCfg(325601057)
				local var_236_38 = arg_233_1:FormatText(var_236_37.content)

				arg_233_1.text_.text = var_236_38

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_39 = 14
				local var_236_40 = utf8.len(var_236_38)
				local var_236_41 = var_236_39 <= 0 and var_236_35 or var_236_35 * (var_236_40 / var_236_39)

				if var_236_41 > 0 and var_236_35 < var_236_41 then
					arg_233_1.talkMaxDuration = var_236_41

					if var_236_41 + var_236_34 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_41 + var_236_34
					end
				end

				arg_233_1.text_.text = var_236_38
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601057", "story_v_out_325601.awb") ~= 0 then
					local var_236_42 = manager.audio:GetVoiceLength("story_v_out_325601", "325601057", "story_v_out_325601.awb") / 1000

					if var_236_42 + var_236_34 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_42 + var_236_34
					end

					if var_236_37.prefab_name ~= "" and arg_233_1.actors_[var_236_37.prefab_name] ~= nil then
						local var_236_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_37.prefab_name].transform, "story_v_out_325601", "325601057", "story_v_out_325601.awb")

						arg_233_1:RecordAudio("325601057", var_236_43)
						arg_233_1:RecordAudio("325601057", var_236_43)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_325601", "325601057", "story_v_out_325601.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_325601", "325601057", "story_v_out_325601.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_44 = math.max(var_236_35, arg_233_1.talkMaxDuration)

			if var_236_34 <= arg_233_1.time_ and arg_233_1.time_ < var_236_34 + var_236_44 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_34) / var_236_44

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_34 + var_236_44 and arg_233_1.time_ < var_236_34 + var_236_44 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325601058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 325601058
		arg_237_1.duration_ = 2

		local var_237_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_237_0:Play325601059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10170ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect10170ui_story == nil then
				arg_237_1.var_.characterEffect10170ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect10170ui_story and not isNil(var_240_0) then
					arg_237_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect10170ui_story then
				arg_237_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_240_4 = arg_237_1.actors_["10180ui_story"]
			local var_240_5 = 0

			if var_240_5 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 and not isNil(var_240_4) and arg_237_1.var_.characterEffect10180ui_story == nil then
				arg_237_1.var_.characterEffect10180ui_story = var_240_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_6 = 0.200000002980232

			if var_240_5 <= arg_237_1.time_ and arg_237_1.time_ < var_240_5 + var_240_6 and not isNil(var_240_4) then
				local var_240_7 = (arg_237_1.time_ - var_240_5) / var_240_6

				if arg_237_1.var_.characterEffect10180ui_story and not isNil(var_240_4) then
					local var_240_8 = Mathf.Lerp(0, 0.5, var_240_7)

					arg_237_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_237_1.var_.characterEffect10180ui_story.fillRatio = var_240_8
				end
			end

			if arg_237_1.time_ >= var_240_5 + var_240_6 and arg_237_1.time_ < var_240_5 + var_240_6 + arg_240_0 and not isNil(var_240_4) and arg_237_1.var_.characterEffect10180ui_story then
				local var_240_9 = 0.5

				arg_237_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_237_1.var_.characterEffect10180ui_story.fillRatio = var_240_9
			end

			local var_240_10 = 0

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 then
				arg_237_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			local var_240_11 = 0

			if var_240_11 < arg_237_1.time_ and arg_237_1.time_ <= var_240_11 + arg_240_0 then
				arg_237_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_240_12 = 0
			local var_240_13 = 0.15

			if var_240_12 < arg_237_1.time_ and arg_237_1.time_ <= var_240_12 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_14 = arg_237_1:FormatText(StoryNameCfg[1450].name)

				arg_237_1.leftNameTxt_.text = var_240_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_15 = arg_237_1:GetWordFromCfg(325601058)
				local var_240_16 = arg_237_1:FormatText(var_240_15.content)

				arg_237_1.text_.text = var_240_16

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_17 = 6
				local var_240_18 = utf8.len(var_240_16)
				local var_240_19 = var_240_17 <= 0 and var_240_13 or var_240_13 * (var_240_18 / var_240_17)

				if var_240_19 > 0 and var_240_13 < var_240_19 then
					arg_237_1.talkMaxDuration = var_240_19

					if var_240_19 + var_240_12 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_19 + var_240_12
					end
				end

				arg_237_1.text_.text = var_240_16
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601058", "story_v_out_325601.awb") ~= 0 then
					local var_240_20 = manager.audio:GetVoiceLength("story_v_out_325601", "325601058", "story_v_out_325601.awb") / 1000

					if var_240_20 + var_240_12 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_20 + var_240_12
					end

					if var_240_15.prefab_name ~= "" and arg_237_1.actors_[var_240_15.prefab_name] ~= nil then
						local var_240_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_15.prefab_name].transform, "story_v_out_325601", "325601058", "story_v_out_325601.awb")

						arg_237_1:RecordAudio("325601058", var_240_21)
						arg_237_1:RecordAudio("325601058", var_240_21)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_325601", "325601058", "story_v_out_325601.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_325601", "325601058", "story_v_out_325601.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_22 = math.max(var_240_13, arg_237_1.talkMaxDuration)

			if var_240_12 <= arg_237_1.time_ and arg_237_1.time_ < var_240_12 + var_240_22 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_12) / var_240_22

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_12 + var_240_22 and arg_237_1.time_ < var_240_12 + var_240_22 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play325601059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 325601059
		arg_241_1.duration_ = 5.4

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play325601060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10170ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos10170ui_story = var_244_0.localPosition

				local var_244_2 = GameObjectTools.GetOrAddComponent(var_244_0.gameObject, typeof(DynamicBoneHelper))

				if var_244_2 then
					var_244_2:EnableDynamicBone(false)
				end
			end

			local var_244_3 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_3 then
				local var_244_4 = (arg_241_1.time_ - var_244_1) / var_244_3
				local var_244_5 = Vector3.New(0, 100, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10170ui_story, var_244_5, var_244_4)

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

			local var_244_11 = arg_241_1.actors_["10180ui_story"].transform
			local var_244_12 = 0

			if var_244_12 < arg_241_1.time_ and arg_241_1.time_ <= var_244_12 + arg_244_0 then
				arg_241_1.var_.moveOldPos10180ui_story = var_244_11.localPosition

				local var_244_13 = GameObjectTools.GetOrAddComponent(var_244_11.gameObject, typeof(DynamicBoneHelper))

				if var_244_13 then
					var_244_13:EnableDynamicBone(false)
				end
			end

			local var_244_14 = 0.001

			if var_244_12 <= arg_241_1.time_ and arg_241_1.time_ < var_244_12 + var_244_14 then
				local var_244_15 = (arg_241_1.time_ - var_244_12) / var_244_14
				local var_244_16 = Vector3.New(0, 100, 0)

				var_244_11.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10180ui_story, var_244_16, var_244_15)

				local var_244_17 = manager.ui.mainCamera.transform.position - var_244_11.position

				var_244_11.forward = Vector3.New(var_244_17.x, var_244_17.y, var_244_17.z)

				local var_244_18 = var_244_11.localEulerAngles

				var_244_18.z = 0
				var_244_18.x = 0
				var_244_11.localEulerAngles = var_244_18
			end

			if arg_241_1.time_ >= var_244_12 + var_244_14 and arg_241_1.time_ < var_244_12 + var_244_14 + arg_244_0 then
				var_244_11.localPosition = Vector3.New(0, 100, 0)

				local var_244_19 = manager.ui.mainCamera.transform.position - var_244_11.position

				var_244_11.forward = Vector3.New(var_244_19.x, var_244_19.y, var_244_19.z)

				local var_244_20 = var_244_11.localEulerAngles

				var_244_20.z = 0
				var_244_20.x = 0
				var_244_11.localEulerAngles = var_244_20

				local var_244_21 = GameObjectTools.GetOrAddComponent(var_244_11.gameObject, typeof(DynamicBoneHelper))

				if var_244_21 then
					var_244_21:EnableDynamicBone(true)
				end
			end

			local var_244_22 = arg_241_1.actors_["10170ui_story"]
			local var_244_23 = 0

			if var_244_23 < arg_241_1.time_ and arg_241_1.time_ <= var_244_23 + arg_244_0 and not isNil(var_244_22) and arg_241_1.var_.characterEffect10170ui_story == nil then
				arg_241_1.var_.characterEffect10170ui_story = var_244_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_24 = 0.200000002980232

			if var_244_23 <= arg_241_1.time_ and arg_241_1.time_ < var_244_23 + var_244_24 and not isNil(var_244_22) then
				local var_244_25 = (arg_241_1.time_ - var_244_23) / var_244_24

				if arg_241_1.var_.characterEffect10170ui_story and not isNil(var_244_22) then
					local var_244_26 = Mathf.Lerp(0, 0.5, var_244_25)

					arg_241_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_241_1.var_.characterEffect10170ui_story.fillRatio = var_244_26
				end
			end

			if arg_241_1.time_ >= var_244_23 + var_244_24 and arg_241_1.time_ < var_244_23 + var_244_24 + arg_244_0 and not isNil(var_244_22) and arg_241_1.var_.characterEffect10170ui_story then
				local var_244_27 = 0.5

				arg_241_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_241_1.var_.characterEffect10170ui_story.fillRatio = var_244_27
			end

			local var_244_28 = manager.ui.mainCamera.transform
			local var_244_29 = 0

			if var_244_29 < arg_241_1.time_ and arg_241_1.time_ <= var_244_29 + arg_244_0 then
				arg_241_1.var_.shakeOldPos = var_244_28.localPosition
			end

			local var_244_30 = 0.4

			if var_244_29 <= arg_241_1.time_ and arg_241_1.time_ < var_244_29 + var_244_30 then
				local var_244_31 = (arg_241_1.time_ - var_244_29) / 0.066
				local var_244_32, var_244_33 = math.modf(var_244_31)

				var_244_28.localPosition = Vector3.New(var_244_33 * 0.13, var_244_33 * 0.13, var_244_33 * 0.13) + arg_241_1.var_.shakeOldPos
			end

			if arg_241_1.time_ >= var_244_29 + var_244_30 and arg_241_1.time_ < var_244_29 + var_244_30 + arg_244_0 then
				var_244_28.localPosition = arg_241_1.var_.shakeOldPos
			end

			local var_244_34 = 0

			if var_244_34 < arg_241_1.time_ and arg_241_1.time_ <= var_244_34 + arg_244_0 then
				arg_241_1.allBtn_.enabled = false
			end

			local var_244_35 = 0.4

			if arg_241_1.time_ >= var_244_34 + var_244_35 and arg_241_1.time_ < var_244_34 + var_244_35 + arg_244_0 then
				arg_241_1.allBtn_.enabled = true
			end

			if arg_241_1.frameCnt_ <= 1 then
				arg_241_1.dialog_:SetActive(false)
			end

			local var_244_36 = 0.4
			local var_244_37 = 1.325

			if var_244_36 < arg_241_1.time_ and arg_241_1.time_ <= var_244_36 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_38 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_38:setOnUpdate(LuaHelper.FloatAction(function(arg_245_0)
					arg_241_1.dialogCg_.alpha = arg_245_0
				end))
				var_244_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_39 = arg_241_1:GetWordFromCfg(325601059)
				local var_244_40 = arg_241_1:FormatText(var_244_39.content)

				arg_241_1.text_.text = var_244_40

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_41 = 53
				local var_244_42 = utf8.len(var_244_40)
				local var_244_43 = var_244_41 <= 0 and var_244_37 or var_244_37 * (var_244_42 / var_244_41)

				if var_244_43 > 0 and var_244_37 < var_244_43 then
					arg_241_1.talkMaxDuration = var_244_43
					var_244_36 = var_244_36 + 0.3

					if var_244_43 + var_244_36 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_43 + var_244_36
					end
				end

				arg_241_1.text_.text = var_244_40
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_44 = var_244_36 + 0.3
			local var_244_45 = math.max(var_244_37, arg_241_1.talkMaxDuration)

			if var_244_44 <= arg_241_1.time_ and arg_241_1.time_ < var_244_44 + var_244_45 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_44) / var_244_45

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_44 + var_244_45 and arg_241_1.time_ < var_244_44 + var_244_45 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325601060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 325601060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play325601061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 0.125

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[7].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:GetWordFromCfg(325601060)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 5
				local var_250_6 = utf8.len(var_250_4)
				local var_250_7 = var_250_5 <= 0 and var_250_1 or var_250_1 * (var_250_6 / var_250_5)

				if var_250_7 > 0 and var_250_1 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_8 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_8 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_8

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_8 and arg_247_1.time_ < var_250_0 + var_250_8 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play325601061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 325601061
		arg_251_1.duration_ = 5.23

		local var_251_0 = {
			zh = 4.033,
			ja = 5.233
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play325601062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10170ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos10170ui_story = var_254_0.localPosition

				local var_254_2 = GameObjectTools.GetOrAddComponent(var_254_0.gameObject, typeof(DynamicBoneHelper))

				if var_254_2 then
					var_254_2:EnableDynamicBone(false)
				end
			end

			local var_254_3 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_3 then
				local var_254_4 = (arg_251_1.time_ - var_254_1) / var_254_3
				local var_254_5 = Vector3.New(0, -1.03, -6.05)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10170ui_story, var_254_5, var_254_4)

				local var_254_6 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_6.x, var_254_6.y, var_254_6.z)

				local var_254_7 = var_254_0.localEulerAngles

				var_254_7.z = 0
				var_254_7.x = 0
				var_254_0.localEulerAngles = var_254_7
			end

			if arg_251_1.time_ >= var_254_1 + var_254_3 and arg_251_1.time_ < var_254_1 + var_254_3 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_254_8 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_8.x, var_254_8.y, var_254_8.z)

				local var_254_9 = var_254_0.localEulerAngles

				var_254_9.z = 0
				var_254_9.x = 0
				var_254_0.localEulerAngles = var_254_9

				local var_254_10 = GameObjectTools.GetOrAddComponent(var_254_0.gameObject, typeof(DynamicBoneHelper))

				if var_254_10 then
					var_254_10:EnableDynamicBone(true)
				end
			end

			local var_254_11 = arg_251_1.actors_["10170ui_story"]
			local var_254_12 = 0

			if var_254_12 < arg_251_1.time_ and arg_251_1.time_ <= var_254_12 + arg_254_0 and not isNil(var_254_11) and arg_251_1.var_.characterEffect10170ui_story == nil then
				arg_251_1.var_.characterEffect10170ui_story = var_254_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_13 = 0.200000002980232

			if var_254_12 <= arg_251_1.time_ and arg_251_1.time_ < var_254_12 + var_254_13 and not isNil(var_254_11) then
				local var_254_14 = (arg_251_1.time_ - var_254_12) / var_254_13

				if arg_251_1.var_.characterEffect10170ui_story and not isNil(var_254_11) then
					arg_251_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_12 + var_254_13 and arg_251_1.time_ < var_254_12 + var_254_13 + arg_254_0 and not isNil(var_254_11) and arg_251_1.var_.characterEffect10170ui_story then
				arg_251_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_254_15 = 0

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				arg_251_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_254_16 = 0

			if var_254_16 < arg_251_1.time_ and arg_251_1.time_ <= var_254_16 + arg_254_0 then
				arg_251_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_254_17 = 0
			local var_254_18 = 0.45

			if var_254_17 < arg_251_1.time_ and arg_251_1.time_ <= var_254_17 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_19 = arg_251_1:FormatText(StoryNameCfg[1450].name)

				arg_251_1.leftNameTxt_.text = var_254_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_20 = arg_251_1:GetWordFromCfg(325601061)
				local var_254_21 = arg_251_1:FormatText(var_254_20.content)

				arg_251_1.text_.text = var_254_21

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_22 = 18
				local var_254_23 = utf8.len(var_254_21)
				local var_254_24 = var_254_22 <= 0 and var_254_18 or var_254_18 * (var_254_23 / var_254_22)

				if var_254_24 > 0 and var_254_18 < var_254_24 then
					arg_251_1.talkMaxDuration = var_254_24

					if var_254_24 + var_254_17 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_24 + var_254_17
					end
				end

				arg_251_1.text_.text = var_254_21
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601061", "story_v_out_325601.awb") ~= 0 then
					local var_254_25 = manager.audio:GetVoiceLength("story_v_out_325601", "325601061", "story_v_out_325601.awb") / 1000

					if var_254_25 + var_254_17 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_25 + var_254_17
					end

					if var_254_20.prefab_name ~= "" and arg_251_1.actors_[var_254_20.prefab_name] ~= nil then
						local var_254_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_20.prefab_name].transform, "story_v_out_325601", "325601061", "story_v_out_325601.awb")

						arg_251_1:RecordAudio("325601061", var_254_26)
						arg_251_1:RecordAudio("325601061", var_254_26)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_325601", "325601061", "story_v_out_325601.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_325601", "325601061", "story_v_out_325601.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_27 = math.max(var_254_18, arg_251_1.talkMaxDuration)

			if var_254_17 <= arg_251_1.time_ and arg_251_1.time_ < var_254_17 + var_254_27 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_17) / var_254_27

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_17 + var_254_27 and arg_251_1.time_ < var_254_17 + var_254_27 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play325601062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 325601062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play325601063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10170ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect10170ui_story == nil then
				arg_255_1.var_.characterEffect10170ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect10170ui_story and not isNil(var_258_0) then
					local var_258_4 = Mathf.Lerp(0, 0.5, var_258_3)

					arg_255_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10170ui_story.fillRatio = var_258_4
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect10170ui_story then
				local var_258_5 = 0.5

				arg_255_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10170ui_story.fillRatio = var_258_5
			end

			local var_258_6 = 0
			local var_258_7 = 0.1

			if var_258_6 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_8 = arg_255_1:FormatText(StoryNameCfg[7].name)

				arg_255_1.leftNameTxt_.text = var_258_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_9 = arg_255_1:GetWordFromCfg(325601062)
				local var_258_10 = arg_255_1:FormatText(var_258_9.content)

				arg_255_1.text_.text = var_258_10

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_11 = 4
				local var_258_12 = utf8.len(var_258_10)
				local var_258_13 = var_258_11 <= 0 and var_258_7 or var_258_7 * (var_258_12 / var_258_11)

				if var_258_13 > 0 and var_258_7 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13

					if var_258_13 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_6
					end
				end

				arg_255_1.text_.text = var_258_10
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_14 = math.max(var_258_7, arg_255_1.talkMaxDuration)

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_14 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_6) / var_258_14

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_6 + var_258_14 and arg_255_1.time_ < var_258_6 + var_258_14 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play325601063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 325601063
		arg_259_1.duration_ = 3.43

		local var_259_0 = {
			zh = 2.1,
			ja = 3.433
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
			arg_259_1.auto_ = false
		end

		function arg_259_1.playNext_(arg_261_0)
			arg_259_1.onStoryFinished_()
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10170ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect10170ui_story == nil then
				arg_259_1.var_.characterEffect10170ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect10170ui_story and not isNil(var_262_0) then
					arg_259_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect10170ui_story then
				arg_259_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_262_4 = 0

			if var_262_4 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action27_1")
			end

			local var_262_5 = 0

			if var_262_5 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_262_6 = 0
			local var_262_7 = 1

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				local var_262_8 = "play"
				local var_262_9 = "effect"

				arg_259_1:AudioAction(var_262_8, var_262_9, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_262_10 = 0
			local var_262_11 = 0.2

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_12 = arg_259_1:FormatText(StoryNameCfg[1450].name)

				arg_259_1.leftNameTxt_.text = var_262_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_13 = arg_259_1:GetWordFromCfg(325601063)
				local var_262_14 = arg_259_1:FormatText(var_262_13.content)

				arg_259_1.text_.text = var_262_14

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_15 = 8
				local var_262_16 = utf8.len(var_262_14)
				local var_262_17 = var_262_15 <= 0 and var_262_11 or var_262_11 * (var_262_16 / var_262_15)

				if var_262_17 > 0 and var_262_11 < var_262_17 then
					arg_259_1.talkMaxDuration = var_262_17

					if var_262_17 + var_262_10 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_17 + var_262_10
					end
				end

				arg_259_1.text_.text = var_262_14
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325601", "325601063", "story_v_out_325601.awb") ~= 0 then
					local var_262_18 = manager.audio:GetVoiceLength("story_v_out_325601", "325601063", "story_v_out_325601.awb") / 1000

					if var_262_18 + var_262_10 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_18 + var_262_10
					end

					if var_262_13.prefab_name ~= "" and arg_259_1.actors_[var_262_13.prefab_name] ~= nil then
						local var_262_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_13.prefab_name].transform, "story_v_out_325601", "325601063", "story_v_out_325601.awb")

						arg_259_1:RecordAudio("325601063", var_262_19)
						arg_259_1:RecordAudio("325601063", var_262_19)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_325601", "325601063", "story_v_out_325601.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_325601", "325601063", "story_v_out_325601.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_20 = math.max(var_262_11, arg_259_1.talkMaxDuration)

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_20 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_10) / var_262_20

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_10 + var_262_20 and arg_259_1.time_ < var_262_10 + var_262_20 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J26h",
		"TextureConfig/Background/J25f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_325601.awb"
	}
}
