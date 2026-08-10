return {
	Play325582001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325582001
		arg_1_1.duration_ = 8.3

		local var_1_0 = {
			zh = 4.8,
			ja = 8.3
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
				arg_1_0:Play325582002(arg_1_1)
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

			local var_4_24 = "10175ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "10175ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "10175ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["10175ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos10175ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, -1, -6.05)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10175ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1, -6.05)

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

			local var_4_40 = arg_1_1.actors_["10175ui_story"]
			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect10175ui_story == nil then
				arg_1_1.var_.characterEffect10175ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect10175ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect10175ui_story then
				arg_1_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_4_45 = 1.8

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_4_46 = 0.1
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "effect"

				arg_1_1:AudioAction(var_4_48, var_4_49, "se_story_1210", "se_story_1210_blast_loop", "")
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
			local var_4_57 = 0.375

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

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[1473].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(325582001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582001", "story_v_out_325582.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_325582", "325582001", "story_v_out_325582.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_325582", "325582001", "story_v_out_325582.awb")

						arg_1_1:RecordAudio("325582001", var_4_66)
						arg_1_1:RecordAudio("325582001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325582", "325582001", "story_v_out_325582.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325582", "325582001", "story_v_out_325582.awb")
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
				actorName = "10175ui_story",
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
	Play325582002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325582002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325582003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["10175ui_story"].transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.moveOldPos10175ui_story = var_11_0.localPosition

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end
			end

			local var_11_3 = 0.001

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_3 then
				local var_11_4 = (arg_8_1.time_ - var_11_1) / var_11_3
				local var_11_5 = Vector3.New(0, 100, 0)

				var_11_0.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10175ui_story, var_11_5, var_11_4)

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

			local var_11_11 = arg_8_1.actors_["10175ui_story"]
			local var_11_12 = 0

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect10175ui_story == nil then
				arg_8_1.var_.characterEffect10175ui_story = var_11_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_13 = 0.200000002980232

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_13 and not isNil(var_11_11) then
				local var_11_14 = (arg_8_1.time_ - var_11_12) / var_11_13

				if arg_8_1.var_.characterEffect10175ui_story and not isNil(var_11_11) then
					local var_11_15 = Mathf.Lerp(0, 0.5, var_11_14)

					arg_8_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10175ui_story.fillRatio = var_11_15
				end
			end

			if arg_8_1.time_ >= var_11_12 + var_11_13 and arg_8_1.time_ < var_11_12 + var_11_13 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect10175ui_story then
				local var_11_16 = 0.5

				arg_8_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10175ui_story.fillRatio = var_11_16
			end

			local var_11_17 = 1
			local var_11_18 = 1

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 then
				local var_11_19 = "play"
				local var_11_20 = "effect"

				arg_8_1:AudioAction(var_11_19, var_11_20, "se_story_148", "se_story_148_sword04", "")
			end

			local var_11_21 = 0
			local var_11_22 = 1.475

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_23 = arg_8_1:GetWordFromCfg(325582002)
				local var_11_24 = arg_8_1:FormatText(var_11_23.content)

				arg_8_1.text_.text = var_11_24

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_25 = 59
				local var_11_26 = utf8.len(var_11_24)
				local var_11_27 = var_11_25 <= 0 and var_11_22 or var_11_22 * (var_11_26 / var_11_25)

				if var_11_27 > 0 and var_11_22 < var_11_27 then
					arg_8_1.talkMaxDuration = var_11_27

					if var_11_27 + var_11_21 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_27 + var_11_21
					end
				end

				arg_8_1.text_.text = var_11_24
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_28 = math.max(var_11_22, arg_8_1.talkMaxDuration)

			if var_11_21 <= arg_8_1.time_ and arg_8_1.time_ < var_11_21 + var_11_28 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_21) / var_11_28

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_21 + var_11_28 and arg_8_1.time_ < var_11_21 + var_11_28 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
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
	Play325582003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325582003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325582004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.925

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

				local var_15_2 = arg_12_1:GetWordFromCfg(325582003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 77
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
	Play325582004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325582004
		arg_16_1.duration_ = 3.43

		local var_16_0 = {
			zh = 3.433,
			ja = 2.366
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
				arg_16_0:Play325582005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10175ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos10175ui_story = var_19_0.localPosition

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end
			end

			local var_19_3 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Vector3.New(0, -1, -6.05)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10175ui_story, var_19_5, var_19_4)

				local var_19_6 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_6.x, var_19_6.y, var_19_6.z)

				local var_19_7 = var_19_0.localEulerAngles

				var_19_7.z = 0
				var_19_7.x = 0
				var_19_0.localEulerAngles = var_19_7
			end

			if arg_16_1.time_ >= var_19_1 + var_19_3 and arg_16_1.time_ < var_19_1 + var_19_3 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, -1, -6.05)

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

			local var_19_11 = arg_16_1.actors_["10175ui_story"]
			local var_19_12 = 0

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect10175ui_story == nil then
				arg_16_1.var_.characterEffect10175ui_story = var_19_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_13 = 0.200000002980232

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_13 and not isNil(var_19_11) then
				local var_19_14 = (arg_16_1.time_ - var_19_12) / var_19_13

				if arg_16_1.var_.characterEffect10175ui_story and not isNil(var_19_11) then
					arg_16_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_12 + var_19_13 and arg_16_1.time_ < var_19_12 + var_19_13 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect10175ui_story then
				arg_16_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action37_1")
			end

			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_19_17 = 0
			local var_19_18 = 0.125

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_19 = arg_16_1:FormatText(StoryNameCfg[1473].name)

				arg_16_1.leftNameTxt_.text = var_19_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_20 = arg_16_1:GetWordFromCfg(325582004)
				local var_19_21 = arg_16_1:FormatText(var_19_20.content)

				arg_16_1.text_.text = var_19_21

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_22 = 5
				local var_19_23 = utf8.len(var_19_21)
				local var_19_24 = var_19_22 <= 0 and var_19_18 or var_19_18 * (var_19_23 / var_19_22)

				if var_19_24 > 0 and var_19_18 < var_19_24 then
					arg_16_1.talkMaxDuration = var_19_24

					if var_19_24 + var_19_17 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_24 + var_19_17
					end
				end

				arg_16_1.text_.text = var_19_21
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582004", "story_v_out_325582.awb") ~= 0 then
					local var_19_25 = manager.audio:GetVoiceLength("story_v_out_325582", "325582004", "story_v_out_325582.awb") / 1000

					if var_19_25 + var_19_17 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_25 + var_19_17
					end

					if var_19_20.prefab_name ~= "" and arg_16_1.actors_[var_19_20.prefab_name] ~= nil then
						local var_19_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_20.prefab_name].transform, "story_v_out_325582", "325582004", "story_v_out_325582.awb")

						arg_16_1:RecordAudio("325582004", var_19_26)
						arg_16_1:RecordAudio("325582004", var_19_26)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325582", "325582004", "story_v_out_325582.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325582", "325582004", "story_v_out_325582.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_27 = math.max(var_19_18, arg_16_1.talkMaxDuration)

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_27 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_17) / var_19_27

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_17 + var_19_27 and arg_16_1.time_ < var_19_17 + var_19_27 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
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
	Play325582005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325582005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325582006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10175ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos10175ui_story = var_23_0.localPosition

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end
			end

			local var_23_3 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_3 then
				local var_23_4 = (arg_20_1.time_ - var_23_1) / var_23_3
				local var_23_5 = Vector3.New(0, 100, 0)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10175ui_story, var_23_5, var_23_4)

				local var_23_6 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_6.x, var_23_6.y, var_23_6.z)

				local var_23_7 = var_23_0.localEulerAngles

				var_23_7.z = 0
				var_23_7.x = 0
				var_23_0.localEulerAngles = var_23_7
			end

			if arg_20_1.time_ >= var_23_1 + var_23_3 and arg_20_1.time_ < var_23_1 + var_23_3 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_23_11 = arg_20_1.actors_["10175ui_story"]
			local var_23_12 = 0

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect10175ui_story == nil then
				arg_20_1.var_.characterEffect10175ui_story = var_23_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_13 = 0.200000002980232

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_13 and not isNil(var_23_11) then
				local var_23_14 = (arg_20_1.time_ - var_23_12) / var_23_13

				if arg_20_1.var_.characterEffect10175ui_story and not isNil(var_23_11) then
					local var_23_15 = Mathf.Lerp(0, 0.5, var_23_14)

					arg_20_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10175ui_story.fillRatio = var_23_15
				end
			end

			if arg_20_1.time_ >= var_23_12 + var_23_13 and arg_20_1.time_ < var_23_12 + var_23_13 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect10175ui_story then
				local var_23_16 = 0.5

				arg_20_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10175ui_story.fillRatio = var_23_16
			end

			local var_23_17 = 0
			local var_23_18 = 1.625

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_19 = arg_20_1:GetWordFromCfg(325582005)
				local var_23_20 = arg_20_1:FormatText(var_23_19.content)

				arg_20_1.text_.text = var_23_20

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_21 = 65
				local var_23_22 = utf8.len(var_23_20)
				local var_23_23 = var_23_21 <= 0 and var_23_18 or var_23_18 * (var_23_22 / var_23_21)

				if var_23_23 > 0 and var_23_18 < var_23_23 then
					arg_20_1.talkMaxDuration = var_23_23

					if var_23_23 + var_23_17 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_17
					end
				end

				arg_20_1.text_.text = var_23_20
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_24 = math.max(var_23_18, arg_20_1.talkMaxDuration)

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_24 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_17) / var_23_24

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_17 + var_23_24 and arg_20_1.time_ < var_23_17 + var_23_24 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
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
	Play325582006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325582006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325582007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 1.95

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(325582006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 78
				local var_27_5 = utf8.len(var_27_3)
				local var_27_6 = var_27_4 <= 0 and var_27_1 or var_27_1 * (var_27_5 / var_27_4)

				if var_27_6 > 0 and var_27_1 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_7 and arg_24_1.time_ < var_27_0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325582007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325582007
		arg_28_1.duration_ = 7.17

		local var_28_0 = {
			zh = 6.933,
			ja = 7.166
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
				arg_28_0:Play325582008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "10166ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "10166ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "10166ui_story"), arg_28_1.stage_.transform)

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

			local var_31_5 = arg_28_1.actors_["10166ui_story"].transform
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.var_.moveOldPos10166ui_story = var_31_5.localPosition

				local var_31_7 = GameObjectTools.GetOrAddComponent(var_31_5.gameObject, typeof(DynamicBoneHelper))

				if var_31_7 then
					var_31_7:EnableDynamicBone(false)
				end
			end

			local var_31_8 = 0.001

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_6) / var_31_8
				local var_31_10 = Vector3.New(0, -1.28, -5.73)

				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10166ui_story, var_31_10, var_31_9)

				local var_31_11 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_11.x, var_31_11.y, var_31_11.z)

				local var_31_12 = var_31_5.localEulerAngles

				var_31_12.z = 0
				var_31_12.x = 0
				var_31_5.localEulerAngles = var_31_12
			end

			if arg_28_1.time_ >= var_31_6 + var_31_8 and arg_28_1.time_ < var_31_6 + var_31_8 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(0, -1.28, -5.73)

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

			local var_31_16 = arg_28_1.actors_["10166ui_story"]
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect10166ui_story == nil then
				arg_28_1.var_.characterEffect10166ui_story = var_31_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_18 = 0.200000002980232

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_18 and not isNil(var_31_16) then
				local var_31_19 = (arg_28_1.time_ - var_31_17) / var_31_18

				if arg_28_1.var_.characterEffect10166ui_story and not isNil(var_31_16) then
					arg_28_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_17 + var_31_18 and arg_28_1.time_ < var_31_17 + var_31_18 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect10166ui_story then
				arg_28_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_31_20 = 0

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			local var_31_21 = 0

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 then
				arg_28_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_31_22 = 0
			local var_31_23 = 0.675

			if var_31_22 < arg_28_1.time_ and arg_28_1.time_ <= var_31_22 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_24 = arg_28_1:FormatText(StoryNameCfg[1530].name)

				arg_28_1.leftNameTxt_.text = var_31_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_25 = arg_28_1:GetWordFromCfg(325582007)
				local var_31_26 = arg_28_1:FormatText(var_31_25.content)

				arg_28_1.text_.text = var_31_26

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_27 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582007", "story_v_out_325582.awb") ~= 0 then
					local var_31_30 = manager.audio:GetVoiceLength("story_v_out_325582", "325582007", "story_v_out_325582.awb") / 1000

					if var_31_30 + var_31_22 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_30 + var_31_22
					end

					if var_31_25.prefab_name ~= "" and arg_28_1.actors_[var_31_25.prefab_name] ~= nil then
						local var_31_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_25.prefab_name].transform, "story_v_out_325582", "325582007", "story_v_out_325582.awb")

						arg_28_1:RecordAudio("325582007", var_31_31)
						arg_28_1:RecordAudio("325582007", var_31_31)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325582", "325582007", "story_v_out_325582.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325582", "325582007", "story_v_out_325582.awb")
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
				actorName = "10166ui_story",
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
	Play325582008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325582008
		arg_32_1.duration_ = 8.37

		local var_32_0 = {
			zh = 5.066,
			ja = 8.366
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
				arg_32_0:Play325582009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.5

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[1530].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(325582008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582008", "story_v_out_325582.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_325582", "325582008", "story_v_out_325582.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_325582", "325582008", "story_v_out_325582.awb")

						arg_32_1:RecordAudio("325582008", var_35_9)
						arg_32_1:RecordAudio("325582008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325582", "325582008", "story_v_out_325582.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325582", "325582008", "story_v_out_325582.awb")
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
	Play325582009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325582009
		arg_36_1.duration_ = 5.73

		local var_36_0 = {
			zh = 3.8,
			ja = 5.733
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
				arg_36_0:Play325582010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10166ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos10166ui_story = var_39_0.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_3 then
				local var_39_4 = (arg_36_1.time_ - var_39_1) / var_39_3
				local var_39_5 = Vector3.New(-0.96, -1.28, -5.73)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10166ui_story, var_39_5, var_39_4)

				local var_39_6 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_6.x, var_39_6.y, var_39_6.z)

				local var_39_7 = var_39_0.localEulerAngles

				var_39_7.z = 0
				var_39_7.x = 0
				var_39_0.localEulerAngles = var_39_7
			end

			if arg_36_1.time_ >= var_39_1 + var_39_3 and arg_36_1.time_ < var_39_1 + var_39_3 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(-0.96, -1.28, -5.73)

				local var_39_8 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_8.x, var_39_8.y, var_39_8.z)

				local var_39_9 = var_39_0.localEulerAngles

				var_39_9.z = 0
				var_39_9.x = 0
				var_39_0.localEulerAngles = var_39_9

				local var_39_10 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_10 then
					var_39_10:EnableDynamicBone(true)
				end
			end

			local var_39_11 = arg_36_1.actors_["10175ui_story"].transform
			local var_39_12 = 0

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.var_.moveOldPos10175ui_story = var_39_11.localPosition

				local var_39_13 = GameObjectTools.GetOrAddComponent(var_39_11.gameObject, typeof(DynamicBoneHelper))

				if var_39_13 then
					var_39_13:EnableDynamicBone(false)
				end
			end

			local var_39_14 = 0.001

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_14 then
				local var_39_15 = (arg_36_1.time_ - var_39_12) / var_39_14
				local var_39_16 = Vector3.New(0.7, -1, -6.05)

				var_39_11.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10175ui_story, var_39_16, var_39_15)

				local var_39_17 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_17.x, var_39_17.y, var_39_17.z)

				local var_39_18 = var_39_11.localEulerAngles

				var_39_18.z = 0
				var_39_18.x = 0
				var_39_11.localEulerAngles = var_39_18
			end

			if arg_36_1.time_ >= var_39_12 + var_39_14 and arg_36_1.time_ < var_39_12 + var_39_14 + arg_39_0 then
				var_39_11.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_39_19 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_19.x, var_39_19.y, var_39_19.z)

				local var_39_20 = var_39_11.localEulerAngles

				var_39_20.z = 0
				var_39_20.x = 0
				var_39_11.localEulerAngles = var_39_20

				local var_39_21 = GameObjectTools.GetOrAddComponent(var_39_11.gameObject, typeof(DynamicBoneHelper))

				if var_39_21 then
					var_39_21:EnableDynamicBone(true)
				end
			end

			local var_39_22 = arg_36_1.actors_["10175ui_story"]
			local var_39_23 = 0

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 and not isNil(var_39_22) and arg_36_1.var_.characterEffect10175ui_story == nil then
				arg_36_1.var_.characterEffect10175ui_story = var_39_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_24 = 0.200000002980232

			if var_39_23 <= arg_36_1.time_ and arg_36_1.time_ < var_39_23 + var_39_24 and not isNil(var_39_22) then
				local var_39_25 = (arg_36_1.time_ - var_39_23) / var_39_24

				if arg_36_1.var_.characterEffect10175ui_story and not isNil(var_39_22) then
					arg_36_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_23 + var_39_24 and arg_36_1.time_ < var_39_23 + var_39_24 + arg_39_0 and not isNil(var_39_22) and arg_36_1.var_.characterEffect10175ui_story then
				arg_36_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_39_26 = arg_36_1.actors_["10166ui_story"]
			local var_39_27 = 0

			if var_39_27 < arg_36_1.time_ and arg_36_1.time_ <= var_39_27 + arg_39_0 and not isNil(var_39_26) and arg_36_1.var_.characterEffect10166ui_story == nil then
				arg_36_1.var_.characterEffect10166ui_story = var_39_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_28 = 0.200000002980232

			if var_39_27 <= arg_36_1.time_ and arg_36_1.time_ < var_39_27 + var_39_28 and not isNil(var_39_26) then
				local var_39_29 = (arg_36_1.time_ - var_39_27) / var_39_28

				if arg_36_1.var_.characterEffect10166ui_story and not isNil(var_39_26) then
					local var_39_30 = Mathf.Lerp(0, 0.5, var_39_29)

					arg_36_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10166ui_story.fillRatio = var_39_30
				end
			end

			if arg_36_1.time_ >= var_39_27 + var_39_28 and arg_36_1.time_ < var_39_27 + var_39_28 + arg_39_0 and not isNil(var_39_26) and arg_36_1.var_.characterEffect10166ui_story then
				local var_39_31 = 0.5

				arg_36_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10166ui_story.fillRatio = var_39_31
			end

			local var_39_32 = 0

			if var_39_32 < arg_36_1.time_ and arg_36_1.time_ <= var_39_32 + arg_39_0 then
				arg_36_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action37_2")
			end

			local var_39_33 = 0

			if var_39_33 < arg_36_1.time_ and arg_36_1.time_ <= var_39_33 + arg_39_0 then
				arg_36_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_39_34 = 0
			local var_39_35 = 0.45

			if var_39_34 < arg_36_1.time_ and arg_36_1.time_ <= var_39_34 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_36 = arg_36_1:FormatText(StoryNameCfg[1473].name)

				arg_36_1.leftNameTxt_.text = var_39_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_37 = arg_36_1:GetWordFromCfg(325582009)
				local var_39_38 = arg_36_1:FormatText(var_39_37.content)

				arg_36_1.text_.text = var_39_38

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_39 = 18
				local var_39_40 = utf8.len(var_39_38)
				local var_39_41 = var_39_39 <= 0 and var_39_35 or var_39_35 * (var_39_40 / var_39_39)

				if var_39_41 > 0 and var_39_35 < var_39_41 then
					arg_36_1.talkMaxDuration = var_39_41

					if var_39_41 + var_39_34 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_41 + var_39_34
					end
				end

				arg_36_1.text_.text = var_39_38
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582009", "story_v_out_325582.awb") ~= 0 then
					local var_39_42 = manager.audio:GetVoiceLength("story_v_out_325582", "325582009", "story_v_out_325582.awb") / 1000

					if var_39_42 + var_39_34 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_42 + var_39_34
					end

					if var_39_37.prefab_name ~= "" and arg_36_1.actors_[var_39_37.prefab_name] ~= nil then
						local var_39_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_37.prefab_name].transform, "story_v_out_325582", "325582009", "story_v_out_325582.awb")

						arg_36_1:RecordAudio("325582009", var_39_43)
						arg_36_1:RecordAudio("325582009", var_39_43)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325582", "325582009", "story_v_out_325582.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325582", "325582009", "story_v_out_325582.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_44 = math.max(var_39_35, arg_36_1.talkMaxDuration)

			if var_39_34 <= arg_36_1.time_ and arg_36_1.time_ < var_39_34 + var_39_44 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_34) / var_39_44

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_34 + var_39_44 and arg_36_1.time_ < var_39_34 + var_39_44 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
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
	Play325582010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325582010
		arg_40_1.duration_ = 5.97

		local var_40_0 = {
			zh = 4.8,
			ja = 5.966
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
				arg_40_0:Play325582011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10166ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10166ui_story == nil then
				arg_40_1.var_.characterEffect10166ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect10166ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10166ui_story then
				arg_40_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["10175ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect10175ui_story == nil then
				arg_40_1.var_.characterEffect10175ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.200000002980232

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect10175ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10175ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect10175ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10175ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_12 = 0
			local var_43_13 = 0.425

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_14 = arg_40_1:FormatText(StoryNameCfg[1530].name)

				arg_40_1.leftNameTxt_.text = var_43_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:GetWordFromCfg(325582010)
				local var_43_16 = arg_40_1:FormatText(var_43_15.content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 17
				local var_43_18 = utf8.len(var_43_16)
				local var_43_19 = var_43_17 <= 0 and var_43_13 or var_43_13 * (var_43_18 / var_43_17)

				if var_43_19 > 0 and var_43_13 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19

					if var_43_19 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_16
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582010", "story_v_out_325582.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_325582", "325582010", "story_v_out_325582.awb") / 1000

					if var_43_20 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_12
					end

					if var_43_15.prefab_name ~= "" and arg_40_1.actors_[var_43_15.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_15.prefab_name].transform, "story_v_out_325582", "325582010", "story_v_out_325582.awb")

						arg_40_1:RecordAudio("325582010", var_43_21)
						arg_40_1:RecordAudio("325582010", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325582", "325582010", "story_v_out_325582.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325582", "325582010", "story_v_out_325582.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_22 and arg_40_1.time_ < var_43_12 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325582011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325582011
		arg_44_1.duration_ = 10.9

		local var_44_0 = {
			zh = 5.1,
			ja = 10.9
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
				arg_44_0:Play325582012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.525

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[1530].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:GetWordFromCfg(325582011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582011", "story_v_out_325582.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_325582", "325582011", "story_v_out_325582.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_325582", "325582011", "story_v_out_325582.awb")

						arg_44_1:RecordAudio("325582011", var_47_9)
						arg_44_1:RecordAudio("325582011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325582", "325582011", "story_v_out_325582.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325582", "325582011", "story_v_out_325582.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play325582012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325582012
		arg_48_1.duration_ = 4.53

		local var_48_0 = {
			zh = 3.033,
			ja = 4.533
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
				arg_48_0:Play325582013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10175ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10175ui_story == nil then
				arg_48_1.var_.characterEffect10175ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect10175ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10175ui_story then
				arg_48_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["10166ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10166ui_story == nil then
				arg_48_1.var_.characterEffect10166ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect10166ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10166ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10166ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10166ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action4_1")
			end

			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_51_12 = 0
			local var_51_13 = 0.375

			if var_51_12 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_14 = arg_48_1:FormatText(StoryNameCfg[1473].name)

				arg_48_1.leftNameTxt_.text = var_51_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_15 = arg_48_1:GetWordFromCfg(325582012)
				local var_51_16 = arg_48_1:FormatText(var_51_15.content)

				arg_48_1.text_.text = var_51_16

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_17 = 15
				local var_51_18 = utf8.len(var_51_16)
				local var_51_19 = var_51_17 <= 0 and var_51_13 or var_51_13 * (var_51_18 / var_51_17)

				if var_51_19 > 0 and var_51_13 < var_51_19 then
					arg_48_1.talkMaxDuration = var_51_19

					if var_51_19 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_19 + var_51_12
					end
				end

				arg_48_1.text_.text = var_51_16
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582012", "story_v_out_325582.awb") ~= 0 then
					local var_51_20 = manager.audio:GetVoiceLength("story_v_out_325582", "325582012", "story_v_out_325582.awb") / 1000

					if var_51_20 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_20 + var_51_12
					end

					if var_51_15.prefab_name ~= "" and arg_48_1.actors_[var_51_15.prefab_name] ~= nil then
						local var_51_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_15.prefab_name].transform, "story_v_out_325582", "325582012", "story_v_out_325582.awb")

						arg_48_1:RecordAudio("325582012", var_51_21)
						arg_48_1:RecordAudio("325582012", var_51_21)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325582", "325582012", "story_v_out_325582.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325582", "325582012", "story_v_out_325582.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_22 = math.max(var_51_13, arg_48_1.talkMaxDuration)

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_12) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_12 + var_51_22 and arg_48_1.time_ < var_51_12 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325582013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325582013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325582014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10175ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos10175ui_story = var_55_0.localPosition

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end
			end

			local var_55_3 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_3 then
				local var_55_4 = (arg_52_1.time_ - var_55_1) / var_55_3
				local var_55_5 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10175ui_story, var_55_5, var_55_4)

				local var_55_6 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_6.x, var_55_6.y, var_55_6.z)

				local var_55_7 = var_55_0.localEulerAngles

				var_55_7.z = 0
				var_55_7.x = 0
				var_55_0.localEulerAngles = var_55_7
			end

			if arg_52_1.time_ >= var_55_1 + var_55_3 and arg_52_1.time_ < var_55_1 + var_55_3 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_55_11 = arg_52_1.actors_["10166ui_story"].transform
			local var_55_12 = 0

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.var_.moveOldPos10166ui_story = var_55_11.localPosition

				local var_55_13 = GameObjectTools.GetOrAddComponent(var_55_11.gameObject, typeof(DynamicBoneHelper))

				if var_55_13 then
					var_55_13:EnableDynamicBone(false)
				end
			end

			local var_55_14 = 0.001

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_14 then
				local var_55_15 = (arg_52_1.time_ - var_55_12) / var_55_14
				local var_55_16 = Vector3.New(0, 100, 0)

				var_55_11.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10166ui_story, var_55_16, var_55_15)

				local var_55_17 = manager.ui.mainCamera.transform.position - var_55_11.position

				var_55_11.forward = Vector3.New(var_55_17.x, var_55_17.y, var_55_17.z)

				local var_55_18 = var_55_11.localEulerAngles

				var_55_18.z = 0
				var_55_18.x = 0
				var_55_11.localEulerAngles = var_55_18
			end

			if arg_52_1.time_ >= var_55_12 + var_55_14 and arg_52_1.time_ < var_55_12 + var_55_14 + arg_55_0 then
				var_55_11.localPosition = Vector3.New(0, 100, 0)

				local var_55_19 = manager.ui.mainCamera.transform.position - var_55_11.position

				var_55_11.forward = Vector3.New(var_55_19.x, var_55_19.y, var_55_19.z)

				local var_55_20 = var_55_11.localEulerAngles

				var_55_20.z = 0
				var_55_20.x = 0
				var_55_11.localEulerAngles = var_55_20

				local var_55_21 = GameObjectTools.GetOrAddComponent(var_55_11.gameObject, typeof(DynamicBoneHelper))

				if var_55_21 then
					var_55_21:EnableDynamicBone(true)
				end
			end

			local var_55_22 = arg_52_1.actors_["10175ui_story"]
			local var_55_23 = 0

			if var_55_23 < arg_52_1.time_ and arg_52_1.time_ <= var_55_23 + arg_55_0 and not isNil(var_55_22) and arg_52_1.var_.characterEffect10175ui_story == nil then
				arg_52_1.var_.characterEffect10175ui_story = var_55_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_24 = 0.200000002980232

			if var_55_23 <= arg_52_1.time_ and arg_52_1.time_ < var_55_23 + var_55_24 and not isNil(var_55_22) then
				local var_55_25 = (arg_52_1.time_ - var_55_23) / var_55_24

				if arg_52_1.var_.characterEffect10175ui_story and not isNil(var_55_22) then
					local var_55_26 = Mathf.Lerp(0, 0.5, var_55_25)

					arg_52_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10175ui_story.fillRatio = var_55_26
				end
			end

			if arg_52_1.time_ >= var_55_23 + var_55_24 and arg_52_1.time_ < var_55_23 + var_55_24 + arg_55_0 and not isNil(var_55_22) and arg_52_1.var_.characterEffect10175ui_story then
				local var_55_27 = 0.5

				arg_52_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10175ui_story.fillRatio = var_55_27
			end

			local var_55_28 = 0
			local var_55_29 = 1.35

			if var_55_28 < arg_52_1.time_ and arg_52_1.time_ <= var_55_28 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_30 = arg_52_1:GetWordFromCfg(325582013)
				local var_55_31 = arg_52_1:FormatText(var_55_30.content)

				arg_52_1.text_.text = var_55_31

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_32 = 54
				local var_55_33 = utf8.len(var_55_31)
				local var_55_34 = var_55_32 <= 0 and var_55_29 or var_55_29 * (var_55_33 / var_55_32)

				if var_55_34 > 0 and var_55_29 < var_55_34 then
					arg_52_1.talkMaxDuration = var_55_34

					if var_55_34 + var_55_28 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_34 + var_55_28
					end
				end

				arg_52_1.text_.text = var_55_31
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_35 = math.max(var_55_29, arg_52_1.talkMaxDuration)

			if var_55_28 <= arg_52_1.time_ and arg_52_1.time_ < var_55_28 + var_55_35 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_28) / var_55_35

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_28 + var_55_35 and arg_52_1.time_ < var_55_28 + var_55_35 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10166ui_story",
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
	Play325582014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325582014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325582015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 1.35

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

				local var_59_2 = arg_56_1:GetWordFromCfg(325582014)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 54
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
	Play325582015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325582015
		arg_60_1.duration_ = 7.8

		local var_60_0 = {
			zh = 4.866,
			ja = 7.8
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
				arg_60_0:Play325582016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10175ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos10175ui_story = var_63_0.localPosition

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end
			end

			local var_63_3 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_3 then
				local var_63_4 = (arg_60_1.time_ - var_63_1) / var_63_3
				local var_63_5 = Vector3.New(0, -1, -6.05)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10175ui_story, var_63_5, var_63_4)

				local var_63_6 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_6.x, var_63_6.y, var_63_6.z)

				local var_63_7 = var_63_0.localEulerAngles

				var_63_7.z = 0
				var_63_7.x = 0
				var_63_0.localEulerAngles = var_63_7
			end

			if arg_60_1.time_ >= var_63_1 + var_63_3 and arg_60_1.time_ < var_63_1 + var_63_3 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, -1, -6.05)

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

			local var_63_11 = arg_60_1.actors_["10175ui_story"]
			local var_63_12 = 0

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect10175ui_story == nil then
				arg_60_1.var_.characterEffect10175ui_story = var_63_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_13 = 0.200000002980232

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_13 and not isNil(var_63_11) then
				local var_63_14 = (arg_60_1.time_ - var_63_12) / var_63_13

				if arg_60_1.var_.characterEffect10175ui_story and not isNil(var_63_11) then
					arg_60_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_12 + var_63_13 and arg_60_1.time_ < var_63_12 + var_63_13 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect10175ui_story then
				arg_60_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_63_15 = 0

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_63_16 = 0

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_63_17 = 0
			local var_63_18 = 0.525

			if var_63_17 < arg_60_1.time_ and arg_60_1.time_ <= var_63_17 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_19 = arg_60_1:FormatText(StoryNameCfg[1473].name)

				arg_60_1.leftNameTxt_.text = var_63_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_20 = arg_60_1:GetWordFromCfg(325582015)
				local var_63_21 = arg_60_1:FormatText(var_63_20.content)

				arg_60_1.text_.text = var_63_21

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_22 = 21
				local var_63_23 = utf8.len(var_63_21)
				local var_63_24 = var_63_22 <= 0 and var_63_18 or var_63_18 * (var_63_23 / var_63_22)

				if var_63_24 > 0 and var_63_18 < var_63_24 then
					arg_60_1.talkMaxDuration = var_63_24

					if var_63_24 + var_63_17 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_24 + var_63_17
					end
				end

				arg_60_1.text_.text = var_63_21
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582015", "story_v_out_325582.awb") ~= 0 then
					local var_63_25 = manager.audio:GetVoiceLength("story_v_out_325582", "325582015", "story_v_out_325582.awb") / 1000

					if var_63_25 + var_63_17 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_25 + var_63_17
					end

					if var_63_20.prefab_name ~= "" and arg_60_1.actors_[var_63_20.prefab_name] ~= nil then
						local var_63_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_20.prefab_name].transform, "story_v_out_325582", "325582015", "story_v_out_325582.awb")

						arg_60_1:RecordAudio("325582015", var_63_26)
						arg_60_1:RecordAudio("325582015", var_63_26)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325582", "325582015", "story_v_out_325582.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325582", "325582015", "story_v_out_325582.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_27 = math.max(var_63_18, arg_60_1.talkMaxDuration)

			if var_63_17 <= arg_60_1.time_ and arg_60_1.time_ < var_63_17 + var_63_27 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_17) / var_63_27

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_17 + var_63_27 and arg_60_1.time_ < var_63_17 + var_63_27 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
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
	Play325582016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325582016
		arg_64_1.duration_ = 2

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325582017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10175ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos10175ui_story = var_67_0.localPosition

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end
			end

			local var_67_3 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_3 then
				local var_67_4 = (arg_64_1.time_ - var_67_1) / var_67_3
				local var_67_5 = Vector3.New(-0.7, -1, -6.05)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10175ui_story, var_67_5, var_67_4)

				local var_67_6 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_6.x, var_67_6.y, var_67_6.z)

				local var_67_7 = var_67_0.localEulerAngles

				var_67_7.z = 0
				var_67_7.x = 0
				var_67_0.localEulerAngles = var_67_7
			end

			if arg_64_1.time_ >= var_67_1 + var_67_3 and arg_64_1.time_ < var_67_1 + var_67_3 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_67_8 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_8.x, var_67_8.y, var_67_8.z)

				local var_67_9 = var_67_0.localEulerAngles

				var_67_9.z = 0
				var_67_9.x = 0
				var_67_0.localEulerAngles = var_67_9

				local var_67_10 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_10 then
					var_67_10:EnableDynamicBone(true)
				end
			end

			local var_67_11 = arg_64_1.actors_["10166ui_story"].transform
			local var_67_12 = 0

			if var_67_12 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 then
				arg_64_1.var_.moveOldPos10166ui_story = var_67_11.localPosition

				local var_67_13 = GameObjectTools.GetOrAddComponent(var_67_11.gameObject, typeof(DynamicBoneHelper))

				if var_67_13 then
					var_67_13:EnableDynamicBone(false)
				end
			end

			local var_67_14 = 0.001

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_14 then
				local var_67_15 = (arg_64_1.time_ - var_67_12) / var_67_14
				local var_67_16 = Vector3.New(0.7, -1.28, -5.73)

				var_67_11.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10166ui_story, var_67_16, var_67_15)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_11.position

				var_67_11.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_11.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_11.localEulerAngles = var_67_18
			end

			if arg_64_1.time_ >= var_67_12 + var_67_14 and arg_64_1.time_ < var_67_12 + var_67_14 + arg_67_0 then
				var_67_11.localPosition = Vector3.New(0.7, -1.28, -5.73)

				local var_67_19 = manager.ui.mainCamera.transform.position - var_67_11.position

				var_67_11.forward = Vector3.New(var_67_19.x, var_67_19.y, var_67_19.z)

				local var_67_20 = var_67_11.localEulerAngles

				var_67_20.z = 0
				var_67_20.x = 0
				var_67_11.localEulerAngles = var_67_20

				local var_67_21 = GameObjectTools.GetOrAddComponent(var_67_11.gameObject, typeof(DynamicBoneHelper))

				if var_67_21 then
					var_67_21:EnableDynamicBone(true)
				end
			end

			local var_67_22 = arg_64_1.actors_["10166ui_story"]
			local var_67_23 = 0

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 and not isNil(var_67_22) and arg_64_1.var_.characterEffect10166ui_story == nil then
				arg_64_1.var_.characterEffect10166ui_story = var_67_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_24 = 0.200000002980232

			if var_67_23 <= arg_64_1.time_ and arg_64_1.time_ < var_67_23 + var_67_24 and not isNil(var_67_22) then
				local var_67_25 = (arg_64_1.time_ - var_67_23) / var_67_24

				if arg_64_1.var_.characterEffect10166ui_story and not isNil(var_67_22) then
					arg_64_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_23 + var_67_24 and arg_64_1.time_ < var_67_23 + var_67_24 + arg_67_0 and not isNil(var_67_22) and arg_64_1.var_.characterEffect10166ui_story then
				arg_64_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_67_26 = arg_64_1.actors_["10175ui_story"]
			local var_67_27 = 0

			if var_67_27 < arg_64_1.time_ and arg_64_1.time_ <= var_67_27 + arg_67_0 and not isNil(var_67_26) and arg_64_1.var_.characterEffect10175ui_story == nil then
				arg_64_1.var_.characterEffect10175ui_story = var_67_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_28 = 0.200000002980232

			if var_67_27 <= arg_64_1.time_ and arg_64_1.time_ < var_67_27 + var_67_28 and not isNil(var_67_26) then
				local var_67_29 = (arg_64_1.time_ - var_67_27) / var_67_28

				if arg_64_1.var_.characterEffect10175ui_story and not isNil(var_67_26) then
					local var_67_30 = Mathf.Lerp(0, 0.5, var_67_29)

					arg_64_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10175ui_story.fillRatio = var_67_30
				end
			end

			if arg_64_1.time_ >= var_67_27 + var_67_28 and arg_64_1.time_ < var_67_27 + var_67_28 + arg_67_0 and not isNil(var_67_26) and arg_64_1.var_.characterEffect10175ui_story then
				local var_67_31 = 0.5

				arg_64_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10175ui_story.fillRatio = var_67_31
			end

			local var_67_32 = 0

			if var_67_32 < arg_64_1.time_ and arg_64_1.time_ <= var_67_32 + arg_67_0 then
				arg_64_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			local var_67_33 = 0

			if var_67_33 < arg_64_1.time_ and arg_64_1.time_ <= var_67_33 + arg_67_0 then
				arg_64_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_34 = 0
			local var_67_35 = 0.1

			if var_67_34 < arg_64_1.time_ and arg_64_1.time_ <= var_67_34 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_36 = arg_64_1:FormatText(StoryNameCfg[1530].name)

				arg_64_1.leftNameTxt_.text = var_67_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_37 = arg_64_1:GetWordFromCfg(325582016)
				local var_67_38 = arg_64_1:FormatText(var_67_37.content)

				arg_64_1.text_.text = var_67_38

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_39 = 4
				local var_67_40 = utf8.len(var_67_38)
				local var_67_41 = var_67_39 <= 0 and var_67_35 or var_67_35 * (var_67_40 / var_67_39)

				if var_67_41 > 0 and var_67_35 < var_67_41 then
					arg_64_1.talkMaxDuration = var_67_41

					if var_67_41 + var_67_34 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_41 + var_67_34
					end
				end

				arg_64_1.text_.text = var_67_38
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582016", "story_v_out_325582.awb") ~= 0 then
					local var_67_42 = manager.audio:GetVoiceLength("story_v_out_325582", "325582016", "story_v_out_325582.awb") / 1000

					if var_67_42 + var_67_34 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_42 + var_67_34
					end

					if var_67_37.prefab_name ~= "" and arg_64_1.actors_[var_67_37.prefab_name] ~= nil then
						local var_67_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_37.prefab_name].transform, "story_v_out_325582", "325582016", "story_v_out_325582.awb")

						arg_64_1:RecordAudio("325582016", var_67_43)
						arg_64_1:RecordAudio("325582016", var_67_43)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325582", "325582016", "story_v_out_325582.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325582", "325582016", "story_v_out_325582.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_44 = math.max(var_67_35, arg_64_1.talkMaxDuration)

			if var_67_34 <= arg_64_1.time_ and arg_64_1.time_ < var_67_34 + var_67_44 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_34) / var_67_44

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_34 + var_67_44 and arg_64_1.time_ < var_67_34 + var_67_44 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10166ui_story",
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
	Play325582017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325582017
		arg_68_1.duration_ = 4.43

		local var_68_0 = {
			zh = 4.033,
			ja = 4.433
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
				arg_68_0:Play325582018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10175ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10175ui_story == nil then
				arg_68_1.var_.characterEffect10175ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect10175ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10175ui_story then
				arg_68_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["10166ui_story"]
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect10166ui_story == nil then
				arg_68_1.var_.characterEffect10166ui_story = var_71_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.200000002980232

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 and not isNil(var_71_4) then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6

				if arg_68_1.var_.characterEffect10166ui_story and not isNil(var_71_4) then
					local var_71_8 = Mathf.Lerp(0, 0.5, var_71_7)

					arg_68_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_68_1.var_.characterEffect10166ui_story.fillRatio = var_71_8
				end
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect10166ui_story then
				local var_71_9 = 0.5

				arg_68_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_68_1.var_.characterEffect10166ui_story.fillRatio = var_71_9
			end

			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			local var_71_11 = 0

			if var_71_11 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_71_12 = 0
			local var_71_13 = 0.525

			if var_71_12 < arg_68_1.time_ and arg_68_1.time_ <= var_71_12 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_14 = arg_68_1:FormatText(StoryNameCfg[1473].name)

				arg_68_1.leftNameTxt_.text = var_71_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_15 = arg_68_1:GetWordFromCfg(325582017)
				local var_71_16 = arg_68_1:FormatText(var_71_15.content)

				arg_68_1.text_.text = var_71_16

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_17 = 21
				local var_71_18 = utf8.len(var_71_16)
				local var_71_19 = var_71_17 <= 0 and var_71_13 or var_71_13 * (var_71_18 / var_71_17)

				if var_71_19 > 0 and var_71_13 < var_71_19 then
					arg_68_1.talkMaxDuration = var_71_19

					if var_71_19 + var_71_12 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_19 + var_71_12
					end
				end

				arg_68_1.text_.text = var_71_16
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582017", "story_v_out_325582.awb") ~= 0 then
					local var_71_20 = manager.audio:GetVoiceLength("story_v_out_325582", "325582017", "story_v_out_325582.awb") / 1000

					if var_71_20 + var_71_12 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_20 + var_71_12
					end

					if var_71_15.prefab_name ~= "" and arg_68_1.actors_[var_71_15.prefab_name] ~= nil then
						local var_71_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_15.prefab_name].transform, "story_v_out_325582", "325582017", "story_v_out_325582.awb")

						arg_68_1:RecordAudio("325582017", var_71_21)
						arg_68_1:RecordAudio("325582017", var_71_21)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325582", "325582017", "story_v_out_325582.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325582", "325582017", "story_v_out_325582.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_22 = math.max(var_71_13, arg_68_1.talkMaxDuration)

			if var_71_12 <= arg_68_1.time_ and arg_68_1.time_ < var_71_12 + var_71_22 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_12) / var_71_22

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_12 + var_71_22 and arg_68_1.time_ < var_71_12 + var_71_22 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play325582018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325582018
		arg_72_1.duration_ = 7.87

		local var_72_0 = {
			zh = 4.466,
			ja = 7.866
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
				arg_72_0:Play325582019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_2")
			end

			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_75_2 = 0
			local var_75_3 = 0.6

			if var_75_2 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_4 = arg_72_1:FormatText(StoryNameCfg[1473].name)

				arg_72_1.leftNameTxt_.text = var_75_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_5 = arg_72_1:GetWordFromCfg(325582018)
				local var_75_6 = arg_72_1:FormatText(var_75_5.content)

				arg_72_1.text_.text = var_75_6

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 24
				local var_75_8 = utf8.len(var_75_6)
				local var_75_9 = var_75_7 <= 0 and var_75_3 or var_75_3 * (var_75_8 / var_75_7)

				if var_75_9 > 0 and var_75_3 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_6
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582018", "story_v_out_325582.awb") ~= 0 then
					local var_75_10 = manager.audio:GetVoiceLength("story_v_out_325582", "325582018", "story_v_out_325582.awb") / 1000

					if var_75_10 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_2
					end

					if var_75_5.prefab_name ~= "" and arg_72_1.actors_[var_75_5.prefab_name] ~= nil then
						local var_75_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_5.prefab_name].transform, "story_v_out_325582", "325582018", "story_v_out_325582.awb")

						arg_72_1:RecordAudio("325582018", var_75_11)
						arg_72_1:RecordAudio("325582018", var_75_11)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325582", "325582018", "story_v_out_325582.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325582", "325582018", "story_v_out_325582.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_12 and arg_72_1.time_ < var_75_2 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play325582019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325582019
		arg_76_1.duration_ = 5.23

		local var_76_0 = {
			zh = 4.133,
			ja = 5.233
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
				arg_76_0:Play325582020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10166ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos10166ui_story = var_79_0.localPosition

				local var_79_2 = GameObjectTools.GetOrAddComponent(var_79_0.gameObject, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(false)
				end
			end

			local var_79_3 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_3 then
				local var_79_4 = (arg_76_1.time_ - var_79_1) / var_79_3
				local var_79_5 = Vector3.New(0, 100, 0)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10166ui_story, var_79_5, var_79_4)

				local var_79_6 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_6.x, var_79_6.y, var_79_6.z)

				local var_79_7 = var_79_0.localEulerAngles

				var_79_7.z = 0
				var_79_7.x = 0
				var_79_0.localEulerAngles = var_79_7
			end

			if arg_76_1.time_ >= var_79_1 + var_79_3 and arg_76_1.time_ < var_79_1 + var_79_3 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_79_11 = "10162ui_story"

			if arg_76_1.actors_[var_79_11] == nil then
				local var_79_12 = Asset.Load("Char/" .. "10162ui_story")

				if not isNil(var_79_12) then
					local var_79_13 = Object.Instantiate(Asset.Load("Char/" .. "10162ui_story"), arg_76_1.stage_.transform)

					var_79_13.name = var_79_11
					var_79_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_76_1.actors_[var_79_11] = var_79_13

					local var_79_14 = var_79_13:GetComponentInChildren(typeof(CharacterEffect))

					var_79_14.enabled = true

					local var_79_15 = GameObjectTools.GetOrAddComponent(var_79_13, typeof(DynamicBoneHelper))

					if var_79_15 then
						var_79_15:EnableDynamicBone(false)
					end

					arg_76_1:ShowWeapon(var_79_14.transform, false)

					arg_76_1.var_[var_79_11 .. "Animator"] = var_79_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_76_1.var_[var_79_11 .. "Animator"].applyRootMotion = true
					arg_76_1.var_[var_79_11 .. "LipSync"] = var_79_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_79_16 = arg_76_1.actors_["10162ui_story"].transform
			local var_79_17 = 0

			if var_79_17 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 then
				arg_76_1.var_.moveOldPos10162ui_story = var_79_16.localPosition

				local var_79_18 = GameObjectTools.GetOrAddComponent(var_79_16.gameObject, typeof(DynamicBoneHelper))

				if var_79_18 then
					var_79_18:EnableDynamicBone(false)
				end
			end

			local var_79_19 = 0.001

			if var_79_17 <= arg_76_1.time_ and arg_76_1.time_ < var_79_17 + var_79_19 then
				local var_79_20 = (arg_76_1.time_ - var_79_17) / var_79_19
				local var_79_21 = Vector3.New(0, -1.08, -5.83)

				var_79_16.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10162ui_story, var_79_21, var_79_20)

				local var_79_22 = manager.ui.mainCamera.transform.position - var_79_16.position

				var_79_16.forward = Vector3.New(var_79_22.x, var_79_22.y, var_79_22.z)

				local var_79_23 = var_79_16.localEulerAngles

				var_79_23.z = 0
				var_79_23.x = 0
				var_79_16.localEulerAngles = var_79_23
			end

			if arg_76_1.time_ >= var_79_17 + var_79_19 and arg_76_1.time_ < var_79_17 + var_79_19 + arg_79_0 then
				var_79_16.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_79_24 = manager.ui.mainCamera.transform.position - var_79_16.position

				var_79_16.forward = Vector3.New(var_79_24.x, var_79_24.y, var_79_24.z)

				local var_79_25 = var_79_16.localEulerAngles

				var_79_25.z = 0
				var_79_25.x = 0
				var_79_16.localEulerAngles = var_79_25

				local var_79_26 = GameObjectTools.GetOrAddComponent(var_79_16.gameObject, typeof(DynamicBoneHelper))

				if var_79_26 then
					var_79_26:EnableDynamicBone(true)
				end
			end

			local var_79_27 = arg_76_1.actors_["10175ui_story"].transform
			local var_79_28 = 0

			if var_79_28 < arg_76_1.time_ and arg_76_1.time_ <= var_79_28 + arg_79_0 then
				arg_76_1.var_.moveOldPos10175ui_story = var_79_27.localPosition

				local var_79_29 = GameObjectTools.GetOrAddComponent(var_79_27.gameObject, typeof(DynamicBoneHelper))

				if var_79_29 then
					var_79_29:EnableDynamicBone(false)
				end
			end

			local var_79_30 = 0.001

			if var_79_28 <= arg_76_1.time_ and arg_76_1.time_ < var_79_28 + var_79_30 then
				local var_79_31 = (arg_76_1.time_ - var_79_28) / var_79_30
				local var_79_32 = Vector3.New(0, 100, 0)

				var_79_27.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10175ui_story, var_79_32, var_79_31)

				local var_79_33 = manager.ui.mainCamera.transform.position - var_79_27.position

				var_79_27.forward = Vector3.New(var_79_33.x, var_79_33.y, var_79_33.z)

				local var_79_34 = var_79_27.localEulerAngles

				var_79_34.z = 0
				var_79_34.x = 0
				var_79_27.localEulerAngles = var_79_34
			end

			if arg_76_1.time_ >= var_79_28 + var_79_30 and arg_76_1.time_ < var_79_28 + var_79_30 + arg_79_0 then
				var_79_27.localPosition = Vector3.New(0, 100, 0)

				local var_79_35 = manager.ui.mainCamera.transform.position - var_79_27.position

				var_79_27.forward = Vector3.New(var_79_35.x, var_79_35.y, var_79_35.z)

				local var_79_36 = var_79_27.localEulerAngles

				var_79_36.z = 0
				var_79_36.x = 0
				var_79_27.localEulerAngles = var_79_36

				local var_79_37 = GameObjectTools.GetOrAddComponent(var_79_27.gameObject, typeof(DynamicBoneHelper))

				if var_79_37 then
					var_79_37:EnableDynamicBone(true)
				end
			end

			local var_79_38 = arg_76_1.actors_["10162ui_story"]
			local var_79_39 = 0

			if var_79_39 < arg_76_1.time_ and arg_76_1.time_ <= var_79_39 + arg_79_0 and not isNil(var_79_38) and arg_76_1.var_.characterEffect10162ui_story == nil then
				arg_76_1.var_.characterEffect10162ui_story = var_79_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_40 = 0.200000002980232

			if var_79_39 <= arg_76_1.time_ and arg_76_1.time_ < var_79_39 + var_79_40 and not isNil(var_79_38) then
				local var_79_41 = (arg_76_1.time_ - var_79_39) / var_79_40

				if arg_76_1.var_.characterEffect10162ui_story and not isNil(var_79_38) then
					arg_76_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_39 + var_79_40 and arg_76_1.time_ < var_79_39 + var_79_40 + arg_79_0 and not isNil(var_79_38) and arg_76_1.var_.characterEffect10162ui_story then
				arg_76_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_79_42 = arg_76_1.actors_["10175ui_story"]
			local var_79_43 = 0

			if var_79_43 < arg_76_1.time_ and arg_76_1.time_ <= var_79_43 + arg_79_0 and not isNil(var_79_42) and arg_76_1.var_.characterEffect10175ui_story == nil then
				arg_76_1.var_.characterEffect10175ui_story = var_79_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_44 = 0.200000002980232

			if var_79_43 <= arg_76_1.time_ and arg_76_1.time_ < var_79_43 + var_79_44 and not isNil(var_79_42) then
				local var_79_45 = (arg_76_1.time_ - var_79_43) / var_79_44

				if arg_76_1.var_.characterEffect10175ui_story and not isNil(var_79_42) then
					local var_79_46 = Mathf.Lerp(0, 0.5, var_79_45)

					arg_76_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_76_1.var_.characterEffect10175ui_story.fillRatio = var_79_46
				end
			end

			if arg_76_1.time_ >= var_79_43 + var_79_44 and arg_76_1.time_ < var_79_43 + var_79_44 + arg_79_0 and not isNil(var_79_42) and arg_76_1.var_.characterEffect10175ui_story then
				local var_79_47 = 0.5

				arg_76_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_76_1.var_.characterEffect10175ui_story.fillRatio = var_79_47
			end

			local var_79_48 = 0

			if var_79_48 < arg_76_1.time_ and arg_76_1.time_ <= var_79_48 + arg_79_0 then
				arg_76_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_79_49 = 0

			if var_79_49 < arg_76_1.time_ and arg_76_1.time_ <= var_79_49 + arg_79_0 then
				arg_76_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_50 = 0
			local var_79_51 = 0.375

			if var_79_50 < arg_76_1.time_ and arg_76_1.time_ <= var_79_50 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_52 = arg_76_1:FormatText(StoryNameCfg[1533].name)

				arg_76_1.leftNameTxt_.text = var_79_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_53 = arg_76_1:GetWordFromCfg(325582019)
				local var_79_54 = arg_76_1:FormatText(var_79_53.content)

				arg_76_1.text_.text = var_79_54

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_55 = 15
				local var_79_56 = utf8.len(var_79_54)
				local var_79_57 = var_79_55 <= 0 and var_79_51 or var_79_51 * (var_79_56 / var_79_55)

				if var_79_57 > 0 and var_79_51 < var_79_57 then
					arg_76_1.talkMaxDuration = var_79_57

					if var_79_57 + var_79_50 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_57 + var_79_50
					end
				end

				arg_76_1.text_.text = var_79_54
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582019", "story_v_out_325582.awb") ~= 0 then
					local var_79_58 = manager.audio:GetVoiceLength("story_v_out_325582", "325582019", "story_v_out_325582.awb") / 1000

					if var_79_58 + var_79_50 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_58 + var_79_50
					end

					if var_79_53.prefab_name ~= "" and arg_76_1.actors_[var_79_53.prefab_name] ~= nil then
						local var_79_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_53.prefab_name].transform, "story_v_out_325582", "325582019", "story_v_out_325582.awb")

						arg_76_1:RecordAudio("325582019", var_79_59)
						arg_76_1:RecordAudio("325582019", var_79_59)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325582", "325582019", "story_v_out_325582.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325582", "325582019", "story_v_out_325582.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_60 = math.max(var_79_51, arg_76_1.talkMaxDuration)

			if var_79_50 <= arg_76_1.time_ and arg_76_1.time_ < var_79_50 + var_79_60 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_50) / var_79_60

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_50 + var_79_60 and arg_76_1.time_ < var_79_50 + var_79_60 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
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
	Play325582020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325582020
		arg_80_1.duration_ = 7.17

		local var_80_0 = {
			zh = 7.166,
			ja = 5.5
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
				arg_80_0:Play325582021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_83_2 = arg_80_1.actors_["10162ui_story"]
			local var_83_3 = 0

			if var_83_3 < arg_80_1.time_ and arg_80_1.time_ <= var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect10162ui_story == nil then
				arg_80_1.var_.characterEffect10162ui_story = var_83_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_4 = 0.200000002980232

			if var_83_3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_3 + var_83_4 and not isNil(var_83_2) then
				local var_83_5 = (arg_80_1.time_ - var_83_3) / var_83_4

				if arg_80_1.var_.characterEffect10162ui_story and not isNil(var_83_2) then
					local var_83_6 = Mathf.Lerp(0, 0.5, var_83_5)

					arg_80_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10162ui_story.fillRatio = var_83_6
				end
			end

			if arg_80_1.time_ >= var_83_3 + var_83_4 and arg_80_1.time_ < var_83_3 + var_83_4 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect10162ui_story then
				local var_83_7 = 0.5

				arg_80_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10162ui_story.fillRatio = var_83_7
			end

			local var_83_8 = 0
			local var_83_9 = 0.55

			if var_83_8 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_10 = arg_80_1:FormatText(StoryNameCfg[1532].name)

				arg_80_1.leftNameTxt_.text = var_83_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_11 = arg_80_1:GetWordFromCfg(325582020)
				local var_83_12 = arg_80_1:FormatText(var_83_11.content)

				arg_80_1.text_.text = var_83_12

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_13 = 22
				local var_83_14 = utf8.len(var_83_12)
				local var_83_15 = var_83_13 <= 0 and var_83_9 or var_83_9 * (var_83_14 / var_83_13)

				if var_83_15 > 0 and var_83_9 < var_83_15 then
					arg_80_1.talkMaxDuration = var_83_15

					if var_83_15 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_15 + var_83_8
					end
				end

				arg_80_1.text_.text = var_83_12
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582020", "story_v_out_325582.awb") ~= 0 then
					local var_83_16 = manager.audio:GetVoiceLength("story_v_out_325582", "325582020", "story_v_out_325582.awb") / 1000

					if var_83_16 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_16 + var_83_8
					end

					if var_83_11.prefab_name ~= "" and arg_80_1.actors_[var_83_11.prefab_name] ~= nil then
						local var_83_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_11.prefab_name].transform, "story_v_out_325582", "325582020", "story_v_out_325582.awb")

						arg_80_1:RecordAudio("325582020", var_83_17)
						arg_80_1:RecordAudio("325582020", var_83_17)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_325582", "325582020", "story_v_out_325582.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_325582", "325582020", "story_v_out_325582.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_18 = math.max(var_83_9, arg_80_1.talkMaxDuration)

			if var_83_8 <= arg_80_1.time_ and arg_80_1.time_ < var_83_8 + var_83_18 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_8) / var_83_18

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_8 + var_83_18 and arg_80_1.time_ < var_83_8 + var_83_18 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play325582021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325582021
		arg_84_1.duration_ = 4.8

		local var_84_0 = {
			zh = 4.433,
			ja = 4.8
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
				arg_84_0:Play325582022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["10162ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10162ui_story == nil then
				arg_84_1.var_.characterEffect10162ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect10162ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10162ui_story then
				arg_84_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_87_4 = 0

			if var_87_4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_1")
			end

			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_87_6 = 0
			local var_87_7 = 0.425

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[1533].name)

				arg_84_1.leftNameTxt_.text = var_87_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_9 = arg_84_1:GetWordFromCfg(325582021)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582021", "story_v_out_325582.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_325582", "325582021", "story_v_out_325582.awb") / 1000

					if var_87_14 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_6
					end

					if var_87_9.prefab_name ~= "" and arg_84_1.actors_[var_87_9.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_9.prefab_name].transform, "story_v_out_325582", "325582021", "story_v_out_325582.awb")

						arg_84_1:RecordAudio("325582021", var_87_15)
						arg_84_1:RecordAudio("325582021", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_325582", "325582021", "story_v_out_325582.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_325582", "325582021", "story_v_out_325582.awb")
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
	Play325582022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325582022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play325582023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10162ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos10162ui_story = var_91_0.localPosition

				local var_91_2 = GameObjectTools.GetOrAddComponent(var_91_0.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(false)
				end
			end

			local var_91_3 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_3 then
				local var_91_4 = (arg_88_1.time_ - var_91_1) / var_91_3
				local var_91_5 = Vector3.New(0, 100, 0)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10162ui_story, var_91_5, var_91_4)

				local var_91_6 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_6.x, var_91_6.y, var_91_6.z)

				local var_91_7 = var_91_0.localEulerAngles

				var_91_7.z = 0
				var_91_7.x = 0
				var_91_0.localEulerAngles = var_91_7
			end

			if arg_88_1.time_ >= var_91_1 + var_91_3 and arg_88_1.time_ < var_91_1 + var_91_3 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, 100, 0)

				local var_91_8 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_8.x, var_91_8.y, var_91_8.z)

				local var_91_9 = var_91_0.localEulerAngles

				var_91_9.z = 0
				var_91_9.x = 0
				var_91_0.localEulerAngles = var_91_9

				local var_91_10 = GameObjectTools.GetOrAddComponent(var_91_0.gameObject, typeof(DynamicBoneHelper))

				if var_91_10 then
					var_91_10:EnableDynamicBone(true)
				end
			end

			local var_91_11 = arg_88_1.actors_["10162ui_story"]
			local var_91_12 = 0

			if var_91_12 < arg_88_1.time_ and arg_88_1.time_ <= var_91_12 + arg_91_0 and not isNil(var_91_11) and arg_88_1.var_.characterEffect10162ui_story == nil then
				arg_88_1.var_.characterEffect10162ui_story = var_91_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_13 = 0.200000002980232

			if var_91_12 <= arg_88_1.time_ and arg_88_1.time_ < var_91_12 + var_91_13 and not isNil(var_91_11) then
				local var_91_14 = (arg_88_1.time_ - var_91_12) / var_91_13

				if arg_88_1.var_.characterEffect10162ui_story and not isNil(var_91_11) then
					local var_91_15 = Mathf.Lerp(0, 0.5, var_91_14)

					arg_88_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_88_1.var_.characterEffect10162ui_story.fillRatio = var_91_15
				end
			end

			if arg_88_1.time_ >= var_91_12 + var_91_13 and arg_88_1.time_ < var_91_12 + var_91_13 + arg_91_0 and not isNil(var_91_11) and arg_88_1.var_.characterEffect10162ui_story then
				local var_91_16 = 0.5

				arg_88_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_88_1.var_.characterEffect10162ui_story.fillRatio = var_91_16
			end

			local var_91_17 = 0
			local var_91_18 = 1.6

			if var_91_17 < arg_88_1.time_ and arg_88_1.time_ <= var_91_17 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_19 = arg_88_1:GetWordFromCfg(325582022)
				local var_91_20 = arg_88_1:FormatText(var_91_19.content)

				arg_88_1.text_.text = var_91_20

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_21 = 64
				local var_91_22 = utf8.len(var_91_20)
				local var_91_23 = var_91_21 <= 0 and var_91_18 or var_91_18 * (var_91_22 / var_91_21)

				if var_91_23 > 0 and var_91_18 < var_91_23 then
					arg_88_1.talkMaxDuration = var_91_23

					if var_91_23 + var_91_17 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_17
					end
				end

				arg_88_1.text_.text = var_91_20
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_24 = math.max(var_91_18, arg_88_1.talkMaxDuration)

			if var_91_17 <= arg_88_1.time_ and arg_88_1.time_ < var_91_17 + var_91_24 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_17) / var_91_24

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_17 + var_91_24 and arg_88_1.time_ < var_91_17 + var_91_24 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play325582023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325582023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play325582024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 1

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				local var_95_2 = "play"
				local var_95_3 = "effect"

				arg_92_1:AudioAction(var_95_2, var_95_3, "se_story_15", "se_story_15_roar3", "")
			end

			local var_95_4 = 0
			local var_95_5 = 0.5

			if var_95_4 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				local var_95_6 = "play"
				local var_95_7 = "effect"

				arg_92_1:AudioAction(var_95_6, var_95_7, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_95_8 = 0
			local var_95_9 = 1.175

			if var_95_8 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_10 = arg_92_1:GetWordFromCfg(325582023)
				local var_95_11 = arg_92_1:FormatText(var_95_10.content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_12 = 47
				local var_95_13 = utf8.len(var_95_11)
				local var_95_14 = var_95_12 <= 0 and var_95_9 or var_95_9 * (var_95_13 / var_95_12)

				if var_95_14 > 0 and var_95_9 < var_95_14 then
					arg_92_1.talkMaxDuration = var_95_14

					if var_95_14 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_15 = math.max(var_95_9, arg_92_1.talkMaxDuration)

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_15 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_8) / var_95_15

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_8 + var_95_15 and arg_92_1.time_ < var_95_8 + var_95_15 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play325582024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325582024
		arg_96_1.duration_ = 2

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325582025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10175ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos10175ui_story = var_99_0.localPosition

				local var_99_2 = GameObjectTools.GetOrAddComponent(var_99_0.gameObject, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(false)
				end
			end

			local var_99_3 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_3 then
				local var_99_4 = (arg_96_1.time_ - var_99_1) / var_99_3
				local var_99_5 = Vector3.New(0, -1, -6.05)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10175ui_story, var_99_5, var_99_4)

				local var_99_6 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_6.x, var_99_6.y, var_99_6.z)

				local var_99_7 = var_99_0.localEulerAngles

				var_99_7.z = 0
				var_99_7.x = 0
				var_99_0.localEulerAngles = var_99_7
			end

			if arg_96_1.time_ >= var_99_1 + var_99_3 and arg_96_1.time_ < var_99_1 + var_99_3 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, -1, -6.05)

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

			local var_99_11 = arg_96_1.actors_["10175ui_story"]
			local var_99_12 = 0

			if var_99_12 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 and not isNil(var_99_11) and arg_96_1.var_.characterEffect10175ui_story == nil then
				arg_96_1.var_.characterEffect10175ui_story = var_99_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_13 = 0.200000002980232

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_13 and not isNil(var_99_11) then
				local var_99_14 = (arg_96_1.time_ - var_99_12) / var_99_13

				if arg_96_1.var_.characterEffect10175ui_story and not isNil(var_99_11) then
					arg_96_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_12 + var_99_13 and arg_96_1.time_ < var_99_12 + var_99_13 + arg_99_0 and not isNil(var_99_11) and arg_96_1.var_.characterEffect10175ui_story then
				arg_96_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_99_15 = 0

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaB", "EmotionTimelineAnimator")
			end

			local var_99_16 = 0
			local var_99_17 = 0.125

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_18 = arg_96_1:FormatText(StoryNameCfg[1473].name)

				arg_96_1.leftNameTxt_.text = var_99_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_19 = arg_96_1:GetWordFromCfg(325582024)
				local var_99_20 = arg_96_1:FormatText(var_99_19.content)

				arg_96_1.text_.text = var_99_20

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_21 = 5
				local var_99_22 = utf8.len(var_99_20)
				local var_99_23 = var_99_21 <= 0 and var_99_17 or var_99_17 * (var_99_22 / var_99_21)

				if var_99_23 > 0 and var_99_17 < var_99_23 then
					arg_96_1.talkMaxDuration = var_99_23

					if var_99_23 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_16
					end
				end

				arg_96_1.text_.text = var_99_20
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582024", "story_v_out_325582.awb") ~= 0 then
					local var_99_24 = manager.audio:GetVoiceLength("story_v_out_325582", "325582024", "story_v_out_325582.awb") / 1000

					if var_99_24 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_24 + var_99_16
					end

					if var_99_19.prefab_name ~= "" and arg_96_1.actors_[var_99_19.prefab_name] ~= nil then
						local var_99_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_19.prefab_name].transform, "story_v_out_325582", "325582024", "story_v_out_325582.awb")

						arg_96_1:RecordAudio("325582024", var_99_25)
						arg_96_1:RecordAudio("325582024", var_99_25)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325582", "325582024", "story_v_out_325582.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325582", "325582024", "story_v_out_325582.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_26 = math.max(var_99_17, arg_96_1.talkMaxDuration)

			if var_99_16 <= arg_96_1.time_ and arg_96_1.time_ < var_99_16 + var_99_26 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_16) / var_99_26

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_16 + var_99_26 and arg_96_1.time_ < var_99_16 + var_99_26 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
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
	Play325582025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325582025
		arg_100_1.duration_ = 5.2

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play325582026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["10175ui_story"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos10175ui_story = var_103_0.localPosition

				local var_103_2 = GameObjectTools.GetOrAddComponent(var_103_0.gameObject, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(false)
				end
			end

			local var_103_3 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_3 then
				local var_103_4 = (arg_100_1.time_ - var_103_1) / var_103_3
				local var_103_5 = Vector3.New(0, 100, 0)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10175ui_story, var_103_5, var_103_4)

				local var_103_6 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_6.x, var_103_6.y, var_103_6.z)

				local var_103_7 = var_103_0.localEulerAngles

				var_103_7.z = 0
				var_103_7.x = 0
				var_103_0.localEulerAngles = var_103_7
			end

			if arg_100_1.time_ >= var_103_1 + var_103_3 and arg_100_1.time_ < var_103_1 + var_103_3 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(0, 100, 0)

				local var_103_8 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_8.x, var_103_8.y, var_103_8.z)

				local var_103_9 = var_103_0.localEulerAngles

				var_103_9.z = 0
				var_103_9.x = 0
				var_103_0.localEulerAngles = var_103_9

				local var_103_10 = GameObjectTools.GetOrAddComponent(var_103_0.gameObject, typeof(DynamicBoneHelper))

				if var_103_10 then
					var_103_10:EnableDynamicBone(true)
				end
			end

			local var_103_11 = arg_100_1.actors_["10175ui_story"]
			local var_103_12 = 0

			if var_103_12 < arg_100_1.time_ and arg_100_1.time_ <= var_103_12 + arg_103_0 and not isNil(var_103_11) and arg_100_1.var_.characterEffect10175ui_story == nil then
				arg_100_1.var_.characterEffect10175ui_story = var_103_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_13 = 0.200000002980232

			if var_103_12 <= arg_100_1.time_ and arg_100_1.time_ < var_103_12 + var_103_13 and not isNil(var_103_11) then
				local var_103_14 = (arg_100_1.time_ - var_103_12) / var_103_13

				if arg_100_1.var_.characterEffect10175ui_story and not isNil(var_103_11) then
					local var_103_15 = Mathf.Lerp(0, 0.5, var_103_14)

					arg_100_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_100_1.var_.characterEffect10175ui_story.fillRatio = var_103_15
				end
			end

			if arg_100_1.time_ >= var_103_12 + var_103_13 and arg_100_1.time_ < var_103_12 + var_103_13 + arg_103_0 and not isNil(var_103_11) and arg_100_1.var_.characterEffect10175ui_story then
				local var_103_16 = 0.5

				arg_100_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_100_1.var_.characterEffect10175ui_story.fillRatio = var_103_16
			end

			local var_103_17 = arg_100_1.bgs_.J26h.transform
			local var_103_18 = 0

			if var_103_18 < arg_100_1.time_ and arg_100_1.time_ <= var_103_18 + arg_103_0 then
				arg_100_1.var_.moveOldPosJ26h = var_103_17.localPosition
			end

			local var_103_19 = 1.13333333333333

			if var_103_18 <= arg_100_1.time_ and arg_100_1.time_ < var_103_18 + var_103_19 then
				local var_103_20 = (arg_100_1.time_ - var_103_18) / var_103_19
				local var_103_21 = Vector3.New(0, 1, 9)

				var_103_17.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPosJ26h, var_103_21, var_103_20)
			end

			if arg_100_1.time_ >= var_103_18 + var_103_19 and arg_100_1.time_ < var_103_18 + var_103_19 + arg_103_0 then
				var_103_17.localPosition = Vector3.New(0, 1, 9)
			end

			local var_103_22 = manager.ui.mainCamera.transform
			local var_103_23 = 0.200000002980232

			if var_103_23 < arg_100_1.time_ and arg_100_1.time_ <= var_103_23 + arg_103_0 then
				local var_103_24 = arg_100_1.var_.effectqiongqixilai1
				local var_103_25
				local var_103_26 = var_103_22

				if not var_103_24 then
					var_103_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), var_103_26)
					var_103_24.name = "qiongqixilai1"
					arg_100_1.var_.effectqiongqixilai1 = var_103_24
				else
					var_103_24.transform:SetParent(var_103_26)
				end

				var_103_24.transform.localPosition = Vector3.New(0, 0, 0)
				var_103_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_103_27 = 0

			if var_103_27 < arg_100_1.time_ and arg_100_1.time_ <= var_103_27 + arg_103_0 then
				arg_100_1.allBtn_.enabled = false
			end

			local var_103_28 = 1.13333333333333

			if arg_100_1.time_ >= var_103_27 + var_103_28 and arg_100_1.time_ < var_103_27 + var_103_28 + arg_103_0 then
				arg_100_1.allBtn_.enabled = true
			end

			local var_103_29 = 1
			local var_103_30 = 1

			if var_103_29 < arg_100_1.time_ and arg_100_1.time_ <= var_103_29 + arg_103_0 then
				local var_103_31 = "play"
				local var_103_32 = "effect"

				arg_100_1:AudioAction(var_103_31, var_103_32, "se_story_145", "se_story_145_monster_roar1", "")
			end

			local var_103_33 = 0
			local var_103_34 = 1

			if var_103_33 < arg_100_1.time_ and arg_100_1.time_ <= var_103_33 + arg_103_0 then
				local var_103_35 = "play"
				local var_103_36 = "music"

				arg_100_1:AudioAction(var_103_35, var_103_36, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_103_37 = ""
				local var_103_38 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_103_38 ~= "" then
					if arg_100_1.bgmTxt_.text ~= var_103_38 and arg_100_1.bgmTxt_.text ~= "" then
						if arg_100_1.bgmTxt2_.text ~= "" then
							arg_100_1.bgmTxt_.text = arg_100_1.bgmTxt2_.text
						end

						arg_100_1.bgmTxt2_.text = var_103_38

						arg_100_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_100_1.bgmTxt_.text = var_103_38
						arg_100_1.bgmTxt2_.text = var_103_38
					end

					if arg_100_1.bgmTimer then
						arg_100_1.bgmTimer:Stop()

						arg_100_1.bgmTimer = nil
					end

					if arg_100_1.settingData.show_music_name == 1 then
						arg_100_1.musicController:SetSelectedState("show")
						arg_100_1.musicAnimator_:Play("open", 0, 0)

						if arg_100_1.settingData.music_time ~= 0 then
							arg_100_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_100_1.settingData.music_time), function()
								if arg_100_1 == nil or isNil(arg_100_1.bgmTxt_) then
									return
								end

								arg_100_1.musicController:SetSelectedState("hide")
								arg_100_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_100_1.frameCnt_ <= 1 then
				arg_100_1.dialog_:SetActive(false)
			end

			local var_103_39 = 0.2
			local var_103_40 = 0.075

			if var_103_39 < arg_100_1.time_ and arg_100_1.time_ <= var_103_39 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0

				arg_100_1.dialog_:SetActive(true)

				arg_100_1.dialogCg_.alpha = 0

				local var_103_41 = LeanTween.value(arg_100_1.dialog_, 0, 1, 0.3)

				var_103_41:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_100_1.dialogCg_.alpha = arg_105_0
				end))
				var_103_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_100_1.dialog_)
					var_103_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_100_1.duration_ = arg_100_1.duration_ + 0.3

				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_42 = arg_100_1:FormatText(StoryNameCfg[1534].name)

				arg_100_1.leftNameTxt_.text = var_103_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4053")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_43 = arg_100_1:GetWordFromCfg(325582025)
				local var_103_44 = arg_100_1:FormatText(var_103_43.content)

				arg_100_1.text_.text = var_103_44

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_45 = 3
				local var_103_46 = utf8.len(var_103_44)
				local var_103_47 = var_103_45 <= 0 and var_103_40 or var_103_40 * (var_103_46 / var_103_45)

				if var_103_47 > 0 and var_103_40 < var_103_47 then
					arg_100_1.talkMaxDuration = var_103_47
					var_103_39 = var_103_39 + 0.3

					if var_103_47 + var_103_39 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_47 + var_103_39
					end
				end

				arg_100_1.text_.text = var_103_44
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_48 = var_103_39 + 0.3
			local var_103_49 = math.max(var_103_40, arg_100_1.talkMaxDuration)

			if var_103_48 <= arg_100_1.time_ and arg_100_1.time_ < var_103_48 + var_103_49 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_48) / var_103_49

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_48 + var_103_49 and arg_100_1.time_ < var_103_48 + var_103_49 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "J26h",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.13333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play325582026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 325582026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play325582027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 1
			local var_110_1 = 1

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				local var_110_2 = "play"
				local var_110_3 = "effect"

				arg_107_1:AudioAction(var_110_2, var_110_3, "se_story_15", "se_story_15_blast03", "")
			end

			local var_110_4 = 0
			local var_110_5 = 1.625

			if var_110_4 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(325582026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_8 = 65
				local var_110_9 = utf8.len(var_110_7)
				local var_110_10 = var_110_8 <= 0 and var_110_5 or var_110_5 * (var_110_9 / var_110_8)

				if var_110_10 > 0 and var_110_5 < var_110_10 then
					arg_107_1.talkMaxDuration = var_110_10

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_11 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_11 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_11

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_11 and arg_107_1.time_ < var_110_4 + var_110_11 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play325582027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 325582027
		arg_111_1.duration_ = 3.43

		local var_111_0 = {
			zh = 2.566,
			ja = 3.433
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
				arg_111_0:Play325582028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10175ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos10175ui_story = var_114_0.localPosition

				local var_114_2 = GameObjectTools.GetOrAddComponent(var_114_0.gameObject, typeof(DynamicBoneHelper))

				if var_114_2 then
					var_114_2:EnableDynamicBone(false)
				end
			end

			local var_114_3 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_3 then
				local var_114_4 = (arg_111_1.time_ - var_114_1) / var_114_3
				local var_114_5 = Vector3.New(0, -1, -6.05)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10175ui_story, var_114_5, var_114_4)

				local var_114_6 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_6.x, var_114_6.y, var_114_6.z)

				local var_114_7 = var_114_0.localEulerAngles

				var_114_7.z = 0
				var_114_7.x = 0
				var_114_0.localEulerAngles = var_114_7
			end

			if arg_111_1.time_ >= var_114_1 + var_114_3 and arg_111_1.time_ < var_114_1 + var_114_3 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_114_8 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_8.x, var_114_8.y, var_114_8.z)

				local var_114_9 = var_114_0.localEulerAngles

				var_114_9.z = 0
				var_114_9.x = 0
				var_114_0.localEulerAngles = var_114_9

				local var_114_10 = GameObjectTools.GetOrAddComponent(var_114_0.gameObject, typeof(DynamicBoneHelper))

				if var_114_10 then
					var_114_10:EnableDynamicBone(true)
				end
			end

			local var_114_11 = arg_111_1.actors_["10175ui_story"]
			local var_114_12 = 0

			if var_114_12 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 and not isNil(var_114_11) and arg_111_1.var_.characterEffect10175ui_story == nil then
				arg_111_1.var_.characterEffect10175ui_story = var_114_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_13 = 0.200000002980232

			if var_114_12 <= arg_111_1.time_ and arg_111_1.time_ < var_114_12 + var_114_13 and not isNil(var_114_11) then
				local var_114_14 = (arg_111_1.time_ - var_114_12) / var_114_13

				if arg_111_1.var_.characterEffect10175ui_story and not isNil(var_114_11) then
					arg_111_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_12 + var_114_13 and arg_111_1.time_ < var_114_12 + var_114_13 + arg_114_0 and not isNil(var_114_11) and arg_111_1.var_.characterEffect10175ui_story then
				arg_111_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_114_15 = 0

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 then
				arg_111_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_114_16 = 0

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_114_17 = 0
			local var_114_18 = 0.3

			if var_114_17 < arg_111_1.time_ and arg_111_1.time_ <= var_114_17 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_19 = arg_111_1:FormatText(StoryNameCfg[1473].name)

				arg_111_1.leftNameTxt_.text = var_114_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_20 = arg_111_1:GetWordFromCfg(325582027)
				local var_114_21 = arg_111_1:FormatText(var_114_20.content)

				arg_111_1.text_.text = var_114_21

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_22 = 12
				local var_114_23 = utf8.len(var_114_21)
				local var_114_24 = var_114_22 <= 0 and var_114_18 or var_114_18 * (var_114_23 / var_114_22)

				if var_114_24 > 0 and var_114_18 < var_114_24 then
					arg_111_1.talkMaxDuration = var_114_24

					if var_114_24 + var_114_17 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_24 + var_114_17
					end
				end

				arg_111_1.text_.text = var_114_21
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582027", "story_v_out_325582.awb") ~= 0 then
					local var_114_25 = manager.audio:GetVoiceLength("story_v_out_325582", "325582027", "story_v_out_325582.awb") / 1000

					if var_114_25 + var_114_17 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_25 + var_114_17
					end

					if var_114_20.prefab_name ~= "" and arg_111_1.actors_[var_114_20.prefab_name] ~= nil then
						local var_114_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_20.prefab_name].transform, "story_v_out_325582", "325582027", "story_v_out_325582.awb")

						arg_111_1:RecordAudio("325582027", var_114_26)
						arg_111_1:RecordAudio("325582027", var_114_26)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_325582", "325582027", "story_v_out_325582.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_325582", "325582027", "story_v_out_325582.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_27 = math.max(var_114_18, arg_111_1.talkMaxDuration)

			if var_114_17 <= arg_111_1.time_ and arg_111_1.time_ < var_114_17 + var_114_27 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_17) / var_114_27

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_17 + var_114_27 and arg_111_1.time_ < var_114_17 + var_114_27 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
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
	Play325582028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 325582028
		arg_115_1.duration_ = 7.13

		local var_115_0 = {
			zh = 3.9,
			ja = 7.133
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
				arg_115_0:Play325582029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action38_1")
			end

			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_118_2 = 0
			local var_118_3 = 0.4

			if var_118_2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_4 = arg_115_1:FormatText(StoryNameCfg[1473].name)

				arg_115_1.leftNameTxt_.text = var_118_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_5 = arg_115_1:GetWordFromCfg(325582028)
				local var_118_6 = arg_115_1:FormatText(var_118_5.content)

				arg_115_1.text_.text = var_118_6

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 16
				local var_118_8 = utf8.len(var_118_6)
				local var_118_9 = var_118_7 <= 0 and var_118_3 or var_118_3 * (var_118_8 / var_118_7)

				if var_118_9 > 0 and var_118_3 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_6
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582028", "story_v_out_325582.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_out_325582", "325582028", "story_v_out_325582.awb") / 1000

					if var_118_10 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_2
					end

					if var_118_5.prefab_name ~= "" and arg_115_1.actors_[var_118_5.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_5.prefab_name].transform, "story_v_out_325582", "325582028", "story_v_out_325582.awb")

						arg_115_1:RecordAudio("325582028", var_118_11)
						arg_115_1:RecordAudio("325582028", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_325582", "325582028", "story_v_out_325582.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_325582", "325582028", "story_v_out_325582.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_3, arg_115_1.talkMaxDuration)

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_2) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_2 + var_118_12 and arg_115_1.time_ < var_118_2 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play325582029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 325582029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play325582030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10175ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10175ui_story = var_122_0.localPosition

				local var_122_2 = GameObjectTools.GetOrAddComponent(var_122_0.gameObject, typeof(DynamicBoneHelper))

				if var_122_2 then
					var_122_2:EnableDynamicBone(false)
				end
			end

			local var_122_3 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_3 then
				local var_122_4 = (arg_119_1.time_ - var_122_1) / var_122_3
				local var_122_5 = Vector3.New(0, 100, 0)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10175ui_story, var_122_5, var_122_4)

				local var_122_6 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_6.x, var_122_6.y, var_122_6.z)

				local var_122_7 = var_122_0.localEulerAngles

				var_122_7.z = 0
				var_122_7.x = 0
				var_122_0.localEulerAngles = var_122_7
			end

			if arg_119_1.time_ >= var_122_1 + var_122_3 and arg_119_1.time_ < var_122_1 + var_122_3 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_122_11 = arg_119_1.actors_["10175ui_story"]
			local var_122_12 = 0

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 and not isNil(var_122_11) and arg_119_1.var_.characterEffect10175ui_story == nil then
				arg_119_1.var_.characterEffect10175ui_story = var_122_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_13 = 0.200000002980232

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_13 and not isNil(var_122_11) then
				local var_122_14 = (arg_119_1.time_ - var_122_12) / var_122_13

				if arg_119_1.var_.characterEffect10175ui_story and not isNil(var_122_11) then
					local var_122_15 = Mathf.Lerp(0, 0.5, var_122_14)

					arg_119_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10175ui_story.fillRatio = var_122_15
				end
			end

			if arg_119_1.time_ >= var_122_12 + var_122_13 and arg_119_1.time_ < var_122_12 + var_122_13 + arg_122_0 and not isNil(var_122_11) and arg_119_1.var_.characterEffect10175ui_story then
				local var_122_16 = 0.5

				arg_119_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10175ui_story.fillRatio = var_122_16
			end

			local var_122_17 = 0
			local var_122_18 = 1.2

			if var_122_17 < arg_119_1.time_ and arg_119_1.time_ <= var_122_17 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_19 = arg_119_1:GetWordFromCfg(325582029)
				local var_122_20 = arg_119_1:FormatText(var_122_19.content)

				arg_119_1.text_.text = var_122_20

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_21 = 48
				local var_122_22 = utf8.len(var_122_20)
				local var_122_23 = var_122_21 <= 0 and var_122_18 or var_122_18 * (var_122_22 / var_122_21)

				if var_122_23 > 0 and var_122_18 < var_122_23 then
					arg_119_1.talkMaxDuration = var_122_23

					if var_122_23 + var_122_17 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_17
					end
				end

				arg_119_1.text_.text = var_122_20
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_24 = math.max(var_122_18, arg_119_1.talkMaxDuration)

			if var_122_17 <= arg_119_1.time_ and arg_119_1.time_ < var_122_17 + var_122_24 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_17) / var_122_24

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_17 + var_122_24 and arg_119_1.time_ < var_122_17 + var_122_24 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
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
	Play325582030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 325582030
		arg_123_1.duration_ = 6.07

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play325582031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = manager.ui.mainCamera.transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				local var_126_2 = arg_123_1.var_.effectdaoguang12342
				local var_126_3
				local var_126_4 = var_126_0

				if not var_126_2 then
					var_126_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), var_126_4)
					var_126_2.name = "daoguang12342"
					arg_123_1.var_.effectdaoguang12342 = var_126_2
				else
					var_126_2.transform:SetParent(var_126_4)
				end

				var_126_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_126_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_126_5 = manager.ui.mainCamera.transform
			local var_126_6 = 2

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				local var_126_7 = arg_123_1.var_.effectdaoguang12342

				if var_126_7 then
					Object.Destroy(var_126_7)

					arg_123_1.var_.effectdaoguang12342 = nil
				end
			end

			local var_126_8 = 0

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.allBtn_.enabled = false
			end

			local var_126_9 = 2.15833333333333

			if arg_123_1.time_ >= var_126_8 + var_126_9 and arg_123_1.time_ < var_126_8 + var_126_9 + arg_126_0 then
				arg_123_1.allBtn_.enabled = true
			end

			local var_126_10 = manager.ui.mainCamera.transform
			local var_126_11 = 0

			if var_126_11 < arg_123_1.time_ and arg_123_1.time_ <= var_126_11 + arg_126_0 then
				arg_123_1.var_.shakeOldPos = var_126_10.localPosition
			end

			local var_126_12 = 0.833333333333333

			if var_126_11 <= arg_123_1.time_ and arg_123_1.time_ < var_126_11 + var_126_12 then
				local var_126_13 = (arg_123_1.time_ - var_126_11) / 0.066
				local var_126_14, var_126_15 = math.modf(var_126_13)

				var_126_10.localPosition = Vector3.New(var_126_15 * 0.13, var_126_15 * 0.13, var_126_15 * 0.13) + arg_123_1.var_.shakeOldPos
			end

			if arg_123_1.time_ >= var_126_11 + var_126_12 and arg_123_1.time_ < var_126_11 + var_126_12 + arg_126_0 then
				var_126_10.localPosition = arg_123_1.var_.shakeOldPos
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_16 = 1.06666666666667
			local var_126_17 = 1.625

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_18 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_18:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_19 = arg_123_1:GetWordFromCfg(325582030)
				local var_126_20 = arg_123_1:FormatText(var_126_19.content)

				arg_123_1.text_.text = var_126_20

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_21 = 65
				local var_126_22 = utf8.len(var_126_20)
				local var_126_23 = var_126_21 <= 0 and var_126_17 or var_126_17 * (var_126_22 / var_126_21)

				if var_126_23 > 0 and var_126_17 < var_126_23 then
					arg_123_1.talkMaxDuration = var_126_23
					var_126_16 = var_126_16 + 0.3

					if var_126_23 + var_126_16 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_16
					end
				end

				arg_123_1.text_.text = var_126_20
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_24 = var_126_16 + 0.3
			local var_126_25 = math.max(var_126_17, arg_123_1.talkMaxDuration)

			if var_126_24 <= arg_123_1.time_ and arg_123_1.time_ < var_126_24 + var_126_25 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_24) / var_126_25

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_24 + var_126_25 and arg_123_1.time_ < var_126_24 + var_126_25 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play325582031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 325582031
		arg_129_1.duration_ = 4.63

		local var_129_0 = {
			zh = 3.666,
			ja = 4.633
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play325582032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10175ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10175ui_story = var_132_0.localPosition

				local var_132_2 = GameObjectTools.GetOrAddComponent(var_132_0.gameObject, typeof(DynamicBoneHelper))

				if var_132_2 then
					var_132_2:EnableDynamicBone(false)
				end
			end

			local var_132_3 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_3 then
				local var_132_4 = (arg_129_1.time_ - var_132_1) / var_132_3
				local var_132_5 = Vector3.New(0, -1, -6.05)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10175ui_story, var_132_5, var_132_4)

				local var_132_6 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_6.x, var_132_6.y, var_132_6.z)

				local var_132_7 = var_132_0.localEulerAngles

				var_132_7.z = 0
				var_132_7.x = 0
				var_132_0.localEulerAngles = var_132_7
			end

			if arg_129_1.time_ >= var_132_1 + var_132_3 and arg_129_1.time_ < var_132_1 + var_132_3 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_132_8 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_8.x, var_132_8.y, var_132_8.z)

				local var_132_9 = var_132_0.localEulerAngles

				var_132_9.z = 0
				var_132_9.x = 0
				var_132_0.localEulerAngles = var_132_9

				local var_132_10 = GameObjectTools.GetOrAddComponent(var_132_0.gameObject, typeof(DynamicBoneHelper))

				if var_132_10 then
					var_132_10:EnableDynamicBone(true)
				end
			end

			local var_132_11 = arg_129_1.actors_["10175ui_story"]
			local var_132_12 = 0

			if var_132_12 < arg_129_1.time_ and arg_129_1.time_ <= var_132_12 + arg_132_0 and not isNil(var_132_11) and arg_129_1.var_.characterEffect10175ui_story == nil then
				arg_129_1.var_.characterEffect10175ui_story = var_132_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_13 = 0.200000002980232

			if var_132_12 <= arg_129_1.time_ and arg_129_1.time_ < var_132_12 + var_132_13 and not isNil(var_132_11) then
				local var_132_14 = (arg_129_1.time_ - var_132_12) / var_132_13

				if arg_129_1.var_.characterEffect10175ui_story and not isNil(var_132_11) then
					arg_129_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_12 + var_132_13 and arg_129_1.time_ < var_132_12 + var_132_13 + arg_132_0 and not isNil(var_132_11) and arg_129_1.var_.characterEffect10175ui_story then
				arg_129_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_132_15 = 0

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_132_16 = 0

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 then
				arg_129_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_132_17 = 0
			local var_132_18 = 0.375

			if var_132_17 < arg_129_1.time_ and arg_129_1.time_ <= var_132_17 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_19 = arg_129_1:FormatText(StoryNameCfg[1473].name)

				arg_129_1.leftNameTxt_.text = var_132_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_20 = arg_129_1:GetWordFromCfg(325582031)
				local var_132_21 = arg_129_1:FormatText(var_132_20.content)

				arg_129_1.text_.text = var_132_21

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_22 = 15
				local var_132_23 = utf8.len(var_132_21)
				local var_132_24 = var_132_22 <= 0 and var_132_18 or var_132_18 * (var_132_23 / var_132_22)

				if var_132_24 > 0 and var_132_18 < var_132_24 then
					arg_129_1.talkMaxDuration = var_132_24

					if var_132_24 + var_132_17 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_24 + var_132_17
					end
				end

				arg_129_1.text_.text = var_132_21
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582031", "story_v_out_325582.awb") ~= 0 then
					local var_132_25 = manager.audio:GetVoiceLength("story_v_out_325582", "325582031", "story_v_out_325582.awb") / 1000

					if var_132_25 + var_132_17 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_25 + var_132_17
					end

					if var_132_20.prefab_name ~= "" and arg_129_1.actors_[var_132_20.prefab_name] ~= nil then
						local var_132_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_20.prefab_name].transform, "story_v_out_325582", "325582031", "story_v_out_325582.awb")

						arg_129_1:RecordAudio("325582031", var_132_26)
						arg_129_1:RecordAudio("325582031", var_132_26)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_325582", "325582031", "story_v_out_325582.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_325582", "325582031", "story_v_out_325582.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_27 = math.max(var_132_18, arg_129_1.talkMaxDuration)

			if var_132_17 <= arg_129_1.time_ and arg_129_1.time_ < var_132_17 + var_132_27 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_17) / var_132_27

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_17 + var_132_27 and arg_129_1.time_ < var_132_17 + var_132_27 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play325582032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 325582032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play325582033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10175ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos10175ui_story = var_136_0.localPosition

				local var_136_2 = GameObjectTools.GetOrAddComponent(var_136_0.gameObject, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(false)
				end
			end

			local var_136_3 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_3 then
				local var_136_4 = (arg_133_1.time_ - var_136_1) / var_136_3
				local var_136_5 = Vector3.New(0, 100, 0)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10175ui_story, var_136_5, var_136_4)

				local var_136_6 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_6.x, var_136_6.y, var_136_6.z)

				local var_136_7 = var_136_0.localEulerAngles

				var_136_7.z = 0
				var_136_7.x = 0
				var_136_0.localEulerAngles = var_136_7
			end

			if arg_133_1.time_ >= var_136_1 + var_136_3 and arg_133_1.time_ < var_136_1 + var_136_3 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, 100, 0)

				local var_136_8 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_8.x, var_136_8.y, var_136_8.z)

				local var_136_9 = var_136_0.localEulerAngles

				var_136_9.z = 0
				var_136_9.x = 0
				var_136_0.localEulerAngles = var_136_9

				local var_136_10 = GameObjectTools.GetOrAddComponent(var_136_0.gameObject, typeof(DynamicBoneHelper))

				if var_136_10 then
					var_136_10:EnableDynamicBone(true)
				end
			end

			local var_136_11 = arg_133_1.actors_["10175ui_story"]
			local var_136_12 = 0

			if var_136_12 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 and not isNil(var_136_11) and arg_133_1.var_.characterEffect10175ui_story == nil then
				arg_133_1.var_.characterEffect10175ui_story = var_136_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_13 = 0.200000002980232

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_13 and not isNil(var_136_11) then
				local var_136_14 = (arg_133_1.time_ - var_136_12) / var_136_13

				if arg_133_1.var_.characterEffect10175ui_story and not isNil(var_136_11) then
					local var_136_15 = Mathf.Lerp(0, 0.5, var_136_14)

					arg_133_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10175ui_story.fillRatio = var_136_15
				end
			end

			if arg_133_1.time_ >= var_136_12 + var_136_13 and arg_133_1.time_ < var_136_12 + var_136_13 + arg_136_0 and not isNil(var_136_11) and arg_133_1.var_.characterEffect10175ui_story then
				local var_136_16 = 0.5

				arg_133_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10175ui_story.fillRatio = var_136_16
			end

			local var_136_17 = 0
			local var_136_18 = 1.55

			if var_136_17 < arg_133_1.time_ and arg_133_1.time_ <= var_136_17 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_19 = arg_133_1:GetWordFromCfg(325582032)
				local var_136_20 = arg_133_1:FormatText(var_136_19.content)

				arg_133_1.text_.text = var_136_20

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_21 = 62
				local var_136_22 = utf8.len(var_136_20)
				local var_136_23 = var_136_21 <= 0 and var_136_18 or var_136_18 * (var_136_22 / var_136_21)

				if var_136_23 > 0 and var_136_18 < var_136_23 then
					arg_133_1.talkMaxDuration = var_136_23

					if var_136_23 + var_136_17 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_17
					end
				end

				arg_133_1.text_.text = var_136_20
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_24 = math.max(var_136_18, arg_133_1.talkMaxDuration)

			if var_136_17 <= arg_133_1.time_ and arg_133_1.time_ < var_136_17 + var_136_24 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_17) / var_136_24

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_17 + var_136_24 and arg_133_1.time_ < var_136_17 + var_136_24 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play325582033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 325582033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play325582034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.1
			local var_140_1 = 1

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				local var_140_2 = "play"
				local var_140_3 = "effect"

				arg_137_1:AudioAction(var_140_2, var_140_3, "se_story_121_04", "se_story_121_04_magic", "")
			end

			local var_140_4 = 0
			local var_140_5 = 1.075

			if var_140_4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(325582033)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_8 = 43
				local var_140_9 = utf8.len(var_140_7)
				local var_140_10 = var_140_8 <= 0 and var_140_5 or var_140_5 * (var_140_9 / var_140_8)

				if var_140_10 > 0 and var_140_5 < var_140_10 then
					arg_137_1.talkMaxDuration = var_140_10

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_11 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_11 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_11

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_11 and arg_137_1.time_ < var_140_4 + var_140_11 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play325582034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 325582034
		arg_141_1.duration_ = 5.37

		local var_141_0 = {
			zh = 5.366,
			ja = 4.8
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
				arg_141_0:Play325582035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10175ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos10175ui_story = var_144_0.localPosition

				local var_144_2 = GameObjectTools.GetOrAddComponent(var_144_0.gameObject, typeof(DynamicBoneHelper))

				if var_144_2 then
					var_144_2:EnableDynamicBone(false)
				end
			end

			local var_144_3 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_3 then
				local var_144_4 = (arg_141_1.time_ - var_144_1) / var_144_3
				local var_144_5 = Vector3.New(0, -1, -6.05)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10175ui_story, var_144_5, var_144_4)

				local var_144_6 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_6.x, var_144_6.y, var_144_6.z)

				local var_144_7 = var_144_0.localEulerAngles

				var_144_7.z = 0
				var_144_7.x = 0
				var_144_0.localEulerAngles = var_144_7
			end

			if arg_141_1.time_ >= var_144_1 + var_144_3 and arg_141_1.time_ < var_144_1 + var_144_3 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_144_8 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_8.x, var_144_8.y, var_144_8.z)

				local var_144_9 = var_144_0.localEulerAngles

				var_144_9.z = 0
				var_144_9.x = 0
				var_144_0.localEulerAngles = var_144_9

				local var_144_10 = GameObjectTools.GetOrAddComponent(var_144_0.gameObject, typeof(DynamicBoneHelper))

				if var_144_10 then
					var_144_10:EnableDynamicBone(true)
				end
			end

			local var_144_11 = arg_141_1.actors_["10175ui_story"]
			local var_144_12 = 0

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.characterEffect10175ui_story == nil then
				arg_141_1.var_.characterEffect10175ui_story = var_144_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_13 = 0.200000002980232

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_13 and not isNil(var_144_11) then
				local var_144_14 = (arg_141_1.time_ - var_144_12) / var_144_13

				if arg_141_1.var_.characterEffect10175ui_story and not isNil(var_144_11) then
					arg_141_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_12 + var_144_13 and arg_141_1.time_ < var_144_12 + var_144_13 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.characterEffect10175ui_story then
				arg_141_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_144_15 = 0
			local var_144_16 = 0.525

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[1473].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_18 = arg_141_1:GetWordFromCfg(325582034)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 21
				local var_144_21 = utf8.len(var_144_19)
				local var_144_22 = var_144_20 <= 0 and var_144_16 or var_144_16 * (var_144_21 / var_144_20)

				if var_144_22 > 0 and var_144_16 < var_144_22 then
					arg_141_1.talkMaxDuration = var_144_22

					if var_144_22 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_22 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_19
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582034", "story_v_out_325582.awb") ~= 0 then
					local var_144_23 = manager.audio:GetVoiceLength("story_v_out_325582", "325582034", "story_v_out_325582.awb") / 1000

					if var_144_23 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_15
					end

					if var_144_18.prefab_name ~= "" and arg_141_1.actors_[var_144_18.prefab_name] ~= nil then
						local var_144_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_18.prefab_name].transform, "story_v_out_325582", "325582034", "story_v_out_325582.awb")

						arg_141_1:RecordAudio("325582034", var_144_24)
						arg_141_1:RecordAudio("325582034", var_144_24)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_325582", "325582034", "story_v_out_325582.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_325582", "325582034", "story_v_out_325582.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_25 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_25

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_25 and arg_141_1.time_ < var_144_15 + var_144_25 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play325582035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 325582035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play325582036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10175ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos10175ui_story = var_148_0.localPosition

				local var_148_2 = GameObjectTools.GetOrAddComponent(var_148_0.gameObject, typeof(DynamicBoneHelper))

				if var_148_2 then
					var_148_2:EnableDynamicBone(false)
				end
			end

			local var_148_3 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_3 then
				local var_148_4 = (arg_145_1.time_ - var_148_1) / var_148_3
				local var_148_5 = Vector3.New(0, 100, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10175ui_story, var_148_5, var_148_4)

				local var_148_6 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_6.x, var_148_6.y, var_148_6.z)

				local var_148_7 = var_148_0.localEulerAngles

				var_148_7.z = 0
				var_148_7.x = 0
				var_148_0.localEulerAngles = var_148_7
			end

			if arg_145_1.time_ >= var_148_1 + var_148_3 and arg_145_1.time_ < var_148_1 + var_148_3 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, 100, 0)

				local var_148_8 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_8.x, var_148_8.y, var_148_8.z)

				local var_148_9 = var_148_0.localEulerAngles

				var_148_9.z = 0
				var_148_9.x = 0
				var_148_0.localEulerAngles = var_148_9

				local var_148_10 = GameObjectTools.GetOrAddComponent(var_148_0.gameObject, typeof(DynamicBoneHelper))

				if var_148_10 then
					var_148_10:EnableDynamicBone(true)
				end
			end

			local var_148_11 = arg_145_1.actors_["10175ui_story"]
			local var_148_12 = 0

			if var_148_12 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 and not isNil(var_148_11) and arg_145_1.var_.characterEffect10175ui_story == nil then
				arg_145_1.var_.characterEffect10175ui_story = var_148_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_13 = 0.200000002980232

			if var_148_12 <= arg_145_1.time_ and arg_145_1.time_ < var_148_12 + var_148_13 and not isNil(var_148_11) then
				local var_148_14 = (arg_145_1.time_ - var_148_12) / var_148_13

				if arg_145_1.var_.characterEffect10175ui_story and not isNil(var_148_11) then
					local var_148_15 = Mathf.Lerp(0, 0.5, var_148_14)

					arg_145_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10175ui_story.fillRatio = var_148_15
				end
			end

			if arg_145_1.time_ >= var_148_12 + var_148_13 and arg_145_1.time_ < var_148_12 + var_148_13 + arg_148_0 and not isNil(var_148_11) and arg_145_1.var_.characterEffect10175ui_story then
				local var_148_16 = 0.5

				arg_145_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10175ui_story.fillRatio = var_148_16
			end

			local var_148_17 = 0
			local var_148_18 = 1

			if var_148_17 < arg_145_1.time_ and arg_145_1.time_ <= var_148_17 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_19 = arg_145_1:GetWordFromCfg(325582035)
				local var_148_20 = arg_145_1:FormatText(var_148_19.content)

				arg_145_1.text_.text = var_148_20

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_21 = 40
				local var_148_22 = utf8.len(var_148_20)
				local var_148_23 = var_148_21 <= 0 and var_148_18 or var_148_18 * (var_148_22 / var_148_21)

				if var_148_23 > 0 and var_148_18 < var_148_23 then
					arg_145_1.talkMaxDuration = var_148_23

					if var_148_23 + var_148_17 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_17
					end
				end

				arg_145_1.text_.text = var_148_20
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_24 = math.max(var_148_18, arg_145_1.talkMaxDuration)

			if var_148_17 <= arg_145_1.time_ and arg_145_1.time_ < var_148_17 + var_148_24 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_17) / var_148_24

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_17 + var_148_24 and arg_145_1.time_ < var_148_17 + var_148_24 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play325582036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 325582036
		arg_149_1.duration_ = 6.53

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play325582037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = manager.ui.mainCamera.transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				local var_152_2 = arg_149_1.var_.effectheibaishan213213
				local var_152_3
				local var_152_4 = var_152_0

				if not var_152_2 then
					var_152_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_152_4)
					var_152_2.name = "heibaishan213213"
					arg_149_1.var_.effectheibaishan213213 = var_152_2
				else
					var_152_2.transform:SetParent(var_152_4)
				end

				var_152_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_152_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_152_5 = 0

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			local var_152_6 = 1.999999999999

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end

			local var_152_7 = 0.1
			local var_152_8 = 1

			if var_152_7 < arg_149_1.time_ and arg_149_1.time_ <= var_152_7 + arg_152_0 then
				local var_152_9 = "play"
				local var_152_10 = "effect"

				arg_149_1:AudioAction(var_152_9, var_152_10, "se_story_150", "se_story_150_sword07", "")
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_11 = 1.53333333333333
			local var_152_12 = 1.85

			if var_152_11 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_13 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_13:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_149_1.dialogCg_.alpha = arg_153_0
				end))
				var_152_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_14 = arg_149_1:GetWordFromCfg(325582036)
				local var_152_15 = arg_149_1:FormatText(var_152_14.content)

				arg_149_1.text_.text = var_152_15

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_16 = 74
				local var_152_17 = utf8.len(var_152_15)
				local var_152_18 = var_152_16 <= 0 and var_152_12 or var_152_12 * (var_152_17 / var_152_16)

				if var_152_18 > 0 and var_152_12 < var_152_18 then
					arg_149_1.talkMaxDuration = var_152_18
					var_152_11 = var_152_11 + 0.3

					if var_152_18 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_18 + var_152_11
					end
				end

				arg_149_1.text_.text = var_152_15
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_19 = var_152_11 + 0.3
			local var_152_20 = math.max(var_152_12, arg_149_1.talkMaxDuration)

			if var_152_19 <= arg_149_1.time_ and arg_149_1.time_ < var_152_19 + var_152_20 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_19) / var_152_20

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_19 + var_152_20 and arg_149_1.time_ < var_152_19 + var_152_20 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play325582037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 325582037
		arg_155_1.duration_ = 3.3

		local var_155_0 = {
			zh = 2.766,
			ja = 3.3
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
				arg_155_0:Play325582038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10175ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10175ui_story = var_158_0.localPosition

				local var_158_2 = GameObjectTools.GetOrAddComponent(var_158_0.gameObject, typeof(DynamicBoneHelper))

				if var_158_2 then
					var_158_2:EnableDynamicBone(false)
				end
			end

			local var_158_3 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_3 then
				local var_158_4 = (arg_155_1.time_ - var_158_1) / var_158_3
				local var_158_5 = Vector3.New(0, -1, -6.05)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10175ui_story, var_158_5, var_158_4)

				local var_158_6 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_6.x, var_158_6.y, var_158_6.z)

				local var_158_7 = var_158_0.localEulerAngles

				var_158_7.z = 0
				var_158_7.x = 0
				var_158_0.localEulerAngles = var_158_7
			end

			if arg_155_1.time_ >= var_158_1 + var_158_3 and arg_155_1.time_ < var_158_1 + var_158_3 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -1, -6.05)

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

			local var_158_11 = arg_155_1.actors_["10175ui_story"]
			local var_158_12 = 0

			if var_158_12 < arg_155_1.time_ and arg_155_1.time_ <= var_158_12 + arg_158_0 and not isNil(var_158_11) and arg_155_1.var_.characterEffect10175ui_story == nil then
				arg_155_1.var_.characterEffect10175ui_story = var_158_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_13 = 0.200000002980232

			if var_158_12 <= arg_155_1.time_ and arg_155_1.time_ < var_158_12 + var_158_13 and not isNil(var_158_11) then
				local var_158_14 = (arg_155_1.time_ - var_158_12) / var_158_13

				if arg_155_1.var_.characterEffect10175ui_story and not isNil(var_158_11) then
					arg_155_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_12 + var_158_13 and arg_155_1.time_ < var_158_12 + var_158_13 + arg_158_0 and not isNil(var_158_11) and arg_155_1.var_.characterEffect10175ui_story then
				arg_155_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_158_15 = 0

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_158_16 = 0

			if var_158_16 < arg_155_1.time_ and arg_155_1.time_ <= var_158_16 + arg_158_0 then
				arg_155_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaB", "EmotionTimelineAnimator")
			end

			local var_158_17 = 0
			local var_158_18 = 0.225

			if var_158_17 < arg_155_1.time_ and arg_155_1.time_ <= var_158_17 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_19 = arg_155_1:FormatText(StoryNameCfg[1473].name)

				arg_155_1.leftNameTxt_.text = var_158_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_20 = arg_155_1:GetWordFromCfg(325582037)
				local var_158_21 = arg_155_1:FormatText(var_158_20.content)

				arg_155_1.text_.text = var_158_21

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_22 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582037", "story_v_out_325582.awb") ~= 0 then
					local var_158_25 = manager.audio:GetVoiceLength("story_v_out_325582", "325582037", "story_v_out_325582.awb") / 1000

					if var_158_25 + var_158_17 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_25 + var_158_17
					end

					if var_158_20.prefab_name ~= "" and arg_155_1.actors_[var_158_20.prefab_name] ~= nil then
						local var_158_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_20.prefab_name].transform, "story_v_out_325582", "325582037", "story_v_out_325582.awb")

						arg_155_1:RecordAudio("325582037", var_158_26)
						arg_155_1:RecordAudio("325582037", var_158_26)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_325582", "325582037", "story_v_out_325582.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_325582", "325582037", "story_v_out_325582.awb")
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
				actorName = "10175ui_story",
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
	Play325582038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 325582038
		arg_159_1.duration_ = 6

		local var_159_0 = {
			zh = 5.2,
			ja = 6
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
			arg_159_1.auto_ = false
		end

		function arg_159_1.playNext_(arg_161_0)
			arg_159_1.onStoryFinished_()
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10175ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos10175ui_story = var_162_0.localPosition

				local var_162_2 = GameObjectTools.GetOrAddComponent(var_162_0.gameObject, typeof(DynamicBoneHelper))

				if var_162_2 then
					var_162_2:EnableDynamicBone(false)
				end
			end

			local var_162_3 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_3 then
				local var_162_4 = (arg_159_1.time_ - var_162_1) / var_162_3
				local var_162_5 = Vector3.New(0, 100, 0)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10175ui_story, var_162_5, var_162_4)

				local var_162_6 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_6.x, var_162_6.y, var_162_6.z)

				local var_162_7 = var_162_0.localEulerAngles

				var_162_7.z = 0
				var_162_7.x = 0
				var_162_0.localEulerAngles = var_162_7
			end

			if arg_159_1.time_ >= var_162_1 + var_162_3 and arg_159_1.time_ < var_162_1 + var_162_3 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, 100, 0)

				local var_162_8 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_8.x, var_162_8.y, var_162_8.z)

				local var_162_9 = var_162_0.localEulerAngles

				var_162_9.z = 0
				var_162_9.x = 0
				var_162_0.localEulerAngles = var_162_9

				local var_162_10 = GameObjectTools.GetOrAddComponent(var_162_0.gameObject, typeof(DynamicBoneHelper))

				if var_162_10 then
					var_162_10:EnableDynamicBone(true)
				end
			end

			local var_162_11 = "1054ui_story"

			if arg_159_1.actors_[var_162_11] == nil then
				local var_162_12 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_162_12) then
					local var_162_13 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_159_1.stage_.transform)

					var_162_13.name = var_162_11
					var_162_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_159_1.actors_[var_162_11] = var_162_13

					local var_162_14 = var_162_13:GetComponentInChildren(typeof(CharacterEffect))

					var_162_14.enabled = true

					local var_162_15 = GameObjectTools.GetOrAddComponent(var_162_13, typeof(DynamicBoneHelper))

					if var_162_15 then
						var_162_15:EnableDynamicBone(false)
					end

					arg_159_1:ShowWeapon(var_162_14.transform, false)

					arg_159_1.var_[var_162_11 .. "Animator"] = var_162_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_159_1.var_[var_162_11 .. "Animator"].applyRootMotion = true
					arg_159_1.var_[var_162_11 .. "LipSync"] = var_162_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_162_16 = arg_159_1.actors_["1054ui_story"].transform
			local var_162_17 = 0

			if var_162_17 < arg_159_1.time_ and arg_159_1.time_ <= var_162_17 + arg_162_0 then
				arg_159_1.var_.moveOldPos1054ui_story = var_162_16.localPosition

				local var_162_18 = GameObjectTools.GetOrAddComponent(var_162_16.gameObject, typeof(DynamicBoneHelper))

				if var_162_18 then
					var_162_18:EnableDynamicBone(false)
				end
			end

			local var_162_19 = 0.001

			if var_162_17 <= arg_159_1.time_ and arg_159_1.time_ < var_162_17 + var_162_19 then
				local var_162_20 = (arg_159_1.time_ - var_162_17) / var_162_19
				local var_162_21 = Vector3.New(-0.7, -0.985, -6)

				var_162_16.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1054ui_story, var_162_21, var_162_20)

				local var_162_22 = manager.ui.mainCamera.transform.position - var_162_16.position

				var_162_16.forward = Vector3.New(var_162_22.x, var_162_22.y, var_162_22.z)

				local var_162_23 = var_162_16.localEulerAngles

				var_162_23.z = 0
				var_162_23.x = 0
				var_162_16.localEulerAngles = var_162_23
			end

			if arg_159_1.time_ >= var_162_17 + var_162_19 and arg_159_1.time_ < var_162_17 + var_162_19 + arg_162_0 then
				var_162_16.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_162_24 = manager.ui.mainCamera.transform.position - var_162_16.position

				var_162_16.forward = Vector3.New(var_162_24.x, var_162_24.y, var_162_24.z)

				local var_162_25 = var_162_16.localEulerAngles

				var_162_25.z = 0
				var_162_25.x = 0
				var_162_16.localEulerAngles = var_162_25

				local var_162_26 = GameObjectTools.GetOrAddComponent(var_162_16.gameObject, typeof(DynamicBoneHelper))

				if var_162_26 then
					var_162_26:EnableDynamicBone(true)
				end
			end

			local var_162_27 = "6148ui_story"

			if arg_159_1.actors_[var_162_27] == nil then
				local var_162_28 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_162_28) then
					local var_162_29 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_159_1.stage_.transform)

					var_162_29.name = var_162_27
					var_162_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_159_1.actors_[var_162_27] = var_162_29

					local var_162_30 = var_162_29:GetComponentInChildren(typeof(CharacterEffect))

					var_162_30.enabled = true

					local var_162_31 = GameObjectTools.GetOrAddComponent(var_162_29, typeof(DynamicBoneHelper))

					if var_162_31 then
						var_162_31:EnableDynamicBone(false)
					end

					arg_159_1:ShowWeapon(var_162_30.transform, false)

					arg_159_1.var_[var_162_27 .. "Animator"] = var_162_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_159_1.var_[var_162_27 .. "Animator"].applyRootMotion = true
					arg_159_1.var_[var_162_27 .. "LipSync"] = var_162_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_162_32 = arg_159_1.actors_["6148ui_story"].transform
			local var_162_33 = 0

			if var_162_33 < arg_159_1.time_ and arg_159_1.time_ <= var_162_33 + arg_162_0 then
				arg_159_1.var_.moveOldPos6148ui_story = var_162_32.localPosition

				local var_162_34 = GameObjectTools.GetOrAddComponent(var_162_32.gameObject, typeof(DynamicBoneHelper))

				if var_162_34 then
					var_162_34:EnableDynamicBone(false)
				end
			end

			local var_162_35 = 0.001

			if var_162_33 <= arg_159_1.time_ and arg_159_1.time_ < var_162_33 + var_162_35 then
				local var_162_36 = (arg_159_1.time_ - var_162_33) / var_162_35
				local var_162_37 = Vector3.New(0.7, -0.985, -6)

				var_162_32.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos6148ui_story, var_162_37, var_162_36)

				local var_162_38 = manager.ui.mainCamera.transform.position - var_162_32.position

				var_162_32.forward = Vector3.New(var_162_38.x, var_162_38.y, var_162_38.z)

				local var_162_39 = var_162_32.localEulerAngles

				var_162_39.z = 0
				var_162_39.x = 0
				var_162_32.localEulerAngles = var_162_39
			end

			if arg_159_1.time_ >= var_162_33 + var_162_35 and arg_159_1.time_ < var_162_33 + var_162_35 + arg_162_0 then
				var_162_32.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_162_40 = manager.ui.mainCamera.transform.position - var_162_32.position

				var_162_32.forward = Vector3.New(var_162_40.x, var_162_40.y, var_162_40.z)

				local var_162_41 = var_162_32.localEulerAngles

				var_162_41.z = 0
				var_162_41.x = 0
				var_162_32.localEulerAngles = var_162_41

				local var_162_42 = GameObjectTools.GetOrAddComponent(var_162_32.gameObject, typeof(DynamicBoneHelper))

				if var_162_42 then
					var_162_42:EnableDynamicBone(true)
				end
			end

			local var_162_43 = arg_159_1.actors_["10175ui_story"]
			local var_162_44 = 0

			if var_162_44 < arg_159_1.time_ and arg_159_1.time_ <= var_162_44 + arg_162_0 and not isNil(var_162_43) and arg_159_1.var_.characterEffect10175ui_story == nil then
				arg_159_1.var_.characterEffect10175ui_story = var_162_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_45 = 0.200000002980232

			if var_162_44 <= arg_159_1.time_ and arg_159_1.time_ < var_162_44 + var_162_45 and not isNil(var_162_43) then
				local var_162_46 = (arg_159_1.time_ - var_162_44) / var_162_45

				if arg_159_1.var_.characterEffect10175ui_story and not isNil(var_162_43) then
					local var_162_47 = Mathf.Lerp(0, 0.5, var_162_46)

					arg_159_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10175ui_story.fillRatio = var_162_47
				end
			end

			if arg_159_1.time_ >= var_162_44 + var_162_45 and arg_159_1.time_ < var_162_44 + var_162_45 + arg_162_0 and not isNil(var_162_43) and arg_159_1.var_.characterEffect10175ui_story then
				local var_162_48 = 0.5

				arg_159_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10175ui_story.fillRatio = var_162_48
			end

			local var_162_49 = arg_159_1.actors_["1054ui_story"]
			local var_162_50 = 0

			if var_162_50 < arg_159_1.time_ and arg_159_1.time_ <= var_162_50 + arg_162_0 and not isNil(var_162_49) and arg_159_1.var_.characterEffect1054ui_story == nil then
				arg_159_1.var_.characterEffect1054ui_story = var_162_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_51 = 0.200000002980232

			if var_162_50 <= arg_159_1.time_ and arg_159_1.time_ < var_162_50 + var_162_51 and not isNil(var_162_49) then
				local var_162_52 = (arg_159_1.time_ - var_162_50) / var_162_51

				if arg_159_1.var_.characterEffect1054ui_story and not isNil(var_162_49) then
					arg_159_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_50 + var_162_51 and arg_159_1.time_ < var_162_50 + var_162_51 + arg_162_0 and not isNil(var_162_49) and arg_159_1.var_.characterEffect1054ui_story then
				arg_159_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_162_53 = 0

			if var_162_53 < arg_159_1.time_ and arg_159_1.time_ <= var_162_53 + arg_162_0 then
				arg_159_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_162_54 = 0

			if var_162_54 < arg_159_1.time_ and arg_159_1.time_ <= var_162_54 + arg_162_0 then
				arg_159_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_162_55 = arg_159_1.actors_["6148ui_story"]
			local var_162_56 = 0

			if var_162_56 < arg_159_1.time_ and arg_159_1.time_ <= var_162_56 + arg_162_0 and not isNil(var_162_55) and arg_159_1.var_.characterEffect6148ui_story == nil then
				arg_159_1.var_.characterEffect6148ui_story = var_162_55:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_57 = 0.200000002980232

			if var_162_56 <= arg_159_1.time_ and arg_159_1.time_ < var_162_56 + var_162_57 and not isNil(var_162_55) then
				local var_162_58 = (arg_159_1.time_ - var_162_56) / var_162_57

				if arg_159_1.var_.characterEffect6148ui_story and not isNil(var_162_55) then
					arg_159_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_56 + var_162_57 and arg_159_1.time_ < var_162_56 + var_162_57 + arg_162_0 and not isNil(var_162_55) and arg_159_1.var_.characterEffect6148ui_story then
				arg_159_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_162_59 = 0

			if var_162_59 < arg_159_1.time_ and arg_159_1.time_ <= var_162_59 + arg_162_0 then
				arg_159_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_162_60 = 0

			if var_162_60 < arg_159_1.time_ and arg_159_1.time_ <= var_162_60 + arg_162_0 then
				arg_159_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_162_61 = 0
			local var_162_62 = 1

			if var_162_61 < arg_159_1.time_ and arg_159_1.time_ <= var_162_61 + arg_162_0 then
				local var_162_63 = "play"
				local var_162_64 = "effect"

				arg_159_1:AudioAction(var_162_63, var_162_64, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_162_65 = 0
			local var_162_66 = 0.55

			if var_162_65 < arg_159_1.time_ and arg_159_1.time_ <= var_162_65 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_67 = arg_159_1:FormatText(StoryNameCfg[1489].name)

				arg_159_1.leftNameTxt_.text = var_162_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_68 = arg_159_1:GetWordFromCfg(325582038)
				local var_162_69 = arg_159_1:FormatText(var_162_68.content)

				arg_159_1.text_.text = var_162_69

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_70 = 22
				local var_162_71 = utf8.len(var_162_69)
				local var_162_72 = var_162_70 <= 0 and var_162_66 or var_162_66 * (var_162_71 / var_162_70)

				if var_162_72 > 0 and var_162_66 < var_162_72 then
					arg_159_1.talkMaxDuration = var_162_72

					if var_162_72 + var_162_65 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_72 + var_162_65
					end
				end

				arg_159_1.text_.text = var_162_69
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582038", "story_v_out_325582.awb") ~= 0 then
					local var_162_73 = manager.audio:GetVoiceLength("story_v_out_325582", "325582038", "story_v_out_325582.awb") / 1000

					if var_162_73 + var_162_65 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_73 + var_162_65
					end

					if var_162_68.prefab_name ~= "" and arg_159_1.actors_[var_162_68.prefab_name] ~= nil then
						local var_162_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_68.prefab_name].transform, "story_v_out_325582", "325582038", "story_v_out_325582.awb")

						arg_159_1:RecordAudio("325582038", var_162_74)
						arg_159_1:RecordAudio("325582038", var_162_74)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_325582", "325582038", "story_v_out_325582.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_325582", "325582038", "story_v_out_325582.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_75 = math.max(var_162_66, arg_159_1.talkMaxDuration)

			if var_162_65 <= arg_159_1.time_ and arg_159_1.time_ < var_162_65 + var_162_75 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_65) / var_162_75

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_65 + var_162_75 and arg_159_1.time_ < var_162_65 + var_162_75 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_159_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J26h"
	},
	voices = {
		"story_v_out_325582.awb"
	}
}
