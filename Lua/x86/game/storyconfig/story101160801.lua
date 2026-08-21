return {
	Play116081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116081001
		arg_1_1.duration_ = 8.9

		local var_1_0 = {
			zh = 8.9,
			ja = 8.033
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
				arg_1_0:Play116081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "A00"

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
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.A00

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
					if iter_4_0 ~= "A00" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = "1029ui_story"

			if arg_1_1.actors_[var_4_16] == nil then
				local var_4_17 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_4_17) then
					local var_4_18 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_1_1.stage_.transform)

					var_4_18.name = var_4_16
					var_4_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_16] = var_4_18

					local var_4_19 = var_4_18:GetComponentInChildren(typeof(CharacterEffect))

					var_4_19.enabled = true

					local var_4_20 = GameObjectTools.GetOrAddComponent(var_4_18, typeof(DynamicBoneHelper))

					if var_4_20 then
						var_4_20:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_19.transform, false)

					arg_1_1.var_[var_4_16 .. "Animator"] = var_4_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_16 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_16 .. "LipSync"] = var_4_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_21 = 1.8

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_4_22 = 1.8

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_4_23 = arg_1_1.actors_["1029ui_story"]
			local var_4_24 = 1.8

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 and not isNil(var_4_23) and arg_1_1.var_.characterEffect1029ui_story == nil then
				arg_1_1.var_.characterEffect1029ui_story = var_4_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_25 = 0.2

			if var_4_24 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 and not isNil(var_4_23) then
				local var_4_26 = (arg_1_1.time_ - var_4_24) / var_4_25

				if arg_1_1.var_.characterEffect1029ui_story and not isNil(var_4_23) then
					arg_1_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 and not isNil(var_4_23) and arg_1_1.var_.characterEffect1029ui_story then
				arg_1_1.var_.characterEffect1029ui_story.fillFlat = false
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

			local var_4_36 = 0

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_37 = 2

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37
				local var_4_39 = Color.New(0, 0, 0)

				var_4_39.a = Mathf.Lerp(1, 0, var_4_38)
				arg_1_1.mask_.color = var_4_39
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				local var_4_40 = Color.New(0, 0, 0)
				local var_4_41 = 0

				arg_1_1.mask_.enabled = false
				var_4_40.a = var_4_41
				arg_1_1.mask_.color = var_4_40
			end

			local var_4_42 = 0
			local var_4_43 = 1

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "music"

				arg_1_1:AudioAction(var_4_44, var_4_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_46 = ""
				local var_4_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_47 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_47 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_47

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_47
						arg_1_1.bgmTxt2_.text = var_4_47
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

			local var_4_48 = 2
			local var_4_49 = 0.733333333333333

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_4_53 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_53 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_53

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_53
						arg_1_1.bgmTxt2_.text = var_4_53
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

			local var_4_54 = 2
			local var_4_55 = 0.725

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_56 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_56:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[319].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(116081001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 29
				local var_4_61 = utf8.len(var_4_59)
				local var_4_62 = var_4_60 <= 0 and var_4_55 or var_4_55 * (var_4_61 / var_4_60)

				if var_4_62 > 0 and var_4_55 < var_4_62 then
					arg_1_1.talkMaxDuration = var_4_62
					var_4_54 = var_4_54 + 0.3

					if var_4_62 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_59
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081001", "story_v_out_116081.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_116081", "116081001", "story_v_out_116081.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_116081", "116081001", "story_v_out_116081.awb")

						arg_1_1:RecordAudio("116081001", var_4_64)
						arg_1_1:RecordAudio("116081001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116081", "116081001", "story_v_out_116081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116081", "116081001", "story_v_out_116081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_65 = var_4_54 + 0.3
			local var_4_66 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_65 <= arg_1_1.time_ and arg_1_1.time_ < var_4_65 + var_4_66 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_65) / var_4_66

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_65 + var_4_66 and arg_1_1.time_ < var_4_65 + var_4_66 + arg_4_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play116081002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116081002
		arg_9_1.duration_ = 0.02

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"

			SetActive(arg_9_1.choicesGo_, true)

			for iter_10_0, iter_10_1 in ipairs(arg_9_1.choices_) do
				local var_10_0 = iter_10_0 <= 2

				SetActive(iter_10_1.go, var_10_0)
			end

			arg_9_1.choices_[1].txt.text = arg_9_1:FormatText(StoryChoiceCfg[242].name)
			arg_9_1.choices_[2].txt.text = arg_9_1:FormatText(StoryChoiceCfg[243].name)
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play116081003(arg_9_1)
			end

			if arg_11_0 == 2 then
				arg_9_0:Play116081003(arg_9_1)
			end

			arg_9_1:RecordChoiceLog(116081002, 242, 243)
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			return
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play116081003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116081003
		arg_13_1.duration_ = 9.63

		local var_13_0 = {
			zh = 7.3,
			ja = 9.633
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
				arg_13_0:Play116081004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1029ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_13_1.stage_.transform)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

					var_16_3.enabled = true

					local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

					if var_16_4 then
						var_16_4:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_3.transform, false)

					arg_13_1.var_[var_16_0 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_0 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_0 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_16_6 = 0
			local var_16_7 = 0.75

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_8 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_8:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_9 = arg_13_1:FormatText(StoryNameCfg[319].name)

				arg_13_1.leftNameTxt_.text = var_16_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(116081003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_12 = 30
				local var_16_13 = utf8.len(var_16_11)
				local var_16_14 = var_16_12 <= 0 and var_16_7 or var_16_7 * (var_16_13 / var_16_12)

				if var_16_14 > 0 and var_16_7 < var_16_14 then
					arg_13_1.talkMaxDuration = var_16_14
					var_16_6 = var_16_6 + 0.3

					if var_16_14 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081003", "story_v_out_116081.awb") ~= 0 then
					local var_16_15 = manager.audio:GetVoiceLength("story_v_out_116081", "116081003", "story_v_out_116081.awb") / 1000

					if var_16_15 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_6
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_116081", "116081003", "story_v_out_116081.awb")

						arg_13_1:RecordAudio("116081003", var_16_16)
						arg_13_1:RecordAudio("116081003", var_16_16)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_116081", "116081003", "story_v_out_116081.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_116081", "116081003", "story_v_out_116081.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_17 = var_16_6 + 0.3
			local var_16_18 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_17 <= arg_13_1.time_ and arg_13_1.time_ < var_16_17 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_17) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_17 + var_16_18 and arg_13_1.time_ < var_16_17 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play116081004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 116081004
		arg_19_1.duration_ = 8.13

		local var_19_0 = {
			zh = 6.333,
			ja = 8.133
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play116081005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_22_1 = 0
			local var_22_2 = 0.725

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_3 = arg_19_1:FormatText(StoryNameCfg[319].name)

				arg_19_1.leftNameTxt_.text = var_22_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_4 = arg_19_1:GetWordFromCfg(116081004)
				local var_22_5 = arg_19_1:FormatText(var_22_4.content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_6 = 29
				local var_22_7 = utf8.len(var_22_5)
				local var_22_8 = var_22_6 <= 0 and var_22_2 or var_22_2 * (var_22_7 / var_22_6)

				if var_22_8 > 0 and var_22_2 < var_22_8 then
					arg_19_1.talkMaxDuration = var_22_8

					if var_22_8 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_1
					end
				end

				arg_19_1.text_.text = var_22_5
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081004", "story_v_out_116081.awb") ~= 0 then
					local var_22_9 = manager.audio:GetVoiceLength("story_v_out_116081", "116081004", "story_v_out_116081.awb") / 1000

					if var_22_9 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_9 + var_22_1
					end

					if var_22_4.prefab_name ~= "" and arg_19_1.actors_[var_22_4.prefab_name] ~= nil then
						local var_22_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_4.prefab_name].transform, "story_v_out_116081", "116081004", "story_v_out_116081.awb")

						arg_19_1:RecordAudio("116081004", var_22_10)
						arg_19_1:RecordAudio("116081004", var_22_10)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_116081", "116081004", "story_v_out_116081.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_116081", "116081004", "story_v_out_116081.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_11 = math.max(var_22_2, arg_19_1.talkMaxDuration)

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_11 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_1) / var_22_11

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_1 + var_22_11 and arg_19_1.time_ < var_22_1 + var_22_11 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play116081005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 116081005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play116081006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1029ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1029ui_story == nil then
				arg_23_1.var_.characterEffect1029ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.2

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect1029ui_story and not isNil(var_26_0) then
					local var_26_4 = Mathf.Lerp(0, 0.5, var_26_3)

					arg_23_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1029ui_story.fillRatio = var_26_4
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1029ui_story then
				local var_26_5 = 0.5

				arg_23_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1029ui_story.fillRatio = var_26_5
			end

			local var_26_6 = 0
			local var_26_7 = 0.25

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_8 = arg_23_1:FormatText(StoryNameCfg[7].name)

				arg_23_1.leftNameTxt_.text = var_26_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_9 = arg_23_1:GetWordFromCfg(116081005)
				local var_26_10 = arg_23_1:FormatText(var_26_9.content)

				arg_23_1.text_.text = var_26_10

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_11 = 10
				local var_26_12 = utf8.len(var_26_10)
				local var_26_13 = var_26_11 <= 0 and var_26_7 or var_26_7 * (var_26_12 / var_26_11)

				if var_26_13 > 0 and var_26_7 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_6 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_6
					end
				end

				arg_23_1.text_.text = var_26_10
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_14 = math.max(var_26_7, arg_23_1.talkMaxDuration)

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_14 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_6) / var_26_14

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_6 + var_26_14 and arg_23_1.time_ < var_26_6 + var_26_14 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play116081006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 116081006
		arg_27_1.duration_ = 5.7

		local var_27_0 = {
			zh = 5.7,
			ja = 4.366
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play116081007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_30_1 = arg_27_1.actors_["1029ui_story"]
			local var_30_2 = 0

			if var_30_2 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1029ui_story == nil then
				arg_27_1.var_.characterEffect1029ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_3 = 0.2

			if var_30_2 <= arg_27_1.time_ and arg_27_1.time_ < var_30_2 + var_30_3 and not isNil(var_30_1) then
				local var_30_4 = (arg_27_1.time_ - var_30_2) / var_30_3

				if arg_27_1.var_.characterEffect1029ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_2 + var_30_3 and arg_27_1.time_ < var_30_2 + var_30_3 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1029ui_story then
				arg_27_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_30_5 = 0
			local var_30_6 = 0.75

			if var_30_5 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_7 = arg_27_1:FormatText(StoryNameCfg[319].name)

				arg_27_1.leftNameTxt_.text = var_30_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_8 = arg_27_1:GetWordFromCfg(116081006)
				local var_30_9 = arg_27_1:FormatText(var_30_8.content)

				arg_27_1.text_.text = var_30_9

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_10 = 30
				local var_30_11 = utf8.len(var_30_9)
				local var_30_12 = var_30_10 <= 0 and var_30_6 or var_30_6 * (var_30_11 / var_30_10)

				if var_30_12 > 0 and var_30_6 < var_30_12 then
					arg_27_1.talkMaxDuration = var_30_12

					if var_30_12 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_12 + var_30_5
					end
				end

				arg_27_1.text_.text = var_30_9
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081006", "story_v_out_116081.awb") ~= 0 then
					local var_30_13 = manager.audio:GetVoiceLength("story_v_out_116081", "116081006", "story_v_out_116081.awb") / 1000

					if var_30_13 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_5
					end

					if var_30_8.prefab_name ~= "" and arg_27_1.actors_[var_30_8.prefab_name] ~= nil then
						local var_30_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_8.prefab_name].transform, "story_v_out_116081", "116081006", "story_v_out_116081.awb")

						arg_27_1:RecordAudio("116081006", var_30_14)
						arg_27_1:RecordAudio("116081006", var_30_14)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_116081", "116081006", "story_v_out_116081.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_116081", "116081006", "story_v_out_116081.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_15 = math.max(var_30_6, arg_27_1.talkMaxDuration)

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_15 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_5) / var_30_15

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_5 + var_30_15 and arg_27_1.time_ < var_30_5 + var_30_15 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play116081007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 116081007
		arg_31_1.duration_ = 10.13

		local var_31_0 = {
			zh = 4.3,
			ja = 10.133
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play116081008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action446")
			end

			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_34_2 = 0
			local var_34_3 = 0.45

			if var_34_2 < arg_31_1.time_ and arg_31_1.time_ <= var_34_2 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_4 = arg_31_1:FormatText(StoryNameCfg[319].name)

				arg_31_1.leftNameTxt_.text = var_34_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_5 = arg_31_1:GetWordFromCfg(116081007)
				local var_34_6 = arg_31_1:FormatText(var_34_5.content)

				arg_31_1.text_.text = var_34_6

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_7 = 18
				local var_34_8 = utf8.len(var_34_6)
				local var_34_9 = var_34_7 <= 0 and var_34_3 or var_34_3 * (var_34_8 / var_34_7)

				if var_34_9 > 0 and var_34_3 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9

					if var_34_9 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_2
					end
				end

				arg_31_1.text_.text = var_34_6
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081007", "story_v_out_116081.awb") ~= 0 then
					local var_34_10 = manager.audio:GetVoiceLength("story_v_out_116081", "116081007", "story_v_out_116081.awb") / 1000

					if var_34_10 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_2
					end

					if var_34_5.prefab_name ~= "" and arg_31_1.actors_[var_34_5.prefab_name] ~= nil then
						local var_34_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_5.prefab_name].transform, "story_v_out_116081", "116081007", "story_v_out_116081.awb")

						arg_31_1:RecordAudio("116081007", var_34_11)
						arg_31_1:RecordAudio("116081007", var_34_11)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_116081", "116081007", "story_v_out_116081.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_116081", "116081007", "story_v_out_116081.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_12 = math.max(var_34_3, arg_31_1.talkMaxDuration)

			if var_34_2 <= arg_31_1.time_ and arg_31_1.time_ < var_34_2 + var_34_12 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_2) / var_34_12

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_2 + var_34_12 and arg_31_1.time_ < var_34_2 + var_34_12 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play116081008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 116081008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play116081009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1029ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1029ui_story == nil then
				arg_35_1.var_.characterEffect1029ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.2

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect1029ui_story and not isNil(var_38_0) then
					local var_38_4 = Mathf.Lerp(0, 0.5, var_38_3)

					arg_35_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1029ui_story.fillRatio = var_38_4
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1029ui_story then
				local var_38_5 = 0.5

				arg_35_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1029ui_story.fillRatio = var_38_5
			end

			local var_38_6 = 0
			local var_38_7 = 0.15

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_8 = arg_35_1:FormatText(StoryNameCfg[7].name)

				arg_35_1.leftNameTxt_.text = var_38_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_9 = arg_35_1:GetWordFromCfg(116081008)
				local var_38_10 = arg_35_1:FormatText(var_38_9.content)

				arg_35_1.text_.text = var_38_10

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_11 = 6
				local var_38_12 = utf8.len(var_38_10)
				local var_38_13 = var_38_11 <= 0 and var_38_7 or var_38_7 * (var_38_12 / var_38_11)

				if var_38_13 > 0 and var_38_7 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_10
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_14 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_14 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_14

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_14 and arg_35_1.time_ < var_38_6 + var_38_14 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play116081009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 116081009
		arg_39_1.duration_ = 7.27

		local var_39_0 = {
			zh = 7.266,
			ja = 6.2
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play116081010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action6_2")
			end

			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_42_2 = arg_39_1.actors_["1029ui_story"]
			local var_42_3 = 0

			if var_42_3 < arg_39_1.time_ and arg_39_1.time_ <= var_42_3 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.characterEffect1029ui_story == nil then
				arg_39_1.var_.characterEffect1029ui_story = var_42_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_4 = 0.2

			if var_42_3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_3 + var_42_4 and not isNil(var_42_2) then
				local var_42_5 = (arg_39_1.time_ - var_42_3) / var_42_4

				if arg_39_1.var_.characterEffect1029ui_story and not isNil(var_42_2) then
					arg_39_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_3 + var_42_4 and arg_39_1.time_ < var_42_3 + var_42_4 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.characterEffect1029ui_story then
				arg_39_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_42_6 = 0
			local var_42_7 = 0.975

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_8 = arg_39_1:FormatText(StoryNameCfg[319].name)

				arg_39_1.leftNameTxt_.text = var_42_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_9 = arg_39_1:GetWordFromCfg(116081009)
				local var_42_10 = arg_39_1:FormatText(var_42_9.content)

				arg_39_1.text_.text = var_42_10

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_11 = 39
				local var_42_12 = utf8.len(var_42_10)
				local var_42_13 = var_42_11 <= 0 and var_42_7 or var_42_7 * (var_42_12 / var_42_11)

				if var_42_13 > 0 and var_42_7 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_10
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081009", "story_v_out_116081.awb") ~= 0 then
					local var_42_14 = manager.audio:GetVoiceLength("story_v_out_116081", "116081009", "story_v_out_116081.awb") / 1000

					if var_42_14 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_14 + var_42_6
					end

					if var_42_9.prefab_name ~= "" and arg_39_1.actors_[var_42_9.prefab_name] ~= nil then
						local var_42_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_9.prefab_name].transform, "story_v_out_116081", "116081009", "story_v_out_116081.awb")

						arg_39_1:RecordAudio("116081009", var_42_15)
						arg_39_1:RecordAudio("116081009", var_42_15)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_116081", "116081009", "story_v_out_116081.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_116081", "116081009", "story_v_out_116081.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_16 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_16 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_16

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_16 and arg_39_1.time_ < var_42_6 + var_42_16 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play116081010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 116081010
		arg_43_1.duration_ = 9

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play116081011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = "ST18a"

			if arg_43_1.bgs_[var_46_0] == nil then
				local var_46_1 = Object.Instantiate(arg_43_1.paintGo_)

				var_46_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_46_0)
				var_46_1.name = var_46_0
				var_46_1.transform.parent = arg_43_1.stage_.transform
				var_46_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.bgs_[var_46_0] = var_46_1
			end

			local var_46_2 = 2

			if var_46_2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				if arg_43_0.sceneSettingEffect_ then
					arg_43_1.sceneSettingEffect_.enabled = false
				end

				arg_43_1.sceneSettingGo_:SetActive(true)

				local var_46_3 = manager.ui.mainCamera.transform.localPosition
				local var_46_4 = Vector3.New(0, 0, 10) + Vector3.New(var_46_3.x, var_46_3.y, 0)
				local var_46_5 = arg_43_1.bgs_.ST18a

				var_46_5.transform.localPosition = var_46_4
				var_46_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_6 = var_46_5:GetComponent("SpriteRenderer")

				if var_46_6 and var_46_6.sprite then
					local var_46_7 = (var_46_5.transform.localPosition - var_46_3).z
					local var_46_8 = manager.ui.mainCameraCom_
					local var_46_9 = 2 * var_46_7 * Mathf.Tan(var_46_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_46_10 = var_46_9 * var_46_8.aspect
					local var_46_11 = var_46_6.sprite.bounds.size.x
					local var_46_12 = var_46_6.sprite.bounds.size.y
					local var_46_13 = var_46_10 / var_46_11
					local var_46_14 = var_46_9 / var_46_12
					local var_46_15 = var_46_14 < var_46_13 and var_46_13 or var_46_14

					var_46_5.transform.localScale = Vector3.New(var_46_15, var_46_15, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "ST18a" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_16 = arg_43_1.actors_["1029ui_story"].transform
			local var_46_17 = 1.966

			if var_46_17 < arg_43_1.time_ and arg_43_1.time_ <= var_46_17 + arg_46_0 then
				arg_43_1.var_.moveOldPos1029ui_story = var_46_16.localPosition
			end

			local var_46_18 = 0.001

			if var_46_17 <= arg_43_1.time_ and arg_43_1.time_ < var_46_17 + var_46_18 then
				local var_46_19 = (arg_43_1.time_ - var_46_17) / var_46_18
				local var_46_20 = Vector3.New(0, 100, 0)

				var_46_16.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1029ui_story, var_46_20, var_46_19)

				local var_46_21 = manager.ui.mainCamera.transform.position - var_46_16.position

				var_46_16.forward = Vector3.New(var_46_21.x, var_46_21.y, var_46_21.z)

				local var_46_22 = var_46_16.localEulerAngles

				var_46_22.z = 0
				var_46_22.x = 0
				var_46_16.localEulerAngles = var_46_22
			end

			if arg_43_1.time_ >= var_46_17 + var_46_18 and arg_43_1.time_ < var_46_17 + var_46_18 + arg_46_0 then
				var_46_16.localPosition = Vector3.New(0, 100, 0)

				local var_46_23 = manager.ui.mainCamera.transform.position - var_46_16.position

				var_46_16.forward = Vector3.New(var_46_23.x, var_46_23.y, var_46_23.z)

				local var_46_24 = var_46_16.localEulerAngles

				var_46_24.z = 0
				var_46_24.x = 0
				var_46_16.localEulerAngles = var_46_24
			end

			local var_46_25 = 0

			if var_46_25 < arg_43_1.time_ and arg_43_1.time_ <= var_46_25 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_26 = 2

			if var_46_25 <= arg_43_1.time_ and arg_43_1.time_ < var_46_25 + var_46_26 then
				local var_46_27 = (arg_43_1.time_ - var_46_25) / var_46_26
				local var_46_28 = Color.New(0, 0, 0)

				var_46_28.a = Mathf.Lerp(0, 1, var_46_27)
				arg_43_1.mask_.color = var_46_28
			end

			if arg_43_1.time_ >= var_46_25 + var_46_26 and arg_43_1.time_ < var_46_25 + var_46_26 + arg_46_0 then
				local var_46_29 = Color.New(0, 0, 0)

				var_46_29.a = 1
				arg_43_1.mask_.color = var_46_29
			end

			local var_46_30 = 2

			if var_46_30 < arg_43_1.time_ and arg_43_1.time_ <= var_46_30 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_31 = 2

			if var_46_30 <= arg_43_1.time_ and arg_43_1.time_ < var_46_30 + var_46_31 then
				local var_46_32 = (arg_43_1.time_ - var_46_30) / var_46_31
				local var_46_33 = Color.New(0, 0, 0)

				var_46_33.a = Mathf.Lerp(1, 0, var_46_32)
				arg_43_1.mask_.color = var_46_33
			end

			if arg_43_1.time_ >= var_46_30 + var_46_31 and arg_43_1.time_ < var_46_30 + var_46_31 + arg_46_0 then
				local var_46_34 = Color.New(0, 0, 0)
				local var_46_35 = 0

				arg_43_1.mask_.enabled = false
				var_46_34.a = var_46_35
				arg_43_1.mask_.color = var_46_34
			end

			local var_46_36 = "10025ui_story"

			if arg_43_1.actors_[var_46_36] == nil then
				local var_46_37 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_46_37) then
					local var_46_38 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_43_1.stage_.transform)

					var_46_38.name = var_46_36
					var_46_38.transform.localPosition = Vector3.New(0, 100, 0)
					arg_43_1.actors_[var_46_36] = var_46_38

					local var_46_39 = var_46_38:GetComponentInChildren(typeof(CharacterEffect))

					var_46_39.enabled = true

					local var_46_40 = GameObjectTools.GetOrAddComponent(var_46_38, typeof(DynamicBoneHelper))

					if var_46_40 then
						var_46_40:EnableDynamicBone(false)
					end

					arg_43_1:ShowWeapon(var_46_39.transform, false)

					arg_43_1.var_[var_46_36 .. "Animator"] = var_46_39.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_43_1.var_[var_46_36 .. "Animator"].applyRootMotion = true
					arg_43_1.var_[var_46_36 .. "LipSync"] = var_46_39.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_46_41 = arg_43_1.actors_["10025ui_story"].transform
			local var_46_42 = 3.8

			if var_46_42 < arg_43_1.time_ and arg_43_1.time_ <= var_46_42 + arg_46_0 then
				arg_43_1.var_.moveOldPos10025ui_story = var_46_41.localPosition
			end

			local var_46_43 = 0.001

			if var_46_42 <= arg_43_1.time_ and arg_43_1.time_ < var_46_42 + var_46_43 then
				local var_46_44 = (arg_43_1.time_ - var_46_42) / var_46_43
				local var_46_45 = Vector3.New(0, -1.1, -5.9)

				var_46_41.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10025ui_story, var_46_45, var_46_44)

				local var_46_46 = manager.ui.mainCamera.transform.position - var_46_41.position

				var_46_41.forward = Vector3.New(var_46_46.x, var_46_46.y, var_46_46.z)

				local var_46_47 = var_46_41.localEulerAngles

				var_46_47.z = 0
				var_46_47.x = 0
				var_46_41.localEulerAngles = var_46_47
			end

			if arg_43_1.time_ >= var_46_42 + var_46_43 and arg_43_1.time_ < var_46_42 + var_46_43 + arg_46_0 then
				var_46_41.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_46_48 = manager.ui.mainCamera.transform.position - var_46_41.position

				var_46_41.forward = Vector3.New(var_46_48.x, var_46_48.y, var_46_48.z)

				local var_46_49 = var_46_41.localEulerAngles

				var_46_49.z = 0
				var_46_49.x = 0
				var_46_41.localEulerAngles = var_46_49
			end

			local var_46_50 = 3.8

			if var_46_50 < arg_43_1.time_ and arg_43_1.time_ <= var_46_50 + arg_46_0 then
				arg_43_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_46_51 = 3.8

			if var_46_51 < arg_43_1.time_ and arg_43_1.time_ <= var_46_51 + arg_46_0 then
				arg_43_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_46_52 = arg_43_1.actors_["10025ui_story"]
			local var_46_53 = 3.8

			if var_46_53 < arg_43_1.time_ and arg_43_1.time_ <= var_46_53 + arg_46_0 and not isNil(var_46_52) and arg_43_1.var_.characterEffect10025ui_story == nil then
				arg_43_1.var_.characterEffect10025ui_story = var_46_52:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_54 = 0.2

			if var_46_53 <= arg_43_1.time_ and arg_43_1.time_ < var_46_53 + var_46_54 and not isNil(var_46_52) then
				local var_46_55 = (arg_43_1.time_ - var_46_53) / var_46_54

				if arg_43_1.var_.characterEffect10025ui_story and not isNil(var_46_52) then
					local var_46_56 = Mathf.Lerp(0, 0.5, var_46_55)

					arg_43_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_43_1.var_.characterEffect10025ui_story.fillRatio = var_46_56
				end
			end

			if arg_43_1.time_ >= var_46_53 + var_46_54 and arg_43_1.time_ < var_46_53 + var_46_54 + arg_46_0 and not isNil(var_46_52) and arg_43_1.var_.characterEffect10025ui_story then
				local var_46_57 = 0.5

				arg_43_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_43_1.var_.characterEffect10025ui_story.fillRatio = var_46_57
			end

			local var_46_58 = 0
			local var_46_59 = 1

			if var_46_58 < arg_43_1.time_ and arg_43_1.time_ <= var_46_58 + arg_46_0 then
				local var_46_60 = "play"
				local var_46_61 = "music"

				arg_43_1:AudioAction(var_46_60, var_46_61, "ui_battle", "ui_battle_stopbgm", "")

				local var_46_62 = ""
				local var_46_63 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_46_63 ~= "" then
					if arg_43_1.bgmTxt_.text ~= var_46_63 and arg_43_1.bgmTxt_.text ~= "" then
						if arg_43_1.bgmTxt2_.text ~= "" then
							arg_43_1.bgmTxt_.text = arg_43_1.bgmTxt2_.text
						end

						arg_43_1.bgmTxt2_.text = var_46_63

						arg_43_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_43_1.bgmTxt_.text = var_46_63
						arg_43_1.bgmTxt2_.text = var_46_63
					end

					if arg_43_1.bgmTimer then
						arg_43_1.bgmTimer:Stop()

						arg_43_1.bgmTimer = nil
					end

					if arg_43_1.settingData.show_music_name == 1 then
						arg_43_1.musicController:SetSelectedState("show")
						arg_43_1.musicAnimator_:Play("open", 0, 0)

						if arg_43_1.settingData.music_time ~= 0 then
							arg_43_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_43_1.settingData.music_time), function()
								if arg_43_1 == nil or isNil(arg_43_1.bgmTxt_) then
									return
								end

								arg_43_1.musicController:SetSelectedState("hide")
								arg_43_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_46_64 = 2
			local var_46_65 = 1.5

			if var_46_64 < arg_43_1.time_ and arg_43_1.time_ <= var_46_64 + arg_46_0 then
				local var_46_66 = "play"
				local var_46_67 = "music"

				arg_43_1:AudioAction(var_46_66, var_46_67, "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				local var_46_68 = ""

				if var_46_68 ~= "" then
					if arg_43_1.bgmTxt_.text ~= var_46_68 and arg_43_1.bgmTxt_.text ~= "" then
						if arg_43_1.bgmTxt2_.text ~= "" then
							arg_43_1.bgmTxt_.text = arg_43_1.bgmTxt2_.text
						end

						arg_43_1.bgmTxt2_.text = var_46_68

						arg_43_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_43_1.bgmTxt_.text = var_46_68
						arg_43_1.bgmTxt2_.text = var_46_68
					end

					if arg_43_1.bgmTimer then
						arg_43_1.bgmTimer:Stop()

						arg_43_1.bgmTimer = nil
					end

					if arg_43_1.settingData.show_music_name == 1 then
						arg_43_1.musicController:SetSelectedState("show")
						arg_43_1.musicAnimator_:Play("open", 0, 0)

						if arg_43_1.settingData.music_time ~= 0 then
							arg_43_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_43_1.settingData.music_time), function()
								if arg_43_1 == nil or isNil(arg_43_1.bgmTxt_) then
									return
								end

								arg_43_1.musicController:SetSelectedState("hide")
								arg_43_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_46_69 = 2.2
			local var_46_70 = 0.733333333333333

			if var_46_69 < arg_43_1.time_ and arg_43_1.time_ <= var_46_69 + arg_46_0 then
				local var_46_71 = "play"
				local var_46_72 = "music"

				arg_43_1:AudioAction(var_46_71, var_46_72, "bgm_activity_1_6_story_story", "dialog", "bgm_activity_1_6_story_story.awb")

				local var_46_73 = ""
				local var_46_74 = MusicRecordCfg[95].musicName

				if var_46_74 ~= "" then
					if arg_43_1.bgmTxt_.text ~= var_46_74 and arg_43_1.bgmTxt_.text ~= "" then
						if arg_43_1.bgmTxt2_.text ~= "" then
							arg_43_1.bgmTxt_.text = arg_43_1.bgmTxt2_.text
						end

						arg_43_1.bgmTxt2_.text = var_46_74

						arg_43_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_43_1.bgmTxt_.text = var_46_74
						arg_43_1.bgmTxt2_.text = var_46_74
					end

					if arg_43_1.bgmTimer then
						arg_43_1.bgmTimer:Stop()

						arg_43_1.bgmTimer = nil
					end

					if arg_43_1.settingData.show_music_name == 1 then
						arg_43_1.musicController:SetSelectedState("show")
						arg_43_1.musicAnimator_:Play("open", 0, 0)

						if arg_43_1.settingData.music_time ~= 0 then
							arg_43_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_43_1.settingData.music_time), function()
								if arg_43_1 == nil or isNil(arg_43_1.bgmTxt_) then
									return
								end

								arg_43_1.musicController:SetSelectedState("hide")
								arg_43_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_75 = 4
			local var_46_76 = 0.625

			if var_46_75 < arg_43_1.time_ and arg_43_1.time_ <= var_46_75 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_77 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_77:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_43_1.dialogCg_.alpha = arg_50_0
				end))
				var_46_77:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_77:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_78 = arg_43_1:GetWordFromCfg(116081010)
				local var_46_79 = arg_43_1:FormatText(var_46_78.content)

				arg_43_1.text_.text = var_46_79

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_80 = 25
				local var_46_81 = utf8.len(var_46_79)
				local var_46_82 = var_46_80 <= 0 and var_46_76 or var_46_76 * (var_46_81 / var_46_80)

				if var_46_82 > 0 and var_46_76 < var_46_82 then
					arg_43_1.talkMaxDuration = var_46_82
					var_46_75 = var_46_75 + 0.3

					if var_46_82 + var_46_75 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_82 + var_46_75
					end
				end

				arg_43_1.text_.text = var_46_79
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_83 = var_46_75 + 0.3
			local var_46_84 = math.max(var_46_76, arg_43_1.talkMaxDuration)

			if var_46_83 <= arg_43_1.time_ and arg_43_1.time_ < var_46_83 + var_46_84 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_83) / var_46_84

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_83 + var_46_84 and arg_43_1.time_ < var_46_83 + var_46_84 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play116081011 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 116081011
		arg_52_1.duration_ = 0.02

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"

			SetActive(arg_52_1.choicesGo_, true)

			for iter_53_0, iter_53_1 in ipairs(arg_52_1.choices_) do
				local var_53_0 = iter_53_0 <= 1

				SetActive(iter_53_1.go, var_53_0)
			end

			arg_52_1.choices_[1].txt.text = arg_52_1:FormatText(StoryChoiceCfg[244].name)
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play116081012(arg_52_1)
			end

			arg_52_1:RecordChoiceLog(116081011, 244)
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			return
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play116081012 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 116081012
		arg_56_1.duration_ = 3.37

		local var_56_0 = {
			zh = 3.366,
			ja = 2.566
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
				arg_56_0:Play116081013(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10025ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10025ui_story == nil then
				arg_56_1.var_.characterEffect10025ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect10025ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10025ui_story then
				arg_56_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_59_4 = 0

			if var_59_4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_59_6 = 0
			local var_59_7 = 0.175

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_8 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_8:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_9 = arg_56_1:FormatText(StoryNameCfg[328].name)

				arg_56_1.leftNameTxt_.text = var_59_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_10 = arg_56_1:GetWordFromCfg(116081012)
				local var_59_11 = arg_56_1:FormatText(var_59_10.content)

				arg_56_1.text_.text = var_59_11

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_12 = 7
				local var_59_13 = utf8.len(var_59_11)
				local var_59_14 = var_59_12 <= 0 and var_59_7 or var_59_7 * (var_59_13 / var_59_12)

				if var_59_14 > 0 and var_59_7 < var_59_14 then
					arg_56_1.talkMaxDuration = var_59_14
					var_59_6 = var_59_6 + 0.3

					if var_59_14 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_11
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081012", "story_v_out_116081.awb") ~= 0 then
					local var_59_15 = manager.audio:GetVoiceLength("story_v_out_116081", "116081012", "story_v_out_116081.awb") / 1000

					if var_59_15 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_6
					end

					if var_59_10.prefab_name ~= "" and arg_56_1.actors_[var_59_10.prefab_name] ~= nil then
						local var_59_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_10.prefab_name].transform, "story_v_out_116081", "116081012", "story_v_out_116081.awb")

						arg_56_1:RecordAudio("116081012", var_59_16)
						arg_56_1:RecordAudio("116081012", var_59_16)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_116081", "116081012", "story_v_out_116081.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_116081", "116081012", "story_v_out_116081.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_17 = var_59_6 + 0.3
			local var_59_18 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_17 <= arg_56_1.time_ and arg_56_1.time_ < var_59_17 + var_59_18 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_17) / var_59_18

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_17 + var_59_18 and arg_56_1.time_ < var_59_17 + var_59_18 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play116081013 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 116081013
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play116081014(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["10025ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect10025ui_story == nil then
				arg_62_1.var_.characterEffect10025ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect10025ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_62_1.var_.characterEffect10025ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect10025ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_62_1.var_.characterEffect10025ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 0.625

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[7].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_9 = arg_62_1:GetWordFromCfg(116081013)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 25
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
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_14 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_14 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_14

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_14 and arg_62_1.time_ < var_65_6 + var_65_14 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play116081014 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 116081014
		arg_66_1.duration_ = 4.2

		local var_66_0 = {
			zh = 4.2,
			ja = 2.333
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play116081015(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10025ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10025ui_story == nil then
				arg_66_1.var_.characterEffect10025ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.2

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect10025ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10025ui_story then
				arg_66_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_69_4 = arg_66_1.actors_["10025ui_story"].transform
			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1.var_.moveOldPos10025ui_story = var_69_4.localPosition
			end

			local var_69_6 = 0.1

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 then
				local var_69_7 = (arg_66_1.time_ - var_69_5) / var_69_6
				local var_69_8 = Vector3.New(0, -1.1, -5.9)

				var_69_4.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10025ui_story, var_69_8, var_69_7)

				local var_69_9 = manager.ui.mainCamera.transform.position - var_69_4.position

				var_69_4.forward = Vector3.New(var_69_9.x, var_69_9.y, var_69_9.z)

				local var_69_10 = var_69_4.localEulerAngles

				var_69_10.z = 0
				var_69_10.x = 0
				var_69_4.localEulerAngles = var_69_10
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 then
				var_69_4.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_69_11 = manager.ui.mainCamera.transform.position - var_69_4.position

				var_69_4.forward = Vector3.New(var_69_11.x, var_69_11.y, var_69_11.z)

				local var_69_12 = var_69_4.localEulerAngles

				var_69_12.z = 0
				var_69_12.x = 0
				var_69_4.localEulerAngles = var_69_12
			end

			local var_69_13 = 0

			if var_69_13 < arg_66_1.time_ and arg_66_1.time_ <= var_69_13 + arg_69_0 then
				arg_66_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_69_14 = 0
			local var_69_15 = 0.1

			if var_69_14 < arg_66_1.time_ and arg_66_1.time_ <= var_69_14 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_16 = arg_66_1:FormatText(StoryNameCfg[328].name)

				arg_66_1.leftNameTxt_.text = var_69_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_17 = arg_66_1:GetWordFromCfg(116081014)
				local var_69_18 = arg_66_1:FormatText(var_69_17.content)

				arg_66_1.text_.text = var_69_18

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_19 = 4
				local var_69_20 = utf8.len(var_69_18)
				local var_69_21 = var_69_19 <= 0 and var_69_15 or var_69_15 * (var_69_20 / var_69_19)

				if var_69_21 > 0 and var_69_15 < var_69_21 then
					arg_66_1.talkMaxDuration = var_69_21

					if var_69_21 + var_69_14 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_21 + var_69_14
					end
				end

				arg_66_1.text_.text = var_69_18
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081014", "story_v_out_116081.awb") ~= 0 then
					local var_69_22 = manager.audio:GetVoiceLength("story_v_out_116081", "116081014", "story_v_out_116081.awb") / 1000

					if var_69_22 + var_69_14 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_22 + var_69_14
					end

					if var_69_17.prefab_name ~= "" and arg_66_1.actors_[var_69_17.prefab_name] ~= nil then
						local var_69_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_17.prefab_name].transform, "story_v_out_116081", "116081014", "story_v_out_116081.awb")

						arg_66_1:RecordAudio("116081014", var_69_23)
						arg_66_1:RecordAudio("116081014", var_69_23)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_116081", "116081014", "story_v_out_116081.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_116081", "116081014", "story_v_out_116081.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_24 = math.max(var_69_15, arg_66_1.talkMaxDuration)

			if var_69_14 <= arg_66_1.time_ and arg_66_1.time_ < var_69_14 + var_69_24 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_14) / var_69_24

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_14 + var_69_24 and arg_66_1.time_ < var_69_14 + var_69_24 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play116081015 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 116081015
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play116081016(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10025ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10025ui_story == nil then
				arg_70_1.var_.characterEffect10025ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect10025ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10025ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10025ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10025ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 0.525

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_8 = arg_70_1:GetWordFromCfg(116081015)
				local var_73_9 = arg_70_1:FormatText(var_73_8.content)

				arg_70_1.text_.text = var_73_9

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_10 = 21
				local var_73_11 = utf8.len(var_73_9)
				local var_73_12 = var_73_10 <= 0 and var_73_7 or var_73_7 * (var_73_11 / var_73_10)

				if var_73_12 > 0 and var_73_7 < var_73_12 then
					arg_70_1.talkMaxDuration = var_73_12

					if var_73_12 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_12 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_9
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_13 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_13 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_13

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_13 and arg_70_1.time_ < var_73_6 + var_73_13 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play116081016 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 116081016
		arg_74_1.duration_ = 6.5

		local var_74_0 = {
			zh = 4.9,
			ja = 6.5
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play116081017(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["10025ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect10025ui_story == nil then
				arg_74_1.var_.characterEffect10025ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect10025ui_story and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect10025ui_story then
				arg_74_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_77_4 = arg_74_1.actors_["10025ui_story"].transform
			local var_77_5 = 0

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 then
				arg_74_1.var_.moveOldPos10025ui_story = var_77_4.localPosition
			end

			local var_77_6 = 0.1

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_6 then
				local var_77_7 = (arg_74_1.time_ - var_77_5) / var_77_6
				local var_77_8 = Vector3.New(0, -1.1, -5.9)

				var_77_4.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos10025ui_story, var_77_8, var_77_7)

				local var_77_9 = manager.ui.mainCamera.transform.position - var_77_4.position

				var_77_4.forward = Vector3.New(var_77_9.x, var_77_9.y, var_77_9.z)

				local var_77_10 = var_77_4.localEulerAngles

				var_77_10.z = 0
				var_77_10.x = 0
				var_77_4.localEulerAngles = var_77_10
			end

			if arg_74_1.time_ >= var_77_5 + var_77_6 and arg_74_1.time_ < var_77_5 + var_77_6 + arg_77_0 then
				var_77_4.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_77_11 = manager.ui.mainCamera.transform.position - var_77_4.position

				var_77_4.forward = Vector3.New(var_77_11.x, var_77_11.y, var_77_11.z)

				local var_77_12 = var_77_4.localEulerAngles

				var_77_12.z = 0
				var_77_12.x = 0
				var_77_4.localEulerAngles = var_77_12
			end

			local var_77_13 = 0

			if var_77_13 < arg_74_1.time_ and arg_74_1.time_ <= var_77_13 + arg_77_0 then
				arg_74_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action442")
			end

			local var_77_14 = 0

			if var_77_14 < arg_74_1.time_ and arg_74_1.time_ <= var_77_14 + arg_77_0 then
				arg_74_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_77_15 = 0
			local var_77_16 = 0.275

			if var_77_15 < arg_74_1.time_ and arg_74_1.time_ <= var_77_15 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_17 = arg_74_1:FormatText(StoryNameCfg[328].name)

				arg_74_1.leftNameTxt_.text = var_77_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_18 = arg_74_1:GetWordFromCfg(116081016)
				local var_77_19 = arg_74_1:FormatText(var_77_18.content)

				arg_74_1.text_.text = var_77_19

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_20 = 11
				local var_77_21 = utf8.len(var_77_19)
				local var_77_22 = var_77_20 <= 0 and var_77_16 or var_77_16 * (var_77_21 / var_77_20)

				if var_77_22 > 0 and var_77_16 < var_77_22 then
					arg_74_1.talkMaxDuration = var_77_22

					if var_77_22 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_22 + var_77_15
					end
				end

				arg_74_1.text_.text = var_77_19
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081016", "story_v_out_116081.awb") ~= 0 then
					local var_77_23 = manager.audio:GetVoiceLength("story_v_out_116081", "116081016", "story_v_out_116081.awb") / 1000

					if var_77_23 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_23 + var_77_15
					end

					if var_77_18.prefab_name ~= "" and arg_74_1.actors_[var_77_18.prefab_name] ~= nil then
						local var_77_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_18.prefab_name].transform, "story_v_out_116081", "116081016", "story_v_out_116081.awb")

						arg_74_1:RecordAudio("116081016", var_77_24)
						arg_74_1:RecordAudio("116081016", var_77_24)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_116081", "116081016", "story_v_out_116081.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_116081", "116081016", "story_v_out_116081.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_25 = math.max(var_77_16, arg_74_1.talkMaxDuration)

			if var_77_15 <= arg_74_1.time_ and arg_74_1.time_ < var_77_15 + var_77_25 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_15) / var_77_25

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_15 + var_77_25 and arg_74_1.time_ < var_77_15 + var_77_25 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play116081017 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 116081017
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play116081018(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10025ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10025ui_story == nil then
				arg_78_1.var_.characterEffect10025ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.2

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect10025ui_story and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10025ui_story.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10025ui_story then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10025ui_story.fillRatio = var_81_5
			end

			local var_81_6 = 0
			local var_81_7 = 0.9

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

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_9 = arg_78_1:GetWordFromCfg(116081017)
				local var_81_10 = arg_78_1:FormatText(var_81_9.content)

				arg_78_1.text_.text = var_81_10

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 36
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
	Play116081018 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 116081018
		arg_82_1.duration_ = 5.4

		local var_82_0 = {
			zh = 2.166,
			ja = 5.4
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play116081019(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10025ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10025ui_story == nil then
				arg_82_1.var_.characterEffect10025ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.2

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect10025ui_story and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10025ui_story then
				arg_82_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_85_4 = arg_82_1.actors_["10025ui_story"].transform
			local var_85_5 = 0

			if var_85_5 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1.var_.moveOldPos10025ui_story = var_85_4.localPosition
			end

			local var_85_6 = 0.1

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_6 then
				local var_85_7 = (arg_82_1.time_ - var_85_5) / var_85_6
				local var_85_8 = Vector3.New(0, -1.1, -5.9)

				var_85_4.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10025ui_story, var_85_8, var_85_7)

				local var_85_9 = manager.ui.mainCamera.transform.position - var_85_4.position

				var_85_4.forward = Vector3.New(var_85_9.x, var_85_9.y, var_85_9.z)

				local var_85_10 = var_85_4.localEulerAngles

				var_85_10.z = 0
				var_85_10.x = 0
				var_85_4.localEulerAngles = var_85_10
			end

			if arg_82_1.time_ >= var_85_5 + var_85_6 and arg_82_1.time_ < var_85_5 + var_85_6 + arg_85_0 then
				var_85_4.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_85_11 = manager.ui.mainCamera.transform.position - var_85_4.position

				var_85_4.forward = Vector3.New(var_85_11.x, var_85_11.y, var_85_11.z)

				local var_85_12 = var_85_4.localEulerAngles

				var_85_12.z = 0
				var_85_12.x = 0
				var_85_4.localEulerAngles = var_85_12
			end

			local var_85_13 = 0

			if var_85_13 < arg_82_1.time_ and arg_82_1.time_ <= var_85_13 + arg_85_0 then
				arg_82_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action2_2")
			end

			local var_85_14 = 0

			if var_85_14 < arg_82_1.time_ and arg_82_1.time_ <= var_85_14 + arg_85_0 then
				arg_82_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_85_15 = 0
			local var_85_16 = 0.25

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_17 = arg_82_1:FormatText(StoryNameCfg[328].name)

				arg_82_1.leftNameTxt_.text = var_85_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_18 = arg_82_1:GetWordFromCfg(116081018)
				local var_85_19 = arg_82_1:FormatText(var_85_18.content)

				arg_82_1.text_.text = var_85_19

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_20 = 10
				local var_85_21 = utf8.len(var_85_19)
				local var_85_22 = var_85_20 <= 0 and var_85_16 or var_85_16 * (var_85_21 / var_85_20)

				if var_85_22 > 0 and var_85_16 < var_85_22 then
					arg_82_1.talkMaxDuration = var_85_22

					if var_85_22 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_22 + var_85_15
					end
				end

				arg_82_1.text_.text = var_85_19
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081018", "story_v_out_116081.awb") ~= 0 then
					local var_85_23 = manager.audio:GetVoiceLength("story_v_out_116081", "116081018", "story_v_out_116081.awb") / 1000

					if var_85_23 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_23 + var_85_15
					end

					if var_85_18.prefab_name ~= "" and arg_82_1.actors_[var_85_18.prefab_name] ~= nil then
						local var_85_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_18.prefab_name].transform, "story_v_out_116081", "116081018", "story_v_out_116081.awb")

						arg_82_1:RecordAudio("116081018", var_85_24)
						arg_82_1:RecordAudio("116081018", var_85_24)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_116081", "116081018", "story_v_out_116081.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_116081", "116081018", "story_v_out_116081.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_25 = math.max(var_85_16, arg_82_1.talkMaxDuration)

			if var_85_15 <= arg_82_1.time_ and arg_82_1.time_ < var_85_15 + var_85_25 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_15) / var_85_25

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_15 + var_85_25 and arg_82_1.time_ < var_85_15 + var_85_25 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play116081019 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 116081019
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play116081020(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10025ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos10025ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(0, 100, 0)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10025ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, 100, 0)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = 0
			local var_89_10 = 0.625

			if var_89_9 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_11 = arg_86_1:GetWordFromCfg(116081019)
				local var_89_12 = arg_86_1:FormatText(var_89_11.content)

				arg_86_1.text_.text = var_89_12

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_13 = 25
				local var_89_14 = utf8.len(var_89_12)
				local var_89_15 = var_89_13 <= 0 and var_89_10 or var_89_10 * (var_89_14 / var_89_13)

				if var_89_15 > 0 and var_89_10 < var_89_15 then
					arg_86_1.talkMaxDuration = var_89_15

					if var_89_15 + var_89_9 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_15 + var_89_9
					end
				end

				arg_86_1.text_.text = var_89_12
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_16 = math.max(var_89_10, arg_86_1.talkMaxDuration)

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_16 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_9) / var_89_16

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_9 + var_89_16 and arg_86_1.time_ < var_89_9 + var_89_16 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play116081020 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 116081020
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play116081021(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.975

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(116081020)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 39
				local var_93_5 = utf8.len(var_93_3)
				local var_93_6 = var_93_4 <= 0 and var_93_1 or var_93_1 * (var_93_5 / var_93_4)

				if var_93_6 > 0 and var_93_1 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_7 and arg_90_1.time_ < var_93_0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play116081021 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 116081021
		arg_94_1.duration_ = 7.23

		local var_94_0 = {
			zh = 6.666,
			ja = 7.233
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play116081022(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["10025ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10025ui_story == nil then
				arg_94_1.var_.characterEffect10025ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect10025ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10025ui_story then
				arg_94_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_97_4 = arg_94_1.actors_["10025ui_story"].transform
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.var_.moveOldPos10025ui_story = var_97_4.localPosition
			end

			local var_97_6 = 0.001

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6
				local var_97_8 = Vector3.New(0, -1.1, -5.9)

				var_97_4.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10025ui_story, var_97_8, var_97_7)

				local var_97_9 = manager.ui.mainCamera.transform.position - var_97_4.position

				var_97_4.forward = Vector3.New(var_97_9.x, var_97_9.y, var_97_9.z)

				local var_97_10 = var_97_4.localEulerAngles

				var_97_10.z = 0
				var_97_10.x = 0
				var_97_4.localEulerAngles = var_97_10
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 then
				var_97_4.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_97_11 = manager.ui.mainCamera.transform.position - var_97_4.position

				var_97_4.forward = Vector3.New(var_97_11.x, var_97_11.y, var_97_11.z)

				local var_97_12 = var_97_4.localEulerAngles

				var_97_12.z = 0
				var_97_12.x = 0
				var_97_4.localEulerAngles = var_97_12
			end

			local var_97_13 = 0

			if var_97_13 < arg_94_1.time_ and arg_94_1.time_ <= var_97_13 + arg_97_0 then
				arg_94_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_97_14 = 0

			if var_97_14 < arg_94_1.time_ and arg_94_1.time_ <= var_97_14 + arg_97_0 then
				arg_94_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_97_15 = arg_94_1.actors_["10025ui_story"].transform
			local var_97_16 = 0

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				arg_94_1.var_.moveOldPos10025ui_story = var_97_15.localPosition
			end

			local var_97_17 = 0.001

			if var_97_16 <= arg_94_1.time_ and arg_94_1.time_ < var_97_16 + var_97_17 then
				local var_97_18 = (arg_94_1.time_ - var_97_16) / var_97_17
				local var_97_19 = Vector3.New(0, -1.1, -5.9)

				var_97_15.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10025ui_story, var_97_19, var_97_18)

				local var_97_20 = manager.ui.mainCamera.transform.position - var_97_15.position

				var_97_15.forward = Vector3.New(var_97_20.x, var_97_20.y, var_97_20.z)

				local var_97_21 = var_97_15.localEulerAngles

				var_97_21.z = 0
				var_97_21.x = 0
				var_97_15.localEulerAngles = var_97_21
			end

			if arg_94_1.time_ >= var_97_16 + var_97_17 and arg_94_1.time_ < var_97_16 + var_97_17 + arg_97_0 then
				var_97_15.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_97_22 = manager.ui.mainCamera.transform.position - var_97_15.position

				var_97_15.forward = Vector3.New(var_97_22.x, var_97_22.y, var_97_22.z)

				local var_97_23 = var_97_15.localEulerAngles

				var_97_23.z = 0
				var_97_23.x = 0
				var_97_15.localEulerAngles = var_97_23
			end

			local var_97_24 = 0
			local var_97_25 = 0.725

			if var_97_24 < arg_94_1.time_ and arg_94_1.time_ <= var_97_24 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_26 = arg_94_1:FormatText(StoryNameCfg[328].name)

				arg_94_1.leftNameTxt_.text = var_97_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_27 = arg_94_1:GetWordFromCfg(116081021)
				local var_97_28 = arg_94_1:FormatText(var_97_27.content)

				arg_94_1.text_.text = var_97_28

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_29 = 29
				local var_97_30 = utf8.len(var_97_28)
				local var_97_31 = var_97_29 <= 0 and var_97_25 or var_97_25 * (var_97_30 / var_97_29)

				if var_97_31 > 0 and var_97_25 < var_97_31 then
					arg_94_1.talkMaxDuration = var_97_31

					if var_97_31 + var_97_24 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_31 + var_97_24
					end
				end

				arg_94_1.text_.text = var_97_28
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081021", "story_v_out_116081.awb") ~= 0 then
					local var_97_32 = manager.audio:GetVoiceLength("story_v_out_116081", "116081021", "story_v_out_116081.awb") / 1000

					if var_97_32 + var_97_24 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_32 + var_97_24
					end

					if var_97_27.prefab_name ~= "" and arg_94_1.actors_[var_97_27.prefab_name] ~= nil then
						local var_97_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_27.prefab_name].transform, "story_v_out_116081", "116081021", "story_v_out_116081.awb")

						arg_94_1:RecordAudio("116081021", var_97_33)
						arg_94_1:RecordAudio("116081021", var_97_33)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_116081", "116081021", "story_v_out_116081.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_116081", "116081021", "story_v_out_116081.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_34 = math.max(var_97_25, arg_94_1.talkMaxDuration)

			if var_97_24 <= arg_94_1.time_ and arg_94_1.time_ < var_97_24 + var_97_34 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_24) / var_97_34

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_24 + var_97_34 and arg_94_1.time_ < var_97_24 + var_97_34 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play116081022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 116081022
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play116081023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10025ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10025ui_story == nil then
				arg_98_1.var_.characterEffect10025ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.2

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect10025ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10025ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10025ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10025ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.75

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_8 = arg_98_1:GetWordFromCfg(116081022)
				local var_101_9 = arg_98_1:FormatText(var_101_8.content)

				arg_98_1.text_.text = var_101_9

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_10 = 30
				local var_101_11 = utf8.len(var_101_9)
				local var_101_12 = var_101_10 <= 0 and var_101_7 or var_101_7 * (var_101_11 / var_101_10)

				if var_101_12 > 0 and var_101_7 < var_101_12 then
					arg_98_1.talkMaxDuration = var_101_12

					if var_101_12 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_12 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_9
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_13 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_13 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_13

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_13 and arg_98_1.time_ < var_101_6 + var_101_13 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play116081023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 116081023
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play116081024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.475

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

				local var_105_2 = arg_102_1:GetWordFromCfg(116081023)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 19
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
	Play116081024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 116081024
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play116081025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.4

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

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(116081024)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 16
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
	Play116081025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 116081025
		arg_110_1.duration_ = 6.8

		local var_110_0 = {
			zh = 6.8,
			ja = 6.466
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
				arg_110_0:Play116081026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["10025ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect10025ui_story == nil then
				arg_110_1.var_.characterEffect10025ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.2

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect10025ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect10025ui_story then
				arg_110_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_113_4 = arg_110_1.actors_["10025ui_story"].transform
			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1.var_.moveOldPos10025ui_story = var_113_4.localPosition
			end

			local var_113_6 = 0.1

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 then
				local var_113_7 = (arg_110_1.time_ - var_113_5) / var_113_6
				local var_113_8 = Vector3.New(0, -1.1, -5.9)

				var_113_4.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10025ui_story, var_113_8, var_113_7)

				local var_113_9 = manager.ui.mainCamera.transform.position - var_113_4.position

				var_113_4.forward = Vector3.New(var_113_9.x, var_113_9.y, var_113_9.z)

				local var_113_10 = var_113_4.localEulerAngles

				var_113_10.z = 0
				var_113_10.x = 0
				var_113_4.localEulerAngles = var_113_10
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 then
				var_113_4.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_113_11 = manager.ui.mainCamera.transform.position - var_113_4.position

				var_113_4.forward = Vector3.New(var_113_11.x, var_113_11.y, var_113_11.z)

				local var_113_12 = var_113_4.localEulerAngles

				var_113_12.z = 0
				var_113_12.x = 0
				var_113_4.localEulerAngles = var_113_12
			end

			local var_113_13 = 0

			if var_113_13 < arg_110_1.time_ and arg_110_1.time_ <= var_113_13 + arg_113_0 then
				arg_110_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_113_14 = 0

			if var_113_14 < arg_110_1.time_ and arg_110_1.time_ <= var_113_14 + arg_113_0 then
				arg_110_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_113_15 = 0
			local var_113_16 = 0.625

			if var_113_15 < arg_110_1.time_ and arg_110_1.time_ <= var_113_15 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_17 = arg_110_1:FormatText(StoryNameCfg[328].name)

				arg_110_1.leftNameTxt_.text = var_113_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_18 = arg_110_1:GetWordFromCfg(116081025)
				local var_113_19 = arg_110_1:FormatText(var_113_18.content)

				arg_110_1.text_.text = var_113_19

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_20 = 25
				local var_113_21 = utf8.len(var_113_19)
				local var_113_22 = var_113_20 <= 0 and var_113_16 or var_113_16 * (var_113_21 / var_113_20)

				if var_113_22 > 0 and var_113_16 < var_113_22 then
					arg_110_1.talkMaxDuration = var_113_22

					if var_113_22 + var_113_15 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_22 + var_113_15
					end
				end

				arg_110_1.text_.text = var_113_19
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081025", "story_v_out_116081.awb") ~= 0 then
					local var_113_23 = manager.audio:GetVoiceLength("story_v_out_116081", "116081025", "story_v_out_116081.awb") / 1000

					if var_113_23 + var_113_15 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_23 + var_113_15
					end

					if var_113_18.prefab_name ~= "" and arg_110_1.actors_[var_113_18.prefab_name] ~= nil then
						local var_113_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_18.prefab_name].transform, "story_v_out_116081", "116081025", "story_v_out_116081.awb")

						arg_110_1:RecordAudio("116081025", var_113_24)
						arg_110_1:RecordAudio("116081025", var_113_24)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_116081", "116081025", "story_v_out_116081.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_116081", "116081025", "story_v_out_116081.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_25 = math.max(var_113_16, arg_110_1.talkMaxDuration)

			if var_113_15 <= arg_110_1.time_ and arg_110_1.time_ < var_113_15 + var_113_25 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_15) / var_113_25

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_15 + var_113_25 and arg_110_1.time_ < var_113_15 + var_113_25 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play116081026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 116081026
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play116081027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["10025ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect10025ui_story == nil then
				arg_114_1.var_.characterEffect10025ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.2

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect10025ui_story and not isNil(var_117_0) then
					local var_117_4 = Mathf.Lerp(0, 0.5, var_117_3)

					arg_114_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_114_1.var_.characterEffect10025ui_story.fillRatio = var_117_4
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect10025ui_story then
				local var_117_5 = 0.5

				arg_114_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_114_1.var_.characterEffect10025ui_story.fillRatio = var_117_5
			end

			local var_117_6 = 0
			local var_117_7 = 0.45

			if var_117_6 < arg_114_1.time_ and arg_114_1.time_ <= var_117_6 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_8 = arg_114_1:FormatText(StoryNameCfg[7].name)

				arg_114_1.leftNameTxt_.text = var_117_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_9 = arg_114_1:GetWordFromCfg(116081026)
				local var_117_10 = arg_114_1:FormatText(var_117_9.content)

				arg_114_1.text_.text = var_117_10

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_11 = 18
				local var_117_12 = utf8.len(var_117_10)
				local var_117_13 = var_117_11 <= 0 and var_117_7 or var_117_7 * (var_117_12 / var_117_11)

				if var_117_13 > 0 and var_117_7 < var_117_13 then
					arg_114_1.talkMaxDuration = var_117_13

					if var_117_13 + var_117_6 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_13 + var_117_6
					end
				end

				arg_114_1.text_.text = var_117_10
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_14 = math.max(var_117_7, arg_114_1.talkMaxDuration)

			if var_117_6 <= arg_114_1.time_ and arg_114_1.time_ < var_117_6 + var_117_14 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_6) / var_117_14

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_6 + var_117_14 and arg_114_1.time_ < var_117_6 + var_117_14 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play116081027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 116081027
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play116081028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.425

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

				local var_121_2 = arg_118_1:GetWordFromCfg(116081027)
				local var_121_3 = arg_118_1:FormatText(var_121_2.content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 17
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
	Play116081028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 116081028
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play116081029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.575

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_2 = arg_122_1:GetWordFromCfg(116081028)
				local var_125_3 = arg_122_1:FormatText(var_125_2.content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 23
				local var_125_5 = utf8.len(var_125_3)
				local var_125_6 = var_125_4 <= 0 and var_125_1 or var_125_1 * (var_125_5 / var_125_4)

				if var_125_6 > 0 and var_125_1 < var_125_6 then
					arg_122_1.talkMaxDuration = var_125_6

					if var_125_6 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_7 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_7 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_7

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_7 and arg_122_1.time_ < var_125_0 + var_125_7 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play116081029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 116081029
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play116081030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 0.25

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_2 = arg_126_1:FormatText(StoryNameCfg[7].name)

				arg_126_1.leftNameTxt_.text = var_129_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_3 = arg_126_1:GetWordFromCfg(116081029)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 10
				local var_129_6 = utf8.len(var_129_4)
				local var_129_7 = var_129_5 <= 0 and var_129_1 or var_129_1 * (var_129_6 / var_129_5)

				if var_129_7 > 0 and var_129_1 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_8 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_8 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_8

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_8 and arg_126_1.time_ < var_129_0 + var_129_8 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play116081030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 116081030
		arg_130_1.duration_ = 7.07

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play116081031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.bgs_.ST18a.transform
			local var_133_1 = 2

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPosST18a = var_133_0.localPosition
			end

			local var_133_2 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2
				local var_133_4 = Vector3.New(1.5, 1, 6)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPosST18a, var_133_4, var_133_3)
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(1.5, 1, 6)
			end

			local var_133_5 = arg_130_1.bgs_.ST18a.transform
			local var_133_6 = 2.01666666666667

			if var_133_6 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.var_.moveOldPosST18a = var_133_5.localPosition
			end

			local var_133_7 = 3.5

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_7 then
				local var_133_8 = (arg_130_1.time_ - var_133_6) / var_133_7
				local var_133_9 = Vector3.New(1, 0.5, 6)

				var_133_5.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPosST18a, var_133_9, var_133_8)
			end

			if arg_130_1.time_ >= var_133_6 + var_133_7 and arg_130_1.time_ < var_133_6 + var_133_7 + arg_133_0 then
				var_133_5.localPosition = Vector3.New(1, 0.5, 6)
			end

			local var_133_10 = arg_130_1.bgs_.ST18a.transform
			local var_133_11 = 5.51666666666667

			if var_133_11 < arg_130_1.time_ and arg_130_1.time_ <= var_133_11 + arg_133_0 then
				arg_130_1.var_.moveOldPosST18a = var_133_10.localPosition
			end

			local var_133_12 = 0.6

			if var_133_11 <= arg_130_1.time_ and arg_130_1.time_ < var_133_11 + var_133_12 then
				local var_133_13 = (arg_130_1.time_ - var_133_11) / var_133_12
				local var_133_14 = Vector3.New(1, 1, 6)

				var_133_10.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPosST18a, var_133_14, var_133_13)
			end

			if arg_130_1.time_ >= var_133_11 + var_133_12 and arg_130_1.time_ < var_133_11 + var_133_12 + arg_133_0 then
				var_133_10.localPosition = Vector3.New(1, 1, 6)
			end

			local var_133_15 = 0

			if var_133_15 < arg_130_1.time_ and arg_130_1.time_ <= var_133_15 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_16 = 2

			if var_133_15 <= arg_130_1.time_ and arg_130_1.time_ < var_133_15 + var_133_16 then
				local var_133_17 = (arg_130_1.time_ - var_133_15) / var_133_16
				local var_133_18 = Color.New(0, 0, 0)

				var_133_18.a = Mathf.Lerp(0, 1, var_133_17)
				arg_130_1.mask_.color = var_133_18
			end

			if arg_130_1.time_ >= var_133_15 + var_133_16 and arg_130_1.time_ < var_133_15 + var_133_16 + arg_133_0 then
				local var_133_19 = Color.New(0, 0, 0)

				var_133_19.a = 1
				arg_130_1.mask_.color = var_133_19
			end

			local var_133_20 = 2

			if var_133_20 < arg_130_1.time_ and arg_130_1.time_ <= var_133_20 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_21 = 2

			if var_133_20 <= arg_130_1.time_ and arg_130_1.time_ < var_133_20 + var_133_21 then
				local var_133_22 = (arg_130_1.time_ - var_133_20) / var_133_21
				local var_133_23 = Color.New(0, 0, 0)

				var_133_23.a = Mathf.Lerp(1, 0, var_133_22)
				arg_130_1.mask_.color = var_133_23
			end

			if arg_130_1.time_ >= var_133_20 + var_133_21 and arg_130_1.time_ < var_133_20 + var_133_21 + arg_133_0 then
				local var_133_24 = Color.New(0, 0, 0)
				local var_133_25 = 0

				arg_130_1.mask_.enabled = false
				var_133_24.a = var_133_25
				arg_130_1.mask_.color = var_133_24
			end

			local var_133_26 = arg_130_1.bgs_.ST18a.transform
			local var_133_27 = 5.51666666666667

			if var_133_27 < arg_130_1.time_ and arg_130_1.time_ <= var_133_27 + arg_133_0 then
				arg_130_1.var_.shakeOldPosST18a = var_133_26.localPosition
			end

			local var_133_28 = 0.6

			if var_133_27 <= arg_130_1.time_ and arg_130_1.time_ < var_133_27 + var_133_28 then
				local var_133_29 = (arg_130_1.time_ - var_133_27) / 0.099
				local var_133_30, var_133_31 = math.modf(var_133_29)

				var_133_26.localPosition = Vector3.New(var_133_31 * 0.01, var_133_31 * 0.01, var_133_31 * 0) + arg_130_1.var_.shakeOldPosST18a
			end

			if arg_130_1.time_ >= var_133_27 + var_133_28 and arg_130_1.time_ < var_133_27 + var_133_28 + arg_133_0 then
				var_133_26.localPosition = arg_130_1.var_.shakeOldPosST18a
			end

			local var_133_32 = arg_130_1.actors_["10025ui_story"].transform
			local var_133_33 = 1.966

			if var_133_33 < arg_130_1.time_ and arg_130_1.time_ <= var_133_33 + arg_133_0 then
				arg_130_1.var_.moveOldPos10025ui_story = var_133_32.localPosition
			end

			local var_133_34 = 0.001

			if var_133_33 <= arg_130_1.time_ and arg_130_1.time_ < var_133_33 + var_133_34 then
				local var_133_35 = (arg_130_1.time_ - var_133_33) / var_133_34
				local var_133_36 = Vector3.New(0, 100, 0)

				var_133_32.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10025ui_story, var_133_36, var_133_35)

				local var_133_37 = manager.ui.mainCamera.transform.position - var_133_32.position

				var_133_32.forward = Vector3.New(var_133_37.x, var_133_37.y, var_133_37.z)

				local var_133_38 = var_133_32.localEulerAngles

				var_133_38.z = 0
				var_133_38.x = 0
				var_133_32.localEulerAngles = var_133_38
			end

			if arg_130_1.time_ >= var_133_33 + var_133_34 and arg_130_1.time_ < var_133_33 + var_133_34 + arg_133_0 then
				var_133_32.localPosition = Vector3.New(0, 100, 0)

				local var_133_39 = manager.ui.mainCamera.transform.position - var_133_32.position

				var_133_32.forward = Vector3.New(var_133_39.x, var_133_39.y, var_133_39.z)

				local var_133_40 = var_133_32.localEulerAngles

				var_133_40.z = 0
				var_133_40.x = 0
				var_133_32.localEulerAngles = var_133_40
			end

			local var_133_41 = 4

			if var_133_41 < arg_130_1.time_ and arg_130_1.time_ <= var_133_41 + arg_133_0 then
				arg_130_1.allBtn_.enabled = false
			end

			local var_133_42 = 2.11666666666667

			if arg_130_1.time_ >= var_133_41 + var_133_42 and arg_130_1.time_ < var_133_41 + var_133_42 + arg_133_0 then
				arg_130_1.allBtn_.enabled = true
			end

			if arg_130_1.frameCnt_ <= 1 then
				arg_130_1.dialog_:SetActive(false)
			end

			local var_133_43 = 1.966
			local var_133_44 = 1

			if var_133_43 < arg_130_1.time_ and arg_130_1.time_ <= var_133_43 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				arg_130_1.dialog_:SetActive(true)

				arg_130_1.dialogCg_.alpha = 0

				local var_133_45 = LeanTween.value(arg_130_1.dialog_, 0, 1, 0.3)

				var_133_45:setOnUpdate(LuaHelper.FloatAction(function(arg_134_0)
					arg_130_1.dialogCg_.alpha = arg_134_0
				end))
				var_133_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_130_1.dialog_)
					var_133_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_130_1.duration_ = arg_130_1.duration_ + 0.3

				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_46 = arg_130_1:GetWordFromCfg(116081030)
				local var_133_47 = arg_130_1:FormatText(var_133_46.content)

				arg_130_1.text_.text = var_133_47

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_48 = 40
				local var_133_49 = utf8.len(var_133_47)
				local var_133_50 = var_133_48 <= 0 and var_133_44 or var_133_44 * (var_133_49 / var_133_48)

				if var_133_50 > 0 and var_133_44 < var_133_50 then
					arg_130_1.talkMaxDuration = var_133_50
					var_133_43 = var_133_43 + 0.3

					if var_133_50 + var_133_43 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_50 + var_133_43
					end
				end

				arg_130_1.text_.text = var_133_47
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_51 = var_133_43 + 0.3
			local var_133_52 = math.max(var_133_44, arg_130_1.talkMaxDuration)

			if var_133_51 <= arg_130_1.time_ and arg_130_1.time_ < var_133_51 + var_133_52 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_51) / var_133_52

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_51 + var_133_52 and arg_130_1.time_ < var_133_51 + var_133_52 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST18a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST18a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST18a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.6,
				className = "StoryMoveNode",
				startTime = 5.51666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play116081031 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 116081031
		arg_136_1.duration_ = 7

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play116081032(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_1 = 1

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_1 then
				local var_139_2 = (arg_136_1.time_ - var_139_0) / var_139_1
				local var_139_3 = Color.New(0, 0, 0)

				var_139_3.a = Mathf.Lerp(0, 1, var_139_2)
				arg_136_1.mask_.color = var_139_3
			end

			if arg_136_1.time_ >= var_139_0 + var_139_1 and arg_136_1.time_ < var_139_0 + var_139_1 + arg_139_0 then
				local var_139_4 = Color.New(0, 0, 0)

				var_139_4.a = 1
				arg_136_1.mask_.color = var_139_4
			end

			local var_139_5 = 1

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_6 = 1

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 then
				local var_139_7 = (arg_136_1.time_ - var_139_5) / var_139_6
				local var_139_8 = Color.New(0, 0, 0)

				var_139_8.a = Mathf.Lerp(1, 0, var_139_7)
				arg_136_1.mask_.color = var_139_8
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 then
				local var_139_9 = Color.New(0, 0, 0)
				local var_139_10 = 0

				arg_136_1.mask_.enabled = false
				var_139_9.a = var_139_10
				arg_136_1.mask_.color = var_139_9
			end

			if arg_136_1.frameCnt_ <= 1 then
				arg_136_1.dialog_:SetActive(false)
			end

			local var_139_11 = 2
			local var_139_12 = 1.025

			if var_139_11 < arg_136_1.time_ and arg_136_1.time_ <= var_139_11 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0

				arg_136_1.dialog_:SetActive(true)

				arg_136_1.dialogCg_.alpha = 0

				local var_139_13 = LeanTween.value(arg_136_1.dialog_, 0, 1, 0.3)

				var_139_13:setOnUpdate(LuaHelper.FloatAction(function(arg_140_0)
					arg_136_1.dialogCg_.alpha = arg_140_0
				end))
				var_139_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_136_1.dialog_)
					var_139_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_136_1.duration_ = arg_136_1.duration_ + 0.3

				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_14 = arg_136_1:GetWordFromCfg(116081031)
				local var_139_15 = arg_136_1:FormatText(var_139_14.content)

				arg_136_1.text_.text = var_139_15

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_16 = 41
				local var_139_17 = utf8.len(var_139_15)
				local var_139_18 = var_139_16 <= 0 and var_139_12 or var_139_12 * (var_139_17 / var_139_16)

				if var_139_18 > 0 and var_139_12 < var_139_18 then
					arg_136_1.talkMaxDuration = var_139_18
					var_139_11 = var_139_11 + 0.3

					if var_139_18 + var_139_11 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_18 + var_139_11
					end
				end

				arg_136_1.text_.text = var_139_15
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_19 = var_139_11 + 0.3
			local var_139_20 = math.max(var_139_12, arg_136_1.talkMaxDuration)

			if var_139_19 <= arg_136_1.time_ and arg_136_1.time_ < var_139_19 + var_139_20 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_19) / var_139_20

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_19 + var_139_20 and arg_136_1.time_ < var_139_19 + var_139_20 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play116081032 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 116081032
		arg_142_1.duration_ = 4.77

		local var_142_0 = {
			zh = 4.766,
			ja = 3.5
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
				arg_142_0:Play116081033(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["10025ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect10025ui_story == nil then
				arg_142_1.var_.characterEffect10025ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.2

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect10025ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect10025ui_story then
				arg_142_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_145_4 = arg_142_1.actors_["10025ui_story"].transform
			local var_145_5 = 0

			if var_145_5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1.var_.moveOldPos10025ui_story = var_145_4.localPosition
			end

			local var_145_6 = 0.001

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_6 then
				local var_145_7 = (arg_142_1.time_ - var_145_5) / var_145_6
				local var_145_8 = Vector3.New(0, -1.1, -5.9)

				var_145_4.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10025ui_story, var_145_8, var_145_7)

				local var_145_9 = manager.ui.mainCamera.transform.position - var_145_4.position

				var_145_4.forward = Vector3.New(var_145_9.x, var_145_9.y, var_145_9.z)

				local var_145_10 = var_145_4.localEulerAngles

				var_145_10.z = 0
				var_145_10.x = 0
				var_145_4.localEulerAngles = var_145_10
			end

			if arg_142_1.time_ >= var_145_5 + var_145_6 and arg_142_1.time_ < var_145_5 + var_145_6 + arg_145_0 then
				var_145_4.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_145_11 = manager.ui.mainCamera.transform.position - var_145_4.position

				var_145_4.forward = Vector3.New(var_145_11.x, var_145_11.y, var_145_11.z)

				local var_145_12 = var_145_4.localEulerAngles

				var_145_12.z = 0
				var_145_12.x = 0
				var_145_4.localEulerAngles = var_145_12
			end

			local var_145_13 = 0

			if var_145_13 < arg_142_1.time_ and arg_142_1.time_ <= var_145_13 + arg_145_0 then
				arg_142_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_1")
			end

			local var_145_14 = 0

			if var_145_14 < arg_142_1.time_ and arg_142_1.time_ <= var_145_14 + arg_145_0 then
				arg_142_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_145_15 = 0
			local var_145_16 = 0.275

			if var_145_15 < arg_142_1.time_ and arg_142_1.time_ <= var_145_15 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_17 = arg_142_1:FormatText(StoryNameCfg[328].name)

				arg_142_1.leftNameTxt_.text = var_145_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_18 = arg_142_1:GetWordFromCfg(116081032)
				local var_145_19 = arg_142_1:FormatText(var_145_18.content)

				arg_142_1.text_.text = var_145_19

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_20 = 11
				local var_145_21 = utf8.len(var_145_19)
				local var_145_22 = var_145_20 <= 0 and var_145_16 or var_145_16 * (var_145_21 / var_145_20)

				if var_145_22 > 0 and var_145_16 < var_145_22 then
					arg_142_1.talkMaxDuration = var_145_22

					if var_145_22 + var_145_15 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_22 + var_145_15
					end
				end

				arg_142_1.text_.text = var_145_19
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081032", "story_v_out_116081.awb") ~= 0 then
					local var_145_23 = manager.audio:GetVoiceLength("story_v_out_116081", "116081032", "story_v_out_116081.awb") / 1000

					if var_145_23 + var_145_15 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_23 + var_145_15
					end

					if var_145_18.prefab_name ~= "" and arg_142_1.actors_[var_145_18.prefab_name] ~= nil then
						local var_145_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_18.prefab_name].transform, "story_v_out_116081", "116081032", "story_v_out_116081.awb")

						arg_142_1:RecordAudio("116081032", var_145_24)
						arg_142_1:RecordAudio("116081032", var_145_24)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_116081", "116081032", "story_v_out_116081.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_116081", "116081032", "story_v_out_116081.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_25 = math.max(var_145_16, arg_142_1.talkMaxDuration)

			if var_145_15 <= arg_142_1.time_ and arg_142_1.time_ < var_145_15 + var_145_25 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_15) / var_145_25

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_15 + var_145_25 and arg_142_1.time_ < var_145_15 + var_145_25 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play116081033 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 116081033
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play116081034(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["10025ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect10025ui_story == nil then
				arg_146_1.var_.characterEffect10025ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.2

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect10025ui_story and not isNil(var_149_0) then
					local var_149_4 = Mathf.Lerp(0, 0.5, var_149_3)

					arg_146_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_146_1.var_.characterEffect10025ui_story.fillRatio = var_149_4
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect10025ui_story then
				local var_149_5 = 0.5

				arg_146_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_146_1.var_.characterEffect10025ui_story.fillRatio = var_149_5
			end

			local var_149_6 = 0
			local var_149_7 = 0.375

			if var_149_6 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_8 = arg_146_1:FormatText(StoryNameCfg[7].name)

				arg_146_1.leftNameTxt_.text = var_149_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_9 = arg_146_1:GetWordFromCfg(116081033)
				local var_149_10 = arg_146_1:FormatText(var_149_9.content)

				arg_146_1.text_.text = var_149_10

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_11 = 15
				local var_149_12 = utf8.len(var_149_10)
				local var_149_13 = var_149_11 <= 0 and var_149_7 or var_149_7 * (var_149_12 / var_149_11)

				if var_149_13 > 0 and var_149_7 < var_149_13 then
					arg_146_1.talkMaxDuration = var_149_13

					if var_149_13 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_13 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_10
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_14 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_14 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_14

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_14 and arg_146_1.time_ < var_149_6 + var_149_14 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play116081034 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 116081034
		arg_150_1.duration_ = 4.87

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play116081035(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.mask_.enabled = true
				arg_150_1.mask_.raycastTarget = true

				arg_150_1:SetGaussion(false)
			end

			local var_153_1 = 2

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_1 then
				local var_153_2 = (arg_150_1.time_ - var_153_0) / var_153_1
				local var_153_3 = Color.New(0, 0, 0)

				var_153_3.a = Mathf.Lerp(0, 1, var_153_2)
				arg_150_1.mask_.color = var_153_3
			end

			if arg_150_1.time_ >= var_153_0 + var_153_1 and arg_150_1.time_ < var_153_0 + var_153_1 + arg_153_0 then
				local var_153_4 = Color.New(0, 0, 0)

				var_153_4.a = 1
				arg_150_1.mask_.color = var_153_4
			end

			local var_153_5 = 2

			if var_153_5 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 then
				arg_150_1.mask_.enabled = true
				arg_150_1.mask_.raycastTarget = true

				arg_150_1:SetGaussion(false)
			end

			local var_153_6 = 0.0166666666666667

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_6 then
				local var_153_7 = (arg_150_1.time_ - var_153_5) / var_153_6
				local var_153_8 = Color.New(0, 0, 0)

				var_153_8.a = Mathf.Lerp(1, 0, var_153_7)
				arg_150_1.mask_.color = var_153_8
			end

			if arg_150_1.time_ >= var_153_5 + var_153_6 and arg_150_1.time_ < var_153_5 + var_153_6 + arg_153_0 then
				local var_153_9 = Color.New(0, 0, 0)
				local var_153_10 = 0

				arg_150_1.mask_.enabled = false
				var_153_9.a = var_153_10
				arg_150_1.mask_.color = var_153_9
			end

			local var_153_11 = "STblack"

			if arg_150_1.bgs_[var_153_11] == nil then
				local var_153_12 = Object.Instantiate(arg_150_1.paintGo_)

				var_153_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_153_11)
				var_153_12.name = var_153_11
				var_153_12.transform.parent = arg_150_1.stage_.transform
				var_153_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.bgs_[var_153_11] = var_153_12
			end

			local var_153_13 = 2

			if var_153_13 < arg_150_1.time_ and arg_150_1.time_ <= var_153_13 + arg_153_0 then
				local var_153_14 = manager.ui.mainCamera.transform.localPosition
				local var_153_15 = Vector3.New(0, 0, 10) + Vector3.New(var_153_14.x, var_153_14.y, 0)
				local var_153_16 = arg_150_1.bgs_.STblack

				var_153_16.transform.localPosition = var_153_15
				var_153_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_153_17 = var_153_16:GetComponent("SpriteRenderer")

				if var_153_17 and var_153_17.sprite then
					local var_153_18 = (var_153_16.transform.localPosition - var_153_14).z
					local var_153_19 = manager.ui.mainCameraCom_
					local var_153_20 = 2 * var_153_18 * Mathf.Tan(var_153_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_153_21 = var_153_20 * var_153_19.aspect
					local var_153_22 = var_153_17.sprite.bounds.size.x
					local var_153_23 = var_153_17.sprite.bounds.size.y
					local var_153_24 = var_153_21 / var_153_22
					local var_153_25 = var_153_20 / var_153_23
					local var_153_26 = var_153_25 < var_153_24 and var_153_24 or var_153_25

					var_153_16.transform.localScale = Vector3.New(var_153_26, var_153_26, 0)
				end

				for iter_153_0, iter_153_1 in pairs(arg_150_1.bgs_) do
					if iter_153_0 ~= "STblack" then
						iter_153_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_153_27 = 2

			if var_153_27 < arg_150_1.time_ and arg_150_1.time_ <= var_153_27 + arg_153_0 then
				arg_150_1.fswbg_:SetActive(true)
				arg_150_1.dialog_:SetActive(false)

				arg_150_1.fswtw_.percent = 0

				local var_153_28 = arg_150_1:GetWordFromCfg(116081034)
				local var_153_29 = arg_150_1:FormatText(var_153_28.content)

				arg_150_1.fswt_.text = var_153_29

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.fswt_)

				arg_150_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_150_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_150_1.fswtw_:SetDirty()

				arg_150_1.typewritterCharCountI18N = 0

				SetActive(arg_150_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_150_1:ShowNextGo(false)
			end

			local var_153_30 = 2.01666666666667

			if var_153_30 < arg_150_1.time_ and arg_150_1.time_ <= var_153_30 + arg_153_0 then
				arg_150_1.var_.oldValueTypewriter = arg_150_1.fswtw_.percent

				SetActive(arg_150_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_150_1:ShowNextGo(false)
			end

			local var_153_31 = 17
			local var_153_32 = 1.13333333333333
			local var_153_33 = arg_150_1:GetWordFromCfg(116081034)
			local var_153_34 = arg_150_1:FormatText(var_153_33.content)
			local var_153_35, var_153_36 = arg_150_1:GetPercentByPara(var_153_34, 1)

			if var_153_30 < arg_150_1.time_ and arg_150_1.time_ <= var_153_30 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0

				local var_153_37 = var_153_31 <= 0 and var_153_32 or var_153_32 * ((var_153_36 - arg_150_1.typewritterCharCountI18N) / var_153_31)

				if var_153_37 > 0 and var_153_32 < var_153_37 then
					arg_150_1.talkMaxDuration = var_153_37

					if var_153_37 + var_153_30 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_37 + var_153_30
					end
				end
			end

			local var_153_38 = 1.13333333333333
			local var_153_39 = math.max(var_153_38, arg_150_1.talkMaxDuration)

			if var_153_30 <= arg_150_1.time_ and arg_150_1.time_ < var_153_30 + var_153_39 then
				local var_153_40 = (arg_150_1.time_ - var_153_30) / var_153_39

				arg_150_1.fswtw_.percent = Mathf.Lerp(arg_150_1.var_.oldValueTypewriter, var_153_35, var_153_40)
				arg_150_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_150_1.fswtw_:SetDirty()
			end

			if arg_150_1.time_ >= var_153_30 + var_153_39 and arg_150_1.time_ < var_153_30 + var_153_39 + arg_153_0 then
				arg_150_1.fswtw_.percent = var_153_35

				arg_150_1.fswtw_:SetDirty()
				arg_150_1:ShowNextGo(true)

				arg_150_1.typewritterCharCountI18N = var_153_36
			end

			local var_153_41 = 2

			if var_153_41 < arg_150_1.time_ and arg_150_1.time_ <= var_153_41 + arg_153_0 then
				local var_153_42 = arg_150_1.fswbg_.transform:Find("textbox/adapt/content") or arg_150_1.fswbg_.transform:Find("textbox/content")
				local var_153_43 = arg_150_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_153_44 = var_153_42:GetComponent("Text")
				local var_153_45 = var_153_42:GetComponent("RectTransform")

				var_153_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_153_45.offsetMin = Vector2.New(0, 0)
				var_153_45.offsetMax = Vector2.New(0, 0)
			end

			local var_153_46 = arg_150_1.actors_["10025ui_story"].transform
			local var_153_47 = 1.9

			if var_153_47 < arg_150_1.time_ and arg_150_1.time_ <= var_153_47 + arg_153_0 then
				arg_150_1.var_.moveOldPos10025ui_story = var_153_46.localPosition
			end

			local var_153_48 = 0.001

			if var_153_47 <= arg_150_1.time_ and arg_150_1.time_ < var_153_47 + var_153_48 then
				local var_153_49 = (arg_150_1.time_ - var_153_47) / var_153_48
				local var_153_50 = Vector3.New(0, 100, 0)

				var_153_46.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10025ui_story, var_153_50, var_153_49)

				local var_153_51 = manager.ui.mainCamera.transform.position - var_153_46.position

				var_153_46.forward = Vector3.New(var_153_51.x, var_153_51.y, var_153_51.z)

				local var_153_52 = var_153_46.localEulerAngles

				var_153_52.z = 0
				var_153_52.x = 0
				var_153_46.localEulerAngles = var_153_52
			end

			if arg_150_1.time_ >= var_153_47 + var_153_48 and arg_150_1.time_ < var_153_47 + var_153_48 + arg_153_0 then
				var_153_46.localPosition = Vector3.New(0, 100, 0)

				local var_153_53 = manager.ui.mainCamera.transform.position - var_153_46.position

				var_153_46.forward = Vector3.New(var_153_53.x, var_153_53.y, var_153_53.z)

				local var_153_54 = var_153_46.localEulerAngles

				var_153_54.z = 0
				var_153_54.x = 0
				var_153_46.localEulerAngles = var_153_54
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play116081035 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 116081035
		arg_154_1.duration_ = 7

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play116081036(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				local var_157_1 = manager.ui.mainCamera.transform.localPosition
				local var_157_2 = Vector3.New(0, 0, 10) + Vector3.New(var_157_1.x, var_157_1.y, 0)
				local var_157_3 = arg_154_1.bgs_.ST18a

				var_157_3.transform.localPosition = var_157_2
				var_157_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_157_4 = var_157_3:GetComponent("SpriteRenderer")

				if var_157_4 and var_157_4.sprite then
					local var_157_5 = (var_157_3.transform.localPosition - var_157_1).z
					local var_157_6 = manager.ui.mainCameraCom_
					local var_157_7 = 2 * var_157_5 * Mathf.Tan(var_157_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_157_8 = var_157_7 * var_157_6.aspect
					local var_157_9 = var_157_4.sprite.bounds.size.x
					local var_157_10 = var_157_4.sprite.bounds.size.y
					local var_157_11 = var_157_8 / var_157_9
					local var_157_12 = var_157_7 / var_157_10
					local var_157_13 = var_157_12 < var_157_11 and var_157_11 or var_157_12

					var_157_3.transform.localScale = Vector3.New(var_157_13, var_157_13, 0)
				end

				for iter_157_0, iter_157_1 in pairs(arg_154_1.bgs_) do
					if iter_157_0 ~= "ST18a" then
						iter_157_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_157_14 = arg_154_1.bgs_.ST18a
			local var_157_15 = 0

			if var_157_15 < arg_154_1.time_ and arg_154_1.time_ <= var_157_15 + arg_157_0 then
				local var_157_16 = var_157_14:GetComponent("SpriteRenderer")

				if var_157_16 then
					arg_154_1.var_.alphaOldValueST18a = var_157_16.color.a
					arg_154_1.var_.alphaMatValueST18a = var_157_16
				end

				arg_154_1.var_.alphaOldValueST18a = 0
			end

			local var_157_17 = 2

			if var_157_15 <= arg_154_1.time_ and arg_154_1.time_ < var_157_15 + var_157_17 then
				local var_157_18 = (arg_154_1.time_ - var_157_15) / var_157_17
				local var_157_19 = Mathf.Lerp(arg_154_1.var_.alphaOldValueST18a, 1, var_157_18)

				if arg_154_1.var_.alphaMatValueST18a then
					local var_157_20 = arg_154_1.var_.alphaMatValueST18a.color

					var_157_20.a = var_157_19
					arg_154_1.var_.alphaMatValueST18a.color = var_157_20
				end
			end

			if arg_154_1.time_ >= var_157_15 + var_157_17 and arg_154_1.time_ < var_157_15 + var_157_17 + arg_157_0 and arg_154_1.var_.alphaMatValueST18a then
				local var_157_21 = arg_154_1.var_.alphaMatValueST18a
				local var_157_22 = var_157_21.color

				var_157_22.a = 1
				var_157_21.color = var_157_22
			end

			local var_157_23 = 0

			if var_157_23 < arg_154_1.time_ and arg_154_1.time_ <= var_157_23 + arg_157_0 then
				arg_154_1.fswbg_:SetActive(false)
				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_154_1:ShowNextGo(false)
			end

			local var_157_24 = arg_154_1.actors_["10025ui_story"].transform
			local var_157_25 = 2

			if var_157_25 < arg_154_1.time_ and arg_154_1.time_ <= var_157_25 + arg_157_0 then
				arg_154_1.var_.moveOldPos10025ui_story = var_157_24.localPosition
			end

			local var_157_26 = 0.001

			if var_157_25 <= arg_154_1.time_ and arg_154_1.time_ < var_157_25 + var_157_26 then
				local var_157_27 = (arg_154_1.time_ - var_157_25) / var_157_26
				local var_157_28 = Vector3.New(0, -1.1, -5.9)

				var_157_24.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10025ui_story, var_157_28, var_157_27)

				local var_157_29 = manager.ui.mainCamera.transform.position - var_157_24.position

				var_157_24.forward = Vector3.New(var_157_29.x, var_157_29.y, var_157_29.z)

				local var_157_30 = var_157_24.localEulerAngles

				var_157_30.z = 0
				var_157_30.x = 0
				var_157_24.localEulerAngles = var_157_30
			end

			if arg_154_1.time_ >= var_157_25 + var_157_26 and arg_154_1.time_ < var_157_25 + var_157_26 + arg_157_0 then
				var_157_24.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_157_31 = manager.ui.mainCamera.transform.position - var_157_24.position

				var_157_24.forward = Vector3.New(var_157_31.x, var_157_31.y, var_157_31.z)

				local var_157_32 = var_157_24.localEulerAngles

				var_157_32.z = 0
				var_157_32.x = 0
				var_157_24.localEulerAngles = var_157_32
			end

			local var_157_33 = 2

			if var_157_33 < arg_154_1.time_ and arg_154_1.time_ <= var_157_33 + arg_157_0 then
				arg_154_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_157_34 = 2

			if var_157_34 < arg_154_1.time_ and arg_154_1.time_ <= var_157_34 + arg_157_0 then
				arg_154_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if arg_154_1.frameCnt_ <= 1 then
				arg_154_1.dialog_:SetActive(false)
			end

			local var_157_35 = 2
			local var_157_36 = 0.425

			if var_157_35 < arg_154_1.time_ and arg_154_1.time_ <= var_157_35 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0

				arg_154_1.dialog_:SetActive(true)

				arg_154_1.dialogCg_.alpha = 0

				local var_157_37 = LeanTween.value(arg_154_1.dialog_, 0, 1, 0.3)

				var_157_37:setOnUpdate(LuaHelper.FloatAction(function(arg_158_0)
					arg_154_1.dialogCg_.alpha = arg_158_0
				end))
				var_157_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_154_1.dialog_)
					var_157_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_154_1.duration_ = arg_154_1.duration_ + 0.3

				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_38 = arg_154_1:FormatText(StoryNameCfg[7].name)

				arg_154_1.leftNameTxt_.text = var_157_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_39 = arg_154_1:GetWordFromCfg(116081035)
				local var_157_40 = arg_154_1:FormatText(var_157_39.content)

				arg_154_1.text_.text = var_157_40

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_41 = 17
				local var_157_42 = utf8.len(var_157_40)
				local var_157_43 = var_157_41 <= 0 and var_157_36 or var_157_36 * (var_157_42 / var_157_41)

				if var_157_43 > 0 and var_157_36 < var_157_43 then
					arg_154_1.talkMaxDuration = var_157_43
					var_157_35 = var_157_35 + 0.3

					if var_157_43 + var_157_35 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_43 + var_157_35
					end
				end

				arg_154_1.text_.text = var_157_40
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_44 = var_157_35 + 0.3
			local var_157_45 = math.max(var_157_36, arg_154_1.talkMaxDuration)

			if var_157_44 <= arg_154_1.time_ and arg_154_1.time_ < var_157_44 + var_157_45 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_44) / var_157_45

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_44 + var_157_45 and arg_154_1.time_ < var_157_44 + var_157_45 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play116081036 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 116081036
		arg_160_1.duration_ = 4.87

		local var_160_0 = {
			zh = 4.866,
			ja = 1.999999999999
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play116081037(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10025ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10025ui_story == nil then
				arg_160_1.var_.characterEffect10025ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.2

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect10025ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10025ui_story then
				arg_160_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_163_4 = arg_160_1.actors_["10025ui_story"].transform
			local var_163_5 = 0

			if var_163_5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 then
				arg_160_1.var_.moveOldPos10025ui_story = var_163_4.localPosition
			end

			local var_163_6 = 0.001

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_6 then
				local var_163_7 = (arg_160_1.time_ - var_163_5) / var_163_6
				local var_163_8 = Vector3.New(0, -1.1, -5.9)

				var_163_4.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10025ui_story, var_163_8, var_163_7)

				local var_163_9 = manager.ui.mainCamera.transform.position - var_163_4.position

				var_163_4.forward = Vector3.New(var_163_9.x, var_163_9.y, var_163_9.z)

				local var_163_10 = var_163_4.localEulerAngles

				var_163_10.z = 0
				var_163_10.x = 0
				var_163_4.localEulerAngles = var_163_10
			end

			if arg_160_1.time_ >= var_163_5 + var_163_6 and arg_160_1.time_ < var_163_5 + var_163_6 + arg_163_0 then
				var_163_4.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_163_11 = manager.ui.mainCamera.transform.position - var_163_4.position

				var_163_4.forward = Vector3.New(var_163_11.x, var_163_11.y, var_163_11.z)

				local var_163_12 = var_163_4.localEulerAngles

				var_163_12.z = 0
				var_163_12.x = 0
				var_163_4.localEulerAngles = var_163_12
			end

			local var_163_13 = 0

			if var_163_13 < arg_160_1.time_ and arg_160_1.time_ <= var_163_13 + arg_163_0 then
				arg_160_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_163_14 = 0

			if var_163_14 < arg_160_1.time_ and arg_160_1.time_ <= var_163_14 + arg_163_0 then
				arg_160_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_163_15 = 0
			local var_163_16 = 0.075

			if var_163_15 < arg_160_1.time_ and arg_160_1.time_ <= var_163_15 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_17 = arg_160_1:FormatText(StoryNameCfg[328].name)

				arg_160_1.leftNameTxt_.text = var_163_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_18 = arg_160_1:GetWordFromCfg(116081036)
				local var_163_19 = arg_160_1:FormatText(var_163_18.content)

				arg_160_1.text_.text = var_163_19

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_20 = 3
				local var_163_21 = utf8.len(var_163_19)
				local var_163_22 = var_163_20 <= 0 and var_163_16 or var_163_16 * (var_163_21 / var_163_20)

				if var_163_22 > 0 and var_163_16 < var_163_22 then
					arg_160_1.talkMaxDuration = var_163_22

					if var_163_22 + var_163_15 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_22 + var_163_15
					end
				end

				arg_160_1.text_.text = var_163_19
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081036", "story_v_out_116081.awb") ~= 0 then
					local var_163_23 = manager.audio:GetVoiceLength("story_v_out_116081", "116081036", "story_v_out_116081.awb") / 1000

					if var_163_23 + var_163_15 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_23 + var_163_15
					end

					if var_163_18.prefab_name ~= "" and arg_160_1.actors_[var_163_18.prefab_name] ~= nil then
						local var_163_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_18.prefab_name].transform, "story_v_out_116081", "116081036", "story_v_out_116081.awb")

						arg_160_1:RecordAudio("116081036", var_163_24)
						arg_160_1:RecordAudio("116081036", var_163_24)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_116081", "116081036", "story_v_out_116081.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_116081", "116081036", "story_v_out_116081.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_25 = math.max(var_163_16, arg_160_1.talkMaxDuration)

			if var_163_15 <= arg_160_1.time_ and arg_160_1.time_ < var_163_15 + var_163_25 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_15) / var_163_25

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_15 + var_163_25 and arg_160_1.time_ < var_163_15 + var_163_25 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play116081037 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 116081037
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play116081038(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["10025ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos10025ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(0, 100, 0)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10025ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0, 100, 0)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = 0
			local var_167_10 = 1.075

			if var_167_9 < arg_164_1.time_ and arg_164_1.time_ <= var_167_9 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_11 = arg_164_1:GetWordFromCfg(116081037)
				local var_167_12 = arg_164_1:FormatText(var_167_11.content)

				arg_164_1.text_.text = var_167_12

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_13 = 43
				local var_167_14 = utf8.len(var_167_12)
				local var_167_15 = var_167_13 <= 0 and var_167_10 or var_167_10 * (var_167_14 / var_167_13)

				if var_167_15 > 0 and var_167_10 < var_167_15 then
					arg_164_1.talkMaxDuration = var_167_15

					if var_167_15 + var_167_9 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_15 + var_167_9
					end
				end

				arg_164_1.text_.text = var_167_12
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_16 = math.max(var_167_10, arg_164_1.talkMaxDuration)

			if var_167_9 <= arg_164_1.time_ and arg_164_1.time_ < var_167_9 + var_167_16 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_9) / var_167_16

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_9 + var_167_16 and arg_164_1.time_ < var_167_9 + var_167_16 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play116081038 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 116081038
		arg_168_1.duration_ = 4.8

		local var_168_0 = {
			zh = 4.8,
			ja = 2.533
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
				arg_168_0:Play116081039(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10025ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10025ui_story == nil then
				arg_168_1.var_.characterEffect10025ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect10025ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10025ui_story then
				arg_168_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_171_4 = arg_168_1.actors_["10025ui_story"].transform
			local var_171_5 = 0

			if var_171_5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1.var_.moveOldPos10025ui_story = var_171_4.localPosition
			end

			local var_171_6 = 0.001

			if var_171_5 <= arg_168_1.time_ and arg_168_1.time_ < var_171_5 + var_171_6 then
				local var_171_7 = (arg_168_1.time_ - var_171_5) / var_171_6
				local var_171_8 = Vector3.New(0, -1.1, -5.9)

				var_171_4.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10025ui_story, var_171_8, var_171_7)

				local var_171_9 = manager.ui.mainCamera.transform.position - var_171_4.position

				var_171_4.forward = Vector3.New(var_171_9.x, var_171_9.y, var_171_9.z)

				local var_171_10 = var_171_4.localEulerAngles

				var_171_10.z = 0
				var_171_10.x = 0
				var_171_4.localEulerAngles = var_171_10
			end

			if arg_168_1.time_ >= var_171_5 + var_171_6 and arg_168_1.time_ < var_171_5 + var_171_6 + arg_171_0 then
				var_171_4.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_171_11 = manager.ui.mainCamera.transform.position - var_171_4.position

				var_171_4.forward = Vector3.New(var_171_11.x, var_171_11.y, var_171_11.z)

				local var_171_12 = var_171_4.localEulerAngles

				var_171_12.z = 0
				var_171_12.x = 0
				var_171_4.localEulerAngles = var_171_12
			end

			local var_171_13 = 0

			if var_171_13 < arg_168_1.time_ and arg_168_1.time_ <= var_171_13 + arg_171_0 then
				arg_168_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_171_14 = 0

			if var_171_14 < arg_168_1.time_ and arg_168_1.time_ <= var_171_14 + arg_171_0 then
				arg_168_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_171_15 = 0
			local var_171_16 = 0.2

			if var_171_15 < arg_168_1.time_ and arg_168_1.time_ <= var_171_15 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_17 = arg_168_1:FormatText(StoryNameCfg[328].name)

				arg_168_1.leftNameTxt_.text = var_171_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_18 = arg_168_1:GetWordFromCfg(116081038)
				local var_171_19 = arg_168_1:FormatText(var_171_18.content)

				arg_168_1.text_.text = var_171_19

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_20 = 8
				local var_171_21 = utf8.len(var_171_19)
				local var_171_22 = var_171_20 <= 0 and var_171_16 or var_171_16 * (var_171_21 / var_171_20)

				if var_171_22 > 0 and var_171_16 < var_171_22 then
					arg_168_1.talkMaxDuration = var_171_22

					if var_171_22 + var_171_15 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_22 + var_171_15
					end
				end

				arg_168_1.text_.text = var_171_19
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081038", "story_v_out_116081.awb") ~= 0 then
					local var_171_23 = manager.audio:GetVoiceLength("story_v_out_116081", "116081038", "story_v_out_116081.awb") / 1000

					if var_171_23 + var_171_15 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_23 + var_171_15
					end

					if var_171_18.prefab_name ~= "" and arg_168_1.actors_[var_171_18.prefab_name] ~= nil then
						local var_171_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_18.prefab_name].transform, "story_v_out_116081", "116081038", "story_v_out_116081.awb")

						arg_168_1:RecordAudio("116081038", var_171_24)
						arg_168_1:RecordAudio("116081038", var_171_24)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_116081", "116081038", "story_v_out_116081.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_116081", "116081038", "story_v_out_116081.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_25 = math.max(var_171_16, arg_168_1.talkMaxDuration)

			if var_171_15 <= arg_168_1.time_ and arg_168_1.time_ < var_171_15 + var_171_25 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_15) / var_171_25

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_15 + var_171_25 and arg_168_1.time_ < var_171_15 + var_171_25 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play116081039 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 116081039
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play116081040(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10025ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10025ui_story == nil then
				arg_172_1.var_.characterEffect10025ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect10025ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_172_1.var_.characterEffect10025ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10025ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_172_1.var_.characterEffect10025ui_story.fillRatio = var_175_5
			end

			local var_175_6 = 0
			local var_175_7 = 0.575

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

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_9 = arg_172_1:GetWordFromCfg(116081039)
				local var_175_10 = arg_172_1:FormatText(var_175_9.content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 23
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
	Play116081040 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 116081040
		arg_176_1.duration_ = 8.93

		local var_176_0 = {
			zh = 8.933,
			ja = 8.333
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
				arg_176_0:Play116081041(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10025ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10025ui_story == nil then
				arg_176_1.var_.characterEffect10025ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect10025ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10025ui_story then
				arg_176_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_179_4 = arg_176_1.actors_["10025ui_story"].transform
			local var_179_5 = 0

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1.var_.moveOldPos10025ui_story = var_179_4.localPosition
			end

			local var_179_6 = 0.1

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_6 then
				local var_179_7 = (arg_176_1.time_ - var_179_5) / var_179_6
				local var_179_8 = Vector3.New(0, -1.1, -5.9)

				var_179_4.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10025ui_story, var_179_8, var_179_7)

				local var_179_9 = manager.ui.mainCamera.transform.position - var_179_4.position

				var_179_4.forward = Vector3.New(var_179_9.x, var_179_9.y, var_179_9.z)

				local var_179_10 = var_179_4.localEulerAngles

				var_179_10.z = 0
				var_179_10.x = 0
				var_179_4.localEulerAngles = var_179_10
			end

			if arg_176_1.time_ >= var_179_5 + var_179_6 and arg_176_1.time_ < var_179_5 + var_179_6 + arg_179_0 then
				var_179_4.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_179_11 = manager.ui.mainCamera.transform.position - var_179_4.position

				var_179_4.forward = Vector3.New(var_179_11.x, var_179_11.y, var_179_11.z)

				local var_179_12 = var_179_4.localEulerAngles

				var_179_12.z = 0
				var_179_12.x = 0
				var_179_4.localEulerAngles = var_179_12
			end

			local var_179_13 = 0

			if var_179_13 < arg_176_1.time_ and arg_176_1.time_ <= var_179_13 + arg_179_0 then
				arg_176_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action483")
			end

			local var_179_14 = 0

			if var_179_14 < arg_176_1.time_ and arg_176_1.time_ <= var_179_14 + arg_179_0 then
				arg_176_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_179_15 = 0
			local var_179_16 = 0.625

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_17 = arg_176_1:FormatText(StoryNameCfg[328].name)

				arg_176_1.leftNameTxt_.text = var_179_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_18 = arg_176_1:GetWordFromCfg(116081040)
				local var_179_19 = arg_176_1:FormatText(var_179_18.content)

				arg_176_1.text_.text = var_179_19

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_20 = 25
				local var_179_21 = utf8.len(var_179_19)
				local var_179_22 = var_179_20 <= 0 and var_179_16 or var_179_16 * (var_179_21 / var_179_20)

				if var_179_22 > 0 and var_179_16 < var_179_22 then
					arg_176_1.talkMaxDuration = var_179_22

					if var_179_22 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_22 + var_179_15
					end
				end

				arg_176_1.text_.text = var_179_19
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081040", "story_v_out_116081.awb") ~= 0 then
					local var_179_23 = manager.audio:GetVoiceLength("story_v_out_116081", "116081040", "story_v_out_116081.awb") / 1000

					if var_179_23 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_23 + var_179_15
					end

					if var_179_18.prefab_name ~= "" and arg_176_1.actors_[var_179_18.prefab_name] ~= nil then
						local var_179_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_18.prefab_name].transform, "story_v_out_116081", "116081040", "story_v_out_116081.awb")

						arg_176_1:RecordAudio("116081040", var_179_24)
						arg_176_1:RecordAudio("116081040", var_179_24)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_116081", "116081040", "story_v_out_116081.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_116081", "116081040", "story_v_out_116081.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_25 = math.max(var_179_16, arg_176_1.talkMaxDuration)

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_25 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_15) / var_179_25

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_15 + var_179_25 and arg_176_1.time_ < var_179_15 + var_179_25 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play116081041 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 116081041
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play116081042(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10025ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10025ui_story == nil then
				arg_180_1.var_.characterEffect10025ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect10025ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_180_1.var_.characterEffect10025ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10025ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_180_1.var_.characterEffect10025ui_story.fillRatio = var_183_5
			end

			local var_183_6 = 0
			local var_183_7 = 0.3

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_8 = arg_180_1:FormatText(StoryNameCfg[7].name)

				arg_180_1.leftNameTxt_.text = var_183_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_9 = arg_180_1:GetWordFromCfg(116081041)
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
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_14 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_14 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_14

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_14 and arg_180_1.time_ < var_183_6 + var_183_14 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play116081042 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 116081042
		arg_184_1.duration_ = 11.47

		local var_184_0 = {
			zh = 7.7,
			ja = 11.466
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
				arg_184_0:Play116081043(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10025ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10025ui_story == nil then
				arg_184_1.var_.characterEffect10025ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect10025ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10025ui_story then
				arg_184_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_187_4 = arg_184_1.actors_["10025ui_story"].transform
			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1.var_.moveOldPos10025ui_story = var_187_4.localPosition
			end

			local var_187_6 = 0.001

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_6 then
				local var_187_7 = (arg_184_1.time_ - var_187_5) / var_187_6
				local var_187_8 = Vector3.New(0, -1.1, -5.9)

				var_187_4.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10025ui_story, var_187_8, var_187_7)

				local var_187_9 = manager.ui.mainCamera.transform.position - var_187_4.position

				var_187_4.forward = Vector3.New(var_187_9.x, var_187_9.y, var_187_9.z)

				local var_187_10 = var_187_4.localEulerAngles

				var_187_10.z = 0
				var_187_10.x = 0
				var_187_4.localEulerAngles = var_187_10
			end

			if arg_184_1.time_ >= var_187_5 + var_187_6 and arg_184_1.time_ < var_187_5 + var_187_6 + arg_187_0 then
				var_187_4.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_187_11 = manager.ui.mainCamera.transform.position - var_187_4.position

				var_187_4.forward = Vector3.New(var_187_11.x, var_187_11.y, var_187_11.z)

				local var_187_12 = var_187_4.localEulerAngles

				var_187_12.z = 0
				var_187_12.x = 0
				var_187_4.localEulerAngles = var_187_12
			end

			local var_187_13 = 0

			if var_187_13 < arg_184_1.time_ and arg_184_1.time_ <= var_187_13 + arg_187_0 then
				arg_184_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_187_14 = 0
			local var_187_15 = 0.7

			if var_187_14 < arg_184_1.time_ and arg_184_1.time_ <= var_187_14 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_16 = arg_184_1:FormatText(StoryNameCfg[328].name)

				arg_184_1.leftNameTxt_.text = var_187_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_17 = arg_184_1:GetWordFromCfg(116081042)
				local var_187_18 = arg_184_1:FormatText(var_187_17.content)

				arg_184_1.text_.text = var_187_18

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_19 = 28
				local var_187_20 = utf8.len(var_187_18)
				local var_187_21 = var_187_19 <= 0 and var_187_15 or var_187_15 * (var_187_20 / var_187_19)

				if var_187_21 > 0 and var_187_15 < var_187_21 then
					arg_184_1.talkMaxDuration = var_187_21

					if var_187_21 + var_187_14 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_21 + var_187_14
					end
				end

				arg_184_1.text_.text = var_187_18
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081042", "story_v_out_116081.awb") ~= 0 then
					local var_187_22 = manager.audio:GetVoiceLength("story_v_out_116081", "116081042", "story_v_out_116081.awb") / 1000

					if var_187_22 + var_187_14 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_22 + var_187_14
					end

					if var_187_17.prefab_name ~= "" and arg_184_1.actors_[var_187_17.prefab_name] ~= nil then
						local var_187_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_17.prefab_name].transform, "story_v_out_116081", "116081042", "story_v_out_116081.awb")

						arg_184_1:RecordAudio("116081042", var_187_23)
						arg_184_1:RecordAudio("116081042", var_187_23)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_116081", "116081042", "story_v_out_116081.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_116081", "116081042", "story_v_out_116081.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_24 = math.max(var_187_15, arg_184_1.talkMaxDuration)

			if var_187_14 <= arg_184_1.time_ and arg_184_1.time_ < var_187_14 + var_187_24 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_14) / var_187_24

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_14 + var_187_24 and arg_184_1.time_ < var_187_14 + var_187_24 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play116081043 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 116081043
		arg_188_1.duration_ = 14.83

		local var_188_0 = {
			zh = 10.766,
			ja = 14.833
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play116081044(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action434")
			end

			local var_191_2 = 0
			local var_191_3 = 1.075

			if var_191_2 < arg_188_1.time_ and arg_188_1.time_ <= var_191_2 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_4 = arg_188_1:FormatText(StoryNameCfg[328].name)

				arg_188_1.leftNameTxt_.text = var_191_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_5 = arg_188_1:GetWordFromCfg(116081043)
				local var_191_6 = arg_188_1:FormatText(var_191_5.content)

				arg_188_1.text_.text = var_191_6

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_7 = 43
				local var_191_8 = utf8.len(var_191_6)
				local var_191_9 = var_191_7 <= 0 and var_191_3 or var_191_3 * (var_191_8 / var_191_7)

				if var_191_9 > 0 and var_191_3 < var_191_9 then
					arg_188_1.talkMaxDuration = var_191_9

					if var_191_9 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_9 + var_191_2
					end
				end

				arg_188_1.text_.text = var_191_6
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081043", "story_v_out_116081.awb") ~= 0 then
					local var_191_10 = manager.audio:GetVoiceLength("story_v_out_116081", "116081043", "story_v_out_116081.awb") / 1000

					if var_191_10 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_10 + var_191_2
					end

					if var_191_5.prefab_name ~= "" and arg_188_1.actors_[var_191_5.prefab_name] ~= nil then
						local var_191_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_5.prefab_name].transform, "story_v_out_116081", "116081043", "story_v_out_116081.awb")

						arg_188_1:RecordAudio("116081043", var_191_11)
						arg_188_1:RecordAudio("116081043", var_191_11)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_116081", "116081043", "story_v_out_116081.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_116081", "116081043", "story_v_out_116081.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_12 = math.max(var_191_3, arg_188_1.talkMaxDuration)

			if var_191_2 <= arg_188_1.time_ and arg_188_1.time_ < var_191_2 + var_191_12 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_2) / var_191_12

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_2 + var_191_12 and arg_188_1.time_ < var_191_2 + var_191_12 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play116081044 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 116081044
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play116081045(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10025ui_story"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos10025ui_story = var_195_0.localPosition
			end

			local var_195_2 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2
				local var_195_4 = Vector3.New(0, 100, 0)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10025ui_story, var_195_4, var_195_3)

				local var_195_5 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_5.x, var_195_5.y, var_195_5.z)

				local var_195_6 = var_195_0.localEulerAngles

				var_195_6.z = 0
				var_195_6.x = 0
				var_195_0.localEulerAngles = var_195_6
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(0, 100, 0)

				local var_195_7 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_7.x, var_195_7.y, var_195_7.z)

				local var_195_8 = var_195_0.localEulerAngles

				var_195_8.z = 0
				var_195_8.x = 0
				var_195_0.localEulerAngles = var_195_8
			end

			local var_195_9 = 0
			local var_195_10 = 0.275

			if var_195_9 < arg_192_1.time_ and arg_192_1.time_ <= var_195_9 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_11 = arg_192_1:GetWordFromCfg(116081044)
				local var_195_12 = arg_192_1:FormatText(var_195_11.content)

				arg_192_1.text_.text = var_195_12

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_13 = 11
				local var_195_14 = utf8.len(var_195_12)
				local var_195_15 = var_195_13 <= 0 and var_195_10 or var_195_10 * (var_195_14 / var_195_13)

				if var_195_15 > 0 and var_195_10 < var_195_15 then
					arg_192_1.talkMaxDuration = var_195_15

					if var_195_15 + var_195_9 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_15 + var_195_9
					end
				end

				arg_192_1.text_.text = var_195_12
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_16 = math.max(var_195_10, arg_192_1.talkMaxDuration)

			if var_195_9 <= arg_192_1.time_ and arg_192_1.time_ < var_195_9 + var_195_16 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_9) / var_195_16

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_9 + var_195_16 and arg_192_1.time_ < var_195_9 + var_195_16 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play116081045 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 116081045
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play116081046(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.5

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_2 = arg_196_1:GetWordFromCfg(116081045)
				local var_199_3 = arg_196_1:FormatText(var_199_2.content)

				arg_196_1.text_.text = var_199_3

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_4 = 20
				local var_199_5 = utf8.len(var_199_3)
				local var_199_6 = var_199_4 <= 0 and var_199_1 or var_199_1 * (var_199_5 / var_199_4)

				if var_199_6 > 0 and var_199_1 < var_199_6 then
					arg_196_1.talkMaxDuration = var_199_6

					if var_199_6 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_6 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_3
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_7 and arg_196_1.time_ < var_199_0 + var_199_7 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play116081046 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 116081046
		arg_200_1.duration_ = 11.2

		local var_200_0 = {
			zh = 8.9,
			ja = 11.2
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play116081047(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10025ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect10025ui_story == nil then
				arg_200_1.var_.characterEffect10025ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.2

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect10025ui_story and not isNil(var_203_0) then
					arg_200_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect10025ui_story then
				arg_200_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_203_4 = arg_200_1.actors_["10025ui_story"].transform
			local var_203_5 = 0

			if var_203_5 < arg_200_1.time_ and arg_200_1.time_ <= var_203_5 + arg_203_0 then
				arg_200_1.var_.moveOldPos10025ui_story = var_203_4.localPosition
			end

			local var_203_6 = 0.001

			if var_203_5 <= arg_200_1.time_ and arg_200_1.time_ < var_203_5 + var_203_6 then
				local var_203_7 = (arg_200_1.time_ - var_203_5) / var_203_6
				local var_203_8 = Vector3.New(0, -1.1, -5.9)

				var_203_4.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10025ui_story, var_203_8, var_203_7)

				local var_203_9 = manager.ui.mainCamera.transform.position - var_203_4.position

				var_203_4.forward = Vector3.New(var_203_9.x, var_203_9.y, var_203_9.z)

				local var_203_10 = var_203_4.localEulerAngles

				var_203_10.z = 0
				var_203_10.x = 0
				var_203_4.localEulerAngles = var_203_10
			end

			if arg_200_1.time_ >= var_203_5 + var_203_6 and arg_200_1.time_ < var_203_5 + var_203_6 + arg_203_0 then
				var_203_4.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_203_11 = manager.ui.mainCamera.transform.position - var_203_4.position

				var_203_4.forward = Vector3.New(var_203_11.x, var_203_11.y, var_203_11.z)

				local var_203_12 = var_203_4.localEulerAngles

				var_203_12.z = 0
				var_203_12.x = 0
				var_203_4.localEulerAngles = var_203_12
			end

			local var_203_13 = 0

			if var_203_13 < arg_200_1.time_ and arg_200_1.time_ <= var_203_13 + arg_203_0 then
				arg_200_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_203_14 = 0

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				arg_200_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_203_15 = 0
			local var_203_16 = 0.8

			if var_203_15 < arg_200_1.time_ and arg_200_1.time_ <= var_203_15 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_17 = arg_200_1:FormatText(StoryNameCfg[328].name)

				arg_200_1.leftNameTxt_.text = var_203_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_18 = arg_200_1:GetWordFromCfg(116081046)
				local var_203_19 = arg_200_1:FormatText(var_203_18.content)

				arg_200_1.text_.text = var_203_19

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_20 = 32
				local var_203_21 = utf8.len(var_203_19)
				local var_203_22 = var_203_20 <= 0 and var_203_16 or var_203_16 * (var_203_21 / var_203_20)

				if var_203_22 > 0 and var_203_16 < var_203_22 then
					arg_200_1.talkMaxDuration = var_203_22

					if var_203_22 + var_203_15 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_22 + var_203_15
					end
				end

				arg_200_1.text_.text = var_203_19
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081046", "story_v_out_116081.awb") ~= 0 then
					local var_203_23 = manager.audio:GetVoiceLength("story_v_out_116081", "116081046", "story_v_out_116081.awb") / 1000

					if var_203_23 + var_203_15 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_23 + var_203_15
					end

					if var_203_18.prefab_name ~= "" and arg_200_1.actors_[var_203_18.prefab_name] ~= nil then
						local var_203_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_18.prefab_name].transform, "story_v_out_116081", "116081046", "story_v_out_116081.awb")

						arg_200_1:RecordAudio("116081046", var_203_24)
						arg_200_1:RecordAudio("116081046", var_203_24)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_116081", "116081046", "story_v_out_116081.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_116081", "116081046", "story_v_out_116081.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_25 = math.max(var_203_16, arg_200_1.talkMaxDuration)

			if var_203_15 <= arg_200_1.time_ and arg_200_1.time_ < var_203_15 + var_203_25 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_15) / var_203_25

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_15 + var_203_25 and arg_200_1.time_ < var_203_15 + var_203_25 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play116081047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 116081047
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play116081048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["10025ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect10025ui_story == nil then
				arg_204_1.var_.characterEffect10025ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.2

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect10025ui_story and not isNil(var_207_0) then
					local var_207_4 = Mathf.Lerp(0, 0.5, var_207_3)

					arg_204_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_204_1.var_.characterEffect10025ui_story.fillRatio = var_207_4
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect10025ui_story then
				local var_207_5 = 0.5

				arg_204_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_204_1.var_.characterEffect10025ui_story.fillRatio = var_207_5
			end

			local var_207_6 = 0
			local var_207_7 = 0.525

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

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_9 = arg_204_1:GetWordFromCfg(116081047)
				local var_207_10 = arg_204_1:FormatText(var_207_9.content)

				arg_204_1.text_.text = var_207_10

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_11 = 21
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
	Play116081048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 116081048
		arg_208_1.duration_ = 7

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play116081049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = "SK0109"

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
				local var_211_5 = arg_208_1.bgs_.SK0109

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
					if iter_211_0 ~= "SK0109" then
						iter_211_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_211_16 = 0

			if var_211_16 < arg_208_1.time_ and arg_208_1.time_ <= var_211_16 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_17 = 2

			if var_211_16 <= arg_208_1.time_ and arg_208_1.time_ < var_211_16 + var_211_17 then
				local var_211_18 = (arg_208_1.time_ - var_211_16) / var_211_17
				local var_211_19 = Color.New(0, 0, 0)

				var_211_19.a = Mathf.Lerp(0, 1, var_211_18)
				arg_208_1.mask_.color = var_211_19
			end

			if arg_208_1.time_ >= var_211_16 + var_211_17 and arg_208_1.time_ < var_211_16 + var_211_17 + arg_211_0 then
				local var_211_20 = Color.New(0, 0, 0)

				var_211_20.a = 1
				arg_208_1.mask_.color = var_211_20
			end

			local var_211_21 = 2

			if var_211_21 < arg_208_1.time_ and arg_208_1.time_ <= var_211_21 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_22 = 2

			if var_211_21 <= arg_208_1.time_ and arg_208_1.time_ < var_211_21 + var_211_22 then
				local var_211_23 = (arg_208_1.time_ - var_211_21) / var_211_22
				local var_211_24 = Color.New(1, 1, 1)

				var_211_24.a = Mathf.Lerp(1, 0, var_211_23)
				arg_208_1.mask_.color = var_211_24
			end

			if arg_208_1.time_ >= var_211_21 + var_211_22 and arg_208_1.time_ < var_211_21 + var_211_22 + arg_211_0 then
				local var_211_25 = Color.New(1, 1, 1)
				local var_211_26 = 0

				arg_208_1.mask_.enabled = false
				var_211_25.a = var_211_26
				arg_208_1.mask_.color = var_211_25
			end

			local var_211_27 = arg_208_1.actors_["10025ui_story"].transform
			local var_211_28 = 1.966

			if var_211_28 < arg_208_1.time_ and arg_208_1.time_ <= var_211_28 + arg_211_0 then
				arg_208_1.var_.moveOldPos10025ui_story = var_211_27.localPosition
			end

			local var_211_29 = 0.001

			if var_211_28 <= arg_208_1.time_ and arg_208_1.time_ < var_211_28 + var_211_29 then
				local var_211_30 = (arg_208_1.time_ - var_211_28) / var_211_29
				local var_211_31 = Vector3.New(0, 100, 0)

				var_211_27.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10025ui_story, var_211_31, var_211_30)

				local var_211_32 = manager.ui.mainCamera.transform.position - var_211_27.position

				var_211_27.forward = Vector3.New(var_211_32.x, var_211_32.y, var_211_32.z)

				local var_211_33 = var_211_27.localEulerAngles

				var_211_33.z = 0
				var_211_33.x = 0
				var_211_27.localEulerAngles = var_211_33
			end

			if arg_208_1.time_ >= var_211_28 + var_211_29 and arg_208_1.time_ < var_211_28 + var_211_29 + arg_211_0 then
				var_211_27.localPosition = Vector3.New(0, 100, 0)

				local var_211_34 = manager.ui.mainCamera.transform.position - var_211_27.position

				var_211_27.forward = Vector3.New(var_211_34.x, var_211_34.y, var_211_34.z)

				local var_211_35 = var_211_27.localEulerAngles

				var_211_35.z = 0
				var_211_35.x = 0
				var_211_27.localEulerAngles = var_211_35
			end

			local var_211_36 = 2
			local var_211_37 = 1

			if var_211_36 < arg_208_1.time_ and arg_208_1.time_ <= var_211_36 + arg_211_0 then
				local var_211_38 = "play"
				local var_211_39 = "effect"

				arg_208_1:AudioAction(var_211_38, var_211_39, "se_story_16", "se_story_16_camera", "")
			end

			local var_211_40 = 2
			local var_211_41 = 0.45

			if var_211_40 < arg_208_1.time_ and arg_208_1.time_ <= var_211_40 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_42 = arg_208_1:GetWordFromCfg(116081048)
				local var_211_43 = arg_208_1:FormatText(var_211_42.content)

				arg_208_1.text_.text = var_211_43

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_44 = 18
				local var_211_45 = utf8.len(var_211_43)
				local var_211_46 = var_211_44 <= 0 and var_211_41 or var_211_41 * (var_211_45 / var_211_44)

				if var_211_46 > 0 and var_211_41 < var_211_46 then
					arg_208_1.talkMaxDuration = var_211_46

					if var_211_46 + var_211_40 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_46 + var_211_40
					end
				end

				arg_208_1.text_.text = var_211_43
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_47 = math.max(var_211_41, arg_208_1.talkMaxDuration)

			if var_211_40 <= arg_208_1.time_ and arg_208_1.time_ < var_211_40 + var_211_47 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_40) / var_211_47

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_40 + var_211_47 and arg_208_1.time_ < var_211_40 + var_211_47 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play116081049 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 116081049
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play116081050(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 1

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_2 = arg_212_1:GetWordFromCfg(116081049)
				local var_215_3 = arg_212_1:FormatText(var_215_2.content)

				arg_212_1.text_.text = var_215_3

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 40
				local var_215_5 = utf8.len(var_215_3)
				local var_215_6 = var_215_4 <= 0 and var_215_1 or var_215_1 * (var_215_5 / var_215_4)

				if var_215_6 > 0 and var_215_1 < var_215_6 then
					arg_212_1.talkMaxDuration = var_215_6

					if var_215_6 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_6 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_3
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_7 and arg_212_1.time_ < var_215_0 + var_215_7 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play116081050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 116081050
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play116081051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0
			local var_219_1 = 0.425

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_2 = arg_216_1:GetWordFromCfg(116081050)
				local var_219_3 = arg_216_1:FormatText(var_219_2.content)

				arg_216_1.text_.text = var_219_3

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_4 = 17
				local var_219_5 = utf8.len(var_219_3)
				local var_219_6 = var_219_4 <= 0 and var_219_1 or var_219_1 * (var_219_5 / var_219_4)

				if var_219_6 > 0 and var_219_1 < var_219_6 then
					arg_216_1.talkMaxDuration = var_219_6

					if var_219_6 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_6 + var_219_0
					end
				end

				arg_216_1.text_.text = var_219_3
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_1, arg_216_1.talkMaxDuration)

			if var_219_0 <= arg_216_1.time_ and arg_216_1.time_ < var_219_0 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_0) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_0 + var_219_7 and arg_216_1.time_ < var_219_0 + var_219_7 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play116081051 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 116081051
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play116081052(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0
			local var_223_1 = 0.525

			if var_223_0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_2 = arg_220_1:GetWordFromCfg(116081051)
				local var_223_3 = arg_220_1:FormatText(var_223_2.content)

				arg_220_1.text_.text = var_223_3

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_4 = 21
				local var_223_5 = utf8.len(var_223_3)
				local var_223_6 = var_223_4 <= 0 and var_223_1 or var_223_1 * (var_223_5 / var_223_4)

				if var_223_6 > 0 and var_223_1 < var_223_6 then
					arg_220_1.talkMaxDuration = var_223_6

					if var_223_6 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_6 + var_223_0
					end
				end

				arg_220_1.text_.text = var_223_3
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_1, arg_220_1.talkMaxDuration)

			if var_223_0 <= arg_220_1.time_ and arg_220_1.time_ < var_223_0 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_0) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_0 + var_223_7 and arg_220_1.time_ < var_223_0 + var_223_7 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play116081052 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 116081052
		arg_224_1.duration_ = 6.17

		local var_224_0 = {
			zh = 2.5,
			ja = 6.166
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play116081053(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0
			local var_227_1 = 0.225

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_2 = arg_224_1:FormatText(StoryNameCfg[328].name)

				arg_224_1.leftNameTxt_.text = var_227_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_3 = arg_224_1:GetWordFromCfg(116081052)
				local var_227_4 = arg_224_1:FormatText(var_227_3.content)

				arg_224_1.text_.text = var_227_4

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 9
				local var_227_6 = utf8.len(var_227_4)
				local var_227_7 = var_227_5 <= 0 and var_227_1 or var_227_1 * (var_227_6 / var_227_5)

				if var_227_7 > 0 and var_227_1 < var_227_7 then
					arg_224_1.talkMaxDuration = var_227_7

					if var_227_7 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_0
					end
				end

				arg_224_1.text_.text = var_227_4
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081052", "story_v_out_116081.awb") ~= 0 then
					local var_227_8 = manager.audio:GetVoiceLength("story_v_out_116081", "116081052", "story_v_out_116081.awb") / 1000

					if var_227_8 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_8 + var_227_0
					end

					if var_227_3.prefab_name ~= "" and arg_224_1.actors_[var_227_3.prefab_name] ~= nil then
						local var_227_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_3.prefab_name].transform, "story_v_out_116081", "116081052", "story_v_out_116081.awb")

						arg_224_1:RecordAudio("116081052", var_227_9)
						arg_224_1:RecordAudio("116081052", var_227_9)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_116081", "116081052", "story_v_out_116081.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_116081", "116081052", "story_v_out_116081.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_10 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_10 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_10

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_10 and arg_224_1.time_ < var_227_0 + var_227_10 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play116081053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 116081053
		arg_228_1.duration_ = 4.2

		local var_228_0 = {
			zh = 3.866,
			ja = 4.2
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play116081054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0
			local var_231_1 = 0.375

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_2 = arg_228_1:FormatText(StoryNameCfg[328].name)

				arg_228_1.leftNameTxt_.text = var_231_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_3 = arg_228_1:GetWordFromCfg(116081053)
				local var_231_4 = arg_228_1:FormatText(var_231_3.content)

				arg_228_1.text_.text = var_231_4

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 15
				local var_231_6 = utf8.len(var_231_4)
				local var_231_7 = var_231_5 <= 0 and var_231_1 or var_231_1 * (var_231_6 / var_231_5)

				if var_231_7 > 0 and var_231_1 < var_231_7 then
					arg_228_1.talkMaxDuration = var_231_7

					if var_231_7 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_7 + var_231_0
					end
				end

				arg_228_1.text_.text = var_231_4
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081053", "story_v_out_116081.awb") ~= 0 then
					local var_231_8 = manager.audio:GetVoiceLength("story_v_out_116081", "116081053", "story_v_out_116081.awb") / 1000

					if var_231_8 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_8 + var_231_0
					end

					if var_231_3.prefab_name ~= "" and arg_228_1.actors_[var_231_3.prefab_name] ~= nil then
						local var_231_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_3.prefab_name].transform, "story_v_out_116081", "116081053", "story_v_out_116081.awb")

						arg_228_1:RecordAudio("116081053", var_231_9)
						arg_228_1:RecordAudio("116081053", var_231_9)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_116081", "116081053", "story_v_out_116081.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_116081", "116081053", "story_v_out_116081.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_10 = math.max(var_231_1, arg_228_1.talkMaxDuration)

			if var_231_0 <= arg_228_1.time_ and arg_228_1.time_ < var_231_0 + var_231_10 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_0) / var_231_10

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_0 + var_231_10 and arg_228_1.time_ < var_231_0 + var_231_10 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play116081054 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 116081054
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play116081055(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0
			local var_235_1 = 0.575

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_2 = arg_232_1:FormatText(StoryNameCfg[7].name)

				arg_232_1.leftNameTxt_.text = var_235_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_3 = arg_232_1:GetWordFromCfg(116081054)
				local var_235_4 = arg_232_1:FormatText(var_235_3.content)

				arg_232_1.text_.text = var_235_4

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_5 = 23
				local var_235_6 = utf8.len(var_235_4)
				local var_235_7 = var_235_5 <= 0 and var_235_1 or var_235_1 * (var_235_6 / var_235_5)

				if var_235_7 > 0 and var_235_1 < var_235_7 then
					arg_232_1.talkMaxDuration = var_235_7

					if var_235_7 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_7 + var_235_0
					end
				end

				arg_232_1.text_.text = var_235_4
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_8 = math.max(var_235_1, arg_232_1.talkMaxDuration)

			if var_235_0 <= arg_232_1.time_ and arg_232_1.time_ < var_235_0 + var_235_8 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_0) / var_235_8

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_0 + var_235_8 and arg_232_1.time_ < var_235_0 + var_235_8 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play116081055 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 116081055
		arg_236_1.duration_ = 9

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play116081056(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 2

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				local var_239_1 = manager.ui.mainCamera.transform.localPosition
				local var_239_2 = Vector3.New(0, 0, 10) + Vector3.New(var_239_1.x, var_239_1.y, 0)
				local var_239_3 = arg_236_1.bgs_.ST18a

				var_239_3.transform.localPosition = var_239_2
				var_239_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_239_4 = var_239_3:GetComponent("SpriteRenderer")

				if var_239_4 and var_239_4.sprite then
					local var_239_5 = (var_239_3.transform.localPosition - var_239_1).z
					local var_239_6 = manager.ui.mainCameraCom_
					local var_239_7 = 2 * var_239_5 * Mathf.Tan(var_239_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_239_8 = var_239_7 * var_239_6.aspect
					local var_239_9 = var_239_4.sprite.bounds.size.x
					local var_239_10 = var_239_4.sprite.bounds.size.y
					local var_239_11 = var_239_8 / var_239_9
					local var_239_12 = var_239_7 / var_239_10
					local var_239_13 = var_239_12 < var_239_11 and var_239_11 or var_239_12

					var_239_3.transform.localScale = Vector3.New(var_239_13, var_239_13, 0)
				end

				for iter_239_0, iter_239_1 in pairs(arg_236_1.bgs_) do
					if iter_239_0 ~= "ST18a" then
						iter_239_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_239_14 = 0

			if var_239_14 < arg_236_1.time_ and arg_236_1.time_ <= var_239_14 + arg_239_0 then
				arg_236_1.mask_.enabled = true
				arg_236_1.mask_.raycastTarget = true

				arg_236_1:SetGaussion(false)
			end

			local var_239_15 = 2

			if var_239_14 <= arg_236_1.time_ and arg_236_1.time_ < var_239_14 + var_239_15 then
				local var_239_16 = (arg_236_1.time_ - var_239_14) / var_239_15
				local var_239_17 = Color.New(0, 0, 0)

				var_239_17.a = Mathf.Lerp(0, 1, var_239_16)
				arg_236_1.mask_.color = var_239_17
			end

			if arg_236_1.time_ >= var_239_14 + var_239_15 and arg_236_1.time_ < var_239_14 + var_239_15 + arg_239_0 then
				local var_239_18 = Color.New(0, 0, 0)

				var_239_18.a = 1
				arg_236_1.mask_.color = var_239_18
			end

			local var_239_19 = 2

			if var_239_19 < arg_236_1.time_ and arg_236_1.time_ <= var_239_19 + arg_239_0 then
				arg_236_1.mask_.enabled = true
				arg_236_1.mask_.raycastTarget = true

				arg_236_1:SetGaussion(false)
			end

			local var_239_20 = 2

			if var_239_19 <= arg_236_1.time_ and arg_236_1.time_ < var_239_19 + var_239_20 then
				local var_239_21 = (arg_236_1.time_ - var_239_19) / var_239_20
				local var_239_22 = Color.New(0, 0, 0)

				var_239_22.a = Mathf.Lerp(1, 0, var_239_21)
				arg_236_1.mask_.color = var_239_22
			end

			if arg_236_1.time_ >= var_239_19 + var_239_20 and arg_236_1.time_ < var_239_19 + var_239_20 + arg_239_0 then
				local var_239_23 = Color.New(0, 0, 0)
				local var_239_24 = 0

				arg_236_1.mask_.enabled = false
				var_239_23.a = var_239_24
				arg_236_1.mask_.color = var_239_23
			end

			local var_239_25 = arg_236_1.actors_["10025ui_story"].transform
			local var_239_26 = 3.8

			if var_239_26 < arg_236_1.time_ and arg_236_1.time_ <= var_239_26 + arg_239_0 then
				arg_236_1.var_.moveOldPos10025ui_story = var_239_25.localPosition
			end

			local var_239_27 = 0.001

			if var_239_26 <= arg_236_1.time_ and arg_236_1.time_ < var_239_26 + var_239_27 then
				local var_239_28 = (arg_236_1.time_ - var_239_26) / var_239_27
				local var_239_29 = Vector3.New(0, -1.1, -5.9)

				var_239_25.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10025ui_story, var_239_29, var_239_28)

				local var_239_30 = manager.ui.mainCamera.transform.position - var_239_25.position

				var_239_25.forward = Vector3.New(var_239_30.x, var_239_30.y, var_239_30.z)

				local var_239_31 = var_239_25.localEulerAngles

				var_239_31.z = 0
				var_239_31.x = 0
				var_239_25.localEulerAngles = var_239_31
			end

			if arg_236_1.time_ >= var_239_26 + var_239_27 and arg_236_1.time_ < var_239_26 + var_239_27 + arg_239_0 then
				var_239_25.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_239_32 = manager.ui.mainCamera.transform.position - var_239_25.position

				var_239_25.forward = Vector3.New(var_239_32.x, var_239_32.y, var_239_32.z)

				local var_239_33 = var_239_25.localEulerAngles

				var_239_33.z = 0
				var_239_33.x = 0
				var_239_25.localEulerAngles = var_239_33
			end

			local var_239_34 = 3.8

			if var_239_34 < arg_236_1.time_ and arg_236_1.time_ <= var_239_34 + arg_239_0 then
				arg_236_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_1")
			end

			local var_239_35 = 3.8

			if var_239_35 < arg_236_1.time_ and arg_236_1.time_ <= var_239_35 + arg_239_0 then
				arg_236_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_239_36 = arg_236_1.actors_["10025ui_story"]
			local var_239_37 = 3.8

			if var_239_37 < arg_236_1.time_ and arg_236_1.time_ <= var_239_37 + arg_239_0 and not isNil(var_239_36) and arg_236_1.var_.characterEffect10025ui_story == nil then
				arg_236_1.var_.characterEffect10025ui_story = var_239_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_38 = 0.2

			if var_239_37 <= arg_236_1.time_ and arg_236_1.time_ < var_239_37 + var_239_38 and not isNil(var_239_36) then
				local var_239_39 = (arg_236_1.time_ - var_239_37) / var_239_38

				if arg_236_1.var_.characterEffect10025ui_story and not isNil(var_239_36) then
					arg_236_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= var_239_37 + var_239_38 and arg_236_1.time_ < var_239_37 + var_239_38 + arg_239_0 and not isNil(var_239_36) and arg_236_1.var_.characterEffect10025ui_story then
				arg_236_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if arg_236_1.frameCnt_ <= 1 then
				arg_236_1.dialog_:SetActive(false)
			end

			local var_239_40 = 4
			local var_239_41 = 0.5

			if var_239_40 < arg_236_1.time_ and arg_236_1.time_ <= var_239_40 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0

				arg_236_1.dialog_:SetActive(true)

				arg_236_1.dialogCg_.alpha = 0

				local var_239_42 = LeanTween.value(arg_236_1.dialog_, 0, 1, 0.3)

				var_239_42:setOnUpdate(LuaHelper.FloatAction(function(arg_240_0)
					arg_236_1.dialogCg_.alpha = arg_240_0
				end))
				var_239_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_236_1.dialog_)
					var_239_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_236_1.duration_ = arg_236_1.duration_ + 0.3

				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_43 = arg_236_1:FormatText(StoryNameCfg[7].name)

				arg_236_1.leftNameTxt_.text = var_239_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_44 = arg_236_1:GetWordFromCfg(116081055)
				local var_239_45 = arg_236_1:FormatText(var_239_44.content)

				arg_236_1.text_.text = var_239_45

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_46 = 20
				local var_239_47 = utf8.len(var_239_45)
				local var_239_48 = var_239_46 <= 0 and var_239_41 or var_239_41 * (var_239_47 / var_239_46)

				if var_239_48 > 0 and var_239_41 < var_239_48 then
					arg_236_1.talkMaxDuration = var_239_48
					var_239_40 = var_239_40 + 0.3

					if var_239_48 + var_239_40 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_48 + var_239_40
					end
				end

				arg_236_1.text_.text = var_239_45
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_49 = var_239_40 + 0.3
			local var_239_50 = math.max(var_239_41, arg_236_1.talkMaxDuration)

			if var_239_49 <= arg_236_1.time_ and arg_236_1.time_ < var_239_49 + var_239_50 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_49) / var_239_50

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_49 + var_239_50 and arg_236_1.time_ < var_239_49 + var_239_50 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play116081056 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 116081056
		arg_242_1.duration_ = 5.23

		local var_242_0 = {
			zh = 5.233,
			ja = 4.733
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
			arg_242_1.auto_ = false
		end

		function arg_242_1.playNext_(arg_244_0)
			arg_242_1.onStoryFinished_()
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0

			if var_245_0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				arg_242_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_245_1 = 0
			local var_245_2 = 0.325

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_3 = arg_242_1:FormatText(StoryNameCfg[328].name)

				arg_242_1.leftNameTxt_.text = var_245_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_4 = arg_242_1:GetWordFromCfg(116081056)
				local var_245_5 = arg_242_1:FormatText(var_245_4.content)

				arg_242_1.text_.text = var_245_5

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_6 = 13
				local var_245_7 = utf8.len(var_245_5)
				local var_245_8 = var_245_6 <= 0 and var_245_2 or var_245_2 * (var_245_7 / var_245_6)

				if var_245_8 > 0 and var_245_2 < var_245_8 then
					arg_242_1.talkMaxDuration = var_245_8

					if var_245_8 + var_245_1 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_8 + var_245_1
					end
				end

				arg_242_1.text_.text = var_245_5
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116081", "116081056", "story_v_out_116081.awb") ~= 0 then
					local var_245_9 = manager.audio:GetVoiceLength("story_v_out_116081", "116081056", "story_v_out_116081.awb") / 1000

					if var_245_9 + var_245_1 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_1
					end

					if var_245_4.prefab_name ~= "" and arg_242_1.actors_[var_245_4.prefab_name] ~= nil then
						local var_245_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_4.prefab_name].transform, "story_v_out_116081", "116081056", "story_v_out_116081.awb")

						arg_242_1:RecordAudio("116081056", var_245_10)
						arg_242_1:RecordAudio("116081056", var_245_10)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_116081", "116081056", "story_v_out_116081.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_116081", "116081056", "story_v_out_116081.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_11 = math.max(var_245_2, arg_242_1.talkMaxDuration)

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_11 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_1) / var_245_11

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_1 + var_245_11 and arg_242_1.time_ < var_245_1 + var_245_11 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/ST18a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SK0109"
	},
	voices = {
		"story_v_out_116081.awb"
	}
}
