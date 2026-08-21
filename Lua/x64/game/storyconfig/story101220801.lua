return {
	Play122081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122081001
		arg_1_1.duration_ = 6.6

		local var_1_0 = {
			ja = 6.6,
			ko = 6.066,
			zh = 6.066
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
				arg_1_0:Play122081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J02"

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
				local var_4_5 = arg_1_1.bgs_.J02

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
					if iter_4_0 ~= "J02" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = "1029ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_1_1.stage_.transform)

					var_4_24.name = var_4_22
					var_4_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_22] = var_4_24

					local var_4_25 = var_4_24:GetComponentInChildren(typeof(CharacterEffect))

					var_4_25.enabled = true

					local var_4_26 = GameObjectTools.GetOrAddComponent(var_4_24, typeof(DynamicBoneHelper))

					if var_4_26 then
						var_4_26:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_25.transform, false)

					arg_1_1.var_[var_4_22 .. "Animator"] = var_4_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_22 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_22 .. "LipSync"] = var_4_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_27 = arg_1_1.actors_["1029ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1029ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -1.09, -6.2)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1029ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1029ui_story"]
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1029ui_story == nil then
				arg_1_1.var_.characterEffect1029ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1029ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1029ui_story then
				arg_1_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_42 = 0

			arg_1_1.isInRecall_ = false

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_4_2, iter_4_3 in pairs(arg_1_1.actors_) do
					local var_4_43 = iter_4_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_4_4, iter_4_5 in ipairs(var_4_43) do
						if iter_4_5.color.r > 0.51 then
							iter_4_5.color = Color.New(1, 1, 1)
						else
							iter_4_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_4_44 = 0.1

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_44 then
				local var_4_45 = (arg_1_1.time_ - var_4_42) / var_4_44

				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_4_45)
			end

			if arg_1_1.time_ >= var_4_42 + var_4_44 and arg_1_1.time_ < var_4_42 + var_4_44 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			local var_4_46 = 0
			local var_4_47 = 0.4

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

			local var_4_52 = 1.30000000298023
			local var_4_53 = 0.7

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_54 = "play"
				local var_4_55 = "music"

				arg_1_1:AudioAction(var_4_54, var_4_55, "bgm_activity_2_2_story_tiantongyinqing", "bgm_activity_2_2_story_tiantongyinqing", "bgm_activity_2_2_story_tiantongyinqing.awb")

				local var_4_56 = ""
				local var_4_57 = manager.audio:GetAudioName("bgm_activity_2_2_story_tiantongyinqing", "bgm_activity_2_2_story_tiantongyinqing")

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

			local var_4_58 = 2
			local var_4_59 = 0.5

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_60 = arg_1_1:FormatText(StoryNameCfg[319].name)

				arg_1_1.leftNameTxt_.text = var_4_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_61 = arg_1_1:GetWordFromCfg(122081001)
				local var_4_62 = arg_1_1:FormatText(var_4_61.content)

				arg_1_1.text_.text = var_4_62

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_63 = 20
				local var_4_64 = utf8.len(var_4_62)
				local var_4_65 = var_4_63 <= 0 and var_4_59 or var_4_59 * (var_4_64 / var_4_63)

				if var_4_65 > 0 and var_4_59 < var_4_65 then
					arg_1_1.talkMaxDuration = var_4_65

					if var_4_65 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_58
					end
				end

				arg_1_1.text_.text = var_4_62
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081001", "story_v_out_122081.awb") ~= 0 then
					local var_4_66 = manager.audio:GetVoiceLength("story_v_out_122081", "122081001", "story_v_out_122081.awb") / 1000

					if var_4_66 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_58
					end

					if var_4_61.prefab_name ~= "" and arg_1_1.actors_[var_4_61.prefab_name] ~= nil then
						local var_4_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_61.prefab_name].transform, "story_v_out_122081", "122081001", "story_v_out_122081.awb")

						arg_1_1:RecordAudio("122081001", var_4_67)
						arg_1_1:RecordAudio("122081001", var_4_67)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_122081", "122081001", "story_v_out_122081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_122081", "122081001", "story_v_out_122081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_68 = math.max(var_4_59, arg_1_1.talkMaxDuration)

			if var_4_58 <= arg_1_1.time_ and arg_1_1.time_ < var_4_58 + var_4_68 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_58) / var_4_68

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_58 + var_4_68 and arg_1_1.time_ < var_4_58 + var_4_68 + arg_4_0 then
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
	Play122081002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 122081002
		arg_7_1.duration_ = 9

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play122081003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = "J08h"

			if arg_7_1.bgs_[var_10_0] == nil then
				local var_10_1 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_10_0)
				var_10_1.name = var_10_0
				var_10_1.transform.parent = arg_7_1.stage_.transform
				var_10_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_[var_10_0] = var_10_1
			end

			local var_10_2 = 2

			if var_10_2 < arg_7_1.time_ and arg_7_1.time_ <= var_10_2 + arg_10_0 then
				local var_10_3 = manager.ui.mainCamera.transform.localPosition
				local var_10_4 = Vector3.New(0, 0, 10) + Vector3.New(var_10_3.x, var_10_3.y, 0)
				local var_10_5 = arg_7_1.bgs_.J08h

				var_10_5.transform.localPosition = var_10_4
				var_10_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_10_6 = var_10_5:GetComponent("SpriteRenderer")

				if var_10_6 and var_10_6.sprite then
					local var_10_7 = (var_10_5.transform.localPosition - var_10_3).z
					local var_10_8 = manager.ui.mainCameraCom_
					local var_10_9 = 2 * var_10_7 * Mathf.Tan(var_10_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_10_10 = var_10_9 * var_10_8.aspect
					local var_10_11 = var_10_6.sprite.bounds.size.x
					local var_10_12 = var_10_6.sprite.bounds.size.y
					local var_10_13 = var_10_10 / var_10_11
					local var_10_14 = var_10_9 / var_10_12
					local var_10_15 = var_10_14 < var_10_13 and var_10_13 or var_10_14

					var_10_5.transform.localScale = Vector3.New(var_10_15, var_10_15, 0)
				end

				for iter_10_0, iter_10_1 in pairs(arg_7_1.bgs_) do
					if iter_10_0 ~= "J08h" then
						iter_10_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_10_16 = 0

			if var_10_16 < arg_7_1.time_ and arg_7_1.time_ <= var_10_16 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_17 = 2

			if var_10_16 <= arg_7_1.time_ and arg_7_1.time_ < var_10_16 + var_10_17 then
				local var_10_18 = (arg_7_1.time_ - var_10_16) / var_10_17
				local var_10_19 = Color.New(0, 0, 0)

				var_10_19.a = Mathf.Lerp(0, 1, var_10_18)
				arg_7_1.mask_.color = var_10_19
			end

			if arg_7_1.time_ >= var_10_16 + var_10_17 and arg_7_1.time_ < var_10_16 + var_10_17 + arg_10_0 then
				local var_10_20 = Color.New(0, 0, 0)

				var_10_20.a = 1
				arg_7_1.mask_.color = var_10_20
			end

			local var_10_21 = 2

			if var_10_21 < arg_7_1.time_ and arg_7_1.time_ <= var_10_21 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_22 = 2

			if var_10_21 <= arg_7_1.time_ and arg_7_1.time_ < var_10_21 + var_10_22 then
				local var_10_23 = (arg_7_1.time_ - var_10_21) / var_10_22
				local var_10_24 = Color.New(0, 0, 0)

				var_10_24.a = Mathf.Lerp(1, 0, var_10_23)
				arg_7_1.mask_.color = var_10_24
			end

			if arg_7_1.time_ >= var_10_21 + var_10_22 and arg_7_1.time_ < var_10_21 + var_10_22 + arg_10_0 then
				local var_10_25 = Color.New(0, 0, 0)
				local var_10_26 = 0

				arg_7_1.mask_.enabled = false
				var_10_25.a = var_10_26
				arg_7_1.mask_.color = var_10_25
			end

			local var_10_27 = arg_7_1.actors_["1029ui_story"].transform
			local var_10_28 = 1.96599999815226

			if var_10_28 < arg_7_1.time_ and arg_7_1.time_ <= var_10_28 + arg_10_0 then
				arg_7_1.var_.moveOldPos1029ui_story = var_10_27.localPosition
			end

			local var_10_29 = 0.001

			if var_10_28 <= arg_7_1.time_ and arg_7_1.time_ < var_10_28 + var_10_29 then
				local var_10_30 = (arg_7_1.time_ - var_10_28) / var_10_29
				local var_10_31 = Vector3.New(0, 100, 0)

				var_10_27.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1029ui_story, var_10_31, var_10_30)

				local var_10_32 = manager.ui.mainCamera.transform.position - var_10_27.position

				var_10_27.forward = Vector3.New(var_10_32.x, var_10_32.y, var_10_32.z)

				local var_10_33 = var_10_27.localEulerAngles

				var_10_33.z = 0
				var_10_33.x = 0
				var_10_27.localEulerAngles = var_10_33
			end

			if arg_7_1.time_ >= var_10_28 + var_10_29 and arg_7_1.time_ < var_10_28 + var_10_29 + arg_10_0 then
				var_10_27.localPosition = Vector3.New(0, 100, 0)

				local var_10_34 = manager.ui.mainCamera.transform.position - var_10_27.position

				var_10_27.forward = Vector3.New(var_10_34.x, var_10_34.y, var_10_34.z)

				local var_10_35 = var_10_27.localEulerAngles

				var_10_35.z = 0
				var_10_35.x = 0
				var_10_27.localEulerAngles = var_10_35
			end

			local var_10_36 = arg_7_1.actors_["1029ui_story"]
			local var_10_37 = 1.96599999815226

			if var_10_37 < arg_7_1.time_ and arg_7_1.time_ <= var_10_37 + arg_10_0 and not isNil(var_10_36) and arg_7_1.var_.characterEffect1029ui_story == nil then
				arg_7_1.var_.characterEffect1029ui_story = var_10_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_38 = 0.034000001847744

			if var_10_37 <= arg_7_1.time_ and arg_7_1.time_ < var_10_37 + var_10_38 and not isNil(var_10_36) then
				local var_10_39 = (arg_7_1.time_ - var_10_37) / var_10_38

				if arg_7_1.var_.characterEffect1029ui_story and not isNil(var_10_36) then
					local var_10_40 = Mathf.Lerp(0, 0.5, var_10_39)

					arg_7_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1029ui_story.fillRatio = var_10_40
				end
			end

			if arg_7_1.time_ >= var_10_37 + var_10_38 and arg_7_1.time_ < var_10_37 + var_10_38 + arg_10_0 and not isNil(var_10_36) and arg_7_1.var_.characterEffect1029ui_story then
				local var_10_41 = 0.5

				arg_7_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1029ui_story.fillRatio = var_10_41
			end

			local var_10_42 = 2

			arg_7_1.isInRecall_ = false

			if var_10_42 < arg_7_1.time_ and arg_7_1.time_ <= var_10_42 + arg_10_0 then
				arg_7_1.screenFilterGo_:SetActive(false)

				for iter_10_2, iter_10_3 in pairs(arg_7_1.actors_) do
					local var_10_43 = iter_10_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_10_4, iter_10_5 in ipairs(var_10_43) do
						if iter_10_5.color.r > 0.51 then
							iter_10_5.color = Color.New(1, 1, 1)
						else
							iter_10_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_10_44 = 0.1

			if var_10_42 <= arg_7_1.time_ and arg_7_1.time_ < var_10_42 + var_10_44 then
				local var_10_45 = (arg_7_1.time_ - var_10_42) / var_10_44

				arg_7_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_10_45)
			end

			if arg_7_1.time_ >= var_10_42 + var_10_44 and arg_7_1.time_ < var_10_42 + var_10_44 + arg_10_0 then
				arg_7_1.screenFilterEffect_.weight = 0
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_46 = 3.999999999999
			local var_10_47 = 1.675

			if var_10_46 < arg_7_1.time_ and arg_7_1.time_ <= var_10_46 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_48 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_48:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_49 = arg_7_1:GetWordFromCfg(122081002)
				local var_10_50 = arg_7_1:FormatText(var_10_49.content)

				arg_7_1.text_.text = var_10_50

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_51 = 67
				local var_10_52 = utf8.len(var_10_50)
				local var_10_53 = var_10_51 <= 0 and var_10_47 or var_10_47 * (var_10_52 / var_10_51)

				if var_10_53 > 0 and var_10_47 < var_10_53 then
					arg_7_1.talkMaxDuration = var_10_53
					var_10_46 = var_10_46 + 0.3

					if var_10_53 + var_10_46 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_53 + var_10_46
					end
				end

				arg_7_1.text_.text = var_10_50
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_54 = var_10_46 + 0.3
			local var_10_55 = math.max(var_10_47, arg_7_1.talkMaxDuration)

			if var_10_54 <= arg_7_1.time_ and arg_7_1.time_ < var_10_54 + var_10_55 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_54) / var_10_55

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_54 + var_10_55 and arg_7_1.time_ < var_10_54 + var_10_55 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
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

		arg_7_1:InitPlayNodeList()
	end,
	Play122081003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 122081003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play122081004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.925

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(122081003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 37
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play122081004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 122081004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play122081005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.35

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(122081004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 14
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_8 and arg_17_1.time_ < var_20_0 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play122081005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 122081005
		arg_21_1.duration_ = 8.43

		local var_21_0 = {
			ja = 8.433,
			ko = 7.466,
			zh = 7.466
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play122081006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "10045ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "10045ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "10045ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["10045ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos10045ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(0, -1.18, -6.05)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10045ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0, -1.18, -6.05)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = arg_21_1.actors_["10045ui_story"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect10045ui_story == nil then
				arg_21_1.var_.characterEffect10045ui_story = var_24_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_16 = 0.200000002980232

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.characterEffect10045ui_story and not isNil(var_24_14) then
					arg_21_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect10045ui_story then
				arg_21_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_24_18 = 0

			if var_24_18 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_1")
			end

			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_24_20 = 0
			local var_24_21 = 0.7

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_22 = arg_21_1:FormatText(StoryNameCfg[45].name)

				arg_21_1.leftNameTxt_.text = var_24_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_23 = arg_21_1:GetWordFromCfg(122081005)
				local var_24_24 = arg_21_1:FormatText(var_24_23.content)

				arg_21_1.text_.text = var_24_24

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_25 = 28
				local var_24_26 = utf8.len(var_24_24)
				local var_24_27 = var_24_25 <= 0 and var_24_21 or var_24_21 * (var_24_26 / var_24_25)

				if var_24_27 > 0 and var_24_21 < var_24_27 then
					arg_21_1.talkMaxDuration = var_24_27

					if var_24_27 + var_24_20 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_27 + var_24_20
					end
				end

				arg_21_1.text_.text = var_24_24
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081005", "story_v_out_122081.awb") ~= 0 then
					local var_24_28 = manager.audio:GetVoiceLength("story_v_out_122081", "122081005", "story_v_out_122081.awb") / 1000

					if var_24_28 + var_24_20 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_28 + var_24_20
					end

					if var_24_23.prefab_name ~= "" and arg_21_1.actors_[var_24_23.prefab_name] ~= nil then
						local var_24_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_23.prefab_name].transform, "story_v_out_122081", "122081005", "story_v_out_122081.awb")

						arg_21_1:RecordAudio("122081005", var_24_29)
						arg_21_1:RecordAudio("122081005", var_24_29)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_122081", "122081005", "story_v_out_122081.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_122081", "122081005", "story_v_out_122081.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_30 = math.max(var_24_21, arg_21_1.talkMaxDuration)

			if var_24_20 <= arg_21_1.time_ and arg_21_1.time_ < var_24_20 + var_24_30 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_20) / var_24_30

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_20 + var_24_30 and arg_21_1.time_ < var_24_20 + var_24_30 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play122081006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 122081006
		arg_25_1.duration_ = 9.63

		local var_25_0 = {
			ja = 5.333,
			ko = 9.633,
			zh = 9.633
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
				arg_25_0:Play122081007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.7

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[45].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(122081006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 28
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081006", "story_v_out_122081.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_122081", "122081006", "story_v_out_122081.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_122081", "122081006", "story_v_out_122081.awb")

						arg_25_1:RecordAudio("122081006", var_28_9)
						arg_25_1:RecordAudio("122081006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_122081", "122081006", "story_v_out_122081.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_122081", "122081006", "story_v_out_122081.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play122081007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 122081007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play122081008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10045ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos10045ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(-0.7, -1.18, -6.05)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10045ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(-0.7, -1.18, -6.05)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["10045ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect10045ui_story == nil then
				arg_29_1.var_.characterEffect10045ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect10045ui_story and not isNil(var_32_9) then
					local var_32_13 = Mathf.Lerp(0, 0.5, var_32_12)

					arg_29_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10045ui_story.fillRatio = var_32_13
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect10045ui_story then
				local var_32_14 = 0.5

				arg_29_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10045ui_story.fillRatio = var_32_14
			end

			local var_32_15 = "4037ui_story"

			if arg_29_1.actors_[var_32_15] == nil then
				local var_32_16 = Asset.Load("Char/" .. "4037ui_story")

				if not isNil(var_32_16) then
					local var_32_17 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_29_1.stage_.transform)

					var_32_17.name = var_32_15
					var_32_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_15] = var_32_17

					local var_32_18 = var_32_17:GetComponentInChildren(typeof(CharacterEffect))

					var_32_18.enabled = true

					local var_32_19 = GameObjectTools.GetOrAddComponent(var_32_17, typeof(DynamicBoneHelper))

					if var_32_19 then
						var_32_19:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_18.transform, false)

					arg_29_1.var_[var_32_15 .. "Animator"] = var_32_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_15 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_15 .. "LipSync"] = var_32_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_20 = arg_29_1.actors_["4037ui_story"].transform
			local var_32_21 = 0

			if var_32_21 < arg_29_1.time_ and arg_29_1.time_ <= var_32_21 + arg_32_0 then
				arg_29_1.var_.moveOldPos4037ui_story = var_32_20.localPosition
			end

			local var_32_22 = 0.001

			if var_32_21 <= arg_29_1.time_ and arg_29_1.time_ < var_32_21 + var_32_22 then
				local var_32_23 = (arg_29_1.time_ - var_32_21) / var_32_22
				local var_32_24 = Vector3.New(0.7, -1.12, -6.2)

				var_32_20.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos4037ui_story, var_32_24, var_32_23)

				local var_32_25 = manager.ui.mainCamera.transform.position - var_32_20.position

				var_32_20.forward = Vector3.New(var_32_25.x, var_32_25.y, var_32_25.z)

				local var_32_26 = var_32_20.localEulerAngles

				var_32_26.z = 0
				var_32_26.x = 0
				var_32_20.localEulerAngles = var_32_26
			end

			if arg_29_1.time_ >= var_32_21 + var_32_22 and arg_29_1.time_ < var_32_21 + var_32_22 + arg_32_0 then
				var_32_20.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_32_27 = manager.ui.mainCamera.transform.position - var_32_20.position

				var_32_20.forward = Vector3.New(var_32_27.x, var_32_27.y, var_32_27.z)

				local var_32_28 = var_32_20.localEulerAngles

				var_32_28.z = 0
				var_32_28.x = 0
				var_32_20.localEulerAngles = var_32_28
			end

			local var_32_29 = arg_29_1.actors_["4037ui_story"]
			local var_32_30 = 0

			if var_32_30 < arg_29_1.time_ and arg_29_1.time_ <= var_32_30 + arg_32_0 and not isNil(var_32_29) and arg_29_1.var_.characterEffect4037ui_story == nil then
				arg_29_1.var_.characterEffect4037ui_story = var_32_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_31 = 0.200000002980232

			if var_32_30 <= arg_29_1.time_ and arg_29_1.time_ < var_32_30 + var_32_31 and not isNil(var_32_29) then
				local var_32_32 = (arg_29_1.time_ - var_32_30) / var_32_31

				if arg_29_1.var_.characterEffect4037ui_story and not isNil(var_32_29) then
					arg_29_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_30 + var_32_31 and arg_29_1.time_ < var_32_30 + var_32_31 + arg_32_0 and not isNil(var_32_29) and arg_29_1.var_.characterEffect4037ui_story then
				arg_29_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_32_33 = 0

			if var_32_33 < arg_29_1.time_ and arg_29_1.time_ <= var_32_33 + arg_32_0 then
				arg_29_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_32_34 = 0

			if var_32_34 < arg_29_1.time_ and arg_29_1.time_ <= var_32_34 + arg_32_0 then
				arg_29_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_35 = 0
			local var_32_36 = 0.1

			if var_32_35 < arg_29_1.time_ and arg_29_1.time_ <= var_32_35 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_37 = arg_29_1:FormatText(StoryNameCfg[453].name)

				arg_29_1.leftNameTxt_.text = var_32_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_38 = arg_29_1:GetWordFromCfg(122081007)
				local var_32_39 = arg_29_1:FormatText(var_32_38.content)

				arg_29_1.text_.text = var_32_39

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_40 = 4
				local var_32_41 = utf8.len(var_32_39)
				local var_32_42 = var_32_40 <= 0 and var_32_36 or var_32_36 * (var_32_41 / var_32_40)

				if var_32_42 > 0 and var_32_36 < var_32_42 then
					arg_29_1.talkMaxDuration = var_32_42

					if var_32_42 + var_32_35 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_42 + var_32_35
					end
				end

				arg_29_1.text_.text = var_32_39
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081007", "story_v_out_122081.awb") ~= 0 then
					local var_32_43 = manager.audio:GetVoiceLength("story_v_out_122081", "122081007", "story_v_out_122081.awb") / 1000

					if var_32_43 + var_32_35 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_43 + var_32_35
					end

					if var_32_38.prefab_name ~= "" and arg_29_1.actors_[var_32_38.prefab_name] ~= nil then
						local var_32_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_38.prefab_name].transform, "story_v_out_122081", "122081007", "story_v_out_122081.awb")

						arg_29_1:RecordAudio("122081007", var_32_44)
						arg_29_1:RecordAudio("122081007", var_32_44)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_122081", "122081007", "story_v_out_122081.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_122081", "122081007", "story_v_out_122081.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_45 = math.max(var_32_36, arg_29_1.talkMaxDuration)

			if var_32_35 <= arg_29_1.time_ and arg_29_1.time_ < var_32_35 + var_32_45 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_35) / var_32_45

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_35 + var_32_45 and arg_29_1.time_ < var_32_35 + var_32_45 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play122081008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 122081008
		arg_33_1.duration_ = 5.2

		local var_33_0 = {
			ja = 5.2,
			ko = 3.366,
			zh = 3.366
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
				arg_33_0:Play122081009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10045ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10045ui_story == nil then
				arg_33_1.var_.characterEffect10045ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10045ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10045ui_story then
				arg_33_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["4037ui_story"]
			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect4037ui_story == nil then
				arg_33_1.var_.characterEffect4037ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_6 and not isNil(var_36_4) then
				local var_36_7 = (arg_33_1.time_ - var_36_5) / var_36_6

				if arg_33_1.var_.characterEffect4037ui_story and not isNil(var_36_4) then
					local var_36_8 = Mathf.Lerp(0, 0.5, var_36_7)

					arg_33_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_33_1.var_.characterEffect4037ui_story.fillRatio = var_36_8
				end
			end

			if arg_33_1.time_ >= var_36_5 + var_36_6 and arg_33_1.time_ < var_36_5 + var_36_6 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect4037ui_story then
				local var_36_9 = 0.5

				arg_33_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_33_1.var_.characterEffect4037ui_story.fillRatio = var_36_9
			end

			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_2")
			end

			local var_36_11 = 0
			local var_36_12 = 0.475

			if var_36_11 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_13 = arg_33_1:FormatText(StoryNameCfg[45].name)

				arg_33_1.leftNameTxt_.text = var_36_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_14 = arg_33_1:GetWordFromCfg(122081008)
				local var_36_15 = arg_33_1:FormatText(var_36_14.content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_16 = 19
				local var_36_17 = utf8.len(var_36_15)
				local var_36_18 = var_36_16 <= 0 and var_36_12 or var_36_12 * (var_36_17 / var_36_16)

				if var_36_18 > 0 and var_36_12 < var_36_18 then
					arg_33_1.talkMaxDuration = var_36_18

					if var_36_18 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_11
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081008", "story_v_out_122081.awb") ~= 0 then
					local var_36_19 = manager.audio:GetVoiceLength("story_v_out_122081", "122081008", "story_v_out_122081.awb") / 1000

					if var_36_19 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_19 + var_36_11
					end

					if var_36_14.prefab_name ~= "" and arg_33_1.actors_[var_36_14.prefab_name] ~= nil then
						local var_36_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_14.prefab_name].transform, "story_v_out_122081", "122081008", "story_v_out_122081.awb")

						arg_33_1:RecordAudio("122081008", var_36_20)
						arg_33_1:RecordAudio("122081008", var_36_20)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_122081", "122081008", "story_v_out_122081.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_122081", "122081008", "story_v_out_122081.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_21 = math.max(var_36_12, arg_33_1.talkMaxDuration)

			if var_36_11 <= arg_33_1.time_ and arg_33_1.time_ < var_36_11 + var_36_21 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_11) / var_36_21

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_11 + var_36_21 and arg_33_1.time_ < var_36_11 + var_36_21 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play122081009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 122081009
		arg_37_1.duration_ = 2

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play122081010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["4037ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect4037ui_story == nil then
				arg_37_1.var_.characterEffect4037ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect4037ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect4037ui_story then
				arg_37_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_40_5 = arg_37_1.actors_["10045ui_story"]
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10045ui_story == nil then
				arg_37_1.var_.characterEffect10045ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_7 = 0.200000002980232

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 and not isNil(var_40_5) then
				local var_40_8 = (arg_37_1.time_ - var_40_6) / var_40_7

				if arg_37_1.var_.characterEffect10045ui_story and not isNil(var_40_5) then
					local var_40_9 = Mathf.Lerp(0, 0.5, var_40_8)

					arg_37_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10045ui_story.fillRatio = var_40_9
				end
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10045ui_story then
				local var_40_10 = 0.5

				arg_37_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10045ui_story.fillRatio = var_40_10
			end

			local var_40_11 = 0
			local var_40_12 = 0.075

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_13 = arg_37_1:FormatText(StoryNameCfg[453].name)

				arg_37_1.leftNameTxt_.text = var_40_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(122081009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 3
				local var_40_17 = utf8.len(var_40_15)
				local var_40_18 = var_40_16 <= 0 and var_40_12 or var_40_12 * (var_40_17 / var_40_16)

				if var_40_18 > 0 and var_40_12 < var_40_18 then
					arg_37_1.talkMaxDuration = var_40_18

					if var_40_18 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081009", "story_v_out_122081.awb") ~= 0 then
					local var_40_19 = manager.audio:GetVoiceLength("story_v_out_122081", "122081009", "story_v_out_122081.awb") / 1000

					if var_40_19 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_11
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_122081", "122081009", "story_v_out_122081.awb")

						arg_37_1:RecordAudio("122081009", var_40_20)
						arg_37_1:RecordAudio("122081009", var_40_20)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_122081", "122081009", "story_v_out_122081.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_122081", "122081009", "story_v_out_122081.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_21 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_21 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_21

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_21 and arg_37_1.time_ < var_40_11 + var_40_21 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play122081010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 122081010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play122081011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["4037ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos4037ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0, 100, 0)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos4037ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, 100, 0)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["4037ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect4037ui_story == nil then
				arg_41_1.var_.characterEffect4037ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect4037ui_story and not isNil(var_44_9) then
					local var_44_13 = Mathf.Lerp(0, 0.5, var_44_12)

					arg_41_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_41_1.var_.characterEffect4037ui_story.fillRatio = var_44_13
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect4037ui_story then
				local var_44_14 = 0.5

				arg_41_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_41_1.var_.characterEffect4037ui_story.fillRatio = var_44_14
			end

			local var_44_15 = arg_41_1.actors_["10045ui_story"].transform
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.var_.moveOldPos10045ui_story = var_44_15.localPosition
			end

			local var_44_17 = 0.001

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17
				local var_44_19 = Vector3.New(0, 100, 0)

				var_44_15.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10045ui_story, var_44_19, var_44_18)

				local var_44_20 = manager.ui.mainCamera.transform.position - var_44_15.position

				var_44_15.forward = Vector3.New(var_44_20.x, var_44_20.y, var_44_20.z)

				local var_44_21 = var_44_15.localEulerAngles

				var_44_21.z = 0
				var_44_21.x = 0
				var_44_15.localEulerAngles = var_44_21
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 then
				var_44_15.localPosition = Vector3.New(0, 100, 0)

				local var_44_22 = manager.ui.mainCamera.transform.position - var_44_15.position

				var_44_15.forward = Vector3.New(var_44_22.x, var_44_22.y, var_44_22.z)

				local var_44_23 = var_44_15.localEulerAngles

				var_44_23.z = 0
				var_44_23.x = 0
				var_44_15.localEulerAngles = var_44_23
			end

			local var_44_24 = arg_41_1.actors_["10045ui_story"]
			local var_44_25 = 0

			if var_44_25 < arg_41_1.time_ and arg_41_1.time_ <= var_44_25 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect10045ui_story == nil then
				arg_41_1.var_.characterEffect10045ui_story = var_44_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_26 = 0.200000002980232

			if var_44_25 <= arg_41_1.time_ and arg_41_1.time_ < var_44_25 + var_44_26 and not isNil(var_44_24) then
				local var_44_27 = (arg_41_1.time_ - var_44_25) / var_44_26

				if arg_41_1.var_.characterEffect10045ui_story and not isNil(var_44_24) then
					local var_44_28 = Mathf.Lerp(0, 0.5, var_44_27)

					arg_41_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10045ui_story.fillRatio = var_44_28
				end
			end

			if arg_41_1.time_ >= var_44_25 + var_44_26 and arg_41_1.time_ < var_44_25 + var_44_26 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect10045ui_story then
				local var_44_29 = 0.5

				arg_41_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10045ui_story.fillRatio = var_44_29
			end

			local var_44_30 = 0
			local var_44_31 = 0.775

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_32 = arg_41_1:GetWordFromCfg(122081010)
				local var_44_33 = arg_41_1:FormatText(var_44_32.content)

				arg_41_1.text_.text = var_44_33

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_34 = 31
				local var_44_35 = utf8.len(var_44_33)
				local var_44_36 = var_44_34 <= 0 and var_44_31 or var_44_31 * (var_44_35 / var_44_34)

				if var_44_36 > 0 and var_44_31 < var_44_36 then
					arg_41_1.talkMaxDuration = var_44_36

					if var_44_36 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_36 + var_44_30
					end
				end

				arg_41_1.text_.text = var_44_33
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_37 = math.max(var_44_31, arg_41_1.talkMaxDuration)

			if var_44_30 <= arg_41_1.time_ and arg_41_1.time_ < var_44_30 + var_44_37 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_30) / var_44_37

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_30 + var_44_37 and arg_41_1.time_ < var_44_30 + var_44_37 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10045ui_story",
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
	Play122081011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 122081011
		arg_45_1.duration_ = 9.27

		local var_45_0 = {
			ja = 7.1,
			ko = 9.266,
			zh = 9.266
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play122081012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10045ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10045ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(-0.7, -1.18, -6.05)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10045ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-0.7, -1.18, -6.05)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["10045ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect10045ui_story == nil then
				arg_45_1.var_.characterEffect10045ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect10045ui_story and not isNil(var_48_9) then
					local var_48_13 = Mathf.Lerp(0, 0.5, var_48_12)

					arg_45_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10045ui_story.fillRatio = var_48_13
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect10045ui_story then
				local var_48_14 = 0.5

				arg_45_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10045ui_story.fillRatio = var_48_14
			end

			local var_48_15 = 0
			local var_48_16 = 0.75

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[45].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(122081011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 30
				local var_48_21 = utf8.len(var_48_19)
				local var_48_22 = var_48_20 <= 0 and var_48_16 or var_48_16 * (var_48_21 / var_48_20)

				if var_48_22 > 0 and var_48_16 < var_48_22 then
					arg_45_1.talkMaxDuration = var_48_22

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081011", "story_v_out_122081.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_out_122081", "122081011", "story_v_out_122081.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_122081", "122081011", "story_v_out_122081.awb")

						arg_45_1:RecordAudio("122081011", var_48_24)
						arg_45_1:RecordAudio("122081011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_122081", "122081011", "story_v_out_122081.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_122081", "122081011", "story_v_out_122081.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_25 and arg_45_1.time_ < var_48_15 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play122081012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 122081012
		arg_49_1.duration_ = 2.47

		local var_49_0 = {
			ja = 2.466,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play122081013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "10037ui_story"

			if arg_49_1.actors_[var_52_0] == nil then
				local var_52_1 = Asset.Load("Char/" .. "10037ui_story")

				if not isNil(var_52_1) then
					local var_52_2 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_49_1.stage_.transform)

					var_52_2.name = var_52_0
					var_52_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_49_1.actors_[var_52_0] = var_52_2

					local var_52_3 = var_52_2:GetComponentInChildren(typeof(CharacterEffect))

					var_52_3.enabled = true

					local var_52_4 = GameObjectTools.GetOrAddComponent(var_52_2, typeof(DynamicBoneHelper))

					if var_52_4 then
						var_52_4:EnableDynamicBone(false)
					end

					arg_49_1:ShowWeapon(var_52_3.transform, false)

					arg_49_1.var_[var_52_0 .. "Animator"] = var_52_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_49_1.var_[var_52_0 .. "Animator"].applyRootMotion = true
					arg_49_1.var_[var_52_0 .. "LipSync"] = var_52_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_52_5 = arg_49_1.actors_["10037ui_story"].transform
			local var_52_6 = 0

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.var_.moveOldPos10037ui_story = var_52_5.localPosition
			end

			local var_52_7 = 0.001

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_7 then
				local var_52_8 = (arg_49_1.time_ - var_52_6) / var_52_7
				local var_52_9 = Vector3.New(0.7, -1.13, -6.2)

				var_52_5.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10037ui_story, var_52_9, var_52_8)

				local var_52_10 = manager.ui.mainCamera.transform.position - var_52_5.position

				var_52_5.forward = Vector3.New(var_52_10.x, var_52_10.y, var_52_10.z)

				local var_52_11 = var_52_5.localEulerAngles

				var_52_11.z = 0
				var_52_11.x = 0
				var_52_5.localEulerAngles = var_52_11
			end

			if arg_49_1.time_ >= var_52_6 + var_52_7 and arg_49_1.time_ < var_52_6 + var_52_7 + arg_52_0 then
				var_52_5.localPosition = Vector3.New(0.7, -1.13, -6.2)

				local var_52_12 = manager.ui.mainCamera.transform.position - var_52_5.position

				var_52_5.forward = Vector3.New(var_52_12.x, var_52_12.y, var_52_12.z)

				local var_52_13 = var_52_5.localEulerAngles

				var_52_13.z = 0
				var_52_13.x = 0
				var_52_5.localEulerAngles = var_52_13
			end

			local var_52_14 = arg_49_1.actors_["10037ui_story"]
			local var_52_15 = 0

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 and not isNil(var_52_14) and arg_49_1.var_.characterEffect10037ui_story == nil then
				arg_49_1.var_.characterEffect10037ui_story = var_52_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_16 = 0.200000002980232

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_16 and not isNil(var_52_14) then
				local var_52_17 = (arg_49_1.time_ - var_52_15) / var_52_16

				if arg_49_1.var_.characterEffect10037ui_story and not isNil(var_52_14) then
					arg_49_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_15 + var_52_16 and arg_49_1.time_ < var_52_15 + var_52_16 + arg_52_0 and not isNil(var_52_14) and arg_49_1.var_.characterEffect10037ui_story then
				arg_49_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_52_18 = 0

			if var_52_18 < arg_49_1.time_ and arg_49_1.time_ <= var_52_18 + arg_52_0 then
				arg_49_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			local var_52_19 = 0

			if var_52_19 < arg_49_1.time_ and arg_49_1.time_ <= var_52_19 + arg_52_0 then
				arg_49_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_20 = "1071ui_story"

			if arg_49_1.actors_[var_52_20] == nil then
				local var_52_21 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_52_21) then
					local var_52_22 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_49_1.stage_.transform)

					var_52_22.name = var_52_20
					var_52_22.transform.localPosition = Vector3.New(0, 100, 0)
					arg_49_1.actors_[var_52_20] = var_52_22

					local var_52_23 = var_52_22:GetComponentInChildren(typeof(CharacterEffect))

					var_52_23.enabled = true

					local var_52_24 = GameObjectTools.GetOrAddComponent(var_52_22, typeof(DynamicBoneHelper))

					if var_52_24 then
						var_52_24:EnableDynamicBone(false)
					end

					arg_49_1:ShowWeapon(var_52_23.transform, false)

					arg_49_1.var_[var_52_20 .. "Animator"] = var_52_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_49_1.var_[var_52_20 .. "Animator"].applyRootMotion = true
					arg_49_1.var_[var_52_20 .. "LipSync"] = var_52_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_52_25 = 0

			if var_52_25 < arg_49_1.time_ and arg_49_1.time_ <= var_52_25 + arg_52_0 then
				arg_49_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_52_26 = 0
			local var_52_27 = 0.175

			if var_52_26 < arg_49_1.time_ and arg_49_1.time_ <= var_52_26 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_28 = arg_49_1:FormatText(StoryNameCfg[383].name)

				arg_49_1.leftNameTxt_.text = var_52_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_29 = arg_49_1:GetWordFromCfg(122081012)
				local var_52_30 = arg_49_1:FormatText(var_52_29.content)

				arg_49_1.text_.text = var_52_30

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_31 = 7
				local var_52_32 = utf8.len(var_52_30)
				local var_52_33 = var_52_31 <= 0 and var_52_27 or var_52_27 * (var_52_32 / var_52_31)

				if var_52_33 > 0 and var_52_27 < var_52_33 then
					arg_49_1.talkMaxDuration = var_52_33

					if var_52_33 + var_52_26 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_33 + var_52_26
					end
				end

				arg_49_1.text_.text = var_52_30
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081012", "story_v_out_122081.awb") ~= 0 then
					local var_52_34 = manager.audio:GetVoiceLength("story_v_out_122081", "122081012", "story_v_out_122081.awb") / 1000

					if var_52_34 + var_52_26 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_34 + var_52_26
					end

					if var_52_29.prefab_name ~= "" and arg_49_1.actors_[var_52_29.prefab_name] ~= nil then
						local var_52_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_29.prefab_name].transform, "story_v_out_122081", "122081012", "story_v_out_122081.awb")

						arg_49_1:RecordAudio("122081012", var_52_35)
						arg_49_1:RecordAudio("122081012", var_52_35)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_122081", "122081012", "story_v_out_122081.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_122081", "122081012", "story_v_out_122081.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_36 = math.max(var_52_27, arg_49_1.talkMaxDuration)

			if var_52_26 <= arg_49_1.time_ and arg_49_1.time_ < var_52_26 + var_52_36 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_26) / var_52_36

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_26 + var_52_36 and arg_49_1.time_ < var_52_26 + var_52_36 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play122081013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 122081013
		arg_53_1.duration_ = 8.7

		local var_53_0 = {
			ja = 4.566,
			ko = 8.7,
			zh = 8.7
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
				arg_53_0:Play122081014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10037ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10037ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10037ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, 100, 0)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["10037ui_story"]
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect10037ui_story == nil then
				arg_53_1.var_.characterEffect10037ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 and not isNil(var_56_9) then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11

				if arg_53_1.var_.characterEffect10037ui_story and not isNil(var_56_9) then
					local var_56_13 = Mathf.Lerp(0, 0.5, var_56_12)

					arg_53_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10037ui_story.fillRatio = var_56_13
				end
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect10037ui_story then
				local var_56_14 = 0.5

				arg_53_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10037ui_story.fillRatio = var_56_14
			end

			local var_56_15 = arg_53_1.actors_["1071ui_story"].transform
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.var_.moveOldPos1071ui_story = var_56_15.localPosition
			end

			local var_56_17 = 0.001

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17
				local var_56_19 = Vector3.New(-0.7, -1.05, -6.2)

				var_56_15.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1071ui_story, var_56_19, var_56_18)

				local var_56_20 = manager.ui.mainCamera.transform.position - var_56_15.position

				var_56_15.forward = Vector3.New(var_56_20.x, var_56_20.y, var_56_20.z)

				local var_56_21 = var_56_15.localEulerAngles

				var_56_21.z = 0
				var_56_21.x = 0
				var_56_15.localEulerAngles = var_56_21
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 then
				var_56_15.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_56_22 = manager.ui.mainCamera.transform.position - var_56_15.position

				var_56_15.forward = Vector3.New(var_56_22.x, var_56_22.y, var_56_22.z)

				local var_56_23 = var_56_15.localEulerAngles

				var_56_23.z = 0
				var_56_23.x = 0
				var_56_15.localEulerAngles = var_56_23
			end

			local var_56_24 = arg_53_1.actors_["1071ui_story"]
			local var_56_25 = 0

			if var_56_25 < arg_53_1.time_ and arg_53_1.time_ <= var_56_25 + arg_56_0 and not isNil(var_56_24) and arg_53_1.var_.characterEffect1071ui_story == nil then
				arg_53_1.var_.characterEffect1071ui_story = var_56_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_26 = 0.200000002980232

			if var_56_25 <= arg_53_1.time_ and arg_53_1.time_ < var_56_25 + var_56_26 and not isNil(var_56_24) then
				local var_56_27 = (arg_53_1.time_ - var_56_25) / var_56_26

				if arg_53_1.var_.characterEffect1071ui_story and not isNil(var_56_24) then
					arg_53_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_25 + var_56_26 and arg_53_1.time_ < var_56_25 + var_56_26 + arg_56_0 and not isNil(var_56_24) and arg_53_1.var_.characterEffect1071ui_story then
				arg_53_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_56_28 = 0

			if var_56_28 < arg_53_1.time_ and arg_53_1.time_ <= var_56_28 + arg_56_0 then
				arg_53_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_56_29 = arg_53_1.actors_["10045ui_story"].transform
			local var_56_30 = 0

			if var_56_30 < arg_53_1.time_ and arg_53_1.time_ <= var_56_30 + arg_56_0 then
				arg_53_1.var_.moveOldPos10045ui_story = var_56_29.localPosition
			end

			local var_56_31 = 0.001

			if var_56_30 <= arg_53_1.time_ and arg_53_1.time_ < var_56_30 + var_56_31 then
				local var_56_32 = (arg_53_1.time_ - var_56_30) / var_56_31
				local var_56_33 = Vector3.New(0, 100, 0)

				var_56_29.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10045ui_story, var_56_33, var_56_32)

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
			local var_56_39 = 0.925

			if var_56_38 < arg_53_1.time_ and arg_53_1.time_ <= var_56_38 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_40 = arg_53_1:FormatText(StoryNameCfg[384].name)

				arg_53_1.leftNameTxt_.text = var_56_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_41 = arg_53_1:GetWordFromCfg(122081013)
				local var_56_42 = arg_53_1:FormatText(var_56_41.content)

				arg_53_1.text_.text = var_56_42

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_43 = 37
				local var_56_44 = utf8.len(var_56_42)
				local var_56_45 = var_56_43 <= 0 and var_56_39 or var_56_39 * (var_56_44 / var_56_43)

				if var_56_45 > 0 and var_56_39 < var_56_45 then
					arg_53_1.talkMaxDuration = var_56_45

					if var_56_45 + var_56_38 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_45 + var_56_38
					end
				end

				arg_53_1.text_.text = var_56_42
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081013", "story_v_out_122081.awb") ~= 0 then
					local var_56_46 = manager.audio:GetVoiceLength("story_v_out_122081", "122081013", "story_v_out_122081.awb") / 1000

					if var_56_46 + var_56_38 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_46 + var_56_38
					end

					if var_56_41.prefab_name ~= "" and arg_53_1.actors_[var_56_41.prefab_name] ~= nil then
						local var_56_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_41.prefab_name].transform, "story_v_out_122081", "122081013", "story_v_out_122081.awb")

						arg_53_1:RecordAudio("122081013", var_56_47)
						arg_53_1:RecordAudio("122081013", var_56_47)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_122081", "122081013", "story_v_out_122081.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_122081", "122081013", "story_v_out_122081.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_48 = math.max(var_56_39, arg_53_1.talkMaxDuration)

			if var_56_38 <= arg_53_1.time_ and arg_53_1.time_ < var_56_38 + var_56_48 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_38) / var_56_48

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_38 + var_56_48 and arg_53_1.time_ < var_56_38 + var_56_48 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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
			},
			{
				assetPath = "",
				actorName = "10045ui_story",
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
	Play122081014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 122081014
		arg_57_1.duration_ = 8.1

		local var_57_0 = {
			ja = 7.933,
			ko = 8.1,
			zh = 8.1
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
				arg_57_0:Play122081015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["4037ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos4037ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0.7, -1.12, -6.2)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos4037ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["4037ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect4037ui_story == nil then
				arg_57_1.var_.characterEffect4037ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect4037ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect4037ui_story then
				arg_57_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_15 = arg_57_1.actors_["1071ui_story"]
			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 and not isNil(var_60_15) and arg_57_1.var_.characterEffect1071ui_story == nil then
				arg_57_1.var_.characterEffect1071ui_story = var_60_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_17 = 0.200000002980232

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_17 and not isNil(var_60_15) then
				local var_60_18 = (arg_57_1.time_ - var_60_16) / var_60_17

				if arg_57_1.var_.characterEffect1071ui_story and not isNil(var_60_15) then
					local var_60_19 = Mathf.Lerp(0, 0.5, var_60_18)

					arg_57_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1071ui_story.fillRatio = var_60_19
				end
			end

			if arg_57_1.time_ >= var_60_16 + var_60_17 and arg_57_1.time_ < var_60_16 + var_60_17 + arg_60_0 and not isNil(var_60_15) and arg_57_1.var_.characterEffect1071ui_story then
				local var_60_20 = 0.5

				arg_57_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1071ui_story.fillRatio = var_60_20
			end

			local var_60_21 = 0
			local var_60_22 = 0.825

			if var_60_21 < arg_57_1.time_ and arg_57_1.time_ <= var_60_21 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_23 = arg_57_1:FormatText(StoryNameCfg[453].name)

				arg_57_1.leftNameTxt_.text = var_60_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_24 = arg_57_1:GetWordFromCfg(122081014)
				local var_60_25 = arg_57_1:FormatText(var_60_24.content)

				arg_57_1.text_.text = var_60_25

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_26 = 33
				local var_60_27 = utf8.len(var_60_25)
				local var_60_28 = var_60_26 <= 0 and var_60_22 or var_60_22 * (var_60_27 / var_60_26)

				if var_60_28 > 0 and var_60_22 < var_60_28 then
					arg_57_1.talkMaxDuration = var_60_28

					if var_60_28 + var_60_21 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_28 + var_60_21
					end
				end

				arg_57_1.text_.text = var_60_25
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081014", "story_v_out_122081.awb") ~= 0 then
					local var_60_29 = manager.audio:GetVoiceLength("story_v_out_122081", "122081014", "story_v_out_122081.awb") / 1000

					if var_60_29 + var_60_21 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_29 + var_60_21
					end

					if var_60_24.prefab_name ~= "" and arg_57_1.actors_[var_60_24.prefab_name] ~= nil then
						local var_60_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_24.prefab_name].transform, "story_v_out_122081", "122081014", "story_v_out_122081.awb")

						arg_57_1:RecordAudio("122081014", var_60_30)
						arg_57_1:RecordAudio("122081014", var_60_30)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_122081", "122081014", "story_v_out_122081.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_122081", "122081014", "story_v_out_122081.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_31 = math.max(var_60_22, arg_57_1.talkMaxDuration)

			if var_60_21 <= arg_57_1.time_ and arg_57_1.time_ < var_60_21 + var_60_31 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_21) / var_60_31

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_21 + var_60_31 and arg_57_1.time_ < var_60_21 + var_60_31 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play122081015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 122081015
		arg_61_1.duration_ = 9.03

		local var_61_0 = {
			ja = 9.033,
			ko = 3.8,
			zh = 3.8
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play122081016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1071ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1071ui_story == nil then
				arg_61_1.var_.characterEffect1071ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1071ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1071ui_story then
				arg_61_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_64_5 = arg_61_1.actors_["4037ui_story"]
			local var_64_6 = 0

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect4037ui_story == nil then
				arg_61_1.var_.characterEffect4037ui_story = var_64_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_7 = 0.200000002980232

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_7 and not isNil(var_64_5) then
				local var_64_8 = (arg_61_1.time_ - var_64_6) / var_64_7

				if arg_61_1.var_.characterEffect4037ui_story and not isNil(var_64_5) then
					local var_64_9 = Mathf.Lerp(0, 0.5, var_64_8)

					arg_61_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_61_1.var_.characterEffect4037ui_story.fillRatio = var_64_9
				end
			end

			if arg_61_1.time_ >= var_64_6 + var_64_7 and arg_61_1.time_ < var_64_6 + var_64_7 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect4037ui_story then
				local var_64_10 = 0.5

				arg_61_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_61_1.var_.characterEffect4037ui_story.fillRatio = var_64_10
			end

			local var_64_11 = 0
			local var_64_12 = 0.425

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_13 = arg_61_1:FormatText(StoryNameCfg[384].name)

				arg_61_1.leftNameTxt_.text = var_64_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_14 = arg_61_1:GetWordFromCfg(122081015)
				local var_64_15 = arg_61_1:FormatText(var_64_14.content)

				arg_61_1.text_.text = var_64_15

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_16 = 17
				local var_64_17 = utf8.len(var_64_15)
				local var_64_18 = var_64_16 <= 0 and var_64_12 or var_64_12 * (var_64_17 / var_64_16)

				if var_64_18 > 0 and var_64_12 < var_64_18 then
					arg_61_1.talkMaxDuration = var_64_18

					if var_64_18 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_18 + var_64_11
					end
				end

				arg_61_1.text_.text = var_64_15
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081015", "story_v_out_122081.awb") ~= 0 then
					local var_64_19 = manager.audio:GetVoiceLength("story_v_out_122081", "122081015", "story_v_out_122081.awb") / 1000

					if var_64_19 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_11
					end

					if var_64_14.prefab_name ~= "" and arg_61_1.actors_[var_64_14.prefab_name] ~= nil then
						local var_64_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_14.prefab_name].transform, "story_v_out_122081", "122081015", "story_v_out_122081.awb")

						arg_61_1:RecordAudio("122081015", var_64_20)
						arg_61_1:RecordAudio("122081015", var_64_20)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_122081", "122081015", "story_v_out_122081.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_122081", "122081015", "story_v_out_122081.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_21 = math.max(var_64_12, arg_61_1.talkMaxDuration)

			if var_64_11 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_21 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_11) / var_64_21

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_11 + var_64_21 and arg_61_1.time_ < var_64_11 + var_64_21 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play122081016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 122081016
		arg_65_1.duration_ = 8.27

		local var_65_0 = {
			ja = 5.933,
			ko = 8.266,
			zh = 8.266
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
				arg_65_0:Play122081017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["4037ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect4037ui_story == nil then
				arg_65_1.var_.characterEffect4037ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect4037ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect4037ui_story then
				arg_65_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_68_4 = 0

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			local var_68_6 = arg_65_1.actors_["1071ui_story"]
			local var_68_7 = 0

			if var_68_7 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1071ui_story == nil then
				arg_65_1.var_.characterEffect1071ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.200000002980232

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_8 and not isNil(var_68_6) then
				local var_68_9 = (arg_65_1.time_ - var_68_7) / var_68_8

				if arg_65_1.var_.characterEffect1071ui_story and not isNil(var_68_6) then
					local var_68_10 = Mathf.Lerp(0, 0.5, var_68_9)

					arg_65_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1071ui_story.fillRatio = var_68_10
				end
			end

			if arg_65_1.time_ >= var_68_7 + var_68_8 and arg_65_1.time_ < var_68_7 + var_68_8 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1071ui_story then
				local var_68_11 = 0.5

				arg_65_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1071ui_story.fillRatio = var_68_11
			end

			local var_68_12 = 0
			local var_68_13 = 0.675

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_14 = arg_65_1:FormatText(StoryNameCfg[453].name)

				arg_65_1.leftNameTxt_.text = var_68_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(122081016)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 27
				local var_68_18 = utf8.len(var_68_16)
				local var_68_19 = var_68_17 <= 0 and var_68_13 or var_68_13 * (var_68_18 / var_68_17)

				if var_68_19 > 0 and var_68_13 < var_68_19 then
					arg_65_1.talkMaxDuration = var_68_19

					if var_68_19 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_16
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081016", "story_v_out_122081.awb") ~= 0 then
					local var_68_20 = manager.audio:GetVoiceLength("story_v_out_122081", "122081016", "story_v_out_122081.awb") / 1000

					if var_68_20 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_122081", "122081016", "story_v_out_122081.awb")

						arg_65_1:RecordAudio("122081016", var_68_21)
						arg_65_1:RecordAudio("122081016", var_68_21)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_122081", "122081016", "story_v_out_122081.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_122081", "122081016", "story_v_out_122081.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_22 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_12) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_12 + var_68_22 and arg_65_1.time_ < var_68_12 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play122081017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 122081017
		arg_69_1.duration_ = 7

		local var_69_0 = {
			ja = 6.733,
			ko = 7,
			zh = 7
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
				arg_69_0:Play122081018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.6

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[453].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(122081017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 24
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081017", "story_v_out_122081.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_122081", "122081017", "story_v_out_122081.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_122081", "122081017", "story_v_out_122081.awb")

						arg_69_1:RecordAudio("122081017", var_72_9)
						arg_69_1:RecordAudio("122081017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_122081", "122081017", "story_v_out_122081.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_122081", "122081017", "story_v_out_122081.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play122081018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 122081018
		arg_73_1.duration_ = 9.4

		local var_73_0 = {
			ja = 9.4,
			ko = 4.566,
			zh = 4.566
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play122081019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1071ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1071ui_story == nil then
				arg_73_1.var_.characterEffect1071ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1071ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1071ui_story then
				arg_73_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_76_4 = 0

			if var_76_4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action423")
			end

			local var_76_5 = 0

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_6 = arg_73_1.actors_["4037ui_story"]
			local var_76_7 = 0

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect4037ui_story == nil then
				arg_73_1.var_.characterEffect4037ui_story = var_76_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_8 = 0.200000002980232

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_8 and not isNil(var_76_6) then
				local var_76_9 = (arg_73_1.time_ - var_76_7) / var_76_8

				if arg_73_1.var_.characterEffect4037ui_story and not isNil(var_76_6) then
					local var_76_10 = Mathf.Lerp(0, 0.5, var_76_9)

					arg_73_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_73_1.var_.characterEffect4037ui_story.fillRatio = var_76_10
				end
			end

			if arg_73_1.time_ >= var_76_7 + var_76_8 and arg_73_1.time_ < var_76_7 + var_76_8 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect4037ui_story then
				local var_76_11 = 0.5

				arg_73_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_73_1.var_.characterEffect4037ui_story.fillRatio = var_76_11
			end

			local var_76_12 = 0
			local var_76_13 = 0.475

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_14 = arg_73_1:FormatText(StoryNameCfg[384].name)

				arg_73_1.leftNameTxt_.text = var_76_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_15 = arg_73_1:GetWordFromCfg(122081018)
				local var_76_16 = arg_73_1:FormatText(var_76_15.content)

				arg_73_1.text_.text = var_76_16

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_17 = 19
				local var_76_18 = utf8.len(var_76_16)
				local var_76_19 = var_76_17 <= 0 and var_76_13 or var_76_13 * (var_76_18 / var_76_17)

				if var_76_19 > 0 and var_76_13 < var_76_19 then
					arg_73_1.talkMaxDuration = var_76_19

					if var_76_19 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_12
					end
				end

				arg_73_1.text_.text = var_76_16
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081018", "story_v_out_122081.awb") ~= 0 then
					local var_76_20 = manager.audio:GetVoiceLength("story_v_out_122081", "122081018", "story_v_out_122081.awb") / 1000

					if var_76_20 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_20 + var_76_12
					end

					if var_76_15.prefab_name ~= "" and arg_73_1.actors_[var_76_15.prefab_name] ~= nil then
						local var_76_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_15.prefab_name].transform, "story_v_out_122081", "122081018", "story_v_out_122081.awb")

						arg_73_1:RecordAudio("122081018", var_76_21)
						arg_73_1:RecordAudio("122081018", var_76_21)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_122081", "122081018", "story_v_out_122081.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_122081", "122081018", "story_v_out_122081.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_22 = math.max(var_76_13, arg_73_1.talkMaxDuration)

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_22 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_12) / var_76_22

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_12 + var_76_22 and arg_73_1.time_ < var_76_12 + var_76_22 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play122081019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 122081019
		arg_77_1.duration_ = 12.33

		local var_77_0 = {
			ja = 12.333,
			ko = 7.466,
			zh = 7.466
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play122081020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["4037ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect4037ui_story == nil then
				arg_77_1.var_.characterEffect4037ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect4037ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect4037ui_story then
				arg_77_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_80_4 = arg_77_1.actors_["1071ui_story"]
			local var_80_5 = 0

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1071ui_story == nil then
				arg_77_1.var_.characterEffect1071ui_story = var_80_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_6 = 0.200000002980232

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_6 and not isNil(var_80_4) then
				local var_80_7 = (arg_77_1.time_ - var_80_5) / var_80_6

				if arg_77_1.var_.characterEffect1071ui_story and not isNil(var_80_4) then
					local var_80_8 = Mathf.Lerp(0, 0.5, var_80_7)

					arg_77_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1071ui_story.fillRatio = var_80_8
				end
			end

			if arg_77_1.time_ >= var_80_5 + var_80_6 and arg_77_1.time_ < var_80_5 + var_80_6 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1071ui_story then
				local var_80_9 = 0.5

				arg_77_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1071ui_story.fillRatio = var_80_9
			end

			local var_80_10 = 0
			local var_80_11 = 0.7

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_12 = arg_77_1:FormatText(StoryNameCfg[453].name)

				arg_77_1.leftNameTxt_.text = var_80_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_13 = arg_77_1:GetWordFromCfg(122081019)
				local var_80_14 = arg_77_1:FormatText(var_80_13.content)

				arg_77_1.text_.text = var_80_14

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 28
				local var_80_16 = utf8.len(var_80_14)
				local var_80_17 = var_80_15 <= 0 and var_80_11 or var_80_11 * (var_80_16 / var_80_15)

				if var_80_17 > 0 and var_80_11 < var_80_17 then
					arg_77_1.talkMaxDuration = var_80_17

					if var_80_17 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_10
					end
				end

				arg_77_1.text_.text = var_80_14
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081019", "story_v_out_122081.awb") ~= 0 then
					local var_80_18 = manager.audio:GetVoiceLength("story_v_out_122081", "122081019", "story_v_out_122081.awb") / 1000

					if var_80_18 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_10
					end

					if var_80_13.prefab_name ~= "" and arg_77_1.actors_[var_80_13.prefab_name] ~= nil then
						local var_80_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_13.prefab_name].transform, "story_v_out_122081", "122081019", "story_v_out_122081.awb")

						arg_77_1:RecordAudio("122081019", var_80_19)
						arg_77_1:RecordAudio("122081019", var_80_19)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_122081", "122081019", "story_v_out_122081.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_122081", "122081019", "story_v_out_122081.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_20 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_20 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_10) / var_80_20

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_10 + var_80_20 and arg_77_1.time_ < var_80_10 + var_80_20 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play122081020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 122081020
		arg_81_1.duration_ = 2

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play122081021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1071ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1071ui_story == nil then
				arg_81_1.var_.characterEffect1071ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1071ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1071ui_story then
				arg_81_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_84_4 = 0

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_2")
			end

			local var_84_5 = arg_81_1.actors_["4037ui_story"]
			local var_84_6 = 0

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect4037ui_story == nil then
				arg_81_1.var_.characterEffect4037ui_story = var_84_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_7 = 0.200000002980232

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_7 and not isNil(var_84_5) then
				local var_84_8 = (arg_81_1.time_ - var_84_6) / var_84_7

				if arg_81_1.var_.characterEffect4037ui_story and not isNil(var_84_5) then
					local var_84_9 = Mathf.Lerp(0, 0.5, var_84_8)

					arg_81_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_81_1.var_.characterEffect4037ui_story.fillRatio = var_84_9
				end
			end

			if arg_81_1.time_ >= var_84_6 + var_84_7 and arg_81_1.time_ < var_84_6 + var_84_7 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect4037ui_story then
				local var_84_10 = 0.5

				arg_81_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_81_1.var_.characterEffect4037ui_story.fillRatio = var_84_10
			end

			local var_84_11 = 0
			local var_84_12 = 0.05

			if var_84_11 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_13 = arg_81_1:FormatText(StoryNameCfg[384].name)

				arg_81_1.leftNameTxt_.text = var_84_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_14 = arg_81_1:GetWordFromCfg(122081020)
				local var_84_15 = arg_81_1:FormatText(var_84_14.content)

				arg_81_1.text_.text = var_84_15

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_16 = 2
				local var_84_17 = utf8.len(var_84_15)
				local var_84_18 = var_84_16 <= 0 and var_84_12 or var_84_12 * (var_84_17 / var_84_16)

				if var_84_18 > 0 and var_84_12 < var_84_18 then
					arg_81_1.talkMaxDuration = var_84_18

					if var_84_18 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_11
					end
				end

				arg_81_1.text_.text = var_84_15
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081020", "story_v_out_122081.awb") ~= 0 then
					local var_84_19 = manager.audio:GetVoiceLength("story_v_out_122081", "122081020", "story_v_out_122081.awb") / 1000

					if var_84_19 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_19 + var_84_11
					end

					if var_84_14.prefab_name ~= "" and arg_81_1.actors_[var_84_14.prefab_name] ~= nil then
						local var_84_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_14.prefab_name].transform, "story_v_out_122081", "122081020", "story_v_out_122081.awb")

						arg_81_1:RecordAudio("122081020", var_84_20)
						arg_81_1:RecordAudio("122081020", var_84_20)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_122081", "122081020", "story_v_out_122081.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_122081", "122081020", "story_v_out_122081.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_21 = math.max(var_84_12, arg_81_1.talkMaxDuration)

			if var_84_11 <= arg_81_1.time_ and arg_81_1.time_ < var_84_11 + var_84_21 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_11) / var_84_21

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_11 + var_84_21 and arg_81_1.time_ < var_84_11 + var_84_21 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play122081021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 122081021
		arg_85_1.duration_ = 11.73

		local var_85_0 = {
			ja = 9.5,
			ko = 11.733,
			zh = 11.733
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
				arg_85_0:Play122081022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["4037ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect4037ui_story == nil then
				arg_85_1.var_.characterEffect4037ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.034000001847744

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect4037ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_85_1.var_.characterEffect4037ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect4037ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_85_1.var_.characterEffect4037ui_story.fillRatio = var_88_5
			end

			local var_88_6 = arg_85_1.actors_["10045ui_story"].transform
			local var_88_7 = 0

			if var_88_7 < arg_85_1.time_ and arg_85_1.time_ <= var_88_7 + arg_88_0 then
				arg_85_1.var_.moveOldPos10045ui_story = var_88_6.localPosition
			end

			local var_88_8 = 0.001

			if var_88_7 <= arg_85_1.time_ and arg_85_1.time_ < var_88_7 + var_88_8 then
				local var_88_9 = (arg_85_1.time_ - var_88_7) / var_88_8
				local var_88_10 = Vector3.New(0.7, -1.18, -6.05)

				var_88_6.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10045ui_story, var_88_10, var_88_9)

				local var_88_11 = manager.ui.mainCamera.transform.position - var_88_6.position

				var_88_6.forward = Vector3.New(var_88_11.x, var_88_11.y, var_88_11.z)

				local var_88_12 = var_88_6.localEulerAngles

				var_88_12.z = 0
				var_88_12.x = 0
				var_88_6.localEulerAngles = var_88_12
			end

			if arg_85_1.time_ >= var_88_7 + var_88_8 and arg_85_1.time_ < var_88_7 + var_88_8 + arg_88_0 then
				var_88_6.localPosition = Vector3.New(0.7, -1.18, -6.05)

				local var_88_13 = manager.ui.mainCamera.transform.position - var_88_6.position

				var_88_6.forward = Vector3.New(var_88_13.x, var_88_13.y, var_88_13.z)

				local var_88_14 = var_88_6.localEulerAngles

				var_88_14.z = 0
				var_88_14.x = 0
				var_88_6.localEulerAngles = var_88_14
			end

			local var_88_15 = arg_85_1.actors_["1071ui_story"]
			local var_88_16 = 0

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.characterEffect1071ui_story == nil then
				arg_85_1.var_.characterEffect1071ui_story = var_88_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_17 = 0.200000002980232

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_17 and not isNil(var_88_15) then
				local var_88_18 = (arg_85_1.time_ - var_88_16) / var_88_17

				if arg_85_1.var_.characterEffect1071ui_story and not isNil(var_88_15) then
					local var_88_19 = Mathf.Lerp(0, 0.5, var_88_18)

					arg_85_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1071ui_story.fillRatio = var_88_19
				end
			end

			if arg_85_1.time_ >= var_88_16 + var_88_17 and arg_85_1.time_ < var_88_16 + var_88_17 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.characterEffect1071ui_story then
				local var_88_20 = 0.5

				arg_85_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1071ui_story.fillRatio = var_88_20
			end

			local var_88_21 = arg_85_1.actors_["10045ui_story"]
			local var_88_22 = 0

			if var_88_22 < arg_85_1.time_ and arg_85_1.time_ <= var_88_22 + arg_88_0 and not isNil(var_88_21) and arg_85_1.var_.characterEffect10045ui_story == nil then
				arg_85_1.var_.characterEffect10045ui_story = var_88_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_23 = 0.200000002980232

			if var_88_22 <= arg_85_1.time_ and arg_85_1.time_ < var_88_22 + var_88_23 and not isNil(var_88_21) then
				local var_88_24 = (arg_85_1.time_ - var_88_22) / var_88_23

				if arg_85_1.var_.characterEffect10045ui_story and not isNil(var_88_21) then
					arg_85_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_22 + var_88_23 and arg_85_1.time_ < var_88_22 + var_88_23 + arg_88_0 and not isNil(var_88_21) and arg_85_1.var_.characterEffect10045ui_story then
				arg_85_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_88_25 = arg_85_1.actors_["4037ui_story"].transform
			local var_88_26 = 0

			if var_88_26 < arg_85_1.time_ and arg_85_1.time_ <= var_88_26 + arg_88_0 then
				arg_85_1.var_.moveOldPos4037ui_story = var_88_25.localPosition
			end

			local var_88_27 = 0.001

			if var_88_26 <= arg_85_1.time_ and arg_85_1.time_ < var_88_26 + var_88_27 then
				local var_88_28 = (arg_85_1.time_ - var_88_26) / var_88_27
				local var_88_29 = Vector3.New(0, 100, 0)

				var_88_25.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos4037ui_story, var_88_29, var_88_28)

				local var_88_30 = manager.ui.mainCamera.transform.position - var_88_25.position

				var_88_25.forward = Vector3.New(var_88_30.x, var_88_30.y, var_88_30.z)

				local var_88_31 = var_88_25.localEulerAngles

				var_88_31.z = 0
				var_88_31.x = 0
				var_88_25.localEulerAngles = var_88_31
			end

			if arg_85_1.time_ >= var_88_26 + var_88_27 and arg_85_1.time_ < var_88_26 + var_88_27 + arg_88_0 then
				var_88_25.localPosition = Vector3.New(0, 100, 0)

				local var_88_32 = manager.ui.mainCamera.transform.position - var_88_25.position

				var_88_25.forward = Vector3.New(var_88_32.x, var_88_32.y, var_88_32.z)

				local var_88_33 = var_88_25.localEulerAngles

				var_88_33.z = 0
				var_88_33.x = 0
				var_88_25.localEulerAngles = var_88_33
			end

			local var_88_34 = 0

			if var_88_34 < arg_85_1.time_ and arg_85_1.time_ <= var_88_34 + arg_88_0 then
				arg_85_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_1")
			end

			local var_88_35 = 0
			local var_88_36 = 1.15

			if var_88_35 < arg_85_1.time_ and arg_85_1.time_ <= var_88_35 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_37 = arg_85_1:FormatText(StoryNameCfg[45].name)

				arg_85_1.leftNameTxt_.text = var_88_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_38 = arg_85_1:GetWordFromCfg(122081021)
				local var_88_39 = arg_85_1:FormatText(var_88_38.content)

				arg_85_1.text_.text = var_88_39

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_40 = 46
				local var_88_41 = utf8.len(var_88_39)
				local var_88_42 = var_88_40 <= 0 and var_88_36 or var_88_36 * (var_88_41 / var_88_40)

				if var_88_42 > 0 and var_88_36 < var_88_42 then
					arg_85_1.talkMaxDuration = var_88_42

					if var_88_42 + var_88_35 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_42 + var_88_35
					end
				end

				arg_85_1.text_.text = var_88_39
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081021", "story_v_out_122081.awb") ~= 0 then
					local var_88_43 = manager.audio:GetVoiceLength("story_v_out_122081", "122081021", "story_v_out_122081.awb") / 1000

					if var_88_43 + var_88_35 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_43 + var_88_35
					end

					if var_88_38.prefab_name ~= "" and arg_85_1.actors_[var_88_38.prefab_name] ~= nil then
						local var_88_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_38.prefab_name].transform, "story_v_out_122081", "122081021", "story_v_out_122081.awb")

						arg_85_1:RecordAudio("122081021", var_88_44)
						arg_85_1:RecordAudio("122081021", var_88_44)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_122081", "122081021", "story_v_out_122081.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_122081", "122081021", "story_v_out_122081.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_45 = math.max(var_88_36, arg_85_1.talkMaxDuration)

			if var_88_35 <= arg_85_1.time_ and arg_85_1.time_ < var_88_35 + var_88_45 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_35) / var_88_45

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_35 + var_88_45 and arg_85_1.time_ < var_88_35 + var_88_45 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play122081022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 122081022
		arg_89_1.duration_ = 8.6

		local var_89_0 = {
			ja = 8.6,
			ko = 5.6,
			zh = 5.6
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play122081023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1071ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1071ui_story == nil then
				arg_89_1.var_.characterEffect1071ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1071ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1071ui_story then
				arg_89_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_92_4 = 0

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_92_5 = arg_89_1.actors_["10045ui_story"]
			local var_92_6 = 0

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.characterEffect10045ui_story == nil then
				arg_89_1.var_.characterEffect10045ui_story = var_92_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_7 = 0.200000002980232

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_7 and not isNil(var_92_5) then
				local var_92_8 = (arg_89_1.time_ - var_92_6) / var_92_7

				if arg_89_1.var_.characterEffect10045ui_story and not isNil(var_92_5) then
					local var_92_9 = Mathf.Lerp(0, 0.5, var_92_8)

					arg_89_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10045ui_story.fillRatio = var_92_9
				end
			end

			if arg_89_1.time_ >= var_92_6 + var_92_7 and arg_89_1.time_ < var_92_6 + var_92_7 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.characterEffect10045ui_story then
				local var_92_10 = 0.5

				arg_89_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10045ui_story.fillRatio = var_92_10
			end

			local var_92_11 = 0
			local var_92_12 = 0.525

			if var_92_11 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_13 = arg_89_1:FormatText(StoryNameCfg[384].name)

				arg_89_1.leftNameTxt_.text = var_92_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_14 = arg_89_1:GetWordFromCfg(122081022)
				local var_92_15 = arg_89_1:FormatText(var_92_14.content)

				arg_89_1.text_.text = var_92_15

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_16 = 21
				local var_92_17 = utf8.len(var_92_15)
				local var_92_18 = var_92_16 <= 0 and var_92_12 or var_92_12 * (var_92_17 / var_92_16)

				if var_92_18 > 0 and var_92_12 < var_92_18 then
					arg_89_1.talkMaxDuration = var_92_18

					if var_92_18 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_18 + var_92_11
					end
				end

				arg_89_1.text_.text = var_92_15
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081022", "story_v_out_122081.awb") ~= 0 then
					local var_92_19 = manager.audio:GetVoiceLength("story_v_out_122081", "122081022", "story_v_out_122081.awb") / 1000

					if var_92_19 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_19 + var_92_11
					end

					if var_92_14.prefab_name ~= "" and arg_89_1.actors_[var_92_14.prefab_name] ~= nil then
						local var_92_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_14.prefab_name].transform, "story_v_out_122081", "122081022", "story_v_out_122081.awb")

						arg_89_1:RecordAudio("122081022", var_92_20)
						arg_89_1:RecordAudio("122081022", var_92_20)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_122081", "122081022", "story_v_out_122081.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_122081", "122081022", "story_v_out_122081.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_21 = math.max(var_92_12, arg_89_1.talkMaxDuration)

			if var_92_11 <= arg_89_1.time_ and arg_89_1.time_ < var_92_11 + var_92_21 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_11) / var_92_21

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_11 + var_92_21 and arg_89_1.time_ < var_92_11 + var_92_21 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play122081023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 122081023
		arg_93_1.duration_ = 7.13

		local var_93_0 = {
			ja = 6.5,
			ko = 7.133,
			zh = 7.133
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play122081024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10045ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10045ui_story == nil then
				arg_93_1.var_.characterEffect10045ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect10045ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10045ui_story then
				arg_93_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_96_4 = arg_93_1.actors_["1071ui_story"]
			local var_96_5 = 0

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect1071ui_story == nil then
				arg_93_1.var_.characterEffect1071ui_story = var_96_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_6 = 0.200000002980232

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_6 and not isNil(var_96_4) then
				local var_96_7 = (arg_93_1.time_ - var_96_5) / var_96_6

				if arg_93_1.var_.characterEffect1071ui_story and not isNil(var_96_4) then
					local var_96_8 = Mathf.Lerp(0, 0.5, var_96_7)

					arg_93_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1071ui_story.fillRatio = var_96_8
				end
			end

			if arg_93_1.time_ >= var_96_5 + var_96_6 and arg_93_1.time_ < var_96_5 + var_96_6 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect1071ui_story then
				local var_96_9 = 0.5

				arg_93_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1071ui_story.fillRatio = var_96_9
			end

			local var_96_10 = 0
			local var_96_11 = 0.525

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_12 = arg_93_1:FormatText(StoryNameCfg[45].name)

				arg_93_1.leftNameTxt_.text = var_96_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_13 = arg_93_1:GetWordFromCfg(122081023)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_15 = 21
				local var_96_16 = utf8.len(var_96_14)
				local var_96_17 = var_96_15 <= 0 and var_96_11 or var_96_11 * (var_96_16 / var_96_15)

				if var_96_17 > 0 and var_96_11 < var_96_17 then
					arg_93_1.talkMaxDuration = var_96_17

					if var_96_17 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_10
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081023", "story_v_out_122081.awb") ~= 0 then
					local var_96_18 = manager.audio:GetVoiceLength("story_v_out_122081", "122081023", "story_v_out_122081.awb") / 1000

					if var_96_18 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_10
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_122081", "122081023", "story_v_out_122081.awb")

						arg_93_1:RecordAudio("122081023", var_96_19)
						arg_93_1:RecordAudio("122081023", var_96_19)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_122081", "122081023", "story_v_out_122081.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_122081", "122081023", "story_v_out_122081.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_20 = math.max(var_96_11, arg_93_1.talkMaxDuration)

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_20 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_10) / var_96_20

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_10 + var_96_20 and arg_93_1.time_ < var_96_10 + var_96_20 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play122081024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 122081024
		arg_97_1.duration_ = 3.23

		local var_97_0 = {
			ja = 1.5,
			ko = 3.233,
			zh = 3.233
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play122081025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1071ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1071ui_story == nil then
				arg_97_1.var_.characterEffect1071ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1071ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1071ui_story then
				arg_97_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_100_4 = arg_97_1.actors_["10045ui_story"]
			local var_100_5 = 0

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect10045ui_story == nil then
				arg_97_1.var_.characterEffect10045ui_story = var_100_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_6 = 0.200000002980232

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_6 and not isNil(var_100_4) then
				local var_100_7 = (arg_97_1.time_ - var_100_5) / var_100_6

				if arg_97_1.var_.characterEffect10045ui_story and not isNil(var_100_4) then
					local var_100_8 = Mathf.Lerp(0, 0.5, var_100_7)

					arg_97_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10045ui_story.fillRatio = var_100_8
				end
			end

			if arg_97_1.time_ >= var_100_5 + var_100_6 and arg_97_1.time_ < var_100_5 + var_100_6 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect10045ui_story then
				local var_100_9 = 0.5

				arg_97_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10045ui_story.fillRatio = var_100_9
			end

			local var_100_10 = 0
			local var_100_11 = 0.15

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_12 = arg_97_1:FormatText(StoryNameCfg[384].name)

				arg_97_1.leftNameTxt_.text = var_100_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_13 = arg_97_1:GetWordFromCfg(122081024)
				local var_100_14 = arg_97_1:FormatText(var_100_13.content)

				arg_97_1.text_.text = var_100_14

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_15 = 6
				local var_100_16 = utf8.len(var_100_14)
				local var_100_17 = var_100_15 <= 0 and var_100_11 or var_100_11 * (var_100_16 / var_100_15)

				if var_100_17 > 0 and var_100_11 < var_100_17 then
					arg_97_1.talkMaxDuration = var_100_17

					if var_100_17 + var_100_10 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_17 + var_100_10
					end
				end

				arg_97_1.text_.text = var_100_14
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081024", "story_v_out_122081.awb") ~= 0 then
					local var_100_18 = manager.audio:GetVoiceLength("story_v_out_122081", "122081024", "story_v_out_122081.awb") / 1000

					if var_100_18 + var_100_10 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_18 + var_100_10
					end

					if var_100_13.prefab_name ~= "" and arg_97_1.actors_[var_100_13.prefab_name] ~= nil then
						local var_100_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_13.prefab_name].transform, "story_v_out_122081", "122081024", "story_v_out_122081.awb")

						arg_97_1:RecordAudio("122081024", var_100_19)
						arg_97_1:RecordAudio("122081024", var_100_19)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_122081", "122081024", "story_v_out_122081.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_122081", "122081024", "story_v_out_122081.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_20 = math.max(var_100_11, arg_97_1.talkMaxDuration)

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_20 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_10) / var_100_20

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_10 + var_100_20 and arg_97_1.time_ < var_100_10 + var_100_20 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play122081025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 122081025
		arg_101_1.duration_ = 8.5

		local var_101_0 = {
			ja = 8.5,
			ko = 5.7,
			zh = 5.7
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play122081026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["4037ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos4037ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0.7, -1.12, -6.2)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos4037ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["4037ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect4037ui_story == nil then
				arg_101_1.var_.characterEffect4037ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect4037ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect4037ui_story then
				arg_101_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action5_1")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_104_15 = arg_101_1.actors_["10045ui_story"].transform
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.var_.moveOldPos10045ui_story = var_104_15.localPosition
			end

			local var_104_17 = 0.001

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17
				local var_104_19 = Vector3.New(0, 100, 0)

				var_104_15.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10045ui_story, var_104_19, var_104_18)

				local var_104_20 = manager.ui.mainCamera.transform.position - var_104_15.position

				var_104_15.forward = Vector3.New(var_104_20.x, var_104_20.y, var_104_20.z)

				local var_104_21 = var_104_15.localEulerAngles

				var_104_21.z = 0
				var_104_21.x = 0
				var_104_15.localEulerAngles = var_104_21
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 then
				var_104_15.localPosition = Vector3.New(0, 100, 0)

				local var_104_22 = manager.ui.mainCamera.transform.position - var_104_15.position

				var_104_15.forward = Vector3.New(var_104_22.x, var_104_22.y, var_104_22.z)

				local var_104_23 = var_104_15.localEulerAngles

				var_104_23.z = 0
				var_104_23.x = 0
				var_104_15.localEulerAngles = var_104_23
			end

			local var_104_24 = arg_101_1.actors_["10045ui_story"]
			local var_104_25 = 0

			if var_104_25 < arg_101_1.time_ and arg_101_1.time_ <= var_104_25 + arg_104_0 and not isNil(var_104_24) and arg_101_1.var_.characterEffect10045ui_story == nil then
				arg_101_1.var_.characterEffect10045ui_story = var_104_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_26 = 0.200000002980232

			if var_104_25 <= arg_101_1.time_ and arg_101_1.time_ < var_104_25 + var_104_26 and not isNil(var_104_24) then
				local var_104_27 = (arg_101_1.time_ - var_104_25) / var_104_26

				if arg_101_1.var_.characterEffect10045ui_story and not isNil(var_104_24) then
					local var_104_28 = Mathf.Lerp(0, 0.5, var_104_27)

					arg_101_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10045ui_story.fillRatio = var_104_28
				end
			end

			if arg_101_1.time_ >= var_104_25 + var_104_26 and arg_101_1.time_ < var_104_25 + var_104_26 + arg_104_0 and not isNil(var_104_24) and arg_101_1.var_.characterEffect10045ui_story then
				local var_104_29 = 0.5

				arg_101_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10045ui_story.fillRatio = var_104_29
			end

			local var_104_30 = arg_101_1.actors_["1071ui_story"]
			local var_104_31 = 0

			if var_104_31 < arg_101_1.time_ and arg_101_1.time_ <= var_104_31 + arg_104_0 and not isNil(var_104_30) and arg_101_1.var_.characterEffect1071ui_story == nil then
				arg_101_1.var_.characterEffect1071ui_story = var_104_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_32 = 0.200000002980232

			if var_104_31 <= arg_101_1.time_ and arg_101_1.time_ < var_104_31 + var_104_32 and not isNil(var_104_30) then
				local var_104_33 = (arg_101_1.time_ - var_104_31) / var_104_32

				if arg_101_1.var_.characterEffect1071ui_story and not isNil(var_104_30) then
					local var_104_34 = Mathf.Lerp(0, 0.5, var_104_33)

					arg_101_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1071ui_story.fillRatio = var_104_34
				end
			end

			if arg_101_1.time_ >= var_104_31 + var_104_32 and arg_101_1.time_ < var_104_31 + var_104_32 + arg_104_0 and not isNil(var_104_30) and arg_101_1.var_.characterEffect1071ui_story then
				local var_104_35 = 0.5

				arg_101_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1071ui_story.fillRatio = var_104_35
			end

			local var_104_36 = 0
			local var_104_37 = 0.525

			if var_104_36 < arg_101_1.time_ and arg_101_1.time_ <= var_104_36 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_38 = arg_101_1:FormatText(StoryNameCfg[453].name)

				arg_101_1.leftNameTxt_.text = var_104_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_39 = arg_101_1:GetWordFromCfg(122081025)
				local var_104_40 = arg_101_1:FormatText(var_104_39.content)

				arg_101_1.text_.text = var_104_40

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_41 = 21
				local var_104_42 = utf8.len(var_104_40)
				local var_104_43 = var_104_41 <= 0 and var_104_37 or var_104_37 * (var_104_42 / var_104_41)

				if var_104_43 > 0 and var_104_37 < var_104_43 then
					arg_101_1.talkMaxDuration = var_104_43

					if var_104_43 + var_104_36 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_43 + var_104_36
					end
				end

				arg_101_1.text_.text = var_104_40
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081025", "story_v_out_122081.awb") ~= 0 then
					local var_104_44 = manager.audio:GetVoiceLength("story_v_out_122081", "122081025", "story_v_out_122081.awb") / 1000

					if var_104_44 + var_104_36 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_44 + var_104_36
					end

					if var_104_39.prefab_name ~= "" and arg_101_1.actors_[var_104_39.prefab_name] ~= nil then
						local var_104_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_39.prefab_name].transform, "story_v_out_122081", "122081025", "story_v_out_122081.awb")

						arg_101_1:RecordAudio("122081025", var_104_45)
						arg_101_1:RecordAudio("122081025", var_104_45)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_122081", "122081025", "story_v_out_122081.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_122081", "122081025", "story_v_out_122081.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_46 = math.max(var_104_37, arg_101_1.talkMaxDuration)

			if var_104_36 <= arg_101_1.time_ and arg_101_1.time_ < var_104_36 + var_104_46 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_36) / var_104_46

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_36 + var_104_46 and arg_101_1.time_ < var_104_36 + var_104_46 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play122081026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 122081026
		arg_105_1.duration_ = 5.37

		local var_105_0 = {
			ja = 4.6,
			ko = 5.366,
			zh = 5.366
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play122081027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_1 = 0
			local var_108_2 = 0.5

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_3 = arg_105_1:FormatText(StoryNameCfg[453].name)

				arg_105_1.leftNameTxt_.text = var_108_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(122081026)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_6 = 20
				local var_108_7 = utf8.len(var_108_5)
				local var_108_8 = var_108_6 <= 0 and var_108_2 or var_108_2 * (var_108_7 / var_108_6)

				if var_108_8 > 0 and var_108_2 < var_108_8 then
					arg_105_1.talkMaxDuration = var_108_8

					if var_108_8 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081026", "story_v_out_122081.awb") ~= 0 then
					local var_108_9 = manager.audio:GetVoiceLength("story_v_out_122081", "122081026", "story_v_out_122081.awb") / 1000

					if var_108_9 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_1
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_out_122081", "122081026", "story_v_out_122081.awb")

						arg_105_1:RecordAudio("122081026", var_108_10)
						arg_105_1:RecordAudio("122081026", var_108_10)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_122081", "122081026", "story_v_out_122081.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_122081", "122081026", "story_v_out_122081.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_11 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_11 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_11

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_11 and arg_105_1.time_ < var_108_1 + var_108_11 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play122081027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 122081027
		arg_109_1.duration_ = 4.03

		local var_109_0 = {
			ja = 4.033,
			ko = 2.4,
			zh = 2.4
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play122081028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["4037ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos4037ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, 100, 0)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos4037ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, 100, 0)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["4037ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect4037ui_story == nil then
				arg_109_1.var_.characterEffect4037ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect4037ui_story and not isNil(var_112_9) then
					local var_112_13 = Mathf.Lerp(0, 0.5, var_112_12)

					arg_109_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_109_1.var_.characterEffect4037ui_story.fillRatio = var_112_13
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect4037ui_story then
				local var_112_14 = 0.5

				arg_109_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_109_1.var_.characterEffect4037ui_story.fillRatio = var_112_14
			end

			local var_112_15 = arg_109_1.actors_["1071ui_story"].transform
			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.var_.moveOldPos1071ui_story = var_112_15.localPosition
			end

			local var_112_17 = 0.001

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17
				local var_112_19 = Vector3.New(0, 100, 0)

				var_112_15.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1071ui_story, var_112_19, var_112_18)

				local var_112_20 = manager.ui.mainCamera.transform.position - var_112_15.position

				var_112_15.forward = Vector3.New(var_112_20.x, var_112_20.y, var_112_20.z)

				local var_112_21 = var_112_15.localEulerAngles

				var_112_21.z = 0
				var_112_21.x = 0
				var_112_15.localEulerAngles = var_112_21
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 then
				var_112_15.localPosition = Vector3.New(0, 100, 0)

				local var_112_22 = manager.ui.mainCamera.transform.position - var_112_15.position

				var_112_15.forward = Vector3.New(var_112_22.x, var_112_22.y, var_112_22.z)

				local var_112_23 = var_112_15.localEulerAngles

				var_112_23.z = 0
				var_112_23.x = 0
				var_112_15.localEulerAngles = var_112_23
			end

			local var_112_24 = arg_109_1.actors_["1071ui_story"]
			local var_112_25 = 0

			if var_112_25 < arg_109_1.time_ and arg_109_1.time_ <= var_112_25 + arg_112_0 and not isNil(var_112_24) and arg_109_1.var_.characterEffect1071ui_story == nil then
				arg_109_1.var_.characterEffect1071ui_story = var_112_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_26 = 0.200000002980232

			if var_112_25 <= arg_109_1.time_ and arg_109_1.time_ < var_112_25 + var_112_26 and not isNil(var_112_24) then
				local var_112_27 = (arg_109_1.time_ - var_112_25) / var_112_26

				if arg_109_1.var_.characterEffect1071ui_story and not isNil(var_112_24) then
					local var_112_28 = Mathf.Lerp(0, 0.5, var_112_27)

					arg_109_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1071ui_story.fillRatio = var_112_28
				end
			end

			if arg_109_1.time_ >= var_112_25 + var_112_26 and arg_109_1.time_ < var_112_25 + var_112_26 + arg_112_0 and not isNil(var_112_24) and arg_109_1.var_.characterEffect1071ui_story then
				local var_112_29 = 0.5

				arg_109_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1071ui_story.fillRatio = var_112_29
			end

			local var_112_30 = "1184ui_story"

			if arg_109_1.actors_[var_112_30] == nil then
				local var_112_31 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_112_31) then
					local var_112_32 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_109_1.stage_.transform)

					var_112_32.name = var_112_30
					var_112_32.transform.localPosition = Vector3.New(0, 100, 0)
					arg_109_1.actors_[var_112_30] = var_112_32

					local var_112_33 = var_112_32:GetComponentInChildren(typeof(CharacterEffect))

					var_112_33.enabled = true

					local var_112_34 = GameObjectTools.GetOrAddComponent(var_112_32, typeof(DynamicBoneHelper))

					if var_112_34 then
						var_112_34:EnableDynamicBone(false)
					end

					arg_109_1:ShowWeapon(var_112_33.transform, false)

					arg_109_1.var_[var_112_30 .. "Animator"] = var_112_33.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_109_1.var_[var_112_30 .. "Animator"].applyRootMotion = true
					arg_109_1.var_[var_112_30 .. "LipSync"] = var_112_33.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_112_35 = arg_109_1.actors_["1184ui_story"].transform
			local var_112_36 = 0

			if var_112_36 < arg_109_1.time_ and arg_109_1.time_ <= var_112_36 + arg_112_0 then
				arg_109_1.var_.moveOldPos1184ui_story = var_112_35.localPosition
			end

			local var_112_37 = 0.001

			if var_112_36 <= arg_109_1.time_ and arg_109_1.time_ < var_112_36 + var_112_37 then
				local var_112_38 = (arg_109_1.time_ - var_112_36) / var_112_37
				local var_112_39 = Vector3.New(0, -0.97, -6)

				var_112_35.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1184ui_story, var_112_39, var_112_38)

				local var_112_40 = manager.ui.mainCamera.transform.position - var_112_35.position

				var_112_35.forward = Vector3.New(var_112_40.x, var_112_40.y, var_112_40.z)

				local var_112_41 = var_112_35.localEulerAngles

				var_112_41.z = 0
				var_112_41.x = 0
				var_112_35.localEulerAngles = var_112_41
			end

			if arg_109_1.time_ >= var_112_36 + var_112_37 and arg_109_1.time_ < var_112_36 + var_112_37 + arg_112_0 then
				var_112_35.localPosition = Vector3.New(0, -0.97, -6)

				local var_112_42 = manager.ui.mainCamera.transform.position - var_112_35.position

				var_112_35.forward = Vector3.New(var_112_42.x, var_112_42.y, var_112_42.z)

				local var_112_43 = var_112_35.localEulerAngles

				var_112_43.z = 0
				var_112_43.x = 0
				var_112_35.localEulerAngles = var_112_43
			end

			local var_112_44 = arg_109_1.actors_["1184ui_story"]
			local var_112_45 = 0

			if var_112_45 < arg_109_1.time_ and arg_109_1.time_ <= var_112_45 + arg_112_0 and not isNil(var_112_44) and arg_109_1.var_.characterEffect1184ui_story == nil then
				arg_109_1.var_.characterEffect1184ui_story = var_112_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_46 = 0.200000002980232

			if var_112_45 <= arg_109_1.time_ and arg_109_1.time_ < var_112_45 + var_112_46 and not isNil(var_112_44) then
				local var_112_47 = (arg_109_1.time_ - var_112_45) / var_112_46

				if arg_109_1.var_.characterEffect1184ui_story and not isNil(var_112_44) then
					arg_109_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_45 + var_112_46 and arg_109_1.time_ < var_112_45 + var_112_46 + arg_112_0 and not isNil(var_112_44) and arg_109_1.var_.characterEffect1184ui_story then
				arg_109_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_112_48 = 0

			if var_112_48 < arg_109_1.time_ and arg_109_1.time_ <= var_112_48 + arg_112_0 then
				arg_109_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_112_49 = 0

			if var_112_49 < arg_109_1.time_ and arg_109_1.time_ <= var_112_49 + arg_112_0 then
				arg_109_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_112_50 = 0
			local var_112_51 = 0.325

			if var_112_50 < arg_109_1.time_ and arg_109_1.time_ <= var_112_50 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_52 = arg_109_1:FormatText(StoryNameCfg[6].name)

				arg_109_1.leftNameTxt_.text = var_112_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_53 = arg_109_1:GetWordFromCfg(122081027)
				local var_112_54 = arg_109_1:FormatText(var_112_53.content)

				arg_109_1.text_.text = var_112_54

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_55 = 13
				local var_112_56 = utf8.len(var_112_54)
				local var_112_57 = var_112_55 <= 0 and var_112_51 or var_112_51 * (var_112_56 / var_112_55)

				if var_112_57 > 0 and var_112_51 < var_112_57 then
					arg_109_1.talkMaxDuration = var_112_57

					if var_112_57 + var_112_50 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_57 + var_112_50
					end
				end

				arg_109_1.text_.text = var_112_54
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081027", "story_v_out_122081.awb") ~= 0 then
					local var_112_58 = manager.audio:GetVoiceLength("story_v_out_122081", "122081027", "story_v_out_122081.awb") / 1000

					if var_112_58 + var_112_50 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_58 + var_112_50
					end

					if var_112_53.prefab_name ~= "" and arg_109_1.actors_[var_112_53.prefab_name] ~= nil then
						local var_112_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_53.prefab_name].transform, "story_v_out_122081", "122081027", "story_v_out_122081.awb")

						arg_109_1:RecordAudio("122081027", var_112_59)
						arg_109_1:RecordAudio("122081027", var_112_59)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_122081", "122081027", "story_v_out_122081.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_122081", "122081027", "story_v_out_122081.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_60 = math.max(var_112_51, arg_109_1.talkMaxDuration)

			if var_112_50 <= arg_109_1.time_ and arg_109_1.time_ < var_112_50 + var_112_60 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_50) / var_112_60

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_50 + var_112_60 and arg_109_1.time_ < var_112_50 + var_112_60 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play122081028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 122081028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play122081029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1184ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1184ui_story == nil then
				arg_113_1.var_.characterEffect1184ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1184ui_story and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1184ui_story.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1184ui_story then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1184ui_story.fillRatio = var_116_5
			end

			local var_116_6 = 0
			local var_116_7 = 0.5

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_8 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_9 = arg_113_1:GetWordFromCfg(122081028)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 20
				local var_116_12 = utf8.len(var_116_10)
				local var_116_13 = var_116_11 <= 0 and var_116_7 or var_116_7 * (var_116_12 / var_116_11)

				if var_116_13 > 0 and var_116_7 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play122081029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 122081029
		arg_117_1.duration_ = 7.5

		local var_117_0 = {
			ja = 7.5,
			ko = 3.5,
			zh = 3.5
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play122081030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1184ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1184ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0, 100, 0)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1184ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, 100, 0)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["1184ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1184ui_story == nil then
				arg_117_1.var_.characterEffect1184ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect1184ui_story and not isNil(var_120_9) then
					local var_120_13 = Mathf.Lerp(0, 0.5, var_120_12)

					arg_117_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1184ui_story.fillRatio = var_120_13
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1184ui_story then
				local var_120_14 = 0.5

				arg_117_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1184ui_story.fillRatio = var_120_14
			end

			local var_120_15 = arg_117_1.actors_["4037ui_story"].transform
			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1.var_.moveOldPos4037ui_story = var_120_15.localPosition
			end

			local var_120_17 = 0.001

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 then
				local var_120_18 = (arg_117_1.time_ - var_120_16) / var_120_17
				local var_120_19 = Vector3.New(0, -1.12, -6.2)

				var_120_15.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos4037ui_story, var_120_19, var_120_18)

				local var_120_20 = manager.ui.mainCamera.transform.position - var_120_15.position

				var_120_15.forward = Vector3.New(var_120_20.x, var_120_20.y, var_120_20.z)

				local var_120_21 = var_120_15.localEulerAngles

				var_120_21.z = 0
				var_120_21.x = 0
				var_120_15.localEulerAngles = var_120_21
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 then
				var_120_15.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_120_22 = manager.ui.mainCamera.transform.position - var_120_15.position

				var_120_15.forward = Vector3.New(var_120_22.x, var_120_22.y, var_120_22.z)

				local var_120_23 = var_120_15.localEulerAngles

				var_120_23.z = 0
				var_120_23.x = 0
				var_120_15.localEulerAngles = var_120_23
			end

			local var_120_24 = arg_117_1.actors_["4037ui_story"]
			local var_120_25 = 0

			if var_120_25 < arg_117_1.time_ and arg_117_1.time_ <= var_120_25 + arg_120_0 and not isNil(var_120_24) and arg_117_1.var_.characterEffect4037ui_story == nil then
				arg_117_1.var_.characterEffect4037ui_story = var_120_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_26 = 0.200000002980232

			if var_120_25 <= arg_117_1.time_ and arg_117_1.time_ < var_120_25 + var_120_26 and not isNil(var_120_24) then
				local var_120_27 = (arg_117_1.time_ - var_120_25) / var_120_26

				if arg_117_1.var_.characterEffect4037ui_story and not isNil(var_120_24) then
					arg_117_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_25 + var_120_26 and arg_117_1.time_ < var_120_25 + var_120_26 + arg_120_0 and not isNil(var_120_24) and arg_117_1.var_.characterEffect4037ui_story then
				arg_117_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_120_28 = 0

			if var_120_28 < arg_117_1.time_ and arg_117_1.time_ <= var_120_28 + arg_120_0 then
				arg_117_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_120_29 = 0

			if var_120_29 < arg_117_1.time_ and arg_117_1.time_ <= var_120_29 + arg_120_0 then
				arg_117_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_30 = 0
			local var_120_31 = 0.35

			if var_120_30 < arg_117_1.time_ and arg_117_1.time_ <= var_120_30 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_32 = arg_117_1:FormatText(StoryNameCfg[453].name)

				arg_117_1.leftNameTxt_.text = var_120_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_33 = arg_117_1:GetWordFromCfg(122081029)
				local var_120_34 = arg_117_1:FormatText(var_120_33.content)

				arg_117_1.text_.text = var_120_34

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_35 = 14
				local var_120_36 = utf8.len(var_120_34)
				local var_120_37 = var_120_35 <= 0 and var_120_31 or var_120_31 * (var_120_36 / var_120_35)

				if var_120_37 > 0 and var_120_31 < var_120_37 then
					arg_117_1.talkMaxDuration = var_120_37

					if var_120_37 + var_120_30 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_37 + var_120_30
					end
				end

				arg_117_1.text_.text = var_120_34
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081029", "story_v_out_122081.awb") ~= 0 then
					local var_120_38 = manager.audio:GetVoiceLength("story_v_out_122081", "122081029", "story_v_out_122081.awb") / 1000

					if var_120_38 + var_120_30 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_38 + var_120_30
					end

					if var_120_33.prefab_name ~= "" and arg_117_1.actors_[var_120_33.prefab_name] ~= nil then
						local var_120_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_33.prefab_name].transform, "story_v_out_122081", "122081029", "story_v_out_122081.awb")

						arg_117_1:RecordAudio("122081029", var_120_39)
						arg_117_1:RecordAudio("122081029", var_120_39)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_122081", "122081029", "story_v_out_122081.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_122081", "122081029", "story_v_out_122081.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_40 = math.max(var_120_31, arg_117_1.talkMaxDuration)

			if var_120_30 <= arg_117_1.time_ and arg_117_1.time_ < var_120_30 + var_120_40 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_30) / var_120_40

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_30 + var_120_40 and arg_117_1.time_ < var_120_30 + var_120_40 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play122081030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 122081030
		arg_121_1.duration_ = 4.03

		local var_121_0 = {
			ja = 4.033,
			ko = 2.8,
			zh = 2.8
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play122081031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["4037ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos4037ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, 100, 0)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos4037ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, 100, 0)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["4037ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect4037ui_story == nil then
				arg_121_1.var_.characterEffect4037ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect4037ui_story and not isNil(var_124_9) then
					local var_124_13 = Mathf.Lerp(0, 0.5, var_124_12)

					arg_121_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_121_1.var_.characterEffect4037ui_story.fillRatio = var_124_13
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect4037ui_story then
				local var_124_14 = 0.5

				arg_121_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_121_1.var_.characterEffect4037ui_story.fillRatio = var_124_14
			end

			local var_124_15 = arg_121_1.actors_["1184ui_story"].transform
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.var_.moveOldPos1184ui_story = var_124_15.localPosition
			end

			local var_124_17 = 0.001

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_17 then
				local var_124_18 = (arg_121_1.time_ - var_124_16) / var_124_17
				local var_124_19 = Vector3.New(0, -0.97, -6)

				var_124_15.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1184ui_story, var_124_19, var_124_18)

				local var_124_20 = manager.ui.mainCamera.transform.position - var_124_15.position

				var_124_15.forward = Vector3.New(var_124_20.x, var_124_20.y, var_124_20.z)

				local var_124_21 = var_124_15.localEulerAngles

				var_124_21.z = 0
				var_124_21.x = 0
				var_124_15.localEulerAngles = var_124_21
			end

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 then
				var_124_15.localPosition = Vector3.New(0, -0.97, -6)

				local var_124_22 = manager.ui.mainCamera.transform.position - var_124_15.position

				var_124_15.forward = Vector3.New(var_124_22.x, var_124_22.y, var_124_22.z)

				local var_124_23 = var_124_15.localEulerAngles

				var_124_23.z = 0
				var_124_23.x = 0
				var_124_15.localEulerAngles = var_124_23
			end

			local var_124_24 = arg_121_1.actors_["1184ui_story"]
			local var_124_25 = 0

			if var_124_25 < arg_121_1.time_ and arg_121_1.time_ <= var_124_25 + arg_124_0 and not isNil(var_124_24) and arg_121_1.var_.characterEffect1184ui_story == nil then
				arg_121_1.var_.characterEffect1184ui_story = var_124_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_26 = 0.200000002980232

			if var_124_25 <= arg_121_1.time_ and arg_121_1.time_ < var_124_25 + var_124_26 and not isNil(var_124_24) then
				local var_124_27 = (arg_121_1.time_ - var_124_25) / var_124_26

				if arg_121_1.var_.characterEffect1184ui_story and not isNil(var_124_24) then
					arg_121_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_25 + var_124_26 and arg_121_1.time_ < var_124_25 + var_124_26 + arg_124_0 and not isNil(var_124_24) and arg_121_1.var_.characterEffect1184ui_story then
				arg_121_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_124_28 = 0

			if var_124_28 < arg_121_1.time_ and arg_121_1.time_ <= var_124_28 + arg_124_0 then
				arg_121_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_124_29 = 0

			if var_124_29 < arg_121_1.time_ and arg_121_1.time_ <= var_124_29 + arg_124_0 then
				arg_121_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_30 = 0
			local var_124_31 = 0.275

			if var_124_30 < arg_121_1.time_ and arg_121_1.time_ <= var_124_30 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_32 = arg_121_1:FormatText(StoryNameCfg[6].name)

				arg_121_1.leftNameTxt_.text = var_124_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_33 = arg_121_1:GetWordFromCfg(122081030)
				local var_124_34 = arg_121_1:FormatText(var_124_33.content)

				arg_121_1.text_.text = var_124_34

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_35 = 11
				local var_124_36 = utf8.len(var_124_34)
				local var_124_37 = var_124_35 <= 0 and var_124_31 or var_124_31 * (var_124_36 / var_124_35)

				if var_124_37 > 0 and var_124_31 < var_124_37 then
					arg_121_1.talkMaxDuration = var_124_37

					if var_124_37 + var_124_30 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_37 + var_124_30
					end
				end

				arg_121_1.text_.text = var_124_34
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081030", "story_v_out_122081.awb") ~= 0 then
					local var_124_38 = manager.audio:GetVoiceLength("story_v_out_122081", "122081030", "story_v_out_122081.awb") / 1000

					if var_124_38 + var_124_30 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_38 + var_124_30
					end

					if var_124_33.prefab_name ~= "" and arg_121_1.actors_[var_124_33.prefab_name] ~= nil then
						local var_124_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_33.prefab_name].transform, "story_v_out_122081", "122081030", "story_v_out_122081.awb")

						arg_121_1:RecordAudio("122081030", var_124_39)
						arg_121_1:RecordAudio("122081030", var_124_39)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_122081", "122081030", "story_v_out_122081.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_122081", "122081030", "story_v_out_122081.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_40 = math.max(var_124_31, arg_121_1.talkMaxDuration)

			if var_124_30 <= arg_121_1.time_ and arg_121_1.time_ < var_124_30 + var_124_40 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_30) / var_124_40

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_30 + var_124_40 and arg_121_1.time_ < var_124_30 + var_124_40 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play122081031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 122081031
		arg_125_1.duration_ = 6.43

		local var_125_0 = {
			ja = 6.433,
			ko = 4.333,
			zh = 4.333
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
				arg_125_0:Play122081032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1184ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1184ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, 100, 0)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1184ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, 100, 0)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["1184ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1184ui_story == nil then
				arg_125_1.var_.characterEffect1184ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect1184ui_story and not isNil(var_128_9) then
					local var_128_13 = Mathf.Lerp(0, 0.5, var_128_12)

					arg_125_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1184ui_story.fillRatio = var_128_13
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1184ui_story then
				local var_128_14 = 0.5

				arg_125_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1184ui_story.fillRatio = var_128_14
			end

			local var_128_15 = arg_125_1.actors_["4037ui_story"].transform
			local var_128_16 = 0

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.var_.moveOldPos4037ui_story = var_128_15.localPosition
			end

			local var_128_17 = 0.001

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_17 then
				local var_128_18 = (arg_125_1.time_ - var_128_16) / var_128_17
				local var_128_19 = Vector3.New(0, -1.12, -6.2)

				var_128_15.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos4037ui_story, var_128_19, var_128_18)

				local var_128_20 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_20.x, var_128_20.y, var_128_20.z)

				local var_128_21 = var_128_15.localEulerAngles

				var_128_21.z = 0
				var_128_21.x = 0
				var_128_15.localEulerAngles = var_128_21
			end

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 then
				var_128_15.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_128_22 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_22.x, var_128_22.y, var_128_22.z)

				local var_128_23 = var_128_15.localEulerAngles

				var_128_23.z = 0
				var_128_23.x = 0
				var_128_15.localEulerAngles = var_128_23
			end

			local var_128_24 = arg_125_1.actors_["4037ui_story"]
			local var_128_25 = 0

			if var_128_25 < arg_125_1.time_ and arg_125_1.time_ <= var_128_25 + arg_128_0 and not isNil(var_128_24) and arg_125_1.var_.characterEffect4037ui_story == nil then
				arg_125_1.var_.characterEffect4037ui_story = var_128_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_26 = 0.200000002980232

			if var_128_25 <= arg_125_1.time_ and arg_125_1.time_ < var_128_25 + var_128_26 and not isNil(var_128_24) then
				local var_128_27 = (arg_125_1.time_ - var_128_25) / var_128_26

				if arg_125_1.var_.characterEffect4037ui_story and not isNil(var_128_24) then
					arg_125_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_25 + var_128_26 and arg_125_1.time_ < var_128_25 + var_128_26 + arg_128_0 and not isNil(var_128_24) and arg_125_1.var_.characterEffect4037ui_story then
				arg_125_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_128_28 = 0

			if var_128_28 < arg_125_1.time_ and arg_125_1.time_ <= var_128_28 + arg_128_0 then
				arg_125_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_128_29 = 0

			if var_128_29 < arg_125_1.time_ and arg_125_1.time_ <= var_128_29 + arg_128_0 then
				arg_125_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_30 = 0
			local var_128_31 = 0.45

			if var_128_30 < arg_125_1.time_ and arg_125_1.time_ <= var_128_30 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_32 = arg_125_1:FormatText(StoryNameCfg[453].name)

				arg_125_1.leftNameTxt_.text = var_128_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_33 = arg_125_1:GetWordFromCfg(122081031)
				local var_128_34 = arg_125_1:FormatText(var_128_33.content)

				arg_125_1.text_.text = var_128_34

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_35 = 18
				local var_128_36 = utf8.len(var_128_34)
				local var_128_37 = var_128_35 <= 0 and var_128_31 or var_128_31 * (var_128_36 / var_128_35)

				if var_128_37 > 0 and var_128_31 < var_128_37 then
					arg_125_1.talkMaxDuration = var_128_37

					if var_128_37 + var_128_30 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_37 + var_128_30
					end
				end

				arg_125_1.text_.text = var_128_34
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081031", "story_v_out_122081.awb") ~= 0 then
					local var_128_38 = manager.audio:GetVoiceLength("story_v_out_122081", "122081031", "story_v_out_122081.awb") / 1000

					if var_128_38 + var_128_30 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_38 + var_128_30
					end

					if var_128_33.prefab_name ~= "" and arg_125_1.actors_[var_128_33.prefab_name] ~= nil then
						local var_128_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_33.prefab_name].transform, "story_v_out_122081", "122081031", "story_v_out_122081.awb")

						arg_125_1:RecordAudio("122081031", var_128_39)
						arg_125_1:RecordAudio("122081031", var_128_39)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_122081", "122081031", "story_v_out_122081.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_122081", "122081031", "story_v_out_122081.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_40 = math.max(var_128_31, arg_125_1.talkMaxDuration)

			if var_128_30 <= arg_125_1.time_ and arg_125_1.time_ < var_128_30 + var_128_40 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_30) / var_128_40

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_30 + var_128_40 and arg_125_1.time_ < var_128_30 + var_128_40 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play122081032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 122081032
		arg_129_1.duration_ = 4.4

		local var_129_0 = {
			ja = 4.4,
			ko = 2.733,
			zh = 2.733
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
				arg_129_0:Play122081033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["4037ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect4037ui_story == nil then
				arg_129_1.var_.characterEffect4037ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect4037ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect4037ui_story then
				arg_129_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_132_4 = 0

			if var_132_4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			local var_132_5 = 0

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_6 = 0
			local var_132_7 = 0.175

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_8 = arg_129_1:FormatText(StoryNameCfg[453].name)

				arg_129_1.leftNameTxt_.text = var_132_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_9 = arg_129_1:GetWordFromCfg(122081032)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081032", "story_v_out_122081.awb") ~= 0 then
					local var_132_14 = manager.audio:GetVoiceLength("story_v_out_122081", "122081032", "story_v_out_122081.awb") / 1000

					if var_132_14 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_6
					end

					if var_132_9.prefab_name ~= "" and arg_129_1.actors_[var_132_9.prefab_name] ~= nil then
						local var_132_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_9.prefab_name].transform, "story_v_out_122081", "122081032", "story_v_out_122081.awb")

						arg_129_1:RecordAudio("122081032", var_132_15)
						arg_129_1:RecordAudio("122081032", var_132_15)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_122081", "122081032", "story_v_out_122081.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_122081", "122081032", "story_v_out_122081.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_16 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_16 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_16

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_16 and arg_129_1.time_ < var_132_6 + var_132_16 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play122081033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 122081033
		arg_133_1.duration_ = 10.83

		local var_133_0 = {
			ja = 10.833,
			ko = 7.8,
			zh = 7.8
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
				arg_133_0:Play122081034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["4037ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos4037ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(-0.7, -1.12, -6.2)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos4037ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = arg_133_1.actors_["4037ui_story"]
			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect4037ui_story == nil then
				arg_133_1.var_.characterEffect4037ui_story = var_136_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_11 = 0.200000002980232

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_11 and not isNil(var_136_9) then
				local var_136_12 = (arg_133_1.time_ - var_136_10) / var_136_11

				if arg_133_1.var_.characterEffect4037ui_story and not isNil(var_136_9) then
					local var_136_13 = Mathf.Lerp(0, 0.5, var_136_12)

					arg_133_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_133_1.var_.characterEffect4037ui_story.fillRatio = var_136_13
				end
			end

			if arg_133_1.time_ >= var_136_10 + var_136_11 and arg_133_1.time_ < var_136_10 + var_136_11 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect4037ui_story then
				local var_136_14 = 0.5

				arg_133_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_133_1.var_.characterEffect4037ui_story.fillRatio = var_136_14
			end

			local var_136_15 = arg_133_1.actors_["1071ui_story"].transform
			local var_136_16 = 0

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1.var_.moveOldPos1071ui_story = var_136_15.localPosition
			end

			local var_136_17 = 0.001

			if var_136_16 <= arg_133_1.time_ and arg_133_1.time_ < var_136_16 + var_136_17 then
				local var_136_18 = (arg_133_1.time_ - var_136_16) / var_136_17
				local var_136_19 = Vector3.New(0.7, -1.05, -6.2)

				var_136_15.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1071ui_story, var_136_19, var_136_18)

				local var_136_20 = manager.ui.mainCamera.transform.position - var_136_15.position

				var_136_15.forward = Vector3.New(var_136_20.x, var_136_20.y, var_136_20.z)

				local var_136_21 = var_136_15.localEulerAngles

				var_136_21.z = 0
				var_136_21.x = 0
				var_136_15.localEulerAngles = var_136_21
			end

			if arg_133_1.time_ >= var_136_16 + var_136_17 and arg_133_1.time_ < var_136_16 + var_136_17 + arg_136_0 then
				var_136_15.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_136_22 = manager.ui.mainCamera.transform.position - var_136_15.position

				var_136_15.forward = Vector3.New(var_136_22.x, var_136_22.y, var_136_22.z)

				local var_136_23 = var_136_15.localEulerAngles

				var_136_23.z = 0
				var_136_23.x = 0
				var_136_15.localEulerAngles = var_136_23
			end

			local var_136_24 = arg_133_1.actors_["1071ui_story"]
			local var_136_25 = 0

			if var_136_25 < arg_133_1.time_ and arg_133_1.time_ <= var_136_25 + arg_136_0 and not isNil(var_136_24) and arg_133_1.var_.characterEffect1071ui_story == nil then
				arg_133_1.var_.characterEffect1071ui_story = var_136_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_26 = 0.200000002980232

			if var_136_25 <= arg_133_1.time_ and arg_133_1.time_ < var_136_25 + var_136_26 and not isNil(var_136_24) then
				local var_136_27 = (arg_133_1.time_ - var_136_25) / var_136_26

				if arg_133_1.var_.characterEffect1071ui_story and not isNil(var_136_24) then
					arg_133_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_25 + var_136_26 and arg_133_1.time_ < var_136_25 + var_136_26 + arg_136_0 and not isNil(var_136_24) and arg_133_1.var_.characterEffect1071ui_story then
				arg_133_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_136_28 = 0

			if var_136_28 < arg_133_1.time_ and arg_133_1.time_ <= var_136_28 + arg_136_0 then
				arg_133_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_136_29 = 0
			local var_136_30 = 0.85

			if var_136_29 < arg_133_1.time_ and arg_133_1.time_ <= var_136_29 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_31 = arg_133_1:FormatText(StoryNameCfg[384].name)

				arg_133_1.leftNameTxt_.text = var_136_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_32 = arg_133_1:GetWordFromCfg(122081033)
				local var_136_33 = arg_133_1:FormatText(var_136_32.content)

				arg_133_1.text_.text = var_136_33

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_34 = 34
				local var_136_35 = utf8.len(var_136_33)
				local var_136_36 = var_136_34 <= 0 and var_136_30 or var_136_30 * (var_136_35 / var_136_34)

				if var_136_36 > 0 and var_136_30 < var_136_36 then
					arg_133_1.talkMaxDuration = var_136_36

					if var_136_36 + var_136_29 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_36 + var_136_29
					end
				end

				arg_133_1.text_.text = var_136_33
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081033", "story_v_out_122081.awb") ~= 0 then
					local var_136_37 = manager.audio:GetVoiceLength("story_v_out_122081", "122081033", "story_v_out_122081.awb") / 1000

					if var_136_37 + var_136_29 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_37 + var_136_29
					end

					if var_136_32.prefab_name ~= "" and arg_133_1.actors_[var_136_32.prefab_name] ~= nil then
						local var_136_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_32.prefab_name].transform, "story_v_out_122081", "122081033", "story_v_out_122081.awb")

						arg_133_1:RecordAudio("122081033", var_136_38)
						arg_133_1:RecordAudio("122081033", var_136_38)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_122081", "122081033", "story_v_out_122081.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_122081", "122081033", "story_v_out_122081.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_39 = math.max(var_136_30, arg_133_1.talkMaxDuration)

			if var_136_29 <= arg_133_1.time_ and arg_133_1.time_ < var_136_29 + var_136_39 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_29) / var_136_39

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_29 + var_136_39 and arg_133_1.time_ < var_136_29 + var_136_39 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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

		arg_133_1:InitPlayNodeList()
	end,
	Play122081034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 122081034
		arg_137_1.duration_ = 6.07

		local var_137_0 = {
			ja = 4.3,
			ko = 6.066,
			zh = 6.066
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play122081035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["4037ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect4037ui_story == nil then
				arg_137_1.var_.characterEffect4037ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect4037ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect4037ui_story then
				arg_137_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_140_4 = arg_137_1.actors_["1071ui_story"]
			local var_140_5 = 0

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect1071ui_story == nil then
				arg_137_1.var_.characterEffect1071ui_story = var_140_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_6 = 0.200000002980232

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_6 and not isNil(var_140_4) then
				local var_140_7 = (arg_137_1.time_ - var_140_5) / var_140_6

				if arg_137_1.var_.characterEffect1071ui_story and not isNil(var_140_4) then
					local var_140_8 = Mathf.Lerp(0, 0.5, var_140_7)

					arg_137_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1071ui_story.fillRatio = var_140_8
				end
			end

			if arg_137_1.time_ >= var_140_5 + var_140_6 and arg_137_1.time_ < var_140_5 + var_140_6 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect1071ui_story then
				local var_140_9 = 0.5

				arg_137_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1071ui_story.fillRatio = var_140_9
			end

			local var_140_10 = 0
			local var_140_11 = 0.5

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_12 = arg_137_1:FormatText(StoryNameCfg[453].name)

				arg_137_1.leftNameTxt_.text = var_140_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_13 = arg_137_1:GetWordFromCfg(122081034)
				local var_140_14 = arg_137_1:FormatText(var_140_13.content)

				arg_137_1.text_.text = var_140_14

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_15 = 19
				local var_140_16 = utf8.len(var_140_14)
				local var_140_17 = var_140_15 <= 0 and var_140_11 or var_140_11 * (var_140_16 / var_140_15)

				if var_140_17 > 0 and var_140_11 < var_140_17 then
					arg_137_1.talkMaxDuration = var_140_17

					if var_140_17 + var_140_10 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_17 + var_140_10
					end
				end

				arg_137_1.text_.text = var_140_14
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081034", "story_v_out_122081.awb") ~= 0 then
					local var_140_18 = manager.audio:GetVoiceLength("story_v_out_122081", "122081034", "story_v_out_122081.awb") / 1000

					if var_140_18 + var_140_10 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_18 + var_140_10
					end

					if var_140_13.prefab_name ~= "" and arg_137_1.actors_[var_140_13.prefab_name] ~= nil then
						local var_140_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_13.prefab_name].transform, "story_v_out_122081", "122081034", "story_v_out_122081.awb")

						arg_137_1:RecordAudio("122081034", var_140_19)
						arg_137_1:RecordAudio("122081034", var_140_19)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_122081", "122081034", "story_v_out_122081.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_122081", "122081034", "story_v_out_122081.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_20 = math.max(var_140_11, arg_137_1.talkMaxDuration)

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_20 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_10) / var_140_20

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_10 + var_140_20 and arg_137_1.time_ < var_140_10 + var_140_20 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play122081035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 122081035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play122081036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["4037ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect4037ui_story == nil then
				arg_141_1.var_.characterEffect4037ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect4037ui_story and not isNil(var_144_0) then
					local var_144_4 = Mathf.Lerp(0, 0.5, var_144_3)

					arg_141_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_141_1.var_.characterEffect4037ui_story.fillRatio = var_144_4
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect4037ui_story then
				local var_144_5 = 0.5

				arg_141_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_141_1.var_.characterEffect4037ui_story.fillRatio = var_144_5
			end

			local var_144_6 = arg_141_1.actors_["4037ui_story"].transform
			local var_144_7 = 0

			if var_144_7 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 then
				arg_141_1.var_.moveOldPos4037ui_story = var_144_6.localPosition
			end

			local var_144_8 = 0.001

			if var_144_7 <= arg_141_1.time_ and arg_141_1.time_ < var_144_7 + var_144_8 then
				local var_144_9 = (arg_141_1.time_ - var_144_7) / var_144_8
				local var_144_10 = Vector3.New(0, 100, 0)

				var_144_6.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos4037ui_story, var_144_10, var_144_9)

				local var_144_11 = manager.ui.mainCamera.transform.position - var_144_6.position

				var_144_6.forward = Vector3.New(var_144_11.x, var_144_11.y, var_144_11.z)

				local var_144_12 = var_144_6.localEulerAngles

				var_144_12.z = 0
				var_144_12.x = 0
				var_144_6.localEulerAngles = var_144_12
			end

			if arg_141_1.time_ >= var_144_7 + var_144_8 and arg_141_1.time_ < var_144_7 + var_144_8 + arg_144_0 then
				var_144_6.localPosition = Vector3.New(0, 100, 0)

				local var_144_13 = manager.ui.mainCamera.transform.position - var_144_6.position

				var_144_6.forward = Vector3.New(var_144_13.x, var_144_13.y, var_144_13.z)

				local var_144_14 = var_144_6.localEulerAngles

				var_144_14.z = 0
				var_144_14.x = 0
				var_144_6.localEulerAngles = var_144_14
			end

			local var_144_15 = arg_141_1.actors_["1071ui_story"].transform
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.var_.moveOldPos1071ui_story = var_144_15.localPosition
			end

			local var_144_17 = 0.001

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_17 then
				local var_144_18 = (arg_141_1.time_ - var_144_16) / var_144_17
				local var_144_19 = Vector3.New(0, 100, 0)

				var_144_15.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1071ui_story, var_144_19, var_144_18)

				local var_144_20 = manager.ui.mainCamera.transform.position - var_144_15.position

				var_144_15.forward = Vector3.New(var_144_20.x, var_144_20.y, var_144_20.z)

				local var_144_21 = var_144_15.localEulerAngles

				var_144_21.z = 0
				var_144_21.x = 0
				var_144_15.localEulerAngles = var_144_21
			end

			if arg_141_1.time_ >= var_144_16 + var_144_17 and arg_141_1.time_ < var_144_16 + var_144_17 + arg_144_0 then
				var_144_15.localPosition = Vector3.New(0, 100, 0)

				local var_144_22 = manager.ui.mainCamera.transform.position - var_144_15.position

				var_144_15.forward = Vector3.New(var_144_22.x, var_144_22.y, var_144_22.z)

				local var_144_23 = var_144_15.localEulerAngles

				var_144_23.z = 0
				var_144_23.x = 0
				var_144_15.localEulerAngles = var_144_23
			end

			local var_144_24 = 0
			local var_144_25 = 1.1

			if var_144_24 < arg_141_1.time_ and arg_141_1.time_ <= var_144_24 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_26 = arg_141_1:GetWordFromCfg(122081035)
				local var_144_27 = arg_141_1:FormatText(var_144_26.content)

				arg_141_1.text_.text = var_144_27

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_28 = 44
				local var_144_29 = utf8.len(var_144_27)
				local var_144_30 = var_144_28 <= 0 and var_144_25 or var_144_25 * (var_144_29 / var_144_28)

				if var_144_30 > 0 and var_144_25 < var_144_30 then
					arg_141_1.talkMaxDuration = var_144_30

					if var_144_30 + var_144_24 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_30 + var_144_24
					end
				end

				arg_141_1.text_.text = var_144_27
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_31 = math.max(var_144_25, arg_141_1.talkMaxDuration)

			if var_144_24 <= arg_141_1.time_ and arg_141_1.time_ < var_144_24 + var_144_31 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_24) / var_144_31

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_24 + var_144_31 and arg_141_1.time_ < var_144_24 + var_144_31 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play122081036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 122081036
		arg_145_1.duration_ = 5.1

		local var_145_0 = {
			ja = 5.1,
			ko = 2.266,
			zh = 2.266
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
				arg_145_0:Play122081037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["4037ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos4037ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, -1.12, -6.2)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos4037ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["4037ui_story"]
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect4037ui_story == nil then
				arg_145_1.var_.characterEffect4037ui_story = var_148_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_11 = 0.200000002980232

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 and not isNil(var_148_9) then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11

				if arg_145_1.var_.characterEffect4037ui_story and not isNil(var_148_9) then
					arg_145_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect4037ui_story then
				arg_145_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_148_13 = 0

			if var_148_13 < arg_145_1.time_ and arg_145_1.time_ <= var_148_13 + arg_148_0 then
				arg_145_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_148_14 = 0

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_15 = 0
			local var_148_16 = 0.225

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[453].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(122081036)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 9
				local var_148_21 = utf8.len(var_148_19)
				local var_148_22 = var_148_20 <= 0 and var_148_16 or var_148_16 * (var_148_21 / var_148_20)

				if var_148_22 > 0 and var_148_16 < var_148_22 then
					arg_145_1.talkMaxDuration = var_148_22

					if var_148_22 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_19
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081036", "story_v_out_122081.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_122081", "122081036", "story_v_out_122081.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_122081", "122081036", "story_v_out_122081.awb")

						arg_145_1:RecordAudio("122081036", var_148_24)
						arg_145_1:RecordAudio("122081036", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_122081", "122081036", "story_v_out_122081.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_122081", "122081036", "story_v_out_122081.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_25 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_25 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_15) / var_148_25

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_15 + var_148_25 and arg_145_1.time_ < var_148_15 + var_148_25 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play122081037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 122081037
		arg_149_1.duration_ = 2

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play122081038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["4037ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos4037ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(-0.7, -1.12, -6.2)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos4037ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["4037ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect4037ui_story == nil then
				arg_149_1.var_.characterEffect4037ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect4037ui_story and not isNil(var_152_9) then
					local var_152_13 = Mathf.Lerp(0, 0.5, var_152_12)

					arg_149_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_149_1.var_.characterEffect4037ui_story.fillRatio = var_152_13
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect4037ui_story then
				local var_152_14 = 0.5

				arg_149_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_149_1.var_.characterEffect4037ui_story.fillRatio = var_152_14
			end

			local var_152_15 = arg_149_1.actors_["1071ui_story"].transform
			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.var_.moveOldPos1071ui_story = var_152_15.localPosition
			end

			local var_152_17 = 0.001

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_17 then
				local var_152_18 = (arg_149_1.time_ - var_152_16) / var_152_17
				local var_152_19 = Vector3.New(0.7, -1.05, -6.2)

				var_152_15.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1071ui_story, var_152_19, var_152_18)

				local var_152_20 = manager.ui.mainCamera.transform.position - var_152_15.position

				var_152_15.forward = Vector3.New(var_152_20.x, var_152_20.y, var_152_20.z)

				local var_152_21 = var_152_15.localEulerAngles

				var_152_21.z = 0
				var_152_21.x = 0
				var_152_15.localEulerAngles = var_152_21
			end

			if arg_149_1.time_ >= var_152_16 + var_152_17 and arg_149_1.time_ < var_152_16 + var_152_17 + arg_152_0 then
				var_152_15.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_152_22 = manager.ui.mainCamera.transform.position - var_152_15.position

				var_152_15.forward = Vector3.New(var_152_22.x, var_152_22.y, var_152_22.z)

				local var_152_23 = var_152_15.localEulerAngles

				var_152_23.z = 0
				var_152_23.x = 0
				var_152_15.localEulerAngles = var_152_23
			end

			local var_152_24 = arg_149_1.actors_["1071ui_story"]
			local var_152_25 = 0

			if var_152_25 < arg_149_1.time_ and arg_149_1.time_ <= var_152_25 + arg_152_0 and not isNil(var_152_24) and arg_149_1.var_.characterEffect1071ui_story == nil then
				arg_149_1.var_.characterEffect1071ui_story = var_152_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_26 = 0.200000002980232

			if var_152_25 <= arg_149_1.time_ and arg_149_1.time_ < var_152_25 + var_152_26 and not isNil(var_152_24) then
				local var_152_27 = (arg_149_1.time_ - var_152_25) / var_152_26

				if arg_149_1.var_.characterEffect1071ui_story and not isNil(var_152_24) then
					arg_149_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_25 + var_152_26 and arg_149_1.time_ < var_152_25 + var_152_26 + arg_152_0 and not isNil(var_152_24) and arg_149_1.var_.characterEffect1071ui_story then
				arg_149_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_152_28 = 0

			if var_152_28 < arg_149_1.time_ and arg_149_1.time_ <= var_152_28 + arg_152_0 then
				arg_149_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_152_29 = 0
			local var_152_30 = 0.2

			if var_152_29 < arg_149_1.time_ and arg_149_1.time_ <= var_152_29 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_31 = arg_149_1:FormatText(StoryNameCfg[384].name)

				arg_149_1.leftNameTxt_.text = var_152_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_32 = arg_149_1:GetWordFromCfg(122081037)
				local var_152_33 = arg_149_1:FormatText(var_152_32.content)

				arg_149_1.text_.text = var_152_33

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_34 = 8
				local var_152_35 = utf8.len(var_152_33)
				local var_152_36 = var_152_34 <= 0 and var_152_30 or var_152_30 * (var_152_35 / var_152_34)

				if var_152_36 > 0 and var_152_30 < var_152_36 then
					arg_149_1.talkMaxDuration = var_152_36

					if var_152_36 + var_152_29 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_36 + var_152_29
					end
				end

				arg_149_1.text_.text = var_152_33
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081037", "story_v_out_122081.awb") ~= 0 then
					local var_152_37 = manager.audio:GetVoiceLength("story_v_out_122081", "122081037", "story_v_out_122081.awb") / 1000

					if var_152_37 + var_152_29 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_37 + var_152_29
					end

					if var_152_32.prefab_name ~= "" and arg_149_1.actors_[var_152_32.prefab_name] ~= nil then
						local var_152_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_32.prefab_name].transform, "story_v_out_122081", "122081037", "story_v_out_122081.awb")

						arg_149_1:RecordAudio("122081037", var_152_38)
						arg_149_1:RecordAudio("122081037", var_152_38)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_122081", "122081037", "story_v_out_122081.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_122081", "122081037", "story_v_out_122081.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_39 = math.max(var_152_30, arg_149_1.talkMaxDuration)

			if var_152_29 <= arg_149_1.time_ and arg_149_1.time_ < var_152_29 + var_152_39 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_29) / var_152_39

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_29 + var_152_39 and arg_149_1.time_ < var_152_29 + var_152_39 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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

		arg_149_1:InitPlayNodeList()
	end,
	Play122081038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 122081038
		arg_153_1.duration_ = 14.37

		local var_153_0 = {
			ja = 14.2,
			ko = 14.366,
			zh = 14.366
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play122081039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["4037ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect4037ui_story == nil then
				arg_153_1.var_.characterEffect4037ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect4037ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect4037ui_story then
				arg_153_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_156_4 = 0

			if var_156_4 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_6 = arg_153_1.actors_["1071ui_story"]
			local var_156_7 = 0

			if var_156_7 < arg_153_1.time_ and arg_153_1.time_ <= var_156_7 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect1071ui_story == nil then
				arg_153_1.var_.characterEffect1071ui_story = var_156_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_8 = 0.200000002980232

			if var_156_7 <= arg_153_1.time_ and arg_153_1.time_ < var_156_7 + var_156_8 and not isNil(var_156_6) then
				local var_156_9 = (arg_153_1.time_ - var_156_7) / var_156_8

				if arg_153_1.var_.characterEffect1071ui_story and not isNil(var_156_6) then
					local var_156_10 = Mathf.Lerp(0, 0.5, var_156_9)

					arg_153_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1071ui_story.fillRatio = var_156_10
				end
			end

			if arg_153_1.time_ >= var_156_7 + var_156_8 and arg_153_1.time_ < var_156_7 + var_156_8 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect1071ui_story then
				local var_156_11 = 0.5

				arg_153_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1071ui_story.fillRatio = var_156_11
			end

			local var_156_12 = 0
			local var_156_13 = 1.45

			if var_156_12 < arg_153_1.time_ and arg_153_1.time_ <= var_156_12 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_14 = arg_153_1:FormatText(StoryNameCfg[453].name)

				arg_153_1.leftNameTxt_.text = var_156_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_15 = arg_153_1:GetWordFromCfg(122081038)
				local var_156_16 = arg_153_1:FormatText(var_156_15.content)

				arg_153_1.text_.text = var_156_16

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_17 = 58
				local var_156_18 = utf8.len(var_156_16)
				local var_156_19 = var_156_17 <= 0 and var_156_13 or var_156_13 * (var_156_18 / var_156_17)

				if var_156_19 > 0 and var_156_13 < var_156_19 then
					arg_153_1.talkMaxDuration = var_156_19

					if var_156_19 + var_156_12 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_12
					end
				end

				arg_153_1.text_.text = var_156_16
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081038", "story_v_out_122081.awb") ~= 0 then
					local var_156_20 = manager.audio:GetVoiceLength("story_v_out_122081", "122081038", "story_v_out_122081.awb") / 1000

					if var_156_20 + var_156_12 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_20 + var_156_12
					end

					if var_156_15.prefab_name ~= "" and arg_153_1.actors_[var_156_15.prefab_name] ~= nil then
						local var_156_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_15.prefab_name].transform, "story_v_out_122081", "122081038", "story_v_out_122081.awb")

						arg_153_1:RecordAudio("122081038", var_156_21)
						arg_153_1:RecordAudio("122081038", var_156_21)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_122081", "122081038", "story_v_out_122081.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_122081", "122081038", "story_v_out_122081.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_22 = math.max(var_156_13, arg_153_1.talkMaxDuration)

			if var_156_12 <= arg_153_1.time_ and arg_153_1.time_ < var_156_12 + var_156_22 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_12) / var_156_22

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_12 + var_156_22 and arg_153_1.time_ < var_156_12 + var_156_22 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play122081039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 122081039
		arg_157_1.duration_ = 11.37

		local var_157_0 = {
			ja = 7.133,
			ko = 11.366,
			zh = 11.366
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
				arg_157_0:Play122081040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 1.15

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[453].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(122081039)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 46
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081039", "story_v_out_122081.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_122081", "122081039", "story_v_out_122081.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_122081", "122081039", "story_v_out_122081.awb")

						arg_157_1:RecordAudio("122081039", var_160_9)
						arg_157_1:RecordAudio("122081039", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_122081", "122081039", "story_v_out_122081.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_122081", "122081039", "story_v_out_122081.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_10 and arg_157_1.time_ < var_160_0 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play122081040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 122081040
		arg_161_1.duration_ = 8.17

		local var_161_0 = {
			ja = 8.166,
			ko = 7.866,
			zh = 7.866
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
				arg_161_0:Play122081041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1071ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1071ui_story == nil then
				arg_161_1.var_.characterEffect1071ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1071ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1071ui_story then
				arg_161_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_164_4 = arg_161_1.actors_["4037ui_story"]
			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect4037ui_story == nil then
				arg_161_1.var_.characterEffect4037ui_story = var_164_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_6 and not isNil(var_164_4) then
				local var_164_7 = (arg_161_1.time_ - var_164_5) / var_164_6

				if arg_161_1.var_.characterEffect4037ui_story and not isNil(var_164_4) then
					local var_164_8 = Mathf.Lerp(0, 0.5, var_164_7)

					arg_161_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_161_1.var_.characterEffect4037ui_story.fillRatio = var_164_8
				end
			end

			if arg_161_1.time_ >= var_164_5 + var_164_6 and arg_161_1.time_ < var_164_5 + var_164_6 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect4037ui_story then
				local var_164_9 = 0.5

				arg_161_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_161_1.var_.characterEffect4037ui_story.fillRatio = var_164_9
			end

			local var_164_10 = 0
			local var_164_11 = 0.95

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_12 = arg_161_1:FormatText(StoryNameCfg[384].name)

				arg_161_1.leftNameTxt_.text = var_164_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_13 = arg_161_1:GetWordFromCfg(122081040)
				local var_164_14 = arg_161_1:FormatText(var_164_13.content)

				arg_161_1.text_.text = var_164_14

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_15 = 38
				local var_164_16 = utf8.len(var_164_14)
				local var_164_17 = var_164_15 <= 0 and var_164_11 or var_164_11 * (var_164_16 / var_164_15)

				if var_164_17 > 0 and var_164_11 < var_164_17 then
					arg_161_1.talkMaxDuration = var_164_17

					if var_164_17 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_17 + var_164_10
					end
				end

				arg_161_1.text_.text = var_164_14
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081040", "story_v_out_122081.awb") ~= 0 then
					local var_164_18 = manager.audio:GetVoiceLength("story_v_out_122081", "122081040", "story_v_out_122081.awb") / 1000

					if var_164_18 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_18 + var_164_10
					end

					if var_164_13.prefab_name ~= "" and arg_161_1.actors_[var_164_13.prefab_name] ~= nil then
						local var_164_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_13.prefab_name].transform, "story_v_out_122081", "122081040", "story_v_out_122081.awb")

						arg_161_1:RecordAudio("122081040", var_164_19)
						arg_161_1:RecordAudio("122081040", var_164_19)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_122081", "122081040", "story_v_out_122081.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_122081", "122081040", "story_v_out_122081.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_20 = math.max(var_164_11, arg_161_1.talkMaxDuration)

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_20 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_10) / var_164_20

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_10 + var_164_20 and arg_161_1.time_ < var_164_10 + var_164_20 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play122081041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 122081041
		arg_165_1.duration_ = 10.57

		local var_165_0 = {
			ja = 10.566,
			ko = 9.633,
			zh = 9.633
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
				arg_165_0:Play122081042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["4037ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect4037ui_story == nil then
				arg_165_1.var_.characterEffect4037ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect4037ui_story and not isNil(var_168_0) then
					arg_165_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect4037ui_story then
				arg_165_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_168_4 = 0

			if var_168_4 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037actionlink/4037action423")
			end

			local var_168_5 = 0

			if var_168_5 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_6 = arg_165_1.actors_["1071ui_story"]
			local var_168_7 = 0

			if var_168_7 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect1071ui_story == nil then
				arg_165_1.var_.characterEffect1071ui_story = var_168_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_8 = 0.200000002980232

			if var_168_7 <= arg_165_1.time_ and arg_165_1.time_ < var_168_7 + var_168_8 and not isNil(var_168_6) then
				local var_168_9 = (arg_165_1.time_ - var_168_7) / var_168_8

				if arg_165_1.var_.characterEffect1071ui_story and not isNil(var_168_6) then
					local var_168_10 = Mathf.Lerp(0, 0.5, var_168_9)

					arg_165_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1071ui_story.fillRatio = var_168_10
				end
			end

			if arg_165_1.time_ >= var_168_7 + var_168_8 and arg_165_1.time_ < var_168_7 + var_168_8 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect1071ui_story then
				local var_168_11 = 0.5

				arg_165_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1071ui_story.fillRatio = var_168_11
			end

			local var_168_12 = 0
			local var_168_13 = 1

			if var_168_12 < arg_165_1.time_ and arg_165_1.time_ <= var_168_12 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_14 = arg_165_1:FormatText(StoryNameCfg[453].name)

				arg_165_1.leftNameTxt_.text = var_168_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_15 = arg_165_1:GetWordFromCfg(122081041)
				local var_168_16 = arg_165_1:FormatText(var_168_15.content)

				arg_165_1.text_.text = var_168_16

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_17 = 40
				local var_168_18 = utf8.len(var_168_16)
				local var_168_19 = var_168_17 <= 0 and var_168_13 or var_168_13 * (var_168_18 / var_168_17)

				if var_168_19 > 0 and var_168_13 < var_168_19 then
					arg_165_1.talkMaxDuration = var_168_19

					if var_168_19 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_19 + var_168_12
					end
				end

				arg_165_1.text_.text = var_168_16
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081041", "story_v_out_122081.awb") ~= 0 then
					local var_168_20 = manager.audio:GetVoiceLength("story_v_out_122081", "122081041", "story_v_out_122081.awb") / 1000

					if var_168_20 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_20 + var_168_12
					end

					if var_168_15.prefab_name ~= "" and arg_165_1.actors_[var_168_15.prefab_name] ~= nil then
						local var_168_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_15.prefab_name].transform, "story_v_out_122081", "122081041", "story_v_out_122081.awb")

						arg_165_1:RecordAudio("122081041", var_168_21)
						arg_165_1:RecordAudio("122081041", var_168_21)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_122081", "122081041", "story_v_out_122081.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_122081", "122081041", "story_v_out_122081.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_22 = math.max(var_168_13, arg_165_1.talkMaxDuration)

			if var_168_12 <= arg_165_1.time_ and arg_165_1.time_ < var_168_12 + var_168_22 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_12) / var_168_22

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_12 + var_168_22 and arg_165_1.time_ < var_168_12 + var_168_22 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play122081042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 122081042
		arg_169_1.duration_ = 12.27

		local var_169_0 = {
			ja = 12.266,
			ko = 5.666,
			zh = 5.666
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
				arg_169_0:Play122081043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.575

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[453].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:GetWordFromCfg(122081042)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 23
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081042", "story_v_out_122081.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_122081", "122081042", "story_v_out_122081.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_122081", "122081042", "story_v_out_122081.awb")

						arg_169_1:RecordAudio("122081042", var_172_9)
						arg_169_1:RecordAudio("122081042", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_122081", "122081042", "story_v_out_122081.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_122081", "122081042", "story_v_out_122081.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play122081043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 122081043
		arg_173_1.duration_ = 16.87

		local var_173_0 = {
			ja = 12.333,
			ko = 16.866,
			zh = 16.866
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play122081044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_2")
			end

			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_2 = 0
			local var_176_3 = 1.225

			if var_176_2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_4 = arg_173_1:FormatText(StoryNameCfg[453].name)

				arg_173_1.leftNameTxt_.text = var_176_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_5 = arg_173_1:GetWordFromCfg(122081043)
				local var_176_6 = arg_173_1:FormatText(var_176_5.content)

				arg_173_1.text_.text = var_176_6

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 49
				local var_176_8 = utf8.len(var_176_6)
				local var_176_9 = var_176_7 <= 0 and var_176_3 or var_176_3 * (var_176_8 / var_176_7)

				if var_176_9 > 0 and var_176_3 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_6
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081043", "story_v_out_122081.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_122081", "122081043", "story_v_out_122081.awb") / 1000

					if var_176_10 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_2
					end

					if var_176_5.prefab_name ~= "" and arg_173_1.actors_[var_176_5.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_5.prefab_name].transform, "story_v_out_122081", "122081043", "story_v_out_122081.awb")

						arg_173_1:RecordAudio("122081043", var_176_11)
						arg_173_1:RecordAudio("122081043", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_122081", "122081043", "story_v_out_122081.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_122081", "122081043", "story_v_out_122081.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_12 and arg_173_1.time_ < var_176_2 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play122081044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 122081044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play122081045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1071ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1071ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, 100, 0)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1071ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, 100, 0)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["1071ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1071ui_story == nil then
				arg_177_1.var_.characterEffect1071ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect1071ui_story and not isNil(var_180_9) then
					local var_180_13 = Mathf.Lerp(0, 0.5, var_180_12)

					arg_177_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1071ui_story.fillRatio = var_180_13
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1071ui_story then
				local var_180_14 = 0.5

				arg_177_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1071ui_story.fillRatio = var_180_14
			end

			local var_180_15 = arg_177_1.actors_["4037ui_story"].transform
			local var_180_16 = 0

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 then
				arg_177_1.var_.moveOldPos4037ui_story = var_180_15.localPosition
			end

			local var_180_17 = 0.001

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_17 then
				local var_180_18 = (arg_177_1.time_ - var_180_16) / var_180_17
				local var_180_19 = Vector3.New(0, 100, 0)

				var_180_15.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos4037ui_story, var_180_19, var_180_18)

				local var_180_20 = manager.ui.mainCamera.transform.position - var_180_15.position

				var_180_15.forward = Vector3.New(var_180_20.x, var_180_20.y, var_180_20.z)

				local var_180_21 = var_180_15.localEulerAngles

				var_180_21.z = 0
				var_180_21.x = 0
				var_180_15.localEulerAngles = var_180_21
			end

			if arg_177_1.time_ >= var_180_16 + var_180_17 and arg_177_1.time_ < var_180_16 + var_180_17 + arg_180_0 then
				var_180_15.localPosition = Vector3.New(0, 100, 0)

				local var_180_22 = manager.ui.mainCamera.transform.position - var_180_15.position

				var_180_15.forward = Vector3.New(var_180_22.x, var_180_22.y, var_180_22.z)

				local var_180_23 = var_180_15.localEulerAngles

				var_180_23.z = 0
				var_180_23.x = 0
				var_180_15.localEulerAngles = var_180_23
			end

			local var_180_24 = arg_177_1.actors_["4037ui_story"]
			local var_180_25 = 0

			if var_180_25 < arg_177_1.time_ and arg_177_1.time_ <= var_180_25 + arg_180_0 and not isNil(var_180_24) and arg_177_1.var_.characterEffect4037ui_story == nil then
				arg_177_1.var_.characterEffect4037ui_story = var_180_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_26 = 0.200000002980232

			if var_180_25 <= arg_177_1.time_ and arg_177_1.time_ < var_180_25 + var_180_26 and not isNil(var_180_24) then
				local var_180_27 = (arg_177_1.time_ - var_180_25) / var_180_26

				if arg_177_1.var_.characterEffect4037ui_story and not isNil(var_180_24) then
					local var_180_28 = Mathf.Lerp(0, 0.5, var_180_27)

					arg_177_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_177_1.var_.characterEffect4037ui_story.fillRatio = var_180_28
				end
			end

			if arg_177_1.time_ >= var_180_25 + var_180_26 and arg_177_1.time_ < var_180_25 + var_180_26 + arg_180_0 and not isNil(var_180_24) and arg_177_1.var_.characterEffect4037ui_story then
				local var_180_29 = 0.5

				arg_177_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_177_1.var_.characterEffect4037ui_story.fillRatio = var_180_29
			end

			local var_180_30 = 0
			local var_180_31 = 0.725

			if var_180_30 < arg_177_1.time_ and arg_177_1.time_ <= var_180_30 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_32 = arg_177_1:GetWordFromCfg(122081044)
				local var_180_33 = arg_177_1:FormatText(var_180_32.content)

				arg_177_1.text_.text = var_180_33

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_34 = 29
				local var_180_35 = utf8.len(var_180_33)
				local var_180_36 = var_180_34 <= 0 and var_180_31 or var_180_31 * (var_180_35 / var_180_34)

				if var_180_36 > 0 and var_180_31 < var_180_36 then
					arg_177_1.talkMaxDuration = var_180_36

					if var_180_36 + var_180_30 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_36 + var_180_30
					end
				end

				arg_177_1.text_.text = var_180_33
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_37 = math.max(var_180_31, arg_177_1.talkMaxDuration)

			if var_180_30 <= arg_177_1.time_ and arg_177_1.time_ < var_180_30 + var_180_37 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_30) / var_180_37

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_30 + var_180_37 and arg_177_1.time_ < var_180_30 + var_180_37 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play122081045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 122081045
		arg_181_1.duration_ = 4.4

		local var_181_0 = {
			ja = 4.4,
			ko = 2.066,
			zh = 2.066
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play122081046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1071ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1071ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1071ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["1071ui_story"]
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1071ui_story == nil then
				arg_181_1.var_.characterEffect1071ui_story = var_184_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_11 = 0.200000002980232

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 and not isNil(var_184_9) then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11

				if arg_181_1.var_.characterEffect1071ui_story and not isNil(var_184_9) then
					arg_181_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1071ui_story then
				arg_181_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_184_13 = 0

			if var_184_13 < arg_181_1.time_ and arg_181_1.time_ <= var_184_13 + arg_184_0 then
				arg_181_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_184_14 = 0

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 then
				arg_181_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_184_15 = 0
			local var_184_16 = 0.275

			if var_184_15 < arg_181_1.time_ and arg_181_1.time_ <= var_184_15 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_17 = arg_181_1:FormatText(StoryNameCfg[384].name)

				arg_181_1.leftNameTxt_.text = var_184_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_18 = arg_181_1:GetWordFromCfg(122081045)
				local var_184_19 = arg_181_1:FormatText(var_184_18.content)

				arg_181_1.text_.text = var_184_19

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_20 = 11
				local var_184_21 = utf8.len(var_184_19)
				local var_184_22 = var_184_20 <= 0 and var_184_16 or var_184_16 * (var_184_21 / var_184_20)

				if var_184_22 > 0 and var_184_16 < var_184_22 then
					arg_181_1.talkMaxDuration = var_184_22

					if var_184_22 + var_184_15 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_22 + var_184_15
					end
				end

				arg_181_1.text_.text = var_184_19
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081045", "story_v_out_122081.awb") ~= 0 then
					local var_184_23 = manager.audio:GetVoiceLength("story_v_out_122081", "122081045", "story_v_out_122081.awb") / 1000

					if var_184_23 + var_184_15 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_23 + var_184_15
					end

					if var_184_18.prefab_name ~= "" and arg_181_1.actors_[var_184_18.prefab_name] ~= nil then
						local var_184_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_18.prefab_name].transform, "story_v_out_122081", "122081045", "story_v_out_122081.awb")

						arg_181_1:RecordAudio("122081045", var_184_24)
						arg_181_1:RecordAudio("122081045", var_184_24)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_122081", "122081045", "story_v_out_122081.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_122081", "122081045", "story_v_out_122081.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_25 = math.max(var_184_16, arg_181_1.talkMaxDuration)

			if var_184_15 <= arg_181_1.time_ and arg_181_1.time_ < var_184_15 + var_184_25 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_15) / var_184_25

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_15 + var_184_25 and arg_181_1.time_ < var_184_15 + var_184_25 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
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

		arg_181_1:InitPlayNodeList()
	end,
	Play122081046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 122081046
		arg_185_1.duration_ = 6.83

		local var_185_0 = {
			ja = 6.833,
			ko = 6.633,
			zh = 6.633
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
				arg_185_0:Play122081047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.8

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[384].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:GetWordFromCfg(122081046)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 32
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081046", "story_v_out_122081.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_122081", "122081046", "story_v_out_122081.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_122081", "122081046", "story_v_out_122081.awb")

						arg_185_1:RecordAudio("122081046", var_188_9)
						arg_185_1:RecordAudio("122081046", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_122081", "122081046", "story_v_out_122081.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_122081", "122081046", "story_v_out_122081.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play122081047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 122081047
		arg_189_1.duration_ = 19.6

		local var_189_0 = {
			ja = 15.5,
			ko = 19.6,
			zh = 19.6
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play122081048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["4037ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos4037ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0.7, -1.12, -6.2)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos4037ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = arg_189_1.actors_["4037ui_story"]
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect4037ui_story == nil then
				arg_189_1.var_.characterEffect4037ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_11 = 0.200000002980232

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 and not isNil(var_192_9) then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11

				if arg_189_1.var_.characterEffect4037ui_story and not isNil(var_192_9) then
					arg_189_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect4037ui_story then
				arg_189_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_192_13 = 0

			if var_192_13 < arg_189_1.time_ and arg_189_1.time_ <= var_192_13 + arg_192_0 then
				arg_189_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_192_14 = 0

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_15 = arg_189_1.actors_["1071ui_story"]
			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 and not isNil(var_192_15) and arg_189_1.var_.characterEffect1071ui_story == nil then
				arg_189_1.var_.characterEffect1071ui_story = var_192_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_17 = 0.200000002980232

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_17 and not isNil(var_192_15) then
				local var_192_18 = (arg_189_1.time_ - var_192_16) / var_192_17

				if arg_189_1.var_.characterEffect1071ui_story and not isNil(var_192_15) then
					local var_192_19 = Mathf.Lerp(0, 0.5, var_192_18)

					arg_189_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1071ui_story.fillRatio = var_192_19
				end
			end

			if arg_189_1.time_ >= var_192_16 + var_192_17 and arg_189_1.time_ < var_192_16 + var_192_17 + arg_192_0 and not isNil(var_192_15) and arg_189_1.var_.characterEffect1071ui_story then
				local var_192_20 = 0.5

				arg_189_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1071ui_story.fillRatio = var_192_20
			end

			local var_192_21 = 0
			local var_192_22 = 1.4

			if var_192_21 < arg_189_1.time_ and arg_189_1.time_ <= var_192_21 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_23 = arg_189_1:FormatText(StoryNameCfg[453].name)

				arg_189_1.leftNameTxt_.text = var_192_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_24 = arg_189_1:GetWordFromCfg(122081047)
				local var_192_25 = arg_189_1:FormatText(var_192_24.content)

				arg_189_1.text_.text = var_192_25

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_26 = 56
				local var_192_27 = utf8.len(var_192_25)
				local var_192_28 = var_192_26 <= 0 and var_192_22 or var_192_22 * (var_192_27 / var_192_26)

				if var_192_28 > 0 and var_192_22 < var_192_28 then
					arg_189_1.talkMaxDuration = var_192_28

					if var_192_28 + var_192_21 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_28 + var_192_21
					end
				end

				arg_189_1.text_.text = var_192_25
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081047", "story_v_out_122081.awb") ~= 0 then
					local var_192_29 = manager.audio:GetVoiceLength("story_v_out_122081", "122081047", "story_v_out_122081.awb") / 1000

					if var_192_29 + var_192_21 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_29 + var_192_21
					end

					if var_192_24.prefab_name ~= "" and arg_189_1.actors_[var_192_24.prefab_name] ~= nil then
						local var_192_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_24.prefab_name].transform, "story_v_out_122081", "122081047", "story_v_out_122081.awb")

						arg_189_1:RecordAudio("122081047", var_192_30)
						arg_189_1:RecordAudio("122081047", var_192_30)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_122081", "122081047", "story_v_out_122081.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_122081", "122081047", "story_v_out_122081.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_31 = math.max(var_192_22, arg_189_1.talkMaxDuration)

			if var_192_21 <= arg_189_1.time_ and arg_189_1.time_ < var_192_21 + var_192_31 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_21) / var_192_31

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_21 + var_192_31 and arg_189_1.time_ < var_192_21 + var_192_31 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play122081048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 122081048
		arg_193_1.duration_ = 12.53

		local var_193_0 = {
			ja = 12.533,
			ko = 8.6,
			zh = 8.6
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play122081049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 1

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[453].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(122081048)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 40
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081048", "story_v_out_122081.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_122081", "122081048", "story_v_out_122081.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_122081", "122081048", "story_v_out_122081.awb")

						arg_193_1:RecordAudio("122081048", var_196_9)
						arg_193_1:RecordAudio("122081048", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_122081", "122081048", "story_v_out_122081.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_122081", "122081048", "story_v_out_122081.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_10 and arg_193_1.time_ < var_196_0 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play122081049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 122081049
		arg_197_1.duration_ = 17

		local var_197_0 = {
			ja = 15.833,
			ko = 17,
			zh = 17
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
				arg_197_0:Play122081050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 1.35

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[453].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(122081049)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 54
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081049", "story_v_out_122081.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_122081", "122081049", "story_v_out_122081.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_122081", "122081049", "story_v_out_122081.awb")

						arg_197_1:RecordAudio("122081049", var_200_9)
						arg_197_1:RecordAudio("122081049", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_122081", "122081049", "story_v_out_122081.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_122081", "122081049", "story_v_out_122081.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play122081050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 122081050
		arg_201_1.duration_ = 4.2

		local var_201_0 = {
			ja = 4.2,
			ko = 2,
			zh = 2
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
				arg_201_0:Play122081051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1071ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos1071ui_story = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1071ui_story, var_204_4, var_204_3)

				local var_204_5 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_5.x, var_204_5.y, var_204_5.z)

				local var_204_6 = var_204_0.localEulerAngles

				var_204_6.z = 0
				var_204_6.x = 0
				var_204_0.localEulerAngles = var_204_6
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_204_7 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_7.x, var_204_7.y, var_204_7.z)

				local var_204_8 = var_204_0.localEulerAngles

				var_204_8.z = 0
				var_204_8.x = 0
				var_204_0.localEulerAngles = var_204_8
			end

			local var_204_9 = arg_201_1.actors_["1071ui_story"]
			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect1071ui_story == nil then
				arg_201_1.var_.characterEffect1071ui_story = var_204_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_11 = 0.200000002980232

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_11 and not isNil(var_204_9) then
				local var_204_12 = (arg_201_1.time_ - var_204_10) / var_204_11

				if arg_201_1.var_.characterEffect1071ui_story and not isNil(var_204_9) then
					arg_201_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_10 + var_204_11 and arg_201_1.time_ < var_204_10 + var_204_11 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect1071ui_story then
				arg_201_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_204_13 = 0

			if var_204_13 < arg_201_1.time_ and arg_201_1.time_ <= var_204_13 + arg_204_0 then
				arg_201_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_204_14 = 0

			if var_204_14 < arg_201_1.time_ and arg_201_1.time_ <= var_204_14 + arg_204_0 then
				arg_201_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_204_15 = arg_201_1.actors_["4037ui_story"]
			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.characterEffect4037ui_story == nil then
				arg_201_1.var_.characterEffect4037ui_story = var_204_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_17 = 0.200000002980232

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_17 and not isNil(var_204_15) then
				local var_204_18 = (arg_201_1.time_ - var_204_16) / var_204_17

				if arg_201_1.var_.characterEffect4037ui_story and not isNil(var_204_15) then
					local var_204_19 = Mathf.Lerp(0, 0.5, var_204_18)

					arg_201_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_201_1.var_.characterEffect4037ui_story.fillRatio = var_204_19
				end
			end

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.characterEffect4037ui_story then
				local var_204_20 = 0.5

				arg_201_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_201_1.var_.characterEffect4037ui_story.fillRatio = var_204_20
			end

			local var_204_21 = 0
			local var_204_22 = 0.325

			if var_204_21 < arg_201_1.time_ and arg_201_1.time_ <= var_204_21 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_23 = arg_201_1:FormatText(StoryNameCfg[384].name)

				arg_201_1.leftNameTxt_.text = var_204_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_24 = arg_201_1:GetWordFromCfg(122081050)
				local var_204_25 = arg_201_1:FormatText(var_204_24.content)

				arg_201_1.text_.text = var_204_25

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_26 = 13
				local var_204_27 = utf8.len(var_204_25)
				local var_204_28 = var_204_26 <= 0 and var_204_22 or var_204_22 * (var_204_27 / var_204_26)

				if var_204_28 > 0 and var_204_22 < var_204_28 then
					arg_201_1.talkMaxDuration = var_204_28

					if var_204_28 + var_204_21 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_28 + var_204_21
					end
				end

				arg_201_1.text_.text = var_204_25
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081050", "story_v_out_122081.awb") ~= 0 then
					local var_204_29 = manager.audio:GetVoiceLength("story_v_out_122081", "122081050", "story_v_out_122081.awb") / 1000

					if var_204_29 + var_204_21 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_29 + var_204_21
					end

					if var_204_24.prefab_name ~= "" and arg_201_1.actors_[var_204_24.prefab_name] ~= nil then
						local var_204_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_24.prefab_name].transform, "story_v_out_122081", "122081050", "story_v_out_122081.awb")

						arg_201_1:RecordAudio("122081050", var_204_30)
						arg_201_1:RecordAudio("122081050", var_204_30)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_122081", "122081050", "story_v_out_122081.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_122081", "122081050", "story_v_out_122081.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_31 = math.max(var_204_22, arg_201_1.talkMaxDuration)

			if var_204_21 <= arg_201_1.time_ and arg_201_1.time_ < var_204_21 + var_204_31 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_21) / var_204_31

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_21 + var_204_31 and arg_201_1.time_ < var_204_21 + var_204_31 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
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

		arg_201_1:InitPlayNodeList()
	end,
	Play122081051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 122081051
		arg_205_1.duration_ = 10.07

		local var_205_0 = {
			ja = 10.066,
			ko = 9.2,
			zh = 9.2
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
				arg_205_0:Play122081052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["4037ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect4037ui_story == nil then
				arg_205_1.var_.characterEffect4037ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect4037ui_story and not isNil(var_208_0) then
					arg_205_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect4037ui_story then
				arg_205_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_208_4 = arg_205_1.actors_["1071ui_story"]
			local var_208_5 = 0

			if var_208_5 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect1071ui_story == nil then
				arg_205_1.var_.characterEffect1071ui_story = var_208_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_6 = 0.200000002980232

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_6 and not isNil(var_208_4) then
				local var_208_7 = (arg_205_1.time_ - var_208_5) / var_208_6

				if arg_205_1.var_.characterEffect1071ui_story and not isNil(var_208_4) then
					local var_208_8 = Mathf.Lerp(0, 0.5, var_208_7)

					arg_205_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1071ui_story.fillRatio = var_208_8
				end
			end

			if arg_205_1.time_ >= var_208_5 + var_208_6 and arg_205_1.time_ < var_208_5 + var_208_6 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect1071ui_story then
				local var_208_9 = 0.5

				arg_205_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1071ui_story.fillRatio = var_208_9
			end

			local var_208_10 = 0
			local var_208_11 = 0.925

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_12 = arg_205_1:FormatText(StoryNameCfg[453].name)

				arg_205_1.leftNameTxt_.text = var_208_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_13 = arg_205_1:GetWordFromCfg(122081051)
				local var_208_14 = arg_205_1:FormatText(var_208_13.content)

				arg_205_1.text_.text = var_208_14

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_15 = 37
				local var_208_16 = utf8.len(var_208_14)
				local var_208_17 = var_208_15 <= 0 and var_208_11 or var_208_11 * (var_208_16 / var_208_15)

				if var_208_17 > 0 and var_208_11 < var_208_17 then
					arg_205_1.talkMaxDuration = var_208_17

					if var_208_17 + var_208_10 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_17 + var_208_10
					end
				end

				arg_205_1.text_.text = var_208_14
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081051", "story_v_out_122081.awb") ~= 0 then
					local var_208_18 = manager.audio:GetVoiceLength("story_v_out_122081", "122081051", "story_v_out_122081.awb") / 1000

					if var_208_18 + var_208_10 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_18 + var_208_10
					end

					if var_208_13.prefab_name ~= "" and arg_205_1.actors_[var_208_13.prefab_name] ~= nil then
						local var_208_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_13.prefab_name].transform, "story_v_out_122081", "122081051", "story_v_out_122081.awb")

						arg_205_1:RecordAudio("122081051", var_208_19)
						arg_205_1:RecordAudio("122081051", var_208_19)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_122081", "122081051", "story_v_out_122081.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_122081", "122081051", "story_v_out_122081.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_20 = math.max(var_208_11, arg_205_1.talkMaxDuration)

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_20 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_10) / var_208_20

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_10 + var_208_20 and arg_205_1.time_ < var_208_10 + var_208_20 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play122081052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 122081052
		arg_209_1.duration_ = 10.3

		local var_209_0 = {
			ja = 10.3,
			ko = 8.1,
			zh = 8.1
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
				arg_209_0:Play122081053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1071ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1071ui_story == nil then
				arg_209_1.var_.characterEffect1071ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1071ui_story and not isNil(var_212_0) then
					arg_209_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1071ui_story then
				arg_209_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_212_4 = 0

			if var_212_4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action453")
			end

			local var_212_5 = arg_209_1.actors_["4037ui_story"]
			local var_212_6 = 0

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.characterEffect4037ui_story == nil then
				arg_209_1.var_.characterEffect4037ui_story = var_212_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_7 = 0.200000002980232

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_7 and not isNil(var_212_5) then
				local var_212_8 = (arg_209_1.time_ - var_212_6) / var_212_7

				if arg_209_1.var_.characterEffect4037ui_story and not isNil(var_212_5) then
					local var_212_9 = Mathf.Lerp(0, 0.5, var_212_8)

					arg_209_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_209_1.var_.characterEffect4037ui_story.fillRatio = var_212_9
				end
			end

			if arg_209_1.time_ >= var_212_6 + var_212_7 and arg_209_1.time_ < var_212_6 + var_212_7 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.characterEffect4037ui_story then
				local var_212_10 = 0.5

				arg_209_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_209_1.var_.characterEffect4037ui_story.fillRatio = var_212_10
			end

			local var_212_11 = 0
			local var_212_12 = 0.8

			if var_212_11 < arg_209_1.time_ and arg_209_1.time_ <= var_212_11 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_13 = arg_209_1:FormatText(StoryNameCfg[384].name)

				arg_209_1.leftNameTxt_.text = var_212_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_14 = arg_209_1:GetWordFromCfg(122081052)
				local var_212_15 = arg_209_1:FormatText(var_212_14.content)

				arg_209_1.text_.text = var_212_15

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_16 = 32
				local var_212_17 = utf8.len(var_212_15)
				local var_212_18 = var_212_16 <= 0 and var_212_12 or var_212_12 * (var_212_17 / var_212_16)

				if var_212_18 > 0 and var_212_12 < var_212_18 then
					arg_209_1.talkMaxDuration = var_212_18

					if var_212_18 + var_212_11 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_18 + var_212_11
					end
				end

				arg_209_1.text_.text = var_212_15
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081052", "story_v_out_122081.awb") ~= 0 then
					local var_212_19 = manager.audio:GetVoiceLength("story_v_out_122081", "122081052", "story_v_out_122081.awb") / 1000

					if var_212_19 + var_212_11 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_19 + var_212_11
					end

					if var_212_14.prefab_name ~= "" and arg_209_1.actors_[var_212_14.prefab_name] ~= nil then
						local var_212_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_14.prefab_name].transform, "story_v_out_122081", "122081052", "story_v_out_122081.awb")

						arg_209_1:RecordAudio("122081052", var_212_20)
						arg_209_1:RecordAudio("122081052", var_212_20)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_122081", "122081052", "story_v_out_122081.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_122081", "122081052", "story_v_out_122081.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_21 = math.max(var_212_12, arg_209_1.talkMaxDuration)

			if var_212_11 <= arg_209_1.time_ and arg_209_1.time_ < var_212_11 + var_212_21 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_11) / var_212_21

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_11 + var_212_21 and arg_209_1.time_ < var_212_11 + var_212_21 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play122081053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 122081053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play122081054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1071ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1071ui_story = var_216_0.localPosition
			end

			local var_216_2 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2
				local var_216_4 = Vector3.New(0, 100, 0)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1071ui_story, var_216_4, var_216_3)

				local var_216_5 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_5.x, var_216_5.y, var_216_5.z)

				local var_216_6 = var_216_0.localEulerAngles

				var_216_6.z = 0
				var_216_6.x = 0
				var_216_0.localEulerAngles = var_216_6
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, 100, 0)

				local var_216_7 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_7.x, var_216_7.y, var_216_7.z)

				local var_216_8 = var_216_0.localEulerAngles

				var_216_8.z = 0
				var_216_8.x = 0
				var_216_0.localEulerAngles = var_216_8
			end

			local var_216_9 = arg_213_1.actors_["1071ui_story"]
			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1071ui_story == nil then
				arg_213_1.var_.characterEffect1071ui_story = var_216_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_11 = 0.200000002980232

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_11 and not isNil(var_216_9) then
				local var_216_12 = (arg_213_1.time_ - var_216_10) / var_216_11

				if arg_213_1.var_.characterEffect1071ui_story and not isNil(var_216_9) then
					local var_216_13 = Mathf.Lerp(0, 0.5, var_216_12)

					arg_213_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1071ui_story.fillRatio = var_216_13
				end
			end

			if arg_213_1.time_ >= var_216_10 + var_216_11 and arg_213_1.time_ < var_216_10 + var_216_11 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1071ui_story then
				local var_216_14 = 0.5

				arg_213_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1071ui_story.fillRatio = var_216_14
			end

			local var_216_15 = arg_213_1.actors_["4037ui_story"].transform
			local var_216_16 = 0

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 then
				arg_213_1.var_.moveOldPos4037ui_story = var_216_15.localPosition
			end

			local var_216_17 = 0.001

			if var_216_16 <= arg_213_1.time_ and arg_213_1.time_ < var_216_16 + var_216_17 then
				local var_216_18 = (arg_213_1.time_ - var_216_16) / var_216_17
				local var_216_19 = Vector3.New(0, 100, 0)

				var_216_15.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos4037ui_story, var_216_19, var_216_18)

				local var_216_20 = manager.ui.mainCamera.transform.position - var_216_15.position

				var_216_15.forward = Vector3.New(var_216_20.x, var_216_20.y, var_216_20.z)

				local var_216_21 = var_216_15.localEulerAngles

				var_216_21.z = 0
				var_216_21.x = 0
				var_216_15.localEulerAngles = var_216_21
			end

			if arg_213_1.time_ >= var_216_16 + var_216_17 and arg_213_1.time_ < var_216_16 + var_216_17 + arg_216_0 then
				var_216_15.localPosition = Vector3.New(0, 100, 0)

				local var_216_22 = manager.ui.mainCamera.transform.position - var_216_15.position

				var_216_15.forward = Vector3.New(var_216_22.x, var_216_22.y, var_216_22.z)

				local var_216_23 = var_216_15.localEulerAngles

				var_216_23.z = 0
				var_216_23.x = 0
				var_216_15.localEulerAngles = var_216_23
			end

			local var_216_24 = arg_213_1.actors_["4037ui_story"]
			local var_216_25 = 0

			if var_216_25 < arg_213_1.time_ and arg_213_1.time_ <= var_216_25 + arg_216_0 and not isNil(var_216_24) and arg_213_1.var_.characterEffect4037ui_story == nil then
				arg_213_1.var_.characterEffect4037ui_story = var_216_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_26 = 0.200000002980232

			if var_216_25 <= arg_213_1.time_ and arg_213_1.time_ < var_216_25 + var_216_26 and not isNil(var_216_24) then
				local var_216_27 = (arg_213_1.time_ - var_216_25) / var_216_26

				if arg_213_1.var_.characterEffect4037ui_story and not isNil(var_216_24) then
					local var_216_28 = Mathf.Lerp(0, 0.5, var_216_27)

					arg_213_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_213_1.var_.characterEffect4037ui_story.fillRatio = var_216_28
				end
			end

			if arg_213_1.time_ >= var_216_25 + var_216_26 and arg_213_1.time_ < var_216_25 + var_216_26 + arg_216_0 and not isNil(var_216_24) and arg_213_1.var_.characterEffect4037ui_story then
				local var_216_29 = 0.5

				arg_213_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_213_1.var_.characterEffect4037ui_story.fillRatio = var_216_29
			end

			local var_216_30 = 0
			local var_216_31 = 1.35

			if var_216_30 < arg_213_1.time_ and arg_213_1.time_ <= var_216_30 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_32 = arg_213_1:GetWordFromCfg(122081053)
				local var_216_33 = arg_213_1:FormatText(var_216_32.content)

				arg_213_1.text_.text = var_216_33

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_34 = 54
				local var_216_35 = utf8.len(var_216_33)
				local var_216_36 = var_216_34 <= 0 and var_216_31 or var_216_31 * (var_216_35 / var_216_34)

				if var_216_36 > 0 and var_216_31 < var_216_36 then
					arg_213_1.talkMaxDuration = var_216_36

					if var_216_36 + var_216_30 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_36 + var_216_30
					end
				end

				arg_213_1.text_.text = var_216_33
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_37 = math.max(var_216_31, arg_213_1.talkMaxDuration)

			if var_216_30 <= arg_213_1.time_ and arg_213_1.time_ < var_216_30 + var_216_37 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_30) / var_216_37

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_30 + var_216_37 and arg_213_1.time_ < var_216_30 + var_216_37 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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
				actorName = "4037ui_story",
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
	Play122081054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 122081054
		arg_217_1.duration_ = 2.7

		local var_217_0 = {
			ja = 2.7,
			ko = 1.433,
			zh = 1.433
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play122081055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10037ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos10037ui_story = var_220_0.localPosition
			end

			local var_220_2 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2
				local var_220_4 = Vector3.New(-0.7, -1.13, -6.2)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10037ui_story, var_220_4, var_220_3)

				local var_220_5 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_5.x, var_220_5.y, var_220_5.z)

				local var_220_6 = var_220_0.localEulerAngles

				var_220_6.z = 0
				var_220_6.x = 0
				var_220_0.localEulerAngles = var_220_6
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(-0.7, -1.13, -6.2)

				local var_220_7 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_7.x, var_220_7.y, var_220_7.z)

				local var_220_8 = var_220_0.localEulerAngles

				var_220_8.z = 0
				var_220_8.x = 0
				var_220_0.localEulerAngles = var_220_8
			end

			local var_220_9 = arg_217_1.actors_["10037ui_story"]
			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect10037ui_story == nil then
				arg_217_1.var_.characterEffect10037ui_story = var_220_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_11 = 0.200000002980232

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_11 and not isNil(var_220_9) then
				local var_220_12 = (arg_217_1.time_ - var_220_10) / var_220_11

				if arg_217_1.var_.characterEffect10037ui_story and not isNil(var_220_9) then
					arg_217_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_10 + var_220_11 and arg_217_1.time_ < var_220_10 + var_220_11 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect10037ui_story then
				arg_217_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_220_13 = 0

			if var_220_13 < arg_217_1.time_ and arg_217_1.time_ <= var_220_13 + arg_220_0 then
				arg_217_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			local var_220_14 = 0

			if var_220_14 < arg_217_1.time_ and arg_217_1.time_ <= var_220_14 + arg_220_0 then
				arg_217_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_220_15 = 0
			local var_220_16 = 0.2

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_17 = arg_217_1:FormatText(StoryNameCfg[383].name)

				arg_217_1.leftNameTxt_.text = var_220_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_18 = arg_217_1:GetWordFromCfg(122081054)
				local var_220_19 = arg_217_1:FormatText(var_220_18.content)

				arg_217_1.text_.text = var_220_19

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_20 = 8
				local var_220_21 = utf8.len(var_220_19)
				local var_220_22 = var_220_20 <= 0 and var_220_16 or var_220_16 * (var_220_21 / var_220_20)

				if var_220_22 > 0 and var_220_16 < var_220_22 then
					arg_217_1.talkMaxDuration = var_220_22

					if var_220_22 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_22 + var_220_15
					end
				end

				arg_217_1.text_.text = var_220_19
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081054", "story_v_out_122081.awb") ~= 0 then
					local var_220_23 = manager.audio:GetVoiceLength("story_v_out_122081", "122081054", "story_v_out_122081.awb") / 1000

					if var_220_23 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_15
					end

					if var_220_18.prefab_name ~= "" and arg_217_1.actors_[var_220_18.prefab_name] ~= nil then
						local var_220_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_18.prefab_name].transform, "story_v_out_122081", "122081054", "story_v_out_122081.awb")

						arg_217_1:RecordAudio("122081054", var_220_24)
						arg_217_1:RecordAudio("122081054", var_220_24)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_122081", "122081054", "story_v_out_122081.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_122081", "122081054", "story_v_out_122081.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_25 = math.max(var_220_16, arg_217_1.talkMaxDuration)

			if var_220_15 <= arg_217_1.time_ and arg_217_1.time_ < var_220_15 + var_220_25 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_15) / var_220_25

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_15 + var_220_25 and arg_217_1.time_ < var_220_15 + var_220_25 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play122081055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 122081055
		arg_221_1.duration_ = 9.17

		local var_221_0 = {
			ja = 9.166,
			ko = 7.166,
			zh = 7.166
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
				arg_221_0:Play122081056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["4037ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos4037ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0.7, -1.12, -6.2)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos4037ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = arg_221_1.actors_["4037ui_story"]
			local var_224_10 = 0

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect4037ui_story == nil then
				arg_221_1.var_.characterEffect4037ui_story = var_224_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.200000002980232

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_11 and not isNil(var_224_9) then
				local var_224_12 = (arg_221_1.time_ - var_224_10) / var_224_11

				if arg_221_1.var_.characterEffect4037ui_story and not isNil(var_224_9) then
					arg_221_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_10 + var_224_11 and arg_221_1.time_ < var_224_10 + var_224_11 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect4037ui_story then
				arg_221_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_224_13 = 0

			if var_224_13 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_224_14 = 0

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_224_15 = arg_221_1.actors_["10037ui_story"]
			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.characterEffect10037ui_story == nil then
				arg_221_1.var_.characterEffect10037ui_story = var_224_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_17 = 0.200000002980232

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_17 and not isNil(var_224_15) then
				local var_224_18 = (arg_221_1.time_ - var_224_16) / var_224_17

				if arg_221_1.var_.characterEffect10037ui_story and not isNil(var_224_15) then
					local var_224_19 = Mathf.Lerp(0, 0.5, var_224_18)

					arg_221_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_221_1.var_.characterEffect10037ui_story.fillRatio = var_224_19
				end
			end

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.characterEffect10037ui_story then
				local var_224_20 = 0.5

				arg_221_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_221_1.var_.characterEffect10037ui_story.fillRatio = var_224_20
			end

			local var_224_21 = 0

			if var_224_21 < arg_221_1.time_ and arg_221_1.time_ <= var_224_21 + arg_224_0 then
				arg_221_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_224_22 = 0
			local var_224_23 = 0.625

			if var_224_22 < arg_221_1.time_ and arg_221_1.time_ <= var_224_22 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_24 = arg_221_1:FormatText(StoryNameCfg[453].name)

				arg_221_1.leftNameTxt_.text = var_224_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_25 = arg_221_1:GetWordFromCfg(122081055)
				local var_224_26 = arg_221_1:FormatText(var_224_25.content)

				arg_221_1.text_.text = var_224_26

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_27 = 25
				local var_224_28 = utf8.len(var_224_26)
				local var_224_29 = var_224_27 <= 0 and var_224_23 or var_224_23 * (var_224_28 / var_224_27)

				if var_224_29 > 0 and var_224_23 < var_224_29 then
					arg_221_1.talkMaxDuration = var_224_29

					if var_224_29 + var_224_22 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_29 + var_224_22
					end
				end

				arg_221_1.text_.text = var_224_26
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081055", "story_v_out_122081.awb") ~= 0 then
					local var_224_30 = manager.audio:GetVoiceLength("story_v_out_122081", "122081055", "story_v_out_122081.awb") / 1000

					if var_224_30 + var_224_22 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_30 + var_224_22
					end

					if var_224_25.prefab_name ~= "" and arg_221_1.actors_[var_224_25.prefab_name] ~= nil then
						local var_224_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_25.prefab_name].transform, "story_v_out_122081", "122081055", "story_v_out_122081.awb")

						arg_221_1:RecordAudio("122081055", var_224_31)
						arg_221_1:RecordAudio("122081055", var_224_31)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_122081", "122081055", "story_v_out_122081.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_122081", "122081055", "story_v_out_122081.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_32 = math.max(var_224_23, arg_221_1.talkMaxDuration)

			if var_224_22 <= arg_221_1.time_ and arg_221_1.time_ < var_224_22 + var_224_32 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_22) / var_224_32

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_22 + var_224_32 and arg_221_1.time_ < var_224_22 + var_224_32 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play122081056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 122081056
		arg_225_1.duration_ = 7.07

		local var_225_0 = {
			ja = 7.066,
			ko = 2.633,
			zh = 2.633
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play122081057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10037ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos10037ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0, 100, 0)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10037ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, 100, 0)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = arg_225_1.actors_["10037ui_story"]
			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect10037ui_story == nil then
				arg_225_1.var_.characterEffect10037ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_11 = 0.200000002980232

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_11 and not isNil(var_228_9) then
				local var_228_12 = (arg_225_1.time_ - var_228_10) / var_228_11

				if arg_225_1.var_.characterEffect10037ui_story and not isNil(var_228_9) then
					local var_228_13 = Mathf.Lerp(0, 0.5, var_228_12)

					arg_225_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10037ui_story.fillRatio = var_228_13
				end
			end

			if arg_225_1.time_ >= var_228_10 + var_228_11 and arg_225_1.time_ < var_228_10 + var_228_11 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect10037ui_story then
				local var_228_14 = 0.5

				arg_225_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10037ui_story.fillRatio = var_228_14
			end

			local var_228_15 = arg_225_1.actors_["1071ui_story"].transform
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 then
				arg_225_1.var_.moveOldPos1071ui_story = var_228_15.localPosition
			end

			local var_228_17 = 0.001

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_17 then
				local var_228_18 = (arg_225_1.time_ - var_228_16) / var_228_17
				local var_228_19 = Vector3.New(-0.7, -1.05, -6.2)

				var_228_15.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1071ui_story, var_228_19, var_228_18)

				local var_228_20 = manager.ui.mainCamera.transform.position - var_228_15.position

				var_228_15.forward = Vector3.New(var_228_20.x, var_228_20.y, var_228_20.z)

				local var_228_21 = var_228_15.localEulerAngles

				var_228_21.z = 0
				var_228_21.x = 0
				var_228_15.localEulerAngles = var_228_21
			end

			if arg_225_1.time_ >= var_228_16 + var_228_17 and arg_225_1.time_ < var_228_16 + var_228_17 + arg_228_0 then
				var_228_15.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_228_22 = manager.ui.mainCamera.transform.position - var_228_15.position

				var_228_15.forward = Vector3.New(var_228_22.x, var_228_22.y, var_228_22.z)

				local var_228_23 = var_228_15.localEulerAngles

				var_228_23.z = 0
				var_228_23.x = 0
				var_228_15.localEulerAngles = var_228_23
			end

			local var_228_24 = arg_225_1.actors_["1071ui_story"]
			local var_228_25 = 0

			if var_228_25 < arg_225_1.time_ and arg_225_1.time_ <= var_228_25 + arg_228_0 and not isNil(var_228_24) and arg_225_1.var_.characterEffect1071ui_story == nil then
				arg_225_1.var_.characterEffect1071ui_story = var_228_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_26 = 0.200000002980232

			if var_228_25 <= arg_225_1.time_ and arg_225_1.time_ < var_228_25 + var_228_26 and not isNil(var_228_24) then
				local var_228_27 = (arg_225_1.time_ - var_228_25) / var_228_26

				if arg_225_1.var_.characterEffect1071ui_story and not isNil(var_228_24) then
					arg_225_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_25 + var_228_26 and arg_225_1.time_ < var_228_25 + var_228_26 + arg_228_0 and not isNil(var_228_24) and arg_225_1.var_.characterEffect1071ui_story then
				arg_225_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_228_28 = 0

			if var_228_28 < arg_225_1.time_ and arg_225_1.time_ <= var_228_28 + arg_228_0 then
				arg_225_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_228_29 = arg_225_1.actors_["4037ui_story"]
			local var_228_30 = 0

			if var_228_30 < arg_225_1.time_ and arg_225_1.time_ <= var_228_30 + arg_228_0 and not isNil(var_228_29) and arg_225_1.var_.characterEffect4037ui_story == nil then
				arg_225_1.var_.characterEffect4037ui_story = var_228_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_31 = 0.200000002980232

			if var_228_30 <= arg_225_1.time_ and arg_225_1.time_ < var_228_30 + var_228_31 and not isNil(var_228_29) then
				local var_228_32 = (arg_225_1.time_ - var_228_30) / var_228_31

				if arg_225_1.var_.characterEffect4037ui_story and not isNil(var_228_29) then
					local var_228_33 = Mathf.Lerp(0, 0.5, var_228_32)

					arg_225_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_225_1.var_.characterEffect4037ui_story.fillRatio = var_228_33
				end
			end

			if arg_225_1.time_ >= var_228_30 + var_228_31 and arg_225_1.time_ < var_228_30 + var_228_31 + arg_228_0 and not isNil(var_228_29) and arg_225_1.var_.characterEffect4037ui_story then
				local var_228_34 = 0.5

				arg_225_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_225_1.var_.characterEffect4037ui_story.fillRatio = var_228_34
			end

			local var_228_35 = 0
			local var_228_36 = 0.275

			if var_228_35 < arg_225_1.time_ and arg_225_1.time_ <= var_228_35 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_37 = arg_225_1:FormatText(StoryNameCfg[384].name)

				arg_225_1.leftNameTxt_.text = var_228_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_38 = arg_225_1:GetWordFromCfg(122081056)
				local var_228_39 = arg_225_1:FormatText(var_228_38.content)

				arg_225_1.text_.text = var_228_39

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_40 = 11
				local var_228_41 = utf8.len(var_228_39)
				local var_228_42 = var_228_40 <= 0 and var_228_36 or var_228_36 * (var_228_41 / var_228_40)

				if var_228_42 > 0 and var_228_36 < var_228_42 then
					arg_225_1.talkMaxDuration = var_228_42

					if var_228_42 + var_228_35 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_42 + var_228_35
					end
				end

				arg_225_1.text_.text = var_228_39
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081056", "story_v_out_122081.awb") ~= 0 then
					local var_228_43 = manager.audio:GetVoiceLength("story_v_out_122081", "122081056", "story_v_out_122081.awb") / 1000

					if var_228_43 + var_228_35 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_43 + var_228_35
					end

					if var_228_38.prefab_name ~= "" and arg_225_1.actors_[var_228_38.prefab_name] ~= nil then
						local var_228_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_38.prefab_name].transform, "story_v_out_122081", "122081056", "story_v_out_122081.awb")

						arg_225_1:RecordAudio("122081056", var_228_44)
						arg_225_1:RecordAudio("122081056", var_228_44)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_122081", "122081056", "story_v_out_122081.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_122081", "122081056", "story_v_out_122081.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_45 = math.max(var_228_36, arg_225_1.talkMaxDuration)

			if var_228_35 <= arg_225_1.time_ and arg_225_1.time_ < var_228_35 + var_228_45 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_35) / var_228_45

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_35 + var_228_45 and arg_225_1.time_ < var_228_35 + var_228_45 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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

		arg_225_1:InitPlayNodeList()
	end,
	Play122081057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 122081057
		arg_229_1.duration_ = 7.6

		local var_229_0 = {
			ja = 7.6,
			ko = 5.333,
			zh = 5.333
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
				arg_229_0:Play122081058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["4037ui_story"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos4037ui_story = var_232_0.localPosition
			end

			local var_232_2 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2
				local var_232_4 = Vector3.New(0.7, -1.12, -6.2)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos4037ui_story, var_232_4, var_232_3)

				local var_232_5 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_5.x, var_232_5.y, var_232_5.z)

				local var_232_6 = var_232_0.localEulerAngles

				var_232_6.z = 0
				var_232_6.x = 0
				var_232_0.localEulerAngles = var_232_6
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_232_7 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_7.x, var_232_7.y, var_232_7.z)

				local var_232_8 = var_232_0.localEulerAngles

				var_232_8.z = 0
				var_232_8.x = 0
				var_232_0.localEulerAngles = var_232_8
			end

			local var_232_9 = arg_229_1.actors_["4037ui_story"]
			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 and not isNil(var_232_9) and arg_229_1.var_.characterEffect4037ui_story == nil then
				arg_229_1.var_.characterEffect4037ui_story = var_232_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_11 = 0.200000002980232

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_11 and not isNil(var_232_9) then
				local var_232_12 = (arg_229_1.time_ - var_232_10) / var_232_11

				if arg_229_1.var_.characterEffect4037ui_story and not isNil(var_232_9) then
					arg_229_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_10 + var_232_11 and arg_229_1.time_ < var_232_10 + var_232_11 + arg_232_0 and not isNil(var_232_9) and arg_229_1.var_.characterEffect4037ui_story then
				arg_229_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_232_13 = 0

			if var_232_13 < arg_229_1.time_ and arg_229_1.time_ <= var_232_13 + arg_232_0 then
				arg_229_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_232_14 = 0

			if var_232_14 < arg_229_1.time_ and arg_229_1.time_ <= var_232_14 + arg_232_0 then
				arg_229_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_232_15 = arg_229_1.actors_["1071ui_story"]
			local var_232_16 = 0

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 and not isNil(var_232_15) and arg_229_1.var_.characterEffect1071ui_story == nil then
				arg_229_1.var_.characterEffect1071ui_story = var_232_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_17 = 0.200000002980232

			if var_232_16 <= arg_229_1.time_ and arg_229_1.time_ < var_232_16 + var_232_17 and not isNil(var_232_15) then
				local var_232_18 = (arg_229_1.time_ - var_232_16) / var_232_17

				if arg_229_1.var_.characterEffect1071ui_story and not isNil(var_232_15) then
					local var_232_19 = Mathf.Lerp(0, 0.5, var_232_18)

					arg_229_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1071ui_story.fillRatio = var_232_19
				end
			end

			if arg_229_1.time_ >= var_232_16 + var_232_17 and arg_229_1.time_ < var_232_16 + var_232_17 + arg_232_0 and not isNil(var_232_15) and arg_229_1.var_.characterEffect1071ui_story then
				local var_232_20 = 0.5

				arg_229_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1071ui_story.fillRatio = var_232_20
			end

			local var_232_21 = 0
			local var_232_22 = 0.375

			if var_232_21 < arg_229_1.time_ and arg_229_1.time_ <= var_232_21 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_23 = arg_229_1:FormatText(StoryNameCfg[453].name)

				arg_229_1.leftNameTxt_.text = var_232_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_24 = arg_229_1:GetWordFromCfg(122081057)
				local var_232_25 = arg_229_1:FormatText(var_232_24.content)

				arg_229_1.text_.text = var_232_25

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_26 = 15
				local var_232_27 = utf8.len(var_232_25)
				local var_232_28 = var_232_26 <= 0 and var_232_22 or var_232_22 * (var_232_27 / var_232_26)

				if var_232_28 > 0 and var_232_22 < var_232_28 then
					arg_229_1.talkMaxDuration = var_232_28

					if var_232_28 + var_232_21 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_28 + var_232_21
					end
				end

				arg_229_1.text_.text = var_232_25
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081057", "story_v_out_122081.awb") ~= 0 then
					local var_232_29 = manager.audio:GetVoiceLength("story_v_out_122081", "122081057", "story_v_out_122081.awb") / 1000

					if var_232_29 + var_232_21 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_29 + var_232_21
					end

					if var_232_24.prefab_name ~= "" and arg_229_1.actors_[var_232_24.prefab_name] ~= nil then
						local var_232_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_24.prefab_name].transform, "story_v_out_122081", "122081057", "story_v_out_122081.awb")

						arg_229_1:RecordAudio("122081057", var_232_30)
						arg_229_1:RecordAudio("122081057", var_232_30)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_122081", "122081057", "story_v_out_122081.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_122081", "122081057", "story_v_out_122081.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_31 = math.max(var_232_22, arg_229_1.talkMaxDuration)

			if var_232_21 <= arg_229_1.time_ and arg_229_1.time_ < var_232_21 + var_232_31 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_21) / var_232_31

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_21 + var_232_31 and arg_229_1.time_ < var_232_21 + var_232_31 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play122081058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 122081058
		arg_233_1.duration_ = 6.63

		local var_233_0 = {
			ja = 6.633,
			ko = 4.433,
			zh = 4.433
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
				arg_233_0:Play122081059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1071ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1071ui_story == nil then
				arg_233_1.var_.characterEffect1071ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1071ui_story and not isNil(var_236_0) then
					arg_233_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1071ui_story then
				arg_233_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_236_4 = 0

			if var_236_4 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_236_5 = arg_233_1.actors_["4037ui_story"]
			local var_236_6 = 0

			if var_236_6 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect4037ui_story == nil then
				arg_233_1.var_.characterEffect4037ui_story = var_236_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_7 = 0.200000002980232

			if var_236_6 <= arg_233_1.time_ and arg_233_1.time_ < var_236_6 + var_236_7 and not isNil(var_236_5) then
				local var_236_8 = (arg_233_1.time_ - var_236_6) / var_236_7

				if arg_233_1.var_.characterEffect4037ui_story and not isNil(var_236_5) then
					local var_236_9 = Mathf.Lerp(0, 0.5, var_236_8)

					arg_233_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_233_1.var_.characterEffect4037ui_story.fillRatio = var_236_9
				end
			end

			if arg_233_1.time_ >= var_236_6 + var_236_7 and arg_233_1.time_ < var_236_6 + var_236_7 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect4037ui_story then
				local var_236_10 = 0.5

				arg_233_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_233_1.var_.characterEffect4037ui_story.fillRatio = var_236_10
			end

			local var_236_11 = 0
			local var_236_12 = 0.575

			if var_236_11 < arg_233_1.time_ and arg_233_1.time_ <= var_236_11 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_13 = arg_233_1:FormatText(StoryNameCfg[384].name)

				arg_233_1.leftNameTxt_.text = var_236_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_14 = arg_233_1:GetWordFromCfg(122081058)
				local var_236_15 = arg_233_1:FormatText(var_236_14.content)

				arg_233_1.text_.text = var_236_15

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_16 = 23
				local var_236_17 = utf8.len(var_236_15)
				local var_236_18 = var_236_16 <= 0 and var_236_12 or var_236_12 * (var_236_17 / var_236_16)

				if var_236_18 > 0 and var_236_12 < var_236_18 then
					arg_233_1.talkMaxDuration = var_236_18

					if var_236_18 + var_236_11 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_18 + var_236_11
					end
				end

				arg_233_1.text_.text = var_236_15
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081058", "story_v_out_122081.awb") ~= 0 then
					local var_236_19 = manager.audio:GetVoiceLength("story_v_out_122081", "122081058", "story_v_out_122081.awb") / 1000

					if var_236_19 + var_236_11 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_19 + var_236_11
					end

					if var_236_14.prefab_name ~= "" and arg_233_1.actors_[var_236_14.prefab_name] ~= nil then
						local var_236_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_14.prefab_name].transform, "story_v_out_122081", "122081058", "story_v_out_122081.awb")

						arg_233_1:RecordAudio("122081058", var_236_20)
						arg_233_1:RecordAudio("122081058", var_236_20)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_122081", "122081058", "story_v_out_122081.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_122081", "122081058", "story_v_out_122081.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_21 = math.max(var_236_12, arg_233_1.talkMaxDuration)

			if var_236_11 <= arg_233_1.time_ and arg_233_1.time_ < var_236_11 + var_236_21 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_11) / var_236_21

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_11 + var_236_21 and arg_233_1.time_ < var_236_11 + var_236_21 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play122081059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 122081059
		arg_237_1.duration_ = 2.1

		local var_237_0 = {
			ja = 2.1,
			ko = 1.999999999999,
			zh = 1.999999999999
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
			arg_237_1.auto_ = false
		end

		function arg_237_1.playNext_(arg_239_0)
			arg_237_1.onStoryFinished_()
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_240_2 = 0
			local var_240_3 = 0.1

			if var_240_2 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_4 = arg_237_1:FormatText(StoryNameCfg[384].name)

				arg_237_1.leftNameTxt_.text = var_240_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_5 = arg_237_1:GetWordFromCfg(122081059)
				local var_240_6 = arg_237_1:FormatText(var_240_5.content)

				arg_237_1.text_.text = var_240_6

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_7 = 4
				local var_240_8 = utf8.len(var_240_6)
				local var_240_9 = var_240_7 <= 0 and var_240_3 or var_240_3 * (var_240_8 / var_240_7)

				if var_240_9 > 0 and var_240_3 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_2
					end
				end

				arg_237_1.text_.text = var_240_6
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122081", "122081059", "story_v_out_122081.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_out_122081", "122081059", "story_v_out_122081.awb") / 1000

					if var_240_10 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_2
					end

					if var_240_5.prefab_name ~= "" and arg_237_1.actors_[var_240_5.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_5.prefab_name].transform, "story_v_out_122081", "122081059", "story_v_out_122081.awb")

						arg_237_1:RecordAudio("122081059", var_240_11)
						arg_237_1:RecordAudio("122081059", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_122081", "122081059", "story_v_out_122081.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_122081", "122081059", "story_v_out_122081.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_3, arg_237_1.talkMaxDuration)

			if var_240_2 <= arg_237_1.time_ and arg_237_1.time_ < var_240_2 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_2) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_2 + var_240_12 and arg_237_1.time_ < var_240_2 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J02",
		"TextureConfig/Background/J08h"
	},
	voices = {
		"story_v_out_122081.awb"
	}
}
