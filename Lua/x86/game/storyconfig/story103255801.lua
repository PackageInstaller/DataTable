return {
	Play325581001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325581001
		arg_1_1.duration_ = 7.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325581002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J21h"

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
				local var_4_5 = arg_1_1.bgs_.J21h

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
					if iter_4_0 ~= "J21h" then
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

			local var_4_24 = "10162ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "10162ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "10162ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["10162ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos10162ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, -1.08, -5.83)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10162ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.08, -5.83)

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

			local var_4_40 = arg_1_1.actors_["10162ui_story"]
			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect10162ui_story == nil then
				arg_1_1.var_.characterEffect10162ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect10162ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect10162ui_story then
				arg_1_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_4_45 = 1.8

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
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
			local var_4_57 = 0.6

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

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[1532].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(325581001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581001", "story_v_out_325581.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_325581", "325581001", "story_v_out_325581.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_325581", "325581001", "story_v_out_325581.awb")

						arg_1_1:RecordAudio("325581001", var_4_66)
						arg_1_1:RecordAudio("325581001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325581", "325581001", "story_v_out_325581.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325581", "325581001", "story_v_out_325581.awb")
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
				actorName = "10162ui_story",
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
	Play325581002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325581002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325581003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["10162ui_story"].transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.moveOldPos10162ui_story = var_11_0.localPosition

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end
			end

			local var_11_3 = 0.001

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_3 then
				local var_11_4 = (arg_8_1.time_ - var_11_1) / var_11_3
				local var_11_5 = Vector3.New(0, 100, 0)

				var_11_0.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10162ui_story, var_11_5, var_11_4)

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

			local var_11_11 = arg_8_1.actors_["10162ui_story"]
			local var_11_12 = 0

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect10162ui_story == nil then
				arg_8_1.var_.characterEffect10162ui_story = var_11_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_13 = 0.200000002980232

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_13 and not isNil(var_11_11) then
				local var_11_14 = (arg_8_1.time_ - var_11_12) / var_11_13

				if arg_8_1.var_.characterEffect10162ui_story and not isNil(var_11_11) then
					local var_11_15 = Mathf.Lerp(0, 0.5, var_11_14)

					arg_8_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10162ui_story.fillRatio = var_11_15
				end
			end

			if arg_8_1.time_ >= var_11_12 + var_11_13 and arg_8_1.time_ < var_11_12 + var_11_13 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect10162ui_story then
				local var_11_16 = 0.5

				arg_8_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10162ui_story.fillRatio = var_11_16
			end

			local var_11_17 = 0
			local var_11_18 = 1.125

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

				local var_11_19 = arg_8_1:GetWordFromCfg(325581002)
				local var_11_20 = arg_8_1:FormatText(var_11_19.content)

				arg_8_1.text_.text = var_11_20

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_21 = 45
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
				actorName = "10162ui_story",
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
	Play325581003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325581003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325581004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.275

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

				local var_15_2 = arg_12_1:GetWordFromCfg(325581003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 51
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
	Play325581004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325581004
		arg_16_1.duration_ = 6.2

		local var_16_0 = {
			zh = 3.4,
			ja = 6.2
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
				arg_16_0:Play325581005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10162ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos10162ui_story = var_19_0.localPosition

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end
			end

			local var_19_3 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10162ui_story, var_19_5, var_19_4)

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

			local var_19_11 = arg_16_1.actors_["10162ui_story"]
			local var_19_12 = 0

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect10162ui_story == nil then
				arg_16_1.var_.characterEffect10162ui_story = var_19_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_13 = 0.200000002980232

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_13 and not isNil(var_19_11) then
				local var_19_14 = (arg_16_1.time_ - var_19_12) / var_19_13

				if arg_16_1.var_.characterEffect10162ui_story and not isNil(var_19_11) then
					arg_16_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_12 + var_19_13 and arg_16_1.time_ < var_19_12 + var_19_13 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect10162ui_story then
				arg_16_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_17 = 0
			local var_19_18 = 0.375

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_19 = arg_16_1:FormatText(StoryNameCfg[1533].name)

				arg_16_1.leftNameTxt_.text = var_19_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_20 = arg_16_1:GetWordFromCfg(325581004)
				local var_19_21 = arg_16_1:FormatText(var_19_20.content)

				arg_16_1.text_.text = var_19_21

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_22 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581004", "story_v_out_325581.awb") ~= 0 then
					local var_19_25 = manager.audio:GetVoiceLength("story_v_out_325581", "325581004", "story_v_out_325581.awb") / 1000

					if var_19_25 + var_19_17 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_25 + var_19_17
					end

					if var_19_20.prefab_name ~= "" and arg_16_1.actors_[var_19_20.prefab_name] ~= nil then
						local var_19_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_20.prefab_name].transform, "story_v_out_325581", "325581004", "story_v_out_325581.awb")

						arg_16_1:RecordAudio("325581004", var_19_26)
						arg_16_1:RecordAudio("325581004", var_19_26)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325581", "325581004", "story_v_out_325581.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325581", "325581004", "story_v_out_325581.awb")
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
				actorName = "10162ui_story",
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
	Play325581005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325581005
		arg_20_1.duration_ = 7.3

		local var_20_0 = {
			zh = 7.3,
			ja = 6.533
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
				arg_20_0:Play325581006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10162ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos10162ui_story = var_23_0.localPosition

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end
			end

			local var_23_3 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_3 then
				local var_23_4 = (arg_20_1.time_ - var_23_1) / var_23_3
				local var_23_5 = Vector3.New(0, -1.08, -5.83)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10162ui_story, var_23_5, var_23_4)

				local var_23_6 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_6.x, var_23_6.y, var_23_6.z)

				local var_23_7 = var_23_0.localEulerAngles

				var_23_7.z = 0
				var_23_7.x = 0
				var_23_0.localEulerAngles = var_23_7
			end

			if arg_20_1.time_ >= var_23_1 + var_23_3 and arg_20_1.time_ < var_23_1 + var_23_3 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, -1.08, -5.83)

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

			local var_23_11 = arg_20_1.actors_["10162ui_story"]
			local var_23_12 = 0

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect10162ui_story == nil then
				arg_20_1.var_.characterEffect10162ui_story = var_23_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_13 = 0.200000002980232

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_13 and not isNil(var_23_11) then
				local var_23_14 = (arg_20_1.time_ - var_23_12) / var_23_13

				if arg_20_1.var_.characterEffect10162ui_story and not isNil(var_23_11) then
					arg_20_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_12 + var_23_13 and arg_20_1.time_ < var_23_12 + var_23_13 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect10162ui_story then
				arg_20_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_23_15 = 0

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_1")
			end

			local var_23_16 = 0

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_23_17 = 0
			local var_23_18 = 0.55

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_19 = arg_20_1:FormatText(StoryNameCfg[1532].name)

				arg_20_1.leftNameTxt_.text = var_23_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_20 = arg_20_1:GetWordFromCfg(325581005)
				local var_23_21 = arg_20_1:FormatText(var_23_20.content)

				arg_20_1.text_.text = var_23_21

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_22 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581005", "story_v_out_325581.awb") ~= 0 then
					local var_23_25 = manager.audio:GetVoiceLength("story_v_out_325581", "325581005", "story_v_out_325581.awb") / 1000

					if var_23_25 + var_23_17 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_25 + var_23_17
					end

					if var_23_20.prefab_name ~= "" and arg_20_1.actors_[var_23_20.prefab_name] ~= nil then
						local var_23_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_20.prefab_name].transform, "story_v_out_325581", "325581005", "story_v_out_325581.awb")

						arg_20_1:RecordAudio("325581005", var_23_26)
						arg_20_1:RecordAudio("325581005", var_23_26)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325581", "325581005", "story_v_out_325581.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325581", "325581005", "story_v_out_325581.awb")
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
				actorName = "10162ui_story",
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
	Play325581006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325581006
		arg_24_1.duration_ = 11.6

		local var_24_0 = {
			zh = 8.766,
			ja = 11.6
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
				arg_24_0:Play325581007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162actionlink/10162action4312")
			end

			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_2 = 0
			local var_27_3 = 0.925

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_4 = arg_24_1:FormatText(StoryNameCfg[1532].name)

				arg_24_1.leftNameTxt_.text = var_27_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_5 = arg_24_1:GetWordFromCfg(325581006)
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

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581006", "story_v_out_325581.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_out_325581", "325581006", "story_v_out_325581.awb") / 1000

					if var_27_10 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_2
					end

					if var_27_5.prefab_name ~= "" and arg_24_1.actors_[var_27_5.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_5.prefab_name].transform, "story_v_out_325581", "325581006", "story_v_out_325581.awb")

						arg_24_1:RecordAudio("325581006", var_27_11)
						arg_24_1:RecordAudio("325581006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325581", "325581006", "story_v_out_325581.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325581", "325581006", "story_v_out_325581.awb")
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
	Play325581007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325581007
		arg_28_1.duration_ = 7.63

		local var_28_0 = {
			zh = 5.1,
			ja = 7.633
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
				arg_28_0:Play325581008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10162ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10162ui_story == nil then
				arg_28_1.var_.characterEffect10162ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect10162ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10162ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10162ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10162ui_story.fillRatio = var_31_5
			end

			local var_31_6 = 0
			local var_31_7 = 0.5

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[1533].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_9 = arg_28_1:GetWordFromCfg(325581007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 20
				local var_31_12 = utf8.len(var_31_10)
				local var_31_13 = var_31_11 <= 0 and var_31_7 or var_31_7 * (var_31_12 / var_31_11)

				if var_31_13 > 0 and var_31_7 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581007", "story_v_out_325581.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_325581", "325581007", "story_v_out_325581.awb") / 1000

					if var_31_14 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_6
					end

					if var_31_9.prefab_name ~= "" and arg_28_1.actors_[var_31_9.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_9.prefab_name].transform, "story_v_out_325581", "325581007", "story_v_out_325581.awb")

						arg_28_1:RecordAudio("325581007", var_31_15)
						arg_28_1:RecordAudio("325581007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325581", "325581007", "story_v_out_325581.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325581", "325581007", "story_v_out_325581.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_16 and arg_28_1.time_ < var_31_6 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325581008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325581008
		arg_32_1.duration_ = 8.5

		local var_32_0 = {
			zh = 6.466,
			ja = 8.5
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
				arg_32_0:Play325581009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10162ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10162ui_story == nil then
				arg_32_1.var_.characterEffect10162ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect10162ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10162ui_story then
				arg_32_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_35_4 = 0

			if var_35_4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_2")
			end

			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_6 = 0
			local var_35_7 = 0.525

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_8 = arg_32_1:FormatText(StoryNameCfg[1532].name)

				arg_32_1.leftNameTxt_.text = var_35_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_9 = arg_32_1:GetWordFromCfg(325581008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581008", "story_v_out_325581.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_out_325581", "325581008", "story_v_out_325581.awb") / 1000

					if var_35_14 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_6
					end

					if var_35_9.prefab_name ~= "" and arg_32_1.actors_[var_35_9.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_9.prefab_name].transform, "story_v_out_325581", "325581008", "story_v_out_325581.awb")

						arg_32_1:RecordAudio("325581008", var_35_15)
						arg_32_1:RecordAudio("325581008", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325581", "325581008", "story_v_out_325581.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325581", "325581008", "story_v_out_325581.awb")
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
	Play325581009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325581009
		arg_36_1.duration_ = 11

		local var_36_0 = {
			zh = 9.1,
			ja = 11
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
				arg_36_0:Play325581010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10162ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos10162ui_story = var_39_0.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_3 then
				local var_39_4 = (arg_36_1.time_ - var_39_1) / var_39_3
				local var_39_5 = Vector3.New(-0.74, -1.08, -5.83)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10162ui_story, var_39_5, var_39_4)

				local var_39_6 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_6.x, var_39_6.y, var_39_6.z)

				local var_39_7 = var_39_0.localEulerAngles

				var_39_7.z = 0
				var_39_7.x = 0
				var_39_0.localEulerAngles = var_39_7
			end

			if arg_36_1.time_ >= var_39_1 + var_39_3 and arg_36_1.time_ < var_39_1 + var_39_3 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(-0.74, -1.08, -5.83)

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

			local var_39_11 = "10166ui_story"

			if arg_36_1.actors_[var_39_11] == nil then
				local var_39_12 = Asset.Load("Char/" .. "10166ui_story")

				if not isNil(var_39_12) then
					local var_39_13 = Object.Instantiate(Asset.Load("Char/" .. "10166ui_story"), arg_36_1.stage_.transform)

					var_39_13.name = var_39_11
					var_39_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_11] = var_39_13

					local var_39_14 = var_39_13:GetComponentInChildren(typeof(CharacterEffect))

					var_39_14.enabled = true

					local var_39_15 = GameObjectTools.GetOrAddComponent(var_39_13, typeof(DynamicBoneHelper))

					if var_39_15 then
						var_39_15:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_14.transform, false)

					arg_36_1.var_[var_39_11 .. "Animator"] = var_39_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_11 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_11 .. "LipSync"] = var_39_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_16 = arg_36_1.actors_["10166ui_story"].transform
			local var_39_17 = 0

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.var_.moveOldPos10166ui_story = var_39_16.localPosition

				local var_39_18 = GameObjectTools.GetOrAddComponent(var_39_16.gameObject, typeof(DynamicBoneHelper))

				if var_39_18 then
					var_39_18:EnableDynamicBone(false)
				end
			end

			local var_39_19 = 0.001

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_19 then
				local var_39_20 = (arg_36_1.time_ - var_39_17) / var_39_19
				local var_39_21 = Vector3.New(0.7, -1.28, -5.73)

				var_39_16.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10166ui_story, var_39_21, var_39_20)

				local var_39_22 = manager.ui.mainCamera.transform.position - var_39_16.position

				var_39_16.forward = Vector3.New(var_39_22.x, var_39_22.y, var_39_22.z)

				local var_39_23 = var_39_16.localEulerAngles

				var_39_23.z = 0
				var_39_23.x = 0
				var_39_16.localEulerAngles = var_39_23
			end

			if arg_36_1.time_ >= var_39_17 + var_39_19 and arg_36_1.time_ < var_39_17 + var_39_19 + arg_39_0 then
				var_39_16.localPosition = Vector3.New(0.7, -1.28, -5.73)

				local var_39_24 = manager.ui.mainCamera.transform.position - var_39_16.position

				var_39_16.forward = Vector3.New(var_39_24.x, var_39_24.y, var_39_24.z)

				local var_39_25 = var_39_16.localEulerAngles

				var_39_25.z = 0
				var_39_25.x = 0
				var_39_16.localEulerAngles = var_39_25

				local var_39_26 = GameObjectTools.GetOrAddComponent(var_39_16.gameObject, typeof(DynamicBoneHelper))

				if var_39_26 then
					var_39_26:EnableDynamicBone(true)
				end
			end

			local var_39_27 = arg_36_1.actors_["10166ui_story"]
			local var_39_28 = 0

			if var_39_28 < arg_36_1.time_ and arg_36_1.time_ <= var_39_28 + arg_39_0 and not isNil(var_39_27) and arg_36_1.var_.characterEffect10166ui_story == nil then
				arg_36_1.var_.characterEffect10166ui_story = var_39_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_29 = 0.200000002980232

			if var_39_28 <= arg_36_1.time_ and arg_36_1.time_ < var_39_28 + var_39_29 and not isNil(var_39_27) then
				local var_39_30 = (arg_36_1.time_ - var_39_28) / var_39_29

				if arg_36_1.var_.characterEffect10166ui_story and not isNil(var_39_27) then
					arg_36_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_28 + var_39_29 and arg_36_1.time_ < var_39_28 + var_39_29 + arg_39_0 and not isNil(var_39_27) and arg_36_1.var_.characterEffect10166ui_story then
				arg_36_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_39_31 = arg_36_1.actors_["10162ui_story"]
			local var_39_32 = 0

			if var_39_32 < arg_36_1.time_ and arg_36_1.time_ <= var_39_32 + arg_39_0 and not isNil(var_39_31) and arg_36_1.var_.characterEffect10162ui_story == nil then
				arg_36_1.var_.characterEffect10162ui_story = var_39_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_33 = 0.200000002980232

			if var_39_32 <= arg_36_1.time_ and arg_36_1.time_ < var_39_32 + var_39_33 and not isNil(var_39_31) then
				local var_39_34 = (arg_36_1.time_ - var_39_32) / var_39_33

				if arg_36_1.var_.characterEffect10162ui_story and not isNil(var_39_31) then
					local var_39_35 = Mathf.Lerp(0, 0.5, var_39_34)

					arg_36_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10162ui_story.fillRatio = var_39_35
				end
			end

			if arg_36_1.time_ >= var_39_32 + var_39_33 and arg_36_1.time_ < var_39_32 + var_39_33 + arg_39_0 and not isNil(var_39_31) and arg_36_1.var_.characterEffect10162ui_story then
				local var_39_36 = 0.5

				arg_36_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10162ui_story.fillRatio = var_39_36
			end

			local var_39_37 = 0

			if var_39_37 < arg_36_1.time_ and arg_36_1.time_ <= var_39_37 + arg_39_0 then
				arg_36_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			local var_39_38 = 0

			if var_39_38 < arg_36_1.time_ and arg_36_1.time_ <= var_39_38 + arg_39_0 then
				arg_36_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_39 = 0
			local var_39_40 = 0.95

			if var_39_39 < arg_36_1.time_ and arg_36_1.time_ <= var_39_39 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_41 = arg_36_1:FormatText(StoryNameCfg[1530].name)

				arg_36_1.leftNameTxt_.text = var_39_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_42 = arg_36_1:GetWordFromCfg(325581009)
				local var_39_43 = arg_36_1:FormatText(var_39_42.content)

				arg_36_1.text_.text = var_39_43

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_44 = 38
				local var_39_45 = utf8.len(var_39_43)
				local var_39_46 = var_39_44 <= 0 and var_39_40 or var_39_40 * (var_39_45 / var_39_44)

				if var_39_46 > 0 and var_39_40 < var_39_46 then
					arg_36_1.talkMaxDuration = var_39_46

					if var_39_46 + var_39_39 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_46 + var_39_39
					end
				end

				arg_36_1.text_.text = var_39_43
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581009", "story_v_out_325581.awb") ~= 0 then
					local var_39_47 = manager.audio:GetVoiceLength("story_v_out_325581", "325581009", "story_v_out_325581.awb") / 1000

					if var_39_47 + var_39_39 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_47 + var_39_39
					end

					if var_39_42.prefab_name ~= "" and arg_36_1.actors_[var_39_42.prefab_name] ~= nil then
						local var_39_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_42.prefab_name].transform, "story_v_out_325581", "325581009", "story_v_out_325581.awb")

						arg_36_1:RecordAudio("325581009", var_39_48)
						arg_36_1:RecordAudio("325581009", var_39_48)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325581", "325581009", "story_v_out_325581.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325581", "325581009", "story_v_out_325581.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_49 = math.max(var_39_40, arg_36_1.talkMaxDuration)

			if var_39_39 <= arg_36_1.time_ and arg_36_1.time_ < var_39_39 + var_39_49 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_39) / var_39_49

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_39 + var_39_49 and arg_36_1.time_ < var_39_39 + var_39_49 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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
				actorName = "10166ui_story",
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
	Play325581010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325581010
		arg_40_1.duration_ = 4.53

		local var_40_0 = {
			zh = 4.533,
			ja = 3.366
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
				arg_40_0:Play325581011(arg_40_1)
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
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10166ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10166ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10166ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0
			local var_43_7 = 0.5

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[1533].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_9 = arg_40_1:GetWordFromCfg(325581010)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581010", "story_v_out_325581.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_out_325581", "325581010", "story_v_out_325581.awb") / 1000

					if var_43_14 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_6
					end

					if var_43_9.prefab_name ~= "" and arg_40_1.actors_[var_43_9.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_9.prefab_name].transform, "story_v_out_325581", "325581010", "story_v_out_325581.awb")

						arg_40_1:RecordAudio("325581010", var_43_15)
						arg_40_1:RecordAudio("325581010", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325581", "325581010", "story_v_out_325581.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325581", "325581010", "story_v_out_325581.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_16 and arg_40_1.time_ < var_43_6 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325581011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325581011
		arg_44_1.duration_ = 8.43

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325581012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10166ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10166ui_story == nil then
				arg_44_1.var_.characterEffect10166ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect10166ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10166ui_story then
				arg_44_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_47_4 = 0
			local var_47_5 = 1

			if var_47_4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_6 = arg_44_1:FormatText(StoryNameCfg[1530].name)

				arg_44_1.leftNameTxt_.text = var_47_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_7 = arg_44_1:GetWordFromCfg(325581011)
				local var_47_8 = arg_44_1:FormatText(var_47_7.content)

				arg_44_1.text_.text = var_47_8

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 40
				local var_47_10 = utf8.len(var_47_8)
				local var_47_11 = var_47_9 <= 0 and var_47_5 or var_47_5 * (var_47_10 / var_47_9)

				if var_47_11 > 0 and var_47_5 < var_47_11 then
					arg_44_1.talkMaxDuration = var_47_11

					if var_47_11 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_11 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_8
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581011", "story_v_out_325581.awb") ~= 0 then
					local var_47_12 = manager.audio:GetVoiceLength("story_v_out_325581", "325581011", "story_v_out_325581.awb") / 1000

					if var_47_12 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_4
					end

					if var_47_7.prefab_name ~= "" and arg_44_1.actors_[var_47_7.prefab_name] ~= nil then
						local var_47_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_7.prefab_name].transform, "story_v_out_325581", "325581011", "story_v_out_325581.awb")

						arg_44_1:RecordAudio("325581011", var_47_13)
						arg_44_1:RecordAudio("325581011", var_47_13)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325581", "325581011", "story_v_out_325581.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325581", "325581011", "story_v_out_325581.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_14 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_14 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_14

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_14 and arg_44_1.time_ < var_47_4 + var_47_14 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play325581012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325581012
		arg_48_1.duration_ = 10

		local var_48_0 = {
			zh = 7.6,
			ja = 10
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
				arg_48_0:Play325581013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10166ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10166ui_story == nil then
				arg_48_1.var_.characterEffect10166ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect10166ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10166ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10166ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10166ui_story.fillRatio = var_51_5
			end

			local var_51_6 = 0
			local var_51_7 = 0.95

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_8 = arg_48_1:FormatText(StoryNameCfg[1533].name)

				arg_48_1.leftNameTxt_.text = var_51_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_9 = arg_48_1:GetWordFromCfg(325581012)
				local var_51_10 = arg_48_1:FormatText(var_51_9.content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581012", "story_v_out_325581.awb") ~= 0 then
					local var_51_14 = manager.audio:GetVoiceLength("story_v_out_325581", "325581012", "story_v_out_325581.awb") / 1000

					if var_51_14 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_14 + var_51_6
					end

					if var_51_9.prefab_name ~= "" and arg_48_1.actors_[var_51_9.prefab_name] ~= nil then
						local var_51_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_9.prefab_name].transform, "story_v_out_325581", "325581012", "story_v_out_325581.awb")

						arg_48_1:RecordAudio("325581012", var_51_15)
						arg_48_1:RecordAudio("325581012", var_51_15)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325581", "325581012", "story_v_out_325581.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325581", "325581012", "story_v_out_325581.awb")
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
	Play325581013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325581013
		arg_52_1.duration_ = 5.77

		local var_52_0 = {
			zh = 4.666,
			ja = 5.766
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
				arg_52_0:Play325581014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10166ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10166ui_story == nil then
				arg_52_1.var_.characterEffect10166ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect10166ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10166ui_story then
				arg_52_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_55_4 = 0

			if var_55_4 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_1")
			end

			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_55_6 = 0
			local var_55_7 = 0.5

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[1530].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_9 = arg_52_1:GetWordFromCfg(325581013)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581013", "story_v_out_325581.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_325581", "325581013", "story_v_out_325581.awb") / 1000

					if var_55_14 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_6
					end

					if var_55_9.prefab_name ~= "" and arg_52_1.actors_[var_55_9.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_9.prefab_name].transform, "story_v_out_325581", "325581013", "story_v_out_325581.awb")

						arg_52_1:RecordAudio("325581013", var_55_15)
						arg_52_1:RecordAudio("325581013", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325581", "325581013", "story_v_out_325581.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325581", "325581013", "story_v_out_325581.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_16 and arg_52_1.time_ < var_55_6 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325581014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325581014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325581015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10166ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos10166ui_story = var_59_0.localPosition

				local var_59_2 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(false)
				end
			end

			local var_59_3 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_3 then
				local var_59_4 = (arg_56_1.time_ - var_59_1) / var_59_3
				local var_59_5 = Vector3.New(0, 100, 0)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10166ui_story, var_59_5, var_59_4)

				local var_59_6 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_6.x, var_59_6.y, var_59_6.z)

				local var_59_7 = var_59_0.localEulerAngles

				var_59_7.z = 0
				var_59_7.x = 0
				var_59_0.localEulerAngles = var_59_7
			end

			if arg_56_1.time_ >= var_59_1 + var_59_3 and arg_56_1.time_ < var_59_1 + var_59_3 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, 100, 0)

				local var_59_8 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_8.x, var_59_8.y, var_59_8.z)

				local var_59_9 = var_59_0.localEulerAngles

				var_59_9.z = 0
				var_59_9.x = 0
				var_59_0.localEulerAngles = var_59_9

				local var_59_10 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_10 then
					var_59_10:EnableDynamicBone(true)
				end
			end

			local var_59_11 = arg_56_1.actors_["10162ui_story"].transform
			local var_59_12 = 0

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 then
				arg_56_1.var_.moveOldPos10162ui_story = var_59_11.localPosition

				local var_59_13 = GameObjectTools.GetOrAddComponent(var_59_11.gameObject, typeof(DynamicBoneHelper))

				if var_59_13 then
					var_59_13:EnableDynamicBone(false)
				end
			end

			local var_59_14 = 0.001

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_14 then
				local var_59_15 = (arg_56_1.time_ - var_59_12) / var_59_14
				local var_59_16 = Vector3.New(0, 100, 0)

				var_59_11.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10162ui_story, var_59_16, var_59_15)

				local var_59_17 = manager.ui.mainCamera.transform.position - var_59_11.position

				var_59_11.forward = Vector3.New(var_59_17.x, var_59_17.y, var_59_17.z)

				local var_59_18 = var_59_11.localEulerAngles

				var_59_18.z = 0
				var_59_18.x = 0
				var_59_11.localEulerAngles = var_59_18
			end

			if arg_56_1.time_ >= var_59_12 + var_59_14 and arg_56_1.time_ < var_59_12 + var_59_14 + arg_59_0 then
				var_59_11.localPosition = Vector3.New(0, 100, 0)

				local var_59_19 = manager.ui.mainCamera.transform.position - var_59_11.position

				var_59_11.forward = Vector3.New(var_59_19.x, var_59_19.y, var_59_19.z)

				local var_59_20 = var_59_11.localEulerAngles

				var_59_20.z = 0
				var_59_20.x = 0
				var_59_11.localEulerAngles = var_59_20

				local var_59_21 = GameObjectTools.GetOrAddComponent(var_59_11.gameObject, typeof(DynamicBoneHelper))

				if var_59_21 then
					var_59_21:EnableDynamicBone(true)
				end
			end

			local var_59_22 = arg_56_1.actors_["10166ui_story"]
			local var_59_23 = 0

			if var_59_23 < arg_56_1.time_ and arg_56_1.time_ <= var_59_23 + arg_59_0 and not isNil(var_59_22) and arg_56_1.var_.characterEffect10166ui_story == nil then
				arg_56_1.var_.characterEffect10166ui_story = var_59_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_24 = 0.200000002980232

			if var_59_23 <= arg_56_1.time_ and arg_56_1.time_ < var_59_23 + var_59_24 and not isNil(var_59_22) then
				local var_59_25 = (arg_56_1.time_ - var_59_23) / var_59_24

				if arg_56_1.var_.characterEffect10166ui_story and not isNil(var_59_22) then
					local var_59_26 = Mathf.Lerp(0, 0.5, var_59_25)

					arg_56_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10166ui_story.fillRatio = var_59_26
				end
			end

			if arg_56_1.time_ >= var_59_23 + var_59_24 and arg_56_1.time_ < var_59_23 + var_59_24 + arg_59_0 and not isNil(var_59_22) and arg_56_1.var_.characterEffect10166ui_story then
				local var_59_27 = 0.5

				arg_56_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10166ui_story.fillRatio = var_59_27
			end

			local var_59_28 = 0
			local var_59_29 = 0.65

			if var_59_28 < arg_56_1.time_ and arg_56_1.time_ <= var_59_28 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_30 = arg_56_1:GetWordFromCfg(325581014)
				local var_59_31 = arg_56_1:FormatText(var_59_30.content)

				arg_56_1.text_.text = var_59_31

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_32 = 26
				local var_59_33 = utf8.len(var_59_31)
				local var_59_34 = var_59_32 <= 0 and var_59_29 or var_59_29 * (var_59_33 / var_59_32)

				if var_59_34 > 0 and var_59_29 < var_59_34 then
					arg_56_1.talkMaxDuration = var_59_34

					if var_59_34 + var_59_28 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_34 + var_59_28
					end
				end

				arg_56_1.text_.text = var_59_31
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_35 = math.max(var_59_29, arg_56_1.talkMaxDuration)

			if var_59_28 <= arg_56_1.time_ and arg_56_1.time_ < var_59_28 + var_59_35 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_28) / var_59_35

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_28 + var_59_35 and arg_56_1.time_ < var_59_28 + var_59_35 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play325581015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325581015
		arg_60_1.duration_ = 10.87

		local var_60_0 = {
			zh = 10.866,
			ja = 9.233
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
				arg_60_0:Play325581016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10166ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos10166ui_story = var_63_0.localPosition

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end
			end

			local var_63_3 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_3 then
				local var_63_4 = (arg_60_1.time_ - var_63_1) / var_63_3
				local var_63_5 = Vector3.New(0, -1.28, -5.73)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10166ui_story, var_63_5, var_63_4)

				local var_63_6 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_6.x, var_63_6.y, var_63_6.z)

				local var_63_7 = var_63_0.localEulerAngles

				var_63_7.z = 0
				var_63_7.x = 0
				var_63_0.localEulerAngles = var_63_7
			end

			if arg_60_1.time_ >= var_63_1 + var_63_3 and arg_60_1.time_ < var_63_1 + var_63_3 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, -1.28, -5.73)

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

			local var_63_11 = arg_60_1.actors_["10166ui_story"]
			local var_63_12 = 0

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect10166ui_story == nil then
				arg_60_1.var_.characterEffect10166ui_story = var_63_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_13 = 0.200000002980232

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_13 and not isNil(var_63_11) then
				local var_63_14 = (arg_60_1.time_ - var_63_12) / var_63_13

				if arg_60_1.var_.characterEffect10166ui_story and not isNil(var_63_11) then
					arg_60_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_12 + var_63_13 and arg_60_1.time_ < var_63_12 + var_63_13 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect10166ui_story then
				arg_60_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_63_15 = 0

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_2")
			end

			local var_63_16 = 0
			local var_63_17 = 1.075

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_18 = arg_60_1:FormatText(StoryNameCfg[1530].name)

				arg_60_1.leftNameTxt_.text = var_63_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_19 = arg_60_1:GetWordFromCfg(325581015)
				local var_63_20 = arg_60_1:FormatText(var_63_19.content)

				arg_60_1.text_.text = var_63_20

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_21 = 43
				local var_63_22 = utf8.len(var_63_20)
				local var_63_23 = var_63_21 <= 0 and var_63_17 or var_63_17 * (var_63_22 / var_63_21)

				if var_63_23 > 0 and var_63_17 < var_63_23 then
					arg_60_1.talkMaxDuration = var_63_23

					if var_63_23 + var_63_16 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_16
					end
				end

				arg_60_1.text_.text = var_63_20
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581015", "story_v_out_325581.awb") ~= 0 then
					local var_63_24 = manager.audio:GetVoiceLength("story_v_out_325581", "325581015", "story_v_out_325581.awb") / 1000

					if var_63_24 + var_63_16 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_24 + var_63_16
					end

					if var_63_19.prefab_name ~= "" and arg_60_1.actors_[var_63_19.prefab_name] ~= nil then
						local var_63_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_19.prefab_name].transform, "story_v_out_325581", "325581015", "story_v_out_325581.awb")

						arg_60_1:RecordAudio("325581015", var_63_25)
						arg_60_1:RecordAudio("325581015", var_63_25)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325581", "325581015", "story_v_out_325581.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325581", "325581015", "story_v_out_325581.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_26 = math.max(var_63_17, arg_60_1.talkMaxDuration)

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_26 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_16) / var_63_26

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_16 + var_63_26 and arg_60_1.time_ < var_63_16 + var_63_26 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play325581016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325581016
		arg_64_1.duration_ = 6.97

		local var_64_0 = {
			zh = 4.3,
			ja = 6.966
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
				arg_64_0:Play325581017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10166ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos10166ui_story = var_67_0.localPosition

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end
			end

			local var_67_3 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_3 then
				local var_67_4 = (arg_64_1.time_ - var_67_1) / var_67_3
				local var_67_5 = Vector3.New(-0.96, -1.28, -5.73)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10166ui_story, var_67_5, var_67_4)

				local var_67_6 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_6.x, var_67_6.y, var_67_6.z)

				local var_67_7 = var_67_0.localEulerAngles

				var_67_7.z = 0
				var_67_7.x = 0
				var_67_0.localEulerAngles = var_67_7
			end

			if arg_64_1.time_ >= var_67_1 + var_67_3 and arg_64_1.time_ < var_67_1 + var_67_3 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(-0.96, -1.28, -5.73)

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

			local var_67_11 = arg_64_1.actors_["10162ui_story"].transform
			local var_67_12 = 0

			if var_67_12 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 then
				arg_64_1.var_.moveOldPos10162ui_story = var_67_11.localPosition

				local var_67_13 = GameObjectTools.GetOrAddComponent(var_67_11.gameObject, typeof(DynamicBoneHelper))

				if var_67_13 then
					var_67_13:EnableDynamicBone(false)
				end
			end

			local var_67_14 = 0.001

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_14 then
				local var_67_15 = (arg_64_1.time_ - var_67_12) / var_67_14
				local var_67_16 = Vector3.New(0.7, -1.08, -5.83)

				var_67_11.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10162ui_story, var_67_16, var_67_15)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_11.position

				var_67_11.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_11.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_11.localEulerAngles = var_67_18
			end

			if arg_64_1.time_ >= var_67_12 + var_67_14 and arg_64_1.time_ < var_67_12 + var_67_14 + arg_67_0 then
				var_67_11.localPosition = Vector3.New(0.7, -1.08, -5.83)

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

			local var_67_22 = arg_64_1.actors_["10162ui_story"]
			local var_67_23 = 0

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 and not isNil(var_67_22) and arg_64_1.var_.characterEffect10162ui_story == nil then
				arg_64_1.var_.characterEffect10162ui_story = var_67_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_24 = 0.200000002980232

			if var_67_23 <= arg_64_1.time_ and arg_64_1.time_ < var_67_23 + var_67_24 and not isNil(var_67_22) then
				local var_67_25 = (arg_64_1.time_ - var_67_23) / var_67_24

				if arg_64_1.var_.characterEffect10162ui_story and not isNil(var_67_22) then
					arg_64_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_23 + var_67_24 and arg_64_1.time_ < var_67_23 + var_67_24 + arg_67_0 and not isNil(var_67_22) and arg_64_1.var_.characterEffect10162ui_story then
				arg_64_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_67_26 = arg_64_1.actors_["10166ui_story"]
			local var_67_27 = 0

			if var_67_27 < arg_64_1.time_ and arg_64_1.time_ <= var_67_27 + arg_67_0 and not isNil(var_67_26) and arg_64_1.var_.characterEffect10166ui_story == nil then
				arg_64_1.var_.characterEffect10166ui_story = var_67_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_28 = 0.200000002980232

			if var_67_27 <= arg_64_1.time_ and arg_64_1.time_ < var_67_27 + var_67_28 and not isNil(var_67_26) then
				local var_67_29 = (arg_64_1.time_ - var_67_27) / var_67_28

				if arg_64_1.var_.characterEffect10166ui_story and not isNil(var_67_26) then
					local var_67_30 = Mathf.Lerp(0, 0.5, var_67_29)

					arg_64_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10166ui_story.fillRatio = var_67_30
				end
			end

			if arg_64_1.time_ >= var_67_27 + var_67_28 and arg_64_1.time_ < var_67_27 + var_67_28 + arg_67_0 and not isNil(var_67_26) and arg_64_1.var_.characterEffect10166ui_story then
				local var_67_31 = 0.5

				arg_64_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10166ui_story.fillRatio = var_67_31
			end

			local var_67_32 = 0

			if var_67_32 < arg_64_1.time_ and arg_64_1.time_ <= var_67_32 + arg_67_0 then
				arg_64_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			local var_67_33 = 0

			if var_67_33 < arg_64_1.time_ and arg_64_1.time_ <= var_67_33 + arg_67_0 then
				arg_64_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_34 = 0
			local var_67_35 = 0.525

			if var_67_34 < arg_64_1.time_ and arg_64_1.time_ <= var_67_34 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_36 = arg_64_1:FormatText(StoryNameCfg[1532].name)

				arg_64_1.leftNameTxt_.text = var_67_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_37 = arg_64_1:GetWordFromCfg(325581016)
				local var_67_38 = arg_64_1:FormatText(var_67_37.content)

				arg_64_1.text_.text = var_67_38

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_39 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581016", "story_v_out_325581.awb") ~= 0 then
					local var_67_42 = manager.audio:GetVoiceLength("story_v_out_325581", "325581016", "story_v_out_325581.awb") / 1000

					if var_67_42 + var_67_34 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_42 + var_67_34
					end

					if var_67_37.prefab_name ~= "" and arg_64_1.actors_[var_67_37.prefab_name] ~= nil then
						local var_67_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_37.prefab_name].transform, "story_v_out_325581", "325581016", "story_v_out_325581.awb")

						arg_64_1:RecordAudio("325581016", var_67_43)
						arg_64_1:RecordAudio("325581016", var_67_43)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325581", "325581016", "story_v_out_325581.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325581", "325581016", "story_v_out_325581.awb")
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
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play325581017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325581017
		arg_68_1.duration_ = 5.2

		local var_68_0 = {
			zh = 4.733,
			ja = 5.2
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
				arg_68_0:Play325581018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10166ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10166ui_story == nil then
				arg_68_1.var_.characterEffect10166ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect10166ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10166ui_story then
				arg_68_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["10162ui_story"]
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect10162ui_story == nil then
				arg_68_1.var_.characterEffect10162ui_story = var_71_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.200000002980232

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 and not isNil(var_71_4) then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6

				if arg_68_1.var_.characterEffect10162ui_story and not isNil(var_71_4) then
					local var_71_8 = Mathf.Lerp(0, 0.5, var_71_7)

					arg_68_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_68_1.var_.characterEffect10162ui_story.fillRatio = var_71_8
				end
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect10162ui_story then
				local var_71_9 = 0.5

				arg_68_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_68_1.var_.characterEffect10162ui_story.fillRatio = var_71_9
			end

			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			local var_71_11 = 0

			if var_71_11 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_71_12 = 0
			local var_71_13 = 0.45

			if var_71_12 < arg_68_1.time_ and arg_68_1.time_ <= var_71_12 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_14 = arg_68_1:FormatText(StoryNameCfg[1530].name)

				arg_68_1.leftNameTxt_.text = var_71_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_15 = arg_68_1:GetWordFromCfg(325581017)
				local var_71_16 = arg_68_1:FormatText(var_71_15.content)

				arg_68_1.text_.text = var_71_16

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_17 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581017", "story_v_out_325581.awb") ~= 0 then
					local var_71_20 = manager.audio:GetVoiceLength("story_v_out_325581", "325581017", "story_v_out_325581.awb") / 1000

					if var_71_20 + var_71_12 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_20 + var_71_12
					end

					if var_71_15.prefab_name ~= "" and arg_68_1.actors_[var_71_15.prefab_name] ~= nil then
						local var_71_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_15.prefab_name].transform, "story_v_out_325581", "325581017", "story_v_out_325581.awb")

						arg_68_1:RecordAudio("325581017", var_71_21)
						arg_68_1:RecordAudio("325581017", var_71_21)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325581", "325581017", "story_v_out_325581.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325581", "325581017", "story_v_out_325581.awb")
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
	Play325581018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325581018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play325581019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10166ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos10166ui_story = var_75_0.localPosition

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end
			end

			local var_75_3 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_3 then
				local var_75_4 = (arg_72_1.time_ - var_75_1) / var_75_3
				local var_75_5 = Vector3.New(0, 100, 0)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10166ui_story, var_75_5, var_75_4)

				local var_75_6 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_6.x, var_75_6.y, var_75_6.z)

				local var_75_7 = var_75_0.localEulerAngles

				var_75_7.z = 0
				var_75_7.x = 0
				var_75_0.localEulerAngles = var_75_7
			end

			if arg_72_1.time_ >= var_75_1 + var_75_3 and arg_72_1.time_ < var_75_1 + var_75_3 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, 100, 0)

				local var_75_8 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_8.x, var_75_8.y, var_75_8.z)

				local var_75_9 = var_75_0.localEulerAngles

				var_75_9.z = 0
				var_75_9.x = 0
				var_75_0.localEulerAngles = var_75_9

				local var_75_10 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_10 then
					var_75_10:EnableDynamicBone(true)
				end
			end

			local var_75_11 = arg_72_1.actors_["10162ui_story"].transform
			local var_75_12 = 0

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 then
				arg_72_1.var_.moveOldPos10162ui_story = var_75_11.localPosition

				local var_75_13 = GameObjectTools.GetOrAddComponent(var_75_11.gameObject, typeof(DynamicBoneHelper))

				if var_75_13 then
					var_75_13:EnableDynamicBone(false)
				end
			end

			local var_75_14 = 0.001

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_14 then
				local var_75_15 = (arg_72_1.time_ - var_75_12) / var_75_14
				local var_75_16 = Vector3.New(0, 100, 0)

				var_75_11.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10162ui_story, var_75_16, var_75_15)

				local var_75_17 = manager.ui.mainCamera.transform.position - var_75_11.position

				var_75_11.forward = Vector3.New(var_75_17.x, var_75_17.y, var_75_17.z)

				local var_75_18 = var_75_11.localEulerAngles

				var_75_18.z = 0
				var_75_18.x = 0
				var_75_11.localEulerAngles = var_75_18
			end

			if arg_72_1.time_ >= var_75_12 + var_75_14 and arg_72_1.time_ < var_75_12 + var_75_14 + arg_75_0 then
				var_75_11.localPosition = Vector3.New(0, 100, 0)

				local var_75_19 = manager.ui.mainCamera.transform.position - var_75_11.position

				var_75_11.forward = Vector3.New(var_75_19.x, var_75_19.y, var_75_19.z)

				local var_75_20 = var_75_11.localEulerAngles

				var_75_20.z = 0
				var_75_20.x = 0
				var_75_11.localEulerAngles = var_75_20

				local var_75_21 = GameObjectTools.GetOrAddComponent(var_75_11.gameObject, typeof(DynamicBoneHelper))

				if var_75_21 then
					var_75_21:EnableDynamicBone(true)
				end
			end

			local var_75_22 = arg_72_1.actors_["10166ui_story"]
			local var_75_23 = 0

			if var_75_23 < arg_72_1.time_ and arg_72_1.time_ <= var_75_23 + arg_75_0 and not isNil(var_75_22) and arg_72_1.var_.characterEffect10166ui_story == nil then
				arg_72_1.var_.characterEffect10166ui_story = var_75_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_24 = 0.200000002980232

			if var_75_23 <= arg_72_1.time_ and arg_72_1.time_ < var_75_23 + var_75_24 and not isNil(var_75_22) then
				local var_75_25 = (arg_72_1.time_ - var_75_23) / var_75_24

				if arg_72_1.var_.characterEffect10166ui_story and not isNil(var_75_22) then
					local var_75_26 = Mathf.Lerp(0, 0.5, var_75_25)

					arg_72_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_72_1.var_.characterEffect10166ui_story.fillRatio = var_75_26
				end
			end

			if arg_72_1.time_ >= var_75_23 + var_75_24 and arg_72_1.time_ < var_75_23 + var_75_24 + arg_75_0 and not isNil(var_75_22) and arg_72_1.var_.characterEffect10166ui_story then
				local var_75_27 = 0.5

				arg_72_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_72_1.var_.characterEffect10166ui_story.fillRatio = var_75_27
			end

			local var_75_28 = 0
			local var_75_29 = 1.2

			if var_75_28 < arg_72_1.time_ and arg_72_1.time_ <= var_75_28 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_30 = arg_72_1:GetWordFromCfg(325581018)
				local var_75_31 = arg_72_1:FormatText(var_75_30.content)

				arg_72_1.text_.text = var_75_31

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_32 = 48
				local var_75_33 = utf8.len(var_75_31)
				local var_75_34 = var_75_32 <= 0 and var_75_29 or var_75_29 * (var_75_33 / var_75_32)

				if var_75_34 > 0 and var_75_29 < var_75_34 then
					arg_72_1.talkMaxDuration = var_75_34

					if var_75_34 + var_75_28 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_34 + var_75_28
					end
				end

				arg_72_1.text_.text = var_75_31
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_35 = math.max(var_75_29, arg_72_1.talkMaxDuration)

			if var_75_28 <= arg_72_1.time_ and arg_72_1.time_ < var_75_28 + var_75_35 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_28) / var_75_35

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_28 + var_75_35 and arg_72_1.time_ < var_75_28 + var_75_35 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play325581019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325581019
		arg_76_1.duration_ = 3.47

		local var_76_0 = {
			zh = 3.233,
			ja = 3.466
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
				arg_76_0:Play325581020(arg_76_1)
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
				local var_79_5 = Vector3.New(0, -1.28, -5.73)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10166ui_story, var_79_5, var_79_4)

				local var_79_6 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_6.x, var_79_6.y, var_79_6.z)

				local var_79_7 = var_79_0.localEulerAngles

				var_79_7.z = 0
				var_79_7.x = 0
				var_79_0.localEulerAngles = var_79_7
			end

			if arg_76_1.time_ >= var_79_1 + var_79_3 and arg_76_1.time_ < var_79_1 + var_79_3 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0, -1.28, -5.73)

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

			local var_79_11 = arg_76_1.actors_["10166ui_story"]
			local var_79_12 = 0

			if var_79_12 < arg_76_1.time_ and arg_76_1.time_ <= var_79_12 + arg_79_0 and not isNil(var_79_11) and arg_76_1.var_.characterEffect10166ui_story == nil then
				arg_76_1.var_.characterEffect10166ui_story = var_79_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_13 = 0.200000002980232

			if var_79_12 <= arg_76_1.time_ and arg_76_1.time_ < var_79_12 + var_79_13 and not isNil(var_79_11) then
				local var_79_14 = (arg_76_1.time_ - var_79_12) / var_79_13

				if arg_76_1.var_.characterEffect10166ui_story and not isNil(var_79_11) then
					arg_76_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_12 + var_79_13 and arg_76_1.time_ < var_79_12 + var_79_13 + arg_79_0 and not isNil(var_79_11) and arg_76_1.var_.characterEffect10166ui_story then
				arg_76_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_79_15 = 0
			local var_79_16 = 0.375

			if var_79_15 < arg_76_1.time_ and arg_76_1.time_ <= var_79_15 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_17 = arg_76_1:FormatText(StoryNameCfg[1530].name)

				arg_76_1.leftNameTxt_.text = var_79_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_18 = arg_76_1:GetWordFromCfg(325581019)
				local var_79_19 = arg_76_1:FormatText(var_79_18.content)

				arg_76_1.text_.text = var_79_19

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_20 = 15
				local var_79_21 = utf8.len(var_79_19)
				local var_79_22 = var_79_20 <= 0 and var_79_16 or var_79_16 * (var_79_21 / var_79_20)

				if var_79_22 > 0 and var_79_16 < var_79_22 then
					arg_76_1.talkMaxDuration = var_79_22

					if var_79_22 + var_79_15 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_22 + var_79_15
					end
				end

				arg_76_1.text_.text = var_79_19
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581019", "story_v_out_325581.awb") ~= 0 then
					local var_79_23 = manager.audio:GetVoiceLength("story_v_out_325581", "325581019", "story_v_out_325581.awb") / 1000

					if var_79_23 + var_79_15 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_23 + var_79_15
					end

					if var_79_18.prefab_name ~= "" and arg_76_1.actors_[var_79_18.prefab_name] ~= nil then
						local var_79_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_18.prefab_name].transform, "story_v_out_325581", "325581019", "story_v_out_325581.awb")

						arg_76_1:RecordAudio("325581019", var_79_24)
						arg_76_1:RecordAudio("325581019", var_79_24)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325581", "325581019", "story_v_out_325581.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325581", "325581019", "story_v_out_325581.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_25 = math.max(var_79_16, arg_76_1.talkMaxDuration)

			if var_79_15 <= arg_76_1.time_ and arg_76_1.time_ < var_79_15 + var_79_25 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_15) / var_79_25

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_15 + var_79_25 and arg_76_1.time_ < var_79_15 + var_79_25 + arg_79_0 then
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
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play325581020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325581020
		arg_80_1.duration_ = 4.27

		local var_80_0 = {
			zh = 4.066,
			ja = 4.266
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
				arg_80_0:Play325581021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10166ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos10166ui_story = var_83_0.localPosition

				local var_83_2 = GameObjectTools.GetOrAddComponent(var_83_0.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(false)
				end
			end

			local var_83_3 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_3 then
				local var_83_4 = (arg_80_1.time_ - var_83_1) / var_83_3
				local var_83_5 = Vector3.New(-0.96, -1.28, -5.73)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10166ui_story, var_83_5, var_83_4)

				local var_83_6 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_6.x, var_83_6.y, var_83_6.z)

				local var_83_7 = var_83_0.localEulerAngles

				var_83_7.z = 0
				var_83_7.x = 0
				var_83_0.localEulerAngles = var_83_7
			end

			if arg_80_1.time_ >= var_83_1 + var_83_3 and arg_80_1.time_ < var_83_1 + var_83_3 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(-0.96, -1.28, -5.73)

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

			local var_83_11 = arg_80_1.actors_["10162ui_story"].transform
			local var_83_12 = 0

			if var_83_12 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
				arg_80_1.var_.moveOldPos10162ui_story = var_83_11.localPosition

				local var_83_13 = GameObjectTools.GetOrAddComponent(var_83_11.gameObject, typeof(DynamicBoneHelper))

				if var_83_13 then
					var_83_13:EnableDynamicBone(false)
				end
			end

			local var_83_14 = 0.001

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_14 then
				local var_83_15 = (arg_80_1.time_ - var_83_12) / var_83_14
				local var_83_16 = Vector3.New(0.7, -1.08, -5.83)

				var_83_11.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10162ui_story, var_83_16, var_83_15)

				local var_83_17 = manager.ui.mainCamera.transform.position - var_83_11.position

				var_83_11.forward = Vector3.New(var_83_17.x, var_83_17.y, var_83_17.z)

				local var_83_18 = var_83_11.localEulerAngles

				var_83_18.z = 0
				var_83_18.x = 0
				var_83_11.localEulerAngles = var_83_18
			end

			if arg_80_1.time_ >= var_83_12 + var_83_14 and arg_80_1.time_ < var_83_12 + var_83_14 + arg_83_0 then
				var_83_11.localPosition = Vector3.New(0.7, -1.08, -5.83)

				local var_83_19 = manager.ui.mainCamera.transform.position - var_83_11.position

				var_83_11.forward = Vector3.New(var_83_19.x, var_83_19.y, var_83_19.z)

				local var_83_20 = var_83_11.localEulerAngles

				var_83_20.z = 0
				var_83_20.x = 0
				var_83_11.localEulerAngles = var_83_20

				local var_83_21 = GameObjectTools.GetOrAddComponent(var_83_11.gameObject, typeof(DynamicBoneHelper))

				if var_83_21 then
					var_83_21:EnableDynamicBone(true)
				end
			end

			local var_83_22 = arg_80_1.actors_["10162ui_story"]
			local var_83_23 = 0

			if var_83_23 < arg_80_1.time_ and arg_80_1.time_ <= var_83_23 + arg_83_0 and not isNil(var_83_22) and arg_80_1.var_.characterEffect10162ui_story == nil then
				arg_80_1.var_.characterEffect10162ui_story = var_83_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_24 = 0.200000002980232

			if var_83_23 <= arg_80_1.time_ and arg_80_1.time_ < var_83_23 + var_83_24 and not isNil(var_83_22) then
				local var_83_25 = (arg_80_1.time_ - var_83_23) / var_83_24

				if arg_80_1.var_.characterEffect10162ui_story and not isNil(var_83_22) then
					arg_80_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_23 + var_83_24 and arg_80_1.time_ < var_83_23 + var_83_24 + arg_83_0 and not isNil(var_83_22) and arg_80_1.var_.characterEffect10162ui_story then
				arg_80_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_83_26 = arg_80_1.actors_["10166ui_story"]
			local var_83_27 = 0

			if var_83_27 < arg_80_1.time_ and arg_80_1.time_ <= var_83_27 + arg_83_0 and not isNil(var_83_26) and arg_80_1.var_.characterEffect10166ui_story == nil then
				arg_80_1.var_.characterEffect10166ui_story = var_83_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_28 = 0.200000002980232

			if var_83_27 <= arg_80_1.time_ and arg_80_1.time_ < var_83_27 + var_83_28 and not isNil(var_83_26) then
				local var_83_29 = (arg_80_1.time_ - var_83_27) / var_83_28

				if arg_80_1.var_.characterEffect10166ui_story and not isNil(var_83_26) then
					local var_83_30 = Mathf.Lerp(0, 0.5, var_83_29)

					arg_80_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10166ui_story.fillRatio = var_83_30
				end
			end

			if arg_80_1.time_ >= var_83_27 + var_83_28 and arg_80_1.time_ < var_83_27 + var_83_28 + arg_83_0 and not isNil(var_83_26) and arg_80_1.var_.characterEffect10166ui_story then
				local var_83_31 = 0.5

				arg_80_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10166ui_story.fillRatio = var_83_31
			end

			local var_83_32 = 0

			if var_83_32 < arg_80_1.time_ and arg_80_1.time_ <= var_83_32 + arg_83_0 then
				arg_80_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_83_33 = 0
			local var_83_34 = 0.4

			if var_83_33 < arg_80_1.time_ and arg_80_1.time_ <= var_83_33 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_35 = arg_80_1:FormatText(StoryNameCfg[1532].name)

				arg_80_1.leftNameTxt_.text = var_83_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_36 = arg_80_1:GetWordFromCfg(325581020)
				local var_83_37 = arg_80_1:FormatText(var_83_36.content)

				arg_80_1.text_.text = var_83_37

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_38 = 16
				local var_83_39 = utf8.len(var_83_37)
				local var_83_40 = var_83_38 <= 0 and var_83_34 or var_83_34 * (var_83_39 / var_83_38)

				if var_83_40 > 0 and var_83_34 < var_83_40 then
					arg_80_1.talkMaxDuration = var_83_40

					if var_83_40 + var_83_33 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_40 + var_83_33
					end
				end

				arg_80_1.text_.text = var_83_37
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581020", "story_v_out_325581.awb") ~= 0 then
					local var_83_41 = manager.audio:GetVoiceLength("story_v_out_325581", "325581020", "story_v_out_325581.awb") / 1000

					if var_83_41 + var_83_33 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_41 + var_83_33
					end

					if var_83_36.prefab_name ~= "" and arg_80_1.actors_[var_83_36.prefab_name] ~= nil then
						local var_83_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_36.prefab_name].transform, "story_v_out_325581", "325581020", "story_v_out_325581.awb")

						arg_80_1:RecordAudio("325581020", var_83_42)
						arg_80_1:RecordAudio("325581020", var_83_42)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_325581", "325581020", "story_v_out_325581.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_325581", "325581020", "story_v_out_325581.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_43 = math.max(var_83_34, arg_80_1.talkMaxDuration)

			if var_83_33 <= arg_80_1.time_ and arg_80_1.time_ < var_83_33 + var_83_43 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_33) / var_83_43

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_33 + var_83_43 and arg_80_1.time_ < var_83_33 + var_83_43 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play325581021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325581021
		arg_84_1.duration_ = 14.33

		local var_84_0 = {
			zh = 9.466,
			ja = 14.333
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
				arg_84_0:Play325581022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.775

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[1532].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:GetWordFromCfg(325581021)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 31
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581021", "story_v_out_325581.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_325581", "325581021", "story_v_out_325581.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_325581", "325581021", "story_v_out_325581.awb")

						arg_84_1:RecordAudio("325581021", var_87_9)
						arg_84_1:RecordAudio("325581021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_325581", "325581021", "story_v_out_325581.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_325581", "325581021", "story_v_out_325581.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_10 and arg_84_1.time_ < var_87_0 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play325581022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325581022
		arg_88_1.duration_ = 5.73

		local var_88_0 = {
			zh = 5.733,
			ja = 3.2
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
				arg_88_0:Play325581023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10166ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10166ui_story == nil then
				arg_88_1.var_.characterEffect10166ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect10166ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10166ui_story then
				arg_88_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_91_4 = arg_88_1.actors_["10162ui_story"]
			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect10162ui_story == nil then
				arg_88_1.var_.characterEffect10162ui_story = var_91_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.200000002980232

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 and not isNil(var_91_4) then
				local var_91_7 = (arg_88_1.time_ - var_91_5) / var_91_6

				if arg_88_1.var_.characterEffect10162ui_story and not isNil(var_91_4) then
					local var_91_8 = Mathf.Lerp(0, 0.5, var_91_7)

					arg_88_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_88_1.var_.characterEffect10162ui_story.fillRatio = var_91_8
				end
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect10162ui_story then
				local var_91_9 = 0.5

				arg_88_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_88_1.var_.characterEffect10162ui_story.fillRatio = var_91_9
			end

			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action16_1")
			end

			local var_91_11 = 0

			if var_91_11 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_91_12 = 0
			local var_91_13 = 0.55

			if var_91_12 < arg_88_1.time_ and arg_88_1.time_ <= var_91_12 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_14 = arg_88_1:FormatText(StoryNameCfg[1530].name)

				arg_88_1.leftNameTxt_.text = var_91_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_15 = arg_88_1:GetWordFromCfg(325581022)
				local var_91_16 = arg_88_1:FormatText(var_91_15.content)

				arg_88_1.text_.text = var_91_16

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_17 = 22
				local var_91_18 = utf8.len(var_91_16)
				local var_91_19 = var_91_17 <= 0 and var_91_13 or var_91_13 * (var_91_18 / var_91_17)

				if var_91_19 > 0 and var_91_13 < var_91_19 then
					arg_88_1.talkMaxDuration = var_91_19

					if var_91_19 + var_91_12 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_19 + var_91_12
					end
				end

				arg_88_1.text_.text = var_91_16
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581022", "story_v_out_325581.awb") ~= 0 then
					local var_91_20 = manager.audio:GetVoiceLength("story_v_out_325581", "325581022", "story_v_out_325581.awb") / 1000

					if var_91_20 + var_91_12 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_20 + var_91_12
					end

					if var_91_15.prefab_name ~= "" and arg_88_1.actors_[var_91_15.prefab_name] ~= nil then
						local var_91_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_15.prefab_name].transform, "story_v_out_325581", "325581022", "story_v_out_325581.awb")

						arg_88_1:RecordAudio("325581022", var_91_21)
						arg_88_1:RecordAudio("325581022", var_91_21)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_325581", "325581022", "story_v_out_325581.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_325581", "325581022", "story_v_out_325581.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_22 = math.max(var_91_13, arg_88_1.talkMaxDuration)

			if var_91_12 <= arg_88_1.time_ and arg_88_1.time_ < var_91_12 + var_91_22 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_12) / var_91_22

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_12 + var_91_22 and arg_88_1.time_ < var_91_12 + var_91_22 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play325581023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325581023
		arg_92_1.duration_ = 10.23

		local var_92_0 = {
			zh = 5.733,
			ja = 10.233
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
				arg_92_0:Play325581024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 0.675

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[1530].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_3 = arg_92_1:GetWordFromCfg(325581023)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581023", "story_v_out_325581.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_325581", "325581023", "story_v_out_325581.awb") / 1000

					if var_95_8 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_0
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_325581", "325581023", "story_v_out_325581.awb")

						arg_92_1:RecordAudio("325581023", var_95_9)
						arg_92_1:RecordAudio("325581023", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325581", "325581023", "story_v_out_325581.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325581", "325581023", "story_v_out_325581.awb")
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
	Play325581024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325581024
		arg_96_1.duration_ = 9

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325581025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = "J26h"

			if arg_96_1.bgs_[var_99_0] == nil then
				local var_99_1 = Object.Instantiate(arg_96_1.paintGo_)

				var_99_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_99_0)
				var_99_1.name = var_99_0
				var_99_1.transform.parent = arg_96_1.stage_.transform
				var_99_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.bgs_[var_99_0] = var_99_1
			end

			local var_99_2 = 2

			if var_99_2 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				local var_99_3 = manager.ui.mainCamera.transform.localPosition
				local var_99_4 = Vector3.New(0, 0, 10) + Vector3.New(var_99_3.x, var_99_3.y, 0)
				local var_99_5 = arg_96_1.bgs_.J26h

				var_99_5.transform.localPosition = var_99_4
				var_99_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_99_6 = var_99_5:GetComponent("SpriteRenderer")

				if var_99_6 and var_99_6.sprite then
					local var_99_7 = (var_99_5.transform.localPosition - var_99_3).z
					local var_99_8 = manager.ui.mainCameraCom_
					local var_99_9 = 2 * var_99_7 * Mathf.Tan(var_99_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_99_10 = var_99_9 * var_99_8.aspect
					local var_99_11 = var_99_6.sprite.bounds.size.x
					local var_99_12 = var_99_6.sprite.bounds.size.y
					local var_99_13 = var_99_10 / var_99_11
					local var_99_14 = var_99_9 / var_99_12
					local var_99_15 = var_99_14 < var_99_13 and var_99_13 or var_99_14

					var_99_5.transform.localScale = Vector3.New(var_99_15, var_99_15, 0)
				end

				for iter_99_0, iter_99_1 in pairs(arg_96_1.bgs_) do
					if iter_99_0 ~= "J26h" then
						iter_99_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_99_16 = 3.999999999999

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.allBtn_.enabled = false
			end

			local var_99_17 = 0.3

			if arg_96_1.time_ >= var_99_16 + var_99_17 and arg_96_1.time_ < var_99_16 + var_99_17 + arg_99_0 then
				arg_96_1.allBtn_.enabled = true
			end

			local var_99_18 = 0

			if var_99_18 < arg_96_1.time_ and arg_96_1.time_ <= var_99_18 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_19 = 2

			if var_99_18 <= arg_96_1.time_ and arg_96_1.time_ < var_99_18 + var_99_19 then
				local var_99_20 = (arg_96_1.time_ - var_99_18) / var_99_19
				local var_99_21 = Color.New(0, 0, 0)

				var_99_21.a = Mathf.Lerp(0, 1, var_99_20)
				arg_96_1.mask_.color = var_99_21
			end

			if arg_96_1.time_ >= var_99_18 + var_99_19 and arg_96_1.time_ < var_99_18 + var_99_19 + arg_99_0 then
				local var_99_22 = Color.New(0, 0, 0)

				var_99_22.a = 1
				arg_96_1.mask_.color = var_99_22
			end

			local var_99_23 = 2

			if var_99_23 < arg_96_1.time_ and arg_96_1.time_ <= var_99_23 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_24 = 2

			if var_99_23 <= arg_96_1.time_ and arg_96_1.time_ < var_99_23 + var_99_24 then
				local var_99_25 = (arg_96_1.time_ - var_99_23) / var_99_24
				local var_99_26 = Color.New(0, 0, 0)

				var_99_26.a = Mathf.Lerp(1, 0, var_99_25)
				arg_96_1.mask_.color = var_99_26
			end

			if arg_96_1.time_ >= var_99_23 + var_99_24 and arg_96_1.time_ < var_99_23 + var_99_24 + arg_99_0 then
				local var_99_27 = Color.New(0, 0, 0)
				local var_99_28 = 0

				arg_96_1.mask_.enabled = false
				var_99_27.a = var_99_28
				arg_96_1.mask_.color = var_99_27
			end

			local var_99_29 = arg_96_1.actors_["10166ui_story"].transform
			local var_99_30 = 1.96599999815226

			if var_99_30 < arg_96_1.time_ and arg_96_1.time_ <= var_99_30 + arg_99_0 then
				arg_96_1.var_.moveOldPos10166ui_story = var_99_29.localPosition

				local var_99_31 = GameObjectTools.GetOrAddComponent(var_99_29.gameObject, typeof(DynamicBoneHelper))

				if var_99_31 then
					var_99_31:EnableDynamicBone(false)
				end
			end

			local var_99_32 = 0.001

			if var_99_30 <= arg_96_1.time_ and arg_96_1.time_ < var_99_30 + var_99_32 then
				local var_99_33 = (arg_96_1.time_ - var_99_30) / var_99_32
				local var_99_34 = Vector3.New(0, 100, 0)

				var_99_29.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10166ui_story, var_99_34, var_99_33)

				local var_99_35 = manager.ui.mainCamera.transform.position - var_99_29.position

				var_99_29.forward = Vector3.New(var_99_35.x, var_99_35.y, var_99_35.z)

				local var_99_36 = var_99_29.localEulerAngles

				var_99_36.z = 0
				var_99_36.x = 0
				var_99_29.localEulerAngles = var_99_36
			end

			if arg_96_1.time_ >= var_99_30 + var_99_32 and arg_96_1.time_ < var_99_30 + var_99_32 + arg_99_0 then
				var_99_29.localPosition = Vector3.New(0, 100, 0)

				local var_99_37 = manager.ui.mainCamera.transform.position - var_99_29.position

				var_99_29.forward = Vector3.New(var_99_37.x, var_99_37.y, var_99_37.z)

				local var_99_38 = var_99_29.localEulerAngles

				var_99_38.z = 0
				var_99_38.x = 0
				var_99_29.localEulerAngles = var_99_38

				local var_99_39 = GameObjectTools.GetOrAddComponent(var_99_29.gameObject, typeof(DynamicBoneHelper))

				if var_99_39 then
					var_99_39:EnableDynamicBone(true)
				end
			end

			local var_99_40 = arg_96_1.actors_["10162ui_story"].transform
			local var_99_41 = 1.96599999815226

			if var_99_41 < arg_96_1.time_ and arg_96_1.time_ <= var_99_41 + arg_99_0 then
				arg_96_1.var_.moveOldPos10162ui_story = var_99_40.localPosition

				local var_99_42 = GameObjectTools.GetOrAddComponent(var_99_40.gameObject, typeof(DynamicBoneHelper))

				if var_99_42 then
					var_99_42:EnableDynamicBone(false)
				end
			end

			local var_99_43 = 0.001

			if var_99_41 <= arg_96_1.time_ and arg_96_1.time_ < var_99_41 + var_99_43 then
				local var_99_44 = (arg_96_1.time_ - var_99_41) / var_99_43
				local var_99_45 = Vector3.New(0, 100, 0)

				var_99_40.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10162ui_story, var_99_45, var_99_44)

				local var_99_46 = manager.ui.mainCamera.transform.position - var_99_40.position

				var_99_40.forward = Vector3.New(var_99_46.x, var_99_46.y, var_99_46.z)

				local var_99_47 = var_99_40.localEulerAngles

				var_99_47.z = 0
				var_99_47.x = 0
				var_99_40.localEulerAngles = var_99_47
			end

			if arg_96_1.time_ >= var_99_41 + var_99_43 and arg_96_1.time_ < var_99_41 + var_99_43 + arg_99_0 then
				var_99_40.localPosition = Vector3.New(0, 100, 0)

				local var_99_48 = manager.ui.mainCamera.transform.position - var_99_40.position

				var_99_40.forward = Vector3.New(var_99_48.x, var_99_48.y, var_99_48.z)

				local var_99_49 = var_99_40.localEulerAngles

				var_99_49.z = 0
				var_99_49.x = 0
				var_99_40.localEulerAngles = var_99_49

				local var_99_50 = GameObjectTools.GetOrAddComponent(var_99_40.gameObject, typeof(DynamicBoneHelper))

				if var_99_50 then
					var_99_50:EnableDynamicBone(true)
				end
			end

			local var_99_51 = arg_96_1.actors_["10166ui_story"]
			local var_99_52 = 1.96599999815226

			if var_99_52 < arg_96_1.time_ and arg_96_1.time_ <= var_99_52 + arg_99_0 and not isNil(var_99_51) and arg_96_1.var_.characterEffect10166ui_story == nil then
				arg_96_1.var_.characterEffect10166ui_story = var_99_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_53 = 0.034000001847744

			if var_99_52 <= arg_96_1.time_ and arg_96_1.time_ < var_99_52 + var_99_53 and not isNil(var_99_51) then
				local var_99_54 = (arg_96_1.time_ - var_99_52) / var_99_53

				if arg_96_1.var_.characterEffect10166ui_story and not isNil(var_99_51) then
					local var_99_55 = Mathf.Lerp(0, 0.5, var_99_54)

					arg_96_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_96_1.var_.characterEffect10166ui_story.fillRatio = var_99_55
				end
			end

			if arg_96_1.time_ >= var_99_52 + var_99_53 and arg_96_1.time_ < var_99_52 + var_99_53 + arg_99_0 and not isNil(var_99_51) and arg_96_1.var_.characterEffect10166ui_story then
				local var_99_56 = 0.5

				arg_96_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_96_1.var_.characterEffect10166ui_story.fillRatio = var_99_56
			end

			local var_99_57 = arg_96_1.bgs_.J26h.transform
			local var_99_58 = 2

			if var_99_58 < arg_96_1.time_ and arg_96_1.time_ <= var_99_58 + arg_99_0 then
				arg_96_1.var_.moveOldPosJ26h = var_99_57.localPosition
			end

			local var_99_59 = 2.4

			if var_99_58 <= arg_96_1.time_ and arg_96_1.time_ < var_99_58 + var_99_59 then
				local var_99_60 = (arg_96_1.time_ - var_99_58) / var_99_59
				local var_99_61 = Vector3.New(0, 1, 9.5)

				var_99_57.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPosJ26h, var_99_61, var_99_60)
			end

			if arg_96_1.time_ >= var_99_58 + var_99_59 and arg_96_1.time_ < var_99_58 + var_99_59 + arg_99_0 then
				var_99_57.localPosition = Vector3.New(0, 1, 9.5)
			end

			if arg_96_1.frameCnt_ <= 1 then
				arg_96_1.dialog_:SetActive(false)
			end

			local var_99_62 = 3.999999999999
			local var_99_63 = 1.675

			if var_99_62 < arg_96_1.time_ and arg_96_1.time_ <= var_99_62 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0

				arg_96_1.dialog_:SetActive(true)

				arg_96_1.dialogCg_.alpha = 0

				local var_99_64 = LeanTween.value(arg_96_1.dialog_, 0, 1, 0.3)

				var_99_64:setOnUpdate(LuaHelper.FloatAction(function(arg_100_0)
					arg_96_1.dialogCg_.alpha = arg_100_0
				end))
				var_99_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_96_1.dialog_)
					var_99_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_96_1.duration_ = arg_96_1.duration_ + 0.3

				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_65 = arg_96_1:GetWordFromCfg(325581024)
				local var_99_66 = arg_96_1:FormatText(var_99_65.content)

				arg_96_1.text_.text = var_99_66

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_67 = 67
				local var_99_68 = utf8.len(var_99_66)
				local var_99_69 = var_99_67 <= 0 and var_99_63 or var_99_63 * (var_99_68 / var_99_67)

				if var_99_69 > 0 and var_99_63 < var_99_69 then
					arg_96_1.talkMaxDuration = var_99_69
					var_99_62 = var_99_62 + 0.3

					if var_99_69 + var_99_62 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_69 + var_99_62
					end
				end

				arg_96_1.text_.text = var_99_66
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_70 = var_99_62 + 0.3
			local var_99_71 = math.max(var_99_63, arg_96_1.talkMaxDuration)

			if var_99_70 <= arg_96_1.time_ and arg_96_1.time_ < var_99_70 + var_99_71 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_70) / var_99_71

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_70 + var_99_71 and arg_96_1.time_ < var_99_70 + var_99_71 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
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
				actorName = "J26h",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.4,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play325581025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325581025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play325581026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 1.075

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_2 = arg_102_1:GetWordFromCfg(325581025)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 43
				local var_105_5 = utf8.len(var_105_3)
				local var_105_6 = var_105_4 <= 0 and var_105_1 or var_105_1 * (var_105_5 / var_105_4)

				if var_105_6 > 0 and var_105_1 < var_105_6 then
					arg_102_1.talkMaxDuration = var_105_6

					if var_105_6 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_7 and arg_102_1.time_ < var_105_0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325581026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325581026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play325581027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 1.375

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_2 = arg_106_1:GetWordFromCfg(325581026)
				local var_109_3 = arg_106_1:FormatText(var_109_2.content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 55
				local var_109_5 = utf8.len(var_109_3)
				local var_109_6 = var_109_4 <= 0 and var_109_1 or var_109_1 * (var_109_5 / var_109_4)

				if var_109_6 > 0 and var_109_1 < var_109_6 then
					arg_106_1.talkMaxDuration = var_109_6

					if var_109_6 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_7 and arg_106_1.time_ < var_109_0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play325581027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325581027
		arg_110_1.duration_ = 4.57

		local var_110_0 = {
			zh = 3.9,
			ja = 4.566
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play325581028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = "10167ui_story"

			if arg_110_1.actors_[var_113_0] == nil then
				local var_113_1 = Asset.Load("Char/" .. "10167ui_story")

				if not isNil(var_113_1) then
					local var_113_2 = Object.Instantiate(Asset.Load("Char/" .. "10167ui_story"), arg_110_1.stage_.transform)

					var_113_2.name = var_113_0
					var_113_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_110_1.actors_[var_113_0] = var_113_2

					local var_113_3 = var_113_2:GetComponentInChildren(typeof(CharacterEffect))

					var_113_3.enabled = true

					local var_113_4 = GameObjectTools.GetOrAddComponent(var_113_2, typeof(DynamicBoneHelper))

					if var_113_4 then
						var_113_4:EnableDynamicBone(false)
					end

					arg_110_1:ShowWeapon(var_113_3.transform, false)

					arg_110_1.var_[var_113_0 .. "Animator"] = var_113_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_110_1.var_[var_113_0 .. "Animator"].applyRootMotion = true
					arg_110_1.var_[var_113_0 .. "LipSync"] = var_113_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_113_5 = arg_110_1.actors_["10167ui_story"].transform
			local var_113_6 = 0

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.var_.moveOldPos10167ui_story = var_113_5.localPosition

				local var_113_7 = GameObjectTools.GetOrAddComponent(var_113_5.gameObject, typeof(DynamicBoneHelper))

				if var_113_7 then
					var_113_7:EnableDynamicBone(false)
				end
			end

			local var_113_8 = 0.001

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_8 then
				local var_113_9 = (arg_110_1.time_ - var_113_6) / var_113_8
				local var_113_10 = Vector3.New(0, -1.28, -5.73)

				var_113_5.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10167ui_story, var_113_10, var_113_9)

				local var_113_11 = manager.ui.mainCamera.transform.position - var_113_5.position

				var_113_5.forward = Vector3.New(var_113_11.x, var_113_11.y, var_113_11.z)

				local var_113_12 = var_113_5.localEulerAngles

				var_113_12.z = 0
				var_113_12.x = 0
				var_113_5.localEulerAngles = var_113_12
			end

			if arg_110_1.time_ >= var_113_6 + var_113_8 and arg_110_1.time_ < var_113_6 + var_113_8 + arg_113_0 then
				var_113_5.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_113_13 = manager.ui.mainCamera.transform.position - var_113_5.position

				var_113_5.forward = Vector3.New(var_113_13.x, var_113_13.y, var_113_13.z)

				local var_113_14 = var_113_5.localEulerAngles

				var_113_14.z = 0
				var_113_14.x = 0
				var_113_5.localEulerAngles = var_113_14

				local var_113_15 = GameObjectTools.GetOrAddComponent(var_113_5.gameObject, typeof(DynamicBoneHelper))

				if var_113_15 then
					var_113_15:EnableDynamicBone(true)
				end
			end

			local var_113_16 = arg_110_1.actors_["10167ui_story"]
			local var_113_17 = 0

			if var_113_17 < arg_110_1.time_ and arg_110_1.time_ <= var_113_17 + arg_113_0 and not isNil(var_113_16) and arg_110_1.var_.characterEffect10167ui_story == nil then
				arg_110_1.var_.characterEffect10167ui_story = var_113_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_18 = 0.200000002980232

			if var_113_17 <= arg_110_1.time_ and arg_110_1.time_ < var_113_17 + var_113_18 and not isNil(var_113_16) then
				local var_113_19 = (arg_110_1.time_ - var_113_17) / var_113_18

				if arg_110_1.var_.characterEffect10167ui_story and not isNil(var_113_16) then
					arg_110_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_17 + var_113_18 and arg_110_1.time_ < var_113_17 + var_113_18 + arg_113_0 and not isNil(var_113_16) and arg_110_1.var_.characterEffect10167ui_story then
				arg_110_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_113_20 = 0

			if var_113_20 < arg_110_1.time_ and arg_110_1.time_ <= var_113_20 + arg_113_0 then
				arg_110_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			local var_113_21 = 0

			if var_113_21 < arg_110_1.time_ and arg_110_1.time_ <= var_113_21 + arg_113_0 then
				arg_110_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_113_22 = 0
			local var_113_23 = 0.425

			if var_113_22 < arg_110_1.time_ and arg_110_1.time_ <= var_113_22 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_24 = arg_110_1:FormatText(StoryNameCfg[1447].name)

				arg_110_1.leftNameTxt_.text = var_113_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_25 = arg_110_1:GetWordFromCfg(325581027)
				local var_113_26 = arg_110_1:FormatText(var_113_25.content)

				arg_110_1.text_.text = var_113_26

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_27 = 17
				local var_113_28 = utf8.len(var_113_26)
				local var_113_29 = var_113_27 <= 0 and var_113_23 or var_113_23 * (var_113_28 / var_113_27)

				if var_113_29 > 0 and var_113_23 < var_113_29 then
					arg_110_1.talkMaxDuration = var_113_29

					if var_113_29 + var_113_22 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_29 + var_113_22
					end
				end

				arg_110_1.text_.text = var_113_26
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581027", "story_v_out_325581.awb") ~= 0 then
					local var_113_30 = manager.audio:GetVoiceLength("story_v_out_325581", "325581027", "story_v_out_325581.awb") / 1000

					if var_113_30 + var_113_22 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_30 + var_113_22
					end

					if var_113_25.prefab_name ~= "" and arg_110_1.actors_[var_113_25.prefab_name] ~= nil then
						local var_113_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_25.prefab_name].transform, "story_v_out_325581", "325581027", "story_v_out_325581.awb")

						arg_110_1:RecordAudio("325581027", var_113_31)
						arg_110_1:RecordAudio("325581027", var_113_31)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_325581", "325581027", "story_v_out_325581.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_325581", "325581027", "story_v_out_325581.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_32 = math.max(var_113_23, arg_110_1.talkMaxDuration)

			if var_113_22 <= arg_110_1.time_ and arg_110_1.time_ < var_113_22 + var_113_32 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_22) / var_113_32

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_22 + var_113_32 and arg_110_1.time_ < var_113_22 + var_113_32 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play325581028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325581028
		arg_114_1.duration_ = 3.57

		local var_114_0 = {
			zh = 1.999999999999,
			ja = 3.566
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
				arg_114_0:Play325581029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["10167ui_story"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos10167ui_story = var_117_0.localPosition

				local var_117_2 = GameObjectTools.GetOrAddComponent(var_117_0.gameObject, typeof(DynamicBoneHelper))

				if var_117_2 then
					var_117_2:EnableDynamicBone(false)
				end
			end

			local var_117_3 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_3 then
				local var_117_4 = (arg_114_1.time_ - var_117_1) / var_117_3
				local var_117_5 = Vector3.New(-0.96, -1.28, -5.73)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10167ui_story, var_117_5, var_117_4)

				local var_117_6 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_6.x, var_117_6.y, var_117_6.z)

				local var_117_7 = var_117_0.localEulerAngles

				var_117_7.z = 0
				var_117_7.x = 0
				var_117_0.localEulerAngles = var_117_7
			end

			if arg_114_1.time_ >= var_117_1 + var_117_3 and arg_114_1.time_ < var_117_1 + var_117_3 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(-0.96, -1.28, -5.73)

				local var_117_8 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_8.x, var_117_8.y, var_117_8.z)

				local var_117_9 = var_117_0.localEulerAngles

				var_117_9.z = 0
				var_117_9.x = 0
				var_117_0.localEulerAngles = var_117_9

				local var_117_10 = GameObjectTools.GetOrAddComponent(var_117_0.gameObject, typeof(DynamicBoneHelper))

				if var_117_10 then
					var_117_10:EnableDynamicBone(true)
				end
			end

			local var_117_11 = "10175ui_story"

			if arg_114_1.actors_[var_117_11] == nil then
				local var_117_12 = Asset.Load("Char/" .. "10175ui_story")

				if not isNil(var_117_12) then
					local var_117_13 = Object.Instantiate(Asset.Load("Char/" .. "10175ui_story"), arg_114_1.stage_.transform)

					var_117_13.name = var_117_11
					var_117_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_114_1.actors_[var_117_11] = var_117_13

					local var_117_14 = var_117_13:GetComponentInChildren(typeof(CharacterEffect))

					var_117_14.enabled = true

					local var_117_15 = GameObjectTools.GetOrAddComponent(var_117_13, typeof(DynamicBoneHelper))

					if var_117_15 then
						var_117_15:EnableDynamicBone(false)
					end

					arg_114_1:ShowWeapon(var_117_14.transform, false)

					arg_114_1.var_[var_117_11 .. "Animator"] = var_117_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_114_1.var_[var_117_11 .. "Animator"].applyRootMotion = true
					arg_114_1.var_[var_117_11 .. "LipSync"] = var_117_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_117_16 = arg_114_1.actors_["10175ui_story"].transform
			local var_117_17 = 0

			if var_117_17 < arg_114_1.time_ and arg_114_1.time_ <= var_117_17 + arg_117_0 then
				arg_114_1.var_.moveOldPos10175ui_story = var_117_16.localPosition

				local var_117_18 = GameObjectTools.GetOrAddComponent(var_117_16.gameObject, typeof(DynamicBoneHelper))

				if var_117_18 then
					var_117_18:EnableDynamicBone(false)
				end
			end

			local var_117_19 = 0.001

			if var_117_17 <= arg_114_1.time_ and arg_114_1.time_ < var_117_17 + var_117_19 then
				local var_117_20 = (arg_114_1.time_ - var_117_17) / var_117_19
				local var_117_21 = Vector3.New(0.7, -1, -6.05)

				var_117_16.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10175ui_story, var_117_21, var_117_20)

				local var_117_22 = manager.ui.mainCamera.transform.position - var_117_16.position

				var_117_16.forward = Vector3.New(var_117_22.x, var_117_22.y, var_117_22.z)

				local var_117_23 = var_117_16.localEulerAngles

				var_117_23.z = 0
				var_117_23.x = 0
				var_117_16.localEulerAngles = var_117_23
			end

			if arg_114_1.time_ >= var_117_17 + var_117_19 and arg_114_1.time_ < var_117_17 + var_117_19 + arg_117_0 then
				var_117_16.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_117_24 = manager.ui.mainCamera.transform.position - var_117_16.position

				var_117_16.forward = Vector3.New(var_117_24.x, var_117_24.y, var_117_24.z)

				local var_117_25 = var_117_16.localEulerAngles

				var_117_25.z = 0
				var_117_25.x = 0
				var_117_16.localEulerAngles = var_117_25

				local var_117_26 = GameObjectTools.GetOrAddComponent(var_117_16.gameObject, typeof(DynamicBoneHelper))

				if var_117_26 then
					var_117_26:EnableDynamicBone(true)
				end
			end

			local var_117_27 = arg_114_1.actors_["10175ui_story"]
			local var_117_28 = 0

			if var_117_28 < arg_114_1.time_ and arg_114_1.time_ <= var_117_28 + arg_117_0 and not isNil(var_117_27) and arg_114_1.var_.characterEffect10175ui_story == nil then
				arg_114_1.var_.characterEffect10175ui_story = var_117_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_29 = 0.200000002980232

			if var_117_28 <= arg_114_1.time_ and arg_114_1.time_ < var_117_28 + var_117_29 and not isNil(var_117_27) then
				local var_117_30 = (arg_114_1.time_ - var_117_28) / var_117_29

				if arg_114_1.var_.characterEffect10175ui_story and not isNil(var_117_27) then
					arg_114_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_28 + var_117_29 and arg_114_1.time_ < var_117_28 + var_117_29 + arg_117_0 and not isNil(var_117_27) and arg_114_1.var_.characterEffect10175ui_story then
				arg_114_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_117_31 = arg_114_1.actors_["10167ui_story"]
			local var_117_32 = 0

			if var_117_32 < arg_114_1.time_ and arg_114_1.time_ <= var_117_32 + arg_117_0 and not isNil(var_117_31) and arg_114_1.var_.characterEffect10167ui_story == nil then
				arg_114_1.var_.characterEffect10167ui_story = var_117_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_33 = 0.200000002980232

			if var_117_32 <= arg_114_1.time_ and arg_114_1.time_ < var_117_32 + var_117_33 and not isNil(var_117_31) then
				local var_117_34 = (arg_114_1.time_ - var_117_32) / var_117_33

				if arg_114_1.var_.characterEffect10167ui_story and not isNil(var_117_31) then
					local var_117_35 = Mathf.Lerp(0, 0.5, var_117_34)

					arg_114_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_114_1.var_.characterEffect10167ui_story.fillRatio = var_117_35
				end
			end

			if arg_114_1.time_ >= var_117_32 + var_117_33 and arg_114_1.time_ < var_117_32 + var_117_33 + arg_117_0 and not isNil(var_117_31) and arg_114_1.var_.characterEffect10167ui_story then
				local var_117_36 = 0.5

				arg_114_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_114_1.var_.characterEffect10167ui_story.fillRatio = var_117_36
			end

			local var_117_37 = 0

			if var_117_37 < arg_114_1.time_ and arg_114_1.time_ <= var_117_37 + arg_117_0 then
				arg_114_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_117_38 = 0

			if var_117_38 < arg_114_1.time_ and arg_114_1.time_ <= var_117_38 + arg_117_0 then
				arg_114_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_117_39 = 0
			local var_117_40 = 0.2

			if var_117_39 < arg_114_1.time_ and arg_114_1.time_ <= var_117_39 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_41 = arg_114_1:FormatText(StoryNameCfg[1473].name)

				arg_114_1.leftNameTxt_.text = var_117_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_42 = arg_114_1:GetWordFromCfg(325581028)
				local var_117_43 = arg_114_1:FormatText(var_117_42.content)

				arg_114_1.text_.text = var_117_43

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_44 = 8
				local var_117_45 = utf8.len(var_117_43)
				local var_117_46 = var_117_44 <= 0 and var_117_40 or var_117_40 * (var_117_45 / var_117_44)

				if var_117_46 > 0 and var_117_40 < var_117_46 then
					arg_114_1.talkMaxDuration = var_117_46

					if var_117_46 + var_117_39 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_46 + var_117_39
					end
				end

				arg_114_1.text_.text = var_117_43
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581028", "story_v_out_325581.awb") ~= 0 then
					local var_117_47 = manager.audio:GetVoiceLength("story_v_out_325581", "325581028", "story_v_out_325581.awb") / 1000

					if var_117_47 + var_117_39 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_47 + var_117_39
					end

					if var_117_42.prefab_name ~= "" and arg_114_1.actors_[var_117_42.prefab_name] ~= nil then
						local var_117_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_42.prefab_name].transform, "story_v_out_325581", "325581028", "story_v_out_325581.awb")

						arg_114_1:RecordAudio("325581028", var_117_48)
						arg_114_1:RecordAudio("325581028", var_117_48)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_325581", "325581028", "story_v_out_325581.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_325581", "325581028", "story_v_out_325581.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_49 = math.max(var_117_40, arg_114_1.talkMaxDuration)

			if var_117_39 <= arg_114_1.time_ and arg_114_1.time_ < var_117_39 + var_117_49 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_39) / var_117_49

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_39 + var_117_49 and arg_114_1.time_ < var_117_39 + var_117_49 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
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

		arg_114_1:InitPlayNodeList()
	end,
	Play325581029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325581029
		arg_118_1.duration_ = 7.8

		local var_118_0 = {
			zh = 6,
			ja = 7.8
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play325581030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["10167ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect10167ui_story == nil then
				arg_118_1.var_.characterEffect10167ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect10167ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect10167ui_story then
				arg_118_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["10175ui_story"]
			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect10175ui_story == nil then
				arg_118_1.var_.characterEffect10175ui_story = var_121_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.200000002980232

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 and not isNil(var_121_4) then
				local var_121_7 = (arg_118_1.time_ - var_121_5) / var_121_6

				if arg_118_1.var_.characterEffect10175ui_story and not isNil(var_121_4) then
					local var_121_8 = Mathf.Lerp(0, 0.5, var_121_7)

					arg_118_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_118_1.var_.characterEffect10175ui_story.fillRatio = var_121_8
				end
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect10175ui_story then
				local var_121_9 = 0.5

				arg_118_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_118_1.var_.characterEffect10175ui_story.fillRatio = var_121_9
			end

			local var_121_10 = 0
			local var_121_11 = 0.65

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_12 = arg_118_1:FormatText(StoryNameCfg[1447].name)

				arg_118_1.leftNameTxt_.text = var_121_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_13 = arg_118_1:GetWordFromCfg(325581029)
				local var_121_14 = arg_118_1:FormatText(var_121_13.content)

				arg_118_1.text_.text = var_121_14

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_15 = 26
				local var_121_16 = utf8.len(var_121_14)
				local var_121_17 = var_121_15 <= 0 and var_121_11 or var_121_11 * (var_121_16 / var_121_15)

				if var_121_17 > 0 and var_121_11 < var_121_17 then
					arg_118_1.talkMaxDuration = var_121_17

					if var_121_17 + var_121_10 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_17 + var_121_10
					end
				end

				arg_118_1.text_.text = var_121_14
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581029", "story_v_out_325581.awb") ~= 0 then
					local var_121_18 = manager.audio:GetVoiceLength("story_v_out_325581", "325581029", "story_v_out_325581.awb") / 1000

					if var_121_18 + var_121_10 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_18 + var_121_10
					end

					if var_121_13.prefab_name ~= "" and arg_118_1.actors_[var_121_13.prefab_name] ~= nil then
						local var_121_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_13.prefab_name].transform, "story_v_out_325581", "325581029", "story_v_out_325581.awb")

						arg_118_1:RecordAudio("325581029", var_121_19)
						arg_118_1:RecordAudio("325581029", var_121_19)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_325581", "325581029", "story_v_out_325581.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_325581", "325581029", "story_v_out_325581.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_20 = math.max(var_121_11, arg_118_1.talkMaxDuration)

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_20 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_10) / var_121_20

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_10 + var_121_20 and arg_118_1.time_ < var_121_10 + var_121_20 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play325581030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325581030
		arg_122_1.duration_ = 6.2

		local var_122_0 = {
			zh = 5.1,
			ja = 6.2
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
				arg_122_0:Play325581031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["10175ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect10175ui_story == nil then
				arg_122_1.var_.characterEffect10175ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect10175ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect10175ui_story then
				arg_122_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_125_4 = arg_122_1.actors_["10167ui_story"]
			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect10167ui_story == nil then
				arg_122_1.var_.characterEffect10167ui_story = var_125_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_6 = 0.200000002980232

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_6 and not isNil(var_125_4) then
				local var_125_7 = (arg_122_1.time_ - var_125_5) / var_125_6

				if arg_122_1.var_.characterEffect10167ui_story and not isNil(var_125_4) then
					local var_125_8 = Mathf.Lerp(0, 0.5, var_125_7)

					arg_122_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_122_1.var_.characterEffect10167ui_story.fillRatio = var_125_8
				end
			end

			if arg_122_1.time_ >= var_125_5 + var_125_6 and arg_122_1.time_ < var_125_5 + var_125_6 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect10167ui_story then
				local var_125_9 = 0.5

				arg_122_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_122_1.var_.characterEffect10167ui_story.fillRatio = var_125_9
			end

			local var_125_10 = 0
			local var_125_11 = 0.6

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_12 = arg_122_1:FormatText(StoryNameCfg[1473].name)

				arg_122_1.leftNameTxt_.text = var_125_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_13 = arg_122_1:GetWordFromCfg(325581030)
				local var_125_14 = arg_122_1:FormatText(var_125_13.content)

				arg_122_1.text_.text = var_125_14

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_15 = 24
				local var_125_16 = utf8.len(var_125_14)
				local var_125_17 = var_125_15 <= 0 and var_125_11 or var_125_11 * (var_125_16 / var_125_15)

				if var_125_17 > 0 and var_125_11 < var_125_17 then
					arg_122_1.talkMaxDuration = var_125_17

					if var_125_17 + var_125_10 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_17 + var_125_10
					end
				end

				arg_122_1.text_.text = var_125_14
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581030", "story_v_out_325581.awb") ~= 0 then
					local var_125_18 = manager.audio:GetVoiceLength("story_v_out_325581", "325581030", "story_v_out_325581.awb") / 1000

					if var_125_18 + var_125_10 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_18 + var_125_10
					end

					if var_125_13.prefab_name ~= "" and arg_122_1.actors_[var_125_13.prefab_name] ~= nil then
						local var_125_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_13.prefab_name].transform, "story_v_out_325581", "325581030", "story_v_out_325581.awb")

						arg_122_1:RecordAudio("325581030", var_125_19)
						arg_122_1:RecordAudio("325581030", var_125_19)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_325581", "325581030", "story_v_out_325581.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_325581", "325581030", "story_v_out_325581.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_20 = math.max(var_125_11, arg_122_1.talkMaxDuration)

			if var_125_10 <= arg_122_1.time_ and arg_122_1.time_ < var_125_10 + var_125_20 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_10) / var_125_20

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_10 + var_125_20 and arg_122_1.time_ < var_125_10 + var_125_20 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play325581031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325581031
		arg_126_1.duration_ = 4.27

		local var_126_0 = {
			zh = 3.3,
			ja = 4.266
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play325581032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["10175ui_story"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos10175ui_story = var_129_0.localPosition

				local var_129_2 = GameObjectTools.GetOrAddComponent(var_129_0.gameObject, typeof(DynamicBoneHelper))

				if var_129_2 then
					var_129_2:EnableDynamicBone(false)
				end
			end

			local var_129_3 = 0.001

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_3 then
				local var_129_4 = (arg_126_1.time_ - var_129_1) / var_129_3
				local var_129_5 = Vector3.New(0, 100, 0)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10175ui_story, var_129_5, var_129_4)

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

			local var_129_11 = "10176ui_story"

			if arg_126_1.actors_[var_129_11] == nil then
				local var_129_12 = Asset.Load("Char/" .. "10176ui_story")

				if not isNil(var_129_12) then
					local var_129_13 = Object.Instantiate(Asset.Load("Char/" .. "10176ui_story"), arg_126_1.stage_.transform)

					var_129_13.name = var_129_11
					var_129_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_126_1.actors_[var_129_11] = var_129_13

					local var_129_14 = var_129_13:GetComponentInChildren(typeof(CharacterEffect))

					var_129_14.enabled = true

					local var_129_15 = GameObjectTools.GetOrAddComponent(var_129_13, typeof(DynamicBoneHelper))

					if var_129_15 then
						var_129_15:EnableDynamicBone(false)
					end

					arg_126_1:ShowWeapon(var_129_14.transform, false)

					arg_126_1.var_[var_129_11 .. "Animator"] = var_129_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_126_1.var_[var_129_11 .. "Animator"].applyRootMotion = true
					arg_126_1.var_[var_129_11 .. "LipSync"] = var_129_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_129_16 = arg_126_1.actors_["10176ui_story"].transform
			local var_129_17 = 0

			if var_129_17 < arg_126_1.time_ and arg_126_1.time_ <= var_129_17 + arg_129_0 then
				arg_126_1.var_.moveOldPos10176ui_story = var_129_16.localPosition

				local var_129_18 = GameObjectTools.GetOrAddComponent(var_129_16.gameObject, typeof(DynamicBoneHelper))

				if var_129_18 then
					var_129_18:EnableDynamicBone(false)
				end
			end

			local var_129_19 = 0.001

			if var_129_17 <= arg_126_1.time_ and arg_126_1.time_ < var_129_17 + var_129_19 then
				local var_129_20 = (arg_126_1.time_ - var_129_17) / var_129_19
				local var_129_21 = Vector3.New(-0.02, -1.09, -6.12)

				var_129_16.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10176ui_story, var_129_21, var_129_20)

				local var_129_22 = manager.ui.mainCamera.transform.position - var_129_16.position

				var_129_16.forward = Vector3.New(var_129_22.x, var_129_22.y, var_129_22.z)

				local var_129_23 = var_129_16.localEulerAngles

				var_129_23.z = 0
				var_129_23.x = 0
				var_129_16.localEulerAngles = var_129_23
			end

			if arg_126_1.time_ >= var_129_17 + var_129_19 and arg_126_1.time_ < var_129_17 + var_129_19 + arg_129_0 then
				var_129_16.localPosition = Vector3.New(-0.02, -1.09, -6.12)

				local var_129_24 = manager.ui.mainCamera.transform.position - var_129_16.position

				var_129_16.forward = Vector3.New(var_129_24.x, var_129_24.y, var_129_24.z)

				local var_129_25 = var_129_16.localEulerAngles

				var_129_25.z = 0
				var_129_25.x = 0
				var_129_16.localEulerAngles = var_129_25

				local var_129_26 = GameObjectTools.GetOrAddComponent(var_129_16.gameObject, typeof(DynamicBoneHelper))

				if var_129_26 then
					var_129_26:EnableDynamicBone(true)
				end
			end

			local var_129_27 = arg_126_1.actors_["10167ui_story"].transform
			local var_129_28 = 0

			if var_129_28 < arg_126_1.time_ and arg_126_1.time_ <= var_129_28 + arg_129_0 then
				arg_126_1.var_.moveOldPos10167ui_story = var_129_27.localPosition

				local var_129_29 = GameObjectTools.GetOrAddComponent(var_129_27.gameObject, typeof(DynamicBoneHelper))

				if var_129_29 then
					var_129_29:EnableDynamicBone(false)
				end
			end

			local var_129_30 = 0.001

			if var_129_28 <= arg_126_1.time_ and arg_126_1.time_ < var_129_28 + var_129_30 then
				local var_129_31 = (arg_126_1.time_ - var_129_28) / var_129_30
				local var_129_32 = Vector3.New(0, 100, 0)

				var_129_27.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10167ui_story, var_129_32, var_129_31)

				local var_129_33 = manager.ui.mainCamera.transform.position - var_129_27.position

				var_129_27.forward = Vector3.New(var_129_33.x, var_129_33.y, var_129_33.z)

				local var_129_34 = var_129_27.localEulerAngles

				var_129_34.z = 0
				var_129_34.x = 0
				var_129_27.localEulerAngles = var_129_34
			end

			if arg_126_1.time_ >= var_129_28 + var_129_30 and arg_126_1.time_ < var_129_28 + var_129_30 + arg_129_0 then
				var_129_27.localPosition = Vector3.New(0, 100, 0)

				local var_129_35 = manager.ui.mainCamera.transform.position - var_129_27.position

				var_129_27.forward = Vector3.New(var_129_35.x, var_129_35.y, var_129_35.z)

				local var_129_36 = var_129_27.localEulerAngles

				var_129_36.z = 0
				var_129_36.x = 0
				var_129_27.localEulerAngles = var_129_36

				local var_129_37 = GameObjectTools.GetOrAddComponent(var_129_27.gameObject, typeof(DynamicBoneHelper))

				if var_129_37 then
					var_129_37:EnableDynamicBone(true)
				end
			end

			local var_129_38 = arg_126_1.actors_["10176ui_story"]
			local var_129_39 = 0

			if var_129_39 < arg_126_1.time_ and arg_126_1.time_ <= var_129_39 + arg_129_0 and not isNil(var_129_38) and arg_126_1.var_.characterEffect10176ui_story == nil then
				arg_126_1.var_.characterEffect10176ui_story = var_129_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_40 = 0.200000002980232

			if var_129_39 <= arg_126_1.time_ and arg_126_1.time_ < var_129_39 + var_129_40 and not isNil(var_129_38) then
				local var_129_41 = (arg_126_1.time_ - var_129_39) / var_129_40

				if arg_126_1.var_.characterEffect10176ui_story and not isNil(var_129_38) then
					arg_126_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_39 + var_129_40 and arg_126_1.time_ < var_129_39 + var_129_40 + arg_129_0 and not isNil(var_129_38) and arg_126_1.var_.characterEffect10176ui_story then
				arg_126_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_129_42 = arg_126_1.actors_["10175ui_story"]
			local var_129_43 = 0

			if var_129_43 < arg_126_1.time_ and arg_126_1.time_ <= var_129_43 + arg_129_0 and not isNil(var_129_42) and arg_126_1.var_.characterEffect10175ui_story == nil then
				arg_126_1.var_.characterEffect10175ui_story = var_129_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_44 = 0.200000002980232

			if var_129_43 <= arg_126_1.time_ and arg_126_1.time_ < var_129_43 + var_129_44 and not isNil(var_129_42) then
				local var_129_45 = (arg_126_1.time_ - var_129_43) / var_129_44

				if arg_126_1.var_.characterEffect10175ui_story and not isNil(var_129_42) then
					local var_129_46 = Mathf.Lerp(0, 0.5, var_129_45)

					arg_126_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10175ui_story.fillRatio = var_129_46
				end
			end

			if arg_126_1.time_ >= var_129_43 + var_129_44 and arg_126_1.time_ < var_129_43 + var_129_44 + arg_129_0 and not isNil(var_129_42) and arg_126_1.var_.characterEffect10175ui_story then
				local var_129_47 = 0.5

				arg_126_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10175ui_story.fillRatio = var_129_47
			end

			local var_129_48 = 0

			if var_129_48 < arg_126_1.time_ and arg_126_1.time_ <= var_129_48 + arg_129_0 then
				arg_126_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action1_1")
			end

			local var_129_49 = 0

			if var_129_49 < arg_126_1.time_ and arg_126_1.time_ <= var_129_49 + arg_129_0 then
				arg_126_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_129_50 = 0
			local var_129_51 = 0.25

			if var_129_50 < arg_126_1.time_ and arg_126_1.time_ <= var_129_50 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_52 = arg_126_1:FormatText(StoryNameCfg[1510].name)

				arg_126_1.leftNameTxt_.text = var_129_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_53 = arg_126_1:GetWordFromCfg(325581031)
				local var_129_54 = arg_126_1:FormatText(var_129_53.content)

				arg_126_1.text_.text = var_129_54

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_55 = 10
				local var_129_56 = utf8.len(var_129_54)
				local var_129_57 = var_129_55 <= 0 and var_129_51 or var_129_51 * (var_129_56 / var_129_55)

				if var_129_57 > 0 and var_129_51 < var_129_57 then
					arg_126_1.talkMaxDuration = var_129_57

					if var_129_57 + var_129_50 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_57 + var_129_50
					end
				end

				arg_126_1.text_.text = var_129_54
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581031", "story_v_out_325581.awb") ~= 0 then
					local var_129_58 = manager.audio:GetVoiceLength("story_v_out_325581", "325581031", "story_v_out_325581.awb") / 1000

					if var_129_58 + var_129_50 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_58 + var_129_50
					end

					if var_129_53.prefab_name ~= "" and arg_126_1.actors_[var_129_53.prefab_name] ~= nil then
						local var_129_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_53.prefab_name].transform, "story_v_out_325581", "325581031", "story_v_out_325581.awb")

						arg_126_1:RecordAudio("325581031", var_129_59)
						arg_126_1:RecordAudio("325581031", var_129_59)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_325581", "325581031", "story_v_out_325581.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_325581", "325581031", "story_v_out_325581.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_60 = math.max(var_129_51, arg_126_1.talkMaxDuration)

			if var_129_50 <= arg_126_1.time_ and arg_126_1.time_ < var_129_50 + var_129_60 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_50) / var_129_60

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_50 + var_129_60 and arg_126_1.time_ < var_129_50 + var_129_60 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
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
	Play325581032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325581032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play325581033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["10176ui_story"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos10176ui_story = var_133_0.localPosition

				local var_133_2 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_2 then
					var_133_2:EnableDynamicBone(false)
				end
			end

			local var_133_3 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_3 then
				local var_133_4 = (arg_130_1.time_ - var_133_1) / var_133_3
				local var_133_5 = Vector3.New(0, 100, 0)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10176ui_story, var_133_5, var_133_4)

				local var_133_6 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_6.x, var_133_6.y, var_133_6.z)

				local var_133_7 = var_133_0.localEulerAngles

				var_133_7.z = 0
				var_133_7.x = 0
				var_133_0.localEulerAngles = var_133_7
			end

			if arg_130_1.time_ >= var_133_1 + var_133_3 and arg_130_1.time_ < var_133_1 + var_133_3 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, 100, 0)

				local var_133_8 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_8.x, var_133_8.y, var_133_8.z)

				local var_133_9 = var_133_0.localEulerAngles

				var_133_9.z = 0
				var_133_9.x = 0
				var_133_0.localEulerAngles = var_133_9

				local var_133_10 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_10 then
					var_133_10:EnableDynamicBone(true)
				end
			end

			local var_133_11 = arg_130_1.actors_["10176ui_story"]
			local var_133_12 = 0

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 and not isNil(var_133_11) and arg_130_1.var_.characterEffect10176ui_story == nil then
				arg_130_1.var_.characterEffect10176ui_story = var_133_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_13 = 0.200000002980232

			if var_133_12 <= arg_130_1.time_ and arg_130_1.time_ < var_133_12 + var_133_13 and not isNil(var_133_11) then
				local var_133_14 = (arg_130_1.time_ - var_133_12) / var_133_13

				if arg_130_1.var_.characterEffect10176ui_story and not isNil(var_133_11) then
					local var_133_15 = Mathf.Lerp(0, 0.5, var_133_14)

					arg_130_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_130_1.var_.characterEffect10176ui_story.fillRatio = var_133_15
				end
			end

			if arg_130_1.time_ >= var_133_12 + var_133_13 and arg_130_1.time_ < var_133_12 + var_133_13 + arg_133_0 and not isNil(var_133_11) and arg_130_1.var_.characterEffect10176ui_story then
				local var_133_16 = 0.5

				arg_130_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_130_1.var_.characterEffect10176ui_story.fillRatio = var_133_16
			end

			local var_133_17 = 0
			local var_133_18 = 1.875

			if var_133_17 < arg_130_1.time_ and arg_130_1.time_ <= var_133_17 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_19 = arg_130_1:GetWordFromCfg(325581032)
				local var_133_20 = arg_130_1:FormatText(var_133_19.content)

				arg_130_1.text_.text = var_133_20

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_21 = 75
				local var_133_22 = utf8.len(var_133_20)
				local var_133_23 = var_133_21 <= 0 and var_133_18 or var_133_18 * (var_133_22 / var_133_21)

				if var_133_23 > 0 and var_133_18 < var_133_23 then
					arg_130_1.talkMaxDuration = var_133_23

					if var_133_23 + var_133_17 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_23 + var_133_17
					end
				end

				arg_130_1.text_.text = var_133_20
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_24 = math.max(var_133_18, arg_130_1.talkMaxDuration)

			if var_133_17 <= arg_130_1.time_ and arg_130_1.time_ < var_133_17 + var_133_24 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_17) / var_133_24

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_17 + var_133_24 and arg_130_1.time_ < var_133_17 + var_133_24 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play325581033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325581033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play325581034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.775

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_2 = arg_134_1:GetWordFromCfg(325581033)
				local var_137_3 = arg_134_1:FormatText(var_137_2.content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 31
				local var_137_5 = utf8.len(var_137_3)
				local var_137_6 = var_137_4 <= 0 and var_137_1 or var_137_1 * (var_137_5 / var_137_4)

				if var_137_6 > 0 and var_137_1 < var_137_6 then
					arg_134_1.talkMaxDuration = var_137_6

					if var_137_6 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_7 and arg_134_1.time_ < var_137_0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play325581034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325581034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play325581035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 0.55

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_2 = arg_138_1:GetWordFromCfg(325581034)
				local var_141_3 = arg_138_1:FormatText(var_141_2.content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 22
				local var_141_5 = utf8.len(var_141_3)
				local var_141_6 = var_141_4 <= 0 and var_141_1 or var_141_1 * (var_141_5 / var_141_4)

				if var_141_6 > 0 and var_141_1 < var_141_6 then
					arg_138_1.talkMaxDuration = var_141_6

					if var_141_6 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_7 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_7 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_7

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_7 and arg_138_1.time_ < var_141_0 + var_141_7 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play325581035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 325581035
		arg_142_1.duration_ = 7.23

		local var_142_0 = {
			zh = 6.433,
			ja = 7.233
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
				arg_142_0:Play325581036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["10175ui_story"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos10175ui_story = var_145_0.localPosition

				local var_145_2 = GameObjectTools.GetOrAddComponent(var_145_0.gameObject, typeof(DynamicBoneHelper))

				if var_145_2 then
					var_145_2:EnableDynamicBone(false)
				end
			end

			local var_145_3 = 0.001

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_3 then
				local var_145_4 = (arg_142_1.time_ - var_145_1) / var_145_3
				local var_145_5 = Vector3.New(0, -1, -6.05)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10175ui_story, var_145_5, var_145_4)

				local var_145_6 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_6.x, var_145_6.y, var_145_6.z)

				local var_145_7 = var_145_0.localEulerAngles

				var_145_7.z = 0
				var_145_7.x = 0
				var_145_0.localEulerAngles = var_145_7
			end

			if arg_142_1.time_ >= var_145_1 + var_145_3 and arg_142_1.time_ < var_145_1 + var_145_3 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_145_8 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_8.x, var_145_8.y, var_145_8.z)

				local var_145_9 = var_145_0.localEulerAngles

				var_145_9.z = 0
				var_145_9.x = 0
				var_145_0.localEulerAngles = var_145_9

				local var_145_10 = GameObjectTools.GetOrAddComponent(var_145_0.gameObject, typeof(DynamicBoneHelper))

				if var_145_10 then
					var_145_10:EnableDynamicBone(true)
				end
			end

			local var_145_11 = arg_142_1.actors_["10175ui_story"]
			local var_145_12 = 0

			if var_145_12 < arg_142_1.time_ and arg_142_1.time_ <= var_145_12 + arg_145_0 and not isNil(var_145_11) and arg_142_1.var_.characterEffect10175ui_story == nil then
				arg_142_1.var_.characterEffect10175ui_story = var_145_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_13 = 0.200000002980232

			if var_145_12 <= arg_142_1.time_ and arg_142_1.time_ < var_145_12 + var_145_13 and not isNil(var_145_11) then
				local var_145_14 = (arg_142_1.time_ - var_145_12) / var_145_13

				if arg_142_1.var_.characterEffect10175ui_story and not isNil(var_145_11) then
					arg_142_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_12 + var_145_13 and arg_142_1.time_ < var_145_12 + var_145_13 + arg_145_0 and not isNil(var_145_11) and arg_142_1.var_.characterEffect10175ui_story then
				arg_142_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_145_15 = 0

			if var_145_15 < arg_142_1.time_ and arg_142_1.time_ <= var_145_15 + arg_145_0 then
				arg_142_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_145_16 = 0

			if var_145_16 < arg_142_1.time_ and arg_142_1.time_ <= var_145_16 + arg_145_0 then
				arg_142_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_145_17 = 0
			local var_145_18 = 0.65

			if var_145_17 < arg_142_1.time_ and arg_142_1.time_ <= var_145_17 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_19 = arg_142_1:FormatText(StoryNameCfg[1473].name)

				arg_142_1.leftNameTxt_.text = var_145_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_20 = arg_142_1:GetWordFromCfg(325581035)
				local var_145_21 = arg_142_1:FormatText(var_145_20.content)

				arg_142_1.text_.text = var_145_21

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_22 = 26
				local var_145_23 = utf8.len(var_145_21)
				local var_145_24 = var_145_22 <= 0 and var_145_18 or var_145_18 * (var_145_23 / var_145_22)

				if var_145_24 > 0 and var_145_18 < var_145_24 then
					arg_142_1.talkMaxDuration = var_145_24

					if var_145_24 + var_145_17 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_24 + var_145_17
					end
				end

				arg_142_1.text_.text = var_145_21
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581035", "story_v_out_325581.awb") ~= 0 then
					local var_145_25 = manager.audio:GetVoiceLength("story_v_out_325581", "325581035", "story_v_out_325581.awb") / 1000

					if var_145_25 + var_145_17 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_25 + var_145_17
					end

					if var_145_20.prefab_name ~= "" and arg_142_1.actors_[var_145_20.prefab_name] ~= nil then
						local var_145_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_20.prefab_name].transform, "story_v_out_325581", "325581035", "story_v_out_325581.awb")

						arg_142_1:RecordAudio("325581035", var_145_26)
						arg_142_1:RecordAudio("325581035", var_145_26)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_325581", "325581035", "story_v_out_325581.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_325581", "325581035", "story_v_out_325581.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_27 = math.max(var_145_18, arg_142_1.talkMaxDuration)

			if var_145_17 <= arg_142_1.time_ and arg_142_1.time_ < var_145_17 + var_145_27 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_17) / var_145_27

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_17 + var_145_27 and arg_142_1.time_ < var_145_17 + var_145_27 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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

		arg_142_1:InitPlayNodeList()
	end,
	Play325581036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 325581036
		arg_146_1.duration_ = 6

		local var_146_0 = {
			zh = 5.833,
			ja = 6
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
				arg_146_0:Play325581037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.725

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[1473].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_3 = arg_146_1:GetWordFromCfg(325581036)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 29
				local var_149_6 = utf8.len(var_149_4)
				local var_149_7 = var_149_5 <= 0 and var_149_1 or var_149_1 * (var_149_6 / var_149_5)

				if var_149_7 > 0 and var_149_1 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581036", "story_v_out_325581.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_325581", "325581036", "story_v_out_325581.awb") / 1000

					if var_149_8 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_0
					end

					if var_149_3.prefab_name ~= "" and arg_146_1.actors_[var_149_3.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_3.prefab_name].transform, "story_v_out_325581", "325581036", "story_v_out_325581.awb")

						arg_146_1:RecordAudio("325581036", var_149_9)
						arg_146_1:RecordAudio("325581036", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_325581", "325581036", "story_v_out_325581.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_325581", "325581036", "story_v_out_325581.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_10 and arg_146_1.time_ < var_149_0 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play325581037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 325581037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play325581038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["10175ui_story"].transform
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.var_.moveOldPos10175ui_story = var_153_0.localPosition

				local var_153_2 = GameObjectTools.GetOrAddComponent(var_153_0.gameObject, typeof(DynamicBoneHelper))

				if var_153_2 then
					var_153_2:EnableDynamicBone(false)
				end
			end

			local var_153_3 = 0.001

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_3 then
				local var_153_4 = (arg_150_1.time_ - var_153_1) / var_153_3
				local var_153_5 = Vector3.New(0, 100, 0)

				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10175ui_story, var_153_5, var_153_4)

				local var_153_6 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_6.x, var_153_6.y, var_153_6.z)

				local var_153_7 = var_153_0.localEulerAngles

				var_153_7.z = 0
				var_153_7.x = 0
				var_153_0.localEulerAngles = var_153_7
			end

			if arg_150_1.time_ >= var_153_1 + var_153_3 and arg_150_1.time_ < var_153_1 + var_153_3 + arg_153_0 then
				var_153_0.localPosition = Vector3.New(0, 100, 0)

				local var_153_8 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_8.x, var_153_8.y, var_153_8.z)

				local var_153_9 = var_153_0.localEulerAngles

				var_153_9.z = 0
				var_153_9.x = 0
				var_153_0.localEulerAngles = var_153_9

				local var_153_10 = GameObjectTools.GetOrAddComponent(var_153_0.gameObject, typeof(DynamicBoneHelper))

				if var_153_10 then
					var_153_10:EnableDynamicBone(true)
				end
			end

			local var_153_11 = arg_150_1.actors_["10175ui_story"]
			local var_153_12 = 0

			if var_153_12 < arg_150_1.time_ and arg_150_1.time_ <= var_153_12 + arg_153_0 and not isNil(var_153_11) and arg_150_1.var_.characterEffect10175ui_story == nil then
				arg_150_1.var_.characterEffect10175ui_story = var_153_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_13 = 0.200000002980232

			if var_153_12 <= arg_150_1.time_ and arg_150_1.time_ < var_153_12 + var_153_13 and not isNil(var_153_11) then
				local var_153_14 = (arg_150_1.time_ - var_153_12) / var_153_13

				if arg_150_1.var_.characterEffect10175ui_story and not isNil(var_153_11) then
					local var_153_15 = Mathf.Lerp(0, 0.5, var_153_14)

					arg_150_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_150_1.var_.characterEffect10175ui_story.fillRatio = var_153_15
				end
			end

			if arg_150_1.time_ >= var_153_12 + var_153_13 and arg_150_1.time_ < var_153_12 + var_153_13 + arg_153_0 and not isNil(var_153_11) and arg_150_1.var_.characterEffect10175ui_story then
				local var_153_16 = 0.5

				arg_150_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_150_1.var_.characterEffect10175ui_story.fillRatio = var_153_16
			end

			local var_153_17 = 0
			local var_153_18 = 1.275

			if var_153_17 < arg_150_1.time_ and arg_150_1.time_ <= var_153_17 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_19 = arg_150_1:GetWordFromCfg(325581037)
				local var_153_20 = arg_150_1:FormatText(var_153_19.content)

				arg_150_1.text_.text = var_153_20

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_21 = 51
				local var_153_22 = utf8.len(var_153_20)
				local var_153_23 = var_153_21 <= 0 and var_153_18 or var_153_18 * (var_153_22 / var_153_21)

				if var_153_23 > 0 and var_153_18 < var_153_23 then
					arg_150_1.talkMaxDuration = var_153_23

					if var_153_23 + var_153_17 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_23 + var_153_17
					end
				end

				arg_150_1.text_.text = var_153_20
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_24 = math.max(var_153_18, arg_150_1.talkMaxDuration)

			if var_153_17 <= arg_150_1.time_ and arg_150_1.time_ < var_153_17 + var_153_24 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_17) / var_153_24

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_17 + var_153_24 and arg_150_1.time_ < var_153_17 + var_153_24 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
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

		arg_150_1:InitPlayNodeList()
	end,
	Play325581038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 325581038
		arg_154_1.duration_ = 5

		local var_154_0 = {
			zh = 4.8,
			ja = 5
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play325581039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["10175ui_story"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos10175ui_story = var_157_0.localPosition

				local var_157_2 = GameObjectTools.GetOrAddComponent(var_157_0.gameObject, typeof(DynamicBoneHelper))

				if var_157_2 then
					var_157_2:EnableDynamicBone(false)
				end
			end

			local var_157_3 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_3 then
				local var_157_4 = (arg_154_1.time_ - var_157_1) / var_157_3
				local var_157_5 = Vector3.New(0, -1, -6.05)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10175ui_story, var_157_5, var_157_4)

				local var_157_6 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_6.x, var_157_6.y, var_157_6.z)

				local var_157_7 = var_157_0.localEulerAngles

				var_157_7.z = 0
				var_157_7.x = 0
				var_157_0.localEulerAngles = var_157_7
			end

			if arg_154_1.time_ >= var_157_1 + var_157_3 and arg_154_1.time_ < var_157_1 + var_157_3 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_157_8 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_8.x, var_157_8.y, var_157_8.z)

				local var_157_9 = var_157_0.localEulerAngles

				var_157_9.z = 0
				var_157_9.x = 0
				var_157_0.localEulerAngles = var_157_9

				local var_157_10 = GameObjectTools.GetOrAddComponent(var_157_0.gameObject, typeof(DynamicBoneHelper))

				if var_157_10 then
					var_157_10:EnableDynamicBone(true)
				end
			end

			local var_157_11 = arg_154_1.actors_["10175ui_story"]
			local var_157_12 = 0

			if var_157_12 < arg_154_1.time_ and arg_154_1.time_ <= var_157_12 + arg_157_0 and not isNil(var_157_11) and arg_154_1.var_.characterEffect10175ui_story == nil then
				arg_154_1.var_.characterEffect10175ui_story = var_157_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_13 = 0.200000002980232

			if var_157_12 <= arg_154_1.time_ and arg_154_1.time_ < var_157_12 + var_157_13 and not isNil(var_157_11) then
				local var_157_14 = (arg_154_1.time_ - var_157_12) / var_157_13

				if arg_154_1.var_.characterEffect10175ui_story and not isNil(var_157_11) then
					arg_154_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_12 + var_157_13 and arg_154_1.time_ < var_157_12 + var_157_13 + arg_157_0 and not isNil(var_157_11) and arg_154_1.var_.characterEffect10175ui_story then
				arg_154_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_157_15 = 0

			if var_157_15 < arg_154_1.time_ and arg_154_1.time_ <= var_157_15 + arg_157_0 then
				arg_154_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			local var_157_16 = 0

			if var_157_16 < arg_154_1.time_ and arg_154_1.time_ <= var_157_16 + arg_157_0 then
				arg_154_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_157_17 = 0
			local var_157_18 = 0.6

			if var_157_17 < arg_154_1.time_ and arg_154_1.time_ <= var_157_17 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_19 = arg_154_1:FormatText(StoryNameCfg[1473].name)

				arg_154_1.leftNameTxt_.text = var_157_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_20 = arg_154_1:GetWordFromCfg(325581038)
				local var_157_21 = arg_154_1:FormatText(var_157_20.content)

				arg_154_1.text_.text = var_157_21

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_22 = 24
				local var_157_23 = utf8.len(var_157_21)
				local var_157_24 = var_157_22 <= 0 and var_157_18 or var_157_18 * (var_157_23 / var_157_22)

				if var_157_24 > 0 and var_157_18 < var_157_24 then
					arg_154_1.talkMaxDuration = var_157_24

					if var_157_24 + var_157_17 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_24 + var_157_17
					end
				end

				arg_154_1.text_.text = var_157_21
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581038", "story_v_out_325581.awb") ~= 0 then
					local var_157_25 = manager.audio:GetVoiceLength("story_v_out_325581", "325581038", "story_v_out_325581.awb") / 1000

					if var_157_25 + var_157_17 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_25 + var_157_17
					end

					if var_157_20.prefab_name ~= "" and arg_154_1.actors_[var_157_20.prefab_name] ~= nil then
						local var_157_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_20.prefab_name].transform, "story_v_out_325581", "325581038", "story_v_out_325581.awb")

						arg_154_1:RecordAudio("325581038", var_157_26)
						arg_154_1:RecordAudio("325581038", var_157_26)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_325581", "325581038", "story_v_out_325581.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_325581", "325581038", "story_v_out_325581.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_27 = math.max(var_157_18, arg_154_1.talkMaxDuration)

			if var_157_17 <= arg_154_1.time_ and arg_154_1.time_ < var_157_17 + var_157_27 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_17) / var_157_27

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_17 + var_157_27 and arg_154_1.time_ < var_157_17 + var_157_27 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
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

		arg_154_1:InitPlayNodeList()
	end,
	Play325581039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 325581039
		arg_158_1.duration_ = 3.87

		local var_158_0 = {
			zh = 2.933,
			ja = 3.866
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

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
			local var_161_1 = 1

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				local var_161_2 = "play"
				local var_161_3 = "effect"

				arg_158_1:AudioAction(var_161_2, var_161_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_161_4 = 0
			local var_161_5 = 0.225

			if var_161_4 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_6 = arg_158_1:FormatText(StoryNameCfg[1473].name)

				arg_158_1.leftNameTxt_.text = var_161_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_7 = arg_158_1:GetWordFromCfg(325581039)
				local var_161_8 = arg_158_1:FormatText(var_161_7.content)

				arg_158_1.text_.text = var_161_8

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 9
				local var_161_10 = utf8.len(var_161_8)
				local var_161_11 = var_161_9 <= 0 and var_161_5 or var_161_5 * (var_161_10 / var_161_9)

				if var_161_11 > 0 and var_161_5 < var_161_11 then
					arg_158_1.talkMaxDuration = var_161_11

					if var_161_11 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_11 + var_161_4
					end
				end

				arg_158_1.text_.text = var_161_8
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581039", "story_v_out_325581.awb") ~= 0 then
					local var_161_12 = manager.audio:GetVoiceLength("story_v_out_325581", "325581039", "story_v_out_325581.awb") / 1000

					if var_161_12 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_12 + var_161_4
					end

					if var_161_7.prefab_name ~= "" and arg_158_1.actors_[var_161_7.prefab_name] ~= nil then
						local var_161_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_7.prefab_name].transform, "story_v_out_325581", "325581039", "story_v_out_325581.awb")

						arg_158_1:RecordAudio("325581039", var_161_13)
						arg_158_1:RecordAudio("325581039", var_161_13)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_325581", "325581039", "story_v_out_325581.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_325581", "325581039", "story_v_out_325581.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_14 = math.max(var_161_5, arg_158_1.talkMaxDuration)

			if var_161_4 <= arg_158_1.time_ and arg_158_1.time_ < var_161_4 + var_161_14 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_4) / var_161_14

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_4 + var_161_14 and arg_158_1.time_ < var_161_4 + var_161_14 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J21h",
		"TextureConfig/Background/J26h"
	},
	voices = {
		"story_v_out_325581.awb"
	}
}
