return {
	Play420051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420051001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play420051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0505"

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
				local var_4_5 = arg_1_1.bgs_.ST0505

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
					if iter_4_0 ~= "ST0505" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.100000000001

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

			local var_4_24 = "404001ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["404001ui_story"].transform
			local var_4_30 = 1.46666666666667

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos404001ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -1.55, -5.5)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos404001ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["404001ui_story"]
			local var_4_39 = 1.46666666666667

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect404001ui_story == nil then
				arg_1_1.var_.characterEffect404001ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect404001ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect404001ui_story then
				arg_1_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_4_42 = 1.46666666666667

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_4_43 = 1.46666666666667

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_4_44 = 1.6
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "effect"

				arg_1_1:AudioAction(var_4_46, var_4_47, "se_story_140", "se_story_140_snap", "")
			end

			local var_4_48 = 0
			local var_4_49 = 0.2

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_54 = 0.366666666666667
			local var_4_55 = 1

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_56 = "play"
				local var_4_57 = "music"

				arg_1_1:AudioAction(var_4_56, var_4_57, "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_4_58 = ""
				local var_4_59 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

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

			local var_4_60 = 1.999999999999
			local var_4_61 = 0.25

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_62 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_62:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[668].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(420051001)
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

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051001", "story_v_out_420051.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_out_420051", "420051001", "story_v_out_420051.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_out_420051", "420051001", "story_v_out_420051.awb")

						arg_1_1:RecordAudio("420051001", var_4_70)
						arg_1_1:RecordAudio("420051001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_420051", "420051001", "story_v_out_420051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_420051", "420051001", "story_v_out_420051.awb")
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
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play420051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 420051002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play420051003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["404001ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos404001ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(0, 100, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos404001ui_story, var_12_4, var_12_3)

				local var_12_5 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_5.x, var_12_5.y, var_12_5.z)

				local var_12_6 = var_12_0.localEulerAngles

				var_12_6.z = 0
				var_12_6.x = 0
				var_12_0.localEulerAngles = var_12_6
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, 100, 0)

				local var_12_7 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_7.x, var_12_7.y, var_12_7.z)

				local var_12_8 = var_12_0.localEulerAngles

				var_12_8.z = 0
				var_12_8.x = 0
				var_12_0.localEulerAngles = var_12_8
			end

			local var_12_9 = 0
			local var_12_10 = 1

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_11 = arg_9_1:GetWordFromCfg(420051002)
				local var_12_12 = arg_9_1:FormatText(var_12_11.content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 40
				local var_12_14 = utf8.len(var_12_12)
				local var_12_15 = var_12_13 <= 0 and var_12_10 or var_12_10 * (var_12_14 / var_12_13)

				if var_12_15 > 0 and var_12_10 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_9 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_9
					end
				end

				arg_9_1.text_.text = var_12_12
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_10, arg_9_1.talkMaxDuration)

			if var_12_9 <= arg_9_1.time_ and arg_9_1.time_ < var_12_9 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_9) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_9 + var_12_16 and arg_9_1.time_ < var_12_9 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play420051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 420051003
		arg_13_1.duration_ = 7.57

		local var_13_0 = {
			zh = 5.3,
			ja = 7.566
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
				arg_13_0:Play420051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["404001ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos404001ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, -1.55, -5.5)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos404001ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["404001ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect404001ui_story == nil then
				arg_13_1.var_.characterEffect404001ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect404001ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect404001ui_story then
				arg_13_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_1")
			end

			local var_16_14 = 0

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_16_15 = 0
			local var_16_16 = 0.55

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[668].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(420051003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051003", "story_v_out_420051.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051003", "story_v_out_420051.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_420051", "420051003", "story_v_out_420051.awb")

						arg_13_1:RecordAudio("420051003", var_16_24)
						arg_13_1:RecordAudio("420051003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_420051", "420051003", "story_v_out_420051.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_420051", "420051003", "story_v_out_420051.awb")
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
				actorName = "404001ui_story",
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
	Play420051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 420051004
		arg_17_1.duration_ = 4.6

		local var_17_0 = {
			zh = 3.5,
			ja = 4.6
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
				arg_17_0:Play420051005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["404001ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos404001ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos404001ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = "1085ui_story"

			if arg_17_1.actors_[var_20_9] == nil then
				local var_20_10 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_20_10) then
					local var_20_11 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_17_1.stage_.transform)

					var_20_11.name = var_20_9
					var_20_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_9] = var_20_11

					local var_20_12 = var_20_11:GetComponentInChildren(typeof(CharacterEffect))

					var_20_12.enabled = true

					local var_20_13 = GameObjectTools.GetOrAddComponent(var_20_11, typeof(DynamicBoneHelper))

					if var_20_13 then
						var_20_13:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_12.transform, false)

					arg_17_1.var_[var_20_9 .. "Animator"] = var_20_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_9 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_9 .. "LipSync"] = var_20_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_14 = arg_17_1.actors_["1085ui_story"].transform
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.var_.moveOldPos1085ui_story = var_20_14.localPosition
			end

			local var_20_16 = 0.001

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16
				local var_20_18 = Vector3.New(0.75, -1.01, -5.83)

				var_20_14.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1085ui_story, var_20_18, var_20_17)

				local var_20_19 = manager.ui.mainCamera.transform.position - var_20_14.position

				var_20_14.forward = Vector3.New(var_20_19.x, var_20_19.y, var_20_19.z)

				local var_20_20 = var_20_14.localEulerAngles

				var_20_20.z = 0
				var_20_20.x = 0
				var_20_14.localEulerAngles = var_20_20
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 then
				var_20_14.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_20_21 = manager.ui.mainCamera.transform.position - var_20_14.position

				var_20_14.forward = Vector3.New(var_20_21.x, var_20_21.y, var_20_21.z)

				local var_20_22 = var_20_14.localEulerAngles

				var_20_22.z = 0
				var_20_22.x = 0
				var_20_14.localEulerAngles = var_20_22
			end

			local var_20_23 = arg_17_1.actors_["1085ui_story"]
			local var_20_24 = 0

			if var_20_24 < arg_17_1.time_ and arg_17_1.time_ <= var_20_24 + arg_20_0 and not isNil(var_20_23) and arg_17_1.var_.characterEffect1085ui_story == nil then
				arg_17_1.var_.characterEffect1085ui_story = var_20_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_25 = 0.200000002980232

			if var_20_24 <= arg_17_1.time_ and arg_17_1.time_ < var_20_24 + var_20_25 and not isNil(var_20_23) then
				local var_20_26 = (arg_17_1.time_ - var_20_24) / var_20_25

				if arg_17_1.var_.characterEffect1085ui_story and not isNil(var_20_23) then
					arg_17_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_24 + var_20_25 and arg_17_1.time_ < var_20_24 + var_20_25 + arg_20_0 and not isNil(var_20_23) and arg_17_1.var_.characterEffect1085ui_story then
				arg_17_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_20_27 = arg_17_1.actors_["404001ui_story"]
			local var_20_28 = 0

			if var_20_28 < arg_17_1.time_ and arg_17_1.time_ <= var_20_28 + arg_20_0 and not isNil(var_20_27) and arg_17_1.var_.characterEffect404001ui_story == nil then
				arg_17_1.var_.characterEffect404001ui_story = var_20_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_29 = 0.200000002980232

			if var_20_28 <= arg_17_1.time_ and arg_17_1.time_ < var_20_28 + var_20_29 and not isNil(var_20_27) then
				local var_20_30 = (arg_17_1.time_ - var_20_28) / var_20_29

				if arg_17_1.var_.characterEffect404001ui_story and not isNil(var_20_27) then
					local var_20_31 = Mathf.Lerp(0, 0.5, var_20_30)

					arg_17_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_17_1.var_.characterEffect404001ui_story.fillRatio = var_20_31
				end
			end

			if arg_17_1.time_ >= var_20_28 + var_20_29 and arg_17_1.time_ < var_20_28 + var_20_29 + arg_20_0 and not isNil(var_20_27) and arg_17_1.var_.characterEffect404001ui_story then
				local var_20_32 = 0.5

				arg_17_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_17_1.var_.characterEffect404001ui_story.fillRatio = var_20_32
			end

			local var_20_33 = 0

			if var_20_33 < arg_17_1.time_ and arg_17_1.time_ <= var_20_33 + arg_20_0 then
				arg_17_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_20_34 = 0

			if var_20_34 < arg_17_1.time_ and arg_17_1.time_ <= var_20_34 + arg_20_0 then
				arg_17_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_20_35 = 0
			local var_20_36 = 0.225

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_37 = arg_17_1:FormatText(StoryNameCfg[328].name)

				arg_17_1.leftNameTxt_.text = var_20_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_38 = arg_17_1:GetWordFromCfg(420051004)
				local var_20_39 = arg_17_1:FormatText(var_20_38.content)

				arg_17_1.text_.text = var_20_39

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_40 = 9
				local var_20_41 = utf8.len(var_20_39)
				local var_20_42 = var_20_40 <= 0 and var_20_36 or var_20_36 * (var_20_41 / var_20_40)

				if var_20_42 > 0 and var_20_36 < var_20_42 then
					arg_17_1.talkMaxDuration = var_20_42

					if var_20_42 + var_20_35 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_42 + var_20_35
					end
				end

				arg_17_1.text_.text = var_20_39
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051004", "story_v_out_420051.awb") ~= 0 then
					local var_20_43 = manager.audio:GetVoiceLength("story_v_out_420051", "420051004", "story_v_out_420051.awb") / 1000

					if var_20_43 + var_20_35 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_43 + var_20_35
					end

					if var_20_38.prefab_name ~= "" and arg_17_1.actors_[var_20_38.prefab_name] ~= nil then
						local var_20_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_38.prefab_name].transform, "story_v_out_420051", "420051004", "story_v_out_420051.awb")

						arg_17_1:RecordAudio("420051004", var_20_44)
						arg_17_1:RecordAudio("420051004", var_20_44)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_420051", "420051004", "story_v_out_420051.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_420051", "420051004", "story_v_out_420051.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_45 = math.max(var_20_36, arg_17_1.talkMaxDuration)

			if var_20_35 <= arg_17_1.time_ and arg_17_1.time_ < var_20_35 + var_20_45 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_35) / var_20_45

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_35 + var_20_45 and arg_17_1.time_ < var_20_35 + var_20_45 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 420051005
		arg_21_1.duration_ = 5.7

		local var_21_0 = {
			zh = 3.666,
			ja = 5.7
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
				arg_21_0:Play420051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["404001ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect404001ui_story == nil then
				arg_21_1.var_.characterEffect404001ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect404001ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect404001ui_story then
				arg_21_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_24_4 = arg_21_1.actors_["1085ui_story"]
			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1085ui_story == nil then
				arg_21_1.var_.characterEffect1085ui_story = var_24_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_6 and not isNil(var_24_4) then
				local var_24_7 = (arg_21_1.time_ - var_24_5) / var_24_6

				if arg_21_1.var_.characterEffect1085ui_story and not isNil(var_24_4) then
					local var_24_8 = Mathf.Lerp(0, 0.5, var_24_7)

					arg_21_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1085ui_story.fillRatio = var_24_8
				end
			end

			if arg_21_1.time_ >= var_24_5 + var_24_6 and arg_21_1.time_ < var_24_5 + var_24_6 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1085ui_story then
				local var_24_9 = 0.5

				arg_21_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1085ui_story.fillRatio = var_24_9
			end

			local var_24_10 = 0
			local var_24_11 = 0.575

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_12 = arg_21_1:FormatText(StoryNameCfg[668].name)

				arg_21_1.leftNameTxt_.text = var_24_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_13 = arg_21_1:GetWordFromCfg(420051005)
				local var_24_14 = arg_21_1:FormatText(var_24_13.content)

				arg_21_1.text_.text = var_24_14

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_15 = 23
				local var_24_16 = utf8.len(var_24_14)
				local var_24_17 = var_24_15 <= 0 and var_24_11 or var_24_11 * (var_24_16 / var_24_15)

				if var_24_17 > 0 and var_24_11 < var_24_17 then
					arg_21_1.talkMaxDuration = var_24_17

					if var_24_17 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_14
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051005", "story_v_out_420051.awb") ~= 0 then
					local var_24_18 = manager.audio:GetVoiceLength("story_v_out_420051", "420051005", "story_v_out_420051.awb") / 1000

					if var_24_18 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_10
					end

					if var_24_13.prefab_name ~= "" and arg_21_1.actors_[var_24_13.prefab_name] ~= nil then
						local var_24_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_13.prefab_name].transform, "story_v_out_420051", "420051005", "story_v_out_420051.awb")

						arg_21_1:RecordAudio("420051005", var_24_19)
						arg_21_1:RecordAudio("420051005", var_24_19)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_420051", "420051005", "story_v_out_420051.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_420051", "420051005", "story_v_out_420051.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_20 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_20 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_20

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_20 and arg_21_1.time_ < var_24_10 + var_24_20 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play420051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 420051006
		arg_25_1.duration_ = 5.4

		local var_25_0 = {
			zh = 4.1,
			ja = 5.4
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
				arg_25_0:Play420051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_2")
			end

			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_2 = 0
			local var_28_3 = 0.575

			if var_28_2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_4 = arg_25_1:FormatText(StoryNameCfg[668].name)

				arg_25_1.leftNameTxt_.text = var_28_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_5 = arg_25_1:GetWordFromCfg(420051006)
				local var_28_6 = arg_25_1:FormatText(var_28_5.content)

				arg_25_1.text_.text = var_28_6

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 23
				local var_28_8 = utf8.len(var_28_6)
				local var_28_9 = var_28_7 <= 0 and var_28_3 or var_28_3 * (var_28_8 / var_28_7)

				if var_28_9 > 0 and var_28_3 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_6
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051006", "story_v_out_420051.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051006", "story_v_out_420051.awb") / 1000

					if var_28_10 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_2
					end

					if var_28_5.prefab_name ~= "" and arg_25_1.actors_[var_28_5.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_5.prefab_name].transform, "story_v_out_420051", "420051006", "story_v_out_420051.awb")

						arg_25_1:RecordAudio("420051006", var_28_11)
						arg_25_1:RecordAudio("420051006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_420051", "420051006", "story_v_out_420051.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_420051", "420051006", "story_v_out_420051.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_12 and arg_25_1.time_ < var_28_2 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play420051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 420051007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play420051008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1085ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1085ui_story == nil then
				arg_29_1.var_.characterEffect1085ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1085ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1085ui_story then
				arg_29_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_32_4 = arg_29_1.actors_["404001ui_story"]
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect404001ui_story == nil then
				arg_29_1.var_.characterEffect404001ui_story = var_32_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 and not isNil(var_32_4) then
				local var_32_7 = (arg_29_1.time_ - var_32_5) / var_32_6

				if arg_29_1.var_.characterEffect404001ui_story and not isNil(var_32_4) then
					local var_32_8 = Mathf.Lerp(0, 0.5, var_32_7)

					arg_29_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_29_1.var_.characterEffect404001ui_story.fillRatio = var_32_8
				end
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect404001ui_story then
				local var_32_9 = 0.5

				arg_29_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_29_1.var_.characterEffect404001ui_story.fillRatio = var_32_9
			end

			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_32_11 = 0
			local var_32_12 = 0.05

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_13 = arg_29_1:FormatText(StoryNameCfg[328].name)

				arg_29_1.leftNameTxt_.text = var_32_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(420051007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 2
				local var_32_17 = utf8.len(var_32_15)
				local var_32_18 = var_32_16 <= 0 and var_32_12 or var_32_12 * (var_32_17 / var_32_16)

				if var_32_18 > 0 and var_32_12 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18

					if var_32_18 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051007", "story_v_out_420051.awb") ~= 0 then
					local var_32_19 = manager.audio:GetVoiceLength("story_v_out_420051", "420051007", "story_v_out_420051.awb") / 1000

					if var_32_19 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_11
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_out_420051", "420051007", "story_v_out_420051.awb")

						arg_29_1:RecordAudio("420051007", var_32_20)
						arg_29_1:RecordAudio("420051007", var_32_20)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_420051", "420051007", "story_v_out_420051.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_420051", "420051007", "story_v_out_420051.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_21 and arg_29_1.time_ < var_32_11 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play420051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 420051008
		arg_33_1.duration_ = 2.3

		local var_33_0 = {
			zh = 2.3,
			ja = 2.066
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
				arg_33_0:Play420051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["404001ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect404001ui_story == nil then
				arg_33_1.var_.characterEffect404001ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect404001ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect404001ui_story then
				arg_33_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["1085ui_story"]
			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1085ui_story == nil then
				arg_33_1.var_.characterEffect1085ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_6 and not isNil(var_36_4) then
				local var_36_7 = (arg_33_1.time_ - var_36_5) / var_36_6

				if arg_33_1.var_.characterEffect1085ui_story and not isNil(var_36_4) then
					local var_36_8 = Mathf.Lerp(0, 0.5, var_36_7)

					arg_33_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1085ui_story.fillRatio = var_36_8
				end
			end

			if arg_33_1.time_ >= var_36_5 + var_36_6 and arg_33_1.time_ < var_36_5 + var_36_6 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1085ui_story then
				local var_36_9 = 0.5

				arg_33_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1085ui_story.fillRatio = var_36_9
			end

			local var_36_10 = 0
			local var_36_11 = 0.2

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_12 = arg_33_1:FormatText(StoryNameCfg[668].name)

				arg_33_1.leftNameTxt_.text = var_36_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_13 = arg_33_1:GetWordFromCfg(420051008)
				local var_36_14 = arg_33_1:FormatText(var_36_13.content)

				arg_33_1.text_.text = var_36_14

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_15 = 8
				local var_36_16 = utf8.len(var_36_14)
				local var_36_17 = var_36_15 <= 0 and var_36_11 or var_36_11 * (var_36_16 / var_36_15)

				if var_36_17 > 0 and var_36_11 < var_36_17 then
					arg_33_1.talkMaxDuration = var_36_17

					if var_36_17 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_10
					end
				end

				arg_33_1.text_.text = var_36_14
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051008", "story_v_out_420051.awb") ~= 0 then
					local var_36_18 = manager.audio:GetVoiceLength("story_v_out_420051", "420051008", "story_v_out_420051.awb") / 1000

					if var_36_18 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_10
					end

					if var_36_13.prefab_name ~= "" and arg_33_1.actors_[var_36_13.prefab_name] ~= nil then
						local var_36_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_13.prefab_name].transform, "story_v_out_420051", "420051008", "story_v_out_420051.awb")

						arg_33_1:RecordAudio("420051008", var_36_19)
						arg_33_1:RecordAudio("420051008", var_36_19)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_420051", "420051008", "story_v_out_420051.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_420051", "420051008", "story_v_out_420051.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_20 = math.max(var_36_11, arg_33_1.talkMaxDuration)

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_20 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_10) / var_36_20

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_10 + var_36_20 and arg_33_1.time_ < var_36_10 + var_36_20 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play420051009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 420051009
		arg_37_1.duration_ = 2.2

		local var_37_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_37_0:Play420051010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1085ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1085ui_story == nil then
				arg_37_1.var_.characterEffect1085ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1085ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1085ui_story then
				arg_37_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["404001ui_story"]
			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect404001ui_story == nil then
				arg_37_1.var_.characterEffect404001ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 and not isNil(var_40_4) then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6

				if arg_37_1.var_.characterEffect404001ui_story and not isNil(var_40_4) then
					local var_40_8 = Mathf.Lerp(0, 0.5, var_40_7)

					arg_37_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_37_1.var_.characterEffect404001ui_story.fillRatio = var_40_8
				end
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect404001ui_story then
				local var_40_9 = 0.5

				arg_37_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_37_1.var_.characterEffect404001ui_story.fillRatio = var_40_9
			end

			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_40_11 = 0
			local var_40_12 = 0.175

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_13 = arg_37_1:FormatText(StoryNameCfg[328].name)

				arg_37_1.leftNameTxt_.text = var_40_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(420051009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051009", "story_v_out_420051.awb") ~= 0 then
					local var_40_19 = manager.audio:GetVoiceLength("story_v_out_420051", "420051009", "story_v_out_420051.awb") / 1000

					if var_40_19 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_11
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_420051", "420051009", "story_v_out_420051.awb")

						arg_37_1:RecordAudio("420051009", var_40_20)
						arg_37_1:RecordAudio("420051009", var_40_20)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_420051", "420051009", "story_v_out_420051.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_420051", "420051009", "story_v_out_420051.awb")
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
	Play420051010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 420051010
		arg_41_1.duration_ = 5.4

		local var_41_0 = {
			zh = 5.366,
			ja = 5.4
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play420051011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["404001ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect404001ui_story == nil then
				arg_41_1.var_.characterEffect404001ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect404001ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect404001ui_story then
				arg_41_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["1085ui_story"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1085ui_story == nil then
				arg_41_1.var_.characterEffect1085ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.characterEffect1085ui_story and not isNil(var_44_4) then
					local var_44_8 = Mathf.Lerp(0, 0.5, var_44_7)

					arg_41_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1085ui_story.fillRatio = var_44_8
				end
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1085ui_story then
				local var_44_9 = 0.5

				arg_41_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1085ui_story.fillRatio = var_44_9
			end

			local var_44_10 = 0
			local var_44_11 = 0.6

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_12 = arg_41_1:FormatText(StoryNameCfg[668].name)

				arg_41_1.leftNameTxt_.text = var_44_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_13 = arg_41_1:GetWordFromCfg(420051010)
				local var_44_14 = arg_41_1:FormatText(var_44_13.content)

				arg_41_1.text_.text = var_44_14

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_15 = 24
				local var_44_16 = utf8.len(var_44_14)
				local var_44_17 = var_44_15 <= 0 and var_44_11 or var_44_11 * (var_44_16 / var_44_15)

				if var_44_17 > 0 and var_44_11 < var_44_17 then
					arg_41_1.talkMaxDuration = var_44_17

					if var_44_17 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_10
					end
				end

				arg_41_1.text_.text = var_44_14
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051010", "story_v_out_420051.awb") ~= 0 then
					local var_44_18 = manager.audio:GetVoiceLength("story_v_out_420051", "420051010", "story_v_out_420051.awb") / 1000

					if var_44_18 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_10
					end

					if var_44_13.prefab_name ~= "" and arg_41_1.actors_[var_44_13.prefab_name] ~= nil then
						local var_44_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_13.prefab_name].transform, "story_v_out_420051", "420051010", "story_v_out_420051.awb")

						arg_41_1:RecordAudio("420051010", var_44_19)
						arg_41_1:RecordAudio("420051010", var_44_19)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_420051", "420051010", "story_v_out_420051.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_420051", "420051010", "story_v_out_420051.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_20 = math.max(var_44_11, arg_41_1.talkMaxDuration)

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_20 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_10) / var_44_20

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_10 + var_44_20 and arg_41_1.time_ < var_44_10 + var_44_20 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play420051011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 420051011
		arg_45_1.duration_ = 2.77

		local var_45_0 = {
			zh = 2.4,
			ja = 2.766
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
				arg_45_0:Play420051012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1085ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1085ui_story == nil then
				arg_45_1.var_.characterEffect1085ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1085ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1085ui_story then
				arg_45_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_48_4 = arg_45_1.actors_["404001ui_story"]
			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect404001ui_story == nil then
				arg_45_1.var_.characterEffect404001ui_story = var_48_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_6 = 0.200000002980232

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_6 and not isNil(var_48_4) then
				local var_48_7 = (arg_45_1.time_ - var_48_5) / var_48_6

				if arg_45_1.var_.characterEffect404001ui_story and not isNil(var_48_4) then
					local var_48_8 = Mathf.Lerp(0, 0.5, var_48_7)

					arg_45_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_45_1.var_.characterEffect404001ui_story.fillRatio = var_48_8
				end
			end

			if arg_45_1.time_ >= var_48_5 + var_48_6 and arg_45_1.time_ < var_48_5 + var_48_6 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect404001ui_story then
				local var_48_9 = 0.5

				arg_45_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_45_1.var_.characterEffect404001ui_story.fillRatio = var_48_9
			end

			local var_48_10 = 0
			local var_48_11 = 0.2

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_12 = arg_45_1:FormatText(StoryNameCfg[328].name)

				arg_45_1.leftNameTxt_.text = var_48_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_13 = arg_45_1:GetWordFromCfg(420051011)
				local var_48_14 = arg_45_1:FormatText(var_48_13.content)

				arg_45_1.text_.text = var_48_14

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_15 = 8
				local var_48_16 = utf8.len(var_48_14)
				local var_48_17 = var_48_15 <= 0 and var_48_11 or var_48_11 * (var_48_16 / var_48_15)

				if var_48_17 > 0 and var_48_11 < var_48_17 then
					arg_45_1.talkMaxDuration = var_48_17

					if var_48_17 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_10
					end
				end

				arg_45_1.text_.text = var_48_14
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051011", "story_v_out_420051.awb") ~= 0 then
					local var_48_18 = manager.audio:GetVoiceLength("story_v_out_420051", "420051011", "story_v_out_420051.awb") / 1000

					if var_48_18 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_10
					end

					if var_48_13.prefab_name ~= "" and arg_45_1.actors_[var_48_13.prefab_name] ~= nil then
						local var_48_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_13.prefab_name].transform, "story_v_out_420051", "420051011", "story_v_out_420051.awb")

						arg_45_1:RecordAudio("420051011", var_48_19)
						arg_45_1:RecordAudio("420051011", var_48_19)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_420051", "420051011", "story_v_out_420051.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_420051", "420051011", "story_v_out_420051.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_20 = math.max(var_48_11, arg_45_1.talkMaxDuration)

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_20 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_10) / var_48_20

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_10 + var_48_20 and arg_45_1.time_ < var_48_10 + var_48_20 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play420051012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 420051012
		arg_49_1.duration_ = 5.9

		local var_49_0 = {
			zh = 5.233,
			ja = 5.9
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
				arg_49_0:Play420051013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["404001ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect404001ui_story == nil then
				arg_49_1.var_.characterEffect404001ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect404001ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect404001ui_story then
				arg_49_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["1085ui_story"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1085ui_story == nil then
				arg_49_1.var_.characterEffect1085ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 and not isNil(var_52_4) then
				local var_52_7 = (arg_49_1.time_ - var_52_5) / var_52_6

				if arg_49_1.var_.characterEffect1085ui_story and not isNil(var_52_4) then
					local var_52_8 = Mathf.Lerp(0, 0.5, var_52_7)

					arg_49_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1085ui_story.fillRatio = var_52_8
				end
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1085ui_story then
				local var_52_9 = 0.5

				arg_49_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1085ui_story.fillRatio = var_52_9
			end

			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_1")
			end

			local var_52_11 = 0

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_52_12 = 0
			local var_52_13 = 0.6

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_14 = arg_49_1:FormatText(StoryNameCfg[668].name)

				arg_49_1.leftNameTxt_.text = var_52_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(420051012)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 24
				local var_52_18 = utf8.len(var_52_16)
				local var_52_19 = var_52_17 <= 0 and var_52_13 or var_52_13 * (var_52_18 / var_52_17)

				if var_52_19 > 0 and var_52_13 < var_52_19 then
					arg_49_1.talkMaxDuration = var_52_19

					if var_52_19 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051012", "story_v_out_420051.awb") ~= 0 then
					local var_52_20 = manager.audio:GetVoiceLength("story_v_out_420051", "420051012", "story_v_out_420051.awb") / 1000

					if var_52_20 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_12
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_out_420051", "420051012", "story_v_out_420051.awb")

						arg_49_1:RecordAudio("420051012", var_52_21)
						arg_49_1:RecordAudio("420051012", var_52_21)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_420051", "420051012", "story_v_out_420051.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_420051", "420051012", "story_v_out_420051.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_22 and arg_49_1.time_ < var_52_12 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play420051013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 420051013
		arg_53_1.duration_ = 6.43

		local var_53_0 = {
			zh = 3.566,
			ja = 6.433
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
				arg_53_0:Play420051014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.45

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[668].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(420051013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051013", "story_v_out_420051.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051013", "story_v_out_420051.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_420051", "420051013", "story_v_out_420051.awb")

						arg_53_1:RecordAudio("420051013", var_56_9)
						arg_53_1:RecordAudio("420051013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_420051", "420051013", "story_v_out_420051.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_420051", "420051013", "story_v_out_420051.awb")
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
	Play420051014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 420051014
		arg_57_1.duration_ = 3.6

		local var_57_0 = {
			zh = 3.066,
			ja = 3.6
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
				arg_57_0:Play420051015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1085ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1085ui_story == nil then
				arg_57_1.var_.characterEffect1085ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1085ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1085ui_story then
				arg_57_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_60_4 = arg_57_1.actors_["404001ui_story"]
			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect404001ui_story == nil then
				arg_57_1.var_.characterEffect404001ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_6 = 0.200000002980232

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_6 and not isNil(var_60_4) then
				local var_60_7 = (arg_57_1.time_ - var_60_5) / var_60_6

				if arg_57_1.var_.characterEffect404001ui_story and not isNil(var_60_4) then
					local var_60_8 = Mathf.Lerp(0, 0.5, var_60_7)

					arg_57_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_57_1.var_.characterEffect404001ui_story.fillRatio = var_60_8
				end
			end

			if arg_57_1.time_ >= var_60_5 + var_60_6 and arg_57_1.time_ < var_60_5 + var_60_6 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect404001ui_story then
				local var_60_9 = 0.5

				arg_57_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_57_1.var_.characterEffect404001ui_story.fillRatio = var_60_9
			end

			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_60_11 = 0
			local var_60_12 = 0.25

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_13 = arg_57_1:FormatText(StoryNameCfg[328].name)

				arg_57_1.leftNameTxt_.text = var_60_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_14 = arg_57_1:GetWordFromCfg(420051014)
				local var_60_15 = arg_57_1:FormatText(var_60_14.content)

				arg_57_1.text_.text = var_60_15

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_16 = 10
				local var_60_17 = utf8.len(var_60_15)
				local var_60_18 = var_60_16 <= 0 and var_60_12 or var_60_12 * (var_60_17 / var_60_16)

				if var_60_18 > 0 and var_60_12 < var_60_18 then
					arg_57_1.talkMaxDuration = var_60_18

					if var_60_18 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_18 + var_60_11
					end
				end

				arg_57_1.text_.text = var_60_15
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051014", "story_v_out_420051.awb") ~= 0 then
					local var_60_19 = manager.audio:GetVoiceLength("story_v_out_420051", "420051014", "story_v_out_420051.awb") / 1000

					if var_60_19 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_11
					end

					if var_60_14.prefab_name ~= "" and arg_57_1.actors_[var_60_14.prefab_name] ~= nil then
						local var_60_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_14.prefab_name].transform, "story_v_out_420051", "420051014", "story_v_out_420051.awb")

						arg_57_1:RecordAudio("420051014", var_60_20)
						arg_57_1:RecordAudio("420051014", var_60_20)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_420051", "420051014", "story_v_out_420051.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_420051", "420051014", "story_v_out_420051.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_21 = math.max(var_60_12, arg_57_1.talkMaxDuration)

			if var_60_11 <= arg_57_1.time_ and arg_57_1.time_ < var_60_11 + var_60_21 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_11) / var_60_21

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_11 + var_60_21 and arg_57_1.time_ < var_60_11 + var_60_21 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play420051015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 420051015
		arg_61_1.duration_ = 2.9

		local var_61_0 = {
			zh = 2.133,
			ja = 2.9
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
				arg_61_0:Play420051016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["404001ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect404001ui_story == nil then
				arg_61_1.var_.characterEffect404001ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect404001ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect404001ui_story then
				arg_61_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_64_4 = arg_61_1.actors_["1085ui_story"]
			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1085ui_story == nil then
				arg_61_1.var_.characterEffect1085ui_story = var_64_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.200000002980232

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_6 and not isNil(var_64_4) then
				local var_64_7 = (arg_61_1.time_ - var_64_5) / var_64_6

				if arg_61_1.var_.characterEffect1085ui_story and not isNil(var_64_4) then
					local var_64_8 = Mathf.Lerp(0, 0.5, var_64_7)

					arg_61_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1085ui_story.fillRatio = var_64_8
				end
			end

			if arg_61_1.time_ >= var_64_5 + var_64_6 and arg_61_1.time_ < var_64_5 + var_64_6 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1085ui_story then
				local var_64_9 = 0.5

				arg_61_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1085ui_story.fillRatio = var_64_9
			end

			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva", "EmotionTimelineAnimator")
			end

			local var_64_11 = 0
			local var_64_12 = 0.125

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_13 = arg_61_1:FormatText(StoryNameCfg[668].name)

				arg_61_1.leftNameTxt_.text = var_64_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_14 = arg_61_1:GetWordFromCfg(420051015)
				local var_64_15 = arg_61_1:FormatText(var_64_14.content)

				arg_61_1.text_.text = var_64_15

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_16 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051015", "story_v_out_420051.awb") ~= 0 then
					local var_64_19 = manager.audio:GetVoiceLength("story_v_out_420051", "420051015", "story_v_out_420051.awb") / 1000

					if var_64_19 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_11
					end

					if var_64_14.prefab_name ~= "" and arg_61_1.actors_[var_64_14.prefab_name] ~= nil then
						local var_64_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_14.prefab_name].transform, "story_v_out_420051", "420051015", "story_v_out_420051.awb")

						arg_61_1:RecordAudio("420051015", var_64_20)
						arg_61_1:RecordAudio("420051015", var_64_20)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_420051", "420051015", "story_v_out_420051.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_420051", "420051015", "story_v_out_420051.awb")
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
	Play420051016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 420051016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play420051017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["404001ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos404001ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, 100, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos404001ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, 100, 0)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1085ui_story"].transform
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1.var_.moveOldPos1085ui_story = var_68_9.localPosition
			end

			local var_68_11 = 0.001

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11
				local var_68_13 = Vector3.New(0, 100, 0)

				var_68_9.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1085ui_story, var_68_13, var_68_12)

				local var_68_14 = manager.ui.mainCamera.transform.position - var_68_9.position

				var_68_9.forward = Vector3.New(var_68_14.x, var_68_14.y, var_68_14.z)

				local var_68_15 = var_68_9.localEulerAngles

				var_68_15.z = 0
				var_68_15.x = 0
				var_68_9.localEulerAngles = var_68_15
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 then
				var_68_9.localPosition = Vector3.New(0, 100, 0)

				local var_68_16 = manager.ui.mainCamera.transform.position - var_68_9.position

				var_68_9.forward = Vector3.New(var_68_16.x, var_68_16.y, var_68_16.z)

				local var_68_17 = var_68_9.localEulerAngles

				var_68_17.z = 0
				var_68_17.x = 0
				var_68_9.localEulerAngles = var_68_17
			end

			local var_68_18 = 0
			local var_68_19 = 0.7

			if var_68_18 < arg_65_1.time_ and arg_65_1.time_ <= var_68_18 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_20 = arg_65_1:GetWordFromCfg(420051016)
				local var_68_21 = arg_65_1:FormatText(var_68_20.content)

				arg_65_1.text_.text = var_68_21

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_22 = 28
				local var_68_23 = utf8.len(var_68_21)
				local var_68_24 = var_68_22 <= 0 and var_68_19 or var_68_19 * (var_68_23 / var_68_22)

				if var_68_24 > 0 and var_68_19 < var_68_24 then
					arg_65_1.talkMaxDuration = var_68_24

					if var_68_24 + var_68_18 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_24 + var_68_18
					end
				end

				arg_65_1.text_.text = var_68_21
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = math.max(var_68_19, arg_65_1.talkMaxDuration)

			if var_68_18 <= arg_65_1.time_ and arg_65_1.time_ < var_68_18 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_18) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_18 + var_68_25 and arg_65_1.time_ < var_68_18 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play420051017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 420051017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play420051018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.7

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(420051017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 28
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play420051018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 420051018
		arg_73_1.duration_ = 9.43

		local var_73_0 = {
			zh = 8.6,
			ja = 9.433
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
				arg_73_0:Play420051019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["404001ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos404001ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, -1.55, -5.5)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos404001ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["404001ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect404001ui_story == nil then
				arg_73_1.var_.characterEffect404001ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect404001ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect404001ui_story then
				arg_73_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_76_13 = 0

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_76_14 = 0

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_76_15 = 0
			local var_76_16 = 0.925

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_17 = arg_73_1:FormatText(StoryNameCfg[668].name)

				arg_73_1.leftNameTxt_.text = var_76_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_18 = arg_73_1:GetWordFromCfg(420051018)
				local var_76_19 = arg_73_1:FormatText(var_76_18.content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_20 = 37
				local var_76_21 = utf8.len(var_76_19)
				local var_76_22 = var_76_20 <= 0 and var_76_16 or var_76_16 * (var_76_21 / var_76_20)

				if var_76_22 > 0 and var_76_16 < var_76_22 then
					arg_73_1.talkMaxDuration = var_76_22

					if var_76_22 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_22 + var_76_15
					end
				end

				arg_73_1.text_.text = var_76_19
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051018", "story_v_out_420051.awb") ~= 0 then
					local var_76_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051018", "story_v_out_420051.awb") / 1000

					if var_76_23 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_15
					end

					if var_76_18.prefab_name ~= "" and arg_73_1.actors_[var_76_18.prefab_name] ~= nil then
						local var_76_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_18.prefab_name].transform, "story_v_out_420051", "420051018", "story_v_out_420051.awb")

						arg_73_1:RecordAudio("420051018", var_76_24)
						arg_73_1:RecordAudio("420051018", var_76_24)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_420051", "420051018", "story_v_out_420051.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_420051", "420051018", "story_v_out_420051.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_25 = math.max(var_76_16, arg_73_1.talkMaxDuration)

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_25 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_15) / var_76_25

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_15 + var_76_25 and arg_73_1.time_ < var_76_15 + var_76_25 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play420051019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 420051019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play420051020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["404001ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos404001ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, 100, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos404001ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, 100, 0)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = 0.8
			local var_80_10 = 1

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 then
				local var_80_11 = "play"
				local var_80_12 = "effect"

				arg_77_1:AudioAction(var_80_11, var_80_12, "se_story_side_1042", "se_story_1042_doorbell", "")
			end

			local var_80_13 = 0
			local var_80_14 = 0.975

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_15 = arg_77_1:GetWordFromCfg(420051019)
				local var_80_16 = arg_77_1:FormatText(var_80_15.content)

				arg_77_1.text_.text = var_80_16

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_17 = 39
				local var_80_18 = utf8.len(var_80_16)
				local var_80_19 = var_80_17 <= 0 and var_80_14 or var_80_14 * (var_80_18 / var_80_17)

				if var_80_19 > 0 and var_80_14 < var_80_19 then
					arg_77_1.talkMaxDuration = var_80_19

					if var_80_19 + var_80_13 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_19 + var_80_13
					end
				end

				arg_77_1.text_.text = var_80_16
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_20 = math.max(var_80_14, arg_77_1.talkMaxDuration)

			if var_80_13 <= arg_77_1.time_ and arg_77_1.time_ < var_80_13 + var_80_20 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_13) / var_80_20

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_13 + var_80_20 and arg_77_1.time_ < var_80_13 + var_80_20 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play420051020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 420051020
		arg_81_1.duration_ = 16.2

		local var_81_0 = {
			zh = 14.1,
			ja = 16.2
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
				arg_81_0:Play420051021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = "L01f"

			if arg_81_1.bgs_[var_84_0] == nil then
				local var_84_1 = Object.Instantiate(arg_81_1.paintGo_)

				var_84_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_84_0)
				var_84_1.name = var_84_0
				var_84_1.transform.parent = arg_81_1.stage_.transform
				var_84_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_[var_84_0] = var_84_1
			end

			local var_84_2 = 2

			if var_84_2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				local var_84_3 = manager.ui.mainCamera.transform.localPosition
				local var_84_4 = Vector3.New(0, 0, 10) + Vector3.New(var_84_3.x, var_84_3.y, 0)
				local var_84_5 = arg_81_1.bgs_.L01f

				var_84_5.transform.localPosition = var_84_4
				var_84_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_6 = var_84_5:GetComponent("SpriteRenderer")

				if var_84_6 and var_84_6.sprite then
					local var_84_7 = (var_84_5.transform.localPosition - var_84_3).z
					local var_84_8 = manager.ui.mainCameraCom_
					local var_84_9 = 2 * var_84_7 * Mathf.Tan(var_84_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_84_10 = var_84_9 * var_84_8.aspect
					local var_84_11 = var_84_6.sprite.bounds.size.x
					local var_84_12 = var_84_6.sprite.bounds.size.y
					local var_84_13 = var_84_10 / var_84_11
					local var_84_14 = var_84_9 / var_84_12
					local var_84_15 = var_84_14 < var_84_13 and var_84_13 or var_84_14

					var_84_5.transform.localScale = Vector3.New(var_84_15, var_84_15, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "L01f" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_16 = 4

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1.allBtn_.enabled = false
			end

			local var_84_17 = 0.3

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 then
				arg_81_1.allBtn_.enabled = true
			end

			local var_84_18 = 0

			if var_84_18 < arg_81_1.time_ and arg_81_1.time_ <= var_84_18 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_19 = 2

			if var_84_18 <= arg_81_1.time_ and arg_81_1.time_ < var_84_18 + var_84_19 then
				local var_84_20 = (arg_81_1.time_ - var_84_18) / var_84_19
				local var_84_21 = Color.New(0, 0, 0)

				var_84_21.a = Mathf.Lerp(0, 1, var_84_20)
				arg_81_1.mask_.color = var_84_21
			end

			if arg_81_1.time_ >= var_84_18 + var_84_19 and arg_81_1.time_ < var_84_18 + var_84_19 + arg_84_0 then
				local var_84_22 = Color.New(0, 0, 0)

				var_84_22.a = 1
				arg_81_1.mask_.color = var_84_22
			end

			local var_84_23 = 2

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_24 = 2

			if var_84_23 <= arg_81_1.time_ and arg_81_1.time_ < var_84_23 + var_84_24 then
				local var_84_25 = (arg_81_1.time_ - var_84_23) / var_84_24
				local var_84_26 = Color.New(0, 0, 0)

				var_84_26.a = Mathf.Lerp(1, 0, var_84_25)
				arg_81_1.mask_.color = var_84_26
			end

			if arg_81_1.time_ >= var_84_23 + var_84_24 and arg_81_1.time_ < var_84_23 + var_84_24 + arg_84_0 then
				local var_84_27 = Color.New(0, 0, 0)
				local var_84_28 = 0

				arg_81_1.mask_.enabled = false
				var_84_27.a = var_84_28
				arg_81_1.mask_.color = var_84_27
			end

			local var_84_29 = 3.8

			if var_84_29 < arg_81_1.time_ and arg_81_1.time_ <= var_84_29 + arg_84_0 then
				arg_81_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_84_30 = 3.8

			if var_84_30 < arg_81_1.time_ and arg_81_1.time_ <= var_84_30 + arg_84_0 then
				arg_81_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_84_31 = arg_81_1.actors_["404001ui_story"].transform
			local var_84_32 = 3.8

			if var_84_32 < arg_81_1.time_ and arg_81_1.time_ <= var_84_32 + arg_84_0 then
				arg_81_1.var_.moveOldPos404001ui_story = var_84_31.localPosition
			end

			local var_84_33 = 0.001

			if var_84_32 <= arg_81_1.time_ and arg_81_1.time_ < var_84_32 + var_84_33 then
				local var_84_34 = (arg_81_1.time_ - var_84_32) / var_84_33
				local var_84_35 = Vector3.New(0, -1.55, -5.5)

				var_84_31.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos404001ui_story, var_84_35, var_84_34)

				local var_84_36 = manager.ui.mainCamera.transform.position - var_84_31.position

				var_84_31.forward = Vector3.New(var_84_36.x, var_84_36.y, var_84_36.z)

				local var_84_37 = var_84_31.localEulerAngles

				var_84_37.z = 0
				var_84_37.x = 0
				var_84_31.localEulerAngles = var_84_37
			end

			if arg_81_1.time_ >= var_84_32 + var_84_33 and arg_81_1.time_ < var_84_32 + var_84_33 + arg_84_0 then
				var_84_31.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_84_38 = manager.ui.mainCamera.transform.position - var_84_31.position

				var_84_31.forward = Vector3.New(var_84_38.x, var_84_38.y, var_84_38.z)

				local var_84_39 = var_84_31.localEulerAngles

				var_84_39.z = 0
				var_84_39.x = 0
				var_84_31.localEulerAngles = var_84_39
			end

			local var_84_40 = arg_81_1.actors_["404001ui_story"]
			local var_84_41 = 3.8

			if var_84_41 < arg_81_1.time_ and arg_81_1.time_ <= var_84_41 + arg_84_0 and not isNil(var_84_40) and arg_81_1.var_.characterEffect404001ui_story == nil then
				arg_81_1.var_.characterEffect404001ui_story = var_84_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_42 = 0.200000002980232

			if var_84_41 <= arg_81_1.time_ and arg_81_1.time_ < var_84_41 + var_84_42 and not isNil(var_84_40) then
				local var_84_43 = (arg_81_1.time_ - var_84_41) / var_84_42

				if arg_81_1.var_.characterEffect404001ui_story and not isNil(var_84_40) then
					arg_81_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_41 + var_84_42 and arg_81_1.time_ < var_84_41 + var_84_42 + arg_84_0 and not isNil(var_84_40) and arg_81_1.var_.characterEffect404001ui_story then
				arg_81_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_44 = 4
			local var_84_45 = 1.125

			if var_84_44 < arg_81_1.time_ and arg_81_1.time_ <= var_84_44 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_46 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_46:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_47 = arg_81_1:FormatText(StoryNameCfg[668].name)

				arg_81_1.leftNameTxt_.text = var_84_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_48 = arg_81_1:GetWordFromCfg(420051020)
				local var_84_49 = arg_81_1:FormatText(var_84_48.content)

				arg_81_1.text_.text = var_84_49

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_50 = 45
				local var_84_51 = utf8.len(var_84_49)
				local var_84_52 = var_84_50 <= 0 and var_84_45 or var_84_45 * (var_84_51 / var_84_50)

				if var_84_52 > 0 and var_84_45 < var_84_52 then
					arg_81_1.talkMaxDuration = var_84_52
					var_84_44 = var_84_44 + 0.3

					if var_84_52 + var_84_44 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_52 + var_84_44
					end
				end

				arg_81_1.text_.text = var_84_49
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051020", "story_v_out_420051.awb") ~= 0 then
					local var_84_53 = manager.audio:GetVoiceLength("story_v_out_420051", "420051020", "story_v_out_420051.awb") / 1000

					if var_84_53 + var_84_44 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_53 + var_84_44
					end

					if var_84_48.prefab_name ~= "" and arg_81_1.actors_[var_84_48.prefab_name] ~= nil then
						local var_84_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_48.prefab_name].transform, "story_v_out_420051", "420051020", "story_v_out_420051.awb")

						arg_81_1:RecordAudio("420051020", var_84_54)
						arg_81_1:RecordAudio("420051020", var_84_54)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_420051", "420051020", "story_v_out_420051.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_420051", "420051020", "story_v_out_420051.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_55 = var_84_44 + 0.3
			local var_84_56 = math.max(var_84_45, arg_81_1.talkMaxDuration)

			if var_84_55 <= arg_81_1.time_ and arg_81_1.time_ < var_84_55 + var_84_56 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_55) / var_84_56

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_55 + var_84_56 and arg_81_1.time_ < var_84_55 + var_84_56 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play420051021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 420051021
		arg_87_1.duration_ = 3.8

		local var_87_0 = {
			zh = 2.8,
			ja = 3.8
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play420051022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.3

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[668].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(420051021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051021", "story_v_out_420051.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051021", "story_v_out_420051.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_420051", "420051021", "story_v_out_420051.awb")

						arg_87_1:RecordAudio("420051021", var_90_9)
						arg_87_1:RecordAudio("420051021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_420051", "420051021", "story_v_out_420051.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_420051", "420051021", "story_v_out_420051.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_10 and arg_87_1.time_ < var_90_0 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play420051022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 420051022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play420051023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["404001ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos404001ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, 100, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos404001ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, 100, 0)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = 0.05
			local var_94_10 = 1

			if var_94_9 < arg_91_1.time_ and arg_91_1.time_ <= var_94_9 + arg_94_0 then
				local var_94_11 = "play"
				local var_94_12 = "effect"

				arg_91_1:AudioAction(var_94_11, var_94_12, "se_story_140", "se_story_140_car04", "")
			end

			local var_94_13 = 0
			local var_94_14 = 1.3

			if var_94_13 < arg_91_1.time_ and arg_91_1.time_ <= var_94_13 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_15 = arg_91_1:GetWordFromCfg(420051022)
				local var_94_16 = arg_91_1:FormatText(var_94_15.content)

				arg_91_1.text_.text = var_94_16

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_17 = 52
				local var_94_18 = utf8.len(var_94_16)
				local var_94_19 = var_94_17 <= 0 and var_94_14 or var_94_14 * (var_94_18 / var_94_17)

				if var_94_19 > 0 and var_94_14 < var_94_19 then
					arg_91_1.talkMaxDuration = var_94_19

					if var_94_19 + var_94_13 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_19 + var_94_13
					end
				end

				arg_91_1.text_.text = var_94_16
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_20 = math.max(var_94_14, arg_91_1.talkMaxDuration)

			if var_94_13 <= arg_91_1.time_ and arg_91_1.time_ < var_94_13 + var_94_20 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_13) / var_94_20

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_13 + var_94_20 and arg_91_1.time_ < var_94_13 + var_94_20 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play420051023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 420051023
		arg_95_1.duration_ = 3.57

		local var_95_0 = {
			zh = 3.566,
			ja = 3.4
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play420051024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1085ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1085ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, -1.01, -5.83)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1085ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["1085ui_story"]
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1085ui_story == nil then
				arg_95_1.var_.characterEffect1085ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.200000002980232

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 and not isNil(var_98_9) then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11

				if arg_95_1.var_.characterEffect1085ui_story and not isNil(var_98_9) then
					arg_95_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1085ui_story then
				arg_95_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_98_13 = 0

			if var_98_13 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_98_14 = 0

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_98_15 = 0
			local var_98_16 = 0.35

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_17 = arg_95_1:FormatText(StoryNameCfg[328].name)

				arg_95_1.leftNameTxt_.text = var_98_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_18 = arg_95_1:GetWordFromCfg(420051023)
				local var_98_19 = arg_95_1:FormatText(var_98_18.content)

				arg_95_1.text_.text = var_98_19

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_20 = 14
				local var_98_21 = utf8.len(var_98_19)
				local var_98_22 = var_98_20 <= 0 and var_98_16 or var_98_16 * (var_98_21 / var_98_20)

				if var_98_22 > 0 and var_98_16 < var_98_22 then
					arg_95_1.talkMaxDuration = var_98_22

					if var_98_22 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_22 + var_98_15
					end
				end

				arg_95_1.text_.text = var_98_19
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051023", "story_v_out_420051.awb") ~= 0 then
					local var_98_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051023", "story_v_out_420051.awb") / 1000

					if var_98_23 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_23 + var_98_15
					end

					if var_98_18.prefab_name ~= "" and arg_95_1.actors_[var_98_18.prefab_name] ~= nil then
						local var_98_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_18.prefab_name].transform, "story_v_out_420051", "420051023", "story_v_out_420051.awb")

						arg_95_1:RecordAudio("420051023", var_98_24)
						arg_95_1:RecordAudio("420051023", var_98_24)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_420051", "420051023", "story_v_out_420051.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_420051", "420051023", "story_v_out_420051.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_25 = math.max(var_98_16, arg_95_1.talkMaxDuration)

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_25 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_15) / var_98_25

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_15 + var_98_25 and arg_95_1.time_ < var_98_15 + var_98_25 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play420051024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 420051024
		arg_99_1.duration_ = 3.3

		local var_99_0 = {
			zh = 2.7,
			ja = 3.3
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play420051025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["404001ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos404001ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, -1.55, -5.5)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos404001ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = arg_99_1.actors_["404001ui_story"]
			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect404001ui_story == nil then
				arg_99_1.var_.characterEffect404001ui_story = var_102_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_11 = 0.200000002980232

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_11 and not isNil(var_102_9) then
				local var_102_12 = (arg_99_1.time_ - var_102_10) / var_102_11

				if arg_99_1.var_.characterEffect404001ui_story and not isNil(var_102_9) then
					arg_99_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_10 + var_102_11 and arg_99_1.time_ < var_102_10 + var_102_11 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect404001ui_story then
				arg_99_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_102_13 = arg_99_1.actors_["1085ui_story"]
			local var_102_14 = 0

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 and not isNil(var_102_13) and arg_99_1.var_.characterEffect1085ui_story == nil then
				arg_99_1.var_.characterEffect1085ui_story = var_102_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_15 = 0.200000002980232

			if var_102_14 <= arg_99_1.time_ and arg_99_1.time_ < var_102_14 + var_102_15 and not isNil(var_102_13) then
				local var_102_16 = (arg_99_1.time_ - var_102_14) / var_102_15

				if arg_99_1.var_.characterEffect1085ui_story and not isNil(var_102_13) then
					local var_102_17 = Mathf.Lerp(0, 0.5, var_102_16)

					arg_99_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1085ui_story.fillRatio = var_102_17
				end
			end

			if arg_99_1.time_ >= var_102_14 + var_102_15 and arg_99_1.time_ < var_102_14 + var_102_15 + arg_102_0 and not isNil(var_102_13) and arg_99_1.var_.characterEffect1085ui_story then
				local var_102_18 = 0.5

				arg_99_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1085ui_story.fillRatio = var_102_18
			end

			local var_102_19 = arg_99_1.actors_["1085ui_story"].transform
			local var_102_20 = 0

			if var_102_20 < arg_99_1.time_ and arg_99_1.time_ <= var_102_20 + arg_102_0 then
				arg_99_1.var_.moveOldPos1085ui_story = var_102_19.localPosition
			end

			local var_102_21 = 0.001

			if var_102_20 <= arg_99_1.time_ and arg_99_1.time_ < var_102_20 + var_102_21 then
				local var_102_22 = (arg_99_1.time_ - var_102_20) / var_102_21
				local var_102_23 = Vector3.New(0, 100, 0)

				var_102_19.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1085ui_story, var_102_23, var_102_22)

				local var_102_24 = manager.ui.mainCamera.transform.position - var_102_19.position

				var_102_19.forward = Vector3.New(var_102_24.x, var_102_24.y, var_102_24.z)

				local var_102_25 = var_102_19.localEulerAngles

				var_102_25.z = 0
				var_102_25.x = 0
				var_102_19.localEulerAngles = var_102_25
			end

			if arg_99_1.time_ >= var_102_20 + var_102_21 and arg_99_1.time_ < var_102_20 + var_102_21 + arg_102_0 then
				var_102_19.localPosition = Vector3.New(0, 100, 0)

				local var_102_26 = manager.ui.mainCamera.transform.position - var_102_19.position

				var_102_19.forward = Vector3.New(var_102_26.x, var_102_26.y, var_102_26.z)

				local var_102_27 = var_102_19.localEulerAngles

				var_102_27.z = 0
				var_102_27.x = 0
				var_102_19.localEulerAngles = var_102_27
			end

			local var_102_28 = 0

			if var_102_28 < arg_99_1.time_ and arg_99_1.time_ <= var_102_28 + arg_102_0 then
				arg_99_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_102_29 = 0
			local var_102_30 = 0.25

			if var_102_29 < arg_99_1.time_ and arg_99_1.time_ <= var_102_29 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_31 = arg_99_1:FormatText(StoryNameCfg[668].name)

				arg_99_1.leftNameTxt_.text = var_102_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_32 = arg_99_1:GetWordFromCfg(420051024)
				local var_102_33 = arg_99_1:FormatText(var_102_32.content)

				arg_99_1.text_.text = var_102_33

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_34 = 10
				local var_102_35 = utf8.len(var_102_33)
				local var_102_36 = var_102_34 <= 0 and var_102_30 or var_102_30 * (var_102_35 / var_102_34)

				if var_102_36 > 0 and var_102_30 < var_102_36 then
					arg_99_1.talkMaxDuration = var_102_36

					if var_102_36 + var_102_29 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_36 + var_102_29
					end
				end

				arg_99_1.text_.text = var_102_33
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051024", "story_v_out_420051.awb") ~= 0 then
					local var_102_37 = manager.audio:GetVoiceLength("story_v_out_420051", "420051024", "story_v_out_420051.awb") / 1000

					if var_102_37 + var_102_29 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_37 + var_102_29
					end

					if var_102_32.prefab_name ~= "" and arg_99_1.actors_[var_102_32.prefab_name] ~= nil then
						local var_102_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_32.prefab_name].transform, "story_v_out_420051", "420051024", "story_v_out_420051.awb")

						arg_99_1:RecordAudio("420051024", var_102_38)
						arg_99_1:RecordAudio("420051024", var_102_38)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_420051", "420051024", "story_v_out_420051.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_420051", "420051024", "story_v_out_420051.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_39 = math.max(var_102_30, arg_99_1.talkMaxDuration)

			if var_102_29 <= arg_99_1.time_ and arg_99_1.time_ < var_102_29 + var_102_39 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_29) / var_102_39

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_29 + var_102_39 and arg_99_1.time_ < var_102_29 + var_102_39 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play420051025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 420051025
		arg_103_1.duration_ = 5.87

		local var_103_0 = {
			zh = 4.7,
			ja = 5.866
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play420051026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["404001ui_story"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos404001ui_story = var_106_0.localPosition
			end

			local var_106_2 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2
				local var_106_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos404001ui_story, var_106_4, var_106_3)

				local var_106_5 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_5.x, var_106_5.y, var_106_5.z)

				local var_106_6 = var_106_0.localEulerAngles

				var_106_6.z = 0
				var_106_6.x = 0
				var_106_0.localEulerAngles = var_106_6
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_106_7 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_7.x, var_106_7.y, var_106_7.z)

				local var_106_8 = var_106_0.localEulerAngles

				var_106_8.z = 0
				var_106_8.x = 0
				var_106_0.localEulerAngles = var_106_8
			end

			local var_106_9 = arg_103_1.actors_["1085ui_story"].transform
			local var_106_10 = 0

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 then
				arg_103_1.var_.moveOldPos1085ui_story = var_106_9.localPosition
			end

			local var_106_11 = 0.001

			if var_106_10 <= arg_103_1.time_ and arg_103_1.time_ < var_106_10 + var_106_11 then
				local var_106_12 = (arg_103_1.time_ - var_106_10) / var_106_11
				local var_106_13 = Vector3.New(0.75, -1.01, -5.83)

				var_106_9.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1085ui_story, var_106_13, var_106_12)

				local var_106_14 = manager.ui.mainCamera.transform.position - var_106_9.position

				var_106_9.forward = Vector3.New(var_106_14.x, var_106_14.y, var_106_14.z)

				local var_106_15 = var_106_9.localEulerAngles

				var_106_15.z = 0
				var_106_15.x = 0
				var_106_9.localEulerAngles = var_106_15
			end

			if arg_103_1.time_ >= var_106_10 + var_106_11 and arg_103_1.time_ < var_106_10 + var_106_11 + arg_106_0 then
				var_106_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_106_16 = manager.ui.mainCamera.transform.position - var_106_9.position

				var_106_9.forward = Vector3.New(var_106_16.x, var_106_16.y, var_106_16.z)

				local var_106_17 = var_106_9.localEulerAngles

				var_106_17.z = 0
				var_106_17.x = 0
				var_106_9.localEulerAngles = var_106_17
			end

			local var_106_18 = arg_103_1.actors_["1085ui_story"]
			local var_106_19 = 0

			if var_106_19 < arg_103_1.time_ and arg_103_1.time_ <= var_106_19 + arg_106_0 and not isNil(var_106_18) and arg_103_1.var_.characterEffect1085ui_story == nil then
				arg_103_1.var_.characterEffect1085ui_story = var_106_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_20 = 0.200000002980232

			if var_106_19 <= arg_103_1.time_ and arg_103_1.time_ < var_106_19 + var_106_20 and not isNil(var_106_18) then
				local var_106_21 = (arg_103_1.time_ - var_106_19) / var_106_20

				if arg_103_1.var_.characterEffect1085ui_story and not isNil(var_106_18) then
					arg_103_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_19 + var_106_20 and arg_103_1.time_ < var_106_19 + var_106_20 + arg_106_0 and not isNil(var_106_18) and arg_103_1.var_.characterEffect1085ui_story then
				arg_103_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_106_22 = arg_103_1.actors_["404001ui_story"]
			local var_106_23 = 0

			if var_106_23 < arg_103_1.time_ and arg_103_1.time_ <= var_106_23 + arg_106_0 and not isNil(var_106_22) and arg_103_1.var_.characterEffect404001ui_story == nil then
				arg_103_1.var_.characterEffect404001ui_story = var_106_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_24 = 0.200000002980232

			if var_106_23 <= arg_103_1.time_ and arg_103_1.time_ < var_106_23 + var_106_24 and not isNil(var_106_22) then
				local var_106_25 = (arg_103_1.time_ - var_106_23) / var_106_24

				if arg_103_1.var_.characterEffect404001ui_story and not isNil(var_106_22) then
					local var_106_26 = Mathf.Lerp(0, 0.5, var_106_25)

					arg_103_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_103_1.var_.characterEffect404001ui_story.fillRatio = var_106_26
				end
			end

			if arg_103_1.time_ >= var_106_23 + var_106_24 and arg_103_1.time_ < var_106_23 + var_106_24 + arg_106_0 and not isNil(var_106_22) and arg_103_1.var_.characterEffect404001ui_story then
				local var_106_27 = 0.5

				arg_103_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_103_1.var_.characterEffect404001ui_story.fillRatio = var_106_27
			end

			local var_106_28 = 0

			if var_106_28 < arg_103_1.time_ and arg_103_1.time_ <= var_106_28 + arg_106_0 then
				arg_103_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_106_29 = 0

			if var_106_29 < arg_103_1.time_ and arg_103_1.time_ <= var_106_29 + arg_106_0 then
				arg_103_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_106_30 = 0
			local var_106_31 = 0.625

			if var_106_30 < arg_103_1.time_ and arg_103_1.time_ <= var_106_30 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_32 = arg_103_1:FormatText(StoryNameCfg[328].name)

				arg_103_1.leftNameTxt_.text = var_106_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_33 = arg_103_1:GetWordFromCfg(420051025)
				local var_106_34 = arg_103_1:FormatText(var_106_33.content)

				arg_103_1.text_.text = var_106_34

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_35 = 25
				local var_106_36 = utf8.len(var_106_34)
				local var_106_37 = var_106_35 <= 0 and var_106_31 or var_106_31 * (var_106_36 / var_106_35)

				if var_106_37 > 0 and var_106_31 < var_106_37 then
					arg_103_1.talkMaxDuration = var_106_37

					if var_106_37 + var_106_30 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_37 + var_106_30
					end
				end

				arg_103_1.text_.text = var_106_34
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051025", "story_v_out_420051.awb") ~= 0 then
					local var_106_38 = manager.audio:GetVoiceLength("story_v_out_420051", "420051025", "story_v_out_420051.awb") / 1000

					if var_106_38 + var_106_30 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_38 + var_106_30
					end

					if var_106_33.prefab_name ~= "" and arg_103_1.actors_[var_106_33.prefab_name] ~= nil then
						local var_106_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_33.prefab_name].transform, "story_v_out_420051", "420051025", "story_v_out_420051.awb")

						arg_103_1:RecordAudio("420051025", var_106_39)
						arg_103_1:RecordAudio("420051025", var_106_39)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_420051", "420051025", "story_v_out_420051.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_420051", "420051025", "story_v_out_420051.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_40 = math.max(var_106_31, arg_103_1.talkMaxDuration)

			if var_106_30 <= arg_103_1.time_ and arg_103_1.time_ < var_106_30 + var_106_40 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_30) / var_106_40

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_30 + var_106_40 and arg_103_1.time_ < var_106_30 + var_106_40 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play420051026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 420051026
		arg_107_1.duration_ = 6.47

		local var_107_0 = {
			zh = 4.833,
			ja = 6.466
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
				arg_107_0:Play420051027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["404001ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect404001ui_story == nil then
				arg_107_1.var_.characterEffect404001ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect404001ui_story and not isNil(var_110_0) then
					arg_107_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect404001ui_story then
				arg_107_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_110_4 = arg_107_1.actors_["1085ui_story"]
			local var_110_5 = 0

			if var_110_5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect1085ui_story == nil then
				arg_107_1.var_.characterEffect1085ui_story = var_110_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_6 = 0.200000002980232

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_6 and not isNil(var_110_4) then
				local var_110_7 = (arg_107_1.time_ - var_110_5) / var_110_6

				if arg_107_1.var_.characterEffect1085ui_story and not isNil(var_110_4) then
					local var_110_8 = Mathf.Lerp(0, 0.5, var_110_7)

					arg_107_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1085ui_story.fillRatio = var_110_8
				end
			end

			if arg_107_1.time_ >= var_110_5 + var_110_6 and arg_107_1.time_ < var_110_5 + var_110_6 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect1085ui_story then
				local var_110_9 = 0.5

				arg_107_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1085ui_story.fillRatio = var_110_9
			end

			local var_110_10 = 0
			local var_110_11 = 0.525

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_12 = arg_107_1:FormatText(StoryNameCfg[668].name)

				arg_107_1.leftNameTxt_.text = var_110_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_13 = arg_107_1:GetWordFromCfg(420051026)
				local var_110_14 = arg_107_1:FormatText(var_110_13.content)

				arg_107_1.text_.text = var_110_14

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_15 = 21
				local var_110_16 = utf8.len(var_110_14)
				local var_110_17 = var_110_15 <= 0 and var_110_11 or var_110_11 * (var_110_16 / var_110_15)

				if var_110_17 > 0 and var_110_11 < var_110_17 then
					arg_107_1.talkMaxDuration = var_110_17

					if var_110_17 + var_110_10 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_17 + var_110_10
					end
				end

				arg_107_1.text_.text = var_110_14
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051026", "story_v_out_420051.awb") ~= 0 then
					local var_110_18 = manager.audio:GetVoiceLength("story_v_out_420051", "420051026", "story_v_out_420051.awb") / 1000

					if var_110_18 + var_110_10 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_18 + var_110_10
					end

					if var_110_13.prefab_name ~= "" and arg_107_1.actors_[var_110_13.prefab_name] ~= nil then
						local var_110_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_13.prefab_name].transform, "story_v_out_420051", "420051026", "story_v_out_420051.awb")

						arg_107_1:RecordAudio("420051026", var_110_19)
						arg_107_1:RecordAudio("420051026", var_110_19)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_420051", "420051026", "story_v_out_420051.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_420051", "420051026", "story_v_out_420051.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_20 = math.max(var_110_11, arg_107_1.talkMaxDuration)

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_20 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_10) / var_110_20

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_10 + var_110_20 and arg_107_1.time_ < var_110_10 + var_110_20 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play420051027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 420051027
		arg_111_1.duration_ = 2

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play420051028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1085ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1085ui_story == nil then
				arg_111_1.var_.characterEffect1085ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1085ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1085ui_story then
				arg_111_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_114_4 = arg_111_1.actors_["404001ui_story"]
			local var_114_5 = 0

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 and not isNil(var_114_4) and arg_111_1.var_.characterEffect404001ui_story == nil then
				arg_111_1.var_.characterEffect404001ui_story = var_114_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_6 = 0.200000002980232

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_6 and not isNil(var_114_4) then
				local var_114_7 = (arg_111_1.time_ - var_114_5) / var_114_6

				if arg_111_1.var_.characterEffect404001ui_story and not isNil(var_114_4) then
					local var_114_8 = Mathf.Lerp(0, 0.5, var_114_7)

					arg_111_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_111_1.var_.characterEffect404001ui_story.fillRatio = var_114_8
				end
			end

			if arg_111_1.time_ >= var_114_5 + var_114_6 and arg_111_1.time_ < var_114_5 + var_114_6 + arg_114_0 and not isNil(var_114_4) and arg_111_1.var_.characterEffect404001ui_story then
				local var_114_9 = 0.5

				arg_111_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_111_1.var_.characterEffect404001ui_story.fillRatio = var_114_9
			end

			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_114_11 = 0

			if var_114_11 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 then
				arg_111_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_114_12 = 0
			local var_114_13 = 0.15

			if var_114_12 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_14 = arg_111_1:FormatText(StoryNameCfg[328].name)

				arg_111_1.leftNameTxt_.text = var_114_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_15 = arg_111_1:GetWordFromCfg(420051027)
				local var_114_16 = arg_111_1:FormatText(var_114_15.content)

				arg_111_1.text_.text = var_114_16

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_17 = 6
				local var_114_18 = utf8.len(var_114_16)
				local var_114_19 = var_114_17 <= 0 and var_114_13 or var_114_13 * (var_114_18 / var_114_17)

				if var_114_19 > 0 and var_114_13 < var_114_19 then
					arg_111_1.talkMaxDuration = var_114_19

					if var_114_19 + var_114_12 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_19 + var_114_12
					end
				end

				arg_111_1.text_.text = var_114_16
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051027", "story_v_out_420051.awb") ~= 0 then
					local var_114_20 = manager.audio:GetVoiceLength("story_v_out_420051", "420051027", "story_v_out_420051.awb") / 1000

					if var_114_20 + var_114_12 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_20 + var_114_12
					end

					if var_114_15.prefab_name ~= "" and arg_111_1.actors_[var_114_15.prefab_name] ~= nil then
						local var_114_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_15.prefab_name].transform, "story_v_out_420051", "420051027", "story_v_out_420051.awb")

						arg_111_1:RecordAudio("420051027", var_114_21)
						arg_111_1:RecordAudio("420051027", var_114_21)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_420051", "420051027", "story_v_out_420051.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_420051", "420051027", "story_v_out_420051.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_22 = math.max(var_114_13, arg_111_1.talkMaxDuration)

			if var_114_12 <= arg_111_1.time_ and arg_111_1.time_ < var_114_12 + var_114_22 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_12) / var_114_22

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_12 + var_114_22 and arg_111_1.time_ < var_114_12 + var_114_22 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play420051028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 420051028
		arg_115_1.duration_ = 9

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play420051029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = "ST0503"

			if arg_115_1.bgs_[var_118_0] == nil then
				local var_118_1 = Object.Instantiate(arg_115_1.paintGo_)

				var_118_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_118_0)
				var_118_1.name = var_118_0
				var_118_1.transform.parent = arg_115_1.stage_.transform
				var_118_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.bgs_[var_118_0] = var_118_1
			end

			local var_118_2 = 1.999999999999

			if var_118_2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				local var_118_3 = manager.ui.mainCamera.transform.localPosition
				local var_118_4 = Vector3.New(0, 0, 10) + Vector3.New(var_118_3.x, var_118_3.y, 0)
				local var_118_5 = arg_115_1.bgs_.ST0503

				var_118_5.transform.localPosition = var_118_4
				var_118_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_118_6 = var_118_5:GetComponent("SpriteRenderer")

				if var_118_6 and var_118_6.sprite then
					local var_118_7 = (var_118_5.transform.localPosition - var_118_3).z
					local var_118_8 = manager.ui.mainCameraCom_
					local var_118_9 = 2 * var_118_7 * Mathf.Tan(var_118_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_118_10 = var_118_9 * var_118_8.aspect
					local var_118_11 = var_118_6.sprite.bounds.size.x
					local var_118_12 = var_118_6.sprite.bounds.size.y
					local var_118_13 = var_118_10 / var_118_11
					local var_118_14 = var_118_9 / var_118_12
					local var_118_15 = var_118_14 < var_118_13 and var_118_13 or var_118_14

					var_118_5.transform.localScale = Vector3.New(var_118_15, var_118_15, 0)
				end

				for iter_118_0, iter_118_1 in pairs(arg_115_1.bgs_) do
					if iter_118_0 ~= "ST0503" then
						iter_118_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_118_16 = 3.999999999999

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 then
				arg_115_1.allBtn_.enabled = false
			end

			local var_118_17 = 0.400000000001

			if arg_115_1.time_ >= var_118_16 + var_118_17 and arg_115_1.time_ < var_118_16 + var_118_17 + arg_118_0 then
				arg_115_1.allBtn_.enabled = true
			end

			local var_118_18 = 0

			if var_118_18 < arg_115_1.time_ and arg_115_1.time_ <= var_118_18 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_19 = 2

			if var_118_18 <= arg_115_1.time_ and arg_115_1.time_ < var_118_18 + var_118_19 then
				local var_118_20 = (arg_115_1.time_ - var_118_18) / var_118_19
				local var_118_21 = Color.New(0, 0, 0)

				var_118_21.a = Mathf.Lerp(0, 1, var_118_20)
				arg_115_1.mask_.color = var_118_21
			end

			if arg_115_1.time_ >= var_118_18 + var_118_19 and arg_115_1.time_ < var_118_18 + var_118_19 + arg_118_0 then
				local var_118_22 = Color.New(0, 0, 0)

				var_118_22.a = 1
				arg_115_1.mask_.color = var_118_22
			end

			local var_118_23 = 2

			if var_118_23 < arg_115_1.time_ and arg_115_1.time_ <= var_118_23 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_24 = 2

			if var_118_23 <= arg_115_1.time_ and arg_115_1.time_ < var_118_23 + var_118_24 then
				local var_118_25 = (arg_115_1.time_ - var_118_23) / var_118_24
				local var_118_26 = Color.New(0, 0, 0)

				var_118_26.a = Mathf.Lerp(1, 0, var_118_25)
				arg_115_1.mask_.color = var_118_26
			end

			if arg_115_1.time_ >= var_118_23 + var_118_24 and arg_115_1.time_ < var_118_23 + var_118_24 + arg_118_0 then
				local var_118_27 = Color.New(0, 0, 0)
				local var_118_28 = 0

				arg_115_1.mask_.enabled = false
				var_118_27.a = var_118_28
				arg_115_1.mask_.color = var_118_27
			end

			local var_118_29 = arg_115_1.actors_["404001ui_story"].transform
			local var_118_30 = 1.999999999999

			if var_118_30 < arg_115_1.time_ and arg_115_1.time_ <= var_118_30 + arg_118_0 then
				arg_115_1.var_.moveOldPos404001ui_story = var_118_29.localPosition
			end

			local var_118_31 = 0.001

			if var_118_30 <= arg_115_1.time_ and arg_115_1.time_ < var_118_30 + var_118_31 then
				local var_118_32 = (arg_115_1.time_ - var_118_30) / var_118_31
				local var_118_33 = Vector3.New(0, 100, 0)

				var_118_29.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos404001ui_story, var_118_33, var_118_32)

				local var_118_34 = manager.ui.mainCamera.transform.position - var_118_29.position

				var_118_29.forward = Vector3.New(var_118_34.x, var_118_34.y, var_118_34.z)

				local var_118_35 = var_118_29.localEulerAngles

				var_118_35.z = 0
				var_118_35.x = 0
				var_118_29.localEulerAngles = var_118_35
			end

			if arg_115_1.time_ >= var_118_30 + var_118_31 and arg_115_1.time_ < var_118_30 + var_118_31 + arg_118_0 then
				var_118_29.localPosition = Vector3.New(0, 100, 0)

				local var_118_36 = manager.ui.mainCamera.transform.position - var_118_29.position

				var_118_29.forward = Vector3.New(var_118_36.x, var_118_36.y, var_118_36.z)

				local var_118_37 = var_118_29.localEulerAngles

				var_118_37.z = 0
				var_118_37.x = 0
				var_118_29.localEulerAngles = var_118_37
			end

			local var_118_38 = arg_115_1.actors_["1085ui_story"].transform
			local var_118_39 = 1.999999999999

			if var_118_39 < arg_115_1.time_ and arg_115_1.time_ <= var_118_39 + arg_118_0 then
				arg_115_1.var_.moveOldPos1085ui_story = var_118_38.localPosition
			end

			local var_118_40 = 0.001

			if var_118_39 <= arg_115_1.time_ and arg_115_1.time_ < var_118_39 + var_118_40 then
				local var_118_41 = (arg_115_1.time_ - var_118_39) / var_118_40
				local var_118_42 = Vector3.New(0, 100, 0)

				var_118_38.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1085ui_story, var_118_42, var_118_41)

				local var_118_43 = manager.ui.mainCamera.transform.position - var_118_38.position

				var_118_38.forward = Vector3.New(var_118_43.x, var_118_43.y, var_118_43.z)

				local var_118_44 = var_118_38.localEulerAngles

				var_118_44.z = 0
				var_118_44.x = 0
				var_118_38.localEulerAngles = var_118_44
			end

			if arg_115_1.time_ >= var_118_39 + var_118_40 and arg_115_1.time_ < var_118_39 + var_118_40 + arg_118_0 then
				var_118_38.localPosition = Vector3.New(0, 100, 0)

				local var_118_45 = manager.ui.mainCamera.transform.position - var_118_38.position

				var_118_38.forward = Vector3.New(var_118_45.x, var_118_45.y, var_118_45.z)

				local var_118_46 = var_118_38.localEulerAngles

				var_118_46.z = 0
				var_118_46.x = 0
				var_118_38.localEulerAngles = var_118_46
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_47 = 4
			local var_118_48 = 0.8

			if var_118_47 < arg_115_1.time_ and arg_115_1.time_ <= var_118_47 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_49 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_49:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_50 = arg_115_1:GetWordFromCfg(420051028)
				local var_118_51 = arg_115_1:FormatText(var_118_50.content)

				arg_115_1.text_.text = var_118_51

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_52 = 32
				local var_118_53 = utf8.len(var_118_51)
				local var_118_54 = var_118_52 <= 0 and var_118_48 or var_118_48 * (var_118_53 / var_118_52)

				if var_118_54 > 0 and var_118_48 < var_118_54 then
					arg_115_1.talkMaxDuration = var_118_54
					var_118_47 = var_118_47 + 0.3

					if var_118_54 + var_118_47 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_54 + var_118_47
					end
				end

				arg_115_1.text_.text = var_118_51
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_55 = var_118_47 + 0.3
			local var_118_56 = math.max(var_118_48, arg_115_1.talkMaxDuration)

			if var_118_55 <= arg_115_1.time_ and arg_115_1.time_ < var_118_55 + var_118_56 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_55) / var_118_56

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_55 + var_118_56 and arg_115_1.time_ < var_118_55 + var_118_56 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play420051029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 420051029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play420051030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 1.725

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_2 = arg_121_1:GetWordFromCfg(420051029)
				local var_124_3 = arg_121_1:FormatText(var_124_2.content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 69
				local var_124_5 = utf8.len(var_124_3)
				local var_124_6 = var_124_4 <= 0 and var_124_1 or var_124_1 * (var_124_5 / var_124_4)

				if var_124_6 > 0 and var_124_1 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_7 and arg_121_1.time_ < var_124_0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play420051030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 420051030
		arg_125_1.duration_ = 3.2

		local var_125_0 = {
			zh = 3.2,
			ja = 2.733
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
				arg_125_0:Play420051031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1085ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1085ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, -1.01, -5.83)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1085ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["1085ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1085ui_story == nil then
				arg_125_1.var_.characterEffect1085ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect1085ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1085ui_story then
				arg_125_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_128_15 = 0
			local var_128_16 = 0.25

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_17 = arg_125_1:FormatText(StoryNameCfg[328].name)

				arg_125_1.leftNameTxt_.text = var_128_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_18 = arg_125_1:GetWordFromCfg(420051030)
				local var_128_19 = arg_125_1:FormatText(var_128_18.content)

				arg_125_1.text_.text = var_128_19

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051030", "story_v_out_420051.awb") ~= 0 then
					local var_128_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051030", "story_v_out_420051.awb") / 1000

					if var_128_23 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_23 + var_128_15
					end

					if var_128_18.prefab_name ~= "" and arg_125_1.actors_[var_128_18.prefab_name] ~= nil then
						local var_128_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_18.prefab_name].transform, "story_v_out_420051", "420051030", "story_v_out_420051.awb")

						arg_125_1:RecordAudio("420051030", var_128_24)
						arg_125_1:RecordAudio("420051030", var_128_24)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_420051", "420051030", "story_v_out_420051.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_420051", "420051030", "story_v_out_420051.awb")
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
				actorName = "1085ui_story",
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
	Play420051031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 420051031
		arg_129_1.duration_ = 5.6

		local var_129_0 = {
			zh = 3.5,
			ja = 5.6
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
				arg_129_0:Play420051032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1085ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1085ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(0, 100, 0)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1085ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, 100, 0)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = 0
			local var_132_10 = 0.375

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_11 = arg_129_1:FormatText(StoryNameCfg[1157].name)

				arg_129_1.leftNameTxt_.text = var_132_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_12 = arg_129_1:GetWordFromCfg(420051031)
				local var_132_13 = arg_129_1:FormatText(var_132_12.content)

				arg_129_1.text_.text = var_132_13

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_14 = 15
				local var_132_15 = utf8.len(var_132_13)
				local var_132_16 = var_132_14 <= 0 and var_132_10 or var_132_10 * (var_132_15 / var_132_14)

				if var_132_16 > 0 and var_132_10 < var_132_16 then
					arg_129_1.talkMaxDuration = var_132_16

					if var_132_16 + var_132_9 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_16 + var_132_9
					end
				end

				arg_129_1.text_.text = var_132_13
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051031", "story_v_out_420051.awb") ~= 0 then
					local var_132_17 = manager.audio:GetVoiceLength("story_v_out_420051", "420051031", "story_v_out_420051.awb") / 1000

					if var_132_17 + var_132_9 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_17 + var_132_9
					end

					if var_132_12.prefab_name ~= "" and arg_129_1.actors_[var_132_12.prefab_name] ~= nil then
						local var_132_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_12.prefab_name].transform, "story_v_out_420051", "420051031", "story_v_out_420051.awb")

						arg_129_1:RecordAudio("420051031", var_132_18)
						arg_129_1:RecordAudio("420051031", var_132_18)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_420051", "420051031", "story_v_out_420051.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_420051", "420051031", "story_v_out_420051.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_19 = math.max(var_132_10, arg_129_1.talkMaxDuration)

			if var_132_9 <= arg_129_1.time_ and arg_129_1.time_ < var_132_9 + var_132_19 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_9) / var_132_19

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_9 + var_132_19 and arg_129_1.time_ < var_132_9 + var_132_19 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420051032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 420051032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play420051033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.05
			local var_136_1 = 1

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				local var_136_2 = "play"
				local var_136_3 = "effect"

				arg_133_1:AudioAction(var_136_2, var_136_3, "se_story_140", "se_story_140_foley_cash02", "")
			end

			local var_136_4 = 0
			local var_136_5 = 0.725

			if var_136_4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(420051032)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_8 = 29
				local var_136_9 = utf8.len(var_136_7)
				local var_136_10 = var_136_8 <= 0 and var_136_5 or var_136_5 * (var_136_9 / var_136_8)

				if var_136_10 > 0 and var_136_5 < var_136_10 then
					arg_133_1.talkMaxDuration = var_136_10

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_11 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_11 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_11

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_11 and arg_133_1.time_ < var_136_4 + var_136_11 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play420051033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 420051033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play420051034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 1.025

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(420051033)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 41
				local var_140_5 = utf8.len(var_140_3)
				local var_140_6 = var_140_4 <= 0 and var_140_1 or var_140_1 * (var_140_5 / var_140_4)

				if var_140_6 > 0 and var_140_1 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_7 and arg_137_1.time_ < var_140_0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play420051034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 420051034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play420051035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.75

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(420051034)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 30
				local var_144_5 = utf8.len(var_144_3)
				local var_144_6 = var_144_4 <= 0 and var_144_1 or var_144_1 * (var_144_5 / var_144_4)

				if var_144_6 > 0 and var_144_1 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_7 and arg_141_1.time_ < var_144_0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play420051035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 420051035
		arg_145_1.duration_ = 6.4

		local var_145_0 = {
			zh = 3.8,
			ja = 6.4
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
				arg_145_0:Play420051036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["404001ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos404001ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, -1.55, -5.5)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos404001ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["404001ui_story"]
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect404001ui_story == nil then
				arg_145_1.var_.characterEffect404001ui_story = var_148_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_11 = 0.200000002980232

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 and not isNil(var_148_9) then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11

				if arg_145_1.var_.characterEffect404001ui_story and not isNil(var_148_9) then
					arg_145_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect404001ui_story then
				arg_145_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_148_13 = 0

			if var_148_13 < arg_145_1.time_ and arg_145_1.time_ <= var_148_13 + arg_148_0 then
				arg_145_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_148_14 = 0

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_148_15 = 0
			local var_148_16 = 0.5

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[668].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(420051035)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051035", "story_v_out_420051.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051035", "story_v_out_420051.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_420051", "420051035", "story_v_out_420051.awb")

						arg_145_1:RecordAudio("420051035", var_148_24)
						arg_145_1:RecordAudio("420051035", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_420051", "420051035", "story_v_out_420051.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_420051", "420051035", "story_v_out_420051.awb")
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
				actorName = "404001ui_story",
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
	Play420051036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 420051036
		arg_149_1.duration_ = 2.3

		local var_149_0 = {
			zh = 1.833,
			ja = 2.3
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play420051037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["404001ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos404001ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos404001ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["1085ui_story"].transform
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1.var_.moveOldPos1085ui_story = var_152_9.localPosition
			end

			local var_152_11 = 0.001

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11
				local var_152_13 = Vector3.New(0.75, -1.01, -5.83)

				var_152_9.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1085ui_story, var_152_13, var_152_12)

				local var_152_14 = manager.ui.mainCamera.transform.position - var_152_9.position

				var_152_9.forward = Vector3.New(var_152_14.x, var_152_14.y, var_152_14.z)

				local var_152_15 = var_152_9.localEulerAngles

				var_152_15.z = 0
				var_152_15.x = 0
				var_152_9.localEulerAngles = var_152_15
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 then
				var_152_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_152_16 = manager.ui.mainCamera.transform.position - var_152_9.position

				var_152_9.forward = Vector3.New(var_152_16.x, var_152_16.y, var_152_16.z)

				local var_152_17 = var_152_9.localEulerAngles

				var_152_17.z = 0
				var_152_17.x = 0
				var_152_9.localEulerAngles = var_152_17
			end

			local var_152_18 = arg_149_1.actors_["1085ui_story"]
			local var_152_19 = 0

			if var_152_19 < arg_149_1.time_ and arg_149_1.time_ <= var_152_19 + arg_152_0 and not isNil(var_152_18) and arg_149_1.var_.characterEffect1085ui_story == nil then
				arg_149_1.var_.characterEffect1085ui_story = var_152_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_20 = 0.200000002980232

			if var_152_19 <= arg_149_1.time_ and arg_149_1.time_ < var_152_19 + var_152_20 and not isNil(var_152_18) then
				local var_152_21 = (arg_149_1.time_ - var_152_19) / var_152_20

				if arg_149_1.var_.characterEffect1085ui_story and not isNil(var_152_18) then
					arg_149_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_19 + var_152_20 and arg_149_1.time_ < var_152_19 + var_152_20 + arg_152_0 and not isNil(var_152_18) and arg_149_1.var_.characterEffect1085ui_story then
				arg_149_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_152_22 = arg_149_1.actors_["404001ui_story"]
			local var_152_23 = 0

			if var_152_23 < arg_149_1.time_ and arg_149_1.time_ <= var_152_23 + arg_152_0 and not isNil(var_152_22) and arg_149_1.var_.characterEffect404001ui_story == nil then
				arg_149_1.var_.characterEffect404001ui_story = var_152_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_24 = 0.200000002980232

			if var_152_23 <= arg_149_1.time_ and arg_149_1.time_ < var_152_23 + var_152_24 and not isNil(var_152_22) then
				local var_152_25 = (arg_149_1.time_ - var_152_23) / var_152_24

				if arg_149_1.var_.characterEffect404001ui_story and not isNil(var_152_22) then
					local var_152_26 = Mathf.Lerp(0, 0.5, var_152_25)

					arg_149_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_149_1.var_.characterEffect404001ui_story.fillRatio = var_152_26
				end
			end

			if arg_149_1.time_ >= var_152_23 + var_152_24 and arg_149_1.time_ < var_152_23 + var_152_24 + arg_152_0 and not isNil(var_152_22) and arg_149_1.var_.characterEffect404001ui_story then
				local var_152_27 = 0.5

				arg_149_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_149_1.var_.characterEffect404001ui_story.fillRatio = var_152_27
			end

			local var_152_28 = 0
			local var_152_29 = 0.4

			if var_152_28 < arg_149_1.time_ and arg_149_1.time_ <= var_152_28 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_30 = arg_149_1:FormatText(StoryNameCfg[328].name)

				arg_149_1.leftNameTxt_.text = var_152_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_31 = arg_149_1:GetWordFromCfg(420051036)
				local var_152_32 = arg_149_1:FormatText(var_152_31.content)

				arg_149_1.text_.text = var_152_32

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_33 = 16
				local var_152_34 = utf8.len(var_152_32)
				local var_152_35 = var_152_33 <= 0 and var_152_29 or var_152_29 * (var_152_34 / var_152_33)

				if var_152_35 > 0 and var_152_29 < var_152_35 then
					arg_149_1.talkMaxDuration = var_152_35

					if var_152_35 + var_152_28 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_35 + var_152_28
					end
				end

				arg_149_1.text_.text = var_152_32
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051036", "story_v_out_420051.awb") ~= 0 then
					local var_152_36 = manager.audio:GetVoiceLength("story_v_out_420051", "420051036", "story_v_out_420051.awb") / 1000

					if var_152_36 + var_152_28 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_36 + var_152_28
					end

					if var_152_31.prefab_name ~= "" and arg_149_1.actors_[var_152_31.prefab_name] ~= nil then
						local var_152_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_31.prefab_name].transform, "story_v_out_420051", "420051036", "story_v_out_420051.awb")

						arg_149_1:RecordAudio("420051036", var_152_37)
						arg_149_1:RecordAudio("420051036", var_152_37)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_420051", "420051036", "story_v_out_420051.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_420051", "420051036", "story_v_out_420051.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_38 = math.max(var_152_29, arg_149_1.talkMaxDuration)

			if var_152_28 <= arg_149_1.time_ and arg_149_1.time_ < var_152_28 + var_152_38 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_28) / var_152_38

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_28 + var_152_38 and arg_149_1.time_ < var_152_28 + var_152_38 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420051037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 420051037
		arg_153_1.duration_ = 4.97

		local var_153_0 = {
			zh = 3.533,
			ja = 4.966
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
				arg_153_0:Play420051038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["404001ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect404001ui_story == nil then
				arg_153_1.var_.characterEffect404001ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect404001ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect404001ui_story then
				arg_153_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_156_4 = arg_153_1.actors_["1085ui_story"]
			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1085ui_story == nil then
				arg_153_1.var_.characterEffect1085ui_story = var_156_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_6 = 0.200000002980232

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 and not isNil(var_156_4) then
				local var_156_7 = (arg_153_1.time_ - var_156_5) / var_156_6

				if arg_153_1.var_.characterEffect1085ui_story and not isNil(var_156_4) then
					local var_156_8 = Mathf.Lerp(0, 0.5, var_156_7)

					arg_153_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1085ui_story.fillRatio = var_156_8
				end
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1085ui_story then
				local var_156_9 = 0.5

				arg_153_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1085ui_story.fillRatio = var_156_9
			end

			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			local var_156_11 = 0
			local var_156_12 = 0.425

			if var_156_11 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_13 = arg_153_1:FormatText(StoryNameCfg[668].name)

				arg_153_1.leftNameTxt_.text = var_156_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_14 = arg_153_1:GetWordFromCfg(420051037)
				local var_156_15 = arg_153_1:FormatText(var_156_14.content)

				arg_153_1.text_.text = var_156_15

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_16 = 17
				local var_156_17 = utf8.len(var_156_15)
				local var_156_18 = var_156_16 <= 0 and var_156_12 or var_156_12 * (var_156_17 / var_156_16)

				if var_156_18 > 0 and var_156_12 < var_156_18 then
					arg_153_1.talkMaxDuration = var_156_18

					if var_156_18 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_18 + var_156_11
					end
				end

				arg_153_1.text_.text = var_156_15
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051037", "story_v_out_420051.awb") ~= 0 then
					local var_156_19 = manager.audio:GetVoiceLength("story_v_out_420051", "420051037", "story_v_out_420051.awb") / 1000

					if var_156_19 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_11
					end

					if var_156_14.prefab_name ~= "" and arg_153_1.actors_[var_156_14.prefab_name] ~= nil then
						local var_156_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_14.prefab_name].transform, "story_v_out_420051", "420051037", "story_v_out_420051.awb")

						arg_153_1:RecordAudio("420051037", var_156_20)
						arg_153_1:RecordAudio("420051037", var_156_20)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_420051", "420051037", "story_v_out_420051.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_420051", "420051037", "story_v_out_420051.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_21 = math.max(var_156_12, arg_153_1.talkMaxDuration)

			if var_156_11 <= arg_153_1.time_ and arg_153_1.time_ < var_156_11 + var_156_21 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_11) / var_156_21

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_11 + var_156_21 and arg_153_1.time_ < var_156_11 + var_156_21 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play420051038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 420051038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play420051039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["404001ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos404001ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0, 100, 0)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos404001ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, 100, 0)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["1085ui_story"].transform
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.var_.moveOldPos1085ui_story = var_160_9.localPosition
			end

			local var_160_11 = 0.001

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11
				local var_160_13 = Vector3.New(0, 100, 0)

				var_160_9.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1085ui_story, var_160_13, var_160_12)

				local var_160_14 = manager.ui.mainCamera.transform.position - var_160_9.position

				var_160_9.forward = Vector3.New(var_160_14.x, var_160_14.y, var_160_14.z)

				local var_160_15 = var_160_9.localEulerAngles

				var_160_15.z = 0
				var_160_15.x = 0
				var_160_9.localEulerAngles = var_160_15
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 then
				var_160_9.localPosition = Vector3.New(0, 100, 0)

				local var_160_16 = manager.ui.mainCamera.transform.position - var_160_9.position

				var_160_9.forward = Vector3.New(var_160_16.x, var_160_16.y, var_160_16.z)

				local var_160_17 = var_160_9.localEulerAngles

				var_160_17.z = 0
				var_160_17.x = 0
				var_160_9.localEulerAngles = var_160_17
			end

			local var_160_18 = 0.200000002980232
			local var_160_19 = 1

			if var_160_18 < arg_157_1.time_ and arg_157_1.time_ <= var_160_18 + arg_160_0 then
				local var_160_20 = "play"
				local var_160_21 = "effect"

				arg_157_1:AudioAction(var_160_20, var_160_21, "se_story_140", "se_story_140_snap", "")
			end

			local var_160_22 = 0
			local var_160_23 = 0.625

			if var_160_22 < arg_157_1.time_ and arg_157_1.time_ <= var_160_22 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_24 = arg_157_1:GetWordFromCfg(420051038)
				local var_160_25 = arg_157_1:FormatText(var_160_24.content)

				arg_157_1.text_.text = var_160_25

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_26 = 25
				local var_160_27 = utf8.len(var_160_25)
				local var_160_28 = var_160_26 <= 0 and var_160_23 or var_160_23 * (var_160_27 / var_160_26)

				if var_160_28 > 0 and var_160_23 < var_160_28 then
					arg_157_1.talkMaxDuration = var_160_28

					if var_160_28 + var_160_22 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_28 + var_160_22
					end
				end

				arg_157_1.text_.text = var_160_25
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_29 = math.max(var_160_23, arg_157_1.talkMaxDuration)

			if var_160_22 <= arg_157_1.time_ and arg_157_1.time_ < var_160_22 + var_160_29 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_22) / var_160_29

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_22 + var_160_29 and arg_157_1.time_ < var_160_22 + var_160_29 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420051039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 420051039
		arg_161_1.duration_ = 9

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play420051040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = "ST61"

			if arg_161_1.bgs_[var_164_0] == nil then
				local var_164_1 = Object.Instantiate(arg_161_1.paintGo_)

				var_164_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_164_0)
				var_164_1.name = var_164_0
				var_164_1.transform.parent = arg_161_1.stage_.transform
				var_164_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.bgs_[var_164_0] = var_164_1
			end

			local var_164_2 = 2

			if var_164_2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 then
				local var_164_3 = manager.ui.mainCamera.transform.localPosition
				local var_164_4 = Vector3.New(0, 0, 10) + Vector3.New(var_164_3.x, var_164_3.y, 0)
				local var_164_5 = arg_161_1.bgs_.ST61

				var_164_5.transform.localPosition = var_164_4
				var_164_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_164_6 = var_164_5:GetComponent("SpriteRenderer")

				if var_164_6 and var_164_6.sprite then
					local var_164_7 = (var_164_5.transform.localPosition - var_164_3).z
					local var_164_8 = manager.ui.mainCameraCom_
					local var_164_9 = 2 * var_164_7 * Mathf.Tan(var_164_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_164_10 = var_164_9 * var_164_8.aspect
					local var_164_11 = var_164_6.sprite.bounds.size.x
					local var_164_12 = var_164_6.sprite.bounds.size.y
					local var_164_13 = var_164_10 / var_164_11
					local var_164_14 = var_164_9 / var_164_12
					local var_164_15 = var_164_14 < var_164_13 and var_164_13 or var_164_14

					var_164_5.transform.localScale = Vector3.New(var_164_15, var_164_15, 0)
				end

				for iter_164_0, iter_164_1 in pairs(arg_161_1.bgs_) do
					if iter_164_0 ~= "ST61" then
						iter_164_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_164_16 = 3.999999999999

			if var_164_16 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 then
				arg_161_1.allBtn_.enabled = false
			end

			local var_164_17 = 0.3

			if arg_161_1.time_ >= var_164_16 + var_164_17 and arg_161_1.time_ < var_164_16 + var_164_17 + arg_164_0 then
				arg_161_1.allBtn_.enabled = true
			end

			local var_164_18 = 0

			if var_164_18 < arg_161_1.time_ and arg_161_1.time_ <= var_164_18 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_19 = 2

			if var_164_18 <= arg_161_1.time_ and arg_161_1.time_ < var_164_18 + var_164_19 then
				local var_164_20 = (arg_161_1.time_ - var_164_18) / var_164_19
				local var_164_21 = Color.New(0, 0, 0)

				var_164_21.a = Mathf.Lerp(0, 1, var_164_20)
				arg_161_1.mask_.color = var_164_21
			end

			if arg_161_1.time_ >= var_164_18 + var_164_19 and arg_161_1.time_ < var_164_18 + var_164_19 + arg_164_0 then
				local var_164_22 = Color.New(0, 0, 0)

				var_164_22.a = 1
				arg_161_1.mask_.color = var_164_22
			end

			local var_164_23 = 2

			if var_164_23 < arg_161_1.time_ and arg_161_1.time_ <= var_164_23 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_24 = 2

			if var_164_23 <= arg_161_1.time_ and arg_161_1.time_ < var_164_23 + var_164_24 then
				local var_164_25 = (arg_161_1.time_ - var_164_23) / var_164_24
				local var_164_26 = Color.New(0, 0, 0)

				var_164_26.a = Mathf.Lerp(1, 0, var_164_25)
				arg_161_1.mask_.color = var_164_26
			end

			if arg_161_1.time_ >= var_164_23 + var_164_24 and arg_161_1.time_ < var_164_23 + var_164_24 + arg_164_0 then
				local var_164_27 = Color.New(0, 0, 0)
				local var_164_28 = 0

				arg_161_1.mask_.enabled = false
				var_164_27.a = var_164_28
				arg_161_1.mask_.color = var_164_27
			end

			if arg_161_1.frameCnt_ <= 1 then
				arg_161_1.dialog_:SetActive(false)
			end

			local var_164_29 = 3.999999999999
			local var_164_30 = 0.8

			if var_164_29 < arg_161_1.time_ and arg_161_1.time_ <= var_164_29 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				arg_161_1.dialog_:SetActive(true)

				arg_161_1.dialogCg_.alpha = 0

				local var_164_31 = LeanTween.value(arg_161_1.dialog_, 0, 1, 0.3)

				var_164_31:setOnUpdate(LuaHelper.FloatAction(function(arg_165_0)
					arg_161_1.dialogCg_.alpha = arg_165_0
				end))
				var_164_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_161_1.dialog_)
					var_164_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_161_1.duration_ = arg_161_1.duration_ + 0.3

				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_32 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_33 = arg_161_1:GetWordFromCfg(420051039)
				local var_164_34 = arg_161_1:FormatText(var_164_33.content)

				arg_161_1.text_.text = var_164_34

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_35 = 32
				local var_164_36 = utf8.len(var_164_34)
				local var_164_37 = var_164_35 <= 0 and var_164_30 or var_164_30 * (var_164_36 / var_164_35)

				if var_164_37 > 0 and var_164_30 < var_164_37 then
					arg_161_1.talkMaxDuration = var_164_37
					var_164_29 = var_164_29 + 0.3

					if var_164_37 + var_164_29 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_37 + var_164_29
					end
				end

				arg_161_1.text_.text = var_164_34
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_38 = var_164_29 + 0.3
			local var_164_39 = math.max(var_164_30, arg_161_1.talkMaxDuration)

			if var_164_38 <= arg_161_1.time_ and arg_161_1.time_ < var_164_38 + var_164_39 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_38) / var_164_39

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_38 + var_164_39 and arg_161_1.time_ < var_164_38 + var_164_39 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play420051040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 420051040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play420051041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.3
			local var_170_1 = 1

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				local var_170_2 = "play"
				local var_170_3 = "effect"

				arg_167_1:AudioAction(var_170_2, var_170_3, "se_story_140", "se_story_140_foley_bag02", "")
			end

			local var_170_4 = 0
			local var_170_5 = 1.025

			if var_170_4 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(420051040)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_8 = 41
				local var_170_9 = utf8.len(var_170_7)
				local var_170_10 = var_170_8 <= 0 and var_170_5 or var_170_5 * (var_170_9 / var_170_8)

				if var_170_10 > 0 and var_170_5 < var_170_10 then
					arg_167_1.talkMaxDuration = var_170_10

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_11 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_11 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_11

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_11 and arg_167_1.time_ < var_170_4 + var_170_11 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play420051041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 420051041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play420051042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.35

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

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(420051041)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 14
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
	Play420051042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 420051042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play420051043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.575

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(420051042)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 23
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_8 and arg_175_1.time_ < var_178_0 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play420051043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 420051043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play420051044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.65

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(420051043)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 26
				local var_182_5 = utf8.len(var_182_3)
				local var_182_6 = var_182_4 <= 0 and var_182_1 or var_182_1 * (var_182_5 / var_182_4)

				if var_182_6 > 0 and var_182_1 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_7 and arg_179_1.time_ < var_182_0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play420051044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 420051044
		arg_183_1.duration_ = 4.1

		local var_183_0 = {
			zh = 1.999999999999,
			ja = 4.1
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play420051045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1085ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1085ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, -1.01, -5.83)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1085ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["1085ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1085ui_story == nil then
				arg_183_1.var_.characterEffect1085ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect1085ui_story and not isNil(var_186_9) then
					arg_183_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1085ui_story then
				arg_183_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_186_13 = 0

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_186_14 = 0

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_186_15 = 0
			local var_186_16 = 0.125

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[328].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(420051044)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 5
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051044", "story_v_out_420051.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051044", "story_v_out_420051.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_out_420051", "420051044", "story_v_out_420051.awb")

						arg_183_1:RecordAudio("420051044", var_186_24)
						arg_183_1:RecordAudio("420051044", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_420051", "420051044", "story_v_out_420051.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_420051", "420051044", "story_v_out_420051.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_25 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_25 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_25

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_25 and arg_183_1.time_ < var_186_15 + var_186_25 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420051045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 420051045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play420051046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1085ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1085ui_story == nil then
				arg_187_1.var_.characterEffect1085ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1085ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1085ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1085ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1085ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0
			local var_190_7 = 0.575

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_8 = arg_187_1:FormatText(StoryNameCfg[7].name)

				arg_187_1.leftNameTxt_.text = var_190_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_9 = arg_187_1:GetWordFromCfg(420051045)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 23
				local var_190_12 = utf8.len(var_190_10)
				local var_190_13 = var_190_11 <= 0 and var_190_7 or var_190_7 * (var_190_12 / var_190_11)

				if var_190_13 > 0 and var_190_7 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_14 and arg_187_1.time_ < var_190_6 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play420051046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 420051046
		arg_191_1.duration_ = 10

		local var_191_0 = {
			zh = 9.833,
			ja = 10
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play420051047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1085ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1085ui_story == nil then
				arg_191_1.var_.characterEffect1085ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect1085ui_story and not isNil(var_194_0) then
					arg_191_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1085ui_story then
				arg_191_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_194_4 = 0

			if var_194_4 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_194_5 = 0
			local var_194_6 = 0.775

			if var_194_5 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_7 = arg_191_1:FormatText(StoryNameCfg[328].name)

				arg_191_1.leftNameTxt_.text = var_194_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:GetWordFromCfg(420051046)
				local var_194_9 = arg_191_1:FormatText(var_194_8.content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 31
				local var_194_11 = utf8.len(var_194_9)
				local var_194_12 = var_194_10 <= 0 and var_194_6 or var_194_6 * (var_194_11 / var_194_10)

				if var_194_12 > 0 and var_194_6 < var_194_12 then
					arg_191_1.talkMaxDuration = var_194_12

					if var_194_12 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051046", "story_v_out_420051.awb") ~= 0 then
					local var_194_13 = manager.audio:GetVoiceLength("story_v_out_420051", "420051046", "story_v_out_420051.awb") / 1000

					if var_194_13 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_5
					end

					if var_194_8.prefab_name ~= "" and arg_191_1.actors_[var_194_8.prefab_name] ~= nil then
						local var_194_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_8.prefab_name].transform, "story_v_out_420051", "420051046", "story_v_out_420051.awb")

						arg_191_1:RecordAudio("420051046", var_194_14)
						arg_191_1:RecordAudio("420051046", var_194_14)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_420051", "420051046", "story_v_out_420051.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_420051", "420051046", "story_v_out_420051.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_15 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_15 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_15

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_15 and arg_191_1.time_ < var_194_5 + var_194_15 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play420051047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 420051047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play420051048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1085ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1085ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, 100, 0)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1085ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, 100, 0)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = 0
			local var_198_10 = 0.075

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_11 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_12 = arg_195_1:GetWordFromCfg(420051047)
				local var_198_13 = arg_195_1:FormatText(var_198_12.content)

				arg_195_1.text_.text = var_198_13

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_14 = 3
				local var_198_15 = utf8.len(var_198_13)
				local var_198_16 = var_198_14 <= 0 and var_198_10 or var_198_10 * (var_198_15 / var_198_14)

				if var_198_16 > 0 and var_198_10 < var_198_16 then
					arg_195_1.talkMaxDuration = var_198_16

					if var_198_16 + var_198_9 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_16 + var_198_9
					end
				end

				arg_195_1.text_.text = var_198_13
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_17 = math.max(var_198_10, arg_195_1.talkMaxDuration)

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_17 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_9) / var_198_17

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_9 + var_198_17 and arg_195_1.time_ < var_198_9 + var_198_17 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play420051048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 420051048
		arg_199_1.duration_ = 5.73

		local var_199_0 = {
			zh = 5.666,
			ja = 5.733
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play420051049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["404001ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos404001ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0, -1.55, -5.5)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos404001ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["404001ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect404001ui_story == nil then
				arg_199_1.var_.characterEffect404001ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect404001ui_story and not isNil(var_202_9) then
					arg_199_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect404001ui_story then
				arg_199_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_202_15 = 0
			local var_202_16 = 0.525

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_17 = arg_199_1:FormatText(StoryNameCfg[668].name)

				arg_199_1.leftNameTxt_.text = var_202_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(420051048)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 21
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051048", "story_v_out_420051.awb") ~= 0 then
					local var_202_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051048", "story_v_out_420051.awb") / 1000

					if var_202_23 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_23 + var_202_15
					end

					if var_202_18.prefab_name ~= "" and arg_199_1.actors_[var_202_18.prefab_name] ~= nil then
						local var_202_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_18.prefab_name].transform, "story_v_out_420051", "420051048", "story_v_out_420051.awb")

						arg_199_1:RecordAudio("420051048", var_202_24)
						arg_199_1:RecordAudio("420051048", var_202_24)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_420051", "420051048", "story_v_out_420051.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_420051", "420051048", "story_v_out_420051.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_25 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_25 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_25

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_25 and arg_199_1.time_ < var_202_15 + var_202_25 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play420051049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 420051049
		arg_203_1.duration_ = 4.13

		local var_203_0 = {
			zh = 4.133,
			ja = 3.9
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play420051050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["404001ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos404001ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos404001ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["1085ui_story"].transform
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 then
				arg_203_1.var_.moveOldPos1085ui_story = var_206_9.localPosition
			end

			local var_206_11 = 0.001

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11
				local var_206_13 = Vector3.New(0.75, -1.01, -5.83)

				var_206_9.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1085ui_story, var_206_13, var_206_12)

				local var_206_14 = manager.ui.mainCamera.transform.position - var_206_9.position

				var_206_9.forward = Vector3.New(var_206_14.x, var_206_14.y, var_206_14.z)

				local var_206_15 = var_206_9.localEulerAngles

				var_206_15.z = 0
				var_206_15.x = 0
				var_206_9.localEulerAngles = var_206_15
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 then
				var_206_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_206_16 = manager.ui.mainCamera.transform.position - var_206_9.position

				var_206_9.forward = Vector3.New(var_206_16.x, var_206_16.y, var_206_16.z)

				local var_206_17 = var_206_9.localEulerAngles

				var_206_17.z = 0
				var_206_17.x = 0
				var_206_9.localEulerAngles = var_206_17
			end

			local var_206_18 = arg_203_1.actors_["1085ui_story"]
			local var_206_19 = 0

			if var_206_19 < arg_203_1.time_ and arg_203_1.time_ <= var_206_19 + arg_206_0 and not isNil(var_206_18) and arg_203_1.var_.characterEffect1085ui_story == nil then
				arg_203_1.var_.characterEffect1085ui_story = var_206_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_20 = 0.200000002980232

			if var_206_19 <= arg_203_1.time_ and arg_203_1.time_ < var_206_19 + var_206_20 and not isNil(var_206_18) then
				local var_206_21 = (arg_203_1.time_ - var_206_19) / var_206_20

				if arg_203_1.var_.characterEffect1085ui_story and not isNil(var_206_18) then
					arg_203_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_19 + var_206_20 and arg_203_1.time_ < var_206_19 + var_206_20 + arg_206_0 and not isNil(var_206_18) and arg_203_1.var_.characterEffect1085ui_story then
				arg_203_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_206_22 = arg_203_1.actors_["404001ui_story"]
			local var_206_23 = 0

			if var_206_23 < arg_203_1.time_ and arg_203_1.time_ <= var_206_23 + arg_206_0 and not isNil(var_206_22) and arg_203_1.var_.characterEffect404001ui_story == nil then
				arg_203_1.var_.characterEffect404001ui_story = var_206_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_24 = 0.200000002980232

			if var_206_23 <= arg_203_1.time_ and arg_203_1.time_ < var_206_23 + var_206_24 and not isNil(var_206_22) then
				local var_206_25 = (arg_203_1.time_ - var_206_23) / var_206_24

				if arg_203_1.var_.characterEffect404001ui_story and not isNil(var_206_22) then
					local var_206_26 = Mathf.Lerp(0, 0.5, var_206_25)

					arg_203_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_203_1.var_.characterEffect404001ui_story.fillRatio = var_206_26
				end
			end

			if arg_203_1.time_ >= var_206_23 + var_206_24 and arg_203_1.time_ < var_206_23 + var_206_24 + arg_206_0 and not isNil(var_206_22) and arg_203_1.var_.characterEffect404001ui_story then
				local var_206_27 = 0.5

				arg_203_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_203_1.var_.characterEffect404001ui_story.fillRatio = var_206_27
			end

			local var_206_28 = 0

			if var_206_28 < arg_203_1.time_ and arg_203_1.time_ <= var_206_28 + arg_206_0 then
				arg_203_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action447")
			end

			local var_206_29 = 0

			if var_206_29 < arg_203_1.time_ and arg_203_1.time_ <= var_206_29 + arg_206_0 then
				arg_203_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_206_30 = 0
			local var_206_31 = 0.25

			if var_206_30 < arg_203_1.time_ and arg_203_1.time_ <= var_206_30 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_32 = arg_203_1:FormatText(StoryNameCfg[328].name)

				arg_203_1.leftNameTxt_.text = var_206_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_33 = arg_203_1:GetWordFromCfg(420051049)
				local var_206_34 = arg_203_1:FormatText(var_206_33.content)

				arg_203_1.text_.text = var_206_34

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_35 = 10
				local var_206_36 = utf8.len(var_206_34)
				local var_206_37 = var_206_35 <= 0 and var_206_31 or var_206_31 * (var_206_36 / var_206_35)

				if var_206_37 > 0 and var_206_31 < var_206_37 then
					arg_203_1.talkMaxDuration = var_206_37

					if var_206_37 + var_206_30 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_37 + var_206_30
					end
				end

				arg_203_1.text_.text = var_206_34
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051049", "story_v_out_420051.awb") ~= 0 then
					local var_206_38 = manager.audio:GetVoiceLength("story_v_out_420051", "420051049", "story_v_out_420051.awb") / 1000

					if var_206_38 + var_206_30 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_38 + var_206_30
					end

					if var_206_33.prefab_name ~= "" and arg_203_1.actors_[var_206_33.prefab_name] ~= nil then
						local var_206_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_33.prefab_name].transform, "story_v_out_420051", "420051049", "story_v_out_420051.awb")

						arg_203_1:RecordAudio("420051049", var_206_39)
						arg_203_1:RecordAudio("420051049", var_206_39)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_420051", "420051049", "story_v_out_420051.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_420051", "420051049", "story_v_out_420051.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_40 = math.max(var_206_31, arg_203_1.talkMaxDuration)

			if var_206_30 <= arg_203_1.time_ and arg_203_1.time_ < var_206_30 + var_206_40 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_30) / var_206_40

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_30 + var_206_40 and arg_203_1.time_ < var_206_30 + var_206_40 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play420051050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 420051050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play420051051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["404001ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos404001ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0, 100, 0)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos404001ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, 100, 0)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["1085ui_story"].transform
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1.var_.moveOldPos1085ui_story = var_210_9.localPosition
			end

			local var_210_11 = 0.001

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11
				local var_210_13 = Vector3.New(0, 100, 0)

				var_210_9.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1085ui_story, var_210_13, var_210_12)

				local var_210_14 = manager.ui.mainCamera.transform.position - var_210_9.position

				var_210_9.forward = Vector3.New(var_210_14.x, var_210_14.y, var_210_14.z)

				local var_210_15 = var_210_9.localEulerAngles

				var_210_15.z = 0
				var_210_15.x = 0
				var_210_9.localEulerAngles = var_210_15
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 then
				var_210_9.localPosition = Vector3.New(0, 100, 0)

				local var_210_16 = manager.ui.mainCamera.transform.position - var_210_9.position

				var_210_9.forward = Vector3.New(var_210_16.x, var_210_16.y, var_210_16.z)

				local var_210_17 = var_210_9.localEulerAngles

				var_210_17.z = 0
				var_210_17.x = 0
				var_210_9.localEulerAngles = var_210_17
			end

			local var_210_18 = 0.05
			local var_210_19 = 1

			if var_210_18 < arg_207_1.time_ and arg_207_1.time_ <= var_210_18 + arg_210_0 then
				local var_210_20 = "play"
				local var_210_21 = "effect"

				arg_207_1:AudioAction(var_210_20, var_210_21, "se_story_140", "se_story_140_camera03", "")
			end

			local var_210_22 = 0
			local var_210_23 = 0.9

			if var_210_22 < arg_207_1.time_ and arg_207_1.time_ <= var_210_22 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_24 = arg_207_1:GetWordFromCfg(420051050)
				local var_210_25 = arg_207_1:FormatText(var_210_24.content)

				arg_207_1.text_.text = var_210_25

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_26 = 36
				local var_210_27 = utf8.len(var_210_25)
				local var_210_28 = var_210_26 <= 0 and var_210_23 or var_210_23 * (var_210_27 / var_210_26)

				if var_210_28 > 0 and var_210_23 < var_210_28 then
					arg_207_1.talkMaxDuration = var_210_28

					if var_210_28 + var_210_22 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_28 + var_210_22
					end
				end

				arg_207_1.text_.text = var_210_25
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_29 = math.max(var_210_23, arg_207_1.talkMaxDuration)

			if var_210_22 <= arg_207_1.time_ and arg_207_1.time_ < var_210_22 + var_210_29 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_22) / var_210_29

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_22 + var_210_29 and arg_207_1.time_ < var_210_22 + var_210_29 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play420051051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 420051051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play420051052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 1.3

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(420051051)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 52
				local var_214_5 = utf8.len(var_214_3)
				local var_214_6 = var_214_4 <= 0 and var_214_1 or var_214_1 * (var_214_5 / var_214_4)

				if var_214_6 > 0 and var_214_1 < var_214_6 then
					arg_211_1.talkMaxDuration = var_214_6

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_7 and arg_211_1.time_ < var_214_0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play420051052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 420051052
		arg_215_1.duration_ = 4.97

		local var_215_0 = {
			zh = 4.266,
			ja = 4.966
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play420051053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1085ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos1085ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, -1.01, -5.83)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1085ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["1085ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1085ui_story == nil then
				arg_215_1.var_.characterEffect1085ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect1085ui_story and not isNil(var_218_9) then
					arg_215_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1085ui_story then
				arg_215_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_218_13 = 0

			if var_218_13 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 then
				arg_215_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_1")
			end

			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_218_15 = 0
			local var_218_16 = 0.35

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[328].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(420051052)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 14
				local var_218_21 = utf8.len(var_218_19)
				local var_218_22 = var_218_20 <= 0 and var_218_16 or var_218_16 * (var_218_21 / var_218_20)

				if var_218_22 > 0 and var_218_16 < var_218_22 then
					arg_215_1.talkMaxDuration = var_218_22

					if var_218_22 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_22 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_19
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051052", "story_v_out_420051.awb") ~= 0 then
					local var_218_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051052", "story_v_out_420051.awb") / 1000

					if var_218_23 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_23 + var_218_15
					end

					if var_218_18.prefab_name ~= "" and arg_215_1.actors_[var_218_18.prefab_name] ~= nil then
						local var_218_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_18.prefab_name].transform, "story_v_out_420051", "420051052", "story_v_out_420051.awb")

						arg_215_1:RecordAudio("420051052", var_218_24)
						arg_215_1:RecordAudio("420051052", var_218_24)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_420051", "420051052", "story_v_out_420051.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_420051", "420051052", "story_v_out_420051.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_25 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_25 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_15) / var_218_25

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_15 + var_218_25 and arg_215_1.time_ < var_218_15 + var_218_25 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play420051053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 420051053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play420051054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = "STblack"

			if arg_219_1.bgs_[var_222_0] == nil then
				local var_222_1 = Object.Instantiate(arg_219_1.paintGo_)

				var_222_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_222_0)
				var_222_1.name = var_222_0
				var_222_1.transform.parent = arg_219_1.stage_.transform
				var_222_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.bgs_[var_222_0] = var_222_1
			end

			local var_222_2 = 2

			if var_222_2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				local var_222_3 = manager.ui.mainCamera.transform.localPosition
				local var_222_4 = Vector3.New(0, 0, 10) + Vector3.New(var_222_3.x, var_222_3.y, 0)
				local var_222_5 = arg_219_1.bgs_.STblack

				var_222_5.transform.localPosition = var_222_4
				var_222_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_6 = var_222_5:GetComponent("SpriteRenderer")

				if var_222_6 and var_222_6.sprite then
					local var_222_7 = (var_222_5.transform.localPosition - var_222_3).z
					local var_222_8 = manager.ui.mainCameraCom_
					local var_222_9 = 2 * var_222_7 * Mathf.Tan(var_222_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_222_10 = var_222_9 * var_222_8.aspect
					local var_222_11 = var_222_6.sprite.bounds.size.x
					local var_222_12 = var_222_6.sprite.bounds.size.y
					local var_222_13 = var_222_10 / var_222_11
					local var_222_14 = var_222_9 / var_222_12
					local var_222_15 = var_222_14 < var_222_13 and var_222_13 or var_222_14

					var_222_5.transform.localScale = Vector3.New(var_222_15, var_222_15, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "STblack" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_16 = 0

			if var_222_16 < arg_219_1.time_ and arg_219_1.time_ <= var_222_16 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_17 = 2

			if var_222_16 <= arg_219_1.time_ and arg_219_1.time_ < var_222_16 + var_222_17 then
				local var_222_18 = (arg_219_1.time_ - var_222_16) / var_222_17
				local var_222_19 = Color.New(0, 0, 0)

				var_222_19.a = Mathf.Lerp(0, 1, var_222_18)
				arg_219_1.mask_.color = var_222_19
			end

			if arg_219_1.time_ >= var_222_16 + var_222_17 and arg_219_1.time_ < var_222_16 + var_222_17 + arg_222_0 then
				local var_222_20 = Color.New(0, 0, 0)

				var_222_20.a = 1
				arg_219_1.mask_.color = var_222_20
			end

			local var_222_21 = 2

			if var_222_21 < arg_219_1.time_ and arg_219_1.time_ <= var_222_21 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_22 = 2

			if var_222_21 <= arg_219_1.time_ and arg_219_1.time_ < var_222_21 + var_222_22 then
				local var_222_23 = (arg_219_1.time_ - var_222_21) / var_222_22
				local var_222_24 = Color.New(0, 0, 0)

				var_222_24.a = Mathf.Lerp(1, 0, var_222_23)
				arg_219_1.mask_.color = var_222_24
			end

			if arg_219_1.time_ >= var_222_21 + var_222_22 and arg_219_1.time_ < var_222_21 + var_222_22 + arg_222_0 then
				local var_222_25 = Color.New(0, 0, 0)
				local var_222_26 = 0

				arg_219_1.mask_.enabled = false
				var_222_25.a = var_222_26
				arg_219_1.mask_.color = var_222_25
			end

			local var_222_27 = arg_219_1.actors_["1085ui_story"].transform
			local var_222_28 = 2

			if var_222_28 < arg_219_1.time_ and arg_219_1.time_ <= var_222_28 + arg_222_0 then
				arg_219_1.var_.moveOldPos1085ui_story = var_222_27.localPosition
			end

			local var_222_29 = 0.001

			if var_222_28 <= arg_219_1.time_ and arg_219_1.time_ < var_222_28 + var_222_29 then
				local var_222_30 = (arg_219_1.time_ - var_222_28) / var_222_29
				local var_222_31 = Vector3.New(0, 100, 0)

				var_222_27.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1085ui_story, var_222_31, var_222_30)

				local var_222_32 = manager.ui.mainCamera.transform.position - var_222_27.position

				var_222_27.forward = Vector3.New(var_222_32.x, var_222_32.y, var_222_32.z)

				local var_222_33 = var_222_27.localEulerAngles

				var_222_33.z = 0
				var_222_33.x = 0
				var_222_27.localEulerAngles = var_222_33
			end

			if arg_219_1.time_ >= var_222_28 + var_222_29 and arg_219_1.time_ < var_222_28 + var_222_29 + arg_222_0 then
				var_222_27.localPosition = Vector3.New(0, 100, 0)

				local var_222_34 = manager.ui.mainCamera.transform.position - var_222_27.position

				var_222_27.forward = Vector3.New(var_222_34.x, var_222_34.y, var_222_34.z)

				local var_222_35 = var_222_27.localEulerAngles

				var_222_35.z = 0
				var_222_35.x = 0
				var_222_27.localEulerAngles = var_222_35
			end

			local var_222_36 = 4
			local var_222_37 = 1

			if var_222_36 < arg_219_1.time_ and arg_219_1.time_ <= var_222_36 + arg_222_0 then
				local var_222_38 = "play"
				local var_222_39 = "effect"

				arg_219_1:AudioAction(var_222_38, var_222_39, "se_story_140", "se_story_140_car_hit", "")
			end

			local var_222_40 = 0
			local var_222_41 = 0.2

			if var_222_40 < arg_219_1.time_ and arg_219_1.time_ <= var_222_40 + arg_222_0 then
				local var_222_42 = "play"
				local var_222_43 = "music"

				arg_219_1:AudioAction(var_222_42, var_222_43, "ui_battle", "ui_battle_stopbgm", "")

				local var_222_44 = ""
				local var_222_45 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_222_45 ~= "" then
					if arg_219_1.bgmTxt_.text ~= var_222_45 and arg_219_1.bgmTxt_.text ~= "" then
						if arg_219_1.bgmTxt2_.text ~= "" then
							arg_219_1.bgmTxt_.text = arg_219_1.bgmTxt2_.text
						end

						arg_219_1.bgmTxt2_.text = var_222_45

						arg_219_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_219_1.bgmTxt_.text = var_222_45
						arg_219_1.bgmTxt2_.text = var_222_45
					end

					if arg_219_1.bgmTimer then
						arg_219_1.bgmTimer:Stop()

						arg_219_1.bgmTimer = nil
					end

					if arg_219_1.settingData.show_music_name == 1 then
						arg_219_1.musicController:SetSelectedState("show")
						arg_219_1.musicAnimator_:Play("open", 0, 0)

						if arg_219_1.settingData.music_time ~= 0 then
							arg_219_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_219_1.settingData.music_time), function()
								if arg_219_1 == nil or isNil(arg_219_1.bgmTxt_) then
									return
								end

								arg_219_1.musicController:SetSelectedState("hide")
								arg_219_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_222_46 = 0.466666666666667
			local var_222_47 = 1

			if var_222_46 < arg_219_1.time_ and arg_219_1.time_ <= var_222_46 + arg_222_0 then
				local var_222_48 = "play"
				local var_222_49 = "music"

				arg_219_1:AudioAction(var_222_48, var_222_49, "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_222_50 = ""
				local var_222_51 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if var_222_51 ~= "" then
					if arg_219_1.bgmTxt_.text ~= var_222_51 and arg_219_1.bgmTxt_.text ~= "" then
						if arg_219_1.bgmTxt2_.text ~= "" then
							arg_219_1.bgmTxt_.text = arg_219_1.bgmTxt2_.text
						end

						arg_219_1.bgmTxt2_.text = var_222_51

						arg_219_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_219_1.bgmTxt_.text = var_222_51
						arg_219_1.bgmTxt2_.text = var_222_51
					end

					if arg_219_1.bgmTimer then
						arg_219_1.bgmTimer:Stop()

						arg_219_1.bgmTimer = nil
					end

					if arg_219_1.settingData.show_music_name == 1 then
						arg_219_1.musicController:SetSelectedState("show")
						arg_219_1.musicAnimator_:Play("open", 0, 0)

						if arg_219_1.settingData.music_time ~= 0 then
							arg_219_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_219_1.settingData.music_time), function()
								if arg_219_1 == nil or isNil(arg_219_1.bgmTxt_) then
									return
								end

								arg_219_1.musicController:SetSelectedState("hide")
								arg_219_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_222_52 = 2

			if var_222_52 < arg_219_1.time_ and arg_219_1.time_ <= var_222_52 + arg_222_0 then
				arg_219_1.fswbg_:SetActive(true)
				arg_219_1.dialog_:SetActive(false)

				arg_219_1.fswtw_.percent = 0

				local var_222_53 = arg_219_1:GetWordFromCfg(420051053)
				local var_222_54 = arg_219_1:FormatText(var_222_53.content)

				arg_219_1.fswt_.text = var_222_54

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.fswt_)

				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_219_1.fswtw_:SetDirty()

				arg_219_1.typewritterCharCountI18N = 0

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_55 = 2.73333333333333

			if var_222_55 < arg_219_1.time_ and arg_219_1.time_ <= var_222_55 + arg_222_0 then
				arg_219_1.var_.oldValueTypewriter = arg_219_1.fswtw_.percent

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_56 = 10
			local var_222_57 = 0.666666666666667
			local var_222_58 = arg_219_1:GetWordFromCfg(420051053)
			local var_222_59 = arg_219_1:FormatText(var_222_58.content)
			local var_222_60, var_222_61 = arg_219_1:GetPercentByPara(var_222_59, 1)

			if var_222_55 < arg_219_1.time_ and arg_219_1.time_ <= var_222_55 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				local var_222_62 = var_222_56 <= 0 and var_222_57 or var_222_57 * ((var_222_61 - arg_219_1.typewritterCharCountI18N) / var_222_56)

				if var_222_62 > 0 and var_222_57 < var_222_62 then
					arg_219_1.talkMaxDuration = var_222_62

					if var_222_62 + var_222_55 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_62 + var_222_55
					end
				end
			end

			local var_222_63 = 0.666666666666667
			local var_222_64 = math.max(var_222_63, arg_219_1.talkMaxDuration)

			if var_222_55 <= arg_219_1.time_ and arg_219_1.time_ < var_222_55 + var_222_64 then
				local var_222_65 = (arg_219_1.time_ - var_222_55) / var_222_64

				arg_219_1.fswtw_.percent = Mathf.Lerp(arg_219_1.var_.oldValueTypewriter, var_222_60, var_222_65)
				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.fswtw_:SetDirty()
			end

			if arg_219_1.time_ >= var_222_55 + var_222_64 and arg_219_1.time_ < var_222_55 + var_222_64 + arg_222_0 then
				arg_219_1.fswtw_.percent = var_222_60

				arg_219_1.fswtw_:SetDirty()
				arg_219_1:ShowNextGo(true)

				arg_219_1.typewritterCharCountI18N = var_222_61
			end

			local var_222_66 = 2

			if var_222_66 < arg_219_1.time_ and arg_219_1.time_ <= var_222_66 + arg_222_0 then
				local var_222_67 = arg_219_1.fswbg_.transform:Find("textbox/adapt/content") or arg_219_1.fswbg_.transform:Find("textbox/content")
				local var_222_68 = arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_222_69 = var_222_67:GetComponent("Text")
				local var_222_70 = var_222_67:GetComponent("RectTransform")

				var_222_69.alignment = UnityEngine.TextAnchor.UpperLeft
				var_222_70.offsetMin = Vector2.New(0, 0)
				var_222_70.offsetMax = Vector2.New(0, -150)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play420051054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 420051054
		arg_225_1.duration_ = 1.47

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play420051055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.var_.oldValueTypewriter = arg_225_1.fswtw_.percent

				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_225_1:ShowNextGo(false)
			end

			local var_228_1 = 22
			local var_228_2 = 1.46666666666667
			local var_228_3 = arg_225_1:GetWordFromCfg(420051053)
			local var_228_4 = arg_225_1:FormatText(var_228_3.content)
			local var_228_5, var_228_6 = arg_225_1:GetPercentByPara(var_228_4, 2)

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				local var_228_7 = var_228_1 <= 0 and var_228_2 or var_228_2 * ((var_228_6 - arg_225_1.typewritterCharCountI18N) / var_228_1)

				if var_228_7 > 0 and var_228_2 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end
			end

			local var_228_8 = 1.46666666666667
			local var_228_9 = math.max(var_228_8, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_9 then
				local var_228_10 = (arg_225_1.time_ - var_228_0) / var_228_9

				arg_225_1.fswtw_.percent = Mathf.Lerp(arg_225_1.var_.oldValueTypewriter, var_228_5, var_228_10)
				arg_225_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_225_1.fswtw_:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_9 and arg_225_1.time_ < var_228_0 + var_228_9 + arg_228_0 then
				arg_225_1.fswtw_.percent = var_228_5

				arg_225_1.fswtw_:SetDirty()
				arg_225_1:ShowNextGo(true)

				arg_225_1.typewritterCharCountI18N = var_228_6
			end

			local var_228_11 = 0.05
			local var_228_12 = 1

			if var_228_11 < arg_225_1.time_ and arg_225_1.time_ <= var_228_11 + arg_228_0 then
				local var_228_13 = "play"
				local var_228_14 = "effect"

				arg_225_1:AudioAction(var_228_13, var_228_14, "se_story_140", "se_story_140_car01", "")
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play420051055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 420051055
		arg_229_1.duration_ = 1.2

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play420051056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.var_.oldValueTypewriter = arg_229_1.fswtw_.percent

				SetActive(arg_229_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_229_1:ShowNextGo(false)
			end

			local var_232_1 = 18
			local var_232_2 = 1.2
			local var_232_3 = arg_229_1:GetWordFromCfg(420051053)
			local var_232_4 = arg_229_1:FormatText(var_232_3.content)
			local var_232_5, var_232_6 = arg_229_1:GetPercentByPara(var_232_4, 3)

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				local var_232_7 = var_232_1 <= 0 and var_232_2 or var_232_2 * ((var_232_6 - arg_229_1.typewritterCharCountI18N) / var_232_1)

				if var_232_7 > 0 and var_232_2 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end
			end

			local var_232_8 = 1.2
			local var_232_9 = math.max(var_232_8, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_9 then
				local var_232_10 = (arg_229_1.time_ - var_232_0) / var_232_9

				arg_229_1.fswtw_.percent = Mathf.Lerp(arg_229_1.var_.oldValueTypewriter, var_232_5, var_232_10)
				arg_229_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_229_1.fswtw_:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_9 and arg_229_1.time_ < var_232_0 + var_232_9 + arg_232_0 then
				arg_229_1.fswtw_.percent = var_232_5

				arg_229_1.fswtw_:SetDirty()
				arg_229_1:ShowNextGo(true)

				arg_229_1.typewritterCharCountI18N = var_232_6
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play420051056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 420051056
		arg_233_1.duration_ = 1.05

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play420051057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.var_.oldValueTypewriter = arg_233_1.fswtw_.percent

				SetActive(arg_233_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_233_1:ShowNextGo(false)
			end

			local var_236_1 = 10
			local var_236_2 = 0.666666666666667
			local var_236_3 = arg_233_1:GetWordFromCfg(420051053)
			local var_236_4 = arg_233_1:FormatText(var_236_3.content)
			local var_236_5, var_236_6 = arg_233_1:GetPercentByPara(var_236_4, 4)

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				local var_236_7 = var_236_1 <= 0 and var_236_2 or var_236_2 * ((var_236_6 - arg_233_1.typewritterCharCountI18N) / var_236_1)

				if var_236_7 > 0 and var_236_2 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end
			end

			local var_236_8 = 0.666666666666667
			local var_236_9 = math.max(var_236_8, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_9 then
				local var_236_10 = (arg_233_1.time_ - var_236_0) / var_236_9

				arg_233_1.fswtw_.percent = Mathf.Lerp(arg_233_1.var_.oldValueTypewriter, var_236_5, var_236_10)
				arg_233_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_233_1.fswtw_:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_9 and arg_233_1.time_ < var_236_0 + var_236_9 + arg_236_0 then
				arg_233_1.fswtw_.percent = var_236_5

				arg_233_1.fswtw_:SetDirty()
				arg_233_1:ShowNextGo(true)

				arg_233_1.typewritterCharCountI18N = var_236_6
			end

			local var_236_11 = 0.05
			local var_236_12 = 1

			if var_236_11 < arg_233_1.time_ and arg_233_1.time_ <= var_236_11 + arg_236_0 then
				local var_236_13 = "play"
				local var_236_14 = "effect"

				arg_233_1:AudioAction(var_236_13, var_236_14, "se_story_1311", "se_story_1311_truck06", "")
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play420051057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 420051057
		arg_237_1.duration_ = 7

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play420051058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.fswbg_:SetActive(false)
				arg_237_1.dialog_:SetActive(false)
				SetActive(arg_237_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_237_1:ShowNextGo(false)
			end

			local var_240_1 = "L16f"

			if arg_237_1.bgs_[var_240_1] == nil then
				local var_240_2 = Object.Instantiate(arg_237_1.paintGo_)

				var_240_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_240_1)
				var_240_2.name = var_240_1
				var_240_2.transform.parent = arg_237_1.stage_.transform
				var_240_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.bgs_[var_240_1] = var_240_2
			end

			local var_240_3 = 0

			if var_240_3 < arg_237_1.time_ and arg_237_1.time_ <= var_240_3 + arg_240_0 then
				local var_240_4 = manager.ui.mainCamera.transform.localPosition
				local var_240_5 = Vector3.New(0, 0, 10) + Vector3.New(var_240_4.x, var_240_4.y, 0)
				local var_240_6 = arg_237_1.bgs_.L16f

				var_240_6.transform.localPosition = var_240_5
				var_240_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_240_7 = var_240_6:GetComponent("SpriteRenderer")

				if var_240_7 and var_240_7.sprite then
					local var_240_8 = (var_240_6.transform.localPosition - var_240_4).z
					local var_240_9 = manager.ui.mainCameraCom_
					local var_240_10 = 2 * var_240_8 * Mathf.Tan(var_240_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_240_11 = var_240_10 * var_240_9.aspect
					local var_240_12 = var_240_7.sprite.bounds.size.x
					local var_240_13 = var_240_7.sprite.bounds.size.y
					local var_240_14 = var_240_11 / var_240_12
					local var_240_15 = var_240_10 / var_240_13
					local var_240_16 = var_240_15 < var_240_14 and var_240_14 or var_240_15

					var_240_6.transform.localScale = Vector3.New(var_240_16, var_240_16, 0)
				end

				for iter_240_0, iter_240_1 in pairs(arg_237_1.bgs_) do
					if iter_240_0 ~= "L16f" then
						iter_240_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_240_17 = 0

			if var_240_17 < arg_237_1.time_ and arg_237_1.time_ <= var_240_17 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = false

				arg_237_1:SetGaussion(false)
			end

			local var_240_18 = 2

			if var_240_17 <= arg_237_1.time_ and arg_237_1.time_ < var_240_17 + var_240_18 then
				local var_240_19 = (arg_237_1.time_ - var_240_17) / var_240_18
				local var_240_20 = Color.New(0, 0, 0)

				var_240_20.a = Mathf.Lerp(1, 0, var_240_19)
				arg_237_1.mask_.color = var_240_20
			end

			if arg_237_1.time_ >= var_240_17 + var_240_18 and arg_237_1.time_ < var_240_17 + var_240_18 + arg_240_0 then
				local var_240_21 = Color.New(0, 0, 0)
				local var_240_22 = 0

				arg_237_1.mask_.enabled = false
				var_240_21.a = var_240_22
				arg_237_1.mask_.color = var_240_21
			end

			if arg_237_1.frameCnt_ <= 1 then
				arg_237_1.dialog_:SetActive(false)
			end

			local var_240_23 = 2
			local var_240_24 = 0.125

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_25 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_25:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_237_1.dialogCg_.alpha = arg_241_0
				end))
				var_240_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_26 = arg_237_1:GetWordFromCfg(420051057)
				local var_240_27 = arg_237_1:FormatText(var_240_26.content)

				arg_237_1.text_.text = var_240_27

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_28 = 5
				local var_240_29 = utf8.len(var_240_27)
				local var_240_30 = var_240_28 <= 0 and var_240_24 or var_240_24 * (var_240_29 / var_240_28)

				if var_240_30 > 0 and var_240_24 < var_240_30 then
					arg_237_1.talkMaxDuration = var_240_30
					var_240_23 = var_240_23 + 0.3

					if var_240_30 + var_240_23 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_30 + var_240_23
					end
				end

				arg_237_1.text_.text = var_240_27
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_31 = var_240_23 + 0.3
			local var_240_32 = math.max(var_240_24, arg_237_1.talkMaxDuration)

			if var_240_31 <= arg_237_1.time_ and arg_237_1.time_ < var_240_31 + var_240_32 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_31) / var_240_32

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_31 + var_240_32 and arg_237_1.time_ < var_240_31 + var_240_32 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play420051058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 420051058
		arg_243_1.duration_ = 4.13

		local var_243_0 = {
			zh = 4.133,
			ja = 4.066
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play420051059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1085ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1085ui_story = var_246_0.localPosition
			end

			local var_246_2 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2
				local var_246_4 = Vector3.New(0, -1.01, -5.83)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1085ui_story, var_246_4, var_246_3)

				local var_246_5 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_5.x, var_246_5.y, var_246_5.z)

				local var_246_6 = var_246_0.localEulerAngles

				var_246_6.z = 0
				var_246_6.x = 0
				var_246_0.localEulerAngles = var_246_6
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_246_7 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_7.x, var_246_7.y, var_246_7.z)

				local var_246_8 = var_246_0.localEulerAngles

				var_246_8.z = 0
				var_246_8.x = 0
				var_246_0.localEulerAngles = var_246_8
			end

			local var_246_9 = arg_243_1.actors_["1085ui_story"]
			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1085ui_story == nil then
				arg_243_1.var_.characterEffect1085ui_story = var_246_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_11 = 0.200000002980232

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_11 and not isNil(var_246_9) then
				local var_246_12 = (arg_243_1.time_ - var_246_10) / var_246_11

				if arg_243_1.var_.characterEffect1085ui_story and not isNil(var_246_9) then
					arg_243_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_10 + var_246_11 and arg_243_1.time_ < var_246_10 + var_246_11 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1085ui_story then
				arg_243_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_246_13 = 0

			if var_246_13 < arg_243_1.time_ and arg_243_1.time_ <= var_246_13 + arg_246_0 then
				arg_243_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_246_14 = 0

			if var_246_14 < arg_243_1.time_ and arg_243_1.time_ <= var_246_14 + arg_246_0 then
				arg_243_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_246_15 = 0
			local var_246_16 = 0.35

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_17 = arg_243_1:FormatText(StoryNameCfg[328].name)

				arg_243_1.leftNameTxt_.text = var_246_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_18 = arg_243_1:GetWordFromCfg(420051058)
				local var_246_19 = arg_243_1:FormatText(var_246_18.content)

				arg_243_1.text_.text = var_246_19

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_20 = 14
				local var_246_21 = utf8.len(var_246_19)
				local var_246_22 = var_246_20 <= 0 and var_246_16 or var_246_16 * (var_246_21 / var_246_20)

				if var_246_22 > 0 and var_246_16 < var_246_22 then
					arg_243_1.talkMaxDuration = var_246_22

					if var_246_22 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_22 + var_246_15
					end
				end

				arg_243_1.text_.text = var_246_19
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051058", "story_v_out_420051.awb") ~= 0 then
					local var_246_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051058", "story_v_out_420051.awb") / 1000

					if var_246_23 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_23 + var_246_15
					end

					if var_246_18.prefab_name ~= "" and arg_243_1.actors_[var_246_18.prefab_name] ~= nil then
						local var_246_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_18.prefab_name].transform, "story_v_out_420051", "420051058", "story_v_out_420051.awb")

						arg_243_1:RecordAudio("420051058", var_246_24)
						arg_243_1:RecordAudio("420051058", var_246_24)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_420051", "420051058", "story_v_out_420051.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_420051", "420051058", "story_v_out_420051.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_25 = math.max(var_246_16, arg_243_1.talkMaxDuration)

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_25 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_15) / var_246_25

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_15 + var_246_25 and arg_243_1.time_ < var_246_15 + var_246_25 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play420051059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 420051059
		arg_247_1.duration_ = 1

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"

			SetActive(arg_247_1.choicesGo_, true)

			for iter_248_0, iter_248_1 in ipairs(arg_247_1.choices_) do
				local var_248_0 = iter_248_0 <= 1

				SetActive(iter_248_1.go, var_248_0)
			end

			arg_247_1.choices_[1].txt.text = arg_247_1:FormatText(StoryChoiceCfg[1229].name)
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play420051060(arg_247_1)
			end

			arg_247_1:RecordChoiceLog(420051059, 1229)
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1085ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1085ui_story == nil then
				arg_247_1.var_.characterEffect1085ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1085ui_story and not isNil(var_250_0) then
					local var_250_4 = Mathf.Lerp(0, 0.5, var_250_3)

					arg_247_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1085ui_story.fillRatio = var_250_4
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1085ui_story then
				local var_250_5 = 0.5

				arg_247_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1085ui_story.fillRatio = var_250_5
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play420051060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 420051060
		arg_251_1.duration_ = 4.37

		local var_251_0 = {
			zh = 4.366,
			ja = 4.3
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
				arg_251_0:Play420051061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.3

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[1160].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:GetWordFromCfg(420051060)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 12
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051060", "story_v_out_420051.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051060", "story_v_out_420051.awb") / 1000

					if var_254_8 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_0
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_420051", "420051060", "story_v_out_420051.awb")

						arg_251_1:RecordAudio("420051060", var_254_9)
						arg_251_1:RecordAudio("420051060", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_420051", "420051060", "story_v_out_420051.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_420051", "420051060", "story_v_out_420051.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_10 and arg_251_1.time_ < var_254_0 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play420051061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 420051061
		arg_255_1.duration_ = 4.9

		local var_255_0 = {
			zh = 4.9,
			ja = 4.5
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play420051062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1085ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1085ui_story == nil then
				arg_255_1.var_.characterEffect1085ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect1085ui_story and not isNil(var_258_0) then
					arg_255_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1085ui_story then
				arg_255_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_258_4 = 0
			local var_258_5 = 0.35

			if var_258_4 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_6 = arg_255_1:FormatText(StoryNameCfg[328].name)

				arg_255_1.leftNameTxt_.text = var_258_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_7 = arg_255_1:GetWordFromCfg(420051061)
				local var_258_8 = arg_255_1:FormatText(var_258_7.content)

				arg_255_1.text_.text = var_258_8

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_9 = 14
				local var_258_10 = utf8.len(var_258_8)
				local var_258_11 = var_258_9 <= 0 and var_258_5 or var_258_5 * (var_258_10 / var_258_9)

				if var_258_11 > 0 and var_258_5 < var_258_11 then
					arg_255_1.talkMaxDuration = var_258_11

					if var_258_11 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_4
					end
				end

				arg_255_1.text_.text = var_258_8
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051061", "story_v_out_420051.awb") ~= 0 then
					local var_258_12 = manager.audio:GetVoiceLength("story_v_out_420051", "420051061", "story_v_out_420051.awb") / 1000

					if var_258_12 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_12 + var_258_4
					end

					if var_258_7.prefab_name ~= "" and arg_255_1.actors_[var_258_7.prefab_name] ~= nil then
						local var_258_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_7.prefab_name].transform, "story_v_out_420051", "420051061", "story_v_out_420051.awb")

						arg_255_1:RecordAudio("420051061", var_258_13)
						arg_255_1:RecordAudio("420051061", var_258_13)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_420051", "420051061", "story_v_out_420051.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_420051", "420051061", "story_v_out_420051.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_14 = math.max(var_258_5, arg_255_1.talkMaxDuration)

			if var_258_4 <= arg_255_1.time_ and arg_255_1.time_ < var_258_4 + var_258_14 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_4) / var_258_14

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_4 + var_258_14 and arg_255_1.time_ < var_258_4 + var_258_14 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play420051062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 420051062
		arg_259_1.duration_ = 5.5

		local var_259_0 = {
			zh = 5.5,
			ja = 4.3
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
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play420051063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 0.4

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_2 = arg_259_1:FormatText(StoryNameCfg[328].name)

				arg_259_1.leftNameTxt_.text = var_262_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_3 = arg_259_1:GetWordFromCfg(420051062)
				local var_262_4 = arg_259_1:FormatText(var_262_3.content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 16
				local var_262_6 = utf8.len(var_262_4)
				local var_262_7 = var_262_5 <= 0 and var_262_1 or var_262_1 * (var_262_6 / var_262_5)

				if var_262_7 > 0 and var_262_1 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051062", "story_v_out_420051.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051062", "story_v_out_420051.awb") / 1000

					if var_262_8 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_0
					end

					if var_262_3.prefab_name ~= "" and arg_259_1.actors_[var_262_3.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_3.prefab_name].transform, "story_v_out_420051", "420051062", "story_v_out_420051.awb")

						arg_259_1:RecordAudio("420051062", var_262_9)
						arg_259_1:RecordAudio("420051062", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_420051", "420051062", "story_v_out_420051.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_420051", "420051062", "story_v_out_420051.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_10 and arg_259_1.time_ < var_262_0 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play420051063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 420051063
		arg_263_1.duration_ = 7.43

		local var_263_0 = {
			zh = 5.633,
			ja = 7.433
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play420051064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1085ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1085ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(0, 100, 0)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1085ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, 100, 0)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = 0
			local var_266_10 = 0.65

			if var_266_9 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_11 = arg_263_1:FormatText(StoryNameCfg[1160].name)

				arg_263_1.leftNameTxt_.text = var_266_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_12 = arg_263_1:GetWordFromCfg(420051063)
				local var_266_13 = arg_263_1:FormatText(var_266_12.content)

				arg_263_1.text_.text = var_266_13

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_14 = 26
				local var_266_15 = utf8.len(var_266_13)
				local var_266_16 = var_266_14 <= 0 and var_266_10 or var_266_10 * (var_266_15 / var_266_14)

				if var_266_16 > 0 and var_266_10 < var_266_16 then
					arg_263_1.talkMaxDuration = var_266_16

					if var_266_16 + var_266_9 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_16 + var_266_9
					end
				end

				arg_263_1.text_.text = var_266_13
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051063", "story_v_out_420051.awb") ~= 0 then
					local var_266_17 = manager.audio:GetVoiceLength("story_v_out_420051", "420051063", "story_v_out_420051.awb") / 1000

					if var_266_17 + var_266_9 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_17 + var_266_9
					end

					if var_266_12.prefab_name ~= "" and arg_263_1.actors_[var_266_12.prefab_name] ~= nil then
						local var_266_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_12.prefab_name].transform, "story_v_out_420051", "420051063", "story_v_out_420051.awb")

						arg_263_1:RecordAudio("420051063", var_266_18)
						arg_263_1:RecordAudio("420051063", var_266_18)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_420051", "420051063", "story_v_out_420051.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_420051", "420051063", "story_v_out_420051.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_19 = math.max(var_266_10, arg_263_1.talkMaxDuration)

			if var_266_9 <= arg_263_1.time_ and arg_263_1.time_ < var_266_9 + var_266_19 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_9) / var_266_19

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_9 + var_266_19 and arg_263_1.time_ < var_266_9 + var_266_19 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play420051064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 420051064
		arg_267_1.duration_ = 8.47

		local var_267_0 = {
			zh = 7.565999999999,
			ja = 8.465999999999
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play420051065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = "L16i"

			if arg_267_1.bgs_[var_270_0] == nil then
				local var_270_1 = Object.Instantiate(arg_267_1.paintGo_)

				var_270_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_270_0)
				var_270_1.name = var_270_0
				var_270_1.transform.parent = arg_267_1.stage_.transform
				var_270_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.bgs_[var_270_0] = var_270_1
			end

			local var_270_2 = 1.999999999999

			if var_270_2 < arg_267_1.time_ and arg_267_1.time_ <= var_270_2 + arg_270_0 then
				local var_270_3 = manager.ui.mainCamera.transform.localPosition
				local var_270_4 = Vector3.New(0, 0, 10) + Vector3.New(var_270_3.x, var_270_3.y, 0)
				local var_270_5 = arg_267_1.bgs_.L16i

				var_270_5.transform.localPosition = var_270_4
				var_270_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_270_6 = var_270_5:GetComponent("SpriteRenderer")

				if var_270_6 and var_270_6.sprite then
					local var_270_7 = (var_270_5.transform.localPosition - var_270_3).z
					local var_270_8 = manager.ui.mainCameraCom_
					local var_270_9 = 2 * var_270_7 * Mathf.Tan(var_270_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_270_10 = var_270_9 * var_270_8.aspect
					local var_270_11 = var_270_6.sprite.bounds.size.x
					local var_270_12 = var_270_6.sprite.bounds.size.y
					local var_270_13 = var_270_10 / var_270_11
					local var_270_14 = var_270_9 / var_270_12
					local var_270_15 = var_270_14 < var_270_13 and var_270_13 or var_270_14

					var_270_5.transform.localScale = Vector3.New(var_270_15, var_270_15, 0)
				end

				for iter_270_0, iter_270_1 in pairs(arg_267_1.bgs_) do
					if iter_270_0 ~= "L16i" then
						iter_270_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_270_16 = 3.999999999999

			if var_270_16 < arg_267_1.time_ and arg_267_1.time_ <= var_270_16 + arg_270_0 then
				arg_267_1.allBtn_.enabled = false
			end

			local var_270_17 = 0.3

			if arg_267_1.time_ >= var_270_16 + var_270_17 and arg_267_1.time_ < var_270_16 + var_270_17 + arg_270_0 then
				arg_267_1.allBtn_.enabled = true
			end

			local var_270_18 = 0

			if var_270_18 < arg_267_1.time_ and arg_267_1.time_ <= var_270_18 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_19 = 2

			if var_270_18 <= arg_267_1.time_ and arg_267_1.time_ < var_270_18 + var_270_19 then
				local var_270_20 = (arg_267_1.time_ - var_270_18) / var_270_19
				local var_270_21 = Color.New(0, 0, 0)

				var_270_21.a = Mathf.Lerp(0, 1, var_270_20)
				arg_267_1.mask_.color = var_270_21
			end

			if arg_267_1.time_ >= var_270_18 + var_270_19 and arg_267_1.time_ < var_270_18 + var_270_19 + arg_270_0 then
				local var_270_22 = Color.New(0, 0, 0)

				var_270_22.a = 1
				arg_267_1.mask_.color = var_270_22
			end

			local var_270_23 = 2

			if var_270_23 < arg_267_1.time_ and arg_267_1.time_ <= var_270_23 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_24 = 2

			if var_270_23 <= arg_267_1.time_ and arg_267_1.time_ < var_270_23 + var_270_24 then
				local var_270_25 = (arg_267_1.time_ - var_270_23) / var_270_24
				local var_270_26 = Color.New(0, 0, 0)

				var_270_26.a = Mathf.Lerp(1, 0, var_270_25)
				arg_267_1.mask_.color = var_270_26
			end

			if arg_267_1.time_ >= var_270_23 + var_270_24 and arg_267_1.time_ < var_270_23 + var_270_24 + arg_270_0 then
				local var_270_27 = Color.New(0, 0, 0)
				local var_270_28 = 0

				arg_267_1.mask_.enabled = false
				var_270_27.a = var_270_28
				arg_267_1.mask_.color = var_270_27
			end

			local var_270_29 = 1.6
			local var_270_30 = 1

			if var_270_29 < arg_267_1.time_ and arg_267_1.time_ <= var_270_29 + arg_270_0 then
				local var_270_31 = "play"
				local var_270_32 = "effect"

				arg_267_1:AudioAction(var_270_31, var_270_32, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_270_33 = 3.56666666666667
			local var_270_34 = 1

			if var_270_33 < arg_267_1.time_ and arg_267_1.time_ <= var_270_33 + arg_270_0 then
				local var_270_35 = "play"
				local var_270_36 = "effect"

				arg_267_1:AudioAction(var_270_35, var_270_36, "se_story_140", "se_story_140_electric02", "")
			end

			if arg_267_1.frameCnt_ <= 1 then
				arg_267_1.dialog_:SetActive(false)
			end

			local var_270_37 = 3.999999999999
			local var_270_38 = 0.4

			if var_270_37 < arg_267_1.time_ and arg_267_1.time_ <= var_270_37 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0

				arg_267_1.dialog_:SetActive(true)

				arg_267_1.dialogCg_.alpha = 0

				local var_270_39 = LeanTween.value(arg_267_1.dialog_, 0, 1, 0.3)

				var_270_39:setOnUpdate(LuaHelper.FloatAction(function(arg_271_0)
					arg_267_1.dialogCg_.alpha = arg_271_0
				end))
				var_270_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_267_1.dialog_)
					var_270_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_267_1.duration_ = arg_267_1.duration_ + 0.3

				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_40 = arg_267_1:FormatText(StoryNameCfg[605].name)

				arg_267_1.leftNameTxt_.text = var_270_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056_split_2")

				arg_267_1.callingController_:SetSelectedState("calling")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_41 = arg_267_1:GetWordFromCfg(420051064)
				local var_270_42 = arg_267_1:FormatText(var_270_41.content)

				arg_267_1.text_.text = var_270_42

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_43 = 16
				local var_270_44 = utf8.len(var_270_42)
				local var_270_45 = var_270_43 <= 0 and var_270_38 or var_270_38 * (var_270_44 / var_270_43)

				if var_270_45 > 0 and var_270_38 < var_270_45 then
					arg_267_1.talkMaxDuration = var_270_45
					var_270_37 = var_270_37 + 0.3

					if var_270_45 + var_270_37 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_45 + var_270_37
					end
				end

				arg_267_1.text_.text = var_270_42
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051064", "story_v_out_420051.awb") ~= 0 then
					local var_270_46 = manager.audio:GetVoiceLength("story_v_out_420051", "420051064", "story_v_out_420051.awb") / 1000

					if var_270_46 + var_270_37 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_46 + var_270_37
					end

					if var_270_41.prefab_name ~= "" and arg_267_1.actors_[var_270_41.prefab_name] ~= nil then
						local var_270_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_41.prefab_name].transform, "story_v_out_420051", "420051064", "story_v_out_420051.awb")

						arg_267_1:RecordAudio("420051064", var_270_47)
						arg_267_1:RecordAudio("420051064", var_270_47)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_420051", "420051064", "story_v_out_420051.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_420051", "420051064", "story_v_out_420051.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_48 = var_270_37 + 0.3
			local var_270_49 = math.max(var_270_38, arg_267_1.talkMaxDuration)

			if var_270_48 <= arg_267_1.time_ and arg_267_1.time_ < var_270_48 + var_270_49 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_48) / var_270_49

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_48 + var_270_49 and arg_267_1.time_ < var_270_48 + var_270_49 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play420051065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 420051065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play420051066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = "1056ui_story"

			if arg_273_1.actors_[var_276_0] == nil then
				local var_276_1 = Asset.Load("Char/" .. "1056ui_story")

				if not isNil(var_276_1) then
					local var_276_2 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_273_1.stage_.transform)

					var_276_2.name = var_276_0
					var_276_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_273_1.actors_[var_276_0] = var_276_2

					local var_276_3 = var_276_2:GetComponentInChildren(typeof(CharacterEffect))

					var_276_3.enabled = true

					local var_276_4 = GameObjectTools.GetOrAddComponent(var_276_2, typeof(DynamicBoneHelper))

					if var_276_4 then
						var_276_4:EnableDynamicBone(false)
					end

					arg_273_1:ShowWeapon(var_276_3.transform, false)

					arg_273_1.var_[var_276_0 .. "Animator"] = var_276_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_273_1.var_[var_276_0 .. "Animator"].applyRootMotion = true
					arg_273_1.var_[var_276_0 .. "LipSync"] = var_276_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_276_5 = arg_273_1.actors_["1056ui_story"].transform
			local var_276_6 = 0

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.var_.moveOldPos1056ui_story = var_276_5.localPosition
			end

			local var_276_7 = 0.001

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_7 then
				local var_276_8 = (arg_273_1.time_ - var_276_6) / var_276_7
				local var_276_9 = Vector3.New(0, 100, 0)

				var_276_5.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1056ui_story, var_276_9, var_276_8)

				local var_276_10 = manager.ui.mainCamera.transform.position - var_276_5.position

				var_276_5.forward = Vector3.New(var_276_10.x, var_276_10.y, var_276_10.z)

				local var_276_11 = var_276_5.localEulerAngles

				var_276_11.z = 0
				var_276_11.x = 0
				var_276_5.localEulerAngles = var_276_11
			end

			if arg_273_1.time_ >= var_276_6 + var_276_7 and arg_273_1.time_ < var_276_6 + var_276_7 + arg_276_0 then
				var_276_5.localPosition = Vector3.New(0, 100, 0)

				local var_276_12 = manager.ui.mainCamera.transform.position - var_276_5.position

				var_276_5.forward = Vector3.New(var_276_12.x, var_276_12.y, var_276_12.z)

				local var_276_13 = var_276_5.localEulerAngles

				var_276_13.z = 0
				var_276_13.x = 0
				var_276_5.localEulerAngles = var_276_13
			end

			local var_276_14 = 0
			local var_276_15 = 1.05

			if var_276_14 < arg_273_1.time_ and arg_273_1.time_ <= var_276_14 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_16 = arg_273_1:GetWordFromCfg(420051065)
				local var_276_17 = arg_273_1:FormatText(var_276_16.content)

				arg_273_1.text_.text = var_276_17

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_18 = 42
				local var_276_19 = utf8.len(var_276_17)
				local var_276_20 = var_276_18 <= 0 and var_276_15 or var_276_15 * (var_276_19 / var_276_18)

				if var_276_20 > 0 and var_276_15 < var_276_20 then
					arg_273_1.talkMaxDuration = var_276_20

					if var_276_20 + var_276_14 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_20 + var_276_14
					end
				end

				arg_273_1.text_.text = var_276_17
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_21 = math.max(var_276_15, arg_273_1.talkMaxDuration)

			if var_276_14 <= arg_273_1.time_ and arg_273_1.time_ < var_276_14 + var_276_21 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_14) / var_276_21

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_14 + var_276_21 and arg_273_1.time_ < var_276_14 + var_276_21 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play420051066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 420051066
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play420051067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 1.275

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_2 = arg_277_1:GetWordFromCfg(420051066)
				local var_280_3 = arg_277_1:FormatText(var_280_2.content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 51
				local var_280_5 = utf8.len(var_280_3)
				local var_280_6 = var_280_4 <= 0 and var_280_1 or var_280_1 * (var_280_5 / var_280_4)

				if var_280_6 > 0 and var_280_1 < var_280_6 then
					arg_277_1.talkMaxDuration = var_280_6

					if var_280_6 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_6 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_7 and arg_277_1.time_ < var_280_0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play420051067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 420051067
		arg_281_1.duration_ = 2.3

		local var_281_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_281_0:Play420051068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1085ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1085ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0, -1.01, -5.83)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1085ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = arg_281_1.actors_["1085ui_story"]
			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect1085ui_story == nil then
				arg_281_1.var_.characterEffect1085ui_story = var_284_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_11 = 0.200000002980232

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_11 and not isNil(var_284_9) then
				local var_284_12 = (arg_281_1.time_ - var_284_10) / var_284_11

				if arg_281_1.var_.characterEffect1085ui_story and not isNil(var_284_9) then
					arg_281_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_10 + var_284_11 and arg_281_1.time_ < var_284_10 + var_284_11 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect1085ui_story then
				arg_281_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_284_13 = 0

			if var_284_13 < arg_281_1.time_ and arg_281_1.time_ <= var_284_13 + arg_284_0 then
				arg_281_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_1")
			end

			local var_284_14 = 0

			if var_284_14 < arg_281_1.time_ and arg_281_1.time_ <= var_284_14 + arg_284_0 then
				arg_281_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_284_15 = 0
			local var_284_16 = 0.125

			if var_284_15 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_17 = arg_281_1:FormatText(StoryNameCfg[328].name)

				arg_281_1.leftNameTxt_.text = var_284_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_18 = arg_281_1:GetWordFromCfg(420051067)
				local var_284_19 = arg_281_1:FormatText(var_284_18.content)

				arg_281_1.text_.text = var_284_19

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_20 = 5
				local var_284_21 = utf8.len(var_284_19)
				local var_284_22 = var_284_20 <= 0 and var_284_16 or var_284_16 * (var_284_21 / var_284_20)

				if var_284_22 > 0 and var_284_16 < var_284_22 then
					arg_281_1.talkMaxDuration = var_284_22

					if var_284_22 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_22 + var_284_15
					end
				end

				arg_281_1.text_.text = var_284_19
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051067", "story_v_out_420051.awb") ~= 0 then
					local var_284_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051067", "story_v_out_420051.awb") / 1000

					if var_284_23 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_23 + var_284_15
					end

					if var_284_18.prefab_name ~= "" and arg_281_1.actors_[var_284_18.prefab_name] ~= nil then
						local var_284_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_18.prefab_name].transform, "story_v_out_420051", "420051067", "story_v_out_420051.awb")

						arg_281_1:RecordAudio("420051067", var_284_24)
						arg_281_1:RecordAudio("420051067", var_284_24)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_420051", "420051067", "story_v_out_420051.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_420051", "420051067", "story_v_out_420051.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_25 = math.max(var_284_16, arg_281_1.talkMaxDuration)

			if var_284_15 <= arg_281_1.time_ and arg_281_1.time_ < var_284_15 + var_284_25 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_15) / var_284_25

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_15 + var_284_25 and arg_281_1.time_ < var_284_15 + var_284_25 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420051068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 420051068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play420051069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1085ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1085ui_story == nil then
				arg_285_1.var_.characterEffect1085ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect1085ui_story and not isNil(var_288_0) then
					local var_288_4 = Mathf.Lerp(0, 0.5, var_288_3)

					arg_285_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1085ui_story.fillRatio = var_288_4
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1085ui_story then
				local var_288_5 = 0.5

				arg_285_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1085ui_story.fillRatio = var_288_5
			end

			local var_288_6 = 0
			local var_288_7 = 0.45

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_8 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_9 = arg_285_1:GetWordFromCfg(420051068)
				local var_288_10 = arg_285_1:FormatText(var_288_9.content)

				arg_285_1.text_.text = var_288_10

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_11 = 18
				local var_288_12 = utf8.len(var_288_10)
				local var_288_13 = var_288_11 <= 0 and var_288_7 or var_288_7 * (var_288_12 / var_288_11)

				if var_288_13 > 0 and var_288_7 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_6
					end
				end

				arg_285_1.text_.text = var_288_10
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_14 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_14 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_14

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_14 and arg_285_1.time_ < var_288_6 + var_288_14 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play420051069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 420051069
		arg_289_1.duration_ = 3.37

		local var_289_0 = {
			zh = 3.066,
			ja = 3.366
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
				arg_289_0:Play420051070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1085ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1085ui_story == nil then
				arg_289_1.var_.characterEffect1085ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1085ui_story and not isNil(var_292_0) then
					arg_289_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1085ui_story then
				arg_289_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_292_4 = 0

			if var_292_4 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_2")
			end

			local var_292_5 = 0

			if var_292_5 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_292_6 = 0
			local var_292_7 = 0.25

			if var_292_6 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_8 = arg_289_1:FormatText(StoryNameCfg[328].name)

				arg_289_1.leftNameTxt_.text = var_292_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_9 = arg_289_1:GetWordFromCfg(420051069)
				local var_292_10 = arg_289_1:FormatText(var_292_9.content)

				arg_289_1.text_.text = var_292_10

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_11 = 10
				local var_292_12 = utf8.len(var_292_10)
				local var_292_13 = var_292_11 <= 0 and var_292_7 or var_292_7 * (var_292_12 / var_292_11)

				if var_292_13 > 0 and var_292_7 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_6
					end
				end

				arg_289_1.text_.text = var_292_10
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051069", "story_v_out_420051.awb") ~= 0 then
					local var_292_14 = manager.audio:GetVoiceLength("story_v_out_420051", "420051069", "story_v_out_420051.awb") / 1000

					if var_292_14 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_6
					end

					if var_292_9.prefab_name ~= "" and arg_289_1.actors_[var_292_9.prefab_name] ~= nil then
						local var_292_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_9.prefab_name].transform, "story_v_out_420051", "420051069", "story_v_out_420051.awb")

						arg_289_1:RecordAudio("420051069", var_292_15)
						arg_289_1:RecordAudio("420051069", var_292_15)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_420051", "420051069", "story_v_out_420051.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_420051", "420051069", "story_v_out_420051.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_16 = math.max(var_292_7, arg_289_1.talkMaxDuration)

			if var_292_6 <= arg_289_1.time_ and arg_289_1.time_ < var_292_6 + var_292_16 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_6) / var_292_16

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_6 + var_292_16 and arg_289_1.time_ < var_292_6 + var_292_16 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play420051070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 420051070
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play420051071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1085ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos1085ui_story = var_296_0.localPosition
			end

			local var_296_2 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2
				local var_296_4 = Vector3.New(0, 100, 0)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1085ui_story, var_296_4, var_296_3)

				local var_296_5 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_5.x, var_296_5.y, var_296_5.z)

				local var_296_6 = var_296_0.localEulerAngles

				var_296_6.z = 0
				var_296_6.x = 0
				var_296_0.localEulerAngles = var_296_6
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(0, 100, 0)

				local var_296_7 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_7.x, var_296_7.y, var_296_7.z)

				local var_296_8 = var_296_0.localEulerAngles

				var_296_8.z = 0
				var_296_8.x = 0
				var_296_0.localEulerAngles = var_296_8
			end

			local var_296_9 = 0
			local var_296_10 = 0.55

			if var_296_9 < arg_293_1.time_ and arg_293_1.time_ <= var_296_9 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_11 = arg_293_1:FormatText(StoryNameCfg[7].name)

				arg_293_1.leftNameTxt_.text = var_296_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_12 = arg_293_1:GetWordFromCfg(420051070)
				local var_296_13 = arg_293_1:FormatText(var_296_12.content)

				arg_293_1.text_.text = var_296_13

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_14 = 22
				local var_296_15 = utf8.len(var_296_13)
				local var_296_16 = var_296_14 <= 0 and var_296_10 or var_296_10 * (var_296_15 / var_296_14)

				if var_296_16 > 0 and var_296_10 < var_296_16 then
					arg_293_1.talkMaxDuration = var_296_16

					if var_296_16 + var_296_9 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_16 + var_296_9
					end
				end

				arg_293_1.text_.text = var_296_13
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_17 = math.max(var_296_10, arg_293_1.talkMaxDuration)

			if var_296_9 <= arg_293_1.time_ and arg_293_1.time_ < var_296_9 + var_296_17 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_9) / var_296_17

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_9 + var_296_17 and arg_293_1.time_ < var_296_9 + var_296_17 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420051071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 420051071
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play420051072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 1.05

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[7].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:GetWordFromCfg(420051071)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 42
				local var_300_6 = utf8.len(var_300_4)
				local var_300_7 = var_300_5 <= 0 and var_300_1 or var_300_1 * (var_300_6 / var_300_5)

				if var_300_7 > 0 and var_300_1 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_8 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_8 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_8

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_8 and arg_297_1.time_ < var_300_0 + var_300_8 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play420051072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 420051072
		arg_301_1.duration_ = 5.77

		local var_301_0 = {
			zh = 5.766,
			ja = 4.2
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
				arg_301_0:Play420051073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1085ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1085ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0, -1.01, -5.83)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1085ui_story, var_304_4, var_304_3)

				local var_304_5 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_5.x, var_304_5.y, var_304_5.z)

				local var_304_6 = var_304_0.localEulerAngles

				var_304_6.z = 0
				var_304_6.x = 0
				var_304_0.localEulerAngles = var_304_6
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_304_7 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_7.x, var_304_7.y, var_304_7.z)

				local var_304_8 = var_304_0.localEulerAngles

				var_304_8.z = 0
				var_304_8.x = 0
				var_304_0.localEulerAngles = var_304_8
			end

			local var_304_9 = arg_301_1.actors_["1085ui_story"]
			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1085ui_story == nil then
				arg_301_1.var_.characterEffect1085ui_story = var_304_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_11 = 0.200000002980232

			if var_304_10 <= arg_301_1.time_ and arg_301_1.time_ < var_304_10 + var_304_11 and not isNil(var_304_9) then
				local var_304_12 = (arg_301_1.time_ - var_304_10) / var_304_11

				if arg_301_1.var_.characterEffect1085ui_story and not isNil(var_304_9) then
					arg_301_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_10 + var_304_11 and arg_301_1.time_ < var_304_10 + var_304_11 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1085ui_story then
				arg_301_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_304_13 = 0

			if var_304_13 < arg_301_1.time_ and arg_301_1.time_ <= var_304_13 + arg_304_0 then
				arg_301_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_304_14 = 0
			local var_304_15 = 0.375

			if var_304_14 < arg_301_1.time_ and arg_301_1.time_ <= var_304_14 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_16 = arg_301_1:FormatText(StoryNameCfg[328].name)

				arg_301_1.leftNameTxt_.text = var_304_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_17 = arg_301_1:GetWordFromCfg(420051072)
				local var_304_18 = arg_301_1:FormatText(var_304_17.content)

				arg_301_1.text_.text = var_304_18

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_19 = 15
				local var_304_20 = utf8.len(var_304_18)
				local var_304_21 = var_304_19 <= 0 and var_304_15 or var_304_15 * (var_304_20 / var_304_19)

				if var_304_21 > 0 and var_304_15 < var_304_21 then
					arg_301_1.talkMaxDuration = var_304_21

					if var_304_21 + var_304_14 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_21 + var_304_14
					end
				end

				arg_301_1.text_.text = var_304_18
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051072", "story_v_out_420051.awb") ~= 0 then
					local var_304_22 = manager.audio:GetVoiceLength("story_v_out_420051", "420051072", "story_v_out_420051.awb") / 1000

					if var_304_22 + var_304_14 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_22 + var_304_14
					end

					if var_304_17.prefab_name ~= "" and arg_301_1.actors_[var_304_17.prefab_name] ~= nil then
						local var_304_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_17.prefab_name].transform, "story_v_out_420051", "420051072", "story_v_out_420051.awb")

						arg_301_1:RecordAudio("420051072", var_304_23)
						arg_301_1:RecordAudio("420051072", var_304_23)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_420051", "420051072", "story_v_out_420051.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_420051", "420051072", "story_v_out_420051.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_24 = math.max(var_304_15, arg_301_1.talkMaxDuration)

			if var_304_14 <= arg_301_1.time_ and arg_301_1.time_ < var_304_14 + var_304_24 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_14) / var_304_24

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_14 + var_304_24 and arg_301_1.time_ < var_304_14 + var_304_24 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420051073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 420051073
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play420051074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1085ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1085ui_story == nil then
				arg_305_1.var_.characterEffect1085ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1085ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1085ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1085ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1085ui_story.fillRatio = var_308_5
			end

			local var_308_6 = 0
			local var_308_7 = 0.075

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

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_9 = arg_305_1:GetWordFromCfg(420051073)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 3
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
	Play420051074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 420051074
		arg_309_1.duration_ = 12.6

		local var_309_0 = {
			zh = 12.6,
			ja = 11.9
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play420051075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1085ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1085ui_story == nil then
				arg_309_1.var_.characterEffect1085ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1085ui_story and not isNil(var_312_0) then
					arg_309_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1085ui_story then
				arg_309_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_312_4 = 0

			if var_312_4 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_312_5 = 0
			local var_312_6 = 0.85

			if var_312_5 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_7 = arg_309_1:FormatText(StoryNameCfg[328].name)

				arg_309_1.leftNameTxt_.text = var_312_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_8 = arg_309_1:GetWordFromCfg(420051074)
				local var_312_9 = arg_309_1:FormatText(var_312_8.content)

				arg_309_1.text_.text = var_312_9

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_10 = 34
				local var_312_11 = utf8.len(var_312_9)
				local var_312_12 = var_312_10 <= 0 and var_312_6 or var_312_6 * (var_312_11 / var_312_10)

				if var_312_12 > 0 and var_312_6 < var_312_12 then
					arg_309_1.talkMaxDuration = var_312_12

					if var_312_12 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_12 + var_312_5
					end
				end

				arg_309_1.text_.text = var_312_9
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051074", "story_v_out_420051.awb") ~= 0 then
					local var_312_13 = manager.audio:GetVoiceLength("story_v_out_420051", "420051074", "story_v_out_420051.awb") / 1000

					if var_312_13 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_5
					end

					if var_312_8.prefab_name ~= "" and arg_309_1.actors_[var_312_8.prefab_name] ~= nil then
						local var_312_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_8.prefab_name].transform, "story_v_out_420051", "420051074", "story_v_out_420051.awb")

						arg_309_1:RecordAudio("420051074", var_312_14)
						arg_309_1:RecordAudio("420051074", var_312_14)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_420051", "420051074", "story_v_out_420051.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_420051", "420051074", "story_v_out_420051.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_15 = math.max(var_312_6, arg_309_1.talkMaxDuration)

			if var_312_5 <= arg_309_1.time_ and arg_309_1.time_ < var_312_5 + var_312_15 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_5) / var_312_15

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_5 + var_312_15 and arg_309_1.time_ < var_312_5 + var_312_15 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play420051075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 420051075
		arg_313_1.duration_ = 8.83

		local var_313_0 = {
			zh = 6.766,
			ja = 8.833
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play420051076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.6

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[328].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:GetWordFromCfg(420051075)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 24
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051075", "story_v_out_420051.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051075", "story_v_out_420051.awb") / 1000

					if var_316_8 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_0
					end

					if var_316_3.prefab_name ~= "" and arg_313_1.actors_[var_316_3.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_3.prefab_name].transform, "story_v_out_420051", "420051075", "story_v_out_420051.awb")

						arg_313_1:RecordAudio("420051075", var_316_9)
						arg_313_1:RecordAudio("420051075", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_420051", "420051075", "story_v_out_420051.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_420051", "420051075", "story_v_out_420051.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_10 and arg_313_1.time_ < var_316_0 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play420051076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 420051076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play420051077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1085ui_story"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos1085ui_story = var_320_0.localPosition
			end

			local var_320_2 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2
				local var_320_4 = Vector3.New(0, 100, 0)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1085ui_story, var_320_4, var_320_3)

				local var_320_5 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_5.x, var_320_5.y, var_320_5.z)

				local var_320_6 = var_320_0.localEulerAngles

				var_320_6.z = 0
				var_320_6.x = 0
				var_320_0.localEulerAngles = var_320_6
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0, 100, 0)

				local var_320_7 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_7.x, var_320_7.y, var_320_7.z)

				local var_320_8 = var_320_0.localEulerAngles

				var_320_8.z = 0
				var_320_8.x = 0
				var_320_0.localEulerAngles = var_320_8
			end

			local var_320_9 = 0
			local var_320_10 = 0.9

			if var_320_9 < arg_317_1.time_ and arg_317_1.time_ <= var_320_9 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_11 = arg_317_1:FormatText(StoryNameCfg[7].name)

				arg_317_1.leftNameTxt_.text = var_320_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_12 = arg_317_1:GetWordFromCfg(420051076)
				local var_320_13 = arg_317_1:FormatText(var_320_12.content)

				arg_317_1.text_.text = var_320_13

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_14 = 36
				local var_320_15 = utf8.len(var_320_13)
				local var_320_16 = var_320_14 <= 0 and var_320_10 or var_320_10 * (var_320_15 / var_320_14)

				if var_320_16 > 0 and var_320_10 < var_320_16 then
					arg_317_1.talkMaxDuration = var_320_16

					if var_320_16 + var_320_9 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_16 + var_320_9
					end
				end

				arg_317_1.text_.text = var_320_13
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_17 = math.max(var_320_10, arg_317_1.talkMaxDuration)

			if var_320_9 <= arg_317_1.time_ and arg_317_1.time_ < var_320_9 + var_320_17 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_9) / var_320_17

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_9 + var_320_17 and arg_317_1.time_ < var_320_9 + var_320_17 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420051077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 420051077
		arg_321_1.duration_ = 10.1

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play420051078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = "STwhite"

			if arg_321_1.bgs_[var_324_0] == nil then
				local var_324_1 = Object.Instantiate(arg_321_1.paintGo_)

				var_324_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_324_0)
				var_324_1.name = var_324_0
				var_324_1.transform.parent = arg_321_1.stage_.transform
				var_324_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_321_1.bgs_[var_324_0] = var_324_1
			end

			local var_324_2 = 1.06666666666667

			if var_324_2 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 then
				local var_324_3 = manager.ui.mainCamera.transform.localPosition
				local var_324_4 = Vector3.New(0, 0, 10) + Vector3.New(var_324_3.x, var_324_3.y, 0)
				local var_324_5 = arg_321_1.bgs_.STwhite

				var_324_5.transform.localPosition = var_324_4
				var_324_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_324_6 = var_324_5:GetComponent("SpriteRenderer")

				if var_324_6 and var_324_6.sprite then
					local var_324_7 = (var_324_5.transform.localPosition - var_324_3).z
					local var_324_8 = manager.ui.mainCameraCom_
					local var_324_9 = 2 * var_324_7 * Mathf.Tan(var_324_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_324_10 = var_324_9 * var_324_8.aspect
					local var_324_11 = var_324_6.sprite.bounds.size.x
					local var_324_12 = var_324_6.sprite.bounds.size.y
					local var_324_13 = var_324_10 / var_324_11
					local var_324_14 = var_324_9 / var_324_12
					local var_324_15 = var_324_14 < var_324_13 and var_324_13 or var_324_14

					var_324_5.transform.localScale = Vector3.New(var_324_15, var_324_15, 0)
				end

				for iter_324_0, iter_324_1 in pairs(arg_321_1.bgs_) do
					if iter_324_0 ~= "STwhite" then
						iter_324_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_324_16 = 3.06666666666667

			if var_324_16 < arg_321_1.time_ and arg_321_1.time_ <= var_324_16 + arg_324_0 then
				arg_321_1.allBtn_.enabled = false
			end

			local var_324_17 = 0.9

			if arg_321_1.time_ >= var_324_16 + var_324_17 and arg_321_1.time_ < var_324_16 + var_324_17 + arg_324_0 then
				arg_321_1.allBtn_.enabled = true
			end

			local var_324_18 = 0

			if var_324_18 < arg_321_1.time_ and arg_321_1.time_ <= var_324_18 + arg_324_0 then
				arg_321_1.mask_.enabled = true
				arg_321_1.mask_.raycastTarget = true

				arg_321_1:SetGaussion(false)
			end

			local var_324_19 = 1.06666666666667

			if var_324_18 <= arg_321_1.time_ and arg_321_1.time_ < var_324_18 + var_324_19 then
				local var_324_20 = (arg_321_1.time_ - var_324_18) / var_324_19
				local var_324_21 = Color.New(0, 0, 0)

				var_324_21.a = Mathf.Lerp(0, 1, var_324_20)
				arg_321_1.mask_.color = var_324_21
			end

			if arg_321_1.time_ >= var_324_18 + var_324_19 and arg_321_1.time_ < var_324_18 + var_324_19 + arg_324_0 then
				local var_324_22 = Color.New(0, 0, 0)

				var_324_22.a = 1
				arg_321_1.mask_.color = var_324_22
			end

			local var_324_23 = 1.06666666666667

			if var_324_23 < arg_321_1.time_ and arg_321_1.time_ <= var_324_23 + arg_324_0 then
				arg_321_1.mask_.enabled = true
				arg_321_1.mask_.raycastTarget = true

				arg_321_1:SetGaussion(false)
			end

			local var_324_24 = 2

			if var_324_23 <= arg_321_1.time_ and arg_321_1.time_ < var_324_23 + var_324_24 then
				local var_324_25 = (arg_321_1.time_ - var_324_23) / var_324_24
				local var_324_26 = Color.New(0, 0, 0)

				var_324_26.a = Mathf.Lerp(1, 0, var_324_25)
				arg_321_1.mask_.color = var_324_26
			end

			if arg_321_1.time_ >= var_324_23 + var_324_24 and arg_321_1.time_ < var_324_23 + var_324_24 + arg_324_0 then
				local var_324_27 = Color.New(0, 0, 0)
				local var_324_28 = 0

				arg_321_1.mask_.enabled = false
				var_324_27.a = var_324_28
				arg_321_1.mask_.color = var_324_27
			end

			local var_324_29 = 1.06666666666667

			if var_324_29 < arg_321_1.time_ and arg_321_1.time_ <= var_324_29 + arg_324_0 then
				arg_321_1.cswbg_:SetActive(true)

				local var_324_30 = arg_321_1.cswt_:GetComponent("RectTransform")

				arg_321_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_324_30.offsetMin = Vector2.New(0, 0)
				var_324_30.offsetMax = Vector2.New(0, 130)

				local var_324_31 = arg_321_1:GetWordFromCfg(419144)
				local var_324_32 = arg_321_1:FormatText(var_324_31.content)

				arg_321_1.cswt_.text = var_324_32

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.cswt_)

				arg_321_1.cswt_.fontSize = 120
				arg_321_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_321_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_321_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_324_33 = 1.06666666666667

			if var_324_33 < arg_321_1.time_ and arg_321_1.time_ <= var_324_33 + arg_324_0 then
				arg_321_1.fswbg_:SetActive(true)
				arg_321_1.dialog_:SetActive(false)

				arg_321_1.fswtw_.percent = 0

				local var_324_34 = arg_321_1:GetWordFromCfg(420051077)
				local var_324_35 = arg_321_1:FormatText(var_324_34.content)

				arg_321_1.fswt_.text = var_324_35

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.fswt_)

				arg_321_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_321_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_321_1.fswtw_:SetDirty()

				arg_321_1.typewritterCharCountI18N = 0

				SetActive(arg_321_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_321_1:ShowNextGo(false)
			end

			local var_324_36 = 3.06666666666667

			if var_324_36 < arg_321_1.time_ and arg_321_1.time_ <= var_324_36 + arg_324_0 then
				arg_321_1.var_.oldValueTypewriter = arg_321_1.fswtw_.percent

				SetActive(arg_321_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_321_1:ShowNextGo(false)
			end

			local var_324_37 = 26
			local var_324_38 = 1.73333333333333
			local var_324_39 = arg_321_1:GetWordFromCfg(420051077)
			local var_324_40 = arg_321_1:FormatText(var_324_39.content)
			local var_324_41, var_324_42 = arg_321_1:GetPercentByPara(var_324_40, 1)

			if var_324_36 < arg_321_1.time_ and arg_321_1.time_ <= var_324_36 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				local var_324_43 = var_324_37 <= 0 and var_324_38 or var_324_38 * ((var_324_42 - arg_321_1.typewritterCharCountI18N) / var_324_37)

				if var_324_43 > 0 and var_324_38 < var_324_43 then
					arg_321_1.talkMaxDuration = var_324_43

					if var_324_43 + var_324_36 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_43 + var_324_36
					end
				end
			end

			local var_324_44 = 1.73333333333333
			local var_324_45 = math.max(var_324_44, arg_321_1.talkMaxDuration)

			if var_324_36 <= arg_321_1.time_ and arg_321_1.time_ < var_324_36 + var_324_45 then
				local var_324_46 = (arg_321_1.time_ - var_324_36) / var_324_45

				arg_321_1.fswtw_.percent = Mathf.Lerp(arg_321_1.var_.oldValueTypewriter, var_324_41, var_324_46)
				arg_321_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_321_1.fswtw_:SetDirty()
			end

			if arg_321_1.time_ >= var_324_36 + var_324_45 and arg_321_1.time_ < var_324_36 + var_324_45 + arg_324_0 then
				arg_321_1.fswtw_.percent = var_324_41

				arg_321_1.fswtw_:SetDirty()
				arg_321_1:ShowNextGo(true)

				arg_321_1.typewritterCharCountI18N = var_324_42
			end

			local var_324_47 = 1.06666666666667
			local var_324_48 = 9.033
			local var_324_49 = manager.audio:GetVoiceLength("story_v_out_420051", "420051077", "story_v_out_420051.awb") / 1000

			if var_324_49 > 0 and var_324_48 < var_324_49 and var_324_49 + var_324_47 > arg_321_1.duration_ then
				local var_324_50 = var_324_49

				arg_321_1.duration_ = var_324_49 + var_324_47
			end

			if var_324_47 < arg_321_1.time_ and arg_321_1.time_ <= var_324_47 + arg_324_0 then
				local var_324_51 = "play"
				local var_324_52 = "voice"

				arg_321_1:AudioAction(var_324_51, var_324_52, "story_v_out_420051", "420051077", "story_v_out_420051.awb")
			end

			local var_324_53 = 1.06666666666667

			if var_324_53 < arg_321_1.time_ and arg_321_1.time_ <= var_324_53 + arg_324_0 then
				local var_324_54 = arg_321_1.fswbg_.transform:Find("textbox/adapt/content") or arg_321_1.fswbg_.transform:Find("textbox/content")
				local var_324_55 = arg_321_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_324_56 = var_324_54:GetComponent("Text")
				local var_324_57 = var_324_54:GetComponent("RectTransform")

				var_324_56.alignment = UnityEngine.TextAnchor.LowerCenter
				var_324_57.offsetMin = Vector2.New(0, -70)
				var_324_57.offsetMax = Vector2.New(0, 0)
			end

			local var_324_58 = 0
			local var_324_59 = 0.2

			if var_324_58 < arg_321_1.time_ and arg_321_1.time_ <= var_324_58 + arg_324_0 then
				local var_324_60 = "play"
				local var_324_61 = "music"

				arg_321_1:AudioAction(var_324_60, var_324_61, "ui_battle", "ui_battle_stopbgm", "")

				local var_324_62 = ""
				local var_324_63 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_324_63 ~= "" then
					if arg_321_1.bgmTxt_.text ~= var_324_63 and arg_321_1.bgmTxt_.text ~= "" then
						if arg_321_1.bgmTxt2_.text ~= "" then
							arg_321_1.bgmTxt_.text = arg_321_1.bgmTxt2_.text
						end

						arg_321_1.bgmTxt2_.text = var_324_63

						arg_321_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_321_1.bgmTxt_.text = var_324_63
						arg_321_1.bgmTxt2_.text = var_324_63
					end

					if arg_321_1.bgmTimer then
						arg_321_1.bgmTimer:Stop()

						arg_321_1.bgmTimer = nil
					end

					if arg_321_1.settingData.show_music_name == 1 then
						arg_321_1.musicController:SetSelectedState("show")
						arg_321_1.musicAnimator_:Play("open", 0, 0)

						if arg_321_1.settingData.music_time ~= 0 then
							arg_321_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_321_1.settingData.music_time), function()
								if arg_321_1 == nil or isNil(arg_321_1.bgmTxt_) then
									return
								end

								arg_321_1.musicController:SetSelectedState("hide")
								arg_321_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_324_64 = 0
			local var_324_65 = 1

			if var_324_64 < arg_321_1.time_ and arg_321_1.time_ <= var_324_64 + arg_324_0 then
				local var_324_66 = "stop"
				local var_324_67 = "effect"

				arg_321_1:AudioAction(var_324_66, var_324_67, "se_story_1310", "se_story_1310_nightloop", "")
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play420051078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 420051078
		arg_326_1.duration_ = 8.97

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play420051079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.fswbg_:SetActive(true)
				arg_326_1.dialog_:SetActive(false)

				arg_326_1.fswtw_.percent = 0

				local var_329_1 = arg_326_1:GetWordFromCfg(420051078)
				local var_329_2 = arg_326_1:FormatText(var_329_1.content)

				arg_326_1.fswt_.text = var_329_2

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.fswt_)

				arg_326_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_326_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_326_1.fswtw_:SetDirty()

				arg_326_1.typewritterCharCountI18N = 0

				SetActive(arg_326_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_326_1:ShowNextGo(false)
			end

			local var_329_3 = 0.0166666666666667

			if var_329_3 < arg_326_1.time_ and arg_326_1.time_ <= var_329_3 + arg_329_0 then
				arg_326_1.var_.oldValueTypewriter = arg_326_1.fswtw_.percent

				SetActive(arg_326_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_326_1:ShowNextGo(false)
			end

			local var_329_4 = 21
			local var_329_5 = 1.73333333333333
			local var_329_6 = arg_326_1:GetWordFromCfg(420051078)
			local var_329_7 = arg_326_1:FormatText(var_329_6.content)
			local var_329_8, var_329_9 = arg_326_1:GetPercentByPara(var_329_7, 1)

			if var_329_3 < arg_326_1.time_ and arg_326_1.time_ <= var_329_3 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0

				local var_329_10 = var_329_4 <= 0 and var_329_5 or var_329_5 * ((var_329_9 - arg_326_1.typewritterCharCountI18N) / var_329_4)

				if var_329_10 > 0 and var_329_5 < var_329_10 then
					arg_326_1.talkMaxDuration = var_329_10

					if var_329_10 + var_329_3 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_10 + var_329_3
					end
				end
			end

			local var_329_11 = 1.73333333333333
			local var_329_12 = math.max(var_329_11, arg_326_1.talkMaxDuration)

			if var_329_3 <= arg_326_1.time_ and arg_326_1.time_ < var_329_3 + var_329_12 then
				local var_329_13 = (arg_326_1.time_ - var_329_3) / var_329_12

				arg_326_1.fswtw_.percent = Mathf.Lerp(arg_326_1.var_.oldValueTypewriter, var_329_8, var_329_13)
				arg_326_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_326_1.fswtw_:SetDirty()
			end

			if arg_326_1.time_ >= var_329_3 + var_329_12 and arg_326_1.time_ < var_329_3 + var_329_12 + arg_329_0 then
				arg_326_1.fswtw_.percent = var_329_8

				arg_326_1.fswtw_:SetDirty()
				arg_326_1:ShowNextGo(true)

				arg_326_1.typewritterCharCountI18N = var_329_9
			end

			local var_329_14 = 0
			local var_329_15 = 8.966
			local var_329_16 = manager.audio:GetVoiceLength("story_v_out_420051", "420051078", "story_v_out_420051.awb") / 1000

			if var_329_16 > 0 and var_329_15 < var_329_16 and var_329_16 + var_329_14 > arg_326_1.duration_ then
				local var_329_17 = var_329_16

				arg_326_1.duration_ = var_329_16 + var_329_14
			end

			if var_329_14 < arg_326_1.time_ and arg_326_1.time_ <= var_329_14 + arg_329_0 then
				local var_329_18 = "play"
				local var_329_19 = "voice"

				arg_326_1:AudioAction(var_329_18, var_329_19, "story_v_out_420051", "420051078", "story_v_out_420051.awb")
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play420051079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 420051079
		arg_330_1.duration_ = 8.33

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play420051080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.fswbg_:SetActive(true)
				arg_330_1.dialog_:SetActive(false)

				arg_330_1.fswtw_.percent = 0

				local var_333_1 = arg_330_1:GetWordFromCfg(420051079)
				local var_333_2 = arg_330_1:FormatText(var_333_1.content)

				arg_330_1.fswt_.text = var_333_2

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.fswt_)

				arg_330_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_330_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_330_1.fswtw_:SetDirty()

				arg_330_1.typewritterCharCountI18N = 0

				SetActive(arg_330_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_330_1:ShowNextGo(false)
			end

			local var_333_3 = 0.0166666666666667

			if var_333_3 < arg_330_1.time_ and arg_330_1.time_ <= var_333_3 + arg_333_0 then
				arg_330_1.var_.oldValueTypewriter = arg_330_1.fswtw_.percent

				SetActive(arg_330_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_330_1:ShowNextGo(false)
			end

			local var_333_4 = 22
			local var_333_5 = 1.73333333333333
			local var_333_6 = arg_330_1:GetWordFromCfg(420051079)
			local var_333_7 = arg_330_1:FormatText(var_333_6.content)
			local var_333_8, var_333_9 = arg_330_1:GetPercentByPara(var_333_7, 1)

			if var_333_3 < arg_330_1.time_ and arg_330_1.time_ <= var_333_3 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0

				local var_333_10 = var_333_4 <= 0 and var_333_5 or var_333_5 * ((var_333_9 - arg_330_1.typewritterCharCountI18N) / var_333_4)

				if var_333_10 > 0 and var_333_5 < var_333_10 then
					arg_330_1.talkMaxDuration = var_333_10

					if var_333_10 + var_333_3 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_10 + var_333_3
					end
				end
			end

			local var_333_11 = 1.73333333333333
			local var_333_12 = math.max(var_333_11, arg_330_1.talkMaxDuration)

			if var_333_3 <= arg_330_1.time_ and arg_330_1.time_ < var_333_3 + var_333_12 then
				local var_333_13 = (arg_330_1.time_ - var_333_3) / var_333_12

				arg_330_1.fswtw_.percent = Mathf.Lerp(arg_330_1.var_.oldValueTypewriter, var_333_8, var_333_13)
				arg_330_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_330_1.fswtw_:SetDirty()
			end

			if arg_330_1.time_ >= var_333_3 + var_333_12 and arg_330_1.time_ < var_333_3 + var_333_12 + arg_333_0 then
				arg_330_1.fswtw_.percent = var_333_8

				arg_330_1.fswtw_:SetDirty()
				arg_330_1:ShowNextGo(true)

				arg_330_1.typewritterCharCountI18N = var_333_9
			end

			local var_333_14 = 0
			local var_333_15 = 8.066
			local var_333_16 = manager.audio:GetVoiceLength("story_v_out_420051", "420051079", "story_v_out_420051.awb") / 1000

			if var_333_16 > 0 and var_333_15 < var_333_16 and var_333_16 + var_333_14 > arg_330_1.duration_ then
				local var_333_17 = var_333_16

				arg_330_1.duration_ = var_333_16 + var_333_14
			end

			if var_333_14 < arg_330_1.time_ and arg_330_1.time_ <= var_333_14 + arg_333_0 then
				local var_333_18 = "play"
				local var_333_19 = "voice"

				arg_330_1:AudioAction(var_333_18, var_333_19, "story_v_out_420051", "420051079", "story_v_out_420051.awb")
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play420051080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 420051080
		arg_334_1.duration_ = 5.97

		local var_334_0 = {
			zh = 5.799999997019,
			ja = 5.966
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play420051081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = "ST67"

			if arg_334_1.bgs_[var_337_0] == nil then
				local var_337_1 = Object.Instantiate(arg_334_1.paintGo_)

				var_337_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_337_0)
				var_337_1.name = var_337_0
				var_337_1.transform.parent = arg_334_1.stage_.transform
				var_337_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.bgs_[var_337_0] = var_337_1
			end

			local var_337_2 = 2

			if var_337_2 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				local var_337_3 = manager.ui.mainCamera.transform.localPosition
				local var_337_4 = Vector3.New(0, 0, 10) + Vector3.New(var_337_3.x, var_337_3.y, 0)
				local var_337_5 = arg_334_1.bgs_.ST67

				var_337_5.transform.localPosition = var_337_4
				var_337_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_337_6 = var_337_5:GetComponent("SpriteRenderer")

				if var_337_6 and var_337_6.sprite then
					local var_337_7 = (var_337_5.transform.localPosition - var_337_3).z
					local var_337_8 = manager.ui.mainCameraCom_
					local var_337_9 = 2 * var_337_7 * Mathf.Tan(var_337_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_337_10 = var_337_9 * var_337_8.aspect
					local var_337_11 = var_337_6.sprite.bounds.size.x
					local var_337_12 = var_337_6.sprite.bounds.size.y
					local var_337_13 = var_337_10 / var_337_11
					local var_337_14 = var_337_9 / var_337_12
					local var_337_15 = var_337_14 < var_337_13 and var_337_13 or var_337_14

					var_337_5.transform.localScale = Vector3.New(var_337_15, var_337_15, 0)
				end

				for iter_337_0, iter_337_1 in pairs(arg_334_1.bgs_) do
					if iter_337_0 ~= "ST67" then
						iter_337_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_337_16 = 4

			if var_337_16 < arg_334_1.time_ and arg_334_1.time_ <= var_337_16 + arg_337_0 then
				arg_334_1.allBtn_.enabled = false
			end

			local var_337_17 = 0.0666666666666669

			if arg_334_1.time_ >= var_337_16 + var_337_17 and arg_334_1.time_ < var_337_16 + var_337_17 + arg_337_0 then
				arg_334_1.allBtn_.enabled = true
			end

			local var_337_18 = 0

			if var_337_18 < arg_334_1.time_ and arg_334_1.time_ <= var_337_18 + arg_337_0 then
				arg_334_1.mask_.enabled = true
				arg_334_1.mask_.raycastTarget = true

				arg_334_1:SetGaussion(false)
			end

			local var_337_19 = 2

			if var_337_18 <= arg_334_1.time_ and arg_334_1.time_ < var_337_18 + var_337_19 then
				local var_337_20 = (arg_334_1.time_ - var_337_18) / var_337_19
				local var_337_21 = Color.New(0, 0, 0)

				var_337_21.a = Mathf.Lerp(0, 1, var_337_20)
				arg_334_1.mask_.color = var_337_21
			end

			if arg_334_1.time_ >= var_337_18 + var_337_19 and arg_334_1.time_ < var_337_18 + var_337_19 + arg_337_0 then
				local var_337_22 = Color.New(0, 0, 0)

				var_337_22.a = 1
				arg_334_1.mask_.color = var_337_22
			end

			local var_337_23 = 2

			if var_337_23 < arg_334_1.time_ and arg_334_1.time_ <= var_337_23 + arg_337_0 then
				arg_334_1.mask_.enabled = true
				arg_334_1.mask_.raycastTarget = true

				arg_334_1:SetGaussion(false)
			end

			local var_337_24 = 2

			if var_337_23 <= arg_334_1.time_ and arg_334_1.time_ < var_337_23 + var_337_24 then
				local var_337_25 = (arg_334_1.time_ - var_337_23) / var_337_24
				local var_337_26 = Color.New(0, 0, 0)

				var_337_26.a = Mathf.Lerp(1, 0, var_337_25)
				arg_334_1.mask_.color = var_337_26
			end

			if arg_334_1.time_ >= var_337_23 + var_337_24 and arg_334_1.time_ < var_337_23 + var_337_24 + arg_337_0 then
				local var_337_27 = Color.New(0, 0, 0)
				local var_337_28 = 0

				arg_334_1.mask_.enabled = false
				var_337_27.a = var_337_28
				arg_334_1.mask_.color = var_337_27
			end

			local var_337_29 = "1061ui_story"

			if arg_334_1.actors_[var_337_29] == nil then
				local var_337_30 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_337_30) then
					local var_337_31 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_334_1.stage_.transform)

					var_337_31.name = var_337_29
					var_337_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_334_1.actors_[var_337_29] = var_337_31

					local var_337_32 = var_337_31:GetComponentInChildren(typeof(CharacterEffect))

					var_337_32.enabled = true

					local var_337_33 = GameObjectTools.GetOrAddComponent(var_337_31, typeof(DynamicBoneHelper))

					if var_337_33 then
						var_337_33:EnableDynamicBone(false)
					end

					arg_334_1:ShowWeapon(var_337_32.transform, false)

					arg_334_1.var_[var_337_29 .. "Animator"] = var_337_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_334_1.var_[var_337_29 .. "Animator"].applyRootMotion = true
					arg_334_1.var_[var_337_29 .. "LipSync"] = var_337_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_337_34 = arg_334_1.actors_["1061ui_story"].transform
			local var_337_35 = 3.79999999701977

			if var_337_35 < arg_334_1.time_ and arg_334_1.time_ <= var_337_35 + arg_337_0 then
				arg_334_1.var_.moveOldPos1061ui_story = var_337_34.localPosition
			end

			local var_337_36 = 0.001

			if var_337_35 <= arg_334_1.time_ and arg_334_1.time_ < var_337_35 + var_337_36 then
				local var_337_37 = (arg_334_1.time_ - var_337_35) / var_337_36
				local var_337_38 = Vector3.New(0, -1.18, -6.15)

				var_337_34.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1061ui_story, var_337_38, var_337_37)

				local var_337_39 = manager.ui.mainCamera.transform.position - var_337_34.position

				var_337_34.forward = Vector3.New(var_337_39.x, var_337_39.y, var_337_39.z)

				local var_337_40 = var_337_34.localEulerAngles

				var_337_40.z = 0
				var_337_40.x = 0
				var_337_34.localEulerAngles = var_337_40
			end

			if arg_334_1.time_ >= var_337_35 + var_337_36 and arg_334_1.time_ < var_337_35 + var_337_36 + arg_337_0 then
				var_337_34.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_337_41 = manager.ui.mainCamera.transform.position - var_337_34.position

				var_337_34.forward = Vector3.New(var_337_41.x, var_337_41.y, var_337_41.z)

				local var_337_42 = var_337_34.localEulerAngles

				var_337_42.z = 0
				var_337_42.x = 0
				var_337_34.localEulerAngles = var_337_42
			end

			local var_337_43 = arg_334_1.actors_["1061ui_story"]
			local var_337_44 = 3.79999999701977

			if var_337_44 < arg_334_1.time_ and arg_334_1.time_ <= var_337_44 + arg_337_0 and not isNil(var_337_43) and arg_334_1.var_.characterEffect1061ui_story == nil then
				arg_334_1.var_.characterEffect1061ui_story = var_337_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_45 = 0.200000002980232

			if var_337_44 <= arg_334_1.time_ and arg_334_1.time_ < var_337_44 + var_337_45 and not isNil(var_337_43) then
				local var_337_46 = (arg_334_1.time_ - var_337_44) / var_337_45

				if arg_334_1.var_.characterEffect1061ui_story and not isNil(var_337_43) then
					arg_334_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= var_337_44 + var_337_45 and arg_334_1.time_ < var_337_44 + var_337_45 + arg_337_0 and not isNil(var_337_43) and arg_334_1.var_.characterEffect1061ui_story then
				arg_334_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_337_47 = 3.79999999701977

			if var_337_47 < arg_334_1.time_ and arg_334_1.time_ <= var_337_47 + arg_337_0 then
				arg_334_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_337_48 = 3.79999999701977

			if var_337_48 < arg_334_1.time_ and arg_334_1.time_ <= var_337_48 + arg_337_0 then
				arg_334_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_337_49 = 1.93333333333333

			if var_337_49 < arg_334_1.time_ and arg_334_1.time_ <= var_337_49 + arg_337_0 then
				arg_334_1.cswbg_:SetActive(false)
			end

			local var_337_50 = 2

			if var_337_50 < arg_334_1.time_ and arg_334_1.time_ <= var_337_50 + arg_337_0 then
				arg_334_1.fswbg_:SetActive(false)
				arg_334_1.dialog_:SetActive(false)
				SetActive(arg_334_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_334_1:ShowNextGo(false)
			end

			local var_337_51 = 1.56666666666667
			local var_337_52 = 1

			if var_337_51 < arg_334_1.time_ and arg_334_1.time_ <= var_337_51 + arg_337_0 then
				local var_337_53 = "play"
				local var_337_54 = "effect"

				arg_334_1:AudioAction(var_337_53, var_337_54, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_337_55 = 0
			local var_337_56 = 0.2

			if var_337_55 < arg_334_1.time_ and arg_334_1.time_ <= var_337_55 + arg_337_0 then
				local var_337_57 = "play"
				local var_337_58 = "music"

				arg_334_1:AudioAction(var_337_57, var_337_58, "ui_battle", "ui_battle_stopbgm", "")

				local var_337_59 = ""
				local var_337_60 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_337_60 ~= "" then
					if arg_334_1.bgmTxt_.text ~= var_337_60 and arg_334_1.bgmTxt_.text ~= "" then
						if arg_334_1.bgmTxt2_.text ~= "" then
							arg_334_1.bgmTxt_.text = arg_334_1.bgmTxt2_.text
						end

						arg_334_1.bgmTxt2_.text = var_337_60

						arg_334_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_334_1.bgmTxt_.text = var_337_60
						arg_334_1.bgmTxt2_.text = var_337_60
					end

					if arg_334_1.bgmTimer then
						arg_334_1.bgmTimer:Stop()

						arg_334_1.bgmTimer = nil
					end

					if arg_334_1.settingData.show_music_name == 1 then
						arg_334_1.musicController:SetSelectedState("show")
						arg_334_1.musicAnimator_:Play("open", 0, 0)

						if arg_334_1.settingData.music_time ~= 0 then
							arg_334_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_334_1.settingData.music_time), function()
								if arg_334_1 == nil or isNil(arg_334_1.bgmTxt_) then
									return
								end

								arg_334_1.musicController:SetSelectedState("hide")
								arg_334_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_337_61 = 1.56666666666667
			local var_337_62 = 1

			if var_337_61 < arg_334_1.time_ and arg_334_1.time_ <= var_337_61 + arg_337_0 then
				local var_337_63 = "play"
				local var_337_64 = "music"

				arg_334_1:AudioAction(var_337_63, var_337_64, "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab.awb")

				local var_337_65 = ""
				local var_337_66 = manager.audio:GetAudioName("bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab")

				if var_337_66 ~= "" then
					if arg_334_1.bgmTxt_.text ~= var_337_66 and arg_334_1.bgmTxt_.text ~= "" then
						if arg_334_1.bgmTxt2_.text ~= "" then
							arg_334_1.bgmTxt_.text = arg_334_1.bgmTxt2_.text
						end

						arg_334_1.bgmTxt2_.text = var_337_66

						arg_334_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_334_1.bgmTxt_.text = var_337_66
						arg_334_1.bgmTxt2_.text = var_337_66
					end

					if arg_334_1.bgmTimer then
						arg_334_1.bgmTimer:Stop()

						arg_334_1.bgmTimer = nil
					end

					if arg_334_1.settingData.show_music_name == 1 then
						arg_334_1.musicController:SetSelectedState("show")
						arg_334_1.musicAnimator_:Play("open", 0, 0)

						if arg_334_1.settingData.music_time ~= 0 then
							arg_334_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_334_1.settingData.music_time), function()
								if arg_334_1 == nil or isNil(arg_334_1.bgmTxt_) then
									return
								end

								arg_334_1.musicController:SetSelectedState("hide")
								arg_334_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_334_1.frameCnt_ <= 1 then
				arg_334_1.dialog_:SetActive(false)
			end

			local var_337_67 = 4
			local var_337_68 = 0.125

			if var_337_67 < arg_334_1.time_ and arg_334_1.time_ <= var_337_67 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0

				arg_334_1.dialog_:SetActive(true)

				arg_334_1.dialogCg_.alpha = 0

				local var_337_69 = LeanTween.value(arg_334_1.dialog_, 0, 1, 0.3)

				var_337_69:setOnUpdate(LuaHelper.FloatAction(function(arg_340_0)
					arg_334_1.dialogCg_.alpha = arg_340_0
				end))
				var_337_69:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_334_1.dialog_)
					var_337_69:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_334_1.duration_ = arg_334_1.duration_ + 0.3

				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_70 = arg_334_1:FormatText(StoryNameCfg[612].name)

				arg_334_1.leftNameTxt_.text = var_337_70

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_71 = arg_334_1:GetWordFromCfg(420051080)
				local var_337_72 = arg_334_1:FormatText(var_337_71.content)

				arg_334_1.text_.text = var_337_72

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_73 = 5
				local var_337_74 = utf8.len(var_337_72)
				local var_337_75 = var_337_73 <= 0 and var_337_68 or var_337_68 * (var_337_74 / var_337_73)

				if var_337_75 > 0 and var_337_68 < var_337_75 then
					arg_334_1.talkMaxDuration = var_337_75
					var_337_67 = var_337_67 + 0.3

					if var_337_75 + var_337_67 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_75 + var_337_67
					end
				end

				arg_334_1.text_.text = var_337_72
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051080", "story_v_out_420051.awb") ~= 0 then
					local var_337_76 = manager.audio:GetVoiceLength("story_v_out_420051", "420051080", "story_v_out_420051.awb") / 1000

					if var_337_76 + var_337_67 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_76 + var_337_67
					end

					if var_337_71.prefab_name ~= "" and arg_334_1.actors_[var_337_71.prefab_name] ~= nil then
						local var_337_77 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_71.prefab_name].transform, "story_v_out_420051", "420051080", "story_v_out_420051.awb")

						arg_334_1:RecordAudio("420051080", var_337_77)
						arg_334_1:RecordAudio("420051080", var_337_77)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_420051", "420051080", "story_v_out_420051.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_420051", "420051080", "story_v_out_420051.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_78 = var_337_67 + 0.3
			local var_337_79 = math.max(var_337_68, arg_334_1.talkMaxDuration)

			if var_337_78 <= arg_334_1.time_ and arg_334_1.time_ < var_337_78 + var_337_79 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_78) / var_337_79

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_78 + var_337_79 and arg_334_1.time_ < var_337_78 + var_337_79 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play420051081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 420051081
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play420051082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1061ui_story"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1061ui_story == nil then
				arg_342_1.var_.characterEffect1061ui_story = var_345_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.characterEffect1061ui_story and not isNil(var_345_0) then
					local var_345_4 = Mathf.Lerp(0, 0.5, var_345_3)

					arg_342_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1061ui_story.fillRatio = var_345_4
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1061ui_story then
				local var_345_5 = 0.5

				arg_342_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1061ui_story.fillRatio = var_345_5
			end

			local var_345_6 = 0.05
			local var_345_7 = 1

			if var_345_6 < arg_342_1.time_ and arg_342_1.time_ <= var_345_6 + arg_345_0 then
				local var_345_8 = "play"
				local var_345_9 = "effect"

				arg_342_1:AudioAction(var_345_8, var_345_9, "se_story_140", "se_story_140_xuanji", "")
			end

			local var_345_10 = 0
			local var_345_11 = 0.575

			if var_345_10 < arg_342_1.time_ and arg_342_1.time_ <= var_345_10 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_12 = arg_342_1:GetWordFromCfg(420051081)
				local var_345_13 = arg_342_1:FormatText(var_345_12.content)

				arg_342_1.text_.text = var_345_13

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_14 = 23
				local var_345_15 = utf8.len(var_345_13)
				local var_345_16 = var_345_14 <= 0 and var_345_11 or var_345_11 * (var_345_15 / var_345_14)

				if var_345_16 > 0 and var_345_11 < var_345_16 then
					arg_342_1.talkMaxDuration = var_345_16

					if var_345_16 + var_345_10 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_16 + var_345_10
					end
				end

				arg_342_1.text_.text = var_345_13
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_17 = math.max(var_345_11, arg_342_1.talkMaxDuration)

			if var_345_10 <= arg_342_1.time_ and arg_342_1.time_ < var_345_10 + var_345_17 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_10) / var_345_17

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_10 + var_345_17 and arg_342_1.time_ < var_345_10 + var_345_17 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play420051082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 420051082
		arg_346_1.duration_ = 7.2

		local var_346_0 = {
			zh = 4.566,
			ja = 7.2
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play420051083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1061ui_story"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1061ui_story == nil then
				arg_346_1.var_.characterEffect1061ui_story = var_349_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.characterEffect1061ui_story and not isNil(var_349_0) then
					arg_346_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1061ui_story then
				arg_346_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_349_4 = 0
			local var_349_5 = 0.525

			if var_349_4 < arg_346_1.time_ and arg_346_1.time_ <= var_349_4 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_6 = arg_346_1:FormatText(StoryNameCfg[612].name)

				arg_346_1.leftNameTxt_.text = var_349_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_7 = arg_346_1:GetWordFromCfg(420051082)
				local var_349_8 = arg_346_1:FormatText(var_349_7.content)

				arg_346_1.text_.text = var_349_8

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_9 = 21
				local var_349_10 = utf8.len(var_349_8)
				local var_349_11 = var_349_9 <= 0 and var_349_5 or var_349_5 * (var_349_10 / var_349_9)

				if var_349_11 > 0 and var_349_5 < var_349_11 then
					arg_346_1.talkMaxDuration = var_349_11

					if var_349_11 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_11 + var_349_4
					end
				end

				arg_346_1.text_.text = var_349_8
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051082", "story_v_out_420051.awb") ~= 0 then
					local var_349_12 = manager.audio:GetVoiceLength("story_v_out_420051", "420051082", "story_v_out_420051.awb") / 1000

					if var_349_12 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_12 + var_349_4
					end

					if var_349_7.prefab_name ~= "" and arg_346_1.actors_[var_349_7.prefab_name] ~= nil then
						local var_349_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_7.prefab_name].transform, "story_v_out_420051", "420051082", "story_v_out_420051.awb")

						arg_346_1:RecordAudio("420051082", var_349_13)
						arg_346_1:RecordAudio("420051082", var_349_13)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_420051", "420051082", "story_v_out_420051.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_420051", "420051082", "story_v_out_420051.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_14 = math.max(var_349_5, arg_346_1.talkMaxDuration)

			if var_349_4 <= arg_346_1.time_ and arg_346_1.time_ < var_349_4 + var_349_14 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_4) / var_349_14

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_4 + var_349_14 and arg_346_1.time_ < var_349_4 + var_349_14 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play420051083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 420051083
		arg_350_1.duration_ = 14.13

		local var_350_0 = {
			zh = 10.466,
			ja = 14.133
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play420051084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_353_2 = 0
			local var_353_3 = 1.2

			if var_353_2 < arg_350_1.time_ and arg_350_1.time_ <= var_353_2 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_4 = arg_350_1:FormatText(StoryNameCfg[612].name)

				arg_350_1.leftNameTxt_.text = var_353_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_5 = arg_350_1:GetWordFromCfg(420051083)
				local var_353_6 = arg_350_1:FormatText(var_353_5.content)

				arg_350_1.text_.text = var_353_6

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_7 = 48
				local var_353_8 = utf8.len(var_353_6)
				local var_353_9 = var_353_7 <= 0 and var_353_3 or var_353_3 * (var_353_8 / var_353_7)

				if var_353_9 > 0 and var_353_3 < var_353_9 then
					arg_350_1.talkMaxDuration = var_353_9

					if var_353_9 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_9 + var_353_2
					end
				end

				arg_350_1.text_.text = var_353_6
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051083", "story_v_out_420051.awb") ~= 0 then
					local var_353_10 = manager.audio:GetVoiceLength("story_v_out_420051", "420051083", "story_v_out_420051.awb") / 1000

					if var_353_10 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_10 + var_353_2
					end

					if var_353_5.prefab_name ~= "" and arg_350_1.actors_[var_353_5.prefab_name] ~= nil then
						local var_353_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_5.prefab_name].transform, "story_v_out_420051", "420051083", "story_v_out_420051.awb")

						arg_350_1:RecordAudio("420051083", var_353_11)
						arg_350_1:RecordAudio("420051083", var_353_11)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_420051", "420051083", "story_v_out_420051.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_420051", "420051083", "story_v_out_420051.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_12 = math.max(var_353_3, arg_350_1.talkMaxDuration)

			if var_353_2 <= arg_350_1.time_ and arg_350_1.time_ < var_353_2 + var_353_12 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_2) / var_353_12

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_2 + var_353_12 and arg_350_1.time_ < var_353_2 + var_353_12 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play420051084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 420051084
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play420051085(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1061ui_story"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1061ui_story == nil then
				arg_354_1.var_.characterEffect1061ui_story = var_357_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.characterEffect1061ui_story and not isNil(var_357_0) then
					local var_357_4 = Mathf.Lerp(0, 0.5, var_357_3)

					arg_354_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_354_1.var_.characterEffect1061ui_story.fillRatio = var_357_4
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1061ui_story then
				local var_357_5 = 0.5

				arg_354_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_354_1.var_.characterEffect1061ui_story.fillRatio = var_357_5
			end

			local var_357_6 = 0
			local var_357_7 = 0.775

			if var_357_6 < arg_354_1.time_ and arg_354_1.time_ <= var_357_6 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_8 = arg_354_1:GetWordFromCfg(420051084)
				local var_357_9 = arg_354_1:FormatText(var_357_8.content)

				arg_354_1.text_.text = var_357_9

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_10 = 31
				local var_357_11 = utf8.len(var_357_9)
				local var_357_12 = var_357_10 <= 0 and var_357_7 or var_357_7 * (var_357_11 / var_357_10)

				if var_357_12 > 0 and var_357_7 < var_357_12 then
					arg_354_1.talkMaxDuration = var_357_12

					if var_357_12 + var_357_6 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_12 + var_357_6
					end
				end

				arg_354_1.text_.text = var_357_9
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_13 = math.max(var_357_7, arg_354_1.talkMaxDuration)

			if var_357_6 <= arg_354_1.time_ and arg_354_1.time_ < var_357_6 + var_357_13 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_6) / var_357_13

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_6 + var_357_13 and arg_354_1.time_ < var_357_6 + var_357_13 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play420051085 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 420051085
		arg_358_1.duration_ = 11.53

		local var_358_0 = {
			zh = 6.8,
			ja = 11.533
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play420051086(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1061ui_story"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1061ui_story == nil then
				arg_358_1.var_.characterEffect1061ui_story = var_361_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.characterEffect1061ui_story and not isNil(var_361_0) then
					arg_358_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1061ui_story then
				arg_358_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_361_4 = 0

			if var_361_4 < arg_358_1.time_ and arg_358_1.time_ <= var_361_4 + arg_361_0 then
				arg_358_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_361_5 = 0

			if var_361_5 < arg_358_1.time_ and arg_358_1.time_ <= var_361_5 + arg_361_0 then
				arg_358_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva", "EmotionTimelineAnimator")
			end

			local var_361_6 = 0
			local var_361_7 = 0.8

			if var_361_6 < arg_358_1.time_ and arg_358_1.time_ <= var_361_6 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_8 = arg_358_1:FormatText(StoryNameCfg[612].name)

				arg_358_1.leftNameTxt_.text = var_361_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_9 = arg_358_1:GetWordFromCfg(420051085)
				local var_361_10 = arg_358_1:FormatText(var_361_9.content)

				arg_358_1.text_.text = var_361_10

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_11 = 32
				local var_361_12 = utf8.len(var_361_10)
				local var_361_13 = var_361_11 <= 0 and var_361_7 or var_361_7 * (var_361_12 / var_361_11)

				if var_361_13 > 0 and var_361_7 < var_361_13 then
					arg_358_1.talkMaxDuration = var_361_13

					if var_361_13 + var_361_6 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_13 + var_361_6
					end
				end

				arg_358_1.text_.text = var_361_10
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051085", "story_v_out_420051.awb") ~= 0 then
					local var_361_14 = manager.audio:GetVoiceLength("story_v_out_420051", "420051085", "story_v_out_420051.awb") / 1000

					if var_361_14 + var_361_6 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_14 + var_361_6
					end

					if var_361_9.prefab_name ~= "" and arg_358_1.actors_[var_361_9.prefab_name] ~= nil then
						local var_361_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_9.prefab_name].transform, "story_v_out_420051", "420051085", "story_v_out_420051.awb")

						arg_358_1:RecordAudio("420051085", var_361_15)
						arg_358_1:RecordAudio("420051085", var_361_15)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_420051", "420051085", "story_v_out_420051.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_420051", "420051085", "story_v_out_420051.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_16 = math.max(var_361_7, arg_358_1.talkMaxDuration)

			if var_361_6 <= arg_358_1.time_ and arg_358_1.time_ < var_361_6 + var_361_16 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_6) / var_361_16

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_6 + var_361_16 and arg_358_1.time_ < var_361_6 + var_361_16 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play420051086 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 420051086
		arg_362_1.duration_ = 8.3

		local var_362_0 = {
			zh = 2.5,
			ja = 8.3
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play420051087(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0
			local var_365_1 = 0.3

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_2 = arg_362_1:FormatText(StoryNameCfg[612].name)

				arg_362_1.leftNameTxt_.text = var_365_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_3 = arg_362_1:GetWordFromCfg(420051086)
				local var_365_4 = arg_362_1:FormatText(var_365_3.content)

				arg_362_1.text_.text = var_365_4

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 12
				local var_365_6 = utf8.len(var_365_4)
				local var_365_7 = var_365_5 <= 0 and var_365_1 or var_365_1 * (var_365_6 / var_365_5)

				if var_365_7 > 0 and var_365_1 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_4
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051086", "story_v_out_420051.awb") ~= 0 then
					local var_365_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051086", "story_v_out_420051.awb") / 1000

					if var_365_8 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_8 + var_365_0
					end

					if var_365_3.prefab_name ~= "" and arg_362_1.actors_[var_365_3.prefab_name] ~= nil then
						local var_365_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_3.prefab_name].transform, "story_v_out_420051", "420051086", "story_v_out_420051.awb")

						arg_362_1:RecordAudio("420051086", var_365_9)
						arg_362_1:RecordAudio("420051086", var_365_9)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_420051", "420051086", "story_v_out_420051.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_420051", "420051086", "story_v_out_420051.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_10 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_10 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_10

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_10 and arg_362_1.time_ < var_365_0 + var_365_10 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play420051087 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 420051087
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play420051088(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1061ui_story"].transform
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.var_.moveOldPos1061ui_story = var_369_0.localPosition
			end

			local var_369_2 = 0.001

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2
				local var_369_4 = Vector3.New(0, 100, 0)

				var_369_0.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1061ui_story, var_369_4, var_369_3)

				local var_369_5 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_5.x, var_369_5.y, var_369_5.z)

				local var_369_6 = var_369_0.localEulerAngles

				var_369_6.z = 0
				var_369_6.x = 0
				var_369_0.localEulerAngles = var_369_6
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 then
				var_369_0.localPosition = Vector3.New(0, 100, 0)

				local var_369_7 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_7.x, var_369_7.y, var_369_7.z)

				local var_369_8 = var_369_0.localEulerAngles

				var_369_8.z = 0
				var_369_8.x = 0
				var_369_0.localEulerAngles = var_369_8
			end

			local var_369_9 = 0
			local var_369_10 = 0.075

			if var_369_9 < arg_366_1.time_ and arg_366_1.time_ <= var_369_9 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_11 = arg_366_1:FormatText(StoryNameCfg[7].name)

				arg_366_1.leftNameTxt_.text = var_369_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_12 = arg_366_1:GetWordFromCfg(420051087)
				local var_369_13 = arg_366_1:FormatText(var_369_12.content)

				arg_366_1.text_.text = var_369_13

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_14 = 3
				local var_369_15 = utf8.len(var_369_13)
				local var_369_16 = var_369_14 <= 0 and var_369_10 or var_369_10 * (var_369_15 / var_369_14)

				if var_369_16 > 0 and var_369_10 < var_369_16 then
					arg_366_1.talkMaxDuration = var_369_16

					if var_369_16 + var_369_9 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_16 + var_369_9
					end
				end

				arg_366_1.text_.text = var_369_13
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_17 = math.max(var_369_10, arg_366_1.talkMaxDuration)

			if var_369_9 <= arg_366_1.time_ and arg_366_1.time_ < var_369_9 + var_369_17 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_9) / var_369_17

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_9 + var_369_17 and arg_366_1.time_ < var_369_9 + var_369_17 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play420051088 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 420051088
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play420051089(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0.533333333333333
			local var_373_1 = 1

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				local var_373_2 = "play"
				local var_373_3 = "effect"

				arg_370_1:AudioAction(var_373_2, var_373_3, "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_373_4 = 0
			local var_373_5 = 1.05

			if var_373_4 < arg_370_1.time_ and arg_370_1.time_ <= var_373_4 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_6 = arg_370_1:GetWordFromCfg(420051088)
				local var_373_7 = arg_370_1:FormatText(var_373_6.content)

				arg_370_1.text_.text = var_373_7

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_8 = 42
				local var_373_9 = utf8.len(var_373_7)
				local var_373_10 = var_373_8 <= 0 and var_373_5 or var_373_5 * (var_373_9 / var_373_8)

				if var_373_10 > 0 and var_373_5 < var_373_10 then
					arg_370_1.talkMaxDuration = var_373_10

					if var_373_10 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_10 + var_373_4
					end
				end

				arg_370_1.text_.text = var_373_7
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_11 = math.max(var_373_5, arg_370_1.talkMaxDuration)

			if var_373_4 <= arg_370_1.time_ and arg_370_1.time_ < var_373_4 + var_373_11 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_4) / var_373_11

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_4 + var_373_11 and arg_370_1.time_ < var_373_4 + var_373_11 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play420051089 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 420051089
		arg_374_1.duration_ = 3.17

		local var_374_0 = {
			zh = 2.5,
			ja = 3.166
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play420051090(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["1085ui_story"].transform
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 then
				arg_374_1.var_.moveOldPos1085ui_story = var_377_0.localPosition
			end

			local var_377_2 = 0.001

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2
				local var_377_4 = Vector3.New(0, -1.01, -5.83)

				var_377_0.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1085ui_story, var_377_4, var_377_3)

				local var_377_5 = manager.ui.mainCamera.transform.position - var_377_0.position

				var_377_0.forward = Vector3.New(var_377_5.x, var_377_5.y, var_377_5.z)

				local var_377_6 = var_377_0.localEulerAngles

				var_377_6.z = 0
				var_377_6.x = 0
				var_377_0.localEulerAngles = var_377_6
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 then
				var_377_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_377_7 = manager.ui.mainCamera.transform.position - var_377_0.position

				var_377_0.forward = Vector3.New(var_377_7.x, var_377_7.y, var_377_7.z)

				local var_377_8 = var_377_0.localEulerAngles

				var_377_8.z = 0
				var_377_8.x = 0
				var_377_0.localEulerAngles = var_377_8
			end

			local var_377_9 = arg_374_1.actors_["1085ui_story"]
			local var_377_10 = 0

			if var_377_10 < arg_374_1.time_ and arg_374_1.time_ <= var_377_10 + arg_377_0 and not isNil(var_377_9) and arg_374_1.var_.characterEffect1085ui_story == nil then
				arg_374_1.var_.characterEffect1085ui_story = var_377_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_11 = 0.200000002980232

			if var_377_10 <= arg_374_1.time_ and arg_374_1.time_ < var_377_10 + var_377_11 and not isNil(var_377_9) then
				local var_377_12 = (arg_374_1.time_ - var_377_10) / var_377_11

				if arg_374_1.var_.characterEffect1085ui_story and not isNil(var_377_9) then
					arg_374_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= var_377_10 + var_377_11 and arg_374_1.time_ < var_377_10 + var_377_11 + arg_377_0 and not isNil(var_377_9) and arg_374_1.var_.characterEffect1085ui_story then
				arg_374_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_377_13 = 0

			if var_377_13 < arg_374_1.time_ and arg_374_1.time_ <= var_377_13 + arg_377_0 then
				arg_374_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_377_14 = 0

			if var_377_14 < arg_374_1.time_ and arg_374_1.time_ <= var_377_14 + arg_377_0 then
				arg_374_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_377_15 = 0
			local var_377_16 = 0.275

			if var_377_15 < arg_374_1.time_ and arg_374_1.time_ <= var_377_15 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_17 = arg_374_1:FormatText(StoryNameCfg[328].name)

				arg_374_1.leftNameTxt_.text = var_377_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_18 = arg_374_1:GetWordFromCfg(420051089)
				local var_377_19 = arg_374_1:FormatText(var_377_18.content)

				arg_374_1.text_.text = var_377_19

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_20 = 11
				local var_377_21 = utf8.len(var_377_19)
				local var_377_22 = var_377_20 <= 0 and var_377_16 or var_377_16 * (var_377_21 / var_377_20)

				if var_377_22 > 0 and var_377_16 < var_377_22 then
					arg_374_1.talkMaxDuration = var_377_22

					if var_377_22 + var_377_15 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_22 + var_377_15
					end
				end

				arg_374_1.text_.text = var_377_19
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051089", "story_v_out_420051.awb") ~= 0 then
					local var_377_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051089", "story_v_out_420051.awb") / 1000

					if var_377_23 + var_377_15 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_23 + var_377_15
					end

					if var_377_18.prefab_name ~= "" and arg_374_1.actors_[var_377_18.prefab_name] ~= nil then
						local var_377_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_18.prefab_name].transform, "story_v_out_420051", "420051089", "story_v_out_420051.awb")

						arg_374_1:RecordAudio("420051089", var_377_24)
						arg_374_1:RecordAudio("420051089", var_377_24)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_420051", "420051089", "story_v_out_420051.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_420051", "420051089", "story_v_out_420051.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_25 = math.max(var_377_16, arg_374_1.talkMaxDuration)

			if var_377_15 <= arg_374_1.time_ and arg_374_1.time_ < var_377_15 + var_377_25 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_15) / var_377_25

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_15 + var_377_25 and arg_374_1.time_ < var_377_15 + var_377_25 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play420051090 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 420051090
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play420051091(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1085ui_story"]
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1085ui_story == nil then
				arg_378_1.var_.characterEffect1085ui_story = var_381_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 and not isNil(var_381_0) then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2

				if arg_378_1.var_.characterEffect1085ui_story and not isNil(var_381_0) then
					local var_381_4 = Mathf.Lerp(0, 0.5, var_381_3)

					arg_378_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1085ui_story.fillRatio = var_381_4
				end
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1085ui_story then
				local var_381_5 = 0.5

				arg_378_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1085ui_story.fillRatio = var_381_5
			end

			local var_381_6 = 0
			local var_381_7 = 0.4

			if var_381_6 < arg_378_1.time_ and arg_378_1.time_ <= var_381_6 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_8 = arg_378_1:FormatText(StoryNameCfg[7].name)

				arg_378_1.leftNameTxt_.text = var_381_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_9 = arg_378_1:GetWordFromCfg(420051090)
				local var_381_10 = arg_378_1:FormatText(var_381_9.content)

				arg_378_1.text_.text = var_381_10

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_11 = 16
				local var_381_12 = utf8.len(var_381_10)
				local var_381_13 = var_381_11 <= 0 and var_381_7 or var_381_7 * (var_381_12 / var_381_11)

				if var_381_13 > 0 and var_381_7 < var_381_13 then
					arg_378_1.talkMaxDuration = var_381_13

					if var_381_13 + var_381_6 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_13 + var_381_6
					end
				end

				arg_378_1.text_.text = var_381_10
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_14 = math.max(var_381_7, arg_378_1.talkMaxDuration)

			if var_381_6 <= arg_378_1.time_ and arg_378_1.time_ < var_381_6 + var_381_14 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_6) / var_381_14

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_6 + var_381_14 and arg_378_1.time_ < var_381_6 + var_381_14 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play420051091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 420051091
		arg_382_1.duration_ = 15.3

		local var_382_0 = {
			zh = 9.7,
			ja = 15.3
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play420051092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["1085ui_story"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1085ui_story == nil then
				arg_382_1.var_.characterEffect1085ui_story = var_385_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.characterEffect1085ui_story and not isNil(var_385_0) then
					arg_382_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1085ui_story then
				arg_382_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_385_4 = 0

			if var_385_4 < arg_382_1.time_ and arg_382_1.time_ <= var_385_4 + arg_385_0 then
				arg_382_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_385_5 = 0
			local var_385_6 = 0.725

			if var_385_5 < arg_382_1.time_ and arg_382_1.time_ <= var_385_5 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_7 = arg_382_1:FormatText(StoryNameCfg[328].name)

				arg_382_1.leftNameTxt_.text = var_385_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_8 = arg_382_1:GetWordFromCfg(420051091)
				local var_385_9 = arg_382_1:FormatText(var_385_8.content)

				arg_382_1.text_.text = var_385_9

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_10 = 29
				local var_385_11 = utf8.len(var_385_9)
				local var_385_12 = var_385_10 <= 0 and var_385_6 or var_385_6 * (var_385_11 / var_385_10)

				if var_385_12 > 0 and var_385_6 < var_385_12 then
					arg_382_1.talkMaxDuration = var_385_12

					if var_385_12 + var_385_5 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_12 + var_385_5
					end
				end

				arg_382_1.text_.text = var_385_9
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051091", "story_v_out_420051.awb") ~= 0 then
					local var_385_13 = manager.audio:GetVoiceLength("story_v_out_420051", "420051091", "story_v_out_420051.awb") / 1000

					if var_385_13 + var_385_5 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_13 + var_385_5
					end

					if var_385_8.prefab_name ~= "" and arg_382_1.actors_[var_385_8.prefab_name] ~= nil then
						local var_385_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_8.prefab_name].transform, "story_v_out_420051", "420051091", "story_v_out_420051.awb")

						arg_382_1:RecordAudio("420051091", var_385_14)
						arg_382_1:RecordAudio("420051091", var_385_14)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_420051", "420051091", "story_v_out_420051.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_420051", "420051091", "story_v_out_420051.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_15 = math.max(var_385_6, arg_382_1.talkMaxDuration)

			if var_385_5 <= arg_382_1.time_ and arg_382_1.time_ < var_385_5 + var_385_15 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_5) / var_385_15

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_5 + var_385_15 and arg_382_1.time_ < var_385_5 + var_385_15 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play420051092 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 420051092
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play420051093(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["1085ui_story"]
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect1085ui_story == nil then
				arg_386_1.var_.characterEffect1085ui_story = var_389_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.200000002980232

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 and not isNil(var_389_0) then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2

				if arg_386_1.var_.characterEffect1085ui_story and not isNil(var_389_0) then
					local var_389_4 = Mathf.Lerp(0, 0.5, var_389_3)

					arg_386_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_386_1.var_.characterEffect1085ui_story.fillRatio = var_389_4
				end
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect1085ui_story then
				local var_389_5 = 0.5

				arg_386_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_386_1.var_.characterEffect1085ui_story.fillRatio = var_389_5
			end

			local var_389_6 = 0
			local var_389_7 = 0.475

			if var_389_6 < arg_386_1.time_ and arg_386_1.time_ <= var_389_6 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_8 = arg_386_1:FormatText(StoryNameCfg[7].name)

				arg_386_1.leftNameTxt_.text = var_389_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_9 = arg_386_1:GetWordFromCfg(420051092)
				local var_389_10 = arg_386_1:FormatText(var_389_9.content)

				arg_386_1.text_.text = var_389_10

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_11 = 19
				local var_389_12 = utf8.len(var_389_10)
				local var_389_13 = var_389_11 <= 0 and var_389_7 or var_389_7 * (var_389_12 / var_389_11)

				if var_389_13 > 0 and var_389_7 < var_389_13 then
					arg_386_1.talkMaxDuration = var_389_13

					if var_389_13 + var_389_6 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_13 + var_389_6
					end
				end

				arg_386_1.text_.text = var_389_10
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_14 = math.max(var_389_7, arg_386_1.talkMaxDuration)

			if var_389_6 <= arg_386_1.time_ and arg_386_1.time_ < var_389_6 + var_389_14 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_6) / var_389_14

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_6 + var_389_14 and arg_386_1.time_ < var_389_6 + var_389_14 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play420051093 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 420051093
		arg_390_1.duration_ = 1.43

		local var_390_0 = {
			zh = 1.1,
			ja = 1.433
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play420051094(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1085ui_story"]
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect1085ui_story == nil then
				arg_390_1.var_.characterEffect1085ui_story = var_393_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_2 = 0.200000002980232

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 and not isNil(var_393_0) then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2

				if arg_390_1.var_.characterEffect1085ui_story and not isNil(var_393_0) then
					arg_390_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect1085ui_story then
				arg_390_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_393_4 = 0
			local var_393_5 = 0.05

			if var_393_4 < arg_390_1.time_ and arg_390_1.time_ <= var_393_4 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_6 = arg_390_1:FormatText(StoryNameCfg[328].name)

				arg_390_1.leftNameTxt_.text = var_393_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_7 = arg_390_1:GetWordFromCfg(420051093)
				local var_393_8 = arg_390_1:FormatText(var_393_7.content)

				arg_390_1.text_.text = var_393_8

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_9 = 2
				local var_393_10 = utf8.len(var_393_8)
				local var_393_11 = var_393_9 <= 0 and var_393_5 or var_393_5 * (var_393_10 / var_393_9)

				if var_393_11 > 0 and var_393_5 < var_393_11 then
					arg_390_1.talkMaxDuration = var_393_11

					if var_393_11 + var_393_4 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_11 + var_393_4
					end
				end

				arg_390_1.text_.text = var_393_8
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051093", "story_v_out_420051.awb") ~= 0 then
					local var_393_12 = manager.audio:GetVoiceLength("story_v_out_420051", "420051093", "story_v_out_420051.awb") / 1000

					if var_393_12 + var_393_4 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_12 + var_393_4
					end

					if var_393_7.prefab_name ~= "" and arg_390_1.actors_[var_393_7.prefab_name] ~= nil then
						local var_393_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_7.prefab_name].transform, "story_v_out_420051", "420051093", "story_v_out_420051.awb")

						arg_390_1:RecordAudio("420051093", var_393_13)
						arg_390_1:RecordAudio("420051093", var_393_13)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_420051", "420051093", "story_v_out_420051.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_420051", "420051093", "story_v_out_420051.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_14 = math.max(var_393_5, arg_390_1.talkMaxDuration)

			if var_393_4 <= arg_390_1.time_ and arg_390_1.time_ < var_393_4 + var_393_14 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_4) / var_393_14

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_4 + var_393_14 and arg_390_1.time_ < var_393_4 + var_393_14 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play420051094 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 420051094
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play420051095(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1085ui_story"].transform
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				arg_394_1.var_.moveOldPos1085ui_story = var_397_0.localPosition
			end

			local var_397_2 = 0.001

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2
				local var_397_4 = Vector3.New(0, 100, 0)

				var_397_0.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1085ui_story, var_397_4, var_397_3)

				local var_397_5 = manager.ui.mainCamera.transform.position - var_397_0.position

				var_397_0.forward = Vector3.New(var_397_5.x, var_397_5.y, var_397_5.z)

				local var_397_6 = var_397_0.localEulerAngles

				var_397_6.z = 0
				var_397_6.x = 0
				var_397_0.localEulerAngles = var_397_6
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 then
				var_397_0.localPosition = Vector3.New(0, 100, 0)

				local var_397_7 = manager.ui.mainCamera.transform.position - var_397_0.position

				var_397_0.forward = Vector3.New(var_397_7.x, var_397_7.y, var_397_7.z)

				local var_397_8 = var_397_0.localEulerAngles

				var_397_8.z = 0
				var_397_8.x = 0
				var_397_0.localEulerAngles = var_397_8
			end

			local var_397_9 = 0
			local var_397_10 = 1.1

			if var_397_9 < arg_394_1.time_ and arg_394_1.time_ <= var_397_9 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_11 = arg_394_1:GetWordFromCfg(420051094)
				local var_397_12 = arg_394_1:FormatText(var_397_11.content)

				arg_394_1.text_.text = var_397_12

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_13 = 44
				local var_397_14 = utf8.len(var_397_12)
				local var_397_15 = var_397_13 <= 0 and var_397_10 or var_397_10 * (var_397_14 / var_397_13)

				if var_397_15 > 0 and var_397_10 < var_397_15 then
					arg_394_1.talkMaxDuration = var_397_15

					if var_397_15 + var_397_9 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_15 + var_397_9
					end
				end

				arg_394_1.text_.text = var_397_12
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_16 = math.max(var_397_10, arg_394_1.talkMaxDuration)

			if var_397_9 <= arg_394_1.time_ and arg_394_1.time_ < var_397_9 + var_397_16 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_9) / var_397_16

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_9 + var_397_16 and arg_394_1.time_ < var_397_9 + var_397_16 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play420051095 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 420051095
		arg_398_1.duration_ = 3.23

		local var_398_0 = {
			zh = 1.999999999999,
			ja = 3.233
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play420051096(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1061ui_story"].transform
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.var_.moveOldPos1061ui_story = var_401_0.localPosition
			end

			local var_401_2 = 0.001

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2
				local var_401_4 = Vector3.New(0, -1.18, -6.15)

				var_401_0.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1061ui_story, var_401_4, var_401_3)

				local var_401_5 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_5.x, var_401_5.y, var_401_5.z)

				local var_401_6 = var_401_0.localEulerAngles

				var_401_6.z = 0
				var_401_6.x = 0
				var_401_0.localEulerAngles = var_401_6
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 then
				var_401_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_401_7 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_7.x, var_401_7.y, var_401_7.z)

				local var_401_8 = var_401_0.localEulerAngles

				var_401_8.z = 0
				var_401_8.x = 0
				var_401_0.localEulerAngles = var_401_8
			end

			local var_401_9 = arg_398_1.actors_["1061ui_story"]
			local var_401_10 = 0

			if var_401_10 < arg_398_1.time_ and arg_398_1.time_ <= var_401_10 + arg_401_0 and not isNil(var_401_9) and arg_398_1.var_.characterEffect1061ui_story == nil then
				arg_398_1.var_.characterEffect1061ui_story = var_401_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_11 = 0.200000002980232

			if var_401_10 <= arg_398_1.time_ and arg_398_1.time_ < var_401_10 + var_401_11 and not isNil(var_401_9) then
				local var_401_12 = (arg_398_1.time_ - var_401_10) / var_401_11

				if arg_398_1.var_.characterEffect1061ui_story and not isNil(var_401_9) then
					arg_398_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= var_401_10 + var_401_11 and arg_398_1.time_ < var_401_10 + var_401_11 + arg_401_0 and not isNil(var_401_9) and arg_398_1.var_.characterEffect1061ui_story then
				arg_398_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_401_13 = 0

			if var_401_13 < arg_398_1.time_ and arg_398_1.time_ <= var_401_13 + arg_401_0 then
				arg_398_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_401_14 = 0

			if var_401_14 < arg_398_1.time_ and arg_398_1.time_ <= var_401_14 + arg_401_0 then
				arg_398_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_401_15 = 0
			local var_401_16 = 0.275

			if var_401_15 < arg_398_1.time_ and arg_398_1.time_ <= var_401_15 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_17 = arg_398_1:FormatText(StoryNameCfg[612].name)

				arg_398_1.leftNameTxt_.text = var_401_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_18 = arg_398_1:GetWordFromCfg(420051095)
				local var_401_19 = arg_398_1:FormatText(var_401_18.content)

				arg_398_1.text_.text = var_401_19

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_20 = 11
				local var_401_21 = utf8.len(var_401_19)
				local var_401_22 = var_401_20 <= 0 and var_401_16 or var_401_16 * (var_401_21 / var_401_20)

				if var_401_22 > 0 and var_401_16 < var_401_22 then
					arg_398_1.talkMaxDuration = var_401_22

					if var_401_22 + var_401_15 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_22 + var_401_15
					end
				end

				arg_398_1.text_.text = var_401_19
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051095", "story_v_out_420051.awb") ~= 0 then
					local var_401_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051095", "story_v_out_420051.awb") / 1000

					if var_401_23 + var_401_15 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_23 + var_401_15
					end

					if var_401_18.prefab_name ~= "" and arg_398_1.actors_[var_401_18.prefab_name] ~= nil then
						local var_401_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_18.prefab_name].transform, "story_v_out_420051", "420051095", "story_v_out_420051.awb")

						arg_398_1:RecordAudio("420051095", var_401_24)
						arg_398_1:RecordAudio("420051095", var_401_24)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_420051", "420051095", "story_v_out_420051.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_420051", "420051095", "story_v_out_420051.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_25 = math.max(var_401_16, arg_398_1.talkMaxDuration)

			if var_401_15 <= arg_398_1.time_ and arg_398_1.time_ < var_401_15 + var_401_25 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_15) / var_401_25

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_15 + var_401_25 and arg_398_1.time_ < var_401_15 + var_401_25 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play420051096 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 420051096
		arg_402_1.duration_ = 3.57

		local var_402_0 = {
			zh = 1.999999999999,
			ja = 3.566
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play420051097(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["1061ui_story"].transform
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.var_.moveOldPos1061ui_story = var_405_0.localPosition
			end

			local var_405_2 = 0.001

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_2 then
				local var_405_3 = (arg_402_1.time_ - var_405_1) / var_405_2
				local var_405_4 = Vector3.New(-0.7, -1.18, -6.15)

				var_405_0.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos1061ui_story, var_405_4, var_405_3)

				local var_405_5 = manager.ui.mainCamera.transform.position - var_405_0.position

				var_405_0.forward = Vector3.New(var_405_5.x, var_405_5.y, var_405_5.z)

				local var_405_6 = var_405_0.localEulerAngles

				var_405_6.z = 0
				var_405_6.x = 0
				var_405_0.localEulerAngles = var_405_6
			end

			if arg_402_1.time_ >= var_405_1 + var_405_2 and arg_402_1.time_ < var_405_1 + var_405_2 + arg_405_0 then
				var_405_0.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_405_7 = manager.ui.mainCamera.transform.position - var_405_0.position

				var_405_0.forward = Vector3.New(var_405_7.x, var_405_7.y, var_405_7.z)

				local var_405_8 = var_405_0.localEulerAngles

				var_405_8.z = 0
				var_405_8.x = 0
				var_405_0.localEulerAngles = var_405_8
			end

			local var_405_9 = arg_402_1.actors_["1085ui_story"].transform
			local var_405_10 = 0

			if var_405_10 < arg_402_1.time_ and arg_402_1.time_ <= var_405_10 + arg_405_0 then
				arg_402_1.var_.moveOldPos1085ui_story = var_405_9.localPosition
			end

			local var_405_11 = 0.001

			if var_405_10 <= arg_402_1.time_ and arg_402_1.time_ < var_405_10 + var_405_11 then
				local var_405_12 = (arg_402_1.time_ - var_405_10) / var_405_11
				local var_405_13 = Vector3.New(0.75, -1.01, -5.83)

				var_405_9.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos1085ui_story, var_405_13, var_405_12)

				local var_405_14 = manager.ui.mainCamera.transform.position - var_405_9.position

				var_405_9.forward = Vector3.New(var_405_14.x, var_405_14.y, var_405_14.z)

				local var_405_15 = var_405_9.localEulerAngles

				var_405_15.z = 0
				var_405_15.x = 0
				var_405_9.localEulerAngles = var_405_15
			end

			if arg_402_1.time_ >= var_405_10 + var_405_11 and arg_402_1.time_ < var_405_10 + var_405_11 + arg_405_0 then
				var_405_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_405_16 = manager.ui.mainCamera.transform.position - var_405_9.position

				var_405_9.forward = Vector3.New(var_405_16.x, var_405_16.y, var_405_16.z)

				local var_405_17 = var_405_9.localEulerAngles

				var_405_17.z = 0
				var_405_17.x = 0
				var_405_9.localEulerAngles = var_405_17
			end

			local var_405_18 = arg_402_1.actors_["1085ui_story"]
			local var_405_19 = 0

			if var_405_19 < arg_402_1.time_ and arg_402_1.time_ <= var_405_19 + arg_405_0 and not isNil(var_405_18) and arg_402_1.var_.characterEffect1085ui_story == nil then
				arg_402_1.var_.characterEffect1085ui_story = var_405_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_20 = 0.200000002980232

			if var_405_19 <= arg_402_1.time_ and arg_402_1.time_ < var_405_19 + var_405_20 and not isNil(var_405_18) then
				local var_405_21 = (arg_402_1.time_ - var_405_19) / var_405_20

				if arg_402_1.var_.characterEffect1085ui_story and not isNil(var_405_18) then
					arg_402_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= var_405_19 + var_405_20 and arg_402_1.time_ < var_405_19 + var_405_20 + arg_405_0 and not isNil(var_405_18) and arg_402_1.var_.characterEffect1085ui_story then
				arg_402_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_405_22 = arg_402_1.actors_["1061ui_story"]
			local var_405_23 = 0

			if var_405_23 < arg_402_1.time_ and arg_402_1.time_ <= var_405_23 + arg_405_0 and not isNil(var_405_22) and arg_402_1.var_.characterEffect1061ui_story == nil then
				arg_402_1.var_.characterEffect1061ui_story = var_405_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_24 = 0.200000002980232

			if var_405_23 <= arg_402_1.time_ and arg_402_1.time_ < var_405_23 + var_405_24 and not isNil(var_405_22) then
				local var_405_25 = (arg_402_1.time_ - var_405_23) / var_405_24

				if arg_402_1.var_.characterEffect1061ui_story and not isNil(var_405_22) then
					local var_405_26 = Mathf.Lerp(0, 0.5, var_405_25)

					arg_402_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1061ui_story.fillRatio = var_405_26
				end
			end

			if arg_402_1.time_ >= var_405_23 + var_405_24 and arg_402_1.time_ < var_405_23 + var_405_24 + arg_405_0 and not isNil(var_405_22) and arg_402_1.var_.characterEffect1061ui_story then
				local var_405_27 = 0.5

				arg_402_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1061ui_story.fillRatio = var_405_27
			end

			local var_405_28 = 0

			if var_405_28 < arg_402_1.time_ and arg_402_1.time_ <= var_405_28 + arg_405_0 then
				arg_402_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_405_29 = 0

			if var_405_29 < arg_402_1.time_ and arg_402_1.time_ <= var_405_29 + arg_405_0 then
				arg_402_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_405_30 = 0
			local var_405_31 = 0.15

			if var_405_30 < arg_402_1.time_ and arg_402_1.time_ <= var_405_30 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_32 = arg_402_1:FormatText(StoryNameCfg[328].name)

				arg_402_1.leftNameTxt_.text = var_405_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_33 = arg_402_1:GetWordFromCfg(420051096)
				local var_405_34 = arg_402_1:FormatText(var_405_33.content)

				arg_402_1.text_.text = var_405_34

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_35 = 6
				local var_405_36 = utf8.len(var_405_34)
				local var_405_37 = var_405_35 <= 0 and var_405_31 or var_405_31 * (var_405_36 / var_405_35)

				if var_405_37 > 0 and var_405_31 < var_405_37 then
					arg_402_1.talkMaxDuration = var_405_37

					if var_405_37 + var_405_30 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_37 + var_405_30
					end
				end

				arg_402_1.text_.text = var_405_34
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051096", "story_v_out_420051.awb") ~= 0 then
					local var_405_38 = manager.audio:GetVoiceLength("story_v_out_420051", "420051096", "story_v_out_420051.awb") / 1000

					if var_405_38 + var_405_30 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_38 + var_405_30
					end

					if var_405_33.prefab_name ~= "" and arg_402_1.actors_[var_405_33.prefab_name] ~= nil then
						local var_405_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_33.prefab_name].transform, "story_v_out_420051", "420051096", "story_v_out_420051.awb")

						arg_402_1:RecordAudio("420051096", var_405_39)
						arg_402_1:RecordAudio("420051096", var_405_39)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_420051", "420051096", "story_v_out_420051.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_420051", "420051096", "story_v_out_420051.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_40 = math.max(var_405_31, arg_402_1.talkMaxDuration)

			if var_405_30 <= arg_402_1.time_ and arg_402_1.time_ < var_405_30 + var_405_40 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_30) / var_405_40

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_30 + var_405_40 and arg_402_1.time_ < var_405_30 + var_405_40 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_402_1:InitPlayNodeList()
	end,
	Play420051097 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 420051097
		arg_406_1.duration_ = 14.9

		local var_406_0 = {
			zh = 9.066,
			ja = 14.9
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play420051098(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1061ui_story"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1061ui_story == nil then
				arg_406_1.var_.characterEffect1061ui_story = var_409_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_2 = 0.200000002980232

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.characterEffect1061ui_story and not isNil(var_409_0) then
					arg_406_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1061ui_story then
				arg_406_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_409_4 = arg_406_1.actors_["1085ui_story"]
			local var_409_5 = 0

			if var_409_5 < arg_406_1.time_ and arg_406_1.time_ <= var_409_5 + arg_409_0 and not isNil(var_409_4) and arg_406_1.var_.characterEffect1085ui_story == nil then
				arg_406_1.var_.characterEffect1085ui_story = var_409_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_6 = 0.200000002980232

			if var_409_5 <= arg_406_1.time_ and arg_406_1.time_ < var_409_5 + var_409_6 and not isNil(var_409_4) then
				local var_409_7 = (arg_406_1.time_ - var_409_5) / var_409_6

				if arg_406_1.var_.characterEffect1085ui_story and not isNil(var_409_4) then
					local var_409_8 = Mathf.Lerp(0, 0.5, var_409_7)

					arg_406_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_406_1.var_.characterEffect1085ui_story.fillRatio = var_409_8
				end
			end

			if arg_406_1.time_ >= var_409_5 + var_409_6 and arg_406_1.time_ < var_409_5 + var_409_6 + arg_409_0 and not isNil(var_409_4) and arg_406_1.var_.characterEffect1085ui_story then
				local var_409_9 = 0.5

				arg_406_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_406_1.var_.characterEffect1085ui_story.fillRatio = var_409_9
			end

			local var_409_10 = 0
			local var_409_11 = 0.85

			if var_409_10 < arg_406_1.time_ and arg_406_1.time_ <= var_409_10 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_12 = arg_406_1:FormatText(StoryNameCfg[612].name)

				arg_406_1.leftNameTxt_.text = var_409_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_13 = arg_406_1:GetWordFromCfg(420051097)
				local var_409_14 = arg_406_1:FormatText(var_409_13.content)

				arg_406_1.text_.text = var_409_14

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_15 = 34
				local var_409_16 = utf8.len(var_409_14)
				local var_409_17 = var_409_15 <= 0 and var_409_11 or var_409_11 * (var_409_16 / var_409_15)

				if var_409_17 > 0 and var_409_11 < var_409_17 then
					arg_406_1.talkMaxDuration = var_409_17

					if var_409_17 + var_409_10 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_17 + var_409_10
					end
				end

				arg_406_1.text_.text = var_409_14
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051097", "story_v_out_420051.awb") ~= 0 then
					local var_409_18 = manager.audio:GetVoiceLength("story_v_out_420051", "420051097", "story_v_out_420051.awb") / 1000

					if var_409_18 + var_409_10 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_18 + var_409_10
					end

					if var_409_13.prefab_name ~= "" and arg_406_1.actors_[var_409_13.prefab_name] ~= nil then
						local var_409_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_13.prefab_name].transform, "story_v_out_420051", "420051097", "story_v_out_420051.awb")

						arg_406_1:RecordAudio("420051097", var_409_19)
						arg_406_1:RecordAudio("420051097", var_409_19)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_420051", "420051097", "story_v_out_420051.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_420051", "420051097", "story_v_out_420051.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_20 = math.max(var_409_11, arg_406_1.talkMaxDuration)

			if var_409_10 <= arg_406_1.time_ and arg_406_1.time_ < var_409_10 + var_409_20 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_10) / var_409_20

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_10 + var_409_20 and arg_406_1.time_ < var_409_10 + var_409_20 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play420051098 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 420051098
		arg_410_1.duration_ = 12.2

		local var_410_0 = {
			zh = 8,
			ja = 12.2
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play420051099(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0
			local var_413_1 = 1.025

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_2 = arg_410_1:FormatText(StoryNameCfg[612].name)

				arg_410_1.leftNameTxt_.text = var_413_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_3 = arg_410_1:GetWordFromCfg(420051098)
				local var_413_4 = arg_410_1:FormatText(var_413_3.content)

				arg_410_1.text_.text = var_413_4

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 41
				local var_413_6 = utf8.len(var_413_4)
				local var_413_7 = var_413_5 <= 0 and var_413_1 or var_413_1 * (var_413_6 / var_413_5)

				if var_413_7 > 0 and var_413_1 < var_413_7 then
					arg_410_1.talkMaxDuration = var_413_7

					if var_413_7 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_7 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_4
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051098", "story_v_out_420051.awb") ~= 0 then
					local var_413_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051098", "story_v_out_420051.awb") / 1000

					if var_413_8 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_8 + var_413_0
					end

					if var_413_3.prefab_name ~= "" and arg_410_1.actors_[var_413_3.prefab_name] ~= nil then
						local var_413_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_3.prefab_name].transform, "story_v_out_420051", "420051098", "story_v_out_420051.awb")

						arg_410_1:RecordAudio("420051098", var_413_9)
						arg_410_1:RecordAudio("420051098", var_413_9)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_420051", "420051098", "story_v_out_420051.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_420051", "420051098", "story_v_out_420051.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_10 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_10 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_10

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_10 and arg_410_1.time_ < var_413_0 + var_413_10 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play420051099 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 420051099
		arg_414_1.duration_ = 4.73

		local var_414_0 = {
			zh = 3.9,
			ja = 4.733
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play420051100(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 0.5

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_2 = arg_414_1:FormatText(StoryNameCfg[612].name)

				arg_414_1.leftNameTxt_.text = var_417_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_3 = arg_414_1:GetWordFromCfg(420051099)
				local var_417_4 = arg_414_1:FormatText(var_417_3.content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 20
				local var_417_6 = utf8.len(var_417_4)
				local var_417_7 = var_417_5 <= 0 and var_417_1 or var_417_1 * (var_417_6 / var_417_5)

				if var_417_7 > 0 and var_417_1 < var_417_7 then
					arg_414_1.talkMaxDuration = var_417_7

					if var_417_7 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_4
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051099", "story_v_out_420051.awb") ~= 0 then
					local var_417_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051099", "story_v_out_420051.awb") / 1000

					if var_417_8 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_8 + var_417_0
					end

					if var_417_3.prefab_name ~= "" and arg_414_1.actors_[var_417_3.prefab_name] ~= nil then
						local var_417_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_3.prefab_name].transform, "story_v_out_420051", "420051099", "story_v_out_420051.awb")

						arg_414_1:RecordAudio("420051099", var_417_9)
						arg_414_1:RecordAudio("420051099", var_417_9)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_420051", "420051099", "story_v_out_420051.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_420051", "420051099", "story_v_out_420051.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_10 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_10 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_10

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_10 and arg_414_1.time_ < var_417_0 + var_417_10 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play420051100 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 420051100
		arg_418_1.duration_ = 10.17

		local var_418_0 = {
			zh = 7.9,
			ja = 10.166
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play420051101(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = "ST0504a"

			if arg_418_1.bgs_[var_421_0] == nil then
				local var_421_1 = Object.Instantiate(arg_418_1.paintGo_)

				var_421_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_421_0)
				var_421_1.name = var_421_0
				var_421_1.transform.parent = arg_418_1.stage_.transform
				var_421_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_418_1.bgs_[var_421_0] = var_421_1
			end

			local var_421_2 = 2

			if var_421_2 < arg_418_1.time_ and arg_418_1.time_ <= var_421_2 + arg_421_0 then
				local var_421_3 = manager.ui.mainCamera.transform.localPosition
				local var_421_4 = Vector3.New(0, 0, 10) + Vector3.New(var_421_3.x, var_421_3.y, 0)
				local var_421_5 = arg_418_1.bgs_.ST0504a

				var_421_5.transform.localPosition = var_421_4
				var_421_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_421_6 = var_421_5:GetComponent("SpriteRenderer")

				if var_421_6 and var_421_6.sprite then
					local var_421_7 = (var_421_5.transform.localPosition - var_421_3).z
					local var_421_8 = manager.ui.mainCameraCom_
					local var_421_9 = 2 * var_421_7 * Mathf.Tan(var_421_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_421_10 = var_421_9 * var_421_8.aspect
					local var_421_11 = var_421_6.sprite.bounds.size.x
					local var_421_12 = var_421_6.sprite.bounds.size.y
					local var_421_13 = var_421_10 / var_421_11
					local var_421_14 = var_421_9 / var_421_12
					local var_421_15 = var_421_14 < var_421_13 and var_421_13 or var_421_14

					var_421_5.transform.localScale = Vector3.New(var_421_15, var_421_15, 0)
				end

				for iter_421_0, iter_421_1 in pairs(arg_418_1.bgs_) do
					if iter_421_0 ~= "ST0504a" then
						iter_421_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_421_16 = 4

			if var_421_16 < arg_418_1.time_ and arg_418_1.time_ <= var_421_16 + arg_421_0 then
				arg_418_1.allBtn_.enabled = false
			end

			local var_421_17 = 0.3

			if arg_418_1.time_ >= var_421_16 + var_421_17 and arg_418_1.time_ < var_421_16 + var_421_17 + arg_421_0 then
				arg_418_1.allBtn_.enabled = true
			end

			local var_421_18 = 0

			if var_421_18 < arg_418_1.time_ and arg_418_1.time_ <= var_421_18 + arg_421_0 then
				arg_418_1.mask_.enabled = true
				arg_418_1.mask_.raycastTarget = true

				arg_418_1:SetGaussion(false)
			end

			local var_421_19 = 2

			if var_421_18 <= arg_418_1.time_ and arg_418_1.time_ < var_421_18 + var_421_19 then
				local var_421_20 = (arg_418_1.time_ - var_421_18) / var_421_19
				local var_421_21 = Color.New(0, 0, 0)

				var_421_21.a = Mathf.Lerp(0, 1, var_421_20)
				arg_418_1.mask_.color = var_421_21
			end

			if arg_418_1.time_ >= var_421_18 + var_421_19 and arg_418_1.time_ < var_421_18 + var_421_19 + arg_421_0 then
				local var_421_22 = Color.New(0, 0, 0)

				var_421_22.a = 1
				arg_418_1.mask_.color = var_421_22
			end

			local var_421_23 = 2

			if var_421_23 < arg_418_1.time_ and arg_418_1.time_ <= var_421_23 + arg_421_0 then
				arg_418_1.mask_.enabled = true
				arg_418_1.mask_.raycastTarget = true

				arg_418_1:SetGaussion(false)
			end

			local var_421_24 = 2

			if var_421_23 <= arg_418_1.time_ and arg_418_1.time_ < var_421_23 + var_421_24 then
				local var_421_25 = (arg_418_1.time_ - var_421_23) / var_421_24
				local var_421_26 = Color.New(0, 0, 0)

				var_421_26.a = Mathf.Lerp(1, 0, var_421_25)
				arg_418_1.mask_.color = var_421_26
			end

			if arg_418_1.time_ >= var_421_23 + var_421_24 and arg_418_1.time_ < var_421_23 + var_421_24 + arg_421_0 then
				local var_421_27 = Color.New(0, 0, 0)
				local var_421_28 = 0

				arg_418_1.mask_.enabled = false
				var_421_27.a = var_421_28
				arg_418_1.mask_.color = var_421_27
			end

			local var_421_29 = arg_418_1.actors_["1061ui_story"].transform
			local var_421_30 = 2

			if var_421_30 < arg_418_1.time_ and arg_418_1.time_ <= var_421_30 + arg_421_0 then
				arg_418_1.var_.moveOldPos1061ui_story = var_421_29.localPosition
			end

			local var_421_31 = 0.001

			if var_421_30 <= arg_418_1.time_ and arg_418_1.time_ < var_421_30 + var_421_31 then
				local var_421_32 = (arg_418_1.time_ - var_421_30) / var_421_31
				local var_421_33 = Vector3.New(0, 100, 0)

				var_421_29.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1061ui_story, var_421_33, var_421_32)

				local var_421_34 = manager.ui.mainCamera.transform.position - var_421_29.position

				var_421_29.forward = Vector3.New(var_421_34.x, var_421_34.y, var_421_34.z)

				local var_421_35 = var_421_29.localEulerAngles

				var_421_35.z = 0
				var_421_35.x = 0
				var_421_29.localEulerAngles = var_421_35
			end

			if arg_418_1.time_ >= var_421_30 + var_421_31 and arg_418_1.time_ < var_421_30 + var_421_31 + arg_421_0 then
				var_421_29.localPosition = Vector3.New(0, 100, 0)

				local var_421_36 = manager.ui.mainCamera.transform.position - var_421_29.position

				var_421_29.forward = Vector3.New(var_421_36.x, var_421_36.y, var_421_36.z)

				local var_421_37 = var_421_29.localEulerAngles

				var_421_37.z = 0
				var_421_37.x = 0
				var_421_29.localEulerAngles = var_421_37
			end

			local var_421_38 = arg_418_1.actors_["1085ui_story"].transform
			local var_421_39 = 2

			if var_421_39 < arg_418_1.time_ and arg_418_1.time_ <= var_421_39 + arg_421_0 then
				arg_418_1.var_.moveOldPos1085ui_story = var_421_38.localPosition
			end

			local var_421_40 = 0.001

			if var_421_39 <= arg_418_1.time_ and arg_418_1.time_ < var_421_39 + var_421_40 then
				local var_421_41 = (arg_418_1.time_ - var_421_39) / var_421_40
				local var_421_42 = Vector3.New(0, 100, 0)

				var_421_38.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1085ui_story, var_421_42, var_421_41)

				local var_421_43 = manager.ui.mainCamera.transform.position - var_421_38.position

				var_421_38.forward = Vector3.New(var_421_43.x, var_421_43.y, var_421_43.z)

				local var_421_44 = var_421_38.localEulerAngles

				var_421_44.z = 0
				var_421_44.x = 0
				var_421_38.localEulerAngles = var_421_44
			end

			if arg_418_1.time_ >= var_421_39 + var_421_40 and arg_418_1.time_ < var_421_39 + var_421_40 + arg_421_0 then
				var_421_38.localPosition = Vector3.New(0, 100, 0)

				local var_421_45 = manager.ui.mainCamera.transform.position - var_421_38.position

				var_421_38.forward = Vector3.New(var_421_45.x, var_421_45.y, var_421_45.z)

				local var_421_46 = var_421_38.localEulerAngles

				var_421_46.z = 0
				var_421_46.x = 0
				var_421_38.localEulerAngles = var_421_46
			end

			local var_421_47 = arg_418_1.actors_["404001ui_story"].transform
			local var_421_48 = 3.79999999701977

			if var_421_48 < arg_418_1.time_ and arg_418_1.time_ <= var_421_48 + arg_421_0 then
				arg_418_1.var_.moveOldPos404001ui_story = var_421_47.localPosition
			end

			local var_421_49 = 0.001

			if var_421_48 <= arg_418_1.time_ and arg_418_1.time_ < var_421_48 + var_421_49 then
				local var_421_50 = (arg_418_1.time_ - var_421_48) / var_421_49
				local var_421_51 = Vector3.New(0, -1.55, -5.5)

				var_421_47.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos404001ui_story, var_421_51, var_421_50)

				local var_421_52 = manager.ui.mainCamera.transform.position - var_421_47.position

				var_421_47.forward = Vector3.New(var_421_52.x, var_421_52.y, var_421_52.z)

				local var_421_53 = var_421_47.localEulerAngles

				var_421_53.z = 0
				var_421_53.x = 0
				var_421_47.localEulerAngles = var_421_53
			end

			if arg_418_1.time_ >= var_421_48 + var_421_49 and arg_418_1.time_ < var_421_48 + var_421_49 + arg_421_0 then
				var_421_47.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_421_54 = manager.ui.mainCamera.transform.position - var_421_47.position

				var_421_47.forward = Vector3.New(var_421_54.x, var_421_54.y, var_421_54.z)

				local var_421_55 = var_421_47.localEulerAngles

				var_421_55.z = 0
				var_421_55.x = 0
				var_421_47.localEulerAngles = var_421_55
			end

			local var_421_56 = arg_418_1.actors_["404001ui_story"]
			local var_421_57 = 3.79999999701977

			if var_421_57 < arg_418_1.time_ and arg_418_1.time_ <= var_421_57 + arg_421_0 and not isNil(var_421_56) and arg_418_1.var_.characterEffect404001ui_story == nil then
				arg_418_1.var_.characterEffect404001ui_story = var_421_56:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_58 = 0.200000002980232

			if var_421_57 <= arg_418_1.time_ and arg_418_1.time_ < var_421_57 + var_421_58 and not isNil(var_421_56) then
				local var_421_59 = (arg_418_1.time_ - var_421_57) / var_421_58

				if arg_418_1.var_.characterEffect404001ui_story and not isNil(var_421_56) then
					arg_418_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= var_421_57 + var_421_58 and arg_418_1.time_ < var_421_57 + var_421_58 + arg_421_0 and not isNil(var_421_56) and arg_418_1.var_.characterEffect404001ui_story then
				arg_418_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_421_60 = 3.79999999701977

			if var_421_60 < arg_418_1.time_ and arg_418_1.time_ <= var_421_60 + arg_421_0 then
				arg_418_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_421_61 = 3.79999999701977

			if var_421_61 < arg_418_1.time_ and arg_418_1.time_ <= var_421_61 + arg_421_0 then
				arg_418_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_421_62 = 0.366666666666667
			local var_421_63 = 1

			if var_421_62 < arg_418_1.time_ and arg_418_1.time_ <= var_421_62 + arg_421_0 then
				local var_421_64 = "stop"
				local var_421_65 = "effect"

				arg_418_1:AudioAction(var_421_64, var_421_65, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_421_66 = 0
			local var_421_67 = 0.2

			if var_421_66 < arg_418_1.time_ and arg_418_1.time_ <= var_421_66 + arg_421_0 then
				local var_421_68 = "play"
				local var_421_69 = "music"

				arg_418_1:AudioAction(var_421_68, var_421_69, "ui_battle", "ui_battle_stopbgm", "")

				local var_421_70 = ""
				local var_421_71 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_421_71 ~= "" then
					if arg_418_1.bgmTxt_.text ~= var_421_71 and arg_418_1.bgmTxt_.text ~= "" then
						if arg_418_1.bgmTxt2_.text ~= "" then
							arg_418_1.bgmTxt_.text = arg_418_1.bgmTxt2_.text
						end

						arg_418_1.bgmTxt2_.text = var_421_71

						arg_418_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_418_1.bgmTxt_.text = var_421_71
						arg_418_1.bgmTxt2_.text = var_421_71
					end

					if arg_418_1.bgmTimer then
						arg_418_1.bgmTimer:Stop()

						arg_418_1.bgmTimer = nil
					end

					if arg_418_1.settingData.show_music_name == 1 then
						arg_418_1.musicController:SetSelectedState("show")
						arg_418_1.musicAnimator_:Play("open", 0, 0)

						if arg_418_1.settingData.music_time ~= 0 then
							arg_418_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_418_1.settingData.music_time), function()
								if arg_418_1 == nil or isNil(arg_418_1.bgmTxt_) then
									return
								end

								arg_418_1.musicController:SetSelectedState("hide")
								arg_418_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_421_72 = 2
			local var_421_73 = 1

			if var_421_72 < arg_418_1.time_ and arg_418_1.time_ <= var_421_72 + arg_421_0 then
				local var_421_74 = "play"
				local var_421_75 = "music"

				arg_418_1:AudioAction(var_421_74, var_421_75, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_421_76 = ""
				local var_421_77 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if var_421_77 ~= "" then
					if arg_418_1.bgmTxt_.text ~= var_421_77 and arg_418_1.bgmTxt_.text ~= "" then
						if arg_418_1.bgmTxt2_.text ~= "" then
							arg_418_1.bgmTxt_.text = arg_418_1.bgmTxt2_.text
						end

						arg_418_1.bgmTxt2_.text = var_421_77

						arg_418_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_418_1.bgmTxt_.text = var_421_77
						arg_418_1.bgmTxt2_.text = var_421_77
					end

					if arg_418_1.bgmTimer then
						arg_418_1.bgmTimer:Stop()

						arg_418_1.bgmTimer = nil
					end

					if arg_418_1.settingData.show_music_name == 1 then
						arg_418_1.musicController:SetSelectedState("show")
						arg_418_1.musicAnimator_:Play("open", 0, 0)

						if arg_418_1.settingData.music_time ~= 0 then
							arg_418_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_418_1.settingData.music_time), function()
								if arg_418_1 == nil or isNil(arg_418_1.bgmTxt_) then
									return
								end

								arg_418_1.musicController:SetSelectedState("hide")
								arg_418_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_418_1.frameCnt_ <= 1 then
				arg_418_1.dialog_:SetActive(false)
			end

			local var_421_78 = 4
			local var_421_79 = 0.45

			if var_421_78 < arg_418_1.time_ and arg_418_1.time_ <= var_421_78 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0

				arg_418_1.dialog_:SetActive(true)

				arg_418_1.dialogCg_.alpha = 0

				local var_421_80 = LeanTween.value(arg_418_1.dialog_, 0, 1, 0.3)

				var_421_80:setOnUpdate(LuaHelper.FloatAction(function(arg_424_0)
					arg_418_1.dialogCg_.alpha = arg_424_0
				end))
				var_421_80:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_418_1.dialog_)
					var_421_80:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_418_1.duration_ = arg_418_1.duration_ + 0.3

				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_81 = arg_418_1:FormatText(StoryNameCfg[668].name)

				arg_418_1.leftNameTxt_.text = var_421_81

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_82 = arg_418_1:GetWordFromCfg(420051100)
				local var_421_83 = arg_418_1:FormatText(var_421_82.content)

				arg_418_1.text_.text = var_421_83

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_84 = 18
				local var_421_85 = utf8.len(var_421_83)
				local var_421_86 = var_421_84 <= 0 and var_421_79 or var_421_79 * (var_421_85 / var_421_84)

				if var_421_86 > 0 and var_421_79 < var_421_86 then
					arg_418_1.talkMaxDuration = var_421_86
					var_421_78 = var_421_78 + 0.3

					if var_421_86 + var_421_78 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_86 + var_421_78
					end
				end

				arg_418_1.text_.text = var_421_83
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051100", "story_v_out_420051.awb") ~= 0 then
					local var_421_87 = manager.audio:GetVoiceLength("story_v_out_420051", "420051100", "story_v_out_420051.awb") / 1000

					if var_421_87 + var_421_78 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_87 + var_421_78
					end

					if var_421_82.prefab_name ~= "" and arg_418_1.actors_[var_421_82.prefab_name] ~= nil then
						local var_421_88 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_82.prefab_name].transform, "story_v_out_420051", "420051100", "story_v_out_420051.awb")

						arg_418_1:RecordAudio("420051100", var_421_88)
						arg_418_1:RecordAudio("420051100", var_421_88)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_420051", "420051100", "story_v_out_420051.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_420051", "420051100", "story_v_out_420051.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_89 = var_421_78 + 0.3
			local var_421_90 = math.max(var_421_79, arg_418_1.talkMaxDuration)

			if var_421_89 <= arg_418_1.time_ and arg_418_1.time_ < var_421_89 + var_421_90 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_89) / var_421_90

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_89 + var_421_90 and arg_418_1.time_ < var_421_89 + var_421_90 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_418_1:InitPlayNodeList()
	end,
	Play420051101 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 420051101
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play420051102(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["404001ui_story"].transform
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.var_.moveOldPos404001ui_story = var_429_0.localPosition
			end

			local var_429_2 = 0.001

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2
				local var_429_4 = Vector3.New(0, 100, 0)

				var_429_0.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos404001ui_story, var_429_4, var_429_3)

				local var_429_5 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_5.x, var_429_5.y, var_429_5.z)

				local var_429_6 = var_429_0.localEulerAngles

				var_429_6.z = 0
				var_429_6.x = 0
				var_429_0.localEulerAngles = var_429_6
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 then
				var_429_0.localPosition = Vector3.New(0, 100, 0)

				local var_429_7 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_7.x, var_429_7.y, var_429_7.z)

				local var_429_8 = var_429_0.localEulerAngles

				var_429_8.z = 0
				var_429_8.x = 0
				var_429_0.localEulerAngles = var_429_8
			end

			local var_429_9 = 0
			local var_429_10 = 1.175

			if var_429_9 < arg_426_1.time_ and arg_426_1.time_ <= var_429_9 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_11 = arg_426_1:GetWordFromCfg(420051101)
				local var_429_12 = arg_426_1:FormatText(var_429_11.content)

				arg_426_1.text_.text = var_429_12

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_13 = 47
				local var_429_14 = utf8.len(var_429_12)
				local var_429_15 = var_429_13 <= 0 and var_429_10 or var_429_10 * (var_429_14 / var_429_13)

				if var_429_15 > 0 and var_429_10 < var_429_15 then
					arg_426_1.talkMaxDuration = var_429_15

					if var_429_15 + var_429_9 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_15 + var_429_9
					end
				end

				arg_426_1.text_.text = var_429_12
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_16 = math.max(var_429_10, arg_426_1.talkMaxDuration)

			if var_429_9 <= arg_426_1.time_ and arg_426_1.time_ < var_429_9 + var_429_16 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_9) / var_429_16

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_9 + var_429_16 and arg_426_1.time_ < var_429_9 + var_429_16 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play420051102 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 420051102
		arg_430_1.duration_ = 14.93

		local var_430_0 = {
			zh = 9.7,
			ja = 14.933
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play420051103(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["404001ui_story"].transform
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 then
				arg_430_1.var_.moveOldPos404001ui_story = var_433_0.localPosition
			end

			local var_433_2 = 0.001

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2
				local var_433_4 = Vector3.New(0, -1.55, -5.5)

				var_433_0.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos404001ui_story, var_433_4, var_433_3)

				local var_433_5 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_5.x, var_433_5.y, var_433_5.z)

				local var_433_6 = var_433_0.localEulerAngles

				var_433_6.z = 0
				var_433_6.x = 0
				var_433_0.localEulerAngles = var_433_6
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 then
				var_433_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_433_7 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_7.x, var_433_7.y, var_433_7.z)

				local var_433_8 = var_433_0.localEulerAngles

				var_433_8.z = 0
				var_433_8.x = 0
				var_433_0.localEulerAngles = var_433_8
			end

			local var_433_9 = arg_430_1.actors_["404001ui_story"]
			local var_433_10 = 0

			if var_433_10 < arg_430_1.time_ and arg_430_1.time_ <= var_433_10 + arg_433_0 and not isNil(var_433_9) and arg_430_1.var_.characterEffect404001ui_story == nil then
				arg_430_1.var_.characterEffect404001ui_story = var_433_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_11 = 0.200000002980232

			if var_433_10 <= arg_430_1.time_ and arg_430_1.time_ < var_433_10 + var_433_11 and not isNil(var_433_9) then
				local var_433_12 = (arg_430_1.time_ - var_433_10) / var_433_11

				if arg_430_1.var_.characterEffect404001ui_story and not isNil(var_433_9) then
					arg_430_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= var_433_10 + var_433_11 and arg_430_1.time_ < var_433_10 + var_433_11 + arg_433_0 and not isNil(var_433_9) and arg_430_1.var_.characterEffect404001ui_story then
				arg_430_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_433_13 = 0

			if var_433_13 < arg_430_1.time_ and arg_430_1.time_ <= var_433_13 + arg_433_0 then
				arg_430_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_433_14 = 0

			if var_433_14 < arg_430_1.time_ and arg_430_1.time_ <= var_433_14 + arg_433_0 then
				arg_430_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_433_15 = 0
			local var_433_16 = 1.2

			if var_433_15 < arg_430_1.time_ and arg_430_1.time_ <= var_433_15 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_17 = arg_430_1:FormatText(StoryNameCfg[668].name)

				arg_430_1.leftNameTxt_.text = var_433_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_18 = arg_430_1:GetWordFromCfg(420051102)
				local var_433_19 = arg_430_1:FormatText(var_433_18.content)

				arg_430_1.text_.text = var_433_19

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_20 = 48
				local var_433_21 = utf8.len(var_433_19)
				local var_433_22 = var_433_20 <= 0 and var_433_16 or var_433_16 * (var_433_21 / var_433_20)

				if var_433_22 > 0 and var_433_16 < var_433_22 then
					arg_430_1.talkMaxDuration = var_433_22

					if var_433_22 + var_433_15 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_22 + var_433_15
					end
				end

				arg_430_1.text_.text = var_433_19
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051102", "story_v_out_420051.awb") ~= 0 then
					local var_433_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051102", "story_v_out_420051.awb") / 1000

					if var_433_23 + var_433_15 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_23 + var_433_15
					end

					if var_433_18.prefab_name ~= "" and arg_430_1.actors_[var_433_18.prefab_name] ~= nil then
						local var_433_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_18.prefab_name].transform, "story_v_out_420051", "420051102", "story_v_out_420051.awb")

						arg_430_1:RecordAudio("420051102", var_433_24)
						arg_430_1:RecordAudio("420051102", var_433_24)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_420051", "420051102", "story_v_out_420051.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_420051", "420051102", "story_v_out_420051.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_25 = math.max(var_433_16, arg_430_1.talkMaxDuration)

			if var_433_15 <= arg_430_1.time_ and arg_430_1.time_ < var_433_15 + var_433_25 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_15) / var_433_25

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_15 + var_433_25 and arg_430_1.time_ < var_433_15 + var_433_25 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play420051103 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 420051103
		arg_434_1.duration_ = 2

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play420051104(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["404001ui_story"].transform
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.var_.moveOldPos404001ui_story = var_437_0.localPosition
			end

			local var_437_2 = 0.001

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2
				local var_437_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_437_0.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos404001ui_story, var_437_4, var_437_3)

				local var_437_5 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_5.x, var_437_5.y, var_437_5.z)

				local var_437_6 = var_437_0.localEulerAngles

				var_437_6.z = 0
				var_437_6.x = 0
				var_437_0.localEulerAngles = var_437_6
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 then
				var_437_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_437_7 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_7.x, var_437_7.y, var_437_7.z)

				local var_437_8 = var_437_0.localEulerAngles

				var_437_8.z = 0
				var_437_8.x = 0
				var_437_0.localEulerAngles = var_437_8
			end

			local var_437_9 = arg_434_1.actors_["1085ui_story"].transform
			local var_437_10 = 0

			if var_437_10 < arg_434_1.time_ and arg_434_1.time_ <= var_437_10 + arg_437_0 then
				arg_434_1.var_.moveOldPos1085ui_story = var_437_9.localPosition
			end

			local var_437_11 = 0.001

			if var_437_10 <= arg_434_1.time_ and arg_434_1.time_ < var_437_10 + var_437_11 then
				local var_437_12 = (arg_434_1.time_ - var_437_10) / var_437_11
				local var_437_13 = Vector3.New(0.75, -1.01, -5.83)

				var_437_9.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1085ui_story, var_437_13, var_437_12)

				local var_437_14 = manager.ui.mainCamera.transform.position - var_437_9.position

				var_437_9.forward = Vector3.New(var_437_14.x, var_437_14.y, var_437_14.z)

				local var_437_15 = var_437_9.localEulerAngles

				var_437_15.z = 0
				var_437_15.x = 0
				var_437_9.localEulerAngles = var_437_15
			end

			if arg_434_1.time_ >= var_437_10 + var_437_11 and arg_434_1.time_ < var_437_10 + var_437_11 + arg_437_0 then
				var_437_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_437_16 = manager.ui.mainCamera.transform.position - var_437_9.position

				var_437_9.forward = Vector3.New(var_437_16.x, var_437_16.y, var_437_16.z)

				local var_437_17 = var_437_9.localEulerAngles

				var_437_17.z = 0
				var_437_17.x = 0
				var_437_9.localEulerAngles = var_437_17
			end

			local var_437_18 = arg_434_1.actors_["1085ui_story"]
			local var_437_19 = 0

			if var_437_19 < arg_434_1.time_ and arg_434_1.time_ <= var_437_19 + arg_437_0 and not isNil(var_437_18) and arg_434_1.var_.characterEffect1085ui_story == nil then
				arg_434_1.var_.characterEffect1085ui_story = var_437_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_20 = 0.200000002980232

			if var_437_19 <= arg_434_1.time_ and arg_434_1.time_ < var_437_19 + var_437_20 and not isNil(var_437_18) then
				local var_437_21 = (arg_434_1.time_ - var_437_19) / var_437_20

				if arg_434_1.var_.characterEffect1085ui_story and not isNil(var_437_18) then
					arg_434_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= var_437_19 + var_437_20 and arg_434_1.time_ < var_437_19 + var_437_20 + arg_437_0 and not isNil(var_437_18) and arg_434_1.var_.characterEffect1085ui_story then
				arg_434_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_437_22 = arg_434_1.actors_["404001ui_story"]
			local var_437_23 = 0

			if var_437_23 < arg_434_1.time_ and arg_434_1.time_ <= var_437_23 + arg_437_0 and not isNil(var_437_22) and arg_434_1.var_.characterEffect404001ui_story == nil then
				arg_434_1.var_.characterEffect404001ui_story = var_437_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_24 = 0.200000002980232

			if var_437_23 <= arg_434_1.time_ and arg_434_1.time_ < var_437_23 + var_437_24 and not isNil(var_437_22) then
				local var_437_25 = (arg_434_1.time_ - var_437_23) / var_437_24

				if arg_434_1.var_.characterEffect404001ui_story and not isNil(var_437_22) then
					local var_437_26 = Mathf.Lerp(0, 0.5, var_437_25)

					arg_434_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_434_1.var_.characterEffect404001ui_story.fillRatio = var_437_26
				end
			end

			if arg_434_1.time_ >= var_437_23 + var_437_24 and arg_434_1.time_ < var_437_23 + var_437_24 + arg_437_0 and not isNil(var_437_22) and arg_434_1.var_.characterEffect404001ui_story then
				local var_437_27 = 0.5

				arg_434_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_434_1.var_.characterEffect404001ui_story.fillRatio = var_437_27
			end

			local var_437_28 = 0

			if var_437_28 < arg_434_1.time_ and arg_434_1.time_ <= var_437_28 + arg_437_0 then
				arg_434_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_437_29 = 0

			if var_437_29 < arg_434_1.time_ and arg_434_1.time_ <= var_437_29 + arg_437_0 then
				arg_434_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_437_30 = 0
			local var_437_31 = 0.175

			if var_437_30 < arg_434_1.time_ and arg_434_1.time_ <= var_437_30 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_32 = arg_434_1:FormatText(StoryNameCfg[328].name)

				arg_434_1.leftNameTxt_.text = var_437_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_33 = arg_434_1:GetWordFromCfg(420051103)
				local var_437_34 = arg_434_1:FormatText(var_437_33.content)

				arg_434_1.text_.text = var_437_34

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_35 = 7
				local var_437_36 = utf8.len(var_437_34)
				local var_437_37 = var_437_35 <= 0 and var_437_31 or var_437_31 * (var_437_36 / var_437_35)

				if var_437_37 > 0 and var_437_31 < var_437_37 then
					arg_434_1.talkMaxDuration = var_437_37

					if var_437_37 + var_437_30 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_37 + var_437_30
					end
				end

				arg_434_1.text_.text = var_437_34
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051103", "story_v_out_420051.awb") ~= 0 then
					local var_437_38 = manager.audio:GetVoiceLength("story_v_out_420051", "420051103", "story_v_out_420051.awb") / 1000

					if var_437_38 + var_437_30 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_38 + var_437_30
					end

					if var_437_33.prefab_name ~= "" and arg_434_1.actors_[var_437_33.prefab_name] ~= nil then
						local var_437_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_33.prefab_name].transform, "story_v_out_420051", "420051103", "story_v_out_420051.awb")

						arg_434_1:RecordAudio("420051103", var_437_39)
						arg_434_1:RecordAudio("420051103", var_437_39)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_420051", "420051103", "story_v_out_420051.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_420051", "420051103", "story_v_out_420051.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_40 = math.max(var_437_31, arg_434_1.talkMaxDuration)

			if var_437_30 <= arg_434_1.time_ and arg_434_1.time_ < var_437_30 + var_437_40 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_30) / var_437_40

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_30 + var_437_40 and arg_434_1.time_ < var_437_30 + var_437_40 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play420051104 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 420051104
		arg_438_1.duration_ = 5.8

		local var_438_0 = {
			zh = 5.366,
			ja = 5.8
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play420051105(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["404001ui_story"]
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect404001ui_story == nil then
				arg_438_1.var_.characterEffect404001ui_story = var_441_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.200000002980232

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 and not isNil(var_441_0) then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2

				if arg_438_1.var_.characterEffect404001ui_story and not isNil(var_441_0) then
					arg_438_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect404001ui_story then
				arg_438_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_441_4 = arg_438_1.actors_["1085ui_story"]
			local var_441_5 = 0

			if var_441_5 < arg_438_1.time_ and arg_438_1.time_ <= var_441_5 + arg_441_0 and not isNil(var_441_4) and arg_438_1.var_.characterEffect1085ui_story == nil then
				arg_438_1.var_.characterEffect1085ui_story = var_441_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_6 = 0.200000002980232

			if var_441_5 <= arg_438_1.time_ and arg_438_1.time_ < var_441_5 + var_441_6 and not isNil(var_441_4) then
				local var_441_7 = (arg_438_1.time_ - var_441_5) / var_441_6

				if arg_438_1.var_.characterEffect1085ui_story and not isNil(var_441_4) then
					local var_441_8 = Mathf.Lerp(0, 0.5, var_441_7)

					arg_438_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_438_1.var_.characterEffect1085ui_story.fillRatio = var_441_8
				end
			end

			if arg_438_1.time_ >= var_441_5 + var_441_6 and arg_438_1.time_ < var_441_5 + var_441_6 + arg_441_0 and not isNil(var_441_4) and arg_438_1.var_.characterEffect1085ui_story then
				local var_441_9 = 0.5

				arg_438_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_438_1.var_.characterEffect1085ui_story.fillRatio = var_441_9
			end

			local var_441_10 = 0

			if var_441_10 < arg_438_1.time_ and arg_438_1.time_ <= var_441_10 + arg_441_0 then
				arg_438_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_441_11 = 0
			local var_441_12 = 0.6

			if var_441_11 < arg_438_1.time_ and arg_438_1.time_ <= var_441_11 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_13 = arg_438_1:FormatText(StoryNameCfg[668].name)

				arg_438_1.leftNameTxt_.text = var_441_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_14 = arg_438_1:GetWordFromCfg(420051104)
				local var_441_15 = arg_438_1:FormatText(var_441_14.content)

				arg_438_1.text_.text = var_441_15

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_16 = 24
				local var_441_17 = utf8.len(var_441_15)
				local var_441_18 = var_441_16 <= 0 and var_441_12 or var_441_12 * (var_441_17 / var_441_16)

				if var_441_18 > 0 and var_441_12 < var_441_18 then
					arg_438_1.talkMaxDuration = var_441_18

					if var_441_18 + var_441_11 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_18 + var_441_11
					end
				end

				arg_438_1.text_.text = var_441_15
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051104", "story_v_out_420051.awb") ~= 0 then
					local var_441_19 = manager.audio:GetVoiceLength("story_v_out_420051", "420051104", "story_v_out_420051.awb") / 1000

					if var_441_19 + var_441_11 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_19 + var_441_11
					end

					if var_441_14.prefab_name ~= "" and arg_438_1.actors_[var_441_14.prefab_name] ~= nil then
						local var_441_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_14.prefab_name].transform, "story_v_out_420051", "420051104", "story_v_out_420051.awb")

						arg_438_1:RecordAudio("420051104", var_441_20)
						arg_438_1:RecordAudio("420051104", var_441_20)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_420051", "420051104", "story_v_out_420051.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_420051", "420051104", "story_v_out_420051.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_21 = math.max(var_441_12, arg_438_1.talkMaxDuration)

			if var_441_11 <= arg_438_1.time_ and arg_438_1.time_ < var_441_11 + var_441_21 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_11) / var_441_21

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_11 + var_441_21 and arg_438_1.time_ < var_441_11 + var_441_21 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play420051105 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 420051105
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play420051106(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["404001ui_story"].transform
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1.var_.moveOldPos404001ui_story = var_445_0.localPosition
			end

			local var_445_2 = 0.001

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2
				local var_445_4 = Vector3.New(0, 100, 0)

				var_445_0.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos404001ui_story, var_445_4, var_445_3)

				local var_445_5 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_5.x, var_445_5.y, var_445_5.z)

				local var_445_6 = var_445_0.localEulerAngles

				var_445_6.z = 0
				var_445_6.x = 0
				var_445_0.localEulerAngles = var_445_6
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 then
				var_445_0.localPosition = Vector3.New(0, 100, 0)

				local var_445_7 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_7.x, var_445_7.y, var_445_7.z)

				local var_445_8 = var_445_0.localEulerAngles

				var_445_8.z = 0
				var_445_8.x = 0
				var_445_0.localEulerAngles = var_445_8
			end

			local var_445_9 = arg_442_1.actors_["1085ui_story"].transform
			local var_445_10 = 0

			if var_445_10 < arg_442_1.time_ and arg_442_1.time_ <= var_445_10 + arg_445_0 then
				arg_442_1.var_.moveOldPos1085ui_story = var_445_9.localPosition
			end

			local var_445_11 = 0.001

			if var_445_10 <= arg_442_1.time_ and arg_442_1.time_ < var_445_10 + var_445_11 then
				local var_445_12 = (arg_442_1.time_ - var_445_10) / var_445_11
				local var_445_13 = Vector3.New(0, 100, 0)

				var_445_9.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1085ui_story, var_445_13, var_445_12)

				local var_445_14 = manager.ui.mainCamera.transform.position - var_445_9.position

				var_445_9.forward = Vector3.New(var_445_14.x, var_445_14.y, var_445_14.z)

				local var_445_15 = var_445_9.localEulerAngles

				var_445_15.z = 0
				var_445_15.x = 0
				var_445_9.localEulerAngles = var_445_15
			end

			if arg_442_1.time_ >= var_445_10 + var_445_11 and arg_442_1.time_ < var_445_10 + var_445_11 + arg_445_0 then
				var_445_9.localPosition = Vector3.New(0, 100, 0)

				local var_445_16 = manager.ui.mainCamera.transform.position - var_445_9.position

				var_445_9.forward = Vector3.New(var_445_16.x, var_445_16.y, var_445_16.z)

				local var_445_17 = var_445_9.localEulerAngles

				var_445_17.z = 0
				var_445_17.x = 0
				var_445_9.localEulerAngles = var_445_17
			end

			local var_445_18 = 0.034000001847744
			local var_445_19 = 1

			if var_445_18 < arg_442_1.time_ and arg_442_1.time_ <= var_445_18 + arg_445_0 then
				local var_445_20 = "play"
				local var_445_21 = "effect"

				arg_442_1:AudioAction(var_445_20, var_445_21, "se_story_140", "se_story_140_curtain02", "")
			end

			local var_445_22 = 0
			local var_445_23 = 0.825

			if var_445_22 < arg_442_1.time_ and arg_442_1.time_ <= var_445_22 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, false)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_24 = arg_442_1:GetWordFromCfg(420051105)
				local var_445_25 = arg_442_1:FormatText(var_445_24.content)

				arg_442_1.text_.text = var_445_25

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_26 = 33
				local var_445_27 = utf8.len(var_445_25)
				local var_445_28 = var_445_26 <= 0 and var_445_23 or var_445_23 * (var_445_27 / var_445_26)

				if var_445_28 > 0 and var_445_23 < var_445_28 then
					arg_442_1.talkMaxDuration = var_445_28

					if var_445_28 + var_445_22 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_28 + var_445_22
					end
				end

				arg_442_1.text_.text = var_445_25
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_29 = math.max(var_445_23, arg_442_1.talkMaxDuration)

			if var_445_22 <= arg_442_1.time_ and arg_442_1.time_ < var_445_22 + var_445_29 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_22) / var_445_29

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_22 + var_445_29 and arg_442_1.time_ < var_445_22 + var_445_29 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play420051106 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 420051106
		arg_446_1.duration_ = 2.87

		local var_446_0 = {
			zh = 2.3,
			ja = 2.866
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play420051107(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["1085ui_story"].transform
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 then
				arg_446_1.var_.moveOldPos1085ui_story = var_449_0.localPosition
			end

			local var_449_2 = 0.001

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2
				local var_449_4 = Vector3.New(0, -1.01, -5.83)

				var_449_0.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos1085ui_story, var_449_4, var_449_3)

				local var_449_5 = manager.ui.mainCamera.transform.position - var_449_0.position

				var_449_0.forward = Vector3.New(var_449_5.x, var_449_5.y, var_449_5.z)

				local var_449_6 = var_449_0.localEulerAngles

				var_449_6.z = 0
				var_449_6.x = 0
				var_449_0.localEulerAngles = var_449_6
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 then
				var_449_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_449_7 = manager.ui.mainCamera.transform.position - var_449_0.position

				var_449_0.forward = Vector3.New(var_449_7.x, var_449_7.y, var_449_7.z)

				local var_449_8 = var_449_0.localEulerAngles

				var_449_8.z = 0
				var_449_8.x = 0
				var_449_0.localEulerAngles = var_449_8
			end

			local var_449_9 = arg_446_1.actors_["1085ui_story"]
			local var_449_10 = 0

			if var_449_10 < arg_446_1.time_ and arg_446_1.time_ <= var_449_10 + arg_449_0 and not isNil(var_449_9) and arg_446_1.var_.characterEffect1085ui_story == nil then
				arg_446_1.var_.characterEffect1085ui_story = var_449_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_11 = 0.200000002980232

			if var_449_10 <= arg_446_1.time_ and arg_446_1.time_ < var_449_10 + var_449_11 and not isNil(var_449_9) then
				local var_449_12 = (arg_446_1.time_ - var_449_10) / var_449_11

				if arg_446_1.var_.characterEffect1085ui_story and not isNil(var_449_9) then
					arg_446_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_446_1.time_ >= var_449_10 + var_449_11 and arg_446_1.time_ < var_449_10 + var_449_11 + arg_449_0 and not isNil(var_449_9) and arg_446_1.var_.characterEffect1085ui_story then
				arg_446_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_449_13 = 0

			if var_449_13 < arg_446_1.time_ and arg_446_1.time_ <= var_449_13 + arg_449_0 then
				arg_446_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_449_14 = 0

			if var_449_14 < arg_446_1.time_ and arg_446_1.time_ <= var_449_14 + arg_449_0 then
				arg_446_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_449_15 = 0
			local var_449_16 = 0.2

			if var_449_15 < arg_446_1.time_ and arg_446_1.time_ <= var_449_15 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_17 = arg_446_1:FormatText(StoryNameCfg[328].name)

				arg_446_1.leftNameTxt_.text = var_449_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_18 = arg_446_1:GetWordFromCfg(420051106)
				local var_449_19 = arg_446_1:FormatText(var_449_18.content)

				arg_446_1.text_.text = var_449_19

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_20 = 8
				local var_449_21 = utf8.len(var_449_19)
				local var_449_22 = var_449_20 <= 0 and var_449_16 or var_449_16 * (var_449_21 / var_449_20)

				if var_449_22 > 0 and var_449_16 < var_449_22 then
					arg_446_1.talkMaxDuration = var_449_22

					if var_449_22 + var_449_15 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_22 + var_449_15
					end
				end

				arg_446_1.text_.text = var_449_19
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051106", "story_v_out_420051.awb") ~= 0 then
					local var_449_23 = manager.audio:GetVoiceLength("story_v_out_420051", "420051106", "story_v_out_420051.awb") / 1000

					if var_449_23 + var_449_15 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_23 + var_449_15
					end

					if var_449_18.prefab_name ~= "" and arg_446_1.actors_[var_449_18.prefab_name] ~= nil then
						local var_449_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_18.prefab_name].transform, "story_v_out_420051", "420051106", "story_v_out_420051.awb")

						arg_446_1:RecordAudio("420051106", var_449_24)
						arg_446_1:RecordAudio("420051106", var_449_24)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_420051", "420051106", "story_v_out_420051.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_420051", "420051106", "story_v_out_420051.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_25 = math.max(var_449_16, arg_446_1.talkMaxDuration)

			if var_449_15 <= arg_446_1.time_ and arg_446_1.time_ < var_449_15 + var_449_25 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_15) / var_449_25

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_15 + var_449_25 and arg_446_1.time_ < var_449_15 + var_449_25 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420051107 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 420051107
		arg_450_1.duration_ = 4.2

		local var_450_0 = {
			zh = 2.4,
			ja = 4.2
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play420051108(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["404001ui_story"].transform
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.var_.moveOldPos404001ui_story = var_453_0.localPosition
			end

			local var_453_2 = 0.001

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2
				local var_453_4 = Vector3.New(0, -1.55, -5.5)

				var_453_0.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos404001ui_story, var_453_4, var_453_3)

				local var_453_5 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_5.x, var_453_5.y, var_453_5.z)

				local var_453_6 = var_453_0.localEulerAngles

				var_453_6.z = 0
				var_453_6.x = 0
				var_453_0.localEulerAngles = var_453_6
			end

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 then
				var_453_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_453_7 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_7.x, var_453_7.y, var_453_7.z)

				local var_453_8 = var_453_0.localEulerAngles

				var_453_8.z = 0
				var_453_8.x = 0
				var_453_0.localEulerAngles = var_453_8
			end

			local var_453_9 = arg_450_1.actors_["1085ui_story"].transform
			local var_453_10 = 0

			if var_453_10 < arg_450_1.time_ and arg_450_1.time_ <= var_453_10 + arg_453_0 then
				arg_450_1.var_.moveOldPos1085ui_story = var_453_9.localPosition
			end

			local var_453_11 = 0.001

			if var_453_10 <= arg_450_1.time_ and arg_450_1.time_ < var_453_10 + var_453_11 then
				local var_453_12 = (arg_450_1.time_ - var_453_10) / var_453_11
				local var_453_13 = Vector3.New(0, 100, 0)

				var_453_9.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1085ui_story, var_453_13, var_453_12)

				local var_453_14 = manager.ui.mainCamera.transform.position - var_453_9.position

				var_453_9.forward = Vector3.New(var_453_14.x, var_453_14.y, var_453_14.z)

				local var_453_15 = var_453_9.localEulerAngles

				var_453_15.z = 0
				var_453_15.x = 0
				var_453_9.localEulerAngles = var_453_15
			end

			if arg_450_1.time_ >= var_453_10 + var_453_11 and arg_450_1.time_ < var_453_10 + var_453_11 + arg_453_0 then
				var_453_9.localPosition = Vector3.New(0, 100, 0)

				local var_453_16 = manager.ui.mainCamera.transform.position - var_453_9.position

				var_453_9.forward = Vector3.New(var_453_16.x, var_453_16.y, var_453_16.z)

				local var_453_17 = var_453_9.localEulerAngles

				var_453_17.z = 0
				var_453_17.x = 0
				var_453_9.localEulerAngles = var_453_17
			end

			local var_453_18 = arg_450_1.actors_["404001ui_story"]
			local var_453_19 = 0

			if var_453_19 < arg_450_1.time_ and arg_450_1.time_ <= var_453_19 + arg_453_0 and not isNil(var_453_18) and arg_450_1.var_.characterEffect404001ui_story == nil then
				arg_450_1.var_.characterEffect404001ui_story = var_453_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_20 = 0.200000002980232

			if var_453_19 <= arg_450_1.time_ and arg_450_1.time_ < var_453_19 + var_453_20 and not isNil(var_453_18) then
				local var_453_21 = (arg_450_1.time_ - var_453_19) / var_453_20

				if arg_450_1.var_.characterEffect404001ui_story and not isNil(var_453_18) then
					arg_450_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_450_1.time_ >= var_453_19 + var_453_20 and arg_450_1.time_ < var_453_19 + var_453_20 + arg_453_0 and not isNil(var_453_18) and arg_450_1.var_.characterEffect404001ui_story then
				arg_450_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_453_22 = arg_450_1.actors_["1085ui_story"]
			local var_453_23 = 0

			if var_453_23 < arg_450_1.time_ and arg_450_1.time_ <= var_453_23 + arg_453_0 and not isNil(var_453_22) and arg_450_1.var_.characterEffect1085ui_story == nil then
				arg_450_1.var_.characterEffect1085ui_story = var_453_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_24 = 0.200000002980232

			if var_453_23 <= arg_450_1.time_ and arg_450_1.time_ < var_453_23 + var_453_24 and not isNil(var_453_22) then
				local var_453_25 = (arg_450_1.time_ - var_453_23) / var_453_24

				if arg_450_1.var_.characterEffect1085ui_story and not isNil(var_453_22) then
					local var_453_26 = Mathf.Lerp(0, 0.5, var_453_25)

					arg_450_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_450_1.var_.characterEffect1085ui_story.fillRatio = var_453_26
				end
			end

			if arg_450_1.time_ >= var_453_23 + var_453_24 and arg_450_1.time_ < var_453_23 + var_453_24 + arg_453_0 and not isNil(var_453_22) and arg_450_1.var_.characterEffect1085ui_story then
				local var_453_27 = 0.5

				arg_450_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_450_1.var_.characterEffect1085ui_story.fillRatio = var_453_27
			end

			local var_453_28 = 0

			if var_453_28 < arg_450_1.time_ and arg_450_1.time_ <= var_453_28 + arg_453_0 then
				arg_450_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_453_29 = 0

			if var_453_29 < arg_450_1.time_ and arg_450_1.time_ <= var_453_29 + arg_453_0 then
				arg_450_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			local var_453_30 = 0
			local var_453_31 = 0.25

			if var_453_30 < arg_450_1.time_ and arg_450_1.time_ <= var_453_30 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_32 = arg_450_1:FormatText(StoryNameCfg[668].name)

				arg_450_1.leftNameTxt_.text = var_453_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_33 = arg_450_1:GetWordFromCfg(420051107)
				local var_453_34 = arg_450_1:FormatText(var_453_33.content)

				arg_450_1.text_.text = var_453_34

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_35 = 10
				local var_453_36 = utf8.len(var_453_34)
				local var_453_37 = var_453_35 <= 0 and var_453_31 or var_453_31 * (var_453_36 / var_453_35)

				if var_453_37 > 0 and var_453_31 < var_453_37 then
					arg_450_1.talkMaxDuration = var_453_37

					if var_453_37 + var_453_30 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_37 + var_453_30
					end
				end

				arg_450_1.text_.text = var_453_34
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051107", "story_v_out_420051.awb") ~= 0 then
					local var_453_38 = manager.audio:GetVoiceLength("story_v_out_420051", "420051107", "story_v_out_420051.awb") / 1000

					if var_453_38 + var_453_30 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_38 + var_453_30
					end

					if var_453_33.prefab_name ~= "" and arg_450_1.actors_[var_453_33.prefab_name] ~= nil then
						local var_453_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_33.prefab_name].transform, "story_v_out_420051", "420051107", "story_v_out_420051.awb")

						arg_450_1:RecordAudio("420051107", var_453_39)
						arg_450_1:RecordAudio("420051107", var_453_39)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_420051", "420051107", "story_v_out_420051.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_420051", "420051107", "story_v_out_420051.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_40 = math.max(var_453_31, arg_450_1.talkMaxDuration)

			if var_453_30 <= arg_450_1.time_ and arg_450_1.time_ < var_453_30 + var_453_40 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_30) / var_453_40

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_30 + var_453_40 and arg_450_1.time_ < var_453_30 + var_453_40 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play420051108 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 420051108
		arg_454_1.duration_ = 9.9

		local var_454_0 = {
			zh = 4.7,
			ja = 9.9
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play420051109(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0
			local var_457_1 = 0.875

			if var_457_0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_2 = arg_454_1:FormatText(StoryNameCfg[668].name)

				arg_454_1.leftNameTxt_.text = var_457_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_3 = arg_454_1:GetWordFromCfg(420051108)
				local var_457_4 = arg_454_1:FormatText(var_457_3.content)

				arg_454_1.text_.text = var_457_4

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_5 = 35
				local var_457_6 = utf8.len(var_457_4)
				local var_457_7 = var_457_5 <= 0 and var_457_1 or var_457_1 * (var_457_6 / var_457_5)

				if var_457_7 > 0 and var_457_1 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_0
					end
				end

				arg_454_1.text_.text = var_457_4
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051108", "story_v_out_420051.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051108", "story_v_out_420051.awb") / 1000

					if var_457_8 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_0
					end

					if var_457_3.prefab_name ~= "" and arg_454_1.actors_[var_457_3.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_3.prefab_name].transform, "story_v_out_420051", "420051108", "story_v_out_420051.awb")

						arg_454_1:RecordAudio("420051108", var_457_9)
						arg_454_1:RecordAudio("420051108", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_420051", "420051108", "story_v_out_420051.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_420051", "420051108", "story_v_out_420051.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_10 = math.max(var_457_1, arg_454_1.talkMaxDuration)

			if var_457_0 <= arg_454_1.time_ and arg_454_1.time_ < var_457_0 + var_457_10 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_0) / var_457_10

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_0 + var_457_10 and arg_454_1.time_ < var_457_0 + var_457_10 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play420051109 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 420051109
		arg_458_1.duration_ = 10.83

		local var_458_0 = {
			zh = 9.033,
			ja = 10.833
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play420051110(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["404001ui_story"].transform
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1.var_.moveOldPos404001ui_story = var_461_0.localPosition
			end

			local var_461_2 = 0.001

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2
				local var_461_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_461_0.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos404001ui_story, var_461_4, var_461_3)

				local var_461_5 = manager.ui.mainCamera.transform.position - var_461_0.position

				var_461_0.forward = Vector3.New(var_461_5.x, var_461_5.y, var_461_5.z)

				local var_461_6 = var_461_0.localEulerAngles

				var_461_6.z = 0
				var_461_6.x = 0
				var_461_0.localEulerAngles = var_461_6
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 then
				var_461_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_461_7 = manager.ui.mainCamera.transform.position - var_461_0.position

				var_461_0.forward = Vector3.New(var_461_7.x, var_461_7.y, var_461_7.z)

				local var_461_8 = var_461_0.localEulerAngles

				var_461_8.z = 0
				var_461_8.x = 0
				var_461_0.localEulerAngles = var_461_8
			end

			local var_461_9 = arg_458_1.actors_["1085ui_story"].transform
			local var_461_10 = 0

			if var_461_10 < arg_458_1.time_ and arg_458_1.time_ <= var_461_10 + arg_461_0 then
				arg_458_1.var_.moveOldPos1085ui_story = var_461_9.localPosition
			end

			local var_461_11 = 0.001

			if var_461_10 <= arg_458_1.time_ and arg_458_1.time_ < var_461_10 + var_461_11 then
				local var_461_12 = (arg_458_1.time_ - var_461_10) / var_461_11
				local var_461_13 = Vector3.New(0.75, -1.01, -5.83)

				var_461_9.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1085ui_story, var_461_13, var_461_12)

				local var_461_14 = manager.ui.mainCamera.transform.position - var_461_9.position

				var_461_9.forward = Vector3.New(var_461_14.x, var_461_14.y, var_461_14.z)

				local var_461_15 = var_461_9.localEulerAngles

				var_461_15.z = 0
				var_461_15.x = 0
				var_461_9.localEulerAngles = var_461_15
			end

			if arg_458_1.time_ >= var_461_10 + var_461_11 and arg_458_1.time_ < var_461_10 + var_461_11 + arg_461_0 then
				var_461_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_461_16 = manager.ui.mainCamera.transform.position - var_461_9.position

				var_461_9.forward = Vector3.New(var_461_16.x, var_461_16.y, var_461_16.z)

				local var_461_17 = var_461_9.localEulerAngles

				var_461_17.z = 0
				var_461_17.x = 0
				var_461_9.localEulerAngles = var_461_17
			end

			local var_461_18 = arg_458_1.actors_["1085ui_story"]
			local var_461_19 = 0

			if var_461_19 < arg_458_1.time_ and arg_458_1.time_ <= var_461_19 + arg_461_0 and not isNil(var_461_18) and arg_458_1.var_.characterEffect1085ui_story == nil then
				arg_458_1.var_.characterEffect1085ui_story = var_461_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_20 = 0.200000002980232

			if var_461_19 <= arg_458_1.time_ and arg_458_1.time_ < var_461_19 + var_461_20 and not isNil(var_461_18) then
				local var_461_21 = (arg_458_1.time_ - var_461_19) / var_461_20

				if arg_458_1.var_.characterEffect1085ui_story and not isNil(var_461_18) then
					arg_458_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= var_461_19 + var_461_20 and arg_458_1.time_ < var_461_19 + var_461_20 + arg_461_0 and not isNil(var_461_18) and arg_458_1.var_.characterEffect1085ui_story then
				arg_458_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_461_22 = arg_458_1.actors_["404001ui_story"]
			local var_461_23 = 0

			if var_461_23 < arg_458_1.time_ and arg_458_1.time_ <= var_461_23 + arg_461_0 and not isNil(var_461_22) and arg_458_1.var_.characterEffect404001ui_story == nil then
				arg_458_1.var_.characterEffect404001ui_story = var_461_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_24 = 0.200000002980232

			if var_461_23 <= arg_458_1.time_ and arg_458_1.time_ < var_461_23 + var_461_24 and not isNil(var_461_22) then
				local var_461_25 = (arg_458_1.time_ - var_461_23) / var_461_24

				if arg_458_1.var_.characterEffect404001ui_story and not isNil(var_461_22) then
					local var_461_26 = Mathf.Lerp(0, 0.5, var_461_25)

					arg_458_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_458_1.var_.characterEffect404001ui_story.fillRatio = var_461_26
				end
			end

			if arg_458_1.time_ >= var_461_23 + var_461_24 and arg_458_1.time_ < var_461_23 + var_461_24 + arg_461_0 and not isNil(var_461_22) and arg_458_1.var_.characterEffect404001ui_story then
				local var_461_27 = 0.5

				arg_458_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_458_1.var_.characterEffect404001ui_story.fillRatio = var_461_27
			end

			local var_461_28 = 0

			if var_461_28 < arg_458_1.time_ and arg_458_1.time_ <= var_461_28 + arg_461_0 then
				arg_458_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_461_29 = 0
			local var_461_30 = 0.8

			if var_461_29 < arg_458_1.time_ and arg_458_1.time_ <= var_461_29 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_31 = arg_458_1:FormatText(StoryNameCfg[328].name)

				arg_458_1.leftNameTxt_.text = var_461_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_32 = arg_458_1:GetWordFromCfg(420051109)
				local var_461_33 = arg_458_1:FormatText(var_461_32.content)

				arg_458_1.text_.text = var_461_33

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_34 = 32
				local var_461_35 = utf8.len(var_461_33)
				local var_461_36 = var_461_34 <= 0 and var_461_30 or var_461_30 * (var_461_35 / var_461_34)

				if var_461_36 > 0 and var_461_30 < var_461_36 then
					arg_458_1.talkMaxDuration = var_461_36

					if var_461_36 + var_461_29 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_36 + var_461_29
					end
				end

				arg_458_1.text_.text = var_461_33
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051109", "story_v_out_420051.awb") ~= 0 then
					local var_461_37 = manager.audio:GetVoiceLength("story_v_out_420051", "420051109", "story_v_out_420051.awb") / 1000

					if var_461_37 + var_461_29 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_37 + var_461_29
					end

					if var_461_32.prefab_name ~= "" and arg_458_1.actors_[var_461_32.prefab_name] ~= nil then
						local var_461_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_32.prefab_name].transform, "story_v_out_420051", "420051109", "story_v_out_420051.awb")

						arg_458_1:RecordAudio("420051109", var_461_38)
						arg_458_1:RecordAudio("420051109", var_461_38)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_420051", "420051109", "story_v_out_420051.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_420051", "420051109", "story_v_out_420051.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_39 = math.max(var_461_30, arg_458_1.talkMaxDuration)

			if var_461_29 <= arg_458_1.time_ and arg_458_1.time_ < var_461_29 + var_461_39 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_29) / var_461_39

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_29 + var_461_39 and arg_458_1.time_ < var_461_29 + var_461_39 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420051110 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 420051110
		arg_462_1.duration_ = 6.53

		local var_462_0 = {
			zh = 3.1,
			ja = 6.533
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play420051111(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0

			if var_465_0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_465_1 = 0
			local var_465_2 = 0.325

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_3 = arg_462_1:FormatText(StoryNameCfg[328].name)

				arg_462_1.leftNameTxt_.text = var_465_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_4 = arg_462_1:GetWordFromCfg(420051110)
				local var_465_5 = arg_462_1:FormatText(var_465_4.content)

				arg_462_1.text_.text = var_465_5

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_6 = 13
				local var_465_7 = utf8.len(var_465_5)
				local var_465_8 = var_465_6 <= 0 and var_465_2 or var_465_2 * (var_465_7 / var_465_6)

				if var_465_8 > 0 and var_465_2 < var_465_8 then
					arg_462_1.talkMaxDuration = var_465_8

					if var_465_8 + var_465_1 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_8 + var_465_1
					end
				end

				arg_462_1.text_.text = var_465_5
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051110", "story_v_out_420051.awb") ~= 0 then
					local var_465_9 = manager.audio:GetVoiceLength("story_v_out_420051", "420051110", "story_v_out_420051.awb") / 1000

					if var_465_9 + var_465_1 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_9 + var_465_1
					end

					if var_465_4.prefab_name ~= "" and arg_462_1.actors_[var_465_4.prefab_name] ~= nil then
						local var_465_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_4.prefab_name].transform, "story_v_out_420051", "420051110", "story_v_out_420051.awb")

						arg_462_1:RecordAudio("420051110", var_465_10)
						arg_462_1:RecordAudio("420051110", var_465_10)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_420051", "420051110", "story_v_out_420051.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_420051", "420051110", "story_v_out_420051.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_11 = math.max(var_465_2, arg_462_1.talkMaxDuration)

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_11 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_1) / var_465_11

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_1 + var_465_11 and arg_462_1.time_ < var_465_1 + var_465_11 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play420051111 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 420051111
		arg_466_1.duration_ = 12.03

		local var_466_0 = {
			zh = 8.7,
			ja = 12.033
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play420051112(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["404001ui_story"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect404001ui_story == nil then
				arg_466_1.var_.characterEffect404001ui_story = var_469_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.200000002980232

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.characterEffect404001ui_story and not isNil(var_469_0) then
					arg_466_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect404001ui_story then
				arg_466_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_469_4 = arg_466_1.actors_["1085ui_story"]
			local var_469_5 = 0

			if var_469_5 < arg_466_1.time_ and arg_466_1.time_ <= var_469_5 + arg_469_0 and not isNil(var_469_4) and arg_466_1.var_.characterEffect1085ui_story == nil then
				arg_466_1.var_.characterEffect1085ui_story = var_469_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_6 = 0.200000002980232

			if var_469_5 <= arg_466_1.time_ and arg_466_1.time_ < var_469_5 + var_469_6 and not isNil(var_469_4) then
				local var_469_7 = (arg_466_1.time_ - var_469_5) / var_469_6

				if arg_466_1.var_.characterEffect1085ui_story and not isNil(var_469_4) then
					local var_469_8 = Mathf.Lerp(0, 0.5, var_469_7)

					arg_466_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1085ui_story.fillRatio = var_469_8
				end
			end

			if arg_466_1.time_ >= var_469_5 + var_469_6 and arg_466_1.time_ < var_469_5 + var_469_6 + arg_469_0 and not isNil(var_469_4) and arg_466_1.var_.characterEffect1085ui_story then
				local var_469_9 = 0.5

				arg_466_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1085ui_story.fillRatio = var_469_9
			end

			local var_469_10 = 0
			local var_469_11 = 1.05

			if var_469_10 < arg_466_1.time_ and arg_466_1.time_ <= var_469_10 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_12 = arg_466_1:FormatText(StoryNameCfg[668].name)

				arg_466_1.leftNameTxt_.text = var_469_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_13 = arg_466_1:GetWordFromCfg(420051111)
				local var_469_14 = arg_466_1:FormatText(var_469_13.content)

				arg_466_1.text_.text = var_469_14

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_15 = 42
				local var_469_16 = utf8.len(var_469_14)
				local var_469_17 = var_469_15 <= 0 and var_469_11 or var_469_11 * (var_469_16 / var_469_15)

				if var_469_17 > 0 and var_469_11 < var_469_17 then
					arg_466_1.talkMaxDuration = var_469_17

					if var_469_17 + var_469_10 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_17 + var_469_10
					end
				end

				arg_466_1.text_.text = var_469_14
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051111", "story_v_out_420051.awb") ~= 0 then
					local var_469_18 = manager.audio:GetVoiceLength("story_v_out_420051", "420051111", "story_v_out_420051.awb") / 1000

					if var_469_18 + var_469_10 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_18 + var_469_10
					end

					if var_469_13.prefab_name ~= "" and arg_466_1.actors_[var_469_13.prefab_name] ~= nil then
						local var_469_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_13.prefab_name].transform, "story_v_out_420051", "420051111", "story_v_out_420051.awb")

						arg_466_1:RecordAudio("420051111", var_469_19)
						arg_466_1:RecordAudio("420051111", var_469_19)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_420051", "420051111", "story_v_out_420051.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_420051", "420051111", "story_v_out_420051.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_20 = math.max(var_469_11, arg_466_1.talkMaxDuration)

			if var_469_10 <= arg_466_1.time_ and arg_466_1.time_ < var_469_10 + var_469_20 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_10) / var_469_20

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_10 + var_469_20 and arg_466_1.time_ < var_469_10 + var_469_20 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play420051112 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 420051112
		arg_470_1.duration_ = 4.97

		local var_470_0 = {
			zh = 3.266,
			ja = 4.966
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play420051113(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0
			local var_473_1 = 0.35

			if var_473_0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_2 = arg_470_1:FormatText(StoryNameCfg[668].name)

				arg_470_1.leftNameTxt_.text = var_473_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_3 = arg_470_1:GetWordFromCfg(420051112)
				local var_473_4 = arg_470_1:FormatText(var_473_3.content)

				arg_470_1.text_.text = var_473_4

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_5 = 14
				local var_473_6 = utf8.len(var_473_4)
				local var_473_7 = var_473_5 <= 0 and var_473_1 or var_473_1 * (var_473_6 / var_473_5)

				if var_473_7 > 0 and var_473_1 < var_473_7 then
					arg_470_1.talkMaxDuration = var_473_7

					if var_473_7 + var_473_0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_7 + var_473_0
					end
				end

				arg_470_1.text_.text = var_473_4
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051112", "story_v_out_420051.awb") ~= 0 then
					local var_473_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051112", "story_v_out_420051.awb") / 1000

					if var_473_8 + var_473_0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_8 + var_473_0
					end

					if var_473_3.prefab_name ~= "" and arg_470_1.actors_[var_473_3.prefab_name] ~= nil then
						local var_473_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_3.prefab_name].transform, "story_v_out_420051", "420051112", "story_v_out_420051.awb")

						arg_470_1:RecordAudio("420051112", var_473_9)
						arg_470_1:RecordAudio("420051112", var_473_9)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_420051", "420051112", "story_v_out_420051.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_420051", "420051112", "story_v_out_420051.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_10 = math.max(var_473_1, arg_470_1.talkMaxDuration)

			if var_473_0 <= arg_470_1.time_ and arg_470_1.time_ < var_473_0 + var_473_10 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_0) / var_473_10

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_0 + var_473_10 and arg_470_1.time_ < var_473_0 + var_473_10 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play420051113 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 420051113
		arg_474_1.duration_ = 4.4

		local var_474_0 = {
			zh = 4.4,
			ja = 3.9
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play420051114(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["1085ui_story"]
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect1085ui_story == nil then
				arg_474_1.var_.characterEffect1085ui_story = var_477_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_2 = 0.200000002980232

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 and not isNil(var_477_0) then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2

				if arg_474_1.var_.characterEffect1085ui_story and not isNil(var_477_0) then
					arg_474_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect1085ui_story then
				arg_474_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_477_4 = arg_474_1.actors_["404001ui_story"]
			local var_477_5 = 0

			if var_477_5 < arg_474_1.time_ and arg_474_1.time_ <= var_477_5 + arg_477_0 and not isNil(var_477_4) and arg_474_1.var_.characterEffect404001ui_story == nil then
				arg_474_1.var_.characterEffect404001ui_story = var_477_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_6 = 0.200000002980232

			if var_477_5 <= arg_474_1.time_ and arg_474_1.time_ < var_477_5 + var_477_6 and not isNil(var_477_4) then
				local var_477_7 = (arg_474_1.time_ - var_477_5) / var_477_6

				if arg_474_1.var_.characterEffect404001ui_story and not isNil(var_477_4) then
					local var_477_8 = Mathf.Lerp(0, 0.5, var_477_7)

					arg_474_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_474_1.var_.characterEffect404001ui_story.fillRatio = var_477_8
				end
			end

			if arg_474_1.time_ >= var_477_5 + var_477_6 and arg_474_1.time_ < var_477_5 + var_477_6 + arg_477_0 and not isNil(var_477_4) and arg_474_1.var_.characterEffect404001ui_story then
				local var_477_9 = 0.5

				arg_474_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_474_1.var_.characterEffect404001ui_story.fillRatio = var_477_9
			end

			local var_477_10 = 0
			local var_477_11 = 0.3

			if var_477_10 < arg_474_1.time_ and arg_474_1.time_ <= var_477_10 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_12 = arg_474_1:FormatText(StoryNameCfg[328].name)

				arg_474_1.leftNameTxt_.text = var_477_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_13 = arg_474_1:GetWordFromCfg(420051113)
				local var_477_14 = arg_474_1:FormatText(var_477_13.content)

				arg_474_1.text_.text = var_477_14

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_15 = 12
				local var_477_16 = utf8.len(var_477_14)
				local var_477_17 = var_477_15 <= 0 and var_477_11 or var_477_11 * (var_477_16 / var_477_15)

				if var_477_17 > 0 and var_477_11 < var_477_17 then
					arg_474_1.talkMaxDuration = var_477_17

					if var_477_17 + var_477_10 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_17 + var_477_10
					end
				end

				arg_474_1.text_.text = var_477_14
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051113", "story_v_out_420051.awb") ~= 0 then
					local var_477_18 = manager.audio:GetVoiceLength("story_v_out_420051", "420051113", "story_v_out_420051.awb") / 1000

					if var_477_18 + var_477_10 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_18 + var_477_10
					end

					if var_477_13.prefab_name ~= "" and arg_474_1.actors_[var_477_13.prefab_name] ~= nil then
						local var_477_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_13.prefab_name].transform, "story_v_out_420051", "420051113", "story_v_out_420051.awb")

						arg_474_1:RecordAudio("420051113", var_477_19)
						arg_474_1:RecordAudio("420051113", var_477_19)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_420051", "420051113", "story_v_out_420051.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_420051", "420051113", "story_v_out_420051.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_20 = math.max(var_477_11, arg_474_1.talkMaxDuration)

			if var_477_10 <= arg_474_1.time_ and arg_474_1.time_ < var_477_10 + var_477_20 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_10) / var_477_20

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_10 + var_477_20 and arg_474_1.time_ < var_477_10 + var_477_20 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play420051114 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 420051114
		arg_478_1.duration_ = 8.73

		local var_478_0 = {
			zh = 7.9,
			ja = 8.733
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play420051115(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = arg_478_1.actors_["404001ui_story"]
			local var_481_1 = 0

			if var_481_1 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.characterEffect404001ui_story == nil then
				arg_478_1.var_.characterEffect404001ui_story = var_481_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_2 = 0.200000002980232

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_2 and not isNil(var_481_0) then
				local var_481_3 = (arg_478_1.time_ - var_481_1) / var_481_2

				if arg_478_1.var_.characterEffect404001ui_story and not isNil(var_481_0) then
					arg_478_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= var_481_1 + var_481_2 and arg_478_1.time_ < var_481_1 + var_481_2 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.characterEffect404001ui_story then
				arg_478_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_481_4 = arg_478_1.actors_["1085ui_story"]
			local var_481_5 = 0

			if var_481_5 < arg_478_1.time_ and arg_478_1.time_ <= var_481_5 + arg_481_0 and not isNil(var_481_4) and arg_478_1.var_.characterEffect1085ui_story == nil then
				arg_478_1.var_.characterEffect1085ui_story = var_481_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_6 = 0.200000002980232

			if var_481_5 <= arg_478_1.time_ and arg_478_1.time_ < var_481_5 + var_481_6 and not isNil(var_481_4) then
				local var_481_7 = (arg_478_1.time_ - var_481_5) / var_481_6

				if arg_478_1.var_.characterEffect1085ui_story and not isNil(var_481_4) then
					local var_481_8 = Mathf.Lerp(0, 0.5, var_481_7)

					arg_478_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_478_1.var_.characterEffect1085ui_story.fillRatio = var_481_8
				end
			end

			if arg_478_1.time_ >= var_481_5 + var_481_6 and arg_478_1.time_ < var_481_5 + var_481_6 + arg_481_0 and not isNil(var_481_4) and arg_478_1.var_.characterEffect1085ui_story then
				local var_481_9 = 0.5

				arg_478_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_478_1.var_.characterEffect1085ui_story.fillRatio = var_481_9
			end

			local var_481_10 = 0

			if var_481_10 < arg_478_1.time_ and arg_478_1.time_ <= var_481_10 + arg_481_0 then
				arg_478_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_1")
			end

			local var_481_11 = 0
			local var_481_12 = 0.925

			if var_481_11 < arg_478_1.time_ and arg_478_1.time_ <= var_481_11 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_13 = arg_478_1:FormatText(StoryNameCfg[668].name)

				arg_478_1.leftNameTxt_.text = var_481_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_14 = arg_478_1:GetWordFromCfg(420051114)
				local var_481_15 = arg_478_1:FormatText(var_481_14.content)

				arg_478_1.text_.text = var_481_15

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_16 = 37
				local var_481_17 = utf8.len(var_481_15)
				local var_481_18 = var_481_16 <= 0 and var_481_12 or var_481_12 * (var_481_17 / var_481_16)

				if var_481_18 > 0 and var_481_12 < var_481_18 then
					arg_478_1.talkMaxDuration = var_481_18

					if var_481_18 + var_481_11 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_18 + var_481_11
					end
				end

				arg_478_1.text_.text = var_481_15
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051114", "story_v_out_420051.awb") ~= 0 then
					local var_481_19 = manager.audio:GetVoiceLength("story_v_out_420051", "420051114", "story_v_out_420051.awb") / 1000

					if var_481_19 + var_481_11 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_19 + var_481_11
					end

					if var_481_14.prefab_name ~= "" and arg_478_1.actors_[var_481_14.prefab_name] ~= nil then
						local var_481_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_14.prefab_name].transform, "story_v_out_420051", "420051114", "story_v_out_420051.awb")

						arg_478_1:RecordAudio("420051114", var_481_20)
						arg_478_1:RecordAudio("420051114", var_481_20)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_420051", "420051114", "story_v_out_420051.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_420051", "420051114", "story_v_out_420051.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_21 = math.max(var_481_12, arg_478_1.talkMaxDuration)

			if var_481_11 <= arg_478_1.time_ and arg_478_1.time_ < var_481_11 + var_481_21 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_11) / var_481_21

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_11 + var_481_21 and arg_478_1.time_ < var_481_11 + var_481_21 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play420051115 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 420051115
		arg_482_1.duration_ = 5.67

		local var_482_0 = {
			zh = 4.933,
			ja = 5.666
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play420051116(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 0.55

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_2 = arg_482_1:FormatText(StoryNameCfg[668].name)

				arg_482_1.leftNameTxt_.text = var_485_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_3 = arg_482_1:GetWordFromCfg(420051115)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 22
				local var_485_6 = utf8.len(var_485_4)
				local var_485_7 = var_485_5 <= 0 and var_485_1 or var_485_1 * (var_485_6 / var_485_5)

				if var_485_7 > 0 and var_485_1 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_0
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051115", "story_v_out_420051.awb") ~= 0 then
					local var_485_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051115", "story_v_out_420051.awb") / 1000

					if var_485_8 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_8 + var_485_0
					end

					if var_485_3.prefab_name ~= "" and arg_482_1.actors_[var_485_3.prefab_name] ~= nil then
						local var_485_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_3.prefab_name].transform, "story_v_out_420051", "420051115", "story_v_out_420051.awb")

						arg_482_1:RecordAudio("420051115", var_485_9)
						arg_482_1:RecordAudio("420051115", var_485_9)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_420051", "420051115", "story_v_out_420051.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_420051", "420051115", "story_v_out_420051.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_10 = math.max(var_485_1, arg_482_1.talkMaxDuration)

			if var_485_0 <= arg_482_1.time_ and arg_482_1.time_ < var_485_0 + var_485_10 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_0) / var_485_10

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_0 + var_485_10 and arg_482_1.time_ < var_485_0 + var_485_10 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play420051116 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 420051116
		arg_486_1.duration_ = 15.7

		local var_486_0 = {
			zh = 10.3,
			ja = 15.7
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play420051117(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0
			local var_489_1 = 1.225

			if var_489_0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_2 = arg_486_1:FormatText(StoryNameCfg[668].name)

				arg_486_1.leftNameTxt_.text = var_489_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_3 = arg_486_1:GetWordFromCfg(420051116)
				local var_489_4 = arg_486_1:FormatText(var_489_3.content)

				arg_486_1.text_.text = var_489_4

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_5 = 49
				local var_489_6 = utf8.len(var_489_4)
				local var_489_7 = var_489_5 <= 0 and var_489_1 or var_489_1 * (var_489_6 / var_489_5)

				if var_489_7 > 0 and var_489_1 < var_489_7 then
					arg_486_1.talkMaxDuration = var_489_7

					if var_489_7 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_7 + var_489_0
					end
				end

				arg_486_1.text_.text = var_489_4
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051116", "story_v_out_420051.awb") ~= 0 then
					local var_489_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051116", "story_v_out_420051.awb") / 1000

					if var_489_8 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_8 + var_489_0
					end

					if var_489_3.prefab_name ~= "" and arg_486_1.actors_[var_489_3.prefab_name] ~= nil then
						local var_489_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_3.prefab_name].transform, "story_v_out_420051", "420051116", "story_v_out_420051.awb")

						arg_486_1:RecordAudio("420051116", var_489_9)
						arg_486_1:RecordAudio("420051116", var_489_9)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_420051", "420051116", "story_v_out_420051.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_420051", "420051116", "story_v_out_420051.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_10 = math.max(var_489_1, arg_486_1.talkMaxDuration)

			if var_489_0 <= arg_486_1.time_ and arg_486_1.time_ < var_489_0 + var_489_10 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_0) / var_489_10

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_0 + var_489_10 and arg_486_1.time_ < var_489_0 + var_489_10 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play420051117 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 420051117
		arg_490_1.duration_ = 4.4

		local var_490_0 = {
			zh = 3.533,
			ja = 4.4
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play420051118(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0

			if var_493_0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				arg_490_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			local var_493_1 = 0
			local var_493_2 = 0.4

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_3 = arg_490_1:FormatText(StoryNameCfg[668].name)

				arg_490_1.leftNameTxt_.text = var_493_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_4 = arg_490_1:GetWordFromCfg(420051117)
				local var_493_5 = arg_490_1:FormatText(var_493_4.content)

				arg_490_1.text_.text = var_493_5

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_6 = 16
				local var_493_7 = utf8.len(var_493_5)
				local var_493_8 = var_493_6 <= 0 and var_493_2 or var_493_2 * (var_493_7 / var_493_6)

				if var_493_8 > 0 and var_493_2 < var_493_8 then
					arg_490_1.talkMaxDuration = var_493_8

					if var_493_8 + var_493_1 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_8 + var_493_1
					end
				end

				arg_490_1.text_.text = var_493_5
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051117", "story_v_out_420051.awb") ~= 0 then
					local var_493_9 = manager.audio:GetVoiceLength("story_v_out_420051", "420051117", "story_v_out_420051.awb") / 1000

					if var_493_9 + var_493_1 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_9 + var_493_1
					end

					if var_493_4.prefab_name ~= "" and arg_490_1.actors_[var_493_4.prefab_name] ~= nil then
						local var_493_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_4.prefab_name].transform, "story_v_out_420051", "420051117", "story_v_out_420051.awb")

						arg_490_1:RecordAudio("420051117", var_493_10)
						arg_490_1:RecordAudio("420051117", var_493_10)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_420051", "420051117", "story_v_out_420051.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_420051", "420051117", "story_v_out_420051.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_11 = math.max(var_493_2, arg_490_1.talkMaxDuration)

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_11 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_1) / var_493_11

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_1 + var_493_11 and arg_490_1.time_ < var_493_1 + var_493_11 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play420051118 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 420051118
		arg_494_1.duration_ = 7

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play420051119(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 2

			if var_497_0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_0 + arg_497_0 then
				local var_497_1 = manager.ui.mainCamera.transform.localPosition
				local var_497_2 = Vector3.New(0, 0, 10) + Vector3.New(var_497_1.x, var_497_1.y, 0)
				local var_497_3 = arg_494_1.bgs_.ST0505

				var_497_3.transform.localPosition = var_497_2
				var_497_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_497_4 = var_497_3:GetComponent("SpriteRenderer")

				if var_497_4 and var_497_4.sprite then
					local var_497_5 = (var_497_3.transform.localPosition - var_497_1).z
					local var_497_6 = manager.ui.mainCameraCom_
					local var_497_7 = 2 * var_497_5 * Mathf.Tan(var_497_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_497_8 = var_497_7 * var_497_6.aspect
					local var_497_9 = var_497_4.sprite.bounds.size.x
					local var_497_10 = var_497_4.sprite.bounds.size.y
					local var_497_11 = var_497_8 / var_497_9
					local var_497_12 = var_497_7 / var_497_10
					local var_497_13 = var_497_12 < var_497_11 and var_497_11 or var_497_12

					var_497_3.transform.localScale = Vector3.New(var_497_13, var_497_13, 0)
				end

				for iter_497_0, iter_497_1 in pairs(arg_494_1.bgs_) do
					if iter_497_0 ~= "ST0505" then
						iter_497_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_497_14 = 4

			if var_497_14 < arg_494_1.time_ and arg_494_1.time_ <= var_497_14 + arg_497_0 then
				arg_494_1.allBtn_.enabled = false
			end

			local var_497_15 = 0.3

			if arg_494_1.time_ >= var_497_14 + var_497_15 and arg_494_1.time_ < var_497_14 + var_497_15 + arg_497_0 then
				arg_494_1.allBtn_.enabled = true
			end

			local var_497_16 = 0

			if var_497_16 < arg_494_1.time_ and arg_494_1.time_ <= var_497_16 + arg_497_0 then
				arg_494_1.mask_.enabled = true
				arg_494_1.mask_.raycastTarget = true

				arg_494_1:SetGaussion(false)
			end

			local var_497_17 = 2

			if var_497_16 <= arg_494_1.time_ and arg_494_1.time_ < var_497_16 + var_497_17 then
				local var_497_18 = (arg_494_1.time_ - var_497_16) / var_497_17
				local var_497_19 = Color.New(0, 0, 0)

				var_497_19.a = Mathf.Lerp(0, 1, var_497_18)
				arg_494_1.mask_.color = var_497_19
			end

			if arg_494_1.time_ >= var_497_16 + var_497_17 and arg_494_1.time_ < var_497_16 + var_497_17 + arg_497_0 then
				local var_497_20 = Color.New(0, 0, 0)

				var_497_20.a = 1
				arg_494_1.mask_.color = var_497_20
			end

			local var_497_21 = 2

			if var_497_21 < arg_494_1.time_ and arg_494_1.time_ <= var_497_21 + arg_497_0 then
				arg_494_1.mask_.enabled = true
				arg_494_1.mask_.raycastTarget = true

				arg_494_1:SetGaussion(false)
			end

			local var_497_22 = 2

			if var_497_21 <= arg_494_1.time_ and arg_494_1.time_ < var_497_21 + var_497_22 then
				local var_497_23 = (arg_494_1.time_ - var_497_21) / var_497_22
				local var_497_24 = Color.New(0, 0, 0)

				var_497_24.a = Mathf.Lerp(1, 0, var_497_23)
				arg_494_1.mask_.color = var_497_24
			end

			if arg_494_1.time_ >= var_497_21 + var_497_22 and arg_494_1.time_ < var_497_21 + var_497_22 + arg_497_0 then
				local var_497_25 = Color.New(0, 0, 0)
				local var_497_26 = 0

				arg_494_1.mask_.enabled = false
				var_497_25.a = var_497_26
				arg_494_1.mask_.color = var_497_25
			end

			local var_497_27 = arg_494_1.actors_["404001ui_story"].transform
			local var_497_28 = 2

			if var_497_28 < arg_494_1.time_ and arg_494_1.time_ <= var_497_28 + arg_497_0 then
				arg_494_1.var_.moveOldPos404001ui_story = var_497_27.localPosition
			end

			local var_497_29 = 0.001

			if var_497_28 <= arg_494_1.time_ and arg_494_1.time_ < var_497_28 + var_497_29 then
				local var_497_30 = (arg_494_1.time_ - var_497_28) / var_497_29
				local var_497_31 = Vector3.New(0, 100, 0)

				var_497_27.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos404001ui_story, var_497_31, var_497_30)

				local var_497_32 = manager.ui.mainCamera.transform.position - var_497_27.position

				var_497_27.forward = Vector3.New(var_497_32.x, var_497_32.y, var_497_32.z)

				local var_497_33 = var_497_27.localEulerAngles

				var_497_33.z = 0
				var_497_33.x = 0
				var_497_27.localEulerAngles = var_497_33
			end

			if arg_494_1.time_ >= var_497_28 + var_497_29 and arg_494_1.time_ < var_497_28 + var_497_29 + arg_497_0 then
				var_497_27.localPosition = Vector3.New(0, 100, 0)

				local var_497_34 = manager.ui.mainCamera.transform.position - var_497_27.position

				var_497_27.forward = Vector3.New(var_497_34.x, var_497_34.y, var_497_34.z)

				local var_497_35 = var_497_27.localEulerAngles

				var_497_35.z = 0
				var_497_35.x = 0
				var_497_27.localEulerAngles = var_497_35
			end

			local var_497_36 = arg_494_1.actors_["1085ui_story"].transform
			local var_497_37 = 2

			if var_497_37 < arg_494_1.time_ and arg_494_1.time_ <= var_497_37 + arg_497_0 then
				arg_494_1.var_.moveOldPos1085ui_story = var_497_36.localPosition
			end

			local var_497_38 = 0.001

			if var_497_37 <= arg_494_1.time_ and arg_494_1.time_ < var_497_37 + var_497_38 then
				local var_497_39 = (arg_494_1.time_ - var_497_37) / var_497_38
				local var_497_40 = Vector3.New(0, 100, 0)

				var_497_36.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1085ui_story, var_497_40, var_497_39)

				local var_497_41 = manager.ui.mainCamera.transform.position - var_497_36.position

				var_497_36.forward = Vector3.New(var_497_41.x, var_497_41.y, var_497_41.z)

				local var_497_42 = var_497_36.localEulerAngles

				var_497_42.z = 0
				var_497_42.x = 0
				var_497_36.localEulerAngles = var_497_42
			end

			if arg_494_1.time_ >= var_497_37 + var_497_38 and arg_494_1.time_ < var_497_37 + var_497_38 + arg_497_0 then
				var_497_36.localPosition = Vector3.New(0, 100, 0)

				local var_497_43 = manager.ui.mainCamera.transform.position - var_497_36.position

				var_497_36.forward = Vector3.New(var_497_43.x, var_497_43.y, var_497_43.z)

				local var_497_44 = var_497_36.localEulerAngles

				var_497_44.z = 0
				var_497_44.x = 0
				var_497_36.localEulerAngles = var_497_44
			end

			local var_497_45 = arg_494_1.actors_["404001ui_story"].transform
			local var_497_46 = 3.9

			if var_497_46 < arg_494_1.time_ and arg_494_1.time_ <= var_497_46 + arg_497_0 then
				arg_494_1.var_.moveOldPos404001ui_story = var_497_45.localPosition
			end

			local var_497_47 = 0.001

			if var_497_46 <= arg_494_1.time_ and arg_494_1.time_ < var_497_46 + var_497_47 then
				local var_497_48 = (arg_494_1.time_ - var_497_46) / var_497_47
				local var_497_49 = Vector3.New(0, -1.55, -5.5)

				var_497_45.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos404001ui_story, var_497_49, var_497_48)

				local var_497_50 = manager.ui.mainCamera.transform.position - var_497_45.position

				var_497_45.forward = Vector3.New(var_497_50.x, var_497_50.y, var_497_50.z)

				local var_497_51 = var_497_45.localEulerAngles

				var_497_51.z = 0
				var_497_51.x = 0
				var_497_45.localEulerAngles = var_497_51
			end

			if arg_494_1.time_ >= var_497_46 + var_497_47 and arg_494_1.time_ < var_497_46 + var_497_47 + arg_497_0 then
				var_497_45.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_497_52 = manager.ui.mainCamera.transform.position - var_497_45.position

				var_497_45.forward = Vector3.New(var_497_52.x, var_497_52.y, var_497_52.z)

				local var_497_53 = var_497_45.localEulerAngles

				var_497_53.z = 0
				var_497_53.x = 0
				var_497_45.localEulerAngles = var_497_53
			end

			local var_497_54 = arg_494_1.actors_["404001ui_story"]
			local var_497_55 = 3.9

			if var_497_55 < arg_494_1.time_ and arg_494_1.time_ <= var_497_55 + arg_497_0 and not isNil(var_497_54) and arg_494_1.var_.characterEffect404001ui_story == nil then
				arg_494_1.var_.characterEffect404001ui_story = var_497_54:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_56 = 0.200000002980232

			if var_497_55 <= arg_494_1.time_ and arg_494_1.time_ < var_497_55 + var_497_56 and not isNil(var_497_54) then
				local var_497_57 = (arg_494_1.time_ - var_497_55) / var_497_56

				if arg_494_1.var_.characterEffect404001ui_story and not isNil(var_497_54) then
					arg_494_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= var_497_55 + var_497_56 and arg_494_1.time_ < var_497_55 + var_497_56 + arg_497_0 and not isNil(var_497_54) and arg_494_1.var_.characterEffect404001ui_story then
				arg_494_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_497_58 = 3.9

			if var_497_58 < arg_494_1.time_ and arg_494_1.time_ <= var_497_58 + arg_497_0 then
				arg_494_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_497_59 = 3.9

			if var_497_59 < arg_494_1.time_ and arg_494_1.time_ <= var_497_59 + arg_497_0 then
				arg_494_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_497_60 = 3.93400000184774
			local var_497_61 = 1

			if var_497_60 < arg_494_1.time_ and arg_494_1.time_ <= var_497_60 + arg_497_0 then
				local var_497_62 = "play"
				local var_497_63 = "effect"

				arg_494_1:AudioAction(var_497_62, var_497_63, "se_story_140", "se_story_140_snap", "")
			end

			local var_497_64 = 0
			local var_497_65 = 0.2

			if var_497_64 < arg_494_1.time_ and arg_494_1.time_ <= var_497_64 + arg_497_0 then
				local var_497_66 = "play"
				local var_497_67 = "music"

				arg_494_1:AudioAction(var_497_66, var_497_67, "ui_battle", "ui_battle_stopbgm", "")

				local var_497_68 = ""
				local var_497_69 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_497_69 ~= "" then
					if arg_494_1.bgmTxt_.text ~= var_497_69 and arg_494_1.bgmTxt_.text ~= "" then
						if arg_494_1.bgmTxt2_.text ~= "" then
							arg_494_1.bgmTxt_.text = arg_494_1.bgmTxt2_.text
						end

						arg_494_1.bgmTxt2_.text = var_497_69

						arg_494_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_494_1.bgmTxt_.text = var_497_69
						arg_494_1.bgmTxt2_.text = var_497_69
					end

					if arg_494_1.bgmTimer then
						arg_494_1.bgmTimer:Stop()

						arg_494_1.bgmTimer = nil
					end

					if arg_494_1.settingData.show_music_name == 1 then
						arg_494_1.musicController:SetSelectedState("show")
						arg_494_1.musicAnimator_:Play("open", 0, 0)

						if arg_494_1.settingData.music_time ~= 0 then
							arg_494_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_494_1.settingData.music_time), function()
								if arg_494_1 == nil or isNil(arg_494_1.bgmTxt_) then
									return
								end

								arg_494_1.musicController:SetSelectedState("hide")
								arg_494_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_497_70 = 1.53333333333333
			local var_497_71 = 1

			if var_497_70 < arg_494_1.time_ and arg_494_1.time_ <= var_497_70 + arg_497_0 then
				local var_497_72 = "play"
				local var_497_73 = "effect"

				arg_494_1:AudioAction(var_497_72, var_497_73, "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_494_1.frameCnt_ <= 1 then
				arg_494_1.dialog_:SetActive(false)
			end

			local var_497_74 = 4
			local var_497_75 = 0.25

			if var_497_74 < arg_494_1.time_ and arg_494_1.time_ <= var_497_74 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0

				arg_494_1.dialog_:SetActive(true)

				arg_494_1.dialogCg_.alpha = 0

				local var_497_76 = LeanTween.value(arg_494_1.dialog_, 0, 1, 0.3)

				var_497_76:setOnUpdate(LuaHelper.FloatAction(function(arg_499_0)
					arg_494_1.dialogCg_.alpha = arg_499_0
				end))
				var_497_76:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_494_1.dialog_)
					var_497_76:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_494_1.duration_ = arg_494_1.duration_ + 0.3

				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_77 = arg_494_1:FormatText(StoryNameCfg[668].name)

				arg_494_1.leftNameTxt_.text = var_497_77

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_78 = arg_494_1:GetWordFromCfg(420051118)
				local var_497_79 = arg_494_1:FormatText(var_497_78.content)

				arg_494_1.text_.text = var_497_79

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_80 = 10
				local var_497_81 = utf8.len(var_497_79)
				local var_497_82 = var_497_80 <= 0 and var_497_75 or var_497_75 * (var_497_81 / var_497_80)

				if var_497_82 > 0 and var_497_75 < var_497_82 then
					arg_494_1.talkMaxDuration = var_497_82
					var_497_74 = var_497_74 + 0.3

					if var_497_82 + var_497_74 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_82 + var_497_74
					end
				end

				arg_494_1.text_.text = var_497_79
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051118", "story_v_out_420051.awb") ~= 0 then
					local var_497_83 = manager.audio:GetVoiceLength("story_v_out_420051", "420051118", "story_v_out_420051.awb") / 1000

					if var_497_83 + var_497_74 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_83 + var_497_74
					end

					if var_497_78.prefab_name ~= "" and arg_494_1.actors_[var_497_78.prefab_name] ~= nil then
						local var_497_84 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_78.prefab_name].transform, "story_v_out_420051", "420051118", "story_v_out_420051.awb")

						arg_494_1:RecordAudio("420051118", var_497_84)
						arg_494_1:RecordAudio("420051118", var_497_84)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_420051", "420051118", "story_v_out_420051.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_420051", "420051118", "story_v_out_420051.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_85 = var_497_74 + 0.3
			local var_497_86 = math.max(var_497_75, arg_494_1.talkMaxDuration)

			if var_497_85 <= arg_494_1.time_ and arg_494_1.time_ < var_497_85 + var_497_86 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_85) / var_497_86

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_85 + var_497_86 and arg_494_1.time_ < var_497_85 + var_497_86 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_494_1:InitPlayNodeList()
	end,
	Play420051119 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 420051119
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play420051120(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = arg_501_1.actors_["404001ui_story"].transform
			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 then
				arg_501_1.var_.moveOldPos404001ui_story = var_504_0.localPosition
			end

			local var_504_2 = 0.001

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_2 then
				local var_504_3 = (arg_501_1.time_ - var_504_1) / var_504_2
				local var_504_4 = Vector3.New(0, 100, 0)

				var_504_0.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos404001ui_story, var_504_4, var_504_3)

				local var_504_5 = manager.ui.mainCamera.transform.position - var_504_0.position

				var_504_0.forward = Vector3.New(var_504_5.x, var_504_5.y, var_504_5.z)

				local var_504_6 = var_504_0.localEulerAngles

				var_504_6.z = 0
				var_504_6.x = 0
				var_504_0.localEulerAngles = var_504_6
			end

			if arg_501_1.time_ >= var_504_1 + var_504_2 and arg_501_1.time_ < var_504_1 + var_504_2 + arg_504_0 then
				var_504_0.localPosition = Vector3.New(0, 100, 0)

				local var_504_7 = manager.ui.mainCamera.transform.position - var_504_0.position

				var_504_0.forward = Vector3.New(var_504_7.x, var_504_7.y, var_504_7.z)

				local var_504_8 = var_504_0.localEulerAngles

				var_504_8.z = 0
				var_504_8.x = 0
				var_504_0.localEulerAngles = var_504_8
			end

			local var_504_9 = 0
			local var_504_10 = 1

			if var_504_9 < arg_501_1.time_ and arg_501_1.time_ <= var_504_9 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_11 = arg_501_1:GetWordFromCfg(420051119)
				local var_504_12 = arg_501_1:FormatText(var_504_11.content)

				arg_501_1.text_.text = var_504_12

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_13 = 40
				local var_504_14 = utf8.len(var_504_12)
				local var_504_15 = var_504_13 <= 0 and var_504_10 or var_504_10 * (var_504_14 / var_504_13)

				if var_504_15 > 0 and var_504_10 < var_504_15 then
					arg_501_1.talkMaxDuration = var_504_15

					if var_504_15 + var_504_9 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_15 + var_504_9
					end
				end

				arg_501_1.text_.text = var_504_12
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_16 = math.max(var_504_10, arg_501_1.talkMaxDuration)

			if var_504_9 <= arg_501_1.time_ and arg_501_1.time_ < var_504_9 + var_504_16 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_9) / var_504_16

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_9 + var_504_16 and arg_501_1.time_ < var_504_9 + var_504_16 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play420051120 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 420051120
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play420051121(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0
			local var_508_1 = 0.2

			if var_508_0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_0 + arg_508_0 then
				local var_508_2 = "play"
				local var_508_3 = "music"

				arg_505_1:AudioAction(var_508_2, var_508_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_508_4 = ""
				local var_508_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_508_5 ~= "" then
					if arg_505_1.bgmTxt_.text ~= var_508_5 and arg_505_1.bgmTxt_.text ~= "" then
						if arg_505_1.bgmTxt2_.text ~= "" then
							arg_505_1.bgmTxt_.text = arg_505_1.bgmTxt2_.text
						end

						arg_505_1.bgmTxt2_.text = var_508_5

						arg_505_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_505_1.bgmTxt_.text = var_508_5
						arg_505_1.bgmTxt2_.text = var_508_5
					end

					if arg_505_1.bgmTimer then
						arg_505_1.bgmTimer:Stop()

						arg_505_1.bgmTimer = nil
					end

					if arg_505_1.settingData.show_music_name == 1 then
						arg_505_1.musicController:SetSelectedState("show")
						arg_505_1.musicAnimator_:Play("open", 0, 0)

						if arg_505_1.settingData.music_time ~= 0 then
							arg_505_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_505_1.settingData.music_time), function()
								if arg_505_1 == nil or isNil(arg_505_1.bgmTxt_) then
									return
								end

								arg_505_1.musicController:SetSelectedState("hide")
								arg_505_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_508_6 = 0.333333333333333
			local var_508_7 = 1

			if var_508_6 < arg_505_1.time_ and arg_505_1.time_ <= var_508_6 + arg_508_0 then
				local var_508_8 = "play"
				local var_508_9 = "music"

				arg_505_1:AudioAction(var_508_8, var_508_9, "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_508_10 = ""
				local var_508_11 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

				if var_508_11 ~= "" then
					if arg_505_1.bgmTxt_.text ~= var_508_11 and arg_505_1.bgmTxt_.text ~= "" then
						if arg_505_1.bgmTxt2_.text ~= "" then
							arg_505_1.bgmTxt_.text = arg_505_1.bgmTxt2_.text
						end

						arg_505_1.bgmTxt2_.text = var_508_11

						arg_505_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_505_1.bgmTxt_.text = var_508_11
						arg_505_1.bgmTxt2_.text = var_508_11
					end

					if arg_505_1.bgmTimer then
						arg_505_1.bgmTimer:Stop()

						arg_505_1.bgmTimer = nil
					end

					if arg_505_1.settingData.show_music_name == 1 then
						arg_505_1.musicController:SetSelectedState("show")
						arg_505_1.musicAnimator_:Play("open", 0, 0)

						if arg_505_1.settingData.music_time ~= 0 then
							arg_505_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_505_1.settingData.music_time), function()
								if arg_505_1 == nil or isNil(arg_505_1.bgmTxt_) then
									return
								end

								arg_505_1.musicController:SetSelectedState("hide")
								arg_505_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_508_12 = 0
			local var_508_13 = 0.575

			if var_508_12 < arg_505_1.time_ and arg_505_1.time_ <= var_508_12 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_14 = arg_505_1:GetWordFromCfg(420051120)
				local var_508_15 = arg_505_1:FormatText(var_508_14.content)

				arg_505_1.text_.text = var_508_15

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_16 = 23
				local var_508_17 = utf8.len(var_508_15)
				local var_508_18 = var_508_16 <= 0 and var_508_13 or var_508_13 * (var_508_17 / var_508_16)

				if var_508_18 > 0 and var_508_13 < var_508_18 then
					arg_505_1.talkMaxDuration = var_508_18

					if var_508_18 + var_508_12 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_18 + var_508_12
					end
				end

				arg_505_1.text_.text = var_508_15
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_19 = math.max(var_508_13, arg_505_1.talkMaxDuration)

			if var_508_12 <= arg_505_1.time_ and arg_505_1.time_ < var_508_12 + var_508_19 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_12) / var_508_19

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_12 + var_508_19 and arg_505_1.time_ < var_508_12 + var_508_19 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play420051121 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 420051121
		arg_511_1.duration_ = 5.03

		local var_511_0 = {
			zh = 3.666,
			ja = 5.033
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play420051122(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["404001ui_story"].transform
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.var_.moveOldPos404001ui_story = var_514_0.localPosition
			end

			local var_514_2 = 0.001

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2
				local var_514_4 = Vector3.New(0, -1.55, -5.5)

				var_514_0.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos404001ui_story, var_514_4, var_514_3)

				local var_514_5 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_5.x, var_514_5.y, var_514_5.z)

				local var_514_6 = var_514_0.localEulerAngles

				var_514_6.z = 0
				var_514_6.x = 0
				var_514_0.localEulerAngles = var_514_6
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 then
				var_514_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_514_7 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_7.x, var_514_7.y, var_514_7.z)

				local var_514_8 = var_514_0.localEulerAngles

				var_514_8.z = 0
				var_514_8.x = 0
				var_514_0.localEulerAngles = var_514_8
			end

			local var_514_9 = arg_511_1.actors_["404001ui_story"]
			local var_514_10 = 0

			if var_514_10 < arg_511_1.time_ and arg_511_1.time_ <= var_514_10 + arg_514_0 and not isNil(var_514_9) and arg_511_1.var_.characterEffect404001ui_story == nil then
				arg_511_1.var_.characterEffect404001ui_story = var_514_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_11 = 0.200000002980232

			if var_514_10 <= arg_511_1.time_ and arg_511_1.time_ < var_514_10 + var_514_11 and not isNil(var_514_9) then
				local var_514_12 = (arg_511_1.time_ - var_514_10) / var_514_11

				if arg_511_1.var_.characterEffect404001ui_story and not isNil(var_514_9) then
					arg_511_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= var_514_10 + var_514_11 and arg_511_1.time_ < var_514_10 + var_514_11 + arg_514_0 and not isNil(var_514_9) and arg_511_1.var_.characterEffect404001ui_story then
				arg_511_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_514_13 = 0

			if var_514_13 < arg_511_1.time_ and arg_511_1.time_ <= var_514_13 + arg_514_0 then
				arg_511_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_514_14 = 0
			local var_514_15 = 0.4

			if var_514_14 < arg_511_1.time_ and arg_511_1.time_ <= var_514_14 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_16 = arg_511_1:FormatText(StoryNameCfg[668].name)

				arg_511_1.leftNameTxt_.text = var_514_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_17 = arg_511_1:GetWordFromCfg(420051121)
				local var_514_18 = arg_511_1:FormatText(var_514_17.content)

				arg_511_1.text_.text = var_514_18

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_19 = 16
				local var_514_20 = utf8.len(var_514_18)
				local var_514_21 = var_514_19 <= 0 and var_514_15 or var_514_15 * (var_514_20 / var_514_19)

				if var_514_21 > 0 and var_514_15 < var_514_21 then
					arg_511_1.talkMaxDuration = var_514_21

					if var_514_21 + var_514_14 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_21 + var_514_14
					end
				end

				arg_511_1.text_.text = var_514_18
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051121", "story_v_out_420051.awb") ~= 0 then
					local var_514_22 = manager.audio:GetVoiceLength("story_v_out_420051", "420051121", "story_v_out_420051.awb") / 1000

					if var_514_22 + var_514_14 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_22 + var_514_14
					end

					if var_514_17.prefab_name ~= "" and arg_511_1.actors_[var_514_17.prefab_name] ~= nil then
						local var_514_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_17.prefab_name].transform, "story_v_out_420051", "420051121", "story_v_out_420051.awb")

						arg_511_1:RecordAudio("420051121", var_514_23)
						arg_511_1:RecordAudio("420051121", var_514_23)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_420051", "420051121", "story_v_out_420051.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_420051", "420051121", "story_v_out_420051.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_24 = math.max(var_514_15, arg_511_1.talkMaxDuration)

			if var_514_14 <= arg_511_1.time_ and arg_511_1.time_ < var_514_14 + var_514_24 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_14) / var_514_24

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_14 + var_514_24 and arg_511_1.time_ < var_514_14 + var_514_24 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play420051122 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 420051122
		arg_515_1.duration_ = 3.63

		local var_515_0 = {
			zh = 2.5,
			ja = 3.633
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play420051123(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["404001ui_story"].transform
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.var_.moveOldPos404001ui_story = var_518_0.localPosition
			end

			local var_518_2 = 0.001

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2
				local var_518_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_518_0.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos404001ui_story, var_518_4, var_518_3)

				local var_518_5 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_5.x, var_518_5.y, var_518_5.z)

				local var_518_6 = var_518_0.localEulerAngles

				var_518_6.z = 0
				var_518_6.x = 0
				var_518_0.localEulerAngles = var_518_6
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 then
				var_518_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_518_7 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_7.x, var_518_7.y, var_518_7.z)

				local var_518_8 = var_518_0.localEulerAngles

				var_518_8.z = 0
				var_518_8.x = 0
				var_518_0.localEulerAngles = var_518_8
			end

			local var_518_9 = arg_515_1.actors_["1085ui_story"].transform
			local var_518_10 = 0

			if var_518_10 < arg_515_1.time_ and arg_515_1.time_ <= var_518_10 + arg_518_0 then
				arg_515_1.var_.moveOldPos1085ui_story = var_518_9.localPosition
			end

			local var_518_11 = 0.001

			if var_518_10 <= arg_515_1.time_ and arg_515_1.time_ < var_518_10 + var_518_11 then
				local var_518_12 = (arg_515_1.time_ - var_518_10) / var_518_11
				local var_518_13 = Vector3.New(0.75, -1.01, -5.83)

				var_518_9.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1085ui_story, var_518_13, var_518_12)

				local var_518_14 = manager.ui.mainCamera.transform.position - var_518_9.position

				var_518_9.forward = Vector3.New(var_518_14.x, var_518_14.y, var_518_14.z)

				local var_518_15 = var_518_9.localEulerAngles

				var_518_15.z = 0
				var_518_15.x = 0
				var_518_9.localEulerAngles = var_518_15
			end

			if arg_515_1.time_ >= var_518_10 + var_518_11 and arg_515_1.time_ < var_518_10 + var_518_11 + arg_518_0 then
				var_518_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_518_16 = manager.ui.mainCamera.transform.position - var_518_9.position

				var_518_9.forward = Vector3.New(var_518_16.x, var_518_16.y, var_518_16.z)

				local var_518_17 = var_518_9.localEulerAngles

				var_518_17.z = 0
				var_518_17.x = 0
				var_518_9.localEulerAngles = var_518_17
			end

			local var_518_18 = arg_515_1.actors_["1085ui_story"]
			local var_518_19 = 0

			if var_518_19 < arg_515_1.time_ and arg_515_1.time_ <= var_518_19 + arg_518_0 and not isNil(var_518_18) and arg_515_1.var_.characterEffect1085ui_story == nil then
				arg_515_1.var_.characterEffect1085ui_story = var_518_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_20 = 0.200000002980232

			if var_518_19 <= arg_515_1.time_ and arg_515_1.time_ < var_518_19 + var_518_20 and not isNil(var_518_18) then
				local var_518_21 = (arg_515_1.time_ - var_518_19) / var_518_20

				if arg_515_1.var_.characterEffect1085ui_story and not isNil(var_518_18) then
					arg_515_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= var_518_19 + var_518_20 and arg_515_1.time_ < var_518_19 + var_518_20 + arg_518_0 and not isNil(var_518_18) and arg_515_1.var_.characterEffect1085ui_story then
				arg_515_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_518_22 = arg_515_1.actors_["404001ui_story"]
			local var_518_23 = 0

			if var_518_23 < arg_515_1.time_ and arg_515_1.time_ <= var_518_23 + arg_518_0 and not isNil(var_518_22) and arg_515_1.var_.characterEffect404001ui_story == nil then
				arg_515_1.var_.characterEffect404001ui_story = var_518_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_24 = 0.200000002980232

			if var_518_23 <= arg_515_1.time_ and arg_515_1.time_ < var_518_23 + var_518_24 and not isNil(var_518_22) then
				local var_518_25 = (arg_515_1.time_ - var_518_23) / var_518_24

				if arg_515_1.var_.characterEffect404001ui_story and not isNil(var_518_22) then
					local var_518_26 = Mathf.Lerp(0, 0.5, var_518_25)

					arg_515_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_515_1.var_.characterEffect404001ui_story.fillRatio = var_518_26
				end
			end

			if arg_515_1.time_ >= var_518_23 + var_518_24 and arg_515_1.time_ < var_518_23 + var_518_24 + arg_518_0 and not isNil(var_518_22) and arg_515_1.var_.characterEffect404001ui_story then
				local var_518_27 = 0.5

				arg_515_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_515_1.var_.characterEffect404001ui_story.fillRatio = var_518_27
			end

			local var_518_28 = 0

			if var_518_28 < arg_515_1.time_ and arg_515_1.time_ <= var_518_28 + arg_518_0 then
				arg_515_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_518_29 = 0
			local var_518_30 = 0.275

			if var_518_29 < arg_515_1.time_ and arg_515_1.time_ <= var_518_29 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_31 = arg_515_1:FormatText(StoryNameCfg[328].name)

				arg_515_1.leftNameTxt_.text = var_518_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_32 = arg_515_1:GetWordFromCfg(420051122)
				local var_518_33 = arg_515_1:FormatText(var_518_32.content)

				arg_515_1.text_.text = var_518_33

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_34 = 11
				local var_518_35 = utf8.len(var_518_33)
				local var_518_36 = var_518_34 <= 0 and var_518_30 or var_518_30 * (var_518_35 / var_518_34)

				if var_518_36 > 0 and var_518_30 < var_518_36 then
					arg_515_1.talkMaxDuration = var_518_36

					if var_518_36 + var_518_29 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_36 + var_518_29
					end
				end

				arg_515_1.text_.text = var_518_33
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051122", "story_v_out_420051.awb") ~= 0 then
					local var_518_37 = manager.audio:GetVoiceLength("story_v_out_420051", "420051122", "story_v_out_420051.awb") / 1000

					if var_518_37 + var_518_29 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_37 + var_518_29
					end

					if var_518_32.prefab_name ~= "" and arg_515_1.actors_[var_518_32.prefab_name] ~= nil then
						local var_518_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_32.prefab_name].transform, "story_v_out_420051", "420051122", "story_v_out_420051.awb")

						arg_515_1:RecordAudio("420051122", var_518_38)
						arg_515_1:RecordAudio("420051122", var_518_38)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_420051", "420051122", "story_v_out_420051.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_420051", "420051122", "story_v_out_420051.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_39 = math.max(var_518_30, arg_515_1.talkMaxDuration)

			if var_518_29 <= arg_515_1.time_ and arg_515_1.time_ < var_518_29 + var_518_39 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_29) / var_518_39

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_29 + var_518_39 and arg_515_1.time_ < var_518_29 + var_518_39 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play420051123 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 420051123
		arg_519_1.duration_ = 1.87

		local var_519_0 = {
			zh = 1.1,
			ja = 1.866
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play420051124(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["404001ui_story"]
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.characterEffect404001ui_story == nil then
				arg_519_1.var_.characterEffect404001ui_story = var_522_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 and not isNil(var_522_0) then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2

				if arg_519_1.var_.characterEffect404001ui_story and not isNil(var_522_0) then
					arg_519_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.characterEffect404001ui_story then
				arg_519_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_522_4 = arg_519_1.actors_["1085ui_story"]
			local var_522_5 = 0

			if var_522_5 < arg_519_1.time_ and arg_519_1.time_ <= var_522_5 + arg_522_0 and not isNil(var_522_4) and arg_519_1.var_.characterEffect1085ui_story == nil then
				arg_519_1.var_.characterEffect1085ui_story = var_522_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_6 = 0.200000002980232

			if var_522_5 <= arg_519_1.time_ and arg_519_1.time_ < var_522_5 + var_522_6 and not isNil(var_522_4) then
				local var_522_7 = (arg_519_1.time_ - var_522_5) / var_522_6

				if arg_519_1.var_.characterEffect1085ui_story and not isNil(var_522_4) then
					local var_522_8 = Mathf.Lerp(0, 0.5, var_522_7)

					arg_519_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_519_1.var_.characterEffect1085ui_story.fillRatio = var_522_8
				end
			end

			if arg_519_1.time_ >= var_522_5 + var_522_6 and arg_519_1.time_ < var_522_5 + var_522_6 + arg_522_0 and not isNil(var_522_4) and arg_519_1.var_.characterEffect1085ui_story then
				local var_522_9 = 0.5

				arg_519_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_519_1.var_.characterEffect1085ui_story.fillRatio = var_522_9
			end

			local var_522_10 = 0
			local var_522_11 = 0.125

			if var_522_10 < arg_519_1.time_ and arg_519_1.time_ <= var_522_10 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_12 = arg_519_1:FormatText(StoryNameCfg[668].name)

				arg_519_1.leftNameTxt_.text = var_522_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_13 = arg_519_1:GetWordFromCfg(420051123)
				local var_522_14 = arg_519_1:FormatText(var_522_13.content)

				arg_519_1.text_.text = var_522_14

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_15 = 5
				local var_522_16 = utf8.len(var_522_14)
				local var_522_17 = var_522_15 <= 0 and var_522_11 or var_522_11 * (var_522_16 / var_522_15)

				if var_522_17 > 0 and var_522_11 < var_522_17 then
					arg_519_1.talkMaxDuration = var_522_17

					if var_522_17 + var_522_10 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_17 + var_522_10
					end
				end

				arg_519_1.text_.text = var_522_14
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051123", "story_v_out_420051.awb") ~= 0 then
					local var_522_18 = manager.audio:GetVoiceLength("story_v_out_420051", "420051123", "story_v_out_420051.awb") / 1000

					if var_522_18 + var_522_10 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_18 + var_522_10
					end

					if var_522_13.prefab_name ~= "" and arg_519_1.actors_[var_522_13.prefab_name] ~= nil then
						local var_522_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_13.prefab_name].transform, "story_v_out_420051", "420051123", "story_v_out_420051.awb")

						arg_519_1:RecordAudio("420051123", var_522_19)
						arg_519_1:RecordAudio("420051123", var_522_19)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_420051", "420051123", "story_v_out_420051.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_420051", "420051123", "story_v_out_420051.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_20 = math.max(var_522_11, arg_519_1.talkMaxDuration)

			if var_522_10 <= arg_519_1.time_ and arg_519_1.time_ < var_522_10 + var_522_20 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_10) / var_522_20

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_10 + var_522_20 and arg_519_1.time_ < var_522_10 + var_522_20 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play420051124 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 420051124
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play420051125(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["404001ui_story"]
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.characterEffect404001ui_story == nil then
				arg_523_1.var_.characterEffect404001ui_story = var_526_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_2 = 0.200000002980232

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_2 and not isNil(var_526_0) then
				local var_526_3 = (arg_523_1.time_ - var_526_1) / var_526_2

				if arg_523_1.var_.characterEffect404001ui_story and not isNil(var_526_0) then
					local var_526_4 = Mathf.Lerp(0, 0.5, var_526_3)

					arg_523_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_523_1.var_.characterEffect404001ui_story.fillRatio = var_526_4
				end
			end

			if arg_523_1.time_ >= var_526_1 + var_526_2 and arg_523_1.time_ < var_526_1 + var_526_2 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.characterEffect404001ui_story then
				local var_526_5 = 0.5

				arg_523_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_523_1.var_.characterEffect404001ui_story.fillRatio = var_526_5
			end

			local var_526_6 = 0
			local var_526_7 = 1.55

			if var_526_6 < arg_523_1.time_ and arg_523_1.time_ <= var_526_6 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_8 = arg_523_1:GetWordFromCfg(420051124)
				local var_526_9 = arg_523_1:FormatText(var_526_8.content)

				arg_523_1.text_.text = var_526_9

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_10 = 62
				local var_526_11 = utf8.len(var_526_9)
				local var_526_12 = var_526_10 <= 0 and var_526_7 or var_526_7 * (var_526_11 / var_526_10)

				if var_526_12 > 0 and var_526_7 < var_526_12 then
					arg_523_1.talkMaxDuration = var_526_12

					if var_526_12 + var_526_6 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_12 + var_526_6
					end
				end

				arg_523_1.text_.text = var_526_9
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_13 = math.max(var_526_7, arg_523_1.talkMaxDuration)

			if var_526_6 <= arg_523_1.time_ and arg_523_1.time_ < var_526_6 + var_526_13 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_6) / var_526_13

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_6 + var_526_13 and arg_523_1.time_ < var_526_6 + var_526_13 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play420051125 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 420051125
		arg_527_1.duration_ = 5.4

		local var_527_0 = {
			zh = 4.933,
			ja = 5.4
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play420051126(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = arg_527_1.actors_["1085ui_story"]
			local var_530_1 = 0

			if var_530_1 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.characterEffect1085ui_story == nil then
				arg_527_1.var_.characterEffect1085ui_story = var_530_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_2 = 0.200000002980232

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_2 and not isNil(var_530_0) then
				local var_530_3 = (arg_527_1.time_ - var_530_1) / var_530_2

				if arg_527_1.var_.characterEffect1085ui_story and not isNil(var_530_0) then
					arg_527_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= var_530_1 + var_530_2 and arg_527_1.time_ < var_530_1 + var_530_2 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.characterEffect1085ui_story then
				arg_527_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_530_4 = 0
			local var_530_5 = 0.3

			if var_530_4 < arg_527_1.time_ and arg_527_1.time_ <= var_530_4 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_6 = arg_527_1:FormatText(StoryNameCfg[328].name)

				arg_527_1.leftNameTxt_.text = var_530_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_7 = arg_527_1:GetWordFromCfg(420051125)
				local var_530_8 = arg_527_1:FormatText(var_530_7.content)

				arg_527_1.text_.text = var_530_8

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_9 = 12
				local var_530_10 = utf8.len(var_530_8)
				local var_530_11 = var_530_9 <= 0 and var_530_5 or var_530_5 * (var_530_10 / var_530_9)

				if var_530_11 > 0 and var_530_5 < var_530_11 then
					arg_527_1.talkMaxDuration = var_530_11

					if var_530_11 + var_530_4 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_11 + var_530_4
					end
				end

				arg_527_1.text_.text = var_530_8
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051125", "story_v_out_420051.awb") ~= 0 then
					local var_530_12 = manager.audio:GetVoiceLength("story_v_out_420051", "420051125", "story_v_out_420051.awb") / 1000

					if var_530_12 + var_530_4 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_12 + var_530_4
					end

					if var_530_7.prefab_name ~= "" and arg_527_1.actors_[var_530_7.prefab_name] ~= nil then
						local var_530_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_7.prefab_name].transform, "story_v_out_420051", "420051125", "story_v_out_420051.awb")

						arg_527_1:RecordAudio("420051125", var_530_13)
						arg_527_1:RecordAudio("420051125", var_530_13)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_420051", "420051125", "story_v_out_420051.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_420051", "420051125", "story_v_out_420051.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_14 = math.max(var_530_5, arg_527_1.talkMaxDuration)

			if var_530_4 <= arg_527_1.time_ and arg_527_1.time_ < var_530_4 + var_530_14 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_4) / var_530_14

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_4 + var_530_14 and arg_527_1.time_ < var_530_4 + var_530_14 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play420051126 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 420051126
		arg_531_1.duration_ = 4.87

		local var_531_0 = {
			zh = 2.7,
			ja = 4.866
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play420051127(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = arg_531_1.actors_["404001ui_story"]
			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 and not isNil(var_534_0) and arg_531_1.var_.characterEffect404001ui_story == nil then
				arg_531_1.var_.characterEffect404001ui_story = var_534_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_2 = 0.200000002980232

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_2 and not isNil(var_534_0) then
				local var_534_3 = (arg_531_1.time_ - var_534_1) / var_534_2

				if arg_531_1.var_.characterEffect404001ui_story and not isNil(var_534_0) then
					arg_531_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= var_534_1 + var_534_2 and arg_531_1.time_ < var_534_1 + var_534_2 + arg_534_0 and not isNil(var_534_0) and arg_531_1.var_.characterEffect404001ui_story then
				arg_531_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_534_4 = arg_531_1.actors_["1085ui_story"]
			local var_534_5 = 0

			if var_534_5 < arg_531_1.time_ and arg_531_1.time_ <= var_534_5 + arg_534_0 and not isNil(var_534_4) and arg_531_1.var_.characterEffect1085ui_story == nil then
				arg_531_1.var_.characterEffect1085ui_story = var_534_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_6 = 0.200000002980232

			if var_534_5 <= arg_531_1.time_ and arg_531_1.time_ < var_534_5 + var_534_6 and not isNil(var_534_4) then
				local var_534_7 = (arg_531_1.time_ - var_534_5) / var_534_6

				if arg_531_1.var_.characterEffect1085ui_story and not isNil(var_534_4) then
					local var_534_8 = Mathf.Lerp(0, 0.5, var_534_7)

					arg_531_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1085ui_story.fillRatio = var_534_8
				end
			end

			if arg_531_1.time_ >= var_534_5 + var_534_6 and arg_531_1.time_ < var_534_5 + var_534_6 + arg_534_0 and not isNil(var_534_4) and arg_531_1.var_.characterEffect1085ui_story then
				local var_534_9 = 0.5

				arg_531_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1085ui_story.fillRatio = var_534_9
			end

			local var_534_10 = 0

			if var_534_10 < arg_531_1.time_ and arg_531_1.time_ <= var_534_10 + arg_534_0 then
				arg_531_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_534_11 = 0

			if var_534_11 < arg_531_1.time_ and arg_531_1.time_ <= var_534_11 + arg_534_0 then
				arg_531_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_534_12 = 0
			local var_534_13 = 0.225

			if var_534_12 < arg_531_1.time_ and arg_531_1.time_ <= var_534_12 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_14 = arg_531_1:FormatText(StoryNameCfg[668].name)

				arg_531_1.leftNameTxt_.text = var_534_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_15 = arg_531_1:GetWordFromCfg(420051126)
				local var_534_16 = arg_531_1:FormatText(var_534_15.content)

				arg_531_1.text_.text = var_534_16

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_17 = 9
				local var_534_18 = utf8.len(var_534_16)
				local var_534_19 = var_534_17 <= 0 and var_534_13 or var_534_13 * (var_534_18 / var_534_17)

				if var_534_19 > 0 and var_534_13 < var_534_19 then
					arg_531_1.talkMaxDuration = var_534_19

					if var_534_19 + var_534_12 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_19 + var_534_12
					end
				end

				arg_531_1.text_.text = var_534_16
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051126", "story_v_out_420051.awb") ~= 0 then
					local var_534_20 = manager.audio:GetVoiceLength("story_v_out_420051", "420051126", "story_v_out_420051.awb") / 1000

					if var_534_20 + var_534_12 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_20 + var_534_12
					end

					if var_534_15.prefab_name ~= "" and arg_531_1.actors_[var_534_15.prefab_name] ~= nil then
						local var_534_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_15.prefab_name].transform, "story_v_out_420051", "420051126", "story_v_out_420051.awb")

						arg_531_1:RecordAudio("420051126", var_534_21)
						arg_531_1:RecordAudio("420051126", var_534_21)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_420051", "420051126", "story_v_out_420051.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_420051", "420051126", "story_v_out_420051.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_22 = math.max(var_534_13, arg_531_1.talkMaxDuration)

			if var_534_12 <= arg_531_1.time_ and arg_531_1.time_ < var_534_12 + var_534_22 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_12) / var_534_22

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_12 + var_534_22 and arg_531_1.time_ < var_534_12 + var_534_22 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play420051127 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 420051127
		arg_535_1.duration_ = 6.83

		local var_535_0 = {
			zh = 6.033,
			ja = 6.833
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play420051128(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0
			local var_538_1 = 0.675

			if var_538_0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_2 = arg_535_1:FormatText(StoryNameCfg[668].name)

				arg_535_1.leftNameTxt_.text = var_538_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_3 = arg_535_1:GetWordFromCfg(420051127)
				local var_538_4 = arg_535_1:FormatText(var_538_3.content)

				arg_535_1.text_.text = var_538_4

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_5 = 27
				local var_538_6 = utf8.len(var_538_4)
				local var_538_7 = var_538_5 <= 0 and var_538_1 or var_538_1 * (var_538_6 / var_538_5)

				if var_538_7 > 0 and var_538_1 < var_538_7 then
					arg_535_1.talkMaxDuration = var_538_7

					if var_538_7 + var_538_0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_7 + var_538_0
					end
				end

				arg_535_1.text_.text = var_538_4
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051127", "story_v_out_420051.awb") ~= 0 then
					local var_538_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051127", "story_v_out_420051.awb") / 1000

					if var_538_8 + var_538_0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_8 + var_538_0
					end

					if var_538_3.prefab_name ~= "" and arg_535_1.actors_[var_538_3.prefab_name] ~= nil then
						local var_538_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_3.prefab_name].transform, "story_v_out_420051", "420051127", "story_v_out_420051.awb")

						arg_535_1:RecordAudio("420051127", var_538_9)
						arg_535_1:RecordAudio("420051127", var_538_9)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_420051", "420051127", "story_v_out_420051.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_420051", "420051127", "story_v_out_420051.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_10 = math.max(var_538_1, arg_535_1.talkMaxDuration)

			if var_538_0 <= arg_535_1.time_ and arg_535_1.time_ < var_538_0 + var_538_10 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_0) / var_538_10

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_0 + var_538_10 and arg_535_1.time_ < var_538_0 + var_538_10 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play420051128 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 420051128
		arg_539_1.duration_ = 4.1

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play420051129(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0.666666666666667

			if var_542_0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_0 + arg_542_0 then
				local var_542_1 = manager.ui.mainCamera.transform.localPosition
				local var_542_2 = Vector3.New(0, 0, 10) + Vector3.New(var_542_1.x, var_542_1.y, 0)
				local var_542_3 = arg_539_1.bgs_.STwhite

				var_542_3.transform.localPosition = var_542_2
				var_542_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_542_4 = var_542_3:GetComponent("SpriteRenderer")

				if var_542_4 and var_542_4.sprite then
					local var_542_5 = (var_542_3.transform.localPosition - var_542_1).z
					local var_542_6 = manager.ui.mainCameraCom_
					local var_542_7 = 2 * var_542_5 * Mathf.Tan(var_542_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_542_8 = var_542_7 * var_542_6.aspect
					local var_542_9 = var_542_4.sprite.bounds.size.x
					local var_542_10 = var_542_4.sprite.bounds.size.y
					local var_542_11 = var_542_8 / var_542_9
					local var_542_12 = var_542_7 / var_542_10
					local var_542_13 = var_542_12 < var_542_11 and var_542_11 or var_542_12

					var_542_3.transform.localScale = Vector3.New(var_542_13, var_542_13, 0)
				end

				for iter_542_0, iter_542_1 in pairs(arg_539_1.bgs_) do
					if iter_542_0 ~= "STwhite" then
						iter_542_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_542_14 = 0

			if var_542_14 < arg_539_1.time_ and arg_539_1.time_ <= var_542_14 + arg_542_0 then
				arg_539_1.mask_.enabled = true
				arg_539_1.mask_.raycastTarget = true

				arg_539_1:SetGaussion(false)
			end

			local var_542_15 = 0.666666666666667

			if var_542_14 <= arg_539_1.time_ and arg_539_1.time_ < var_542_14 + var_542_15 then
				local var_542_16 = (arg_539_1.time_ - var_542_14) / var_542_15
				local var_542_17 = Color.New(0, 0, 0)

				var_542_17.a = Mathf.Lerp(0, 1, var_542_16)
				arg_539_1.mask_.color = var_542_17
			end

			if arg_539_1.time_ >= var_542_14 + var_542_15 and arg_539_1.time_ < var_542_14 + var_542_15 + arg_542_0 then
				local var_542_18 = Color.New(0, 0, 0)

				var_542_18.a = 1
				arg_539_1.mask_.color = var_542_18
			end

			local var_542_19 = 0.666666666666667

			if var_542_19 < arg_539_1.time_ and arg_539_1.time_ <= var_542_19 + arg_542_0 then
				arg_539_1.mask_.enabled = true
				arg_539_1.mask_.raycastTarget = true

				arg_539_1:SetGaussion(false)
			end

			local var_542_20 = 2

			if var_542_19 <= arg_539_1.time_ and arg_539_1.time_ < var_542_19 + var_542_20 then
				local var_542_21 = (arg_539_1.time_ - var_542_19) / var_542_20
				local var_542_22 = Color.New(0, 0, 0)

				var_542_22.a = Mathf.Lerp(1, 0, var_542_21)
				arg_539_1.mask_.color = var_542_22
			end

			if arg_539_1.time_ >= var_542_19 + var_542_20 and arg_539_1.time_ < var_542_19 + var_542_20 + arg_542_0 then
				local var_542_23 = Color.New(0, 0, 0)
				local var_542_24 = 0

				arg_539_1.mask_.enabled = false
				var_542_23.a = var_542_24
				arg_539_1.mask_.color = var_542_23
			end

			local var_542_25 = 0.666666666666667

			if var_542_25 < arg_539_1.time_ and arg_539_1.time_ <= var_542_25 + arg_542_0 then
				arg_539_1.cswbg_:SetActive(true)

				local var_542_26 = arg_539_1.cswt_:GetComponent("RectTransform")

				arg_539_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_542_26.offsetMin = Vector2.New(0, 0)
				var_542_26.offsetMax = Vector2.New(0, 130)

				local var_542_27 = arg_539_1:GetWordFromCfg(419145)
				local var_542_28 = arg_539_1:FormatText(var_542_27.content)

				arg_539_1.cswt_.text = var_542_28

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.cswt_)

				arg_539_1.cswt_.fontSize = 120
				arg_539_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_539_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_539_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_542_29 = arg_539_1.actors_["1085ui_story"].transform
			local var_542_30 = 0.666666666666667

			if var_542_30 < arg_539_1.time_ and arg_539_1.time_ <= var_542_30 + arg_542_0 then
				arg_539_1.var_.moveOldPos1085ui_story = var_542_29.localPosition
			end

			local var_542_31 = 0.001

			if var_542_30 <= arg_539_1.time_ and arg_539_1.time_ < var_542_30 + var_542_31 then
				local var_542_32 = (arg_539_1.time_ - var_542_30) / var_542_31
				local var_542_33 = Vector3.New(0, 100, 0)

				var_542_29.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos1085ui_story, var_542_33, var_542_32)

				local var_542_34 = manager.ui.mainCamera.transform.position - var_542_29.position

				var_542_29.forward = Vector3.New(var_542_34.x, var_542_34.y, var_542_34.z)

				local var_542_35 = var_542_29.localEulerAngles

				var_542_35.z = 0
				var_542_35.x = 0
				var_542_29.localEulerAngles = var_542_35
			end

			if arg_539_1.time_ >= var_542_30 + var_542_31 and arg_539_1.time_ < var_542_30 + var_542_31 + arg_542_0 then
				var_542_29.localPosition = Vector3.New(0, 100, 0)

				local var_542_36 = manager.ui.mainCamera.transform.position - var_542_29.position

				var_542_29.forward = Vector3.New(var_542_36.x, var_542_36.y, var_542_36.z)

				local var_542_37 = var_542_29.localEulerAngles

				var_542_37.z = 0
				var_542_37.x = 0
				var_542_29.localEulerAngles = var_542_37
			end

			local var_542_38 = arg_539_1.actors_["404001ui_story"].transform
			local var_542_39 = 0.666666666666667

			if var_542_39 < arg_539_1.time_ and arg_539_1.time_ <= var_542_39 + arg_542_0 then
				arg_539_1.var_.moveOldPos404001ui_story = var_542_38.localPosition
			end

			local var_542_40 = 0.001

			if var_542_39 <= arg_539_1.time_ and arg_539_1.time_ < var_542_39 + var_542_40 then
				local var_542_41 = (arg_539_1.time_ - var_542_39) / var_542_40
				local var_542_42 = Vector3.New(0, 100, 0)

				var_542_38.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos404001ui_story, var_542_42, var_542_41)

				local var_542_43 = manager.ui.mainCamera.transform.position - var_542_38.position

				var_542_38.forward = Vector3.New(var_542_43.x, var_542_43.y, var_542_43.z)

				local var_542_44 = var_542_38.localEulerAngles

				var_542_44.z = 0
				var_542_44.x = 0
				var_542_38.localEulerAngles = var_542_44
			end

			if arg_539_1.time_ >= var_542_39 + var_542_40 and arg_539_1.time_ < var_542_39 + var_542_40 + arg_542_0 then
				var_542_38.localPosition = Vector3.New(0, 100, 0)

				local var_542_45 = manager.ui.mainCamera.transform.position - var_542_38.position

				var_542_38.forward = Vector3.New(var_542_45.x, var_542_45.y, var_542_45.z)

				local var_542_46 = var_542_38.localEulerAngles

				var_542_46.z = 0
				var_542_46.x = 0
				var_542_38.localEulerAngles = var_542_46
			end

			local var_542_47 = 0.666666666666667

			if var_542_47 < arg_539_1.time_ and arg_539_1.time_ <= var_542_47 + arg_542_0 then
				arg_539_1.fswbg_:SetActive(true)
				arg_539_1.dialog_:SetActive(false)

				arg_539_1.fswtw_.percent = 0

				local var_542_48 = arg_539_1:GetWordFromCfg(420051128)
				local var_542_49 = arg_539_1:FormatText(var_542_48.content)

				arg_539_1.fswt_.text = var_542_49

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.fswt_)

				arg_539_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_539_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_539_1.fswtw_:SetDirty()

				arg_539_1.typewritterCharCountI18N = 0

				SetActive(arg_539_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_539_1:ShowNextGo(false)
			end

			local var_542_50 = 2.66666666666667

			if var_542_50 < arg_539_1.time_ and arg_539_1.time_ <= var_542_50 + arg_542_0 then
				arg_539_1.var_.oldValueTypewriter = arg_539_1.fswtw_.percent

				SetActive(arg_539_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_539_1:ShowNextGo(false)
			end

			local var_542_51 = 4
			local var_542_52 = 0.266666666666667
			local var_542_53 = arg_539_1:GetWordFromCfg(420051128)
			local var_542_54 = arg_539_1:FormatText(var_542_53.content)
			local var_542_55, var_542_56 = arg_539_1:GetPercentByPara(var_542_54, 1)

			if var_542_50 < arg_539_1.time_ and arg_539_1.time_ <= var_542_50 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0

				local var_542_57 = var_542_51 <= 0 and var_542_52 or var_542_52 * ((var_542_56 - arg_539_1.typewritterCharCountI18N) / var_542_51)

				if var_542_57 > 0 and var_542_52 < var_542_57 then
					arg_539_1.talkMaxDuration = var_542_57

					if var_542_57 + var_542_50 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_57 + var_542_50
					end
				end
			end

			local var_542_58 = 0.266666666666667
			local var_542_59 = math.max(var_542_58, arg_539_1.talkMaxDuration)

			if var_542_50 <= arg_539_1.time_ and arg_539_1.time_ < var_542_50 + var_542_59 then
				local var_542_60 = (arg_539_1.time_ - var_542_50) / var_542_59

				arg_539_1.fswtw_.percent = Mathf.Lerp(arg_539_1.var_.oldValueTypewriter, var_542_55, var_542_60)
				arg_539_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_539_1.fswtw_:SetDirty()
			end

			if arg_539_1.time_ >= var_542_50 + var_542_59 and arg_539_1.time_ < var_542_50 + var_542_59 + arg_542_0 then
				arg_539_1.fswtw_.percent = var_542_55

				arg_539_1.fswtw_:SetDirty()
				arg_539_1:ShowNextGo(true)

				arg_539_1.typewritterCharCountI18N = var_542_56
			end

			local var_542_61 = 0.666666666666666

			if var_542_61 < arg_539_1.time_ and arg_539_1.time_ <= var_542_61 + arg_542_0 then
				local var_542_62 = arg_539_1.fswbg_.transform:Find("textbox/adapt/content") or arg_539_1.fswbg_.transform:Find("textbox/content")
				local var_542_63 = arg_539_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_542_64 = var_542_62:GetComponent("Text")
				local var_542_65 = var_542_62:GetComponent("RectTransform")

				var_542_64.alignment = UnityEngine.TextAnchor.LowerCenter
				var_542_65.offsetMin = Vector2.New(0, -70)
				var_542_65.offsetMax = Vector2.New(0, 0)
			end

			local var_542_66 = 1.66666666666667
			local var_542_67 = 2.4
			local var_542_68 = manager.audio:GetVoiceLength("story_v_out_420051", "420051128", "story_v_out_420051.awb") / 1000

			if var_542_68 > 0 and var_542_67 < var_542_68 and var_542_68 + var_542_66 > arg_539_1.duration_ then
				local var_542_69 = var_542_68

				arg_539_1.duration_ = var_542_68 + var_542_66
			end

			if var_542_66 < arg_539_1.time_ and arg_539_1.time_ <= var_542_66 + arg_542_0 then
				local var_542_70 = "play"
				local var_542_71 = "voice"

				arg_539_1:AudioAction(var_542_70, var_542_71, "story_v_out_420051", "420051128", "story_v_out_420051.awb")
			end

			local var_542_72 = 0.05
			local var_542_73 = 1

			if var_542_72 < arg_539_1.time_ and arg_539_1.time_ <= var_542_72 + arg_542_0 then
				local var_542_74 = "stop"
				local var_542_75 = "effect"

				arg_539_1:AudioAction(var_542_74, var_542_75, "se_story_140", "se_story_140_amb_room01", "")
			end
		end

		arg_539_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_539_1:InitPlayNodeList()
	end,
	Play420051129 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 420051129
		arg_543_1.duration_ = 1.22

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play420051130(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0

			if var_546_0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_0 + arg_546_0 then
				arg_543_1.fswbg_:SetActive(true)
				arg_543_1.dialog_:SetActive(false)

				arg_543_1.fswtw_.percent = 0

				local var_546_1 = arg_543_1:GetWordFromCfg(420051129)
				local var_546_2 = arg_543_1:FormatText(var_546_1.content)

				arg_543_1.fswt_.text = var_546_2

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.fswt_)

				arg_543_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_543_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_543_1.fswtw_:SetDirty()

				arg_543_1.typewritterCharCountI18N = 0

				SetActive(arg_543_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_543_1:ShowNextGo(false)
			end

			local var_546_3 = 0.0166666666666667

			if var_546_3 < arg_543_1.time_ and arg_543_1.time_ <= var_546_3 + arg_546_0 then
				arg_543_1.var_.oldValueTypewriter = arg_543_1.fswtw_.percent

				SetActive(arg_543_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_543_1:ShowNextGo(false)
			end

			local var_546_4 = 18
			local var_546_5 = 1.2
			local var_546_6 = arg_543_1:GetWordFromCfg(420051129)
			local var_546_7 = arg_543_1:FormatText(var_546_6.content)
			local var_546_8, var_546_9 = arg_543_1:GetPercentByPara(var_546_7, 1)

			if var_546_3 < arg_543_1.time_ and arg_543_1.time_ <= var_546_3 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0

				local var_546_10 = var_546_4 <= 0 and var_546_5 or var_546_5 * ((var_546_9 - arg_543_1.typewritterCharCountI18N) / var_546_4)

				if var_546_10 > 0 and var_546_5 < var_546_10 then
					arg_543_1.talkMaxDuration = var_546_10

					if var_546_10 + var_546_3 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_10 + var_546_3
					end
				end
			end

			local var_546_11 = 1.2
			local var_546_12 = math.max(var_546_11, arg_543_1.talkMaxDuration)

			if var_546_3 <= arg_543_1.time_ and arg_543_1.time_ < var_546_3 + var_546_12 then
				local var_546_13 = (arg_543_1.time_ - var_546_3) / var_546_12

				arg_543_1.fswtw_.percent = Mathf.Lerp(arg_543_1.var_.oldValueTypewriter, var_546_8, var_546_13)
				arg_543_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_543_1.fswtw_:SetDirty()
			end

			if arg_543_1.time_ >= var_546_3 + var_546_12 and arg_543_1.time_ < var_546_3 + var_546_12 + arg_546_0 then
				arg_543_1.fswtw_.percent = var_546_8

				arg_543_1.fswtw_:SetDirty()
				arg_543_1:ShowNextGo(true)

				arg_543_1.typewritterCharCountI18N = var_546_9
			end

			local var_546_14 = 0.216666666666
			local var_546_15 = 1

			if var_546_14 < arg_543_1.time_ and arg_543_1.time_ <= var_546_14 + arg_546_0 then
				local var_546_16 = "play"
				local var_546_17 = "effect"

				arg_543_1:AudioAction(var_546_16, var_546_17, "se_story_side_1042", "se_story_1042_doorbell", "")
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play420051130 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 420051130
		arg_547_1.duration_ = 9

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play420051131(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = 0

			if var_550_0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_0 + arg_550_0 then
				arg_547_1.mask_.enabled = true
				arg_547_1.mask_.raycastTarget = true

				arg_547_1:SetGaussion(false)
			end

			local var_550_1 = 2

			if var_550_0 <= arg_547_1.time_ and arg_547_1.time_ < var_550_0 + var_550_1 then
				local var_550_2 = (arg_547_1.time_ - var_550_0) / var_550_1
				local var_550_3 = Color.New(0, 0, 0)

				var_550_3.a = Mathf.Lerp(0, 1, var_550_2)
				arg_547_1.mask_.color = var_550_3
			end

			if arg_547_1.time_ >= var_550_0 + var_550_1 and arg_547_1.time_ < var_550_0 + var_550_1 + arg_550_0 then
				local var_550_4 = Color.New(0, 0, 0)

				var_550_4.a = 1
				arg_547_1.mask_.color = var_550_4
			end

			local var_550_5 = 2

			if var_550_5 < arg_547_1.time_ and arg_547_1.time_ <= var_550_5 + arg_550_0 then
				arg_547_1.mask_.enabled = true
				arg_547_1.mask_.raycastTarget = true

				arg_547_1:SetGaussion(false)
			end

			local var_550_6 = 2

			if var_550_5 <= arg_547_1.time_ and arg_547_1.time_ < var_550_5 + var_550_6 then
				local var_550_7 = (arg_547_1.time_ - var_550_5) / var_550_6
				local var_550_8 = Color.New(0, 0, 0)

				var_550_8.a = Mathf.Lerp(1, 0, var_550_7)
				arg_547_1.mask_.color = var_550_8
			end

			if arg_547_1.time_ >= var_550_5 + var_550_6 and arg_547_1.time_ < var_550_5 + var_550_6 + arg_550_0 then
				local var_550_9 = Color.New(0, 0, 0)
				local var_550_10 = 0

				arg_547_1.mask_.enabled = false
				var_550_9.a = var_550_10
				arg_547_1.mask_.color = var_550_9
			end

			local var_550_11 = 2

			if var_550_11 < arg_547_1.time_ and arg_547_1.time_ <= var_550_11 + arg_550_0 then
				local var_550_12 = manager.ui.mainCamera.transform.localPosition
				local var_550_13 = Vector3.New(0, 0, 10) + Vector3.New(var_550_12.x, var_550_12.y, 0)
				local var_550_14 = arg_547_1.bgs_.ST0505

				var_550_14.transform.localPosition = var_550_13
				var_550_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_550_15 = var_550_14:GetComponent("SpriteRenderer")

				if var_550_15 and var_550_15.sprite then
					local var_550_16 = (var_550_14.transform.localPosition - var_550_12).z
					local var_550_17 = manager.ui.mainCameraCom_
					local var_550_18 = 2 * var_550_16 * Mathf.Tan(var_550_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_550_19 = var_550_18 * var_550_17.aspect
					local var_550_20 = var_550_15.sprite.bounds.size.x
					local var_550_21 = var_550_15.sprite.bounds.size.y
					local var_550_22 = var_550_19 / var_550_20
					local var_550_23 = var_550_18 / var_550_21
					local var_550_24 = var_550_23 < var_550_22 and var_550_22 or var_550_23

					var_550_14.transform.localScale = Vector3.New(var_550_24, var_550_24, 0)
				end

				for iter_550_0, iter_550_1 in pairs(arg_547_1.bgs_) do
					if iter_550_0 ~= "ST0505" then
						iter_550_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_550_25 = 1.93333333333333

			if var_550_25 < arg_547_1.time_ and arg_547_1.time_ <= var_550_25 + arg_550_0 then
				arg_547_1.fswbg_:SetActive(false)
				arg_547_1.dialog_:SetActive(false)
				SetActive(arg_547_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_547_1:ShowNextGo(false)
			end

			local var_550_26 = 1.93333333333333

			if var_550_26 < arg_547_1.time_ and arg_547_1.time_ <= var_550_26 + arg_550_0 then
				arg_547_1.cswbg_:SetActive(false)
			end

			local var_550_27 = 4
			local var_550_28 = 1.025

			if var_550_27 < arg_547_1.time_ and arg_547_1.time_ <= var_550_27 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, false)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_29 = arg_547_1:GetWordFromCfg(420051130)
				local var_550_30 = arg_547_1:FormatText(var_550_29.content)

				arg_547_1.text_.text = var_550_30

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_31 = 41
				local var_550_32 = utf8.len(var_550_30)
				local var_550_33 = var_550_31 <= 0 and var_550_28 or var_550_28 * (var_550_32 / var_550_31)

				if var_550_33 > 0 and var_550_28 < var_550_33 then
					arg_547_1.talkMaxDuration = var_550_33

					if var_550_33 + var_550_27 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_33 + var_550_27
					end
				end

				arg_547_1.text_.text = var_550_30
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_34 = math.max(var_550_28, arg_547_1.talkMaxDuration)

			if var_550_27 <= arg_547_1.time_ and arg_547_1.time_ < var_550_27 + var_550_34 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_27) / var_550_34

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_27 + var_550_34 and arg_547_1.time_ < var_550_27 + var_550_34 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play420051131 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 420051131
		arg_551_1.duration_ = 2.3

		local var_551_0 = {
			zh = 1.8,
			ja = 2.3
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play420051132(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0
			local var_554_1 = 1.025

			if var_554_0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_2 = arg_551_1:FormatText(StoryNameCfg[328].name)

				arg_551_1.leftNameTxt_.text = var_554_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1085")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_3 = arg_551_1:GetWordFromCfg(420051131)
				local var_554_4 = arg_551_1:FormatText(var_554_3.content)

				arg_551_1.text_.text = var_554_4

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_5 = 10
				local var_554_6 = utf8.len(var_554_4)
				local var_554_7 = var_554_5 <= 0 and var_554_1 or var_554_1 * (var_554_6 / var_554_5)

				if var_554_7 > 0 and var_554_1 < var_554_7 then
					arg_551_1.talkMaxDuration = var_554_7

					if var_554_7 + var_554_0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_7 + var_554_0
					end
				end

				arg_551_1.text_.text = var_554_4
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051131", "story_v_out_420051.awb") ~= 0 then
					local var_554_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051131", "story_v_out_420051.awb") / 1000

					if var_554_8 + var_554_0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_8 + var_554_0
					end

					if var_554_3.prefab_name ~= "" and arg_551_1.actors_[var_554_3.prefab_name] ~= nil then
						local var_554_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_3.prefab_name].transform, "story_v_out_420051", "420051131", "story_v_out_420051.awb")

						arg_551_1:RecordAudio("420051131", var_554_9)
						arg_551_1:RecordAudio("420051131", var_554_9)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_420051", "420051131", "story_v_out_420051.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_420051", "420051131", "story_v_out_420051.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_10 = math.max(var_554_1, arg_551_1.talkMaxDuration)

			if var_554_0 <= arg_551_1.time_ and arg_551_1.time_ < var_554_0 + var_554_10 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_0) / var_554_10

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_0 + var_554_10 and arg_551_1.time_ < var_554_0 + var_554_10 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play420051132 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 420051132
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play420051133(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0.133333333333333
			local var_558_1 = 1

			if var_558_0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_0 + arg_558_0 then
				local var_558_2 = "play"
				local var_558_3 = "effect"

				arg_555_1:AudioAction(var_558_2, var_558_3, "se_story_1311", "se_story_1311_footsteps", "")
			end

			local var_558_4 = 0
			local var_558_5 = 0.75

			if var_558_4 < arg_555_1.time_ and arg_555_1.time_ <= var_558_4 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_6 = arg_555_1:GetWordFromCfg(420051132)
				local var_558_7 = arg_555_1:FormatText(var_558_6.content)

				arg_555_1.text_.text = var_558_7

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_8 = 30
				local var_558_9 = utf8.len(var_558_7)
				local var_558_10 = var_558_8 <= 0 and var_558_5 or var_558_5 * (var_558_9 / var_558_8)

				if var_558_10 > 0 and var_558_5 < var_558_10 then
					arg_555_1.talkMaxDuration = var_558_10

					if var_558_10 + var_558_4 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_10 + var_558_4
					end
				end

				arg_555_1.text_.text = var_558_7
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_11 = math.max(var_558_5, arg_555_1.talkMaxDuration)

			if var_558_4 <= arg_555_1.time_ and arg_555_1.time_ < var_558_4 + var_558_11 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_4) / var_558_11

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_4 + var_558_11 and arg_555_1.time_ < var_558_4 + var_558_11 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play420051133 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 420051133
		arg_559_1.duration_ = 5.1

		local var_559_0 = {
			zh = 3.466,
			ja = 5.1
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play420051134(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0
			local var_562_1 = 0.35

			if var_562_0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				local var_562_2 = arg_559_1:FormatText(StoryNameCfg[1156].name)

				arg_559_1.leftNameTxt_.text = var_562_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_3 = arg_559_1:GetWordFromCfg(420051133)
				local var_562_4 = arg_559_1:FormatText(var_562_3.content)

				arg_559_1.text_.text = var_562_4

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_5 = 14
				local var_562_6 = utf8.len(var_562_4)
				local var_562_7 = var_562_5 <= 0 and var_562_1 or var_562_1 * (var_562_6 / var_562_5)

				if var_562_7 > 0 and var_562_1 < var_562_7 then
					arg_559_1.talkMaxDuration = var_562_7

					if var_562_7 + var_562_0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_7 + var_562_0
					end
				end

				arg_559_1.text_.text = var_562_4
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051133", "story_v_out_420051.awb") ~= 0 then
					local var_562_8 = manager.audio:GetVoiceLength("story_v_out_420051", "420051133", "story_v_out_420051.awb") / 1000

					if var_562_8 + var_562_0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_8 + var_562_0
					end

					if var_562_3.prefab_name ~= "" and arg_559_1.actors_[var_562_3.prefab_name] ~= nil then
						local var_562_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_3.prefab_name].transform, "story_v_out_420051", "420051133", "story_v_out_420051.awb")

						arg_559_1:RecordAudio("420051133", var_562_9)
						arg_559_1:RecordAudio("420051133", var_562_9)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_out_420051", "420051133", "story_v_out_420051.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_out_420051", "420051133", "story_v_out_420051.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_10 = math.max(var_562_1, arg_559_1.talkMaxDuration)

			if var_562_0 <= arg_559_1.time_ and arg_559_1.time_ < var_562_0 + var_562_10 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_0) / var_562_10

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_0 + var_562_10 and arg_559_1.time_ < var_562_0 + var_562_10 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play420051134 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 420051134
		arg_563_1.duration_ = 2

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play420051135(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = arg_563_1.actors_["404001ui_story"].transform
			local var_566_1 = 0

			if var_566_1 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 then
				arg_563_1.var_.moveOldPos404001ui_story = var_566_0.localPosition
			end

			local var_566_2 = 0.001

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_2 then
				local var_566_3 = (arg_563_1.time_ - var_566_1) / var_566_2
				local var_566_4 = Vector3.New(0, -1.55, -5.5)

				var_566_0.localPosition = Vector3.Lerp(arg_563_1.var_.moveOldPos404001ui_story, var_566_4, var_566_3)

				local var_566_5 = manager.ui.mainCamera.transform.position - var_566_0.position

				var_566_0.forward = Vector3.New(var_566_5.x, var_566_5.y, var_566_5.z)

				local var_566_6 = var_566_0.localEulerAngles

				var_566_6.z = 0
				var_566_6.x = 0
				var_566_0.localEulerAngles = var_566_6
			end

			if arg_563_1.time_ >= var_566_1 + var_566_2 and arg_563_1.time_ < var_566_1 + var_566_2 + arg_566_0 then
				var_566_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_566_7 = manager.ui.mainCamera.transform.position - var_566_0.position

				var_566_0.forward = Vector3.New(var_566_7.x, var_566_7.y, var_566_7.z)

				local var_566_8 = var_566_0.localEulerAngles

				var_566_8.z = 0
				var_566_8.x = 0
				var_566_0.localEulerAngles = var_566_8
			end

			local var_566_9 = arg_563_1.actors_["404001ui_story"]
			local var_566_10 = 0

			if var_566_10 < arg_563_1.time_ and arg_563_1.time_ <= var_566_10 + arg_566_0 and not isNil(var_566_9) and arg_563_1.var_.characterEffect404001ui_story == nil then
				arg_563_1.var_.characterEffect404001ui_story = var_566_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_11 = 0.200000002980232

			if var_566_10 <= arg_563_1.time_ and arg_563_1.time_ < var_566_10 + var_566_11 and not isNil(var_566_9) then
				local var_566_12 = (arg_563_1.time_ - var_566_10) / var_566_11

				if arg_563_1.var_.characterEffect404001ui_story and not isNil(var_566_9) then
					arg_563_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_563_1.time_ >= var_566_10 + var_566_11 and arg_563_1.time_ < var_566_10 + var_566_11 + arg_566_0 and not isNil(var_566_9) and arg_563_1.var_.characterEffect404001ui_story then
				arg_563_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_566_13 = "1042ui_story"

			if arg_563_1.actors_[var_566_13] == nil then
				local var_566_14 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_566_14) then
					local var_566_15 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_563_1.stage_.transform)

					var_566_15.name = var_566_13
					var_566_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_563_1.actors_[var_566_13] = var_566_15

					local var_566_16 = var_566_15:GetComponentInChildren(typeof(CharacterEffect))

					var_566_16.enabled = true

					local var_566_17 = GameObjectTools.GetOrAddComponent(var_566_15, typeof(DynamicBoneHelper))

					if var_566_17 then
						var_566_17:EnableDynamicBone(false)
					end

					arg_563_1:ShowWeapon(var_566_16.transform, false)

					arg_563_1.var_[var_566_13 .. "Animator"] = var_566_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_563_1.var_[var_566_13 .. "Animator"].applyRootMotion = true
					arg_563_1.var_[var_566_13 .. "LipSync"] = var_566_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_566_18 = arg_563_1.actors_["1042ui_story"]
			local var_566_19 = 0

			if var_566_19 < arg_563_1.time_ and arg_563_1.time_ <= var_566_19 + arg_566_0 and not isNil(var_566_18) and arg_563_1.var_.characterEffect1042ui_story == nil then
				arg_563_1.var_.characterEffect1042ui_story = var_566_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_20 = 0.200000002980232

			if var_566_19 <= arg_563_1.time_ and arg_563_1.time_ < var_566_19 + var_566_20 and not isNil(var_566_18) then
				local var_566_21 = (arg_563_1.time_ - var_566_19) / var_566_20

				if arg_563_1.var_.characterEffect1042ui_story and not isNil(var_566_18) then
					local var_566_22 = Mathf.Lerp(0, 0.5, var_566_21)

					arg_563_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_563_1.var_.characterEffect1042ui_story.fillRatio = var_566_22
				end
			end

			if arg_563_1.time_ >= var_566_19 + var_566_20 and arg_563_1.time_ < var_566_19 + var_566_20 + arg_566_0 and not isNil(var_566_18) and arg_563_1.var_.characterEffect1042ui_story then
				local var_566_23 = 0.5

				arg_563_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_563_1.var_.characterEffect1042ui_story.fillRatio = var_566_23
			end

			local var_566_24 = 0

			if var_566_24 < arg_563_1.time_ and arg_563_1.time_ <= var_566_24 + arg_566_0 then
				arg_563_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_566_25 = 0

			if var_566_25 < arg_563_1.time_ and arg_563_1.time_ <= var_566_25 + arg_566_0 then
				arg_563_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_566_26 = 0
			local var_566_27 = 0.15

			if var_566_26 < arg_563_1.time_ and arg_563_1.time_ <= var_566_26 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_28 = arg_563_1:FormatText(StoryNameCfg[668].name)

				arg_563_1.leftNameTxt_.text = var_566_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_29 = arg_563_1:GetWordFromCfg(420051134)
				local var_566_30 = arg_563_1:FormatText(var_566_29.content)

				arg_563_1.text_.text = var_566_30

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_31 = 6
				local var_566_32 = utf8.len(var_566_30)
				local var_566_33 = var_566_31 <= 0 and var_566_27 or var_566_27 * (var_566_32 / var_566_31)

				if var_566_33 > 0 and var_566_27 < var_566_33 then
					arg_563_1.talkMaxDuration = var_566_33

					if var_566_33 + var_566_26 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_33 + var_566_26
					end
				end

				arg_563_1.text_.text = var_566_30
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051134", "story_v_out_420051.awb") ~= 0 then
					local var_566_34 = manager.audio:GetVoiceLength("story_v_out_420051", "420051134", "story_v_out_420051.awb") / 1000

					if var_566_34 + var_566_26 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_34 + var_566_26
					end

					if var_566_29.prefab_name ~= "" and arg_563_1.actors_[var_566_29.prefab_name] ~= nil then
						local var_566_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_29.prefab_name].transform, "story_v_out_420051", "420051134", "story_v_out_420051.awb")

						arg_563_1:RecordAudio("420051134", var_566_35)
						arg_563_1:RecordAudio("420051134", var_566_35)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_420051", "420051134", "story_v_out_420051.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_420051", "420051134", "story_v_out_420051.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_36 = math.max(var_566_27, arg_563_1.talkMaxDuration)

			if var_566_26 <= arg_563_1.time_ and arg_563_1.time_ < var_566_26 + var_566_36 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_26) / var_566_36

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_26 + var_566_36 and arg_563_1.time_ < var_566_26 + var_566_36 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_563_1:InitPlayNodeList()
	end,
	Play420051135 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 420051135
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play420051136(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = arg_567_1.actors_["404001ui_story"].transform
			local var_570_1 = 0

			if var_570_1 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 then
				arg_567_1.var_.moveOldPos404001ui_story = var_570_0.localPosition
			end

			local var_570_2 = 0.001

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_2 then
				local var_570_3 = (arg_567_1.time_ - var_570_1) / var_570_2
				local var_570_4 = Vector3.New(0, 100, 0)

				var_570_0.localPosition = Vector3.Lerp(arg_567_1.var_.moveOldPos404001ui_story, var_570_4, var_570_3)

				local var_570_5 = manager.ui.mainCamera.transform.position - var_570_0.position

				var_570_0.forward = Vector3.New(var_570_5.x, var_570_5.y, var_570_5.z)

				local var_570_6 = var_570_0.localEulerAngles

				var_570_6.z = 0
				var_570_6.x = 0
				var_570_0.localEulerAngles = var_570_6
			end

			if arg_567_1.time_ >= var_570_1 + var_570_2 and arg_567_1.time_ < var_570_1 + var_570_2 + arg_570_0 then
				var_570_0.localPosition = Vector3.New(0, 100, 0)

				local var_570_7 = manager.ui.mainCamera.transform.position - var_570_0.position

				var_570_0.forward = Vector3.New(var_570_7.x, var_570_7.y, var_570_7.z)

				local var_570_8 = var_570_0.localEulerAngles

				var_570_8.z = 0
				var_570_8.x = 0
				var_570_0.localEulerAngles = var_570_8
			end

			local var_570_9 = 0
			local var_570_10 = 1.175

			if var_570_9 < arg_567_1.time_ and arg_567_1.time_ <= var_570_9 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, false)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_11 = arg_567_1:GetWordFromCfg(420051135)
				local var_570_12 = arg_567_1:FormatText(var_570_11.content)

				arg_567_1.text_.text = var_570_12

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_13 = 47
				local var_570_14 = utf8.len(var_570_12)
				local var_570_15 = var_570_13 <= 0 and var_570_10 or var_570_10 * (var_570_14 / var_570_13)

				if var_570_15 > 0 and var_570_10 < var_570_15 then
					arg_567_1.talkMaxDuration = var_570_15

					if var_570_15 + var_570_9 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_15 + var_570_9
					end
				end

				arg_567_1.text_.text = var_570_12
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_16 = math.max(var_570_10, arg_567_1.talkMaxDuration)

			if var_570_9 <= arg_567_1.time_ and arg_567_1.time_ < var_570_9 + var_570_16 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_9) / var_570_16

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_9 + var_570_16 and arg_567_1.time_ < var_570_9 + var_570_16 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_567_1:InitPlayNodeList()
	end,
	Play420051136 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 420051136
		arg_571_1.duration_ = 9.1

		local var_571_0 = {
			zh = 9.099999999999,
			ja = 8.765999999999
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play420051137(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 1.999999999999

			if var_574_0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_0 + arg_574_0 then
				local var_574_1 = manager.ui.mainCamera.transform.localPosition
				local var_574_2 = Vector3.New(0, 0, 10) + Vector3.New(var_574_1.x, var_574_1.y, 0)
				local var_574_3 = arg_571_1.bgs_.ST61

				var_574_3.transform.localPosition = var_574_2
				var_574_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_574_4 = var_574_3:GetComponent("SpriteRenderer")

				if var_574_4 and var_574_4.sprite then
					local var_574_5 = (var_574_3.transform.localPosition - var_574_1).z
					local var_574_6 = manager.ui.mainCameraCom_
					local var_574_7 = 2 * var_574_5 * Mathf.Tan(var_574_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_574_8 = var_574_7 * var_574_6.aspect
					local var_574_9 = var_574_4.sprite.bounds.size.x
					local var_574_10 = var_574_4.sprite.bounds.size.y
					local var_574_11 = var_574_8 / var_574_9
					local var_574_12 = var_574_7 / var_574_10
					local var_574_13 = var_574_12 < var_574_11 and var_574_11 or var_574_12

					var_574_3.transform.localScale = Vector3.New(var_574_13, var_574_13, 0)
				end

				for iter_574_0, iter_574_1 in pairs(arg_571_1.bgs_) do
					if iter_574_0 ~= "ST61" then
						iter_574_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_574_14 = 3.999999999999

			if var_574_14 < arg_571_1.time_ and arg_571_1.time_ <= var_574_14 + arg_574_0 then
				arg_571_1.allBtn_.enabled = false
			end

			local var_574_15 = 0.3

			if arg_571_1.time_ >= var_574_14 + var_574_15 and arg_571_1.time_ < var_574_14 + var_574_15 + arg_574_0 then
				arg_571_1.allBtn_.enabled = true
			end

			local var_574_16 = 0

			if var_574_16 < arg_571_1.time_ and arg_571_1.time_ <= var_574_16 + arg_574_0 then
				arg_571_1.mask_.enabled = true
				arg_571_1.mask_.raycastTarget = true

				arg_571_1:SetGaussion(false)
			end

			local var_574_17 = 2

			if var_574_16 <= arg_571_1.time_ and arg_571_1.time_ < var_574_16 + var_574_17 then
				local var_574_18 = (arg_571_1.time_ - var_574_16) / var_574_17
				local var_574_19 = Color.New(0, 0, 0)

				var_574_19.a = Mathf.Lerp(0, 1, var_574_18)
				arg_571_1.mask_.color = var_574_19
			end

			if arg_571_1.time_ >= var_574_16 + var_574_17 and arg_571_1.time_ < var_574_16 + var_574_17 + arg_574_0 then
				local var_574_20 = Color.New(0, 0, 0)

				var_574_20.a = 1
				arg_571_1.mask_.color = var_574_20
			end

			local var_574_21 = 2

			if var_574_21 < arg_571_1.time_ and arg_571_1.time_ <= var_574_21 + arg_574_0 then
				arg_571_1.mask_.enabled = true
				arg_571_1.mask_.raycastTarget = true

				arg_571_1:SetGaussion(false)
			end

			local var_574_22 = 2

			if var_574_21 <= arg_571_1.time_ and arg_571_1.time_ < var_574_21 + var_574_22 then
				local var_574_23 = (arg_571_1.time_ - var_574_21) / var_574_22
				local var_574_24 = Color.New(0, 0, 0)

				var_574_24.a = Mathf.Lerp(1, 0, var_574_23)
				arg_571_1.mask_.color = var_574_24
			end

			if arg_571_1.time_ >= var_574_21 + var_574_22 and arg_571_1.time_ < var_574_21 + var_574_22 + arg_574_0 then
				local var_574_25 = Color.New(0, 0, 0)
				local var_574_26 = 0

				arg_571_1.mask_.enabled = false
				var_574_25.a = var_574_26
				arg_571_1.mask_.color = var_574_25
			end

			local var_574_27 = arg_571_1.actors_["1085ui_story"].transform
			local var_574_28 = 3.9

			if var_574_28 < arg_571_1.time_ and arg_571_1.time_ <= var_574_28 + arg_574_0 then
				arg_571_1.var_.moveOldPos1085ui_story = var_574_27.localPosition
			end

			local var_574_29 = 0.001

			if var_574_28 <= arg_571_1.time_ and arg_571_1.time_ < var_574_28 + var_574_29 then
				local var_574_30 = (arg_571_1.time_ - var_574_28) / var_574_29
				local var_574_31 = Vector3.New(0, -1.01, -5.83)

				var_574_27.localPosition = Vector3.Lerp(arg_571_1.var_.moveOldPos1085ui_story, var_574_31, var_574_30)

				local var_574_32 = manager.ui.mainCamera.transform.position - var_574_27.position

				var_574_27.forward = Vector3.New(var_574_32.x, var_574_32.y, var_574_32.z)

				local var_574_33 = var_574_27.localEulerAngles

				var_574_33.z = 0
				var_574_33.x = 0
				var_574_27.localEulerAngles = var_574_33
			end

			if arg_571_1.time_ >= var_574_28 + var_574_29 and arg_571_1.time_ < var_574_28 + var_574_29 + arg_574_0 then
				var_574_27.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_574_34 = manager.ui.mainCamera.transform.position - var_574_27.position

				var_574_27.forward = Vector3.New(var_574_34.x, var_574_34.y, var_574_34.z)

				local var_574_35 = var_574_27.localEulerAngles

				var_574_35.z = 0
				var_574_35.x = 0
				var_574_27.localEulerAngles = var_574_35
			end

			local var_574_36 = arg_571_1.actors_["1085ui_story"]
			local var_574_37 = 3.9

			if var_574_37 < arg_571_1.time_ and arg_571_1.time_ <= var_574_37 + arg_574_0 and not isNil(var_574_36) and arg_571_1.var_.characterEffect1085ui_story == nil then
				arg_571_1.var_.characterEffect1085ui_story = var_574_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_38 = 0.200000002980232

			if var_574_37 <= arg_571_1.time_ and arg_571_1.time_ < var_574_37 + var_574_38 and not isNil(var_574_36) then
				local var_574_39 = (arg_571_1.time_ - var_574_37) / var_574_38

				if arg_571_1.var_.characterEffect1085ui_story and not isNil(var_574_36) then
					arg_571_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= var_574_37 + var_574_38 and arg_571_1.time_ < var_574_37 + var_574_38 + arg_574_0 and not isNil(var_574_36) and arg_571_1.var_.characterEffect1085ui_story then
				arg_571_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_574_40 = 3.9

			if var_574_40 < arg_571_1.time_ and arg_571_1.time_ <= var_574_40 + arg_574_0 then
				arg_571_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_574_41 = 3.9

			if var_574_41 < arg_571_1.time_ and arg_571_1.time_ <= var_574_41 + arg_574_0 then
				arg_571_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if arg_571_1.frameCnt_ <= 1 then
				arg_571_1.dialog_:SetActive(false)
			end

			local var_574_42 = 3.999999999999
			local var_574_43 = 0.375

			if var_574_42 < arg_571_1.time_ and arg_571_1.time_ <= var_574_42 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0

				arg_571_1.dialog_:SetActive(true)

				arg_571_1.dialogCg_.alpha = 0

				local var_574_44 = LeanTween.value(arg_571_1.dialog_, 0, 1, 0.3)

				var_574_44:setOnUpdate(LuaHelper.FloatAction(function(arg_575_0)
					arg_571_1.dialogCg_.alpha = arg_575_0
				end))
				var_574_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_571_1.dialog_)
					var_574_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_571_1.duration_ = arg_571_1.duration_ + 0.3

				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_45 = arg_571_1:FormatText(StoryNameCfg[328].name)

				arg_571_1.leftNameTxt_.text = var_574_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_46 = arg_571_1:GetWordFromCfg(420051136)
				local var_574_47 = arg_571_1:FormatText(var_574_46.content)

				arg_571_1.text_.text = var_574_47

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_48 = 15
				local var_574_49 = utf8.len(var_574_47)
				local var_574_50 = var_574_48 <= 0 and var_574_43 or var_574_43 * (var_574_49 / var_574_48)

				if var_574_50 > 0 and var_574_43 < var_574_50 then
					arg_571_1.talkMaxDuration = var_574_50
					var_574_42 = var_574_42 + 0.3

					if var_574_50 + var_574_42 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_50 + var_574_42
					end
				end

				arg_571_1.text_.text = var_574_47
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420051", "420051136", "story_v_out_420051.awb") ~= 0 then
					local var_574_51 = manager.audio:GetVoiceLength("story_v_out_420051", "420051136", "story_v_out_420051.awb") / 1000

					if var_574_51 + var_574_42 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_51 + var_574_42
					end

					if var_574_46.prefab_name ~= "" and arg_571_1.actors_[var_574_46.prefab_name] ~= nil then
						local var_574_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_46.prefab_name].transform, "story_v_out_420051", "420051136", "story_v_out_420051.awb")

						arg_571_1:RecordAudio("420051136", var_574_52)
						arg_571_1:RecordAudio("420051136", var_574_52)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_420051", "420051136", "story_v_out_420051.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_420051", "420051136", "story_v_out_420051.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_53 = var_574_42 + 0.3
			local var_574_54 = math.max(var_574_43, arg_571_1.talkMaxDuration)

			if var_574_53 <= arg_571_1.time_ and arg_571_1.time_ < var_574_53 + var_574_54 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_53) / var_574_54

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_53 + var_574_54 and arg_571_1.time_ < var_574_53 + var_574_54 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_571_1:InitPlayNodeList()
	end,
	Play420051137 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 420051137
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play420051138(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = arg_577_1.actors_["1085ui_story"]
			local var_580_1 = 0

			if var_580_1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.characterEffect1085ui_story == nil then
				arg_577_1.var_.characterEffect1085ui_story = var_580_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_2 = 0.200000002980232

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_2 and not isNil(var_580_0) then
				local var_580_3 = (arg_577_1.time_ - var_580_1) / var_580_2

				if arg_577_1.var_.characterEffect1085ui_story and not isNil(var_580_0) then
					local var_580_4 = Mathf.Lerp(0, 0.5, var_580_3)

					arg_577_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_577_1.var_.characterEffect1085ui_story.fillRatio = var_580_4
				end
			end

			if arg_577_1.time_ >= var_580_1 + var_580_2 and arg_577_1.time_ < var_580_1 + var_580_2 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.characterEffect1085ui_story then
				local var_580_5 = 0.5

				arg_577_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_577_1.var_.characterEffect1085ui_story.fillRatio = var_580_5
			end

			local var_580_6 = 0
			local var_580_7 = 0.625

			if var_580_6 < arg_577_1.time_ and arg_577_1.time_ <= var_580_6 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, false)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_8 = arg_577_1:GetWordFromCfg(420051137)
				local var_580_9 = arg_577_1:FormatText(var_580_8.content)

				arg_577_1.text_.text = var_580_9

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_10 = 25
				local var_580_11 = utf8.len(var_580_9)
				local var_580_12 = var_580_10 <= 0 and var_580_7 or var_580_7 * (var_580_11 / var_580_10)

				if var_580_12 > 0 and var_580_7 < var_580_12 then
					arg_577_1.talkMaxDuration = var_580_12

					if var_580_12 + var_580_6 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_12 + var_580_6
					end
				end

				arg_577_1.text_.text = var_580_9
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_13 = math.max(var_580_7, arg_577_1.talkMaxDuration)

			if var_580_6 <= arg_577_1.time_ and arg_577_1.time_ < var_580_6 + var_580_13 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_6) / var_580_13

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_6 + var_580_13 and arg_577_1.time_ < var_580_6 + var_580_13 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play420051138 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 420051138
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play420051139(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = arg_581_1.actors_["1085ui_story"].transform
			local var_584_1 = 0

			if var_584_1 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 then
				arg_581_1.var_.moveOldPos1085ui_story = var_584_0.localPosition
			end

			local var_584_2 = 0.001

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_2 then
				local var_584_3 = (arg_581_1.time_ - var_584_1) / var_584_2
				local var_584_4 = Vector3.New(0, 100, 0)

				var_584_0.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos1085ui_story, var_584_4, var_584_3)

				local var_584_5 = manager.ui.mainCamera.transform.position - var_584_0.position

				var_584_0.forward = Vector3.New(var_584_5.x, var_584_5.y, var_584_5.z)

				local var_584_6 = var_584_0.localEulerAngles

				var_584_6.z = 0
				var_584_6.x = 0
				var_584_0.localEulerAngles = var_584_6
			end

			if arg_581_1.time_ >= var_584_1 + var_584_2 and arg_581_1.time_ < var_584_1 + var_584_2 + arg_584_0 then
				var_584_0.localPosition = Vector3.New(0, 100, 0)

				local var_584_7 = manager.ui.mainCamera.transform.position - var_584_0.position

				var_584_0.forward = Vector3.New(var_584_7.x, var_584_7.y, var_584_7.z)

				local var_584_8 = var_584_0.localEulerAngles

				var_584_8.z = 0
				var_584_8.x = 0
				var_584_0.localEulerAngles = var_584_8
			end

			local var_584_9 = 0
			local var_584_10 = 0.175

			if var_584_9 < arg_581_1.time_ and arg_581_1.time_ <= var_584_9 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				local var_584_11 = arg_581_1:FormatText(StoryNameCfg[7].name)

				arg_581_1.leftNameTxt_.text = var_584_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, true)
				arg_581_1.iconController_:SetSelectedState("hero")

				arg_581_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_581_1.callingController_:SetSelectedState("normal")

				arg_581_1.keyicon_.color = Color.New(1, 1, 1)
				arg_581_1.icon_.color = Color.New(1, 1, 1)

				local var_584_12 = arg_581_1:GetWordFromCfg(420051138)
				local var_584_13 = arg_581_1:FormatText(var_584_12.content)

				arg_581_1.text_.text = var_584_13

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_14 = 7
				local var_584_15 = utf8.len(var_584_13)
				local var_584_16 = var_584_14 <= 0 and var_584_10 or var_584_10 * (var_584_15 / var_584_14)

				if var_584_16 > 0 and var_584_10 < var_584_16 then
					arg_581_1.talkMaxDuration = var_584_16

					if var_584_16 + var_584_9 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_16 + var_584_9
					end
				end

				arg_581_1.text_.text = var_584_13
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_17 = math.max(var_584_10, arg_581_1.talkMaxDuration)

			if var_584_9 <= arg_581_1.time_ and arg_581_1.time_ < var_584_9 + var_584_17 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_9) / var_584_17

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_9 + var_584_17 and arg_581_1.time_ < var_584_9 + var_584_17 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_581_1:InitPlayNodeList()
	end,
	Play420051139 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 420051139
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play420051140(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0
			local var_588_1 = 1.45

			if var_588_0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_2 = arg_585_1:GetWordFromCfg(420051139)
				local var_588_3 = arg_585_1:FormatText(var_588_2.content)

				arg_585_1.text_.text = var_588_3

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_4 = 58
				local var_588_5 = utf8.len(var_588_3)
				local var_588_6 = var_588_4 <= 0 and var_588_1 or var_588_1 * (var_588_5 / var_588_4)

				if var_588_6 > 0 and var_588_1 < var_588_6 then
					arg_585_1.talkMaxDuration = var_588_6

					if var_588_6 + var_588_0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_6 + var_588_0
					end
				end

				arg_585_1.text_.text = var_588_3
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_7 = math.max(var_588_1, arg_585_1.talkMaxDuration)

			if var_588_0 <= arg_585_1.time_ and arg_585_1.time_ < var_588_0 + var_588_7 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_0) / var_588_7

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_0 + var_588_7 and arg_585_1.time_ < var_588_0 + var_588_7 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play420051140 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 420051140
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play420051141(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0
			local var_592_1 = 0.7

			if var_592_0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				local var_592_2 = arg_589_1:FormatText(StoryNameCfg[7].name)

				arg_589_1.leftNameTxt_.text = var_592_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, true)
				arg_589_1.iconController_:SetSelectedState("hero")

				arg_589_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_589_1.callingController_:SetSelectedState("normal")

				arg_589_1.keyicon_.color = Color.New(1, 1, 1)
				arg_589_1.icon_.color = Color.New(1, 1, 1)

				local var_592_3 = arg_589_1:GetWordFromCfg(420051140)
				local var_592_4 = arg_589_1:FormatText(var_592_3.content)

				arg_589_1.text_.text = var_592_4

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_5 = 28
				local var_592_6 = utf8.len(var_592_4)
				local var_592_7 = var_592_5 <= 0 and var_592_1 or var_592_1 * (var_592_6 / var_592_5)

				if var_592_7 > 0 and var_592_1 < var_592_7 then
					arg_589_1.talkMaxDuration = var_592_7

					if var_592_7 + var_592_0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_7 + var_592_0
					end
				end

				arg_589_1.text_.text = var_592_4
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_8 = math.max(var_592_1, arg_589_1.talkMaxDuration)

			if var_592_0 <= arg_589_1.time_ and arg_589_1.time_ < var_592_0 + var_592_8 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_0) / var_592_8

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_0 + var_592_8 and arg_589_1.time_ < var_592_0 + var_592_8 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play420051141 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 420051141
		arg_593_1.duration_ = 8

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play420051142(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 1

			if var_596_0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_0 + arg_596_0 then
				local var_596_1 = manager.ui.mainCamera.transform.localPosition
				local var_596_2 = Vector3.New(0, 0, 10) + Vector3.New(var_596_1.x, var_596_1.y, 0)
				local var_596_3 = arg_593_1.bgs_.L16f

				var_596_3.transform.localPosition = var_596_2
				var_596_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_596_4 = var_596_3:GetComponent("SpriteRenderer")

				if var_596_4 and var_596_4.sprite then
					local var_596_5 = (var_596_3.transform.localPosition - var_596_1).z
					local var_596_6 = manager.ui.mainCameraCom_
					local var_596_7 = 2 * var_596_5 * Mathf.Tan(var_596_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_596_8 = var_596_7 * var_596_6.aspect
					local var_596_9 = var_596_4.sprite.bounds.size.x
					local var_596_10 = var_596_4.sprite.bounds.size.y
					local var_596_11 = var_596_8 / var_596_9
					local var_596_12 = var_596_7 / var_596_10
					local var_596_13 = var_596_12 < var_596_11 and var_596_11 or var_596_12

					var_596_3.transform.localScale = Vector3.New(var_596_13, var_596_13, 0)
				end

				for iter_596_0, iter_596_1 in pairs(arg_593_1.bgs_) do
					if iter_596_0 ~= "L16f" then
						iter_596_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_596_14 = 3

			if var_596_14 < arg_593_1.time_ and arg_593_1.time_ <= var_596_14 + arg_596_0 then
				arg_593_1.allBtn_.enabled = false
			end

			local var_596_15 = 0.3

			if arg_593_1.time_ >= var_596_14 + var_596_15 and arg_593_1.time_ < var_596_14 + var_596_15 + arg_596_0 then
				arg_593_1.allBtn_.enabled = true
			end

			local var_596_16 = 0

			if var_596_16 < arg_593_1.time_ and arg_593_1.time_ <= var_596_16 + arg_596_0 then
				arg_593_1.mask_.enabled = true
				arg_593_1.mask_.raycastTarget = true

				arg_593_1:SetGaussion(false)
			end

			local var_596_17 = 1

			if var_596_16 <= arg_593_1.time_ and arg_593_1.time_ < var_596_16 + var_596_17 then
				local var_596_18 = (arg_593_1.time_ - var_596_16) / var_596_17
				local var_596_19 = Color.New(0, 0, 0)

				var_596_19.a = Mathf.Lerp(0, 1, var_596_18)
				arg_593_1.mask_.color = var_596_19
			end

			if arg_593_1.time_ >= var_596_16 + var_596_17 and arg_593_1.time_ < var_596_16 + var_596_17 + arg_596_0 then
				local var_596_20 = Color.New(0, 0, 0)

				var_596_20.a = 1
				arg_593_1.mask_.color = var_596_20
			end

			local var_596_21 = 1

			if var_596_21 < arg_593_1.time_ and arg_593_1.time_ <= var_596_21 + arg_596_0 then
				arg_593_1.mask_.enabled = true
				arg_593_1.mask_.raycastTarget = true

				arg_593_1:SetGaussion(false)
			end

			local var_596_22 = 2

			if var_596_21 <= arg_593_1.time_ and arg_593_1.time_ < var_596_21 + var_596_22 then
				local var_596_23 = (arg_593_1.time_ - var_596_21) / var_596_22
				local var_596_24 = Color.New(0, 0, 0)

				var_596_24.a = Mathf.Lerp(1, 0, var_596_23)
				arg_593_1.mask_.color = var_596_24
			end

			if arg_593_1.time_ >= var_596_21 + var_596_22 and arg_593_1.time_ < var_596_21 + var_596_22 + arg_596_0 then
				local var_596_25 = Color.New(0, 0, 0)
				local var_596_26 = 0

				arg_593_1.mask_.enabled = false
				var_596_25.a = var_596_26
				arg_593_1.mask_.color = var_596_25
			end

			if arg_593_1.frameCnt_ <= 1 then
				arg_593_1.dialog_:SetActive(false)
			end

			local var_596_27 = 3
			local var_596_28 = 0.55

			if var_596_27 < arg_593_1.time_ and arg_593_1.time_ <= var_596_27 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0

				arg_593_1.dialog_:SetActive(true)

				arg_593_1.dialogCg_.alpha = 0

				local var_596_29 = LeanTween.value(arg_593_1.dialog_, 0, 1, 0.3)

				var_596_29:setOnUpdate(LuaHelper.FloatAction(function(arg_597_0)
					arg_593_1.dialogCg_.alpha = arg_597_0
				end))
				var_596_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_593_1.dialog_)
					var_596_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_593_1.duration_ = arg_593_1.duration_ + 0.3

				SetActive(arg_593_1.leftNameGo_, false)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_30 = arg_593_1:GetWordFromCfg(420051141)
				local var_596_31 = arg_593_1:FormatText(var_596_30.content)

				arg_593_1.text_.text = var_596_31

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_32 = 22
				local var_596_33 = utf8.len(var_596_31)
				local var_596_34 = var_596_32 <= 0 and var_596_28 or var_596_28 * (var_596_33 / var_596_32)

				if var_596_34 > 0 and var_596_28 < var_596_34 then
					arg_593_1.talkMaxDuration = var_596_34
					var_596_27 = var_596_27 + 0.3

					if var_596_34 + var_596_27 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_34 + var_596_27
					end
				end

				arg_593_1.text_.text = var_596_31
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_35 = var_596_27 + 0.3
			local var_596_36 = math.max(var_596_28, arg_593_1.talkMaxDuration)

			if var_596_35 <= arg_593_1.time_ and arg_593_1.time_ < var_596_35 + var_596_36 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_35) / var_596_36

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_35 + var_596_36 and arg_593_1.time_ < var_596_35 + var_596_36 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play420051142 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 420051142
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play420051143(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0
			local var_602_1 = 0.55

			if var_602_0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, false)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_2 = arg_599_1:GetWordFromCfg(420051142)
				local var_602_3 = arg_599_1:FormatText(var_602_2.content)

				arg_599_1.text_.text = var_602_3

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_4 = 22
				local var_602_5 = utf8.len(var_602_3)
				local var_602_6 = var_602_4 <= 0 and var_602_1 or var_602_1 * (var_602_5 / var_602_4)

				if var_602_6 > 0 and var_602_1 < var_602_6 then
					arg_599_1.talkMaxDuration = var_602_6

					if var_602_6 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_6 + var_602_0
					end
				end

				arg_599_1.text_.text = var_602_3
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_7 = math.max(var_602_1, arg_599_1.talkMaxDuration)

			if var_602_0 <= arg_599_1.time_ and arg_599_1.time_ < var_602_0 + var_602_7 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_0) / var_602_7

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_0 + var_602_7 and arg_599_1.time_ < var_602_0 + var_602_7 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play420051143 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 420051143
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play420051144(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 0
			local var_606_1 = 0.45

			if var_606_0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_0 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, false)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_2 = arg_603_1:GetWordFromCfg(420051143)
				local var_606_3 = arg_603_1:FormatText(var_606_2.content)

				arg_603_1.text_.text = var_606_3

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_4 = 18
				local var_606_5 = utf8.len(var_606_3)
				local var_606_6 = var_606_4 <= 0 and var_606_1 or var_606_1 * (var_606_5 / var_606_4)

				if var_606_6 > 0 and var_606_1 < var_606_6 then
					arg_603_1.talkMaxDuration = var_606_6

					if var_606_6 + var_606_0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_6 + var_606_0
					end
				end

				arg_603_1.text_.text = var_606_3
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_7 = math.max(var_606_1, arg_603_1.talkMaxDuration)

			if var_606_0 <= arg_603_1.time_ and arg_603_1.time_ < var_606_0 + var_606_7 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_0) / var_606_7

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_0 + var_606_7 and arg_603_1.time_ < var_606_0 + var_606_7 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play420051144 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 420051144
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
			arg_607_1.auto_ = false
		end

		function arg_607_1.playNext_(arg_609_0)
			arg_607_1.onStoryFinished_()
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0
			local var_610_1 = 0.125

			if var_610_0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, false)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_2 = arg_607_1:GetWordFromCfg(420051144)
				local var_610_3 = arg_607_1:FormatText(var_610_2.content)

				arg_607_1.text_.text = var_610_3

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_4 = 5
				local var_610_5 = utf8.len(var_610_3)
				local var_610_6 = var_610_4 <= 0 and var_610_1 or var_610_1 * (var_610_5 / var_610_4)

				if var_610_6 > 0 and var_610_1 < var_610_6 then
					arg_607_1.talkMaxDuration = var_610_6

					if var_610_6 + var_610_0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_6 + var_610_0
					end
				end

				arg_607_1.text_.text = var_610_3
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_7 = math.max(var_610_1, arg_607_1.talkMaxDuration)

			if var_610_0 <= arg_607_1.time_ and arg_607_1.time_ < var_610_0 + var_610_7 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_0) / var_610_7

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_0 + var_610_7 and arg_607_1.time_ < var_610_0 + var_610_7 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0505",
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/ST0503",
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L16f",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/ST67",
		"TextureConfig/Background/ST0504a"
	},
	voices = {
		"story_v_out_420051.awb"
	}
}
