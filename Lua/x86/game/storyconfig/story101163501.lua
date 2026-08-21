return {
	Play116351001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116351001
		arg_1_1.duration_ = 5.03

		local var_1_0 = {
			zh = 4.3,
			ja = 5.033
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
				arg_1_0:Play116351002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST03"

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
				local var_4_5 = arg_1_1.bgs_.ST03

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
					if iter_4_0 ~= "ST03" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = "10025ui_story"

			if arg_1_1.actors_[var_4_16] == nil then
				local var_4_17 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_4_17) then
					local var_4_18 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_1_1.stage_.transform)

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

			local var_4_21 = arg_1_1.actors_["10025ui_story"].transform
			local var_4_22 = 1.9

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.var_.moveOldPos10025ui_story = var_4_21.localPosition
			end

			local var_4_23 = 0.001

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				local var_4_24 = (arg_1_1.time_ - var_4_22) / var_4_23
				local var_4_25 = Vector3.New(0, -1.1, -5.9)

				var_4_21.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10025ui_story, var_4_25, var_4_24)

				local var_4_26 = manager.ui.mainCamera.transform.position - var_4_21.position

				var_4_21.forward = Vector3.New(var_4_26.x, var_4_26.y, var_4_26.z)

				local var_4_27 = var_4_21.localEulerAngles

				var_4_27.z = 0
				var_4_27.x = 0
				var_4_21.localEulerAngles = var_4_27
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				var_4_21.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_4_28 = manager.ui.mainCamera.transform.position - var_4_21.position

				var_4_21.forward = Vector3.New(var_4_28.x, var_4_28.y, var_4_28.z)

				local var_4_29 = var_4_21.localEulerAngles

				var_4_29.z = 0
				var_4_29.x = 0
				var_4_21.localEulerAngles = var_4_29
			end

			local var_4_30 = 1.96666666666667

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_4_31 = arg_1_1.actors_["10025ui_story"]
			local var_4_32 = 1.96666666666667

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 and not isNil(var_4_31) and arg_1_1.var_.characterEffect10025ui_story == nil then
				arg_1_1.var_.characterEffect10025ui_story = var_4_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_33 = 0.2

			if var_4_32 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 and not isNil(var_4_31) then
				local var_4_34 = (arg_1_1.time_ - var_4_32) / var_4_33

				if arg_1_1.var_.characterEffect10025ui_story and not isNil(var_4_31) then
					arg_1_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 and not isNil(var_4_31) and arg_1_1.var_.characterEffect10025ui_story then
				arg_1_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_4_35 = 1.96666666666667

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
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
			local var_4_43 = 0.666666666666667

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

			local var_4_48 = 0.866666666666667
			local var_4_49 = 1.13333333333333

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_story_mood_daily", "bgm_story_mood_daily", "bgm_story_mood_daily.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_story_mood_daily", "bgm_story_mood_daily")

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
			local var_4_55 = 0.25

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

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[328].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(116351001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351001", "story_v_out_116351.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_116351", "116351001", "story_v_out_116351.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_116351", "116351001", "story_v_out_116351.awb")

						arg_1_1:RecordAudio("116351001", var_4_64)
						arg_1_1:RecordAudio("116351001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116351", "116351001", "story_v_out_116351.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116351", "116351001", "story_v_out_116351.awb")
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
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play116351002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116351002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play116351003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10025ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect10025ui_story == nil then
				arg_9_1.var_.characterEffect10025ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.2

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect10025ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10025ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect10025ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10025ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 0.3

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_8 = arg_9_1:FormatText(StoryNameCfg[344].name)

				arg_9_1.leftNameTxt_.text = var_12_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_9 = arg_9_1:GetWordFromCfg(116351002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 12
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
	Play116351003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116351003
		arg_13_1.duration_ = 3.23

		local var_13_0 = {
			zh = 2.233,
			ja = 3.233
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
				arg_13_0:Play116351004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10025ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10025ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, -1.1, -5.9)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10025ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = 0

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_16_10 = arg_13_1.actors_["10025ui_story"]
			local var_16_11 = 0

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect10025ui_story == nil then
				arg_13_1.var_.characterEffect10025ui_story = var_16_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_12 = 0.2

			if var_16_11 <= arg_13_1.time_ and arg_13_1.time_ < var_16_11 + var_16_12 and not isNil(var_16_10) then
				local var_16_13 = (arg_13_1.time_ - var_16_11) / var_16_12

				if arg_13_1.var_.characterEffect10025ui_story and not isNil(var_16_10) then
					arg_13_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_11 + var_16_12 and arg_13_1.time_ < var_16_11 + var_16_12 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect10025ui_story then
				arg_13_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_16_14 = 0

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action452")
			end

			local var_16_15 = 0
			local var_16_16 = 0.225

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[328].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(116351003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 9
				local var_16_21 = utf8.len(var_16_19)
				local var_16_22 = var_16_20 <= 0 and var_16_16 or var_16_16 * (var_16_21 / var_16_20)

				if var_16_22 > 0 and var_16_16 < var_16_22 then
					arg_13_1.talkMaxDuration = var_16_22

					if var_16_22 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_22 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_19
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351003", "story_v_out_116351.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_116351", "116351003", "story_v_out_116351.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_116351", "116351003", "story_v_out_116351.awb")

						arg_13_1:RecordAudio("116351003", var_16_24)
						arg_13_1:RecordAudio("116351003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_116351", "116351003", "story_v_out_116351.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_116351", "116351003", "story_v_out_116351.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_25 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_25 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_25

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_25 and arg_13_1.time_ < var_16_15 + var_16_25 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play116351004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116351004
		arg_17_1.duration_ = 5.83

		local var_17_0 = {
			zh = 5.833,
			ja = 4.866
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play116351005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10025ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10025ui_story == nil then
				arg_17_1.var_.characterEffect10025ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect10025ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10025ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10025ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10025ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.675

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[343].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(116351004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 27
				local var_20_12 = utf8.len(var_20_10)
				local var_20_13 = var_20_11 <= 0 and var_20_7 or var_20_7 * (var_20_12 / var_20_11)

				if var_20_13 > 0 and var_20_7 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351004", "story_v_out_116351.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_116351", "116351004", "story_v_out_116351.awb") / 1000

					if var_20_14 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_6
					end

					if var_20_9.prefab_name ~= "" and arg_17_1.actors_[var_20_9.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_9.prefab_name].transform, "story_v_out_116351", "116351004", "story_v_out_116351.awb")

						arg_17_1:RecordAudio("116351004", var_20_15)
						arg_17_1:RecordAudio("116351004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_116351", "116351004", "story_v_out_116351.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_116351", "116351004", "story_v_out_116351.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_16 and arg_17_1.time_ < var_20_6 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play116351005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116351005
		arg_21_1.duration_ = 4.47

		local var_21_0 = {
			zh = 3.666,
			ja = 4.466
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
				arg_21_0:Play116351006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10025ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10025ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, -1.1, -5.9)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10025ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_24_10 = arg_21_1.actors_["10025ui_story"]
			local var_24_11 = 0

			if var_24_11 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 and not isNil(var_24_10) and arg_21_1.var_.characterEffect10025ui_story == nil then
				arg_21_1.var_.characterEffect10025ui_story = var_24_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_12 = 0.2

			if var_24_11 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_12 and not isNil(var_24_10) then
				local var_24_13 = (arg_21_1.time_ - var_24_11) / var_24_12

				if arg_21_1.var_.characterEffect10025ui_story and not isNil(var_24_10) then
					arg_21_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_11 + var_24_12 and arg_21_1.time_ < var_24_11 + var_24_12 + arg_24_0 and not isNil(var_24_10) and arg_21_1.var_.characterEffect10025ui_story then
				arg_21_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action427")
			end

			local var_24_15 = 0
			local var_24_16 = 0.325

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[328].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(116351005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 13
				local var_24_21 = utf8.len(var_24_19)
				local var_24_22 = var_24_20 <= 0 and var_24_16 or var_24_16 * (var_24_21 / var_24_20)

				if var_24_22 > 0 and var_24_16 < var_24_22 then
					arg_21_1.talkMaxDuration = var_24_22

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351005", "story_v_out_116351.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_116351", "116351005", "story_v_out_116351.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_116351", "116351005", "story_v_out_116351.awb")

						arg_21_1:RecordAudio("116351005", var_24_24)
						arg_21_1:RecordAudio("116351005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_116351", "116351005", "story_v_out_116351.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_116351", "116351005", "story_v_out_116351.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_25 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_25 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_25

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_25 and arg_21_1.time_ < var_24_15 + var_24_25 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play116351006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116351006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play116351007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10025ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect10025ui_story == nil then
				arg_25_1.var_.characterEffect10025ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect10025ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10025ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect10025ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10025ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.9

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[344].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(116351006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 36
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
	Play116351007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116351007
		arg_29_1.duration_ = 7.56

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play116351008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "ST15"

			if arg_29_1.bgs_[var_32_0] == nil then
				local var_32_1 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_32_0)
				var_32_1.name = var_32_0
				var_32_1.transform.parent = arg_29_1.stage_.transform
				var_32_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_[var_32_0] = var_32_1
			end

			local var_32_2 = 2

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				local var_32_3 = manager.ui.mainCamera.transform.localPosition
				local var_32_4 = Vector3.New(0, 0, 10) + Vector3.New(var_32_3.x, var_32_3.y, 0)
				local var_32_5 = arg_29_1.bgs_.ST15

				var_32_5.transform.localPosition = var_32_4
				var_32_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_6 = var_32_5:GetComponent("SpriteRenderer")

				if var_32_6 and var_32_6.sprite then
					local var_32_7 = (var_32_5.transform.localPosition - var_32_3).z
					local var_32_8 = manager.ui.mainCameraCom_
					local var_32_9 = 2 * var_32_7 * Mathf.Tan(var_32_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_32_10 = var_32_9 * var_32_8.aspect
					local var_32_11 = var_32_6.sprite.bounds.size.x
					local var_32_12 = var_32_6.sprite.bounds.size.y
					local var_32_13 = var_32_10 / var_32_11
					local var_32_14 = var_32_9 / var_32_12
					local var_32_15 = var_32_14 < var_32_13 and var_32_13 or var_32_14

					var_32_5.transform.localScale = Vector3.New(var_32_15, var_32_15, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "ST15" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_16 = 4
			local var_32_17 = 3.562
			local var_32_18 = manager.audio:GetVoiceLength("story_v_out_116351", "116351007", "story_v_out_116351.awb") / 1000

			if var_32_18 > 0 and var_32_17 < var_32_18 and var_32_18 + var_32_16 > arg_29_1.duration_ then
				local var_32_19 = var_32_18

				arg_29_1.duration_ = var_32_18 + var_32_16
			end

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				local var_32_20 = "play"
				local var_32_21 = "voice"

				arg_29_1:AudioAction(var_32_20, var_32_21, "story_v_out_116351", "116351007", "story_v_out_116351.awb")
			end

			local var_32_22 = arg_29_1.actors_["10025ui_story"].transform
			local var_32_23 = 2

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1.var_.moveOldPos10025ui_story = var_32_22.localPosition
			end

			local var_32_24 = 0.001

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_24 then
				local var_32_25 = (arg_29_1.time_ - var_32_23) / var_32_24
				local var_32_26 = Vector3.New(0, 100, 0)

				var_32_22.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10025ui_story, var_32_26, var_32_25)

				local var_32_27 = manager.ui.mainCamera.transform.position - var_32_22.position

				var_32_22.forward = Vector3.New(var_32_27.x, var_32_27.y, var_32_27.z)

				local var_32_28 = var_32_22.localEulerAngles

				var_32_28.z = 0
				var_32_28.x = 0
				var_32_22.localEulerAngles = var_32_28
			end

			if arg_29_1.time_ >= var_32_23 + var_32_24 and arg_29_1.time_ < var_32_23 + var_32_24 + arg_32_0 then
				var_32_22.localPosition = Vector3.New(0, 100, 0)

				local var_32_29 = manager.ui.mainCamera.transform.position - var_32_22.position

				var_32_22.forward = Vector3.New(var_32_29.x, var_32_29.y, var_32_29.z)

				local var_32_30 = var_32_22.localEulerAngles

				var_32_30.z = 0
				var_32_30.x = 0
				var_32_22.localEulerAngles = var_32_30
			end

			local var_32_31 = 0

			if var_32_31 < arg_29_1.time_ and arg_29_1.time_ <= var_32_31 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_32 = 2

			if var_32_31 <= arg_29_1.time_ and arg_29_1.time_ < var_32_31 + var_32_32 then
				local var_32_33 = (arg_29_1.time_ - var_32_31) / var_32_32
				local var_32_34 = Color.New(0, 0, 0)

				var_32_34.a = Mathf.Lerp(0, 1, var_32_33)
				arg_29_1.mask_.color = var_32_34
			end

			if arg_29_1.time_ >= var_32_31 + var_32_32 and arg_29_1.time_ < var_32_31 + var_32_32 + arg_32_0 then
				local var_32_35 = Color.New(0, 0, 0)

				var_32_35.a = 1
				arg_29_1.mask_.color = var_32_35
			end

			local var_32_36 = 2

			if var_32_36 < arg_29_1.time_ and arg_29_1.time_ <= var_32_36 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_37 = 2

			if var_32_36 <= arg_29_1.time_ and arg_29_1.time_ < var_32_36 + var_32_37 then
				local var_32_38 = (arg_29_1.time_ - var_32_36) / var_32_37
				local var_32_39 = Color.New(0, 0, 0)

				var_32_39.a = Mathf.Lerp(1, 0, var_32_38)
				arg_29_1.mask_.color = var_32_39
			end

			if arg_29_1.time_ >= var_32_36 + var_32_37 and arg_29_1.time_ < var_32_36 + var_32_37 + arg_32_0 then
				local var_32_40 = Color.New(0, 0, 0)
				local var_32_41 = 0

				arg_29_1.mask_.enabled = false
				var_32_40.a = var_32_41
				arg_29_1.mask_.color = var_32_40
			end

			local var_32_42 = 2

			if var_32_42 < arg_29_1.time_ and arg_29_1.time_ <= var_32_42 + arg_32_0 then
				arg_29_1.fswbg_:SetActive(true)
				arg_29_1.dialog_:SetActive(false)

				arg_29_1.fswtw_.percent = 0

				local var_32_43 = arg_29_1:GetWordFromCfg(116351007)
				local var_32_44 = arg_29_1:FormatText(var_32_43.content)

				arg_29_1.fswt_.text = var_32_44

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.fswt_)

				arg_29_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_29_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_29_1.fswtw_:SetDirty()

				arg_29_1.typewritterCharCountI18N = 0

				SetActive(arg_29_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_29_1:ShowNextGo(false)
			end

			local var_32_45 = 4

			if var_32_45 < arg_29_1.time_ and arg_29_1.time_ <= var_32_45 + arg_32_0 then
				arg_29_1.var_.oldValueTypewriter = arg_29_1.fswtw_.percent

				SetActive(arg_29_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_29_1:ShowNextGo(false)
			end

			local var_32_46 = 13
			local var_32_47 = 0.866666666666667
			local var_32_48 = arg_29_1:GetWordFromCfg(116351007)
			local var_32_49 = arg_29_1:FormatText(var_32_48.content)
			local var_32_50, var_32_51 = arg_29_1:GetPercentByPara(var_32_49, 1)

			if var_32_45 < arg_29_1.time_ and arg_29_1.time_ <= var_32_45 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				local var_32_52 = var_32_46 <= 0 and var_32_47 or var_32_47 * ((var_32_51 - arg_29_1.typewritterCharCountI18N) / var_32_46)

				if var_32_52 > 0 and var_32_47 < var_32_52 then
					arg_29_1.talkMaxDuration = var_32_52

					if var_32_52 + var_32_45 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_52 + var_32_45
					end
				end
			end

			local var_32_53 = 0.866666666666667
			local var_32_54 = math.max(var_32_53, arg_29_1.talkMaxDuration)

			if var_32_45 <= arg_29_1.time_ and arg_29_1.time_ < var_32_45 + var_32_54 then
				local var_32_55 = (arg_29_1.time_ - var_32_45) / var_32_54

				arg_29_1.fswtw_.percent = Mathf.Lerp(arg_29_1.var_.oldValueTypewriter, var_32_50, var_32_55)
				arg_29_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_29_1.fswtw_:SetDirty()
			end

			if arg_29_1.time_ >= var_32_45 + var_32_54 and arg_29_1.time_ < var_32_45 + var_32_54 + arg_32_0 then
				arg_29_1.fswtw_.percent = var_32_50

				arg_29_1.fswtw_:SetDirty()
				arg_29_1:ShowNextGo(true)

				arg_29_1.typewritterCharCountI18N = var_32_51
			end

			local var_32_56 = 4

			if var_32_56 < arg_29_1.time_ and arg_29_1.time_ <= var_32_56 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			local var_32_57 = 0.866666666666667

			if arg_29_1.time_ >= var_32_56 + var_32_57 and arg_29_1.time_ < var_32_56 + var_32_57 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play116351008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116351008
		arg_33_1.duration_ = 9.03

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play116351009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.var_.oldValueTypewriter = arg_33_1.fswtw_.percent

				SetActive(arg_33_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_33_1:ShowNextGo(false)
			end

			local var_36_1 = 32
			local var_36_2 = 2.13333333333333
			local var_36_3 = arg_33_1:GetWordFromCfg(116351007)
			local var_36_4 = arg_33_1:FormatText(var_36_3.content)
			local var_36_5, var_36_6 = arg_33_1:GetPercentByPara(var_36_4, 2)

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				local var_36_7 = var_36_1 <= 0 and var_36_2 or var_36_2 * ((var_36_6 - arg_33_1.typewritterCharCountI18N) / var_36_1)

				if var_36_7 > 0 and var_36_2 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end
			end

			local var_36_8 = 2.13333333333333
			local var_36_9 = math.max(var_36_8, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_9 then
				local var_36_10 = (arg_33_1.time_ - var_36_0) / var_36_9

				arg_33_1.fswtw_.percent = Mathf.Lerp(arg_33_1.var_.oldValueTypewriter, var_36_5, var_36_10)
				arg_33_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_33_1.fswtw_:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_9 and arg_33_1.time_ < var_36_0 + var_36_9 + arg_36_0 then
				arg_33_1.fswtw_.percent = var_36_5

				arg_33_1.fswtw_:SetDirty()
				arg_33_1:ShowNextGo(true)

				arg_33_1.typewritterCharCountI18N = var_36_6
			end

			local var_36_11 = 0
			local var_36_12 = 9.027
			local var_36_13 = manager.audio:GetVoiceLength("story_v_out_116351", "116351008", "story_v_out_116351.awb") / 1000

			if var_36_13 > 0 and var_36_12 < var_36_13 and var_36_13 + var_36_11 > arg_33_1.duration_ then
				local var_36_14 = var_36_13

				arg_33_1.duration_ = var_36_13 + var_36_11
			end

			if var_36_11 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				local var_36_15 = "play"
				local var_36_16 = "voice"

				arg_33_1:AudioAction(var_36_15, var_36_16, "story_v_out_116351", "116351008", "story_v_out_116351.awb")
			end

			local var_36_17 = 0

			if var_36_17 < arg_33_1.time_ and arg_33_1.time_ <= var_36_17 + arg_36_0 then
				arg_33_1.allBtn_.enabled = false
			end

			local var_36_18 = 2.13333333333333

			if arg_33_1.time_ >= var_36_17 + var_36_18 and arg_33_1.time_ < var_36_17 + var_36_18 + arg_36_0 then
				arg_33_1.allBtn_.enabled = true
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play116351009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 116351009
		arg_37_1.duration_ = 16.03

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play116351010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.var_.oldValueTypewriter = arg_37_1.fswtw_.percent

				SetActive(arg_37_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_37_1:ShowNextGo(false)
			end

			local var_40_1 = 52
			local var_40_2 = 3.46666666666667
			local var_40_3 = arg_37_1:GetWordFromCfg(116351007)
			local var_40_4 = arg_37_1:FormatText(var_40_3.content)
			local var_40_5, var_40_6 = arg_37_1:GetPercentByPara(var_40_4, 3)

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				local var_40_7 = var_40_1 <= 0 and var_40_2 or var_40_2 * ((var_40_6 - arg_37_1.typewritterCharCountI18N) / var_40_1)

				if var_40_7 > 0 and var_40_2 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end
			end

			local var_40_8 = 3.46666666666667
			local var_40_9 = math.max(var_40_8, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_9 then
				local var_40_10 = (arg_37_1.time_ - var_40_0) / var_40_9

				arg_37_1.fswtw_.percent = Mathf.Lerp(arg_37_1.var_.oldValueTypewriter, var_40_5, var_40_10)
				arg_37_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_37_1.fswtw_:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_9 and arg_37_1.time_ < var_40_0 + var_40_9 + arg_40_0 then
				arg_37_1.fswtw_.percent = var_40_5

				arg_37_1.fswtw_:SetDirty()
				arg_37_1:ShowNextGo(true)

				arg_37_1.typewritterCharCountI18N = var_40_6
			end

			local var_40_11 = 0
			local var_40_12 = 16.027
			local var_40_13 = manager.audio:GetVoiceLength("story_v_out_116351", "116351009", "story_v_out_116351.awb") / 1000

			if var_40_13 > 0 and var_40_12 < var_40_13 and var_40_13 + var_40_11 > arg_37_1.duration_ then
				local var_40_14 = var_40_13

				arg_37_1.duration_ = var_40_13 + var_40_11
			end

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				local var_40_15 = "play"
				local var_40_16 = "voice"

				arg_37_1:AudioAction(var_40_15, var_40_16, "story_v_out_116351", "116351009", "story_v_out_116351.awb")
			end

			local var_40_17 = 0

			if var_40_17 < arg_37_1.time_ and arg_37_1.time_ <= var_40_17 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			local var_40_18 = 3.46666666666667

			if arg_37_1.time_ >= var_40_17 + var_40_18 and arg_37_1.time_ < var_40_17 + var_40_18 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play116351010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 116351010
		arg_41_1.duration_ = 1.85

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play116351011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.var_.oldValueTypewriter = arg_41_1.fswtw_.percent

				SetActive(arg_41_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_41_1:ShowNextGo(false)
			end

			local var_44_1 = 10
			local var_44_2 = 0.666666666666667
			local var_44_3 = arg_41_1:GetWordFromCfg(116351007)
			local var_44_4 = arg_41_1:FormatText(var_44_3.content)
			local var_44_5, var_44_6 = arg_41_1:GetPercentByPara(var_44_4, 4)

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				local var_44_7 = var_44_1 <= 0 and var_44_2 or var_44_2 * ((var_44_6 - arg_41_1.typewritterCharCountI18N) / var_44_1)

				if var_44_7 > 0 and var_44_2 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end
			end

			local var_44_8 = 0.666666666666667
			local var_44_9 = math.max(var_44_8, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_9 then
				local var_44_10 = (arg_41_1.time_ - var_44_0) / var_44_9

				arg_41_1.fswtw_.percent = Mathf.Lerp(arg_41_1.var_.oldValueTypewriter, var_44_5, var_44_10)
				arg_41_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_41_1.fswtw_:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_9 and arg_41_1.time_ < var_44_0 + var_44_9 + arg_44_0 then
				arg_41_1.fswtw_.percent = var_44_5

				arg_41_1.fswtw_:SetDirty()
				arg_41_1:ShowNextGo(true)

				arg_41_1.typewritterCharCountI18N = var_44_6
			end

			local var_44_11 = 0
			local var_44_12 = 1.852
			local var_44_13 = manager.audio:GetVoiceLength("story_v_out_116351", "116351010", "story_v_out_116351.awb") / 1000

			if var_44_13 > 0 and var_44_12 < var_44_13 and var_44_13 + var_44_11 > arg_41_1.duration_ then
				local var_44_14 = var_44_13

				arg_41_1.duration_ = var_44_13 + var_44_11
			end

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				local var_44_15 = "play"
				local var_44_16 = "voice"

				arg_41_1:AudioAction(var_44_15, var_44_16, "story_v_out_116351", "116351010", "story_v_out_116351.awb")
			end

			local var_44_17 = 0

			if var_44_17 < arg_41_1.time_ and arg_41_1.time_ <= var_44_17 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			local var_44_18 = 1.852

			if arg_41_1.time_ >= var_44_17 + var_44_18 and arg_41_1.time_ < var_44_17 + var_44_18 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play116351011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 116351011
		arg_45_1.duration_ = 10.85

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play116351012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.var_.oldValueTypewriter = arg_45_1.fswtw_.percent

				SetActive(arg_45_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_45_1:ShowNextGo(false)
			end

			local var_48_1 = 42
			local var_48_2 = 2.8
			local var_48_3 = arg_45_1:GetWordFromCfg(116351007)
			local var_48_4 = arg_45_1:FormatText(var_48_3.content)
			local var_48_5, var_48_6 = arg_45_1:GetPercentByPara(var_48_4, 5)

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				local var_48_7 = var_48_1 <= 0 and var_48_2 or var_48_2 * ((var_48_6 - arg_45_1.typewritterCharCountI18N) / var_48_1)

				if var_48_7 > 0 and var_48_2 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end
			end

			local var_48_8 = 2.8
			local var_48_9 = math.max(var_48_8, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_9 then
				local var_48_10 = (arg_45_1.time_ - var_48_0) / var_48_9

				arg_45_1.fswtw_.percent = Mathf.Lerp(arg_45_1.var_.oldValueTypewriter, var_48_5, var_48_10)
				arg_45_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_45_1.fswtw_:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_9 and arg_45_1.time_ < var_48_0 + var_48_9 + arg_48_0 then
				arg_45_1.fswtw_.percent = var_48_5

				arg_45_1.fswtw_:SetDirty()
				arg_45_1:ShowNextGo(true)

				arg_45_1.typewritterCharCountI18N = var_48_6
			end

			local var_48_11 = 0
			local var_48_12 = 10.849
			local var_48_13 = manager.audio:GetVoiceLength("story_v_out_116351", "116351011", "story_v_out_116351.awb") / 1000

			if var_48_13 > 0 and var_48_12 < var_48_13 and var_48_13 + var_48_11 > arg_45_1.duration_ then
				local var_48_14 = var_48_13

				arg_45_1.duration_ = var_48_13 + var_48_11
			end

			if var_48_11 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				local var_48_15 = "play"
				local var_48_16 = "voice"

				arg_45_1:AudioAction(var_48_15, var_48_16, "story_v_out_116351", "116351011", "story_v_out_116351.awb")
			end

			local var_48_17 = 0

			if var_48_17 < arg_45_1.time_ and arg_45_1.time_ <= var_48_17 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			local var_48_18 = 2.8

			if arg_45_1.time_ >= var_48_17 + var_48_18 and arg_45_1.time_ < var_48_17 + var_48_18 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play116351012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116351012
		arg_49_1.duration_ = 13.23

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play116351013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.var_.oldValueTypewriter = arg_49_1.fswtw_.percent

				SetActive(arg_49_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_49_1:ShowNextGo(false)
			end

			local var_52_1 = 47
			local var_52_2 = 3.13333333333333
			local var_52_3 = arg_49_1:GetWordFromCfg(116351007)
			local var_52_4 = arg_49_1:FormatText(var_52_3.content)
			local var_52_5, var_52_6 = arg_49_1:GetPercentByPara(var_52_4, 6)

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				local var_52_7 = var_52_1 <= 0 and var_52_2 or var_52_2 * ((var_52_6 - arg_49_1.typewritterCharCountI18N) / var_52_1)

				if var_52_7 > 0 and var_52_2 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end
			end

			local var_52_8 = 3.13333333333333
			local var_52_9 = math.max(var_52_8, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_9 then
				local var_52_10 = (arg_49_1.time_ - var_52_0) / var_52_9

				arg_49_1.fswtw_.percent = Mathf.Lerp(arg_49_1.var_.oldValueTypewriter, var_52_5, var_52_10)
				arg_49_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_49_1.fswtw_:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_9 and arg_49_1.time_ < var_52_0 + var_52_9 + arg_52_0 then
				arg_49_1.fswtw_.percent = var_52_5

				arg_49_1.fswtw_:SetDirty()
				arg_49_1:ShowNextGo(true)

				arg_49_1.typewritterCharCountI18N = var_52_6
			end

			local var_52_11 = 0
			local var_52_12 = 13.233
			local var_52_13 = manager.audio:GetVoiceLength("story_v_out_116351", "116351012", "story_v_out_116351.awb") / 1000

			if var_52_13 > 0 and var_52_12 < var_52_13 and var_52_13 + var_52_11 > arg_49_1.duration_ then
				local var_52_14 = var_52_13

				arg_49_1.duration_ = var_52_13 + var_52_11
			end

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				local var_52_15 = "play"
				local var_52_16 = "voice"

				arg_49_1:AudioAction(var_52_15, var_52_16, "story_v_out_116351", "116351012", "story_v_out_116351.awb")
			end

			local var_52_17 = 0

			if var_52_17 < arg_49_1.time_ and arg_49_1.time_ <= var_52_17 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			local var_52_18 = 3.13333333333333

			if arg_49_1.time_ >= var_52_17 + var_52_18 and arg_49_1.time_ < var_52_17 + var_52_18 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play116351013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116351013
		arg_53_1.duration_ = 9

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play116351014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.98333333333333

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.fswbg_:SetActive(false)
				arg_53_1.dialog_:SetActive(false)
				SetActive(arg_53_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_53_1:ShowNextGo(false)
			end

			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_2 = 2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Color.New(0, 0, 0)

				var_56_4.a = Mathf.Lerp(0, 1, var_56_3)
				arg_53_1.mask_.color = var_56_4
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				local var_56_5 = Color.New(0, 0, 0)

				var_56_5.a = 1
				arg_53_1.mask_.color = var_56_5
			end

			local var_56_6 = 2

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_7 = 2

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_7 then
				local var_56_8 = (arg_53_1.time_ - var_56_6) / var_56_7
				local var_56_9 = Color.New(0, 0, 0)

				var_56_9.a = Mathf.Lerp(1, 0, var_56_8)
				arg_53_1.mask_.color = var_56_9
			end

			if arg_53_1.time_ >= var_56_6 + var_56_7 and arg_53_1.time_ < var_56_6 + var_56_7 + arg_56_0 then
				local var_56_10 = Color.New(0, 0, 0)
				local var_56_11 = 0

				arg_53_1.mask_.enabled = false
				var_56_10.a = var_56_11
				arg_53_1.mask_.color = var_56_10
			end

			local var_56_12 = 0

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			local var_56_13 = 4.5

			if arg_53_1.time_ >= var_56_12 + var_56_13 and arg_53_1.time_ < var_56_12 + var_56_13 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_14 = 4
			local var_56_15 = 0.5

			if var_56_14 < arg_53_1.time_ and arg_53_1.time_ <= var_56_14 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_16 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_16:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_17 = arg_53_1:FormatText(StoryNameCfg[344].name)

				arg_53_1.leftNameTxt_.text = var_56_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(116351013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 20
				local var_56_21 = utf8.len(var_56_19)
				local var_56_22 = var_56_20 <= 0 and var_56_15 or var_56_15 * (var_56_21 / var_56_20)

				if var_56_22 > 0 and var_56_15 < var_56_22 then
					arg_53_1.talkMaxDuration = var_56_22
					var_56_14 = var_56_14 + 0.3

					if var_56_22 + var_56_14 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_14
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_23 = var_56_14 + 0.3
			local var_56_24 = math.max(var_56_15, arg_53_1.talkMaxDuration)

			if var_56_23 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_24 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_23) / var_56_24

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_23 + var_56_24 and arg_53_1.time_ < var_56_23 + var_56_24 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play116351014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 116351014
		arg_59_1.duration_ = 14.83

		local var_59_0 = {
			zh = 14.833,
			ja = 11.233
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play116351015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10025ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos10025ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, -1.1, -5.9)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10025ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = 0

			if var_62_9 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				arg_59_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_62_10 = arg_59_1.actors_["10025ui_story"]
			local var_62_11 = 0

			if var_62_11 < arg_59_1.time_ and arg_59_1.time_ <= var_62_11 + arg_62_0 and not isNil(var_62_10) and arg_59_1.var_.characterEffect10025ui_story == nil then
				arg_59_1.var_.characterEffect10025ui_story = var_62_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_12 = 0.2

			if var_62_11 <= arg_59_1.time_ and arg_59_1.time_ < var_62_11 + var_62_12 and not isNil(var_62_10) then
				local var_62_13 = (arg_59_1.time_ - var_62_11) / var_62_12

				if arg_59_1.var_.characterEffect10025ui_story and not isNil(var_62_10) then
					arg_59_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_11 + var_62_12 and arg_59_1.time_ < var_62_11 + var_62_12 + arg_62_0 and not isNil(var_62_10) and arg_59_1.var_.characterEffect10025ui_story then
				arg_59_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_62_14 = 0

			if var_62_14 < arg_59_1.time_ and arg_59_1.time_ <= var_62_14 + arg_62_0 then
				arg_59_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_62_15 = 0
			local var_62_16 = 1.05

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_17 = arg_59_1:FormatText(StoryNameCfg[328].name)

				arg_59_1.leftNameTxt_.text = var_62_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_18 = arg_59_1:GetWordFromCfg(116351014)
				local var_62_19 = arg_59_1:FormatText(var_62_18.content)

				arg_59_1.text_.text = var_62_19

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_20 = 42
				local var_62_21 = utf8.len(var_62_19)
				local var_62_22 = var_62_20 <= 0 and var_62_16 or var_62_16 * (var_62_21 / var_62_20)

				if var_62_22 > 0 and var_62_16 < var_62_22 then
					arg_59_1.talkMaxDuration = var_62_22

					if var_62_22 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_22 + var_62_15
					end
				end

				arg_59_1.text_.text = var_62_19
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351014", "story_v_out_116351.awb") ~= 0 then
					local var_62_23 = manager.audio:GetVoiceLength("story_v_out_116351", "116351014", "story_v_out_116351.awb") / 1000

					if var_62_23 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_23 + var_62_15
					end

					if var_62_18.prefab_name ~= "" and arg_59_1.actors_[var_62_18.prefab_name] ~= nil then
						local var_62_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_18.prefab_name].transform, "story_v_out_116351", "116351014", "story_v_out_116351.awb")

						arg_59_1:RecordAudio("116351014", var_62_24)
						arg_59_1:RecordAudio("116351014", var_62_24)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_116351", "116351014", "story_v_out_116351.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_116351", "116351014", "story_v_out_116351.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_25 = math.max(var_62_16, arg_59_1.talkMaxDuration)

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_25 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_15) / var_62_25

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_15 + var_62_25 and arg_59_1.time_ < var_62_15 + var_62_25 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play116351015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 116351015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play116351016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10025ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10025ui_story == nil then
				arg_63_1.var_.characterEffect10025ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect10025ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10025ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10025ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10025ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 0.325

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_8 = arg_63_1:FormatText(StoryNameCfg[344].name)

				arg_63_1.leftNameTxt_.text = var_66_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_9 = arg_63_1:GetWordFromCfg(116351015)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 13
				local var_66_12 = utf8.len(var_66_10)
				local var_66_13 = var_66_11 <= 0 and var_66_7 or var_66_7 * (var_66_12 / var_66_11)

				if var_66_13 > 0 and var_66_7 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_10
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_14 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_14 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_14

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_14 and arg_63_1.time_ < var_66_6 + var_66_14 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play116351016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 116351016
		arg_67_1.duration_ = 11.8

		local var_67_0 = {
			zh = 11.8,
			ja = 10.633
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play116351017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["10025ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos10025ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, -1.1, -5.9)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10025ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = 0

			if var_70_9 < arg_67_1.time_ and arg_67_1.time_ <= var_70_9 + arg_70_0 then
				arg_67_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_70_10 = arg_67_1.actors_["10025ui_story"]
			local var_70_11 = 0

			if var_70_11 < arg_67_1.time_ and arg_67_1.time_ <= var_70_11 + arg_70_0 and not isNil(var_70_10) and arg_67_1.var_.characterEffect10025ui_story == nil then
				arg_67_1.var_.characterEffect10025ui_story = var_70_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_12 = 0.2

			if var_70_11 <= arg_67_1.time_ and arg_67_1.time_ < var_70_11 + var_70_12 and not isNil(var_70_10) then
				local var_70_13 = (arg_67_1.time_ - var_70_11) / var_70_12

				if arg_67_1.var_.characterEffect10025ui_story and not isNil(var_70_10) then
					arg_67_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_11 + var_70_12 and arg_67_1.time_ < var_70_11 + var_70_12 + arg_70_0 and not isNil(var_70_10) and arg_67_1.var_.characterEffect10025ui_story then
				arg_67_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_70_14 = 0
			local var_70_15 = 1.05

			if var_70_14 < arg_67_1.time_ and arg_67_1.time_ <= var_70_14 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_16 = arg_67_1:FormatText(StoryNameCfg[328].name)

				arg_67_1.leftNameTxt_.text = var_70_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_17 = arg_67_1:GetWordFromCfg(116351016)
				local var_70_18 = arg_67_1:FormatText(var_70_17.content)

				arg_67_1.text_.text = var_70_18

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_19 = 42
				local var_70_20 = utf8.len(var_70_18)
				local var_70_21 = var_70_19 <= 0 and var_70_15 or var_70_15 * (var_70_20 / var_70_19)

				if var_70_21 > 0 and var_70_15 < var_70_21 then
					arg_67_1.talkMaxDuration = var_70_21

					if var_70_21 + var_70_14 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_21 + var_70_14
					end
				end

				arg_67_1.text_.text = var_70_18
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351016", "story_v_out_116351.awb") ~= 0 then
					local var_70_22 = manager.audio:GetVoiceLength("story_v_out_116351", "116351016", "story_v_out_116351.awb") / 1000

					if var_70_22 + var_70_14 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_22 + var_70_14
					end

					if var_70_17.prefab_name ~= "" and arg_67_1.actors_[var_70_17.prefab_name] ~= nil then
						local var_70_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_17.prefab_name].transform, "story_v_out_116351", "116351016", "story_v_out_116351.awb")

						arg_67_1:RecordAudio("116351016", var_70_23)
						arg_67_1:RecordAudio("116351016", var_70_23)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_116351", "116351016", "story_v_out_116351.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_116351", "116351016", "story_v_out_116351.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_24 = math.max(var_70_15, arg_67_1.talkMaxDuration)

			if var_70_14 <= arg_67_1.time_ and arg_67_1.time_ < var_70_14 + var_70_24 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_14) / var_70_24

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_14 + var_70_24 and arg_67_1.time_ < var_70_14 + var_70_24 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play116351017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 116351017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play116351018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10025ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10025ui_story == nil then
				arg_71_1.var_.characterEffect10025ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect10025ui_story and not isNil(var_74_0) then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10025ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10025ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10025ui_story.fillRatio = var_74_5
			end

			local var_74_6 = 0
			local var_74_7 = 0.325

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_8 = arg_71_1:FormatText(StoryNameCfg[344].name)

				arg_71_1.leftNameTxt_.text = var_74_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_9 = arg_71_1:GetWordFromCfg(116351017)
				local var_74_10 = arg_71_1:FormatText(var_74_9.content)

				arg_71_1.text_.text = var_74_10

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 13
				local var_74_12 = utf8.len(var_74_10)
				local var_74_13 = var_74_11 <= 0 and var_74_7 or var_74_7 * (var_74_12 / var_74_11)

				if var_74_13 > 0 and var_74_7 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_10
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play116351018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116351018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play116351019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.975

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[344].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(116351018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 39
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_8 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_8 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_8

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_8 and arg_75_1.time_ < var_78_0 + var_78_8 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play116351019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 116351019
		arg_79_1.duration_ = 3.7

		local var_79_0 = {
			zh = 3.433,
			ja = 3.7
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play116351020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10025ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos10025ui_story = var_82_0.localPosition
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(0, -1.1, -5.9)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10025ui_story, var_82_4, var_82_3)

				local var_82_5 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_5.x, var_82_5.y, var_82_5.z)

				local var_82_6 = var_82_0.localEulerAngles

				var_82_6.z = 0
				var_82_6.x = 0
				var_82_0.localEulerAngles = var_82_6
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_82_7 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_7.x, var_82_7.y, var_82_7.z)

				local var_82_8 = var_82_0.localEulerAngles

				var_82_8.z = 0
				var_82_8.x = 0
				var_82_0.localEulerAngles = var_82_8
			end

			local var_82_9 = 0

			if var_82_9 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 then
				arg_79_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_10 = arg_79_1.actors_["10025ui_story"]
			local var_82_11 = 0

			if var_82_11 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 and not isNil(var_82_10) and arg_79_1.var_.characterEffect10025ui_story == nil then
				arg_79_1.var_.characterEffect10025ui_story = var_82_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_12 = 0.2

			if var_82_11 <= arg_79_1.time_ and arg_79_1.time_ < var_82_11 + var_82_12 and not isNil(var_82_10) then
				local var_82_13 = (arg_79_1.time_ - var_82_11) / var_82_12

				if arg_79_1.var_.characterEffect10025ui_story and not isNil(var_82_10) then
					arg_79_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_11 + var_82_12 and arg_79_1.time_ < var_82_11 + var_82_12 + arg_82_0 and not isNil(var_82_10) and arg_79_1.var_.characterEffect10025ui_story then
				arg_79_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_82_14 = 0

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_82_15 = 0
			local var_82_16 = 0.225

			if var_82_15 < arg_79_1.time_ and arg_79_1.time_ <= var_82_15 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_17 = arg_79_1:FormatText(StoryNameCfg[328].name)

				arg_79_1.leftNameTxt_.text = var_82_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_18 = arg_79_1:GetWordFromCfg(116351019)
				local var_82_19 = arg_79_1:FormatText(var_82_18.content)

				arg_79_1.text_.text = var_82_19

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_20 = 9
				local var_82_21 = utf8.len(var_82_19)
				local var_82_22 = var_82_20 <= 0 and var_82_16 or var_82_16 * (var_82_21 / var_82_20)

				if var_82_22 > 0 and var_82_16 < var_82_22 then
					arg_79_1.talkMaxDuration = var_82_22

					if var_82_22 + var_82_15 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_22 + var_82_15
					end
				end

				arg_79_1.text_.text = var_82_19
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351019", "story_v_out_116351.awb") ~= 0 then
					local var_82_23 = manager.audio:GetVoiceLength("story_v_out_116351", "116351019", "story_v_out_116351.awb") / 1000

					if var_82_23 + var_82_15 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_23 + var_82_15
					end

					if var_82_18.prefab_name ~= "" and arg_79_1.actors_[var_82_18.prefab_name] ~= nil then
						local var_82_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_18.prefab_name].transform, "story_v_out_116351", "116351019", "story_v_out_116351.awb")

						arg_79_1:RecordAudio("116351019", var_82_24)
						arg_79_1:RecordAudio("116351019", var_82_24)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_116351", "116351019", "story_v_out_116351.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_116351", "116351019", "story_v_out_116351.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_25 = math.max(var_82_16, arg_79_1.talkMaxDuration)

			if var_82_15 <= arg_79_1.time_ and arg_79_1.time_ < var_82_15 + var_82_25 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_15) / var_82_25

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_15 + var_82_25 and arg_79_1.time_ < var_82_15 + var_82_25 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play116351020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 116351020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play116351021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10025ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect10025ui_story == nil then
				arg_83_1.var_.characterEffect10025ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect10025ui_story and not isNil(var_86_0) then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10025ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect10025ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10025ui_story.fillRatio = var_86_5
			end

			local var_86_6 = 0
			local var_86_7 = 1.075

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_8 = arg_83_1:FormatText(StoryNameCfg[344].name)

				arg_83_1.leftNameTxt_.text = var_86_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_9 = arg_83_1:GetWordFromCfg(116351020)
				local var_86_10 = arg_83_1:FormatText(var_86_9.content)

				arg_83_1.text_.text = var_86_10

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 43
				local var_86_12 = utf8.len(var_86_10)
				local var_86_13 = var_86_11 <= 0 and var_86_7 or var_86_7 * (var_86_12 / var_86_11)

				if var_86_13 > 0 and var_86_7 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_10
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_14 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_14 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_14

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_14 and arg_83_1.time_ < var_86_6 + var_86_14 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play116351021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 116351021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play116351022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.825

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[344].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(116351021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 33
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_8 and arg_87_1.time_ < var_90_0 + var_90_8 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play116351022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 116351022
		arg_91_1.duration_ = 6.97

		local var_91_0 = {
			zh = 6.966,
			ja = 6.266
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play116351023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10025ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos10025ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, -1.1, -5.9)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10025ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = 0

			if var_94_9 < arg_91_1.time_ and arg_91_1.time_ <= var_94_9 + arg_94_0 then
				arg_91_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_94_10 = arg_91_1.actors_["10025ui_story"]
			local var_94_11 = 0

			if var_94_11 < arg_91_1.time_ and arg_91_1.time_ <= var_94_11 + arg_94_0 and not isNil(var_94_10) and arg_91_1.var_.characterEffect10025ui_story == nil then
				arg_91_1.var_.characterEffect10025ui_story = var_94_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_12 = 0.2

			if var_94_11 <= arg_91_1.time_ and arg_91_1.time_ < var_94_11 + var_94_12 and not isNil(var_94_10) then
				local var_94_13 = (arg_91_1.time_ - var_94_11) / var_94_12

				if arg_91_1.var_.characterEffect10025ui_story and not isNil(var_94_10) then
					arg_91_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_11 + var_94_12 and arg_91_1.time_ < var_94_11 + var_94_12 + arg_94_0 and not isNil(var_94_10) and arg_91_1.var_.characterEffect10025ui_story then
				arg_91_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_94_14 = 0
			local var_94_15 = 0.575

			if var_94_14 < arg_91_1.time_ and arg_91_1.time_ <= var_94_14 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_16 = arg_91_1:FormatText(StoryNameCfg[328].name)

				arg_91_1.leftNameTxt_.text = var_94_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_17 = arg_91_1:GetWordFromCfg(116351022)
				local var_94_18 = arg_91_1:FormatText(var_94_17.content)

				arg_91_1.text_.text = var_94_18

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_19 = 23
				local var_94_20 = utf8.len(var_94_18)
				local var_94_21 = var_94_19 <= 0 and var_94_15 or var_94_15 * (var_94_20 / var_94_19)

				if var_94_21 > 0 and var_94_15 < var_94_21 then
					arg_91_1.talkMaxDuration = var_94_21

					if var_94_21 + var_94_14 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_21 + var_94_14
					end
				end

				arg_91_1.text_.text = var_94_18
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351022", "story_v_out_116351.awb") ~= 0 then
					local var_94_22 = manager.audio:GetVoiceLength("story_v_out_116351", "116351022", "story_v_out_116351.awb") / 1000

					if var_94_22 + var_94_14 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_22 + var_94_14
					end

					if var_94_17.prefab_name ~= "" and arg_91_1.actors_[var_94_17.prefab_name] ~= nil then
						local var_94_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_17.prefab_name].transform, "story_v_out_116351", "116351022", "story_v_out_116351.awb")

						arg_91_1:RecordAudio("116351022", var_94_23)
						arg_91_1:RecordAudio("116351022", var_94_23)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_116351", "116351022", "story_v_out_116351.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_116351", "116351022", "story_v_out_116351.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_24 = math.max(var_94_15, arg_91_1.talkMaxDuration)

			if var_94_14 <= arg_91_1.time_ and arg_91_1.time_ < var_94_14 + var_94_24 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_14) / var_94_24

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_14 + var_94_24 and arg_91_1.time_ < var_94_14 + var_94_24 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play116351023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 116351023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play116351024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10025ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect10025ui_story == nil then
				arg_95_1.var_.characterEffect10025ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.2

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect10025ui_story and not isNil(var_98_0) then
					local var_98_4 = Mathf.Lerp(0, 0.5, var_98_3)

					arg_95_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_95_1.var_.characterEffect10025ui_story.fillRatio = var_98_4
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect10025ui_story then
				local var_98_5 = 0.5

				arg_95_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_95_1.var_.characterEffect10025ui_story.fillRatio = var_98_5
			end

			local var_98_6 = 0
			local var_98_7 = 0.55

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[344].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_9 = arg_95_1:GetWordFromCfg(116351023)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 22
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_14 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_14 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_14

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_14 and arg_95_1.time_ < var_98_6 + var_98_14 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play116351024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 116351024
		arg_99_1.duration_ = 2.47

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play116351025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10025ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos10025ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, -1.1, -5.9)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10025ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = 0

			if var_102_9 < arg_99_1.time_ and arg_99_1.time_ <= var_102_9 + arg_102_0 then
				arg_99_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_102_10 = arg_99_1.actors_["10025ui_story"]
			local var_102_11 = 0

			if var_102_11 < arg_99_1.time_ and arg_99_1.time_ <= var_102_11 + arg_102_0 and not isNil(var_102_10) and arg_99_1.var_.characterEffect10025ui_story == nil then
				arg_99_1.var_.characterEffect10025ui_story = var_102_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_12 = 0.2

			if var_102_11 <= arg_99_1.time_ and arg_99_1.time_ < var_102_11 + var_102_12 and not isNil(var_102_10) then
				local var_102_13 = (arg_99_1.time_ - var_102_11) / var_102_12

				if arg_99_1.var_.characterEffect10025ui_story and not isNil(var_102_10) then
					arg_99_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_11 + var_102_12 and arg_99_1.time_ < var_102_11 + var_102_12 + arg_102_0 and not isNil(var_102_10) and arg_99_1.var_.characterEffect10025ui_story then
				arg_99_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_102_14 = 0

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_102_15 = 0
			local var_102_16 = 0.1

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_17 = arg_99_1:FormatText(StoryNameCfg[328].name)

				arg_99_1.leftNameTxt_.text = var_102_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_18 = arg_99_1:GetWordFromCfg(116351024)
				local var_102_19 = arg_99_1:FormatText(var_102_18.content)

				arg_99_1.text_.text = var_102_19

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_20 = 4
				local var_102_21 = utf8.len(var_102_19)
				local var_102_22 = var_102_20 <= 0 and var_102_16 or var_102_16 * (var_102_21 / var_102_20)

				if var_102_22 > 0 and var_102_16 < var_102_22 then
					arg_99_1.talkMaxDuration = var_102_22

					if var_102_22 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_22 + var_102_15
					end
				end

				arg_99_1.text_.text = var_102_19
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351024", "story_v_out_116351.awb") ~= 0 then
					local var_102_23 = manager.audio:GetVoiceLength("story_v_out_116351", "116351024", "story_v_out_116351.awb") / 1000

					if var_102_23 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_23 + var_102_15
					end

					if var_102_18.prefab_name ~= "" and arg_99_1.actors_[var_102_18.prefab_name] ~= nil then
						local var_102_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_18.prefab_name].transform, "story_v_out_116351", "116351024", "story_v_out_116351.awb")

						arg_99_1:RecordAudio("116351024", var_102_24)
						arg_99_1:RecordAudio("116351024", var_102_24)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_116351", "116351024", "story_v_out_116351.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_116351", "116351024", "story_v_out_116351.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_25 = math.max(var_102_16, arg_99_1.talkMaxDuration)

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_25 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_15) / var_102_25

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_15 + var_102_25 and arg_99_1.time_ < var_102_15 + var_102_25 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play116351025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 116351025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play116351026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10025ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10025ui_story == nil then
				arg_103_1.var_.characterEffect10025ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.2

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect10025ui_story and not isNil(var_106_0) then
					local var_106_4 = Mathf.Lerp(0, 0.5, var_106_3)

					arg_103_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10025ui_story.fillRatio = var_106_4
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10025ui_story then
				local var_106_5 = 0.5

				arg_103_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10025ui_story.fillRatio = var_106_5
			end

			local var_106_6 = 0
			local var_106_7 = 0.3

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_8 = arg_103_1:FormatText(StoryNameCfg[344].name)

				arg_103_1.leftNameTxt_.text = var_106_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_9 = arg_103_1:GetWordFromCfg(116351025)
				local var_106_10 = arg_103_1:FormatText(var_106_9.content)

				arg_103_1.text_.text = var_106_10

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_11 = 12
				local var_106_12 = utf8.len(var_106_10)
				local var_106_13 = var_106_11 <= 0 and var_106_7 or var_106_7 * (var_106_12 / var_106_11)

				if var_106_13 > 0 and var_106_7 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_10
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_14 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_14 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_14

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_14 and arg_103_1.time_ < var_106_6 + var_106_14 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play116351026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 116351026
		arg_107_1.duration_ = 2.4

		local var_107_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play116351027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10025ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10025ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(0, -1.1, -5.9)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10025ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = 0

			if var_110_9 < arg_107_1.time_ and arg_107_1.time_ <= var_110_9 + arg_110_0 then
				arg_107_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_110_10 = arg_107_1.actors_["10025ui_story"]
			local var_110_11 = 0

			if var_110_11 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 and not isNil(var_110_10) and arg_107_1.var_.characterEffect10025ui_story == nil then
				arg_107_1.var_.characterEffect10025ui_story = var_110_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_12 = 0.2

			if var_110_11 <= arg_107_1.time_ and arg_107_1.time_ < var_110_11 + var_110_12 and not isNil(var_110_10) then
				local var_110_13 = (arg_107_1.time_ - var_110_11) / var_110_12

				if arg_107_1.var_.characterEffect10025ui_story and not isNil(var_110_10) then
					arg_107_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_11 + var_110_12 and arg_107_1.time_ < var_110_11 + var_110_12 + arg_110_0 and not isNil(var_110_10) and arg_107_1.var_.characterEffect10025ui_story then
				arg_107_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_110_14 = 0
			local var_110_15 = 0.1

			if var_110_14 < arg_107_1.time_ and arg_107_1.time_ <= var_110_14 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_16 = arg_107_1:FormatText(StoryNameCfg[328].name)

				arg_107_1.leftNameTxt_.text = var_110_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_17 = arg_107_1:GetWordFromCfg(116351026)
				local var_110_18 = arg_107_1:FormatText(var_110_17.content)

				arg_107_1.text_.text = var_110_18

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_19 = 4
				local var_110_20 = utf8.len(var_110_18)
				local var_110_21 = var_110_19 <= 0 and var_110_15 or var_110_15 * (var_110_20 / var_110_19)

				if var_110_21 > 0 and var_110_15 < var_110_21 then
					arg_107_1.talkMaxDuration = var_110_21

					if var_110_21 + var_110_14 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_21 + var_110_14
					end
				end

				arg_107_1.text_.text = var_110_18
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351026", "story_v_out_116351.awb") ~= 0 then
					local var_110_22 = manager.audio:GetVoiceLength("story_v_out_116351", "116351026", "story_v_out_116351.awb") / 1000

					if var_110_22 + var_110_14 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_22 + var_110_14
					end

					if var_110_17.prefab_name ~= "" and arg_107_1.actors_[var_110_17.prefab_name] ~= nil then
						local var_110_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_17.prefab_name].transform, "story_v_out_116351", "116351026", "story_v_out_116351.awb")

						arg_107_1:RecordAudio("116351026", var_110_23)
						arg_107_1:RecordAudio("116351026", var_110_23)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_116351", "116351026", "story_v_out_116351.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_116351", "116351026", "story_v_out_116351.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_24 = math.max(var_110_15, arg_107_1.talkMaxDuration)

			if var_110_14 <= arg_107_1.time_ and arg_107_1.time_ < var_110_14 + var_110_24 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_14) / var_110_24

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_14 + var_110_24 and arg_107_1.time_ < var_110_14 + var_110_24 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play116351027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 116351027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play116351028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10025ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10025ui_story == nil then
				arg_111_1.var_.characterEffect10025ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect10025ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10025ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10025ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10025ui_story.fillRatio = var_114_5
			end

			local var_114_6 = 0
			local var_114_7 = 0.425

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_8 = arg_111_1:FormatText(StoryNameCfg[344].name)

				arg_111_1.leftNameTxt_.text = var_114_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_9 = arg_111_1:GetWordFromCfg(116351027)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 17
				local var_114_12 = utf8.len(var_114_10)
				local var_114_13 = var_114_11 <= 0 and var_114_7 or var_114_7 * (var_114_12 / var_114_11)

				if var_114_13 > 0 and var_114_7 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_10
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_14 and arg_111_1.time_ < var_114_6 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play116351028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 116351028
		arg_115_1.duration_ = 12.77

		local var_115_0 = {
			zh = 7.466,
			ja = 12.766
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
				arg_115_0:Play116351029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10025ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos10025ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(0, -1.1, -5.9)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10025ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = 0

			if var_118_9 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 then
				arg_115_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_10 = arg_115_1.actors_["10025ui_story"]
			local var_118_11 = 0

			if var_118_11 < arg_115_1.time_ and arg_115_1.time_ <= var_118_11 + arg_118_0 and not isNil(var_118_10) and arg_115_1.var_.characterEffect10025ui_story == nil then
				arg_115_1.var_.characterEffect10025ui_story = var_118_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_12 = 0.2

			if var_118_11 <= arg_115_1.time_ and arg_115_1.time_ < var_118_11 + var_118_12 and not isNil(var_118_10) then
				local var_118_13 = (arg_115_1.time_ - var_118_11) / var_118_12

				if arg_115_1.var_.characterEffect10025ui_story and not isNil(var_118_10) then
					arg_115_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_11 + var_118_12 and arg_115_1.time_ < var_118_11 + var_118_12 + arg_118_0 and not isNil(var_118_10) and arg_115_1.var_.characterEffect10025ui_story then
				arg_115_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_118_14 = 0

			if var_118_14 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_2")
			end

			local var_118_15 = 0
			local var_118_16 = 0.75

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_17 = arg_115_1:FormatText(StoryNameCfg[328].name)

				arg_115_1.leftNameTxt_.text = var_118_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_18 = arg_115_1:GetWordFromCfg(116351028)
				local var_118_19 = arg_115_1:FormatText(var_118_18.content)

				arg_115_1.text_.text = var_118_19

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_20 = 29
				local var_118_21 = utf8.len(var_118_19)
				local var_118_22 = var_118_20 <= 0 and var_118_16 or var_118_16 * (var_118_21 / var_118_20)

				if var_118_22 > 0 and var_118_16 < var_118_22 then
					arg_115_1.talkMaxDuration = var_118_22

					if var_118_22 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_22 + var_118_15
					end
				end

				arg_115_1.text_.text = var_118_19
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351028", "story_v_out_116351.awb") ~= 0 then
					local var_118_23 = manager.audio:GetVoiceLength("story_v_out_116351", "116351028", "story_v_out_116351.awb") / 1000

					if var_118_23 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_23 + var_118_15
					end

					if var_118_18.prefab_name ~= "" and arg_115_1.actors_[var_118_18.prefab_name] ~= nil then
						local var_118_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_18.prefab_name].transform, "story_v_out_116351", "116351028", "story_v_out_116351.awb")

						arg_115_1:RecordAudio("116351028", var_118_24)
						arg_115_1:RecordAudio("116351028", var_118_24)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_116351", "116351028", "story_v_out_116351.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_116351", "116351028", "story_v_out_116351.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_25 = math.max(var_118_16, arg_115_1.talkMaxDuration)

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_25 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_15) / var_118_25

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_15 + var_118_25 and arg_115_1.time_ < var_118_15 + var_118_25 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play116351029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 116351029
		arg_119_1.duration_ = 0.2

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"

			SetActive(arg_119_1.choicesGo_, true)

			for iter_120_0, iter_120_1 in ipairs(arg_119_1.choices_) do
				local var_120_0 = iter_120_0 <= 2

				SetActive(iter_120_1.go, var_120_0)
			end

			arg_119_1.choices_[1].txt.text = arg_119_1:FormatText(StoryChoiceCfg[271].name)
			arg_119_1.choices_[2].txt.text = arg_119_1:FormatText(StoryChoiceCfg[272].name)
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play116351030(arg_119_1)
			end

			if arg_121_0 == 2 then
				arg_119_0:Play116351030(arg_119_1)
			end

			arg_119_1:RecordChoiceLog(116351029, 271, 272)
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10025ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10025ui_story == nil then
				arg_119_1.var_.characterEffect10025ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.2

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect10025ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10025ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10025ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10025ui_story.fillRatio = var_122_5
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play116351030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 116351030
		arg_123_1.duration_ = 2.73

		local var_123_0 = {
			zh = 2.633,
			ja = 2.733
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play116351031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10025ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos10025ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0, -1.1, -5.9)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10025ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = "10025ui_story"

			if arg_123_1.actors_[var_126_9] == nil then
				local var_126_10 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_126_10) then
					local var_126_11 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_123_1.stage_.transform)

					var_126_11.name = var_126_9
					var_126_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_123_1.actors_[var_126_9] = var_126_11

					local var_126_12 = var_126_11:GetComponentInChildren(typeof(CharacterEffect))

					var_126_12.enabled = true

					local var_126_13 = GameObjectTools.GetOrAddComponent(var_126_11, typeof(DynamicBoneHelper))

					if var_126_13 then
						var_126_13:EnableDynamicBone(false)
					end

					arg_123_1:ShowWeapon(var_126_12.transform, false)

					arg_123_1.var_[var_126_9 .. "Animator"] = var_126_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_123_1.var_[var_126_9 .. "Animator"].applyRootMotion = true
					arg_123_1.var_[var_126_9 .. "LipSync"] = var_126_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_126_14 = 0

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_126_15 = arg_123_1.actors_["10025ui_story"]
			local var_126_16 = 0

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 and not isNil(var_126_15) and arg_123_1.var_.characterEffect10025ui_story == nil then
				arg_123_1.var_.characterEffect10025ui_story = var_126_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_17 = 0.2

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 and not isNil(var_126_15) then
				local var_126_18 = (arg_123_1.time_ - var_126_16) / var_126_17

				if arg_123_1.var_.characterEffect10025ui_story and not isNil(var_126_15) then
					arg_123_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 and not isNil(var_126_15) and arg_123_1.var_.characterEffect10025ui_story then
				arg_123_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_126_19 = 0
			local var_126_20 = 0.15

			if var_126_19 < arg_123_1.time_ and arg_123_1.time_ <= var_126_19 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_21 = arg_123_1:FormatText(StoryNameCfg[328].name)

				arg_123_1.leftNameTxt_.text = var_126_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_22 = arg_123_1:GetWordFromCfg(116351030)
				local var_126_23 = arg_123_1:FormatText(var_126_22.content)

				arg_123_1.text_.text = var_126_23

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_24 = 6
				local var_126_25 = utf8.len(var_126_23)
				local var_126_26 = var_126_24 <= 0 and var_126_20 or var_126_20 * (var_126_25 / var_126_24)

				if var_126_26 > 0 and var_126_20 < var_126_26 then
					arg_123_1.talkMaxDuration = var_126_26

					if var_126_26 + var_126_19 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_26 + var_126_19
					end
				end

				arg_123_1.text_.text = var_126_23
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351030", "story_v_out_116351.awb") ~= 0 then
					local var_126_27 = manager.audio:GetVoiceLength("story_v_out_116351", "116351030", "story_v_out_116351.awb") / 1000

					if var_126_27 + var_126_19 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_27 + var_126_19
					end

					if var_126_22.prefab_name ~= "" and arg_123_1.actors_[var_126_22.prefab_name] ~= nil then
						local var_126_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_22.prefab_name].transform, "story_v_out_116351", "116351030", "story_v_out_116351.awb")

						arg_123_1:RecordAudio("116351030", var_126_28)
						arg_123_1:RecordAudio("116351030", var_126_28)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_116351", "116351030", "story_v_out_116351.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_116351", "116351030", "story_v_out_116351.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_29 = math.max(var_126_20, arg_123_1.talkMaxDuration)

			if var_126_19 <= arg_123_1.time_ and arg_123_1.time_ < var_126_19 + var_126_29 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_19) / var_126_29

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_19 + var_126_29 and arg_123_1.time_ < var_126_19 + var_126_29 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play116351031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 116351031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play116351032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10025ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10025ui_story == nil then
				arg_127_1.var_.characterEffect10025ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect10025ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10025ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10025ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10025ui_story.fillRatio = var_130_5
			end

			local var_130_6 = 0
			local var_130_7 = 0.15

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_8 = arg_127_1:FormatText(StoryNameCfg[344].name)

				arg_127_1.leftNameTxt_.text = var_130_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_9 = arg_127_1:GetWordFromCfg(116351031)
				local var_130_10 = arg_127_1:FormatText(var_130_9.content)

				arg_127_1.text_.text = var_130_10

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 6
				local var_130_12 = utf8.len(var_130_10)
				local var_130_13 = var_130_11 <= 0 and var_130_7 or var_130_7 * (var_130_12 / var_130_11)

				if var_130_13 > 0 and var_130_7 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_10
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play116351032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 116351032
		arg_131_1.duration_ = 8.8

		local var_131_0 = {
			zh = 6,
			ja = 8.8
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
				arg_131_0:Play116351033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10025ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos10025ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, -1.1, -5.9)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10025ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = 0

			if var_134_9 < arg_131_1.time_ and arg_131_1.time_ <= var_134_9 + arg_134_0 then
				arg_131_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_134_10 = arg_131_1.actors_["10025ui_story"]
			local var_134_11 = 0

			if var_134_11 < arg_131_1.time_ and arg_131_1.time_ <= var_134_11 + arg_134_0 and not isNil(var_134_10) and arg_131_1.var_.characterEffect10025ui_story == nil then
				arg_131_1.var_.characterEffect10025ui_story = var_134_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_12 = 0.2

			if var_134_11 <= arg_131_1.time_ and arg_131_1.time_ < var_134_11 + var_134_12 and not isNil(var_134_10) then
				local var_134_13 = (arg_131_1.time_ - var_134_11) / var_134_12

				if arg_131_1.var_.characterEffect10025ui_story and not isNil(var_134_10) then
					arg_131_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_11 + var_134_12 and arg_131_1.time_ < var_134_11 + var_134_12 + arg_134_0 and not isNil(var_134_10) and arg_131_1.var_.characterEffect10025ui_story then
				arg_131_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_134_15 = 0
			local var_134_16 = 0.475

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_17 = arg_131_1:FormatText(StoryNameCfg[328].name)

				arg_131_1.leftNameTxt_.text = var_134_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_18 = arg_131_1:GetWordFromCfg(116351032)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_20 = 19
				local var_134_21 = utf8.len(var_134_19)
				local var_134_22 = var_134_20 <= 0 and var_134_16 or var_134_16 * (var_134_21 / var_134_20)

				if var_134_22 > 0 and var_134_16 < var_134_22 then
					arg_131_1.talkMaxDuration = var_134_22

					if var_134_22 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_22 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_19
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351032", "story_v_out_116351.awb") ~= 0 then
					local var_134_23 = manager.audio:GetVoiceLength("story_v_out_116351", "116351032", "story_v_out_116351.awb") / 1000

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_out_116351", "116351032", "story_v_out_116351.awb")

						arg_131_1:RecordAudio("116351032", var_134_24)
						arg_131_1:RecordAudio("116351032", var_134_24)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_116351", "116351032", "story_v_out_116351.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_116351", "116351032", "story_v_out_116351.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_25 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_25 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_15) / var_134_25

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_15 + var_134_25 and arg_131_1.time_ < var_134_15 + var_134_25 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play116351033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 116351033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play116351034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10025ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect10025ui_story == nil then
				arg_135_1.var_.characterEffect10025ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect10025ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10025ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect10025ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10025ui_story.fillRatio = var_138_5
			end

			local var_138_6 = 0
			local var_138_7 = 0.675

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_8 = arg_135_1:FormatText(StoryNameCfg[344].name)

				arg_135_1.leftNameTxt_.text = var_138_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_9 = arg_135_1:GetWordFromCfg(116351033)
				local var_138_10 = arg_135_1:FormatText(var_138_9.content)

				arg_135_1.text_.text = var_138_10

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_11 = 27
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
	Play116351034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 116351034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play116351035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.85

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[344].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:GetWordFromCfg(116351034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 34
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
	Play116351035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 116351035
		arg_143_1.duration_ = 5.17

		local var_143_0 = {
			zh = 2.866,
			ja = 5.166
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
				arg_143_0:Play116351036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10025ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos10025ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(0, -1.1, -5.9)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10025ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = 0

			if var_146_9 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 then
				arg_143_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_146_10 = arg_143_1.actors_["10025ui_story"]
			local var_146_11 = 0

			if var_146_11 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 and not isNil(var_146_10) and arg_143_1.var_.characterEffect10025ui_story == nil then
				arg_143_1.var_.characterEffect10025ui_story = var_146_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_12 = 0.2

			if var_146_11 <= arg_143_1.time_ and arg_143_1.time_ < var_146_11 + var_146_12 and not isNil(var_146_10) then
				local var_146_13 = (arg_143_1.time_ - var_146_11) / var_146_12

				if arg_143_1.var_.characterEffect10025ui_story and not isNil(var_146_10) then
					arg_143_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_11 + var_146_12 and arg_143_1.time_ < var_146_11 + var_146_12 + arg_146_0 and not isNil(var_146_10) and arg_143_1.var_.characterEffect10025ui_story then
				arg_143_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_146_14 = 0

			if var_146_14 < arg_143_1.time_ and arg_143_1.time_ <= var_146_14 + arg_146_0 then
				arg_143_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_146_15 = 0
			local var_146_16 = 0.275

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_17 = arg_143_1:FormatText(StoryNameCfg[328].name)

				arg_143_1.leftNameTxt_.text = var_146_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_18 = arg_143_1:GetWordFromCfg(116351035)
				local var_146_19 = arg_143_1:FormatText(var_146_18.content)

				arg_143_1.text_.text = var_146_19

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_20 = 11
				local var_146_21 = utf8.len(var_146_19)
				local var_146_22 = var_146_20 <= 0 and var_146_16 or var_146_16 * (var_146_21 / var_146_20)

				if var_146_22 > 0 and var_146_16 < var_146_22 then
					arg_143_1.talkMaxDuration = var_146_22

					if var_146_22 + var_146_15 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_22 + var_146_15
					end
				end

				arg_143_1.text_.text = var_146_19
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351035", "story_v_out_116351.awb") ~= 0 then
					local var_146_23 = manager.audio:GetVoiceLength("story_v_out_116351", "116351035", "story_v_out_116351.awb") / 1000

					if var_146_23 + var_146_15 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_23 + var_146_15
					end

					if var_146_18.prefab_name ~= "" and arg_143_1.actors_[var_146_18.prefab_name] ~= nil then
						local var_146_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_18.prefab_name].transform, "story_v_out_116351", "116351035", "story_v_out_116351.awb")

						arg_143_1:RecordAudio("116351035", var_146_24)
						arg_143_1:RecordAudio("116351035", var_146_24)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_116351", "116351035", "story_v_out_116351.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_116351", "116351035", "story_v_out_116351.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_25 = math.max(var_146_16, arg_143_1.talkMaxDuration)

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_25 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_15) / var_146_25

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_15 + var_146_25 and arg_143_1.time_ < var_146_15 + var_146_25 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play116351036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 116351036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play116351037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10025ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10025ui_story == nil then
				arg_147_1.var_.characterEffect10025ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.2

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect10025ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10025ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10025ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10025ui_story.fillRatio = var_150_5
			end

			local var_150_6 = 0
			local var_150_7 = 0.5

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_8 = arg_147_1:FormatText(StoryNameCfg[344].name)

				arg_147_1.leftNameTxt_.text = var_150_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_9 = arg_147_1:GetWordFromCfg(116351036)
				local var_150_10 = arg_147_1:FormatText(var_150_9.content)

				arg_147_1.text_.text = var_150_10

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 20
				local var_150_12 = utf8.len(var_150_10)
				local var_150_13 = var_150_11 <= 0 and var_150_7 or var_150_7 * (var_150_12 / var_150_11)

				if var_150_13 > 0 and var_150_7 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_10
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_14 and arg_147_1.time_ < var_150_6 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play116351037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 116351037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play116351038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.6

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[344].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(116351037)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 24
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_8 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_8 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_8

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_8 and arg_151_1.time_ < var_154_0 + var_154_8 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play116351038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 116351038
		arg_155_1.duration_ = 3.87

		local var_155_0 = {
			zh = 2.633,
			ja = 3.866
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
				arg_155_0:Play116351039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10025ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10025ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0, -1.1, -5.9)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10025ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = 0

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 then
				arg_155_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_158_10 = arg_155_1.actors_["10025ui_story"]
			local var_158_11 = 0

			if var_158_11 < arg_155_1.time_ and arg_155_1.time_ <= var_158_11 + arg_158_0 and not isNil(var_158_10) and arg_155_1.var_.characterEffect10025ui_story == nil then
				arg_155_1.var_.characterEffect10025ui_story = var_158_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_12 = 0.2

			if var_158_11 <= arg_155_1.time_ and arg_155_1.time_ < var_158_11 + var_158_12 and not isNil(var_158_10) then
				local var_158_13 = (arg_155_1.time_ - var_158_11) / var_158_12

				if arg_155_1.var_.characterEffect10025ui_story and not isNil(var_158_10) then
					arg_155_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_11 + var_158_12 and arg_155_1.time_ < var_158_11 + var_158_12 + arg_158_0 and not isNil(var_158_10) and arg_155_1.var_.characterEffect10025ui_story then
				arg_155_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_158_14 = 0
			local var_158_15 = 0.25

			if var_158_14 < arg_155_1.time_ and arg_155_1.time_ <= var_158_14 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_16 = arg_155_1:FormatText(StoryNameCfg[328].name)

				arg_155_1.leftNameTxt_.text = var_158_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_17 = arg_155_1:GetWordFromCfg(116351038)
				local var_158_18 = arg_155_1:FormatText(var_158_17.content)

				arg_155_1.text_.text = var_158_18

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_19 = 10
				local var_158_20 = utf8.len(var_158_18)
				local var_158_21 = var_158_19 <= 0 and var_158_15 or var_158_15 * (var_158_20 / var_158_19)

				if var_158_21 > 0 and var_158_15 < var_158_21 then
					arg_155_1.talkMaxDuration = var_158_21

					if var_158_21 + var_158_14 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_21 + var_158_14
					end
				end

				arg_155_1.text_.text = var_158_18
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351038", "story_v_out_116351.awb") ~= 0 then
					local var_158_22 = manager.audio:GetVoiceLength("story_v_out_116351", "116351038", "story_v_out_116351.awb") / 1000

					if var_158_22 + var_158_14 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_22 + var_158_14
					end

					if var_158_17.prefab_name ~= "" and arg_155_1.actors_[var_158_17.prefab_name] ~= nil then
						local var_158_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_17.prefab_name].transform, "story_v_out_116351", "116351038", "story_v_out_116351.awb")

						arg_155_1:RecordAudio("116351038", var_158_23)
						arg_155_1:RecordAudio("116351038", var_158_23)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_116351", "116351038", "story_v_out_116351.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_116351", "116351038", "story_v_out_116351.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_24 = math.max(var_158_15, arg_155_1.talkMaxDuration)

			if var_158_14 <= arg_155_1.time_ and arg_155_1.time_ < var_158_14 + var_158_24 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_14) / var_158_24

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_14 + var_158_24 and arg_155_1.time_ < var_158_14 + var_158_24 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play116351039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 116351039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play116351040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10025ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10025ui_story == nil then
				arg_159_1.var_.characterEffect10025ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.2

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect10025ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10025ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10025ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10025ui_story.fillRatio = var_162_5
			end

			local var_162_6 = 0
			local var_162_7 = 0.35

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_8 = arg_159_1:FormatText(StoryNameCfg[344].name)

				arg_159_1.leftNameTxt_.text = var_162_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_9 = arg_159_1:GetWordFromCfg(116351039)
				local var_162_10 = arg_159_1:FormatText(var_162_9.content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 14
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
	Play116351040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 116351040
		arg_163_1.duration_ = 6.1

		local var_163_0 = {
			zh = 6.1,
			ja = 3.2
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play116351041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10025ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10025ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, -1.1, -5.9)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10025ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = 0

			if var_166_9 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 then
				arg_163_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_166_10 = arg_163_1.actors_["10025ui_story"]
			local var_166_11 = 0

			if var_166_11 < arg_163_1.time_ and arg_163_1.time_ <= var_166_11 + arg_166_0 and not isNil(var_166_10) and arg_163_1.var_.characterEffect10025ui_story == nil then
				arg_163_1.var_.characterEffect10025ui_story = var_166_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_12 = 0.2

			if var_166_11 <= arg_163_1.time_ and arg_163_1.time_ < var_166_11 + var_166_12 and not isNil(var_166_10) then
				local var_166_13 = (arg_163_1.time_ - var_166_11) / var_166_12

				if arg_163_1.var_.characterEffect10025ui_story and not isNil(var_166_10) then
					arg_163_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_11 + var_166_12 and arg_163_1.time_ < var_166_11 + var_166_12 + arg_166_0 and not isNil(var_166_10) and arg_163_1.var_.characterEffect10025ui_story then
				arg_163_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_166_14 = 0

			if var_166_14 < arg_163_1.time_ and arg_163_1.time_ <= var_166_14 + arg_166_0 then
				arg_163_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action2_1")
			end

			local var_166_15 = 0
			local var_166_16 = 0.425

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_17 = arg_163_1:FormatText(StoryNameCfg[328].name)

				arg_163_1.leftNameTxt_.text = var_166_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:GetWordFromCfg(116351040)
				local var_166_19 = arg_163_1:FormatText(var_166_18.content)

				arg_163_1.text_.text = var_166_19

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 17
				local var_166_21 = utf8.len(var_166_19)
				local var_166_22 = var_166_20 <= 0 and var_166_16 or var_166_16 * (var_166_21 / var_166_20)

				if var_166_22 > 0 and var_166_16 < var_166_22 then
					arg_163_1.talkMaxDuration = var_166_22

					if var_166_22 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_22 + var_166_15
					end
				end

				arg_163_1.text_.text = var_166_19
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351040", "story_v_out_116351.awb") ~= 0 then
					local var_166_23 = manager.audio:GetVoiceLength("story_v_out_116351", "116351040", "story_v_out_116351.awb") / 1000

					if var_166_23 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_23 + var_166_15
					end

					if var_166_18.prefab_name ~= "" and arg_163_1.actors_[var_166_18.prefab_name] ~= nil then
						local var_166_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_18.prefab_name].transform, "story_v_out_116351", "116351040", "story_v_out_116351.awb")

						arg_163_1:RecordAudio("116351040", var_166_24)
						arg_163_1:RecordAudio("116351040", var_166_24)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_116351", "116351040", "story_v_out_116351.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_116351", "116351040", "story_v_out_116351.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_25 = math.max(var_166_16, arg_163_1.talkMaxDuration)

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_25 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_15) / var_166_25

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_15 + var_166_25 and arg_163_1.time_ < var_166_15 + var_166_25 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play116351041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 116351041
		arg_167_1.duration_ = 4.73

		local var_167_0 = {
			zh = 2.7,
			ja = 4.733
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play116351042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10025ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10025ui_story == nil then
				arg_167_1.var_.characterEffect10025ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect10025ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10025ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10025ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10025ui_story.fillRatio = var_170_5
			end

			local var_170_6 = 0

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action426")
			end

			local var_170_7 = 0
			local var_170_8 = 0.0166666666666667

			if var_170_7 < arg_167_1.time_ and arg_167_1.time_ <= var_170_7 + arg_170_0 then
				local var_170_9 = "play"
				local var_170_10 = "music"

				arg_167_1:AudioAction(var_170_9, var_170_10, "ui_battle", "ui_battle_stopbgm", "")

				local var_170_11 = ""
				local var_170_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_170_12 ~= "" then
					if arg_167_1.bgmTxt_.text ~= var_170_12 and arg_167_1.bgmTxt_.text ~= "" then
						if arg_167_1.bgmTxt2_.text ~= "" then
							arg_167_1.bgmTxt_.text = arg_167_1.bgmTxt2_.text
						end

						arg_167_1.bgmTxt2_.text = var_170_12

						arg_167_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_167_1.bgmTxt_.text = var_170_12
						arg_167_1.bgmTxt2_.text = var_170_12
					end

					if arg_167_1.bgmTimer then
						arg_167_1.bgmTimer:Stop()

						arg_167_1.bgmTimer = nil
					end

					if arg_167_1.settingData.show_music_name == 1 then
						arg_167_1.musicController:SetSelectedState("show")
						arg_167_1.musicAnimator_:Play("open", 0, 0)

						if arg_167_1.settingData.music_time ~= 0 then
							arg_167_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_167_1.settingData.music_time), function()
								if arg_167_1 == nil or isNil(arg_167_1.bgmTxt_) then
									return
								end

								arg_167_1.musicController:SetSelectedState("hide")
								arg_167_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_170_13 = 0
			local var_170_14 = 0.375

			if var_170_13 < arg_167_1.time_ and arg_167_1.time_ <= var_170_13 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_15 = arg_167_1:FormatText(StoryNameCfg[320].name)

				arg_167_1.leftNameTxt_.text = var_170_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_16 = arg_167_1:GetWordFromCfg(116351041)
				local var_170_17 = arg_167_1:FormatText(var_170_16.content)

				arg_167_1.text_.text = var_170_17

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_18 = 15
				local var_170_19 = utf8.len(var_170_17)
				local var_170_20 = var_170_18 <= 0 and var_170_14 or var_170_14 * (var_170_19 / var_170_18)

				if var_170_20 > 0 and var_170_14 < var_170_20 then
					arg_167_1.talkMaxDuration = var_170_20

					if var_170_20 + var_170_13 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_20 + var_170_13
					end
				end

				arg_167_1.text_.text = var_170_17
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351041", "story_v_out_116351.awb") ~= 0 then
					local var_170_21 = manager.audio:GetVoiceLength("story_v_out_116351", "116351041", "story_v_out_116351.awb") / 1000

					if var_170_21 + var_170_13 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_21 + var_170_13
					end

					if var_170_16.prefab_name ~= "" and arg_167_1.actors_[var_170_16.prefab_name] ~= nil then
						local var_170_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_16.prefab_name].transform, "story_v_out_116351", "116351041", "story_v_out_116351.awb")

						arg_167_1:RecordAudio("116351041", var_170_22)
						arg_167_1:RecordAudio("116351041", var_170_22)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_116351", "116351041", "story_v_out_116351.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_116351", "116351041", "story_v_out_116351.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_23 = math.max(var_170_14, arg_167_1.talkMaxDuration)

			if var_170_13 <= arg_167_1.time_ and arg_167_1.time_ < var_170_13 + var_170_23 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_13) / var_170_23

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_13 + var_170_23 and arg_167_1.time_ < var_170_13 + var_170_23 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play116351042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 116351042
		arg_172_1.duration_ = 4.57

		local var_172_0 = {
			zh = 4.566,
			ja = 4.5
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play116351043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 0.5

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[321].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:GetWordFromCfg(116351042)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 20
				local var_175_6 = utf8.len(var_175_4)
				local var_175_7 = var_175_5 <= 0 and var_175_1 or var_175_1 * (var_175_6 / var_175_5)

				if var_175_7 > 0 and var_175_1 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351042", "story_v_out_116351.awb") ~= 0 then
					local var_175_8 = manager.audio:GetVoiceLength("story_v_out_116351", "116351042", "story_v_out_116351.awb") / 1000

					if var_175_8 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_0
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_out_116351", "116351042", "story_v_out_116351.awb")

						arg_172_1:RecordAudio("116351042", var_175_9)
						arg_172_1:RecordAudio("116351042", var_175_9)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_116351", "116351042", "story_v_out_116351.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_116351", "116351042", "story_v_out_116351.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_10 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_10 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_10

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_10 and arg_172_1.time_ < var_175_0 + var_175_10 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play116351043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 116351043
		arg_176_1.duration_ = 5.8

		local var_176_0 = {
			zh = 5.8,
			ja = 5.6
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
				arg_176_0:Play116351044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10025ui_story"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos10025ui_story = var_179_0.localPosition
			end

			local var_179_2 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2
				local var_179_4 = Vector3.New(0, -1.1, -5.9)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10025ui_story, var_179_4, var_179_3)

				local var_179_5 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_5.x, var_179_5.y, var_179_5.z)

				local var_179_6 = var_179_0.localEulerAngles

				var_179_6.z = 0
				var_179_6.x = 0
				var_179_0.localEulerAngles = var_179_6
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_179_7 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_7.x, var_179_7.y, var_179_7.z)

				local var_179_8 = var_179_0.localEulerAngles

				var_179_8.z = 0
				var_179_8.x = 0
				var_179_0.localEulerAngles = var_179_8
			end

			local var_179_9 = 0

			if var_179_9 < arg_176_1.time_ and arg_176_1.time_ <= var_179_9 + arg_179_0 then
				arg_176_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_179_10 = arg_176_1.actors_["10025ui_story"]
			local var_179_11 = 0

			if var_179_11 < arg_176_1.time_ and arg_176_1.time_ <= var_179_11 + arg_179_0 and not isNil(var_179_10) and arg_176_1.var_.characterEffect10025ui_story == nil then
				arg_176_1.var_.characterEffect10025ui_story = var_179_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_12 = 0.2

			if var_179_11 <= arg_176_1.time_ and arg_176_1.time_ < var_179_11 + var_179_12 and not isNil(var_179_10) then
				local var_179_13 = (arg_176_1.time_ - var_179_11) / var_179_12

				if arg_176_1.var_.characterEffect10025ui_story and not isNil(var_179_10) then
					arg_176_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_11 + var_179_12 and arg_176_1.time_ < var_179_11 + var_179_12 + arg_179_0 and not isNil(var_179_10) and arg_176_1.var_.characterEffect10025ui_story then
				arg_176_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_179_14 = 0

			if var_179_14 < arg_176_1.time_ and arg_176_1.time_ <= var_179_14 + arg_179_0 then
				arg_176_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_179_15 = 0
			local var_179_16 = 0.425

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

				local var_179_18 = arg_176_1:GetWordFromCfg(116351043)
				local var_179_19 = arg_176_1:FormatText(var_179_18.content)

				arg_176_1.text_.text = var_179_19

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_20 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_116351", "116351043", "story_v_out_116351.awb") ~= 0 then
					local var_179_23 = manager.audio:GetVoiceLength("story_v_out_116351", "116351043", "story_v_out_116351.awb") / 1000

					if var_179_23 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_23 + var_179_15
					end

					if var_179_18.prefab_name ~= "" and arg_176_1.actors_[var_179_18.prefab_name] ~= nil then
						local var_179_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_18.prefab_name].transform, "story_v_out_116351", "116351043", "story_v_out_116351.awb")

						arg_176_1:RecordAudio("116351043", var_179_24)
						arg_176_1:RecordAudio("116351043", var_179_24)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_116351", "116351043", "story_v_out_116351.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_116351", "116351043", "story_v_out_116351.awb")
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play116351044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 116351044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
			arg_180_1.auto_ = false
		end

		function arg_180_1.playNext_(arg_182_0)
			arg_180_1.onStoryFinished_()
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
			local var_183_7 = 0.25

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_8 = arg_180_1:FormatText(StoryNameCfg[344].name)

				arg_180_1.leftNameTxt_.text = var_183_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_9 = arg_180_1:GetWordFromCfg(116351044)
				local var_183_10 = arg_180_1:FormatText(var_183_9.content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 10
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
	assets = {
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/ST15"
	},
	voices = {
		"story_v_out_116351.awb"
	}
}
