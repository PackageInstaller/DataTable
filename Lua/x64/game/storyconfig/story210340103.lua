return {
	Play1103403001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1103403001
		arg_1_1.duration_ = 4.67

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1103403002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I11o"

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
				local var_4_5 = arg_1_1.bgs_.I11o

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
					if iter_4_0 ~= "I11o" then
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

			local var_4_24 = "1034ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1034ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1034ui_story"].transform
			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1034ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, 100, 0)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1034ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, 100, 0)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1034ui_story"].transform
			local var_4_39 = 2

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.var_.moveOldPos1034ui_story = var_4_38.localPosition
			end

			local var_4_40 = 0.001

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40
				local var_4_42 = Vector3.New(0, -0.93, -6)

				var_4_38.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1034ui_story, var_4_42, var_4_41)

				local var_4_43 = manager.ui.mainCamera.transform.position - var_4_38.position

				var_4_38.forward = Vector3.New(var_4_43.x, var_4_43.y, var_4_43.z)

				local var_4_44 = var_4_38.localEulerAngles

				var_4_44.z = 0
				var_4_44.x = 0
				var_4_38.localEulerAngles = var_4_44
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				var_4_38.localPosition = Vector3.New(0, -0.93, -6)

				local var_4_45 = manager.ui.mainCamera.transform.position - var_4_38.position

				var_4_38.forward = Vector3.New(var_4_45.x, var_4_45.y, var_4_45.z)

				local var_4_46 = var_4_38.localEulerAngles

				var_4_46.z = 0
				var_4_46.x = 0
				var_4_38.localEulerAngles = var_4_46
			end

			local var_4_47 = 2

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_4_48 = 0.133333333333333
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "effect"

				arg_1_1:AudioAction(var_4_50, var_4_51, "se_story_16", "se_story_16_street_loop", "")
			end

			local var_4_52 = 0
			local var_4_53 = 0.3

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_54 = "play"
				local var_4_55 = "music"

				arg_1_1:AudioAction(var_4_54, var_4_55, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_56 = ""
				local var_4_57 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_58 = 0.4
			local var_4_59 = 1

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				local var_4_60 = "play"
				local var_4_61 = "music"

				arg_1_1:AudioAction(var_4_60, var_4_61, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_62 = ""
				local var_4_63 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_4_63 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_63 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_63

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_63
						arg_1_1.bgmTxt2_.text = var_4_63
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

			local var_4_64 = 2
			local var_4_65 = 0.3

			if var_4_64 < arg_1_1.time_ and arg_1_1.time_ <= var_4_64 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_66 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_66:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_67 = arg_1_1:FormatText(StoryNameCfg[1384].name)

				arg_1_1.leftNameTxt_.text = var_4_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_68 = arg_1_1:GetWordFromCfg(1103403001)
				local var_4_69 = arg_1_1:FormatText(var_4_68.content)

				arg_1_1.text_.text = var_4_69

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_70 = 2
				local var_4_71 = utf8.len(var_4_69)
				local var_4_72 = var_4_70 <= 0 and var_4_65 or var_4_65 * (var_4_71 / var_4_70)

				if var_4_72 > 0 and var_4_65 < var_4_72 then
					arg_1_1.talkMaxDuration = var_4_72
					var_4_64 = var_4_64 + 0.3

					if var_4_72 + var_4_64 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_72 + var_4_64
					end
				end

				arg_1_1.text_.text = var_4_69
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403001", "story_v_side_new_1103403.awb") ~= 0 then
					local var_4_73 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403001", "story_v_side_new_1103403.awb") / 1000

					if var_4_73 + var_4_64 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_73 + var_4_64
					end

					if var_4_68.prefab_name ~= "" and arg_1_1.actors_[var_4_68.prefab_name] ~= nil then
						local var_4_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_68.prefab_name].transform, "story_v_side_new_1103403", "1103403001", "story_v_side_new_1103403.awb")

						arg_1_1:RecordAudio("1103403001", var_4_74)
						arg_1_1:RecordAudio("1103403001", var_4_74)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403001", "story_v_side_new_1103403.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403001", "story_v_side_new_1103403.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_75 = var_4_64 + 0.3
			local var_4_76 = math.max(var_4_65, arg_1_1.talkMaxDuration)

			if var_4_75 <= arg_1_1.time_ and arg_1_1.time_ < var_4_75 + var_4_76 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_75) / var_4_76

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_75 + var_4_76 and arg_1_1.time_ < var_4_75 + var_4_76 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
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
	Play1103403002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1103403002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1103403003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_12_2 = arg_9_1.actors_["1034ui_story"]
			local var_12_3 = 0

			if var_12_3 < arg_9_1.time_ and arg_9_1.time_ <= var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.characterEffect1034ui_story == nil then
				arg_9_1.var_.characterEffect1034ui_story = var_12_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_4 = 0.200000002980232

			if var_12_3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_3 + var_12_4 and not isNil(var_12_2) then
				local var_12_5 = (arg_9_1.time_ - var_12_3) / var_12_4

				if arg_9_1.var_.characterEffect1034ui_story and not isNil(var_12_2) then
					local var_12_6 = Mathf.Lerp(0, 0.5, var_12_5)

					arg_9_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1034ui_story.fillRatio = var_12_6
				end
			end

			if arg_9_1.time_ >= var_12_3 + var_12_4 and arg_9_1.time_ < var_12_3 + var_12_4 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.characterEffect1034ui_story then
				local var_12_7 = 0.5

				arg_9_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1034ui_story.fillRatio = var_12_7
			end

			local var_12_8 = 0
			local var_12_9 = 1.375

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(1103403002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_12 = 55
				local var_12_13 = utf8.len(var_12_11)
				local var_12_14 = var_12_12 <= 0 and var_12_9 or var_12_9 * (var_12_13 / var_12_12)

				if var_12_14 > 0 and var_12_9 < var_12_14 then
					arg_9_1.talkMaxDuration = var_12_14

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_15 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_15 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_15

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_15 and arg_9_1.time_ < var_12_8 + var_12_15 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1103403003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1103403003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1103403004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_16_2 = 1
			local var_16_3 = 1

			if var_16_2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				local var_16_4 = "play"
				local var_16_5 = "effect"

				arg_13_1:AudioAction(var_16_4, var_16_5, "se_story_side_1034", "se_story_side_1034_clap", "")
			end

			local var_16_6 = 0
			local var_16_7 = 0.75

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:GetWordFromCfg(1103403003)
				local var_16_9 = arg_13_1:FormatText(var_16_8.content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 30
				local var_16_11 = utf8.len(var_16_9)
				local var_16_12 = var_16_10 <= 0 and var_16_7 or var_16_7 * (var_16_11 / var_16_10)

				if var_16_12 > 0 and var_16_7 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12

					if var_16_12 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_13 and arg_13_1.time_ < var_16_6 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1103403004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1103403004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1103403005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_20_1 = 0
			local var_20_2 = 0.4

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_3 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_4 = arg_17_1:GetWordFromCfg(1103403004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 16
				local var_20_7 = utf8.len(var_20_5)
				local var_20_8 = var_20_6 <= 0 and var_20_2 or var_20_2 * (var_20_7 / var_20_6)

				if var_20_8 > 0 and var_20_2 < var_20_8 then
					arg_17_1.talkMaxDuration = var_20_8

					if var_20_8 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_9 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_9 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_9

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_9 and arg_17_1.time_ < var_20_1 + var_20_9 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1103403005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1103403005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1103403006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_24_1 = 0
			local var_24_2 = 0.5

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_3 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_3

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

				local var_24_4 = arg_21_1:GetWordFromCfg(1103403005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 20
				local var_24_7 = utf8.len(var_24_5)
				local var_24_8 = var_24_6 <= 0 and var_24_2 or var_24_2 * (var_24_7 / var_24_6)

				if var_24_8 > 0 and var_24_2 < var_24_8 then
					arg_21_1.talkMaxDuration = var_24_8

					if var_24_8 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_9 and arg_21_1.time_ < var_24_1 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1103403006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1103403006
		arg_25_1.duration_ = 5.5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1103403007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1034ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1034ui_story == nil then
				arg_25_1.var_.characterEffect1034ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1034ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1034ui_story then
				arg_25_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_28_6 = 0
			local var_28_7 = 0.775

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[1109].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(1103403006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 31
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

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403006", "story_v_side_new_1103403.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403006", "story_v_side_new_1103403.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_side_new_1103403", "1103403006", "story_v_side_new_1103403.awb")

						arg_25_1:RecordAudio("1103403006", var_28_15)
						arg_25_1:RecordAudio("1103403006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403006", "story_v_side_new_1103403.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403006", "story_v_side_new_1103403.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_16 and arg_25_1.time_ < var_28_6 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1103403007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1103403007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1103403008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1034ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1034ui_story == nil then
				arg_29_1.var_.characterEffect1034ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1034ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1034ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1034ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1034ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_32_7 = 0
			local var_32_8 = 0.425

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_9 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_9

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

				local var_32_10 = arg_29_1:GetWordFromCfg(1103403007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_12 = 17
				local var_32_13 = utf8.len(var_32_11)
				local var_32_14 = var_32_12 <= 0 and var_32_8 or var_32_8 * (var_32_13 / var_32_12)

				if var_32_14 > 0 and var_32_8 < var_32_14 then
					arg_29_1.talkMaxDuration = var_32_14

					if var_32_14 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_7
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_15 = math.max(var_32_8, arg_29_1.talkMaxDuration)

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_15 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_7) / var_32_15

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_7 + var_32_15 and arg_29_1.time_ < var_32_7 + var_32_15 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1103403008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1103403008
		arg_33_1.duration_ = 4.5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1103403009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1034ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1034ui_story == nil then
				arg_33_1.var_.characterEffect1034ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1034ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1034ui_story then
				arg_33_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_36_5 = 0
			local var_36_6 = 0.475

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_7 = arg_33_1:FormatText(StoryNameCfg[1109].name)

				arg_33_1.leftNameTxt_.text = var_36_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(1103403008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 19
				local var_36_11 = utf8.len(var_36_9)
				local var_36_12 = var_36_10 <= 0 and var_36_6 or var_36_6 * (var_36_11 / var_36_10)

				if var_36_12 > 0 and var_36_6 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12

					if var_36_12 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403008", "story_v_side_new_1103403.awb") ~= 0 then
					local var_36_13 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403008", "story_v_side_new_1103403.awb") / 1000

					if var_36_13 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_5
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_side_new_1103403", "1103403008", "story_v_side_new_1103403.awb")

						arg_33_1:RecordAudio("1103403008", var_36_14)
						arg_33_1:RecordAudio("1103403008", var_36_14)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403008", "story_v_side_new_1103403.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403008", "story_v_side_new_1103403.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_15 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_15 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_15

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_15 and arg_33_1.time_ < var_36_5 + var_36_15 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1103403009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1103403009
		arg_37_1.duration_ = 8.3

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1103403010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_40_1 = 0
			local var_40_2 = 0.925

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_3 = arg_37_1:FormatText(StoryNameCfg[1109].name)

				arg_37_1.leftNameTxt_.text = var_40_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(1103403009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 37
				local var_40_7 = utf8.len(var_40_5)
				local var_40_8 = var_40_6 <= 0 and var_40_2 or var_40_2 * (var_40_7 / var_40_6)

				if var_40_8 > 0 and var_40_2 < var_40_8 then
					arg_37_1.talkMaxDuration = var_40_8

					if var_40_8 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403009", "story_v_side_new_1103403.awb") ~= 0 then
					local var_40_9 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403009", "story_v_side_new_1103403.awb") / 1000

					if var_40_9 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_1
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_side_new_1103403", "1103403009", "story_v_side_new_1103403.awb")

						arg_37_1:RecordAudio("1103403009", var_40_10)
						arg_37_1:RecordAudio("1103403009", var_40_10)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403009", "story_v_side_new_1103403.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403009", "story_v_side_new_1103403.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_11 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_11 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_11

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_11 and arg_37_1.time_ < var_40_1 + var_40_11 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1103403010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1103403010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1103403011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1034ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1034ui_story == nil then
				arg_41_1.var_.characterEffect1034ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1034ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1034ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1034ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1034ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_44_7 = 0
			local var_44_8 = 0.175

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_9 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_10 = arg_41_1:GetWordFromCfg(1103403010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_12 = 7
				local var_44_13 = utf8.len(var_44_11)
				local var_44_14 = var_44_12 <= 0 and var_44_8 or var_44_8 * (var_44_13 / var_44_12)

				if var_44_14 > 0 and var_44_8 < var_44_14 then
					arg_41_1.talkMaxDuration = var_44_14

					if var_44_14 + var_44_7 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_7
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_15 = math.max(var_44_8, arg_41_1.talkMaxDuration)

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_15 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_7) / var_44_15

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_7 + var_44_15 and arg_41_1.time_ < var_44_7 + var_44_15 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1103403011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1103403011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1103403012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_48_2 = 0
			local var_48_3 = 0.675

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_4 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_5 = arg_45_1:GetWordFromCfg(1103403011)
				local var_48_6 = arg_45_1:FormatText(var_48_5.content)

				arg_45_1.text_.text = var_48_6

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 27
				local var_48_8 = utf8.len(var_48_6)
				local var_48_9 = var_48_7 <= 0 and var_48_3 or var_48_3 * (var_48_8 / var_48_7)

				if var_48_9 > 0 and var_48_3 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_6
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_10 and arg_45_1.time_ < var_48_2 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1103403012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1103403012
		arg_49_1.duration_ = 4.9

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1103403013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1034ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1034ui_story == nil then
				arg_49_1.var_.characterEffect1034ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1034ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1034ui_story then
				arg_49_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_52_6 = 0
			local var_52_7 = 0.675

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[1109].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:GetWordFromCfg(1103403012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 27
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403012", "story_v_side_new_1103403.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403012", "story_v_side_new_1103403.awb") / 1000

					if var_52_14 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_6
					end

					if var_52_9.prefab_name ~= "" and arg_49_1.actors_[var_52_9.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_9.prefab_name].transform, "story_v_side_new_1103403", "1103403012", "story_v_side_new_1103403.awb")

						arg_49_1:RecordAudio("1103403012", var_52_15)
						arg_49_1:RecordAudio("1103403012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403012", "story_v_side_new_1103403.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403012", "story_v_side_new_1103403.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_16 and arg_49_1.time_ < var_52_6 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1103403013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1103403013
		arg_53_1.duration_ = 6.77

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1103403014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.7

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1109].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(1103403013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 28
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403013", "story_v_side_new_1103403.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403013", "story_v_side_new_1103403.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_side_new_1103403", "1103403013", "story_v_side_new_1103403.awb")

						arg_53_1:RecordAudio("1103403013", var_56_9)
						arg_53_1:RecordAudio("1103403013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403013", "story_v_side_new_1103403.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403013", "story_v_side_new_1103403.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1103403014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1103403014
		arg_57_1.duration_ = 1

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"

			SetActive(arg_57_1.choicesGo_, true)

			for iter_58_0, iter_58_1 in ipairs(arg_57_1.choices_) do
				local var_58_0 = iter_58_0 <= 2

				SetActive(iter_58_1.go, var_58_0)
			end

			arg_57_1.choices_[1].txt.text = arg_57_1:FormatText(StoryChoiceCfg[1455].name)
			arg_57_1.choices_[2].txt.text = arg_57_1:FormatText(StoryChoiceCfg[1456].name)
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1103403015(arg_57_1)
			end

			if arg_59_0 == 2 then
				arg_57_0:Play1103403018(arg_57_1)
			end

			arg_57_1:RecordChoiceLog(1103403014, 1455, 1456)
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1034ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1034ui_story == nil then
				arg_57_1.var_.characterEffect1034ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1034ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1034ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1034ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1034ui_story.fillRatio = var_60_5
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1103403015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1103403015
		arg_61_1.duration_ = 4.4

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1103403016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1034ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1034ui_story == nil then
				arg_61_1.var_.characterEffect1034ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1034ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1034ui_story then
				arg_61_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2")
			end

			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_64_6 = 0
			local var_64_7 = 0.375

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[1109].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_9 = arg_61_1:GetWordFromCfg(1103403015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 15
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

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403015", "story_v_side_new_1103403.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403015", "story_v_side_new_1103403.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_side_new_1103403", "1103403015", "story_v_side_new_1103403.awb")

						arg_61_1:RecordAudio("1103403015", var_64_15)
						arg_61_1:RecordAudio("1103403015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403015", "story_v_side_new_1103403.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403015", "story_v_side_new_1103403.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_16 and arg_61_1.time_ < var_64_6 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1103403016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1103403016
		arg_65_1.duration_ = 3.87

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1103403017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_68_1 = 0
			local var_68_2 = 0.425

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_3 = arg_65_1:FormatText(StoryNameCfg[1109].name)

				arg_65_1.leftNameTxt_.text = var_68_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(1103403016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_6 = 17
				local var_68_7 = utf8.len(var_68_5)
				local var_68_8 = var_68_6 <= 0 and var_68_2 or var_68_2 * (var_68_7 / var_68_6)

				if var_68_8 > 0 and var_68_2 < var_68_8 then
					arg_65_1.talkMaxDuration = var_68_8

					if var_68_8 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403016", "story_v_side_new_1103403.awb") ~= 0 then
					local var_68_9 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403016", "story_v_side_new_1103403.awb") / 1000

					if var_68_9 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_1
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_side_new_1103403", "1103403016", "story_v_side_new_1103403.awb")

						arg_65_1:RecordAudio("1103403016", var_68_10)
						arg_65_1:RecordAudio("1103403016", var_68_10)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403016", "story_v_side_new_1103403.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403016", "story_v_side_new_1103403.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_11 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_11 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_11

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_11 and arg_65_1.time_ < var_68_1 + var_68_11 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1103403017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1103403017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1103403020(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1034ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1034ui_story == nil then
				arg_69_1.var_.characterEffect1034ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1034ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1034ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1034ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1034ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.35

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_9 = arg_69_1:GetWordFromCfg(1103403017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 14
				local var_72_12 = utf8.len(var_72_10)
				local var_72_13 = var_72_11 <= 0 and var_72_7 or var_72_7 * (var_72_12 / var_72_11)

				if var_72_13 > 0 and var_72_7 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1103403020 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1103403020
		arg_73_1.duration_ = 4.37

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1103403021(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1034ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1034ui_story == nil then
				arg_73_1.var_.characterEffect1034ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1034ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1034ui_story then
				arg_73_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_76_4 = 0

			if var_76_4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action467")
			end

			local var_76_5 = 0

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_76_6 = 0
			local var_76_7 = 0.65

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[1109].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_9 = arg_73_1:GetWordFromCfg(1103403020)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403020", "story_v_side_new_1103403.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403020", "story_v_side_new_1103403.awb") / 1000

					if var_76_14 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_6
					end

					if var_76_9.prefab_name ~= "" and arg_73_1.actors_[var_76_9.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_9.prefab_name].transform, "story_v_side_new_1103403", "1103403020", "story_v_side_new_1103403.awb")

						arg_73_1:RecordAudio("1103403020", var_76_15)
						arg_73_1:RecordAudio("1103403020", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403020", "story_v_side_new_1103403.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403020", "story_v_side_new_1103403.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_16 and arg_73_1.time_ < var_76_6 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1103403021 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1103403021
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1103403022(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1034ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1034ui_story == nil then
				arg_77_1.var_.characterEffect1034ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1034ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1034ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1034ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1034ui_story.fillRatio = var_80_5
			end

			local var_80_6 = 0
			local var_80_7 = 0.375

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_8 = arg_77_1:FormatText(StoryNameCfg[7].name)

				arg_77_1.leftNameTxt_.text = var_80_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_9 = arg_77_1:GetWordFromCfg(1103403021)
				local var_80_10 = arg_77_1:FormatText(var_80_9.content)

				arg_77_1.text_.text = var_80_10

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 15
				local var_80_12 = utf8.len(var_80_10)
				local var_80_13 = var_80_11 <= 0 and var_80_7 or var_80_7 * (var_80_12 / var_80_11)

				if var_80_13 > 0 and var_80_7 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_10
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_14 and arg_77_1.time_ < var_80_6 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1103403022 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1103403022
		arg_81_1.duration_ = 3.5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1103403023(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1034ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1034ui_story == nil then
				arg_81_1.var_.characterEffect1034ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1034ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1034ui_story then
				arg_81_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_84_4 = 0

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action472")
			end

			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_84_6 = 0
			local var_84_7 = 0.225

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[1109].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_9 = arg_81_1:GetWordFromCfg(1103403022)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 9
				local var_84_12 = utf8.len(var_84_10)
				local var_84_13 = var_84_11 <= 0 and var_84_7 or var_84_7 * (var_84_12 / var_84_11)

				if var_84_13 > 0 and var_84_7 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403022", "story_v_side_new_1103403.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403022", "story_v_side_new_1103403.awb") / 1000

					if var_84_14 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_6
					end

					if var_84_9.prefab_name ~= "" and arg_81_1.actors_[var_84_9.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_9.prefab_name].transform, "story_v_side_new_1103403", "1103403022", "story_v_side_new_1103403.awb")

						arg_81_1:RecordAudio("1103403022", var_84_15)
						arg_81_1:RecordAudio("1103403022", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403022", "story_v_side_new_1103403.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403022", "story_v_side_new_1103403.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_16 and arg_81_1.time_ < var_84_6 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1103403023 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1103403023
		arg_85_1.duration_ = 6.37

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1103403024(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action425")
			end

			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_88_2 = 0
			local var_88_3 = 0.533333333333333

			if var_88_2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_4 = arg_85_1:FormatText(StoryNameCfg[1109].name)

				arg_85_1.leftNameTxt_.text = var_88_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_5 = arg_85_1:GetWordFromCfg(1103403023)
				local var_88_6 = arg_85_1:FormatText(var_88_5.content)

				arg_85_1.text_.text = var_88_6

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 32
				local var_88_8 = utf8.len(var_88_6)
				local var_88_9 = var_88_7 <= 0 and var_88_3 or var_88_3 * (var_88_8 / var_88_7)

				if var_88_9 > 0 and var_88_3 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_6
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403023", "story_v_side_new_1103403.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403023", "story_v_side_new_1103403.awb") / 1000

					if var_88_10 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_2
					end

					if var_88_5.prefab_name ~= "" and arg_85_1.actors_[var_88_5.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_5.prefab_name].transform, "story_v_side_new_1103403", "1103403023", "story_v_side_new_1103403.awb")

						arg_85_1:RecordAudio("1103403023", var_88_11)
						arg_85_1:RecordAudio("1103403023", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403023", "story_v_side_new_1103403.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403023", "story_v_side_new_1103403.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_12 and arg_85_1.time_ < var_88_2 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1103403024 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1103403024
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1103403025(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1034ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1034ui_story == nil then
				arg_89_1.var_.characterEffect1034ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1034ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1034ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1034ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1034ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_92_7 = 0
			local var_92_8 = 0.35

			if var_92_7 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_9 = arg_89_1:FormatText(StoryNameCfg[7].name)

				arg_89_1.leftNameTxt_.text = var_92_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_10 = arg_89_1:GetWordFromCfg(1103403024)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_12 = 14
				local var_92_13 = utf8.len(var_92_11)
				local var_92_14 = var_92_12 <= 0 and var_92_8 or var_92_8 * (var_92_13 / var_92_12)

				if var_92_14 > 0 and var_92_8 < var_92_14 then
					arg_89_1.talkMaxDuration = var_92_14

					if var_92_14 + var_92_7 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_7
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_15 = math.max(var_92_8, arg_89_1.talkMaxDuration)

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_15 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_7) / var_92_15

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_7 + var_92_15 and arg_89_1.time_ < var_92_7 + var_92_15 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1103403025 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1103403025
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1103403026(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_2 = 0
			local var_96_3 = 0.625

			if var_96_2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_4 = arg_93_1:FormatText(StoryNameCfg[7].name)

				arg_93_1.leftNameTxt_.text = var_96_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_5 = arg_93_1:GetWordFromCfg(1103403025)
				local var_96_6 = arg_93_1:FormatText(var_96_5.content)

				arg_93_1.text_.text = var_96_6

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 25
				local var_96_8 = utf8.len(var_96_6)
				local var_96_9 = var_96_7 <= 0 and var_96_3 or var_96_3 * (var_96_8 / var_96_7)

				if var_96_9 > 0 and var_96_3 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_6
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_10 and arg_93_1.time_ < var_96_2 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1103403026 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1103403026
		arg_97_1.duration_ = 7.3

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1103403027(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1034ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1034ui_story == nil then
				arg_97_1.var_.characterEffect1034ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1034ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1034ui_story then
				arg_97_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_100_4 = 0

			if var_100_4 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			local var_100_5 = 0

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_100_6 = 0
			local var_100_7 = 1

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[1109].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_9 = arg_97_1:GetWordFromCfg(1103403026)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 40
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403026", "story_v_side_new_1103403.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403026", "story_v_side_new_1103403.awb") / 1000

					if var_100_14 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_6
					end

					if var_100_9.prefab_name ~= "" and arg_97_1.actors_[var_100_9.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_9.prefab_name].transform, "story_v_side_new_1103403", "1103403026", "story_v_side_new_1103403.awb")

						arg_97_1:RecordAudio("1103403026", var_100_15)
						arg_97_1:RecordAudio("1103403026", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403026", "story_v_side_new_1103403.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403026", "story_v_side_new_1103403.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_16 and arg_97_1.time_ < var_100_6 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1103403027 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1103403027
		arg_101_1.duration_ = 7.33

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1103403028(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_104_1 = 0
			local var_104_2 = 0.9

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_3 = arg_101_1:FormatText(StoryNameCfg[1109].name)

				arg_101_1.leftNameTxt_.text = var_104_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(1103403027)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_6 = 36
				local var_104_7 = utf8.len(var_104_5)
				local var_104_8 = var_104_6 <= 0 and var_104_2 or var_104_2 * (var_104_7 / var_104_6)

				if var_104_8 > 0 and var_104_2 < var_104_8 then
					arg_101_1.talkMaxDuration = var_104_8

					if var_104_8 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403027", "story_v_side_new_1103403.awb") ~= 0 then
					local var_104_9 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403027", "story_v_side_new_1103403.awb") / 1000

					if var_104_9 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_1
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_side_new_1103403", "1103403027", "story_v_side_new_1103403.awb")

						arg_101_1:RecordAudio("1103403027", var_104_10)
						arg_101_1:RecordAudio("1103403027", var_104_10)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403027", "story_v_side_new_1103403.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403027", "story_v_side_new_1103403.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_11 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_11 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_11

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_11 and arg_101_1.time_ < var_104_1 + var_104_11 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1103403028 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1103403028
		arg_105_1.duration_ = 3.87

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1103403029(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action426")
			end

			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_108_2 = 0
			local var_108_3 = 0.5

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_4 = arg_105_1:FormatText(StoryNameCfg[1109].name)

				arg_105_1.leftNameTxt_.text = var_108_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_5 = arg_105_1:GetWordFromCfg(1103403028)
				local var_108_6 = arg_105_1:FormatText(var_108_5.content)

				arg_105_1.text_.text = var_108_6

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 20
				local var_108_8 = utf8.len(var_108_6)
				local var_108_9 = var_108_7 <= 0 and var_108_3 or var_108_3 * (var_108_8 / var_108_7)

				if var_108_9 > 0 and var_108_3 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_6
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403028", "story_v_side_new_1103403.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403028", "story_v_side_new_1103403.awb") / 1000

					if var_108_10 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_2
					end

					if var_108_5.prefab_name ~= "" and arg_105_1.actors_[var_108_5.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_5.prefab_name].transform, "story_v_side_new_1103403", "1103403028", "story_v_side_new_1103403.awb")

						arg_105_1:RecordAudio("1103403028", var_108_11)
						arg_105_1:RecordAudio("1103403028", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403028", "story_v_side_new_1103403.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403028", "story_v_side_new_1103403.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_12 and arg_105_1.time_ < var_108_2 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1103403029 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1103403029
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1103403030(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1034ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1034ui_story == nil then
				arg_109_1.var_.characterEffect1034ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1034ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1034ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1034ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1034ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.7

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[7].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_9 = arg_109_1:GetWordFromCfg(1103403029)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 28
				local var_112_12 = utf8.len(var_112_10)
				local var_112_13 = var_112_11 <= 0 and var_112_7 or var_112_7 * (var_112_12 / var_112_11)

				if var_112_13 > 0 and var_112_7 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_14 and arg_109_1.time_ < var_112_6 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1103403030 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1103403030
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1103403031(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.7

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(1103403030)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 28
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_8 and arg_113_1.time_ < var_116_0 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1103403031 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1103403031
		arg_117_1.duration_ = 1.27

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1103403032(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1034ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1034ui_story == nil then
				arg_117_1.var_.characterEffect1034ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1034ui_story and not isNil(var_120_0) then
					arg_117_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1034ui_story then
				arg_117_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_120_4 = 0
			local var_120_5 = 0.1

			if var_120_4 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_6 = arg_117_1:FormatText(StoryNameCfg[1109].name)

				arg_117_1.leftNameTxt_.text = var_120_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_7 = arg_117_1:GetWordFromCfg(1103403031)
				local var_120_8 = arg_117_1:FormatText(var_120_7.content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 4
				local var_120_10 = utf8.len(var_120_8)
				local var_120_11 = var_120_9 <= 0 and var_120_5 or var_120_5 * (var_120_10 / var_120_9)

				if var_120_11 > 0 and var_120_5 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403031", "story_v_side_new_1103403.awb") ~= 0 then
					local var_120_12 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403031", "story_v_side_new_1103403.awb") / 1000

					if var_120_12 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_4
					end

					if var_120_7.prefab_name ~= "" and arg_117_1.actors_[var_120_7.prefab_name] ~= nil then
						local var_120_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_7.prefab_name].transform, "story_v_side_new_1103403", "1103403031", "story_v_side_new_1103403.awb")

						arg_117_1:RecordAudio("1103403031", var_120_13)
						arg_117_1:RecordAudio("1103403031", var_120_13)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403031", "story_v_side_new_1103403.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403031", "story_v_side_new_1103403.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_14 and arg_117_1.time_ < var_120_4 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1103403032 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1103403032
		arg_121_1.duration_ = 6.67

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1103403033(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1034ui_story"]
			local var_124_1 = 1.66666666666667

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1034ui_story == nil then
				arg_121_1.var_.characterEffect1034ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1034ui_story and not isNil(var_124_0) then
					local var_124_4 = Mathf.Lerp(0, 0.5, var_124_3)

					arg_121_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1034ui_story.fillRatio = var_124_4
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1034ui_story then
				local var_124_5 = 0.5

				arg_121_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1034ui_story.fillRatio = var_124_5
			end

			local var_124_6 = 1.66666666666667

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = false

				arg_121_1:SetGaussion(false)
			end

			local var_124_7 = 0.333333333333333

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_7 then
				local var_124_8 = (arg_121_1.time_ - var_124_6) / var_124_7
				local var_124_9 = Color.New(1, 1, 1)

				var_124_9.a = Mathf.Lerp(1, 0, var_124_8)
				arg_121_1.mask_.color = var_124_9
			end

			if arg_121_1.time_ >= var_124_6 + var_124_7 and arg_121_1.time_ < var_124_6 + var_124_7 + arg_124_0 then
				local var_124_10 = Color.New(1, 1, 1)
				local var_124_11 = 0

				arg_121_1.mask_.enabled = false
				var_124_10.a = var_124_11
				arg_121_1.mask_.color = var_124_10
			end

			local var_124_12 = 0

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				local var_124_13 = manager.ui.mainCamera.transform.localPosition
				local var_124_14 = Vector3.New(0, 0, 10) + Vector3.New(var_124_13.x, var_124_13.y, 0)
				local var_124_15 = arg_121_1.bgs_.I11o

				var_124_15.transform.localPosition = var_124_14
				var_124_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_124_16 = var_124_15:GetComponent("SpriteRenderer")

				if var_124_16 and var_124_16.sprite then
					local var_124_17 = (var_124_15.transform.localPosition - var_124_13).z
					local var_124_18 = manager.ui.mainCameraCom_
					local var_124_19 = 2 * var_124_17 * Mathf.Tan(var_124_18.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_124_20 = var_124_19 * var_124_18.aspect
					local var_124_21 = var_124_16.sprite.bounds.size.x
					local var_124_22 = var_124_16.sprite.bounds.size.y
					local var_124_23 = var_124_20 / var_124_21
					local var_124_24 = var_124_19 / var_124_22
					local var_124_25 = var_124_24 < var_124_23 and var_124_23 or var_124_24

					var_124_15.transform.localScale = Vector3.New(var_124_25, var_124_25, 0)
				end

				for iter_124_0, iter_124_1 in pairs(arg_121_1.bgs_) do
					if iter_124_0 ~= "I11o" then
						iter_124_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_124_26 = 1.66666666666667
			local var_124_27 = 1

			if var_124_26 < arg_121_1.time_ and arg_121_1.time_ <= var_124_26 + arg_124_0 then
				local var_124_28 = "play"
				local var_124_29 = "effect"

				arg_121_1:AudioAction(var_124_28, var_124_29, "se_story_16", "se_story_16_camera", "")
			end

			local var_124_30 = 0

			if var_124_30 < arg_121_1.time_ and arg_121_1.time_ <= var_124_30 + arg_124_0 then
				arg_121_1.allBtn_.enabled = false
			end

			local var_124_31 = 2.66666666666667

			if arg_121_1.time_ >= var_124_30 + var_124_31 and arg_121_1.time_ < var_124_30 + var_124_31 + arg_124_0 then
				arg_121_1.allBtn_.enabled = true
			end

			local var_124_32 = 1.66666666666667
			local var_124_33 = 0.975

			if var_124_32 < arg_121_1.time_ and arg_121_1.time_ <= var_124_32 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_34 = arg_121_1:GetWordFromCfg(1103403032)
				local var_124_35 = arg_121_1:FormatText(var_124_34.content)

				arg_121_1.text_.text = var_124_35

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_36 = 39
				local var_124_37 = utf8.len(var_124_35)
				local var_124_38 = var_124_36 <= 0 and var_124_33 or var_124_33 * (var_124_37 / var_124_36)

				if var_124_38 > 0 and var_124_33 < var_124_38 then
					arg_121_1.talkMaxDuration = var_124_38

					if var_124_38 + var_124_32 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_38 + var_124_32
					end
				end

				arg_121_1.text_.text = var_124_35
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_39 = math.max(var_124_33, arg_121_1.talkMaxDuration)

			if var_124_32 <= arg_121_1.time_ and arg_121_1.time_ < var_124_32 + var_124_39 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_32) / var_124_39

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_32 + var_124_39 and arg_121_1.time_ < var_124_32 + var_124_39 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1103403033 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1103403033
		arg_125_1.duration_ = 4.63

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1103403034(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1034ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1034ui_story == nil then
				arg_125_1.var_.characterEffect1034ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1034ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1034ui_story then
				arg_125_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_128_4 = 0

			if var_128_4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			local var_128_5 = 0

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_128_6 = arg_125_1.actors_["1034ui_story"].transform
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 then
				arg_125_1.var_.moveOldPos1034ui_story = var_128_6.localPosition
			end

			local var_128_8 = 0.001

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_8 then
				local var_128_9 = (arg_125_1.time_ - var_128_7) / var_128_8
				local var_128_10 = Vector3.New(0, -0.93, -6)

				var_128_6.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1034ui_story, var_128_10, var_128_9)

				local var_128_11 = manager.ui.mainCamera.transform.position - var_128_6.position

				var_128_6.forward = Vector3.New(var_128_11.x, var_128_11.y, var_128_11.z)

				local var_128_12 = var_128_6.localEulerAngles

				var_128_12.z = 0
				var_128_12.x = 0
				var_128_6.localEulerAngles = var_128_12
			end

			if arg_125_1.time_ >= var_128_7 + var_128_8 and arg_125_1.time_ < var_128_7 + var_128_8 + arg_128_0 then
				var_128_6.localPosition = Vector3.New(0, -0.93, -6)

				local var_128_13 = manager.ui.mainCamera.transform.position - var_128_6.position

				var_128_6.forward = Vector3.New(var_128_13.x, var_128_13.y, var_128_13.z)

				local var_128_14 = var_128_6.localEulerAngles

				var_128_14.z = 0
				var_128_14.x = 0
				var_128_6.localEulerAngles = var_128_14
			end

			local var_128_15 = 0
			local var_128_16 = 0.6

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_17 = arg_125_1:FormatText(StoryNameCfg[1109].name)

				arg_125_1.leftNameTxt_.text = var_128_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_18 = arg_125_1:GetWordFromCfg(1103403033)
				local var_128_19 = arg_125_1:FormatText(var_128_18.content)

				arg_125_1.text_.text = var_128_19

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_20 = 24
				local var_128_21 = utf8.len(var_128_19)
				local var_128_22 = var_128_20 <= 0 and var_128_16 or var_128_16 * (var_128_21 / var_128_20)

				if var_128_22 > 0 and var_128_16 < var_128_22 then
					arg_125_1.talkMaxDuration = var_128_22

					if var_128_22 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_22 + var_128_15
					end
				end

				arg_125_1.text_.text = var_128_19
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403033", "story_v_side_new_1103403.awb") ~= 0 then
					local var_128_23 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403033", "story_v_side_new_1103403.awb") / 1000

					if var_128_23 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_23 + var_128_15
					end

					if var_128_18.prefab_name ~= "" and arg_125_1.actors_[var_128_18.prefab_name] ~= nil then
						local var_128_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_18.prefab_name].transform, "story_v_side_new_1103403", "1103403033", "story_v_side_new_1103403.awb")

						arg_125_1:RecordAudio("1103403033", var_128_24)
						arg_125_1:RecordAudio("1103403033", var_128_24)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403033", "story_v_side_new_1103403.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403033", "story_v_side_new_1103403.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_25 = math.max(var_128_16, arg_125_1.talkMaxDuration)

			if var_128_15 <= arg_125_1.time_ and arg_125_1.time_ < var_128_15 + var_128_25 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_15) / var_128_25

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_15 + var_128_25 and arg_125_1.time_ < var_128_15 + var_128_25 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play1103403034 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1103403034
		arg_129_1.duration_ = 6.27

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1103403035(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_132_1 = 0
			local var_132_2 = 0.775

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_3 = arg_129_1:FormatText(StoryNameCfg[1109].name)

				arg_129_1.leftNameTxt_.text = var_132_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:GetWordFromCfg(1103403034)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 31
				local var_132_7 = utf8.len(var_132_5)
				local var_132_8 = var_132_6 <= 0 and var_132_2 or var_132_2 * (var_132_7 / var_132_6)

				if var_132_8 > 0 and var_132_2 < var_132_8 then
					arg_129_1.talkMaxDuration = var_132_8

					if var_132_8 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403034", "story_v_side_new_1103403.awb") ~= 0 then
					local var_132_9 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403034", "story_v_side_new_1103403.awb") / 1000

					if var_132_9 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_1
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_side_new_1103403", "1103403034", "story_v_side_new_1103403.awb")

						arg_129_1:RecordAudio("1103403034", var_132_10)
						arg_129_1:RecordAudio("1103403034", var_132_10)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403034", "story_v_side_new_1103403.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403034", "story_v_side_new_1103403.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_11 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_11 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_11

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_11 and arg_129_1.time_ < var_132_1 + var_132_11 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1103403035 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1103403035
		arg_133_1.duration_ = 4.97

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1103403036(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action4_1")
			end

			local var_136_2 = 0
			local var_136_3 = 0.65

			if var_136_2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_4 = arg_133_1:FormatText(StoryNameCfg[1109].name)

				arg_133_1.leftNameTxt_.text = var_136_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_5 = arg_133_1:GetWordFromCfg(1103403035)
				local var_136_6 = arg_133_1:FormatText(var_136_5.content)

				arg_133_1.text_.text = var_136_6

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 26
				local var_136_8 = utf8.len(var_136_6)
				local var_136_9 = var_136_7 <= 0 and var_136_3 or var_136_3 * (var_136_8 / var_136_7)

				if var_136_9 > 0 and var_136_3 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_6
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403035", "story_v_side_new_1103403.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403035", "story_v_side_new_1103403.awb") / 1000

					if var_136_10 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_2
					end

					if var_136_5.prefab_name ~= "" and arg_133_1.actors_[var_136_5.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_5.prefab_name].transform, "story_v_side_new_1103403", "1103403035", "story_v_side_new_1103403.awb")

						arg_133_1:RecordAudio("1103403035", var_136_11)
						arg_133_1:RecordAudio("1103403035", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403035", "story_v_side_new_1103403.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403035", "story_v_side_new_1103403.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_12 and arg_133_1.time_ < var_136_2 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1103403036 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1103403036
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1103403037(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1034ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1034ui_story == nil then
				arg_137_1.var_.characterEffect1034ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1034ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1034ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1034ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1034ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 0.475

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

				local var_140_9 = arg_137_1:GetWordFromCfg(1103403036)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 19
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
	Play1103403037 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1103403037
		arg_141_1.duration_ = 7.27

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1103403038(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1034ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1034ui_story == nil then
				arg_141_1.var_.characterEffect1034ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1034ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1034ui_story then
				arg_141_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_144_4 = 0

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action446")
			end

			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_144_6 = 0
			local var_144_7 = 0.7

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_8 = arg_141_1:FormatText(StoryNameCfg[1109].name)

				arg_141_1.leftNameTxt_.text = var_144_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_9 = arg_141_1:GetWordFromCfg(1103403037)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 28
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

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403037", "story_v_side_new_1103403.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403037", "story_v_side_new_1103403.awb") / 1000

					if var_144_14 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_6
					end

					if var_144_9.prefab_name ~= "" and arg_141_1.actors_[var_144_9.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_9.prefab_name].transform, "story_v_side_new_1103403", "1103403037", "story_v_side_new_1103403.awb")

						arg_141_1:RecordAudio("1103403037", var_144_15)
						arg_141_1:RecordAudio("1103403037", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403037", "story_v_side_new_1103403.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403037", "story_v_side_new_1103403.awb")
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
	Play1103403038 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1103403038
		arg_145_1.duration_ = 6.67

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1103403039(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_148_1 = 0
			local var_148_2 = 0.7

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_3 = arg_145_1:FormatText(StoryNameCfg[1109].name)

				arg_145_1.leftNameTxt_.text = var_148_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_4 = arg_145_1:GetWordFromCfg(1103403038)
				local var_148_5 = arg_145_1:FormatText(var_148_4.content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_6 = 28
				local var_148_7 = utf8.len(var_148_5)
				local var_148_8 = var_148_6 <= 0 and var_148_2 or var_148_2 * (var_148_7 / var_148_6)

				if var_148_8 > 0 and var_148_2 < var_148_8 then
					arg_145_1.talkMaxDuration = var_148_8

					if var_148_8 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403038", "story_v_side_new_1103403.awb") ~= 0 then
					local var_148_9 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403038", "story_v_side_new_1103403.awb") / 1000

					if var_148_9 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_1
					end

					if var_148_4.prefab_name ~= "" and arg_145_1.actors_[var_148_4.prefab_name] ~= nil then
						local var_148_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_4.prefab_name].transform, "story_v_side_new_1103403", "1103403038", "story_v_side_new_1103403.awb")

						arg_145_1:RecordAudio("1103403038", var_148_10)
						arg_145_1:RecordAudio("1103403038", var_148_10)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403038", "story_v_side_new_1103403.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403038", "story_v_side_new_1103403.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_11 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_11 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_11

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_11 and arg_145_1.time_ < var_148_1 + var_148_11 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1103403039 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1103403039
		arg_149_1.duration_ = 8.43

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1103403040(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_152_1 = 0
			local var_152_2 = 0.925

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_3 = arg_149_1:FormatText(StoryNameCfg[1109].name)

				arg_149_1.leftNameTxt_.text = var_152_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_4 = arg_149_1:GetWordFromCfg(1103403039)
				local var_152_5 = arg_149_1:FormatText(var_152_4.content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_6 = 37
				local var_152_7 = utf8.len(var_152_5)
				local var_152_8 = var_152_6 <= 0 and var_152_2 or var_152_2 * (var_152_7 / var_152_6)

				if var_152_8 > 0 and var_152_2 < var_152_8 then
					arg_149_1.talkMaxDuration = var_152_8

					if var_152_8 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_1
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403039", "story_v_side_new_1103403.awb") ~= 0 then
					local var_152_9 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403039", "story_v_side_new_1103403.awb") / 1000

					if var_152_9 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_1
					end

					if var_152_4.prefab_name ~= "" and arg_149_1.actors_[var_152_4.prefab_name] ~= nil then
						local var_152_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_4.prefab_name].transform, "story_v_side_new_1103403", "1103403039", "story_v_side_new_1103403.awb")

						arg_149_1:RecordAudio("1103403039", var_152_10)
						arg_149_1:RecordAudio("1103403039", var_152_10)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403039", "story_v_side_new_1103403.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403039", "story_v_side_new_1103403.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_11 = math.max(var_152_2, arg_149_1.talkMaxDuration)

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_11 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_1) / var_152_11

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_1 + var_152_11 and arg_149_1.time_ < var_152_1 + var_152_11 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1103403040 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1103403040
		arg_153_1.duration_ = 6.57

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1103403041(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.7

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[1109].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(1103403040)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 28
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403040", "story_v_side_new_1103403.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403040", "story_v_side_new_1103403.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_side_new_1103403", "1103403040", "story_v_side_new_1103403.awb")

						arg_153_1:RecordAudio("1103403040", var_156_9)
						arg_153_1:RecordAudio("1103403040", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403040", "story_v_side_new_1103403.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403040", "story_v_side_new_1103403.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1103403041 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1103403041
		arg_157_1.duration_ = 4.33

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1103403042(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_160_2 = 0
			local var_160_3 = 0.5

			if var_160_2 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_4 = arg_157_1:FormatText(StoryNameCfg[1109].name)

				arg_157_1.leftNameTxt_.text = var_160_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_5 = arg_157_1:GetWordFromCfg(1103403041)
				local var_160_6 = arg_157_1:FormatText(var_160_5.content)

				arg_157_1.text_.text = var_160_6

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_7 = 20
				local var_160_8 = utf8.len(var_160_6)
				local var_160_9 = var_160_7 <= 0 and var_160_3 or var_160_3 * (var_160_8 / var_160_7)

				if var_160_9 > 0 and var_160_3 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_2
					end
				end

				arg_157_1.text_.text = var_160_6
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403041", "story_v_side_new_1103403.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403041", "story_v_side_new_1103403.awb") / 1000

					if var_160_10 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_2
					end

					if var_160_5.prefab_name ~= "" and arg_157_1.actors_[var_160_5.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_5.prefab_name].transform, "story_v_side_new_1103403", "1103403041", "story_v_side_new_1103403.awb")

						arg_157_1:RecordAudio("1103403041", var_160_11)
						arg_157_1:RecordAudio("1103403041", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403041", "story_v_side_new_1103403.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403041", "story_v_side_new_1103403.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_3, arg_157_1.talkMaxDuration)

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_2) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_2 + var_160_12 and arg_157_1.time_ < var_160_2 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1103403042 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1103403042
		arg_161_1.duration_ = 2

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1103403043(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1034ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1034ui_story == nil then
				arg_161_1.var_.characterEffect1034ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1034ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1034ui_story then
				arg_161_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_164_4 = 0

			if var_164_4 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_164_5 = 0
			local var_164_6 = 0.05

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_7 = arg_161_1:FormatText(StoryNameCfg[1384].name)

				arg_161_1.leftNameTxt_.text = var_164_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_8 = arg_161_1:GetWordFromCfg(1103403042)
				local var_164_9 = arg_161_1:FormatText(var_164_8.content)

				arg_161_1.text_.text = var_164_9

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_10 = 2
				local var_164_11 = utf8.len(var_164_9)
				local var_164_12 = var_164_10 <= 0 and var_164_6 or var_164_6 * (var_164_11 / var_164_10)

				if var_164_12 > 0 and var_164_6 < var_164_12 then
					arg_161_1.talkMaxDuration = var_164_12

					if var_164_12 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_12 + var_164_5
					end
				end

				arg_161_1.text_.text = var_164_9
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403042", "story_v_side_new_1103403.awb") ~= 0 then
					local var_164_13 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403042", "story_v_side_new_1103403.awb") / 1000

					if var_164_13 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_5
					end

					if var_164_8.prefab_name ~= "" and arg_161_1.actors_[var_164_8.prefab_name] ~= nil then
						local var_164_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_8.prefab_name].transform, "story_v_side_new_1103403", "1103403042", "story_v_side_new_1103403.awb")

						arg_161_1:RecordAudio("1103403042", var_164_14)
						arg_161_1:RecordAudio("1103403042", var_164_14)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403042", "story_v_side_new_1103403.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403042", "story_v_side_new_1103403.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_15 = math.max(var_164_6, arg_161_1.talkMaxDuration)

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_15 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_5) / var_164_15

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_5 + var_164_15 and arg_161_1.time_ < var_164_5 + var_164_15 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1103403043 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1103403043
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1103403044(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_168_2 = arg_165_1.actors_["1034ui_story"]
			local var_168_3 = 0

			if var_168_3 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect1034ui_story == nil then
				arg_165_1.var_.characterEffect1034ui_story = var_168_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_4 = 0.200000002980232

			if var_168_3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_3 + var_168_4 and not isNil(var_168_2) then
				local var_168_5 = (arg_165_1.time_ - var_168_3) / var_168_4

				if arg_165_1.var_.characterEffect1034ui_story and not isNil(var_168_2) then
					local var_168_6 = Mathf.Lerp(0, 0.5, var_168_5)

					arg_165_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1034ui_story.fillRatio = var_168_6
				end
			end

			if arg_165_1.time_ >= var_168_3 + var_168_4 and arg_165_1.time_ < var_168_3 + var_168_4 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect1034ui_story then
				local var_168_7 = 0.5

				arg_165_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1034ui_story.fillRatio = var_168_7
			end

			local var_168_8 = 0
			local var_168_9 = 1.15

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:GetWordFromCfg(1103403043)
				local var_168_11 = arg_165_1:FormatText(var_168_10.content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_12 = 46
				local var_168_13 = utf8.len(var_168_11)
				local var_168_14 = var_168_12 <= 0 and var_168_9 or var_168_9 * (var_168_13 / var_168_12)

				if var_168_14 > 0 and var_168_9 < var_168_14 then
					arg_165_1.talkMaxDuration = var_168_14

					if var_168_14 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_15 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_15 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_15

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_15 and arg_165_1.time_ < var_168_8 + var_168_15 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1103403044 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1103403044
		arg_169_1.duration_ = 5.17

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1103403045(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1034ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1034ui_story == nil then
				arg_169_1.var_.characterEffect1034ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect1034ui_story and not isNil(var_172_0) then
					arg_169_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1034ui_story then
				arg_169_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_172_4 = 0

			if var_172_4 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			local var_172_5 = 0

			if var_172_5 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_172_6 = 0
			local var_172_7 = 0.8

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_8 = arg_169_1:FormatText(StoryNameCfg[1109].name)

				arg_169_1.leftNameTxt_.text = var_172_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_9 = arg_169_1:GetWordFromCfg(1103403044)
				local var_172_10 = arg_169_1:FormatText(var_172_9.content)

				arg_169_1.text_.text = var_172_10

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 32
				local var_172_12 = utf8.len(var_172_10)
				local var_172_13 = var_172_11 <= 0 and var_172_7 or var_172_7 * (var_172_12 / var_172_11)

				if var_172_13 > 0 and var_172_7 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_10
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403044", "story_v_side_new_1103403.awb") ~= 0 then
					local var_172_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403044", "story_v_side_new_1103403.awb") / 1000

					if var_172_14 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_6
					end

					if var_172_9.prefab_name ~= "" and arg_169_1.actors_[var_172_9.prefab_name] ~= nil then
						local var_172_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_9.prefab_name].transform, "story_v_side_new_1103403", "1103403044", "story_v_side_new_1103403.awb")

						arg_169_1:RecordAudio("1103403044", var_172_15)
						arg_169_1:RecordAudio("1103403044", var_172_15)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403044", "story_v_side_new_1103403.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403044", "story_v_side_new_1103403.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_16 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_16 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_16

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_16 and arg_169_1.time_ < var_172_6 + var_172_16 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1103403045 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1103403045
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1103403046(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1034ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1034ui_story == nil then
				arg_173_1.var_.characterEffect1034ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1034ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1034ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1034ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1034ui_story.fillRatio = var_176_5
			end

			local var_176_6 = 0
			local var_176_7 = 0.25

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

				local var_176_9 = arg_173_1:GetWordFromCfg(1103403045)
				local var_176_10 = arg_173_1:FormatText(var_176_9.content)

				arg_173_1.text_.text = var_176_10

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 10
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
	Play1103403046 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1103403046
		arg_177_1.duration_ = 2.27

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1103403047(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1034ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1034ui_story == nil then
				arg_177_1.var_.characterEffect1034ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1034ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1034ui_story then
				arg_177_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_180_4 = 0

			if var_180_4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_180_5 = 0
			local var_180_6 = 0.225

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_7 = arg_177_1:FormatText(StoryNameCfg[1109].name)

				arg_177_1.leftNameTxt_.text = var_180_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(1103403046)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 9
				local var_180_11 = utf8.len(var_180_9)
				local var_180_12 = var_180_10 <= 0 and var_180_6 or var_180_6 * (var_180_11 / var_180_10)

				if var_180_12 > 0 and var_180_6 < var_180_12 then
					arg_177_1.talkMaxDuration = var_180_12

					if var_180_12 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403046", "story_v_side_new_1103403.awb") ~= 0 then
					local var_180_13 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403046", "story_v_side_new_1103403.awb") / 1000

					if var_180_13 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_5
					end

					if var_180_8.prefab_name ~= "" and arg_177_1.actors_[var_180_8.prefab_name] ~= nil then
						local var_180_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_8.prefab_name].transform, "story_v_side_new_1103403", "1103403046", "story_v_side_new_1103403.awb")

						arg_177_1:RecordAudio("1103403046", var_180_14)
						arg_177_1:RecordAudio("1103403046", var_180_14)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403046", "story_v_side_new_1103403.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403046", "story_v_side_new_1103403.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_15 = math.max(var_180_6, arg_177_1.talkMaxDuration)

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_15 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_5) / var_180_15

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_5 + var_180_15 and arg_177_1.time_ < var_180_5 + var_180_15 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1103403047 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1103403047
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1103403048(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1034ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1034ui_story == nil then
				arg_181_1.var_.characterEffect1034ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1034ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1034ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1034ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1034ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2")
			end

			local var_184_7 = arg_181_1.actors_["1034ui_story"]
			local var_184_8 = 0

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.characterEffect1034ui_story == nil then
				arg_181_1.var_.characterEffect1034ui_story = var_184_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_9 = 0.200000002980232

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_9 and not isNil(var_184_7) then
				local var_184_10 = (arg_181_1.time_ - var_184_8) / var_184_9

				if arg_181_1.var_.characterEffect1034ui_story and not isNil(var_184_7) then
					local var_184_11 = Mathf.Lerp(0, 0.5, var_184_10)

					arg_181_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1034ui_story.fillRatio = var_184_11
				end
			end

			if arg_181_1.time_ >= var_184_8 + var_184_9 and arg_181_1.time_ < var_184_8 + var_184_9 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.characterEffect1034ui_story then
				local var_184_12 = 0.5

				arg_181_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1034ui_story.fillRatio = var_184_12
			end

			local var_184_13 = 0
			local var_184_14 = 0.45

			if var_184_13 < arg_181_1.time_ and arg_181_1.time_ <= var_184_13 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_15 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_15

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

				local var_184_16 = arg_181_1:GetWordFromCfg(1103403047)
				local var_184_17 = arg_181_1:FormatText(var_184_16.content)

				arg_181_1.text_.text = var_184_17

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_18 = 18
				local var_184_19 = utf8.len(var_184_17)
				local var_184_20 = var_184_18 <= 0 and var_184_14 or var_184_14 * (var_184_19 / var_184_18)

				if var_184_20 > 0 and var_184_14 < var_184_20 then
					arg_181_1.talkMaxDuration = var_184_20

					if var_184_20 + var_184_13 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_20 + var_184_13
					end
				end

				arg_181_1.text_.text = var_184_17
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_21 = math.max(var_184_14, arg_181_1.talkMaxDuration)

			if var_184_13 <= arg_181_1.time_ and arg_181_1.time_ < var_184_13 + var_184_21 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_13) / var_184_21

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_13 + var_184_21 and arg_181_1.time_ < var_184_13 + var_184_21 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1103403048 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1103403048
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1103403049(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.55

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[7].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(1103403048)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 22
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
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1103403049 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1103403049
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1103403050(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_192_1 = 0
			local var_192_2 = 0.5

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_3 = arg_189_1:FormatText(StoryNameCfg[7].name)

				arg_189_1.leftNameTxt_.text = var_192_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_4 = arg_189_1:GetWordFromCfg(1103403049)
				local var_192_5 = arg_189_1:FormatText(var_192_4.content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_6 = 20
				local var_192_7 = utf8.len(var_192_5)
				local var_192_8 = var_192_6 <= 0 and var_192_2 or var_192_2 * (var_192_7 / var_192_6)

				if var_192_8 > 0 and var_192_2 < var_192_8 then
					arg_189_1.talkMaxDuration = var_192_8

					if var_192_8 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_9 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_9 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_9

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_9 and arg_189_1.time_ < var_192_1 + var_192_9 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1103403050 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1103403050
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1103403051(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.466666666666667

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_196_1 = 0.466666666666667

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_196_2 = 0
			local var_196_3 = 0.925

			if var_196_2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_2 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_4 = arg_193_1:GetWordFromCfg(1103403050)
				local var_196_5 = arg_193_1:FormatText(var_196_4.content)

				arg_193_1.text_.text = var_196_5

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_6 = 37
				local var_196_7 = utf8.len(var_196_5)
				local var_196_8 = var_196_6 <= 0 and var_196_3 or var_196_3 * (var_196_7 / var_196_6)

				if var_196_8 > 0 and var_196_3 < var_196_8 then
					arg_193_1.talkMaxDuration = var_196_8

					if var_196_8 + var_196_2 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_2
					end
				end

				arg_193_1.text_.text = var_196_5
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_9 = math.max(var_196_3, arg_193_1.talkMaxDuration)

			if var_196_2 <= arg_193_1.time_ and arg_193_1.time_ < var_196_2 + var_196_9 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_2) / var_196_9

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_2 + var_196_9 and arg_193_1.time_ < var_196_2 + var_196_9 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1103403051 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1103403051
		arg_197_1.duration_ = 2.3

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1103403052(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1034ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1034ui_story == nil then
				arg_197_1.var_.characterEffect1034ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1034ui_story and not isNil(var_200_0) then
					arg_197_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1034ui_story then
				arg_197_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_200_4 = 0
			local var_200_5 = 0.325

			if var_200_4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_6 = arg_197_1:FormatText(StoryNameCfg[1109].name)

				arg_197_1.leftNameTxt_.text = var_200_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_7 = arg_197_1:GetWordFromCfg(1103403051)
				local var_200_8 = arg_197_1:FormatText(var_200_7.content)

				arg_197_1.text_.text = var_200_8

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 13
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

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403051", "story_v_side_new_1103403.awb") ~= 0 then
					local var_200_12 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403051", "story_v_side_new_1103403.awb") / 1000

					if var_200_12 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_12 + var_200_4
					end

					if var_200_7.prefab_name ~= "" and arg_197_1.actors_[var_200_7.prefab_name] ~= nil then
						local var_200_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_7.prefab_name].transform, "story_v_side_new_1103403", "1103403051", "story_v_side_new_1103403.awb")

						arg_197_1:RecordAudio("1103403051", var_200_13)
						arg_197_1:RecordAudio("1103403051", var_200_13)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403051", "story_v_side_new_1103403.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403051", "story_v_side_new_1103403.awb")
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
	Play1103403052 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1103403052
		arg_201_1.duration_ = 4.37

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1103403053(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_204_2 = 0
			local var_204_3 = 0.45

			if var_204_2 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_4 = arg_201_1:FormatText(StoryNameCfg[1109].name)

				arg_201_1.leftNameTxt_.text = var_204_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_5 = arg_201_1:GetWordFromCfg(1103403052)
				local var_204_6 = arg_201_1:FormatText(var_204_5.content)

				arg_201_1.text_.text = var_204_6

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 18
				local var_204_8 = utf8.len(var_204_6)
				local var_204_9 = var_204_7 <= 0 and var_204_3 or var_204_3 * (var_204_8 / var_204_7)

				if var_204_9 > 0 and var_204_3 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_2
					end
				end

				arg_201_1.text_.text = var_204_6
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403052", "story_v_side_new_1103403.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403052", "story_v_side_new_1103403.awb") / 1000

					if var_204_10 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_2
					end

					if var_204_5.prefab_name ~= "" and arg_201_1.actors_[var_204_5.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_5.prefab_name].transform, "story_v_side_new_1103403", "1103403052", "story_v_side_new_1103403.awb")

						arg_201_1:RecordAudio("1103403052", var_204_11)
						arg_201_1:RecordAudio("1103403052", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403052", "story_v_side_new_1103403.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403052", "story_v_side_new_1103403.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_12 = math.max(var_204_3, arg_201_1.talkMaxDuration)

			if var_204_2 <= arg_201_1.time_ and arg_201_1.time_ < var_204_2 + var_204_12 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_2) / var_204_12

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_2 + var_204_12 and arg_201_1.time_ < var_204_2 + var_204_12 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1103403053 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1103403053
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1103403054(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1034ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1034ui_story == nil then
				arg_205_1.var_.characterEffect1034ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect1034ui_story and not isNil(var_208_0) then
					local var_208_4 = Mathf.Lerp(0, 0.5, var_208_3)

					arg_205_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1034ui_story.fillRatio = var_208_4
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1034ui_story then
				local var_208_5 = 0.5

				arg_205_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1034ui_story.fillRatio = var_208_5
			end

			local var_208_6 = 0
			local var_208_7 = 0.125

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

				local var_208_9 = arg_205_1:GetWordFromCfg(1103403053)
				local var_208_10 = arg_205_1:FormatText(var_208_9.content)

				arg_205_1.text_.text = var_208_10

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_11 = 5
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
	Play1103403054 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1103403054
		arg_209_1.duration_ = 3.03

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1103403055(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1034ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1034ui_story == nil then
				arg_209_1.var_.characterEffect1034ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1034ui_story and not isNil(var_212_0) then
					arg_209_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1034ui_story then
				arg_209_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_212_4 = 0

			if var_212_4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			local var_212_5 = 0

			if var_212_5 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_212_6 = 0
			local var_212_7 = 0.375

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_8 = arg_209_1:FormatText(StoryNameCfg[1109].name)

				arg_209_1.leftNameTxt_.text = var_212_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_9 = arg_209_1:GetWordFromCfg(1103403054)
				local var_212_10 = arg_209_1:FormatText(var_212_9.content)

				arg_209_1.text_.text = var_212_10

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 15
				local var_212_12 = utf8.len(var_212_10)
				local var_212_13 = var_212_11 <= 0 and var_212_7 or var_212_7 * (var_212_12 / var_212_11)

				if var_212_13 > 0 and var_212_7 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_10
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403054", "story_v_side_new_1103403.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403054", "story_v_side_new_1103403.awb") / 1000

					if var_212_14 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_6
					end

					if var_212_9.prefab_name ~= "" and arg_209_1.actors_[var_212_9.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_9.prefab_name].transform, "story_v_side_new_1103403", "1103403054", "story_v_side_new_1103403.awb")

						arg_209_1:RecordAudio("1103403054", var_212_15)
						arg_209_1:RecordAudio("1103403054", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403054", "story_v_side_new_1103403.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403054", "story_v_side_new_1103403.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_16 and arg_209_1.time_ < var_212_6 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1103403055 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1103403055
		arg_213_1.duration_ = 5.2

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1103403056(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_216_1 = 0
			local var_216_2 = 0.675

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_3 = arg_213_1:FormatText(StoryNameCfg[1109].name)

				arg_213_1.leftNameTxt_.text = var_216_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_4 = arg_213_1:GetWordFromCfg(1103403055)
				local var_216_5 = arg_213_1:FormatText(var_216_4.content)

				arg_213_1.text_.text = var_216_5

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_6 = 27
				local var_216_7 = utf8.len(var_216_5)
				local var_216_8 = var_216_6 <= 0 and var_216_2 or var_216_2 * (var_216_7 / var_216_6)

				if var_216_8 > 0 and var_216_2 < var_216_8 then
					arg_213_1.talkMaxDuration = var_216_8

					if var_216_8 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_5
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403055", "story_v_side_new_1103403.awb") ~= 0 then
					local var_216_9 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403055", "story_v_side_new_1103403.awb") / 1000

					if var_216_9 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_1
					end

					if var_216_4.prefab_name ~= "" and arg_213_1.actors_[var_216_4.prefab_name] ~= nil then
						local var_216_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_4.prefab_name].transform, "story_v_side_new_1103403", "1103403055", "story_v_side_new_1103403.awb")

						arg_213_1:RecordAudio("1103403055", var_216_10)
						arg_213_1:RecordAudio("1103403055", var_216_10)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403055", "story_v_side_new_1103403.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403055", "story_v_side_new_1103403.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_11 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_11 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_11

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_11 and arg_213_1.time_ < var_216_1 + var_216_11 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1103403056 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1103403056
		arg_217_1.duration_ = 2

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"

			SetActive(arg_217_1.choicesGo_, true)

			for iter_218_0, iter_218_1 in ipairs(arg_217_1.choices_) do
				local var_218_0 = iter_218_0 <= 2

				SetActive(iter_218_1.go, var_218_0)
			end

			arg_217_1.choices_[1].txt.text = arg_217_1:FormatText(StoryChoiceCfg[1457].name)
			arg_217_1.choices_[2].txt.text = arg_217_1:FormatText(StoryChoiceCfg[1458].name)
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1103403057(arg_217_1)
			end

			if arg_219_0 == 2 then
				arg_217_0:Play1103403060(arg_217_1)
			end

			arg_217_1:RecordChoiceLog(1103403056, 1457, 1458)
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1034ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1034ui_story == nil then
				arg_217_1.var_.characterEffect1034ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.366666666666667

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1034ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1034ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1034ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1034ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_220_7 = 0

			if var_220_7 < arg_217_1.time_ and arg_217_1.time_ <= var_220_7 + arg_220_0 then
				arg_217_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_220_8 = 0

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			local var_220_9 = 2

			if arg_217_1.time_ >= var_220_8 + var_220_9 and arg_217_1.time_ < var_220_8 + var_220_9 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1103403057 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1103403057
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1103403058(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_224_2 = 0
			local var_224_3 = 0.625

			if var_224_2 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_4 = arg_221_1:FormatText(StoryNameCfg[7].name)

				arg_221_1.leftNameTxt_.text = var_224_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_5 = arg_221_1:GetWordFromCfg(1103403057)
				local var_224_6 = arg_221_1:FormatText(var_224_5.content)

				arg_221_1.text_.text = var_224_6

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 25
				local var_224_8 = utf8.len(var_224_6)
				local var_224_9 = var_224_7 <= 0 and var_224_3 or var_224_3 * (var_224_8 / var_224_7)

				if var_224_9 > 0 and var_224_3 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_6
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_10 and arg_221_1.time_ < var_224_2 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1103403058 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1103403058
		arg_225_1.duration_ = 6.43

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1103403059(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1034ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1034ui_story == nil then
				arg_225_1.var_.characterEffect1034ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1034ui_story and not isNil(var_228_0) then
					arg_225_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1034ui_story then
				arg_225_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_228_4 = 0

			if var_228_4 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			local var_228_5 = 0

			if var_228_5 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 then
				arg_225_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_228_6 = 0
			local var_228_7 = 0.6

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_8 = arg_225_1:FormatText(StoryNameCfg[1109].name)

				arg_225_1.leftNameTxt_.text = var_228_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_9 = arg_225_1:GetWordFromCfg(1103403058)
				local var_228_10 = arg_225_1:FormatText(var_228_9.content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 24
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

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403058", "story_v_side_new_1103403.awb") ~= 0 then
					local var_228_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403058", "story_v_side_new_1103403.awb") / 1000

					if var_228_14 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_14 + var_228_6
					end

					if var_228_9.prefab_name ~= "" and arg_225_1.actors_[var_228_9.prefab_name] ~= nil then
						local var_228_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_9.prefab_name].transform, "story_v_side_new_1103403", "1103403058", "story_v_side_new_1103403.awb")

						arg_225_1:RecordAudio("1103403058", var_228_15)
						arg_225_1:RecordAudio("1103403058", var_228_15)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403058", "story_v_side_new_1103403.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403058", "story_v_side_new_1103403.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_16 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_16 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_16

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_16 and arg_225_1.time_ < var_228_6 + var_228_16 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1103403059 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1103403059
		arg_229_1.duration_ = 4

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1103403064(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_232_1 = 0
			local var_232_2 = 0.575

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_3 = arg_229_1:FormatText(StoryNameCfg[1109].name)

				arg_229_1.leftNameTxt_.text = var_232_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:GetWordFromCfg(1103403059)
				local var_232_5 = arg_229_1:FormatText(var_232_4.content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_6 = 23
				local var_232_7 = utf8.len(var_232_5)
				local var_232_8 = var_232_6 <= 0 and var_232_2 or var_232_2 * (var_232_7 / var_232_6)

				if var_232_8 > 0 and var_232_2 < var_232_8 then
					arg_229_1.talkMaxDuration = var_232_8

					if var_232_8 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403059", "story_v_side_new_1103403.awb") ~= 0 then
					local var_232_9 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403059", "story_v_side_new_1103403.awb") / 1000

					if var_232_9 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_1
					end

					if var_232_4.prefab_name ~= "" and arg_229_1.actors_[var_232_4.prefab_name] ~= nil then
						local var_232_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_4.prefab_name].transform, "story_v_side_new_1103403", "1103403059", "story_v_side_new_1103403.awb")

						arg_229_1:RecordAudio("1103403059", var_232_10)
						arg_229_1:RecordAudio("1103403059", var_232_10)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403059", "story_v_side_new_1103403.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403059", "story_v_side_new_1103403.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_11 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_11 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_11

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_11 and arg_229_1.time_ < var_232_1 + var_232_11 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1103403064 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1103403064
		arg_233_1.duration_ = 1.33

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1103403065(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1034ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1034ui_story == nil then
				arg_233_1.var_.characterEffect1034ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1034ui_story and not isNil(var_236_0) then
					local var_236_4 = Mathf.Lerp(0, 0.5, var_236_3)

					arg_233_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1034ui_story.fillRatio = var_236_4
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1034ui_story then
				local var_236_5 = 0.5

				arg_233_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1034ui_story.fillRatio = var_236_5
			end

			local var_236_6 = 0
			local var_236_7 = 0.3

			if var_236_6 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				local var_236_8 = "play"
				local var_236_9 = "music"

				arg_233_1:AudioAction(var_236_8, var_236_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_236_10 = ""
				local var_236_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_236_11 ~= "" then
					if arg_233_1.bgmTxt_.text ~= var_236_11 and arg_233_1.bgmTxt_.text ~= "" then
						if arg_233_1.bgmTxt2_.text ~= "" then
							arg_233_1.bgmTxt_.text = arg_233_1.bgmTxt2_.text
						end

						arg_233_1.bgmTxt2_.text = var_236_11

						arg_233_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_233_1.bgmTxt_.text = var_236_11
						arg_233_1.bgmTxt2_.text = var_236_11
					end

					if arg_233_1.bgmTimer then
						arg_233_1.bgmTimer:Stop()

						arg_233_1.bgmTimer = nil
					end

					if arg_233_1.settingData.show_music_name == 1 then
						arg_233_1.musicController:SetSelectedState("show")
						arg_233_1.musicAnimator_:Play("open", 0, 0)

						if arg_233_1.settingData.music_time ~= 0 then
							arg_233_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_233_1.settingData.music_time), function()
								if arg_233_1 == nil or isNil(arg_233_1.bgmTxt_) then
									return
								end

								arg_233_1.musicController:SetSelectedState("hide")
								arg_233_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_236_12 = 0
			local var_236_13 = 1

			if var_236_12 < arg_233_1.time_ and arg_233_1.time_ <= var_236_12 + arg_236_0 then
				local var_236_14 = "play"
				local var_236_15 = "effect"

				arg_233_1:AudioAction(var_236_14, var_236_15, "se_story_1310", "se_story_1310_motorcycle01", "")
			end

			local var_236_16 = 0
			local var_236_17 = 0.1

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_18 = arg_233_1:FormatText(StoryNameCfg[171].name)

				arg_233_1.leftNameTxt_.text = var_236_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_19 = arg_233_1:GetWordFromCfg(1103403064)
				local var_236_20 = arg_233_1:FormatText(var_236_19.content)

				arg_233_1.text_.text = var_236_20

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_21 = 4
				local var_236_22 = utf8.len(var_236_20)
				local var_236_23 = var_236_21 <= 0 and var_236_17 or var_236_17 * (var_236_22 / var_236_21)

				if var_236_23 > 0 and var_236_17 < var_236_23 then
					arg_233_1.talkMaxDuration = var_236_23

					if var_236_23 + var_236_16 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_23 + var_236_16
					end
				end

				arg_233_1.text_.text = var_236_20
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403064", "story_v_side_new_1103403.awb") ~= 0 then
					local var_236_24 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403064", "story_v_side_new_1103403.awb") / 1000

					if var_236_24 + var_236_16 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_24 + var_236_16
					end

					if var_236_19.prefab_name ~= "" and arg_233_1.actors_[var_236_19.prefab_name] ~= nil then
						local var_236_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_19.prefab_name].transform, "story_v_side_new_1103403", "1103403064", "story_v_side_new_1103403.awb")

						arg_233_1:RecordAudio("1103403064", var_236_25)
						arg_233_1:RecordAudio("1103403064", var_236_25)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403064", "story_v_side_new_1103403.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403064", "story_v_side_new_1103403.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_26 = math.max(var_236_17, arg_233_1.talkMaxDuration)

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_26 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_16) / var_236_26

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_16 + var_236_26 and arg_233_1.time_ < var_236_16 + var_236_26 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1103403065 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1103403065
		arg_238_1.duration_ = 7.8

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1103403066(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 2

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				local var_241_1 = manager.ui.mainCamera.transform.localPosition
				local var_241_2 = Vector3.New(0, 0, 10) + Vector3.New(var_241_1.x, var_241_1.y, 0)
				local var_241_3 = arg_238_1.bgs_.I11o

				var_241_3.transform.localPosition = var_241_2
				var_241_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_241_4 = var_241_3:GetComponent("SpriteRenderer")

				if var_241_4 and var_241_4.sprite then
					local var_241_5 = (var_241_3.transform.localPosition - var_241_1).z
					local var_241_6 = manager.ui.mainCameraCom_
					local var_241_7 = 2 * var_241_5 * Mathf.Tan(var_241_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_241_8 = var_241_7 * var_241_6.aspect
					local var_241_9 = var_241_4.sprite.bounds.size.x
					local var_241_10 = var_241_4.sprite.bounds.size.y
					local var_241_11 = var_241_8 / var_241_9
					local var_241_12 = var_241_7 / var_241_10
					local var_241_13 = var_241_12 < var_241_11 and var_241_11 or var_241_12

					var_241_3.transform.localScale = Vector3.New(var_241_13, var_241_13, 0)
				end

				for iter_241_0, iter_241_1 in pairs(arg_238_1.bgs_) do
					if iter_241_0 ~= "I11o" then
						iter_241_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_241_14 = 2.8

			if var_241_14 < arg_238_1.time_ and arg_238_1.time_ <= var_241_14 + arg_241_0 then
				arg_238_1.allBtn_.enabled = false
			end

			local var_241_15 = 0.3

			if arg_238_1.time_ >= var_241_14 + var_241_15 and arg_238_1.time_ < var_241_14 + var_241_15 + arg_241_0 then
				arg_238_1.allBtn_.enabled = true
			end

			local var_241_16 = 0

			if var_241_16 < arg_238_1.time_ and arg_238_1.time_ <= var_241_16 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_17 = 2

			if var_241_16 <= arg_238_1.time_ and arg_238_1.time_ < var_241_16 + var_241_17 then
				local var_241_18 = (arg_238_1.time_ - var_241_16) / var_241_17
				local var_241_19 = Color.New(0, 0, 0)

				var_241_19.a = Mathf.Lerp(0, 1, var_241_18)
				arg_238_1.mask_.color = var_241_19
			end

			if arg_238_1.time_ >= var_241_16 + var_241_17 and arg_238_1.time_ < var_241_16 + var_241_17 + arg_241_0 then
				local var_241_20 = Color.New(0, 0, 0)

				var_241_20.a = 1
				arg_238_1.mask_.color = var_241_20
			end

			local var_241_21 = 2

			if var_241_21 < arg_238_1.time_ and arg_238_1.time_ <= var_241_21 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_22 = 0.8

			if var_241_21 <= arg_238_1.time_ and arg_238_1.time_ < var_241_21 + var_241_22 then
				local var_241_23 = (arg_238_1.time_ - var_241_21) / var_241_22
				local var_241_24 = Color.New(0, 0, 0)

				var_241_24.a = Mathf.Lerp(1, 0, var_241_23)
				arg_238_1.mask_.color = var_241_24
			end

			if arg_238_1.time_ >= var_241_21 + var_241_22 and arg_238_1.time_ < var_241_21 + var_241_22 + arg_241_0 then
				local var_241_25 = Color.New(0, 0, 0)
				local var_241_26 = 0

				arg_238_1.mask_.enabled = false
				var_241_25.a = var_241_26
				arg_238_1.mask_.color = var_241_25
			end

			local var_241_27 = arg_238_1.actors_["1034ui_story"].transform
			local var_241_28 = 1.98333333333333

			if var_241_28 < arg_238_1.time_ and arg_238_1.time_ <= var_241_28 + arg_241_0 then
				arg_238_1.var_.moveOldPos1034ui_story = var_241_27.localPosition
			end

			local var_241_29 = 0.001

			if var_241_28 <= arg_238_1.time_ and arg_238_1.time_ < var_241_28 + var_241_29 then
				local var_241_30 = (arg_238_1.time_ - var_241_28) / var_241_29
				local var_241_31 = Vector3.New(0, 100, 0)

				var_241_27.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1034ui_story, var_241_31, var_241_30)

				local var_241_32 = manager.ui.mainCamera.transform.position - var_241_27.position

				var_241_27.forward = Vector3.New(var_241_32.x, var_241_32.y, var_241_32.z)

				local var_241_33 = var_241_27.localEulerAngles

				var_241_33.z = 0
				var_241_33.x = 0
				var_241_27.localEulerAngles = var_241_33
			end

			if arg_238_1.time_ >= var_241_28 + var_241_29 and arg_238_1.time_ < var_241_28 + var_241_29 + arg_241_0 then
				var_241_27.localPosition = Vector3.New(0, 100, 0)

				local var_241_34 = manager.ui.mainCamera.transform.position - var_241_27.position

				var_241_27.forward = Vector3.New(var_241_34.x, var_241_34.y, var_241_34.z)

				local var_241_35 = var_241_27.localEulerAngles

				var_241_35.z = 0
				var_241_35.x = 0
				var_241_27.localEulerAngles = var_241_35
			end

			local var_241_36 = 0

			if var_241_36 < arg_238_1.time_ and arg_238_1.time_ <= var_241_36 + arg_241_0 then
				arg_238_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_241_37 = manager.ui.mainCamera.transform
			local var_241_38 = 2

			if var_241_38 < arg_238_1.time_ and arg_238_1.time_ <= var_241_38 + arg_241_0 then
				local var_241_39 = arg_238_1.var_.effectwqerweqqwetewrgwe
				local var_241_40
				local var_241_41 = var_241_37

				if not var_241_39 then
					var_241_39 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), var_241_41)
					var_241_39.name = "wqerweqqwetewrgwe"
					arg_238_1.var_.effectwqerweqqwetewrgwe = var_241_39
				else
					var_241_39.transform:SetParent(var_241_41)
				end

				var_241_39.transform.localPosition = Vector3.New(0, 0, 0)
				var_241_39.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_241_42 = manager.ui.mainCameraCom_
				local var_241_43 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_241_42.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_241_44 = var_241_39.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_241_45 = 15
				local var_241_46 = 2 * var_241_45 * Mathf.Tan(var_241_42.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_241_42.aspect
				local var_241_47 = 1
				local var_241_48 = 1.7777777777777777

				if var_241_48 < var_241_42.aspect then
					var_241_47 = var_241_46 / (2 * var_241_45 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_241_48)
				end

				for iter_241_2, iter_241_3 in ipairs(var_241_44) do
					local var_241_49 = iter_241_3.transform.localScale

					iter_241_3.transform.localScale = Vector3.New(var_241_49.x / var_241_43 * var_241_47, var_241_49.y / var_241_43, var_241_49.z)
				end
			end

			local var_241_50 = 2
			local var_241_51 = 1

			if var_241_50 < arg_238_1.time_ and arg_238_1.time_ <= var_241_50 + arg_241_0 then
				local var_241_52 = "play"
				local var_241_53 = "effect"

				arg_238_1:AudioAction(var_241_52, var_241_53, "se_story_1310", "se_story_1310_motorcycle04", "")
			end

			if arg_238_1.frameCnt_ <= 1 then
				arg_238_1.dialog_:SetActive(false)
			end

			local var_241_54 = 2.8
			local var_241_55 = 1.075

			if var_241_54 < arg_238_1.time_ and arg_238_1.time_ <= var_241_54 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0

				arg_238_1.dialog_:SetActive(true)

				arg_238_1.dialogCg_.alpha = 0

				local var_241_56 = LeanTween.value(arg_238_1.dialog_, 0, 1, 0.3)

				var_241_56:setOnUpdate(LuaHelper.FloatAction(function(arg_242_0)
					arg_238_1.dialogCg_.alpha = arg_242_0
				end))
				var_241_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_238_1.dialog_)
					var_241_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_238_1.duration_ = arg_238_1.duration_ + 0.3

				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_57 = arg_238_1:GetWordFromCfg(1103403065)
				local var_241_58 = arg_238_1:FormatText(var_241_57.content)

				arg_238_1.text_.text = var_241_58

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_59 = 43
				local var_241_60 = utf8.len(var_241_58)
				local var_241_61 = var_241_59 <= 0 and var_241_55 or var_241_55 * (var_241_60 / var_241_59)

				if var_241_61 > 0 and var_241_55 < var_241_61 then
					arg_238_1.talkMaxDuration = var_241_61
					var_241_54 = var_241_54 + 0.3

					if var_241_61 + var_241_54 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_61 + var_241_54
					end
				end

				arg_238_1.text_.text = var_241_58
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_62 = var_241_54 + 0.3
			local var_241_63 = math.max(var_241_55, arg_238_1.talkMaxDuration)

			if var_241_62 <= arg_238_1.time_ and arg_238_1.time_ < var_241_62 + var_241_63 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_62) / var_241_63

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_62 + var_241_63 and arg_238_1.time_ < var_241_62 + var_241_63 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666665,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play1103403066 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 1103403066
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play1103403067(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				local var_247_1 = arg_244_1.var_.effectweqrwerqwerqwerqwe
				local var_247_2
				local var_247_3 = goTrans

				if not var_247_1 then
					var_247_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), var_247_3)
					var_247_1.name = ""
					arg_244_1.var_.effectweqrwerqwerqwerqwe = var_247_1
				else
					var_247_1.transform:SetParent(var_247_3)
				end

				var_247_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_247_1.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_247_4 = manager.ui.mainCameraCom_
				local var_247_5 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_247_4.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_247_6 = var_247_1.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_247_7 = 15
				local var_247_8 = 2 * var_247_7 * Mathf.Tan(var_247_4.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_247_4.aspect
				local var_247_9 = 1
				local var_247_10 = 1.7777777777777777

				if var_247_10 < var_247_4.aspect then
					var_247_9 = var_247_8 / (2 * var_247_7 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_247_10)
				end

				for iter_247_0, iter_247_1 in ipairs(var_247_6) do
					local var_247_11 = iter_247_1.transform.localScale

					iter_247_1.transform.localScale = Vector3.New(var_247_11.x / var_247_5 * var_247_9, var_247_11.y / var_247_5, var_247_11.z)
				end
			end

			local var_247_12 = 0
			local var_247_13 = 0.3

			if var_247_12 < arg_244_1.time_ and arg_244_1.time_ <= var_247_12 + arg_247_0 then
				local var_247_14 = "play"
				local var_247_15 = "music"

				arg_244_1:AudioAction(var_247_14, var_247_15, "ui_battle", "ui_battle_stopbgm", "")

				local var_247_16 = ""
				local var_247_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_247_17 ~= "" then
					if arg_244_1.bgmTxt_.text ~= var_247_17 and arg_244_1.bgmTxt_.text ~= "" then
						if arg_244_1.bgmTxt2_.text ~= "" then
							arg_244_1.bgmTxt_.text = arg_244_1.bgmTxt2_.text
						end

						arg_244_1.bgmTxt2_.text = var_247_17

						arg_244_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_244_1.bgmTxt_.text = var_247_17
						arg_244_1.bgmTxt2_.text = var_247_17
					end

					if arg_244_1.bgmTimer then
						arg_244_1.bgmTimer:Stop()

						arg_244_1.bgmTimer = nil
					end

					if arg_244_1.settingData.show_music_name == 1 then
						arg_244_1.musicController:SetSelectedState("show")
						arg_244_1.musicAnimator_:Play("open", 0, 0)

						if arg_244_1.settingData.music_time ~= 0 then
							arg_244_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_244_1.settingData.music_time), function()
								if arg_244_1 == nil or isNil(arg_244_1.bgmTxt_) then
									return
								end

								arg_244_1.musicController:SetSelectedState("hide")
								arg_244_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_247_18 = 0.4
			local var_247_19 = 1

			if var_247_18 < arg_244_1.time_ and arg_244_1.time_ <= var_247_18 + arg_247_0 then
				local var_247_20 = "play"
				local var_247_21 = "music"

				arg_244_1:AudioAction(var_247_20, var_247_21, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_247_22 = ""
				local var_247_23 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_247_23 ~= "" then
					if arg_244_1.bgmTxt_.text ~= var_247_23 and arg_244_1.bgmTxt_.text ~= "" then
						if arg_244_1.bgmTxt2_.text ~= "" then
							arg_244_1.bgmTxt_.text = arg_244_1.bgmTxt2_.text
						end

						arg_244_1.bgmTxt2_.text = var_247_23

						arg_244_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_244_1.bgmTxt_.text = var_247_23
						arg_244_1.bgmTxt2_.text = var_247_23
					end

					if arg_244_1.bgmTimer then
						arg_244_1.bgmTimer:Stop()

						arg_244_1.bgmTimer = nil
					end

					if arg_244_1.settingData.show_music_name == 1 then
						arg_244_1.musicController:SetSelectedState("show")
						arg_244_1.musicAnimator_:Play("open", 0, 0)

						if arg_244_1.settingData.music_time ~= 0 then
							arg_244_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_244_1.settingData.music_time), function()
								if arg_244_1 == nil or isNil(arg_244_1.bgmTxt_) then
									return
								end

								arg_244_1.musicController:SetSelectedState("hide")
								arg_244_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_247_24 = 0
			local var_247_25 = 1.3

			if var_247_24 < arg_244_1.time_ and arg_244_1.time_ <= var_247_24 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_26 = arg_244_1:GetWordFromCfg(1103403066)
				local var_247_27 = arg_244_1:FormatText(var_247_26.content)

				arg_244_1.text_.text = var_247_27

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_28 = 52
				local var_247_29 = utf8.len(var_247_27)
				local var_247_30 = var_247_28 <= 0 and var_247_25 or var_247_25 * (var_247_29 / var_247_28)

				if var_247_30 > 0 and var_247_25 < var_247_30 then
					arg_244_1.talkMaxDuration = var_247_30

					if var_247_30 + var_247_24 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_30 + var_247_24
					end
				end

				arg_244_1.text_.text = var_247_27
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_31 = math.max(var_247_25, arg_244_1.talkMaxDuration)

			if var_247_24 <= arg_244_1.time_ and arg_244_1.time_ < var_247_24 + var_247_31 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_24) / var_247_31

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_24 + var_247_31 and arg_244_1.time_ < var_247_24 + var_247_31 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play1103403067 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1103403067
		arg_250_1.duration_ = 2.9

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1103403068(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.25

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_2 = arg_250_1:FormatText(StoryNameCfg[690].name)

				arg_250_1.leftNameTxt_.text = var_253_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_3 = arg_250_1:GetWordFromCfg(1103403067)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403067", "story_v_side_new_1103403.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403067", "story_v_side_new_1103403.awb") / 1000

					if var_253_8 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_0
					end

					if var_253_3.prefab_name ~= "" and arg_250_1.actors_[var_253_3.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_3.prefab_name].transform, "story_v_side_new_1103403", "1103403067", "story_v_side_new_1103403.awb")

						arg_250_1:RecordAudio("1103403067", var_253_9)
						arg_250_1:RecordAudio("1103403067", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403067", "story_v_side_new_1103403.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403067", "story_v_side_new_1103403.awb")
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
	Play1103403068 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1103403068
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1103403069(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.133333333333333
			local var_257_1 = 1

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				local var_257_2 = "play"
				local var_257_3 = "effect"

				arg_254_1:AudioAction(var_257_2, var_257_3, "se_story_1310", "se_story_1310_motorcycle02", "")
			end

			local var_257_4 = 0.325
			local var_257_5 = 1

			if var_257_4 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				local var_257_6 = "play"
				local var_257_7 = "effect"

				arg_254_1:AudioAction(var_257_6, var_257_7, "se_story_side_1050", "se_story_side_1050_fall", "")
			end

			local var_257_8 = 0
			local var_257_9 = 1.325

			if var_257_8 < arg_254_1.time_ and arg_254_1.time_ <= var_257_8 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_10 = arg_254_1:GetWordFromCfg(1103403068)
				local var_257_11 = arg_254_1:FormatText(var_257_10.content)

				arg_254_1.text_.text = var_257_11

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_12 = 53
				local var_257_13 = utf8.len(var_257_11)
				local var_257_14 = var_257_12 <= 0 and var_257_9 or var_257_9 * (var_257_13 / var_257_12)

				if var_257_14 > 0 and var_257_9 < var_257_14 then
					arg_254_1.talkMaxDuration = var_257_14

					if var_257_14 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_14 + var_257_8
					end
				end

				arg_254_1.text_.text = var_257_11
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_15 = math.max(var_257_9, arg_254_1.talkMaxDuration)

			if var_257_8 <= arg_254_1.time_ and arg_254_1.time_ < var_257_8 + var_257_15 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_8) / var_257_15

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_8 + var_257_15 and arg_254_1.time_ < var_257_8 + var_257_15 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play1103403069 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1103403069
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1103403070(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 1.4

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_2 = arg_258_1:GetWordFromCfg(1103403069)
				local var_261_3 = arg_258_1:FormatText(var_261_2.content)

				arg_258_1.text_.text = var_261_3

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 56
				local var_261_5 = utf8.len(var_261_3)
				local var_261_6 = var_261_4 <= 0 and var_261_1 or var_261_1 * (var_261_5 / var_261_4)

				if var_261_6 > 0 and var_261_1 < var_261_6 then
					arg_258_1.talkMaxDuration = var_261_6

					if var_261_6 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_6 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_3
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_7 and arg_258_1.time_ < var_261_0 + var_261_7 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play1103403070 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1103403070
		arg_262_1.duration_ = 2.33

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1103403071(arg_262_1)
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

				local var_265_2 = arg_262_1:FormatText(StoryNameCfg[690].name)

				arg_262_1.leftNameTxt_.text = var_265_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_3 = arg_262_1:GetWordFromCfg(1103403070)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403070", "story_v_side_new_1103403.awb") ~= 0 then
					local var_265_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403070", "story_v_side_new_1103403.awb") / 1000

					if var_265_8 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_0
					end

					if var_265_3.prefab_name ~= "" and arg_262_1.actors_[var_265_3.prefab_name] ~= nil then
						local var_265_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_3.prefab_name].transform, "story_v_side_new_1103403", "1103403070", "story_v_side_new_1103403.awb")

						arg_262_1:RecordAudio("1103403070", var_265_9)
						arg_262_1:RecordAudio("1103403070", var_265_9)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403070", "story_v_side_new_1103403.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403070", "story_v_side_new_1103403.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_10 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_10 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_10

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_10 and arg_262_1.time_ < var_265_0 + var_265_10 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 100,
				className = "StoryShakeNode",
				duration = 0.4,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(2, 0, 2)
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play1103403071 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1103403071
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1103403072(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.166666666666667
			local var_269_1 = 1

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				local var_269_2 = "play"
				local var_269_3 = "effect"

				arg_266_1:AudioAction(var_269_2, var_269_3, "se_story_140", "se_story_140_footstep_run02", "")
			end

			local var_269_4 = 0.166666666666667
			local var_269_5 = 1

			if var_269_4 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				local var_269_6 = "play"
				local var_269_7 = "effect"

				arg_266_1:AudioAction(var_269_6, var_269_7, "se_story_birthday3", "se_story_birthday3_motorcycle", "")
			end

			local var_269_8 = 0
			local var_269_9 = 1.35

			if var_269_8 < arg_266_1.time_ and arg_266_1.time_ <= var_269_8 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_10 = arg_266_1:GetWordFromCfg(1103403071)
				local var_269_11 = arg_266_1:FormatText(var_269_10.content)

				arg_266_1.text_.text = var_269_11

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_12 = 54
				local var_269_13 = utf8.len(var_269_11)
				local var_269_14 = var_269_12 <= 0 and var_269_9 or var_269_9 * (var_269_13 / var_269_12)

				if var_269_14 > 0 and var_269_9 < var_269_14 then
					arg_266_1.talkMaxDuration = var_269_14

					if var_269_14 + var_269_8 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_14 + var_269_8
					end
				end

				arg_266_1.text_.text = var_269_11
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_15 = math.max(var_269_9, arg_266_1.talkMaxDuration)

			if var_269_8 <= arg_266_1.time_ and arg_266_1.time_ < var_269_8 + var_269_15 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_8) / var_269_15

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_8 + var_269_15 and arg_266_1.time_ < var_269_8 + var_269_15 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1103403072 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1103403072
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1103403073(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 1.375

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_2 = arg_270_1:GetWordFromCfg(1103403072)
				local var_273_3 = arg_270_1:FormatText(var_273_2.content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_4 = 55
				local var_273_5 = utf8.len(var_273_3)
				local var_273_6 = var_273_4 <= 0 and var_273_1 or var_273_1 * (var_273_5 / var_273_4)

				if var_273_6 > 0 and var_273_1 < var_273_6 then
					arg_270_1.talkMaxDuration = var_273_6

					if var_273_6 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_6 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_7 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_7 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_7

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_7 and arg_270_1.time_ < var_273_0 + var_273_7 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1103403073 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1103403073
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1103403074(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.4

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_2 = arg_274_1:FormatText(StoryNameCfg[7].name)

				arg_274_1.leftNameTxt_.text = var_277_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:GetWordFromCfg(1103403073)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 16
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
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_8 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_8 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_8

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_8 and arg_274_1.time_ < var_277_0 + var_277_8 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1103403074 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1103403074
		arg_278_1.duration_ = 2

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1103403075(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1034ui_story"].transform
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.var_.moveOldPos1034ui_story = var_281_0.localPosition
			end

			local var_281_2 = 0.001

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2
				local var_281_4 = Vector3.New(0, -0.93, -6)

				var_281_0.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1034ui_story, var_281_4, var_281_3)

				local var_281_5 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_5.x, var_281_5.y, var_281_5.z)

				local var_281_6 = var_281_0.localEulerAngles

				var_281_6.z = 0
				var_281_6.x = 0
				var_281_0.localEulerAngles = var_281_6
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 then
				var_281_0.localPosition = Vector3.New(0, -0.93, -6)

				local var_281_7 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_7.x, var_281_7.y, var_281_7.z)

				local var_281_8 = var_281_0.localEulerAngles

				var_281_8.z = 0
				var_281_8.x = 0
				var_281_0.localEulerAngles = var_281_8
			end

			local var_281_9 = arg_278_1.actors_["1034ui_story"]
			local var_281_10 = 0

			if var_281_10 < arg_278_1.time_ and arg_278_1.time_ <= var_281_10 + arg_281_0 and not isNil(var_281_9) and arg_278_1.var_.characterEffect1034ui_story == nil then
				arg_278_1.var_.characterEffect1034ui_story = var_281_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_11 = 0.2

			if var_281_10 <= arg_278_1.time_ and arg_278_1.time_ < var_281_10 + var_281_11 and not isNil(var_281_9) then
				local var_281_12 = (arg_278_1.time_ - var_281_10) / var_281_11

				if arg_278_1.var_.characterEffect1034ui_story and not isNil(var_281_9) then
					arg_278_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= var_281_10 + var_281_11 and arg_278_1.time_ < var_281_10 + var_281_11 + arg_281_0 and not isNil(var_281_9) and arg_278_1.var_.characterEffect1034ui_story then
				arg_278_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_281_13 = 0

			if var_281_13 < arg_278_1.time_ and arg_278_1.time_ <= var_281_13 + arg_281_0 then
				arg_278_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_281_14 = 0

			if var_281_14 < arg_278_1.time_ and arg_278_1.time_ <= var_281_14 + arg_281_0 then
				arg_278_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_281_15 = 0
			local var_281_16 = 0.125

			if var_281_15 < arg_278_1.time_ and arg_278_1.time_ <= var_281_15 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_17 = arg_278_1:FormatText(StoryNameCfg[1109].name)

				arg_278_1.leftNameTxt_.text = var_281_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_18 = arg_278_1:GetWordFromCfg(1103403074)
				local var_281_19 = arg_278_1:FormatText(var_281_18.content)

				arg_278_1.text_.text = var_281_19

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_20 = 5
				local var_281_21 = utf8.len(var_281_19)
				local var_281_22 = var_281_20 <= 0 and var_281_16 or var_281_16 * (var_281_21 / var_281_20)

				if var_281_22 > 0 and var_281_16 < var_281_22 then
					arg_278_1.talkMaxDuration = var_281_22

					if var_281_22 + var_281_15 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_22 + var_281_15
					end
				end

				arg_278_1.text_.text = var_281_19
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403074", "story_v_side_new_1103403.awb") ~= 0 then
					local var_281_23 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403074", "story_v_side_new_1103403.awb") / 1000

					if var_281_23 + var_281_15 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_23 + var_281_15
					end

					if var_281_18.prefab_name ~= "" and arg_278_1.actors_[var_281_18.prefab_name] ~= nil then
						local var_281_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_18.prefab_name].transform, "story_v_side_new_1103403", "1103403074", "story_v_side_new_1103403.awb")

						arg_278_1:RecordAudio("1103403074", var_281_24)
						arg_278_1:RecordAudio("1103403074", var_281_24)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403074", "story_v_side_new_1103403.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403074", "story_v_side_new_1103403.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_25 = math.max(var_281_16, arg_278_1.talkMaxDuration)

			if var_281_15 <= arg_278_1.time_ and arg_278_1.time_ < var_281_15 + var_281_25 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_15) / var_281_25

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_15 + var_281_25 and arg_278_1.time_ < var_281_15 + var_281_25 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
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
	Play1103403075 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1103403075
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1103403076(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1034ui_story"].transform
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.var_.moveOldPos1034ui_story = var_285_0.localPosition
			end

			local var_285_2 = 0.001

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2
				local var_285_4 = Vector3.New(0, 100, 0)

				var_285_0.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1034ui_story, var_285_4, var_285_3)

				local var_285_5 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_5.x, var_285_5.y, var_285_5.z)

				local var_285_6 = var_285_0.localEulerAngles

				var_285_6.z = 0
				var_285_6.x = 0
				var_285_0.localEulerAngles = var_285_6
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 then
				var_285_0.localPosition = Vector3.New(0, 100, 0)

				local var_285_7 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_7.x, var_285_7.y, var_285_7.z)

				local var_285_8 = var_285_0.localEulerAngles

				var_285_8.z = 0
				var_285_8.x = 0
				var_285_0.localEulerAngles = var_285_8
			end

			local var_285_9 = arg_282_1.actors_["1034ui_story"]
			local var_285_10 = 0

			if var_285_10 < arg_282_1.time_ and arg_282_1.time_ <= var_285_10 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect1034ui_story == nil then
				arg_282_1.var_.characterEffect1034ui_story = var_285_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_11 = 0.200000002980232

			if var_285_10 <= arg_282_1.time_ and arg_282_1.time_ < var_285_10 + var_285_11 and not isNil(var_285_9) then
				local var_285_12 = (arg_282_1.time_ - var_285_10) / var_285_11

				if arg_282_1.var_.characterEffect1034ui_story and not isNil(var_285_9) then
					local var_285_13 = Mathf.Lerp(0, 0.5, var_285_12)

					arg_282_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1034ui_story.fillRatio = var_285_13
				end
			end

			if arg_282_1.time_ >= var_285_10 + var_285_11 and arg_282_1.time_ < var_285_10 + var_285_11 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect1034ui_story then
				local var_285_14 = 0.5

				arg_282_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1034ui_story.fillRatio = var_285_14
			end

			local var_285_15 = 0

			if var_285_15 < arg_282_1.time_ and arg_282_1.time_ <= var_285_15 + arg_285_0 then
				arg_282_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_285_16 = manager.ui.mainCamera.transform
			local var_285_17 = 0

			if var_285_17 < arg_282_1.time_ and arg_282_1.time_ <= var_285_17 + arg_285_0 then
				local var_285_18 = arg_282_1.var_.effect6556774563453453123156162165165151
				local var_285_19
				local var_285_20 = var_285_16

				if not var_285_18 then
					var_285_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), var_285_20)
					var_285_18.name = "123156162165165151"
					arg_282_1.var_.effect6556774563453453123156162165165151 = var_285_18
				else
					var_285_18.transform:SetParent(var_285_20)
				end

				var_285_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_285_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_285_21 = manager.ui.mainCameraCom_
				local var_285_22 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_285_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_285_23 = var_285_18.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_285_24 = 15
				local var_285_25 = 2 * var_285_24 * Mathf.Tan(var_285_21.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_285_21.aspect
				local var_285_26 = 1
				local var_285_27 = 1.7777777777777777

				if var_285_27 < var_285_21.aspect then
					var_285_26 = var_285_25 / (2 * var_285_24 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_285_27)
				end

				for iter_285_0, iter_285_1 in ipairs(var_285_23) do
					local var_285_28 = iter_285_1.transform.localScale

					iter_285_1.transform.localScale = Vector3.New(var_285_28.x / var_285_22 * var_285_26, var_285_28.y / var_285_22, var_285_28.z)
				end
			end

			local var_285_29 = 0.034000001847744
			local var_285_30 = 1

			if var_285_29 < arg_282_1.time_ and arg_282_1.time_ <= var_285_29 + arg_285_0 then
				local var_285_31 = "play"
				local var_285_32 = "effect"

				arg_282_1:AudioAction(var_285_31, var_285_32, "se_story_140", "se_story_140_footstep_run01", "")
			end

			local var_285_33 = 0
			local var_285_34 = 1.45

			if var_285_33 < arg_282_1.time_ and arg_282_1.time_ <= var_285_33 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_35 = arg_282_1:GetWordFromCfg(1103403075)
				local var_285_36 = arg_282_1:FormatText(var_285_35.content)

				arg_282_1.text_.text = var_285_36

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_37 = 58
				local var_285_38 = utf8.len(var_285_36)
				local var_285_39 = var_285_37 <= 0 and var_285_34 or var_285_34 * (var_285_38 / var_285_37)

				if var_285_39 > 0 and var_285_34 < var_285_39 then
					arg_282_1.talkMaxDuration = var_285_39

					if var_285_39 + var_285_33 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_39 + var_285_33
					end
				end

				arg_282_1.text_.text = var_285_36
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_40 = math.max(var_285_34, arg_282_1.talkMaxDuration)

			if var_285_33 <= arg_282_1.time_ and arg_282_1.time_ < var_285_33 + var_285_40 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_33) / var_285_40

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_33 + var_285_40 and arg_282_1.time_ < var_285_33 + var_285_40 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play1103403076 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1103403076
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1103403077(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.133333333333333
			local var_289_1 = 1

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				local var_289_2 = "play"
				local var_289_3 = "effect"

				arg_286_1:AudioAction(var_289_2, var_289_3, "se_story_140", "se_story_140_footstep_run05", "")
			end

			local var_289_4 = 0
			local var_289_5 = 1.4

			if var_289_4 < arg_286_1.time_ and arg_286_1.time_ <= var_289_4 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_6 = arg_286_1:GetWordFromCfg(1103403076)
				local var_289_7 = arg_286_1:FormatText(var_289_6.content)

				arg_286_1.text_.text = var_289_7

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_8 = 56
				local var_289_9 = utf8.len(var_289_7)
				local var_289_10 = var_289_8 <= 0 and var_289_5 or var_289_5 * (var_289_9 / var_289_8)

				if var_289_10 > 0 and var_289_5 < var_289_10 then
					arg_286_1.talkMaxDuration = var_289_10

					if var_289_10 + var_289_4 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_10 + var_289_4
					end
				end

				arg_286_1.text_.text = var_289_7
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_11 = math.max(var_289_5, arg_286_1.talkMaxDuration)

			if var_289_4 <= arg_286_1.time_ and arg_286_1.time_ < var_289_4 + var_289_11 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_4) / var_289_11

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_4 + var_289_11 and arg_286_1.time_ < var_289_4 + var_289_11 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play1103403077 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1103403077
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1103403078(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 1.2

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_2 = arg_290_1:GetWordFromCfg(1103403077)
				local var_293_3 = arg_290_1:FormatText(var_293_2.content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 48
				local var_293_5 = utf8.len(var_293_3)
				local var_293_6 = var_293_4 <= 0 and var_293_1 or var_293_1 * (var_293_5 / var_293_4)

				if var_293_6 > 0 and var_293_1 < var_293_6 then
					arg_290_1.talkMaxDuration = var_293_6

					if var_293_6 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_6 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_7 and arg_290_1.time_ < var_293_0 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play1103403078 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1103403078
		arg_294_1.duration_ = 8

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1103403079(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = "I05a"

			if arg_294_1.bgs_[var_297_0] == nil then
				local var_297_1 = Object.Instantiate(arg_294_1.paintGo_)

				var_297_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_297_0)
				var_297_1.name = var_297_0
				var_297_1.transform.parent = arg_294_1.stage_.transform
				var_297_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_294_1.bgs_[var_297_0] = var_297_1
			end

			local var_297_2 = 1

			if var_297_2 < arg_294_1.time_ and arg_294_1.time_ <= var_297_2 + arg_297_0 then
				local var_297_3 = manager.ui.mainCamera.transform.localPosition
				local var_297_4 = Vector3.New(0, 0, 10) + Vector3.New(var_297_3.x, var_297_3.y, 0)
				local var_297_5 = arg_294_1.bgs_.I05a

				var_297_5.transform.localPosition = var_297_4
				var_297_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_297_6 = var_297_5:GetComponent("SpriteRenderer")

				if var_297_6 and var_297_6.sprite then
					local var_297_7 = (var_297_5.transform.localPosition - var_297_3).z
					local var_297_8 = manager.ui.mainCameraCom_
					local var_297_9 = 2 * var_297_7 * Mathf.Tan(var_297_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_297_10 = var_297_9 * var_297_8.aspect
					local var_297_11 = var_297_6.sprite.bounds.size.x
					local var_297_12 = var_297_6.sprite.bounds.size.y
					local var_297_13 = var_297_10 / var_297_11
					local var_297_14 = var_297_9 / var_297_12
					local var_297_15 = var_297_14 < var_297_13 and var_297_13 or var_297_14

					var_297_5.transform.localScale = Vector3.New(var_297_15, var_297_15, 0)
				end

				for iter_297_0, iter_297_1 in pairs(arg_294_1.bgs_) do
					if iter_297_0 ~= "I05a" then
						iter_297_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_297_16 = 3

			if var_297_16 < arg_294_1.time_ and arg_294_1.time_ <= var_297_16 + arg_297_0 then
				arg_294_1.allBtn_.enabled = false
			end

			local var_297_17 = 0.3

			if arg_294_1.time_ >= var_297_16 + var_297_17 and arg_294_1.time_ < var_297_16 + var_297_17 + arg_297_0 then
				arg_294_1.allBtn_.enabled = true
			end

			local var_297_18 = 0

			if var_297_18 < arg_294_1.time_ and arg_294_1.time_ <= var_297_18 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_19 = 1

			if var_297_18 <= arg_294_1.time_ and arg_294_1.time_ < var_297_18 + var_297_19 then
				local var_297_20 = (arg_294_1.time_ - var_297_18) / var_297_19
				local var_297_21 = Color.New(0, 0, 0)

				var_297_21.a = Mathf.Lerp(0, 1, var_297_20)
				arg_294_1.mask_.color = var_297_21
			end

			if arg_294_1.time_ >= var_297_18 + var_297_19 and arg_294_1.time_ < var_297_18 + var_297_19 + arg_297_0 then
				local var_297_22 = Color.New(0, 0, 0)

				var_297_22.a = 1
				arg_294_1.mask_.color = var_297_22
			end

			local var_297_23 = 1

			if var_297_23 < arg_294_1.time_ and arg_294_1.time_ <= var_297_23 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_24 = 2

			if var_297_23 <= arg_294_1.time_ and arg_294_1.time_ < var_297_23 + var_297_24 then
				local var_297_25 = (arg_294_1.time_ - var_297_23) / var_297_24
				local var_297_26 = Color.New(0, 0, 0)

				var_297_26.a = Mathf.Lerp(1, 0, var_297_25)
				arg_294_1.mask_.color = var_297_26
			end

			if arg_294_1.time_ >= var_297_23 + var_297_24 and arg_294_1.time_ < var_297_23 + var_297_24 + arg_297_0 then
				local var_297_27 = Color.New(0, 0, 0)
				local var_297_28 = 0

				arg_294_1.mask_.enabled = false
				var_297_27.a = var_297_28
				arg_294_1.mask_.color = var_297_27
			end

			local var_297_29 = manager.ui.mainCamera.transform
			local var_297_30 = 1

			if var_297_30 < arg_294_1.time_ and arg_294_1.time_ <= var_297_30 + arg_297_0 then
				local var_297_31 = arg_294_1.var_.effect6556774563453453123156162165165151

				if var_297_31 then
					Object.Destroy(var_297_31)

					arg_294_1.var_.effect6556774563453453123156162165165151 = nil
				end
			end

			local var_297_32 = 0.1
			local var_297_33 = 1

			if var_297_32 < arg_294_1.time_ and arg_294_1.time_ <= var_297_32 + arg_297_0 then
				local var_297_34 = "stop"
				local var_297_35 = "effect"

				arg_294_1:AudioAction(var_297_34, var_297_35, "se_story_16", "se_story_16_street_loop", "")
			end

			local var_297_36 = 0.766666666666667
			local var_297_37 = 1

			if var_297_36 < arg_294_1.time_ and arg_294_1.time_ <= var_297_36 + arg_297_0 then
				local var_297_38 = "play"
				local var_297_39 = "effect"

				arg_294_1:AudioAction(var_297_38, var_297_39, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_40 = 3
			local var_297_41 = 0.15

			if var_297_40 < arg_294_1.time_ and arg_294_1.time_ <= var_297_40 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_42 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_42:setOnUpdate(LuaHelper.FloatAction(function(arg_298_0)
					arg_294_1.dialogCg_.alpha = arg_298_0
				end))
				var_297_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_43 = arg_294_1:GetWordFromCfg(1103403078)
				local var_297_44 = arg_294_1:FormatText(var_297_43.content)

				arg_294_1.text_.text = var_297_44

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_45 = 6
				local var_297_46 = utf8.len(var_297_44)
				local var_297_47 = var_297_45 <= 0 and var_297_41 or var_297_41 * (var_297_46 / var_297_45)

				if var_297_47 > 0 and var_297_41 < var_297_47 then
					arg_294_1.talkMaxDuration = var_297_47
					var_297_40 = var_297_40 + 0.3

					if var_297_47 + var_297_40 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_47 + var_297_40
					end
				end

				arg_294_1.text_.text = var_297_44
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_48 = var_297_40 + 0.3
			local var_297_49 = math.max(var_297_41, arg_294_1.talkMaxDuration)

			if var_297_48 <= arg_294_1.time_ and arg_294_1.time_ < var_297_48 + var_297_49 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_48) / var_297_49

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_48 + var_297_49 and arg_294_1.time_ < var_297_48 + var_297_49 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1103403079 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1103403079
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1103403080(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 0.15

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_2 = arg_300_1:FormatText(StoryNameCfg[7].name)

				arg_300_1.leftNameTxt_.text = var_303_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:GetWordFromCfg(1103403079)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 6
				local var_303_6 = utf8.len(var_303_4)
				local var_303_7 = var_303_5 <= 0 and var_303_1 or var_303_1 * (var_303_6 / var_303_5)

				if var_303_7 > 0 and var_303_1 < var_303_7 then
					arg_300_1.talkMaxDuration = var_303_7

					if var_303_7 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_8 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_8 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_8

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_8 and arg_300_1.time_ < var_303_0 + var_303_8 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play1103403080 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1103403080
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1103403081(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 1.6

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_2 = arg_304_1:GetWordFromCfg(1103403080)
				local var_307_3 = arg_304_1:FormatText(var_307_2.content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 64
				local var_307_5 = utf8.len(var_307_3)
				local var_307_6 = var_307_4 <= 0 and var_307_1 or var_307_1 * (var_307_5 / var_307_4)

				if var_307_6 > 0 and var_307_1 < var_307_6 then
					arg_304_1.talkMaxDuration = var_307_6

					if var_307_6 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_6 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_7 and arg_304_1.time_ < var_307_0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1103403081 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1103403081
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1103403082(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0.1
			local var_311_1 = 1

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				local var_311_2 = "play"
				local var_311_3 = "effect"

				arg_308_1:AudioAction(var_311_2, var_311_3, "se_story_16", "se_story_16_foot03", "")
			end

			local var_311_4 = 0
			local var_311_5 = 0.925

			if var_311_4 < arg_308_1.time_ and arg_308_1.time_ <= var_311_4 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_6 = arg_308_1:GetWordFromCfg(1103403081)
				local var_311_7 = arg_308_1:FormatText(var_311_6.content)

				arg_308_1.text_.text = var_311_7

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_8 = 37
				local var_311_9 = utf8.len(var_311_7)
				local var_311_10 = var_311_8 <= 0 and var_311_5 or var_311_5 * (var_311_9 / var_311_8)

				if var_311_10 > 0 and var_311_5 < var_311_10 then
					arg_308_1.talkMaxDuration = var_311_10

					if var_311_10 + var_311_4 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_10 + var_311_4
					end
				end

				arg_308_1.text_.text = var_311_7
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_11 = math.max(var_311_5, arg_308_1.talkMaxDuration)

			if var_311_4 <= arg_308_1.time_ and arg_308_1.time_ < var_311_4 + var_311_11 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_4) / var_311_11

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_4 + var_311_11 and arg_308_1.time_ < var_311_4 + var_311_11 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play1103403082 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1103403082
		arg_312_1.duration_ = 2.87

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1103403083(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1034ui_story"].transform
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.var_.moveOldPos1034ui_story = var_315_0.localPosition
			end

			local var_315_2 = 0.001

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2
				local var_315_4 = Vector3.New(0, -0.93, -6)

				var_315_0.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1034ui_story, var_315_4, var_315_3)

				local var_315_5 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_5.x, var_315_5.y, var_315_5.z)

				local var_315_6 = var_315_0.localEulerAngles

				var_315_6.z = 0
				var_315_6.x = 0
				var_315_0.localEulerAngles = var_315_6
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 then
				var_315_0.localPosition = Vector3.New(0, -0.93, -6)

				local var_315_7 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_7.x, var_315_7.y, var_315_7.z)

				local var_315_8 = var_315_0.localEulerAngles

				var_315_8.z = 0
				var_315_8.x = 0
				var_315_0.localEulerAngles = var_315_8
			end

			local var_315_9 = arg_312_1.actors_["1034ui_story"]
			local var_315_10 = 0

			if var_315_10 < arg_312_1.time_ and arg_312_1.time_ <= var_315_10 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect1034ui_story == nil then
				arg_312_1.var_.characterEffect1034ui_story = var_315_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_11 = 0.200000002980232

			if var_315_10 <= arg_312_1.time_ and arg_312_1.time_ < var_315_10 + var_315_11 and not isNil(var_315_9) then
				local var_315_12 = (arg_312_1.time_ - var_315_10) / var_315_11

				if arg_312_1.var_.characterEffect1034ui_story and not isNil(var_315_9) then
					arg_312_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= var_315_10 + var_315_11 and arg_312_1.time_ < var_315_10 + var_315_11 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect1034ui_story then
				arg_312_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_315_13 = 0.866666666666667

			if var_315_13 < arg_312_1.time_ and arg_312_1.time_ <= var_315_13 + arg_315_0 then
				arg_312_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action4_1")
			end

			local var_315_14 = 0.866666666666667

			if var_315_14 < arg_312_1.time_ and arg_312_1.time_ <= var_315_14 + arg_315_0 then
				arg_312_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_315_15 = 0
			local var_315_16 = 0.15

			if var_315_15 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_17 = arg_312_1:FormatText(StoryNameCfg[1109].name)

				arg_312_1.leftNameTxt_.text = var_315_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_18 = arg_312_1:GetWordFromCfg(1103403082)
				local var_315_19 = arg_312_1:FormatText(var_315_18.content)

				arg_312_1.text_.text = var_315_19

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_20 = 6
				local var_315_21 = utf8.len(var_315_19)
				local var_315_22 = var_315_20 <= 0 and var_315_16 or var_315_16 * (var_315_21 / var_315_20)

				if var_315_22 > 0 and var_315_16 < var_315_22 then
					arg_312_1.talkMaxDuration = var_315_22

					if var_315_22 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_22 + var_315_15
					end
				end

				arg_312_1.text_.text = var_315_19
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403082", "story_v_side_new_1103403.awb") ~= 0 then
					local var_315_23 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403082", "story_v_side_new_1103403.awb") / 1000

					if var_315_23 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_23 + var_315_15
					end

					if var_315_18.prefab_name ~= "" and arg_312_1.actors_[var_315_18.prefab_name] ~= nil then
						local var_315_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_18.prefab_name].transform, "story_v_side_new_1103403", "1103403082", "story_v_side_new_1103403.awb")

						arg_312_1:RecordAudio("1103403082", var_315_24)
						arg_312_1:RecordAudio("1103403082", var_315_24)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403082", "story_v_side_new_1103403.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403082", "story_v_side_new_1103403.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_25 = math.max(var_315_16, arg_312_1.talkMaxDuration)

			if var_315_15 <= arg_312_1.time_ and arg_312_1.time_ < var_315_15 + var_315_25 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_15) / var_315_25

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_15 + var_315_25 and arg_312_1.time_ < var_315_15 + var_315_25 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play1103403083 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1103403083
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1103403084(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["1034ui_story"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect1034ui_story == nil then
				arg_316_1.var_.characterEffect1034ui_story = var_319_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.characterEffect1034ui_story and not isNil(var_319_0) then
					local var_319_4 = Mathf.Lerp(0, 0.5, var_319_3)

					arg_316_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1034ui_story.fillRatio = var_319_4
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect1034ui_story then
				local var_319_5 = 0.5

				arg_316_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1034ui_story.fillRatio = var_319_5
			end

			local var_319_6 = 0
			local var_319_7 = 0.525

			if var_319_6 < arg_316_1.time_ and arg_316_1.time_ <= var_319_6 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_8 = arg_316_1:FormatText(StoryNameCfg[7].name)

				arg_316_1.leftNameTxt_.text = var_319_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_9 = arg_316_1:GetWordFromCfg(1103403083)
				local var_319_10 = arg_316_1:FormatText(var_319_9.content)

				arg_316_1.text_.text = var_319_10

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_11 = 21
				local var_319_12 = utf8.len(var_319_10)
				local var_319_13 = var_319_11 <= 0 and var_319_7 or var_319_7 * (var_319_12 / var_319_11)

				if var_319_13 > 0 and var_319_7 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13

					if var_319_13 + var_319_6 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_6
					end
				end

				arg_316_1.text_.text = var_319_10
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_14 = math.max(var_319_7, arg_316_1.talkMaxDuration)

			if var_319_6 <= arg_316_1.time_ and arg_316_1.time_ < var_319_6 + var_319_14 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_6) / var_319_14

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_6 + var_319_14 and arg_316_1.time_ < var_319_6 + var_319_14 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play1103403084 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1103403084
		arg_320_1.duration_ = 4.33

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1103403085(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["1034ui_story"]
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect1034ui_story == nil then
				arg_320_1.var_.characterEffect1034ui_story = var_323_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.200000002980232

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 and not isNil(var_323_0) then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2

				if arg_320_1.var_.characterEffect1034ui_story and not isNil(var_323_0) then
					arg_320_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect1034ui_story then
				arg_320_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_323_4 = 0

			if var_323_4 < arg_320_1.time_ and arg_320_1.time_ <= var_323_4 + arg_323_0 then
				arg_320_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action446")
			end

			local var_323_5 = 0

			if var_323_5 < arg_320_1.time_ and arg_320_1.time_ <= var_323_5 + arg_323_0 then
				arg_320_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_323_6 = 0
			local var_323_7 = 0.475

			if var_323_6 < arg_320_1.time_ and arg_320_1.time_ <= var_323_6 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_8 = arg_320_1:FormatText(StoryNameCfg[1109].name)

				arg_320_1.leftNameTxt_.text = var_323_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_9 = arg_320_1:GetWordFromCfg(1103403084)
				local var_323_10 = arg_320_1:FormatText(var_323_9.content)

				arg_320_1.text_.text = var_323_10

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_11 = 19
				local var_323_12 = utf8.len(var_323_10)
				local var_323_13 = var_323_11 <= 0 and var_323_7 or var_323_7 * (var_323_12 / var_323_11)

				if var_323_13 > 0 and var_323_7 < var_323_13 then
					arg_320_1.talkMaxDuration = var_323_13

					if var_323_13 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_13 + var_323_6
					end
				end

				arg_320_1.text_.text = var_323_10
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403084", "story_v_side_new_1103403.awb") ~= 0 then
					local var_323_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403084", "story_v_side_new_1103403.awb") / 1000

					if var_323_14 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_14 + var_323_6
					end

					if var_323_9.prefab_name ~= "" and arg_320_1.actors_[var_323_9.prefab_name] ~= nil then
						local var_323_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_9.prefab_name].transform, "story_v_side_new_1103403", "1103403084", "story_v_side_new_1103403.awb")

						arg_320_1:RecordAudio("1103403084", var_323_15)
						arg_320_1:RecordAudio("1103403084", var_323_15)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403084", "story_v_side_new_1103403.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403084", "story_v_side_new_1103403.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_16 = math.max(var_323_7, arg_320_1.talkMaxDuration)

			if var_323_6 <= arg_320_1.time_ and arg_320_1.time_ < var_323_6 + var_323_16 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_6) / var_323_16

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_6 + var_323_16 and arg_320_1.time_ < var_323_6 + var_323_16 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1103403085 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1103403085
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1103403086(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1034ui_story"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1034ui_story == nil then
				arg_324_1.var_.characterEffect1034ui_story = var_327_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.200000002980232

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.characterEffect1034ui_story and not isNil(var_327_0) then
					local var_327_4 = Mathf.Lerp(0, 0.5, var_327_3)

					arg_324_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1034ui_story.fillRatio = var_327_4
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1034ui_story then
				local var_327_5 = 0.5

				arg_324_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1034ui_story.fillRatio = var_327_5
			end

			local var_327_6 = 0
			local var_327_7 = 0.125

			if var_327_6 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_8 = arg_324_1:FormatText(StoryNameCfg[7].name)

				arg_324_1.leftNameTxt_.text = var_327_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_9 = arg_324_1:GetWordFromCfg(1103403085)
				local var_327_10 = arg_324_1:FormatText(var_327_9.content)

				arg_324_1.text_.text = var_327_10

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_11 = 5
				local var_327_12 = utf8.len(var_327_10)
				local var_327_13 = var_327_11 <= 0 and var_327_7 or var_327_7 * (var_327_12 / var_327_11)

				if var_327_13 > 0 and var_327_7 < var_327_13 then
					arg_324_1.talkMaxDuration = var_327_13

					if var_327_13 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_13 + var_327_6
					end
				end

				arg_324_1.text_.text = var_327_10
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_14 = math.max(var_327_7, arg_324_1.talkMaxDuration)

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_14 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_6) / var_327_14

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_6 + var_327_14 and arg_324_1.time_ < var_327_6 + var_327_14 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1103403086 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1103403086
		arg_328_1.duration_ = 5.03

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1103403087(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1034ui_story"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1034ui_story == nil then
				arg_328_1.var_.characterEffect1034ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.characterEffect1034ui_story and not isNil(var_331_0) then
					arg_328_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1034ui_story then
				arg_328_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_331_4 = 0

			if var_331_4 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			local var_331_5 = 0

			if var_331_5 < arg_328_1.time_ and arg_328_1.time_ <= var_331_5 + arg_331_0 then
				arg_328_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_331_6 = 0
			local var_331_7 = 0.675

			if var_331_6 < arg_328_1.time_ and arg_328_1.time_ <= var_331_6 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_8 = arg_328_1:FormatText(StoryNameCfg[1109].name)

				arg_328_1.leftNameTxt_.text = var_331_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_9 = arg_328_1:GetWordFromCfg(1103403086)
				local var_331_10 = arg_328_1:FormatText(var_331_9.content)

				arg_328_1.text_.text = var_331_10

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_11 = 27
				local var_331_12 = utf8.len(var_331_10)
				local var_331_13 = var_331_11 <= 0 and var_331_7 or var_331_7 * (var_331_12 / var_331_11)

				if var_331_13 > 0 and var_331_7 < var_331_13 then
					arg_328_1.talkMaxDuration = var_331_13

					if var_331_13 + var_331_6 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_13 + var_331_6
					end
				end

				arg_328_1.text_.text = var_331_10
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403086", "story_v_side_new_1103403.awb") ~= 0 then
					local var_331_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403086", "story_v_side_new_1103403.awb") / 1000

					if var_331_14 + var_331_6 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_14 + var_331_6
					end

					if var_331_9.prefab_name ~= "" and arg_328_1.actors_[var_331_9.prefab_name] ~= nil then
						local var_331_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_9.prefab_name].transform, "story_v_side_new_1103403", "1103403086", "story_v_side_new_1103403.awb")

						arg_328_1:RecordAudio("1103403086", var_331_15)
						arg_328_1:RecordAudio("1103403086", var_331_15)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403086", "story_v_side_new_1103403.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403086", "story_v_side_new_1103403.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_16 = math.max(var_331_7, arg_328_1.talkMaxDuration)

			if var_331_6 <= arg_328_1.time_ and arg_328_1.time_ < var_331_6 + var_331_16 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_6) / var_331_16

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_6 + var_331_16 and arg_328_1.time_ < var_331_6 + var_331_16 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play1103403087 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1103403087
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1103403088(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1034ui_story"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1034ui_story == nil then
				arg_332_1.var_.characterEffect1034ui_story = var_335_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.200000002980232

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.characterEffect1034ui_story and not isNil(var_335_0) then
					local var_335_4 = Mathf.Lerp(0, 0.5, var_335_3)

					arg_332_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1034ui_story.fillRatio = var_335_4
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1034ui_story then
				local var_335_5 = 0.5

				arg_332_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1034ui_story.fillRatio = var_335_5
			end

			local var_335_6 = 0

			if var_335_6 < arg_332_1.time_ and arg_332_1.time_ <= var_335_6 + arg_335_0 then
				arg_332_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_335_7 = 0
			local var_335_8 = 0.4

			if var_335_7 < arg_332_1.time_ and arg_332_1.time_ <= var_335_7 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_9 = arg_332_1:FormatText(StoryNameCfg[7].name)

				arg_332_1.leftNameTxt_.text = var_335_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_10 = arg_332_1:GetWordFromCfg(1103403087)
				local var_335_11 = arg_332_1:FormatText(var_335_10.content)

				arg_332_1.text_.text = var_335_11

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_12 = 16
				local var_335_13 = utf8.len(var_335_11)
				local var_335_14 = var_335_12 <= 0 and var_335_8 or var_335_8 * (var_335_13 / var_335_12)

				if var_335_14 > 0 and var_335_8 < var_335_14 then
					arg_332_1.talkMaxDuration = var_335_14

					if var_335_14 + var_335_7 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_14 + var_335_7
					end
				end

				arg_332_1.text_.text = var_335_11
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_15 = math.max(var_335_8, arg_332_1.talkMaxDuration)

			if var_335_7 <= arg_332_1.time_ and arg_332_1.time_ < var_335_7 + var_335_15 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_7) / var_335_15

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_7 + var_335_15 and arg_332_1.time_ < var_335_7 + var_335_15 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play1103403088 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1103403088
		arg_336_1.duration_ = 3.87

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1103403089(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1034ui_story"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1034ui_story == nil then
				arg_336_1.var_.characterEffect1034ui_story = var_339_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.characterEffect1034ui_story and not isNil(var_339_0) then
					arg_336_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1034ui_story then
				arg_336_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_339_4 = 0

			if var_339_4 < arg_336_1.time_ and arg_336_1.time_ <= var_339_4 + arg_339_0 then
				arg_336_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_339_5 = 0

			if var_339_5 < arg_336_1.time_ and arg_336_1.time_ <= var_339_5 + arg_339_0 then
				arg_336_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_339_6 = 0
			local var_339_7 = 0.475

			if var_339_6 < arg_336_1.time_ and arg_336_1.time_ <= var_339_6 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_8 = arg_336_1:FormatText(StoryNameCfg[1109].name)

				arg_336_1.leftNameTxt_.text = var_339_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_9 = arg_336_1:GetWordFromCfg(1103403088)
				local var_339_10 = arg_336_1:FormatText(var_339_9.content)

				arg_336_1.text_.text = var_339_10

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_11 = 19
				local var_339_12 = utf8.len(var_339_10)
				local var_339_13 = var_339_11 <= 0 and var_339_7 or var_339_7 * (var_339_12 / var_339_11)

				if var_339_13 > 0 and var_339_7 < var_339_13 then
					arg_336_1.talkMaxDuration = var_339_13

					if var_339_13 + var_339_6 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_13 + var_339_6
					end
				end

				arg_336_1.text_.text = var_339_10
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403088", "story_v_side_new_1103403.awb") ~= 0 then
					local var_339_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403088", "story_v_side_new_1103403.awb") / 1000

					if var_339_14 + var_339_6 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_14 + var_339_6
					end

					if var_339_9.prefab_name ~= "" and arg_336_1.actors_[var_339_9.prefab_name] ~= nil then
						local var_339_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_9.prefab_name].transform, "story_v_side_new_1103403", "1103403088", "story_v_side_new_1103403.awb")

						arg_336_1:RecordAudio("1103403088", var_339_15)
						arg_336_1:RecordAudio("1103403088", var_339_15)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403088", "story_v_side_new_1103403.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403088", "story_v_side_new_1103403.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_16 = math.max(var_339_7, arg_336_1.talkMaxDuration)

			if var_339_6 <= arg_336_1.time_ and arg_336_1.time_ < var_339_6 + var_339_16 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_6) / var_339_16

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_6 + var_339_16 and arg_336_1.time_ < var_339_6 + var_339_16 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play1103403089 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1103403089
		arg_340_1.duration_ = 5.07

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1103403090(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action465")
			end

			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_343_2 = 0
			local var_343_3 = 0.575

			if var_343_2 < arg_340_1.time_ and arg_340_1.time_ <= var_343_2 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_4 = arg_340_1:FormatText(StoryNameCfg[1109].name)

				arg_340_1.leftNameTxt_.text = var_343_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_5 = arg_340_1:GetWordFromCfg(1103403089)
				local var_343_6 = arg_340_1:FormatText(var_343_5.content)

				arg_340_1.text_.text = var_343_6

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_7 = 23
				local var_343_8 = utf8.len(var_343_6)
				local var_343_9 = var_343_7 <= 0 and var_343_3 or var_343_3 * (var_343_8 / var_343_7)

				if var_343_9 > 0 and var_343_3 < var_343_9 then
					arg_340_1.talkMaxDuration = var_343_9

					if var_343_9 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_9 + var_343_2
					end
				end

				arg_340_1.text_.text = var_343_6
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403089", "story_v_side_new_1103403.awb") ~= 0 then
					local var_343_10 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403089", "story_v_side_new_1103403.awb") / 1000

					if var_343_10 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_10 + var_343_2
					end

					if var_343_5.prefab_name ~= "" and arg_340_1.actors_[var_343_5.prefab_name] ~= nil then
						local var_343_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_5.prefab_name].transform, "story_v_side_new_1103403", "1103403089", "story_v_side_new_1103403.awb")

						arg_340_1:RecordAudio("1103403089", var_343_11)
						arg_340_1:RecordAudio("1103403089", var_343_11)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403089", "story_v_side_new_1103403.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403089", "story_v_side_new_1103403.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_12 = math.max(var_343_3, arg_340_1.talkMaxDuration)

			if var_343_2 <= arg_340_1.time_ and arg_340_1.time_ < var_343_2 + var_343_12 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_2) / var_343_12

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_2 + var_343_12 and arg_340_1.time_ < var_343_2 + var_343_12 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1103403090 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1103403090
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1103403091(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1034ui_story"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1034ui_story == nil then
				arg_344_1.var_.characterEffect1034ui_story = var_347_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.characterEffect1034ui_story and not isNil(var_347_0) then
					local var_347_4 = Mathf.Lerp(0, 0.5, var_347_3)

					arg_344_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1034ui_story.fillRatio = var_347_4
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1034ui_story then
				local var_347_5 = 0.5

				arg_344_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1034ui_story.fillRatio = var_347_5
			end

			local var_347_6 = 0

			if var_347_6 < arg_344_1.time_ and arg_344_1.time_ <= var_347_6 + arg_347_0 then
				arg_344_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_347_7 = 0
			local var_347_8 = 0.625

			if var_347_7 < arg_344_1.time_ and arg_344_1.time_ <= var_347_7 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_9 = arg_344_1:FormatText(StoryNameCfg[7].name)

				arg_344_1.leftNameTxt_.text = var_347_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_10 = arg_344_1:GetWordFromCfg(1103403090)
				local var_347_11 = arg_344_1:FormatText(var_347_10.content)

				arg_344_1.text_.text = var_347_11

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_12 = 25
				local var_347_13 = utf8.len(var_347_11)
				local var_347_14 = var_347_12 <= 0 and var_347_8 or var_347_8 * (var_347_13 / var_347_12)

				if var_347_14 > 0 and var_347_8 < var_347_14 then
					arg_344_1.talkMaxDuration = var_347_14

					if var_347_14 + var_347_7 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_14 + var_347_7
					end
				end

				arg_344_1.text_.text = var_347_11
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_15 = math.max(var_347_8, arg_344_1.talkMaxDuration)

			if var_347_7 <= arg_344_1.time_ and arg_344_1.time_ < var_347_7 + var_347_15 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_7) / var_347_15

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_7 + var_347_15 and arg_344_1.time_ < var_347_7 + var_347_15 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play1103403091 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1103403091
		arg_348_1.duration_ = 2.63

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1103403092(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1034ui_story"]
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect1034ui_story == nil then
				arg_348_1.var_.characterEffect1034ui_story = var_351_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_2 = 0.200000002980232

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 and not isNil(var_351_0) then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2

				if arg_348_1.var_.characterEffect1034ui_story and not isNil(var_351_0) then
					arg_348_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect1034ui_story then
				arg_348_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_351_4 = 0

			if var_351_4 < arg_348_1.time_ and arg_348_1.time_ <= var_351_4 + arg_351_0 then
				arg_348_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			local var_351_5 = 0

			if var_351_5 < arg_348_1.time_ and arg_348_1.time_ <= var_351_5 + arg_351_0 then
				arg_348_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_351_6 = 0
			local var_351_7 = 0.225

			if var_351_6 < arg_348_1.time_ and arg_348_1.time_ <= var_351_6 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_8 = arg_348_1:FormatText(StoryNameCfg[1109].name)

				arg_348_1.leftNameTxt_.text = var_351_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_9 = arg_348_1:GetWordFromCfg(1103403091)
				local var_351_10 = arg_348_1:FormatText(var_351_9.content)

				arg_348_1.text_.text = var_351_10

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_11 = 9
				local var_351_12 = utf8.len(var_351_10)
				local var_351_13 = var_351_11 <= 0 and var_351_7 or var_351_7 * (var_351_12 / var_351_11)

				if var_351_13 > 0 and var_351_7 < var_351_13 then
					arg_348_1.talkMaxDuration = var_351_13

					if var_351_13 + var_351_6 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_13 + var_351_6
					end
				end

				arg_348_1.text_.text = var_351_10
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403091", "story_v_side_new_1103403.awb") ~= 0 then
					local var_351_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403091", "story_v_side_new_1103403.awb") / 1000

					if var_351_14 + var_351_6 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_14 + var_351_6
					end

					if var_351_9.prefab_name ~= "" and arg_348_1.actors_[var_351_9.prefab_name] ~= nil then
						local var_351_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_9.prefab_name].transform, "story_v_side_new_1103403", "1103403091", "story_v_side_new_1103403.awb")

						arg_348_1:RecordAudio("1103403091", var_351_15)
						arg_348_1:RecordAudio("1103403091", var_351_15)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403091", "story_v_side_new_1103403.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403091", "story_v_side_new_1103403.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_16 = math.max(var_351_7, arg_348_1.talkMaxDuration)

			if var_351_6 <= arg_348_1.time_ and arg_348_1.time_ < var_351_6 + var_351_16 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_6) / var_351_16

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_6 + var_351_16 and arg_348_1.time_ < var_351_6 + var_351_16 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1103403092 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1103403092
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1103403093(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1034ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1034ui_story == nil then
				arg_352_1.var_.characterEffect1034ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect1034ui_story and not isNil(var_355_0) then
					local var_355_4 = Mathf.Lerp(0, 0.5, var_355_3)

					arg_352_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1034ui_story.fillRatio = var_355_4
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1034ui_story then
				local var_355_5 = 0.5

				arg_352_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1034ui_story.fillRatio = var_355_5
			end

			local var_355_6 = 0

			if var_355_6 < arg_352_1.time_ and arg_352_1.time_ <= var_355_6 + arg_355_0 then
				arg_352_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_355_7 = 0

			if var_355_7 < arg_352_1.time_ and arg_352_1.time_ <= var_355_7 + arg_355_0 then
				arg_352_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_355_8 = 0
			local var_355_9 = 0.1

			if var_355_8 < arg_352_1.time_ and arg_352_1.time_ <= var_355_8 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_10 = arg_352_1:FormatText(StoryNameCfg[7].name)

				arg_352_1.leftNameTxt_.text = var_355_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_11 = arg_352_1:GetWordFromCfg(1103403092)
				local var_355_12 = arg_352_1:FormatText(var_355_11.content)

				arg_352_1.text_.text = var_355_12

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_13 = 4
				local var_355_14 = utf8.len(var_355_12)
				local var_355_15 = var_355_13 <= 0 and var_355_9 or var_355_9 * (var_355_14 / var_355_13)

				if var_355_15 > 0 and var_355_9 < var_355_15 then
					arg_352_1.talkMaxDuration = var_355_15

					if var_355_15 + var_355_8 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_15 + var_355_8
					end
				end

				arg_352_1.text_.text = var_355_12
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_16 = math.max(var_355_9, arg_352_1.talkMaxDuration)

			if var_355_8 <= arg_352_1.time_ and arg_352_1.time_ < var_355_8 + var_355_16 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_8) / var_355_16

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_8 + var_355_16 and arg_352_1.time_ < var_355_8 + var_355_16 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play1103403093 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1103403093
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1103403094(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_359_1 = 0
			local var_359_2 = 0.95

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_3 = arg_356_1:GetWordFromCfg(1103403093)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 38
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_2 or var_359_2 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_2 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_1 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_1
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_8 = math.max(var_359_2, arg_356_1.talkMaxDuration)

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_8 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_1) / var_359_8

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_1 + var_359_8 and arg_356_1.time_ < var_359_1 + var_359_8 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1103403094 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1103403094
		arg_360_1.duration_ = 5.53

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1103403095(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["1034ui_story"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect1034ui_story == nil then
				arg_360_1.var_.characterEffect1034ui_story = var_363_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.characterEffect1034ui_story and not isNil(var_363_0) then
					arg_360_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect1034ui_story then
				arg_360_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_363_4 = 0

			if var_363_4 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_363_5 = 0
			local var_363_6 = 0.65

			if var_363_5 < arg_360_1.time_ and arg_360_1.time_ <= var_363_5 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_7 = arg_360_1:FormatText(StoryNameCfg[1109].name)

				arg_360_1.leftNameTxt_.text = var_363_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_8 = arg_360_1:GetWordFromCfg(1103403094)
				local var_363_9 = arg_360_1:FormatText(var_363_8.content)

				arg_360_1.text_.text = var_363_9

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_10 = 26
				local var_363_11 = utf8.len(var_363_9)
				local var_363_12 = var_363_10 <= 0 and var_363_6 or var_363_6 * (var_363_11 / var_363_10)

				if var_363_12 > 0 and var_363_6 < var_363_12 then
					arg_360_1.talkMaxDuration = var_363_12

					if var_363_12 + var_363_5 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_12 + var_363_5
					end
				end

				arg_360_1.text_.text = var_363_9
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403094", "story_v_side_new_1103403.awb") ~= 0 then
					local var_363_13 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403094", "story_v_side_new_1103403.awb") / 1000

					if var_363_13 + var_363_5 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_13 + var_363_5
					end

					if var_363_8.prefab_name ~= "" and arg_360_1.actors_[var_363_8.prefab_name] ~= nil then
						local var_363_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_8.prefab_name].transform, "story_v_side_new_1103403", "1103403094", "story_v_side_new_1103403.awb")

						arg_360_1:RecordAudio("1103403094", var_363_14)
						arg_360_1:RecordAudio("1103403094", var_363_14)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403094", "story_v_side_new_1103403.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403094", "story_v_side_new_1103403.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_15 = math.max(var_363_6, arg_360_1.talkMaxDuration)

			if var_363_5 <= arg_360_1.time_ and arg_360_1.time_ < var_363_5 + var_363_15 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_5) / var_363_15

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_5 + var_363_15 and arg_360_1.time_ < var_363_5 + var_363_15 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play1103403095 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1103403095
		arg_364_1.duration_ = 2.3

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1103403096(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_367_1 = 0
			local var_367_2 = 0.275

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_3 = arg_364_1:FormatText(StoryNameCfg[1109].name)

				arg_364_1.leftNameTxt_.text = var_367_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_4 = arg_364_1:GetWordFromCfg(1103403095)
				local var_367_5 = arg_364_1:FormatText(var_367_4.content)

				arg_364_1.text_.text = var_367_5

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_6 = 11
				local var_367_7 = utf8.len(var_367_5)
				local var_367_8 = var_367_6 <= 0 and var_367_2 or var_367_2 * (var_367_7 / var_367_6)

				if var_367_8 > 0 and var_367_2 < var_367_8 then
					arg_364_1.talkMaxDuration = var_367_8

					if var_367_8 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_1
					end
				end

				arg_364_1.text_.text = var_367_5
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403095", "story_v_side_new_1103403.awb") ~= 0 then
					local var_367_9 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403095", "story_v_side_new_1103403.awb") / 1000

					if var_367_9 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_9 + var_367_1
					end

					if var_367_4.prefab_name ~= "" and arg_364_1.actors_[var_367_4.prefab_name] ~= nil then
						local var_367_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_4.prefab_name].transform, "story_v_side_new_1103403", "1103403095", "story_v_side_new_1103403.awb")

						arg_364_1:RecordAudio("1103403095", var_367_10)
						arg_364_1:RecordAudio("1103403095", var_367_10)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403095", "story_v_side_new_1103403.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403095", "story_v_side_new_1103403.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_11 = math.max(var_367_2, arg_364_1.talkMaxDuration)

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_11 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_1) / var_367_11

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_1 + var_367_11 and arg_364_1.time_ < var_367_1 + var_367_11 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1103403096 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1103403096
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1103403097(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["1034ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect1034ui_story == nil then
				arg_368_1.var_.characterEffect1034ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect1034ui_story and not isNil(var_371_0) then
					local var_371_4 = Mathf.Lerp(0, 0.5, var_371_3)

					arg_368_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_368_1.var_.characterEffect1034ui_story.fillRatio = var_371_4
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect1034ui_story then
				local var_371_5 = 0.5

				arg_368_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_368_1.var_.characterEffect1034ui_story.fillRatio = var_371_5
			end

			local var_371_6 = 0

			if var_371_6 < arg_368_1.time_ and arg_368_1.time_ <= var_371_6 + arg_371_0 then
				arg_368_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			local var_371_7 = 0

			if var_371_7 < arg_368_1.time_ and arg_368_1.time_ <= var_371_7 + arg_371_0 then
				arg_368_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_371_8 = 0
			local var_371_9 = 1.075

			if var_371_8 < arg_368_1.time_ and arg_368_1.time_ <= var_371_8 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_10 = arg_368_1:GetWordFromCfg(1103403096)
				local var_371_11 = arg_368_1:FormatText(var_371_10.content)

				arg_368_1.text_.text = var_371_11

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_12 = 43
				local var_371_13 = utf8.len(var_371_11)
				local var_371_14 = var_371_12 <= 0 and var_371_9 or var_371_9 * (var_371_13 / var_371_12)

				if var_371_14 > 0 and var_371_9 < var_371_14 then
					arg_368_1.talkMaxDuration = var_371_14

					if var_371_14 + var_371_8 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_14 + var_371_8
					end
				end

				arg_368_1.text_.text = var_371_11
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_15 = math.max(var_371_9, arg_368_1.talkMaxDuration)

			if var_371_8 <= arg_368_1.time_ and arg_368_1.time_ < var_371_8 + var_371_15 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_8) / var_371_15

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_8 + var_371_15 and arg_368_1.time_ < var_371_8 + var_371_15 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play1103403097 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1103403097
		arg_372_1.duration_ = 2

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"

			SetActive(arg_372_1.choicesGo_, true)

			for iter_373_0, iter_373_1 in ipairs(arg_372_1.choices_) do
				local var_373_0 = iter_373_0 <= 2

				SetActive(iter_373_1.go, var_373_0)
			end

			arg_372_1.choices_[1].txt.text = arg_372_1:FormatText(StoryChoiceCfg[1459].name)
			arg_372_1.choices_[2].txt.text = arg_372_1:FormatText(StoryChoiceCfg[1460].name)
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1103403098(arg_372_1)
			end

			if arg_374_0 == 2 then
				arg_372_0:Play1103403101(arg_372_1)
			end

			arg_372_1:RecordChoiceLog(1103403097, 1459, 1460)
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_375_2 = 0

			if var_375_2 < arg_372_1.time_ and arg_372_1.time_ <= var_375_2 + arg_375_0 then
				arg_372_1.allBtn_.enabled = false
			end

			local var_375_3 = 2

			if arg_372_1.time_ >= var_375_2 + var_375_3 and arg_372_1.time_ < var_375_2 + var_375_3 + arg_375_0 then
				arg_372_1.allBtn_.enabled = true
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1103403098 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1103403098
		arg_376_1.duration_ = 2.67

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1103403099(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1034ui_story"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect1034ui_story == nil then
				arg_376_1.var_.characterEffect1034ui_story = var_379_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.characterEffect1034ui_story and not isNil(var_379_0) then
					arg_376_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect1034ui_story then
				arg_376_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_379_4 = 0

			if var_379_4 < arg_376_1.time_ and arg_376_1.time_ <= var_379_4 + arg_379_0 then
				arg_376_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			local var_379_5 = 0

			if var_379_5 < arg_376_1.time_ and arg_376_1.time_ <= var_379_5 + arg_379_0 then
				arg_376_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_379_6 = 0
			local var_379_7 = 0.25

			if var_379_6 < arg_376_1.time_ and arg_376_1.time_ <= var_379_6 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_8 = arg_376_1:FormatText(StoryNameCfg[1109].name)

				arg_376_1.leftNameTxt_.text = var_379_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_9 = arg_376_1:GetWordFromCfg(1103403098)
				local var_379_10 = arg_376_1:FormatText(var_379_9.content)

				arg_376_1.text_.text = var_379_10

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_11 = 10
				local var_379_12 = utf8.len(var_379_10)
				local var_379_13 = var_379_11 <= 0 and var_379_7 or var_379_7 * (var_379_12 / var_379_11)

				if var_379_13 > 0 and var_379_7 < var_379_13 then
					arg_376_1.talkMaxDuration = var_379_13

					if var_379_13 + var_379_6 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_13 + var_379_6
					end
				end

				arg_376_1.text_.text = var_379_10
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403098", "story_v_side_new_1103403.awb") ~= 0 then
					local var_379_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403098", "story_v_side_new_1103403.awb") / 1000

					if var_379_14 + var_379_6 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_14 + var_379_6
					end

					if var_379_9.prefab_name ~= "" and arg_376_1.actors_[var_379_9.prefab_name] ~= nil then
						local var_379_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_9.prefab_name].transform, "story_v_side_new_1103403", "1103403098", "story_v_side_new_1103403.awb")

						arg_376_1:RecordAudio("1103403098", var_379_15)
						arg_376_1:RecordAudio("1103403098", var_379_15)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403098", "story_v_side_new_1103403.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403098", "story_v_side_new_1103403.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_16 = math.max(var_379_7, arg_376_1.talkMaxDuration)

			if var_379_6 <= arg_376_1.time_ and arg_376_1.time_ < var_379_6 + var_379_16 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_6) / var_379_16

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_6 + var_379_16 and arg_376_1.time_ < var_379_6 + var_379_16 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1103403099 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1103403099
		arg_380_1.duration_ = 5.17

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1103403100(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 0.575

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_2 = arg_380_1:FormatText(StoryNameCfg[1109].name)

				arg_380_1.leftNameTxt_.text = var_383_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_3 = arg_380_1:GetWordFromCfg(1103403099)
				local var_383_4 = arg_380_1:FormatText(var_383_3.content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 23
				local var_383_6 = utf8.len(var_383_4)
				local var_383_7 = var_383_5 <= 0 and var_383_1 or var_383_1 * (var_383_6 / var_383_5)

				if var_383_7 > 0 and var_383_1 < var_383_7 then
					arg_380_1.talkMaxDuration = var_383_7

					if var_383_7 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403099", "story_v_side_new_1103403.awb") ~= 0 then
					local var_383_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403099", "story_v_side_new_1103403.awb") / 1000

					if var_383_8 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_8 + var_383_0
					end

					if var_383_3.prefab_name ~= "" and arg_380_1.actors_[var_383_3.prefab_name] ~= nil then
						local var_383_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_3.prefab_name].transform, "story_v_side_new_1103403", "1103403099", "story_v_side_new_1103403.awb")

						arg_380_1:RecordAudio("1103403099", var_383_9)
						arg_380_1:RecordAudio("1103403099", var_383_9)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403099", "story_v_side_new_1103403.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403099", "story_v_side_new_1103403.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_10 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_10 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_10

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_10 and arg_380_1.time_ < var_383_0 + var_383_10 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1103403100 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1103403100
		arg_384_1.duration_ = 5.27

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1103403105(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2")
			end

			local var_387_1 = 0
			local var_387_2 = 0.575

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_3 = arg_384_1:FormatText(StoryNameCfg[1109].name)

				arg_384_1.leftNameTxt_.text = var_387_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_4 = arg_384_1:GetWordFromCfg(1103403100)
				local var_387_5 = arg_384_1:FormatText(var_387_4.content)

				arg_384_1.text_.text = var_387_5

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_6 = 23
				local var_387_7 = utf8.len(var_387_5)
				local var_387_8 = var_387_6 <= 0 and var_387_2 or var_387_2 * (var_387_7 / var_387_6)

				if var_387_8 > 0 and var_387_2 < var_387_8 then
					arg_384_1.talkMaxDuration = var_387_8

					if var_387_8 + var_387_1 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_8 + var_387_1
					end
				end

				arg_384_1.text_.text = var_387_5
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403100", "story_v_side_new_1103403.awb") ~= 0 then
					local var_387_9 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403100", "story_v_side_new_1103403.awb") / 1000

					if var_387_9 + var_387_1 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_9 + var_387_1
					end

					if var_387_4.prefab_name ~= "" and arg_384_1.actors_[var_387_4.prefab_name] ~= nil then
						local var_387_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_4.prefab_name].transform, "story_v_side_new_1103403", "1103403100", "story_v_side_new_1103403.awb")

						arg_384_1:RecordAudio("1103403100", var_387_10)
						arg_384_1:RecordAudio("1103403100", var_387_10)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403100", "story_v_side_new_1103403.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403100", "story_v_side_new_1103403.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_11 = math.max(var_387_2, arg_384_1.talkMaxDuration)

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_11 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_1) / var_387_11

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_1 + var_387_11 and arg_384_1.time_ < var_387_1 + var_387_11 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1103403105 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1103403105
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1103403106(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1034ui_story"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1034ui_story == nil then
				arg_388_1.var_.characterEffect1034ui_story = var_391_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.characterEffect1034ui_story and not isNil(var_391_0) then
					local var_391_4 = Mathf.Lerp(0, 0.5, var_391_3)

					arg_388_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1034ui_story.fillRatio = var_391_4
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1034ui_story then
				local var_391_5 = 0.5

				arg_388_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1034ui_story.fillRatio = var_391_5
			end

			local var_391_6 = 0

			if var_391_6 < arg_388_1.time_ and arg_388_1.time_ <= var_391_6 + arg_391_0 then
				arg_388_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_391_7 = 0

			if var_391_7 < arg_388_1.time_ and arg_388_1.time_ <= var_391_7 + arg_391_0 then
				arg_388_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_391_8 = 0.200000002980232
			local var_391_9 = 1

			if var_391_8 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				local var_391_10 = "play"
				local var_391_11 = "effect"

				arg_388_1:AudioAction(var_391_10, var_391_11, "se_story_16", "se_story_16_foot", "")
			end

			local var_391_12 = 0
			local var_391_13 = 0.625

			if var_391_12 < arg_388_1.time_ and arg_388_1.time_ <= var_391_12 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_14 = arg_388_1:GetWordFromCfg(1103403105)
				local var_391_15 = arg_388_1:FormatText(var_391_14.content)

				arg_388_1.text_.text = var_391_15

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_16 = 25
				local var_391_17 = utf8.len(var_391_15)
				local var_391_18 = var_391_16 <= 0 and var_391_13 or var_391_13 * (var_391_17 / var_391_16)

				if var_391_18 > 0 and var_391_13 < var_391_18 then
					arg_388_1.talkMaxDuration = var_391_18

					if var_391_18 + var_391_12 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_18 + var_391_12
					end
				end

				arg_388_1.text_.text = var_391_15
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_19 = math.max(var_391_13, arg_388_1.talkMaxDuration)

			if var_391_12 <= arg_388_1.time_ and arg_388_1.time_ < var_391_12 + var_391_19 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_12) / var_391_19

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_12 + var_391_19 and arg_388_1.time_ < var_391_12 + var_391_19 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play1103403106 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1103403106
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1103403107(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0
			local var_395_1 = 1.025

			if var_395_0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, false)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_2 = arg_392_1:GetWordFromCfg(1103403106)
				local var_395_3 = arg_392_1:FormatText(var_395_2.content)

				arg_392_1.text_.text = var_395_3

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_4 = 41
				local var_395_5 = utf8.len(var_395_3)
				local var_395_6 = var_395_4 <= 0 and var_395_1 or var_395_1 * (var_395_5 / var_395_4)

				if var_395_6 > 0 and var_395_1 < var_395_6 then
					arg_392_1.talkMaxDuration = var_395_6

					if var_395_6 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_6 + var_395_0
					end
				end

				arg_392_1.text_.text = var_395_3
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_7 = math.max(var_395_1, arg_392_1.talkMaxDuration)

			if var_395_0 <= arg_392_1.time_ and arg_392_1.time_ < var_395_0 + var_395_7 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_0) / var_395_7

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_0 + var_395_7 and arg_392_1.time_ < var_395_0 + var_395_7 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play1103403107 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1103403107
		arg_396_1.duration_ = 3.7

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
			arg_396_1.auto_ = false
		end

		function arg_396_1.playNext_(arg_398_0)
			arg_396_1.onStoryFinished_()
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1034ui_story"]
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect1034ui_story == nil then
				arg_396_1.var_.characterEffect1034ui_story = var_399_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_2 = 0.200000002980232

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 and not isNil(var_399_0) then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2

				if arg_396_1.var_.characterEffect1034ui_story and not isNil(var_399_0) then
					arg_396_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect1034ui_story then
				arg_396_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_399_4 = 0

			if var_399_4 < arg_396_1.time_ and arg_396_1.time_ <= var_399_4 + arg_399_0 then
				arg_396_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_399_5 = 0
			local var_399_6 = 0.225

			if var_399_5 < arg_396_1.time_ and arg_396_1.time_ <= var_399_5 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_7 = arg_396_1:FormatText(StoryNameCfg[1109].name)

				arg_396_1.leftNameTxt_.text = var_399_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_8 = arg_396_1:GetWordFromCfg(1103403107)
				local var_399_9 = arg_396_1:FormatText(var_399_8.content)

				arg_396_1.text_.text = var_399_9

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_10 = 9
				local var_399_11 = utf8.len(var_399_9)
				local var_399_12 = var_399_10 <= 0 and var_399_6 or var_399_6 * (var_399_11 / var_399_10)

				if var_399_12 > 0 and var_399_6 < var_399_12 then
					arg_396_1.talkMaxDuration = var_399_12

					if var_399_12 + var_399_5 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_12 + var_399_5
					end
				end

				arg_396_1.text_.text = var_399_9
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403107", "story_v_side_new_1103403.awb") ~= 0 then
					local var_399_13 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403107", "story_v_side_new_1103403.awb") / 1000

					if var_399_13 + var_399_5 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_13 + var_399_5
					end

					if var_399_8.prefab_name ~= "" and arg_396_1.actors_[var_399_8.prefab_name] ~= nil then
						local var_399_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_8.prefab_name].transform, "story_v_side_new_1103403", "1103403107", "story_v_side_new_1103403.awb")

						arg_396_1:RecordAudio("1103403107", var_399_14)
						arg_396_1:RecordAudio("1103403107", var_399_14)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403107", "story_v_side_new_1103403.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403107", "story_v_side_new_1103403.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_15 = math.max(var_399_6, arg_396_1.talkMaxDuration)

			if var_399_5 <= arg_396_1.time_ and arg_396_1.time_ < var_399_5 + var_399_15 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_5) / var_399_15

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_5 + var_399_15 and arg_396_1.time_ < var_399_5 + var_399_15 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play1103403101 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1103403101
		arg_400_1.duration_ = 4.37

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1103403102(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = "1034ui_story"

			if arg_400_1.actors_[var_403_0] == nil then
				local var_403_1 = Asset.Load("Char/" .. "1034ui_story")

				if not isNil(var_403_1) then
					local var_403_2 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_400_1.stage_.transform)

					var_403_2.name = var_403_0
					var_403_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_400_1.actors_[var_403_0] = var_403_2

					local var_403_3 = var_403_2:GetComponentInChildren(typeof(CharacterEffect))

					var_403_3.enabled = true

					local var_403_4 = GameObjectTools.GetOrAddComponent(var_403_2, typeof(DynamicBoneHelper))

					if var_403_4 then
						var_403_4:EnableDynamicBone(false)
					end

					arg_400_1:ShowWeapon(var_403_3.transform, false)

					arg_400_1.var_[var_403_0 .. "Animator"] = var_403_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_400_1.var_[var_403_0 .. "Animator"].applyRootMotion = true
					arg_400_1.var_[var_403_0 .. "LipSync"] = var_403_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_403_5 = 0

			if var_403_5 < arg_400_1.time_ and arg_400_1.time_ <= var_403_5 + arg_403_0 then
				arg_400_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_403_6 = "1034ui_story"

			if arg_400_1.actors_[var_403_6] == nil then
				local var_403_7 = Asset.Load("Char/" .. "1034ui_story")

				if not isNil(var_403_7) then
					local var_403_8 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_400_1.stage_.transform)

					var_403_8.name = var_403_6
					var_403_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_400_1.actors_[var_403_6] = var_403_8

					local var_403_9 = var_403_8:GetComponentInChildren(typeof(CharacterEffect))

					var_403_9.enabled = true

					local var_403_10 = GameObjectTools.GetOrAddComponent(var_403_8, typeof(DynamicBoneHelper))

					if var_403_10 then
						var_403_10:EnableDynamicBone(false)
					end

					arg_400_1:ShowWeapon(var_403_9.transform, false)

					arg_400_1.var_[var_403_6 .. "Animator"] = var_403_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_400_1.var_[var_403_6 .. "Animator"].applyRootMotion = true
					arg_400_1.var_[var_403_6 .. "LipSync"] = var_403_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_403_11 = 0

			if var_403_11 < arg_400_1.time_ and arg_400_1.time_ <= var_403_11 + arg_403_0 then
				arg_400_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_403_12 = arg_400_1.actors_["1034ui_story"]
			local var_403_13 = 0

			if var_403_13 < arg_400_1.time_ and arg_400_1.time_ <= var_403_13 + arg_403_0 and not isNil(var_403_12) and arg_400_1.var_.characterEffect1034ui_story == nil then
				arg_400_1.var_.characterEffect1034ui_story = var_403_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_14 = 0.200000002980232

			if var_403_13 <= arg_400_1.time_ and arg_400_1.time_ < var_403_13 + var_403_14 and not isNil(var_403_12) then
				local var_403_15 = (arg_400_1.time_ - var_403_13) / var_403_14

				if arg_400_1.var_.characterEffect1034ui_story and not isNil(var_403_12) then
					arg_400_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= var_403_13 + var_403_14 and arg_400_1.time_ < var_403_13 + var_403_14 + arg_403_0 and not isNil(var_403_12) and arg_400_1.var_.characterEffect1034ui_story then
				arg_400_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_403_16 = 0
			local var_403_17 = 0.45

			if var_403_16 < arg_400_1.time_ and arg_400_1.time_ <= var_403_16 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_18 = arg_400_1:FormatText(StoryNameCfg[1109].name)

				arg_400_1.leftNameTxt_.text = var_403_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_19 = arg_400_1:GetWordFromCfg(1103403101)
				local var_403_20 = arg_400_1:FormatText(var_403_19.content)

				arg_400_1.text_.text = var_403_20

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_21 = 18
				local var_403_22 = utf8.len(var_403_20)
				local var_403_23 = var_403_21 <= 0 and var_403_17 or var_403_17 * (var_403_22 / var_403_21)

				if var_403_23 > 0 and var_403_17 < var_403_23 then
					arg_400_1.talkMaxDuration = var_403_23

					if var_403_23 + var_403_16 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_23 + var_403_16
					end
				end

				arg_400_1.text_.text = var_403_20
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403101", "story_v_side_new_1103403.awb") ~= 0 then
					local var_403_24 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403101", "story_v_side_new_1103403.awb") / 1000

					if var_403_24 + var_403_16 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_24 + var_403_16
					end

					if var_403_19.prefab_name ~= "" and arg_400_1.actors_[var_403_19.prefab_name] ~= nil then
						local var_403_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_19.prefab_name].transform, "story_v_side_new_1103403", "1103403101", "story_v_side_new_1103403.awb")

						arg_400_1:RecordAudio("1103403101", var_403_25)
						arg_400_1:RecordAudio("1103403101", var_403_25)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403101", "story_v_side_new_1103403.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403101", "story_v_side_new_1103403.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_26 = math.max(var_403_17, arg_400_1.talkMaxDuration)

			if var_403_16 <= arg_400_1.time_ and arg_400_1.time_ < var_403_16 + var_403_26 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_16) / var_403_26

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_16 + var_403_26 and arg_400_1.time_ < var_403_16 + var_403_26 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play1103403102 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1103403102
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1103403103(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1034ui_story"]
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect1034ui_story == nil then
				arg_404_1.var_.characterEffect1034ui_story = var_407_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 and not isNil(var_407_0) then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2

				if arg_404_1.var_.characterEffect1034ui_story and not isNil(var_407_0) then
					local var_407_4 = Mathf.Lerp(0, 0.5, var_407_3)

					arg_404_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1034ui_story.fillRatio = var_407_4
				end
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect1034ui_story then
				local var_407_5 = 0.5

				arg_404_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1034ui_story.fillRatio = var_407_5
			end

			local var_407_6 = 0
			local var_407_7 = 0.6

			if var_407_6 < arg_404_1.time_ and arg_404_1.time_ <= var_407_6 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_8 = arg_404_1:FormatText(StoryNameCfg[7].name)

				arg_404_1.leftNameTxt_.text = var_407_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_9 = arg_404_1:GetWordFromCfg(1103403102)
				local var_407_10 = arg_404_1:FormatText(var_407_9.content)

				arg_404_1.text_.text = var_407_10

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_11 = 24
				local var_407_12 = utf8.len(var_407_10)
				local var_407_13 = var_407_11 <= 0 and var_407_7 or var_407_7 * (var_407_12 / var_407_11)

				if var_407_13 > 0 and var_407_7 < var_407_13 then
					arg_404_1.talkMaxDuration = var_407_13

					if var_407_13 + var_407_6 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_13 + var_407_6
					end
				end

				arg_404_1.text_.text = var_407_10
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_14 = math.max(var_407_7, arg_404_1.talkMaxDuration)

			if var_407_6 <= arg_404_1.time_ and arg_404_1.time_ < var_407_6 + var_407_14 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_6) / var_407_14

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_6 + var_407_14 and arg_404_1.time_ < var_407_6 + var_407_14 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play1103403103 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1103403103
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1103403104(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.575

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

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_3 = arg_408_1:GetWordFromCfg(1103403103)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 23
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
	Play1103403104 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1103403104
		arg_412_1.duration_ = 6.93

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1103403105(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["1034ui_story"]
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.characterEffect1034ui_story == nil then
				arg_412_1.var_.characterEffect1034ui_story = var_415_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_2 = 0.200000002980232

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 and not isNil(var_415_0) then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2

				if arg_412_1.var_.characterEffect1034ui_story and not isNil(var_415_0) then
					arg_412_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.characterEffect1034ui_story then
				arg_412_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_415_4 = 0

			if var_415_4 < arg_412_1.time_ and arg_412_1.time_ <= var_415_4 + arg_415_0 then
				arg_412_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_415_5 = 0
			local var_415_6 = 0.9

			if var_415_5 < arg_412_1.time_ and arg_412_1.time_ <= var_415_5 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_7 = arg_412_1:FormatText(StoryNameCfg[1109].name)

				arg_412_1.leftNameTxt_.text = var_415_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_8 = arg_412_1:GetWordFromCfg(1103403104)
				local var_415_9 = arg_412_1:FormatText(var_415_8.content)

				arg_412_1.text_.text = var_415_9

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_10 = 36
				local var_415_11 = utf8.len(var_415_9)
				local var_415_12 = var_415_10 <= 0 and var_415_6 or var_415_6 * (var_415_11 / var_415_10)

				if var_415_12 > 0 and var_415_6 < var_415_12 then
					arg_412_1.talkMaxDuration = var_415_12

					if var_415_12 + var_415_5 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_12 + var_415_5
					end
				end

				arg_412_1.text_.text = var_415_9
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403104", "story_v_side_new_1103403.awb") ~= 0 then
					local var_415_13 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403104", "story_v_side_new_1103403.awb") / 1000

					if var_415_13 + var_415_5 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_13 + var_415_5
					end

					if var_415_8.prefab_name ~= "" and arg_412_1.actors_[var_415_8.prefab_name] ~= nil then
						local var_415_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_8.prefab_name].transform, "story_v_side_new_1103403", "1103403104", "story_v_side_new_1103403.awb")

						arg_412_1:RecordAudio("1103403104", var_415_14)
						arg_412_1:RecordAudio("1103403104", var_415_14)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403104", "story_v_side_new_1103403.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403104", "story_v_side_new_1103403.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_15 = math.max(var_415_6, arg_412_1.talkMaxDuration)

			if var_415_5 <= arg_412_1.time_ and arg_412_1.time_ < var_415_5 + var_415_15 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_5) / var_415_15

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_5 + var_415_15 and arg_412_1.time_ < var_415_5 + var_415_15 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play1103403060 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1103403060
		arg_416_1.duration_ = 3.13

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1103403061(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = "1034ui_story"

			if arg_416_1.actors_[var_419_0] == nil then
				local var_419_1 = Asset.Load("Char/" .. "1034ui_story")

				if not isNil(var_419_1) then
					local var_419_2 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_416_1.stage_.transform)

					var_419_2.name = var_419_0
					var_419_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_416_1.actors_[var_419_0] = var_419_2

					local var_419_3 = var_419_2:GetComponentInChildren(typeof(CharacterEffect))

					var_419_3.enabled = true

					local var_419_4 = GameObjectTools.GetOrAddComponent(var_419_2, typeof(DynamicBoneHelper))

					if var_419_4 then
						var_419_4:EnableDynamicBone(false)
					end

					arg_416_1:ShowWeapon(var_419_3.transform, false)

					arg_416_1.var_[var_419_0 .. "Animator"] = var_419_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_416_1.var_[var_419_0 .. "Animator"].applyRootMotion = true
					arg_416_1.var_[var_419_0 .. "LipSync"] = var_419_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_419_5 = 0

			if var_419_5 < arg_416_1.time_ and arg_416_1.time_ <= var_419_5 + arg_419_0 then
				arg_416_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_419_6 = arg_416_1.actors_["1034ui_story"]
			local var_419_7 = 0

			if var_419_7 < arg_416_1.time_ and arg_416_1.time_ <= var_419_7 + arg_419_0 and not isNil(var_419_6) and arg_416_1.var_.characterEffect1034ui_story == nil then
				arg_416_1.var_.characterEffect1034ui_story = var_419_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_8 = 0.200000002980232

			if var_419_7 <= arg_416_1.time_ and arg_416_1.time_ < var_419_7 + var_419_8 and not isNil(var_419_6) then
				local var_419_9 = (arg_416_1.time_ - var_419_7) / var_419_8

				if arg_416_1.var_.characterEffect1034ui_story and not isNil(var_419_6) then
					arg_416_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= var_419_7 + var_419_8 and arg_416_1.time_ < var_419_7 + var_419_8 + arg_419_0 and not isNil(var_419_6) and arg_416_1.var_.characterEffect1034ui_story then
				arg_416_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_419_10 = 0
			local var_419_11 = 0.35

			if var_419_10 < arg_416_1.time_ and arg_416_1.time_ <= var_419_10 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_12 = arg_416_1:FormatText(StoryNameCfg[1109].name)

				arg_416_1.leftNameTxt_.text = var_419_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_13 = arg_416_1:GetWordFromCfg(1103403060)
				local var_419_14 = arg_416_1:FormatText(var_419_13.content)

				arg_416_1.text_.text = var_419_14

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_15 = 14
				local var_419_16 = utf8.len(var_419_14)
				local var_419_17 = var_419_15 <= 0 and var_419_11 or var_419_11 * (var_419_16 / var_419_15)

				if var_419_17 > 0 and var_419_11 < var_419_17 then
					arg_416_1.talkMaxDuration = var_419_17

					if var_419_17 + var_419_10 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_17 + var_419_10
					end
				end

				arg_416_1.text_.text = var_419_14
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403060", "story_v_side_new_1103403.awb") ~= 0 then
					local var_419_18 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403060", "story_v_side_new_1103403.awb") / 1000

					if var_419_18 + var_419_10 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_18 + var_419_10
					end

					if var_419_13.prefab_name ~= "" and arg_416_1.actors_[var_419_13.prefab_name] ~= nil then
						local var_419_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_13.prefab_name].transform, "story_v_side_new_1103403", "1103403060", "story_v_side_new_1103403.awb")

						arg_416_1:RecordAudio("1103403060", var_419_19)
						arg_416_1:RecordAudio("1103403060", var_419_19)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403060", "story_v_side_new_1103403.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403060", "story_v_side_new_1103403.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_20 = math.max(var_419_11, arg_416_1.talkMaxDuration)

			if var_419_10 <= arg_416_1.time_ and arg_416_1.time_ < var_419_10 + var_419_20 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_10) / var_419_20

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_10 + var_419_20 and arg_416_1.time_ < var_419_10 + var_419_20 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1103403061 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1103403061
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1103403062(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["1034ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1034ui_story == nil then
				arg_420_1.var_.characterEffect1034ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect1034ui_story and not isNil(var_423_0) then
					local var_423_4 = Mathf.Lerp(0, 0.5, var_423_3)

					arg_420_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_420_1.var_.characterEffect1034ui_story.fillRatio = var_423_4
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1034ui_story then
				local var_423_5 = 0.5

				arg_420_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_420_1.var_.characterEffect1034ui_story.fillRatio = var_423_5
			end

			local var_423_6 = 0
			local var_423_7 = 0.7

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

				local var_423_9 = arg_420_1:GetWordFromCfg(1103403061)
				local var_423_10 = arg_420_1:FormatText(var_423_9.content)

				arg_420_1.text_.text = var_423_10

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_11 = 28
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
	Play1103403062 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1103403062
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1103403063(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0

			if var_427_0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_427_1 = 0
			local var_427_2 = 0.7

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_3 = arg_424_1:FormatText(StoryNameCfg[7].name)

				arg_424_1.leftNameTxt_.text = var_427_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_4 = arg_424_1:GetWordFromCfg(1103403062)
				local var_427_5 = arg_424_1:FormatText(var_427_4.content)

				arg_424_1.text_.text = var_427_5

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_6 = 28
				local var_427_7 = utf8.len(var_427_5)
				local var_427_8 = var_427_6 <= 0 and var_427_2 or var_427_2 * (var_427_7 / var_427_6)

				if var_427_8 > 0 and var_427_2 < var_427_8 then
					arg_424_1.talkMaxDuration = var_427_8

					if var_427_8 + var_427_1 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_8 + var_427_1
					end
				end

				arg_424_1.text_.text = var_427_5
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_9 = math.max(var_427_2, arg_424_1.talkMaxDuration)

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_9 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_1) / var_427_9

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_1 + var_427_9 and arg_424_1.time_ < var_427_1 + var_427_9 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1103403063 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1103403063
		arg_428_1.duration_ = 3.3

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1103403064(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["1034ui_story"]
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect1034ui_story == nil then
				arg_428_1.var_.characterEffect1034ui_story = var_431_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.200000002980232

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 and not isNil(var_431_0) then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2

				if arg_428_1.var_.characterEffect1034ui_story and not isNil(var_431_0) then
					arg_428_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect1034ui_story then
				arg_428_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_431_4 = 0

			if var_431_4 < arg_428_1.time_ and arg_428_1.time_ <= var_431_4 + arg_431_0 then
				arg_428_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			local var_431_5 = 0

			if var_431_5 < arg_428_1.time_ and arg_428_1.time_ <= var_431_5 + arg_431_0 then
				arg_428_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_431_6 = 0
			local var_431_7 = 0.325

			if var_431_6 < arg_428_1.time_ and arg_428_1.time_ <= var_431_6 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_8 = arg_428_1:FormatText(StoryNameCfg[1109].name)

				arg_428_1.leftNameTxt_.text = var_431_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_9 = arg_428_1:GetWordFromCfg(1103403063)
				local var_431_10 = arg_428_1:FormatText(var_431_9.content)

				arg_428_1.text_.text = var_431_10

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_11 = 13
				local var_431_12 = utf8.len(var_431_10)
				local var_431_13 = var_431_11 <= 0 and var_431_7 or var_431_7 * (var_431_12 / var_431_11)

				if var_431_13 > 0 and var_431_7 < var_431_13 then
					arg_428_1.talkMaxDuration = var_431_13

					if var_431_13 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_13 + var_431_6
					end
				end

				arg_428_1.text_.text = var_431_10
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403063", "story_v_side_new_1103403.awb") ~= 0 then
					local var_431_14 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403063", "story_v_side_new_1103403.awb") / 1000

					if var_431_14 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_14 + var_431_6
					end

					if var_431_9.prefab_name ~= "" and arg_428_1.actors_[var_431_9.prefab_name] ~= nil then
						local var_431_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_9.prefab_name].transform, "story_v_side_new_1103403", "1103403063", "story_v_side_new_1103403.awb")

						arg_428_1:RecordAudio("1103403063", var_431_15)
						arg_428_1:RecordAudio("1103403063", var_431_15)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403063", "story_v_side_new_1103403.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403063", "story_v_side_new_1103403.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_16 = math.max(var_431_7, arg_428_1.talkMaxDuration)

			if var_431_6 <= arg_428_1.time_ and arg_428_1.time_ < var_431_6 + var_431_16 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_6) / var_431_16

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_6 + var_431_16 and arg_428_1.time_ < var_431_6 + var_431_16 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play1103403018 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1103403018
		arg_432_1.duration_ = 4.67

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1103403019(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["1034ui_story"]
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect1034ui_story == nil then
				arg_432_1.var_.characterEffect1034ui_story = var_435_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_2 = 0.200000002980232

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 and not isNil(var_435_0) then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2

				if arg_432_1.var_.characterEffect1034ui_story and not isNil(var_435_0) then
					arg_432_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect1034ui_story then
				arg_432_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_435_4 = "1034ui_story"

			if arg_432_1.actors_[var_435_4] == nil then
				local var_435_5 = Asset.Load("Char/" .. "1034ui_story")

				if not isNil(var_435_5) then
					local var_435_6 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_432_1.stage_.transform)

					var_435_6.name = var_435_4
					var_435_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_432_1.actors_[var_435_4] = var_435_6

					local var_435_7 = var_435_6:GetComponentInChildren(typeof(CharacterEffect))

					var_435_7.enabled = true

					local var_435_8 = GameObjectTools.GetOrAddComponent(var_435_6, typeof(DynamicBoneHelper))

					if var_435_8 then
						var_435_8:EnableDynamicBone(false)
					end

					arg_432_1:ShowWeapon(var_435_7.transform, false)

					arg_432_1.var_[var_435_4 .. "Animator"] = var_435_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_432_1.var_[var_435_4 .. "Animator"].applyRootMotion = true
					arg_432_1.var_[var_435_4 .. "LipSync"] = var_435_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_435_9 = 0

			if var_435_9 < arg_432_1.time_ and arg_432_1.time_ <= var_435_9 + arg_435_0 then
				arg_432_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action426")
			end

			local var_435_10 = "1034ui_story"

			if arg_432_1.actors_[var_435_10] == nil then
				local var_435_11 = Asset.Load("Char/" .. "1034ui_story")

				if not isNil(var_435_11) then
					local var_435_12 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_432_1.stage_.transform)

					var_435_12.name = var_435_10
					var_435_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_432_1.actors_[var_435_10] = var_435_12

					local var_435_13 = var_435_12:GetComponentInChildren(typeof(CharacterEffect))

					var_435_13.enabled = true

					local var_435_14 = GameObjectTools.GetOrAddComponent(var_435_12, typeof(DynamicBoneHelper))

					if var_435_14 then
						var_435_14:EnableDynamicBone(false)
					end

					arg_432_1:ShowWeapon(var_435_13.transform, false)

					arg_432_1.var_[var_435_10 .. "Animator"] = var_435_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_432_1.var_[var_435_10 .. "Animator"].applyRootMotion = true
					arg_432_1.var_[var_435_10 .. "LipSync"] = var_435_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_435_15 = 0

			if var_435_15 < arg_432_1.time_ and arg_432_1.time_ <= var_435_15 + arg_435_0 then
				arg_432_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_435_16 = 0
			local var_435_17 = 0.45

			if var_435_16 < arg_432_1.time_ and arg_432_1.time_ <= var_435_16 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_18 = arg_432_1:FormatText(StoryNameCfg[1109].name)

				arg_432_1.leftNameTxt_.text = var_435_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_19 = arg_432_1:GetWordFromCfg(1103403018)
				local var_435_20 = arg_432_1:FormatText(var_435_19.content)

				arg_432_1.text_.text = var_435_20

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_21 = 18
				local var_435_22 = utf8.len(var_435_20)
				local var_435_23 = var_435_21 <= 0 and var_435_17 or var_435_17 * (var_435_22 / var_435_21)

				if var_435_23 > 0 and var_435_17 < var_435_23 then
					arg_432_1.talkMaxDuration = var_435_23

					if var_435_23 + var_435_16 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_23 + var_435_16
					end
				end

				arg_432_1.text_.text = var_435_20
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403018", "story_v_side_new_1103403.awb") ~= 0 then
					local var_435_24 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403018", "story_v_side_new_1103403.awb") / 1000

					if var_435_24 + var_435_16 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_24 + var_435_16
					end

					if var_435_19.prefab_name ~= "" and arg_432_1.actors_[var_435_19.prefab_name] ~= nil then
						local var_435_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_19.prefab_name].transform, "story_v_side_new_1103403", "1103403018", "story_v_side_new_1103403.awb")

						arg_432_1:RecordAudio("1103403018", var_435_25)
						arg_432_1:RecordAudio("1103403018", var_435_25)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403018", "story_v_side_new_1103403.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403018", "story_v_side_new_1103403.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_26 = math.max(var_435_17, arg_432_1.talkMaxDuration)

			if var_435_16 <= arg_432_1.time_ and arg_432_1.time_ < var_435_16 + var_435_26 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_16) / var_435_26

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_16 + var_435_26 and arg_432_1.time_ < var_435_16 + var_435_26 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1103403019 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1103403019
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1103403020(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["1034ui_story"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect1034ui_story == nil then
				arg_436_1.var_.characterEffect1034ui_story = var_439_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.200000002980232

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.characterEffect1034ui_story and not isNil(var_439_0) then
					local var_439_4 = Mathf.Lerp(0, 0.5, var_439_3)

					arg_436_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_436_1.var_.characterEffect1034ui_story.fillRatio = var_439_4
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect1034ui_story then
				local var_439_5 = 0.5

				arg_436_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_436_1.var_.characterEffect1034ui_story.fillRatio = var_439_5
			end

			local var_439_6 = 0

			if var_439_6 < arg_436_1.time_ and arg_436_1.time_ <= var_439_6 + arg_439_0 then
				arg_436_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_439_7 = 0
			local var_439_8 = 0.825

			if var_439_7 < arg_436_1.time_ and arg_436_1.time_ <= var_439_7 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_9 = arg_436_1:GetWordFromCfg(1103403019)
				local var_439_10 = arg_436_1:FormatText(var_439_9.content)

				arg_436_1.text_.text = var_439_10

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_11 = 33
				local var_439_12 = utf8.len(var_439_10)
				local var_439_13 = var_439_11 <= 0 and var_439_8 or var_439_8 * (var_439_12 / var_439_11)

				if var_439_13 > 0 and var_439_8 < var_439_13 then
					arg_436_1.talkMaxDuration = var_439_13

					if var_439_13 + var_439_7 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_13 + var_439_7
					end
				end

				arg_436_1.text_.text = var_439_10
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_14 = math.max(var_439_8, arg_436_1.talkMaxDuration)

			if var_439_7 <= arg_436_1.time_ and arg_436_1.time_ < var_439_7 + var_439_14 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_7) / var_439_14

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_7 + var_439_14 and arg_436_1.time_ < var_439_7 + var_439_14 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/I05a"
	},
	voices = {
		"story_v_side_new_1103403.awb"
	}
}
