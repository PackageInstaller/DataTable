return {
	Play322012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322012001
		arg_1_1.duration_ = 4.9

		local var_1_0 = {
			zh = 3.8,
			ja = 4.9
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
				arg_1_0:Play322012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST73a"

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
				local var_4_5 = arg_1_1.bgs_.ST73a

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
					if iter_4_0 ~= "ST73a" then
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

			local var_4_24 = "1061ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1061ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1061ui_story = var_4_29.localPosition

				local var_4_31 = "1061ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_31 .. "Animator"].transform, false)
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, -1.18, -6.15)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1061ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_29.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_29.localEulerAngles = var_4_38
			end

			local var_4_39 = arg_1_1.actors_["1061ui_story"]
			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1061ui_story == nil then
				arg_1_1.var_.characterEffect1061ui_story = var_4_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_41 = 0.200000002980232

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 and not isNil(var_4_39) then
				local var_4_42 = (arg_1_1.time_ - var_4_40) / var_4_41

				if arg_1_1.var_.characterEffect1061ui_story and not isNil(var_4_39) then
					arg_1_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1061ui_story then
				arg_1_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_4_45 = 0
			local var_4_46 = 0.3

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "music"

				arg_1_1:AudioAction(var_4_47, var_4_48, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_49 = ""
				local var_4_50 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_50 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_50 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_50

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_50
						arg_1_1.bgmTxt2_.text = var_4_50
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

			local var_4_51 = 0.500666666666667
			local var_4_52 = 1

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				local var_4_53 = "play"
				local var_4_54 = "music"

				arg_1_1:AudioAction(var_4_53, var_4_54, "bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference.awb")

				local var_4_55 = ""
				local var_4_56 = manager.audio:GetAudioName("bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference")

				if var_4_56 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_56 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_56

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_56
						arg_1_1.bgmTxt2_.text = var_4_56
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

			local var_4_57 = 0.166666666666667
			local var_4_58 = 1

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				local var_4_59 = "play"
				local var_4_60 = "effect"

				arg_1_1:AudioAction(var_4_59, var_4_60, "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_61 = 2
			local var_4_62 = 0.175

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_63 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_63:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[612].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(322012001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 7
				local var_4_68 = utf8.len(var_4_66)
				local var_4_69 = var_4_67 <= 0 and var_4_62 or var_4_62 * (var_4_68 / var_4_67)

				if var_4_69 > 0 and var_4_62 < var_4_69 then
					arg_1_1.talkMaxDuration = var_4_69
					var_4_61 = var_4_61 + 0.3

					if var_4_69 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_61
					end
				end

				arg_1_1.text_.text = var_4_66
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012001", "story_v_out_322012.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_322012", "322012001", "story_v_out_322012.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_322012", "322012001", "story_v_out_322012.awb")

						arg_1_1:RecordAudio("322012001", var_4_71)
						arg_1_1:RecordAudio("322012001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322012", "322012001", "story_v_out_322012.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322012", "322012001", "story_v_out_322012.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_72 = var_4_61 + 0.3
			local var_4_73 = math.max(var_4_62, arg_1_1.talkMaxDuration)

			if var_4_72 <= arg_1_1.time_ and arg_1_1.time_ < var_4_72 + var_4_73 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_72) / var_4_73

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_72 + var_4_73 and arg_1_1.time_ < var_4_72 + var_4_73 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play322012002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322012002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322012003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1061ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1061ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(0, 100, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1061ui_story, var_12_4, var_12_3)

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
			local var_12_10 = 1.225

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

				local var_12_11 = arg_9_1:GetWordFromCfg(322012002)
				local var_12_12 = arg_9_1:FormatText(var_12_11.content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 49
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
				actorName = "1061ui_story",
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
	Play322012003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322012003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play322012004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.2

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

				local var_16_2 = arg_13_1:GetWordFromCfg(322012003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 48
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
	Play322012004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322012004
		arg_17_1.duration_ = 7.4

		local var_17_0 = {
			zh = 2.8,
			ja = 7.4
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
				arg_17_0:Play322012005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1061ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1061ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, -1.18, -6.15)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1061ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1061ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1061ui_story == nil then
				arg_17_1.var_.characterEffect1061ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1061ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1061ui_story then
				arg_17_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_20_13 = 0
			local var_20_14 = 0.35

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_15 = arg_17_1:FormatText(StoryNameCfg[612].name)

				arg_17_1.leftNameTxt_.text = var_20_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_16 = arg_17_1:GetWordFromCfg(322012004)
				local var_20_17 = arg_17_1:FormatText(var_20_16.content)

				arg_17_1.text_.text = var_20_17

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_18 = 14
				local var_20_19 = utf8.len(var_20_17)
				local var_20_20 = var_20_18 <= 0 and var_20_14 or var_20_14 * (var_20_19 / var_20_18)

				if var_20_20 > 0 and var_20_14 < var_20_20 then
					arg_17_1.talkMaxDuration = var_20_20

					if var_20_20 + var_20_13 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_20 + var_20_13
					end
				end

				arg_17_1.text_.text = var_20_17
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012004", "story_v_out_322012.awb") ~= 0 then
					local var_20_21 = manager.audio:GetVoiceLength("story_v_out_322012", "322012004", "story_v_out_322012.awb") / 1000

					if var_20_21 + var_20_13 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_21 + var_20_13
					end

					if var_20_16.prefab_name ~= "" and arg_17_1.actors_[var_20_16.prefab_name] ~= nil then
						local var_20_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_16.prefab_name].transform, "story_v_out_322012", "322012004", "story_v_out_322012.awb")

						arg_17_1:RecordAudio("322012004", var_20_22)
						arg_17_1:RecordAudio("322012004", var_20_22)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_322012", "322012004", "story_v_out_322012.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_322012", "322012004", "story_v_out_322012.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_23 = math.max(var_20_14, arg_17_1.talkMaxDuration)

			if var_20_13 <= arg_17_1.time_ and arg_17_1.time_ < var_20_13 + var_20_23 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_13) / var_20_23

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_13 + var_20_23 and arg_17_1.time_ < var_20_13 + var_20_23 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play322012005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322012005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play322012006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1061ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1061ui_story == nil then
				arg_21_1.var_.characterEffect1061ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1061ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1061ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1061ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1061ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.25

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_8

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

				local var_24_9 = arg_21_1:GetWordFromCfg(322012005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 10
				local var_24_12 = utf8.len(var_24_10)
				local var_24_13 = var_24_11 <= 0 and var_24_7 or var_24_7 * (var_24_12 / var_24_11)

				if var_24_13 > 0 and var_24_7 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play322012006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322012006
		arg_25_1.duration_ = 7.63

		local var_25_0 = {
			zh = 5,
			ja = 7.633
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
				arg_25_0:Play322012007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1061ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1061ui_story == nil then
				arg_25_1.var_.characterEffect1061ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1061ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1061ui_story then
				arg_25_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_6 = 0
			local var_28_7 = 0.55

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[612].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(322012006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012006", "story_v_out_322012.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_322012", "322012006", "story_v_out_322012.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_out_322012", "322012006", "story_v_out_322012.awb")

						arg_25_1:RecordAudio("322012006", var_28_15)
						arg_25_1:RecordAudio("322012006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322012", "322012006", "story_v_out_322012.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322012", "322012006", "story_v_out_322012.awb")
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
	Play322012007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322012007
		arg_29_1.duration_ = 16.9

		local var_29_0 = {
			zh = 12.6,
			ja = 16.9
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play322012008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "10104ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_29_1.stage_.transform)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

					var_32_3.enabled = true

					local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

					if var_32_4 then
						var_32_4:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_3.transform, false)

					arg_29_1.var_[var_32_0 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_5 = arg_29_1.actors_["10104ui_story"].transform
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.var_.moveOldPos10104ui_story = var_32_5.localPosition
			end

			local var_32_7 = 0.001

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7
				local var_32_9 = Vector3.New(0.99, -1.12, -5.99)

				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10104ui_story, var_32_9, var_32_8)

				local var_32_10 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_10.x, var_32_10.y, var_32_10.z)

				local var_32_11 = var_32_5.localEulerAngles

				var_32_11.z = 0
				var_32_11.x = 0
				var_32_5.localEulerAngles = var_32_11
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_32_12 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_12.x, var_32_12.y, var_32_12.z)

				local var_32_13 = var_32_5.localEulerAngles

				var_32_13.z = 0
				var_32_13.x = 0
				var_32_5.localEulerAngles = var_32_13
			end

			local var_32_14 = arg_29_1.actors_["1061ui_story"].transform
			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.var_.moveOldPos1061ui_story = var_32_14.localPosition
			end

			local var_32_16 = 0.001

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 then
				local var_32_17 = (arg_29_1.time_ - var_32_15) / var_32_16
				local var_32_18 = Vector3.New(-0.7, -1.18, -6.15)

				var_32_14.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1061ui_story, var_32_18, var_32_17)

				local var_32_19 = manager.ui.mainCamera.transform.position - var_32_14.position

				var_32_14.forward = Vector3.New(var_32_19.x, var_32_19.y, var_32_19.z)

				local var_32_20 = var_32_14.localEulerAngles

				var_32_20.z = 0
				var_32_20.x = 0
				var_32_14.localEulerAngles = var_32_20
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 then
				var_32_14.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_32_21 = manager.ui.mainCamera.transform.position - var_32_14.position

				var_32_14.forward = Vector3.New(var_32_21.x, var_32_21.y, var_32_21.z)

				local var_32_22 = var_32_14.localEulerAngles

				var_32_22.z = 0
				var_32_22.x = 0
				var_32_14.localEulerAngles = var_32_22
			end

			local var_32_23 = arg_29_1.actors_["10104ui_story"]
			local var_32_24 = 0

			if var_32_24 < arg_29_1.time_ and arg_29_1.time_ <= var_32_24 + arg_32_0 and not isNil(var_32_23) and arg_29_1.var_.characterEffect10104ui_story == nil then
				arg_29_1.var_.characterEffect10104ui_story = var_32_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_25 = 0.200000002980232

			if var_32_24 <= arg_29_1.time_ and arg_29_1.time_ < var_32_24 + var_32_25 and not isNil(var_32_23) then
				local var_32_26 = (arg_29_1.time_ - var_32_24) / var_32_25

				if arg_29_1.var_.characterEffect10104ui_story and not isNil(var_32_23) then
					arg_29_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_24 + var_32_25 and arg_29_1.time_ < var_32_24 + var_32_25 + arg_32_0 and not isNil(var_32_23) and arg_29_1.var_.characterEffect10104ui_story then
				arg_29_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_32_27 = arg_29_1.actors_["1061ui_story"]
			local var_32_28 = 0

			if var_32_28 < arg_29_1.time_ and arg_29_1.time_ <= var_32_28 + arg_32_0 and not isNil(var_32_27) and arg_29_1.var_.characterEffect1061ui_story == nil then
				arg_29_1.var_.characterEffect1061ui_story = var_32_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_29 = 0.200000002980232

			if var_32_28 <= arg_29_1.time_ and arg_29_1.time_ < var_32_28 + var_32_29 and not isNil(var_32_27) then
				local var_32_30 = (arg_29_1.time_ - var_32_28) / var_32_29

				if arg_29_1.var_.characterEffect1061ui_story and not isNil(var_32_27) then
					local var_32_31 = Mathf.Lerp(0, 0.5, var_32_30)

					arg_29_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1061ui_story.fillRatio = var_32_31
				end
			end

			if arg_29_1.time_ >= var_32_28 + var_32_29 and arg_29_1.time_ < var_32_28 + var_32_29 + arg_32_0 and not isNil(var_32_27) and arg_29_1.var_.characterEffect1061ui_story then
				local var_32_32 = 0.5

				arg_29_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1061ui_story.fillRatio = var_32_32
			end

			local var_32_33 = 0

			if var_32_33 < arg_29_1.time_ and arg_29_1.time_ <= var_32_33 + arg_32_0 then
				arg_29_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_32_34 = 0

			if var_32_34 < arg_29_1.time_ and arg_29_1.time_ <= var_32_34 + arg_32_0 then
				arg_29_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_35 = 0
			local var_32_36 = 1.55

			if var_32_35 < arg_29_1.time_ and arg_29_1.time_ <= var_32_35 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_37 = arg_29_1:FormatText(StoryNameCfg[1030].name)

				arg_29_1.leftNameTxt_.text = var_32_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_38 = arg_29_1:GetWordFromCfg(322012007)
				local var_32_39 = arg_29_1:FormatText(var_32_38.content)

				arg_29_1.text_.text = var_32_39

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_40 = 62
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

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012007", "story_v_out_322012.awb") ~= 0 then
					local var_32_43 = manager.audio:GetVoiceLength("story_v_out_322012", "322012007", "story_v_out_322012.awb") / 1000

					if var_32_43 + var_32_35 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_43 + var_32_35
					end

					if var_32_38.prefab_name ~= "" and arg_29_1.actors_[var_32_38.prefab_name] ~= nil then
						local var_32_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_38.prefab_name].transform, "story_v_out_322012", "322012007", "story_v_out_322012.awb")

						arg_29_1:RecordAudio("322012007", var_32_44)
						arg_29_1:RecordAudio("322012007", var_32_44)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322012", "322012007", "story_v_out_322012.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322012", "322012007", "story_v_out_322012.awb")
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
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_29_1:InitPlayNodeList()
	end,
	Play322012008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322012008
		arg_33_1.duration_ = 20.47

		local var_33_0 = {
			zh = 10.566,
			ja = 20.466
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
				arg_33_0:Play322012009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_2 = 0
			local var_36_3 = 1.4

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_4 = arg_33_1:FormatText(StoryNameCfg[1030].name)

				arg_33_1.leftNameTxt_.text = var_36_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:GetWordFromCfg(322012008)
				local var_36_6 = arg_33_1:FormatText(var_36_5.content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 56
				local var_36_8 = utf8.len(var_36_6)
				local var_36_9 = var_36_7 <= 0 and var_36_3 or var_36_3 * (var_36_8 / var_36_7)

				if var_36_9 > 0 and var_36_3 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012008", "story_v_out_322012.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012008", "story_v_out_322012.awb") / 1000

					if var_36_10 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_2
					end

					if var_36_5.prefab_name ~= "" and arg_33_1.actors_[var_36_5.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_5.prefab_name].transform, "story_v_out_322012", "322012008", "story_v_out_322012.awb")

						arg_33_1:RecordAudio("322012008", var_36_11)
						arg_33_1:RecordAudio("322012008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_322012", "322012008", "story_v_out_322012.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_322012", "322012008", "story_v_out_322012.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_12 and arg_33_1.time_ < var_36_2 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322012009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322012009
		arg_37_1.duration_ = 5.33

		local var_37_0 = {
			zh = 3.8,
			ja = 5.333
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
				arg_37_0:Play322012010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1061ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1061ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, -1.18, -6.15)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1061ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1061ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1061ui_story == nil then
				arg_37_1.var_.characterEffect1061ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1061ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1061ui_story then
				arg_37_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_40_15 = arg_37_1.actors_["10104ui_story"].transform
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.var_.moveOldPos10104ui_story = var_40_15.localPosition
			end

			local var_40_17 = 0.001

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17
				local var_40_19 = Vector3.New(0, 100, 0)

				var_40_15.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10104ui_story, var_40_19, var_40_18)

				local var_40_20 = manager.ui.mainCamera.transform.position - var_40_15.position

				var_40_15.forward = Vector3.New(var_40_20.x, var_40_20.y, var_40_20.z)

				local var_40_21 = var_40_15.localEulerAngles

				var_40_21.z = 0
				var_40_21.x = 0
				var_40_15.localEulerAngles = var_40_21
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 then
				var_40_15.localPosition = Vector3.New(0, 100, 0)

				local var_40_22 = manager.ui.mainCamera.transform.position - var_40_15.position

				var_40_15.forward = Vector3.New(var_40_22.x, var_40_22.y, var_40_22.z)

				local var_40_23 = var_40_15.localEulerAngles

				var_40_23.z = 0
				var_40_23.x = 0
				var_40_15.localEulerAngles = var_40_23
			end

			local var_40_24 = 0
			local var_40_25 = 0.525

			if var_40_24 < arg_37_1.time_ and arg_37_1.time_ <= var_40_24 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_26 = arg_37_1:FormatText(StoryNameCfg[612].name)

				arg_37_1.leftNameTxt_.text = var_40_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_27 = arg_37_1:GetWordFromCfg(322012009)
				local var_40_28 = arg_37_1:FormatText(var_40_27.content)

				arg_37_1.text_.text = var_40_28

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_29 = 21
				local var_40_30 = utf8.len(var_40_28)
				local var_40_31 = var_40_29 <= 0 and var_40_25 or var_40_25 * (var_40_30 / var_40_29)

				if var_40_31 > 0 and var_40_25 < var_40_31 then
					arg_37_1.talkMaxDuration = var_40_31

					if var_40_31 + var_40_24 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_31 + var_40_24
					end
				end

				arg_37_1.text_.text = var_40_28
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012009", "story_v_out_322012.awb") ~= 0 then
					local var_40_32 = manager.audio:GetVoiceLength("story_v_out_322012", "322012009", "story_v_out_322012.awb") / 1000

					if var_40_32 + var_40_24 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_32 + var_40_24
					end

					if var_40_27.prefab_name ~= "" and arg_37_1.actors_[var_40_27.prefab_name] ~= nil then
						local var_40_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_27.prefab_name].transform, "story_v_out_322012", "322012009", "story_v_out_322012.awb")

						arg_37_1:RecordAudio("322012009", var_40_33)
						arg_37_1:RecordAudio("322012009", var_40_33)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322012", "322012009", "story_v_out_322012.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322012", "322012009", "story_v_out_322012.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_34 = math.max(var_40_25, arg_37_1.talkMaxDuration)

			if var_40_24 <= arg_37_1.time_ and arg_37_1.time_ < var_40_24 + var_40_34 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_24) / var_40_34

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_24 + var_40_34 and arg_37_1.time_ < var_40_24 + var_40_34 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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
				actorName = "10104ui_story",
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
	Play322012010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322012010
		arg_41_1.duration_ = 11.27

		local var_41_0 = {
			zh = 8.8,
			ja = 11.266
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
				arg_41_0:Play322012011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_44_2 = 0
			local var_44_3 = 0.775

			if var_44_2 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_4 = arg_41_1:FormatText(StoryNameCfg[612].name)

				arg_41_1.leftNameTxt_.text = var_44_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_5 = arg_41_1:GetWordFromCfg(322012010)
				local var_44_6 = arg_41_1:FormatText(var_44_5.content)

				arg_41_1.text_.text = var_44_6

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 31
				local var_44_8 = utf8.len(var_44_6)
				local var_44_9 = var_44_7 <= 0 and var_44_3 or var_44_3 * (var_44_8 / var_44_7)

				if var_44_9 > 0 and var_44_3 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_6
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012010", "story_v_out_322012.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012010", "story_v_out_322012.awb") / 1000

					if var_44_10 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_2
					end

					if var_44_5.prefab_name ~= "" and arg_41_1.actors_[var_44_5.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_5.prefab_name].transform, "story_v_out_322012", "322012010", "story_v_out_322012.awb")

						arg_41_1:RecordAudio("322012010", var_44_11)
						arg_41_1:RecordAudio("322012010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322012", "322012010", "story_v_out_322012.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322012", "322012010", "story_v_out_322012.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_12 and arg_41_1.time_ < var_44_2 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play322012011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322012011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322012012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1061ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1061ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1061ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, 100, 0)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["10104ui_story"].transform
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.var_.moveOldPos10104ui_story = var_48_9.localPosition
			end

			local var_48_11 = 0.001

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11
				local var_48_13 = Vector3.New(0, 100, 0)

				var_48_9.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10104ui_story, var_48_13, var_48_12)

				local var_48_14 = manager.ui.mainCamera.transform.position - var_48_9.position

				var_48_9.forward = Vector3.New(var_48_14.x, var_48_14.y, var_48_14.z)

				local var_48_15 = var_48_9.localEulerAngles

				var_48_15.z = 0
				var_48_15.x = 0
				var_48_9.localEulerAngles = var_48_15
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 then
				var_48_9.localPosition = Vector3.New(0, 100, 0)

				local var_48_16 = manager.ui.mainCamera.transform.position - var_48_9.position

				var_48_9.forward = Vector3.New(var_48_16.x, var_48_16.y, var_48_16.z)

				local var_48_17 = var_48_9.localEulerAngles

				var_48_17.z = 0
				var_48_17.x = 0
				var_48_9.localEulerAngles = var_48_17
			end

			local var_48_18 = 0
			local var_48_19 = 1.175

			if var_48_18 < arg_45_1.time_ and arg_45_1.time_ <= var_48_18 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_20 = arg_45_1:GetWordFromCfg(322012011)
				local var_48_21 = arg_45_1:FormatText(var_48_20.content)

				arg_45_1.text_.text = var_48_21

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_22 = 47
				local var_48_23 = utf8.len(var_48_21)
				local var_48_24 = var_48_22 <= 0 and var_48_19 or var_48_19 * (var_48_23 / var_48_22)

				if var_48_24 > 0 and var_48_19 < var_48_24 then
					arg_45_1.talkMaxDuration = var_48_24

					if var_48_24 + var_48_18 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_24 + var_48_18
					end
				end

				arg_45_1.text_.text = var_48_21
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_19, arg_45_1.talkMaxDuration)

			if var_48_18 <= arg_45_1.time_ and arg_45_1.time_ < var_48_18 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_18) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_18 + var_48_25 and arg_45_1.time_ < var_48_18 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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
				actorName = "10104ui_story",
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
	Play322012012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322012012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play322012013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1.725

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(322012012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 69
				local var_52_5 = utf8.len(var_52_3)
				local var_52_6 = var_52_4 <= 0 and var_52_1 or var_52_1 * (var_52_5 / var_52_4)

				if var_52_6 > 0 and var_52_1 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_7 and arg_49_1.time_ < var_52_0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play322012013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322012013
		arg_53_1.duration_ = 14.2

		local var_53_0 = {
			zh = 12.032999999999,
			ja = 14.199999999999
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
				arg_53_0:Play322012014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "L14f"

			if arg_53_1.bgs_[var_56_0] == nil then
				local var_56_1 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_56_0)
				var_56_1.name = var_56_0
				var_56_1.transform.parent = arg_53_1.stage_.transform
				var_56_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_[var_56_0] = var_56_1
			end

			local var_56_2 = 2

			if var_56_2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				local var_56_3 = manager.ui.mainCamera.transform.localPosition
				local var_56_4 = Vector3.New(0, 0, 10) + Vector3.New(var_56_3.x, var_56_3.y, 0)
				local var_56_5 = arg_53_1.bgs_.L14f

				var_56_5.transform.localPosition = var_56_4
				var_56_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_6 = var_56_5:GetComponent("SpriteRenderer")

				if var_56_6 and var_56_6.sprite then
					local var_56_7 = (var_56_5.transform.localPosition - var_56_3).z
					local var_56_8 = manager.ui.mainCameraCom_
					local var_56_9 = 2 * var_56_7 * Mathf.Tan(var_56_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_56_10 = var_56_9 * var_56_8.aspect
					local var_56_11 = var_56_6.sprite.bounds.size.x
					local var_56_12 = var_56_6.sprite.bounds.size.y
					local var_56_13 = var_56_10 / var_56_11
					local var_56_14 = var_56_9 / var_56_12
					local var_56_15 = var_56_14 < var_56_13 and var_56_13 or var_56_14

					var_56_5.transform.localScale = Vector3.New(var_56_15, var_56_15, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "L14f" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_16 = 3.999999999999

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			local var_56_17 = 0.3

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_18 = 0

			if var_56_18 < arg_53_1.time_ and arg_53_1.time_ <= var_56_18 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_19 = 2

			if var_56_18 <= arg_53_1.time_ and arg_53_1.time_ < var_56_18 + var_56_19 then
				local var_56_20 = (arg_53_1.time_ - var_56_18) / var_56_19
				local var_56_21 = Color.New(0, 0, 0)

				var_56_21.a = Mathf.Lerp(0, 1, var_56_20)
				arg_53_1.mask_.color = var_56_21
			end

			if arg_53_1.time_ >= var_56_18 + var_56_19 and arg_53_1.time_ < var_56_18 + var_56_19 + arg_56_0 then
				local var_56_22 = Color.New(0, 0, 0)

				var_56_22.a = 1
				arg_53_1.mask_.color = var_56_22
			end

			local var_56_23 = 2

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_24 = 2

			if var_56_23 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_24 then
				local var_56_25 = (arg_53_1.time_ - var_56_23) / var_56_24
				local var_56_26 = Color.New(0, 0, 0)

				var_56_26.a = Mathf.Lerp(1, 0, var_56_25)
				arg_53_1.mask_.color = var_56_26
			end

			if arg_53_1.time_ >= var_56_23 + var_56_24 and arg_53_1.time_ < var_56_23 + var_56_24 + arg_56_0 then
				local var_56_27 = Color.New(0, 0, 0)
				local var_56_28 = 0

				arg_53_1.mask_.enabled = false
				var_56_27.a = var_56_28
				arg_53_1.mask_.color = var_56_27
			end

			local var_56_29 = 0
			local var_56_30 = 0.3

			if var_56_29 < arg_53_1.time_ and arg_53_1.time_ <= var_56_29 + arg_56_0 then
				local var_56_31 = "play"
				local var_56_32 = "music"

				arg_53_1:AudioAction(var_56_31, var_56_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_56_33 = ""
				local var_56_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_56_34 ~= "" then
					if arg_53_1.bgmTxt_.text ~= var_56_34 and arg_53_1.bgmTxt_.text ~= "" then
						if arg_53_1.bgmTxt2_.text ~= "" then
							arg_53_1.bgmTxt_.text = arg_53_1.bgmTxt2_.text
						end

						arg_53_1.bgmTxt2_.text = var_56_34

						arg_53_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_53_1.bgmTxt_.text = var_56_34
						arg_53_1.bgmTxt2_.text = var_56_34
					end

					if arg_53_1.bgmTimer then
						arg_53_1.bgmTimer:Stop()

						arg_53_1.bgmTimer = nil
					end

					if arg_53_1.settingData.show_music_name == 1 then
						arg_53_1.musicController:SetSelectedState("show")
						arg_53_1.musicAnimator_:Play("open", 0, 0)

						if arg_53_1.settingData.music_time ~= 0 then
							arg_53_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_53_1.settingData.music_time), function()
								if arg_53_1 == nil or isNil(arg_53_1.bgmTxt_) then
									return
								end

								arg_53_1.musicController:SetSelectedState("hide")
								arg_53_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_56_35 = 0.4
			local var_56_36 = 1

			if var_56_35 < arg_53_1.time_ and arg_53_1.time_ <= var_56_35 + arg_56_0 then
				local var_56_37 = "play"
				local var_56_38 = "music"

				arg_53_1:AudioAction(var_56_37, var_56_38, "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_56_39 = ""
				local var_56_40 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

				if var_56_40 ~= "" then
					if arg_53_1.bgmTxt_.text ~= var_56_40 and arg_53_1.bgmTxt_.text ~= "" then
						if arg_53_1.bgmTxt2_.text ~= "" then
							arg_53_1.bgmTxt_.text = arg_53_1.bgmTxt2_.text
						end

						arg_53_1.bgmTxt2_.text = var_56_40

						arg_53_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_53_1.bgmTxt_.text = var_56_40
						arg_53_1.bgmTxt2_.text = var_56_40
					end

					if arg_53_1.bgmTimer then
						arg_53_1.bgmTimer:Stop()

						arg_53_1.bgmTimer = nil
					end

					if arg_53_1.settingData.show_music_name == 1 then
						arg_53_1.musicController:SetSelectedState("show")
						arg_53_1.musicAnimator_:Play("open", 0, 0)

						if arg_53_1.settingData.music_time ~= 0 then
							arg_53_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_53_1.settingData.music_time), function()
								if arg_53_1 == nil or isNil(arg_53_1.bgmTxt_) then
									return
								end

								arg_53_1.musicController:SetSelectedState("hide")
								arg_53_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_56_41 = 0.1
			local var_56_42 = 1

			if var_56_41 < arg_53_1.time_ and arg_53_1.time_ <= var_56_41 + arg_56_0 then
				local var_56_43 = "stop"
				local var_56_44 = "effect"

				arg_53_1:AudioAction(var_56_43, var_56_44, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_56_45 = 1.56666666666667
			local var_56_46 = 1

			if var_56_45 < arg_53_1.time_ and arg_53_1.time_ <= var_56_45 + arg_56_0 then
				local var_56_47 = "play"
				local var_56_48 = "effect"

				arg_53_1:AudioAction(var_56_47, var_56_48, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_49 = 3.999999999999
			local var_56_50 = 0.95

			if var_56_49 < arg_53_1.time_ and arg_53_1.time_ <= var_56_49 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_51 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_51:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_53_1.dialogCg_.alpha = arg_59_0
				end))
				var_56_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_52 = arg_53_1:FormatText(StoryNameCfg[1167].name)

				arg_53_1.leftNameTxt_.text = var_56_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_53 = arg_53_1:GetWordFromCfg(322012013)
				local var_56_54 = arg_53_1:FormatText(var_56_53.content)

				arg_53_1.text_.text = var_56_54

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_55 = 38
				local var_56_56 = utf8.len(var_56_54)
				local var_56_57 = var_56_55 <= 0 and var_56_50 or var_56_50 * (var_56_56 / var_56_55)

				if var_56_57 > 0 and var_56_50 < var_56_57 then
					arg_53_1.talkMaxDuration = var_56_57
					var_56_49 = var_56_49 + 0.3

					if var_56_57 + var_56_49 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_57 + var_56_49
					end
				end

				arg_53_1.text_.text = var_56_54
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012013", "story_v_out_322012.awb") ~= 0 then
					local var_56_58 = manager.audio:GetVoiceLength("story_v_out_322012", "322012013", "story_v_out_322012.awb") / 1000

					if var_56_58 + var_56_49 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_58 + var_56_49
					end

					if var_56_53.prefab_name ~= "" and arg_53_1.actors_[var_56_53.prefab_name] ~= nil then
						local var_56_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_53.prefab_name].transform, "story_v_out_322012", "322012013", "story_v_out_322012.awb")

						arg_53_1:RecordAudio("322012013", var_56_59)
						arg_53_1:RecordAudio("322012013", var_56_59)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322012", "322012013", "story_v_out_322012.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322012", "322012013", "story_v_out_322012.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_60 = var_56_49 + 0.3
			local var_56_61 = math.max(var_56_50, arg_53_1.talkMaxDuration)

			if var_56_60 <= arg_53_1.time_ and arg_53_1.time_ < var_56_60 + var_56_61 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_60) / var_56_61

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_60 + var_56_61 and arg_53_1.time_ < var_56_60 + var_56_61 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322012014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322012014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play322012015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.1

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(322012014)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 44
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play322012015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322012015
		arg_65_1.duration_ = 11.93

		local var_65_0 = {
			zh = 7.333,
			ja = 11.933
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
				arg_65_0:Play322012016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 1

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[1167].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(322012015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 40
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012015", "story_v_out_322012.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_322012", "322012015", "story_v_out_322012.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_322012", "322012015", "story_v_out_322012.awb")

						arg_65_1:RecordAudio("322012015", var_68_9)
						arg_65_1:RecordAudio("322012015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_322012", "322012015", "story_v_out_322012.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_322012", "322012015", "story_v_out_322012.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play322012016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 322012016
		arg_69_1.duration_ = 10.77

		local var_69_0 = {
			zh = 7.833,
			ja = 10.766
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
				arg_69_0:Play322012017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.025

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[1167].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(322012016)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012016", "story_v_out_322012.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_322012", "322012016", "story_v_out_322012.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_322012", "322012016", "story_v_out_322012.awb")

						arg_69_1:RecordAudio("322012016", var_72_9)
						arg_69_1:RecordAudio("322012016", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_322012", "322012016", "story_v_out_322012.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_322012", "322012016", "story_v_out_322012.awb")
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
	Play322012017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 322012017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play322012018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.1
			local var_76_1 = 1

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				local var_76_2 = "play"
				local var_76_3 = "effect"

				arg_73_1:AudioAction(var_76_2, var_76_3, "se_story_145", "se_story_145_footstep", "")
			end

			local var_76_4 = 0
			local var_76_5 = 1.3

			if var_76_4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(322012017)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_8 = 52
				local var_76_9 = utf8.len(var_76_7)
				local var_76_10 = var_76_8 <= 0 and var_76_5 or var_76_5 * (var_76_9 / var_76_8)

				if var_76_10 > 0 and var_76_5 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_11 and arg_73_1.time_ < var_76_4 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play322012018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 322012018
		arg_77_1.duration_ = 13.1

		local var_77_0 = {
			zh = 13.1000000029802,
			ja = 11.9330000029802
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
				arg_77_0:Play322012019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = "L15"

			if arg_77_1.bgs_[var_80_0] == nil then
				local var_80_1 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_80_0)
				var_80_1.name = var_80_0
				var_80_1.transform.parent = arg_77_1.stage_.transform
				var_80_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_[var_80_0] = var_80_1
			end

			local var_80_2 = 2.00000000298023

			if var_80_2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				local var_80_3 = manager.ui.mainCamera.transform.localPosition
				local var_80_4 = Vector3.New(0, 0, 10) + Vector3.New(var_80_3.x, var_80_3.y, 0)
				local var_80_5 = arg_77_1.bgs_.L15

				var_80_5.transform.localPosition = var_80_4
				var_80_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_6 = var_80_5:GetComponent("SpriteRenderer")

				if var_80_6 and var_80_6.sprite then
					local var_80_7 = (var_80_5.transform.localPosition - var_80_3).z
					local var_80_8 = manager.ui.mainCameraCom_
					local var_80_9 = 2 * var_80_7 * Mathf.Tan(var_80_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_80_10 = var_80_9 * var_80_8.aspect
					local var_80_11 = var_80_6.sprite.bounds.size.x
					local var_80_12 = var_80_6.sprite.bounds.size.y
					local var_80_13 = var_80_10 / var_80_11
					local var_80_14 = var_80_9 / var_80_12
					local var_80_15 = var_80_14 < var_80_13 and var_80_13 or var_80_14

					var_80_5.transform.localScale = Vector3.New(var_80_15, var_80_15, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "L15" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_16 = 3.999999999999

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			local var_80_17 = 0.3

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end

			local var_80_18 = 0

			if var_80_18 < arg_77_1.time_ and arg_77_1.time_ <= var_80_18 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_19 = 2

			if var_80_18 <= arg_77_1.time_ and arg_77_1.time_ < var_80_18 + var_80_19 then
				local var_80_20 = (arg_77_1.time_ - var_80_18) / var_80_19
				local var_80_21 = Color.New(0, 0, 0)

				var_80_21.a = Mathf.Lerp(0, 1, var_80_20)
				arg_77_1.mask_.color = var_80_21
			end

			if arg_77_1.time_ >= var_80_18 + var_80_19 and arg_77_1.time_ < var_80_18 + var_80_19 + arg_80_0 then
				local var_80_22 = Color.New(0, 0, 0)

				var_80_22.a = 1
				arg_77_1.mask_.color = var_80_22
			end

			local var_80_23 = 2

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_24 = 2

			if var_80_23 <= arg_77_1.time_ and arg_77_1.time_ < var_80_23 + var_80_24 then
				local var_80_25 = (arg_77_1.time_ - var_80_23) / var_80_24
				local var_80_26 = Color.New(0, 0, 0)

				var_80_26.a = Mathf.Lerp(1, 0, var_80_25)
				arg_77_1.mask_.color = var_80_26
			end

			if arg_77_1.time_ >= var_80_23 + var_80_24 and arg_77_1.time_ < var_80_23 + var_80_24 + arg_80_0 then
				local var_80_27 = Color.New(0, 0, 0)
				local var_80_28 = 0

				arg_77_1.mask_.enabled = false
				var_80_27.a = var_80_28
				arg_77_1.mask_.color = var_80_27
			end

			local var_80_29 = "1156ui_story"

			if arg_77_1.actors_[var_80_29] == nil then
				local var_80_30 = Asset.Load("Char/" .. "1156ui_story")

				if not isNil(var_80_30) then
					local var_80_31 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_77_1.stage_.transform)

					var_80_31.name = var_80_29
					var_80_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_77_1.actors_[var_80_29] = var_80_31

					local var_80_32 = var_80_31:GetComponentInChildren(typeof(CharacterEffect))

					var_80_32.enabled = true

					local var_80_33 = GameObjectTools.GetOrAddComponent(var_80_31, typeof(DynamicBoneHelper))

					if var_80_33 then
						var_80_33:EnableDynamicBone(false)
					end

					arg_77_1:ShowWeapon(var_80_32.transform, false)

					arg_77_1.var_[var_80_29 .. "Animator"] = var_80_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_77_1.var_[var_80_29 .. "Animator"].applyRootMotion = true
					arg_77_1.var_[var_80_29 .. "LipSync"] = var_80_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_80_34 = arg_77_1.actors_["1156ui_story"].transform
			local var_80_35 = 3.8

			if var_80_35 < arg_77_1.time_ and arg_77_1.time_ <= var_80_35 + arg_80_0 then
				arg_77_1.var_.moveOldPos1156ui_story = var_80_34.localPosition

				local var_80_36 = "1156ui_story"

				arg_77_1:ShowWeapon(arg_77_1.var_[var_80_36 .. "Animator"].transform, false)
			end

			local var_80_37 = 0.001

			if var_80_35 <= arg_77_1.time_ and arg_77_1.time_ < var_80_35 + var_80_37 then
				local var_80_38 = (arg_77_1.time_ - var_80_35) / var_80_37
				local var_80_39 = Vector3.New(0, -1.1, -6.18)

				var_80_34.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1156ui_story, var_80_39, var_80_38)

				local var_80_40 = manager.ui.mainCamera.transform.position - var_80_34.position

				var_80_34.forward = Vector3.New(var_80_40.x, var_80_40.y, var_80_40.z)

				local var_80_41 = var_80_34.localEulerAngles

				var_80_41.z = 0
				var_80_41.x = 0
				var_80_34.localEulerAngles = var_80_41
			end

			if arg_77_1.time_ >= var_80_35 + var_80_37 and arg_77_1.time_ < var_80_35 + var_80_37 + arg_80_0 then
				var_80_34.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_80_42 = manager.ui.mainCamera.transform.position - var_80_34.position

				var_80_34.forward = Vector3.New(var_80_42.x, var_80_42.y, var_80_42.z)

				local var_80_43 = var_80_34.localEulerAngles

				var_80_43.z = 0
				var_80_43.x = 0
				var_80_34.localEulerAngles = var_80_43
			end

			local var_80_44 = arg_77_1.actors_["1156ui_story"]
			local var_80_45 = 3.8

			if var_80_45 < arg_77_1.time_ and arg_77_1.time_ <= var_80_45 + arg_80_0 and not isNil(var_80_44) and arg_77_1.var_.characterEffect1156ui_story == nil then
				arg_77_1.var_.characterEffect1156ui_story = var_80_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_46 = 0.200000002980232

			if var_80_45 <= arg_77_1.time_ and arg_77_1.time_ < var_80_45 + var_80_46 and not isNil(var_80_44) then
				local var_80_47 = (arg_77_1.time_ - var_80_45) / var_80_46

				if arg_77_1.var_.characterEffect1156ui_story and not isNil(var_80_44) then
					arg_77_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_45 + var_80_46 and arg_77_1.time_ < var_80_45 + var_80_46 + arg_80_0 and not isNil(var_80_44) and arg_77_1.var_.characterEffect1156ui_story then
				arg_77_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_80_48 = 3.8

			if var_80_48 < arg_77_1.time_ and arg_77_1.time_ <= var_80_48 + arg_80_0 then
				arg_77_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_80_49 = 3.8

			if var_80_49 < arg_77_1.time_ and arg_77_1.time_ <= var_80_49 + arg_80_0 then
				arg_77_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_50 = 4.00000000298023
			local var_80_51 = 0.825

			if var_80_50 < arg_77_1.time_ and arg_77_1.time_ <= var_80_50 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_52 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_52:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_53 = arg_77_1:FormatText(StoryNameCfg[605].name)

				arg_77_1.leftNameTxt_.text = var_80_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_54 = arg_77_1:GetWordFromCfg(322012018)
				local var_80_55 = arg_77_1:FormatText(var_80_54.content)

				arg_77_1.text_.text = var_80_55

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_56 = 33
				local var_80_57 = utf8.len(var_80_55)
				local var_80_58 = var_80_56 <= 0 and var_80_51 or var_80_51 * (var_80_57 / var_80_56)

				if var_80_58 > 0 and var_80_51 < var_80_58 then
					arg_77_1.talkMaxDuration = var_80_58
					var_80_50 = var_80_50 + 0.3

					if var_80_58 + var_80_50 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_58 + var_80_50
					end
				end

				arg_77_1.text_.text = var_80_55
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012018", "story_v_out_322012.awb") ~= 0 then
					local var_80_59 = manager.audio:GetVoiceLength("story_v_out_322012", "322012018", "story_v_out_322012.awb") / 1000

					if var_80_59 + var_80_50 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_59 + var_80_50
					end

					if var_80_54.prefab_name ~= "" and arg_77_1.actors_[var_80_54.prefab_name] ~= nil then
						local var_80_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_54.prefab_name].transform, "story_v_out_322012", "322012018", "story_v_out_322012.awb")

						arg_77_1:RecordAudio("322012018", var_80_60)
						arg_77_1:RecordAudio("322012018", var_80_60)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_322012", "322012018", "story_v_out_322012.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_322012", "322012018", "story_v_out_322012.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_61 = var_80_50 + 0.3
			local var_80_62 = math.max(var_80_51, arg_77_1.talkMaxDuration)

			if var_80_61 <= arg_77_1.time_ and arg_77_1.time_ < var_80_61 + var_80_62 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_61) / var_80_62

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_61 + var_80_62 and arg_77_1.time_ < var_80_61 + var_80_62 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play322012019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322012019
		arg_83_1.duration_ = 13.37

		local var_83_0 = {
			zh = 10.6,
			ja = 13.366
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play322012020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action7_1")
			end

			local var_86_1 = 0
			local var_86_2 = 1.225

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_3 = arg_83_1:FormatText(StoryNameCfg[605].name)

				arg_83_1.leftNameTxt_.text = var_86_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_4 = arg_83_1:GetWordFromCfg(322012019)
				local var_86_5 = arg_83_1:FormatText(var_86_4.content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 49
				local var_86_7 = utf8.len(var_86_5)
				local var_86_8 = var_86_6 <= 0 and var_86_2 or var_86_2 * (var_86_7 / var_86_6)

				if var_86_8 > 0 and var_86_2 < var_86_8 then
					arg_83_1.talkMaxDuration = var_86_8

					if var_86_8 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012019", "story_v_out_322012.awb") ~= 0 then
					local var_86_9 = manager.audio:GetVoiceLength("story_v_out_322012", "322012019", "story_v_out_322012.awb") / 1000

					if var_86_9 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_1
					end

					if var_86_4.prefab_name ~= "" and arg_83_1.actors_[var_86_4.prefab_name] ~= nil then
						local var_86_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_4.prefab_name].transform, "story_v_out_322012", "322012019", "story_v_out_322012.awb")

						arg_83_1:RecordAudio("322012019", var_86_10)
						arg_83_1:RecordAudio("322012019", var_86_10)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_322012", "322012019", "story_v_out_322012.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_322012", "322012019", "story_v_out_322012.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_11 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_11 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_11

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_11 and arg_83_1.time_ < var_86_1 + var_86_11 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play322012020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322012020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play322012021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1156ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1156ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, 100, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1156ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, 100, 0)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = 0
			local var_90_10 = 0.85

			if var_90_9 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_11 = arg_87_1:GetWordFromCfg(322012020)
				local var_90_12 = arg_87_1:FormatText(var_90_11.content)

				arg_87_1.text_.text = var_90_12

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 34
				local var_90_14 = utf8.len(var_90_12)
				local var_90_15 = var_90_13 <= 0 and var_90_10 or var_90_10 * (var_90_14 / var_90_13)

				if var_90_15 > 0 and var_90_10 < var_90_15 then
					arg_87_1.talkMaxDuration = var_90_15

					if var_90_15 + var_90_9 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_15 + var_90_9
					end
				end

				arg_87_1.text_.text = var_90_12
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_16 = math.max(var_90_10, arg_87_1.talkMaxDuration)

			if var_90_9 <= arg_87_1.time_ and arg_87_1.time_ < var_90_9 + var_90_16 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_9) / var_90_16

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_9 + var_90_16 and arg_87_1.time_ < var_90_9 + var_90_16 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play322012021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 322012021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play322012022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 1.3

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_2 = arg_91_1:GetWordFromCfg(322012021)
				local var_94_3 = arg_91_1:FormatText(var_94_2.content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 52
				local var_94_5 = utf8.len(var_94_3)
				local var_94_6 = var_94_4 <= 0 and var_94_1 or var_94_1 * (var_94_5 / var_94_4)

				if var_94_6 > 0 and var_94_1 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_7 and arg_91_1.time_ < var_94_0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play322012022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 322012022
		arg_95_1.duration_ = 14.3

		local var_95_0 = {
			zh = 11.833,
			ja = 14.3
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
				arg_95_0:Play322012023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1156ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1156ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, -1.1, -6.18)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1156ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["1156ui_story"]
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1156ui_story == nil then
				arg_95_1.var_.characterEffect1156ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.200000002980232

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 and not isNil(var_98_9) then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11

				if arg_95_1.var_.characterEffect1156ui_story and not isNil(var_98_9) then
					arg_95_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1156ui_story then
				arg_95_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_98_13 = 0

			if var_98_13 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_98_14 = 0
			local var_98_15 = 1.325

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_16 = arg_95_1:FormatText(StoryNameCfg[605].name)

				arg_95_1.leftNameTxt_.text = var_98_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_17 = arg_95_1:GetWordFromCfg(322012022)
				local var_98_18 = arg_95_1:FormatText(var_98_17.content)

				arg_95_1.text_.text = var_98_18

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_19 = 53
				local var_98_20 = utf8.len(var_98_18)
				local var_98_21 = var_98_19 <= 0 and var_98_15 or var_98_15 * (var_98_20 / var_98_19)

				if var_98_21 > 0 and var_98_15 < var_98_21 then
					arg_95_1.talkMaxDuration = var_98_21

					if var_98_21 + var_98_14 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_21 + var_98_14
					end
				end

				arg_95_1.text_.text = var_98_18
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012022", "story_v_out_322012.awb") ~= 0 then
					local var_98_22 = manager.audio:GetVoiceLength("story_v_out_322012", "322012022", "story_v_out_322012.awb") / 1000

					if var_98_22 + var_98_14 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_22 + var_98_14
					end

					if var_98_17.prefab_name ~= "" and arg_95_1.actors_[var_98_17.prefab_name] ~= nil then
						local var_98_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_17.prefab_name].transform, "story_v_out_322012", "322012022", "story_v_out_322012.awb")

						arg_95_1:RecordAudio("322012022", var_98_23)
						arg_95_1:RecordAudio("322012022", var_98_23)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_322012", "322012022", "story_v_out_322012.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_322012", "322012022", "story_v_out_322012.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_24 = math.max(var_98_15, arg_95_1.talkMaxDuration)

			if var_98_14 <= arg_95_1.time_ and arg_95_1.time_ < var_98_14 + var_98_24 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_14) / var_98_24

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_14 + var_98_24 and arg_95_1.time_ < var_98_14 + var_98_24 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play322012023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 322012023
		arg_99_1.duration_ = 11

		local var_99_0 = {
			zh = 9.866,
			ja = 11
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
				arg_99_0:Play322012024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[605].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(322012023)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 40
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012023", "story_v_out_322012.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_322012", "322012023", "story_v_out_322012.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_322012", "322012023", "story_v_out_322012.awb")

						arg_99_1:RecordAudio("322012023", var_102_9)
						arg_99_1:RecordAudio("322012023", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_322012", "322012023", "story_v_out_322012.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_322012", "322012023", "story_v_out_322012.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_10 and arg_99_1.time_ < var_102_0 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play322012024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 322012024
		arg_103_1.duration_ = 8.07

		local var_103_0 = {
			zh = 7.53300000298023,
			ja = 8.06600000298023
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
				arg_103_0:Play322012025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 2

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				local var_106_1 = manager.ui.mainCamera.transform.localPosition
				local var_106_2 = Vector3.New(0, 0, 10) + Vector3.New(var_106_1.x, var_106_1.y, 0)
				local var_106_3 = arg_103_1.bgs_.L14f

				var_106_3.transform.localPosition = var_106_2
				var_106_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_4 = var_106_3:GetComponent("SpriteRenderer")

				if var_106_4 and var_106_4.sprite then
					local var_106_5 = (var_106_3.transform.localPosition - var_106_1).z
					local var_106_6 = manager.ui.mainCameraCom_
					local var_106_7 = 2 * var_106_5 * Mathf.Tan(var_106_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_106_8 = var_106_7 * var_106_6.aspect
					local var_106_9 = var_106_4.sprite.bounds.size.x
					local var_106_10 = var_106_4.sprite.bounds.size.y
					local var_106_11 = var_106_8 / var_106_9
					local var_106_12 = var_106_7 / var_106_10
					local var_106_13 = var_106_12 < var_106_11 and var_106_11 or var_106_12

					var_106_3.transform.localScale = Vector3.New(var_106_13, var_106_13, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "L14f" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_14 = 4.00000000298023

			if var_106_14 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				arg_103_1.allBtn_.enabled = false
			end

			local var_106_15 = 0.3

			if arg_103_1.time_ >= var_106_14 + var_106_15 and arg_103_1.time_ < var_106_14 + var_106_15 + arg_106_0 then
				arg_103_1.allBtn_.enabled = true
			end

			local var_106_16 = 0

			if var_106_16 < arg_103_1.time_ and arg_103_1.time_ <= var_106_16 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_17 = 2

			if var_106_16 <= arg_103_1.time_ and arg_103_1.time_ < var_106_16 + var_106_17 then
				local var_106_18 = (arg_103_1.time_ - var_106_16) / var_106_17
				local var_106_19 = Color.New(0, 0, 0)

				var_106_19.a = Mathf.Lerp(0, 1, var_106_18)
				arg_103_1.mask_.color = var_106_19
			end

			if arg_103_1.time_ >= var_106_16 + var_106_17 and arg_103_1.time_ < var_106_16 + var_106_17 + arg_106_0 then
				local var_106_20 = Color.New(0, 0, 0)

				var_106_20.a = 1
				arg_103_1.mask_.color = var_106_20
			end

			local var_106_21 = 2

			if var_106_21 < arg_103_1.time_ and arg_103_1.time_ <= var_106_21 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_22 = 2

			if var_106_21 <= arg_103_1.time_ and arg_103_1.time_ < var_106_21 + var_106_22 then
				local var_106_23 = (arg_103_1.time_ - var_106_21) / var_106_22
				local var_106_24 = Color.New(0, 0, 0)

				var_106_24.a = Mathf.Lerp(1, 0, var_106_23)
				arg_103_1.mask_.color = var_106_24
			end

			if arg_103_1.time_ >= var_106_21 + var_106_22 and arg_103_1.time_ < var_106_21 + var_106_22 + arg_106_0 then
				local var_106_25 = Color.New(0, 0, 0)
				local var_106_26 = 0

				arg_103_1.mask_.enabled = false
				var_106_25.a = var_106_26
				arg_103_1.mask_.color = var_106_25
			end

			local var_106_27 = "1085ui_story"

			if arg_103_1.actors_[var_106_27] == nil then
				local var_106_28 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_106_28) then
					local var_106_29 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_103_1.stage_.transform)

					var_106_29.name = var_106_27
					var_106_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_103_1.actors_[var_106_27] = var_106_29

					local var_106_30 = var_106_29:GetComponentInChildren(typeof(CharacterEffect))

					var_106_30.enabled = true

					local var_106_31 = GameObjectTools.GetOrAddComponent(var_106_29, typeof(DynamicBoneHelper))

					if var_106_31 then
						var_106_31:EnableDynamicBone(false)
					end

					arg_103_1:ShowWeapon(var_106_30.transform, false)

					arg_103_1.var_[var_106_27 .. "Animator"] = var_106_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_103_1.var_[var_106_27 .. "Animator"].applyRootMotion = true
					arg_103_1.var_[var_106_27 .. "LipSync"] = var_106_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_106_32 = arg_103_1.actors_["1085ui_story"].transform
			local var_106_33 = 3.8

			if var_106_33 < arg_103_1.time_ and arg_103_1.time_ <= var_106_33 + arg_106_0 then
				arg_103_1.var_.moveOldPos1085ui_story = var_106_32.localPosition
			end

			local var_106_34 = 0.001

			if var_106_33 <= arg_103_1.time_ and arg_103_1.time_ < var_106_33 + var_106_34 then
				local var_106_35 = (arg_103_1.time_ - var_106_33) / var_106_34
				local var_106_36 = Vector3.New(0, -1.01, -5.83)

				var_106_32.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1085ui_story, var_106_36, var_106_35)

				local var_106_37 = manager.ui.mainCamera.transform.position - var_106_32.position

				var_106_32.forward = Vector3.New(var_106_37.x, var_106_37.y, var_106_37.z)

				local var_106_38 = var_106_32.localEulerAngles

				var_106_38.z = 0
				var_106_38.x = 0
				var_106_32.localEulerAngles = var_106_38
			end

			if arg_103_1.time_ >= var_106_33 + var_106_34 and arg_103_1.time_ < var_106_33 + var_106_34 + arg_106_0 then
				var_106_32.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_106_39 = manager.ui.mainCamera.transform.position - var_106_32.position

				var_106_32.forward = Vector3.New(var_106_39.x, var_106_39.y, var_106_39.z)

				local var_106_40 = var_106_32.localEulerAngles

				var_106_40.z = 0
				var_106_40.x = 0
				var_106_32.localEulerAngles = var_106_40
			end

			local var_106_41 = arg_103_1.actors_["1085ui_story"]
			local var_106_42 = 3.8

			if var_106_42 < arg_103_1.time_ and arg_103_1.time_ <= var_106_42 + arg_106_0 and not isNil(var_106_41) and arg_103_1.var_.characterEffect1085ui_story == nil then
				arg_103_1.var_.characterEffect1085ui_story = var_106_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_43 = 0.200000002980232

			if var_106_42 <= arg_103_1.time_ and arg_103_1.time_ < var_106_42 + var_106_43 and not isNil(var_106_41) then
				local var_106_44 = (arg_103_1.time_ - var_106_42) / var_106_43

				if arg_103_1.var_.characterEffect1085ui_story and not isNil(var_106_41) then
					arg_103_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_42 + var_106_43 and arg_103_1.time_ < var_106_42 + var_106_43 + arg_106_0 and not isNil(var_106_41) and arg_103_1.var_.characterEffect1085ui_story then
				arg_103_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_106_45 = 3.8

			if var_106_45 < arg_103_1.time_ and arg_103_1.time_ <= var_106_45 + arg_106_0 then
				arg_103_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_106_46 = 3.8

			if var_106_46 < arg_103_1.time_ and arg_103_1.time_ <= var_106_46 + arg_106_0 then
				arg_103_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_106_47 = arg_103_1.actors_["1156ui_story"].transform
			local var_106_48 = 1.96599999815226

			if var_106_48 < arg_103_1.time_ and arg_103_1.time_ <= var_106_48 + arg_106_0 then
				arg_103_1.var_.moveOldPos1156ui_story = var_106_47.localPosition
			end

			local var_106_49 = 0.001

			if var_106_48 <= arg_103_1.time_ and arg_103_1.time_ < var_106_48 + var_106_49 then
				local var_106_50 = (arg_103_1.time_ - var_106_48) / var_106_49
				local var_106_51 = Vector3.New(0, 100, 0)

				var_106_47.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1156ui_story, var_106_51, var_106_50)

				local var_106_52 = manager.ui.mainCamera.transform.position - var_106_47.position

				var_106_47.forward = Vector3.New(var_106_52.x, var_106_52.y, var_106_52.z)

				local var_106_53 = var_106_47.localEulerAngles

				var_106_53.z = 0
				var_106_53.x = 0
				var_106_47.localEulerAngles = var_106_53
			end

			if arg_103_1.time_ >= var_106_48 + var_106_49 and arg_103_1.time_ < var_106_48 + var_106_49 + arg_106_0 then
				var_106_47.localPosition = Vector3.New(0, 100, 0)

				local var_106_54 = manager.ui.mainCamera.transform.position - var_106_47.position

				var_106_47.forward = Vector3.New(var_106_54.x, var_106_54.y, var_106_54.z)

				local var_106_55 = var_106_47.localEulerAngles

				var_106_55.z = 0
				var_106_55.x = 0
				var_106_47.localEulerAngles = var_106_55
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_56 = 4.00000000298023
			local var_106_57 = 0.325

			if var_106_56 < arg_103_1.time_ and arg_103_1.time_ <= var_106_56 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_58 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_58:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_59 = arg_103_1:FormatText(StoryNameCfg[328].name)

				arg_103_1.leftNameTxt_.text = var_106_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_60 = arg_103_1:GetWordFromCfg(322012024)
				local var_106_61 = arg_103_1:FormatText(var_106_60.content)

				arg_103_1.text_.text = var_106_61

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_62 = 13
				local var_106_63 = utf8.len(var_106_61)
				local var_106_64 = var_106_62 <= 0 and var_106_57 or var_106_57 * (var_106_63 / var_106_62)

				if var_106_64 > 0 and var_106_57 < var_106_64 then
					arg_103_1.talkMaxDuration = var_106_64
					var_106_56 = var_106_56 + 0.3

					if var_106_64 + var_106_56 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_64 + var_106_56
					end
				end

				arg_103_1.text_.text = var_106_61
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012024", "story_v_out_322012.awb") ~= 0 then
					local var_106_65 = manager.audio:GetVoiceLength("story_v_out_322012", "322012024", "story_v_out_322012.awb") / 1000

					if var_106_65 + var_106_56 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_65 + var_106_56
					end

					if var_106_60.prefab_name ~= "" and arg_103_1.actors_[var_106_60.prefab_name] ~= nil then
						local var_106_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_60.prefab_name].transform, "story_v_out_322012", "322012024", "story_v_out_322012.awb")

						arg_103_1:RecordAudio("322012024", var_106_66)
						arg_103_1:RecordAudio("322012024", var_106_66)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_322012", "322012024", "story_v_out_322012.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_322012", "322012024", "story_v_out_322012.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_67 = var_106_56 + 0.3
			local var_106_68 = math.max(var_106_57, arg_103_1.talkMaxDuration)

			if var_106_67 <= arg_103_1.time_ and arg_103_1.time_ < var_106_67 + var_106_68 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_67) / var_106_68

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_67 + var_106_68 and arg_103_1.time_ < var_106_67 + var_106_68 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play322012025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322012025
		arg_109_1.duration_ = 3.83

		local var_109_0 = {
			zh = 3.833,
			ja = 3.766
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
				arg_109_0:Play322012026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1085ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1085ui_story == nil then
				arg_109_1.var_.characterEffect1085ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1085ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1085ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1085ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1085ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.475

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[1184].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_9 = arg_109_1:GetWordFromCfg(322012025)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012025", "story_v_out_322012.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_322012", "322012025", "story_v_out_322012.awb") / 1000

					if var_112_14 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_6
					end

					if var_112_9.prefab_name ~= "" and arg_109_1.actors_[var_112_9.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_9.prefab_name].transform, "story_v_out_322012", "322012025", "story_v_out_322012.awb")

						arg_109_1:RecordAudio("322012025", var_112_15)
						arg_109_1:RecordAudio("322012025", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322012", "322012025", "story_v_out_322012.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322012", "322012025", "story_v_out_322012.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_16 and arg_109_1.time_ < var_112_6 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play322012026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322012026
		arg_113_1.duration_ = 5.73

		local var_113_0 = {
			zh = 4,
			ja = 5.733
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play322012027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = "404001ui_story"

			if arg_113_1.actors_[var_116_0] == nil then
				local var_116_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_116_1) then
					local var_116_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_113_1.stage_.transform)

					var_116_2.name = var_116_0
					var_116_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_113_1.actors_[var_116_0] = var_116_2

					local var_116_3 = var_116_2:GetComponentInChildren(typeof(CharacterEffect))

					var_116_3.enabled = true

					local var_116_4 = GameObjectTools.GetOrAddComponent(var_116_2, typeof(DynamicBoneHelper))

					if var_116_4 then
						var_116_4:EnableDynamicBone(false)
					end

					arg_113_1:ShowWeapon(var_116_3.transform, false)

					arg_113_1.var_[var_116_0 .. "Animator"] = var_116_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_113_1.var_[var_116_0 .. "Animator"].applyRootMotion = true
					arg_113_1.var_[var_116_0 .. "LipSync"] = var_116_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_116_5 = arg_113_1.actors_["404001ui_story"].transform
			local var_116_6 = 0

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.var_.moveOldPos404001ui_story = var_116_5.localPosition
			end

			local var_116_7 = 0.001

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_7 then
				local var_116_8 = (arg_113_1.time_ - var_116_6) / var_116_7
				local var_116_9 = Vector3.New(0.8, -1.55, -5.5)

				var_116_5.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos404001ui_story, var_116_9, var_116_8)

				local var_116_10 = manager.ui.mainCamera.transform.position - var_116_5.position

				var_116_5.forward = Vector3.New(var_116_10.x, var_116_10.y, var_116_10.z)

				local var_116_11 = var_116_5.localEulerAngles

				var_116_11.z = 0
				var_116_11.x = 0
				var_116_5.localEulerAngles = var_116_11
			end

			if arg_113_1.time_ >= var_116_6 + var_116_7 and arg_113_1.time_ < var_116_6 + var_116_7 + arg_116_0 then
				var_116_5.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_116_12 = manager.ui.mainCamera.transform.position - var_116_5.position

				var_116_5.forward = Vector3.New(var_116_12.x, var_116_12.y, var_116_12.z)

				local var_116_13 = var_116_5.localEulerAngles

				var_116_13.z = 0
				var_116_13.x = 0
				var_116_5.localEulerAngles = var_116_13
			end

			local var_116_14 = arg_113_1.actors_["1085ui_story"].transform
			local var_116_15 = 0

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.var_.moveOldPos1085ui_story = var_116_14.localPosition
			end

			local var_116_16 = 0.001

			if var_116_15 <= arg_113_1.time_ and arg_113_1.time_ < var_116_15 + var_116_16 then
				local var_116_17 = (arg_113_1.time_ - var_116_15) / var_116_16
				local var_116_18 = Vector3.New(-0.75, -1.01, -5.83)

				var_116_14.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1085ui_story, var_116_18, var_116_17)

				local var_116_19 = manager.ui.mainCamera.transform.position - var_116_14.position

				var_116_14.forward = Vector3.New(var_116_19.x, var_116_19.y, var_116_19.z)

				local var_116_20 = var_116_14.localEulerAngles

				var_116_20.z = 0
				var_116_20.x = 0
				var_116_14.localEulerAngles = var_116_20
			end

			if arg_113_1.time_ >= var_116_15 + var_116_16 and arg_113_1.time_ < var_116_15 + var_116_16 + arg_116_0 then
				var_116_14.localPosition = Vector3.New(-0.75, -1.01, -5.83)

				local var_116_21 = manager.ui.mainCamera.transform.position - var_116_14.position

				var_116_14.forward = Vector3.New(var_116_21.x, var_116_21.y, var_116_21.z)

				local var_116_22 = var_116_14.localEulerAngles

				var_116_22.z = 0
				var_116_22.x = 0
				var_116_14.localEulerAngles = var_116_22
			end

			local var_116_23 = arg_113_1.actors_["404001ui_story"]
			local var_116_24 = 0

			if var_116_24 < arg_113_1.time_ and arg_113_1.time_ <= var_116_24 + arg_116_0 and not isNil(var_116_23) and arg_113_1.var_.characterEffect404001ui_story == nil then
				arg_113_1.var_.characterEffect404001ui_story = var_116_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_25 = 0.200000002980232

			if var_116_24 <= arg_113_1.time_ and arg_113_1.time_ < var_116_24 + var_116_25 and not isNil(var_116_23) then
				local var_116_26 = (arg_113_1.time_ - var_116_24) / var_116_25

				if arg_113_1.var_.characterEffect404001ui_story and not isNil(var_116_23) then
					arg_113_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_24 + var_116_25 and arg_113_1.time_ < var_116_24 + var_116_25 + arg_116_0 and not isNil(var_116_23) and arg_113_1.var_.characterEffect404001ui_story then
				arg_113_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_116_27 = 0

			if var_116_27 < arg_113_1.time_ and arg_113_1.time_ <= var_116_27 + arg_116_0 then
				arg_113_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_116_28 = 0

			if var_116_28 < arg_113_1.time_ and arg_113_1.time_ <= var_116_28 + arg_116_0 then
				arg_113_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_116_29 = 0
			local var_116_30 = 0.45

			if var_116_29 < arg_113_1.time_ and arg_113_1.time_ <= var_116_29 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_31 = arg_113_1:FormatText(StoryNameCfg[668].name)

				arg_113_1.leftNameTxt_.text = var_116_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_32 = arg_113_1:GetWordFromCfg(322012026)
				local var_116_33 = arg_113_1:FormatText(var_116_32.content)

				arg_113_1.text_.text = var_116_33

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_34 = 18
				local var_116_35 = utf8.len(var_116_33)
				local var_116_36 = var_116_34 <= 0 and var_116_30 or var_116_30 * (var_116_35 / var_116_34)

				if var_116_36 > 0 and var_116_30 < var_116_36 then
					arg_113_1.talkMaxDuration = var_116_36

					if var_116_36 + var_116_29 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_36 + var_116_29
					end
				end

				arg_113_1.text_.text = var_116_33
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012026", "story_v_out_322012.awb") ~= 0 then
					local var_116_37 = manager.audio:GetVoiceLength("story_v_out_322012", "322012026", "story_v_out_322012.awb") / 1000

					if var_116_37 + var_116_29 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_37 + var_116_29
					end

					if var_116_32.prefab_name ~= "" and arg_113_1.actors_[var_116_32.prefab_name] ~= nil then
						local var_116_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_32.prefab_name].transform, "story_v_out_322012", "322012026", "story_v_out_322012.awb")

						arg_113_1:RecordAudio("322012026", var_116_38)
						arg_113_1:RecordAudio("322012026", var_116_38)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_322012", "322012026", "story_v_out_322012.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_322012", "322012026", "story_v_out_322012.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_39 = math.max(var_116_30, arg_113_1.talkMaxDuration)

			if var_116_29 <= arg_113_1.time_ and arg_113_1.time_ < var_116_29 + var_116_39 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_29) / var_116_39

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_29 + var_116_39 and arg_113_1.time_ < var_116_29 + var_116_39 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play322012027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322012027
		arg_117_1.duration_ = 6

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play322012028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["404001ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos404001ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0, 100, 0)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos404001ui_story, var_120_4, var_120_3)

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

			local var_120_9 = arg_117_1.actors_["1085ui_story"].transform
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1.var_.moveOldPos1085ui_story = var_120_9.localPosition
			end

			local var_120_11 = 0.001

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11
				local var_120_13 = Vector3.New(0, 100, 0)

				var_120_9.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1085ui_story, var_120_13, var_120_12)

				local var_120_14 = manager.ui.mainCamera.transform.position - var_120_9.position

				var_120_9.forward = Vector3.New(var_120_14.x, var_120_14.y, var_120_14.z)

				local var_120_15 = var_120_9.localEulerAngles

				var_120_15.z = 0
				var_120_15.x = 0
				var_120_9.localEulerAngles = var_120_15
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 then
				var_120_9.localPosition = Vector3.New(0, 100, 0)

				local var_120_16 = manager.ui.mainCamera.transform.position - var_120_9.position

				var_120_9.forward = Vector3.New(var_120_16.x, var_120_16.y, var_120_16.z)

				local var_120_17 = var_120_9.localEulerAngles

				var_120_17.z = 0
				var_120_17.x = 0
				var_120_9.localEulerAngles = var_120_17
			end

			local var_120_18 = 0
			local var_120_19 = 1

			if var_120_18 < arg_117_1.time_ and arg_117_1.time_ <= var_120_18 + arg_120_0 then
				local var_120_20 = "play"
				local var_120_21 = "effect"

				arg_117_1:AudioAction(var_120_20, var_120_21, "se_story_1311", "se_story_1311_truck06", "")
			end

			local var_120_22 = manager.ui.mainCamera.transform
			local var_120_23 = 0.233333333333333

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 then
				local var_120_24 = arg_117_1.var_.effect12028
				local var_120_25
				local var_120_26 = var_120_22

				if not var_120_24 then
					var_120_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_120_26)
					var_120_24.name = "12028"
					arg_117_1.var_.effect12028 = var_120_24
				else
					var_120_24.transform:SetParent(var_120_26)
				end

				var_120_24.transform.localPosition = Vector3.New(0, 0, -3.86)
				var_120_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_120_27 = arg_117_1.bgs_.L14f.transform
			local var_120_28 = 0.233333333333333

			if var_120_28 < arg_117_1.time_ and arg_117_1.time_ <= var_120_28 + arg_120_0 then
				arg_117_1.var_.moveOldPosL14f = var_120_27.localPosition
			end

			local var_120_29 = 0.001

			if var_120_28 <= arg_117_1.time_ and arg_117_1.time_ < var_120_28 + var_120_29 then
				local var_120_30 = (arg_117_1.time_ - var_120_28) / var_120_29
				local var_120_31 = Vector3.New(0, 1, 10)

				var_120_27.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPosL14f, var_120_31, var_120_30)
			end

			if arg_117_1.time_ >= var_120_28 + var_120_29 and arg_117_1.time_ < var_120_28 + var_120_29 + arg_120_0 then
				var_120_27.localPosition = Vector3.New(0, 1, 10)
			end

			local var_120_32 = arg_117_1.bgs_.L14f.transform
			local var_120_33 = 0.267333333333333

			if var_120_33 < arg_117_1.time_ and arg_117_1.time_ <= var_120_33 + arg_120_0 then
				arg_117_1.var_.moveOldPosL14f = var_120_32.localPosition
			end

			local var_120_34 = 0.466

			if var_120_33 <= arg_117_1.time_ and arg_117_1.time_ < var_120_33 + var_120_34 then
				local var_120_35 = (arg_117_1.time_ - var_120_33) / var_120_34
				local var_120_36 = Vector3.New(0, 1, 8.5)

				var_120_32.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPosL14f, var_120_36, var_120_35)
			end

			if arg_117_1.time_ >= var_120_33 + var_120_34 and arg_117_1.time_ < var_120_33 + var_120_34 + arg_120_0 then
				var_120_32.localPosition = Vector3.New(0, 1, 8.5)
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_37 = 1
			local var_120_38 = 1.775

			if var_120_37 < arg_117_1.time_ and arg_117_1.time_ <= var_120_37 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_39 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_39:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_40 = arg_117_1:GetWordFromCfg(322012027)
				local var_120_41 = arg_117_1:FormatText(var_120_40.content)

				arg_117_1.text_.text = var_120_41

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_42 = 71
				local var_120_43 = utf8.len(var_120_41)
				local var_120_44 = var_120_42 <= 0 and var_120_38 or var_120_38 * (var_120_43 / var_120_42)

				if var_120_44 > 0 and var_120_38 < var_120_44 then
					arg_117_1.talkMaxDuration = var_120_44
					var_120_37 = var_120_37 + 0.3

					if var_120_44 + var_120_37 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_44 + var_120_37
					end
				end

				arg_117_1.text_.text = var_120_41
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_45 = var_120_37 + 0.3
			local var_120_46 = math.max(var_120_38, arg_117_1.talkMaxDuration)

			if var_120_45 <= arg_117_1.time_ and arg_117_1.time_ < var_120_45 + var_120_46 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_45) / var_120_46

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_45 + var_120_46 and arg_117_1.time_ < var_120_45 + var_120_46 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "L14f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.233333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "L14f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.466,
				className = "StoryMoveNode",
				startTime = 0.267333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play322012028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 322012028
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play322012029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = manager.ui.mainCamera.transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				local var_126_2 = arg_123_1.var_.effect12028

				if var_126_2 then
					Object.Destroy(var_126_2)

					arg_123_1.var_.effect12028 = nil
				end
			end

			local var_126_3 = 0
			local var_126_4 = 1.425

			if var_126_3 < arg_123_1.time_ and arg_123_1.time_ <= var_126_3 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_5 = arg_123_1:GetWordFromCfg(322012028)
				local var_126_6 = arg_123_1:FormatText(var_126_5.content)

				arg_123_1.text_.text = var_126_6

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 57
				local var_126_8 = utf8.len(var_126_6)
				local var_126_9 = var_126_7 <= 0 and var_126_4 or var_126_4 * (var_126_8 / var_126_7)

				if var_126_9 > 0 and var_126_4 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_3 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_3
					end
				end

				arg_123_1.text_.text = var_126_6
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_4, arg_123_1.talkMaxDuration)

			if var_126_3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_3 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_3) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_3 + var_126_10 and arg_123_1.time_ < var_126_3 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play322012029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322012029
		arg_127_1.duration_ = 8.1

		local var_127_0 = {
			zh = 5.7,
			ja = 8.1
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play322012030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "1043ui_story"

			if arg_127_1.actors_[var_130_0] == nil then
				local var_130_1 = Asset.Load("Char/" .. "1043ui_story")

				if not isNil(var_130_1) then
					local var_130_2 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_127_1.stage_.transform)

					var_130_2.name = var_130_0
					var_130_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_127_1.actors_[var_130_0] = var_130_2

					local var_130_3 = var_130_2:GetComponentInChildren(typeof(CharacterEffect))

					var_130_3.enabled = true

					local var_130_4 = GameObjectTools.GetOrAddComponent(var_130_2, typeof(DynamicBoneHelper))

					if var_130_4 then
						var_130_4:EnableDynamicBone(false)
					end

					arg_127_1:ShowWeapon(var_130_3.transform, false)

					arg_127_1.var_[var_130_0 .. "Animator"] = var_130_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_127_1.var_[var_130_0 .. "Animator"].applyRootMotion = true
					arg_127_1.var_[var_130_0 .. "LipSync"] = var_130_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_130_5 = arg_127_1.actors_["1043ui_story"].transform
			local var_130_6 = 0

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.var_.moveOldPos1043ui_story = var_130_5.localPosition
			end

			local var_130_7 = 0.001

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_7 then
				local var_130_8 = (arg_127_1.time_ - var_130_6) / var_130_7
				local var_130_9 = Vector3.New(0.01, -1.01, -5.73)

				var_130_5.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1043ui_story, var_130_9, var_130_8)

				local var_130_10 = manager.ui.mainCamera.transform.position - var_130_5.position

				var_130_5.forward = Vector3.New(var_130_10.x, var_130_10.y, var_130_10.z)

				local var_130_11 = var_130_5.localEulerAngles

				var_130_11.z = 0
				var_130_11.x = 0
				var_130_5.localEulerAngles = var_130_11
			end

			if arg_127_1.time_ >= var_130_6 + var_130_7 and arg_127_1.time_ < var_130_6 + var_130_7 + arg_130_0 then
				var_130_5.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_130_12 = manager.ui.mainCamera.transform.position - var_130_5.position

				var_130_5.forward = Vector3.New(var_130_12.x, var_130_12.y, var_130_12.z)

				local var_130_13 = var_130_5.localEulerAngles

				var_130_13.z = 0
				var_130_13.x = 0
				var_130_5.localEulerAngles = var_130_13
			end

			local var_130_14 = arg_127_1.actors_["1043ui_story"]
			local var_130_15 = 0

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 and not isNil(var_130_14) and arg_127_1.var_.characterEffect1043ui_story == nil then
				arg_127_1.var_.characterEffect1043ui_story = var_130_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_16 = 0.200000002980232

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_16 and not isNil(var_130_14) then
				local var_130_17 = (arg_127_1.time_ - var_130_15) / var_130_16

				if arg_127_1.var_.characterEffect1043ui_story and not isNil(var_130_14) then
					arg_127_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_15 + var_130_16 and arg_127_1.time_ < var_130_15 + var_130_16 + arg_130_0 and not isNil(var_130_14) and arg_127_1.var_.characterEffect1043ui_story then
				arg_127_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_130_18 = 0

			if var_130_18 < arg_127_1.time_ and arg_127_1.time_ <= var_130_18 + arg_130_0 then
				arg_127_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_130_19 = 0

			if var_130_19 < arg_127_1.time_ and arg_127_1.time_ <= var_130_19 + arg_130_0 then
				arg_127_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_130_20 = 0
			local var_130_21 = 0.65

			if var_130_20 < arg_127_1.time_ and arg_127_1.time_ <= var_130_20 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_22 = arg_127_1:FormatText(StoryNameCfg[1156].name)

				arg_127_1.leftNameTxt_.text = var_130_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_23 = arg_127_1:GetWordFromCfg(322012029)
				local var_130_24 = arg_127_1:FormatText(var_130_23.content)

				arg_127_1.text_.text = var_130_24

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_25 = 26
				local var_130_26 = utf8.len(var_130_24)
				local var_130_27 = var_130_25 <= 0 and var_130_21 or var_130_21 * (var_130_26 / var_130_25)

				if var_130_27 > 0 and var_130_21 < var_130_27 then
					arg_127_1.talkMaxDuration = var_130_27

					if var_130_27 + var_130_20 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_27 + var_130_20
					end
				end

				arg_127_1.text_.text = var_130_24
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012029", "story_v_out_322012.awb") ~= 0 then
					local var_130_28 = manager.audio:GetVoiceLength("story_v_out_322012", "322012029", "story_v_out_322012.awb") / 1000

					if var_130_28 + var_130_20 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_28 + var_130_20
					end

					if var_130_23.prefab_name ~= "" and arg_127_1.actors_[var_130_23.prefab_name] ~= nil then
						local var_130_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_23.prefab_name].transform, "story_v_out_322012", "322012029", "story_v_out_322012.awb")

						arg_127_1:RecordAudio("322012029", var_130_29)
						arg_127_1:RecordAudio("322012029", var_130_29)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_322012", "322012029", "story_v_out_322012.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_322012", "322012029", "story_v_out_322012.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_30 = math.max(var_130_21, arg_127_1.talkMaxDuration)

			if var_130_20 <= arg_127_1.time_ and arg_127_1.time_ < var_130_20 + var_130_30 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_20) / var_130_30

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_20 + var_130_30 and arg_127_1.time_ < var_130_20 + var_130_30 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play322012030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 322012030
		arg_131_1.duration_ = 6.5

		local var_131_0 = {
			zh = 5.433,
			ja = 6.5
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
				arg_131_0:Play322012031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1043ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1043ui_story == nil then
				arg_131_1.var_.characterEffect1043ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1043ui_story and not isNil(var_134_0) then
					local var_134_4 = Mathf.Lerp(0, 0.5, var_134_3)

					arg_131_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1043ui_story.fillRatio = var_134_4
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1043ui_story then
				local var_134_5 = 0.5

				arg_131_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1043ui_story.fillRatio = var_134_5
			end

			local var_134_6 = 0
			local var_134_7 = 0.775

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_8 = arg_131_1:FormatText(StoryNameCfg[1184].name)

				arg_131_1.leftNameTxt_.text = var_134_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_9 = arg_131_1:GetWordFromCfg(322012030)
				local var_134_10 = arg_131_1:FormatText(var_134_9.content)

				arg_131_1.text_.text = var_134_10

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 31
				local var_134_12 = utf8.len(var_134_10)
				local var_134_13 = var_134_11 <= 0 and var_134_7 or var_134_7 * (var_134_12 / var_134_11)

				if var_134_13 > 0 and var_134_7 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_10
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012030", "story_v_out_322012.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_322012", "322012030", "story_v_out_322012.awb") / 1000

					if var_134_14 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_6
					end

					if var_134_9.prefab_name ~= "" and arg_131_1.actors_[var_134_9.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_9.prefab_name].transform, "story_v_out_322012", "322012030", "story_v_out_322012.awb")

						arg_131_1:RecordAudio("322012030", var_134_15)
						arg_131_1:RecordAudio("322012030", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_322012", "322012030", "story_v_out_322012.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_322012", "322012030", "story_v_out_322012.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_16 and arg_131_1.time_ < var_134_6 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play322012031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322012031
		arg_135_1.duration_ = 9.93

		local var_135_0 = {
			zh = 8.033,
			ja = 9.933
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play322012032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["404001ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos404001ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0.8, -1.55, -5.5)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos404001ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = arg_135_1.actors_["1043ui_story"].transform
			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.var_.moveOldPos1043ui_story = var_138_9.localPosition
			end

			local var_138_11 = 0.001

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_11 then
				local var_138_12 = (arg_135_1.time_ - var_138_10) / var_138_11
				local var_138_13 = Vector3.New(-0.92, -1.01, -5.73)

				var_138_9.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1043ui_story, var_138_13, var_138_12)

				local var_138_14 = manager.ui.mainCamera.transform.position - var_138_9.position

				var_138_9.forward = Vector3.New(var_138_14.x, var_138_14.y, var_138_14.z)

				local var_138_15 = var_138_9.localEulerAngles

				var_138_15.z = 0
				var_138_15.x = 0
				var_138_9.localEulerAngles = var_138_15
			end

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 then
				var_138_9.localPosition = Vector3.New(-0.92, -1.01, -5.73)

				local var_138_16 = manager.ui.mainCamera.transform.position - var_138_9.position

				var_138_9.forward = Vector3.New(var_138_16.x, var_138_16.y, var_138_16.z)

				local var_138_17 = var_138_9.localEulerAngles

				var_138_17.z = 0
				var_138_17.x = 0
				var_138_9.localEulerAngles = var_138_17
			end

			local var_138_18 = arg_135_1.actors_["404001ui_story"]
			local var_138_19 = 0

			if var_138_19 < arg_135_1.time_ and arg_135_1.time_ <= var_138_19 + arg_138_0 and not isNil(var_138_18) and arg_135_1.var_.characterEffect404001ui_story == nil then
				arg_135_1.var_.characterEffect404001ui_story = var_138_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_20 = 0.200000002980232

			if var_138_19 <= arg_135_1.time_ and arg_135_1.time_ < var_138_19 + var_138_20 and not isNil(var_138_18) then
				local var_138_21 = (arg_135_1.time_ - var_138_19) / var_138_20

				if arg_135_1.var_.characterEffect404001ui_story and not isNil(var_138_18) then
					arg_135_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_19 + var_138_20 and arg_135_1.time_ < var_138_19 + var_138_20 + arg_138_0 and not isNil(var_138_18) and arg_135_1.var_.characterEffect404001ui_story then
				arg_135_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_138_22 = 0

			if var_138_22 < arg_135_1.time_ and arg_135_1.time_ <= var_138_22 + arg_138_0 then
				arg_135_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_138_23 = 0

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 then
				arg_135_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_138_24 = 0
			local var_138_25 = 0.9

			if var_138_24 < arg_135_1.time_ and arg_135_1.time_ <= var_138_24 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_26 = arg_135_1:FormatText(StoryNameCfg[668].name)

				arg_135_1.leftNameTxt_.text = var_138_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_27 = arg_135_1:GetWordFromCfg(322012031)
				local var_138_28 = arg_135_1:FormatText(var_138_27.content)

				arg_135_1.text_.text = var_138_28

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_29 = 36
				local var_138_30 = utf8.len(var_138_28)
				local var_138_31 = var_138_29 <= 0 and var_138_25 or var_138_25 * (var_138_30 / var_138_29)

				if var_138_31 > 0 and var_138_25 < var_138_31 then
					arg_135_1.talkMaxDuration = var_138_31

					if var_138_31 + var_138_24 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_31 + var_138_24
					end
				end

				arg_135_1.text_.text = var_138_28
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012031", "story_v_out_322012.awb") ~= 0 then
					local var_138_32 = manager.audio:GetVoiceLength("story_v_out_322012", "322012031", "story_v_out_322012.awb") / 1000

					if var_138_32 + var_138_24 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_32 + var_138_24
					end

					if var_138_27.prefab_name ~= "" and arg_135_1.actors_[var_138_27.prefab_name] ~= nil then
						local var_138_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_27.prefab_name].transform, "story_v_out_322012", "322012031", "story_v_out_322012.awb")

						arg_135_1:RecordAudio("322012031", var_138_33)
						arg_135_1:RecordAudio("322012031", var_138_33)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_322012", "322012031", "story_v_out_322012.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_322012", "322012031", "story_v_out_322012.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_34 = math.max(var_138_25, arg_135_1.talkMaxDuration)

			if var_138_24 <= arg_135_1.time_ and arg_135_1.time_ < var_138_24 + var_138_34 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_24) / var_138_34

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_24 + var_138_34 and arg_135_1.time_ < var_138_24 + var_138_34 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play322012032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 322012032
		arg_139_1.duration_ = 1.27

		local var_139_0 = {
			zh = 1,
			ja = 1.266
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play322012033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["404001ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect404001ui_story == nil then
				arg_139_1.var_.characterEffect404001ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect404001ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_139_1.var_.characterEffect404001ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect404001ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_139_1.var_.characterEffect404001ui_story.fillRatio = var_142_5
			end

			local var_142_6 = 0
			local var_142_7 = 0.200000002980232

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_8 = arg_139_1:FormatText(StoryNameCfg[1184].name)

				arg_139_1.leftNameTxt_.text = var_142_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_9 = arg_139_1:GetWordFromCfg(322012032)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 3
				local var_142_12 = utf8.len(var_142_10)
				local var_142_13 = var_142_11 <= 0 and var_142_7 or var_142_7 * (var_142_12 / var_142_11)

				if var_142_13 > 0 and var_142_7 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_10
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012032", "story_v_out_322012.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_322012", "322012032", "story_v_out_322012.awb") / 1000

					if var_142_14 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_6
					end

					if var_142_9.prefab_name ~= "" and arg_139_1.actors_[var_142_9.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_9.prefab_name].transform, "story_v_out_322012", "322012032", "story_v_out_322012.awb")

						arg_139_1:RecordAudio("322012032", var_142_15)
						arg_139_1:RecordAudio("322012032", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_322012", "322012032", "story_v_out_322012.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_322012", "322012032", "story_v_out_322012.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_16 and arg_139_1.time_ < var_142_6 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play322012033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 322012033
		arg_143_1.duration_ = 2.3

		local var_143_0 = {
			zh = 2.3,
			ja = 2.2
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
				arg_143_0:Play322012034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["404001ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect404001ui_story == nil then
				arg_143_1.var_.characterEffect404001ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect404001ui_story and not isNil(var_146_0) then
					arg_143_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect404001ui_story then
				arg_143_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_146_4 = 0

			if var_146_4 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_146_5 = 0

			if var_146_5 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_146_6 = 0
			local var_146_7 = 0.225

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_8 = arg_143_1:FormatText(StoryNameCfg[668].name)

				arg_143_1.leftNameTxt_.text = var_146_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_9 = arg_143_1:GetWordFromCfg(322012033)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 9
				local var_146_12 = utf8.len(var_146_10)
				local var_146_13 = var_146_11 <= 0 and var_146_7 or var_146_7 * (var_146_12 / var_146_11)

				if var_146_13 > 0 and var_146_7 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_10
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012033", "story_v_out_322012.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_322012", "322012033", "story_v_out_322012.awb") / 1000

					if var_146_14 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_6
					end

					if var_146_9.prefab_name ~= "" and arg_143_1.actors_[var_146_9.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_9.prefab_name].transform, "story_v_out_322012", "322012033", "story_v_out_322012.awb")

						arg_143_1:RecordAudio("322012033", var_146_15)
						arg_143_1:RecordAudio("322012033", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_322012", "322012033", "story_v_out_322012.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_322012", "322012033", "story_v_out_322012.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_16 and arg_143_1.time_ < var_146_6 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play322012034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 322012034
		arg_147_1.duration_ = 3.57

		local var_147_0 = {
			zh = 3.1,
			ja = 3.566
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
				arg_147_0:Play322012035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1085ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1085ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0.75, -1.01, -5.83)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1085ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["1043ui_story"].transform
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 then
				arg_147_1.var_.moveOldPos1043ui_story = var_150_9.localPosition
			end

			local var_150_11 = 0.001

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11
				local var_150_13 = Vector3.New(-0.92, -1.01, -5.73)

				var_150_9.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1043ui_story, var_150_13, var_150_12)

				local var_150_14 = manager.ui.mainCamera.transform.position - var_150_9.position

				var_150_9.forward = Vector3.New(var_150_14.x, var_150_14.y, var_150_14.z)

				local var_150_15 = var_150_9.localEulerAngles

				var_150_15.z = 0
				var_150_15.x = 0
				var_150_9.localEulerAngles = var_150_15
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 then
				var_150_9.localPosition = Vector3.New(-0.92, -1.01, -5.73)

				local var_150_16 = manager.ui.mainCamera.transform.position - var_150_9.position

				var_150_9.forward = Vector3.New(var_150_16.x, var_150_16.y, var_150_16.z)

				local var_150_17 = var_150_9.localEulerAngles

				var_150_17.z = 0
				var_150_17.x = 0
				var_150_9.localEulerAngles = var_150_17
			end

			local var_150_18 = arg_147_1.actors_["1085ui_story"]
			local var_150_19 = 0

			if var_150_19 < arg_147_1.time_ and arg_147_1.time_ <= var_150_19 + arg_150_0 and not isNil(var_150_18) and arg_147_1.var_.characterEffect1085ui_story == nil then
				arg_147_1.var_.characterEffect1085ui_story = var_150_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_20 = 0.200000002980232

			if var_150_19 <= arg_147_1.time_ and arg_147_1.time_ < var_150_19 + var_150_20 and not isNil(var_150_18) then
				local var_150_21 = (arg_147_1.time_ - var_150_19) / var_150_20

				if arg_147_1.var_.characterEffect1085ui_story and not isNil(var_150_18) then
					arg_147_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_19 + var_150_20 and arg_147_1.time_ < var_150_19 + var_150_20 + arg_150_0 and not isNil(var_150_18) and arg_147_1.var_.characterEffect1085ui_story then
				arg_147_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_150_22 = arg_147_1.actors_["404001ui_story"]
			local var_150_23 = 0

			if var_150_23 < arg_147_1.time_ and arg_147_1.time_ <= var_150_23 + arg_150_0 and not isNil(var_150_22) and arg_147_1.var_.characterEffect404001ui_story == nil then
				arg_147_1.var_.characterEffect404001ui_story = var_150_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_24 = 0.200000002980232

			if var_150_23 <= arg_147_1.time_ and arg_147_1.time_ < var_150_23 + var_150_24 and not isNil(var_150_22) then
				local var_150_25 = (arg_147_1.time_ - var_150_23) / var_150_24

				if arg_147_1.var_.characterEffect404001ui_story and not isNil(var_150_22) then
					local var_150_26 = Mathf.Lerp(0, 0.5, var_150_25)

					arg_147_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_147_1.var_.characterEffect404001ui_story.fillRatio = var_150_26
				end
			end

			if arg_147_1.time_ >= var_150_23 + var_150_24 and arg_147_1.time_ < var_150_23 + var_150_24 + arg_150_0 and not isNil(var_150_22) and arg_147_1.var_.characterEffect404001ui_story then
				local var_150_27 = 0.5

				arg_147_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_147_1.var_.characterEffect404001ui_story.fillRatio = var_150_27
			end

			local var_150_28 = 0

			if var_150_28 < arg_147_1.time_ and arg_147_1.time_ <= var_150_28 + arg_150_0 then
				arg_147_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_150_29 = 0

			if var_150_29 < arg_147_1.time_ and arg_147_1.time_ <= var_150_29 + arg_150_0 then
				arg_147_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_150_30 = arg_147_1.actors_["404001ui_story"].transform
			local var_150_31 = 0

			if var_150_31 < arg_147_1.time_ and arg_147_1.time_ <= var_150_31 + arg_150_0 then
				arg_147_1.var_.moveOldPos404001ui_story = var_150_30.localPosition
			end

			local var_150_32 = 0.001

			if var_150_31 <= arg_147_1.time_ and arg_147_1.time_ < var_150_31 + var_150_32 then
				local var_150_33 = (arg_147_1.time_ - var_150_31) / var_150_32
				local var_150_34 = Vector3.New(0, 100, 0)

				var_150_30.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos404001ui_story, var_150_34, var_150_33)

				local var_150_35 = manager.ui.mainCamera.transform.position - var_150_30.position

				var_150_30.forward = Vector3.New(var_150_35.x, var_150_35.y, var_150_35.z)

				local var_150_36 = var_150_30.localEulerAngles

				var_150_36.z = 0
				var_150_36.x = 0
				var_150_30.localEulerAngles = var_150_36
			end

			if arg_147_1.time_ >= var_150_31 + var_150_32 and arg_147_1.time_ < var_150_31 + var_150_32 + arg_150_0 then
				var_150_30.localPosition = Vector3.New(0, 100, 0)

				local var_150_37 = manager.ui.mainCamera.transform.position - var_150_30.position

				var_150_30.forward = Vector3.New(var_150_37.x, var_150_37.y, var_150_37.z)

				local var_150_38 = var_150_30.localEulerAngles

				var_150_38.z = 0
				var_150_38.x = 0
				var_150_30.localEulerAngles = var_150_38
			end

			local var_150_39 = 0
			local var_150_40 = 0.25

			if var_150_39 < arg_147_1.time_ and arg_147_1.time_ <= var_150_39 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_41 = arg_147_1:FormatText(StoryNameCfg[328].name)

				arg_147_1.leftNameTxt_.text = var_150_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_42 = arg_147_1:GetWordFromCfg(322012034)
				local var_150_43 = arg_147_1:FormatText(var_150_42.content)

				arg_147_1.text_.text = var_150_43

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_44 = 10
				local var_150_45 = utf8.len(var_150_43)
				local var_150_46 = var_150_44 <= 0 and var_150_40 or var_150_40 * (var_150_45 / var_150_44)

				if var_150_46 > 0 and var_150_40 < var_150_46 then
					arg_147_1.talkMaxDuration = var_150_46

					if var_150_46 + var_150_39 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_46 + var_150_39
					end
				end

				arg_147_1.text_.text = var_150_43
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012034", "story_v_out_322012.awb") ~= 0 then
					local var_150_47 = manager.audio:GetVoiceLength("story_v_out_322012", "322012034", "story_v_out_322012.awb") / 1000

					if var_150_47 + var_150_39 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_47 + var_150_39
					end

					if var_150_42.prefab_name ~= "" and arg_147_1.actors_[var_150_42.prefab_name] ~= nil then
						local var_150_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_42.prefab_name].transform, "story_v_out_322012", "322012034", "story_v_out_322012.awb")

						arg_147_1:RecordAudio("322012034", var_150_48)
						arg_147_1:RecordAudio("322012034", var_150_48)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_322012", "322012034", "story_v_out_322012.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_322012", "322012034", "story_v_out_322012.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_49 = math.max(var_150_40, arg_147_1.talkMaxDuration)

			if var_150_39 <= arg_147_1.time_ and arg_147_1.time_ < var_150_39 + var_150_49 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_39) / var_150_49

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_39 + var_150_49 and arg_147_1.time_ < var_150_39 + var_150_49 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_147_1:InitPlayNodeList()
	end,
	Play322012035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 322012035
		arg_151_1.duration_ = 1.17

		local var_151_0 = {
			zh = 0.999999999999,
			ja = 1.166
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play322012036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1085ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1085ui_story == nil then
				arg_151_1.var_.characterEffect1085ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1085ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1085ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1085ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1085ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.05

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[1184].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(322012035)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012035", "story_v_out_322012.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_322012", "322012035", "story_v_out_322012.awb") / 1000

					if var_154_14 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_6
					end

					if var_154_9.prefab_name ~= "" and arg_151_1.actors_[var_154_9.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_9.prefab_name].transform, "story_v_out_322012", "322012035", "story_v_out_322012.awb")

						arg_151_1:RecordAudio("322012035", var_154_15)
						arg_151_1:RecordAudio("322012035", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_322012", "322012035", "story_v_out_322012.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_322012", "322012035", "story_v_out_322012.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_16 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_16 and arg_151_1.time_ < var_154_6 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play322012036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 322012036
		arg_155_1.duration_ = 5.87

		local var_155_0 = {
			zh = 3.4,
			ja = 5.866
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
				arg_155_0:Play322012037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1043ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1043ui_story == nil then
				arg_155_1.var_.characterEffect1043ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1043ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1043ui_story then
				arg_155_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_158_4 = 0

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			local var_158_5 = 0

			if var_158_5 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_158_6 = 0
			local var_158_7 = 0.375

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_8 = arg_155_1:FormatText(StoryNameCfg[1156].name)

				arg_155_1.leftNameTxt_.text = var_158_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_9 = arg_155_1:GetWordFromCfg(322012036)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 15
				local var_158_12 = utf8.len(var_158_10)
				local var_158_13 = var_158_11 <= 0 and var_158_7 or var_158_7 * (var_158_12 / var_158_11)

				if var_158_13 > 0 and var_158_7 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012036", "story_v_out_322012.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_out_322012", "322012036", "story_v_out_322012.awb") / 1000

					if var_158_14 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_6
					end

					if var_158_9.prefab_name ~= "" and arg_155_1.actors_[var_158_9.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_9.prefab_name].transform, "story_v_out_322012", "322012036", "story_v_out_322012.awb")

						arg_155_1:RecordAudio("322012036", var_158_15)
						arg_155_1:RecordAudio("322012036", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_322012", "322012036", "story_v_out_322012.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_322012", "322012036", "story_v_out_322012.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_16 and arg_155_1.time_ < var_158_6 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play322012037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 322012037
		arg_159_1.duration_ = 8.8

		local var_159_0 = {
			zh = 8.8,
			ja = 7.866
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
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play322012038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			local var_162_1 = 0
			local var_162_2 = 0.3

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				local var_162_3 = "play"
				local var_162_4 = "music"

				arg_159_1:AudioAction(var_162_3, var_162_4, "ui_battle", "ui_battle_stopbgm", "")

				local var_162_5 = ""
				local var_162_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_162_6 ~= "" then
					if arg_159_1.bgmTxt_.text ~= var_162_6 and arg_159_1.bgmTxt_.text ~= "" then
						if arg_159_1.bgmTxt2_.text ~= "" then
							arg_159_1.bgmTxt_.text = arg_159_1.bgmTxt2_.text
						end

						arg_159_1.bgmTxt2_.text = var_162_6

						arg_159_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_159_1.bgmTxt_.text = var_162_6
						arg_159_1.bgmTxt2_.text = var_162_6
					end

					if arg_159_1.bgmTimer then
						arg_159_1.bgmTimer:Stop()

						arg_159_1.bgmTimer = nil
					end

					if arg_159_1.settingData.show_music_name == 1 then
						arg_159_1.musicController:SetSelectedState("show")
						arg_159_1.musicAnimator_:Play("open", 0, 0)

						if arg_159_1.settingData.music_time ~= 0 then
							arg_159_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_159_1.settingData.music_time), function()
								if arg_159_1 == nil or isNil(arg_159_1.bgmTxt_) then
									return
								end

								arg_159_1.musicController:SetSelectedState("hide")
								arg_159_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_162_7 = 0
			local var_162_8 = 1.025

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_9 = arg_159_1:FormatText(StoryNameCfg[1156].name)

				arg_159_1.leftNameTxt_.text = var_162_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(322012037)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_12 = 41
				local var_162_13 = utf8.len(var_162_11)
				local var_162_14 = var_162_12 <= 0 and var_162_8 or var_162_8 * (var_162_13 / var_162_12)

				if var_162_14 > 0 and var_162_8 < var_162_14 then
					arg_159_1.talkMaxDuration = var_162_14

					if var_162_14 + var_162_7 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_7
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012037", "story_v_out_322012.awb") ~= 0 then
					local var_162_15 = manager.audio:GetVoiceLength("story_v_out_322012", "322012037", "story_v_out_322012.awb") / 1000

					if var_162_15 + var_162_7 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_15 + var_162_7
					end

					if var_162_10.prefab_name ~= "" and arg_159_1.actors_[var_162_10.prefab_name] ~= nil then
						local var_162_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_10.prefab_name].transform, "story_v_out_322012", "322012037", "story_v_out_322012.awb")

						arg_159_1:RecordAudio("322012037", var_162_16)
						arg_159_1:RecordAudio("322012037", var_162_16)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_322012", "322012037", "story_v_out_322012.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_322012", "322012037", "story_v_out_322012.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_17 = math.max(var_162_8, arg_159_1.talkMaxDuration)

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_17 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_7) / var_162_17

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_7 + var_162_17 and arg_159_1.time_ < var_162_7 + var_162_17 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play322012038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 322012038
		arg_164_1.duration_ = 6.9

		local var_164_0 = {
			zh = 6.9,
			ja = 6.866
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play322012039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 2

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				local var_167_1 = manager.ui.mainCamera.transform.localPosition
				local var_167_2 = Vector3.New(0, 0, 10) + Vector3.New(var_167_1.x, var_167_1.y, 0)
				local var_167_3 = arg_164_1.bgs_.ST73a

				var_167_3.transform.localPosition = var_167_2
				var_167_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_4 = var_167_3:GetComponent("SpriteRenderer")

				if var_167_4 and var_167_4.sprite then
					local var_167_5 = (var_167_3.transform.localPosition - var_167_1).z
					local var_167_6 = manager.ui.mainCameraCom_
					local var_167_7 = 2 * var_167_5 * Mathf.Tan(var_167_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_167_8 = var_167_7 * var_167_6.aspect
					local var_167_9 = var_167_4.sprite.bounds.size.x
					local var_167_10 = var_167_4.sprite.bounds.size.y
					local var_167_11 = var_167_8 / var_167_9
					local var_167_12 = var_167_7 / var_167_10
					local var_167_13 = var_167_12 < var_167_11 and var_167_11 or var_167_12

					var_167_3.transform.localScale = Vector3.New(var_167_13, var_167_13, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "ST73a" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_167_14 = 4

			if var_167_14 < arg_164_1.time_ and arg_164_1.time_ <= var_167_14 + arg_167_0 then
				arg_164_1.allBtn_.enabled = false
			end

			local var_167_15 = 0.3

			if arg_164_1.time_ >= var_167_14 + var_167_15 and arg_164_1.time_ < var_167_14 + var_167_15 + arg_167_0 then
				arg_164_1.allBtn_.enabled = true
			end

			local var_167_16 = 0

			if var_167_16 < arg_164_1.time_ and arg_164_1.time_ <= var_167_16 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_17 = 2

			if var_167_16 <= arg_164_1.time_ and arg_164_1.time_ < var_167_16 + var_167_17 then
				local var_167_18 = (arg_164_1.time_ - var_167_16) / var_167_17
				local var_167_19 = Color.New(0, 0, 0)

				var_167_19.a = Mathf.Lerp(0, 1, var_167_18)
				arg_164_1.mask_.color = var_167_19
			end

			if arg_164_1.time_ >= var_167_16 + var_167_17 and arg_164_1.time_ < var_167_16 + var_167_17 + arg_167_0 then
				local var_167_20 = Color.New(0, 0, 0)

				var_167_20.a = 1
				arg_164_1.mask_.color = var_167_20
			end

			local var_167_21 = 2

			if var_167_21 < arg_164_1.time_ and arg_164_1.time_ <= var_167_21 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_22 = 2

			if var_167_21 <= arg_164_1.time_ and arg_164_1.time_ < var_167_21 + var_167_22 then
				local var_167_23 = (arg_164_1.time_ - var_167_21) / var_167_22
				local var_167_24 = Color.New(0, 0, 0)

				var_167_24.a = Mathf.Lerp(1, 0, var_167_23)
				arg_164_1.mask_.color = var_167_24
			end

			if arg_164_1.time_ >= var_167_21 + var_167_22 and arg_164_1.time_ < var_167_21 + var_167_22 + arg_167_0 then
				local var_167_25 = Color.New(0, 0, 0)
				local var_167_26 = 0

				arg_164_1.mask_.enabled = false
				var_167_25.a = var_167_26
				arg_164_1.mask_.color = var_167_25
			end

			local var_167_27 = arg_164_1.actors_["1061ui_story"].transform
			local var_167_28 = 3.8

			if var_167_28 < arg_164_1.time_ and arg_164_1.time_ <= var_167_28 + arg_167_0 then
				arg_164_1.var_.moveOldPos1061ui_story = var_167_27.localPosition
			end

			local var_167_29 = 0.001

			if var_167_28 <= arg_164_1.time_ and arg_164_1.time_ < var_167_28 + var_167_29 then
				local var_167_30 = (arg_164_1.time_ - var_167_28) / var_167_29
				local var_167_31 = Vector3.New(0, -1.18, -6.15)

				var_167_27.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1061ui_story, var_167_31, var_167_30)

				local var_167_32 = manager.ui.mainCamera.transform.position - var_167_27.position

				var_167_27.forward = Vector3.New(var_167_32.x, var_167_32.y, var_167_32.z)

				local var_167_33 = var_167_27.localEulerAngles

				var_167_33.z = 0
				var_167_33.x = 0
				var_167_27.localEulerAngles = var_167_33
			end

			if arg_164_1.time_ >= var_167_28 + var_167_29 and arg_164_1.time_ < var_167_28 + var_167_29 + arg_167_0 then
				var_167_27.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_167_34 = manager.ui.mainCamera.transform.position - var_167_27.position

				var_167_27.forward = Vector3.New(var_167_34.x, var_167_34.y, var_167_34.z)

				local var_167_35 = var_167_27.localEulerAngles

				var_167_35.z = 0
				var_167_35.x = 0
				var_167_27.localEulerAngles = var_167_35
			end

			local var_167_36 = arg_164_1.actors_["1043ui_story"].transform
			local var_167_37 = 1.96599999815226

			if var_167_37 < arg_164_1.time_ and arg_164_1.time_ <= var_167_37 + arg_167_0 then
				arg_164_1.var_.moveOldPos1043ui_story = var_167_36.localPosition
			end

			local var_167_38 = 0.001

			if var_167_37 <= arg_164_1.time_ and arg_164_1.time_ < var_167_37 + var_167_38 then
				local var_167_39 = (arg_164_1.time_ - var_167_37) / var_167_38
				local var_167_40 = Vector3.New(0, 100, 0)

				var_167_36.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1043ui_story, var_167_40, var_167_39)

				local var_167_41 = manager.ui.mainCamera.transform.position - var_167_36.position

				var_167_36.forward = Vector3.New(var_167_41.x, var_167_41.y, var_167_41.z)

				local var_167_42 = var_167_36.localEulerAngles

				var_167_42.z = 0
				var_167_42.x = 0
				var_167_36.localEulerAngles = var_167_42
			end

			if arg_164_1.time_ >= var_167_37 + var_167_38 and arg_164_1.time_ < var_167_37 + var_167_38 + arg_167_0 then
				var_167_36.localPosition = Vector3.New(0, 100, 0)

				local var_167_43 = manager.ui.mainCamera.transform.position - var_167_36.position

				var_167_36.forward = Vector3.New(var_167_43.x, var_167_43.y, var_167_43.z)

				local var_167_44 = var_167_36.localEulerAngles

				var_167_44.z = 0
				var_167_44.x = 0
				var_167_36.localEulerAngles = var_167_44
			end

			local var_167_45 = arg_164_1.actors_["1085ui_story"].transform
			local var_167_46 = 1.96599999815226

			if var_167_46 < arg_164_1.time_ and arg_164_1.time_ <= var_167_46 + arg_167_0 then
				arg_164_1.var_.moveOldPos1085ui_story = var_167_45.localPosition
			end

			local var_167_47 = 0.001

			if var_167_46 <= arg_164_1.time_ and arg_164_1.time_ < var_167_46 + var_167_47 then
				local var_167_48 = (arg_164_1.time_ - var_167_46) / var_167_47
				local var_167_49 = Vector3.New(0, 100, 0)

				var_167_45.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1085ui_story, var_167_49, var_167_48)

				local var_167_50 = manager.ui.mainCamera.transform.position - var_167_45.position

				var_167_45.forward = Vector3.New(var_167_50.x, var_167_50.y, var_167_50.z)

				local var_167_51 = var_167_45.localEulerAngles

				var_167_51.z = 0
				var_167_51.x = 0
				var_167_45.localEulerAngles = var_167_51
			end

			if arg_164_1.time_ >= var_167_46 + var_167_47 and arg_164_1.time_ < var_167_46 + var_167_47 + arg_167_0 then
				var_167_45.localPosition = Vector3.New(0, 100, 0)

				local var_167_52 = manager.ui.mainCamera.transform.position - var_167_45.position

				var_167_45.forward = Vector3.New(var_167_52.x, var_167_52.y, var_167_52.z)

				local var_167_53 = var_167_45.localEulerAngles

				var_167_53.z = 0
				var_167_53.x = 0
				var_167_45.localEulerAngles = var_167_53
			end

			local var_167_54 = arg_164_1.actors_["1061ui_story"]
			local var_167_55 = 3.8

			if var_167_55 < arg_164_1.time_ and arg_164_1.time_ <= var_167_55 + arg_167_0 and not isNil(var_167_54) and arg_164_1.var_.characterEffect1061ui_story == nil then
				arg_164_1.var_.characterEffect1061ui_story = var_167_54:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_56 = 0.200000002980232

			if var_167_55 <= arg_164_1.time_ and arg_164_1.time_ < var_167_55 + var_167_56 and not isNil(var_167_54) then
				local var_167_57 = (arg_164_1.time_ - var_167_55) / var_167_56

				if arg_164_1.var_.characterEffect1061ui_story and not isNil(var_167_54) then
					arg_164_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_55 + var_167_56 and arg_164_1.time_ < var_167_55 + var_167_56 + arg_167_0 and not isNil(var_167_54) and arg_164_1.var_.characterEffect1061ui_story then
				arg_164_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_167_58 = 3.8

			if var_167_58 < arg_164_1.time_ and arg_164_1.time_ <= var_167_58 + arg_167_0 then
				arg_164_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_167_59 = 3.8

			if var_167_59 < arg_164_1.time_ and arg_164_1.time_ <= var_167_59 + arg_167_0 then
				arg_164_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_167_60 = 0
			local var_167_61 = 0.3

			if var_167_60 < arg_164_1.time_ and arg_164_1.time_ <= var_167_60 + arg_167_0 then
				local var_167_62 = "play"
				local var_167_63 = "music"

				arg_164_1:AudioAction(var_167_62, var_167_63, "ui_battle", "ui_battle_stopbgm", "")

				local var_167_64 = ""
				local var_167_65 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_167_65 ~= "" then
					if arg_164_1.bgmTxt_.text ~= var_167_65 and arg_164_1.bgmTxt_.text ~= "" then
						if arg_164_1.bgmTxt2_.text ~= "" then
							arg_164_1.bgmTxt_.text = arg_164_1.bgmTxt2_.text
						end

						arg_164_1.bgmTxt2_.text = var_167_65

						arg_164_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_164_1.bgmTxt_.text = var_167_65
						arg_164_1.bgmTxt2_.text = var_167_65
					end

					if arg_164_1.bgmTimer then
						arg_164_1.bgmTimer:Stop()

						arg_164_1.bgmTimer = nil
					end

					if arg_164_1.settingData.show_music_name == 1 then
						arg_164_1.musicController:SetSelectedState("show")
						arg_164_1.musicAnimator_:Play("open", 0, 0)

						if arg_164_1.settingData.music_time ~= 0 then
							arg_164_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_164_1.settingData.music_time), function()
								if arg_164_1 == nil or isNil(arg_164_1.bgmTxt_) then
									return
								end

								arg_164_1.musicController:SetSelectedState("hide")
								arg_164_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_167_66 = 0.433333333333333
			local var_167_67 = 1

			if var_167_66 < arg_164_1.time_ and arg_164_1.time_ <= var_167_66 + arg_167_0 then
				local var_167_68 = "play"
				local var_167_69 = "music"

				arg_164_1:AudioAction(var_167_68, var_167_69, "bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference.awb")

				local var_167_70 = ""
				local var_167_71 = manager.audio:GetAudioName("bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference")

				if var_167_71 ~= "" then
					if arg_164_1.bgmTxt_.text ~= var_167_71 and arg_164_1.bgmTxt_.text ~= "" then
						if arg_164_1.bgmTxt2_.text ~= "" then
							arg_164_1.bgmTxt_.text = arg_164_1.bgmTxt2_.text
						end

						arg_164_1.bgmTxt2_.text = var_167_71

						arg_164_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_164_1.bgmTxt_.text = var_167_71
						arg_164_1.bgmTxt2_.text = var_167_71
					end

					if arg_164_1.bgmTimer then
						arg_164_1.bgmTimer:Stop()

						arg_164_1.bgmTimer = nil
					end

					if arg_164_1.settingData.show_music_name == 1 then
						arg_164_1.musicController:SetSelectedState("show")
						arg_164_1.musicAnimator_:Play("open", 0, 0)

						if arg_164_1.settingData.music_time ~= 0 then
							arg_164_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_164_1.settingData.music_time), function()
								if arg_164_1 == nil or isNil(arg_164_1.bgmTxt_) then
									return
								end

								arg_164_1.musicController:SetSelectedState("hide")
								arg_164_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_167_72 = 0.1
			local var_167_73 = 1

			if var_167_72 < arg_164_1.time_ and arg_164_1.time_ <= var_167_72 + arg_167_0 then
				local var_167_74 = "stop"
				local var_167_75 = "effect"

				arg_164_1:AudioAction(var_167_74, var_167_75, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_167_76 = 1.56666666666667
			local var_167_77 = 1

			if var_167_76 < arg_164_1.time_ and arg_164_1.time_ <= var_167_76 + arg_167_0 then
				local var_167_78 = "play"
				local var_167_79 = "effect"

				arg_164_1:AudioAction(var_167_78, var_167_79, "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_80 = 4
			local var_167_81 = 0.275

			if var_167_80 < arg_164_1.time_ and arg_164_1.time_ <= var_167_80 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_82 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_82:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_164_1.dialogCg_.alpha = arg_170_0
				end))
				var_167_82:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_82:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_83 = arg_164_1:FormatText(StoryNameCfg[612].name)

				arg_164_1.leftNameTxt_.text = var_167_83

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_84 = arg_164_1:GetWordFromCfg(322012038)
				local var_167_85 = arg_164_1:FormatText(var_167_84.content)

				arg_164_1.text_.text = var_167_85

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_86 = 11
				local var_167_87 = utf8.len(var_167_85)
				local var_167_88 = var_167_86 <= 0 and var_167_81 or var_167_81 * (var_167_87 / var_167_86)

				if var_167_88 > 0 and var_167_81 < var_167_88 then
					arg_164_1.talkMaxDuration = var_167_88
					var_167_80 = var_167_80 + 0.3

					if var_167_88 + var_167_80 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_88 + var_167_80
					end
				end

				arg_164_1.text_.text = var_167_85
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012038", "story_v_out_322012.awb") ~= 0 then
					local var_167_89 = manager.audio:GetVoiceLength("story_v_out_322012", "322012038", "story_v_out_322012.awb") / 1000

					if var_167_89 + var_167_80 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_89 + var_167_80
					end

					if var_167_84.prefab_name ~= "" and arg_164_1.actors_[var_167_84.prefab_name] ~= nil then
						local var_167_90 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_84.prefab_name].transform, "story_v_out_322012", "322012038", "story_v_out_322012.awb")

						arg_164_1:RecordAudio("322012038", var_167_90)
						arg_164_1:RecordAudio("322012038", var_167_90)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_322012", "322012038", "story_v_out_322012.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_322012", "322012038", "story_v_out_322012.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_91 = var_167_80 + 0.3
			local var_167_92 = math.max(var_167_81, arg_164_1.talkMaxDuration)

			if var_167_91 <= arg_164_1.time_ and arg_164_1.time_ < var_167_91 + var_167_92 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_91) / var_167_92

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_91 + var_167_92 and arg_164_1.time_ < var_167_91 + var_167_92 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play322012039 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 322012039
		arg_172_1.duration_ = 14.83

		local var_172_0 = {
			zh = 9.466,
			ja = 14.833
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
				arg_172_0:Play322012040(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 1.2

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[612].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_3 = arg_172_1:GetWordFromCfg(322012039)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012039", "story_v_out_322012.awb") ~= 0 then
					local var_175_8 = manager.audio:GetVoiceLength("story_v_out_322012", "322012039", "story_v_out_322012.awb") / 1000

					if var_175_8 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_0
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_out_322012", "322012039", "story_v_out_322012.awb")

						arg_172_1:RecordAudio("322012039", var_175_9)
						arg_172_1:RecordAudio("322012039", var_175_9)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_322012", "322012039", "story_v_out_322012.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_322012", "322012039", "story_v_out_322012.awb")
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
	Play322012040 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 322012040
		arg_176_1.duration_ = 16.4

		local var_176_0 = {
			zh = 11.433,
			ja = 16.4
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
				arg_176_0:Play322012041(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1061ui_story"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos1061ui_story = var_179_0.localPosition
			end

			local var_179_2 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2
				local var_179_4 = Vector3.New(0, -1.18, -6.15)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1061ui_story, var_179_4, var_179_3)

				local var_179_5 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_5.x, var_179_5.y, var_179_5.z)

				local var_179_6 = var_179_0.localEulerAngles

				var_179_6.z = 0
				var_179_6.x = 0
				var_179_0.localEulerAngles = var_179_6
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_179_7 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_7.x, var_179_7.y, var_179_7.z)

				local var_179_8 = var_179_0.localEulerAngles

				var_179_8.z = 0
				var_179_8.x = 0
				var_179_0.localEulerAngles = var_179_8
			end

			local var_179_9 = 0

			if var_179_9 < arg_176_1.time_ and arg_176_1.time_ <= var_179_9 + arg_179_0 then
				arg_176_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_179_10 = 0

			if var_179_10 < arg_176_1.time_ and arg_176_1.time_ <= var_179_10 + arg_179_0 then
				arg_176_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_179_11 = 0
			local var_179_12 = 1.325

			if var_179_11 < arg_176_1.time_ and arg_176_1.time_ <= var_179_11 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_13 = arg_176_1:FormatText(StoryNameCfg[612].name)

				arg_176_1.leftNameTxt_.text = var_179_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_14 = arg_176_1:GetWordFromCfg(322012040)
				local var_179_15 = arg_176_1:FormatText(var_179_14.content)

				arg_176_1.text_.text = var_179_15

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_16 = 53
				local var_179_17 = utf8.len(var_179_15)
				local var_179_18 = var_179_16 <= 0 and var_179_12 or var_179_12 * (var_179_17 / var_179_16)

				if var_179_18 > 0 and var_179_12 < var_179_18 then
					arg_176_1.talkMaxDuration = var_179_18

					if var_179_18 + var_179_11 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_18 + var_179_11
					end
				end

				arg_176_1.text_.text = var_179_15
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012040", "story_v_out_322012.awb") ~= 0 then
					local var_179_19 = manager.audio:GetVoiceLength("story_v_out_322012", "322012040", "story_v_out_322012.awb") / 1000

					if var_179_19 + var_179_11 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_19 + var_179_11
					end

					if var_179_14.prefab_name ~= "" and arg_176_1.actors_[var_179_14.prefab_name] ~= nil then
						local var_179_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_14.prefab_name].transform, "story_v_out_322012", "322012040", "story_v_out_322012.awb")

						arg_176_1:RecordAudio("322012040", var_179_20)
						arg_176_1:RecordAudio("322012040", var_179_20)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_322012", "322012040", "story_v_out_322012.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_322012", "322012040", "story_v_out_322012.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_21 = math.max(var_179_12, arg_176_1.talkMaxDuration)

			if var_179_11 <= arg_176_1.time_ and arg_176_1.time_ < var_179_11 + var_179_21 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_11) / var_179_21

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_11 + var_179_21 and arg_176_1.time_ < var_179_11 + var_179_21 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play322012041 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 322012041
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play322012042(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1061ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1061ui_story == nil then
				arg_180_1.var_.characterEffect1061ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1061ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1061ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1061ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1061ui_story.fillRatio = var_183_5
			end

			local var_183_6 = 0
			local var_183_7 = 1.075

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_8 = arg_180_1:GetWordFromCfg(322012041)
				local var_183_9 = arg_180_1:FormatText(var_183_8.content)

				arg_180_1.text_.text = var_183_9

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_10 = 43
				local var_183_11 = utf8.len(var_183_9)
				local var_183_12 = var_183_10 <= 0 and var_183_7 or var_183_7 * (var_183_11 / var_183_10)

				if var_183_12 > 0 and var_183_7 < var_183_12 then
					arg_180_1.talkMaxDuration = var_183_12

					if var_183_12 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_12 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_9
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_13 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_13 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_13

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_13 and arg_180_1.time_ < var_183_6 + var_183_13 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play322012042 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 322012042
		arg_184_1.duration_ = 10.57

		local var_184_0 = {
			zh = 9.8,
			ja = 10.566
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
				arg_184_0:Play322012043(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1061ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1061ui_story == nil then
				arg_184_1.var_.characterEffect1061ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1061ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1061ui_story then
				arg_184_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_187_4 = 0
			local var_187_5 = 0.8

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_6 = arg_184_1:FormatText(StoryNameCfg[612].name)

				arg_184_1.leftNameTxt_.text = var_187_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_7 = arg_184_1:GetWordFromCfg(322012042)
				local var_187_8 = arg_184_1:FormatText(var_187_7.content)

				arg_184_1.text_.text = var_187_8

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_9 = 32
				local var_187_10 = utf8.len(var_187_8)
				local var_187_11 = var_187_9 <= 0 and var_187_5 or var_187_5 * (var_187_10 / var_187_9)

				if var_187_11 > 0 and var_187_5 < var_187_11 then
					arg_184_1.talkMaxDuration = var_187_11

					if var_187_11 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_11 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_8
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012042", "story_v_out_322012.awb") ~= 0 then
					local var_187_12 = manager.audio:GetVoiceLength("story_v_out_322012", "322012042", "story_v_out_322012.awb") / 1000

					if var_187_12 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_12 + var_187_4
					end

					if var_187_7.prefab_name ~= "" and arg_184_1.actors_[var_187_7.prefab_name] ~= nil then
						local var_187_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_7.prefab_name].transform, "story_v_out_322012", "322012042", "story_v_out_322012.awb")

						arg_184_1:RecordAudio("322012042", var_187_13)
						arg_184_1:RecordAudio("322012042", var_187_13)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_322012", "322012042", "story_v_out_322012.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_322012", "322012042", "story_v_out_322012.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_14 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 <= arg_184_1.time_ and arg_184_1.time_ < var_187_4 + var_187_14 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_4) / var_187_14

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_4 + var_187_14 and arg_184_1.time_ < var_187_4 + var_187_14 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play322012043 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 322012043
		arg_188_1.duration_ = 6.93

		local var_188_0 = {
			zh = 4.966,
			ja = 6.933
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
				arg_188_0:Play322012044(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = "1211ui_story"

			if arg_188_1.actors_[var_191_0] == nil then
				local var_191_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_191_1) then
					local var_191_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_188_1.stage_.transform)

					var_191_2.name = var_191_0
					var_191_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_188_1.actors_[var_191_0] = var_191_2

					local var_191_3 = var_191_2:GetComponentInChildren(typeof(CharacterEffect))

					var_191_3.enabled = true

					local var_191_4 = GameObjectTools.GetOrAddComponent(var_191_2, typeof(DynamicBoneHelper))

					if var_191_4 then
						var_191_4:EnableDynamicBone(false)
					end

					arg_188_1:ShowWeapon(var_191_3.transform, false)

					arg_188_1.var_[var_191_0 .. "Animator"] = var_191_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_188_1.var_[var_191_0 .. "Animator"].applyRootMotion = true
					arg_188_1.var_[var_191_0 .. "LipSync"] = var_191_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_191_5 = arg_188_1.actors_["1211ui_story"].transform
			local var_191_6 = 0

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.var_.moveOldPos1211ui_story = var_191_5.localPosition

				local var_191_7 = "1211ui_story"

				arg_188_1:ShowWeapon(arg_188_1.var_[var_191_7 .. "Animator"].transform, false)
			end

			local var_191_8 = 0.001

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_8 then
				local var_191_9 = (arg_188_1.time_ - var_191_6) / var_191_8
				local var_191_10 = Vector3.New(0.7, -0.67, -6.07)

				var_191_5.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1211ui_story, var_191_10, var_191_9)

				local var_191_11 = manager.ui.mainCamera.transform.position - var_191_5.position

				var_191_5.forward = Vector3.New(var_191_11.x, var_191_11.y, var_191_11.z)

				local var_191_12 = var_191_5.localEulerAngles

				var_191_12.z = 0
				var_191_12.x = 0
				var_191_5.localEulerAngles = var_191_12
			end

			if arg_188_1.time_ >= var_191_6 + var_191_8 and arg_188_1.time_ < var_191_6 + var_191_8 + arg_191_0 then
				var_191_5.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_191_13 = manager.ui.mainCamera.transform.position - var_191_5.position

				var_191_5.forward = Vector3.New(var_191_13.x, var_191_13.y, var_191_13.z)

				local var_191_14 = var_191_5.localEulerAngles

				var_191_14.z = 0
				var_191_14.x = 0
				var_191_5.localEulerAngles = var_191_14
			end

			local var_191_15 = arg_188_1.actors_["1061ui_story"].transform
			local var_191_16 = 0

			if var_191_16 < arg_188_1.time_ and arg_188_1.time_ <= var_191_16 + arg_191_0 then
				arg_188_1.var_.moveOldPos1061ui_story = var_191_15.localPosition

				local var_191_17 = "1061ui_story"

				arg_188_1:ShowWeapon(arg_188_1.var_[var_191_17 .. "Animator"].transform, false)
			end

			local var_191_18 = 0.001

			if var_191_16 <= arg_188_1.time_ and arg_188_1.time_ < var_191_16 + var_191_18 then
				local var_191_19 = (arg_188_1.time_ - var_191_16) / var_191_18
				local var_191_20 = Vector3.New(-0.7, -1.18, -6.15)

				var_191_15.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1061ui_story, var_191_20, var_191_19)

				local var_191_21 = manager.ui.mainCamera.transform.position - var_191_15.position

				var_191_15.forward = Vector3.New(var_191_21.x, var_191_21.y, var_191_21.z)

				local var_191_22 = var_191_15.localEulerAngles

				var_191_22.z = 0
				var_191_22.x = 0
				var_191_15.localEulerAngles = var_191_22
			end

			if arg_188_1.time_ >= var_191_16 + var_191_18 and arg_188_1.time_ < var_191_16 + var_191_18 + arg_191_0 then
				var_191_15.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_191_23 = manager.ui.mainCamera.transform.position - var_191_15.position

				var_191_15.forward = Vector3.New(var_191_23.x, var_191_23.y, var_191_23.z)

				local var_191_24 = var_191_15.localEulerAngles

				var_191_24.z = 0
				var_191_24.x = 0
				var_191_15.localEulerAngles = var_191_24
			end

			local var_191_25 = arg_188_1.actors_["1211ui_story"]
			local var_191_26 = 0

			if var_191_26 < arg_188_1.time_ and arg_188_1.time_ <= var_191_26 + arg_191_0 and not isNil(var_191_25) and arg_188_1.var_.characterEffect1211ui_story == nil then
				arg_188_1.var_.characterEffect1211ui_story = var_191_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_27 = 0.200000002980232

			if var_191_26 <= arg_188_1.time_ and arg_188_1.time_ < var_191_26 + var_191_27 and not isNil(var_191_25) then
				local var_191_28 = (arg_188_1.time_ - var_191_26) / var_191_27

				if arg_188_1.var_.characterEffect1211ui_story and not isNil(var_191_25) then
					arg_188_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_26 + var_191_27 and arg_188_1.time_ < var_191_26 + var_191_27 + arg_191_0 and not isNil(var_191_25) and arg_188_1.var_.characterEffect1211ui_story then
				arg_188_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_191_29 = arg_188_1.actors_["1061ui_story"]
			local var_191_30 = 0

			if var_191_30 < arg_188_1.time_ and arg_188_1.time_ <= var_191_30 + arg_191_0 and not isNil(var_191_29) and arg_188_1.var_.characterEffect1061ui_story == nil then
				arg_188_1.var_.characterEffect1061ui_story = var_191_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_31 = 0.200000002980232

			if var_191_30 <= arg_188_1.time_ and arg_188_1.time_ < var_191_30 + var_191_31 and not isNil(var_191_29) then
				local var_191_32 = (arg_188_1.time_ - var_191_30) / var_191_31

				if arg_188_1.var_.characterEffect1061ui_story and not isNil(var_191_29) then
					local var_191_33 = Mathf.Lerp(0, 0.5, var_191_32)

					arg_188_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1061ui_story.fillRatio = var_191_33
				end
			end

			if arg_188_1.time_ >= var_191_30 + var_191_31 and arg_188_1.time_ < var_191_30 + var_191_31 + arg_191_0 and not isNil(var_191_29) and arg_188_1.var_.characterEffect1061ui_story then
				local var_191_34 = 0.5

				arg_188_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1061ui_story.fillRatio = var_191_34
			end

			local var_191_35 = 0

			if var_191_35 < arg_188_1.time_ and arg_188_1.time_ <= var_191_35 + arg_191_0 then
				arg_188_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			local var_191_36 = 0

			if var_191_36 < arg_188_1.time_ and arg_188_1.time_ <= var_191_36 + arg_191_0 then
				arg_188_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_191_37 = 0
			local var_191_38 = 0.625

			if var_191_37 < arg_188_1.time_ and arg_188_1.time_ <= var_191_37 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_39 = arg_188_1:FormatText(StoryNameCfg[37].name)

				arg_188_1.leftNameTxt_.text = var_191_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_40 = arg_188_1:GetWordFromCfg(322012043)
				local var_191_41 = arg_188_1:FormatText(var_191_40.content)

				arg_188_1.text_.text = var_191_41

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_42 = 25
				local var_191_43 = utf8.len(var_191_41)
				local var_191_44 = var_191_42 <= 0 and var_191_38 or var_191_38 * (var_191_43 / var_191_42)

				if var_191_44 > 0 and var_191_38 < var_191_44 then
					arg_188_1.talkMaxDuration = var_191_44

					if var_191_44 + var_191_37 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_44 + var_191_37
					end
				end

				arg_188_1.text_.text = var_191_41
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012043", "story_v_out_322012.awb") ~= 0 then
					local var_191_45 = manager.audio:GetVoiceLength("story_v_out_322012", "322012043", "story_v_out_322012.awb") / 1000

					if var_191_45 + var_191_37 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_45 + var_191_37
					end

					if var_191_40.prefab_name ~= "" and arg_188_1.actors_[var_191_40.prefab_name] ~= nil then
						local var_191_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_40.prefab_name].transform, "story_v_out_322012", "322012043", "story_v_out_322012.awb")

						arg_188_1:RecordAudio("322012043", var_191_46)
						arg_188_1:RecordAudio("322012043", var_191_46)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_322012", "322012043", "story_v_out_322012.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_322012", "322012043", "story_v_out_322012.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_47 = math.max(var_191_38, arg_188_1.talkMaxDuration)

			if var_191_37 <= arg_188_1.time_ and arg_188_1.time_ < var_191_37 + var_191_47 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_37) / var_191_47

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_37 + var_191_47 and arg_188_1.time_ < var_191_37 + var_191_47 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_188_1:InitPlayNodeList()
	end,
	Play322012044 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 322012044
		arg_192_1.duration_ = 3.6

		local var_192_0 = {
			zh = 3.1,
			ja = 3.6
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play322012045(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10104ui_story"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos10104ui_story = var_195_0.localPosition
			end

			local var_195_2 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2
				local var_195_4 = Vector3.New(0.99, -1.12, -5.99)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10104ui_story, var_195_4, var_195_3)

				local var_195_5 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_5.x, var_195_5.y, var_195_5.z)

				local var_195_6 = var_195_0.localEulerAngles

				var_195_6.z = 0
				var_195_6.x = 0
				var_195_0.localEulerAngles = var_195_6
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_195_7 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_7.x, var_195_7.y, var_195_7.z)

				local var_195_8 = var_195_0.localEulerAngles

				var_195_8.z = 0
				var_195_8.x = 0
				var_195_0.localEulerAngles = var_195_8
			end

			local var_195_9 = arg_192_1.actors_["1211ui_story"].transform
			local var_195_10 = 0

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 then
				arg_192_1.var_.moveOldPos1211ui_story = var_195_9.localPosition
			end

			local var_195_11 = 0.001

			if var_195_10 <= arg_192_1.time_ and arg_192_1.time_ < var_195_10 + var_195_11 then
				local var_195_12 = (arg_192_1.time_ - var_195_10) / var_195_11
				local var_195_13 = Vector3.New(0, 100, 0)

				var_195_9.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1211ui_story, var_195_13, var_195_12)

				local var_195_14 = manager.ui.mainCamera.transform.position - var_195_9.position

				var_195_9.forward = Vector3.New(var_195_14.x, var_195_14.y, var_195_14.z)

				local var_195_15 = var_195_9.localEulerAngles

				var_195_15.z = 0
				var_195_15.x = 0
				var_195_9.localEulerAngles = var_195_15
			end

			if arg_192_1.time_ >= var_195_10 + var_195_11 and arg_192_1.time_ < var_195_10 + var_195_11 + arg_195_0 then
				var_195_9.localPosition = Vector3.New(0, 100, 0)

				local var_195_16 = manager.ui.mainCamera.transform.position - var_195_9.position

				var_195_9.forward = Vector3.New(var_195_16.x, var_195_16.y, var_195_16.z)

				local var_195_17 = var_195_9.localEulerAngles

				var_195_17.z = 0
				var_195_17.x = 0
				var_195_9.localEulerAngles = var_195_17
			end

			local var_195_18 = arg_192_1.actors_["10104ui_story"]
			local var_195_19 = 0

			if var_195_19 < arg_192_1.time_ and arg_192_1.time_ <= var_195_19 + arg_195_0 and not isNil(var_195_18) and arg_192_1.var_.characterEffect10104ui_story == nil then
				arg_192_1.var_.characterEffect10104ui_story = var_195_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_20 = 0.200000002980232

			if var_195_19 <= arg_192_1.time_ and arg_192_1.time_ < var_195_19 + var_195_20 and not isNil(var_195_18) then
				local var_195_21 = (arg_192_1.time_ - var_195_19) / var_195_20

				if arg_192_1.var_.characterEffect10104ui_story and not isNil(var_195_18) then
					arg_192_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_19 + var_195_20 and arg_192_1.time_ < var_195_19 + var_195_20 + arg_195_0 and not isNil(var_195_18) and arg_192_1.var_.characterEffect10104ui_story then
				arg_192_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_195_22 = arg_192_1.actors_["1211ui_story"]
			local var_195_23 = 0

			if var_195_23 < arg_192_1.time_ and arg_192_1.time_ <= var_195_23 + arg_195_0 and not isNil(var_195_22) and arg_192_1.var_.characterEffect1211ui_story == nil then
				arg_192_1.var_.characterEffect1211ui_story = var_195_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_24 = 0.200000002980232

			if var_195_23 <= arg_192_1.time_ and arg_192_1.time_ < var_195_23 + var_195_24 and not isNil(var_195_22) then
				local var_195_25 = (arg_192_1.time_ - var_195_23) / var_195_24

				if arg_192_1.var_.characterEffect1211ui_story and not isNil(var_195_22) then
					local var_195_26 = Mathf.Lerp(0, 0.5, var_195_25)

					arg_192_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1211ui_story.fillRatio = var_195_26
				end
			end

			if arg_192_1.time_ >= var_195_23 + var_195_24 and arg_192_1.time_ < var_195_23 + var_195_24 + arg_195_0 and not isNil(var_195_22) and arg_192_1.var_.characterEffect1211ui_story then
				local var_195_27 = 0.5

				arg_192_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1211ui_story.fillRatio = var_195_27
			end

			local var_195_28 = 0

			if var_195_28 < arg_192_1.time_ and arg_192_1.time_ <= var_195_28 + arg_195_0 then
				arg_192_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_195_29 = 0

			if var_195_29 < arg_192_1.time_ and arg_192_1.time_ <= var_195_29 + arg_195_0 then
				arg_192_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_195_30 = 0
			local var_195_31 = 0.375

			if var_195_30 < arg_192_1.time_ and arg_192_1.time_ <= var_195_30 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_32 = arg_192_1:FormatText(StoryNameCfg[1030].name)

				arg_192_1.leftNameTxt_.text = var_195_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_33 = arg_192_1:GetWordFromCfg(322012044)
				local var_195_34 = arg_192_1:FormatText(var_195_33.content)

				arg_192_1.text_.text = var_195_34

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_35 = 15
				local var_195_36 = utf8.len(var_195_34)
				local var_195_37 = var_195_35 <= 0 and var_195_31 or var_195_31 * (var_195_36 / var_195_35)

				if var_195_37 > 0 and var_195_31 < var_195_37 then
					arg_192_1.talkMaxDuration = var_195_37

					if var_195_37 + var_195_30 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_37 + var_195_30
					end
				end

				arg_192_1.text_.text = var_195_34
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012044", "story_v_out_322012.awb") ~= 0 then
					local var_195_38 = manager.audio:GetVoiceLength("story_v_out_322012", "322012044", "story_v_out_322012.awb") / 1000

					if var_195_38 + var_195_30 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_38 + var_195_30
					end

					if var_195_33.prefab_name ~= "" and arg_192_1.actors_[var_195_33.prefab_name] ~= nil then
						local var_195_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_33.prefab_name].transform, "story_v_out_322012", "322012044", "story_v_out_322012.awb")

						arg_192_1:RecordAudio("322012044", var_195_39)
						arg_192_1:RecordAudio("322012044", var_195_39)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_322012", "322012044", "story_v_out_322012.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_322012", "322012044", "story_v_out_322012.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_40 = math.max(var_195_31, arg_192_1.talkMaxDuration)

			if var_195_30 <= arg_192_1.time_ and arg_192_1.time_ < var_195_30 + var_195_40 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_30) / var_195_40

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_30 + var_195_40 and arg_192_1.time_ < var_195_30 + var_195_40 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play322012045 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 322012045
		arg_196_1.duration_ = 17.03

		local var_196_0 = {
			zh = 11.033,
			ja = 17.033
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play322012046(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1061ui_story"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1061ui_story == nil then
				arg_196_1.var_.characterEffect1061ui_story = var_199_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.200000002980232

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.characterEffect1061ui_story and not isNil(var_199_0) then
					arg_196_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1061ui_story then
				arg_196_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_199_4 = arg_196_1.actors_["10104ui_story"]
			local var_199_5 = 0

			if var_199_5 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 and not isNil(var_199_4) and arg_196_1.var_.characterEffect10104ui_story == nil then
				arg_196_1.var_.characterEffect10104ui_story = var_199_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_6 = 0.200000002980232

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_6 and not isNil(var_199_4) then
				local var_199_7 = (arg_196_1.time_ - var_199_5) / var_199_6

				if arg_196_1.var_.characterEffect10104ui_story and not isNil(var_199_4) then
					local var_199_8 = Mathf.Lerp(0, 0.5, var_199_7)

					arg_196_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_196_1.var_.characterEffect10104ui_story.fillRatio = var_199_8
				end
			end

			if arg_196_1.time_ >= var_199_5 + var_199_6 and arg_196_1.time_ < var_199_5 + var_199_6 + arg_199_0 and not isNil(var_199_4) and arg_196_1.var_.characterEffect10104ui_story then
				local var_199_9 = 0.5

				arg_196_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_196_1.var_.characterEffect10104ui_story.fillRatio = var_199_9
			end

			local var_199_10 = 0
			local var_199_11 = 1.25

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_12 = arg_196_1:FormatText(StoryNameCfg[612].name)

				arg_196_1.leftNameTxt_.text = var_199_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_13 = arg_196_1:GetWordFromCfg(322012045)
				local var_199_14 = arg_196_1:FormatText(var_199_13.content)

				arg_196_1.text_.text = var_199_14

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_15 = 50
				local var_199_16 = utf8.len(var_199_14)
				local var_199_17 = var_199_15 <= 0 and var_199_11 or var_199_11 * (var_199_16 / var_199_15)

				if var_199_17 > 0 and var_199_11 < var_199_17 then
					arg_196_1.talkMaxDuration = var_199_17

					if var_199_17 + var_199_10 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_17 + var_199_10
					end
				end

				arg_196_1.text_.text = var_199_14
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012045", "story_v_out_322012.awb") ~= 0 then
					local var_199_18 = manager.audio:GetVoiceLength("story_v_out_322012", "322012045", "story_v_out_322012.awb") / 1000

					if var_199_18 + var_199_10 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_18 + var_199_10
					end

					if var_199_13.prefab_name ~= "" and arg_196_1.actors_[var_199_13.prefab_name] ~= nil then
						local var_199_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_13.prefab_name].transform, "story_v_out_322012", "322012045", "story_v_out_322012.awb")

						arg_196_1:RecordAudio("322012045", var_199_19)
						arg_196_1:RecordAudio("322012045", var_199_19)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_322012", "322012045", "story_v_out_322012.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_322012", "322012045", "story_v_out_322012.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_20 = math.max(var_199_11, arg_196_1.talkMaxDuration)

			if var_199_10 <= arg_196_1.time_ and arg_196_1.time_ < var_199_10 + var_199_20 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_10) / var_199_20

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_10 + var_199_20 and arg_196_1.time_ < var_199_10 + var_199_20 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play322012046 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 322012046
		arg_200_1.duration_ = 10.53

		local var_200_0 = {
			zh = 8.833,
			ja = 10.533
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
				arg_200_0:Play322012047(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 1.05

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_2 = arg_200_1:FormatText(StoryNameCfg[612].name)

				arg_200_1.leftNameTxt_.text = var_203_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_3 = arg_200_1:GetWordFromCfg(322012046)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 42
				local var_203_6 = utf8.len(var_203_4)
				local var_203_7 = var_203_5 <= 0 and var_203_1 or var_203_1 * (var_203_6 / var_203_5)

				if var_203_7 > 0 and var_203_1 < var_203_7 then
					arg_200_1.talkMaxDuration = var_203_7

					if var_203_7 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_7 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_4
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012046", "story_v_out_322012.awb") ~= 0 then
					local var_203_8 = manager.audio:GetVoiceLength("story_v_out_322012", "322012046", "story_v_out_322012.awb") / 1000

					if var_203_8 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_8 + var_203_0
					end

					if var_203_3.prefab_name ~= "" and arg_200_1.actors_[var_203_3.prefab_name] ~= nil then
						local var_203_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_3.prefab_name].transform, "story_v_out_322012", "322012046", "story_v_out_322012.awb")

						arg_200_1:RecordAudio("322012046", var_203_9)
						arg_200_1:RecordAudio("322012046", var_203_9)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_322012", "322012046", "story_v_out_322012.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_322012", "322012046", "story_v_out_322012.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_10 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_10 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_10

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_10 and arg_200_1.time_ < var_203_0 + var_203_10 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play322012047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 322012047
		arg_204_1.duration_ = 3.33

		local var_204_0 = {
			zh = 2.5,
			ja = 3.333
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play322012048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["10104ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect10104ui_story == nil then
				arg_204_1.var_.characterEffect10104ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect10104ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect10104ui_story then
				arg_204_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_207_4 = arg_204_1.actors_["1061ui_story"]
			local var_207_5 = 0

			if var_207_5 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect1061ui_story == nil then
				arg_204_1.var_.characterEffect1061ui_story = var_207_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_6 = 0.200000002980232

			if var_207_5 <= arg_204_1.time_ and arg_204_1.time_ < var_207_5 + var_207_6 and not isNil(var_207_4) then
				local var_207_7 = (arg_204_1.time_ - var_207_5) / var_207_6

				if arg_204_1.var_.characterEffect1061ui_story and not isNil(var_207_4) then
					local var_207_8 = Mathf.Lerp(0, 0.5, var_207_7)

					arg_204_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1061ui_story.fillRatio = var_207_8
				end
			end

			if arg_204_1.time_ >= var_207_5 + var_207_6 and arg_204_1.time_ < var_207_5 + var_207_6 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect1061ui_story then
				local var_207_9 = 0.5

				arg_204_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1061ui_story.fillRatio = var_207_9
			end

			local var_207_10 = 0

			if var_207_10 < arg_204_1.time_ and arg_204_1.time_ <= var_207_10 + arg_207_0 then
				arg_204_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			local var_207_11 = 0

			if var_207_11 < arg_204_1.time_ and arg_204_1.time_ <= var_207_11 + arg_207_0 then
				arg_204_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_207_12 = 0
			local var_207_13 = 0.2

			if var_207_12 < arg_204_1.time_ and arg_204_1.time_ <= var_207_12 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_14 = arg_204_1:FormatText(StoryNameCfg[1030].name)

				arg_204_1.leftNameTxt_.text = var_207_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_15 = arg_204_1:GetWordFromCfg(322012047)
				local var_207_16 = arg_204_1:FormatText(var_207_15.content)

				arg_204_1.text_.text = var_207_16

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_17 = 8
				local var_207_18 = utf8.len(var_207_16)
				local var_207_19 = var_207_17 <= 0 and var_207_13 or var_207_13 * (var_207_18 / var_207_17)

				if var_207_19 > 0 and var_207_13 < var_207_19 then
					arg_204_1.talkMaxDuration = var_207_19

					if var_207_19 + var_207_12 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_19 + var_207_12
					end
				end

				arg_204_1.text_.text = var_207_16
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012047", "story_v_out_322012.awb") ~= 0 then
					local var_207_20 = manager.audio:GetVoiceLength("story_v_out_322012", "322012047", "story_v_out_322012.awb") / 1000

					if var_207_20 + var_207_12 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_20 + var_207_12
					end

					if var_207_15.prefab_name ~= "" and arg_204_1.actors_[var_207_15.prefab_name] ~= nil then
						local var_207_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_15.prefab_name].transform, "story_v_out_322012", "322012047", "story_v_out_322012.awb")

						arg_204_1:RecordAudio("322012047", var_207_21)
						arg_204_1:RecordAudio("322012047", var_207_21)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_322012", "322012047", "story_v_out_322012.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_322012", "322012047", "story_v_out_322012.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_22 = math.max(var_207_13, arg_204_1.talkMaxDuration)

			if var_207_12 <= arg_204_1.time_ and arg_204_1.time_ < var_207_12 + var_207_22 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_12) / var_207_22

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_12 + var_207_22 and arg_204_1.time_ < var_207_12 + var_207_22 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play322012048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 322012048
		arg_208_1.duration_ = 10.5

		local var_208_0 = {
			zh = 6.733,
			ja = 10.5
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play322012049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1061ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1061ui_story == nil then
				arg_208_1.var_.characterEffect1061ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect1061ui_story and not isNil(var_211_0) then
					arg_208_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1061ui_story then
				arg_208_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_211_4 = arg_208_1.actors_["10104ui_story"]
			local var_211_5 = 0

			if var_211_5 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 and not isNil(var_211_4) and arg_208_1.var_.characterEffect10104ui_story == nil then
				arg_208_1.var_.characterEffect10104ui_story = var_211_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_6 = 0.200000002980232

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_6 and not isNil(var_211_4) then
				local var_211_7 = (arg_208_1.time_ - var_211_5) / var_211_6

				if arg_208_1.var_.characterEffect10104ui_story and not isNil(var_211_4) then
					local var_211_8 = Mathf.Lerp(0, 0.5, var_211_7)

					arg_208_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10104ui_story.fillRatio = var_211_8
				end
			end

			if arg_208_1.time_ >= var_211_5 + var_211_6 and arg_208_1.time_ < var_211_5 + var_211_6 + arg_211_0 and not isNil(var_211_4) and arg_208_1.var_.characterEffect10104ui_story then
				local var_211_9 = 0.5

				arg_208_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10104ui_story.fillRatio = var_211_9
			end

			local var_211_10 = 0

			if var_211_10 < arg_208_1.time_ and arg_208_1.time_ <= var_211_10 + arg_211_0 then
				arg_208_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			local var_211_11 = 0

			if var_211_11 < arg_208_1.time_ and arg_208_1.time_ <= var_211_11 + arg_211_0 then
				arg_208_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_211_12 = 0
			local var_211_13 = 0.575

			if var_211_12 < arg_208_1.time_ and arg_208_1.time_ <= var_211_12 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_14 = arg_208_1:FormatText(StoryNameCfg[612].name)

				arg_208_1.leftNameTxt_.text = var_211_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_15 = arg_208_1:GetWordFromCfg(322012048)
				local var_211_16 = arg_208_1:FormatText(var_211_15.content)

				arg_208_1.text_.text = var_211_16

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_17 = 23
				local var_211_18 = utf8.len(var_211_16)
				local var_211_19 = var_211_17 <= 0 and var_211_13 or var_211_13 * (var_211_18 / var_211_17)

				if var_211_19 > 0 and var_211_13 < var_211_19 then
					arg_208_1.talkMaxDuration = var_211_19

					if var_211_19 + var_211_12 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_19 + var_211_12
					end
				end

				arg_208_1.text_.text = var_211_16
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012048", "story_v_out_322012.awb") ~= 0 then
					local var_211_20 = manager.audio:GetVoiceLength("story_v_out_322012", "322012048", "story_v_out_322012.awb") / 1000

					if var_211_20 + var_211_12 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_20 + var_211_12
					end

					if var_211_15.prefab_name ~= "" and arg_208_1.actors_[var_211_15.prefab_name] ~= nil then
						local var_211_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_15.prefab_name].transform, "story_v_out_322012", "322012048", "story_v_out_322012.awb")

						arg_208_1:RecordAudio("322012048", var_211_21)
						arg_208_1:RecordAudio("322012048", var_211_21)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_322012", "322012048", "story_v_out_322012.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_322012", "322012048", "story_v_out_322012.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_22 = math.max(var_211_13, arg_208_1.talkMaxDuration)

			if var_211_12 <= arg_208_1.time_ and arg_208_1.time_ < var_211_12 + var_211_22 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_12) / var_211_22

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_12 + var_211_22 and arg_208_1.time_ < var_211_12 + var_211_22 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play322012049 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 322012049
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play322012050(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1061ui_story"].transform
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.var_.moveOldPos1061ui_story = var_215_0.localPosition
			end

			local var_215_2 = 0.001

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2
				local var_215_4 = Vector3.New(0, 100, 0)

				var_215_0.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1061ui_story, var_215_4, var_215_3)

				local var_215_5 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_5.x, var_215_5.y, var_215_5.z)

				local var_215_6 = var_215_0.localEulerAngles

				var_215_6.z = 0
				var_215_6.x = 0
				var_215_0.localEulerAngles = var_215_6
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 then
				var_215_0.localPosition = Vector3.New(0, 100, 0)

				local var_215_7 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_7.x, var_215_7.y, var_215_7.z)

				local var_215_8 = var_215_0.localEulerAngles

				var_215_8.z = 0
				var_215_8.x = 0
				var_215_0.localEulerAngles = var_215_8
			end

			local var_215_9 = arg_212_1.actors_["10104ui_story"].transform
			local var_215_10 = 0

			if var_215_10 < arg_212_1.time_ and arg_212_1.time_ <= var_215_10 + arg_215_0 then
				arg_212_1.var_.moveOldPos10104ui_story = var_215_9.localPosition
			end

			local var_215_11 = 0.001

			if var_215_10 <= arg_212_1.time_ and arg_212_1.time_ < var_215_10 + var_215_11 then
				local var_215_12 = (arg_212_1.time_ - var_215_10) / var_215_11
				local var_215_13 = Vector3.New(0, 100, 0)

				var_215_9.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10104ui_story, var_215_13, var_215_12)

				local var_215_14 = manager.ui.mainCamera.transform.position - var_215_9.position

				var_215_9.forward = Vector3.New(var_215_14.x, var_215_14.y, var_215_14.z)

				local var_215_15 = var_215_9.localEulerAngles

				var_215_15.z = 0
				var_215_15.x = 0
				var_215_9.localEulerAngles = var_215_15
			end

			if arg_212_1.time_ >= var_215_10 + var_215_11 and arg_212_1.time_ < var_215_10 + var_215_11 + arg_215_0 then
				var_215_9.localPosition = Vector3.New(0, 100, 0)

				local var_215_16 = manager.ui.mainCamera.transform.position - var_215_9.position

				var_215_9.forward = Vector3.New(var_215_16.x, var_215_16.y, var_215_16.z)

				local var_215_17 = var_215_9.localEulerAngles

				var_215_17.z = 0
				var_215_17.x = 0
				var_215_9.localEulerAngles = var_215_17
			end

			local var_215_18 = 0
			local var_215_19 = 0.925

			if var_215_18 < arg_212_1.time_ and arg_212_1.time_ <= var_215_18 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_20 = arg_212_1:GetWordFromCfg(322012049)
				local var_215_21 = arg_212_1:FormatText(var_215_20.content)

				arg_212_1.text_.text = var_215_21

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_22 = 37
				local var_215_23 = utf8.len(var_215_21)
				local var_215_24 = var_215_22 <= 0 and var_215_19 or var_215_19 * (var_215_23 / var_215_22)

				if var_215_24 > 0 and var_215_19 < var_215_24 then
					arg_212_1.talkMaxDuration = var_215_24

					if var_215_24 + var_215_18 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_24 + var_215_18
					end
				end

				arg_212_1.text_.text = var_215_21
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_25 = math.max(var_215_19, arg_212_1.talkMaxDuration)

			if var_215_18 <= arg_212_1.time_ and arg_212_1.time_ < var_215_18 + var_215_25 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_18) / var_215_25

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_18 + var_215_25 and arg_212_1.time_ < var_215_18 + var_215_25 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
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
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play322012050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 322012050
		arg_216_1.duration_ = 2.8

		local var_216_0 = {
			zh = 2.8,
			ja = 2.666
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play322012051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1211ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos1211ui_story = var_219_0.localPosition
			end

			local var_219_2 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2
				local var_219_4 = Vector3.New(0, -0.67, -6.07)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1211ui_story, var_219_4, var_219_3)

				local var_219_5 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_5.x, var_219_5.y, var_219_5.z)

				local var_219_6 = var_219_0.localEulerAngles

				var_219_6.z = 0
				var_219_6.x = 0
				var_219_0.localEulerAngles = var_219_6
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_219_7 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_7.x, var_219_7.y, var_219_7.z)

				local var_219_8 = var_219_0.localEulerAngles

				var_219_8.z = 0
				var_219_8.x = 0
				var_219_0.localEulerAngles = var_219_8
			end

			local var_219_9 = arg_216_1.actors_["1211ui_story"]
			local var_219_10 = 0

			if var_219_10 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect1211ui_story == nil then
				arg_216_1.var_.characterEffect1211ui_story = var_219_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_11 = 0.200000002980232

			if var_219_10 <= arg_216_1.time_ and arg_216_1.time_ < var_219_10 + var_219_11 and not isNil(var_219_9) then
				local var_219_12 = (arg_216_1.time_ - var_219_10) / var_219_11

				if arg_216_1.var_.characterEffect1211ui_story and not isNil(var_219_9) then
					arg_216_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_10 + var_219_11 and arg_216_1.time_ < var_219_10 + var_219_11 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect1211ui_story then
				arg_216_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_219_13 = 0

			if var_219_13 < arg_216_1.time_ and arg_216_1.time_ <= var_219_13 + arg_219_0 then
				arg_216_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_219_14 = 0

			if var_219_14 < arg_216_1.time_ and arg_216_1.time_ <= var_219_14 + arg_219_0 then
				arg_216_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_219_15 = 0
			local var_219_16 = 0.3

			if var_219_15 < arg_216_1.time_ and arg_216_1.time_ <= var_219_15 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_17 = arg_216_1:FormatText(StoryNameCfg[37].name)

				arg_216_1.leftNameTxt_.text = var_219_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_18 = arg_216_1:GetWordFromCfg(322012050)
				local var_219_19 = arg_216_1:FormatText(var_219_18.content)

				arg_216_1.text_.text = var_219_19

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_20 = 12
				local var_219_21 = utf8.len(var_219_19)
				local var_219_22 = var_219_20 <= 0 and var_219_16 or var_219_16 * (var_219_21 / var_219_20)

				if var_219_22 > 0 and var_219_16 < var_219_22 then
					arg_216_1.talkMaxDuration = var_219_22

					if var_219_22 + var_219_15 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_22 + var_219_15
					end
				end

				arg_216_1.text_.text = var_219_19
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012050", "story_v_out_322012.awb") ~= 0 then
					local var_219_23 = manager.audio:GetVoiceLength("story_v_out_322012", "322012050", "story_v_out_322012.awb") / 1000

					if var_219_23 + var_219_15 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_23 + var_219_15
					end

					if var_219_18.prefab_name ~= "" and arg_216_1.actors_[var_219_18.prefab_name] ~= nil then
						local var_219_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_18.prefab_name].transform, "story_v_out_322012", "322012050", "story_v_out_322012.awb")

						arg_216_1:RecordAudio("322012050", var_219_24)
						arg_216_1:RecordAudio("322012050", var_219_24)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_322012", "322012050", "story_v_out_322012.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_322012", "322012050", "story_v_out_322012.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_25 = math.max(var_219_16, arg_216_1.talkMaxDuration)

			if var_219_15 <= arg_216_1.time_ and arg_216_1.time_ < var_219_15 + var_219_25 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_15) / var_219_25

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_15 + var_219_25 and arg_216_1.time_ < var_219_15 + var_219_25 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play322012051 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 322012051
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play322012052(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1211ui_story"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos1211ui_story = var_223_0.localPosition
			end

			local var_223_2 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2
				local var_223_4 = Vector3.New(0, 100, 0)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1211ui_story, var_223_4, var_223_3)

				local var_223_5 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_5.x, var_223_5.y, var_223_5.z)

				local var_223_6 = var_223_0.localEulerAngles

				var_223_6.z = 0
				var_223_6.x = 0
				var_223_0.localEulerAngles = var_223_6
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(0, 100, 0)

				local var_223_7 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_7.x, var_223_7.y, var_223_7.z)

				local var_223_8 = var_223_0.localEulerAngles

				var_223_8.z = 0
				var_223_8.x = 0
				var_223_0.localEulerAngles = var_223_8
			end

			local var_223_9 = 0
			local var_223_10 = 0.575

			if var_223_9 < arg_220_1.time_ and arg_220_1.time_ <= var_223_9 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_11 = arg_220_1:FormatText(StoryNameCfg[7].name)

				arg_220_1.leftNameTxt_.text = var_223_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_12 = arg_220_1:GetWordFromCfg(322012051)
				local var_223_13 = arg_220_1:FormatText(var_223_12.content)

				arg_220_1.text_.text = var_223_13

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_14 = 21
				local var_223_15 = utf8.len(var_223_13)
				local var_223_16 = var_223_14 <= 0 and var_223_10 or var_223_10 * (var_223_15 / var_223_14)

				if var_223_16 > 0 and var_223_10 < var_223_16 then
					arg_220_1.talkMaxDuration = var_223_16

					if var_223_16 + var_223_9 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_16 + var_223_9
					end
				end

				arg_220_1.text_.text = var_223_13
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_17 = math.max(var_223_10, arg_220_1.talkMaxDuration)

			if var_223_9 <= arg_220_1.time_ and arg_220_1.time_ < var_223_9 + var_223_17 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_9) / var_223_17

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_9 + var_223_17 and arg_220_1.time_ < var_223_9 + var_223_17 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play322012052 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 322012052
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play322012053(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0
			local var_227_1 = 1.6

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_2 = arg_224_1:FormatText(StoryNameCfg[7].name)

				arg_224_1.leftNameTxt_.text = var_227_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_3 = arg_224_1:GetWordFromCfg(322012052)
				local var_227_4 = arg_224_1:FormatText(var_227_3.content)

				arg_224_1.text_.text = var_227_4

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 64
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
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_8 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_8 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_8

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_8 and arg_224_1.time_ < var_227_0 + var_227_8 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play322012053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 322012053
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play322012054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0
			local var_231_1 = 1.075

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_2 = arg_228_1:FormatText(StoryNameCfg[7].name)

				arg_228_1.leftNameTxt_.text = var_231_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_3 = arg_228_1:GetWordFromCfg(322012053)
				local var_231_4 = arg_228_1:FormatText(var_231_3.content)

				arg_228_1.text_.text = var_231_4

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 43
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
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_8 = math.max(var_231_1, arg_228_1.talkMaxDuration)

			if var_231_0 <= arg_228_1.time_ and arg_228_1.time_ < var_231_0 + var_231_8 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_0) / var_231_8

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_0 + var_231_8 and arg_228_1.time_ < var_231_0 + var_231_8 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play322012054 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 322012054
		arg_232_1.duration_ = 13.2

		local var_232_0 = {
			zh = 8.8,
			ja = 13.2
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play322012055(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1061ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos1061ui_story = var_235_0.localPosition
			end

			local var_235_2 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2
				local var_235_4 = Vector3.New(0, -1.18, -6.15)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1061ui_story, var_235_4, var_235_3)

				local var_235_5 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_5.x, var_235_5.y, var_235_5.z)

				local var_235_6 = var_235_0.localEulerAngles

				var_235_6.z = 0
				var_235_6.x = 0
				var_235_0.localEulerAngles = var_235_6
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_235_7 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_7.x, var_235_7.y, var_235_7.z)

				local var_235_8 = var_235_0.localEulerAngles

				var_235_8.z = 0
				var_235_8.x = 0
				var_235_0.localEulerAngles = var_235_8
			end

			local var_235_9 = arg_232_1.actors_["1061ui_story"]
			local var_235_10 = 0

			if var_235_10 < arg_232_1.time_ and arg_232_1.time_ <= var_235_10 + arg_235_0 and not isNil(var_235_9) and arg_232_1.var_.characterEffect1061ui_story == nil then
				arg_232_1.var_.characterEffect1061ui_story = var_235_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_11 = 0.200000002980232

			if var_235_10 <= arg_232_1.time_ and arg_232_1.time_ < var_235_10 + var_235_11 and not isNil(var_235_9) then
				local var_235_12 = (arg_232_1.time_ - var_235_10) / var_235_11

				if arg_232_1.var_.characterEffect1061ui_story and not isNil(var_235_9) then
					arg_232_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_10 + var_235_11 and arg_232_1.time_ < var_235_10 + var_235_11 + arg_235_0 and not isNil(var_235_9) and arg_232_1.var_.characterEffect1061ui_story then
				arg_232_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_235_13 = 0

			if var_235_13 < arg_232_1.time_ and arg_232_1.time_ <= var_235_13 + arg_235_0 then
				arg_232_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_235_14 = 0

			if var_235_14 < arg_232_1.time_ and arg_232_1.time_ <= var_235_14 + arg_235_0 then
				arg_232_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_235_15 = 0
			local var_235_16 = 1.1

			if var_235_15 < arg_232_1.time_ and arg_232_1.time_ <= var_235_15 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_17 = arg_232_1:FormatText(StoryNameCfg[612].name)

				arg_232_1.leftNameTxt_.text = var_235_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_18 = arg_232_1:GetWordFromCfg(322012054)
				local var_235_19 = arg_232_1:FormatText(var_235_18.content)

				arg_232_1.text_.text = var_235_19

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_20 = 44
				local var_235_21 = utf8.len(var_235_19)
				local var_235_22 = var_235_20 <= 0 and var_235_16 or var_235_16 * (var_235_21 / var_235_20)

				if var_235_22 > 0 and var_235_16 < var_235_22 then
					arg_232_1.talkMaxDuration = var_235_22

					if var_235_22 + var_235_15 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_22 + var_235_15
					end
				end

				arg_232_1.text_.text = var_235_19
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012054", "story_v_out_322012.awb") ~= 0 then
					local var_235_23 = manager.audio:GetVoiceLength("story_v_out_322012", "322012054", "story_v_out_322012.awb") / 1000

					if var_235_23 + var_235_15 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_23 + var_235_15
					end

					if var_235_18.prefab_name ~= "" and arg_232_1.actors_[var_235_18.prefab_name] ~= nil then
						local var_235_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_18.prefab_name].transform, "story_v_out_322012", "322012054", "story_v_out_322012.awb")

						arg_232_1:RecordAudio("322012054", var_235_24)
						arg_232_1:RecordAudio("322012054", var_235_24)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_322012", "322012054", "story_v_out_322012.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_322012", "322012054", "story_v_out_322012.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_25 = math.max(var_235_16, arg_232_1.talkMaxDuration)

			if var_235_15 <= arg_232_1.time_ and arg_232_1.time_ < var_235_15 + var_235_25 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_15) / var_235_25

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_15 + var_235_25 and arg_232_1.time_ < var_235_15 + var_235_25 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
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

		arg_232_1:InitPlayNodeList()
	end,
	Play322012055 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 322012055
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play322012056(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1061ui_story"].transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.var_.moveOldPos1061ui_story = var_239_0.localPosition
			end

			local var_239_2 = 0.001

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2
				local var_239_4 = Vector3.New(0, 100, 0)

				var_239_0.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1061ui_story, var_239_4, var_239_3)

				local var_239_5 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_5.x, var_239_5.y, var_239_5.z)

				local var_239_6 = var_239_0.localEulerAngles

				var_239_6.z = 0
				var_239_6.x = 0
				var_239_0.localEulerAngles = var_239_6
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 then
				var_239_0.localPosition = Vector3.New(0, 100, 0)

				local var_239_7 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_7.x, var_239_7.y, var_239_7.z)

				local var_239_8 = var_239_0.localEulerAngles

				var_239_8.z = 0
				var_239_8.x = 0
				var_239_0.localEulerAngles = var_239_8
			end

			local var_239_9 = 0
			local var_239_10 = 1.325

			if var_239_9 < arg_236_1.time_ and arg_236_1.time_ <= var_239_9 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_11 = arg_236_1:GetWordFromCfg(322012055)
				local var_239_12 = arg_236_1:FormatText(var_239_11.content)

				arg_236_1.text_.text = var_239_12

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_13 = 53
				local var_239_14 = utf8.len(var_239_12)
				local var_239_15 = var_239_13 <= 0 and var_239_10 or var_239_10 * (var_239_14 / var_239_13)

				if var_239_15 > 0 and var_239_10 < var_239_15 then
					arg_236_1.talkMaxDuration = var_239_15

					if var_239_15 + var_239_9 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_15 + var_239_9
					end
				end

				arg_236_1.text_.text = var_239_12
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_16 = math.max(var_239_10, arg_236_1.talkMaxDuration)

			if var_239_9 <= arg_236_1.time_ and arg_236_1.time_ < var_239_9 + var_239_16 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_9) / var_239_16

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_9 + var_239_16 and arg_236_1.time_ < var_239_9 + var_239_16 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
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

		arg_236_1:InitPlayNodeList()
	end,
	Play322012056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 322012056
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play322012057(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 0.5

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_2 = arg_240_1:FormatText(StoryNameCfg[7].name)

				arg_240_1.leftNameTxt_.text = var_243_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_3 = arg_240_1:GetWordFromCfg(322012056)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 20
				local var_243_6 = utf8.len(var_243_4)
				local var_243_7 = var_243_5 <= 0 and var_243_1 or var_243_1 * (var_243_6 / var_243_5)

				if var_243_7 > 0 and var_243_1 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_4
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_8 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_8 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_8

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_8 and arg_240_1.time_ < var_243_0 + var_243_8 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play322012057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 322012057
		arg_244_1.duration_ = 4.27

		local var_244_0 = {
			zh = 2.933,
			ja = 4.266
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play322012058(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1061ui_story"].transform
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.var_.moveOldPos1061ui_story = var_247_0.localPosition
			end

			local var_247_2 = 0.001

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2
				local var_247_4 = Vector3.New(0, -1.18, -6.15)

				var_247_0.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1061ui_story, var_247_4, var_247_3)

				local var_247_5 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_5.x, var_247_5.y, var_247_5.z)

				local var_247_6 = var_247_0.localEulerAngles

				var_247_6.z = 0
				var_247_6.x = 0
				var_247_0.localEulerAngles = var_247_6
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 then
				var_247_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_247_7 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_7.x, var_247_7.y, var_247_7.z)

				local var_247_8 = var_247_0.localEulerAngles

				var_247_8.z = 0
				var_247_8.x = 0
				var_247_0.localEulerAngles = var_247_8
			end

			local var_247_9 = arg_244_1.actors_["1061ui_story"]
			local var_247_10 = 0

			if var_247_10 < arg_244_1.time_ and arg_244_1.time_ <= var_247_10 + arg_247_0 and not isNil(var_247_9) and arg_244_1.var_.characterEffect1061ui_story == nil then
				arg_244_1.var_.characterEffect1061ui_story = var_247_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_11 = 0.200000002980232

			if var_247_10 <= arg_244_1.time_ and arg_244_1.time_ < var_247_10 + var_247_11 and not isNil(var_247_9) then
				local var_247_12 = (arg_244_1.time_ - var_247_10) / var_247_11

				if arg_244_1.var_.characterEffect1061ui_story and not isNil(var_247_9) then
					arg_244_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_10 + var_247_11 and arg_244_1.time_ < var_247_10 + var_247_11 + arg_247_0 and not isNil(var_247_9) and arg_244_1.var_.characterEffect1061ui_story then
				arg_244_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_247_13 = 0

			if var_247_13 < arg_244_1.time_ and arg_244_1.time_ <= var_247_13 + arg_247_0 then
				arg_244_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_247_14 = 0

			if var_247_14 < arg_244_1.time_ and arg_244_1.time_ <= var_247_14 + arg_247_0 then
				arg_244_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_247_15 = 0
			local var_247_16 = 0.4

			if var_247_15 < arg_244_1.time_ and arg_244_1.time_ <= var_247_15 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_17 = arg_244_1:FormatText(StoryNameCfg[612].name)

				arg_244_1.leftNameTxt_.text = var_247_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_18 = arg_244_1:GetWordFromCfg(322012057)
				local var_247_19 = arg_244_1:FormatText(var_247_18.content)

				arg_244_1.text_.text = var_247_19

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_20 = 16
				local var_247_21 = utf8.len(var_247_19)
				local var_247_22 = var_247_20 <= 0 and var_247_16 or var_247_16 * (var_247_21 / var_247_20)

				if var_247_22 > 0 and var_247_16 < var_247_22 then
					arg_244_1.talkMaxDuration = var_247_22

					if var_247_22 + var_247_15 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_22 + var_247_15
					end
				end

				arg_244_1.text_.text = var_247_19
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012057", "story_v_out_322012.awb") ~= 0 then
					local var_247_23 = manager.audio:GetVoiceLength("story_v_out_322012", "322012057", "story_v_out_322012.awb") / 1000

					if var_247_23 + var_247_15 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_23 + var_247_15
					end

					if var_247_18.prefab_name ~= "" and arg_244_1.actors_[var_247_18.prefab_name] ~= nil then
						local var_247_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_18.prefab_name].transform, "story_v_out_322012", "322012057", "story_v_out_322012.awb")

						arg_244_1:RecordAudio("322012057", var_247_24)
						arg_244_1:RecordAudio("322012057", var_247_24)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_322012", "322012057", "story_v_out_322012.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_322012", "322012057", "story_v_out_322012.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_25 = math.max(var_247_16, arg_244_1.talkMaxDuration)

			if var_247_15 <= arg_244_1.time_ and arg_244_1.time_ < var_247_15 + var_247_25 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_15) / var_247_25

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_15 + var_247_25 and arg_244_1.time_ < var_247_15 + var_247_25 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
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

		arg_244_1:InitPlayNodeList()
	end,
	Play322012058 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 322012058
		arg_248_1.duration_ = 15.03

		local var_248_0 = {
			zh = 10.733,
			ja = 15.033
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play322012059(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_251_2 = 0
			local var_251_3 = 1.15

			if var_251_2 < arg_248_1.time_ and arg_248_1.time_ <= var_251_2 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_4 = arg_248_1:FormatText(StoryNameCfg[612].name)

				arg_248_1.leftNameTxt_.text = var_251_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_5 = arg_248_1:GetWordFromCfg(322012058)
				local var_251_6 = arg_248_1:FormatText(var_251_5.content)

				arg_248_1.text_.text = var_251_6

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_7 = 46
				local var_251_8 = utf8.len(var_251_6)
				local var_251_9 = var_251_7 <= 0 and var_251_3 or var_251_3 * (var_251_8 / var_251_7)

				if var_251_9 > 0 and var_251_3 < var_251_9 then
					arg_248_1.talkMaxDuration = var_251_9

					if var_251_9 + var_251_2 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_9 + var_251_2
					end
				end

				arg_248_1.text_.text = var_251_6
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012058", "story_v_out_322012.awb") ~= 0 then
					local var_251_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012058", "story_v_out_322012.awb") / 1000

					if var_251_10 + var_251_2 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_10 + var_251_2
					end

					if var_251_5.prefab_name ~= "" and arg_248_1.actors_[var_251_5.prefab_name] ~= nil then
						local var_251_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_5.prefab_name].transform, "story_v_out_322012", "322012058", "story_v_out_322012.awb")

						arg_248_1:RecordAudio("322012058", var_251_11)
						arg_248_1:RecordAudio("322012058", var_251_11)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_322012", "322012058", "story_v_out_322012.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_322012", "322012058", "story_v_out_322012.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_12 = math.max(var_251_3, arg_248_1.talkMaxDuration)

			if var_251_2 <= arg_248_1.time_ and arg_248_1.time_ < var_251_2 + var_251_12 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_2) / var_251_12

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_2 + var_251_12 and arg_248_1.time_ < var_251_2 + var_251_12 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play322012059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 322012059
		arg_252_1.duration_ = 12.3

		local var_252_0 = {
			zh = 6.9,
			ja = 12.3
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play322012060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10104ui_story"].transform
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.var_.moveOldPos10104ui_story = var_255_0.localPosition
			end

			local var_255_2 = 0.001

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2
				local var_255_4 = Vector3.New(0.99, -1.12, -5.99)

				var_255_0.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10104ui_story, var_255_4, var_255_3)

				local var_255_5 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_5.x, var_255_5.y, var_255_5.z)

				local var_255_6 = var_255_0.localEulerAngles

				var_255_6.z = 0
				var_255_6.x = 0
				var_255_0.localEulerAngles = var_255_6
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 then
				var_255_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_255_7 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_7.x, var_255_7.y, var_255_7.z)

				local var_255_8 = var_255_0.localEulerAngles

				var_255_8.z = 0
				var_255_8.x = 0
				var_255_0.localEulerAngles = var_255_8
			end

			local var_255_9 = arg_252_1.actors_["1061ui_story"].transform
			local var_255_10 = 0

			if var_255_10 < arg_252_1.time_ and arg_252_1.time_ <= var_255_10 + arg_255_0 then
				arg_252_1.var_.moveOldPos1061ui_story = var_255_9.localPosition
			end

			local var_255_11 = 0.001

			if var_255_10 <= arg_252_1.time_ and arg_252_1.time_ < var_255_10 + var_255_11 then
				local var_255_12 = (arg_252_1.time_ - var_255_10) / var_255_11
				local var_255_13 = Vector3.New(-0.7, -1.18, -6.15)

				var_255_9.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1061ui_story, var_255_13, var_255_12)

				local var_255_14 = manager.ui.mainCamera.transform.position - var_255_9.position

				var_255_9.forward = Vector3.New(var_255_14.x, var_255_14.y, var_255_14.z)

				local var_255_15 = var_255_9.localEulerAngles

				var_255_15.z = 0
				var_255_15.x = 0
				var_255_9.localEulerAngles = var_255_15
			end

			if arg_252_1.time_ >= var_255_10 + var_255_11 and arg_252_1.time_ < var_255_10 + var_255_11 + arg_255_0 then
				var_255_9.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_255_16 = manager.ui.mainCamera.transform.position - var_255_9.position

				var_255_9.forward = Vector3.New(var_255_16.x, var_255_16.y, var_255_16.z)

				local var_255_17 = var_255_9.localEulerAngles

				var_255_17.z = 0
				var_255_17.x = 0
				var_255_9.localEulerAngles = var_255_17
			end

			local var_255_18 = arg_252_1.actors_["10104ui_story"]
			local var_255_19 = 0

			if var_255_19 < arg_252_1.time_ and arg_252_1.time_ <= var_255_19 + arg_255_0 and not isNil(var_255_18) and arg_252_1.var_.characterEffect10104ui_story == nil then
				arg_252_1.var_.characterEffect10104ui_story = var_255_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_20 = 0.200000002980232

			if var_255_19 <= arg_252_1.time_ and arg_252_1.time_ < var_255_19 + var_255_20 and not isNil(var_255_18) then
				local var_255_21 = (arg_252_1.time_ - var_255_19) / var_255_20

				if arg_252_1.var_.characterEffect10104ui_story and not isNil(var_255_18) then
					arg_252_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_19 + var_255_20 and arg_252_1.time_ < var_255_19 + var_255_20 + arg_255_0 and not isNil(var_255_18) and arg_252_1.var_.characterEffect10104ui_story then
				arg_252_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_255_22 = arg_252_1.actors_["1061ui_story"]
			local var_255_23 = 0

			if var_255_23 < arg_252_1.time_ and arg_252_1.time_ <= var_255_23 + arg_255_0 and not isNil(var_255_22) and arg_252_1.var_.characterEffect1061ui_story == nil then
				arg_252_1.var_.characterEffect1061ui_story = var_255_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_24 = 0.200000002980232

			if var_255_23 <= arg_252_1.time_ and arg_252_1.time_ < var_255_23 + var_255_24 and not isNil(var_255_22) then
				local var_255_25 = (arg_252_1.time_ - var_255_23) / var_255_24

				if arg_252_1.var_.characterEffect1061ui_story and not isNil(var_255_22) then
					local var_255_26 = Mathf.Lerp(0, 0.5, var_255_25)

					arg_252_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1061ui_story.fillRatio = var_255_26
				end
			end

			if arg_252_1.time_ >= var_255_23 + var_255_24 and arg_252_1.time_ < var_255_23 + var_255_24 + arg_255_0 and not isNil(var_255_22) and arg_252_1.var_.characterEffect1061ui_story then
				local var_255_27 = 0.5

				arg_252_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1061ui_story.fillRatio = var_255_27
			end

			local var_255_28 = 0

			if var_255_28 < arg_252_1.time_ and arg_252_1.time_ <= var_255_28 + arg_255_0 then
				arg_252_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_255_29 = 0

			if var_255_29 < arg_252_1.time_ and arg_252_1.time_ <= var_255_29 + arg_255_0 then
				arg_252_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_255_30 = 0
			local var_255_31 = 0.825

			if var_255_30 < arg_252_1.time_ and arg_252_1.time_ <= var_255_30 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_32 = arg_252_1:FormatText(StoryNameCfg[1030].name)

				arg_252_1.leftNameTxt_.text = var_255_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_33 = arg_252_1:GetWordFromCfg(322012059)
				local var_255_34 = arg_252_1:FormatText(var_255_33.content)

				arg_252_1.text_.text = var_255_34

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_35 = 33
				local var_255_36 = utf8.len(var_255_34)
				local var_255_37 = var_255_35 <= 0 and var_255_31 or var_255_31 * (var_255_36 / var_255_35)

				if var_255_37 > 0 and var_255_31 < var_255_37 then
					arg_252_1.talkMaxDuration = var_255_37

					if var_255_37 + var_255_30 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_37 + var_255_30
					end
				end

				arg_252_1.text_.text = var_255_34
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012059", "story_v_out_322012.awb") ~= 0 then
					local var_255_38 = manager.audio:GetVoiceLength("story_v_out_322012", "322012059", "story_v_out_322012.awb") / 1000

					if var_255_38 + var_255_30 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_38 + var_255_30
					end

					if var_255_33.prefab_name ~= "" and arg_252_1.actors_[var_255_33.prefab_name] ~= nil then
						local var_255_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_33.prefab_name].transform, "story_v_out_322012", "322012059", "story_v_out_322012.awb")

						arg_252_1:RecordAudio("322012059", var_255_39)
						arg_252_1:RecordAudio("322012059", var_255_39)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_322012", "322012059", "story_v_out_322012.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_322012", "322012059", "story_v_out_322012.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_40 = math.max(var_255_31, arg_252_1.talkMaxDuration)

			if var_255_30 <= arg_252_1.time_ and arg_252_1.time_ < var_255_30 + var_255_40 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_30) / var_255_40

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_30 + var_255_40 and arg_252_1.time_ < var_255_30 + var_255_40 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_252_1:InitPlayNodeList()
	end,
	Play322012060 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 322012060
		arg_256_1.duration_ = 2.07

		local var_256_0 = {
			zh = 1.999999999999,
			ja = 2.066
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play322012061(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1061ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1061ui_story == nil then
				arg_256_1.var_.characterEffect1061ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect1061ui_story and not isNil(var_259_0) then
					arg_256_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1061ui_story then
				arg_256_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_259_4 = arg_256_1.actors_["10104ui_story"]
			local var_259_5 = 0

			if var_259_5 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 and not isNil(var_259_4) and arg_256_1.var_.characterEffect10104ui_story == nil then
				arg_256_1.var_.characterEffect10104ui_story = var_259_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_6 = 0.200000002980232

			if var_259_5 <= arg_256_1.time_ and arg_256_1.time_ < var_259_5 + var_259_6 and not isNil(var_259_4) then
				local var_259_7 = (arg_256_1.time_ - var_259_5) / var_259_6

				if arg_256_1.var_.characterEffect10104ui_story and not isNil(var_259_4) then
					local var_259_8 = Mathf.Lerp(0, 0.5, var_259_7)

					arg_256_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_256_1.var_.characterEffect10104ui_story.fillRatio = var_259_8
				end
			end

			if arg_256_1.time_ >= var_259_5 + var_259_6 and arg_256_1.time_ < var_259_5 + var_259_6 + arg_259_0 and not isNil(var_259_4) and arg_256_1.var_.characterEffect10104ui_story then
				local var_259_9 = 0.5

				arg_256_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_256_1.var_.characterEffect10104ui_story.fillRatio = var_259_9
			end

			local var_259_10 = 0

			if var_259_10 < arg_256_1.time_ and arg_256_1.time_ <= var_259_10 + arg_259_0 then
				arg_256_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_259_11 = 0

			if var_259_11 < arg_256_1.time_ and arg_256_1.time_ <= var_259_11 + arg_259_0 then
				arg_256_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_259_12 = 0
			local var_259_13 = 0.125

			if var_259_12 < arg_256_1.time_ and arg_256_1.time_ <= var_259_12 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_14 = arg_256_1:FormatText(StoryNameCfg[612].name)

				arg_256_1.leftNameTxt_.text = var_259_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_15 = arg_256_1:GetWordFromCfg(322012060)
				local var_259_16 = arg_256_1:FormatText(var_259_15.content)

				arg_256_1.text_.text = var_259_16

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_17 = 5
				local var_259_18 = utf8.len(var_259_16)
				local var_259_19 = var_259_17 <= 0 and var_259_13 or var_259_13 * (var_259_18 / var_259_17)

				if var_259_19 > 0 and var_259_13 < var_259_19 then
					arg_256_1.talkMaxDuration = var_259_19

					if var_259_19 + var_259_12 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_19 + var_259_12
					end
				end

				arg_256_1.text_.text = var_259_16
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012060", "story_v_out_322012.awb") ~= 0 then
					local var_259_20 = manager.audio:GetVoiceLength("story_v_out_322012", "322012060", "story_v_out_322012.awb") / 1000

					if var_259_20 + var_259_12 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_20 + var_259_12
					end

					if var_259_15.prefab_name ~= "" and arg_256_1.actors_[var_259_15.prefab_name] ~= nil then
						local var_259_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_15.prefab_name].transform, "story_v_out_322012", "322012060", "story_v_out_322012.awb")

						arg_256_1:RecordAudio("322012060", var_259_21)
						arg_256_1:RecordAudio("322012060", var_259_21)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_322012", "322012060", "story_v_out_322012.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_322012", "322012060", "story_v_out_322012.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_22 = math.max(var_259_13, arg_256_1.talkMaxDuration)

			if var_259_12 <= arg_256_1.time_ and arg_256_1.time_ < var_259_12 + var_259_22 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_12) / var_259_22

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_12 + var_259_22 and arg_256_1.time_ < var_259_12 + var_259_22 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play322012061 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 322012061
		arg_260_1.duration_ = 8.5

		local var_260_0 = {
			zh = 6.933,
			ja = 8.5
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play322012062(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = "1284ui_story"

			if arg_260_1.actors_[var_263_0] == nil then
				local var_263_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_263_1) then
					local var_263_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_260_1.stage_.transform)

					var_263_2.name = var_263_0
					var_263_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_260_1.actors_[var_263_0] = var_263_2

					local var_263_3 = var_263_2:GetComponentInChildren(typeof(CharacterEffect))

					var_263_3.enabled = true

					local var_263_4 = GameObjectTools.GetOrAddComponent(var_263_2, typeof(DynamicBoneHelper))

					if var_263_4 then
						var_263_4:EnableDynamicBone(false)
					end

					arg_260_1:ShowWeapon(var_263_3.transform, false)

					arg_260_1.var_[var_263_0 .. "Animator"] = var_263_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_260_1.var_[var_263_0 .. "Animator"].applyRootMotion = true
					arg_260_1.var_[var_263_0 .. "LipSync"] = var_263_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_263_5 = arg_260_1.actors_["1284ui_story"].transform
			local var_263_6 = 0

			if var_263_6 < arg_260_1.time_ and arg_260_1.time_ <= var_263_6 + arg_263_0 then
				arg_260_1.var_.moveOldPos1284ui_story = var_263_5.localPosition

				local var_263_7 = "1284ui_story"

				arg_260_1:ShowWeapon(arg_260_1.var_[var_263_7 .. "Animator"].transform, false)
			end

			local var_263_8 = 0.001

			if var_263_6 <= arg_260_1.time_ and arg_260_1.time_ < var_263_6 + var_263_8 then
				local var_263_9 = (arg_260_1.time_ - var_263_6) / var_263_8
				local var_263_10 = Vector3.New(0.7, -0.985, -6.22)

				var_263_5.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1284ui_story, var_263_10, var_263_9)

				local var_263_11 = manager.ui.mainCamera.transform.position - var_263_5.position

				var_263_5.forward = Vector3.New(var_263_11.x, var_263_11.y, var_263_11.z)

				local var_263_12 = var_263_5.localEulerAngles

				var_263_12.z = 0
				var_263_12.x = 0
				var_263_5.localEulerAngles = var_263_12
			end

			if arg_260_1.time_ >= var_263_6 + var_263_8 and arg_260_1.time_ < var_263_6 + var_263_8 + arg_263_0 then
				var_263_5.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_263_13 = manager.ui.mainCamera.transform.position - var_263_5.position

				var_263_5.forward = Vector3.New(var_263_13.x, var_263_13.y, var_263_13.z)

				local var_263_14 = var_263_5.localEulerAngles

				var_263_14.z = 0
				var_263_14.x = 0
				var_263_5.localEulerAngles = var_263_14
			end

			local var_263_15 = arg_260_1.actors_["10104ui_story"].transform
			local var_263_16 = 0

			if var_263_16 < arg_260_1.time_ and arg_260_1.time_ <= var_263_16 + arg_263_0 then
				arg_260_1.var_.moveOldPos10104ui_story = var_263_15.localPosition
			end

			local var_263_17 = 0.001

			if var_263_16 <= arg_260_1.time_ and arg_260_1.time_ < var_263_16 + var_263_17 then
				local var_263_18 = (arg_260_1.time_ - var_263_16) / var_263_17
				local var_263_19 = Vector3.New(0, 100, 0)

				var_263_15.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10104ui_story, var_263_19, var_263_18)

				local var_263_20 = manager.ui.mainCamera.transform.position - var_263_15.position

				var_263_15.forward = Vector3.New(var_263_20.x, var_263_20.y, var_263_20.z)

				local var_263_21 = var_263_15.localEulerAngles

				var_263_21.z = 0
				var_263_21.x = 0
				var_263_15.localEulerAngles = var_263_21
			end

			if arg_260_1.time_ >= var_263_16 + var_263_17 and arg_260_1.time_ < var_263_16 + var_263_17 + arg_263_0 then
				var_263_15.localPosition = Vector3.New(0, 100, 0)

				local var_263_22 = manager.ui.mainCamera.transform.position - var_263_15.position

				var_263_15.forward = Vector3.New(var_263_22.x, var_263_22.y, var_263_22.z)

				local var_263_23 = var_263_15.localEulerAngles

				var_263_23.z = 0
				var_263_23.x = 0
				var_263_15.localEulerAngles = var_263_23
			end

			local var_263_24 = arg_260_1.actors_["1284ui_story"]
			local var_263_25 = 0

			if var_263_25 < arg_260_1.time_ and arg_260_1.time_ <= var_263_25 + arg_263_0 and not isNil(var_263_24) and arg_260_1.var_.characterEffect1284ui_story == nil then
				arg_260_1.var_.characterEffect1284ui_story = var_263_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_26 = 0.200000002980232

			if var_263_25 <= arg_260_1.time_ and arg_260_1.time_ < var_263_25 + var_263_26 and not isNil(var_263_24) then
				local var_263_27 = (arg_260_1.time_ - var_263_25) / var_263_26

				if arg_260_1.var_.characterEffect1284ui_story and not isNil(var_263_24) then
					arg_260_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= var_263_25 + var_263_26 and arg_260_1.time_ < var_263_25 + var_263_26 + arg_263_0 and not isNil(var_263_24) and arg_260_1.var_.characterEffect1284ui_story then
				arg_260_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_263_28 = arg_260_1.actors_["1061ui_story"]
			local var_263_29 = 0

			if var_263_29 < arg_260_1.time_ and arg_260_1.time_ <= var_263_29 + arg_263_0 and not isNil(var_263_28) and arg_260_1.var_.characterEffect1061ui_story == nil then
				arg_260_1.var_.characterEffect1061ui_story = var_263_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_30 = 0.200000002980232

			if var_263_29 <= arg_260_1.time_ and arg_260_1.time_ < var_263_29 + var_263_30 and not isNil(var_263_28) then
				local var_263_31 = (arg_260_1.time_ - var_263_29) / var_263_30

				if arg_260_1.var_.characterEffect1061ui_story and not isNil(var_263_28) then
					local var_263_32 = Mathf.Lerp(0, 0.5, var_263_31)

					arg_260_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1061ui_story.fillRatio = var_263_32
				end
			end

			if arg_260_1.time_ >= var_263_29 + var_263_30 and arg_260_1.time_ < var_263_29 + var_263_30 + arg_263_0 and not isNil(var_263_28) and arg_260_1.var_.characterEffect1061ui_story then
				local var_263_33 = 0.5

				arg_260_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1061ui_story.fillRatio = var_263_33
			end

			local var_263_34 = 0

			if var_263_34 < arg_260_1.time_ and arg_260_1.time_ <= var_263_34 + arg_263_0 then
				arg_260_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_263_35 = 0

			if var_263_35 < arg_260_1.time_ and arg_260_1.time_ <= var_263_35 + arg_263_0 then
				arg_260_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_263_36 = 0
			local var_263_37 = 0.85

			if var_263_36 < arg_260_1.time_ and arg_260_1.time_ <= var_263_36 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_38 = arg_260_1:FormatText(StoryNameCfg[6].name)

				arg_260_1.leftNameTxt_.text = var_263_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_39 = arg_260_1:GetWordFromCfg(322012061)
				local var_263_40 = arg_260_1:FormatText(var_263_39.content)

				arg_260_1.text_.text = var_263_40

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_41 = 34
				local var_263_42 = utf8.len(var_263_40)
				local var_263_43 = var_263_41 <= 0 and var_263_37 or var_263_37 * (var_263_42 / var_263_41)

				if var_263_43 > 0 and var_263_37 < var_263_43 then
					arg_260_1.talkMaxDuration = var_263_43

					if var_263_43 + var_263_36 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_43 + var_263_36
					end
				end

				arg_260_1.text_.text = var_263_40
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012061", "story_v_out_322012.awb") ~= 0 then
					local var_263_44 = manager.audio:GetVoiceLength("story_v_out_322012", "322012061", "story_v_out_322012.awb") / 1000

					if var_263_44 + var_263_36 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_44 + var_263_36
					end

					if var_263_39.prefab_name ~= "" and arg_260_1.actors_[var_263_39.prefab_name] ~= nil then
						local var_263_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_39.prefab_name].transform, "story_v_out_322012", "322012061", "story_v_out_322012.awb")

						arg_260_1:RecordAudio("322012061", var_263_45)
						arg_260_1:RecordAudio("322012061", var_263_45)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_322012", "322012061", "story_v_out_322012.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_322012", "322012061", "story_v_out_322012.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_46 = math.max(var_263_37, arg_260_1.talkMaxDuration)

			if var_263_36 <= arg_260_1.time_ and arg_260_1.time_ < var_263_36 + var_263_46 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_36) / var_263_46

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_36 + var_263_46 and arg_260_1.time_ < var_263_36 + var_263_46 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play322012062 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 322012062
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play322012063(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1284ui_story"].transform
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.var_.moveOldPos1284ui_story = var_267_0.localPosition
			end

			local var_267_2 = 0.001

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2
				local var_267_4 = Vector3.New(0, 100, 0)

				var_267_0.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1284ui_story, var_267_4, var_267_3)

				local var_267_5 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_5.x, var_267_5.y, var_267_5.z)

				local var_267_6 = var_267_0.localEulerAngles

				var_267_6.z = 0
				var_267_6.x = 0
				var_267_0.localEulerAngles = var_267_6
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 then
				var_267_0.localPosition = Vector3.New(0, 100, 0)

				local var_267_7 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_7.x, var_267_7.y, var_267_7.z)

				local var_267_8 = var_267_0.localEulerAngles

				var_267_8.z = 0
				var_267_8.x = 0
				var_267_0.localEulerAngles = var_267_8
			end

			local var_267_9 = arg_264_1.actors_["1061ui_story"].transform
			local var_267_10 = 0

			if var_267_10 < arg_264_1.time_ and arg_264_1.time_ <= var_267_10 + arg_267_0 then
				arg_264_1.var_.moveOldPos1061ui_story = var_267_9.localPosition
			end

			local var_267_11 = 0.001

			if var_267_10 <= arg_264_1.time_ and arg_264_1.time_ < var_267_10 + var_267_11 then
				local var_267_12 = (arg_264_1.time_ - var_267_10) / var_267_11
				local var_267_13 = Vector3.New(0, 100, 0)

				var_267_9.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1061ui_story, var_267_13, var_267_12)

				local var_267_14 = manager.ui.mainCamera.transform.position - var_267_9.position

				var_267_9.forward = Vector3.New(var_267_14.x, var_267_14.y, var_267_14.z)

				local var_267_15 = var_267_9.localEulerAngles

				var_267_15.z = 0
				var_267_15.x = 0
				var_267_9.localEulerAngles = var_267_15
			end

			if arg_264_1.time_ >= var_267_10 + var_267_11 and arg_264_1.time_ < var_267_10 + var_267_11 + arg_267_0 then
				var_267_9.localPosition = Vector3.New(0, 100, 0)

				local var_267_16 = manager.ui.mainCamera.transform.position - var_267_9.position

				var_267_9.forward = Vector3.New(var_267_16.x, var_267_16.y, var_267_16.z)

				local var_267_17 = var_267_9.localEulerAngles

				var_267_17.z = 0
				var_267_17.x = 0
				var_267_9.localEulerAngles = var_267_17
			end

			local var_267_18 = 0
			local var_267_19 = 0.65

			if var_267_18 < arg_264_1.time_ and arg_264_1.time_ <= var_267_18 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_20 = arg_264_1:GetWordFromCfg(322012062)
				local var_267_21 = arg_264_1:FormatText(var_267_20.content)

				arg_264_1.text_.text = var_267_21

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_22 = 26
				local var_267_23 = utf8.len(var_267_21)
				local var_267_24 = var_267_22 <= 0 and var_267_19 or var_267_19 * (var_267_23 / var_267_22)

				if var_267_24 > 0 and var_267_19 < var_267_24 then
					arg_264_1.talkMaxDuration = var_267_24

					if var_267_24 + var_267_18 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_24 + var_267_18
					end
				end

				arg_264_1.text_.text = var_267_21
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_25 = math.max(var_267_19, arg_264_1.talkMaxDuration)

			if var_267_18 <= arg_264_1.time_ and arg_264_1.time_ < var_267_18 + var_267_25 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_18) / var_267_25

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_18 + var_267_25 and arg_264_1.time_ < var_267_18 + var_267_25 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_264_1:InitPlayNodeList()
	end,
	Play322012063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 322012063
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play322012064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 0.3

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				local var_271_2 = "play"
				local var_271_3 = "music"

				arg_268_1:AudioAction(var_271_2, var_271_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_271_4 = ""
				local var_271_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_271_5 ~= "" then
					if arg_268_1.bgmTxt_.text ~= var_271_5 and arg_268_1.bgmTxt_.text ~= "" then
						if arg_268_1.bgmTxt2_.text ~= "" then
							arg_268_1.bgmTxt_.text = arg_268_1.bgmTxt2_.text
						end

						arg_268_1.bgmTxt2_.text = var_271_5

						arg_268_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_268_1.bgmTxt_.text = var_271_5
						arg_268_1.bgmTxt2_.text = var_271_5
					end

					if arg_268_1.bgmTimer then
						arg_268_1.bgmTimer:Stop()

						arg_268_1.bgmTimer = nil
					end

					if arg_268_1.settingData.show_music_name == 1 then
						arg_268_1.musicController:SetSelectedState("show")
						arg_268_1.musicAnimator_:Play("open", 0, 0)

						if arg_268_1.settingData.music_time ~= 0 then
							arg_268_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_268_1.settingData.music_time), function()
								if arg_268_1 == nil or isNil(arg_268_1.bgmTxt_) then
									return
								end

								arg_268_1.musicController:SetSelectedState("hide")
								arg_268_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_271_6 = 0
			local var_271_7 = 1.225

			if var_271_6 < arg_268_1.time_ and arg_268_1.time_ <= var_271_6 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_8 = arg_268_1:GetWordFromCfg(322012063)
				local var_271_9 = arg_268_1:FormatText(var_271_8.content)

				arg_268_1.text_.text = var_271_9

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_10 = 49
				local var_271_11 = utf8.len(var_271_9)
				local var_271_12 = var_271_10 <= 0 and var_271_7 or var_271_7 * (var_271_11 / var_271_10)

				if var_271_12 > 0 and var_271_7 < var_271_12 then
					arg_268_1.talkMaxDuration = var_271_12

					if var_271_12 + var_271_6 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_12 + var_271_6
					end
				end

				arg_268_1.text_.text = var_271_9
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_13 = math.max(var_271_7, arg_268_1.talkMaxDuration)

			if var_271_6 <= arg_268_1.time_ and arg_268_1.time_ < var_271_6 + var_271_13 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_6) / var_271_13

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_6 + var_271_13 and arg_268_1.time_ < var_271_6 + var_271_13 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play322012064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322012064
		arg_273_1.duration_ = 3.1

		local var_273_0 = {
			zh = 3,
			ja = 3.1
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play322012065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10104ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos10104ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(-0.88, -1.12, -5.99)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10104ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(-0.88, -1.12, -5.99)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = arg_273_1.actors_["10104ui_story"]
			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect10104ui_story == nil then
				arg_273_1.var_.characterEffect10104ui_story = var_276_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_11 = 0.200000002980232

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_11 and not isNil(var_276_9) then
				local var_276_12 = (arg_273_1.time_ - var_276_10) / var_276_11

				if arg_273_1.var_.characterEffect10104ui_story and not isNil(var_276_9) then
					arg_273_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_10 + var_276_11 and arg_273_1.time_ < var_276_10 + var_276_11 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect10104ui_story then
				arg_273_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_276_13 = 0

			if var_276_13 < arg_273_1.time_ and arg_273_1.time_ <= var_276_13 + arg_276_0 then
				arg_273_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			local var_276_14 = 0

			if var_276_14 < arg_273_1.time_ and arg_273_1.time_ <= var_276_14 + arg_276_0 then
				arg_273_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_276_15 = 0
			local var_276_16 = 0.3

			if var_276_15 < arg_273_1.time_ and arg_273_1.time_ <= var_276_15 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_17 = arg_273_1:FormatText(StoryNameCfg[1030].name)

				arg_273_1.leftNameTxt_.text = var_276_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_18 = arg_273_1:GetWordFromCfg(322012064)
				local var_276_19 = arg_273_1:FormatText(var_276_18.content)

				arg_273_1.text_.text = var_276_19

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_20 = 12
				local var_276_21 = utf8.len(var_276_19)
				local var_276_22 = var_276_20 <= 0 and var_276_16 or var_276_16 * (var_276_21 / var_276_20)

				if var_276_22 > 0 and var_276_16 < var_276_22 then
					arg_273_1.talkMaxDuration = var_276_22

					if var_276_22 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_22 + var_276_15
					end
				end

				arg_273_1.text_.text = var_276_19
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012064", "story_v_out_322012.awb") ~= 0 then
					local var_276_23 = manager.audio:GetVoiceLength("story_v_out_322012", "322012064", "story_v_out_322012.awb") / 1000

					if var_276_23 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_23 + var_276_15
					end

					if var_276_18.prefab_name ~= "" and arg_273_1.actors_[var_276_18.prefab_name] ~= nil then
						local var_276_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_18.prefab_name].transform, "story_v_out_322012", "322012064", "story_v_out_322012.awb")

						arg_273_1:RecordAudio("322012064", var_276_24)
						arg_273_1:RecordAudio("322012064", var_276_24)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322012", "322012064", "story_v_out_322012.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322012", "322012064", "story_v_out_322012.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_25 = math.max(var_276_16, arg_273_1.talkMaxDuration)

			if var_276_15 <= arg_273_1.time_ and arg_273_1.time_ < var_276_15 + var_276_25 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_15) / var_276_25

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_15 + var_276_25 and arg_273_1.time_ < var_276_15 + var_276_25 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play322012065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322012065
		arg_277_1.duration_ = 2.2

		local var_277_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_277_0:Play322012066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1284ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1284ui_story = var_280_0.localPosition

				local var_280_2 = "1284ui_story"

				arg_277_1:ShowWeapon(arg_277_1.var_[var_280_2 .. "Animator"].transform, false)
			end

			local var_280_3 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_3 then
				local var_280_4 = (arg_277_1.time_ - var_280_1) / var_280_3
				local var_280_5 = Vector3.New(0.7, -0.985, -6.22)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1284ui_story, var_280_5, var_280_4)

				local var_280_6 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_6.x, var_280_6.y, var_280_6.z)

				local var_280_7 = var_280_0.localEulerAngles

				var_280_7.z = 0
				var_280_7.x = 0
				var_280_0.localEulerAngles = var_280_7
			end

			if arg_277_1.time_ >= var_280_1 + var_280_3 and arg_277_1.time_ < var_280_1 + var_280_3 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_280_8 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_8.x, var_280_8.y, var_280_8.z)

				local var_280_9 = var_280_0.localEulerAngles

				var_280_9.z = 0
				var_280_9.x = 0
				var_280_0.localEulerAngles = var_280_9
			end

			local var_280_10 = arg_277_1.actors_["1284ui_story"]
			local var_280_11 = 0

			if var_280_11 < arg_277_1.time_ and arg_277_1.time_ <= var_280_11 + arg_280_0 and not isNil(var_280_10) and arg_277_1.var_.characterEffect1284ui_story == nil then
				arg_277_1.var_.characterEffect1284ui_story = var_280_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_12 = 0.200000002980232

			if var_280_11 <= arg_277_1.time_ and arg_277_1.time_ < var_280_11 + var_280_12 and not isNil(var_280_10) then
				local var_280_13 = (arg_277_1.time_ - var_280_11) / var_280_12

				if arg_277_1.var_.characterEffect1284ui_story and not isNil(var_280_10) then
					arg_277_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_11 + var_280_12 and arg_277_1.time_ < var_280_11 + var_280_12 + arg_280_0 and not isNil(var_280_10) and arg_277_1.var_.characterEffect1284ui_story then
				arg_277_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_280_14 = arg_277_1.actors_["10104ui_story"]
			local var_280_15 = 0

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 and not isNil(var_280_14) and arg_277_1.var_.characterEffect10104ui_story == nil then
				arg_277_1.var_.characterEffect10104ui_story = var_280_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_16 = 0.200000002980232

			if var_280_15 <= arg_277_1.time_ and arg_277_1.time_ < var_280_15 + var_280_16 and not isNil(var_280_14) then
				local var_280_17 = (arg_277_1.time_ - var_280_15) / var_280_16

				if arg_277_1.var_.characterEffect10104ui_story and not isNil(var_280_14) then
					local var_280_18 = Mathf.Lerp(0, 0.5, var_280_17)

					arg_277_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10104ui_story.fillRatio = var_280_18
				end
			end

			if arg_277_1.time_ >= var_280_15 + var_280_16 and arg_277_1.time_ < var_280_15 + var_280_16 + arg_280_0 and not isNil(var_280_14) and arg_277_1.var_.characterEffect10104ui_story then
				local var_280_19 = 0.5

				arg_277_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10104ui_story.fillRatio = var_280_19
			end

			local var_280_20 = 0

			if var_280_20 < arg_277_1.time_ and arg_277_1.time_ <= var_280_20 + arg_280_0 then
				arg_277_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_280_21 = 0

			if var_280_21 < arg_277_1.time_ and arg_277_1.time_ <= var_280_21 + arg_280_0 then
				arg_277_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_280_22 = 0
			local var_280_23 = 0.075

			if var_280_22 < arg_277_1.time_ and arg_277_1.time_ <= var_280_22 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_24 = arg_277_1:FormatText(StoryNameCfg[6].name)

				arg_277_1.leftNameTxt_.text = var_280_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_25 = arg_277_1:GetWordFromCfg(322012065)
				local var_280_26 = arg_277_1:FormatText(var_280_25.content)

				arg_277_1.text_.text = var_280_26

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_27 = 3
				local var_280_28 = utf8.len(var_280_26)
				local var_280_29 = var_280_27 <= 0 and var_280_23 or var_280_23 * (var_280_28 / var_280_27)

				if var_280_29 > 0 and var_280_23 < var_280_29 then
					arg_277_1.talkMaxDuration = var_280_29

					if var_280_29 + var_280_22 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_29 + var_280_22
					end
				end

				arg_277_1.text_.text = var_280_26
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012065", "story_v_out_322012.awb") ~= 0 then
					local var_280_30 = manager.audio:GetVoiceLength("story_v_out_322012", "322012065", "story_v_out_322012.awb") / 1000

					if var_280_30 + var_280_22 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_30 + var_280_22
					end

					if var_280_25.prefab_name ~= "" and arg_277_1.actors_[var_280_25.prefab_name] ~= nil then
						local var_280_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_25.prefab_name].transform, "story_v_out_322012", "322012065", "story_v_out_322012.awb")

						arg_277_1:RecordAudio("322012065", var_280_31)
						arg_277_1:RecordAudio("322012065", var_280_31)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322012", "322012065", "story_v_out_322012.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322012", "322012065", "story_v_out_322012.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_32 = math.max(var_280_23, arg_277_1.talkMaxDuration)

			if var_280_22 <= arg_277_1.time_ and arg_277_1.time_ < var_280_22 + var_280_32 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_22) / var_280_32

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_22 + var_280_32 and arg_277_1.time_ < var_280_22 + var_280_32 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322012066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322012066
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play322012067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10104ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos10104ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0, 100, 0)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10104ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, 100, 0)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = arg_281_1.actors_["1284ui_story"].transform
			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 then
				arg_281_1.var_.moveOldPos1284ui_story = var_284_9.localPosition
			end

			local var_284_11 = 0.001

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_11 then
				local var_284_12 = (arg_281_1.time_ - var_284_10) / var_284_11
				local var_284_13 = Vector3.New(0, 100, 0)

				var_284_9.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1284ui_story, var_284_13, var_284_12)

				local var_284_14 = manager.ui.mainCamera.transform.position - var_284_9.position

				var_284_9.forward = Vector3.New(var_284_14.x, var_284_14.y, var_284_14.z)

				local var_284_15 = var_284_9.localEulerAngles

				var_284_15.z = 0
				var_284_15.x = 0
				var_284_9.localEulerAngles = var_284_15
			end

			if arg_281_1.time_ >= var_284_10 + var_284_11 and arg_281_1.time_ < var_284_10 + var_284_11 + arg_284_0 then
				var_284_9.localPosition = Vector3.New(0, 100, 0)

				local var_284_16 = manager.ui.mainCamera.transform.position - var_284_9.position

				var_284_9.forward = Vector3.New(var_284_16.x, var_284_16.y, var_284_16.z)

				local var_284_17 = var_284_9.localEulerAngles

				var_284_17.z = 0
				var_284_17.x = 0
				var_284_9.localEulerAngles = var_284_17
			end

			local var_284_18 = 0
			local var_284_19 = 1.175

			if var_284_18 < arg_281_1.time_ and arg_281_1.time_ <= var_284_18 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_20 = arg_281_1:GetWordFromCfg(322012066)
				local var_284_21 = arg_281_1:FormatText(var_284_20.content)

				arg_281_1.text_.text = var_284_21

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_22 = 47
				local var_284_23 = utf8.len(var_284_21)
				local var_284_24 = var_284_22 <= 0 and var_284_19 or var_284_19 * (var_284_23 / var_284_22)

				if var_284_24 > 0 and var_284_19 < var_284_24 then
					arg_281_1.talkMaxDuration = var_284_24

					if var_284_24 + var_284_18 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_24 + var_284_18
					end
				end

				arg_281_1.text_.text = var_284_21
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_25 = math.max(var_284_19, arg_281_1.talkMaxDuration)

			if var_284_18 <= arg_281_1.time_ and arg_281_1.time_ < var_284_18 + var_284_25 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_18) / var_284_25

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_18 + var_284_25 and arg_281_1.time_ < var_284_18 + var_284_25 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322012067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322012067
		arg_285_1.duration_ = 3.4

		local var_285_0 = {
			zh = 1.999999999999,
			ja = 3.4
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
				arg_285_0:Play322012068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10104ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos10104ui_story = var_288_0.localPosition
			end

			local var_288_2 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2
				local var_288_4 = Vector3.New(0.02, -1.12, -5.99)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10104ui_story, var_288_4, var_288_3)

				local var_288_5 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_5.x, var_288_5.y, var_288_5.z)

				local var_288_6 = var_288_0.localEulerAngles

				var_288_6.z = 0
				var_288_6.x = 0
				var_288_0.localEulerAngles = var_288_6
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_288_7 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_7.x, var_288_7.y, var_288_7.z)

				local var_288_8 = var_288_0.localEulerAngles

				var_288_8.z = 0
				var_288_8.x = 0
				var_288_0.localEulerAngles = var_288_8
			end

			local var_288_9 = arg_285_1.actors_["10104ui_story"]
			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect10104ui_story == nil then
				arg_285_1.var_.characterEffect10104ui_story = var_288_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_11 = 0.200000002980232

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_11 and not isNil(var_288_9) then
				local var_288_12 = (arg_285_1.time_ - var_288_10) / var_288_11

				if arg_285_1.var_.characterEffect10104ui_story and not isNil(var_288_9) then
					arg_285_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_10 + var_288_11 and arg_285_1.time_ < var_288_10 + var_288_11 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect10104ui_story then
				arg_285_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_288_13 = 0

			if var_288_13 < arg_285_1.time_ and arg_285_1.time_ <= var_288_13 + arg_288_0 then
				arg_285_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_288_14 = 0

			if var_288_14 < arg_285_1.time_ and arg_285_1.time_ <= var_288_14 + arg_288_0 then
				arg_285_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_288_15 = 0
			local var_288_16 = 0.2

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_17 = arg_285_1:FormatText(StoryNameCfg[1030].name)

				arg_285_1.leftNameTxt_.text = var_288_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_18 = arg_285_1:GetWordFromCfg(322012067)
				local var_288_19 = arg_285_1:FormatText(var_288_18.content)

				arg_285_1.text_.text = var_288_19

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_20 = 8
				local var_288_21 = utf8.len(var_288_19)
				local var_288_22 = var_288_20 <= 0 and var_288_16 or var_288_16 * (var_288_21 / var_288_20)

				if var_288_22 > 0 and var_288_16 < var_288_22 then
					arg_285_1.talkMaxDuration = var_288_22

					if var_288_22 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_22 + var_288_15
					end
				end

				arg_285_1.text_.text = var_288_19
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012067", "story_v_out_322012.awb") ~= 0 then
					local var_288_23 = manager.audio:GetVoiceLength("story_v_out_322012", "322012067", "story_v_out_322012.awb") / 1000

					if var_288_23 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_23 + var_288_15
					end

					if var_288_18.prefab_name ~= "" and arg_285_1.actors_[var_288_18.prefab_name] ~= nil then
						local var_288_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_18.prefab_name].transform, "story_v_out_322012", "322012067", "story_v_out_322012.awb")

						arg_285_1:RecordAudio("322012067", var_288_24)
						arg_285_1:RecordAudio("322012067", var_288_24)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_322012", "322012067", "story_v_out_322012.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_322012", "322012067", "story_v_out_322012.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_25 = math.max(var_288_16, arg_285_1.talkMaxDuration)

			if var_288_15 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_25 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_15) / var_288_25

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_15 + var_288_25 and arg_285_1.time_ < var_288_15 + var_288_25 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play322012068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322012068
		arg_289_1.duration_ = 9.83

		local var_289_0 = {
			zh = 8.1,
			ja = 9.833
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
			arg_289_1.auto_ = false
		end

		function arg_289_1.playNext_(arg_291_0)
			arg_289_1.onStoryFinished_()
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 0.875

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_2 = arg_289_1:FormatText(StoryNameCfg[1030].name)

				arg_289_1.leftNameTxt_.text = var_292_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_3 = arg_289_1:GetWordFromCfg(322012068)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 35
				local var_292_6 = utf8.len(var_292_4)
				local var_292_7 = var_292_5 <= 0 and var_292_1 or var_292_1 * (var_292_6 / var_292_5)

				if var_292_7 > 0 and var_292_1 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012068", "story_v_out_322012.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_out_322012", "322012068", "story_v_out_322012.awb") / 1000

					if var_292_8 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_0
					end

					if var_292_3.prefab_name ~= "" and arg_289_1.actors_[var_292_3.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_3.prefab_name].transform, "story_v_out_322012", "322012068", "story_v_out_322012.awb")

						arg_289_1:RecordAudio("322012068", var_292_9)
						arg_289_1:RecordAudio("322012068", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_322012", "322012068", "story_v_out_322012.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_322012", "322012068", "story_v_out_322012.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_10 and arg_289_1.time_ < var_292_0 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST73a",
		"TextureConfig/Background/L14f",
		"TextureConfig/Background/L15"
	},
	voices = {
		"story_v_out_322012.awb"
	}
}
